# meta v1.65-fix-v8-separator — PLAN

세션 시작: 2026-05-04
직접 선행 세션: [`sessions/meta/v1.60-fix-bash-permission-pattern/`](../v1.60-fix-bash-permission-pattern/REPORT.md) — V1/V5/V7 fix 도입, V8/V9 Out of scope

목적: `smoke-bash-permission-pattern.sh --fix` mode에 **V8 fix** 추가 — 단일 라인 콤마 separator `allowed-tools: A, B, C` → YAML list 구조 변환. V9 (YAML list 형식 부재)는 V8 변환으로 연계 해소.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: `tests/smoke-bash-permission-pattern.sh` (S3 — repo 정책·검증 인프라)
- **T1 경로 다수결** — 1/1 파일 S3 (meta)
- T2 무관 (단일 scope)

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.60-fix-bash-permission-pattern/REPORT.md` 다음 후보 표 (verbatim)**:

> | `v1.60d-v8-v9-structural-fix` | A | V8 콤마 separator + V9 YAML list 항목 수 auto-fix (구조적 변환 검증 evidence 필요) |

**Parsed sub-items (1)**:

1. **V8 콤마 separator auto-fix** — `allowed-tools: A, B, C` → YAML list 구조 변환 (parenthesis-aware Python split). V9 YAML list 형식 부재는 V8 변환으로 연계 해소.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| V9 count threshold 변경 (≥ 3 → ≥ 1) | 후속 미정 (evidence-driven) |
| V4 PERMISSION_PATTERN.md keyword fix | 후속 미정 (문서성 변경) |
| tools: 필드 (agent 파일) V8 fix | FILES에 agent 미포함 — 범위 외 |
| smoke-broad-bash-fine-grain V8/V9 | 해당 smoke는 별도 scope |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 smoke tooling 추가만. 외부 spec 의존 무 |
| **re-verify** | N/A |

## 1. 문제

`smoke-bash-permission-pattern.sh --fix` 는 V1/V5/V7만 자동 정정. V8 (콤마 separator)은 multi-line 구조 변환이 필요해 "Out of scope"로 이연됨.

V8 violation 예:
```yaml
allowed-tools: Read, Glob, Grep, Bash(mkdir *)
```
→ Stage 4 FAIL (`^(allowed-tools|tools):.+,` 패턴 매치)
→ Stage 5 FAIL (YAML list 형식 부재: `^allowed-tools:\s*$` 없음)

현재 6/6 PASS이지만 향후 신규 SKILL/command 작성 시 V8 위반 발생 가능. --fix로 자동 정정 mechanism 확보 필요.

## 2. 결정 (R1 ~ R3)

### R1 — V8 fix 알고리즘 (parenthesis-aware Python split)

단순 `split(',')` 은 `Bash(git *, npm *)` 내부 콤마를 잘못 분리. **괄호 내부 콤마 무시** 필요.

```python
def split_outside_parens(s):
    items, current, depth = [], [], 0
    for c in s:
        if c == '(':
            depth += 1; current.append(c)
        elif c == ')':
            depth -= 1; current.append(c)
        elif c == ',' and depth == 0:
            items.append(''.join(current).strip())
            current = []
        else:
            current.append(c)
    if current:
        items.append(''.join(current).strip())
    return [i for i in items if i]
```

실 분리 예:
- `Read, Glob, Bash(mkdir *)` → `['Read', 'Glob', 'Bash(mkdir *)']` ✓
- `Bash(git *, npm *)` → `['Bash(git *, npm *)']` (1건 — no-op) ✓

1건 결과 시 변환 없이 원본 반환 (single tool inline은 V8 대상 아님).

### R2 — Python3 heredoc 방식

구조 변환은 sed/awk로 어렵고 오류 가능성 高. `python3 -` + `<<'PYEOF'` heredoc 사용:

```bash
python3 - "$f" <<'PYEOF'
import sys, re

