# tests/ 모듈 가이드

smoke 스크립트 + pre-commit autofix wrapper. 모든 변경의 회귀 검증 + drift 감지 단일 소스.

상위 진입: [`../CLAUDE.md`](../CLAUDE.md)

## smoke 매트릭스 (현 26 파일)

### 핵심 정책 검증

| smoke | 검증 대상 | `--fix` 지원 |
|-------|---------|:----------:|
| `smoke-spec-verification.sh` | PLAN/REPORT context7 § 7 stage (헤더/sub-field 5종/drift 값/N/A 분기/cross-file 매트릭스 9 case) | ✅ skeleton 자동 삽입 (v1.29) |
| `smoke-scope-contract.sh` | PLAN의 Scope inheritance + Out of scope § 의무 + harness-meta.md 안내 | ✅ skeleton 자동 삽입 (v1.33) |
| `smoke-bash-permission-pattern.sh` | frontmatter 6축 V1/V5/V7/V8/V10 (콜론 패턴/auto-allow set/필드명/콤마 separator/YAML list) | ✅ V1/V5/V7/V8 (v1.60/v1.65) |
| `smoke-thinking-effort.sh` | model+effort 6축 + `thinking:` 필드 silent ignore 차단 (V10) | ✅ V10 + R1/R2/R3 frontmatter insert/replace/delete (v1.61/v1.71) |
| `smoke-broad-bash-fine-grain.sh` | broad Bash 범위 + 필드명 양방향 rename (3 SKILL ↔ 4 agent) | ✅ V5/R2/R6 + Stage 6 (v1.62/v1.63) |

### 인프라 검증

| smoke | 검증 대상 |
|-------|---------|
| `smoke-language-overlay.sh` | bootstrap/templates/<language>/ overlay 인프라 (8 checks 정적 4 + dynamic 4) |
| `smoke-legacy-cleanup-overlay.sh` | install-project-claude legacy cleanup overlay-aware (v1.21) |
| `smoke-skills-install.sh` | install-skills 5 skill 정적 매트릭스 + 자동 lookup |
| `smoke-sync-agents.sh` | sync-agents.{ps1,sh} 7 AGENT_MAPPINGS + drift 감지 |
| `smoke-verify-sh-parity.sh` | verify.ps1 ↔ verify.sh 동작 동등성 |
| `smoke-bootstrap-render.sh` | render-manifest.sh 안전성 + round-trip |
| `smoke-bootstrap-agents-md.sh` + license 3종 | AGENTS.md 콘텐츠 자동 적용 (bootstrap/install_cmd/license) |

### 도메인 별 회귀

| smoke | 검증 대상 |
|-------|---------|
| `smoke-roi-regression.sh` | ai-ready-scorer ROI action 조건식 (정적 4 + 동적 2) |
| `smoke-detect-language.sh` | detect_language priority tie-breaking (Python/Shell 자연 우선) |
| `smoke-agentic-safety-na.sh` | score_agentic_safety N/A 분기 (Helper 1 적용) |
| `smoke-scorer-output-newline.sh` | scorer 산출물 CRLF 회귀 방지 (byte-level) |
| `smoke-posttooluse-hook.sh` | post-report-write.sh 17 test (Write/Edit/MultiEdit/NotebookEdit + 패턴 매칭) |
| `smoke-roadmap-sync.sh` | ROADMAP §"최근 완료" entry 동기화 (per session) |
| `smoke-backup-cleanup.sh` | install-skills `--cleanup` retain/grace 정책 |

### Pre-commit autofix wrapper

| 파일 | 역할 |
|------|------|
| `precommit-autofix-or-fail.sh` | smoke 실패 시 `--fix` 자동 시도 + 안내 후 abort (v1.64+ — Approach B) |

## 작성 규약

### Bash 호환성

- **shebang**: `#!/usr/bin/env bash`
- **errexit**: `set -euo pipefail` 권장 (각 smoke 동작 일관성)
- **LF 라인 종결**: CRLF 시 `$'\r': command not found` 오류. `.gitattributes` 의존
- **shellcheck SC1102/SC2010/SC2064/SC2088/SC2034**: pre-commit shellcheck로 자동 차단 (v1.66+)
- **MSYS2/Git Bash path translation**: Python 인자에 Windows path 전달 시 `sys.argv` 경유 패턴 (v1.70 사례)

