---
id: claude-autonomous-milestone-proposal
title: Claude 자율 milestone 발의 mechanism
version: v6.5
status: in_progress
---

# v6.5 — Claude 자율 milestone 발의 mechanism

## INTENT

### Spec

```json
{
  "id": "claude-autonomous-milestone-proposal",
  "title": "Claude 자율 milestone 발의 mechanism",
  "goal": "Claude 가 ROADMAP/CHANGELOG/최근 REPORT.md 를 자동 분석해 다음 milestone candidate 후보를 제안하는 mechanism 도입 — AI Native § 7.1 '자율성' 면 첫 실 적용. 자율 범위 = candidate 제안까지만 (사용자 결정 게이트 보존, 스무고개 방식 milestone 결정 선호 자연 부합). 결정 = 사용자가 후보 보고 스무고개로 좁혀 INTENT 진입. mechanism = `/propose-next` slash command 명시 호출 (v6.4 cascade-sync hybrid 정합 — slash command + script + smoke 3 컴포넌트 예상, DESIGN 안 결정). Input source = 최소 세트 (ROADMAP next_candidates[] + 최근 5 milestone REPORT.md PROPOSE 거명만 + lessons_learned 종합) — 토큰 절약 + audit chain hallucination 위험 최소화.",
  "success_criteria": [
    {"id": "sc_1", "description": "'Claude 자율 candidate 제안' mechanism 도입 — 단일 entry point (slash command `/propose-next` 또는 script, DESIGN 안 결정). 입력 = 최소 세트 (ROADMAP next_candidates[] + 최근 5 milestone REPORT.md PROPOSE 거명만 + lessons_learned). 동작 = 자동 분석 → candidate 후보 N건 제안. 구체 구현 형태 (slash command vs script vs hybrid) + invocation interface 는 DESIGN 안 결정."},
    {"id": "sc_2", "description": "Input source enumerate 방식 도입 — DESIGN 안 옵션 결정 (한 번에 N 파일 Read / glob 패턴 / 캐시). 최근 5 milestone REPORT.md 안 PROPOSE 섹션 grep + lessons_learned 안 P2 거명만 항목 grep = 자율 발의 source 본질. RESEARCH 안 v3.18~v6.4 누적 27 milestone REPORT 안 PROPOSE 분포 + 거명만 항목 실측 통계 + context7 안 Claude Code Plugin slash command spec cross-validate."},
    {"id": "sc_3", "description": "Output 형식 + 출력 host 도입 (round 4 결정 = ROADMAP `candidate_draft[]` 새 필드 활용) — Claude 자율 제안 시 `candidate_draft[]` append + 사용자 review 후 채택 → `next_candidates[]` 이동 / 거절 → 삭제. trace 명확 (channel 분리 staging area) + 사용자 결정 게이트 보존 (round 1) 자연 부합. ROADMAP schema A2 안 이미 존재 (line 9 빈 array). 대화창 동시 출력 = UX (사용자가 바로 확인). 구체 schema (id/title/trigger/origin/score/rationale 등 필드) = DESIGN 안 결정."},
    {"id": "sc_4", "description": "도그푸드 self-check — 본 v6.5 mechanism 도입 후 1 회 호출 → next milestone (v6.6 후보) candidate 자동 제안. round 1 자율 범위 결정 정합 — Claude 가 candidate 만 제안, 사용자가 보고 스무고개로 좁혀 INTENT 진입 결정. v3.21 narrative 정전화 3 단계 패턴 cycle 30 자기참조 부합 (mechanism 도입 milestone 안 mechanism 자체 적용 = self-host, v6.4 cycle 29 정합)."},
    {"id": "sc_5", "description": "회귀 0 — 기존 smoke 9종 (projects-scope-discipline / spec-verification / scope-contract / cross-ref / claude-md-drift / bundle-trigger / open-stage-discipline / entry-title-guideline / cascade-drift) + 신규 smoke (DESIGN 안 결정, 0 또는 1종) 모두 PASS, pre-commit 현 16 hook 모두 PASS. `/propose-next` 명시 호출 mechanism (pre-commit 자동 호출 oos)."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "Claude 자율 결정 게이트 (OPEN/INTENT 자동 진입)", "reason": "round 1 사용자 결정 자율 범위 = candidate 제안까지만. 사용자 결정 게이트 (INTENT 진입 결정) 보존 = 스무고개 방식 milestone 결정 선호 (feedback_iterative_dialog) 자연 부합. OPEN/INTENT draft 자동 생성 + APPROVE 만 사용자 = round 1 거절 옵션."},
    {"id": "oos_2", "item": "PostToolUse hook 안 trigger 자동화 (REPORT 완료 시 자동 분석)", "reason": "round 2 사용자 결정 trigger = '명시 slash command 호출'. hook 안 자동 trigger 는 토큰 비용 + 사용자 모르는 사이 ROADMAP 변경 가능성 + 자율 범위 round 1 결정과 균형 trade-off — v6.x 후속 candidate 거명만."},
    {"id": "oos_3", "item": "넓은 input source (전체 CHANGELOG + git log + memory + 코드 grep)", "reason": "round 3 사용자 결정 input = 최소 세트 (ROADMAP next_candidates[] + 최근 5 milestone REPORT PROPOSE 거명만 + lessons_learned). 토큰 비용 2~4배 + audit chain hallucination 위험 증가 (memory feedback_subagent_fact_hallucination_correction cycle 3 evidence) — v6.x 후속 candidate."},
    {"id": "oos_4", "item": "외부 projects/<name> (예: upbit) Claude 자율 발의 확장", "reason": "meta scope 한정. 외부 projects/<name> 적용은 v6.5 안정화 후 vector 누적 evidence 도달 시 별 milestone (외부 적용 패턴 v5.10/v5.14/v5.15/v5.17/v5.19 정합)."},
    {"id": "oos_5", "item": "Claude 자율 발의 후 자동 ROADMAP `next_candidates[]` append 없이 대화창 only", "reason": "사용자 결정 게이트 보존 (round 1) + ROADMAP archival 본질 (v5.21 schema A2). 출력 형식은 DESIGN 안 결정 — append 후 사용자가 채택/거절 trace 보장 vs 대화창 only 채택 시 사용자 명시 ROADMAP edit 의무 trade-off."}
  ],
  "dependencies": [
    {"id": "dep_1", "source": "pre-PLAN dialog 3 round (2026-05-20)", "purpose": "사용자 결정 source — (1) 자율 범위 candidate 제안까지만 / (2) Trigger 명시 slash command / (3) Input source 최소 세트"},
    {"id": "dep_2", "source": "v6.0 INTENT.oos_4 + ROADMAP next_candidates[] target_version v6.5", "purpose": "본 milestone origin 정전 source (자율성 면 첫 실 적용)"},
    {"id": "dep_3", "source": "v6.4 cascade-sync hybrid 패턴 (slash command + script + smoke 3 컴포넌트)", "purpose": "DESIGN 안 mechanism 구현 형태 참조 source"},
    {"id": "dep_4", "source": "v3.18~v6.4 누적 27 milestone REPORT.md 안 PROPOSE 분포", "purpose": "RESEARCH 안 자율 발의 source 본질 실측 통계 source"},
    {"id": "dep_5", "source": "v6.2 5 관점 subagent 병렬 검토 패턴 (Plan + general-purpose × 4) + cycle 3 누적 (v6.2 + v6.3 + v6.4)", "purpose": "DESIGN stage 적용 (feedback_subagent_parallel_review_evidence cycle 4 자연 부합)"},
    {"id": "dep_6", "source": "feedback_anthropic_yaml_frontmatter_pattern + v6.1 hybrid schema + v6.2 flattened era", "purpose": "MILESTONE.md 단일 본책 + INTENT/RESEARCH/DESIGN H2 안 `### Spec` + ```json``` body 적용"},
    {"id": "dep_7", "source": "memory feedback (iterative_dialog / non_developer_role / iterative_pre_plan_review / token_efficiency_priority / subagent_fact_hallucination_correction)", "purpose": "작업 톤 가이드 + 매 round 결정적 이슈 trigger 의무 + audit chain fact 검증 (v5.13/v5.18 절차 정합)"},
    {"id": "dep_8", "source": "context7 — Claude Code Plugin slash command spec + 자율 추천/제안 패턴 (recommendation system)", "purpose": "RESEARCH ext_* source — mechanism 옵션 (slash command vs script vs hybrid) 외부 spec cross-validate"},
    {"id": "dep_9", "source": "schedule skill (system 안 available, v4.0 phase-7 narrative 안 활용 의도) — v6.5 미활용", "purpose": "v4.0 narrative 안 'schedule skill 주 1회 cron' 본질 source 명시. v6.5 미활용 rationale = round 2 결정 (Trigger = 명시 slash command) — cron 자동 trigger 후속 candidate 거명만 (P2 후속, 5 관점 architecture P1_arch_4 흡수)."}
  ]
}
```

### Motivation

v6.0 INTENT.oos_4 origin (AI Native § 7.1 '자율성' 면 시리즈 후보 #1). v6.4 cascade-sync (다중 AI 협업 면) 완료 후 자연 후속.

**자율 candidate 제안 필요성 evidence** (v3.18~v6.4 누적):

- 매 milestone PROPOSE 단계 안 next_candidates 거명만 항목 = **수동 발의 source**. 사용자가 ROADMAP 직접 열어 next_candidates[] 안 항목 보고 다음 milestone 결정 = 인지 cost.
- 최근 5 milestone REPORT.md 안 lessons_learned (LN) + P2 거명만 항목 = **잠재 candidate**. 자동 종합 분석 → 우선순위 제안 가능.
- AI Native § 7.1 '자율성' 면 첫 실 적용 — Claude 가 능동 후보 제안 + 사용자 결정 게이트 보존 = AI native 협업 본질.

pre-PLAN 4 round 누적 결정 (2026-05-20):

1. **자율 범위** — candidate 제안까지만 (사용자 결정 게이트 보존, 스무고개 방식 milestone 결정 선호 [feedback_iterative_dialog] 자연 부합)
2. **Trigger** — 명시 slash command `/propose-next` (v6.4 cascade-sync hybrid 패턴 정합)
3. **Input source** — 최소 세트 (ROADMAP next_candidates[] + 최근 5 milestone REPORT.md PROPOSE 거명만 + lessons_learned)
4. **Output 형식** — ROADMAP `candidate_draft[]` 새 필드 활용 (이미 존재, 빈 array) + 대화창 동시 출력. 사용자 채택 → `next_candidates[]` 이동 / 거절 → 삭제. trace 명확 + 결정 게이트 보존.

### Harness engineering mapping

- **element**: Workflow (1차) + Context (보조)
- **target**: PROPOSE stage 안 next_candidates 발의 cycle 자동화 — 사용자 인지 cost 단축 + 잠재 candidate 누락 회귀 회피
- **rationale**: AI Native § 7.1 3 면 안 **자율성 면 첫 실 적용** (v6.3 Verification 면 → v6.4 다중 AI 협업 → v6.5 자율성). Claude = 능동 발의 + 사용자 = 최종 결정 = AI native 협업 본질.

### 명료화

#### 본 milestone 의 위치 — AI Native 시리즈 v6.5

| Version | 본질 | AI Native 면 |
|:-:|------|------|
| v6.0 (완료) | 정의 + entry title 가이드 | 정의 정전화 |
| v6.1 (완료) | JSON 필드 감축 (Anthropic 하이브리드) | 컨텍스트 효율 (cycle 1) |
| v6.2 (완료) | 디렉토리 평탄화 (b) 하이브리드 | 컨텍스트 효율 (cycle 2) |
| v6.3 (완료) | entry title 가이드 smoke 자동 검증 | Verification (첫 실 적용) |
| v6.4 (완료) | cascade 자동 동기 mechanism | 다중 AI 협업 (첫 실 적용) |
| **v6.5 (본)** | Claude 자율 milestone 발의 mechanism | **자율성 (첫 실 적용)** |
| v6.6 (예약) | hallucination 자동 정정 mechanism | 다중 AI 협업 (cycle 2) |
| v7.0 (예약, major) | 3 면 통합 | — |

#### 자율 범위 명료화 — "candidate 제안까지만" 의 정확한 경계

| 단계 | 자율 (Claude) | 결정 (사용자) |
|------|:-:|:-:|
| ROADMAP `next_candidates[]` 후보 자동 분석/제안 | ✅ | — |
| 후보 보고 우선순위 결정 + 스무고개 좁히기 | — | ✅ |
| OPEN/INTENT 진입 결정 | — | ✅ |
| INTENT/RESEARCH/DESIGN draft 작성 | (기존 workflow 정합) | (기존 workflow 정합) |
| APPROVE 게이트 | — | ✅ |

= round 1 결정 본질. 본 milestone 은 **첫 column** 만 자동화 (사용자 인지 cost 단축).

## RESEARCH

### Spec

```json
{
  "codebase": [
    {"id": "cb_1", "topic": "ROADMAP.md `candidate_draft[]` 신 필드 기존 narrative", "finding": "v4.0_harness-composer-pivot phase-7 안 도입 narrative — '벤치마크 cycle routine schedule skill 주 1회 cron (GitHub 인기 repo + Claude Code release notes/changelog). 산출물 host = projects/meta/ROADMAP.md 안 candidate_draft[] 신 필드'. CHANGELOG.md [v4.0] entry 안 정의 정전화. schema_note 안 entry schema = id/title/source/detected_at/rationale/category/decision_pending. bootstrap/agents/CLAUDE.md:163 + :173 안 cascade host narrative.", "evidence": "Grep `candidate_draft` 20 위치 — ROADMAP.md:9 (현재 빈 array) + CHANGELOG.md:40/331/337 + bootstrap/agents/CLAUDE.md:163/173 + v5.8 RESEARCH/REPORT 등."},
    {"id": "cb_2", "topic": "candidate_draft[] 실 작동 0건 evidence", "finding": "v5.8_identity-application-vector-audit RESEARCH § R4: 'candidate_draft_entries: 0건 (벤치마크 cycle routine 미실행)'. v4.0 PROPOSE #4 'benchmark-routine-first-run' = decision_pending: '사용자 환경 의존, schedule 등록 후 첫 candidate_draft entry 발생 시 검토'. schedule 등록 자체 미실행 → 작동 0건. v6.5 가 첫 실 작동 mechanism = candidate_draft[] 정전 narrative 의 1년 만의 실 채움.", "evidence": "v5.8/RESEARCH.md:34-35 + R4 통계 § 117."},
    {"id": "cb_3", "topic": "v6.0~v6.4 PROPOSE 섹션 format 진화 (input source 형식)", "finding": "v6.0 + v6.1 = 별 PROPOSE.md 파일 (9-stage-bundled era, frontmatter `stage: PROPOSE` + ## Spec). v6.2 + v6.3 + v6.4 = MILESTONE.md 안 ## PROPOSE H2 (9-stage-flattened era). 두 형태 모두 `### Spec` + ```json``` body 안 `next_candidates_named_only[]` (lightweight) 또는 `next_candidates[]` 안 ROADMAP 등재 본질. v6.5 mechanism 은 두 형태 모두 enumerate 필요.", "evidence": "v6.0/PROPOSE.md:3 + v6.1/PROPOSE.md:4 + v6.2/MILESTONE.md:9 + v6.3:18 + v6.4:5 (## PROPOSE count)."},
    {"id": "cb_4", "topic": "v6.4 cascade-sync hybrid 패턴 (참조 source)", "finding": "claude/commands/cascade-sync.md (slash command UX orchestrator) + scripts/cascade_sync.py (deterministic core, ~220 LOC, hash compare 안 normalize_whitespace + SHA-256 16-hex prefix + path traversal 차단 + fixed argument list) + tests/smoke-cascade-drift.sh (read-only drift detect). slash command frontmatter: `allowed-tools: Bash, Read` + `argument-hint: \"[apply]\"`. dry-run default (--check) + --apply 사용자 명시. v6.5 mechanism 형태 결정 안 직접 참조 source.", "evidence": "scripts/cascade_sync.py:1-100 + claude/commands/cascade-sync.md 전체."},
    {"id": "cb_5", "topic": "최근 5 milestone REPORT.md/MILESTONE.md 안 lessons_learned 분포", "finding": "v6.0~v6.4 안 lessons_learned 5건 + 추가 7건 = ~30~40건 누적. 각 lesson 안 `narrative_priority` 또는 P1/P2 라벨. P2 거명만 항목 = 잠재 candidate (수동 발의 source). v6.4 PROPOSE 안 27건 P2 거명만 (cycle 3 평균). 본 mechanism 의 핵심 input source.", "evidence": "v6.0~v6.4 MILESTONE.md / PROPOSE.md 안 lessons_learned 표."},
    {"id": "cb_6", "topic": "schedule skill 기존 존재 (system reminder)", "finding": "available skills 안 `schedule` skill 존재 — 'Create, update, list, or run scheduled remote agents (routines) that execute on a cron schedule'. v4.0 phase-7 narrative 안 'schedule skill 활용 주 1회 cron' = 본 skill 활용 의도. v6.5 mechanism 은 cron 자동 trigger oos (round 2 결정) 라 schedule skill 미활용 — `/propose-next` 명시 호출 만.", "evidence": "system reminder available skills 안 schedule entry."}
  ],
  "external": [
    {"id": "ext_1", "source": "context7 /websites/code_claude — Slash Command Frontmatter spec", "finding": "frontmatter 표준 패턴: `allowed-tools` (List, 예: `Bash, Read, Grep, Glob`) + `description` + `model` (`claude-opus-4-7` 등) + `argument-hint`. Bash 도구 호출 패턴 = `!`backticks`` 직접 호출 (예: `current status: !`git status``). v6.4 cascade-sync.md 형식 직접 정합. v6.5 `/propose-next` = `allowed-tools: Bash, Read, Grep, Glob` 예상.", "cross_validate": "v6.4 cascade-sync.md frontmatter + claude/CLAUDE.md § slash 명령 추가 가이드 = `allowed-tools` YAML list + model 책임 선택."},
    {"id": "ext_2", "source": "Claude Code Plugin Skills spec (memory feedback_anthropic_yaml_frontmatter_pattern)", "finding": "YAML frontmatter 안 최소 메타 (name/description/triggers) + Markdown body. 본 mechanism = slash command + script 형태 (skill 형태 아님) — frontmatter description 안 trigger 본질 충분.", "cross_validate": "v6.4 + claude/commands/ 안 .md 파일 frontmatter 형식 직접 정합."}
  ],
  "options": [
    {"id": "o_1", "topic": "mechanism 구현 형태", "options": ["(a) slash command + python script (v6.4 hybrid 정합)", "(b) slash command only (Bash 안 grep/Read 만 활용)", "(c) script only (slash command 부재, 직접 호출)"], "rationale": "(a) = v6.4 정합 + deterministic core 분리 trace + 토큰 효율 (script 안 logic 비용 0 token). (b) = LLM 안 logic = 자유도 높음 + 토큰 비용 매 호출. (c) = UX layer 부재 + 사용자 결정 게이트 게재 위치 fuzzy. **DESIGN 안 (a) 선택 예상** (v6.4 cycle 2 정합 + token efficiency priority memory 정합)."},
    {"id": "o_2", "topic": "분석 logic (script 안)", "options": ["(d) rule-based grep (PROPOSE 섹션 안 next_candidates_named_only / P2 라벨 항목 enumerate)", "(e) heuristic 점수 (각 후보의 origin count + lesson 빈도 등 가중)", "(f) LLM 자체 추론 (script 가 단순 enumerate, slash command 안 LLM 이 우선순위 결정)"], "rationale": "(d) = deterministic + 검증 가능 + audit chain hallucination 위험 0. (e) = 점수 logic 복잡도 + 검증 cost. (f) = LLM 추론 = hallucination 위험 (memory feedback_subagent_fact_hallucination_correction cycle 3). **DESIGN 안 (d) + (f) hybrid 예상** — script (d) enumerate + slash command 안 LLM (f) summary/우선순위 보고 (사용자 결정 게이트 보존)."},
    {"id": "o_3", "topic": "Output 형식 + 출력 host (INTENT sc_3 round 4 결정 candidate_draft[] 활용 확정)", "options": ["INTENT round 4 결정 = ROADMAP candidate_draft[] append + 대화창 동시 출력. schema 구체 (id/title/source/detected_at/rationale/category/decision_pending 등 필드) = DESIGN 안 결정."], "rationale": "candidate_draft[] 신 필드 기존 schema (cb_1) 직접 reuse — 추가 schema 도입 불요. category 필드 = 'autonomous_proposal' 신 값 도입 (벤치마크 cycle = 'benchmark_external' vs 자율 발의 = 'internal_synthesis' 식, DESIGN 안 결정). detected_at = ISO date. decision_pending = '사용자 명시 검토 대기'."},
    {"id": "o_4", "topic": "smoke 도입 여부", "options": ["(g) smoke 신규 도입 (예: tests/smoke-candidate-draft-schema.sh — candidate_draft entry schema 강제)", "(h) 기존 smoke 활용 (smoke-spec-verification 안 candidate_draft entry 안 필드 검증 흡수)", "(i) smoke 부재 (mechanism 자체 사용자 명시 호출 + 사용자 review = guardrail)"], "rationale": "(g) = 신규 smoke 비용 + 첫 entry 도입 시 도그푸드 가능. (h) = 통합 + 기존 smoke 확장 cost. (i) = 사용자 review = 충분 guardrail. **DESIGN 안 (i) 또는 (g) 최소 schema 검증 결정**."},
    {"id": "o_5", "topic": "도그푸드 시점", "options": ["(j) EXECUTE phase-2 안 mechanism 도입 직후 1 회 호출 → v6.6 후보 candidate_draft[] append", "(k) VERIFY 안 1 회 호출 + v6.6 후보 후속 검토", "(l) 도그푸드 skip (외부 milestone 안 첫 호출)"], "rationale": "(j) = v3.21 cycle 30 자기참조 부합 (v6.4 cycle 29 정합) + 첫 실 작동 evidence. (k) = VERIFY 안 검증 source. (l) = 자기참조 부합 약화. **DESIGN 안 (j) 예상**."}
  ],
  "risks_identified": [
    {"id": "r_1", "risk": "Claude 가 자율 candidate 제안 시 hallucination (잘못된 정보 또는 존재하지 않는 source 인용)", "mitigation": "v5.13/v5.18 fact 검증 절차 정합 — script 가 enumerate 한 deterministic source 만 reference + slash command 안 LLM summary 시 source 인용 필수 (rationale 필드 안 origin_milestone + line/section 명시). cycle 3 hallucination evidence (memory feedback_subagent_fact_hallucination_correction)."},
    {"id": "r_2", "risk": "토큰 비용 — REPORT 5건 + lessons 종합 read 매 호출", "mitigation": "최근 5 milestone limit (round 3 결정) + script 안 grep 으로 PROPOSE/lessons 섹션만 추출 (전체 Read 회피). slash command 안 LLM input = script 가 추출한 핵심 분만."},
    {"id": "r_3", "risk": "사용자 결정 게이트 미세 위반 — 자동 ROADMAP 변경 (candidate_draft[] append)", "mitigation": "round 4 결정 = candidate_draft[] (staging area) 활용. next_candidates[] 와 분리 = 사용자 채택 시만 이동. 대화창 동시 출력 = 사용자 immediate awareness. slash command 안 'append 진행할까요? (y/n)' 사용자 명시 응답 받기 (v6.4 cascade-sync Step 3 정합)."},
    {"id": "r_4", "risk": "candidate_draft[] 진입 entry 후 사용자 review 없으면 stale 누적", "mitigation": "smoke 안 stale check (예: detected_at > N 일 + 사용자 결정 부재 = WARN) DESIGN 안 결정. 또는 사용자 review cycle 운영 narrative (v5.21 archival cycle 정합)."},
    {"id": "r_5", "risk": "v4.0 phase-7 안 '벤치마크 cycle routine' 기존 narrative 와 충돌 가능", "mitigation": "두 mechanism 의 input source 본질 다름 — v4.0 = 외부 (GitHub repo + release notes) / v6.5 = 내부 (ROADMAP + REPORT + lessons). 같은 host (candidate_draft[]) 적재 + category 필드 분리 (DESIGN 안 결정) = 충돌 회피. v4.0 narrative 명료화 narrative cascade 가능 (DESIGN 안 결정)."},
    {"id": "r_6", "risk": "spec-drift — Claude Code slash command spec 변경 시 frontmatter 위반", "mitigation": "v5.7 spec-drift spike 패턴 정합 — RESEARCH 안 context7 query (ext_1) cross-validate + DESIGN 또는 Stage F 안 spike (c) 분기 자연 흡수. v6.4 cascade-sync.md 형식 직접 정합 = baseline."},
    {"id": "r_7", "risk": "audit chain hallucination cycle 4 도래 가능 — Claude 가 자율 발의 시 source fact 검증 누락", "mitigation": "Input Verification 패턴 (v5.18 정합) — slash command 안 rationale 필드 안 source line/section 인용 의무. 사용자 review 시 source 직접 확인 + 명시 채택. memory feedback_subagent_fact_hallucination_correction cycle 4 자연 발현 가능성 인지."}
  ]
}
```

### Codebase findings summary

v6.5 mechanism 의 host = `candidate_draft[]` 신 필드 (v4.0 phase-7 안 도입 narrative). v5.8 RESEARCH evidence = **작동 0건** (~ 1년). v6.5 가 첫 실 작동 mechanism — candidate_draft[] schema (id/title/source/detected_at/rationale/category/decision_pending) 의 첫 실 채움.

v6.4 cascade-sync hybrid 패턴 = 직접 참조 source. slash command (UX orchestrator) + python script (deterministic core) + smoke (read-only validation) 3 컴포넌트.

### External findings summary

context7 query 1건 (`/websites/code_claude` — slash command frontmatter spec) cross-validate — `allowed-tools` YAML list + `description` + `model` + `argument-hint` 표준 패턴. v6.4 cascade-sync.md 형식 직접 정합.

### Options summary

- **o_1 (구현 형태)**: (a) slash command + script hybrid (v6.4 cycle 2 정합) — DESIGN 안 확정 예상
- **o_2 (분석 logic)**: (d) script grep + (f) LLM summary hybrid — DESIGN 안 확정 예상
- **o_3 (Output 형식)**: INTENT round 4 결정 = candidate_draft[] 활용. schema 구체 = DESIGN
- **o_4 (smoke)**: (g) 또는 (i) — DESIGN 안 결정
- **o_5 (도그푸드)**: (j) EXECUTE phase-2 안 1 회 호출 — DESIGN 안 결정

### Risks summary

r_1~r_7 = hallucination + 토큰 비용 + 결정 게이트 미세 위반 + stale 누적 + v4.0 narrative 충돌 + spec-drift + audit chain hallucination cycle 4 자연 발현. mitigation = fact 검증 절차 (v5.13/v5.18) + staging area 분리 (candidate_draft[]) + 사용자 명시 응답 (v6.4 정합).

## DESIGN

### Spec

```json
{
  "decisions": [
    {"id": "D1", "topic": "Mechanism 구현 형태", "decision": "(a) slash command + python script + smoke 3 컴포넌트 hybrid (v6.4 cascade-sync 정합, cycle 2). claude/commands/propose-next.md (UX orchestrator) + scripts/propose_next.py (deterministic core, ~150~250 LOC) + tests/smoke-candidate-draft-schema.sh (schema validation).", "rationale": "RESEARCH o_1 (a). v6.4 cycle 2 정합 + deterministic core 분리 trace + token efficiency priority (script logic 비용 0 token, LLM 비용 summary 만)."},
    {"id": "D2", "topic": "분석 logic 분리", "decision": "(d)+(f) hybrid — script grep (deterministic enumerate of PROPOSE next_candidates_named_only + lessons P2 라벨 항목) + slash command LLM summary (우선순위 + rationale 작성). script = source 추출 단일 책임. LLM = 의미 분석 + 사용자 친화 표현 단일 책임.", "rationale": "RESEARCH o_2 — deterministic source = audit chain hallucination 위험 0 + LLM summary 안 source 인용 의무 (rationale 필드 안 origin_milestone + section 명시) = fact 검증 절차 (v5.13/v5.18) 자연 부합."},
    {"id": "D3", "topic": "candidate_draft[] entry schema (v4.0 narrative 기존 schema 확장)", "decision": "기존 7 필드 (id/title/source/detected_at/rationale/category/decision_pending) 정합 보존 + `category` 필드 안 enum 명시: 'internal_synthesis' (v6.5 자율 발의) | 'benchmark_external' (v4.0 벤치마크 cycle routine). 추가 필드 0 (Anthropic YAML frontmatter 최소 메타 패턴 정합 + INTENT.dep_6 sc 정합). **fact 정정 (cycle 4 hallucination evidence)**: 5 관점 외부 vector agent P1#1 = 'v4.0 PROPOSE.md:54 안 category fleet-evolution 명시' 주장 = hallucination. grep verify 결과 v4.0/PROPOSE.md 안 `category` 0 매치 — fact 부재 (v5.13/v5.18 fact 검증 절차 cycle 4 자연 발현, memory feedback_subagent_fact_hallucination_correction direct evidence). 따라서 D3 enum 결정 = v6.5 신규 정전화 (v4.0 narrative 안 category 3 축 기존 분류 부재).", "rationale": "round 5 결정 = category 필드 분리. v4.0 narrative + v6.5 mechanism 공존. ROADMAP `schema_note` 안 category enum 명시 cascade (D8)."},
    {"id": "D4", "topic": "Output 형식 + 출력 host (INTENT sc_3 round 4 결정 정합)", "decision": "ROADMAP `candidate_draft[]` direct append + 대화창 동시 출력. `/propose-next` slash command 안 사용자 명시 응답 (y/n) 받기 (v6.4 cascade-sync Step 3 정합). y = append + 'review 후 채택 시 next_candidates[] 이동, 거절 시 삭제' narrative. n = append skip + 대화창 출력 만 보존.", "rationale": "INTENT round 4 결정 + r_3 mitigation (staging area + 사용자 명시 응답)."},
    {"id": "D5", "topic": "smoke 도입 (5 관점 arch P1_arch_2 흡수 — 단일 책임 명료화)", "decision": "(g) tests/smoke-candidate-draft-schema.sh 신규 — read-only schema validation. **단일 책임 = 'candidate_draft[] entry 안 7 필드 존재 + category enum 2 값 한정 검증'** (boolean schema validation). ISO 8601 date format 검증은 보조 (json validity 가 1차, format 미세 차이는 false-positive 위험 = 단일 책임 외 보조 위치). pre-commit 등재.", "rationale": "RESEARCH o_4 (g) + arch P1_arch_2 흡수. v6.3 entry-title smoke 단일 책임 정합 (v6.3 = ' + ' 부재 + ≤ 60자 2 책임 같은 source 분리, v6.5 = field 존재 + enum 단일 source). v6.4 cascade-drift smoke 정합."},
    {"id": "D6", "topic": "도그푸드 시점", "decision": "(j) EXECUTE phase-2 안 mechanism 도입 직후 1 회 호출 → v6.6 후보 candidate_draft[] append (자기참조 cycle 30 자연 부합).", "rationale": "RESEARCH o_5 (j). v3.21 narrative 정전화 3 단계 패턴 cycle 30 (v6.4 cycle 29 정합) + 첫 실 작동 evidence + sc_4 직접 충족."},
    {"id": "D7", "topic": "phase 구조 (arch P1_arch_5 흡수 — v6.4 cascade-sync mechanism 자체 도그푸드)", "decision": "2 phase — phase-1 (mechanism 도입: slash command + script + smoke + ARCHITECTURE 안 자율 발의 narrative 정전화 + cascade marker 추가 + v4.0 narrative category 분리 명시 + **phase-1 끝 안 `/cascade-sync --check` 호출 검증 step 추가 = v6.4 mechanism × v6.5 narrative cascade 자기참조 cycle 31**) / phase-2 (도그푸드 1 회 호출 `/propose-next` + ROADMAP archival v6.2 → CHANGELOG + REPORT.md lessons + PROPOSE).", "rationale": "v6.4 정합 (2 phase). lightweight 분포 (현재 14/32 = 43.75% per memory) 정합. arch P1_arch_5 흡수 — v6.4 mechanism 자체 적용 = 자기참조 cycle 31 (v6.4 = cycle 29 self-host, v6.5 = cycle 30 자기 narrative cascade + cycle 31 v6.4 mechanism × v6.5 narrative 양 cycle 자연 결합)."},
    {"id": "D8", "topic": "cascade narrative 정전화 위치 (외부 vector P1#2 흡수 — 정확 위치 명시)", "decision": "ARCHITECTURE.md 신규 § (예: § 4 끝 매트릭스 #9 row, 'Claude 자율 milestone 발의 mechanism') paragraph 정전화 + explicit anchor (`<a id=\"section-4-end-row-9\">`) + v6.4 mechanism (`<!-- cascade-source: ... expected-hash:... -->` marker) 적용. cascade host 2 위치 정확 명시: (1) root CLAUDE.md § 명령어 안 narrative 1 줄 인용 (v6.4 cycle 29 정합) / (2) bootstrap/agents/CLAUDE.md:163 paragraph 안 'candidate_draft[] 안 category enum 2 축 분리 (internal_synthesis vs benchmark_external)' narrative 추가 + :186-196 entry 예시 안 category 필드 값 추가 (현재 부재).", "rationale": "v3.21 narrative 정전화 3 단계 패턴 cycle 30 + v6.4 cycle 29 정합 + 도그푸드 (mechanism 도입 milestone 안 mechanism 자체 적용 = self-host) + 외부 vector P1#2 cascade 정확 위치 명시 흡수."},
    {"id": "D9", "topic": "frontmatter spec (`/propose-next`)", "decision": "frontmatter: `description: Claude 자율 candidate 제안 mechanism (ROADMAP + 최근 5 milestone REPORT + lessons 분석 → candidate_draft[] append, v6.5)` + `allowed-tools: Bash, Read, Grep` + `argument-hint: \"[dry-run]\"` (dry-run 기본 = candidate_draft[] append 안 함, 명시 적용 시 append). model 필드 미명시 (default inherit, v6.4 cascade-sync 정합).", "rationale": "RESEARCH ext_1 cross-validate + v6.4 cascade-sync.md 정합 + dry-run default 안전성 (D4 정합)."},
    {"id": "D10", "topic": "script logic 단일 책임 + 입력/출력 interface (arch P1_arch_1 + sec P1_sec_1/2/3 흡수)", "decision": "scripts/propose_next.py — CLI args **분리** (arch P1_arch_1 흡수): `--scan` (default, read-only enumerate → JSON to stdout) | `--list-candidates` (read-only, 현재 ROADMAP candidate_draft[] 출력). **--append 분리** = script 안 미포함, slash command 안 Bash Edit 도구 직접 호출 (v6.4 cascade-sync.md step 3 정합). script 단일 책임 = read-only enumerate. **input validation 3축 (sec P1_sec_1/2/3 흡수)**: (1) length bound — args 별 regex `[^\\s]{1,N}` (v6.4 MARKER_REGEX 정합), (2) charset bound — id `^[a-z0-9-]{1,64}$` (next_candidates regex 정합) / title ≤ 60자 (entry title 가이드 정합) / category enum strict, (3) path traversal 차단 — source 필드 안 path-like string verify `is_relative_to(REPO_ROOT)` (v6.4 D12 정합). JSON 출력 = `json.dumps()` 의무 (raw string interpolation 금지) + round-trip self-check (`json.loads(output)`). fixed argument list (v6.4 D13 정합, subprocess injection 차단).", "rationale": "v6.4 cascade_sync.py 패턴 정합 + 결정 게이트 분리 (scan = read-only, append = slash command 책임). 5 관점 cycle 4 P1 4건 (arch_1 + sec_1+2+3) 흡수."},
    {"id": "D11", "topic": "최근 5 milestone enumerate 방식 (arch P1_arch_3 흡수 — fallback 우선순위 명료화)", "decision": "**1차 (default)**: 디렉토리 enumerate — `projects/meta/milestones/v*/` directory name 안 semver descending 정렬 (v6.4 → v6.3 → v6.2 → v6.1 → v6.0). 각 디렉토리 안 MILESTONE.md (v6.2+ flattened) 또는 PROPOSE.md (v6.0~v6.1 bundled) read. **2차 (cross-validate)**: ROADMAP `milestones[]` recent 3 + CHANGELOG.md 상단 archival entry 2건 cross-validate (v5.18 Input Verification 패턴 정합). 1차 디렉토리 enumerate = 직접 source / 2차 = ROADMAP/CHANGELOG fact 정합 검증 (불일치 시 stderr warn + 1차 우선).", "rationale": "arch P1_arch_3 흡수 — fallback 우선순위 명료화. v5.18 Input Verification 패턴 정합 = 직접 source 1차 + ROADMAP/CHANGELOG cross-validate 2차. schema A2 recent 3 만 보존 cycle = source 부족 보완."},
    {"id": "D12", "topic": "스무고개 방식 milestone 결정 선호 보존 verify (dialog P1-1 + P1-2 흡수)", "decision": "slash command orchestrator 안 LLM summary 가이드라인 (claude/commands/propose-next.md 안 narrative): (1) **최우선 1건 우선 보고** (paper 일괄 제시 회피, dialog P1-1 흡수) — '가장 우선 후보 1건 = ... + rationale + source. 추가 N-1건 후보 표시할까요?' 사용자 명시 요청 후 추가. (2) **비유 + 결정 단계별 표현** (dialog P1-2 흡수) — 기술 용어 회피, 예: 'candidate_draft[]' → '아직 결정 안 한 후보 명단' / 'internal_synthesis' → '내부 진척 후 떠오른 아이디어' / 'benchmark_external' → '외부 트렌드 발견' / 'lessons_learned P2 라벨' → '이전 작업 후속 후보 거명'. user_non_developer_role 정합.", "rationale": "memory feedback_iterative_dialog (paper 일괄 제시 금지) + user_non_developer_role (비유 표현) 두 patron 직접 흡수. round 1 결정 (자율 범위 = candidate 제안까지만) + r_3 mitigation."}
  ],
  "approach": "scripts/propose_next.py = deterministic enumerate + JSON 출력. claude/commands/propose-next.md = LLM orchestrator (script 호출 → JSON parse → 우선순위 + rationale 요약 → 사용자 응답 → candidate_draft[] append). tests/smoke-candidate-draft-schema.sh = 7 필드 + category enum + detected_at ISO 강제. ARCHITECTURE.md § 4 끝 신규 row + paragraph 정전화 + cascade marker (v6.4 mechanism 적용 = 자기참조 cycle 30).",
  "phases": [
    {"id": "phase_1", "title": "mechanism 도입 + 정전화 + cascade", "steps": ["scripts/propose_next.py 작성 (~150~200 LOC, --scan + --list-candidates read-only, --append 미포함 D10 정합, input validation 3축 sec P1 흡수, fixed argument list, path traversal 차단)", "claude/commands/propose-next.md 작성 (frontmatter + 5 step orchestrator, v6.4 cascade-sync.md 정합, append 책임 = LLM 안 Bash Edit 도구 직접 호출 + D12 비유 가이드라인 + 최우선 1건 우선 보고)", "tests/smoke-candidate-draft-schema.sh 작성 (read-only schema validation 단일 책임 = 7 필드 존재 + category enum 2 값, D5 정합. pre-commit 등재)", "ARCHITECTURE.md § 4 끝 신규 row #9 + paragraph 정전화 + explicit anchor `<a id=\"section-4-end-row-9\">` + cascade marker `<!-- cascade-source: ... expected-hash:... -->`", "root CLAUDE.md § 명령어 안 narrative 1 줄 cascade host (cascade marker 포함) + bootstrap/agents/CLAUDE.md:163 paragraph 안 category 분리 narrative + :186-196 entry 예시 안 category 필드 값 추가 (D8 정확 위치)", "ROADMAP.md schema_note 안 category enum ('internal_synthesis'|'benchmark_external') 명시", ".pre-commit-config.yaml 안 smoke-candidate-draft-schema 등재", "**`/cascade-sync --check` 호출 = v6.4 mechanism × v6.5 narrative cascade 검증 (arch P1_arch_5 흡수, 자기참조 cycle 31)**", "pre-commit 회귀 0 검증 (17 hook PASS)"]},
    {"id": "phase_2", "title": "도그푸드 + archival + REPORT/PROPOSE", "steps": ["/propose-next mechanism 1 회 호출 (read-only --scan) → v6.6 후보 enumerate + LLM 우선순위 + 비유 표현 보고", "사용자 명시 응답 (y/n) → y 시 LLM 안 Bash Edit 으로 ROADMAP candidate_draft[] 안 1+ entry append (D10 D4 정합, 자기참조 cycle 30)", "ROADMAP archival — v6.2 milestones[] entry → CHANGELOG.md [v6.2] entry 이동 (v5.21 archival cycle 5번째)", "CHANGELOG.md [v6.5] entry 추가 (entry title 가이드 ≤ 60자 + 본질 1 개 정합)", "MILESTONE.md ## VERIFY + ## REPORT + ## PROPOSE 작성 + status `completed`", "pre-commit 회귀 0 검증 (17 hook PASS)"]}
  ],
  "risk_mitigation": [
    {"id": "rm_1", "risk": "r_1 hallucination", "mitigation": "D2 script grep + LLM rationale 안 source 인용 의무. v5.13/v5.18 절차 정합."},
    {"id": "rm_2", "risk": "r_2 토큰 비용", "mitigation": "D10 script enumerate (PROPOSE/lessons 섹션만 grep, 전체 Read 회피). LLM input = JSON 추출 본만."},
    {"id": "rm_3", "risk": "r_3 결정 게이트 미세 위반", "mitigation": "D4 사용자 명시 응답 (y/n) + D9 dry-run default + D3 candidate_draft[] (staging area, next_candidates[] 별도)."},
    {"id": "rm_4", "risk": "r_4 stale 누적", "mitigation": "D5 smoke 안 stale check 미포함 (v6.5 scope 한정, 첫 실 작동 priority). 사용자 review cycle 운영 = v6.x 후속 candidate 거명만 (PROPOSE)."},
    {"id": "rm_5", "risk": "r_5 v4.0 narrative 충돌", "mitigation": "D3 category 필드 분리 + D8 bootstrap/agents/CLAUDE.md § 벤치마크 cycle routine 안 category 분리 narrative cascade (v4.0 narrative 명료화) + ROADMAP schema_note enum 명시."},
    {"id": "rm_6", "risk": "r_6 spec-drift", "mitigation": "RESEARCH ext_1 cross-validate (v5.7 spike 패턴) + v6.4 cascade-sync.md baseline 정합 + Stage F spike (c) 분기 자연 흡수 가능."},
    {"id": "rm_7", "risk": "r_7 audit chain hallucination cycle 4 자연 발현", "mitigation": "D2 script + LLM source 인용 + D5 smoke 안 source 필드 (origin_milestone) 강제. memory feedback_subagent_fact_hallucination_correction cycle 4 인지."}
  ]
}
```

### Approach summary

3 컴포넌트 hybrid (v6.4 cycle 2 정합):

1. **`scripts/propose_next.py`** = deterministic enumerate + JSON 출력. CLI args: `--scan` (default, read-only) | `--list-candidates` | `--append <args>`. fixed argument list + path traversal 차단.
2. **`claude/commands/propose-next.md`** = LLM orchestrator. script 호출 → JSON parse → 우선순위 + rationale 요약 → 사용자 응답 → candidate_draft[] append.
3. **`tests/smoke-candidate-draft-schema.sh`** = read-only schema validation. 7 필드 + category enum + detected_at ISO 강제. pre-commit 등재.

cascade narrative 정전화 = ARCHITECTURE.md § 4 끝 매트릭스 #9 row + paragraph. v6.4 mechanism (marker comment) 적용 = 자기참조 cycle 30.

### Phases summary

- **phase-1** (mechanism 도입): 3 컴포넌트 + ARCHITECTURE 정전화 + cascade (root CLAUDE.md + bootstrap/agents/CLAUDE.md) + ROADMAP schema_note category enum
- **phase-2** (도그푸드 + archival): `/propose-next` 1 회 호출 → candidate_draft[] append + v6.2 → CHANGELOG archival (cycle 5) + REPORT/PROPOSE

### 5 관점 subagent 병렬 검토 (cycle 4)

memory feedback_subagent_parallel_review_evidence cycle 3 누적 (v6.2 = 20건 baseline, v6.3 = 35건 1.75배, v6.4 = 38건 1.09배 converged). **cycle 4 결과 = 32건 (P1 12 + P2 20), v6.4 대비 0.84배 — converged trend 유지**.

5 관점 = architecture (Plan agent) + spec-drift + security + iterative-dialog 정합 + 외부 vector (general-purpose × 4).

#### Absorption matrix

| 관점 | P1 | P2 | 흡수 위치 |
|------|:-:|:-:|------|
| 1. architecture | 5 | 5 | D5 (smoke 단일 책임) / D7 (cascade-sync 도그푸드 cycle 31) / D10 (--append 분리) / D11 (fallback 명료화) / INTENT dep_9 (schedule skill) |
| 2. spec-drift | 0 | 4 | (pass-with-comments, P2 거명만) |
| 3. security | 3 | 3 | D10 (input validation 3축: length + charset + path traversal + JSON round-trip) |
| 4. iterative-dialog | 2 | 3 | D12 (최우선 1건 우선 + 비유 표현 가이드) |
| 5. 외부 vector | 2 | 5 | D3 (hallucination 정정 narrative) / D8 (cascade 정확 위치 :163 + :186-196) |
| **합** | **12** | **20** | **P1 12 모두 흡수 / P2 20 PROPOSE 거명만** |

#### Audit chain hallucination cycle 4 자연 발현

5 관점 외부 vector agent 의 P1#1 (v4.0/PROPOSE.md:54 안 'category: fleet-evolution' 명시) = **fact hallucination**. grep 검증 결과 v4.0/PROPOSE.md 안 `category` 키워드 0 매치 — fact 부재. memory feedback_subagent_fact_hallucination_correction direct evidence cycle 4 (cycle 1 = v5.10 component-proposer 12 항목 표 / cycle 2 = v5.11 project-scanner / cycle 3 = v5.12 mapper). v5.13/v5.18 fact 검증 절차 4번째 실전 — D3 narrative 안 inline 정정 흡수 (lightweight 모드).

## APPROVE

### Spec

```json
{
  "id": "claude-autonomous-milestone-proposal",
  "title": "Claude 자율 milestone 발의 mechanism",
  "approval": {
    "approved_by": "user",
    "approved_at": "2026-05-20",
    "scope_summary": "DESIGN 12 결정 + 5 관점 cycle 4 P1 12건 흡수 + hallucination cycle 4 inline 정정. 2 phase 구조 (phase-1 mechanism 도입 + cascade-sync 도그푸드 + 회귀 0 / phase-2 도그푸드 1 회 호출 + archival + REPORT/PROPOSE). AskUserQuestion 명시 응답 '승인 → EXECUTE 진행 (Recommended)'.",
    "decisions_locked": ["D1: 3 컴포넌트 hybrid", "D2: script + LLM 분리", "D3: 7 필드 + category enum 2 값 (hallucination 정정 inline)", "D4: candidate_draft[] append + y/n", "D5: smoke 단일 책임", "D6: 도그푸드 phase-2", "D7: 2 phase + cascade-sync 검증 cycle 31", "D8: cascade 정확 2 host", "D9: frontmatter 4 필드", "D10: --append 분리 + input validation 3축", "D11: 1차 디렉토리 + 2차 cross-validate", "D12: 최우선 1건 + 비유 표현"]
  }
}
```

### Approval narrative

사용자 명시 응답 (AskUserQuestion, 2026-05-20) = "승인 → EXECUTE 진행 (Recommended)". DESIGN 12 결정 + P1 12건 흡수 + cycle 4 hallucination evidence inline 정정 모두 본 승인 scope 안 포함. EXECUTE phase-1 진입 게이트 통과.

## EXECUTE

본 H2 = phase 목록 + 진행 표지. 실 본책 = `execute/phase-{n}.md` 별책 (v6.2+ flattened era 정합).

- **phase-1** ([execute/phase-1.md](execute/phase-1.md)): mechanism 도입 (slash command + python script + smoke 3 컴포넌트) + ARCHITECTURE § 4 끝 매트릭스 #9 row + paragraph 본문 정전화 + cascade 2 host (root CLAUDE.md + bootstrap/agents/CLAUDE.md) + ROADMAP schema_note category enum + tests/CLAUDE.md cascade 갱신 + pre-commit 등재 + v6.4 mechanism × v6.5 narrative 자기참조 cycle 31 검증. **status: completed** (acceptance gate 8/8 PASS, 회귀 0 17 hook).
- **phase-2** (예약): 도그푸드 1 회 `/propose-next` 호출 → candidate_draft[] append + ROADMAP archival v6.2 → CHANGELOG (archival cycle 5) + CHANGELOG [v6.5] entry + REPORT + PROPOSE + MILESTONE.md status completed.

## VERIFY

<!-- Stage G: 검증 (smoke / criteria_check vs INTENT / verdict) -->

## REPORT

<!-- Stage H: 종합 backward (summary / delta / lessons_learned) -->

## PROPOSE

<!-- Stage I: 후속 forward (next_candidates ROADMAP 등록) -->

## SUB_MILESTONES

<!-- v6.2+ flattened era — 같은 의미 단위 후속 candidates 가 본 milestone 안 sub-milestone phase 로 흡수될 때 등재. 현재 미정 (single-milestone). -->

- (현재 단일 milestone, sub-milestone 미정)
