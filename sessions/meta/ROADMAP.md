# meta ROADMAP — 후속 세션 통합 view

`sessions/meta/v1.36-roadmap-unification-and-flow/`에서 `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md`로부터 이관·확정. **메타 전역 단일 ROADMAP** — S1~S3 후속 세션의 횡단 view. 프로젝트별 ROADMAP은 `projects/<name>/ROADMAP.md` 분리.

⚠️ **본 파일은 운영 docs 성격** — `sessions/meta/` 트리에 있지만 `vX.Y-{name}/PLAN.md+REPORT.md` 한 쌍 규약(CLAUDE.md "구조 규칙 (CRITICAL)")의 **예외 1 파일**. 후속 트리거 통합 view 단일 소스 + harness-meta 8단계 흐름의 단계 3(ROADMAP 읽기) + 단계 9(ROADMAP 갱신) 진입점.

마지막 audit: 2026-05-04 (v1.64 기준)

## 1. 정의 — Evidence-driven 패턴

### 1-1. 의미

evidence-driven 후속이란 **외부 trigger (사용자 등장 / 회귀 / 환경 변화 등) 발생 시점부터 진행 가능**한 세션을 의미. v1.10e REPORT L3에서 패턴 정착:

> "evidence가 후속 동기 자연 유도 — sample T1 추출률 0% 명시 → 사용자가 한계 인지 → v1.10e2 채택 결정 자연 유도. evidence-driven 후속 분기"

### 1-2. Trigger 종류 5분류

| 종류 | trigger 발생 메커니즘 | schedule 등록 가능? |
|:----:|----------------------|:-:|
| **A** 외부 사용자 등장 | 사용자가 명시적으로 도입/사용 요청 | ❌ (자동 감지 불가) |
| **B** 회귀/장애 evidence | verify.ps1/sh 실패, install fail 등 | ⚠️ (CI hook 등록 가능) |
| **C** 외부 환경 변화 | PyPI unpublish, upstream archived 등 | ✅ (정기 점검 가능) |
| **D** 설계 결정 선행 | 타입 안전성 redesign 등 prerequisite | ❌ (시간 trigger 아님) |
| **E** 정규화 우선순위 미달 | 사용자 사례 누적 (3+) | ❌ (사용자 입력 시점만) |

### 1-3. 임계 도달 인식

evidence 누적 임계는 각 후속 세션 정의 시점에 명시 (예: `evidence 3+ 사례`). 임계 도달 시 §3 → §2로 promote.

## 2. 다음 후보 (활성)

| # | 후속 세션 | 카테고리 | 진행 근거 | 출처 |
|:-:|---------|---------|---------|------|
| 1 | **`v1.22-skills-categories`** → **본 v1.36에서 흡수 완료** (audit/dev-tools 2 카테고리 도입) | skills-distribution | ✅ archive |

(현재 진행 가능 활성 항목 0건 — v1.22 흡수 후. 신규 후보는 §3에서 trigger 도달 시 promote)

## 3. Out of scope (trigger 대기)

### 3-A. 외부 사용자 등장 의존 (9건)

| 후속 세션 | Trigger 조건 | 출처 |
|---------|------------|------|
| `v1.11b-overlay-python-skill` | Python 사용자 1+ 등장 | `OVERLAY.md` |
| `v1.11c-overlay-typescript` | TS 사용자 등장 | `OVERLAY.md` |
| `v1.11c+`-overlay-go | Go 사용자 등장 | `OVERLAY.md` |
| `v1.11c+`-overlay-rust | Rust 사용자 등장 | `OVERLAY.md` |
| `v1.11c+`-overlay-java | Java 사용자 등장 | `OVERLAY.md` |
| `v1.11c+`-overlay-kotlin | Kotlin 사용자 등장 | `OVERLAY.md` |
| `v1.11c+`-overlay-csharp | C# 사용자 등장 | `OVERLAY.md` |
| `v1.18i-package-promotion` (`__init__.py` + `python -m`) | 외부 scorer 사용자 등장 | `v1.18g REPORT` |
| `v1.28b-anthropic-sdk-source` | claude-api skill 활용 evidence 누적 | `v1.28 REPORT` |
| ~~`v1.39c-fix-autofix`~~ | ✅ 완료 (v1.64 세션, 2026-05-04) | — |
| `v1.57c-hook-bash-detect` | `Bash` 통한 REPORT.md 작성 시 hook 미발화 evidence | `v1.57 REPORT` |

### 3-B. 회귀/장애 evidence 의존 (13건)

| 후속 세션 | Trigger 조건 | 출처 |
|---------|------------|------|
| `v1.15c-ci-windows-runner` | install-project-claude.ps1 회귀 의심 evidence | `v1.15 REPORT` |
| `v1.29c-sentinel-check` (SPEC_SKELETON ↔ §2 drift) | drift 실 발생 | `v1.29 REPORT` |
| `v1.30d-project-claude-backup-cleanup` | `<proj>/.claude/backup-<ts>/` 누적 + git status 부담 | `v1.30 REPORT` |
| `v1.30e-backup-restore-cli` | 사용자 backup 복원 요구 | `v1.30 REPORT` |
| ~~`v1.18g3-helper-redesign`~~ | ✅ 완료 (v1.50 세션, 2026-05-04) | — |
| `v1.18h-category-max-recalibration` | CATEGORY_META mismatch | `v1.35 REPORT`, `v1.18g2 REPORT` |
| `v1.18d2-multi-script-encoding` | 다른 글로벌 user-skill `scripts/*.py`에서 cp949 UnicodeEncodeError 재발 | `v1.18d REPORT` |
| ~~`v1.51b-roi-smoke`~~ | ✅ 완료 (v1.52 세션, 2026-05-04) | — |
| ~~`v1.36b4-hook-debug-log`~~ | ✅ 완료 (v1.54 세션, 2026-05-04) | — |
| `v1.39b-hooks-expand` | 다른 smoke hook 포함 (실패 빈도 evidence 누적 후) | `v1.39 REPORT` |
| ~~`v1.40c-hook-more-tools`~~ | ✅ 완료 (v1.57 세션, 2026-05-04) | — |
| ~~`v1.40d-hook-pattern-expand`~~ | ✅ 완료 (v1.59 세션, 2026-05-04) | — |
| `v1.59b-hook-filename-rename` | hook 파일명 변경 (`post-report-write.sh` → `post-harness-write.sh` 등) 수요 evidence 3+ | `v1.59 REPORT` |
| ~~`v1.56-quality-file-split`~~ | ✅ 완료 (v1.56 세션, 2026-05-04) | — |
| `v1.57b-hook-notebookedit-cell-extract` | REPORT.ipynb 실사용 + cell source에서 섹션명 추출 요구 evidence | `v1.57 REPORT` |

