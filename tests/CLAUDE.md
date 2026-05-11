# tests/ 모듈 가이드

smoke 스크립트 + pre-commit autofix wrapper. 모든 변경의 회귀 검증 + drift 감지 단일 소스.

상위 진입: [`../CLAUDE.md`](../CLAUDE.md)

## smoke 매트릭스 (현 7 파일 active (`tests/`) + archive 22 (`tests/_inactive/`, v3.6 분리) + helper 1 — `_era_detect.py` v3.0+ era 분류 단일 source)

> **narrative 1차 source**: 본 매트릭스는 회귀 차단 책임의 narrative 1차 source. ARCHITECTURE.md § 3.3 'Verification' 행 정전 분류 (narrative 우위) + § 6.2 lightweight 모드 정책 (v3.6_overengineering-audit 도입) 정합 — active 7 (`tests/`) = pre-commit 강제 (narrative 보조 자동화), archive 22 (`tests/_inactive/`) = 격리 + git history 보존 (manual run leverage narrative 정전화, 사용자 명시 게이트). 신규 smoke 등재 시 회귀 차단 책임 명시 의무.

### 핵심 정책 검증

| smoke | 검증 대상 | `--fix` 지원 |
|-------|---------|:----------:|
| `smoke-spec-verification.sh` | milestone 산출물 JSON schema 검증 — 4 era 자동 식별 (9-stage-bundled v3.0+ / 9-stage v2.0~v2.1 / 7-stage v1.0~v1.4 / 4-tier v1.84~v1.88), `tests/_era_detect.py` 단일 source (v3.0 phase-2 흡수). ARCHITECTURE.md § 6.1 era 정책 | ✅ skeleton 자동 삽입 (v1.29) |
| `smoke-scope-contract.sh` | INTENT.out_of_scope 의무 (또는 7-stage era PLAN.out_of_scope 동치) + APPROVE.md.approval gate (또는 7-stage era DESIGN.approval 동치) + harness-meta.md 안내. era 분기 4 era (9-stage-bundled / 9-stage / 7-stage / 4-tier), `tests/_era_detect.py` import | ✅ skeleton 자동 삽입 (v1.33) |
| `smoke-bash-permission-pattern.sh` | frontmatter 6축 V1/V5/V7/V8/V10 (콜론 패턴/auto-allow set/필드명/콤마 separator/YAML list) | ✅ V1/V5/V7/V8 (v1.60/v1.65) |
| `smoke-thinking-effort.sh` | model+effort 6축 + `thinking:` 필드 silent ignore 차단 (V10) | ✅ V10 + R1/R2/R3 frontmatter insert/replace/delete (v1.61/v1.71) |
| `smoke-broad-bash-fine-grain.sh` | broad Bash 범위 + 필드명 양방향 rename (3 SKILL ↔ 4 agent) | ✅ V5/R2/R6 + Stage 6 (v1.62/v1.63) |
| `smoke-projects-scope-discipline.sh` | root ROADMAP thin index 강제 — milestones[] 키가 root 에 직접 등재되지 않고 `projects/<name>/ROADMAP.md` 에만 (v1.1_meta-as-project) | ❌ |
| `smoke-bundle-trigger.sh` | ARCHITECTURE.md § 6.1 bundling 정책 자동 강제 — v3.0+ 신 schema entry (version 필드 존재) 가 같은 version 값 둘 이상 보유 부재 + milestones_path 필드 형식 검증, historical entry 무시 (forward-only). v3.1 phase-3 신규 (v3.1_smoke-bundle-trigger-validation 흡수) | ❌ |
| `smoke-open-stage-discipline.sh` | ARCHITECTURE.md § 6.1 9-stage-bundled era 디렉토리 ↔ `milestones.md` 페어링 자동 강제 — 디렉토리 명 `^v\d+\.\d+$` (밑줄 부재) 이면서 `milestones.md` 부재 시 FAIL, historical era forward-only skip. `tests/_era_detect.py:27` 표지 1:1 정합. bundle-trigger 와 책임 직교 (entry → 실 파일 vs 디렉토리 → milestones.md). v3.5 phase-1 신규 (v3.4 L1 cascade 검증 흡수) | ❌ |

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
| `smoke-claude-md-drift.sh` | root ↔ 모듈 CLAUDE.md drift 감지 — 존재/back-ref/중복 블록/smoke count 정합 (v1.79) |
| `smoke-cross-ref.sh` | living docs cross-ref 정합 — @import + markdown link (코드 블록/backtick 제외, `--fix` 행 삭제) |
| `smoke-roi-regression.sh` | ai-ready-scorer ROI action 조건식 (정적 4 + 동적 2) |
| `smoke-detect-language.sh` | detect_language priority tie-breaking (Python/Shell 자연 우선) |
| `smoke-agentic-safety-na.sh` | score_agentic_safety N/A 분기 (Helper 1 적용) |
| `smoke-scorer-output-newline.sh` | scorer 산출물 CRLF 회귀 방지 (byte-level) |
| `smoke-python-entry-boilerplate.sh` | Python entry-point boilerplate (AST audit) — P1 `write_text` newline + P2 `__main__` stdout reconfigure (v1.87) |
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

