# meta v1.60-fix-bash-permission-pattern — PLAN

세션 시작: 2026-05-04
직접 선행 세션:
- [`sessions/meta/v1.59-hook-pattern-expand/`](../v1.59-hook-pattern-expand/PLAN.md) — 직전 메타 세션
- [`sessions/meta/v1.33-fix-scope-contract/`](../v1.33-fix-scope-contract/PLAN.md) — `--fix` 패턴 답습

목적: `tests/smoke-bash-permission-pattern.sh`에 `--fix` mode 도입. V1(Bash 공백 형식) + V5(자동 허용 set declare) + V7(allowed-tools 필드명)의 자동 정정 mechanism 신설.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S3(1) `tests/smoke-bash-permission-pattern.sh` = **1/1 meta**
- **T1 경로 다수결** — S3 단독
- **T2 스펙 vs 값** — smoke 자동 정정 mechanism = 글로벌 정책

## Scope inheritance (verbatim from 선행 세션)

**Source — `bootstrap/docs/SPEC_VERIFICATION.md §10-2` (verbatim)**:

> `v1.29b-fix-other-smokes` — smoke-scope-contract / smoke-bash-permission-pattern `--fix` 도입. evidence-driven

**Source — 사용자 발의 (2026-05-04)**:

> "기존 smoke에 --fix 추가" — smoke-bash-permission-pattern.sh 대상 (smoke-scope-contract는 v1.33에서 이미 보유)

**Parsed sub-items (3)**:

1. **--fix mode 추가** — argv 파싱 (`--fix` / `--dry-run` / `--help`) + v1.33 pattern 답습
2. **자동 정정 대상 3 stage** — V1 (`Bash(cmd*)` → `Bash(cmd *)`), V5 (YAML list 자동 허용 set 줄 삭제), V7 (`^tools:` → `^allowed-tools:` slash command만)
3. **--fix 후 자동 재검증** — 정정 적용 후 동일 smoke 본문 진행 → PASS 확인

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| V8 (single-line 콤마 separator) auto-fix | 후속 미정 — YAML list 구조적 변환 필요, 안전성 검증 어려움 |
| V9 (YAML list 형식 + ≥3 항목) auto-fix | 후속 미정 — 구조적 재배치 필요 |
| V4 (`PERMISSION_PATTERN.md` 9 keyword) auto-fix | 후속 미정 — 문서 콘텐츠 자동 생성 부적합 |
| 다른 smoke (`smoke-thinking-effort`, `smoke-broad-bash-fine-grain` 등) `--fix` 추가 | 후속 미정 evidence-driven (v1.60b+) |
| 자동 정정 본문 patterns 추가 (예: argument fragile rule auto-fix) | 후속 미정 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 smoke tooling 추가만. Claude Code spec 신규 의존 없음 |
| **re-verify** | N/A |

## 배경

`smoke-bash-permission-pattern.sh`는 v1.10d β 4 + v1.10f 7 + v1.10g 4 통합 후 **현재 0건 위반** 상태. 그러나 향후 신규 SKILL/command 추가 시 사용자 또는 Claude가 V1/V5/V7 위반 작성 가능 — 현재는 수동 sed 또는 IDE 편집 필요.

`smoke-spec-verification.sh` (v1.29) + `smoke-scope-contract.sh` (v1.33) + `smoke-roadmap-sync.sh` (v1.31c)에서 도입된 `--fix` 패턴 답습 → smoke 자체가 자동 정정 도구 역할. 향후 위반 발생 시 1줄 명령으로 정정.

## 구현 설계

### Argument parsing (v1.33 답습)

```bash
FIX_MODE=0
DRY_RUN=0
while [ $# -gt 0 ]; do
    case "$1" in
        --fix) FIX_MODE=1 ;;
        --dry-run) DRY_RUN=1 ;;
        --help|-h) cat <<USAGE
Usage: $0 [--fix [--dry-run]]

Default: Stage 1~6 검증 (회귀 0).
--fix:     V1/V5/V7 위반 자동 정정 (V8/V9/V4 제외 — 구조적 변경 어려움).
--dry-run: --fix와 함께 — 변경 없이 plan 출력.
USAGE
            exit 0 ;;
        --*) echo "Unknown option: $1 (try --help)" >&2; exit 2 ;;
        *) echo "Unexpected arg: $1" >&2; exit 2 ;;
    esac
    shift
done
```

### V1 자동 정정 (Bash 공백 형식)

```bash
# Bash(cmd*) → Bash(cmd *) — sed 단일 변환
for f in "${FILES[@]}"; do
    if grep -qE 'Bash\([a-z][a-z\-]*\*\)' "$f"; then
        if [ "$DRY_RUN" -eq 1 ]; then
            grep -nE 'Bash\([a-z][a-z\-]*\*\)' "$f" | sed "s|^|[would fix V1] $f: |"
        else
            sed -E -i.bak 's/Bash\(([a-z][a-z\-]*)\*\)/Bash(\1 *)/g' "$f" && rm -f "$f.bak"
            echo "  [fix V1] $f"
        fi
    fi
done
```

### V5 자동 정정 (YAML list 자동 허용 set 줄 삭제)