### 3-C. 외부 환경 변화 trigger (2건 — Schedule 후보)

| 후속 세션 | Trigger 조건 | 출처 |
|---------|------------|------|
| `vX-mindvault-self-fork` | PyPI mindvault-ai unpublish 발생 | `v1.20 REPORT` |
| `v1.20b-mindvault-alternative` | upstream archived 후 graphify 등 active alternative 사용 패턴 변화 | `SKILLS.md` |

### 3-D. 설계 결정 선행 (1건)

| 후속 세션 | Trigger 조건 | 출처 |
|---------|------------|------|
| ~~`v1.36d-detect-language-refactor`~~ | ✅ 완료 (v1.53 세션, 2026-05-04) | — |
| `vX-type-safety-paradox-resolve` | 타입 안전성 역설 구조 실제 해소 — harness-meta `.sh` 파일이 `.md`보다 적어도 Shell 우선 감지. v1.53 prerequisite 완료 후 사용자 발의 또는 evidence 수집 | `v1.18 REPORT L3`, `v1.53 REPORT` |

### 3-E. 정규화 우선순위 미달 (5건)

| 후속 세션 | Trigger 조건 | 출처 |
|---------|------------|------|
| `v1.10i-license-case3-enhancement` | LICENSE Case 3 evidence 3+ 누적. 현재 0건 | `v1.10h REPORT`, `v1.11 REPORT` |
| `v1.10i` non-SPDX 정규화 (`Apache 2.0` → `Apache-2.0`) | non-SPDX form 메타 사례 3+ 누적. 현재 1건 (Oracle) | `INTERVIEW_FLOW.md`, `v1.10h2 REPORT` |
| ~~`v1.46b-scorer-config-separation-na`~~ | ✅ 완료 (v1.47 세션, 2026-05-03) | — |
| ~~`v1.46c-scorer-linter-na`~~ | ✅ 완료 (v1.48 세션, 2026-05-03) | — |
| ~~`v1.18e-scorer-html-na-ui`~~ | ✅ 완료 (v1.49 세션, 2026-05-04) | — |
| ~~`v1.57d-hook-msg-dynamic-filename`~~ | ✅ 완료 (v1.58 세션, 2026-05-04) | — |
| ~~`v1.60b-fix-thinking-effort`~~ | ✅ 완료 (v1.61 세션, 2026-05-04) | — |
| `v1.61b-fix-model-effort-insert` | R1/R2/R3/R4 model+effort frontmatter 구조 삽입 auto-fix evidence | `v1.61 REPORT` |
| ~~`v1.60c-fix-broad-bash-fine-grain`~~ | ✅ 완료 (v1.62 세션, 2026-05-04) | — |
| ~~`v1.62b-fix-field-name-rename`~~ | ✅ 완료 (v1.63 세션, 2026-05-04) | — |
| `v1.63b-fix-field-name-both-merge` | 양쪽 필드 동시 존재 시 자동 merge/delete 정책 evidence (3+ case) | `v1.63 REPORT` |
| `v1.60d-v8-v9-structural-fix` | V8 콤마 separator + V9 YAML list 항목 수 auto-fix 구조적 변환 evidence | `v1.60 REPORT` |

### 3-F. v1.36 신규 (1건)

| 후속 세션 | Trigger 종류 | Trigger 조건 | 출처 |
|---------|:----------:|------------|------|
| `v1.37-skills-3-tier-categories` | E | 5+ skill 추가 후 3단계 구조 필요 evidence | `v1.36 PLAN Out of scope` |

## 4. Schedule 후보 (cadence 근거)

evidence 발생을 **자동 감지 가능**한 항목만. 외부 사용자 등장(§3-A)은 자동 감지 불가하므로 schedule 후보 아님.

### 4-1. `mindvault-pypi-check` — **월 1회**

- **작업**: `pip index versions mindvault-ai` 또는 PyPI API → unpublish/yank 감지 시 `vX-mindvault-self-fork` trigger
- **cadence 근거**: PyPI archived 패키지 통상 6~24개월 내 maintainer unpublish/yank. 월 1회 = trigger 발현 ≤30일 지연

### 4-2. `mindvault-alternative-survey` — **분기 1회 (3개월)**

- **작업**: graphify 등 active alternative GitHub stars/commits 활성도 모니터링
- **cadence 근거**: 활성 OSS 도구 통상 분기 단위 major release

### 4-3. `project-claude-backup-audit` — **월 1회**

- **작업**: 활성 프로젝트 `.claude/backup-<ts>/` 누적 개수 측정. 임계 5+ 도달 시 `v1.30d` trigger
- **cadence 근거**: install-project-claude 재실행 빈도 월 1~3회. 임계 5+ 도달 = 1~5개월

⚠️ 위 cadence는 모두 **추정값**. 실 발생 빈도 관찰 후 조정 권장.

## 5. 자동 검증 (drift 감지)

본 docs drift 자동 감지: `bash tests/smoke-roadmap-sync.sh` (v1.36에서 `smoke-archive-sync.sh` rename + glob 양쪽 지원).