## smoke 작성 5-step 흐름 (v1.75+)

신규 smoke 작성 또는 기존 smoke 수정 시 의사결정 트리. v1.75에서 module-skill 패턴 거부 후 본 모듈 CLAUDE.md 단일 source-of-truth로 통합.

### Step 1 — Identify (사용자 의도 분류)

| 의도 | 분기 |
|------|------|
| 신규 smoke 작성 | Step 2 → Plan (카테고리 선택) |
| 기존 smoke 수정 | 본 §"smoke 매트릭스"에서 대상 식별 후 Step 3 직행 |
| `--fix` mode 추가 | Step 4-bis (위 §"--fix mode 패턴" 적용) |
| smoke 회귀 검증 | Step 5 (Register) skip → §"회귀 검증 절차" 직행 |

### Step 2 — Plan (카테고리 + skeleton 선택)

신규 smoke의 적합 카테고리 결정 (위 §"smoke 매트릭스" 참조):

- **핵심 정책 검증** — PLAN/REPORT/frontmatter spec 등 모든 세션 영향
- **인프라 검증** — install / overlay / sync 등 배포 메커니즘
- **도메인 별 회귀** — 특정 기능 / scorer / hook 등 좁은 영역

판정 트리:

```text
영향 범위가 모든 세션? → 핵심 정책 검증 (5건 카테고리)
배포 메커니즘 검증?   → 인프라 검증 (7+건 카테고리)
좁은 도메인 검증?     → 도메인 별 회귀 (7건 카테고리)
모호 시               → 사용자에게 카테고리 선택 요청
```

### Step 3 — Generate (bash skeleton 작성)

위 §"출력 패턴" 표준 적용 + 아래 §"Skeleton 선택 매트릭스"에서 시나리오별 skeleton 선택.

**Python heredoc 사용 시 의무 boilerplate** (v3.0 phase-6 흡수 v2.2_smoke-cp949-encoding-pattern):

```python
import sys
# Windows cp949 콘솔 UnicodeEncodeError 회피 (§ '흔한 함정' 6번 항목, smoke-python-entry-boilerplate § P2 v1.87)
if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
```

본 boilerplate 부재 시 Windows Git Bash 환경에서 한글/em dash 출력 fail. tests/smoke-python-entry-boilerplate.sh AST audit 이 자동 강제.

### Step 4 — Validate (E2E violation 주입)

위 §"회귀 검증 절차"의 신규 smoke 추가 절차 적용 — 의도된 violation 주입 → FAIL → 정정 → PASS 순.

### Step 4-bis — `--fix` mode 추가 (기존 smoke 확장 시)

위 §"--fix mode 패턴" 표준 인터페이스 적용. Python heredoc 위임 임계는 frontmatter 구조 삽입 / JSON 조작 / 다중 라인 매칭.

### Step 5 — Register (등재)

1. `chmod +x tests/smoke-<name>.sh` (Linux/macOS)
2. 본 모듈 §"smoke 매트릭스" 표에 1 row 추가
3. **(user discretion)** `.pre-commit-config.yaml`에 등록 검토 — 자주 실패하는 항목만
4. **(user discretion)** `.github/workflows/ci.yml`에 자동 실행 추가
5. 회귀 검증 — §"회귀 검증 절차" 의무

