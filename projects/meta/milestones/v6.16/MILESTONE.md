---
id: stage-templated-task-canonicalization-and-skill-pilot
title: stage-templated-task 정전화 및 OPEN/PROPOSE skill 시범 도입
version: v6.16
status: open
---

# v6.16 — stage-templated-task 정전화 및 OPEN/PROPOSE skill 시범 도입

## INTENT

### Spec

```json
{
  "id": "stage-templated-task-canonicalization-and-skill-pilot",
  "title": "stage-templated-task 정전화 및 OPEN/PROPOSE skill 시범 도입",
  "goal": "v6.2 9-stage-flattened era 이후 자연 수렴한 stage 본질 = 'MILESTONE.md H2 section 작성 task' 를 ARCHITECTURE.md 1차 source 로 정전화 (phase-1) + OPEN + PROPOSE 2 stage skill 시범 도입 (phase-2, mechanical-heavy stage 우선 포맷 검증) — 나머지 7 stage (INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT) skill 확장은 시범 포맷 검증 후 후속 milestone 자연. v3.21 narrative 정전화 3 단계 패턴 적용 대상 = 단방향 (ARCHITECTURE 1차 → skills/* derived, cascade host 1차 부재 → v6.10 L3 판정 기준 (cascade host ≥2) 자연 외).",
  "success_criteria": [
    {"id": "sc_1", "description": "ARCHITECTURE.md 안 'stage = templated section 작성 task 본질' paragraph 정전화 — 정확 위치 (§ 3.x 또는 § 7.x sub-paragraph) 는 DESIGN 단계 결정. 본문 = (i) v6.2 flattened era 자연 수렴 사실 + (ii) mechanical 자동화 완료 (cascade_sync/propose_next/smoke) + manual narrative 작성 잔존 분리 + (iii) skill = derived checklist 정합 본질."},
    {"id": "sc_2", "description": "skills/stage-open/SKILL.md 작성 — frontmatter (name + description + 사용 case) + body 4 섹션 (입력 / 작성할 것 / 검증 / cross-ref). body = checklist (필수 필드 목록 + smoke 명령) + schema template (frontmatter 4 필드 skeleton + section H2 목록) only. 예시 narrative 부재 (sc_4 정합)."},
    {"id": "sc_3", "description": "skills/stage-propose/SKILL.md 작성 — sc_2 동질 구조. PROPOSE stage 본질 = next_candidates 등재 + propose_next.py 자동화 cycle 정합. body = checklist + schema template (candidate entry 6 필드 schema 인용)."},
    {"id": "sc_4", "description": "2 skill body scope 검증 — checklist + schema template only (예시 narrative 부재 grep 확인). 본질 분리 = skill = template, narrative judgment = LLM at runtime."},
    {"id": "sc_5", "description": ".claude-plugin/plugin.json paths 갱신 확인 — v5.1+ 'skills/*/SKILL.md' add-to-default auto-discovery 정합 (이미 정합 시 변경 부재 자연)."},
    {"id": "sc_6", "description": "회귀 0 — pre-commit 18 hook 전체 PASS. cascade-drift 영향 = ARCHITECTURE 1차 source 신규 추가 (cascade marker 부재 → drift detect oos 자연). skill SKILL.md frontmatter description 매칭 정합 (Claude Code Skill spec)."},
    {"id": "sc_7", "description": "cascade host 본질 검증 narrative 안 명시 — ARCHITECTURE 1차 source 단일 + skills/* derived 단방향. v3.21 3 단계 패턴 적용 대상 부재 (v6.10 L3 판정 기준 정합). 단방향 derived 관계는 SKILL.md frontmatter description 안 'ARCHITECTURE § X.Y 1차 source 참조' 직접 인용 evidence."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "나머지 7 stage skill (INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT) 확장", "reason": "사용자 결정 (시범 1-2 먼저 → 포맷 검증 → 확장). OPEN + PROPOSE 시범 후 별 milestone 자연 (포맷 검증 dependency). narrative-heavy stage (INTENT/RESEARCH/DESIGN/REPORT) 는 mechanical-heavy 시범 검증 evidence 후 자연 확장."},
    {"id": "oos_2", "item": "기존 harness-meta:harness-meta entry skill 재설계", "reason": "본 milestone = stage-specific child skill 추가만. entry skill = 9-stage workflow 진입점 본질, stage skill = 단일 stage 진행 본질. 토폴로지 별축. 코existence 자연."},
    {"id": "oos_3", "item": "skill 자체 smoke 도입 (skill 형식 자동 검증)", "reason": "DESIGN 단계 결정 후 별 milestone 자연. skill 형식 안정화 dependency = 시범 2 skill 검증 evidence 후 smoke trigger 자연. 본 milestone scope creep 회피."},
    {"id": "oos_4", "item": "skill trigger 모델 정전화 (auto-load vs explicit /command)", "reason": "DESIGN 단계 결정 안 narrative 포함 자연 (별 정전화 위치 부재). Claude Code Skill spec 안 description 매칭 auto-load 본질 = 기존 동작, 본 milestone 변경 부재 자연. SKILL.md description 안 trigger condition 자연 inject."},
    {"id": "oos_5", "item": "5 관점 subagent 병렬 검토 (architecture / spec-drift / 회귀 risk / 보안 / scope contract)", "reason": "lightweight 1-phase 본질 (scope ~5-10 파일 mechanical edit + 2 SKILL.md 신규 작성). v6.6~v6.15 lightweight 1-phase 9 consecutive cycle 누적 패턴 정합. inline self-review (decisive 0 / P2 거명 / P3 거명) 자연. 단 본 milestone phase 2개 분리 (phase-1 ARCHITECTURE + phase-2 skill) — lightweight 본질 보존 (1-phase 의미 = subagent 병렬 부재, 본질 분리 phase 2건 ≠ 본질 1개)."}
  ],
  "dependencies": [
    {"id": "dep_1", "source": "사용자 자연어 관찰 origin (2026-05-21 대화) — `stage 진행 = open 진입이 아니라 open 작성` 표현 차이", "purpose": "본 milestone trigger source. pre-PLAN 4 round 누적 결정 origin."},
    {"id": "dep_2", "source": "projects/meta/ARCHITECTURE.md § 3.1 (v4.0 정체성 paragraph) + § 7 (AI Native 3 면 + entry title 가이드 4 원칙)", "purpose": "정전화 paragraph 신규 추가 위치 후보 source. DESIGN 단계 정확 위치 결정 input."},
    {"id": "dep_3", "source": "기존 skills/* 디렉토리 (특히 skills/harness-meta/, skills/cascade-sync/, skills/propose-next/ 등)", "purpose": "신규 2 skill 동질 패턴 source. frontmatter description 형식 + body 구조 정합 참조."},
    {"id": "dep_4", "source": ".claude-plugin/plugin.json paths (`skills` add-to-default 명시 위치)", "purpose": "skill auto-discovery 정전 source. v5.1+ 자동 인식 정합 확인."},
    {"id": "dep_5", "source": "memory feedback_v1.75_manual_context_injection (SKILL 인프라 거부 사례)", "purpose": "토폴로지 분리 정합 확인. v1.75 = sub-agent context injection 맥락 / 본 milestone = main Claude stage template 맥락 = 직접 충돌 부재 evidence."},
    {"id": "dep_6", "source": "Anthropic Claude Code Skill spec (context7 query, RESEARCH 단계 진행)", "purpose": "SKILL.md frontmatter + body 표준 형식 1차 source. v6.1 안 'YAML frontmatter + Markdown body' 패턴 자기 정전화 정합 evidence."}
  ]
}
```