| Stage | 검증 내용 | --fix |
|-------|---------|:---:|
| 1 | post-v1.31 메타 §"최근 완료" entry 존재 (per session) | ✅ skeleton 자동 삽입 |
| 2 | §"다음 후보" 활성 ranking 정합 | ❌ manual edit |
| 3 | §"Out of scope (trigger 대기)" 표 정합 | ❌ 사용자 판단 |
| 4 | §"최근 완료" 카운트 동기화 | ❌ manual edit |
| 5 | 프로젝트 ROADMAP "최근 완료" entry per 프로젝트 세션 (v1.36+) | ⏭️ 프로젝트 ROADMAP 부재 시 skip |

**호출 시점**:
- 매 메타 또는 프로젝트 세션 종료 시 (REPORT.md 작성 후)
- commit 직전 (수동 또는 pre-commit hook v1.31d 후속)
- `--fix` 호출 → §"최근 완료" skeleton 삽입 → 사용자 TODO 채움 → 재커밋

**LEGACY_SESSIONS skip 정책**: pre-v1.31 메타 53건은 forward-only (smoke 영구 skip). v1.27 LEGACY_REPORTS 패턴 정합.

## 6. 갱신 정책

### 6-1. 진행 가능 항목 진행 시

해당 row를 `✅ 완료 (vX.Y 세션, YYYY-MM-DD)` 표기 후 **archive 섹션** (§8 최근 완료)으로 이동. §2 활성 목록 축소.

### 6-2. 신규 evidence-driven 후속 추가 시

각 메타 세션 REPORT의 "다음 후보" 섹션 작성 후 본 docs §3 또는 §4에 row 추가. **drift 회피**: 도메인 docs와 본 docs **동시 갱신 의무 부재**. 본 docs는 분류·통합 view 우선, 상세는 도메인 docs 단일 소스 유지.

### 6-3. 진행 불가 → 진행 가능 promote

trigger 발생 감지 (사용자 명시 또는 정기 schedule 결과) 시 §3 row를 §2로 이동 + 진행 근거 갱신. 임계 도달 명시 (예: "evidence 3+ 도달, sample N").

### 6-4. `harness-roadmap-update` SKILL 자동 갱신 (v1.36+)

REPORT.md 작성 직후 `harness-roadmap-update` SKILL 명시 invoke (단계 9). SKILL이 5-step (Identify / Validate / Classify / Sanitize / Update) 진행 후 §8 최근 완료 + §3 trigger 대기 자동 갱신. 분류 애매 시 `AskUserQuestion` 자동 invoke.

## 7. 관련 문서

- 상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md) · [`../../README.md`](../../README.md)
- 세션 소속 (S1~S7): [`../../bootstrap/docs/OWNERSHIP.md`](../../bootstrap/docs/OWNERSHIP.md)
- Language overlay 후속: [`../../bootstrap/docs/OVERLAY.md`](../../bootstrap/docs/OVERLAY.md) §13
- 글로벌 user-skill 후속: [`../../bootstrap/docs/SKILLS.md`](../../bootstrap/docs/SKILLS.md) §9
- Spec verification 후속: [`../../bootstrap/docs/SPEC_VERIFICATION.md`](../../bootstrap/docs/SPEC_VERIFICATION.md) §10-2
- 8단계 흐름: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md)
- ROADMAP 갱신 SKILL: [`../../bootstrap/skills/audit/harness-roadmap-update/SKILL.md`](../../bootstrap/skills/audit/harness-roadmap-update/SKILL.md)
- 본 docs 단일화 세션: [`v1.36-roadmap-unification-and-flow/`](v1.36-roadmap-unification-and-flow/)

## 8. 최근 완료