## Skeleton 선택 매트릭스 (v1.75+)

| 시나리오 | skeleton |
|---------|---------|
| 정적 패턴 grep만 | `check + grep -qE` 단순 패턴 |
| 정적 + 동적 (실행 검증) | mktemp tmpdir + 명령 실행 + exit code 검증 |
| Cross-OS (Linux only dynamic) | `if [[ "$OSTYPE" == "linux-gnu"* ]] \|\| [[ "$OSTYPE" == "darwin"* ]]; then ...; fi` 분기 |
| `--fix` mode-only | argv 파싱 + Python heredoc + .bak 백업 idempotent |
| LEGACY skip 적용 | `LEGACY_FILES=(...)` array + `for f in $TARGETS; do contains "$f" && continue; done` |
| `--include-legacy` opt-in | flag 추가 + LEGACY 포함 enumerate (v1.34 precedent) |
| era 분류 검사 vs ROADMAP entry schema 검증 (책임 분리, v3.1 L3 D16) | era 분류 = milestone 디렉토리 책임 → `tests/_era_detect.py` 호출 / entry schema = ROADMAP `milestones[]` 책임 → `version` 필드 등 직접 검사. 같은 smoke 에 두 책임 혼재 금지 (향후 era 추가 시 복잡도 누적). |
| ROADMAP entry `status` 기반 검증 분기 (v3.1 L9 post-EXECUTE discovery) | `status: "pending"` → `milestones_path` 부재 허용 (OPEN stage 미완료, 정상). `status: "in_progress"` 또는 `"completed"` → `milestones_path` 검증 의무. smoke 내 분기: `if entry["status"] == "pending": continue` 패턴. |

## 흔한 함정 (7 evidence-base, v1.75+ / v3.0 cp949 / v3.1 markdownlint 추가)

harness-meta 실 사례 누적:

