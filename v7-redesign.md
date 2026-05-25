# v7 워크플로우 재설계 (root 진행)

본 file = harness-meta workflow 자체 재설계 design doc.

## 진행 본질

- 위치: `C:\Users\qkreh\harness-meta\` (root)
- 9-stage workflow 본질 안 진행 **안 함** (self-referential 회피)
- ROADMAP 등재 **안 함**
- 산출물 자유 형식 (필요 시 추가 file 자연 발현)
- audit trail = file 거주 자체 (gitignored, git tracked 부재 — root 진행 + self-referential 회피 본질 정합, commit `4f8f423` 정합)
- 사용자 의도 #24 ("새 세션 진행") 정합 → 본 세션 안 carry-over + 다음 세션 안 design 본격 진입

## 본 세션 안 결정 (2026-05-22)

| # | 결정 | 적용 |
|:-:|---|---|
| 1 | v7.0/v7.1 폐기 | commit `57a01ed` — host 5 full rollback (옵션 B-2) |
| 2 | tag v7.0 삭제 (로컬 + remote) | push 완료 |
| 3 | 새 v7.0 scope = v7-0-pre-discussion.txt 안 8 후보 단일 milestone | 사용자 명시 |
| 4 | 진행 본질 = root 진행 + 자유 형식 + ROADMAP 등재 안 함 | 본 file 거주 자연 |

폐기 본질 (commit 57a01ed):

- `projects/meta/milestone/` (단수형 디렉토리) 통째 삭제
- 7 file → `9dfc217` (v6.23 last) 회귀 (catalog README / harness-meta.md / ARCHITECTURE / ROADMAP / `_era_detect.py` / 2 smoke)
- memory `feedback_v7_external_vector_mandate.md` 삭제 + MEMORY.md entry 3 곳 정정

## v7-0-pre-discussion.txt 종합 (Phase A / B / C 자연 분할)

### 4 핵심 인사이트

| # | 시점 | 인사이트 |
|:-:|:-:|---|
| 1 | #08 (5:48) | 정책/메모리 부하 자각 — self-host overhead 첫 표출 |
| 2 | #12, #13 (6:06~6:11) | 매 milestone 마다 next_candidates 부산물 발생 — 자기참조 loop 본질 인식 (폐기 v7.0 mechanism-cleanup 의 직접 trigger) |
| 3 | #14 (6:17) | 검증 sub-agent (5 관점 review) 의도 미달 자각 |
| 4 | #10, #20 (5:53, 7:01) | 외부 vector 방향 명시 — Claude Code built-in/skill 적극 활용 + 버전 추적 |

### 8 후보 (변경 본질)

| # | 메시지 | 본질 | 본질 분류 |
|:-:|:-:|---|---|
| 1 | #04, #05 | `.claude/rules/` 도입 (memory/architecture 정책 일부 이전 검토) | 정책 본질 |
| 2 | #15 | stage별 sub-agent/agent team 도입 필요성 | workflow 본질 |
| 3 | #16 | stage별 skill 도입 필요성 | workflow 본질 |
| 4 | #17 | stage별 최소권한원칙 정합성 검토 | workflow 본질 |
| 5 | #18 | stage 완료 시 context 사용량 확인 + /clear 결정 (context rot 방지) | workflow 본질 |
| 6 | #19 | 마일스톤 완료 시 산출물 reset + github tag 버전 관리 (BREAKING) | 산출물 본질 |
| 7 | #21, #22 | Claude Code docs 전수조사 + 버전 추적 agent | 외부 vector |
| 8 | #26 | 마일스톤 단위 commit/push (per-phase 금지) | commit 본질 |

## self-referential 충돌 6 본질

본 v7.0 자체 진행 시 — 변경 대상이 동시에 진행 도구가 되는 충돌.

| # | 현재 워크플로우 | v7.0 변경 후보 (충돌) |
|:-:|---|---|
| 1 | 산출물 영구 보존 (`milestones/v{X.Y}/`) | #19 다음 마일스톤 진행 시 reset |
| 2 | 9-stage (OPEN~PROPOSE) | #15 stage별 sub-agent + #16 skill + #17 권한 |
| 3 | per-phase 또는 milestone 단위 commit | #26 milestone 단위 only |
| 4 | 산출물 안 5 관점 review (조건부) | #15~17 안 변경 가능 |
| 5 | next_candidates 발의 default | #11 propose-next 정체성 의문 |
| 6 | memory/architecture 정책 본질 | #04 `.claude/rules/` 이전 검토 |

**해결 = root 진행** (workflow 본질 무시 → 6 충돌 100% 회피)

## 2026-05-22 round 안 26 prompt 순차 분석 결과 (carry-over)

본 round = `v7-0-pre-discussion.txt` 26 prompt 안 사용자 의도 순차 답변. 본 § = 본 round 안 추가 도출 detail (위 8 후보 매트릭스 expansion).

### 본 round 안 핵심 발견 (per-prompt)

| prompt | 핵심 발견 |
|:-:|---|
| #02~#04 | `.claude/rules/` 공식 본질 = path-scoped lazy load (`paths:` frontmatter) + CLAUDE.md 와 함께 로드. CLAUDE.md (always-loaded) ↔ rules (path-scoped) ↔ MEMORY (cross-session personal) 3-way 책임 직교 |
| #05~#06 | MEMORY archival 후보 5건 (`feedback_approve_md_schema_wrap` 등 schema 본질 + `feedback_cascade_marker_placeholder_avoidance` + `feedback_subagent_fact_hallucination_correction`) — path-scoped 본질 자연. ARCHITECTURE policy 이전 부적합 (conceptual scope 본질) |
| #07 | MEMORY.md 공식 = **첫 200 줄 또는 25 KB 자동 inject** (index 본질). detail 은 topic file 위임. 본 repo 현 상태 (17 entry, 약 30 줄) — index 본질 잘 보존 |
| #08 | 부하 근거 매트릭스 = ROADMAP `next_candidates[]` 27 entry (~13 KB) + ARCHITECTURE § 4 끝 매트릭스 16 row + MEMORY redundancy (`feedback_iterative_*` cluster 3건 유사) — 누적 압력 vs 절제 mechanism 미비 |
| #11 | propose-next = harness-meta 자율성 면 (§ 7.2) 본질 — **보존**. next_candidates[] 만 절제 (mechanism ↔ stored field 분리 평가) |
| #12 | 부산물 발생 5 본질 — (1) 검토 폭 vs scope 깊이 비대칭 + (2) lessons P2/P3 자동 candidate 화 + (3) scope 보수성 정책 + (4) carry-over narrative 연속성 + (5) self-referential 본질. **가장 무거운 = #1 × #5** |
| #13 | OPEN/INTENT 안 사용자 인터뷰는 정상 동작 — 부산물은 **DESIGN 5 관점 review subagent prompt 본질** 안 자연. scope 안 본질 vs scope 외 거명 두 본질 직교 |
| #14 | 5 관점 review 의도 ('scope 안 기술 검증') vs 실 동작 (scope 외 거명 가산) 갭 — `/code-review` 본질 정합 본질. redesign 4 옵션 (A=2 관점 축소 / B=scope 외 거명 금지 / C=review 자체 폐지 / D=scope 안/외 분리 archival) |
| #15 | stage 별 subagent 필요성 — OPEN/INTENT/APPROVE/REPORT 부적합 (사용자 대화/narrative 본질). DESIGN (5 관점 redesign) + RESEARCH (Explore 병렬) 가 1차 후보 |
| #16 | 현 stage skill 9건 description 'vague' — 'milestone X stage 작성 시' 만 명시. body sub-field 검증 logic + description trigger 강화 필요 |
| #17 | 최소권한원칙 = 현 미적용 (stage skill 안 prompt-based playbook 본질). 적용 옵션 (A=stage subagent 전환 / B=Auto-Mode JSON / C=self-regulation 가이드라인) — **(B) Auto-Mode 추천** |
| #18 | context rot 방지 mechanism = ROADMAP `candidate_draft[]` 안 이미 등재 (`stage-completion-context-clear-recommendation`). 본 round 가 detected_at source — 자동 /clear 호출 불가능 (hook 한계) → Claude 명시 권고 + 사용자 명시 /clear |
| #19 | milestone 산출물 누적 → GitHub Releases migration — 2 해석 (A=디스크 거주 1 milestone 만 / B=현 본질 유지 + 매 진입 안 새 디렉토리). 사용자 의도 (A) 가능 — narrative 연속성 trade-off |
| #20 | built-in 적극 활용 — v6.21 'bundled skill 흡수 0' 결정 재고 trigger. `/code-review` + `/security-review` + `/verify` + `/ultrareview` + Auto-Mode + `/memory` + Background sessions 등 |
| #21 | Claude Code 버전별 기능 전수조사 결과 — Plugin/Auto-Mode/`.claude/rules/`/Agent allowlist syntax 모두 v2.1.33+. `/simplify` → `/code-review` 리브랜딩 v2.1.147+ (본 환경 v2.1.146 마진 후) |
| #22 | 버전 추적 mechanism — SessionStart hook (자동 검출) + version-tracker subagent (사용자 명시 trigger 시 추가 기능 조사) 조합 추천. 적재 위치 = `projects/meta/claude-code-version-log.md` |
| #26 | milestone 단위 push 정책 — commit 본질 보존, push 만 milestone 완료 시점 batched. 본 정책 적용 시 `[release:v{X.Y}]` marker push = Actions trigger 정합 |

### v7.0 scope Tier 매트릭스 (본 round 결과)

기존 § 'v7-0-pre-discussion.txt 종합' 안 8 후보 → 본 round 안 17 후보 expansion + 우선순위 Tier 분류.

**Tier 1 (7 후보 — 결정 자연, 사용자 명시 의도 + 본 repo 갭 명료)**:

| # | 후보 | origin prompt |
|:-:|---|---|
| T1.1 | `.claude/rules/` 도입 + MEMORY archival 5건 | #04~#06 |
| T1.2 | `next_candidates[]` 절제 + 부산물 mechanism redesign | #08, #12, #13 |
| T1.3 | 5 관점 review subagent 책임 redesign (scope 안 검증 집중) | #14 |
| T1.4 | stage 완료 시 context 평가 + /clear 권장 mechanism | #18 |
| T1.5 | Auto-Mode + 최소권한원칙 적용 | #17, #20 |
| T1.6 | 버전 추적 SessionStart hook + version-tracker subagent | #22 |
| T1.7 | milestone 완료 후 batched push 정책 정전화 | #26 |

**Tier 2 (4 후보 — 사용자 결정 필요)**:

| # | 후보 | origin prompt |
|:-:|---|---|
| T2.1 | milestone 디렉토리 → GitHub Releases 본문 migration | #19 |
| T2.2 | built-in skill 적극 활용 (v6.21 결정 재고) | #20 |
| T2.3 | RESEARCH 안 Explore agent 병렬 활용 | #15 |
| T2.4 | stage skill description 강화 + body sub-field 검증 logic | #16 |

**Tier 3 (7 후보 — 보완 가산)**:

| # | 후보 | origin prompt |
|:-:|---|---|
| T3.1 | MEMORY redundancy 통합 (`feedback_iterative_*` cluster 3→1) | #08 |
| T3.2 | ARCHITECTURE § 4 끝 매트릭스 paragraph 분리 (lazy-load) | #08 |
| T3.3 | CHANGELOG GitHub Releases migration (v6.18 candidate) | #19, #20 |
| T3.4 | TaskCompleted/SubagentStop hook PoC (audit chain) | #20, #21 |
| T3.5 | `/ultrareview` 활용 검토 (5 관점 보완/대체) | #21 |
| T3.6 | Extended Thinking 활용 narrative (DESIGN/RESEARCH) | #21 |
| T3.7 | Background sessions (`/bg`) 활용 (long-running EXECUTE) | #21 |

**Tier 4 (3 후보 — 폐기/보류)**:

| # | 후보 | 폐기 이유 |
|:-:|---|---|
| T4.1 | propose-next mechanism 폐지 | #11 — 자율성 면 본질 보존, next_candidates 만 절제 |
| T4.2 | stage 별 subagent 전면 도입 | #15 — OPEN/INTENT/APPROVE/REPORT 부적합 |
| T4.3 | EXECUTE phase 분할 sub-agent | #15 — lightweight 1-phase 본질 위배 |

### Claude Code v2.x 신기능 갭 매트릭스 (#21 결과)

| 기능 | 도입 | 본 repo 적용 | v7.0 활용 후보 |
|---|:-:|:-:|---|
| Skill 시스템 | v1.x | ✓ (13건) | description 강화 (T2.4) |
| Plugin 시스템 | v2.1.33+ | ✓ (v5.0+) | — |
| Agent allowlist syntax (`tools: Agent(agent_type)`) | v2.1.33+ | ✓ 부분 (audit-orchestrator) | standalone 확장 candidate |
| Hook (TaskCompleted/SubagentStop) | v2.1.33+ | ✗ | T3.4 |
| Auto-Mode | v2.1.33+ | ✗ | T1.5 |
| `.claude/rules/` | v2.1.33+ | ✗ | T1.1 |
| Extended Thinking | v2.1.100+ | ✗ | T3.6 |
| Background sessions (`/bg`) | v2.1.139+ | ✗ | T3.7 |
| `/ultrareview` | v2.1.111+ | ✗ | T3.5 |
| `/code-review` 리브랜딩 (`/simplify` →) | v2.1.147+ | 마진 후 자연 | — |

### 부산물 발생 근본 원인 narrative (#12, #13)

```
milestone N 진행
  → 5 관점 review (scope 외 거명 정상 — /code-review 본질 정합)
    → REPORT lessons P2/P3 (별 trigger 거명)
      → next_candidates 자동 append
        → milestone N+1 INTENT 안 next_candidates 일부 pick
          → 본 milestone scope 외 항목 또 5 관점 review 안 거명
            → 부산물 재생산 (cycle 무한)