| 완료 세션 | 진행 일자 | 산출 |
|---------|---------|------|
| **v1.64-precommit-autofix** | 2026-05-04 | pre-commit 실패 시 `--fix` 자동 시도 + 안내 후 abort. `tests/precommit-autofix-or-fail.sh` wrapper 신설(범용 — smoke path 인자) + `.pre-commit-config.yaml` 2 hook(smoke-spec-verification + smoke-scope-contract) entry wrapper 경유 + README.md 안내. safe abort 패턴(Approach B) — 사용자 `git diff` 검토 후 `git add -u` 재스테이징. PASS 경로 423/148 PASS. E2E FAIL 시나리오: § 누락 주입 → wrapper --fix 자동 정정 + exit 1 + 안내. 회귀 0. v1.39c-fix-autofix trigger 이행. |
| **v1.63-fix-field-name-rename** | 2026-05-04 | `tests/smoke-broad-bash-fine-grain.sh` `--fix` block에 Stage 6 field name bidirectional rename 추가. 3 SKILL `^tools:` → `^allowed-tools:` + 4 agent `^allowed-tools:` → `^tools:`. 양쪽 필드 동시 존재 시 skip(수동 정정 필요). `grep -c || echo 0` 이중 출력 함정 해결 — boolean 분리 패턴(`grep -qE && var=1`). default 6/6 PASS (회귀 0). E2E 3 시나리오 검증(SKILL rename + agent rename + both skip). v1.62 패턴 확장. v1.62b-fix-field-name-rename trigger 이행. |
| **v1.62-fix-broad-bash-fine-grain** | 2026-05-04 | `tests/smoke-broad-bash-fine-grain.sh`에 `--fix` mode 도입. argv 파싱(`--fix`/`--dry-run`/`--help`) + V5(7 파일 auto-allow set YAML list 삭제) + R2/R6(4 NO_BASH_FILES — harness SKILL + 3 agent dispatcher/explore/grey-area Bash declare 삭제). V8/V9/Stage 4/Stage 6 field name은 Out of scope. default 6/6 PASS (회귀 0). E2E 시나리오 두 종류 violation(V5+R6) 정정 검증. v1.60/v1.61 패턴 답습. v1.60c-fix-broad-bash-fine-grain trigger 이행. |
| **v1.61-fix-thinking-effort** | 2026-05-04 | `tests/smoke-thinking-effort.sh`에 `--fix` mode 도입. argv 파싱(`--fix`/`--dry-run`/`--help`) + V10(`^thinking:` line auto-remove) 자동 정정. R1/R2/Stage 5는 Out of scope (frontmatter 구조 삽입 또는 다른 smoke 중복 회피). default 5/5 PASS (회귀 0). E2E 시나리오 검증(violation 주입 → --fix → 정정 + PASS). v1.60 패턴 답습. v1.60b-fix-thinking-effort trigger 이행. |
| **v1.60-fix-bash-permission-pattern** | 2026-05-04 | `tests/smoke-bash-permission-pattern.sh`에 `--fix` mode 도입. argv 파싱(`--fix`/`--dry-run`/`--help`) + V1(`Bash(cmd*)` → `Bash(cmd *)`) + V5(YAML list 자동허용 set 줄 삭제, anchor `^[[:space:]]*-[[:space:]]*...$`로 markdown body 보호) + V7(`^tools:` → `^allowed-tools:` slash command만). V8/V9/V4 Out of scope. default 6/6 PASS (회귀 0). E2E 시나리오 검증(violation 주입 → --fix → 정정 + PASS). v1.33 패턴 답습. v1.29b-fix-other-smokes trigger 부분 이행. |
| **v1.59-hook-pattern-expand** | 2026-05-04 | `post-report-write.sh` PLAN.md 감지 추가. `FILE_TYPE` 분기(REPORT\|PLAN) + MSG 라우팅(PLAN → `/harness-plan-verify`, REPORT → `/harness-roadmap-update`). `REPORT_BASENAME` → `FILE_BASENAME`. smoke 18→20/20 PASS (Test P+Q 신규). 회귀 0. ROADMAP §3-B `v1.40d-hook-pattern-expand` trigger 이행. |
| **v1.58-hook-msg-dynamic-filename** | 2026-05-04 | `post-report-write.sh` MSG 동적 파일명 반영. `REPORT_BASENAME=$(basename "$NORM_PATH")` 추출 + MSG 2개소 `REPORT.md` → `${REPORT_BASENAME}` 치환. `smoke-posttooluse-hook.sh` Test O 신규 (NotebookEdit + REPORT.ipynb → MSG에 'REPORT.ipynb' 포함 검증). smoke 18/18 PASS. 회귀 0 (A~N 17 tests). ROADMAP §3-E `v1.57d` trigger 이행. |
| **v1.57-hook-notebookedit** | 2026-05-04 | PostToolUse hook `post-report-write.sh`에 NotebookEdit 도구 지원. case 매처 `Write\|Edit\|MultiEdit\|NotebookEdit` 확장 + Python/grep 양쪽 `notebook_path` 분기 + 패턴 `REPORT\.(md\|ipynb)$`. install.ps1 matcher migration (`Edit\|Write\|MultiEdit` → `Edit\|Write\|MultiEdit\|NotebookEdit`) + 메시지 4개소 갱신. verify.ps1/sh Stage J 갱신 (3+4개소). smoke 17/17 PASS (Test M+N 신규) + verify.ps1 43/43 PASS. context7 `NotebookEditInput.notebook_path` 공식 확인 drift=no. 회귀 0 (smoke-spec-verification 360/360 + smoke-scope-contract 134/134 + smoke-roi-regression 6/6). ROADMAP §3-B `v1.40c-hook-more-tools` trigger 이행. Delete 제외 (의미론적). |
| **v1.56-quality-file-split** | 2026-05-04 | `categories_quality.py` (545줄) → 4 파일 분할 (categories_documentation/code_structure/type_safety/test_quality, 각 117~207줄). `score_codebase.py` import 갱신. 파일 크기 체크 2/3→3/3 (1pt 회복, 93→94/100 S). smoke-roi-regression 6/6 + smoke-detect-language 6/6 + smoke-agentic-safety-na 5/5 PASS. 회귀 0. |
| **v1.55-agentic-safety-na** | 2026-05-04 | `score_agentic_safety()` 상단 `na_repo` 추출 + 3 sub-check Helper 1 N/A 분기 (`.env.example` / `Claude Code 권한 설정` / `가드레일 파일`). `rubric.md` §"적용 체크" 25→28건. `tests/smoke-agentic-safety-na.sh` 신설 5/5 PASS (정적 2 + 동적 3). harness-meta 93/100 변동 0. 회귀 0 (smoke-roi-regression 6/6 + smoke-detect-language 6/6 + smoke-scope-contract 130/130 + smoke-spec-verification 342/342). 에이전틱 안전 카테고리 N/A 적용 첫 시리즈. |
| **v1.54-hook-debug-log** | 2026-05-04 | `claude/hooks/post-report-write.sh` R1(python3 미설치 WARN) + R2(양쪽 파서 실패 시 TOOL_NAME='' WARN + 조기 종료) + 헤더 갱신. `tests/smoke-posttooluse-hook.sh` Test L 신규 (malformed JSON → stderr WARN 검증, mktemp stdout/stderr 분리 캡처). smoke 14→15/15 PASS. 전체 smoke 회귀 0. ROADMAP §3-B `v1.36b4-hook-debug-log` trigger 이행. silent NOOP 진단 가능 경로 확보. |
| **v1.53-detect-language-refactor** | 2026-05-04 | `utils.py` `_LANG_PRIORITY` 상수 + `detect_language` priority tie-breaking + Shell lang_map 등재. `is_shell_markdown_only_repo` 조건 #1 재구조화 (tiny Python N/A 보호 유지). `tests/smoke-detect-language.sh` 신설 6/6 PASS. harness-meta 93/100 S 변동 0. ROADMAP §3-D `v1.36d` 이행. 신규 후속 `vX-type-safety-paradox-resolve` §3-D 등록. |
| **v1.52-roi-smoke-regression** | 2026-05-04 | `tests/smoke-roi-regression.sh` 신설 — 정적 4 + 동적 2 = 6/6 PASS. `compute_roi_actions` / `top_actions` 조건식 존재 grep + mock Check(na/eligible/perfect) 3 케이스 동적 검증. ROADMAP §3-B `v1.51b-roi-smoke` trigger 이행. 회귀 0. |
| **v1.51-roi-action-bug-fix** | 2026-05-04 | `compute_roi_actions` / `top_actions` / `html_renderer` 3개소 `not passed` → `score < max_score and not na` 조건 수정. `passed=False` 코드가 전체에 없어 ROI 액션이 영구 0건이던 버그 해소. harness-meta ROI 1건 생성 확인. ⚠️ 아이콘 도입. 93/100 S 변동 0 (회귀 0). |
| **v1.50-helper-ratio-redesign** | 2026-05-04 | `is_shell_markdown_only_repo` 조건 #4 count→OR(count<10 \| ratio<10%) 재설계. `_BUILD_SOURCE_RATIO_THRESHOLD=0.10` 상수 신설. 동적 시뮬레이션 6/6 PASS. harness-meta 93/100 S 변동 0 (회귀 0). ROADMAP §3-B v1.18g3 evidence 해소. |
| **v1.49-scorer-html-na-ui** | 2026-05-04 | `html_renderer.py` CSS 3 클래스 (.check-na/.na-tag/.na-count) + 체크 루프 N/A 분기 + 카테고리 헤더 배지 + 레전드 어노테이션. na-tag 4건/na-count 2건/check-na 4건/레전드 2건. harness-meta 93/100 S 변동 0 (회귀 0). ROADMAP §3-E v1.18e evidence 해소. |
| **v1.48-scorer-linter-na** | 2026-05-03 | `score_automation()` 상단 `na_repo` 추출 + 린터 설정 3 분기 N/A 신설 (Python/TS Helper 2 + else Helper 1). `rubric.md` §N/A 적용 체크 22→25건. 5 case 동적 시뮬레이션 PASS (Md/Python<5/Python≥5+ruff/TS<5/Go). harness-meta 93/100 S 변동 0 (회귀 0). ROADMAP §3-E `v1.46c` evidence 해소. |
| **v1.47-scorer-config-na** | 2026-05-03 | `score_code_structure()` 상단 `na_repo` 추출 + "설정 분리 (config/settings)" N/A 분기 신설 + "패키지 매니페스트" 직접 호출 → `na_repo` 참조 통일. `rubric.md` §N/A 적용 체크 21→22건. 3 case 동적 시뮬레이션 PASS. harness-meta 93/100 S 변동 0 (회귀 0). ROADMAP §3-E `v1.46b` evidence 해소. |
| **v1.46-scorer-test-borderline-na** | 2026-05-01 | `score_test_quality()` 마지막 2 sub-check (테스트/소스 비율 + CI 테스트 자동화)에 `if ... and na_repo` 분기 추가. ROADMAP §3-E `v1.36c` evidence 해소 + Helper 3 불필요 결정 (Helper 1 의미 동등성). `rubric.md` §N/A 적용 체크 19→21건. 7 case 동적 시뮬레이션 PASS (borderline 0.15 자연 1pt 검증). harness-meta 93/100 S 변동 0 (Test 15/15 만점 유지). |
| **v1.45-scorer-docstring-na** | 2026-05-01 | `score_documentation()` Docstring / JSDoc 커버리지 체크 `else` 브랜치에 `elif na_repo` N/A 분기 추가. shell/markdown-only repo → N/A 자동 만점 (3/3). `rubric.md` §N/A 적용 체크 18→19건. 4 case 동적 시뮬레이션 PASS. harness-meta 92→93/100 S (문서화 12→13/15). |
| **v1.44-scorer-test-pytest-na** | 2026-05-01 | `score_test_quality()` pytest 설정 N/A 분기 신설. `is_small_typed_lang_repo` 직접 재사용. Python 소스 5개 미만 + pytest 미설치 → N/A 자동 만점 (2/2). `rubric.md` §N/A 적용 체크 17→18건. 4 case 동적 시뮬레이션 PASS. harness-meta 92/100 S 변동 0. |
| **v1.43-scorer-typesafety-na** | 2026-05-01 | `is_small_typed_lang_repo` 신규 helper (2 조건 AND, 임계 <5) + `score_type_safety()` Python 4 + TypeScript 2 = 6 sub-check N/A 분기. `rubric.md` §N/A 적용 체크 11→17건. 5 case 동적 시뮬레이션 PASS. harness-meta 93/100 S 변동 0. |
| **v1.42-content-message-enhance** | 2026-05-01 | python3 블록 `import re` + Write/Edit/MultiEdit 섹션명 추출 + SECTIONS 변수 + MSG 조건부 (sections 있을 때 섹션명 포함, 없을 때 기존 형식). smoke 12→14 PASS (Test J+K 신규). 회귀 0. bash 단일 인용부호 제약 → `chr()` 우회 필수 교훈. |
| **v1.41-multiedit-content-filter** | 2026-05-01 | MultiEdit edits[*].new_string `## ` 마커 검사. 마커 없으면 NOOP (false positive 필터). python3 4라인 출력(has_markers) + grep fallback + 콘텐츠 가드. smoke 10→12 PASS (Test H+I 신규). 회귀 0. |
| **v1.40-multiedit-trigger** | 2026-05-01 | PostToolUse hook `post-report-write.sh` case + install.ps1 matcher `Edit\|Write` → `Edit\|Write\|MultiEdit` 확장. legacy migration 3단계 (신규 탐색 → in-place 교체 → append). verify.ps1/sh Stage J 갱신. smoke 8→10 PASS (Test F+G MultiEdit 신규). 43/43 PASS + 회귀 0. |
| **v1.39-precommit-hook** | 2026-04-30 | `.pre-commit-config.yaml`에 `repo: local` 섹션 추가 — smoke-spec-verification + smoke-scope-contract 커밋 전 자동 검증. 기존 shellcheck/markdownlint framework 무영향. README.md + CLAUDE.md 설치 안내 갱신. |
| **v1.38-verify-posttooluse-stage-j** | 2026-04-30 | install.ps1 hooks pattern `'session-init.sh'` → `'*.sh'` (post-report-write.sh symlink 배포 fix). verify.ps1/sh Stage B 동일 수정 + Stage J (J1~J5) 추가 — hooks.PostToolUse[Edit|Write] matcher·command·type·shell 검증. verify.ps1 43/43 PASS · smoke 6/6 회귀 0 |
| **v1.37-install-docs-ssot** | 2026-04-30 | install.ps1 헤더 충돌 정책 3줄 → 1줄 수렴 (settings.json idempotent v1.36e + CLAUDE.md §명령어 참조). README.md:47 reinstall note "abort without -Force" → "idempotent (v1.36e)". CLAUDE.md는 단일 소스 유지. smoke 6/6 PASS 회귀 0 |
| **upbit/v1.3-roadmap-backfill** | 2026-04-30 | `projects/upbit/ROADMAP.md` 소급 작성 (v1.0~v1.2 이력 기반). pending 2건 §2 trigger 대기 이관. v1.36 Bootstrap S6 5종 파일 체계 소급 보완. `v1.36c-legacy-project-roadmap-migration` trigger A 이행 |
| **v1.36e-install-sessionstart-idempotent** | 2026-04-30 | install.ps1 SessionStart/statusLine idempotent no-op 구현. SessionStart: matcher-level lookup (PostToolUse 패턴 답습) — startup+session-init.sh 동일 시 no-op, 다를 시 -Force. statusLine: 동일 command 시 write skip. CLAUDE.md L47/L55 -Force 필수→불필요 갱신. 단위 테스트 5/5 PASS + PostToolUse smoke 8/8 회귀 0 |
| **v1.36d-skill-resync** | 2026-04-30 | install-skills.ps1 `Resolve-SkillName` 파라미터명 `$Input`→`$SkillInput` fix (PowerShell 자동변수 충돌). 5 skill symlink 2단계 카테고리 경로로 갱신. harness-roadmap-update 신규 설치 |
| **v1.36b2-install-ps1-force-docs** | 2026-04-30 | install.ps1 정기 재실행 -Force 필수 명시 (README.md Stage 1 직하 + L63 Stage 2 분리 / CLAUDE.md L38 "최초 1회" + L47-48 -Force + L55 bullet / install.ps1 헤더 충돌 정책 1줄). v1.36b L3 trigger 이행. 5 관점 검토 PASS (architecture 결함 2 + scope contract drift=N/A 카테고리 권고 → 모두 적용). 회귀 0 (docs only) |
| **v1.36b-postoolse-roadmap-hook** | 2026-04-30 | PostToolUse hook `post-report-write.sh` 신설 — sessions/**/REPORT.md Write/Edit 감지 → additionalContext로 /harness-roadmap-update invoke 안내. install.ps1 matcher-level merge 등록. smoke 8/8 PASS (정적 3 + dynamic 5). 회귀 0. settings.json hooks.PostToolUse[Edit|Write] 추가 확인 |
| **v1.36-roadmap-unification-and-flow** | 2026-04-30 | EVIDENCE_DRIVEN_ROADMAP.md 폐기 + sessions/meta/ROADMAP.md 신설 + projects/<name>/ROADMAP.md 템플릿 + skills 2단계 카테고리 (audit/dev-tools, 5 skill) + 8단계 흐름 형식화 + AskUserQuestion 자동 invoke 정책 + harness-roadmap-update SKILL 신설 + harness-plan-verify 프로젝트 확장. 4 commit 분할. smoke 21+ 회귀 0 + verify.ps1 38/38 PASS |
| v1.31c-archive-sync-automation | 2026-04-30 | drift 자동 감지 워크플로우. `tests/smoke-archive-sync.sh` Stage 1~4 + Stage 1 `--fix` mode. (v1.36에서 `smoke-roadmap-sync.sh`로 rename) |
| v1.31b-roadmap-archive-arrears | 2026-04-30 | EVIDENCE_DRIVEN_ROADMAP §2/§8/§9 archive arrears 정정 (v1.35 + v1.18g2 누락 보충). routine bookkeeping |
| v1.18d-scorer-stdout-encoding | 2026-04-30 | Windows cp949 default stdout encoding emoji UnicodeEncodeError 차단. `score_codebase.py main()` 진입 직후 `sys.stdout/stderr.reconfigure(UTF-8, errors='replace')` |
| v1.18g2-helper-threshold-revisit | 2026-04-30 | helper `build_sources < 5` → `< 10` 임계 상향 (v1.18g 분할 부수 효과 보정). harness-meta 점수 90→93 (Docker+Lock N/A 복원). 회귀 0 |
| v1.35-scorer-other-na-categories | 2026-04-30 | 8 sub-checks N/A 확장 (Documentation 2 + Context layer 2 + Test 4 — sub-3.3 dead code 제거). harness-meta 변동 0 (helper=False), 8 case dynamic 시뮬레이션 통과 |
| v1.34-legacy-plan-migration | 2026-04-30 | smoke-scope-contract.sh `--include-legacy` opt-in flag + `is_anchor_missing()` G1 SKIP. 도구 인프라만 — 실 legacy § 삽입 0 (사용자 자율 영역). default smoke PASS=68 + 회귀 0 |
| v1.33-fix-scope-contract | 2026-04-29 | smoke-scope-contract.sh `--fix` mode + enumerate 자동 흡수 glob 5건 (v1.10h~v1.99 + v2+) |
| v1.32-report-cross-file-consistency | 2026-04-29 | smoke Stage 7 매트릭스 9 case (5 OK + 2 FAIL + 2 WARN). `SPEC_VERIFICATION.md §11` 단일 소스. Self-test 6/6 OK |
| v1.31-evidence-driven-roadmap | 2026-04-29 | EVIDENCE_DRIVEN_ROADMAP.md docs 신설. 23건 분류 (진행 가능 5 + 진행 불가 18 + schedule 후보 3). v1.36에서 본 docs로 이관·폐기 |
| v1.30b-smoke-backup-cleanup-pipefail-fix | 2026-04-29 | smoke-backup-cleanup pipefail 회귀 fix |
| v1.30-backup-cleanup | 2026-04-29 | install-skills `--cleanup` opt-in CLI flag + count + grace-days 정책 |
| v1.29-verify-fix-mode | 2026-04-29 | smoke-spec-verification.sh `--fix` mode (§ skeleton 자동 삽입) |
| v1.28-source-matrix-expand | 2026-04-29 | SPEC_VERIFICATION.md §4 source matrix 4 row (PowerShell + Bash 추가) |
| v1.27-report-spec-verification | 2026-04-29 | REPORT.md `Spec verification (context7)` § 의무화 (v1.27+) |
| v1.26-project-plan-verify | 2026-04-29 | 프로젝트 PLAN § 의무 확장 (v1.24b 후속) |
| v1.24-plan-spec-verification | 2026-04-29 | PLAN.md `Spec verification (context7)` § 의무화 + `harness-plan-verify` SKILL 신설 |
| (이하 v1.0 ~ v1.23 — git log 참조) | — | — |

