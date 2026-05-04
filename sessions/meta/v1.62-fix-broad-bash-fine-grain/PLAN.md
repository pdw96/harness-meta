# meta v1.62-fix-broad-bash-fine-grain — PLAN

세션 시작: 2026-05-04
직접 선행 세션:

- [`sessions/meta/v1.61-fix-thinking-effort/`](../v1.61-fix-thinking-effort/PLAN.md) — `--fix` 패턴 답습 직속
- [`sessions/meta/v1.10f-broad-bash-fine-grain/`](../v1.10f-broad-bash-fine-grain/PLAN.md) — V5/R2/R6 spec origin

목적: `tests/smoke-broad-bash-fine-grain.sh`에 `--fix` mode 도입. V5(자동 허용 set, 7 파일) + R2/R6(Bash declare 부재 의무, 4 파일) 자동 정정.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S3(1) `tests/smoke-broad-bash-fine-grain.sh` = **1/1 meta**
- **T1 경로 다수결** — S3 단독
- **T2 스펙 vs 값** — smoke 자동 정정 mechanism = 글로벌 정책

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.61-fix-thinking-effort/REPORT.md` 다음 후보 (verbatim)**:

> `v1.60c-fix-broad-bash-fine-grain` | E | smoke-broad-bash-fine-grain.sh `--fix` 패턴 (별도 세션)

**Source — ROADMAP §3-E (verbatim)**:

> `v1.60c-fix-broad-bash-fine-grain` | smoke-broad-bash-fine-grain.sh `--fix` 패턴 도입 evidence | `v1.60 REPORT`

**Parsed sub-items (3)**:

1. **--fix mode 추가** — argv 파싱 (`--fix` / `--dry-run` / `--help`), v1.60/v1.61 패턴 답습
2. **V5 auto-allow set 삭제** — 7 파일 (3 SKILL + 4 agent) YAML list anchor `^[[:space:]]*-[[:space:]]*Bash\((ls|cat|...)\)`
3. **R2+R6 Bash declare 삭제** — 4 파일 (harness/SKILL + 3 agent: dispatcher/explore/grey-area) `^[[:space:]]*-[[:space:]]*Bash([[:space:]]*\(.*\))?$`

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| V8 (Stage 1 single-line 콤마 separator) auto-fix | 후속 미정 — YAML list 구조적 변환 필요 (v1.60 동일 정책) |
| V9 (Stage 2 YAML list 항목 수 정확 일치) auto-fix | 후속 미정 — 구조적 변경 어려움 |
| Stage 4 R3/R4 (broad Bash 유지) auto-fix | 본질 — positive existence check, violation 아님 |
| Stage 6 Field name (A1) bidirectional rename auto-fix | 후속 미정 — 3 SKILL `tools:` → `allowed-tools:` + 4 agent `allowed-tools:` → `tools:` 양방향 sed 안전성 검증 필요 |
| 다른 smoke `--fix` 추가 | v1.62b+ 별도 세션 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 smoke tooling 추가만. Claude Code spec 신규 의존 없음 |
| **re-verify** | N/A |

## 배경

`smoke-broad-bash-fine-grain.sh`는 v1.10f scope 7 파일(3 SKILL + 4 agent) frontmatter spec 정합 검증. 6 stage 중:

- **Stage 1 V8**: single-line 콤마 separator → 0 (구조적 변환 필요, Out of scope)
- **Stage 2 V9**: YAML list 항목 수 정확 일치 (구조적 검증, Out of scope)
- **Stage 3 R2**: `harness/SKILL.md` Bash declare 부재
- **Stage 4 R3/R4**: 3 broad-Bash 파일 `^  - Bash$` 존재 (positive check, Out of scope)
- **Stage 5 V5**: 자동 허용 set declare 잔존 0 (7 파일)
- **Stage 6 R6**: 3 agent (dispatcher/explore/grey-area) Bash declare 부재

본 v1.62는 Stage 5 V5 + Stage 3/6 R2+R6 자동 정정만 도입. v1.60(smoke-bash-permission-pattern V5/V7) + v1.61(thinking V10) 패턴 답습.

## 구현 설계

### Argument parsing (v1.61 답습)

```bash
FIX_MODE=0
DRY_RUN=0
while [ $# -gt 0 ]; do
    case "$1" in
        --fix)     FIX_MODE=1 ;;
        --dry-run) DRY_RUN=1 ;;
        --help|-h) cat <<USAGE
Usage: $0 [--fix [--dry-run]]

Default: Stage 1~6 검증.
--fix:     V5 (7 파일 auto-allow set 삭제) + R2/R6 (4 NO_BASH_FILES Bash declare 삭제) 자동 정정.
           V8/V9/Stage 4/Stage 6 field name은 Out of scope.
--dry-run: --fix와 함께 — 변경 없이 plan 출력.
USAGE
            exit 0 ;;
        --*) echo "Unknown option: $1 (try --help)" >&2; exit 2 ;;
        *)   echo "Unexpected arg: $1 (try --help)" >&2; exit 2 ;;
    esac
    shift