| 함정 | 증상 | 회피 |
|------|------|------|
| **`pipefail` 회귀** (v1.30b) | `cmd \| head -1` 같은 파이프에서 head exit 141 시 전체 fail | 영향 받는 라인만 `set +o pipefail; ...; set -o pipefail` 또는 `\|\| true` |
| **`grep -c \|\| echo 0` 이중 출력** (v1.63) | grep 0 매치 시 `0` + echo `0` → 변수에 `0\n0` 들어감 | boolean 분리: `grep -qE '...' && var=1 \|\| var=0` |
| **MSYS2 path translation** (v1.70) | Windows Git Bash가 `/c/Users/...` 인자를 `C:\Users\...`로 변환 → Python sys.argv mismatch | bash 인자 전달 대신 `sys.argv` 경유 + Python `Path(sys.argv[1])` 정규화 |
| **shellcheck SC2010/SC2064/SC2088/SC2034** (v1.66) | `ls\|grep` (SC2010) / single-quote trap (SC2064) / `~` expansion 안 됨 (SC2088) / unused var (SC2034) | `find` 대체 / double-quote trap / `$HOME` 사용 / `# shellcheck disable=...` |
| **CRLF 라인 종결** (회귀 잠재) | `$'\r': command not found` 오류 | `.gitattributes`로 LF 강제 + Python file write 시 `newline='\n'` 명시 |
| **Windows cp949 콘솔 인코딩** (v2.1 phase-1, v3.0 phase-6 흡수 v2.2_smoke-cp949-encoding-pattern) | Python heredoc 안 한글/em dash (U+2014) 출력 시 `UnicodeEncodeError: 'cp949' codec can't encode character` | Python entry-point 직후 `if hasattr(sys.stdout, 'reconfigure'): sys.stdout.reconfigure(encoding='utf-8', errors='replace')` (D15 errors 인자 명시 통일). AST audit 자동 강제: `tests/smoke-python-entry-boilerplate.sh` § P2 (v1.87) — `__main__` + `print()` 보유 script 의 reconfigure 호출 의무 검증 |
| **markdownlint MD032/MD049 자동 차단** (v3.0 phase-3, v3.1 phase-1 흡수) | (a) MD032 (blanks-around-lists) — 강조 직후 list 시작 시 빈 줄 부재로 fail (예: `**필수 게이트**:\n- item` → `**필수 게이트**:\n\n- item`). (b) MD049 (emphasis-style consistent) — 단어 내부 underscore 가 emphasis 로 오인 (예: `v{X.Y}_{slug}` 의 `_` pair 가 italic 시도) | (a) 강조 (`**...**`) 직후 list 시 빈 줄 1개 의무. (b) underscore 포함 identifier 백틱 escape (`` `v{X.Y}_{slug}` ``). markdownlint MD049 spec 직접 인용: "intra-word emphasis is restricted to asterisk to avoid unwanted emphasis for words containing internal underscores" (`/davidanson/markdownlint` doc/md049.md). pre-commit `markdownlint-cli` (v0.42.0) hook 자동 차단 — phase commit 전 `markdownlint --all-files` self-check 권장 |

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
- **Controlled 비교 패턴** (v2.1 lessons L3, v3.0 phase-7 흡수 v2.2_smoke-controlled-comparison-pattern): 단순 baseline vs post 비교는 milestone 상태 변화 (신규 milestone 추가, 기존 milestone status 변환) 로 PASS/SKIP 분포 차이 발생. 동치 검증을 위해 commit 전후 동일 milestone set 입력에서 출력 동치 확인:

  ```bash
  # baseline (HEAD 시점 smoke + 현 milestone set)
  git show HEAD:tests/smoke-<name>.sh > /tmp/old.sh
  bash /tmp/old.sh > /tmp/old.out

  # post (수정 후 smoke + 동일 milestone set)
  bash tests/smoke-<name>.sh > /tmp/new.out

  # CRLF 정규화 후 diff (Windows + Linux 차이 제거)
  diff <(tr -d '\r' < /tmp/old.out) <(tr -d '\r' < /tmp/new.out)
  # diff 결과 빈 = 출력 동치 PASS / 비어있지 않음 = 의도된 변경 또는 회귀
  ```

  의도된 변경 (예: 신규 era 분기 추가) 인 경우 diff 결과를 narrative 로 기록 (REPORT.lessons_learned). 의도되지 않은 회귀 시 phase commit revert (R5 mitigation).

  **violation 주입 단계의 cp949 mojibake 출력 — 정상 작동** (v3.1 L5): controlled 비교 4-step 에서 violation 주입 시 smoke Python heredoc 안 한글/em dash 출력이 깨져 보이는 경우가 있다 (cp949 콘솔에서 `errors='replace'` 치환 → `?` 또는 유사 문자). 이는 `sys.stdout.reconfigure(errors='replace')` 의 **의도된 동작** — UnicodeEncodeError 없이 exit=1 정상 반환. 한글 가독성 손실은 수용 trade-off (자동화 파이프라인 정상 동작 우선). 가독성 필요 시: `bash tests/smoke-<name>.sh 2>&1 | iconv -f utf-8 -t cp949` 선택 사항.

## Pre-commit 통합

```bash
pip install pre-commit   # or: pipx install pre-commit
pre-commit install       # one-time per clone
pre-commit run --all-files                     # manual run
pre-commit run smoke-spec-verification         # individual hook
pre-commit run smoke-scope-contract
pre-commit run smoke-cross-ref                 # v1.78b — broken @import / markdown link 자동 차단
pre-commit run smoke-claude-md-drift           # v1.79b — root ↔ 모듈 CLAUDE.md drift 자동 차단
```

**v1.64+ autofix**: smoke 실패 시 `precommit-autofix-or-fail.sh` wrapper가 `--fix` 자동 시도 + 안내 후 abort. 사용자는 `git diff` 검토 → `git add -u` 재스테이징 → 재커밋.

## Pre-commit hook entry 정책 (v1.80+)

`.pre-commit-config.yaml` local hook의 `entry` 필드 결정 기준. 신규 smoke를 pre-commit에 등록할 때 적용.

| smoke `--fix` 지원 여부 | `entry` 형식 |
|:--------------------:|------------|
| ✅ 지원 | `bash tests/precommit-autofix-or-fail.sh tests/<smoke>.sh` |
| ❌ 미지원 | `bash tests/<smoke>.sh` |

