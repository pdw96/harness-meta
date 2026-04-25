# meta v1.10-bootstrap-interview — PLAN

세션 시작: 2026-04-25 (PLAN 검토·정정 2026-04-26)
직접 선행 세션: [`sessions/meta/v1.9-project-auto-detect/`](../v1.9-project-auto-detect/REPORT.md) — `detect-project.sh` 신설 (본 흐름의 Stage S1)
보조 동시기: [`sessions/meta/v1.9b-install-legacy-cleanup/`](../v1.9b-install-legacy-cleanup/REPORT.md), [`sessions/meta/v1.9c-docs-ps-home-path-fix/`](../v1.9c-docs-ps-home-path-fix/REPORT.md)

목적: `/harness-meta <new-name>` Bootstrap 모드의 **end-to-end 흐름**을 설계·고정한다.
v1.9의 `detect-project.sh` 결과를 **기본값 추천**으로 사용해 사용자 대화(인터뷰)로 확정한 뒤,
`.harness.toml` · 프로젝트 `CLAUDE.md` baseline · `GUARDRAILS.md` placeholder · `phases/` 디렉토리 · 프로젝트 `.claude/` 배포 · `projects/<name>/` 4종 · 세션 기록 · README.md 등록을 **한 사이클로 완결**한다.

본 세션은 **흐름 설계 + 인터뷰 템플릿 신설** 중심. 실제 신규 프로젝트 부트스트랩 적용은 차기 세션(`sessions/<new-name>/v0.1-bootstrap/`)에서 본 인터뷰를 호출하며 수행.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: `bootstrap/interview.md` + `bootstrap/docs/INTERVIEW_FLOW.md` + `bootstrap/render-manifest.sh` + `bootstrap/skeletons/projects/{4종}.md` + `bootstrap/skeletons/sessions/v0.1-bootstrap/{2종}.md` + `bootstrap/skeletons/CLAUDE.md.tmpl` + `bootstrap/skeletons/GUARDRAILS.md.tmpl` (전부 신규) + `claude/commands/harness-meta.md` + `bootstrap/manifest-schema.md` + `CLAUDE.md` + `README.md` (수정) → **S2(11) + S1a(1) + S3(2) = 14/14 meta**.
- **T1 경로 다수결** — meta scope 14/14 → meta 확정.
- **T2 스펙 vs 값** — 본 세션은 "Bootstrap 흐름 스펙" 정의. 각 신규 프로젝트 적용은 별도 `sessions/<name>/v0.1-bootstrap/` (값 단위) — T4 크로스 커팅 분할 원칙 준수.

## 배경

### 현재 격차

`/harness-meta <new-name>` 슬래시 명령은 Bootstrap 모드를 선언만 하고 **실제 인터뷰 흐름 자산이 없다**:

```
~/harness-meta/bootstrap/
├── detect-project.sh           ✅ v1.9
├── docs/
│   ├── DETECTION.md            ✅ v1.9
│   ├── OWNERSHIP.md            ✅ v1.2~
│   └── AGENTS_MD_STRATEGY.md   ✅ v1.5
├── manifest-schema.md          ✅ v1.7 (.harness.toml v1.1 spec)
├── install-project-claude.ps1  ✅ v1.8 + v1.9b cleanup
├── install-project-claude.sh   ✅ v1.8 + v1.9b cleanup
└── templates/_base/.claude/    ✅ v1.8b (14 파일)

❌ interview.md                       — 슬래시 명령에서 referenced되지만 부재
❌ docs/INTERVIEW_FLOW.md             — Bootstrap 7-stage 책임 분리 문서 부재
❌ render-manifest.sh                 — 답변→TOML 직렬화 helper 부재
❌ skeletons/projects/                — projects/<name>/ 4종 placeholder 부재
❌ skeletons/sessions/v0.1-bootstrap/ — v0.1 PLAN/REPORT placeholder 부재
❌ skeletons/CLAUDE.md.tmpl           — 신규 프로젝트 CLAUDE.md baseline 부재
❌ skeletons/GUARDRAILS.md.tmpl       — GUARDRAILS placeholder 부재
```

`claude/commands/harness-meta.md`(슬래시 명령)는 Bootstrap 절차 §에서 7개 산출물(매니페스트·CLAUDE.md·GUARDRAILS·`scripts/harness/`·`phases/`·`projects/<name>/`·README 등록)을 약속하지만 **대응 자산이 부재** → Claude가 즉흥 대화에 의존 → **재현성·일관성 결손**.

### 기대 흐름 (요약)

```
사용자: /harness-meta my-new-project   (해당 프로젝트 루트에서 실행)
   ↓
Claude:
  S0 .harness.toml 부재 + projects/my-new-project/ 부재 확인 → Bootstrap 진입 의사 확인
  S1 detect-project.sh 실행 → TOML snippet 캡처 (언어/PM/test_cmd 힌트)
  S2 interview.md 따라 사용자에게 코어 7 + 옵션 5 = 12 질문 (감지값을 default로 제시)
  S3 답변 → render-manifest.sh로 .harness.toml 미리보기 → 사용자 확정
  S4 manifest 작성 + 파싱 검증 (grep+sed 핵심 필드 round-trip)
  S5 프로젝트 부수 자산 생성:
       a) <proj>/CLAUDE.md baseline (skeletons/CLAUDE.md.tmpl 기반, ARCHITECTURE include)
          분기: (i) 부재→신규, (ii) 존재+import 라인 부재→append 사용자 확인, (iii) 존재+import 있음→no-op
       b) <proj>/{HM_GUARDRAILS}/GUARDRAILS.md placeholder (default `docs/GUARDRAILS.md`, skeletons/GUARDRAILS.md.tmpl 기반)
       c) <proj>/{HM_PHASES_DIR}/.gitkeep (빈 디렉토리. default = `phases/`. 첫 phase 추가 시 사용자가 .gitkeep 삭제 권장 — S10 후속 안내)
       d) <proj>/{HM_CODE_DIR}/ — **본 세션 범위 외**. v1.11+ language overlay에서 처리 (사용자 안내)
  S6 install-project-claude.{ps1|sh} 실행 (.claude/ 14 파일 배포)
  S7 ~/harness-meta/projects/my-new-project/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK}.md 작성
       (skeletons/projects/ 기반, INTERVIEW.md는 답변 그대로 + 자유 응답 Q11~Q12 포함)
  S8 ~/harness-meta/sessions/my-new-project/v0.1-bootstrap/{PLAN,REPORT}.md 작성
       (skeletons/sessions/v0.1-bootstrap/ 기반)
  S9 ~/harness-meta/README.md 프로젝트 섹션에 my-new-project 링크 추가
  S10 사용자 후속 안내 (`/config` Output style / GUARDRAILS 작성 / scripts/harness 도입)
```

