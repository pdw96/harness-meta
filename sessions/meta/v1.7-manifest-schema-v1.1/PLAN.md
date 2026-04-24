# meta v1.7-manifest-schema-v1.1 — PLAN

세션 시작: 2026-04-25
선행 세션: [`sessions/meta/v1.6-language-neutral-claude-layer/`](../v1.6-language-neutral-claude-layer/REPORT.md)
목적: `.harness.toml` 스키마 **v1.0 → v1.1** SemVer minor bump (additive only). v1.6 선반영 필드(`statusline_cmd`, `state_file`) 정식화 + 다국어/다어댑터 지원 필드 추가 + manifest-schema.md 12 섹션 재구성. fixture + smoke 스크립트로 bash 파싱 회귀 검증.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: `bootstrap/manifest-schema.md` + `bootstrap/docs/OWNERSHIP.md` → **S2** 2개 + fixture 4개 + smoke 1개 → **S2** 총 7.
- **T1 경로 다수결** — S2 전부 → meta.
- **T2 스펙 vs 값** — 스펙 자체 변경이라 meta. upbit 실제 매니페스트 upgrade는 T4로 별도 세션.

## 배경

### pyproject.toml `semantics-version` 거부 전례

[PEP 518 논의](https://peps.python.org/pep-0518/) — `semantics-version` 필드 **명시 거부** ("premature optimization"). 현재 pyproject.toml은 스키마 버전 필드 없음.

**본 세션 교훈**: `schema_version` 필드 유지 정당화 필수. 현재 harness-meta:
- hook/statusline: 읽지 **않음** (bash grep 대상에서 제외)
- install.ps1 / verify.ps1: 읽지 않음
- 실질 dead field

**결정**: retained — 이유 명시:
1. 문서화 가치 (사용자가 "이 매니페스트는 v1.1 규격" 기록)
2. 미래 tomllib parser(v2.0+)의 검증용
3. 3rd-party 도구 호환성 판단

### v1.6 선반영 필드 정식화

v1.6 hook/statusline이 이미 fallback-read하는 두 필드:

| 필드 | v1.6 구현 | v1.7 정식화 |
|------|---------|-----------|
| `[harness].statusline_cmd` | grep 읽음, array 실행 (`timeout 3s`) | 스펙 확정 |
| `[harness].state_file` | grep 읽음, 있으면 cat → additionalContext 주입 | 스펙 확정 |

### v1.4 로드맵 결정 반영

- **`[project].runtime_version`** (통일) — `python_version`/`node_version`/… 필드 인플레이션 회피. 값 해석은 `language` 필드와 조합
- **`[project].locale`** — AGENTS.md §8 locale 정책. 기본 `"en"`, `"ko"` 등 (bootstrap v1.10+만 해석)
- **`[agents]`** — primary adapter 선언 (v1.8 core-adapter-split 전제)
- **`[build]` 섹션** — 컴파일 언어 빌드 명령 (v1.8+ harness-ship 활용)
- **`[testing].format_cmd`** — test/type_check/lint 외 format 분리 (v1.8+ review 활용)
- **`[harness].statusline_timeout_ms`** — 사용자 override 가능 필드 (기본 3000, 구현 일치)

### 하위 호환 원칙 — Additive Only

- schema 1.0 매니페스트(upbit 포함) **무변경**
- 누락 신규 필드는 hook/statusline이 default 또는 skip
- breaking 0건

## 목표

- [ ] **manifest-schema.md 12 섹션 재구성** (원 5 → 12)
- [ ] **v1.0 → v1.1 변경 요약 표** + **하위 호환 매트릭스** 2개
- [ ] **bash 파싱 가능/불가 필드 분류 표** (신규)
- [ ] v1.6 선반영 필드 정식화: `statusline_cmd`, `statusline_timeout_ms`, `state_file`
- [ ] 신규 필드: `[project].runtime_version`, `locale`, `[agents].primary`, `[agents].secondary`, `[build].*`, `[testing].format_cmd`
- [ ] 다언어 예시 4종: Python/uv, TS/pnpm, Go, Rust
- [ ] `python_version` deprecated 표기 (retained)
- [ ] `mcp_server` vs `agents.primary` 관계 문서화
- [ ] `guardrails` vs AGENTS.md 역할 분리 문서화
- [ ] OWNERSHIP.md Evolution 조항에 "schema v1.1 bump 적용 예시" 추가
- [ ] fixture `tests/fixtures/schema-v1.1-full/` (매니페스트 + state 파일 + .gitkeep)
- [ ] `tests/smoke-v1.1.sh` — 15라인 이내 bash 파싱 회귀 smoke
- [ ] smoke 실행 evidence
- [ ] verify.ps1 30/30 유지 (회귀 없음)
- [ ] Grey Area 37건 결정 기록

## 범위

**포함**:
- `bootstrap/manifest-schema.md` 대규모 재작성 (12 섹션)
- `bootstrap/docs/OWNERSHIP.md` Evolution 조항 예시 추가
- fixture 4 파일 (`.harness.toml`, `.state.txt`, `.gitkeep`, 디렉토리)
- `tests/smoke-v1.1.sh` 신규
- evidence 1 (`smoke-v1.1-output.txt`)
- 세션 기록

**제외 (T4 후행 / 범위 외)**:
- upbit 매니페스트 upgrade → `sessions/upbit/vX-manifest-upgrade-1.1/`
- upbit statusline 복원 (statusline_cmd + state_file) → `sessions/upbit/vX-statusline-cmd-migration/`
- `[agents]` / `[build]` / `format_cmd` 실 해석 구현 → v1.8+
- `statusline_timeout_ms` hook 기본값 2000 변경 → 별도 `sessions/meta/vX-statusline-timeout-2s/`
- tomllib parser 도입 → v2.0
- `[ci]` / `[worktree]` 필드 — 실사용 사례 없음 (v1.2+ 후보)

## 변경 대상

### 수정 파일 (2)

| # | 경로 | scope | 변경 |
|---|------|-------|------|
| 1 | `bootstrap/manifest-schema.md` | S2 | **12 섹션 재작성** — 원 ~170 라인 → 확장 |
| 2 | `bootstrap/docs/OWNERSHIP.md` | S2 | Evolution `. harness.toml 스키마 진화 시` 조항에 v1.1 예시 3~5줄 추가 |

### 신규 파일 (6)

| # | 경로 | 역할 |
|---|------|------|
| 3 | `tests/fixtures/schema-v1.1-full/.harness.toml` | v1.1 전 필드 예시 |
| 4 | `tests/fixtures/schema-v1.1-full/phases/.harness-state.txt` | state_file 샘플 내용 |
| 5 | `tests/fixtures/schema-v1.1-full/.gitkeep` | |
| 6 | `tests/smoke-v1.1.sh` | 15라인 이내 bash 파싱 회귀 검증 |
| 7 | `sessions/meta/v1.7-manifest-schema-v1.1/PLAN.md` | 본 파일 |
| 8 | `sessions/meta/v1.7-manifest-schema-v1.1/REPORT.md` | 구현 후 |
| 9 | `sessions/meta/v1.7-manifest-schema-v1.1/evidence/smoke-v1.1-output.txt` | smoke 결과 캡처 |

## manifest-schema.md 12 섹션 구조 (확정)

1. **제목 + 한 줄 설명**
2. **설계 원칙** — 1파일·평탄·상대경로·파싱 단순성·스키마 진화
3. **v1.0 → v1.1 변경 요약 표** (신규) — breaking=0, deprecated=1, additive=다수
4. **파싱 호환성 제약** (v1.0 제약 + v1.1 추가)
5. **현행 버전** — `schema_version = "1.1"` (SemVer minor)
6. **전체 스키마** (v1.1 풀 예시 TOML)
7. **필드 상세** — 섹션별 표 + 신규 [agents]/[build]
8. **bash 파싱 가능/불가 필드 표** (신규) — dead field 명시 포함
9. **하위 호환 매트릭스** — v1.0 필드별 v1.1 동작
10. **다언어 예시 4종** — Python/uv, TS/pnpm, Go, Rust + "참고: upbit는 schema 1.0"
11. **파싱 가이드** — bash (최소) + Python tomllib (깊은 파싱)
12. **마이그레이션 가이드 + 향후 확장**

## v1.1 스키마 정식 (요약)

```toml
schema_version = "1.1"

[project]
name = "..."
language = "..."
package_manager = "..."
runtime_version = "..."    # v1.1 — 통일 (python_version/node_version 대체)
locale = "en"              # v1.1 — 기본 "en"
# python_version = "..."   # deprecated, retained

[harness]
code_dir = "..."
phases_dir = "phases"
guardrails = "docs/GUARDRAILS.md"
mcp_server = "harness"
executor = "..."
statusline_cmd = "..."     # v1.1 정식 (v1.6 선반영)
statusline_timeout_ms = 3000  # v1.1 — 기본 3000 (구현 일치)
state_file = "..."         # v1.1 정식 (v1.6 선반영)

[agents]                   # v1.1 신규 (해석 v1.8+)
primary = "claude-code"
secondary = ["cursor", "aider"]   # bash 파싱 불가

[architecture]
meta_ref = "projects/<name>/ARCHITECTURE.md"

[build]                    # v1.1 신규 (해석 v1.8+)
tool = "..."
build_cmd = "..."
artifact_dir = "..."

[testing]
test_cmd = "..."
harness_test_cmd = "..."
type_check_cmd = "..."
lint_cmd = "..."
format_cmd = "..."         # v1.1 신규

[notifications]
discord_webhook_env = "DISCORD_WEBHOOK_URL"
```

## bash 파싱 가능/불가 필드 표 (확정)

| 필드 | bash grep | tomllib | 현재 해석 주체 |
|-----|:---------:|:-------:|--------------|
| `schema_version` | O | O | **dead (문서화 only)** |
| `[project].name` | O | O | hook, statusline |
| `[project].language` | O | O | 사용자/bootstrap |
| `[project].package_manager` | O | O | 사용자/bootstrap |
| `[project].runtime_version` | O | O | 사용자/bootstrap |
| `[project].locale` | O | O | bootstrap (symlink 선택, v1.10+) |
| `[project].python_version` (deprecated) | O | O | 사용자 legacy |
| `[harness].code_dir` | O | O | hook (존재 확인) |
| `[harness].phases_dir` | O | O | hook, statusline |
| `[harness].guardrails` | O | O | harness builders |
| `[harness].mcp_server` | O | O | `.mcp.json` 교차참조 |
| `[harness].executor` | O | O | 문서화, v1.8+ |
| `[harness].statusline_cmd` | O | O | statusline (v1.6 구현) |
| `[harness].statusline_timeout_ms` | O | O | statusline (v1.6 구현 — 하드코딩 3000, override는 tomllib 파서에서) |
| `[harness].state_file` | O | O | session-init (v1.6 구현) |
| `[agents].primary` | O | O | **dead (v1.8+)** |
| `[agents].secondary` (array) | **X** | O | **dead (v1.8+)** |
| `[architecture].meta_ref` | O | O | 프로젝트 CLAUDE.md @import |
| `[build].tool` | O | O | **dead (v1.8+)** |
| `[build].build_cmd` | O | O | **dead (v1.8+)** |
| `[build].artifact_dir` | O | O | **dead (v1.8+)** |
| `[testing].test_cmd` | O | O | harness-ship, harness-review |
| `[testing].harness_test_cmd` | O | O | 동일 |
| `[testing].type_check_cmd` | O | O | 동일 |
| `[testing].lint_cmd` | O | O | 동일 |
| `[testing].format_cmd` | O | O | **dead (v1.8+ harness-review 확장)** |
| `[notifications].discord_webhook_env` | O | O | 프로젝트 runtime |

## 하위 호환 매트릭스 (확정)

| 필드 | v1.0 | v1.1 | 마이그레이션 |
|------|------|------|-----------|
| `schema_version` | "1.0" | "1.1" | string 변경만 (선택) |
| `[project].python_version` | 선택 | **deprecated** retained | 계속 동작. 신규는 `runtime_version` 권장 |
| `[project].runtime_version` | — | 선택 신규 | 선언 안 해도 무방 |
| `[project].locale` | — | 선택 신규, default "en" | 영문 사용자 생략 가능 |
| `[harness].statusline_cmd` | — | 선택 신규 (v1.6 선반영) | 없으면 `[harness] {name}` minimal |
| `[harness].statusline_timeout_ms` | — | 선택 신규, default 3000 | hook 하드코딩 동일 |
| `[harness].state_file` | — | 선택 신규 (v1.6 선반영) | 없으면 "phases directory exists" minimal |
| `[agents].*` | — | 선택 신규, default primary="claude-code" | 기존 프로젝트 무영향 |
| `[build].*` | — | 선택 신규 | 컴파일 언어만 |
| `[testing].format_cmd` | — | 선택 신규 | 없으면 skip |

**Breaking change: 0건. 모든 v1.0 매니페스트(upbit 포함) 무수정 계속 동작.**

## 다언어 예시 설계 (4종)

Python/uv, TypeScript/pnpm, Go, Rust — 각 필수+신규 필드 모두 포함 풀 예시. 각 50~70라인.

## smoke-v1.1.sh (확정)

```bash
#!/usr/bin/env bash
# v1.1 manifest fixture smoke — v1.6 bash hook이 v1.1 신규 필드 파싱 정상 + 회귀 없음
set -e

FIXTURE="$HOME/harness-meta/tests/fixtures/schema-v1.1-full"
HOOK="$HOME/harness-meta/claude/hooks/session-init.sh"
STATUSLINE="$HOME/harness-meta/claude/statusline/statusline.sh"

echo "== hook (v1.1 fixture) =="
CLAUDE_PROJECT_DIR="$FIXTURE" bash "$HOOK"
echo
echo "== statusline (v1.1 fixture) =="
CLAUDE_PROJECT_DIR="$FIXTURE" bash "$STATUSLINE"
echo
echo "PASS: bash hook/statusline parses schema v1.1 fixture"
```

기대 결과:
- hook: `{"hookSpecificOutput":...,"additionalContext":"<state_file 내용>"}`
- statusline: `<statusline_cmd 출력>` 또는 timeout 시 `[harness] <name>` fallback

## Grey Areas — 결정 (37건)

### 기존 G1~G15 (v1.7 PLAN 원안)

| ID | 결정 요약 |
|----|---------|
| G1 | `python_version` deprecated but retained |
| G2 | `statusline_timeout_ms` 스펙 **3000** (구현 일치) |
| G3 | `[agents].primary` default `"claude-code"` |
| G4 | `[agents].secondary` 배열 **선언만**, 해석 v1.8+ |
| G5 | `[build]` Python/TS는 섹션 생략 |
| G6 | `locale` ISO 639-1 2자 + RFC 5646 허용 |
| G7 | `locale` symlink 선택은 bootstrap(v1.10+) |
| G8 | schema_version mismatch 동작 — bash 무관, tomllib(v2.0) warning |
| G9 | upbit 무영향 (additive only) |
| G10 | 예시 4종 문서 내장 + templates 디렉토리는 v1.11+ |
| G11 | grep이 `schema_version` 읽지 않음 명시 |
| G12 | fixture는 수동 smoke + 문서 예시 실증 |
| G13 | `[notifications]` 확장 보류 |
| G14 | `[architecture].meta_ref` 형식 유지 |
| G15 | verify.ps1에 schema_version 체크 추가 안 함 |

### 심층 분석 추가 G16~G37

| ID | 결정 |
|----|------|
| **G16** | `schema_version` retained — 문서화 + tomllib 미래 + 3rd-party |
| **G17** | `runtime_version` 통일 채택 (값 해석 `language` 조합, 필드 인플레이션 회피) |
| **G18** | SemVer semantics 명시 (additive=minor, breaking=major) |
| **G19** | string 타입, SemVer 비교 ("1.10" > "1.9") |
| **G20** | 신규 프로젝트 bootstrap = v1.1 생성, 기존은 migrate 없이 OK |
| **G21** | 섹션 순서 권장: project → harness → agents → architecture → build → testing → notifications |
| **G22** | `[agents].primary` 해석 v1.8+ 명시 |
| **G23** | `[agents].secondary` 배열 bash 파싱 불가 명시 |
| **G24** | `locale` bootstrap(v1.10+)만 해석 |
| **G25** | `[build]` 선언만, v1.8+ harness-ship 활용 |
| **G26** | `format_cmd` 선언만, v1.8+ review 확장 |
| **G27** | `statusline_timeout_ms` 스펙 3000 (구현 일치). 2000은 별도 세션 |
| **G28** | `mcp_server`(세부) vs `agents.primary`(상위) 관계 명시 |
| **G29** | `guardrails`(step-level 주입) vs AGENTS.md(전체 컨텍스트) 분리 |
| **G30** | manifest-schema.md 12 섹션 구성 |
| **G31** | upbit 예시는 "참고 1.0" 언급만, 메인은 다언어 4종 |
| **G32** | bash 파싱 표 신설 — dead field 3개 명시 (schema_version, [agents].*, [build].*) |
| **G33** | smoke-v1.1.sh 간이 스크립트 + evidence 캡처 |
| **G34** | deprecated = 문서만 (실시간 WARN 주체 없음). v2.0 parser에서 emit |
| **G35** | v1.1 추가 필수 필드 0개 (additive only 원칙) |
| **G36** | TOML 트레일링 주석(`# ...`) 허용 — sed가 첫 `"..."`만 추출 |
| **G37** | inline table `[a.b]` 금지 유지. 평탄 구조만 |

## 성공 기준

- [ ] manifest-schema.md 12 섹션 모두 존재
- [ ] v1.0 → v1.1 변경 요약 표 + 하위 호환 매트릭스 2 표 존재
- [ ] bash 파싱 가능/불가 분류 표 존재 (dead field 명시)
- [ ] 다언어 예시 4종 (Python/uv, TS/pnpm, Go, Rust) 모두 풀 TOML
- [ ] `mcp_server` vs `agents.primary` 관계 1 문단 존재
- [ ] `guardrails` vs AGENTS.md 역할 분리 1 문단 존재
- [ ] OWNERSHIP.md Evolution 조항에 "schema v1.1 bump 적용 예시" 3~5줄 추가
- [ ] fixture `tests/fixtures/schema-v1.1-full/` 4 파일
- [ ] `tests/smoke-v1.1.sh` 15라인 이내, chmod +x
- [ ] smoke 실행 → evidence 파일 생성 (hook 출력 + statusline 출력 PASS)
- [ ] verify.ps1 30/30 유지
- [ ] Grey Area 37건 결정 기록
- [ ] 커밋 + push

## 커밋 전략

단일 커밋 (additive only — non-breaking):

```
feat(meta): sessions/meta/v1.7-manifest-schema-v1.1 — schema 1.0 → 1.1 (additive)

- rewrite: bootstrap/manifest-schema.md (12 섹션)
    schema_version "1.1" 정식 (SemVer minor bump).
    v1.6 선반영 정식화: statusline_cmd / statusline_timeout_ms / state_file
    신규: [project].runtime_version / locale / [agents] / [build] / [testing].format_cmd
    deprecated: [project].python_version (retained)
    v1.0 → v1.1 변경 요약 표 + 하위 호환 매트릭스
    bash 파싱 가능/불가 필드 분류 표 (dead field 명시)
    다언어 예시 4종 (Python/uv, TS/pnpm, Go, Rust)
    mcp_server vs agents.primary 관계 / guardrails vs AGENTS.md 역할 분리
- update: bootstrap/docs/OWNERSHIP.md — Evolution 조항에 v1.1 적용 예시
- add: tests/fixtures/schema-v1.1-full/ (매니페스트 + state + .gitkeep)
- add: tests/smoke-v1.1.sh (15라인, bash 파싱 회귀 smoke)
- add: sessions/meta/v1.7-manifest-schema-v1.1/{PLAN,REPORT,evidence}

Additive only — 기존 v1.0 매니페스트(upbit 포함) 무영향.
Grey Area 37건 결정. smoke PASS. verify 30/30 유지.
pyproject.toml의 semantics-version 거부 전례 인지하고 유지 정당화 명시.
```

## 후속 세션 연결

### 직접 연계 (T4 후행)

| 순위 | 세션 ID | Scope |
|-----|---------|-------|
| 1 | **sessions/upbit/vX-statusline-cmd-migration** | S6 upbit — v1.6 + v1.7 함께 적용 (statusline_cmd + state_file) |
| 2 | **sessions/upbit/vX-manifest-upgrade-1.1** | S6 upbit — schema_version "1.1" + runtime_version/locale 등 |
| 3 | v1.8-core-adapter-split | S1+S2 — `[agents]` 필드 실 해석. claude/ → bootstrap/templates/<language>/.claude/ 구조 재편 |

### 보류 후보

- `sessions/meta/vX-statusline-timeout-2s` — hook 기본값 3000→2000 변경 (v1.6 Lesson #5)
- `sessions/meta/vX-manifest-linter-cli` — `.harness.toml` 스펙 검증 CLI 도구 (tomllib 기반)
- `sessions/meta/vX-schema-diff-tool` — v1.0 → v1.1 자동 마이그레이션
- `sessions/meta/vX-notifications-extend` — Slack/Teams/Webhook 일반화
- `sessions/meta/vX-schema-v2-planning` — tomllib parser 도입 (breaking)

### 3개월 재평가 게이트

v1.1 신규 필드 실사용 패턴 관찰. 특히 `[agents].secondary`, `statusline_timeout_ms`, `[build]` 실적용 프로젝트 3+ 확보 후 재논의 (v1.2 또는 v2.0).