### Motivation

사용자 자연어 관찰 origin (2026-05-21 대화) — "stage 진행되는걸 보면 예를 들어 open 진입이 아니라 open 작성이라고 말해". 본 표현 차이가 stage 본질 인식 drift evidence — v6.2 9-stage-flattened era 도입 이후 stage 본질이 'MILESTONE.md H2 section 작성 task' 로 자연 수렴 (디렉토리 평탄화 + 본책 단일화 결과) 했으나, ARCHITECTURE.md 1차 source 안 본 본질 명문화 부재. 결과 = 사용자/Claude 대화에서 "진입" 같은 phase-centric 표현이 잔존, 실제 운영은 section-centric 인 inconsistency.

mechanical 자동화는 누적 진행 — OPEN dir 생성 (cascade_sync), PROPOSE candidate 등재 (propose_next.py), VERIFY smoke 실행 (tests/*), entry title (smoke-entry-title-guideline), cascade drift (smoke-cascade-drift), audit fact verify (audit_fact_verify.py) 등. 즉 v6.x 후반 누적 패턴 = "stage 안 mechanical 부분 → 별 script + slash command + smoke 흡수 → 남은 narrative judgment 만 LLM at runtime". 본 milestone 은 그 누적 패턴을 ARCHITECTURE 1차 source 로 명문화 + 시범적으로 2 stage skill (template 역할) 도입.

pre-PLAN 4 round 누적 결정 (2026-05-21):

1. **방향** — (A) document-writing 인정 + skill template 화 (vs (B) phase-like 액션 복원 = OPEN dir 자동 생성 등 script 추가). 사용자 결정 (A) — 현 상태 정전화 본질.
2. **canonical 위치** — ARCHITECTURE 1차 source + skill derived (vs skill 자체가 1차). cascade host 패턴 정합 본질 우선.
3. **scope** — OPEN + PROPOSE 2 skill 시범 (mechanical-heavy 우선 포맷 검증, vs 9 skill 일괄). 위험 회피 + iteration 우선.
4. **skill 내용** — checklist + schema template (vs checklist만 / vs +예시 narrative). 본질 forcing function + size 균형.

milestone 번호 = v6.16 (v6.15 직후 단조 증가). 제목 = `stage-templated-task 정전화 및 OPEN/PROPOSE skill 시범 도입` (§ 7.2 4 원칙 정합 — 한 본질 ≈ '시범 + 정전화' 통합 / ≤ 60자 (40자) / Active form 본질 동사 `도입` 종결 / detail summary 안).

**자기 적용 본질 부재** — 본 milestone 자체는 stage skill 도입 milestone 이지만, 본 milestone 작성은 기존 manual stage 흐름으로 진행 (skill 도입 완료 후 다음 milestone 부터 새 skill 활용). 도그푸드 첫 cycle = v6.17 (다음 milestone 의 OPEN/PROPOSE stage 진입 시 stage-open/stage-propose skill auto-load).

### Out of scope rationale

oos_1: 나머지 7 stage skill 확장 = 시범 검증 evidence 후 별 milestone 자연. narrative-heavy stage (INTENT/RESEARCH/DESIGN/REPORT) 는 template forcing function 본질 차이 (mechanical 보다 LLM judgment 비중 큼) → 시범 2 skill 안정 후 자연 trigger.

oos_2: 기존 harness-meta:harness-meta entry skill 재설계 = 토폴로지 별축. entry skill = workflow 진입점 (어느 stage 부터 시작) / stage skill = stage 진행 (해당 stage 안 section 작성). 코existence 자연.

oos_3: skill 자체 smoke 도입 = 시범 안정화 dependency. 2 skill 형식 검증 evidence 후 smoke trigger (frontmatter + body 구조 + cross-ref 정합) 자연.

oos_4: skill trigger 모델 정전화 = Claude Code Skill spec 안 description 매칭 auto-load 기존 동작 정합. SKILL.md description 안 trigger condition 자연 inject (별 정전화 위치 부재).

oos_5: 5 관점 subagent 병렬 검토 = lightweight 1-phase 본질 (scope ~5-10 파일). v6.6~v6.15 누적 패턴 정합. phase 2개 분리 (phase-1 ARCHITECTURE + phase-2 skill) ≠ 본질 2개 (= 단일 본질 '시범 + 정전화', phase 는 변경 위치 분리 본질).

## RESEARCH

(미작성 — Stage C RESEARCH 에서 작성)

## DESIGN

(미작성 — Stage D DESIGN 에서 작성)

## APPROVE

(미작성 — Stage E APPROVE 에서 사용자 명시 승인)

## EXECUTE

(미작성 — Stage F EXECUTE 에서 phase 별 작성. 본책 = phase 진행 요약, 별책 = `execute/phase-{n}.md`)

## VERIFY

(미작성 — Stage G VERIFY 에서 작성)

## REPORT

(미작성 — Stage H REPORT 에서 작성)

## PROPOSE

(미작성 — Stage I PROPOSE 에서 작성)

## SUB_MILESTONES

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음)