10-stage. 각 stage는 단일 책임. 실패 단위 격리 + 재실행 단위 명확.

### 책임 분리

| Stage | 주체 | 산출 |
|------|------|------|
| **S0 모드 진입** | 슬래시 명령 (`harness-meta.md`) | Bootstrap 의사 확인 |
| **S1 감지** | `detect-project.sh` (v1.9) | TOML snippet (lang/pm/test_cmd) |
| **S2 인터뷰** | `interview.md` (**본 세션 신규**) | 사용자 답변 (key=value 매핑) |
| **S3 렌더링** | `render-manifest.sh` (**본 세션 신규**) | `.harness.toml` 텍스트 |
| **S4 매니페스트 작성+검증** | Claude (Write + Bash grep) | `<proj>/.harness.toml` + round-trip 통과 (3 필드: `name`, `code_dir`, `phases_dir` — session-init.sh / statusline.sh 사용 필드 모두) |
| **S5 프로젝트 부수 자산** | Claude (skeletons/ 기반 Write) | CLAUDE.md / GUARDRAILS.md / phases/ |
| **S6 .claude/ 배포** | `install-project-claude.{ps1,sh}` (v1.8+v1.9b) | `<proj>/.claude/` 14 파일 |
| **S7 아키텍처 기록** | `skeletons/projects/` (**본 세션 신규**) | `projects/<name>/` 4종 |
| **S8 세션 기록** | `skeletons/sessions/v0.1-bootstrap/` (**본 세션 신규**) | `sessions/<name>/v0.1-bootstrap/{PLAN,REPORT}` |
| **S9 README 등록** | Claude (Edit) | `~/harness-meta/README.md` 프로젝트 섹션 |
| **S10 후속 안내** | Claude (텍스트 출력) | 사용자 행동 항목 (output style / GUARDRAILS 작성 등) |

## 목표