**wrapper 경유 (`--fix` 지원)**: 실패 시 wrapper가 `--fix` 자동 시도 → 정정 파일 생성 → exit 1 + 안내. 사용자는 `git diff` 검토 후 `git add -u` 재스테이징.

**직접 호출 (`--fix` 미지원)**: 콘텐츠 drift 등 사람 판단이 필요한 검사. 자동 정정 불가이므로 wrapper 불경유. smoke가 직접 실패/성공 반환.

### 현행 hook 현황 (v1.1_smoke-precommit-rewrite 기준)

**v1.1_smoke-precommit-rewrite (2026-05-08) + v3.1 phase-3 (2026-05-10) + v3.5 phase-1 (2026-05-11)**: 5 hook (v1.1) + 1 hook (v3.1 smoke-bundle-trigger) + 1 hook (v3.5 smoke-open-stage-discipline). 총 7 hook active.

| hook id | smoke 파일 | 상태 | `--fix` | entry 방식 | `files:` 패턴 |
|---------|-----------|------|:-------:|-----------|--------------|
| `smoke-projects-scope-discipline` | `smoke-projects-scope-discipline.sh` | **active** | ❌ | direct | `ROADMAP\.md$\|projects/.*/ROADMAP\.md$` |
| `smoke-spec-verification` | `smoke-spec-verification.sh` | **active** | ❌ | direct | `projects/[^/]+/milestones/v[^/]+/.*\.md$` |
| `smoke-scope-contract` | `smoke-scope-contract.sh` | **active** | ❌ | direct | `projects/[^/]+/milestones/v[^/]+/.*\.md$\|claude/commands/harness-meta\.md$` |
| `smoke-cross-ref` | `smoke-cross-ref.sh` | **active** | ✅ | wrapper | `\.(md\|sh\|ps1\|toml\|json\|yaml\|yml\|py\|txt)$` |
| `smoke-claude-md-drift` | `smoke-claude-md-drift.sh` | **active** | ❌ | direct | `CLAUDE\.md$\|tests/smoke-.*\.sh$` |
| `smoke-bundle-trigger` | `smoke-bundle-trigger.sh` | **active** (v3.1) | ❌ | direct | `ROADMAP\.md$\|projects/.*/ROADMAP\.md$` |
| `smoke-open-stage-discipline` | `smoke-open-stage-discipline.sh` | **active** (v3.5) | ❌ | direct | `projects/[^/]+/milestones/v[0-9]+\.[0-9]+/.*\.md$\|\.pre-commit-config\.yaml$` |

**Archive (inactive smoke, v3.6_overengineering-audit 권고 #4 도입)**: 위 active 7 외 22 smoke 는 `tests/_inactive/` 하위로 격리 (git mv, history 보존). 이전 'manual leverage' narrative 가 실 검증 부재 변명 — archive 격리로 정전화 (active 7 (`tests/`) = pre-commit 강제 / archive 22 (`tests/_inactive/`) = 디렉토리 분리, 실 사용시 `bash tests/_inactive/<smoke>.sh` 직접 호출). ARCHITECTURE.md § 6.2 lightweight 모드 정책 정합 (workflow self-improvement 동결 + narrative 정전화). archive smoke 의 active 승격 trigger 조건: 외부 프로젝트 실 적용에서 정량 데이터 기반 회귀 차단 필요성 명시 발의만 (release train / lessons_learned 자동 후속 등재 금지).

위 카테고리 표 (인프라 검증 / 도메인 별 회귀) 거명된 inactive smoke 의 path prefix 는 `tests/_inactive/` — 본 narrative 가 표 path 단일 cascade source (표 항목 path 개별 갱신 회피, lightweight 정신).

## 외부 의존

- **shellcheck** (pre-commit framework가 자동 설치)
- **markdownlint** (동상)
- **Python 3.10+** (smoke 일부 + ai-ready-scorer + post-report-write.sh)
- **jq** (선택, smoke 일부)

## 관련 문서

- 상위 진입: [`../CLAUDE.md`](../CLAUDE.md)