```

**해소 방향** (T1.3 정합):

- (D) review 결과 scope 안 / 외 명시 분리 — scope 외 거명은 별 archival (next_candidates 아님) **추천**
- 또는 (A) 5 관점 → 2 관점 (spec-drift + security) 축소 — scope 안 기술 검증 집중

### scope 분할 결정 후보 (#23)

- (A) **v7.0 단일 milestone — T1 7건 핵심 + T2/T3 후속 candidate** — lightweight 본질 보존 + scope 명료 **추천**
- (B) v7.0 multi-phase EXECUTE — T1 + T2 통합 (11건)
- (C) v7.0 ~ v7.x series — T1/T2/T3 phase 분할

단 본 v7-redesign.md 본질 (root 진행 + 자유 형식 + ROADMAP 등재 안 함) 정합 → 'milestone' 본질 자체 본 재설계 결과로 변경 가능 (예: T2.1 = milestone 디렉토리 폐지). 즉 본 round T1~T4 분류는 **현 9-stage 본질 안 분류** — 새 워크플로우 정전화 후 재분류 자연.

## 본 round 결정 (2026-05-22, A 옵션 확정)

사용자 결정 = **A 옵션 (P0+P1 7건)** — lightweight 본질 보존 + scope 명료.

### v7.0 scope 7 후보 (P0+P1)

| Priority | # | 후보 | origin |
|:-:|:-:|---|---|
| **P0** | T2.1 | milestone 디렉토리 폐지 (GitHub Releases migration) | #19 |
| **P0** | T1.6 | 버전 추적 (SessionStart hook + version-tracker subagent) | #22 |
| P1 | T1.1 | `.claude/rules/` 도입 + MEMORY archival 5건 | #04~#06 |
| P1 | T1.2 | `next_candidates[]` 절제 + 부산물 mechanism redesign | #08, #12, #13 |
| P1 | T1.3 | 5 관점 review subagent 책임 redesign (scope 안 검증 집중) | #14 |
| P1 | T1.5 | Auto-Mode + 최소권한원칙 적용 | #17, #20 |
| P1 | T2.3 | RESEARCH 안 Explore agent 병렬 활용 | #15 |

### P2~P4 후속 (7건)

| 본질 | 후보 |
|---|---|
| P2 (정책 본질, mechanism 단순) | T1.4 stage 완료 context /clear · T1.7 batched push · T2.4 stage skill description 강화 |
| P3 (보완 가산) | T2.2 built-in skill 적극 활용 · T3.1 MEMORY redundancy 통합 · T3.2 ARCHITECTURE 매트릭스 lazy-load · T3.5 `/ultrareview` 활용 |
| P4 (nice-to-have) | T3.3 CHANGELOG → Releases · T3.4 Hook PoC · T3.6 Extended Thinking · T3.7 Background sessions |

본 후속 본질 = v7.0 design 본문 결과 안 적용 방식 결정 (현 9-stage 본질 = 변경 대상 → 후속 본질의 milestone 본질 자체 v7.0 결과로 변동 가능, § 176 narrative 정합).

### T4 3건 = 폐기 (본 round 확정)

| # | 폐기 본질 |
|:-:|---|
| T4.1 | propose-next mechanism 폐지 — 자율성 면 본질 보존 (next_candidates 만 절제, T1.2 안 흡수) |
| T4.2 | stage 별 subagent 전면 도입 — OPEN/INTENT/APPROVE/REPORT 부적합 (T1.3 + T2.3 안 부분 흡수) |
| T4.3 | EXECUTE phase 분할 sub-agent — lightweight 1-phase 본질 위배 |

## 의존 관계 결정 (2026-05-25)

본 round = P0+P1 7 후보 의존 관계 결정 본질. 단계별 사용자 결정 누적 → 진입 순서 그래프 + 통합 결정 매트릭스 도출.

### 진입 순서 그래프

```
Tier 0 (3 parallel base):
  ├─ T2.1 (milestone 디렉토리 폐지) — BREAKING
  ├─ T1.6a (버전 추적 mechanism) — v2.1.33+ 검출 source
  └─ T1.1 (.claude/rules/ + MEMORY archival 5건)