- [ ] **`bootstrap/interview.md`** — 코어 7 + 옵션 manifest 3 + 자유 2 = 12 질문 + 자동 적용 4건 명시
- [ ] **`bootstrap/docs/INTERVIEW_FLOW.md`** — 10-stage 책임 분리 + abort 정책 + idempotency + cross-platform OS 분기 코드
- [ ] **`bootstrap/render-manifest.sh`** — key=value → `.harness.toml` v1.1 직렬화. **bash 4+ gate** (exit 3) + **TOML escaping 검증 5종** (`"`, `'`, `\n`, `$`, `\` 거부, exit 2). schema §10 예시 순서 일치. exit code 분류 명시 (0/1/2/3)
- [ ] **`bootstrap/skeletons/projects/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK}.md`** — 4종 placeholder
- [ ] **`bootstrap/skeletons/sessions/v0.1-bootstrap/{PLAN,REPORT}.md`** — 2종 placeholder
- [ ] **`bootstrap/skeletons/CLAUDE.md.tmpl`** — 신규 프로젝트 CLAUDE.md baseline (`@~/harness-meta/projects/{{name}}/ARCHITECTURE.md` import)
- [ ] **`bootstrap/skeletons/GUARDRAILS.md.tmpl`** — 5120 byte 상한 안내 + 빈 § 헤더 4개 (사용자 작성용)
- [ ] **smoke (기존 fixture 재사용)** — `tests/smoke-bootstrap-render.sh` (단일 파일, `tests/smoke/` 디렉토리 신설 안 함). 입력은 기존 `tests/fixtures/detect-python-uv/`. detect→render→reparse 사이클 검증
- [ ] **`claude/commands/harness-meta.md` 갱신** — Bootstrap §를 10-stage로 갱신 + interview.md 정확 링크 + tools에 `Bash(bash*)`, `Bash(pwsh*)` 추가 (확정)
- [ ] **`bootstrap/manifest-schema.md` §12 갱신** — Bootstrap 신규 작성 cross-link 짧은 절
- [ ] **`CLAUDE.md` / `README.md` 갱신** — INTERVIEW_FLOW 링크 + Bootstrap 1줄 요약
- [ ] **Grey Area 결정** (16 + R 반영 4 + M/W 반영 4 = 24건)
- [ ] 본 세션 REPORT — 결정사항 + 차기 세션 연결 + smoke 결과
- [ ] 커밋 (1건) + 사용자 확인 후 push

## 범위

**포함**:
- 10-stage 흐름 설계 + 인터뷰 질문 템플릿 (코어 7 + 옵션 manifest 3 + 자유 2 = 12 + 자동 4)
- TOML 렌더링 helper (bash-only, schema v1.1 일치, escaping 검증)
- skeletons/ 7종 placeholder (projects 4 + sessions 2 + CLAUDE.md.tmpl + GUARDRAILS.md.tmpl)
- 기존 fixture 재사용으로 detect→render→reparse smoke
- abort/재실행/idempotency/cross-platform 정책

**제외 (T4 분할 / 후속 세션)**:
- 신규 프로젝트 **실제 부트스트랩 실행** — 첫 적용은 사용자가 신규 프로젝트 만들 때 별도 `sessions/<new-name>/v0.1-bootstrap/`
- **`scripts/harness/` 언어별 실행기 골격 생성** — v1.11~v1.13 language overlay (Python/TS/Go/Rust). 본 세션은 사용자 안내만 (S10)
- **`bootstrap/templates/<language>/` overlay 신설** — v1.11~v1.13
- **`AGENTS.md` baseline 자동 생성** — v1.5 규약 적용 세션 별도 (`v1.10b-bootstrap-agents-md`). 본 세션은 CLAUDE.md only (Claude Code 단일 adapter)
- **비대화형 mode** (JSON config 받아 자동) — v1.22+
- **TOML 스키마 정식 validator** (CLI linter) — v2.0 tomllib parser 도입과 함께
- **upbit retroactive 적용** — upbit는 이미 부트스트랩 완료 (Idempotency §)

## 변경 대상

### 신규 (11 파일 + smoke + 세션)

| 경로 | scope | 역할 |
|------|------|------|
| `bootstrap/interview.md` | S2 | Claude가 따르는 인터뷰 질문지 |
| `bootstrap/docs/INTERVIEW_FLOW.md` | S2 | 10-stage 흐름 + abort + idempotency + OS 분기 |
| `bootstrap/render-manifest.sh` | S2 | key=value → `.harness.toml` 직렬화 (escaping 검증) |
| `bootstrap/skeletons/projects/ARCHITECTURE.md` | S2 | placeholder (디렉토리 구조 + 통합 지점) |
| `bootstrap/skeletons/projects/DECISIONS.md` | S2 | placeholder (H-ADR-001 1건 자리) |
| `bootstrap/skeletons/projects/INTERVIEW.md` | S2 | 답변 기록용 (Q1~Q12 마커) |
| `bootstrap/skeletons/projects/STACK.md` | S2 | placeholder (의존성·툴 표) |
| `bootstrap/skeletons/sessions/v0.1-bootstrap/PLAN.md` | S2 | v0.1 PLAN placeholder |
| `bootstrap/skeletons/sessions/v0.1-bootstrap/REPORT.md` | S2 | v0.1 REPORT placeholder |
| `bootstrap/skeletons/CLAUDE.md.tmpl` | S2 | 프로젝트 루트 CLAUDE.md baseline |
| `bootstrap/skeletons/GUARDRAILS.md.tmpl` | S2 | docs/GUARDRAILS.md placeholder (5120 byte 안내) |
| `tests/smoke-bootstrap-render.sh` | S2 | detect→render→reparse 사이클 검증 (기존 fixture 재사용) |
| `sessions/meta/v1.10-bootstrap-interview/{PLAN,REPORT,evidence/smoke-bootstrap-render.txt}` | meta | 본 세션 기록 |

### 수정 (4)

| 경로 | scope | 변경 |
|------|------|------|
| `claude/commands/harness-meta.md` | S1a | (a) Bootstrap 절차를 10-stage로 갱신 (b) `interview.md` 정확 링크 (c) **tools frontmatter 확정 추가**: `Bash(bash*)`, `Bash(pwsh*)`, `Bash(grep*)`, `Bash(sed*)`, `Bash(uname*)`, `Bash(mv*)`, `Bash(cp*)`, `Bash(test*)` — 흐름 7-stage 운영에 필요한 최소 권한. 매 호출마다 사용자 prompt 폭주 방지 |
| `bootstrap/manifest-schema.md` | S2 | §12 "마이그레이션 가이드"에 §12.3 "Bootstrap 신규 작성 경로" 짧은 cross-link 추가 |
| `CLAUDE.md` | S3 | "관련 문서" 섹션에 INTERVIEW_FLOW.md 링크 |
| `README.md` | S3 | Bootstrap 모드 1줄 설명 + INTERVIEW_FLOW.md 링크 |

## interview.md — 질문 설계 (코어 7 + 옵션 manifest 3 + 자유 2 = 12 + 자동 4)

`detect-project.sh` 결과를 default로 제시. **{D}**는 감지값, **{U}**는 사용자 입력, **{R}**는 합리적 추천 default.

### 코어 질문 (7) — 모두 필수, manifest 핵심 필드

| # | 키 | 질문 | Default |
|---|----|----|---------|
| Q1 | `[project].name` | 프로젝트 이름? (식별자, 디렉토리명 권장) | CWD basename {R} |
| Q2 | `[project].language` | 주 언어? | {D} 또는 unknown→manual |
| Q3 | `[project].package_manager` | 패키지매니저? | {D} 또는 manual |
| Q4 | `[project].runtime_version` | 런타임 버전? (예: Python "3.12", Node "20.x", Go "1.22") | (감지 안 함, {U}) |
| Q5 | `[harness].code_dir` | 하네스 코드 디렉토리? | `scripts/harness` {R} |
| Q6 | `[harness].phases_dir` | phases 디렉토리? | `phases` {R} |
| Q7 | `[architecture].meta_ref` | harness-meta 내부 경로? | `projects/{Q1}/ARCHITECTURE.md` {R} |

### 옵션 manifest-매핑 질문 (3) — skip 시 default 적용 또는 omit

| # | 키 | 질문 | Default | Skip 시 |
|---|----|----|---------|--------|
| Q8 | `[harness].guardrails` | GUARDRAILS.md 경로? | `docs/GUARDRAILS.md` {R} (placeholder 자동 생성됨) | omit |
| Q9 | `[project].locale` | 작업 언어? (en/ko/ja/zh/...) | `en` {R} (schema §6.2 default) — 한국어 사용자는 명시 입력 | "en" 채택 |
| Q10 | `[testing]` 4건 | 테스트 명령? (test/lint/format은 detect default 채택. type_check_cmd는 사용자 입력) | test/lint/format = {D}. type_check_cmd = {U} (예: `uv run mypy src`, `pnpm tsc --noEmit`) | type_check_cmd 빈 응답 시 omit. 그 외 default 채택 |

### 자유 응답 질문 (2) — manifest 매핑 없음, INTERVIEW.md 영구 기록

| # | 매핑 | 질문 |
|---|----|----|
| Q11 | INTERVIEW.md + STACK.md 관측 표 | 관측·트레이싱 스택? (메트릭/로그/트레이스 도구) |
| Q12 | INTERVIEW.md + ARCHITECTURE.md CI 절 | CI/CD 인프라? (GitHub Actions/GitLab/Jenkins/없음) |

**총 12 질문 = 코어 7 (manifest 필수) + 옵션 manifest 3 (Q8/9/10) + 자유 응답 2 (Q11/Q12)**.

### Q&A UX 시퀀스

- **Claude는 한 번에 12 질문을 표시** (각 질문 옆에 default 명시) — 12 turn 회피로 사용자 피로 최소화
- 사용자는 한 번에 답변 (빈 항목 = default 채택). 부분 수정 원하면 follow-up
- 답변 수신 후 Claude가 미리보기 manifest를 사용자에게 표시 → 최종 확정

### 자동 적용 (질문 없음, 4건)

- `schema_version = "1.1"`
- `[harness].mcp_server = "harness"` (단일 default)
- `[agents].primary = "claude-code"` (현재 단일 adapter — v1.5 규약 §6 시나리오 A)
- 컴파일 언어(rust/go/java/csharp)면 `[build]` 섹션 자동 포함 (`tool` + `build_cmd` + `artifact_dir`) — detect 결과 기반

### 명시적 omit (생성 안 함, 7건)

- `[harness].executor` — v1.11+ language overlay 책임 (사용자 후속 추가)
- `[harness].statusline_cmd` + `statusline_timeout_ms` + `state_file` — 풍부한 statusline은 `code_dir/` 코드 작성 후 사용자 추가 (v1.11+ overlay에서 template 제공). statusline_cmd가 omit이면 timeout/state도 단독 의미 없음 → 함께 omit
- `[testing].harness_test_cmd` — `code_dir/` 코드 작성 후 사용자 추가
- `[notifications]` 섹션 전체 — 프로젝트별 webhook URL 운영 정책. 사용자 후속 추가
- `[agents].secondary` — 단일 adapter 가정. multi-adapter 도입 시(v1.14+) 추가
- `[project].python_version` (deprecated v1.0) — v1.1 신규 프로젝트는 사용 안 함

### Q→A 처리 규칙

- **빈 응답(엔터) → default 채택**. detect 결과 또는 {R} 추천값 사용
- **"-" 또는 "skip" → 옵션 필드 omit**. 코어 필드는 재질의 (코어는 빈 응답/skip 3회 시 abort)
- **detect unknown 코어 필드(Q2/Q3)** → **첫 시도부터 사용자 직접 입력** (재시도 3회 카운트 시작). detect unknown 자체는 fail 아님
- **다중 값** → array 필드면 그대로, scalar면 첫 값 + WARN
- **TOML 안전성**: 응답에 `"`, `'`, `\n`, `$`, `\` 포함 시 **재입력 요구** (render-manifest.sh가 5종 거부 — `'` 포함 = bash `-c` 명령 주입 차단)

