# meta v1.24-plan-spec-verification — REPORT

세션 종료: 2026-04-29
선행 세션:

- [`sessions/meta/v1.23-verify-unification/`](../v1.23-verify-unification/REPORT.md) — verify.sh + Stage H/I 통합. v1.24 본 세션은 L1 "context7 spec 검증 표준화" 후속 직접 응답
- [`sessions/meta/v1.10j-scope-contract-discipline/`](../v1.10j-scope-contract-discipline/PLAN.md) — Scope contract 의무화 패턴 (본 세션이 두 번째 self-applying mechanism으로 재사용)

## 최종 결과

| 항목 | 수치 |
|------|------|
| Smoke PASS (신규) | smoke-spec-verification **11/11** (정적 5 stage + self-test) |
| Smoke PASS (회귀) | smoke-bash-permission-pattern **6/6** (FILES 5 → 5) + smoke-thinking-effort 5/5 + smoke-language-overlay 11/11 + smoke-legacy-cleanup-overlay 9/9 + smoke-skills-install 9/9 + smoke-sync-agents 5/5 + smoke-verify-sh-parity 5/5 + smoke-scope-contract **46/46** (44 → 46, v1.24 PLAN 자동 흡수) |
| verify.ps1 PASS | **38/38** ($frontmatterFiles 13 → 14, Stage I 5/5 신규 SKILL 포함) |
| 신규 파일 | **5** (SKILL.md, SPEC_VERIFICATION.md, smoke-spec-verification.sh, PLAN, REPORT) |
| 수정 파일 | **6** (claude/commands/harness-meta.md, bootstrap/docs/{OWNERSHIP, SKILLS}.md, CLAUDE.md, tests/smoke-bash-permission-pattern.sh, tests/smoke-scope-contract.sh, verify.{ps1,sh}) |
| context7 검증 | C1~C6 (`/websites/code_claude` benchmark 83.6 — drift no) |

## 구현 요약

### Stage 0 — context7 spec 검증

**Query 2회** (`mcp__plugin_context7_context7__query-docs` × 2):

- Q1: SKILL.md frontmatter + PostToolUse hook spec → C1, C2, C3, C4, C5
- Q2: MCP tool name format in `allowed-tools` + skill discovery context budget → C6

**Findings (C1~C6)**: 본 PLAN.md `## Spec verification (context7)` § 본문 list로 채움 (drift=no, 모든 spec v1.10d/v1.10g/v1.23 시점과 동일).

**핵심 영향**: C3 (PostToolUse matcher tool name only)로 SKILL 단독 채택 결정 보강. C6 (MCP tool 이름 `mcp__server__tool` 형식 `allowed-tools` 사용 가능)로 R2 frontmatter 정합 확인.

### Stage A — PLAN.md 작성 (D1.1~D7.4 22 issue 분석)

**1차 작성** 후 사용자 "디테일하게 분석해" 요청 → **7 차원 × 22 issue 카탈로그** (D1.1~D7.4):

- 차원 1 — Skill 배치 (CRITICAL D1.1 발견)
- 차원 2 — § 규격 + smoke 검증 정확성 (HIGH 5건)
- 차원 3 — Trigger 신뢰성 (HIGH 2건)
- 차원 4 — Frontmatter / verify.ps1 통합 (HIGH 2건)
- 차원 5 — self-application + Edge cases (MEDIUM 5건)
- 차원 6 — Source matrix + drift 정의 (MEDIUM 3건)
- 차원 7 — 운영 + 후속 (LOW 4건)

**5 권장안 결정 (K1~K5) 반영**:

- K1: Skill 배치 `_base/.claude/skills/` → **`bootstrap/skills/`** (S1c 글로벌 user-skill, opt-in)
- K2: 변경 대상 표 4 수정 → **6 수정** (verify.ps1 + smoke-bash-permission-pattern.sh FILES 추가)
- K3: smoke S2 `awk '/^## Spec verification.../,/^## /'` § 구간 추출 (전역 grep false positive 차단)
- K4: findings cell 단일 라인 `see citations below`, multi-line citations § 본문 list로 분리
- K5: description trigger "PLAN.md 작성 직후" → "사용자가 'spec 검증' / 'context7 검증' / 'PLAN 검증' 언급 시"

