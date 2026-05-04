# meta v1.61-fix-thinking-effort — PLAN

세션 시작: 2026-05-04
직접 선행 세션:
- [`sessions/meta/v1.60-fix-bash-permission-pattern/`](../v1.60-fix-bash-permission-pattern/PLAN.md) — `--fix` 패턴 답습 직속
- [`sessions/meta/v1.10g-skill-thinking-effort/`](../v1.10g-skill-thinking-effort/PLAN.md) — V10 spec origin

목적: `tests/smoke-thinking-effort.sh`에 `--fix` mode 도입. V10(`^thinking:` field 제거) 자동 정정 mechanism 신설.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S3(1) `tests/smoke-thinking-effort.sh` = **1/1 meta**
- **T1 경로 다수결** — S3 단독
- **T2 스펙 vs 값** — smoke 자동 정정 mechanism = 글로벌 정책

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.60-fix-bash-permission-pattern/REPORT.md` 다음 후보 (verbatim)**:

> `v1.60b-fix-thinking-effort` | E | smoke-thinking-effort.sh `thinking:` field auto-remove `--fix` 도입

**Source — ROADMAP §3-E (verbatim)**:

> `v1.60b-fix-thinking-effort` | smoke-thinking-effort.sh `thinking:` field auto-remove `--fix` 도입 evidence | `v1.60 REPORT`

**Parsed sub-items (2)**:

1. **--fix mode 추가** — argv 파싱 (`--fix` / `--dry-run` / `--help`), v1.60 패턴 답습
2. **V10 `^thinking:` line auto-remove** — 4 파일(slash + 3 opus SKILL) sed `/^thinking:/d`

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| R1 (`^model: sonnet$` 강제) auto-fix | 후속 미정 — frontmatter 구조에 model 라인 삽입 위치 결정 필요 (--- 사이) |
| R2/R3/R4 (`^effort: xhigh$` / `^model: opus$` 강제) auto-fix | 후속 미정 — 동일한 구조적 삽입 문제 |
| Stage 5 cross-session V1/V5 auto-fix | v1.60에서 이미 smoke-bash-permission-pattern으로 처리 (중복 회피) |
| Stage 5 V8/V9 auto-fix | v1.60에서 Out of scope 동일 (구조적 변환 어려움) |
| 다른 smoke (`smoke-broad-bash-fine-grain` 등) `--fix` 추가 | v1.60c 별도 세션 (evidence-driven) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 smoke tooling 추가만. Claude Code spec 신규 의존 없음 |
| **re-verify** | N/A |

## 배경

`smoke-thinking-effort.sh`는 v1.10g audit/A1 § "thinking field — silent ignore" 방어 smoke. 현재 4 파일 모두 `^thinking:` 부재 (위반 0건). 향후 SKILL/command 작성 시 사용자 또는 Claude가 무의식적으로 `thinking:` 추가 가능 — silent ignore되어 의도 손실.

`v1.60`에서 `smoke-bash-permission-pattern.sh`에 V1/V5/V7 auto-fix 도입 시 v1.33 패턴 답습. 본 v1.61은 동일 패턴 답습 → V10만 단일 sed 자동 정정 mechanism 추가.

## 구현 설계

### Argument parsing (v1.60 답습)

```bash
FIX_MODE=0
DRY_RUN=0
while [ $# -gt 0 ]; do
    case "$1" in
        --fix)     FIX_MODE=1 ;;
        --dry-run) DRY_RUN=1 ;;
        --help|-h) cat <<USAGE
Usage: $0 [--fix [--dry-run]]

Default: Stage 1~5 검증.
--fix:     V10 (^thinking: line auto-remove) 정정. R1/R2/Stage 5는 Out of scope.
--dry-run: --fix와 함께 — 변경 없이 plan 출력.
USAGE
            exit 0 ;;
        --*) echo "Unknown option: $1 (try --help)" >&2; exit 2 ;;
        *)   echo "Unexpected arg: $1 (try --help)" >&2; exit 2 ;;
    esac
    shift