## render-manifest.sh — 직렬화 helper (escaping 검증 포함)

```bash
#!/usr/bin/env bash
# Render .harness.toml v1.1 from environment variables.
# Stdout: TOML text. Caller redirects to <project>/.harness.toml.
#
# Exit codes:
#   0 — success
#   1 — missing required env (bash :? failure)
#   2 — unsafe TOML char in input
#   3 — bash version < 4 (indirect expansion 미지원, macOS 시스템 bash 3.2)
#
# Required env: HM_NAME, HM_LANGUAGE, HM_PACKAGE_MANAGER, HM_RUNTIME_VERSION,
#               HM_CODE_DIR, HM_PHASES_DIR, HM_META_REF
# Optional env: HM_GUARDRAILS, HM_LOCALE (default "en"),
#               HM_TEST_CMD, HM_LINT_CMD, HM_FORMAT_CMD, HM_TYPE_CHECK_CMD,
#               HM_BUILD_TOOL, HM_BUILD_CMD, HM_ARTIFACT_DIR
#
# Note (v1.10): executor / statusline_cmd / statusline_timeout_ms / state_file /
#               harness_test_cmd / notifications / agents.secondary 는 본 helper에서 emit 안 함.
#               해당 필드는 v1.11+ language overlay 또는 사용자 후속 편집.

set -euo pipefail

# 0. Bash 4+ required (indirect expansion ${!v} 사용)
[ "${BASH_VERSINFO[0]:-0}" -ge 4 ] || {
    echo "ERR: bash 4+ required. macOS 사용자: brew install bash 후 /opt/homebrew/bin/bash 명시 호출" >&2
    exit 3
}

# 1. Required validation
: "${HM_NAME:?required}" "${HM_LANGUAGE:?required}" "${HM_PACKAGE_MANAGER:?required}"
: "${HM_RUNTIME_VERSION:?required}" "${HM_CODE_DIR:?required}" "${HM_PHASES_DIR:?required}"
: "${HM_META_REF:?required}"

# 2. TOML escaping validation — refuse unsafe chars (5종)
check_safe() {
    local var_name="$1" val="$2"
    case "$val" in
        *\"*|*\'*|*$'\n'*|*\$*|*\\*)
            echo "ERR: $var_name contains unsafe chars (\", ', newline, \$, backslash): $val" >&2
            exit 2
            ;;
    esac
}
for v in HM_NAME HM_LANGUAGE HM_PACKAGE_MANAGER HM_RUNTIME_VERSION HM_CODE_DIR \
         HM_PHASES_DIR HM_META_REF HM_GUARDRAILS HM_LOCALE \
         HM_TEST_CMD HM_LINT_CMD HM_FORMAT_CMD HM_TYPE_CHECK_CMD \
         HM_BUILD_TOOL HM_BUILD_CMD HM_ARTIFACT_DIR; do
    check_safe "$v" "${!v:-}"
done

# 3. Render — schema §10 예시 순서 일치
cat <<EOF
schema_version = "1.1"

[project]
name = "$HM_NAME"
language = "$HM_LANGUAGE"
package_manager = "$HM_PACKAGE_MANAGER"
runtime_version = "$HM_RUNTIME_VERSION"
locale = "${HM_LOCALE:-en}"

[harness]
code_dir = "$HM_CODE_DIR"
phases_dir = "$HM_PHASES_DIR"
EOF
[ -n "${HM_GUARDRAILS:-}" ] && echo "guardrails = \"$HM_GUARDRAILS\""
echo "mcp_server = \"harness\""

cat <<EOF

[agents]
primary = "claude-code"

[architecture]
meta_ref = "$HM_META_REF"
EOF

if [ -n "${HM_BUILD_TOOL:-}" ]; then
    cat <<EOF

[build]
tool = "$HM_BUILD_TOOL"
build_cmd = "$HM_BUILD_CMD"
artifact_dir = "$HM_ARTIFACT_DIR"
EOF
fi

if [ -n "${HM_TEST_CMD:-}${HM_LINT_CMD:-}${HM_FORMAT_CMD:-}${HM_TYPE_CHECK_CMD:-}" ]; then
    echo ""
    echo "[testing]"
    [ -n "${HM_TEST_CMD:-}" ]       && echo "test_cmd = \"$HM_TEST_CMD\""
    [ -n "${HM_TYPE_CHECK_CMD:-}" ] && echo "type_check_cmd = \"$HM_TYPE_CHECK_CMD\""
    [ -n "${HM_LINT_CMD:-}" ]       && echo "lint_cmd = \"$HM_LINT_CMD\""
    [ -n "${HM_FORMAT_CMD:-}" ]     && echo "format_cmd = \"$HM_FORMAT_CMD\""
fi

exit 0
```

**원칙**:
- 환경변수만 입력 — 인자 파싱 복잡도 회피
- TOML 섹션 순서 = schema §10 예시 = `[project]` → `[harness]` → `[agents]` → `[architecture]` → `[build]` → `[testing]`
- 미정의 옵션 필드는 emit 안 함 → grep+sed bash 파서 misfire 방지
- `mcp_server`은 항상 emit (현재 단일 default)
- TOML escaping: `"`, `'`, `\n`, `$`, `\` 5종 거부 → exit 2. interview.md가 사용자에게 재입력 요구. `'` 추가 = bash `-c` 명령 주입 차단
- bash 4+ gate: macOS 시스템 bash 3.2 silent fail 방지. `brew install bash` 안내 (exit 3)
- 본 helper 미생성 필드 (7): executor / statusline_cmd / statusline_timeout_ms / state_file / harness_test_cmd / notifications / agents.secondary — v1.11+ overlay 또는 사용자 후속

