# v7.0 design 본문

본 file = `v7-redesign.md` 안 의존 관계 결정 결과 기반 v7.0 design 본문. 별 file 분리 (사용자 결정 2026-05-25).

## meta

- 거주: root (gitignored, `v7-redesign.md` 와 동일 본질 — root 진행 + self-referential 회피 본질 정합)
- 정합 source: `v7-redesign.md` (결정 진행 본질 + carry-over)
- audit trail: 작업 중 = 본 file (gitignored scratch) / **최종 = v7.0 milestone INTENT·DESIGN (git tracked)**. "file 거주 자체가 audit trail" 주장 폐기 — gitignored = 삭제 시 흔적 0 (모순). 검토 round 2026-05-25 정정.
- 진입 순서 (T2.1 폐기 후): Tier 0 (T1.6 / T1.1) → Tier 1 (T1.5) → Tier 2 (T1.3+T2.3) → Tier 3 (T1.2) → Tier 1.5 (T1.6b 자연 흡수)

## 검토 round 정정 결과 (2026-05-25)

본 design 본문은 검토 round (사용자 + Claude, 2026-05-25) 에서 **13 건 정정 확정**. 아래 항목이 본 문서의 권위 source — 이하 본문 narrative 와 충돌 시 본 섹션 우선.

1. **T2.1 완전 폐기** — "milestone 디스크 거주 = 컨텍스트 부하" 전제 거짓 (milestone 은 on-demand Read, always-load 아님 — CLAUDE.md + ROADMAP.md 만 자동 로드, 본 세션 직접 검증). 진짜 부하 = ROADMAP `next_candidates` ~30 건 (T1.2 담당). 추가로 `git rm` 시 `/propose-next` (`propose_next.py:109` 최근 5 milestone enumerate) 와 충돌. → milestone 디스크 유지, T2.1 mechanism 삭제.
2. **T1.5 repo-local** — plugin manifest 에 `settings` 필드 부재 (context7 verify) → plugin 배포 불가. `.claude/settings.json` (repo-local), T1.1 과 일관. Auto-Mode spec 자체는 실재 ✓. "v2.1.33+" 버전 표기 정정 (docs = 주차 표기 "2026-w13").
3. **T1.1 repo-local** — plugin manifest 에 `rules` 필드 부재 → harness-meta repo 전용. `.claude/rules/` spec 실재 ✓. MEMORY archival **4 건만** (audit fact-hallucination 1 건 = cross-project 일반 원칙 → MEMORY 유지, 3-way 직교 정합). MEMORY.md index 17→13.
4. **T1.6 hook 재설계** — SessionStart hook 은 system reminder 파싱 불가 (hook = 출력 전용). hook = `claude --version` stdout 주입만, log file 기록 = Claude/version-tracker 단독 (단일 writer → 경합 제거 + churn 제거). SessionStart/SubagentStop/TaskCompleted hook 자체는 실재 ✓.
5. **T1.3 순차 통합** — subagent 중첩 불가 (design-review tools = read-only, Agent 부재). 1 subagent 가 N 관점 **순차 통합** 검토 ("parallel" 표현 정정). 진짜 정정 대상 = `claude/commands/harness-meta.md:194-208` (smoke 아님 — smoke 에 5관점 검증 logic 부재). 현 commands 에 이미 3~5 가변 표 존재 → "신규 N+ 가변" 아니라 "기존 가변 확장 + scope 안/외 분리".
6. **T1.2 적용점 = slash 설명서** — `propose_next.py` 에 lessons enumerate logic 부재 (count only, `grep_lessons_p2` = `len`). 폐지 대상 = `/propose-next` 설명서 (`skills/propose-next` + `claude/commands/`) + 메인 Claude 지침. script 는 `lessons_p2_count` 통계 출력만 (후보 source 로 안 씀).
7. **도그푸드 = 설치만** — v7.0 은 6 mechanism 설치만, 자기 적용 (도그푸드 cycle 1차) 폐기. 첫 사용 = v7.1 (과거 commit `57a01ed` v7 full rollback 위험 격리).
8. **SCOPE_OUT_NOTES 조건부** — SUB_MILESTONES 선례 (v6.2~v6.22 21 milestone 생략) 정합. 거명 있을 때만 생성, skeleton = 선택 섹션 (고정 10 H2 아님).
9. **부수 정정** — 3-way 직교 새 § = **§ 9** (§ 8 "관련 문서" 이미 사용, design "§ 8" 추정 틀림). MILESTONE.md skeleton = **4~5 곳 분산** (ARCH §6.1 L233 + commands L113 + stage skills + CLAUDE.md). SessionStart hook 등록 = `hooks.json` (plugin.json 불변). agents = root `./agents/` 자동 discovery (plugin.json 불변). smoke 5관점 정정 + propose script lessons 정정 = **헛작업, 삭제**. "본질" 남용 정리.
10. **phase 6 개** (T2.1 폐기로 phase-1 제거).

> EXECUTE-time 결정 (지금 확정 안 함): T2.3 max count (작업 크기 봐서 RESEARCH 진입 때) / T1.2 33 entry 폐기 (design 에 사용자 명시 게이트 존재, 폐기 순간 목록 보며).

## Tier 0 (3 parallel base)

### T2.1 (milestone 산출물 거주 mechanism 변경)