### Stage C — `bootstrap/skills/harness-plan-verify/SKILL.md` 신설 (R2)

**Frontmatter 6축 정합**:

- `name: harness-plan-verify`
- `description: |` (메타 세션 전용 + harness-plan stages 1~4와 무관 명시)
- `allowed-tools:` YAML list 5개 (Read + Grep + Edit + MCP 2 tool)
- `model: opus` + `effort: xhigh` (PERMISSION_PATTERN.md A6 R2 정합)
- `disable-model-invocation` 부재 (Claude auto-invoke 허용)
- `thinking:` 부재 (V10 정합)

**본문 3-step**: Identify (PLAN keyword grep) → Query (source matrix lookup + context7 1~2회) → Fill (Edit § 5 sub-fields).

### Stage D — `claude/commands/harness-meta.md` PLAN § list 갱신 (R1)

PLAN 필수 § list에 1줄 추가:

> **Spec verification (context7)** — 외부 spec drift 검증 표 5 sub-fields (library/topic/findings/drift/re-verify) + Citations 본문 list. drift=N/A 분기 시 모든 sub-field N/A (**의무 v1.24+**, sessions/meta/ only). 상세: `~/harness-meta/bootstrap/docs/SPEC_VERIFICATION.md`

cross-ref 1줄도 footer에 추가.

### Stage E — `bootstrap/docs/SPEC_VERIFICATION.md` 신설 (R3)

10 § 단일 소스:

1. 개요 (수동 → 반자동 전환 동기 + v1.23 REPORT L1 인용)
2. § 규격 (sub-field 5종 + Citations + 영문 key)
3. 위반 정책 (4 케이스 — § 누락 / sub-field 누락 / drift 부적절 / 부분 N/A)
4. **Context7 source matrix** (2 source — `/websites/code_claude` + `/anthropics/claude-code`)
5. SKILL `harness-plan-verify` 사용법 (auto + 수동 + 신뢰성 한계)
6. N/A 정책 (외부 spec 의존 무 케이스 — 부분 N/A 금지)
7. 레거시 정책 (v1.24+ forward-only)
8. 회귀 정책 + self-test
9. v1.24 적용 + 후속 분기 (v1.24b/c/d, v1.B/C/D)
10. 관련 문서

### Stage F — `tests/smoke-spec-verification.sh` 신설 (R4) + `tests/smoke-scope-contract.sh` v1.24 glob (R5)

**`smoke-spec-verification.sh`** (5 stage, 11 check):

- Stage 1 — § 헤더 정확 매치 (`^## Spec verification \(context7\)$`)
- Stage 2 — § 구간 awk 추출 후 sub-field 5종 (`extract_section()` helper)
- Stage 3 — drift 값 yes/no/N/A 정확 1개 (`extract_cell()` helper + `case` 분기)
- Stage 4 — N/A 분기 정합 (drift=N/A → 다른 4 sub-field 정확히 N/A, 부분 N/A 차단)
- Stage 5 — SKILL.md frontmatter 7 check (name/model/effort/MCP query/MCP resolve/thinking 부재)

**Self-test 결과**: v1.24 본 PLAN.md가 첫 입력 → 11/11 PASS (drift=no, sub-field 5종 정합).

**`smoke-scope-contract.sh`**: glob 배열에 `sessions/meta/v1.24*/PLAN.md` 1줄 추가 → 44/44 → 46/46 PASS.

### Stage G — cross-ref 5건 갱신 (D4.2)