### Tmpl 변수 매핑 (W3)

`skeletons/CLAUDE.md.tmpl` / `skeletons/GUARDRAILS.md.tmpl` / `skeletons/projects/*.md`의 `{{var}}` 마커는 Claude가 인터뷰 답변(env)에서 치환:

| Tmpl marker | env source | Fallback |
|---|---|---|
| `{{name}}` | `HM_NAME` | (코어, 필수) |
| `{{language}}` | `HM_LANGUAGE` | (코어, 필수) |
| `{{runtime_version}}` | `HM_RUNTIME_VERSION` | (코어, 필수) |
| `{{package_manager}}` | `HM_PACKAGE_MANAGER` | (코어, 필수) |
| `{{code_dir}}` | `HM_CODE_DIR` | `scripts/harness` |
| `{{phases_dir}}` | `HM_PHASES_DIR` | `phases` |
| `{{guardrails_path}}` | `HM_GUARDRAILS` | `docs/GUARDRAILS.md` |
| `{{locale}}` | `HM_LOCALE` | `en` |
| `{{q11_observability}}` | (Q11 자유 응답) | `(미설정)` |
| `{{q12_ci}}` | (Q12 자유 응답) | `(미설정)` |

**치환 방식**: Claude가 Read tmpl → 답변 기반 텍스트 치환 → Write 결과 파일. bash sed helper 별도 작성 안 함 (Claude 직접 처리, G18).

## INTERVIEW_FLOW.md — 흐름 문서 구조

1. **Bootstrap 모드 진입 조건** — `.harness.toml` 부재 + `projects/<name>/` 부재 동시 충족
2. **10-stage 표** (S0~S10, 위 §책임 분리 표 재게시)
3. **데이터 전달 명세** — detect → interview → render의 환경변수 매핑 + Q11/Q12 자유 응답 → INTERVIEW.md 흐름. **detect output 파싱 절차** (W18):
   ```
   (a) Claude는 Bash tool로 detect-project.sh 실행, stdout 캡처:
       DETECT_OUT=$(bash $HARNESS_META_ROOT/bootstrap/detect-project.sh "$PROJECT_ROOT")
   (b) Claude는 출력에서 line별 grep으로 default 추출:
       lang=$(echo "$DETECT_OUT" | grep -E '^language = "' | sed -E 's/.*"([^"]+)".*/\1/')
       pm=$(echo   "$DETECT_OUT" | grep -E '^package_manager = "' | sed -E 's/.*"([^"]+)".*/\1/')
       test_cmd=$(echo "$DETECT_OUT" | grep -E '^test_cmd = "' | sed -E 's/.*"([^"]+)".*/\1/')
       lint_cmd=$(echo "$DETECT_OUT" | grep -E '^lint_cmd = "' | sed -E 's/.*"([^"]+)".*/\1/')
       format_cmd=$(echo "$DETECT_OUT" | grep -E '^format_cmd = "' | sed -E 's/.*"([^"]+)".*/\1/')
   (c) 각 default 값을 Q2/Q3/Q10에 표시 후 사용자 확정 → HM_* env로 export
   (d) Q11/Q12 자유 응답은 env 미매핑 — Claude 메모리에만 보유 후 INTERVIEW.md/STACK.md에 기록
   ```
4. **각 stage 실패/abort 정책**:
   - S1 detect 실패 → unknown으로 진행, 사용자 수동 입력 강제
   - S2 사용자 abort → 0 영향 (아직 파일 미작성)
   - S3 render 실패 (escaping 위반) → 사용자에게 재입력 요구. 3회 시도 후 abort
   - S4 manifest round-trip 실패 → 작성된 manifest를 backup 후 재시도 안내
   - S5 부수 자산 실패 (CLAUDE.md/GUARDRAILS/phases) → manifest 보존, 사용자 수동 작성 안내
   - S6 install-project-claude 실패 → manifest+부수 자산 그대로, 사용자에게 재실행 안내
   - S7~S9 실패 → 사용자 수동 작성 안내 (manifest+`.claude/`는 보존, 프로젝트는 작동 가능 상태)
5. **Idempotency** — 재실행 시 `.harness.toml` 존재하면 abort. **Claude가 사용자에게 명시 확인** ("기존 manifest 발견. backup 후 재진행할까요?"). yes → `<proj>/.harness.toml` → `<proj>/.harness/backups/manifest.<ts>.toml` 이동 (.harness/ 디렉토리 생성). 동시에 `<proj>/.gitignore`에 `.harness/backups/` 자동 append (없으면 .gitignore 신규). no → abort. (bash flag 아닌 대화 분기) — git 추적 오염 방지(W8)
6. **Cross-platform OS 분기 (S6 install-project-claude 호출)**:
   ```bash
   case "$(uname -s 2>/dev/null || echo Windows)" in
       MINGW*|MSYS*|CYGWIN*|Windows) pwsh "$HARNESS_META_ROOT/bootstrap/install-project-claude.ps1" -ProjectRoot "$PWD" ;;
       Darwin|Linux|*)               bash "$HARNESS_META_ROOT/bootstrap/install-project-claude.sh" "$PWD" ;;
   esac
   ```
   Claude는 Bash tool로 `uname -s` 실행 후 분기 명령 호출.
7. **로깅** — 인터뷰 진행 중 답변은 메모리. manifest 작성 후 INTERVIEW.md에 영구 기록 (Q1~Q12 + 자유 응답)

## skeletons/ 템플릿 명세

### `skeletons/CLAUDE.md.tmpl` (~30줄)

```markdown
# 프로젝트: {{name}}

<!-- 이 파일은 Bootstrap v0.1로 자동 생성. 자유롭게 수정. -->

## 기술 스택
- {{language}} {{runtime_version}} ({{package_manager}})

## 하네스 통합
- 매니페스트: `.harness.toml`
- 코드 디렉토리: `{{code_dir}}`
- Phases: `{{phases_dir}}`
- 가드레일: `{{guardrails_path}}`

## 아키텍처 상세
@~/harness-meta/projects/{{name}}/ARCHITECTURE.md

## 작업 규칙
- 커밋 전 사용자 확인
- (사용자가 후속 추가)
```

### `skeletons/GUARDRAILS.md.tmpl` (~20줄)