> **🛑 폐기 (검토 round 2026-05-25 — 정정 #1 참조)** — milestone 디스크 거주는 컨텍스트 부하가 아님 (on-demand Read, always-load 아님). 진짜 부하 = ROADMAP next_candidates. `git rm` 은 `/propose-next` (propose_next.py:109) 와 충돌. **T2.1 mechanism 전체 삭제 + milestone 디스크 유지.** 이하 본문은 historical 보존 (적용 안 함).

**title 정확화** (사용자 의문 trigger, 2026-05-25): "폐지" 표현 mismatch 인정 → "milestone 산출물 거주 mechanism 변경" 정확화. milestone 본질 자체 보존 + 거주 위치 logic 만 변경.

#### 결정 본질

| 본질 | 결정 |
|---|---|
| 디스크 거주 | 진행 중 1건만 (`projects/meta/milestones/v{X.Y}/`) |
| 완료 후 | GitHub Releases 본문 안 migration → 디스크 디렉토리 제거 |
| 기존 28+40 보존 | 디스크 보존 (점진적, v7.0+ 신규만 새 본질) |
| v7.0 자체 산출물 | root 자유 형식 유지 (`v7-redesign.md` + `v7-design.md`, self-referential 회피) |
| file structure | MILESTONE.md + execute/phase-{n}.md 분리 보존 (현 본질) |
| 중복 narrative | 제거 — 책임 분리 정확화 (phase-{n}.md = changes/verification JSON + minimal narrative / MILESTONE.md ## EXECUTE = 요약 narrative 만) |

#### 중복 본질 evidence (책임 분리 trigger source)

| milestone | MILESTONE.md | execute/ total | 통합 추정 | 증가율 |
|---|:-:|:-:|:-:|:-:|
| v6.23 (1-phase) | 384 | 48 | ~430 | +12% |
| v6.20 (3-phase) | 681 | 224 | ~905 | +33% |

중복 본질 = lightweight 1-phase + multi-phase 모두 일반적. evidence 위치:

- "agents/audit-orchestrator.md 신규 ~140 LOC" = MILESTONE.md ## EXECUTE.Spec.summary + Narrative + phase-1.md Spec.scope + Narrative (4 위치 거의 동일)
- "ext_2 transitive 비적용 hardcode" = 4 위치 거의 동일
- "단일 host 본질" = 2 위치 정확 동일

→ MILESTONE.md ## EXECUTE.Narrative + phase-{n}.md Narrative 안 narrative 본질 중복 자연 발생.

#### 책임 분리 정확화 mechanism

| file | 본질 |
|---|---|
| **MILESTONE.md ## EXECUTE** | 요약 narrative 만 (phase 단위 = phase id + status + commit SHA + 1 sentence summary) |
| **phase-{n}.md** | changes/verification JSON 본질 + minimal narrative (mechanical detail — path 단위 changes + method 단위 verification + commit metadata) |

중복 본질 자연 제거 = 두 file 안 본질 본질 단일 (narrative repetition 부재).

#### mechanism 본질 (현재 vs T2.1 후)

| 본질 | 현재 (누적) | T2.1 후 (1건만 + Releases) |
|---|---|---|
| 거주 위치 | `projects/meta/milestones/v{X.Y}/` (모든 milestone 누적) | 진행 중 1건만 + 완료 시 Releases body 안 migration |
| 디스크 milestone 수 | 28 active + 40 _archive/ | 1 (진행 중) + 28+40 (점진적 보존) |
| Claude 컨텍스트 부하 | 모든 milestone 산출물 검색 가능 (누적 부하) | 진행 중 1건 한정 (~430~900 lines ≈ 30KB) |
| 완료 milestone 접근 | 디스크 직접 (`Read milestones/v{X.Y}/MILESTONE.md`) | GitHub Releases body 또는 git tag SHA 안 milestone 디렉토리 (`git show v{X.Y}:projects/meta/milestones/v{X.Y}/MILESTONE.md`) |

#### GitHub Releases migration mechanism (v6.19 정합 확장)

v6.19 mechanism (commit msg marker `[release:v{X.Y}]` → workflow trigger → ## REPORT 섹션 추출 → `gh release create --notes-file`) 본질 보존 + T2.1 확장:

- **확장 본질** = MILESTONE.md 전체 본문 + execute/phase-{n}.md 본문 통합 → Releases body 안 migration (REPORT 섹션 한정 → 전체 본문)
- **workflow yaml 변경 의무** = ## REPORT 섹션 추출 → MILESTONE.md 전체 + execute/ 본문 통합 (awk filter 본질 변경)
- **디스크 milestone 디렉토리 제거** = workflow 안 자동 `git rm -r projects/meta/milestones/v{X.Y}/` (release publish 후, 사용자 명시 결정 게이트 본질 정합 — commit marker = 사용자 명시)
- **사용자 통제 본질** = commit msg marker `[release:v{X.Y}]` 작성 자체 = 명시 결정 게이트 (memory `커밋·배포 전 확인 요청` 직접 정합)

#### audit trail mechanism

- **진행 중** = file 직접 (디스크 거주)
- **완료 후** = GitHub Releases body + git tag SHA + (역사적) git log
- **검색 본질** = git tag 안 SHA reference 직접 본질 (`git show v{X.Y}:path`) — 디스크 제거 후도 git history 안 보존

#### 본질 미해소 (다음 round trigger)

- workflow yaml 안 자동 `git rm -r` 본질 안 사용자 명시 결정 게이트 강화 본질 — release publish 전 dry-run + 사용자 명시 확인 mechanism (`workflow_dispatch` input 활용)
- migration 시 image/binary file 본질 처리 (현 본질 부재 — markdown only)
- legacy era (v3.0~v6.1 9-stage-bundled) milestones.md 본질 안 migration 적용 본질 (점진적 vs 일괄)

### T1.6 (버전 추적 mechanism — 단계 a)

> **⚠️ 정정 #4** — SessionStart hook 은 system reminder 파싱 불가 (출력 전용). hook = `claude --version` stdout 주입만, log 기록 = Claude/version-tracker **단일 writer** (경합 + churn 제거). 이하 "hook 이 system reminder 파싱 + log overwrite/append" mechanism 폐기.

#### 결정 본질

| 본질 | 결정 |
|---|---|
| 검출 정보 | (B) full — Claude Code version + 사용 가능 기능 매핑 (Auto-Mode / `.claude/rules/` / Hook / Extended Thinking / Background / `/ultrareview` 등) |
| 책임 분리 | SessionStart hook (자동 검출, system reminder source) + version-tracker subagent (사용자 명시 trigger, context7 query) |
| 거주 | `projects/meta/claude-code-version-log.md` (meta scope, long-lived 참조 — T2.1 milestone 본질 외, 디스크 보존 자연) |
| 갱신 주기 | 매 session detect + 변경 시만 log update (churn 회피) |
| log format | ## Current state (overwrite) + ## History (entry append) 두 section |
| 2 단계 분리 | a (본 round, mechanism 도입) → b (T1.6b Tier 1.5 후속, subagent 권한 정전화 T1.5 후) |

#### log file 본질 (skeleton)

````markdown
# Claude Code 버전 추적 log

본 file = Claude Code 버전 + 사용 가능 기능 자동 추적 (T1.6 mechanism source).

## Current state

- **Claude Code version**: v{X.Y.Z} (last updated: 2026-MM-DD)
- **사용 가능 기능 매트릭스**:
  - Auto-Mode (v2.1.33+): ✓
  - .claude/rules/ (v2.1.33+): ✓
  - Hook (TaskCompleted/SubagentStop) (v2.1.33+): ✓
  - Extended Thinking (v2.1.100+): ✓
  - Background sessions (/bg) (v2.1.139+): ✓
  - /ultrareview (v2.1.111+): ✓
  - ... (전수 매트릭스)

## History

### 2026-MM-DD — v{X.Y.Z} → v{X.Y.Z'}

- 변경 = Auto-Mode (신규 ✓) / Background sessions (신규 ✓) / ...
- detect source = SessionStart hook + system reminder

### 2026-MM-DD — initial entry

- version = v{X.Y.Z}
- 사용 가능 기능 = (전수 매트릭스)
````

#### SessionStart hook 본질

scope = 자동 검출 + 매 session 1회 호출.

mechanism:

1. SessionStart hook trigger (Claude Code v2.1.33+ event)
2. system reminder 파싱 = bundled skills list + agent type list 추출 (system reminder 안 매 session 자동 inject 본질 정합)
3. `claude-code-version-log.md` ## Current state hash compare = 변경 detect
4. 변경 시 = ## Current state overwrite + ## History entry append
5. 변경 부재 = no-op (log churn 회피)

위치 = `claude/hooks/session-start-version-track.sh` (자연 채택, `claude/hooks/` 글로벌 hook 본질 정합).

#### version-tracker subagent 본질

scope = 사용자 명시 trigger 시 추가 기능 조사 (context7 query — Claude Code docs).

mechanism:

1. 사용자 trigger = "버전 추적 추가 조사" / "Claude Code 신기능 조사" 자연어 명시
2. subagent invoke = context7 query Claude Code docs (recent version + 신기능 + plugin matrix)
3. log file update = ## Current state 보강 + ## History entry append (manual trigger 본질 명시)

위치 = `agents/version-tracker.md` (자연 채택, plugin paths `./agents/` default discovery 본질 정합).

frontmatter draft:

```yaml
---
name: version-tracker
description: Claude Code 버전 추적 추가 조사 — 사용자 명시 trigger 시 context7 query Claude Code docs (recent version + 신기능 + plugin matrix) 후 projects/meta/claude-code-version-log.md update. SessionStart hook 자동 검출 (system reminder source) 보강 본질.
tools: mcp__plugin_context7_context7__resolve-library-id, mcp__plugin_context7_context7__query-docs, Read, Edit
model: opus
---
```

#### 2 단계 분리 본질

- **a 단계 (본 round, Tier 0)**: mechanism 도입 (hook + subagent 본질 작성, 권한 정전화 부재 — 기본 frontmatter tools)
- **b 단계 (T1.6b, Tier 1.5 후속)**: version-tracker subagent 권한 정전화 (T1.5 Auto-Mode + 최소권한 결과 활용)

T1.5 안 subagent 권한 정전화 mechanism 도입 후 본 subagent 자연 정합 = b 단계 진입 trigger.

#### 활용 본질 (T1.5 / T1.1 안)

- **T1.5 (Auto-Mode + 최소권한)** = v2.1.33+ 전제 검출 source 자동 활용 → Auto-Mode 사용 가능 여부 자동 판단
- **T1.1 (`.claude/rules/`)** = v2.1.33+ 전제 검출 source 자동 활용 → `.claude/rules/` 사용 가능 여부 자동 판단

#### 본질 미해소 (다음 round trigger)

- SessionStart hook 안 system reminder 파싱 mechanism 본질 (정확 regex + edge case 처리)
- log file 안 ## Current state 매트릭스 본질 수동 갱신 vs 자동 갱신 trade-off (Claude Code 신기능 발견 시 어떻게 매트릭스 row append?)
- T1.6 b 단계 (subagent 권한 정전화) 본질 = T1.5 후속 결정 의존

### T1.1 (`.claude/rules/` + MEMORY archival 5건)

> **⚠️ 정정 #3** — spec 실재 ✓, 단 repo-local (plugin manifest 에 `rules` 필드 부재 → 배포 불가). MEMORY archival = **4 건만** (audit fact-hallucination 은 cross-project 일반 원칙 → MEMORY 유지, 3-way 직교 정합). index 17→13. 새 3-way 직교 § = **§ 9** (§ 8 이미 사용).

#### 결정 본질

| 본질 | 결정 |
|---|---|
| `.claude/rules/` file 구성 | 본질 묶음 3 file (schema-discipline.md / subagent-fact-verification.md / candidate-draft-schema.md) — 5 후보 본질 3 분류 자연 |
| MEMORY 처리 | 완전 archive (5 entry file 삭제 + MEMORY.md index entry 5 row 제거) — 단일 source 본질 |
| 3-way 정전화 위치 | ARCHITECTURE.md 안 새 § (long-lived 1차 source) + `.claude/rules/README.md` (operational index) + CLAUDE.md § 구조 규칙 안 1 줄 (entry pointer) |
| paths frontmatter 정밀도 | 본질별 path glob 정확 분리 (e.g., APPROVE.md = `projects/*/milestones/**/APPROVE.md`, cascade marker = `**/*.md` 전역, subagent fact-verification = `**` universal) |
| MEMORY.md index 사후 | 17 → 12 entry (5 entry 제거, narrative 추가 부재 — 단일 source 본질 정합) |

#### 5 archival 후보 본질 3 분류 매트릭스

| # | 후보 | 본질 분류 | 1차 source 위치 |
|:-:|---|:-:|---|
| 1 | `feedback_approve_md_schema_wrap` | schema | `.claude/rules/schema-discipline.md` (## APPROVE.md) |
| 2 | `feedback_intent_md_schema_required` | schema | `.claude/rules/schema-discipline.md` (## INTENT.md) |
| 3 | `feedback_cascade_marker_placeholder_avoidance` | schema | `.claude/rules/schema-discipline.md` (## cascade marker) |
| 4 | `feedback_subagent_fact_hallucination_correction` | audit | `.claude/rules/subagent-fact-verification.md` |
| 5 | `feedback_candidate_draft_decision_pending_string` | smoke | `.claude/rules/candidate-draft-schema.md` |

본질 묶음 정합 = schema 3건 (milestone 산출물 + marker 작성 시 의무 필드 패턴) 단일 file 통합, audit/smoke 본질 = 책임 분리 단일 file. 5 → 3 file 본질 압축 = path-scoped lazy load 본질 정합 + Claude 컨텍스트 부하 최소화.

#### `.claude/rules/` 3 file 본질 (skeleton)

**1. `schema-discipline.md`** (3 schema 본질 통합)

````markdown
---
description: harness-meta milestone 산출물 + cascade marker 안 schema 의무 필드 — APPROVE.md approval wrap / INTENT.md id+title / cascade marker 16-hex dummy
paths:
  - "projects/*/milestones/**/APPROVE.md"
  - "projects/*/milestones/**/INTENT.md"
  - "**/*.md"  # cascade marker (CLAUDE.md / ARCHITECTURE.md / 기타 narrative)
---

## APPROVE.md — approval 객체 wrap 의무

`approved_by` / `date` / `approval_summary` 3 필드 = `approval` 객체 안 wrap (top-level 직접 금지). smoke-spec-verification Stage 5 강제. 정확 schema 예시 = `projects/meta/milestones/v5.7/APPROVE.md`.

## INTENT.md — id + title 필드 의무

top-level 안 `id: "v{X.Y}_{slug}"` (9-stage-bundled era v3.0+ — `v{X.Y}_{group-slug}`) + `title: "..."` (ROADMAP entry title 정합) 두 필드 항상 포함. smoke-spec-verification 강제.

## cascade marker — 16-hex dummy 의무

신규 cascade marker (`<!-- cascade-source: <path>#<anchor> expected-hash:<hash> -->`) 작성 시 hash 값 = **16-hex dummy** (`0000000000000000`) 사용. cascade_sync.py regex `expected-hash:[0-9a-f]{16}` 매칭 정합. PLACEHOLDER 영문 사용 시 silent skip → drift detect 무력화.
````

**2. `subagent-fact-verification.md`** (audit 본질)

````markdown
---
description: Agent tool 호출 후 산출 안 외부 1차 source fact 인용 시 메인 Claude 직접 매핑 검증 의무 — hallucination 누적 cycle 10+ evidence
paths:
  - "**"  # universal
---

# subagent 산출 fact 인용 hallucination 검증 의무

Agent tool 호출 후 산출 안 (1) 외부 파일/fact 1차 인용 시 → 메인 Claude 가 1차 source 직접 Read + 매핑 검증 / (2) 산출이 "요약" 또는 "텍스트 반환" 형식이고 detail 부재 시 → 의심 신호 / (3) hallucination 발견 시 = synthesizer 임시 overwrite (v5.10 cycle 1) 또는 agent 직접 산출 inline 정정 archive (v5.11 cycle 2+).

cycle 10+ 누적 evidence — v5.10~v5.17 (subagent 산출 fact 인용 한정) + v6.15 (self-RESEARCH 자체 fact 인용 확장). 절차 정전화 = v5.13 (1차 3-layer WHAT/WHERE/HOW) + v5.18 (2차 agent `## Input Verification` H2 + 검증 method 분리 boolean/표/수치).

검증 method 분리 (v5.18 정전화):
- **boolean fact** (e.g., file exists?) → 직접 Read 또는 Glob/Grep 검증
- **표 fact** (e.g., agent fleet 매트릭스) → 1차 source 표 row 직접 매핑
- **수치 fact** (e.g., LOC count) → grep + wc 직접 측정 또는 git log SHA reference
````

**3. `candidate-draft-schema.md`** (smoke 본질)

````markdown
---
description: ROADMAP candidate_draft[] decision_pending 필드 = string non-empty 본질 (boolean 아님) — smoke-candidate-draft-schema 강제
paths:
  - "projects/*/ROADMAP.md"
---

# candidate_draft[] decision_pending = string non-empty

ROADMAP `candidate_draft[]` entry 안 `decision_pending` 값 = **string 본질** (e.g., `"pending"` / `"approved"` / `"rejected"`). boolean 아님. tests/smoke-candidate-draft-schema.sh line 137 `isinstance(dp, str) or not dp.strip()` 강제.

v6.22 evidence — /propose-next 평가 도중 `"decision_pending": true` (boolean) 작성 → smoke FAIL=2 "decision_pending 빈 문자열" detect → `"pending"` string 정정 후 PASS.
````

#### `.claude/rules/README.md` 본질 (skeleton)

````markdown
# .claude/rules/ — operational index

본 디렉토리 = harness-meta path-scoped rule 본질 (Claude Code v2.1.33+ `.claude/rules/` mechanism). CLAUDE.md (always-loaded entry) ↔ `.claude/rules/` (path-scoped mechanical rule) ↔ MEMORY (cross-session personal preference) **3-way 책임 직교** — 1차 source = ARCHITECTURE.md § N.

## 3 rule file

| file | scope (paths) | 본질 |
|---|---|---|
| schema-discipline.md | `projects/*/milestones/**/APPROVE.md` + `projects/*/milestones/**/INTENT.md` + `**/*.md` (cascade marker) | milestone 산출물 + cascade marker schema 의무 |
| subagent-fact-verification.md | `**` (universal) | Agent tool 호출 후 fact 인용 검증 의무 |
| candidate-draft-schema.md | `projects/*/ROADMAP.md` | candidate_draft[] decision_pending = string 본질 |
````

#### ARCHITECTURE.md 안 새 § 본질 (skeleton, 정확 § 번호는 EXECUTE 시 결정)

````markdown
## § N — 3-way responsibility orthogonality (CLAUDE.md / .claude/rules/ / MEMORY)

Claude Code v2.1.33+ 환경 안 컨텍스트 본질 3 분류 책임 직교:

| 본질 | 거주 | load 시점 | 책임 |
|---|---|---|---|
| **CLAUDE.md** | repo root + subdirectory | always-loaded (CWD 안 자동) | entry pointer + 구조 규칙 + 진입 narrative |
| **.claude/rules/** | `.claude/rules/*.md` | path-scoped (frontmatter `paths:` glob 매칭 시) | mechanical rule (schema 의무 / 검증 의무 / smoke 정합) |
| **MEMORY** | `~/.claude/projects/<encoded>/memory/` | cross-session (memory tool inject) | personal preference (사용자 협업 스타일 / feedback / project state) |

### 책임 직교 본질

- **CLAUDE.md** = 진입 narrative + 구조 규칙 + entry pointer (.claude/rules/ + MEMORY 본질 명시). always-loaded 본질 정합 — 본질 정전화 한정.
- **.claude/rules/** = 특정 path 작업 시만 자동 inject. lazy load 본질 정합 — Claude 컨텍스트 부하 최소화. mechanical rule (schema 의무 등) 자연 거주.
- **MEMORY** = 사용자 협업 본질 (선호도 / 과거 결정 / project state). cross-session personal 본질 정합 — repo 안 거주 부재 (개인 환경 단독).

### archival 본질 (v7.0 T1.1 도입)

기존 MEMORY 안 mechanical rule 본질 (schema 의무 + audit 의무 + smoke 정합) 5 entry = `.claude/rules/` 안 archival (단일 source 본질). MEMORY = personal preference 본질 한정 유지.
````

#### MEMORY.md index 사후 본질 (17 → 12 entry)

5 entry 제거 후 MEMORY.md index = 12 entry. 추가 narrative 부재 — 단일 source 본질 정합 (MEMORY 안 cross-reference `.claude/rules/` 추가 시 책임 직교 위배).

제거 5 entry (현 MEMORY.md row):

```
- [APPROVE.md schema 안 approval 객체 wrap 의무](feedback_approve_md_schema_wrap.md) — ...
- [INTENT.md schema 안 id + title 필드 의무](feedback_intent_md_schema_required.md) — ...
- [cascade marker PLACEHOLDER 회피](feedback_cascade_marker_placeholder_avoidance.md) — ...
- [subagent fact 인용 hallucination 검증 의무](feedback_subagent_fact_hallucination_correction.md) — ...
- [candidate_draft decision_pending = string non-empty](feedback_candidate_draft_decision_pending_string.md) — ...
```

memory file 5건 (`feedback_approve_md_schema_wrap.md` 등) = 동시 삭제 (단일 source 본질 정합).

#### adoption mechanism (T1.1 EXECUTE 안 적용 순서)

1. **ARCHITECTURE.md § N 추가** (long-lived 1차 source 정전화 우선)
2. **`.claude/rules/` 디렉토리 + 3 file 작성** (mechanism source 거주)
3. **`.claude/rules/README.md` 작성** (operational index)
4. **CLAUDE.md § 구조 규칙 안 1 줄 추가** (entry pointer)
5. **MEMORY 5 entry archive** (file 5건 삭제 + MEMORY.md index 5 row 제거)
6. **smoke 본질 검증** (기존 smoke-spec-verification / smoke-candidate-draft-schema 기능 유지 — `.claude/rules/` 본질은 Claude Code session 안 path-scoped inject 본질, smoke 와 직교)

#### 본질 미해소 (다음 round trigger)

- ARCHITECTURE.md § N 정확 § 번호 결정 (현 § 7 AI Native 후 § 8? 또는 § 4 끝 매트릭스 row 추가?)
- `.claude/rules/` 본질 Claude Code session 안 path-scoped inject 본질 실 검증 mechanism (smoke 본질 부재 — v2.1.33+ runtime 본질, 사용자 실 session 안 확인 필요)
- 기존 MEMORY 안 12 entry 본질 안 추가 archival 후보 본질 (예: `feedback_section_6_2_abolished` = workflow 본질, `.claude/rules/` 후보 vs MEMORY 유지)
- T1.1 후 신규 mechanical rule 발생 시 `.claude/rules/` 자연 거주 vs MEMORY 임시 거주 → archive 본질 (운영 본질 정전화 후속)

## Tier 1

### T1.5 (Auto-Mode + 3 subagent 권한 정전화)

> **⚠️ 정정 #2** — Auto-Mode spec 실재 ✓ (context7 verify), 단 plugin 배포 불가 (manifest 에 `settings` 필드 부재) → `.claude/settings.json` **repo-local** (T1.1 과 일관). "v2.1.33+" 표기 → "2026-w13" 주차 표기 정정.

#### 결정 본질

| 본질 | 결정 |
|---|---|
| scope | mechanism 정의 + 3 신규/활용 subagent 한정 (기존 9 subagent 대상 외 — 이미 minimal tools) |
| Auto-Mode 본질 | settings.json `autoMode` config (environment/allow/soft_deny/hard_deny 4 분류) + `permissions.defaultMode: "auto"` (Claude Code v2.1.33+ 공식 spec) |
| 3 subagent 매핑 | (a) review subagent (T1.3 신규, Tier 2) → frontmatter `tools:` read-only + Auto-Mode allow / (b) Explore (built-in, T2.3 활용) → settings.json `autoMode.environment` 안 명시 / (c) version-tracker (T1.6a 신규, T1.6b 안 정전화) → frontmatter `tools:` minimal + Auto-Mode allow |
| settings.json 거주 | `~/.claude/settings.json` (user-level, harness-meta repo 외 — `.claude/settings.local.json` 안 거주 자연) 또는 `.claude/settings.json` (project-level, harness-meta repo 안 거주). harness-meta = 공유 본질 → repo 안 `claude/settings.json` template 거주 + 사용자 install 시 `.claude-plugin/plugin.json` paths 안 자동 인식 |
| frontmatter pattern | `tools:` allowlist 최소 (read-only / specific write) + `model:` 명시 + Auto-Mode 정합 본질 자연 inherit (frontmatter 안 Auto-Mode 직접 지정 부재 — settings.json 안 정전화) |
| 책임 분리 | T1.5 = mechanism source-of-truth 단일 책임 (settings.json template + frontmatter pattern + Auto-Mode 4 분류 본질 정의) / 실 적용 = T1.3 (review) + T2.3 (Explore) + T1.6b (version-tracker) 안 각자 |

#### Claude Code Auto-Mode 공식 spec 본질 (context7 source)

context7 query 결과 (`/websites/code_claude`, 2026-05-25):

| spec | 본질 | 거주 |
|---|---|---|
| `permissions.defaultMode: "auto"` | 매 session 안 permission prompt 자동 분류 (Shift+Tab cycle 불요) | settings.json |
| `autoMode.environment[]` | trusted source control / cloud bucket / internal domain 명시 (LLM classifier 정합도 향상) | settings.json |
| `autoMode.allow[]` | 명시 허용 본질 (e.g., "Writing to s3://acme-scratch/ is allowed: ephemeral bucket") | settings.json |
| `autoMode.soft_deny[]` | 명시 금지 본질 — prompt 발생 (사용자 명시 결정 게이트) | settings.json |
| `autoMode.hard_deny[]` | 절대 금지 본질 — prompt 부재 + 자동 reject | settings.json |
| `$defaults` | built-in rule inherit (omit 시 모든 default 보안 제거 — 위험) | autoMode 4 분류 array 안 |
| PermissionRequest hook | 특정 prompt 자동 승인 (e.g., ExitPlanMode) — JSON decision stdout | settings.json `hooks.PermissionRequest[]` |

#### harness-meta settings.json template 본질 (skeleton)

거주 = `claude/settings.json` (repo 안, plugin paths 자동 인식) — 사용자 install 시 user-level merge 본질 (plugin lifecycle).

````json
{
  "permissions": {
    "defaultMode": "auto"
  },
  "autoMode": {
    "environment": [
      "$defaults",
      "Source control: github.com/pdw96/harness-meta and all branches under it",
      "Trusted local path: $HOME/harness-meta (primary repo)",
      "Trusted project paths: $HOME/<project>/ with .harness.toml present"
    ],
    "allow": [
      "$defaults",
      "Reading any file under harness-meta/ is allowed: read-only audit + design body",
      "Writing to harness-meta/projects/meta/milestones/v{X.Y}/** is allowed: 진행 중 milestone 산출물 (T2.1 정합 — 디스크 거주 1건만)",
      "Writing to harness-meta/.claude/rules/** is allowed: path-scoped rule 본질 (T1.1 정합)",
      "Running scripts/cascade_sync.py and scripts/propose_next.py is allowed: 자동화 mechanism (v6.4+ / v6.5+ 정전화)"
    ],
    "soft_deny": [
      "$defaults",
      "Never modify files under harness-meta/projects/meta/milestones/_archive/**: 역사적 보존 본질 (40 milestone _archive 무결성)",
      "Never modify files under harness-meta/projects/meta/milestones/v{X.Y}/** for completed milestones: 완료 후 GitHub Releases migration 본질 (T2.1 정합)",
      "Never bypass pre-commit hook (--no-verify): 사용자 명시 승인 후만 (CLAUDE.md '개발 프로세스' 정합)"
    ],
    "hard_deny": [
      "$defaults",
      "Never push to harness-meta main without [release:v{X.Y}] marker commit: milestone 완료 본질 정합 (v6.19 정전화)",
      "Never delete files under harness-meta/projects/meta/milestones/_archive/**: 역사적 보존 무결성 절대"
    ]
  }
}
````

#### 3 subagent 권한 정전화 mechanism 본질

**(a) review subagent** (T1.3 안 신규, Tier 2 진입 시 자연 적용)

frontmatter draft (T1.3 안 정확화):

```yaml
---
name: design-review
description: DESIGN.md 산출 후 5 관점 review (spec-drift / security / token-efficiency / consistency / scope-out-archival) — scope 안 검증 집중, scope 외 거명 별 archival (MILESTONE.md ## SCOPE_OUT_NOTES)
tools: Read, Grep, Glob  # read-only 본질 (review = 검증, write 부재)
model: opus  # 5 관점 병렬 검증 본질 → 추론 능력 우선
---
```

Auto-Mode 정합 = settings.json `autoMode.allow` 안 "Reading any file under harness-meta/ is allowed" 본질 inherit. review subagent 안 추가 정전화 부재 (frontmatter tools = read-only → 자동 allow).

**(b) Explore** (built-in, T2.3 안 활용)

설정 = settings.json `autoMode.environment` 안 명시 (trusted path 본질 inherit). frontmatter 본질 부재 (Anthropic 제공 built-in agent).

활용 pattern (T2.3 안 정전화) — RESEARCH stage 안 parallel invoke:

```
Agent(subagent_type: "Explore", prompt: "<분야 A> 본질 codebase 안 거주 + cross-reference 본질 매핑")
Agent(subagent_type: "Explore", prompt: "<분야 B> 본질 codebase 안 거주 + cross-reference 본질 매핑")
Agent(subagent_type: "Explore", prompt: "<분야 C> 본질 codebase 안 거주 + cross-reference 본질 매핑")
```

3+ Explore parallel = RESEARCH.cb (codebase 분야) 매트릭스 자동 채움. Auto-Mode 정합 = read-only 본질 자연 allow.

**(c) version-tracker subagent** (T1.6a 신규, T1.6b 안 정전화)

T1.6a 안 frontmatter draft (v7-design.md L156):

```yaml
---
name: version-tracker
description: Claude Code 버전 추적 추가 조사 — 사용자 명시 trigger 시 context7 query Claude Code docs (recent version + 신기능 + plugin matrix) 후 projects/meta/claude-code-version-log.md update. SessionStart hook 자동 검출 (system reminder source) 보강 본질.
tools: mcp__plugin_context7_context7__resolve-library-id, mcp__plugin_context7_context7__query-docs, Read, Edit
model: opus
---
```

T1.6b 안 권한 정전화 = (1) `tools:` allowlist 검토 — context7 2 tool + Read + Edit 한정 자연 / (2) Auto-Mode `allow` 안 "Writing to projects/meta/claude-code-version-log.md is allowed: 버전 추적 log 단일 file" 명시 추가 / (3) `soft_deny` 안 "Never modify files outside projects/meta/claude-code-version-log.md from version-tracker agent" 명시.

#### frontmatter pattern 정전화 (3 subagent 정합)

| 본질 | review | Explore | version-tracker |
|---|---|---|---|
| frontmatter `tools:` | Read, Grep, Glob (read-only) | (built-in, frontmatter 부재) | context7 2 + Read + Edit (minimal write) |
| `model:` | opus (추론 집중) | (built-in default) | opus (조사 집중) |
| Auto-Mode allow | inherit (read-only 자연) | inherit (read-only 자연) | 명시 (단일 file write) |
| Auto-Mode soft_deny | inherit | inherit | 명시 (다른 file write 금지) |
| settings.json 추가 | 부재 | environment 안 명시 | allow + soft_deny 명시 |

#### adoption mechanism (T1.5 EXECUTE 안 적용 순서)

1. **settings.json template 작성** (`claude/settings.json` 안 거주, plugin paths 자동 인식)
2. **`.claude-plugin/plugin.json` 안 settings paths 추가** (Claude Code plugin spec 정합)
3. **frontmatter pattern 정전화** (3 subagent 적용 pattern table — design body 안 정전화 본질)
4. **Tier 2/Tier 1.5 pre-work 보장** — T1.3 / T2.3 / T1.6b 진입 시 본 mechanism 직접 inherit
5. **ARCHITECTURE.md § 7 (AI Native) 안 cross-ref 추가** — "AI Native § 7.2 자율성 면 = Auto-Mode 정합 본질 (v2.1.33+ 공식 spec 정합, T1.5 정전화)"

#### 책임 분리 정합 본질 (T1.5 ↔ Tier 2 ↔ Tier 1.5)

| Tier | 책임 |
|:-:|---|
| Tier 1 (T1.5) | mechanism source-of-truth 단일 — settings.json template + frontmatter pattern + Auto-Mode 4 분류 본질 정의 |
| Tier 2 (T1.3) | review subagent **신규 작성** + T1.5 mechanism inherit (read-only tools + Auto-Mode allow 자연) |
| Tier 2 (T2.3) | Explore **활용 pattern 정전화** + T1.5 mechanism inherit (settings.json `autoMode.environment` 안 trusted path 본질) |
| Tier 1.5 (T1.6b) | version-tracker **권한 정전화** + T1.5 mechanism 직접 inherit (allow + soft_deny 명시) |

#### 본질 미해소 (다음 round trigger)

- `claude/settings.json` 안 `$defaults` inherit 본질 실 verify (Claude Code 환경 안 `permissions.defaultMode: "auto"` 활성 + 4 분류 default rule 본질 실 동작 확인)
- Auto-Mode classifier (LLM 기반) 정합도 본질 — harness-meta repo 안 적용 시 false positive (soft_deny 잘못된 trigger) 본질 검증 mechanism
- review subagent frontmatter `description` 안 trigger 본질 정밀도 (T1.3 안 결정) — "DESIGN.md 산출 후 5 관점 review" trigger 본질 vs Claude 자동 invoke 본질
- PermissionRequest hook 활용 본질 (T1.5 scope 외 보류 — Tier 3 T3.4 안 자연 흡수 candidate)

## Tier 2 (2 parallel)

### T1.3 (5 관점 review redesign — N+ 가변 + scope 안/외 분리)

> **⚠️ 정정 #5** — subagent 중첩 불가 (design-review = read-only, Agent 부재) → 1 subagent 가 N 관점 **순차 통합** ("parallel" 표현 정정). 진짜 정정 대상 = `commands/harness-meta.md:194-208` (smoke 아님 — smoke 에 5관점 logic 부재, 헛작업 삭제). 현 commands 이미 3~5 가변 표 존재 → "신규" 아니라 "기존 가변 확장 + scope 안/외". SCOPE_OUT_NOTES = 조건부 생성 (#8).

#### 결정 본질

| 본질 | 결정 |
|---|---|
| 관점 count 본질 | **N+ 가변** (5 관점 fixed pattern 폐기) — 작업 본질 매트릭스 안 자연 발현 (3~10 가능) |
| 분야 발현 책임 | **Claude 메인 자동 발현 + 사용자 명시 게이트** — DESIGN.md 작성 완료 직후 Claude (메인) 가 INTENT + DESIGN 자동 분석 → 관련 분야 매트릭스 제안 → AskUserQuestion 게이트 → 사용자 명시 후 review subagent 부릅 |
| scope 안/외 분리 | scope 안 = DESIGN.md 흡수 (현 본질 보존) / scope 외 거명 = **MILESTONE.md ## SCOPE_OUT_NOTES** (신규 H2, 완료 시 T2.1 Releases body 흡수) |
| 현 5 관점 위치 | N+ 매트릭스 안 default 5 자연 거주 — architecture / spec-drift / 회귀 risk / 보안 / scope contract 본질 보존 + 추가 분야 (token-efficiency / consistency / cascade-drift / 사용자 협업 fit 등) 작업 본질 별 자연 발현 |
| review subagent 본질 | **단일 design-review subagent** (T1.5 안 draft 정전화) + N 분야 parallel invoke pattern — subagent invoke prompt 안 `perspectives:` array 명시 → 각 분야별 검증 결과 통합 산출 |
| breaking change | 신규 v7.0+ milestone 만 본 mechanism 적용 — 기존 28 active milestone DESIGN 5 관점 narrative 자연 보존 (T2.1 정합 — 디스크 보존) |

#### N+ 가변 본질 mechanism (foundational 본질)

**현 본질 한계** (#14 정합 — 5 관점 review 의도 미달):

- 5 = 고정 매트릭스 (architecture / spec / 회귀 / 보안 / scope) → 코드 본질 검증 5 면 자연
- 작은 작업 (≤5 파일) 안 5 관점 = 과잉 검증 (token 부하)
- 큰 작업 (16+ 파일) 안 5 관점 = 부족 검증 (token-efficiency / cascade-drift / consistency 등 분야 명시 부재)
- scope 외 거명 가산 본질 (현 회귀 risk 안 자연 발생) = scope 안/외 분리 부재

**N+ 가변 mechanism 본질**:

- 작업 본질 type 매트릭스 (e.g., schema change → spec-drift + consistency 중심 / new feature → architecture + security 중심 / cascade narrative → cascade-drift + token-efficiency 중심)
- 작업 scope 크기 매트릭스 (작음 ≤5 파일 = 3~5 분야 / 중간 6~15 = 5~7 분야 / 큼 16+ = 7~10 분야)
- 분야 매트릭스 = open-ended (신규 분야 자연 발현 가능 — e.g., v7.x 안 자율성 검증 분야 신규 발현)

#### 분야 발현 mechanism 본질 (workflow 정합)

```
DESIGN.md 작성 완료 (Stage D 종료 직전)
  ↓
Claude 메인 자동 분야 발현 (Step 1):
  1. INTENT.success_criteria 분석 → 의도 정합 분야 매핑
  2. DESIGN.phases 변경 영향 매핑 → 영향 범위 분야 매핑
  3. 작업 본질 type 매트릭스 → type 정합 분야 자동 선택
  4. scope 크기 매트릭스 → count 자동 결정 (가변)
  ↓
관련 분야 매트릭스 제안 (Step 2):
  [
    {perspective: "spec-drift", agent_type: "general-purpose + context7"},
    {perspective: "token-efficiency", agent_type: "Explore"},
    {perspective: "scope contract", agent_type: "Explore"},
    ...
  ]
  ↓
AskUserQuestion 게이트 (Step 3):
  "DESIGN 검증 N 관점 제안 — 이대로 충분? 추가/제거?"
  ↓
사용자 명시 결정 (Step 4):
  - 동일 → 그대로
  - 정정 → 분야 매트릭스 갱신
  ↓
review subagent (design-review) 부릅 (Step 5):
  prompt: perspectives = [...] + DESIGN.md + INTENT.md
  ↓
N 분야 parallel 검증 (subagent 내부):
  각 분야별 검증 결과 + scope 안/외 분리 흡수
  ↓
검증 결과 통합 산출 (Step 6):
  - scope 안 결과 → DESIGN.md 안 흡수
  - scope 외 거명 → MILESTONE.md ## SCOPE_OUT_NOTES 흡수
```

#### scope 안/외 분리 mechanism 본질 (D 옵션 정전화)

| 본질 | scope 안 | scope 외 |
|---|---|---|
| 정의 | INTENT.success_criteria + DESIGN.phases 직접 정합 본질 | scope 본질 외 거명 (관련 본질 / 후속 candidate / 우연 발견) |
| 흡수 위치 | DESIGN.md 안 `review_findings[]` 또는 narrative 자연 흡수 (현 본질 보존) | **MILESTONE.md ## SCOPE_OUT_NOTES** (신규 H2 — v7.0 신규 schema) |
| forward 본질 | EXECUTE stage 안 직접 반영 (scope 안 본질 정합) | PROPOSE stage 안 next_candidates 자연 source (forward propose 책임) |
| 완료 후 본질 | DESIGN.md 본문 보존 → T2.1 Releases body 안 흡수 (전체 본문 migration) | MILESTONE.md ## SCOPE_OUT_NOTES → T2.1 Releases body 안 흡수 (전체 본문 migration) |
| 부산물 cycle 차단 | 검증 결과 EXECUTE 안 자연 반영 — cycle 자연 종료 | 명시 분리 거주 → next_candidates 자동 append 부재 (PROPOSE 안 사용자 명시 결정 게이트 후만 등재) |

**부산물 cycle 차단 본질** (v7-redesign.md L154~164 정합):

- 기존 cycle = review 안 scope 외 거명 → REPORT lessons P2/P3 → next_candidates 자동 append → milestone N+1 안 pick → 또 review 안 거명 → 부산물 재생산 (cycle 무한)
- T1.3 N+ 가변 + scope 안/외 분리 → scope 외 거명 = MILESTONE.md ## SCOPE_OUT_NOTES 거주만 (next_candidates 자동 append 부재) → cycle 자연 종료

#### MILESTONE.md 신규 H2 본질 (## SCOPE_OUT_NOTES)

v6.2+ 9-stage-flattened era 본질 정합 — MILESTONE.md 안 9 H2 섹션 (8 stage + ## SUB_MILESTONES) → **10 H2 섹션** (+ ## SCOPE_OUT_NOTES 신규).

skeleton:

````markdown
## SCOPE_OUT_NOTES

본 milestone scope 외 거명 본질 (T1.3 N+ 가변 review subagent 안 자연 발현). next_candidates 자동 append 부재 — PROPOSE stage 안 사용자 명시 결정 게이트 후만 등재.

### {분야 1} — {거명 본질 요약}

- **거명 본질**: ...
- **scope 외 사유**: 본 milestone INTENT.success_criteria 외 본질
- **forward 본질**: PROPOSE stage 안 사용자 명시 결정 본질 (자동 next_candidates 부재)

### {분야 2} — ...

...
````

#### design-review subagent 본질 (T1.5 draft 정전화)

frontmatter (T1.5 draft 정정 — perspectives parameterized 본질 반영):

```yaml
---
name: design-review
description: DESIGN.md + INTENT.md 산출 후 N+ 가변 분야 review — 메인 Claude 가 perspectives array 명시 후 부릅. 각 분야별 검증 + scope 안/외 분리 결과 통합 산출. read-only 본질 (검증 = write 부재, 결과는 메인 Claude 가 DESIGN.md + MILESTONE.md 안 흡수).
tools: Read, Grep, Glob
model: opus
---
```

prompt template 본질 (메인 Claude 가 invoke 시):

```
DESIGN.md + INTENT.md Read 후 다음 N 분야 review 수행:

perspectives:
  - {perspective_1}: {agent_type 또는 검증 method}
  - {perspective_2}: ...
  ...

각 분야별:
1. scope 안 검증 (INTENT.success_criteria ↔ DESIGN.phases 직접 정합)
2. scope 외 거명 (관련 본질 / 후속 candidate / 우연 발견)

결과 산출:
- scope 안 결과 → review_findings (DESIGN.md 안 흡수 본질)
- scope 외 거명 → scope_out_notes (MILESTONE.md ## SCOPE_OUT_NOTES 흡수 본질)
```

#### adoption mechanism (T1.3 EXECUTE 안 적용 순서)

1. **claude/commands/harness-meta.md § Stage D 안 5 관점 매트릭스 → N+ 가변 mechanism 정전화** (현 L194~210 본질 → 신규 narrative)
2. **agents/design-review.md 신규 작성** (T1.5 draft 정정 본질 정합 — perspectives parameterized)
3. **MILESTONE.md skeleton 안 ## SCOPE_OUT_NOTES 신규 H2 추가** (v6.2+ 9-stage-flattened skeleton 본질 정정)
4. **smoke 본질 정합 검증** — 기존 smoke-spec-verification 안 5 관점 narrative 검증 logic 정정 (가변 본질 자연 정합 — 분야 count 강제 검증 폐기, perspectives array 비어 있지 않음 본질만 검증)
5. **기존 28 active milestone narrative 보존** — 자연 자연 (T2.1 정합 — 디스크 보존 1건만 + 28 보존)
6. **v7.0+ 신규 milestone 본 mechanism 적용** — 첫 적용 = v7.x (본 v7.0 자체 후속 milestone)

#### 본질 미해소 (다음 round trigger)

- 작업 본질 type 매트릭스 정확 분야 매핑 본질 (e.g., schema change → 어떤 분야 자연 발현? new feature → 어떤 분야 자연 발현? 매트릭스 직접 정전화 vs LLM 자율 분류)
- AskUserQuestion 게이트 본질 정밀도 (현 게이트 = max 4 question — N 분야 게이트 안 1 question 안 통합 vs 분야별 1 question 분할)
- MILESTONE.md ## SCOPE_OUT_NOTES 안 분야 매트릭스 정합 본질 (review 분야 ↔ scope 외 거명 분야 1:1 vs N:M)
- design-review subagent 안 N 분야 parallel 본질 mechanism (subagent 내부 Agent tool 안 sub-Explore parallel 가능? 또는 메인 Claude 가 분야별 직접 invoke?)

### T2.3 (RESEARCH Explore 병렬 활용)

#### 결정 본질

| 본질 | 결정 |
|---|---|
| 분야 발현 책임 | **T1.3 pattern inherit 자연** — Claude 메인 자동 발현 + 사용자 명시 게이트 (mechanism 통일성 + 학습 부하 최소) |
| 분야 발현 시점 | **INTENT.md 작성 완료 직후** (Stage B 종료 = Stage C RESEARCH 진입 직전) |
| Explore parallel count | **N+ 가변** (T1.3 정합) — 작업 본질 매트릭스 안 자연 발현 (작음 ≤5 파일 = 2~3 분야 / 중간 6~15 = 3~5 분야 / 큼 16+ = 5~8 분야) |
| Explore prompt template | 분야별 prompt template 본질 (`<분야명> 본질 codebase 안 거주 + cross-reference 본질 매핑`) |
| 결과 흡수 위치 | RESEARCH.md 안 `codebase.{분야명}` 자연 채움 (현 RESEARCH schema 본질 정합 — `codebase` 필드 본질 확장) |
| 책임 분리 | T1.3 = DESIGN stage 안 review subagent (검증) / T2.3 = RESEARCH stage 안 Explore parallel (조사) — 같은 mechanism pattern + 다른 stage + 다른 본질 (검증 vs 조사) |

#### T1.3 pattern symmetry 본질

**같은 mechanism pattern**:

| 본질 | T1.3 (DESIGN review) | T2.3 (RESEARCH cb mapping) |
|---|---|---|
| 시점 | DESIGN.md 작성 완료 직후 (Stage D 종료) | INTENT.md 작성 완료 직후 (Stage B 종료) |
| Claude 메인 자동 분석 source | INTENT.success_criteria + DESIGN.phases | INTENT.goal + INTENT.dependencies |
| 자동 발현 본질 | 검증 관점 매트릭스 (spec-drift / token-efficiency / scope contract 등) | codebase 분야 매트릭스 (agent fleet / smoke fleet / cascade narrative 등) |
| AskUserQuestion 게이트 | "이 N 관점으로 충분? 추가/제거?" | "이 N 분야로 충분? 추가/제거?" |
| 사용자 명시 후 invoke | design-review subagent (perspectives parameterized) | Explore parallel (분야별 sub-invoke) |
| 결과 흡수 | DESIGN.md (scope 안) + MILESTONE.md ## SCOPE_OUT_NOTES (scope 외) | RESEARCH.md 안 codebase.{분야명} |

**다른 본질**:

- T1.3 = **검증** (verification) — 산출 후 본질 정합 확인
- T2.3 = **조사** (investigation) — 진입 전 본질 매핑

#### 분야 발현 mechanism 본질 (workflow 정합)

```
INTENT.md 작성 완료 (Stage B 종료)
  ↓
Claude 메인 자동 cb 분야 발현 (Step 1):
  1. INTENT.goal 분석 → 본 milestone 본질 핵심 keyword 추출
  2. INTENT.dependencies 분석 → 영향 받는 codebase 영역 매핑
  3. 작업 본질 type 매트릭스 → type 정합 cb 분야 자동 선택
  4. scope 크기 매트릭스 → count 자동 결정 (가변)
  ↓
관련 codebase 분야 매트릭스 제안 (Step 2):
  [
    {분야: "agent fleet", path_scope: "agents/**"},
    {분야: "smoke fleet", path_scope: "tests/smoke-*.sh"},
    {분야: "cascade narrative", path_scope: "**/*.md (cascade marker)"},
    ...
  ]
  ↓
AskUserQuestion 게이트 (Step 3):
  "RESEARCH cb 분야 N건 제안 — 이대로 충분? 추가/제거?"
  ↓
사용자 명시 결정 (Step 4):
  - 동일 → 그대로
  - 정정 → 분야 매트릭스 갱신
  ↓
Explore parallel invoke (Step 5):
  Agent(subagent_type: "Explore", prompt: "<분야 1> 본질 codebase 안 거주 + cross-reference 본질 매핑")
  Agent(subagent_type: "Explore", prompt: "<분야 2> ...")
  Agent(subagent_type: "Explore", prompt: "<분야 3> ...")
  ↓
N 분야 parallel 매핑 (Explore subagent 각자):
  각 분야별 codebase 거주 + cross-reference 결과 산출
  ↓
RESEARCH.md 안 codebase.{분야명} 자연 채움 (Step 6):
  메인 Claude 가 N Explore 결과 통합 → RESEARCH.md 안 흡수
```

#### Explore prompt template 본질

각 Explore 부릅 시 prompt template:

```
<분야명> 본질 codebase 안 거주 + cross-reference 본질 매핑.

scope: <path_scope> (e.g., "agents/**", "tests/smoke-*.sh")

매핑 본질:
1. 현 거주 본질 (어떤 file 어떤 책임)
2. cross-reference 본질 (다른 file 안 본 분야 인용 거주)
3. 본 milestone (INTENT 본질) 안 영향 받는 본질 매핑
4. 부산물 발견 본질 (선택적 — scope 외 거명은 별 분리)

search breadth: "medium" (default — 작은 분야 = "quick", 큰 분야 = "very thorough")

결과 산출 = RESEARCH.md codebase.<분야명> 자연 흡수 본질 format.
```

#### RESEARCH.md schema 본질 정합 (codebase 필드 확장)

현 RESEARCH schema (`claude/commands/harness-meta.md` § Stage C 안):

```
RESEARCH.md schema:
  - external (외부 spec)
  - codebase (cb)
  - options
  - risks_identified
```

T2.3 후 codebase 필드 확장:

```json
{
  "codebase": {
    "agent_fleet": {
      "거주": ["agents/audit-orchestrator.md", "agents/version-tracker.md", ...],
      "cross_reference": [...],
      "본_milestone_영향": [...]
    },
    "smoke_fleet": {
      "거주": ["tests/smoke-spec-verification.sh", ...],
      "cross_reference": [...],
      "본_milestone_영향": [...]
    },
    "cascade_narrative": {
      "거주": ["CLAUDE.md", "projects/meta/ARCHITECTURE.md", ...],
      "cross_reference": [...],
      "본_milestone_영향": [...]
    }
  }
}
```

각 분야 = Explore 1번 호출 = codebase.{분야명} 본질 자연 채움.

#### 작업 본질 type 매트릭스 본질 (cb 분야 자동 발현 source)

| 작업 본질 type | 자연 발현 cb 분야 (예시) |
|---|---|
| schema change (smoke 강제 필드 변경) | spec verification logic + 기존 milestone schema 정합 |
| agent fleet 변경 (신규 / 정정) | agent fleet + plugin.json paths + audit-orchestrator allowlist |
| skill 추가/정정 | skills directory + plugin.json skills paths + frontmatter description trigger |
| hook 추가/정정 | hooks directory + hooks.json matcher + PostToolUse 본질 |
| cascade narrative 변경 (ARCHITECTURE / CLAUDE.md) | cascade marker 거주 + cascade_sync logic + cross-ref 매트릭스 |
| workflow stage 변경 | stage skills + commands/harness-meta.md narrative + 28 milestone 본질 적용 |
| .claude/rules/ 추가 (T1.1 정합) | rules directory + paths frontmatter scope + CLAUDE.md entry pointer |
| settings.json 변경 (T1.5 정합) | settings.json + plugin.json paths + Auto-Mode 4 분류 본질 |

작업 본질 type 자체는 Claude 메인 LLM 자율 분류 (INTENT.goal 본질 자연 매핑). 매트릭스 row 추가 = v7.x 안 자연 발현 (lessons P2 흡수 본질).

#### adoption mechanism (T2.3 EXECUTE 안 적용 순서)

1. **claude/commands/harness-meta.md § Stage C 안 RESEARCH cb 분야 매핑 mechanism 정전화** (현 narrative 안 본 mechanism 추가)
2. **RESEARCH.md schema 안 codebase 필드 구조 확장 정전화** (분야별 sub-field 본질)
3. **Explore prompt template 본질 정전화** (메인 Claude 안 invoke pattern source)
4. **작업 본질 type 매트릭스 정전화** — ARCHITECTURE.md 안 새 § 또는 commands/harness-meta.md 안 정전화 (적정 위치 본질 미해소 — 다음 round trigger)
5. **smoke 본질 정합 검증** — 기존 smoke-spec-verification 안 RESEARCH codebase 필드 검증 logic 가변 본질 정합 정정 (분야 매트릭스 비어 있지 않음 본질만 검증)
6. **v7.0+ 신규 milestone 본 mechanism 적용** — 첫 적용 = v7.x (본 v7.0 자체 후속 milestone)

#### 책임 분리 정합 본질 (T1.3 ↔ T2.3)

| Tier 2 | 책임 | 진입 stage | mechanism 본질 |
|:-:|---|:-:|---|
| T1.3 | DESIGN review subagent (검증) | Stage D 종료 직전 | Claude 자동 분야 발현 + 사용자 게이트 + design-review subagent invoke |
| T2.3 | RESEARCH cb Explore parallel (조사) | Stage B 종료 직후 | Claude 자동 분야 발현 + 사용자 게이트 + Explore parallel invoke |

**parallel 본질**: T1.3 = subagent 1번 invoke 안 N 관점 통합 검증 (design-review 안 perspectives parameterized) / T2.3 = Explore subagent N번 parallel invoke (분야별 1:1).

T1.3 안 design-review subagent 안 sub-Explore parallel invoke 가능성 = T1.3 본질 미해소 안 보류 (subagent 안 Agent tool 본질 = Claude Code 실 spec verify 필요).

#### 본질 미해소 (다음 round trigger)

- 작업 본질 type 매트릭스 정확 거주 본질 (ARCHITECTURE.md 안 새 § vs commands/harness-meta.md 안 정전화 vs design body 안 한정 보존)
- Explore parallel invoke count 본질 임계 (N+ 가변이지만 max count 본질 — token 부하 vs 검증 깊이 trade-off)
- RESEARCH.md schema 안 codebase 필드 구조 확장 cascade 본질 (기존 28 active milestone RESEARCH.md 자연 보존 vs migration)
- Explore prompt template 안 search breadth 자동 결정 본질 ("quick" / "medium" / "very thorough" 분야 크기 매핑 매트릭스)

## Tier 3

### T1.2 (next_candidates 절제, T1.3 안 자연 흡수)

> **⚠️ 정정 #6** — `propose_next.py` 에 lessons enumerate logic 부재 (count only, `grep_lessons_p2` = `len`). 폐지 대상 = `/propose-next` 설명서 (`skills/propose-next` + `claude/commands/`) + 메인 Claude 지침 (**script 아님**). script lessons 정정 = 헛작업 삭제. 추가: next_candidates 절제가 컨텍스트 효율 **주역** (T2.1 폐기 후).

#### 결정 본질

| 본질 | 결정 |
|---|---|
| T1.3 안 자연 흡수 | **자연 흡수 본질 확정** — scope 외 거명 자동 candidate 화 폐지 mechanism = T1.3 안 SCOPE_OUT_NOTES 흡수 + next_candidates 자동 append 부재 (T1.3 § '부산물 cycle 차단 본질' 정합) |
| lessons P2/P3 자동 enumerate | **폐지** — REPORT.lessons_learned 안 본질 기록만 유지, next_candidates 자동 append mechanism 제거 |
| 기존 33 entry 처리 | **일괄 폐기** (사용자 명시 결정 게이트 후) — ROADMAP `next_candidates[]` = [] 정정, CHANGELOG 흡수 부재 (임시 본질 — 보존 가치 부재) |
| propose-next mechanism | **보존** (T4.1 정합 — 자율성 면 § 7.2 본질 보존) — `/propose-next` skill + scripts/propose_next.py 본질 유지, ROADMAP 등재 mechanism 만 정정 (자동 append → 사용자 명시 결정 게이트 후만) |
| candidate_draft[] mechanism | **보존** (현 1 entry 자연 보존) — 사용자 명시 결정 후 append 본질 정합 — T1.2 변경 부재 |
| forward-only 본질 | 모든 신규 next_candidates 추가 = 사용자 명시 결정 게이트 후만 (자동 mechanism 폐지) |

#### T1.3 자연 흡수 본질 매트릭스

| 부산물 발생 본질 (현) | T1.3 mechanism (해소) | T1.2 책임 |
|---|---|---|
| review 안 scope 외 거명 → REPORT lessons P2/P3 → next_candidates 자동 append | scope 외 거명 = MILESTONE.md ## SCOPE_OUT_NOTES 거주만 (next_candidates 자동 append 부재) | T1.3 정전화 inherit |
| lessons P2/P3 자동 candidate 화 | REPORT.lessons_learned 안 narrative 기록만 유지 — candidate 자동 enumerate logic 제거 | **T1.2 mechanism 추가** |
| carry-over narrative 연속성 (cycle 자기참조) | scope 외 거명 = 별 거주 본질 → carry-over 자연 종료 | T1.3 정전화 inherit |
| scope 보수성 정책 (작은 milestone 안 큰 candidate enumerate) | N+ 가변 mechanism = scope 자연 정합 (작음 ≤5 = 3~5 분야 / 큼 16+ = 5~10 분야) | T1.3 정전화 inherit |

T1.2 **단독 책임** = lessons P2/P3 자동 enumerate 폐지 mechanism 1건만 (나머지 4건은 T1.3 안 자연 흡수).

#### lessons P2/P3 자동 enumerate 폐지 mechanism 본질

**현 본질** (v7-redesign.md L155~164 정합):

```
milestone N REPORT.lessons_learned 작성
  ↓
lessons 본질 안 P2/P3 분류 (priority hierarchical)
  ↓
lessons P2/P3 자동 enumerate → PROPOSE.next_candidates[] append
  ↓
milestone N+1 INTENT 안 next_candidates 일부 pick
  ↓
scope 외 본질 또 review 안 거명 (부산물 cycle)
```

**T1.2 후 본질**:

```
milestone N REPORT.lessons_learned 작성
  ↓
lessons 본질 narrative 기록 (P2/P3 분류 보존 가능 — lessons 본질 자체 유지)
  ↓
PROPOSE stage 안 next_candidates 발의 본질 = 사용자 명시 결정 게이트만
  - REPORT.lessons_learned 본질 자체 source 가능 (참고)
  - 자동 enumerate logic 폐지
  - 사용자 명시 결정 후만 next_candidates append
  ↓
milestone N+1 INTENT 안 next_candidates pick = forward-only 본질 (자동 cycle 부재)
```

#### REPORT.lessons_learned schema 본질 정합 (변경 부재)

T1.2 = lessons 본질 narrative 기록 보존 — schema 변경 부재. 변경 mechanism:

- **현 (v6.x)**: REPORT.lessons_learned[] 안 `priority: "P0|P1|P2|P3"` 분류 → P2/P3 자동 enumerate logic → PROPOSE.next_candidates[] append
- **T1.2 후 (v7.0+)**: REPORT.lessons_learned[] 안 `priority` 분류 본질 보존 — enumerate logic 부재 (PROPOSE 안 사용자 명시 결정만)

자동 logic 거주 위치 = `scripts/propose_next.py` 안 lessons P2/P3 scan logic (T1.2 안 정정 본질).

#### scripts/propose_next.py 정정 본질

현 mechanism (v6.5+ /propose-next, ARCHITECTURE.md § 4 끝 매트릭스 #9 row 정전화):

```
Step 1: ROADMAP + 최근 5 milestone PROPOSE + lessons P2 자동 종합
Step 2: 다음 milestone candidate 후보 제안
Step 3: 사용자 명시 결정 후 candidate_draft[] append
```

T1.2 후 mechanism:

```
Step 1: ROADMAP + 최근 5 milestone PROPOSE 종합 (lessons P2 자동 종합 폐지)
Step 2: 다음 milestone candidate 후보 제안 (Claude 자율 발의 본질 보존 — 자율성 면 § 7.2)
Step 3: 사용자 명시 결정 후 candidate_draft[] append (현 본질 보존)
```

**핵심 변경** = Step 1 안 `lessons P2 자동 종합` logic 제거. 후보 제안 source = ROADMAP + 최근 5 milestone PROPOSE만 (lessons 본질 직접 source 부재 — 자율성 면 본질 정합).

#### 기존 33 entry 일괄 폐기 mechanism 본질

**EXECUTE 안 sequence**:

```
1. 사용자 명시 결정 게이트 (AskUserQuestion)
   "33 entry 일괄 폐기 의지? (T1.3 mechanism 정전화 후 자동 append 부재 본질 정합)"
   ↓
2. 사용자 명시 "예" 시:
   ROADMAP next_candidates[] = [] 정정
   schema_note 안 narrative 추가 (T1.2 정합 본질 — 자동 append 부재)
   ↓
3. CHANGELOG 흡수 부재 — 임시 본질 (보존 가치 부재)
   audit trail = git history 안 commit SHA reference 보존 (`git log -- projects/meta/ROADMAP.md`)
```

**임시 본질 정합**:

- 33 entry = 부산물 cycle 안 누적된 임시 candidate (보존 가치 부재)
- CHANGELOG = milestone 완료 entry archival 본질 (Keep a Changelog v1.1.0 정합) — candidate 본질 부재
- git history = 본질 audit trail 자연 (commit SHA reference 안 보존)

#### propose-next mechanism 보존 본질 (T4.1 정합)

T4.1 = propose-next mechanism 폐지 폐기 (자율성 면 본질 보존). T1.2 후 mechanism 본질:

| 본질 | propose-next mechanism 보존 |
|---|---|
| 자율성 면 § 7.2 | Claude 자율 candidate 후보 발의 본질 보존 (AI Native 운영 본질 정합) |
| next_candidates[] append mechanism | 자동 append → 사용자 명시 결정 게이트 후만 (forward-only 정합) |
| candidate_draft[] mechanism | 사용자 명시 결정 후 append 본질 보존 (현 mechanism 유지) |
| scripts/propose_next.py 거주 | 유지 — lessons P2 자동 종합 logic 만 제거 |
| /propose-next skill 거주 | 유지 — 본질 narrative 정정 (lessons P2 자동 종합 폐지) |

#### ROADMAP schema 본질 정합 (v5.21+ schema A2 보존)

현 schema (v5.21+ schema A2):

```json
{
  "milestones": [...],          // recent 3 completed + in_progress + deferred
  "next_candidates": [...],     // PROPOSE 발의 후보 — T1.2 후 = 사용자 명시 결정 게이트 후만 append
  "candidate_draft": [...]      // /propose-next 안 사용자 명시 결정 후 append (보존)
}
```

T1.2 후 schema = 변경 부재 (schema 본질 보존 — append mechanism 만 정정).

`schema_note` 안 narrative 추가 (T1.2 정합):
> next_candidates[] append mechanism = 사용자 명시 결정 게이트 후만 (자동 append 부재, v7.0 T1.2 정전화 후). lessons P2/P3 자동 enumerate logic 폐지 — PROPOSE stage 안 사용자 명시 결정만 candidate 본질 source.

#### adoption mechanism (T1.2 EXECUTE 안 적용 순서)

1. **사용자 명시 결정 게이트** — "33 entry 일괄 폐기 의지?" (AskUserQuestion)
2. **ROADMAP next_candidates[] = [] 정정** + schema_note 안 narrative 추가 (T1.2 정합)
3. **scripts/propose_next.py 안 lessons P2 자동 종합 logic 제거** (Step 1 정정)
4. **skills/propose-next/SKILL.md 안 narrative 정정** — lessons P2 자동 종합 폐지 본질 명시
5. **claude/commands/harness-meta.md § Stage I (PROPOSE) 안 narrative 정정** — next_candidates 자동 append mechanism 폐지 본질 명시
6. **ARCHITECTURE.md § 4 끝 매트릭스 #9 row 정정** — propose-next mechanism 본질 (lessons P2 자동 종합 폐지 narrative 추가)
7. **smoke 본질 정합 검증** — 기존 smoke-spec-verification + smoke-candidate-draft-schema 본질 검증 logic 변경 부재 (schema 본질 보존 — smoke 자연 정합)

#### 책임 분리 정합 본질 (T1.3 ↔ T1.2)

| Tier | 책임 |
|:-:|---|
| Tier 2 (T1.3) | review subagent N+ 가변 + scope 안/외 분리 (SCOPE_OUT_NOTES 흡수) + 부산물 cycle 4건 차단 mechanism |
| Tier 3 (T1.2) | lessons P2/P3 자동 enumerate 폐지 mechanism + 기존 33 entry 일괄 폐기 + propose-next mechanism 보존 |

**T1.2 = T1.3 안 자연 흡수 본질** = 4건 자연 차단 + 1건 단독 (lessons P2/P3 자동 enumerate 폐지) + 1건 임시 (33 entry 폐기) + 1건 보존 (propose-next mechanism).

#### 본질 미해소 (다음 round trigger)

- `scripts/propose_next.py` 안 lessons P2 자동 종합 logic 정확 거주 line 본질 (T1.2 EXECUTE 안 정정 시 발견)
- propose-next 발의 source 본질 (lessons 부재 후 ROADMAP + 최근 5 milestone PROPOSE만 — 충분한 source 본질 vs 부족 본질 verify)
- 기존 33 entry 안 의미 있는 entry 본질 매트릭스 (일괄 폐기 결정 후도 사후 정전화 본질 — git history 안 보존 본질 정합)
- candidate_draft[] mechanism 안 decision_pending 본질 정합 (현 `pending` / `approved` / `rejected` string — T1.2 안 변경 부재 vs 사용자 명시 결정 게이트 본질 정정 cascading)

## Tier 1.5 (후속)

### T1.6b (version-tracker subagent 권한 정전화)

#### 결정 본질

| 본질 | 결정 |
|---|---|
| scope | **T1.5 + T1.6a 직접 정전화만** — mechanical application 한정, 신규 본질 부재 |
| settings.json 정정 | Auto-Mode `allow` + `soft_deny` 각 1 row 추가 (version-tracker 한정 명시) |
| frontmatter tools | T1.6a draft 본질 보존 (context7 2 + Read + Edit) — 이미 minimal, 정정 부재 자연 |
| PermissionRequest hook | **보류** (T3.4 정합 — Tier 1.5 scope 외) — 사용자 명시 결정 게이트 본질 (e3 정책) 보존 |
| SessionStart hook ↔ subagent 경합 | 본질 미해소 — 다음 round trigger 안 보류 (T1.6b scope 외) |

#### 직접 정전화 mechanism 본질 (3 step)

**1. settings.json Auto-Mode `allow[]` 안 명시 추가**

T1.5 안 settings.json template (L468~) 정정:

```json
{
  "autoMode": {
    "allow": [
      "$defaults",
      ... (기존 본질 보존) ...
      "Writing to projects/meta/claude-code-version-log.md is allowed: 버전 추적 log 단일 file (T1.6 mechanism source, SessionStart hook + version-tracker subagent 동시 update)"
    ]
  }
}
```

**2. settings.json Auto-Mode `soft_deny[]` 안 명시 추가**

```json
{
  "autoMode": {
    "soft_deny": [
      "$defaults",
      ... (기존 본질 보존) ...
      "Never modify files outside projects/meta/claude-code-version-log.md from version-tracker agent: 본 subagent 책임 = log file 단일 update (T1.6b 정합)"
    ]
  }
}
```

**3. agents/version-tracker.md frontmatter 본질 검토**

T1.6a draft (v7-design.md L156~) 본질 보존:

```yaml
---
name: version-tracker
description: Claude Code 버전 추적 추가 조사 — 사용자 명시 trigger 시 context7 query Claude Code docs (recent version + 신기능 + plugin matrix) 후 projects/meta/claude-code-version-log.md update. SessionStart hook 자동 검출 (system reminder source) 보강 본질.
tools: mcp__plugin_context7_context7__resolve-library-id, mcp__plugin_context7_context7__query-docs, Read, Edit
model: opus
---
```

**검토 결과** (정정 부재 자연):

- `tools:` allowlist = context7 2 tool + Read + Edit 한정 (minimal 본질 정합)
- `model:` = opus (조사 본질 정합, 추론 깊이 우선)
- `description:` = 사용자 명시 trigger 본질 명시 (Claude 자동 invoke 부재)

T1.6a draft 본질 이미 T1.5 frontmatter pattern 정합 (L516~) — 추가 정정 부재.

#### T1.5 frontmatter pattern 정합 본질 (3 subagent 매트릭스 cross-ref)

| 본질 | review (T1.3 안) | Explore (T2.3 안 활용) | version-tracker (T1.6b) |
|---|---|---|---|
| frontmatter `tools:` | Read, Grep, Glob (read-only) | (built-in, frontmatter 부재) | context7 2 + Read + Edit (minimal write) |
| `model:` | opus (추론) | (built-in default) | opus (조사) |
| Auto-Mode allow | inherit (read-only 자연) | inherit (read-only 자연) | **명시** (단일 file write) |
| Auto-Mode soft_deny | inherit | inherit | **명시** (다른 file write 금지) |
| settings.json 추가 | 부재 | environment 안 명시 | **allow + soft_deny 명시 (T1.6b 정정)** |

T1.6b = 3 subagent 매트릭스 안 가장 정밀한 권한 정전화 본질 (write 본질 = settings.json 명시 의무).

#### T1.6 a 단계 ↔ b 단계 분리 본질 정합

| 단계 | Tier | 책임 | 산출물 |
|:-:|:-:|---|---|
| **a 단계** | Tier 0 (T1.6a) | mechanism 도입 (hook + subagent 본질 작성) | claude/hooks/session-start-version-track.sh + agents/version-tracker.md + projects/meta/claude-code-version-log.md (기본 frontmatter tools) |
| **b 단계** | Tier 1.5 (T1.6b) | 권한 정전화 (T1.5 Auto-Mode + 최소권한 결과 활용) | claude/settings.json 안 allow + soft_deny 명시 추가 (frontmatter tools 정정 부재 자연) |

분리 본질 정합 (v7-design.md L166~168 정전화):

- a 단계 = T1.5 진입 전 mechanism source 거주 (frontmatter 본질 부재 임시 보존)
- b 단계 = T1.5 진입 후 권한 정전화 자연 (T1.5 mechanism inherit)

#### adoption mechanism (T1.6b EXECUTE 안 적용 순서)

1. **T1.5 결과 확정 확인** — claude/settings.json template 거주 + plugin.json paths 자동 인식 본질 verify
2. **claude/settings.json 안 `autoMode.allow[]` row 추가** (version-tracker log file write 명시)
3. **claude/settings.json 안 `autoMode.soft_deny[]` row 추가** (version-tracker 외 file write 금지 명시)
4. **agents/version-tracker.md frontmatter 본질 verify** (T1.6a draft 본질 이미 정합 — 정정 부재 자연 보존)
5. **smoke 본질 정합 검증** — 기존 smoke 본질 자연 정합 (settings.json + frontmatter 변경은 Claude Code runtime 본질, smoke 와 직교)

#### 책임 분리 정합 본질 (Tier 0 T1.6a ↔ Tier 1 T1.5 ↔ Tier 1.5 T1.6b)

| Tier | 본질 |
|:-:|---|
| Tier 0 (T1.6a) | mechanism 본질 도입 (SessionStart hook + version-tracker subagent + claude-code-version-log.md) — 기본 frontmatter tools |
| Tier 1 (T1.5) | Auto-Mode + 권한 정전화 mechanism source-of-truth 단일 책임 (settings.json template + frontmatter pattern + 3 subagent 매트릭스) |
| Tier 1.5 (T1.6b) | T1.5 mechanism 안 version-tracker 직접 정전화 (settings.json allow + soft_deny 명시, frontmatter 정정 부재 자연) |

**의존 본질 정합**:

- T1.6a (Tier 0) → T1.5 (Tier 1) → T1.6b (Tier 1.5) 순차 의존
- T1.6 2 단계 분리 본질 = T1.5 진입 후 권한 정전화 자연 정합 (순환 의존 해소)

#### 본질 미해소 (다음 round trigger)

- SessionStart hook ↔ version-tracker subagent 경합 처리 본질 (두 mechanism 이 같은 log file update 경채 — file lock vs append-only mechanism 본질, T1.6b scope 외)
- log file 안 ## History entry append 경쟁 처리 본질 (multi-session 안 concurrent write 시 file integrity 본질)
- PermissionRequest hook 활용 본질 (T3.4 보류 — Tier 3 안 자연 흡수 시 version-tracker 한정 적용 candidate)
- version-tracker subagent 실 invoke 시점 본질 (사용자 명시 trigger keyword 매트릭스 정밀화 — `description:` 안 명시된 "버전 추적 추가 조사" / "Claude Code 신기능 조사" 외 추가 trigger 본질 verify)

## 새 워크플로우 본질 정의 (통합)

### 결정 본질

| 본질 | 결정 |
|---|---|
| 9-stage 본질 자체 | **보존** (OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE) — 7 결정 모두 stage 내부 mechanism 정정 (stage 본질 자체 변경 부재) |
| breaking change | **최소** (28 active milestone + 40 _archive milestone narrative 자연 보존, T2.1 정합 — 디스크 보존 1건만 + 기존 점진적 보존) |
| 적용 시점 | **v7.0+ 신규 milestone** (기존 milestone 본질 cascading 부재) |
| 7 결정 분류 | stage 내부 mechanism 3건 (T1.3 DESIGN / T2.3 RESEARCH / T1.2 PROPOSE) + stage 외 mechanism 4건 (T1.6 Session start / T1.1 Path-scoped / T1.5 Settings / T2.1 Milestone 완료 후) |

### 9-stage 본질 정합 매트릭스 (v7.0 후 정정 본질)

| Stage | 책임 | v7.0 정정 본질 | 정정 source |
|:-:|---|---|:-:|
| A. OPEN | 컨테이너 마운트 + ROADMAP entry `in_progress` | 변경 부재 | — |
| B. INTENT | 의도 (goal / motivation / success_criteria / out_of_scope / dependencies) | 변경 부재 (INTENT 본질 자연 보존, T2.3 분야 발현 source 자연) | — |
| **C. RESEARCH** | 조사 (external / codebase / options / risks_identified) | **codebase 분야 매트릭스 자동 발현 + Explore parallel invoke** | T2.3 |
| **D. DESIGN** | 설계 (decisions / approach / phases / risk_mitigation) | **5 관점 → N+ 가변 + scope 안/외 분리 + design-review subagent** | T1.3 |
| E. APPROVE | 사용자 명시 승인 게이트 (approved_by + date + approval_summary) | 변경 부재 (T1.5 Auto-Mode `defaultMode: "auto"` 안 사용자 명시 게이트 본질 자연 보존) | — |
| F. EXECUTE | per-phase 구현 (changes + commit) | 변경 부재 (per-phase commit 본질 보존, T1.7 batched push 본질 P2 후속 보류) | — |
| G. VERIFY | 검증 (smoke + criteria_check vs INTENT + verdict) | 변경 부재 | — |
| H. REPORT | 종합 backward (summary + delta + lessons_learned) | **lessons P2/P3 자동 enumerate 폐지 (lessons 본질 narrative 보존, candidate 자동 화 폐지)** | T1.2 |
| **I. PROPOSE** | 후속 forward (next_candidates ROADMAP 등재) | **자동 append → 사용자 명시 결정 게이트 후만 append** | T1.2 |

### stage 외 mechanism 매트릭스 (v7.0 신규)

| 시점 | 본질 | source | 적용 위치 |
|---|---|:-:|---|
| Session start (자동) | Claude Code 버전 추적 + 사용 가능 기능 매트릭스 update | T1.6a | claude/hooks/session-start-version-track.sh + projects/meta/claude-code-version-log.md |
| 사용자 명시 trigger | Claude Code 신기능 추가 조사 (context7 query) | T1.6a / T1.6b | agents/version-tracker.md + claude/settings.json allow + soft_deny |
| Path-scoped (file 매칭 시) | mechanical rule 자동 inject (schema / fact-verification / candidate-draft) | T1.1 | .claude/rules/{schema-discipline, subagent-fact-verification, candidate-draft-schema}.md |
| Settings (always-loaded) | Auto-Mode 4 분류 (environment / allow / soft_deny / hard_deny) + permissions.defaultMode | T1.5 | claude/settings.json |
| Milestone 완료 시 | GitHub Releases body migration + 디스크 디렉토리 제거 (commit marker `[release:v{X.Y}]` trigger) | T2.1 | .github/workflows/release.yml 안 awk filter 본질 변경 + auto `git rm -r` |
| MILESTONE.md 안 (Stage 외 신규 H2) | scope 외 거명 archival (next_candidates 자동 append 부재) | T1.3 | projects/meta/milestones/v{X.Y}/MILESTONE.md ## SCOPE_OUT_NOTES |

### 3-way 책임 직교 본질 (T1.1 정전화 정합)

| 본질 | 거주 | load 시점 | 책임 |
|---|---|---|---|
| **CLAUDE.md** | repo root + subdirectory | always-loaded (CWD 안 자동) | entry pointer + 구조 규칙 + 진입 narrative |
| **.claude/rules/** | `.claude/rules/*.md` | path-scoped (frontmatter `paths:` glob 매칭 시) | mechanical rule (schema 의무 / 검증 의무 / smoke 정합) |
| **MEMORY** | `~/.claude/projects/<encoded>/memory/` | cross-session (memory tool inject) | personal preference (사용자 협업 스타일 / feedback / project state) |

### subagent fleet 본질 (v7.0 후 매트릭스)

| subagent | 도입 source | scope | tools | Auto-Mode 정합 |
|---|:-:|---|---|---|
| **design-review** | T1.3 | DESIGN.md 산출 후 N+ 가변 분야 review | Read, Grep, Glob (read-only) | inherit (read-only 자연) |
| **version-tracker** | T1.6a / T1.6b | 사용자 명시 trigger 시 context7 query + log update | context7 2 + Read + Edit | 명시 (allow + soft_deny) |
| **Explore** (built-in) | T2.3 활용 pattern | RESEARCH cb 분야 매트릭스 parallel mapping | (built-in) | inherit + environment 명시 |
| (기존 9 subagent) | v5.x~v6.x | audit-team + agents-md-sync + environment-auditor + audit-orchestrator | 각 minimal tools 본질 보존 | inherit |

### AI Native 운영 본질 정합 (ARCHITECTURE § 7 정합)

v7.0 7 결정 ↔ AI Native 3 면 매트릭스 매핑:

| AI Native 면 | 정합 결정 | 본질 |
|---|---|---|
| 컨텍스트 효율 (§ 7.1) | T2.1 (milestone 1건만 디스크) + T1.1 (path-scoped rule lazy load) + T1.2 (next_candidates 절제) | 누적 부하 절감 — 진행 중 본질만 자동 inject |
| 자율성 (§ 7.2) | T1.5 (Auto-Mode + 최소권한) + T1.6 (자동 버전 추적) + T1.3 (Claude 메인 자동 분야 발현) + T2.3 (자동 분야 발현) | Claude 자율 발의 본질 + 사용자 명시 게이트 균형 (e3 정책 정합) |
| 다중 AI 협업 (§ 7.3) | T2.3 (Explore parallel) + T1.3 (design-review N 분야 parallel) + T1.6 (SessionStart hook ↔ version-tracker subagent 본질 분리) | 책임 분리 + parallel invoke 본질 자연 |

## adoption mechanism

> **⚠️ 변경 (검토 round 2026-05-25 — 정정 #7·#10 참조)** — adoption = v7.0 milestone 안 6 mechanism **설치만** (도그푸드 자기 적용 폐기, 첫 사용 v7.1). phase **6 개** (T2.1 폐기로 phase-1 제거). 이하 narrative 의 "도그푼드"·"자기 적용"·7-phase 표현은 historical (적용 안 함).

### 결정 본질

| 본질 | 결정 |
|---|---|
| adoption 방식 | **단일 v7.0 milestone 안 표준 9-stage 도그푼드** — v7.0 자체가 v7.0 결과 첫 적용 cycle (자기참조 적용 본질) |
| root design 본질 | **보존** — `v7-redesign.md` + `v7-design.md` = root gitignored 자유 형식 (자기참조 회피 본질 보존, audit trail 자연) |
| v7.0 milestone 본질 | `projects/meta/milestones/v7.0/` 안 v6.2+ 9-stage-flattened 본질 정합 (MILESTONE.md + execute/phase-{n}.md) |
| 자기참조 적용 본질 | T2.3 자체 적용 (RESEARCH cb 분야 = Explore parallel) + T1.3 자체 적용 (DESIGN review = N+ 가변 + scope 안/외) — 본 v7.0 = 도그푼드 cycle 1차 |
| Releases migration | v7.0 완료 시 commit marker `[release:v7.0]` push → workflow trigger → GitHub Releases body migration + 디스크 디렉토리 제거 (T2.1 도그푼드) |
| 기존 28 active milestone | 디스크 보존 (점진적, T2.1 정합) — v7.0+ 신규 milestone 만 Releases migration 본질 적용 |

### 적용 sequence 본질

```
1. v7-design.md design 본문 완료 (현 round 본질 — 7 entry + 통합 section)
   ↓
2. v7.0 milestone OPEN (Stage A)
   - projects/meta/milestones/v7.0/ 디렉토리 생성
   - MILESTONE.md skeleton 작성 (8 H2 + ## SUB_MILESTONES + 신규 ## SCOPE_OUT_NOTES)
   - ROADMAP entry `in_progress`
   ↓
3. v7.0 milestone INTENT (Stage B)
   - v7-design.md 결과 흕수 → INTENT.md (goal / motivation / success_criteria / out_of_scope / dependencies)
   - success_criteria = 7 entry 자체 + 통합 section 본질
   ↓
4. v7.0 milestone RESEARCH (Stage C) — T2.3 자체 적용 (도그푼드)
   - Claude 메인 자동 cb 분야 발현 (e.g., agent fleet + settings.json + cascade narrative + .claude/rules/ + plugin.json paths + smoke fleet)
   - AskUserQuestion 게이트
   - 사용자 명시 후 Explore parallel invoke (N 분야 동시)
   - RESEARCH.md 안 codebase.{분야명} 자연 채움
   ↓
5. v7.0 milestone DESIGN (Stage D) — T1.3 자체 적용 (도그푼드)
   - v7-design.md 결과 흕수 → DESIGN.md (decisions / approach / phases / risk_mitigation)
   - phases = 7 entry 본질 매핑 (phase 1~7 또는 의미 단위 통합)
   - Claude 메인 자동 분야 발현 (관련 검증 관점 매트릭스)
   - AskUserQuestion 게이트
   - design-review subagent invoke (N 관점 병렬, scope 안/외 분리)
   - scope 외 거명 → MILESTONE.md ## SCOPE_OUT_NOTES 흡수
   ↓
6. v7.0 milestone APPROVE (Stage E) — 사용자 명시 승인 게이트
   - DESIGN 종합 → APPROVE.md (approved_by: "user" + date + approval_summary)
   ↓
7. v7.0 milestone EXECUTE (Stage F) — phase-{1~7} per-phase 본질
   - phase별 1 entry mechanical 적용 (per-phase commit, conventional commits)
   ↓
8. v7.0 milestone VERIFY (Stage G)
   - smoke 본질 검증 (기존 smoke-spec-verification + smoke-candidate-draft-schema 본질 정합)
   - criteria_check vs INTENT 매핑
   ↓
9. v7.0 milestone REPORT (Stage H)
   - 종합 backward (summary + delta + lessons_learned)
   - lessons P2/P3 자동 enumerate 폐지 본질 자연 적용 (T1.2 자체 적용)
   ↓
10. v7.0 milestone PROPOSE (Stage I)
   - next_candidates 발의 = 사용자 명시 결정 게이트 후만 append (T1.2 자체 적용)
   - 후보 source = P2~P4 14건 (v7-redesign.md L194~200 정합)
   ↓
11. v7.0 milestone 완료 commit marker push (T2.1 자체 적용)
   - commit msg = `feat(meta): v7.0 ... [release:v7.0]`
   - workflow trigger → GitHub Releases body migration → 디스크 `projects/meta/milestones/v7.0/` 제거
   - root v7-redesign.md + v7-design.md = 보존 (gitignored, audit trail)
```

### 자기참조 도그푼드 본질 (cycle 1차)

> **🛑 변경 (검토 round 2026-05-25 — 정정 #7)** — v7.0 도그푸드 (자기 적용) 폐기. v7.0 = 6 mechanism **설치만**, 첫 사용 = v7.1 (과거 commit `57a01ed` v7 full rollback 위험 격리). 이하 매트릭스는 historical.

본 v7.0 = v7.0 결과 첫 적용 cycle. self-referential 본질 정합 매트릭스:

| v7.0 결정 | v7.0 자체 적용 본질 | self-referential 정합 |
|:-:|---|---|
| T2.3 (RESEARCH Explore parallel) | v7.0 RESEARCH Stage 안 직접 적용 | 도그푼드 cycle 1차 |
| T1.3 (DESIGN review N+ 가변) | v7.0 DESIGN Stage 안 직접 적용 | 도그푼드 cycle 1차 |
| T1.2 (lessons P2/P3 자동 enumerate 폐지) | v7.0 REPORT Stage 안 직접 적용 | 도그푼드 cycle 1차 |
| T2.1 (milestone 산출물 거주 mechanism 변경) | v7.0 완료 시 직접 적용 (Releases migration) | 도그푼드 cycle 1차 (역사적 첫 적용) |
| T1.5 (Auto-Mode) | v7.0 EXECUTE Stage 안 직접 적용 (settings.json 작성 후 EXECUTE 내내 활용) | 도그푼드 cycle 1차 |
| T1.1 (.claude/rules/) | v7.0 EXECUTE Stage 안 작성 → 즉시 path-scoped inject 본질 활용 | 도그푼드 cycle 1차 |
| T1.6 (버전 추적) | v7.0 EXECUTE Stage 안 신규 mechanism → 즉시 활용 | 도그푼드 cycle 1차 |
| T1.6b (version-tracker 권한 정전화) | T1.5 적용 후 즉시 적용 | 도그푼드 cycle 1차 |

### root design 본질 보존 정합

v7-redesign.md + v7-design.md = root gitignored 자유 형식 보존 (commit `4f8f423` 정합, .gitignore root carry-over file 정전화).

이유:

- **자기참조 회피 본질** — v7.0 design 작업 자체를 9-stage 본질 안 진행 시 self-referential 충돌 6 본질 (v7-redesign.md § 53~66 정합) 발생
- **audit trail** — root file 거주 자체가 commit history 안 보존 본질 (gitignored 이지만 .gitignore commit + 본 file 거주 패턴 자체가 audit trail)
- **token-efficiency 본질** — root 보존 시 v7.0 milestone INTENT/DESIGN 안 v7-design.md cascade 흡수 (1차 source) — 중복 narrative 부재

## v7.0 자체 결과 적용

### 결정 본질

| 본질 | 결정 |
|---|---|
| 적용 단위 | **phase-{1~7} 안 1 entry per phase** — 7 결정 의미 단위 분리 (T2.1 / T1.6 / T1.1 / T1.5 / T1.3 / T2.3 / T1.2) + T1.6b 자연 흡수 (T1.5 cascade) |
| phase 본질 | 의존 본질 정합 순서 — Tier 0 (T2.1 / T1.6 / T1.1 parallel base) → Tier 1 (T1.5) → Tier 2 (T1.3 + T2.3 parallel) → Tier 3 (T1.2) → Tier 1.5 (T1.6b) |
| commit 본질 | per-phase 1 commit (conventional commits) — 마지막 phase commit msg 안 `[release:v7.0]` marker |
| 사용자 명시 게이트 | phase 진입 + 완료 시 (현 본질 정합) — T1.5 Auto-Mode 정합 안에서도 사용자 명시 결정 본질 보존 |

### phase 매트릭스 본질 (7 phase)

> **⚠️ 변경 (검토 round 2026-05-25 — 정정 #10)** — phase **6 개** (phase-1 = T2.1 폐기로 삭제). 나머지 phase = mechanism **설치만** (자기 적용 표현 historical). phase 재번호는 v7.0 OPEN 때.

| phase | entry | 적용 대상 | 본질 |
|:-:|:-:|---|---|
| phase-1 | T2.1 | `.github/workflows/release.yml` 안 awk filter 변경 + auto `git rm -r` (사용자 명시 결정 게이트 강화) | milestone 산출물 거주 mechanism 변경 (BREAKING — 본 v7.0 자체 첫 적용) |
| phase-2 | T1.6 | `claude/hooks/session-start-version-track.sh` 신규 + `agents/version-tracker.md` 신규 + `projects/meta/claude-code-version-log.md` 신규 + `.claude-plugin/plugin.json` paths 정정 | 버전 추적 mechanism 도입 (a 단계) |
| phase-3 | T1.1 | `ARCHITECTURE.md § N` 신규 (3-way 직교) + `.claude/rules/` 디렉토리 + 3 file 신규 + `README.md` 신규 + CLAUDE.md § 구조 규칙 안 1 줄 추가 + MEMORY 5 entry archive (file 5건 삭제 + MEMORY.md index 5 row 제거) | .claude/rules/ 도입 + MEMORY archival |
| phase-4 | T1.5 | `claude/settings.json` 신규 (Auto-Mode 4 분류 + permissions.defaultMode) + `.claude-plugin/plugin.json` settings paths 추가 + frontmatter pattern 정전화 narrative (design body 안 정전화 보존) | Auto-Mode + 3 subagent 권한 정전화 mechanism |
| phase-5 | T1.3 | `agents/design-review.md` 신규 + `claude/commands/harness-meta.md § Stage D` 안 narrative 정정 (N+ 가변 mechanism) + MILESTONE.md skeleton 안 ## SCOPE_OUT_NOTES H2 신규 + smoke-spec-verification 본질 정정 (가변 본질 정합) | 5 관점 review redesign — N+ 가변 + scope 안/외 분리 |
| phase-6 | T2.3 | `claude/commands/harness-meta.md § Stage C` 안 RESEARCH cb 분야 매핑 mechanism 정전화 + RESEARCH.md schema codebase 필드 구조 확장 narrative + Explore prompt template 정전화 + 작업 본질 type 매트릭스 정전화 (ARCHITECTURE.md 안 새 § 또는 commands narrative 안) | RESEARCH Explore 병렬 활용 |
| phase-7 | T1.2 + T1.6b + 마지막 정합 | (1) 사용자 명시 결정 게이트 → ROADMAP `next_candidates[]` = [] + schema_note narrative 추가 / (2) `scripts/propose_next.py` 안 lessons P2 자동 종합 logic 제거 / (3) `skills/propose-next/SKILL.md` 정정 / (4) `claude/commands/harness-meta.md § Stage I` 정정 / (5) ARCHITECTURE.md § 4 끝 매트릭스 #9 row 정정 + (6) T1.6b 자연 흡수 = `claude/settings.json` 안 version-tracker allow + soft_deny row 추가 / (7) ROADMAP root + projects/meta/ROADMAP entry v7.0 completed 갱신 + commit marker `[release:v7.0]` | next_candidates 절제 + T1.6b 자연 흡수 + 마지막 commit |

### 적용 대상 file 본질 매트릭스

| file 본질 | 변경 본질 | source phase |
|---|---|:-:|
| **신규 file** | `agents/version-tracker.md` / `agents/design-review.md` / `claude/hooks/session-start-version-track.sh` / `claude/settings.json` / `projects/meta/claude-code-version-log.md` / `.claude/rules/schema-discipline.md` / `.claude/rules/subagent-fact-verification.md` / `.claude/rules/candidate-draft-schema.md` / `.claude/rules/README.md` | phase 2/3/4/5 |
| **MILESTONE.md skeleton 정정** | 8 H2 + ## SUB_MILESTONES + 신규 ## SCOPE_OUT_NOTES (10 H2 본질) | phase 5 |
| **ARCHITECTURE.md** | § N (3-way 직교) 신규 + § 4 끝 매트릭스 #9 row 정정 (propose-next mechanism lessons P2 폐지) + 작업 본질 type 매트릭스 정전화 (위치 결정 본질) | phase 3 / 6 / 7 |
| **CLAUDE.md (root)** | § 구조 규칙 안 .claude/rules/ entry pointer 1 줄 추가 | phase 3 |
| **claude/commands/harness-meta.md** | § Stage C RESEARCH cb 매핑 mechanism + § Stage D DESIGN review N+ 가변 mechanism + § Stage I PROPOSE next_candidates 절제 mechanism | phase 5 / 6 / 7 |
| **.claude-plugin/plugin.json** | hooks paths + agents paths (자동 인식 자연) + settings paths 추가 | phase 2 / 4 |
| **.github/workflows/release.yml** | awk filter 변경 (REPORT 섹션 → MILESTONE.md 전체 + execute/ 본문 통합) + auto `git rm -r` 본질 추가 (사용자 명시 결정 게이트 강화) | phase 1 |
| **ROADMAP (projects/meta/)** | next_candidates[] = [] 정정 + schema_note narrative 추가 + v7.0 entry completed 갱신 | phase 7 |
| **scripts/propose_next.py** | Step 1 안 lessons P2 자동 종합 logic 제거 | phase 7 |
| **skills/propose-next/SKILL.md** | narrative 정정 (lessons P2 자동 종합 폐지 본질) | phase 7 |
| **MEMORY archival** | 5 entry file 삭제 (`feedback_approve_md_schema_wrap.md` / `feedback_intent_md_schema_required.md` / `feedback_cascade_marker_placeholder_avoidance.md` / `feedback_subagent_fact_hallucination_correction.md` / `feedback_candidate_draft_decision_pending_string.md`) + MEMORY.md index 5 row 제거 | phase 3 |
| **smoke 본질 정합 검증** | smoke-spec-verification 안 5 관점 narrative 검증 logic 가변 본질 정합 정정 (perspectives array 비어 있지 않음 본질만) | phase 5 |
| **tag v7.0 재발급 본질** | 사용자 명시 결정 본질 — phase 7 commit marker push 후 Releases workflow 자연 trigger | phase 7 |

### 본질 미해소 (다음 round trigger / EXECUTE 안 결정)

- 작업 본질 type 매트릭스 정확 거주 본질 (ARCHITECTURE.md 안 새 § vs commands/harness-meta.md 안 정전화) — phase 6 안 결정
- ARCHITECTURE.md § N (3-way 직교) 정확 § 번호 본질 — 현 § 7 AI Native 후 § 8 자연 vs § 4 끝 매트릭스 row 추가 — phase 3 안 결정
- v7.0 milestone 안 self-referential 도그푼드 cycle 1차 본질 안 evidence 누적 (검증 mechanism — RESEARCH/DESIGN 안 실 Explore parallel + design-review subagent invoke 결과) — phase 4~5 안 결정
- T1.7 batched push 정책 (P2 후속) — v7.0 자체 자연 적용 (마지막 phase commit marker 안 자연 정합) vs v7.x 후속 정전화
- ROADMAP root + projects/meta/ROADMAP.md schema 본질 정합 (next_candidates[] = [] 후 next_candidates 본질 자체 ROADMAP 안 유지 vs 폐지) — phase 7 안 결정
- MEMORY archival 후 5 file 삭제 vs MEMORY directory cleanup 본질 (memory tool 자연 인식 — file 삭제만으로 충분 vs index 재구축)

### 적용 후 expected outcome 본질

| 본질 | v7.0 후 expected state |
|---|---|
| 디스크 milestone 수 | 28 active + 40 _archive (변경 부재) → v7.1+ 첫 신규 시 = 28 + (v7.1 진행 중 1) + 40 _archive + v7.0 Releases body 안 흡수 (디스크 부재) |
| Claude 컨텍스트 부하 | T1.1 path-scoped rule lazy load 효과 + T1.2 next_candidates 절제 효과 누적 → INTENT/RESEARCH/DESIGN 안 항상 inject 본질 절감 |
| subagent fleet | 9 기존 + design-review (T1.3) + version-tracker (T1.6) = 11 subagent + Explore (built-in 활용 정전화) |
| 외부 vector 본질 | Claude Code Plugin spec (v5.0+) + .claude/rules/ (v2.1.33+) + Auto-Mode (v2.1.33+) 동시 적용 = AI Native 운영 본질 § 7 정합 |
| 자기참조 정합 | v7.0 결과 첫 적용 cycle (도그푼드 1차) — v7.x+ 추가 cycle 누적 본질 자연 |