## 9. 확정 세션 (이력 stamp)

- **v1.64** (2026-05-04) — pre-commit 실패 시 `--fix` 자동 시도 wrapper 신설 (`tests/precommit-autofix-or-fail.sh` + `.pre-commit-config.yaml` 2 hook entry 경유 + README 안내). safe abort 패턴 — exit 1 + 사용자 git diff 검토. E2E 시나리오 검증 통과. v1.39c-fix-autofix trigger 이행.
- **v1.63** (2026-05-04) — `smoke-broad-bash-fine-grain.sh` `--fix` Stage 6 field name bidirectional rename 추가 (3 SKILL ↔ 4 agent + 양쪽 동시 skip). default 6/6 PASS 회귀 0. E2E 3 시나리오 검증 (SKILL rename + agent rename + both skip). `grep -c || echo 0` 이중 출력 함정 해결. v1.62b-fix-field-name-rename trigger 이행.
- **v1.62** (2026-05-04) — `smoke-broad-bash-fine-grain.sh` `--fix` mode 도입 (argv 파싱 + V5 auto-allow + R2/R6 Bash declare 삭제 + dry-run + .bak 백업). default 6/6 PASS 회귀 0. E2E 시나리오 검증 통과 (V5 + R6 두 종류 violation). v1.60/v1.61 패턴 답습. v1.60c-fix-broad-bash-fine-grain trigger 이행.
- **v1.61** (2026-05-04) — `smoke-thinking-effort.sh` `--fix` mode 도입 (argv 파싱 + V10 `^thinking:` auto-remove + dry-run + .bak 백업). default 5/5 PASS 회귀 0. E2E 시나리오 검증 통과. v1.60 패턴 답습. v1.60b-fix-thinking-effort trigger 이행.
- **v1.60** (2026-05-04) — `smoke-bash-permission-pattern.sh` `--fix` mode 도입 (argv 파싱 + V1/V5/V7 자동 정정 + dry-run + .bak 백업). default 6/6 PASS 회귀 0. E2E 시나리오 검증 통과. v1.33 패턴 답습. v1.29b-fix-other-smokes trigger 부분 이행 (smoke-bash-permission-pattern 대상).
- **v1.59** (2026-05-04) — `post-report-write.sh` PLAN.md 감지 추가. `FILE_TYPE` 분기(REPORT|PLAN) + MSG 라우팅(PLAN → `/harness-plan-verify`, REPORT → `/harness-roadmap-update`). `REPORT_BASENAME` → `FILE_BASENAME`. smoke 20/20 PASS (Test P+Q 신규). 회귀 0. §3-B `v1.40d-hook-pattern-expand` 이행.
- **v1.58** (2026-05-04) — `post-report-write.sh` MSG 동적 파일명. `REPORT_BASENAME=$(basename "$NORM_PATH")` 추출 + MSG 2개소 치환. smoke-posttooluse-hook.sh Test O 신규. 18/18 PASS. 회귀 0. ROADMAP §3-E `v1.57d` 이행.
- **v1.57** (2026-05-04) — PostToolUse hook NotebookEdit 지원. `post-report-write.sh` case `Write|Edit|MultiEdit|NotebookEdit` + Python/grep `notebook_path` 분기 + 패턴 `REPORT.(md|ipynb)$`. install.ps1 matcher migration + 메시지 4개소 + verify.ps1/sh Stage J 4개소. smoke 17/17 (Test M+N 신규) + verify.ps1 43/43. context7 `NotebookEditInput.notebook_path` 공식 확인 drift=no. ROADMAP §3-B `v1.40c-hook-more-tools` 이행. 회귀 0.
- **v1.56** (2026-05-04) — `categories_quality.py` 545줄 → 4 파일 분할 (documentation/code_structure/type_safety/test_quality). `score_codebase.py` import 갱신. 파일 크기 체크 2/3→3/3. harness-meta 93→94/100 S. smoke 3종 PASS. 회귀 0.
- **v1.55** (2026-05-04) — `score_agentic_safety()` Helper 1 N/A 3 sub-check (`.env.example` / `Claude Code 권한 설정` / `가드레일 파일`). `categories_ops.py` `na_repo` 추출 + 3 분기. `rubric.md` §"적용 체크" 28건. `smoke-agentic-safety-na.sh` 신설 5/5 PASS (정적 2 + 동적 3). harness-meta 93/100 변동 0. 회귀 0 (4 smoke 통과). 에이전틱 안전 카테고리 N/A 적용 첫 시리즈 (v1.43~v1.48 패턴 답습).
- **v1.54** (2026-05-04) — `claude/hooks/post-report-write.sh` R1(python3 미설치 WARN) + R2(양쪽 파서 실패 시 TOOL_NAME='' WARN + 조기 종료). `smoke-posttooluse-hook.sh` Test L 신규 (mktemp stderr 분리). smoke 15/15 PASS + 전체 회귀 0. §3-B `v1.36b4-hook-debug-log` 이행.
- **v1.53** (2026-05-04) — `detect_language()` `_LANG_PRIORITY` priority tie-breaking + Shell lang_map 등재. `is_shell_markdown_only_repo()` 조건 #1 재구조화 (tiny Python N/A 보호 유지). `smoke-detect-language.sh` 신설 6/6 PASS. harness-meta 93/100 S 변동 0. §3-D `v1.36d` 이행. 신규 §3-D `vX-type-safety-paradox-resolve` 등록.
- **v1.52** (2026-05-04) — `tests/smoke-roi-regression.sh` 신설. 정적 4(조건식 grep) + 동적 2(mock eligible/na/perfect) = 6/6 PASS. §3-B `v1.51b-roi-smoke` 해소.
- **v1.51** (2026-05-04) — `compute_roi_actions` / `top_actions` / `html_renderer` 3개소 `not passed` → `score < max_score and not na` 수정. ROI 액션 영구 0건 버그 해소. ⚠️ 아이콘 도입. 93/100 S 변동 0.
- **v1.50** (2026-05-04) — `is_shell_markdown_only_repo` 조건 #4 count→OR(count<10|ratio<10%) 재설계. `_BUILD_SOURCE_RATIO_THRESHOLD=0.10` 상수. 동적 시뮬레이션 6/6 PASS. harness-meta 93/100 S 변동 0. §3-B v1.18g3 해소.
- **v1.49** (2026-05-04) — HTML 대시보드 N/A 카드 정밀 시각화. html_renderer.py CSS 3 클래스 + 체크 루프/헤더/레전드 3개소 변경. na-tag 4건/na-count 2건/레전드 어노테이션 2건. 93/100 S 변동 0. §3-E v1.18e 해소.
- **v1.48** (2026-05-03) — Automation 린터 설정 N/A 분기 신설 (Helper 1+2). `score_automation()` `na_repo` 상단 이동 + Python/TS Helper 2 + else Helper 1. rubric.md §N/A 적용 체크 25건. 5 case 시뮬레이션 PASS. harness-meta 93/100 S 변동 0 (회귀 0). ROADMAP §3-E v1.46c 해소.
- **v1.47** (2026-05-03) — Code Structure "설정 분리 (config/settings)" N/A 분기 신설 (Helper 1). `na_repo` 상단 추출 + "패키지 매니페스트" 직접 호출 통일. rubric.md §N/A 적용 체크 22건. 3 case 시뮬레이션 PASS. harness-meta 93/100 S 변동 0 (회귀 0). ROADMAP §3-E v1.46b 해소.
- **v1.46** (2026-05-01) — Test borderline 2 sub-check (테스트/소스 비율 + CI 테스트 자동화) N/A 분기 신설 (Helper 1). ROADMAP §3-E `v1.36c` evidence 해소 + Helper 3 불필요 결정. rubric.md §N/A 적용 체크 21건. 7 case 시뮬레이션 PASS. harness-meta 93/100 S 변동 0 (회귀 0).
- **v1.45** (2026-05-01) — Docstring / JSDoc 커버리지 N/A 분기 신설 (Helper 1). shell/markdown-only repo → N/A 자동 만점 (3/3). rubric.md §N/A 19건. harness-meta 92→93/100 S (문서화 12→13/15).
- **v1.44** (2026-05-01) — pytest 설정 N/A 분기 신설. `is_small_typed_lang_repo` 직접 재사용. Python 소스 <5 + pytest 미설치 → N/A 자동 만점. rubric.md §N/A 18건. harness-meta 92/100 S 변동 0.
- **v1.43** (2026-05-01) — Type Safety N/A 분기 신설. `is_small_typed_lang_repo` helper (Python/TS/JS, 소스 <5 임계). Python 4 + TypeScript 2 = 6 sub-check N/A 경로. rubric.md §N/A 17건. harness-meta 93/100 S 변동 0.
- **v1.42** (2026-05-01) — section name extraction. Write/Edit/MultiEdit 섹션명 추출 → additionalContext 메시지 포함. smoke 14/14 PASS (Test J+K 신규). bash 단일 인용부호 제약 → `chr()` 우회.
- **v1.41** (2026-05-01) — MultiEdit edits 콘텐츠 가드. `## ` 마커 없으면 NOOP (false positive 필터). smoke 12/12 PASS (Test H+I 신규).
- **v1.40** (2026-05-01) — PostToolUse hook MultiEdit 매처 확장. `Edit|Write` → `Edit|Write|MultiEdit`. legacy in-place migration. smoke 10/10 + verify.ps1 43/43 PASS.
- **v1.36e** (2026-04-30) — install.ps1 SessionStart/statusLine idempotent no-op. PostToolUse matcher-level 패턴 SessionStart에 이식. CLAUDE.md -Force 필수→불필요 갱신. 5/5 단위 PASS + smoke 8/8 회귀 0.
- **v1.36d** (2026-04-30) — install-skills.ps1 `$Input`→`$SkillInput` PS 자동변수 충돌 픽스. 5 skill symlink 2단계 경로 정상화.
- **v1.36b2** (2026-04-30) — install.ps1 정기 재실행 `-Force` 필수 명시 (README/CLAUDE.md/install.ps1 헤더 3 파일). v1.36b L3 trigger 이행. 5 관점 검토 PASS + 회귀 0.
- **v1.36** (2026-04-30) — `EVIDENCE_DRIVEN_ROADMAP.md` 폐기 + `sessions/meta/ROADMAP.md` (본 파일) 신설 + `projects/<name>/ROADMAP.md` 템플릿 + 8단계 흐름 형식화 + skills 2단계 카테고리 + AskUserQuestion 자동 invoke 정책 + `harness-roadmap-update` SKILL 신설 + `harness-plan-verify` 프로젝트 확장.
- **v1.31c** (2026-04-30) — `tests/smoke-archive-sync.sh` 신설 (Stage 1~4 + Stage 1 `--fix`). v1.36에서 `smoke-roadmap-sync.sh`로 rename.
- **v1.31** (2026-04-29) — EVIDENCE_DRIVEN_ROADMAP.md 신설. v1.36에서 본 docs로 이관·폐기.