```markdown
# {{name}} — Guardrails

<!--
이 파일은 하네스가 매 step 프롬프트에 주입하는 압축 규칙이다.
- 5120 byte 상한 (UTF-8). 초과 시 빌더가 거부.
- AGENTS.md(전체 컨텍스트)와 다름. 여기는 step-level 핵심만.
- 신규 프로젝트는 빈 § 헤더로 시작 → 도메인 학습하며 채워라.
-->

## CRITICAL 규칙

(예: 외부 호출 금지 / 환경변수 경로 / 데이터 가공 위치 등)

## 테스트 정책

## 커밋 정책

## 금지 패턴
```

### `skeletons/projects/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK}.md`

각 파일 상단 `<!-- BOOTSTRAP: replaced at v0.1-bootstrap. {{var}} 마커는 Claude가 인터뷰 답변으로 치환 -->` 주석.

- **ARCHITECTURE.md**: `{{name}}` 개요 / 디렉토리 구조 placeholder / `{{code_dir}}` 통합 지점 / Q11~Q12 자유 응답 일부 반영
- **DECISIONS.md**: H-ADR-001 placeholder (Bootstrap 시점 핵심 결정 1건). 사용자가 후속 추가
- **INTERVIEW.md**: Q1~Q12 + 자유 응답 그대로 기록. **upbit INTERVIEW.md 형식 준용** — 각 질문은 `## QN. 질문 텍스트` + `**답**: ...` + `**근거**: ...` 패턴. 12개 Q 마커를 placeholder로 미리 작성. "본 파일은 v0.1-bootstrap 답변 원본. 향후 ARCHITECTURE 업데이트의 근거"
- **STACK.md**: 언어/PM/runtime/test/lint/format/type_check 표 + Q11(관측)/Q12(CI) 응답 반영 placeholder

### `skeletons/sessions/v0.1-bootstrap/{PLAN,REPORT}.md`

- **PLAN.md**: 세션 소속 근거(`sessions/{{name}}/`, S4+S6 다수) + 목표 = 10-stage 완수 + 변경 대상 = 신규 프로젝트 루트·projects·sessions
- **REPORT.md**: 10-stage 통과 체크박스 + 인터뷰 답변 요약 (INTERVIEW.md 참조) + 후속 (GUARDRAILS 작성 / `/config` Output style / scripts/harness 도입 등)

## smoke 시나리오

```bash
# tests/smoke-bootstrap-render.sh — 기존 fixture 재사용. detect→render→reparse 사이클.
set -euo pipefail
META_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FIXTURE="$META_ROOT/tests/fixtures/detect-python-uv"

# Stage 1: detect
DETECT_OUT="$(bash "$META_ROOT/bootstrap/detect-project.sh" "$FIXTURE")"
echo "$DETECT_OUT" | grep -q 'language = "python"'      || { echo "FAIL detect lang";  exit 1; }
echo "$DETECT_OUT" | grep -q 'package_manager = "uv"'   || { echo "FAIL detect pm";    exit 1; }

# Stage 2: interview answers (env mock — 사용자 대화 시뮬)
export HM_NAME="my-pyuv"
export HM_LANGUAGE="python"
export HM_PACKAGE_MANAGER="uv"
export HM_RUNTIME_VERSION="3.12"
export HM_CODE_DIR="scripts/harness"
export HM_PHASES_DIR="phases"
export HM_META_REF="projects/my-pyuv/ARCHITECTURE.md"
export HM_GUARDRAILS="docs/GUARDRAILS.md"
export HM_LOCALE="ko"
export HM_TEST_CMD="uv run pytest"
export HM_LINT_CMD="uv run ruff check"
export HM_FORMAT_CMD="uv run ruff format --check"
export HM_TYPE_CHECK_CMD="uv run mypy src"

# Stage 3: render
TOML_FILE="$(mktemp)"
bash "$META_ROOT/bootstrap/render-manifest.sh" > "$TOML_FILE"

# Stage 4: assertions on rendered TOML
grep -q '^schema_version = "1.1"$'              "$TOML_FILE" || { echo FAIL schema; exit 1; }
grep -q '^name = "my-pyuv"$'                    "$TOML_FILE" || { echo FAIL name; exit 1; }
grep -q '^locale = "ko"$'                       "$TOML_FILE" || { echo FAIL locale; exit 1; }
grep -q '^mcp_server = "harness"$'              "$TOML_FILE" || { echo FAIL mcp; exit 1; }
grep -q '^primary = "claude-code"$'             "$TOML_FILE" || { echo FAIL agent; exit 1; }
grep -q '^meta_ref = "projects/my-pyuv/.*"$'    "$TOML_FILE" || { echo FAIL meta_ref; exit 1; }
grep -q '^type_check_cmd = "uv run mypy src"$'  "$TOML_FILE" || { echo FAIL type_check; exit 1; }

# Stage 5: round-trip — session-init.sh / statusline.sh가 쓰는 grep+sed 파싱과 동일 패턴 재현
# 3 필드: name + code_dir + phases_dir (W5 — 신규 프로젝트 hook 호환 보장)
parsed_name="$(grep -E '^name[[:space:]]*=[[:space:]]*"' "$TOML_FILE" | head -1 \
    | sed -E 's/^name[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')"
[ "$parsed_name" = "my-pyuv" ] || { echo "FAIL round-trip name=$parsed_name"; exit 1; }

parsed_code_dir="$(grep -E '^code_dir[[:space:]]*=[[:space:]]*"' "$TOML_FILE" | head -1 \
    | sed -E 's/^code_dir[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')"
[ "$parsed_code_dir" = "scripts/harness" ] || { echo "FAIL round-trip code_dir=$parsed_code_dir"; exit 1; }

parsed_phases_dir="$(grep -E '^phases_dir[[:space:]]*=[[:space:]]*"' "$TOML_FILE" | head -1 \
    | sed -E 's/^phases_dir[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')"
[ "$parsed_phases_dir" = "phases" ] || { echo "FAIL round-trip phases_dir=$parsed_phases_dir"; exit 1; }

# Stage 6: escaping rejection — unsafe input must exit 2 (not exit 1)
set +e
HM_NAME='bad"name' HM_LANGUAGE=python HM_PACKAGE_MANAGER=uv \
HM_RUNTIME_VERSION=3.12 HM_CODE_DIR=scripts/harness HM_PHASES_DIR=phases \
HM_META_REF=projects/x/ARCHITECTURE.md \
bash "$META_ROOT/bootstrap/render-manifest.sh" >/dev/null 2>&1
rc=$?
set -e
[ $rc -eq 2 ] || { echo "FAIL escape-rejection: rc=$rc (expected 2)"; exit 1; }

# Stage 7: single-quote rejection (W2 — bash -c 명령 주입 차단)
set +e
HM_NAME="bad'name" HM_LANGUAGE=python HM_PACKAGE_MANAGER=uv \
HM_RUNTIME_VERSION=3.12 HM_CODE_DIR=scripts/harness HM_PHASES_DIR=phases \
HM_META_REF=projects/x/ARCHITECTURE.md \
bash "$META_ROOT/bootstrap/render-manifest.sh" >/dev/null 2>&1
rc=$?
set -e
[ $rc -eq 2 ] || { echo "FAIL single-quote-rejection: rc=$rc"; exit 1; }

rm -f "$TOML_FILE"
echo "PASS — bootstrap render smoke (7 stages)"
```