Tier 1:
  └─ T1.5 (Auto-Mode + 3 subagent 권한 정전화) — T1.6a+T1.1 후

Tier 2 (2 parallel):
  ├─ T1.3 (5 관점 review redesign) — T1.5 후
  └─ T2.3 (RESEARCH Explore 병렬) — T1.5 후

Tier 3:
  └─ T1.2 (next_candidates 절제) — T1.3 안 자연 흡수

Tier 1.5 (후속):
  └─ T1.6b (version-tracker subagent 권한 정전화) — T1.5 결과 활용
```

### 7 후보 통합 결정 매트릭스

| Tier | # | 결정 본질 |
|:-:|:-:|---|
| 0 | T2.1 | 디스크 1건만 + Releases migration + 기존 28+40 점진적 보존 + v7.0 자체 root 자유 형식 유지 |
| 0 | T1.6 | SessionStart hook + version-tracker subagent + `projects/meta/claude-code-version-log.md` 거주 (2 단계 분리) |
| 0 | T1.1 | `.claude/rules/` v2.1.33+ 표준 + MEMORY archival 5건 + 3-way 책임 직교 (CLAUDE.md ↔ rules ↔ MEMORY) |
| 1 | T1.5 | (B) Auto-Mode JSON + review/Explore/version-tracker 3 subagent 권한 정전화 |
| 2 | T1.3 | (D) only — 5 관점 유지 + scope 안/외 분리 (scope 안 = DESIGN.md / scope 외 = MILESTONE.md ## SCOPE_OUT_NOTES + 완료 시 Releases 흡수) |
| 2 | T2.3 | RESEARCH cb 분야 매핑 → Explore 병렬 호출 (자연 채택) |
| 3 | T1.2 | T1.3 안 자연 흡수 + lessons P2/P3 자동 enumerate 폐지 (REPORT 거주만) + 기존 27 entry 자연 소진 |

### MEMORY archival 5건 (T1.1)

1. `feedback_approve_md_schema_wrap` (schema 본질)
2. `feedback_intent_md_schema_required` (schema 본질)
3. `feedback_cascade_marker_placeholder_avoidance` (schema 본질)
4. `feedback_subagent_fact_hallucination_correction` (audit 본질)
5. `feedback_candidate_draft_decision_pending_string` (smoke 본질)

### 의존 관계 핵심 본질

- **순환 의존 해소**: T1.6 = 2 단계 분리 (a mechanism 도입 → T1.5 → b subagent 권한 정전화)
- **T1.2 자연 흡수**: T1.3 안 통합 결정 — 별 Tier 본질 부재
- **3 parallel base**: T2.1 / T1.6a / T1.1 = 의존 부재 → EXECUTE 안 병렬 진입 가능
- **review 본질 정합**: 사용자 본질 = "확정된 scope EXECUTE 전 여러 관점 디테일 분석" → (D) only 자연 (5 관점 유지 + scope 안/외 분리 archival)

### 다음 본질 (EXECUTE 본격 진입)

본 의존 관계 결정 본질 완결 → 다음 round 본질:

1. v7.0 design 본문 작성 — 본 의존 관계 그래프 기반 EXECUTE 본질 정전화
2. 새 워크플로우 본질 정의 (T1.3+T1.5+T2.3+T2.1 통합 결과)
3. adoption mechanism 결정 (v7.0 본질 본 repo 적용 본질)
4. v7.0 자체 결과 적용 (ARCHITECTURE.md / CLAUDE.md / agents/ / skills/ / hooks/ 등 본 repo 정전화)

## 다음 세션 진입 가이드

본 file 읽기 + 다음 본질 순서 진행:

1. **8 후보 우선순위 결정** — 사용자 인터뷰 (`feedback_iterative_dialog` 스무고개 방식 정합)
   - 의존 관계 식별 (예: #19 산출물 reset 정책 도입 = 이후 모든 변경 본질 영향)
   - 우선순위 (P1/P2/P3) 결정
2. **새 워크플로우 본질 정전화 (design 본문)**
   - 본 file 또는 별 file (자유 형식) 안 진행
   - 현재 9-stage 보존 vs 부분 개편 vs 완전 대체 결정
3. **adoption mechanism 결정**
   - 새 워크플로우 정전화 후 본 repo 적용 방식
   - 다음 milestone (v7.0 이후) 부터 새 워크플로우 적용 본질
4. **본 v7.0 자체 결과 적용**
   - 본 file design 완료 본질 적용 = ARCHITECTURE.md / CLAUDE.md / agents/ / skills/ / hooks/ 등 본 repo 안 정전화
   - tag v7.0 재발급 (또는 안 함 — 결정 본질)

### 본 세션 안 미진입 본질 (다음 세션 안 진입)

- 8 후보 안 우선순위 + 의존 관계
- 새 워크플로우 본질 정의 (stage 변경 / 산출물 본질 / 권한 본질 / agent + skill 도입 본질)
- 본 file 안 design 본격 진입

## 첨부 file (root 안 거주)

- `v7-0-pre-discussion.txt` — 2026-05-21 사전 논의 transcript (26 메시지)
- `prompts.txt` — 사용자 prompt 모음 (root)

## 참고 commit

- `57a01ed` — v7.0/v7.1 폐기 (옵션 B-2 full rollback)
- `9dfc217` — v6.23 last (rollback 목표 상태)
- `20b2873` — v7.0 (폐기됨, git history 보존)
- `b7d834e` — v7.1 (폐기됨, git history 보존)

## 메모리 정합

- `feedback_iterative_pre_plan_review` — design 진행 안 매 round 결정적 이슈 trigger
- `feedback_iterative_dialog` — INTENT 본질 진입 전 사용자 의도 좁혀가기, paper 일괄 제시 금지
- `feedback_token_efficiency_priority` — 토큰 효율 우선
- `feedback_section_6_2_abolished` — workflow self-improvement 본질 현재 정체성 (§ 3.1) 안 자연 부합 안 함 — 본 재설계 본질 사용자 명시 발의 (A_user) 자연 정합
- `user_non_developer_role` — 비기술 용어 + 비유 + 결정 단계별 짚어가기