done
```

### V10 자동 정정 (`^thinking:` line delete)

```bash
# Stage 1 진입 전 실행
if [ "$FIX_MODE" -eq 1 ]; then
    echo "=== --fix mode (V10) ==="
    fix_count=0
    for f in "${ALL_FILES[@]}"; do
        if grep -qE '^thinking:' "$f" 2>/dev/null; then
            if [ "$DRY_RUN" -eq 1 ]; then
                grep -nE '^thinking:' "$f" | sed "s|^|  [would fix V10] $f: |"
            else
                sed -E -i.bak '/^thinking:/d' "$f" && rm -f "$f.bak"
                echo "  [fix V10] $f"
            fi
            fix_count=$((fix_count + 1))
        fi
    done
    [ "$fix_count" -eq 0 ] && echo "  (no violations found — 0 fixes)"
    if [ "$DRY_RUN" -eq 1 ]; then
        echo ""
        echo "=== dry-run 종료 (Stage 검증 skip) ==="
        exit 0
    fi
    echo ""
fi
```

### 안전성 분석

- **V10 sed**: anchor `^thinking:` — 행 시작 + `thinking:` 정확. body inline 또는 markdown 코드블록 내 "thinking:" 표현은 매치 안 됨 (그런 표현은 들여쓰기 또는 backtick 안에 있음). 4 파일 frontmatter (`---` 사이)에서만 발생 가능 → 안전
- **백업**: `-i.bak` 후 `rm -f $f.bak` — 실패 시 .bak 잔존으로 복구 가능
- **frontmatter 구조 보존**: `^thinking:` 1 라인만 삭제 → 다른 frontmatter 키(`name`, `description`, `model`, `effort`, `allowed-tools`) 영향 없음

## 목표

- [ ] 세션 디렉토리 + PLAN.md 작성 ✅
- [ ] Stage A — `tests/smoke-thinking-effort.sh`에 argv 파싱 + --help 추가
- [ ] Stage B — V10 --fix block 추가
- [ ] Stage C — 검증: default 호출 5/5 PASS 유지 (회귀 0)
- [ ] Stage D — 검증: `--fix --dry-run` 호출 정상
- [ ] Stage E — E2E 시나리오: `^thinking: high` 주입 → `--fix` → 정정 + 5/5 PASS
- [ ] REPORT.md 작성

## 변경 대상

| 경로 | scope | 변경 |
|------|------|------|
| `tests/smoke-thinking-effort.sh` | S3 | argv 파싱 + --help + V10 --fix block + .bak 백업 |

## 성공 기준

- [ ] default: `bash tests/smoke-thinking-effort.sh` → 5/5 PASS (회귀 0)
- [ ] `--help`: usage 출력 + exit 0
- [ ] `--fix --dry-run`: plan 출력 (현재 0건 → "no violations found")
- [ ] E2E: `^thinking: high` 주입 → `--fix` → V10 0건 + smoke 5/5 PASS

## 커밋 전략

```
feat(meta): v1.61-fix-thinking-effort — smoke --fix mode 도입

- update: tests/smoke-thinking-effort.sh (argv 파싱 + --help + V10 --fix + dry-run + .bak 백업)

V10: ^thinking: line auto-remove. R1/R2/Stage 5는 Out of scope.
default 5/5 PASS 유지 (회귀 0). E2E 시나리오 검증.
v1.60 패턴 답습. v1.60b-fix-thinking-effort trigger 이행.
```

## 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.61b-fix-model-effort-insert` | R1/R2/R3/R4 model+effort frontmatter 구조 삽입 auto-fix (구조적 변환 evidence) |
| `v1.60c-fix-broad-bash-fine-grain` | smoke-broad-bash-fine-grain.sh `--fix` (별도 세션) |