**검증 포인트 (7 stage)**:
1. Stage 1: detect lang/pm 정확
2. Stage 2: env mock 설정
3. Stage 3: render → 임시 파일
4. Stage 4: render된 TOML 7개 라인 grep 검증 (schema_version + name + locale + mcp_server + primary + meta_ref + type_check_cmd)
5. Stage 5: round-trip — `name` + `code_dir` + `phases_dir` 3 필드를 session-init.sh / statusline.sh의 grep+sed 패턴으로 재추출하여 일치 확인 (W22 — hook 호환 보장)
6. Stage 6: `"` (double quote) 입력 → render exit 2 검증
7. Stage 7: `'` (single quote) 입력 → render exit 2 검증 (W2 — bash 명령 주입 차단)

## Grey Areas — 결정 (24건: 16 + R 반영 4 + M/W 반영 4)

| ID | 질문 | 결정 |
|---|------|------|
| **G1** | 인터뷰 — Claude markdown vs bash interactive | **Claude markdown** (slash command 정합) |
| **G2** | 필수 vs 선택 필드 분리 | schema §6.2~6.3 기준 — 코어 7 필수, 옵션 5 + 자유 2 |
| **G3** | detect unknown 처리 | **detect unknown은 첫 시도부터 manual 입력 (재시도 카운트 시작점)**. 코어 필드의 빈 응답/skip 3회 시 abort. 두 케이스 분리 (W10 반영) |
| **G4** | 기존 `.harness.toml` 존재 | abort + Claude가 사용자 명시 확인. yes → backup 이동 후 같은 대화 내 인터뷰 재진입 (위치·형식 G22 참조). 재실행 = 슬래시 명령 재호출 아님 |
| **G5** | TOML 렌더링 위치 | render-manifest.sh 분리 (schema 변화 시 단일 갱신점) |
| **G6** | code_dir 디렉토리 자동 생성 | **No** — manifest만. scripts/harness/ 골격은 v1.11+ overlay |
| **G7** | install-project-claude 자동 호출 | **자동** — 10-stage 일관성. cross-platform OS 분기 (uname) |
| **G8** | projects/4종 — 답변 채움 vs placeholder | 부분 채움 — INTERVIEW.md = 답변 그대로 + Q11/Q12 자유 응답, ARCHITECTURE/STACK은 표 부분 채움, 자유 서술은 placeholder |
| **G9** | 세션 ID — v0.1-bootstrap 고정 | **고정** — 한 프로젝트당 한 번. 재부트스트랩은 v0.2-rebootstrap 별도 |
| **G10** | AGENTS.md baseline | **본 세션 범위 외** — `v1.10b-bootstrap-agents-md` 후속. 신규 프로젝트는 일시적으로 CLAUDE.md only (v1.5 규약 §6 시나리오 A) |
| **G11** | 인터뷰 질문 수 | **코어 7 + 옵션 manifest 3 + 자유 2 = 12** + 자동 4. upbit Q12 대비 (Q11 관측 / Q12 CI 자유 응답으로 흡수) |
| **G12** | locale default | **`"en"`** (schema §6.2 default 준수). 한국어 사용자가 명시 입력 — 조용한 주입 금지 |
| **G13** | 폴리글랏 monorepo | 단일 언어 가정. v1.23+ 후속 |
| **G14** | 비대화형 mode | v1.22+ 후속 |
| **G15** | abort 후 cleanup 책임 | abort 시점 따라 분기 — manifest 작성 전 = 0 영향. 작성 후 = 사용자 수동 또는 G4 재실행 |
| **G16** | render-manifest.sh PowerShell port | **bash-only** — Git Bash가 Windows에서도 동작. install-project-claude만 ps1+sh 둘 다 필요 |
| **G17** | TOML escaping (R8/W2) | **render에서 5종 거부** — `"`, `'`, `\n`, `$`, `\` 포함 시 exit 2. `'` 추가 = bash `-c` 명령 주입 차단 (G21 참조). interview가 재입력 요구 |
| **G18** | skeleton 디렉토리 위치 (R2) | **`bootstrap/skeletons/`** — `_base/`(install이 소비)와 분리. install-project-claude 미관여 |
| **G19** | CLAUDE.md baseline 책임 (R4) | **본 세션** — S5 a) 3분기: (i) 부재→tmpl 신규, (ii) 존재+import 라인 부재→append 사용자 확인, (iii) 존재+import 있음→no-op |
| **G20** | scripts/harness/ 골격 + phases/ (R6) | scripts/harness/ → v1.11+ overlay. phases/ → 본 세션에서 `{HM_PHASES_DIR}/.gitkeep` 생성 (default `phases/`). 비표준 phases_dir도 동일 처리 (M3) |
| **G21** | bash 4+ 호환 (M1) | render-manifest.sh 시작부에 `BASH_VERSINFO[0] >= 4` gate. macOS 시스템 bash 3.2 silent fail 방지. `brew install bash` 사용자 안내 (exit 3) |
| **G22** | manifest backup 위치 (W8) | `<proj>/.harness/backups/manifest.<ts>.toml` + `.gitignore`에 `.harness/backups/` 자동 append. git 추적 오염 방지 |
| **G23** | INTERVIEW.md 작성 형식 (W4) | upbit `## QN.` + `**답**` + `**근거**` 패턴 준용. skeletons/projects/INTERVIEW.md에 12 Q 마커 미리 작성 |
| **G24** | Q&A UX 시퀀스 (W12) | Claude가 한 번에 12 질문 표시 (default 옆 명시). 사용자 한 번에 답변. 12 turn 회피 |

## 성공 기준