- **`bootstrap/docs/OWNERSHIP.md`** — Scope contract § 직후 "Spec verification (context7) §" sub-§ 추가 (1줄 cross-ref + smoke 명시)
- **`bootstrap/docs/SKILLS.md`** — §1 매트릭스 3 skill → **4 skill** (harness-plan-verify 행 추가, "v1.24" 도입)
- **`CLAUDE.md`** — 관련 문서 § 1줄 cross-ref + SKILLS.md "4 skill" 표기 갱신
- **`tests/smoke-bash-permission-pattern.sh`** — FILES 배열에 `bootstrap/skills/harness-plan-verify/SKILL.md` 추가 → 4 → 5 파일
- **`verify.{ps1,sh}`** — `$frontmatterFiles` / `FRONTMATTER_FILES` 양쪽에 동상 1줄 추가 → 13 → 14 파일 (Stage I 6축 검증 자동 포함)

## 판정

| 성공 기준 | 결과 |
|-----------|------|
| `bootstrap/skills/harness-plan-verify/SKILL.md` 존재 + frontmatter 6축 정합 | ✅ |
| `bootstrap/docs/SPEC_VERIFICATION.md` 존재 + 10 § + Context7 source matrix | ✅ |
| `tests/smoke-spec-verification.sh` 5/5 PASS — v1.24 self-test | ✅ (11/11) |
| `tests/smoke-scope-contract.sh` v1.24 glob 자동 흡수 PASS | ✅ (46/46) |
| `claude/commands/harness-meta.md` PLAN § list 갱신 | ✅ |
| `bootstrap/docs/OWNERSHIP.md` Scope contract 직후 cross-ref | ✅ |
| `bootstrap/docs/SKILLS.md` §1 매트릭스 4번째 행 추가 | ✅ |
| `CLAUDE.md` 관련 문서 cross-ref | ✅ |
| `tests/smoke-bash-permission-pattern.sh` FILES + 6/6 PASS | ✅ |
| `verify.{ps1,sh}` `$frontmatterFiles` + Stage I 5/5 PASS | ✅ (38/38) |
| 회귀 0 (기존 smoke 7건 + verify.ps1) | ✅ |
| context7 검증 (`/websites/code_claude` C1~C6) | ✅ (drift no) |

## Lessons Learned

### L1 — Self-applying mechanism의 두 번째 사례 (v1.10j 패턴 재사용)

v1.10j Scope contract (§ 의무 + smoke + 위반 정책)에 이어 본 세션이 **같은 패턴 재사용**으로 Spec verification mechanism 도입. 핵심 기법 동일:

1. PLAN § 의무화 (정확 위치 + 정확 형식)
2. 자동 enumerate smoke (`v1.24*/PLAN.md` glob, 향후 세션 자동 흡수)
3. self-test (본 v1.24 PLAN이 첫 입력으로 mechanism 자기 검증)

**핵심 가치**: "validate-once mechanism으로 N건의 미래 PLAN을 보호"하는 ROI 패턴 정형화. 향후 추가 §(예: REPORT § 의무 v1.24d) 도입 시 본 패턴 3번째 적용 예상.

### L2 — context7 검증의 절차화 가치 (수동 → 반자동)

v1.10d/v1.10g/v1.23 audit 시점 모두 수동 patterns였음:

- "context7 query 해야 하나?" 매 PLAN마다 즉흥 판단
- 결과는 PLAN 본문 또는 audit/ 디렉토리 산재 — grep 불가
- "검증 했는가?" 명시화 부재

§ 의무화로 "PLAN이 검증 거쳤는가"가 grep 가능 (`grep -l '^## Spec verification' sessions/meta/v1.24*/PLAN.md`). drift=N/A opt-out 분기로 외부 spec 의존 무 케이스도 명시 표기.

### L3 — Hook vs SKILL trigger trade-off — context7 C3가 결정 보강

PostToolUse hook + file_path 필터 가능하나:

- C3 finding: matcher는 tool name만 (Edit|Write 등). file path 필터는 hook 본문 `tool_input.file_path` 검사 + Claude에 stdin 메시지
- 복잡도 증가 vs description trigger의 단순함
- description trigger의 opportunistic 한계는 사용자 명시 호출(`/harness-plan-verify`) + smoke § 검증 backstop 2단계로 보강

### L4 — D1.1 CRITICAL 발견 — 정밀 분석 ROI

1차 PLAN은 SKILL을 `_base/.claude/skills/`에 배치 (모든 프로젝트 자동 배포). 사용자 "디테일하게 분석해" 요청으로 7차원 22 issue 분석 진행 → D1.1 발견 (메타 전용 SKILL이 모든 프로젝트에 배포되는 scope misuse). 정밀 분석 단계 없었으면 v1.24b 후속 세션에서 재배치 필요했을 결함.

**원칙**: PLAN 작성 후 정밀 분석 단계는 over-engineering 아닌 결함 사전 차단. 본 세션도 "spec verification SKILL"이라는 self-referential 도구 도입이라 더욱 신중 필요.

### L5 — sub-field key 영문화 + locale 호환

1차 PLAN의 `재검증 시점` (한국어) → `re-verify` (영문) 전환. 근거:

- Git Bash on Windows에서 grep + 한국어 패턴은 LC_ALL/UTF-8 의존
- BSD grep / GNU grep 환경별 동작 차이
- sub-field key는 영문 sentinel, 본문은 한국어 자유 — 분리 원칙

향후 § 규격에서 sub-field key 추가 시 영문 통일 의무.

### L6 — bash awk 범위 추출 + extract_cell helper 패턴

§ 구간 추출 시 단순 grep 한계 (전역 매칭으로 false positive). 본 세션 helper 2종:

```bash
extract_section() { awk '/^## Spec verification \(context7\)$/ { in_sec=1; next } in_sec && /^## / { exit } in_sec { print }' "$plan"; }
extract_cell() { echo "$1" | grep -E "^\| \*\*${2}\*\* \|" | head -1 | sed -E 's/^\| \*\*[^*]+\*\* \| (.*) \|.*$/\1/' | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//'; }
```

향후 markdown table 검증 smoke에 재사용 가능 (예: v1.24d REPORT § 검증).

## 다음 후보 (보류)

| 세션 | 조건 |
|------|------|
| `v1.24b-project-plan-verify` | 프로젝트 PLAN(`sessions/<project>/**/PLAN.md`)에도 § 의무 확장. evidence-driven (프로젝트 PLAN이 SKILL/hook spec 의존 사례 누적 후) |
| `v1.24c-source-matrix-expand` | Context7 source matrix 확장 (Anthropic SDK / agents.md / 외부 라이브러리). evidence-driven |
| `v1.24d-report-spec-verification` | REPORT.md에도 § 의무 확장. post-hoc citation drift 사례 누적 후 |
| `v1.D-postoolse-hook` | PostToolUse hook + tool_input.file_path 필터로 deterministic trigger. SKILL trigger 신뢰성 evidence 비교 후 |
| `v1.B-verify-fix-mode` | smoke `--fix` mode (§ skeleton 자동 삽입) |
| `v1.C-precommit-hook` | pre-commit hook으로 smoke-spec-verification 강제 |
| `v1.25-multi-os-validation` | (v1.23 REPORT 다음 후보, 본 세션과 별 도메인이라 v1.24 → v1.25 prefix 변경) verify.sh dynamic 3건 Linux/macOS/WSL 실 검증 |

## 후속 세션 (예정)

- **v1.25-multi-os-validation** — verify.sh dynamic 3건을 Linux/macOS 또는 WSL bash 환경에서 실 검증
- **install-skills 안내 갱신** — 본 SKILL은 글로벌 user-skill이므로 사용자가 `pwsh ~/harness-meta/install-skills.ps1 harness-plan-verify` 또는 `-All`로 활성화 필요. README "글로벌 user-skill 설치" § 안내 갱신은 evidence-driven (사용 패턴 누적 후)