def split_outside_parens(s):
    items, current, depth = [], [], 0
    for c in s:
        if c == '(': depth += 1; current.append(c)
        elif c == ')': depth -= 1; current.append(c)
        elif c == ',' and depth == 0:
            items.append(''.join(current).strip()); current = []
        else: current.append(c)
    if current: items.append(''.join(current).strip())
    return [i for i in items if i]

p = sys.argv[1]
t = open(p, encoding='utf-8').read()

def fix(m):
    field, val = m.group(1), m.group(2).strip()
    items = split_outside_parens(val)
    if len(items) <= 1:
        return m.group(0)  # single item — no-op
    return field + ':\n' + '\n'.join('  - ' + i for i in items)

new = re.sub(r'^(allowed-tools|tools):\s+(.+,.+)$', fix, t, flags=re.MULTILINE)
open(p, 'w', encoding='utf-8').write(new)
PYEOF
```

`<<'PYEOF'` — single-quote heredoc으로 Python 코드 내 `$` 등 변수 expansion 방지.
`python3 -` — stdin에서 스크립트 읽고 `sys.argv[1]`으로 파일 경로 수신.

### R3 — --help 텍스트 + 헤더 주석 갱신

`--help` 출력:
```
--fix:     V1 (Bash(cmd*) → Bash(cmd *)) + V5 (YAML list 자동허용 set 줄 삭제) +
           V7 (slash command ^tools: → ^allowed-tools:) +
           V8 (콤마 separator → YAML list 구조 변환, parenthesis-aware) 자동 정정.
           V9 (YAML list 형식 부재)는 V8 변환으로 연계 해소됨.
           V4 (doc keyword)는 문서성 변경 Out of scope.
```

헤더 주석:
```bash
# v1.60 — --fix mode: V1/V5/V7 자동 정정 (V8/V9/V4 Out of scope)
# v1.65 — --fix V8 추가: 콤마 separator → YAML list 구조 변환 (parenthesis-aware)
```

## 3. 변경 대상 (1파일)

| 경로 | scope | 변경 |
|------|------|------|
| `tests/smoke-bash-permission-pattern.sh` | S3 | R1+R2+R3 — V8 fix block 추가 + --help + 헤더 주석 |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [ ] **사용자 PLAN 확정**
- [ ] Stage A — V8 fix block + --help + 헤더 주석 추가
- [ ] Stage B — E2E 검증 (V8 violation 주입 → --fix → YAML list 정합 + 6/6 PASS)
- [ ] Stage C — default 6/6 PASS (회귀 0)
- [ ] Stage D — REPORT.md 작성
- [ ] Stage E — ROADMAP 갱신 (`harness-roadmap-update`)
- [ ] 커밋

## 5. 성공 기준

- [ ] V8 violation 주입 → `--fix` → YAML list 변환 정합
- [ ] `Bash(git *, npm *)` single item → no-op (parenthesis-aware 보호)
- [ ] default 6/6 PASS (회귀 0)
- [ ] `--fix --dry-run` plan 출력 정상
- [ ] `--help` V8 언급 포함

## 6. 커밋 전략

```
feat(meta): v1.65-fix-v8-separator — smoke-bash-permission-pattern --fix V8 추가

- update: tests/smoke-bash-permission-pattern.sh
  + V8 fix block: allowed-tools: A, B, C → YAML list (parenthesis-aware Python split)
  + --help: V8 fixable 명시
  + 헤더 주석 v1.65 갱신
- add: sessions/meta/v1.65-fix-v8-separator/{PLAN,REPORT}.md

default 6/6 PASS (회귀 0). E2E: V8 violation 주입 → --fix → 정합.
v1.60d-v8-v9-structural-fix ROADMAP trigger 이행.
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|-----------|------|
| `v1.65b-v9-count-threshold` | V9 count ≥ 3 → ≥ 1 threshold 조정 evidence 3+ |
| `v1.65c-agent-v8-fix` | agent FILES 추가 evidence (현재 smoke에 agent 미포함) |