- [ ] `bootstrap/interview.md` — 코어 7 + 옵션 manifest 3 + 자유 2 + 자동 4 + Q→A 처리 규칙 모두 명시
- [ ] `bootstrap/docs/INTERVIEW_FLOW.md` — 10-stage + abort 정책 + idempotency 대화 분기 + cross-platform OS 분기 코드
- [ ] `bootstrap/render-manifest.sh` — schema §10 순서 일치 + bash 4+ gate (exit 3) + escaping 검증 5종 (`"`, `'`, `\n`, `$`, `\` 거부, exit 2) + 미생성 필드 7종 주석 명시 + exit code 표 (0/1/2/3)
- [ ] `bootstrap/skeletons/projects/{4종}.md` + `sessions/v0.1-bootstrap/{2종}.md` + `CLAUDE.md.tmpl` + `GUARDRAILS.md.tmpl` 존재 (총 8 placeholder)
- [ ] `tests/smoke-bootstrap-render.sh` 실행 → "PASS — bootstrap render smoke (7 stages)" + exit 0. 기존 fixture 재사용 (신규 fixture 0). Stage 6/7에서 `"` + `'` 입력 → exit 2 명시 검증
- [ ] `claude/commands/harness-meta.md` Bootstrap 절차 10-stage 명시 + interview.md 정확 링크 + tools에 8종 Bash 권한 추가 (`bash*/pwsh*/grep*/sed*/uname*/mv*/cp*/test*`)
- [ ] `manifest-schema.md` §12에 Bootstrap 신규 작성 cross-link 절 (3~5줄)
- [ ] `CLAUDE.md` + `README.md`에 INTERVIEW_FLOW.md 링크
- [ ] Grey Area 24건 모두 결정 + REPORT 반영
- [ ] 사용자 확인 후 단일 커밋 + push

## 커밋 전략

단일 커밋 — 인터뷰 흐름·렌더 helper·skeleton·슬래시 명령 갱신은 원자 단위 (부분 적용 시 슬래시 명령이 부재 자산 참조).

```
feat(meta): sessions/meta/v1.10-bootstrap-interview — Bootstrap 인터뷰 10-stage 흐름

- add: bootstrap/interview.md (Claude 인터뷰 — 코어 7 + 옵션 manifest 3 + 자동 4 + 자유 2)
- add: bootstrap/docs/INTERVIEW_FLOW.md (10-stage + abort + idempotency 대화 분기 + cross-platform OS 분기)
- add: bootstrap/render-manifest.sh (key=value → .harness.toml v1.1, schema §10 순서, bash 4+ gate, escaping 5종 거부, exit codes 0/1/2/3)
- add: bootstrap/skeletons/projects/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK}.md
- add: bootstrap/skeletons/sessions/v0.1-bootstrap/{PLAN,REPORT}.md
- add: bootstrap/skeletons/CLAUDE.md.tmpl (프로젝트 루트 baseline + ARCHITECTURE import)
- add: bootstrap/skeletons/GUARDRAILS.md.tmpl (5120 byte 안내 + 빈 § 4개)
- add: tests/smoke-bootstrap-render.sh (기존 fixture 재사용, 7-stage 검증 — `"` + `'` exit 2 검증 포함)
- update: claude/commands/harness-meta.md (10-stage 갱신 + interview.md 링크 + tools 8종 Bash 권한)
- update: bootstrap/manifest-schema.md (§12.3 Bootstrap 신규 작성 cross-link)
- update: CLAUDE.md / README.md (INTERVIEW_FLOW 링크)
- add: sessions/meta/v1.10-bootstrap-interview/{PLAN,REPORT,evidence/smoke-bootstrap-render.txt}

v1.9 detect-project.sh의 자연 후속. /harness-meta <new-name> Bootstrap 모드를
재현 가능 흐름으로 고정. 실 신규 프로젝트 적용은 별도 sessions/<name>/v0.1-bootstrap/.

Smoke PASS — Python/uv fixture detect→render→round-trip→`"`/`'` rejection 7 stage.
Grey Area 24건 결정 (G17~G20: R 반영, G21~G24: M1/W2/W4/W8/W12 반영).
```

사용자 확인 후 push.

## 후속 세션 연결

### 직접 연계 (본 흐름 적용·확장)

- **v1.10b-bootstrap-agents-md** (S2) — Bootstrap 흐름에 AGENTS.md baseline 자동 생성 추가 (v1.5 규약 §10 마이그레이션 가이드 적용). Stage S5와 S6 사이 S5.5로 삽입
- **v1.11~v1.13 bootstrap-templates** (S2) — 언어별 overlay (`bootstrap/templates/<language>/`). `code_dir/`, `executor`, `statusline_cmd`, `state_file`, `harness_test_cmd` 등 본 세션 omit 필드를 overlay에서 공급
- **v1.22-bootstrap-noninteractive** (S2) — JSON config 입력 비대화형 mode (CI/CD)
- **v1.23-monorepo-polyglot** (S2) — 다중 언어 monorepo Bootstrap

### 적용 사례

- 새 프로젝트 추가 시점에 본 인터뷰 호출 → `sessions/<new-name>/v0.1-bootstrap/`
- upbit는 이미 부트스트랩 완료 — 재적용 안 함 (Idempotency G4)

### Lessons Forward

- v1.9 detect → v1.10 interview → v1.11+ template overlay의 **3-stage 파이프라인** 정착
- 신규 프로젝트는 본 흐름 후 `INTERVIEW.md`에 Q1~Q12 + 자유 응답 보존 → audit trail
- **신규 프로젝트는 일시적으로 CLAUDE.md only** (AGENTS.md 부재). v1.10b 적용 전까지 v1.5 규약 §6 시나리오 A 미달 — 의식적 점진 도입 (T4 분할 원칙)
- **본 세션이 미생성하는 manifest 필드 7종** (executor / statusline_cmd / statusline_timeout_ms / state_file / harness_test_cmd / notifications / agents.secondary)은 v1.11+ overlay 또는 사용자 후속 책임 — 슬래시 명령 step 4가 약속한 "scripts/harness/ 언어별 실행기"의 자연스러운 후속 작업
- **README.md 프로젝트 섹션 위치 (W14)** — 구현 시 `~/harness-meta/README.md`의 정확한 헤더(예: `## 대상 프로젝트` 또는 `## 활성 프로젝트`)를 grep으로 확인 후 항목 추가. 본 PLAN은 위치 미확정 — 구현 단계에서 결정
- **L3 추출 대비** — 본 세션 산출 자산은 모두 `~/harness-meta/bootstrap/` 하위 → 향후 하네스 코어 분리(L3) 시 같이 이동 또는 잔존 결정에 영향 없음 (S2 scope 보존)