자동 허용 set: `ls cat head tail grep find wc diff stat du cd`. YAML list line만 삭제 (markdown body code-block 보호).

```bash
# YAML list line: ^[[:space:]]*-[[:space:]]*Bash\(...\)
auto_set_yaml='^[[:space:]]*-[[:space:]]*Bash\((ls|cat|head|tail|grep|find|wc|diff|stat|du|cd)([: ]\*?)?\)[[:space:]]*$'
for f in "${FILES[@]}"; do
    if grep -qE "$auto_set_yaml" "$f"; then
        if [ "$DRY_RUN" -eq 1 ]; then
            grep -nE "$auto_set_yaml" "$f" | sed "s|^|[would fix V5] $f: |"
        else
            sed -E -i.bak "/$auto_set_yaml/d" "$f" && rm -f "$f.bak"
            echo "  [fix V5] $f"
        fi
    fi
done
```

### V7 자동 정정 (slash command field name)

```bash
SLASH="claude/commands/harness-meta.md"
if grep -qE '^tools:' "$SLASH"; then
    if [ "$DRY_RUN" -eq 1 ]; then
        grep -nE '^tools:' "$SLASH" | sed "s|^|[would fix V7] $SLASH: |"
    else
        sed -E -i.bak 's/^tools:/allowed-tools:/' "$SLASH" && rm -f "$SLASH.bak"
        echo "  [fix V7] $SLASH"
    fi
fi
```

### --fix 적용 후 재검증

`--fix` 블록은 **Stage 1 직전**에 배치. 정정 후 기존 Stage 1~6 그대로 실행 → PASS 검증. dry-run 시 정정 plan 출력 후 즉시 exit 0 (검증 skip — drift 의도).

### 안전성 분석

- **V1 sed**: regex `Bash\(([a-z][a-z\-]*)\*\)` — 영문 소문자 + hyphen만 매칭. body markdown code block 내 `` `Bash(rm -rf*)` `` 같은 표기는 backtick 외 위치에서만 매치. 본 5축 Bash 패턴 검증 도구가 markdown 코드블록 내부에 등장 가능성은 낮음 (실 audit 결과 0건). **감수 가능**
- **V5 sed**: YAML list 형식만 (`^[[:space:]]*-[[:space:]]*Bash\(...\)[[:space:]]*$`) — body 평문 또는 inline code (`Bash(ls *)`)은 매치 안 함. 안전
- **V7 sed**: line-anchor `^tools:` — 본문 내 "tools: ..." 표현은 매치 안 함. harness-meta.md 1 파일만 대상. 안전
- **백업**: 모든 sed에 `-i.bak` 사용 후 `rm -f $f.bak`. 실패 시 .bak 잔존으로 복구 가능

## 목표

- [ ] 세션 디렉토리 + PLAN.md 작성 ✅
- [ ] Stage A — `tests/smoke-bash-permission-pattern.sh`에 argv 파싱 + --help 추가
- [ ] Stage B — V1/V5/V7 --fix block 추가
- [ ] Stage C — 검증: default 호출 6/6 PASS 유지 (회귀 0)
- [ ] Stage D — 검증: `--fix --dry-run` 호출 시 0건 plan (현재 위반 0건이므로 출력 없음)
- [ ] Stage E — 검증: 인공 violation 주입 → `--fix` → smoke PASS (시나리오 검증)
- [ ] REPORT.md 작성

## 변경 대상

| 경로 | scope | 변경 |
|------|------|------|
| `tests/smoke-bash-permission-pattern.sh` | S3 | argv 파싱 + --help + V1/V5/V7 --fix block + dry-run + .bak 백업 |

## 성공 기준

- [ ] default 호출: `bash tests/smoke-bash-permission-pattern.sh` → 6/6 PASS (회귀 0)
- [ ] `--help` 호출: usage 출력 + exit 0
- [ ] `--fix --dry-run`: plan 출력 (현재 0건이므로 빈 plan + Stage 검증 skip)
- [ ] 시나리오 검증: 임시 violation 주입 → `--fix` → 정정 → 6/6 PASS

## 커밋 전략

```
feat(meta): v1.60-fix-bash-permission-pattern — smoke --fix mode 도입

- update: tests/smoke-bash-permission-pattern.sh (argv 파싱 + --help + V1/V5/V7 --fix + dry-run + .bak 백업)

V1 Bash(cmd*) → Bash(cmd *), V5 YAML list 자동허용 set 줄 삭제, V7 ^tools: → ^allowed-tools:.
V8/V9/V4는 구조적/문서성 변경 어려워 Out of scope.

default 호출 6/6 PASS 유지 (회귀 0). 시나리오 검증으로 --fix 동작 확인.
v1.29b-fix-other-smokes trigger 부분 이행 (smoke-bash-permission-pattern 대상).
```

## 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.60b-fix-thinking-effort` | smoke-thinking-effort.sh `thinking:` field auto-remove |
| `v1.60c-fix-broad-bash-fine-grain` | smoke-broad-bash-fine-grain.sh `--fix` 패턴 |
| `v1.60d-v8-v9-structural-fix` | V8 콤마 separator + V9 YAML list 항목 수 auto-fix (구조적 변환) |