### 출력 패턴

```bash
PASS=0
FAIL=0
SKIP=0

# 각 stage / check
echo "=== Stage 1 — <description> ==="
if <check>; then
    echo "  ✓ <message>"
    PASS=$((PASS+1))
else
    echo "  ✗ <message>"
    FAIL=$((FAIL+1))
fi

# 마지막 라인
echo "=== 결과: PASS=$PASS FAIL=$FAIL SKIP=$SKIP ==="
exit $((FAIL == 0 ? 0 : 1))
```

### `--fix` mode 패턴

v1.33 (smoke-scope-contract) → v1.29 (smoke-spec-verification) → v1.60/v1.61/v1.62/v1.63/v1.65/v1.71 시리즈로 확장. 표준 인터페이스:

```bash
# 인자 파싱
FIX_MODE=0
DRY_RUN=0
TARGETS=()
while [[ $# -gt 0 ]]; do
    case "$1" in
        --fix) FIX_MODE=1; shift ;;
        --dry-run) DRY_RUN=1; shift ;;
        --help) usage; exit 0 ;;
        --*) echo "Unknown: $1" >&2; exit 2 ;;
        *) TARGETS+=("$1"); shift ;;
    esac
done

# 부재 시 default 검증, --fix 시 자동 정정
```

복잡한 정정은 Python heredoc 위임 (v1.71 패턴 — `python3 <<'EOF' "$args"`).

### Backup

자동 정정 시 `<file>.bak` 백업 의무 (사용자 rollback 가능). idempotent 호출 시 .bak 누적 회피 — 같은 ts 내 중복 무시.

## 회귀 검증 절차

### 신규 smoke 추가 시

1. `tests/smoke-<name>.sh` 작성 (위 출력 패턴 준수)
2. `chmod +x` (Linux/macOS)
3. **수동 dynamic 검증** — 의도된 violation 주입 → smoke FAIL → 수정 → smoke PASS
4. `.pre-commit-config.yaml`에 등록 검토 (자주 실패하는 항목만)
5. CI workflow `.github/workflows/ci.yml`에 자동 실행 추가
6. 본 매트릭스에 1 row 추가

### 기존 smoke 수정 시

- **회귀 0 의무** — 다른 smoke 영향 검증
- E2E violation 주입 → 수정 → 재검증 시나리오 기록
- `--fix` mode 추가 시 idempotent (1회 fix 후 재호출 시 no-op) 보장

## Pre-commit 통합

```bash
pip install pre-commit   # or: pipx install pre-commit
pre-commit install       # one-time per clone
pre-commit run --all-files                     # manual run
pre-commit run smoke-spec-verification         # individual hook
pre-commit run smoke-scope-contract
```

**v1.64+ autofix**: smoke 실패 시 `precommit-autofix-or-fail.sh` wrapper가 `--fix` 자동 시도 + 안내 후 abort. 사용자는 `git diff` 검토 → `git add -u` 재스테이징 → 재커밋.

## 외부 의존

- **shellcheck** (pre-commit framework가 자동 설치)
- **markdownlint** (동상)
- **Python 3.10+** (smoke 일부 + ai-ready-scorer + post-report-write.sh)
- **jq** (선택, smoke 일부)

## 관련 문서

- 상위 진입: [`../CLAUDE.md`](../CLAUDE.md)
- Spec verification § 규격: [`../bootstrap/docs/SPEC_VERIFICATION.md`](../bootstrap/docs/SPEC_VERIFICATION.md)
- Scope contract 규약: [`../bootstrap/docs/OWNERSHIP.md`](../bootstrap/docs/OWNERSHIP.md) (Scope contract §)
- frontmatter 6축: [`../bootstrap/docs/PERMISSION_PATTERN.md`](../bootstrap/docs/PERMISSION_PATTERN.md)
- pre-commit 도입 세션 (v1.39): [`../sessions/meta/v1.39-precommit-hook/`](../sessions/meta/v1.39-precommit-hook/)
- autofix wrapper (v1.64): [`../sessions/meta/v1.64-precommit-autofix/`](../sessions/meta/v1.64-precommit-autofix/)