done
```

### V5 자동 정정 (auto-allow set, 7 파일)

```bash
V5_PAT='^[[:space:]]*-[[:space:]]*Bash\((ls|cat|head|tail|grep|find|wc|diff|stat|du|cd)([: ]\*?)?\)[[:space:]]*$'
for f in "${ALL_FILES[@]}"; do
    if grep -qE "$V5_PAT" "$f" 2>/dev/null; then
        if [ "$DRY_RUN" -eq 1 ]; then
            grep -nE "$V5_PAT" "$f" | sed "s|^|  [would fix V5] $f: |"
        else
            sed -E -i.bak "/$V5_PAT/d" "$f" && rm -f "$f.bak"
            echo "  [fix V5] $f"
        fi
        fix_count=$((fix_count + 1))
    fi
done
```

### R2+R6 자동 정정 (Bash declare 부재 의무, 4 파일)

```bash
NO_BASH_FILES=(
    "bootstrap/templates/_base/.claude/skills/harness/SKILL.md"
    "bootstrap/templates/_base/.claude/agents/harness-dispatcher.md"
    "bootstrap/templates/_base/.claude/agents/harness-explore.md"
    "bootstrap/templates/_base/.claude/agents/harness-grey-area.md"
)
NO_BASH_PAT='^[[:space:]]*-[[:space:]]*Bash([[:space:]]*\(.*\))?[[:space:]]*$'
for f in "${NO_BASH_FILES[@]}"; do
    if grep -qE "$NO_BASH_PAT" "$f" 2>/dev/null; then
        if [ "$DRY_RUN" -eq 1 ]; then
            grep -nE "$NO_BASH_PAT" "$f" | sed "s|^|  [would fix R2/R6] $f: |"
        else
            sed -E -i.bak "/$NO_BASH_PAT/d" "$f" && rm -f "$f.bak"
            echo "  [fix R2/R6] $f"
        fi
        fix_count=$((fix_count + 1))
    fi
done
```

### 안전성 분석

- **V5 sed**: anchor `^[[:space:]]*-[[:space:]]*Bash\((auto_set)...\)[[:space:]]*$` — YAML list line만 매치. markdown body inline (`` `Bash(ls *)` ``)는 backtick 외 위치이므로 매치 안 됨. v1.60에서 동일 패턴 검증됨
- **R2/R6 sed**: anchor `^[[:space:]]*-[[:space:]]*Bash([[:space:]]*\(.*\))?[[:space:]]*$` — `- Bash` 또는 `- Bash(...)` 라인만 매치. broad Bash 또는 parenthesized 모두 cover. NO_BASH_FILES 4 파일에만 적용 (다른 3 파일의 `- Bash$` broad 라인은 R3/R4 의무 보존)
- **백업**: 모든 sed `-i.bak` + `rm -f $f.bak` (실패 시 .bak 잔존 → 복구 가능)
- **순서 보존**: V5는 모든 7 파일 적용 → 그 후 R2/R6 4 파일 적용. 같은 라인 중복 매칭 시 먼저 V5가 삭제 → R2/R6은 no-op (idempotent)

## 목표

- [ ] 세션 디렉토리 + PLAN.md 작성 ✅
- [ ] Stage A — `tests/smoke-broad-bash-fine-grain.sh`에 argv 파싱 + --help 추가
- [ ] Stage B — V5 + R2/R6 --fix block 추가
- [ ] Stage C — 검증: default 호출 6/6 PASS 유지 (회귀 0)
- [ ] Stage D — 검증: `--fix --dry-run` 호출 정상
- [ ] Stage E — E2E 시나리오: 두 종류 violation 주입 → `--fix` → 정정 + 6/6 PASS
- [ ] REPORT.md 작성

## 변경 대상

| 경로 | scope | 변경 |
|------|------|------|
| `tests/smoke-broad-bash-fine-grain.sh` | S3 | argv 파싱 + --help + V5 + R2/R6 --fix block + .bak 백업 |

## 성공 기준

- [ ] default: `bash tests/smoke-broad-bash-fine-grain.sh` → 6/6 PASS (회귀 0)
- [ ] `--help`: usage 출력 + exit 0
- [ ] `--fix --dry-run`: plan 출력 (현재 0건 → "no violations found")
- [ ] E2E V5: `- Bash(ls *)` 주입 → `--fix` → 0건 + smoke PASS
- [ ] E2E R2/R6: NO_BASH_FILE에 `- Bash` 주입 → `--fix` → 0건 + smoke PASS

## 커밋 전략

```
feat(meta): v1.62-fix-broad-bash-fine-grain — smoke --fix mode 도입

- update: tests/smoke-broad-bash-fine-grain.sh (argv 파싱 + --help + V5 + R2/R6 --fix + dry-run + .bak 백업)

V5: 7 파일 auto-allow set YAML list 삭제. R2/R6: 4 NO_BASH_FILES (harness SKILL + 3 agent) Bash declare 삭제.
V8/V9/Stage 4/Stage 6 field name은 Out of scope.

default 6/6 PASS 유지 (회귀 0). E2E 시나리오 검증.
v1.60/v1.61 패턴 답습. v1.60c-fix-broad-bash-fine-grain trigger 이행.
```

## 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.62b-fix-field-name-rename` | Stage 6 field name (3 SKILL `tools:` → `allowed-tools:` + 4 agent 역방향) bidirectional auto-fix evidence |
| `v1.61b-fix-model-effort-insert` | R1/R2/R3/R4 model+effort frontmatter 구조 삽입 (앞 세션 후속 이연) |
