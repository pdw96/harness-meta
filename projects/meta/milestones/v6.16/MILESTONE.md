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

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "Anthropic Claude Code Skill spec (context7 `/websites/code_claude` query `SKILL.md frontmatter format required fields and body structure`)", "verdict": "VERIFIED — SKILL.md = YAML frontmatter (--- markers) + Markdown body 2 부분. frontmatter 필드: `description` (필수, auto-invoke trigger 본질) + `name` (권장) + `disable-model-invocation` (선택, model auto-invoke 차단) + `allowed-tools` (선택, tool whitelist) + `argument-hint` (선택, slash command 인자 힌트). description = auto-invoke 정합 핵심 — Claude 가 description 매칭으로 skill 활성. skill dir name = slash command 이름 (예: `summarize-changes` → `/summarize-changes`). body = Markdown 자유 — instructions / examples / sections. 본 milestone scope 정합 — frontmatter description = trigger 본질 + body = checklist + schema template."},
    {"id": "ext_2", "source": "Anthropic Claude Code Skill spec (context7) — dynamic context injection 패턴", "verdict": "VERIFIED — body 안 `!<command>` syntax 로 shell command output 동적 inject 가능 (예: `!git diff HEAD`). 본 milestone scope 외 (oos 명시 부재 — 본 2 skill body = 정적 checklist + schema template 본질, 동적 inject 부재 자연). 향후 stage skill 확장 (예: stage-verify) 안 smoke output 동적 inject 가능성 = v6.17+ 후속 candidate 자연."}
  ],
  "codebase": [
    {"id": "cb_1", "file": ".claude-plugin/plugin.json:18", "fact": "`skills: \"./skills/\"` 명시 — v5.1+ add-to-default auto-discovery 정합. 신규 skills/stage-open/SKILL.md + skills/stage-propose/SKILL.md 추가 시 plugin.json 갱신 부재 자연 (디렉토리 자동 인식). sc_5 검증 대상 — `paths` 명시 부재 (top-level `skills` 필드만 사용) → 추가 변경 부재 evidence."},
    {"id": "cb_2", "file": "skills/", "fact": "현 skill 5건 — ai-ready-scorer / developer-profile / harness-plan-verify / harness-roadmap-update (DEPRECATED) / mindvault. 신규 stage-open + stage-propose 추가 시 합산 7건. naming convention = kebab-case 단어 단일."},
    {"id": "cb_3", "file": "skills/harness-plan-verify/SKILL.md:1~165", "fact": "본 milestone 신규 2 skill 동질 패턴 source. 구조 = (a) YAML frontmatter (name + description multi-line + allowed-tools + model + effort) + (b) body 5 H2 섹션 (적용 대상 / 사용법 / 흐름 N-step / 위반 정책 / 한계 / 관련 문서). description = auto-invoke trigger keyword 다수 명시 (`spec 검증` / `context7 검증` / `PLAN 검증` / `spec drift`). 본 milestone scope 정합 — 동질 frontmatter + body 4 H2 섹션 (입력 / 작성할 것 / 검증 / 관련) 단순화. allowed-tools 명시 vs 부재 = DESIGN 단계 결정."},
    {"id": "cb_4", "file": "skills/harness-roadmap-update/SKILL.md:1~138", "fact": "DEPRECATED skill — v1.0 이전 sessions/ 4-tier era 기반 broken path 잔존. 본 milestone scope 외 (참조용 패턴 보존 only). frontmatter `disable-model-invocation: true` (사용자 명시 호출 only) + 5-step 흐름 구조 본질 = 신규 2 skill 와 다름 (mechanical auto-invoke 본질, 본 milestone = AI 판단 위임 본질). 단 `Step 1 Identify / Step 2 Validate / Step N Update` N-step body 패턴 = 신규 skill 참조 가능."},
    {"id": "cb_5", "file": "skills/mindvault/SKILL.md + skills/ai-ready-scorer/SKILL.md + skills/developer-profile/SKILL.md", "fact": "추가 skill 3건 패턴 cross-check 가능. RESEARCH 단계 read 부재 — DESIGN 단계 cross-validate 시 cross-check 자연."},
    {"id": "cb_6", "file": "projects/meta/ARCHITECTURE.md § 3.1~§ 3.6", "fact": "§ 3 정전 single source — § 3.1 working definition + 정체성 paragraph (v4.0~v6.0) + § 3.2 working philosophy + § 3.3 5요소 매트릭스 (Context/Workflow/Constraint/Verification/Trace) + § 3.4 외부 컨벤션 관계 + § 3.5 ★ 단일 source 정합 + § 3.6 신규 milestone 발의 시 평가 절차. **본 milestone 정전화 paragraph 위치 candidate 1 (Option E)** — § 3 안 신규 sub-section § 3.7 'Stage 본질'. 정합 = stage 본질 = 정전 single source 자연. 단 § 3 sub-section 6개 누적 (sub-section 가중 weak)."},
    {"id": "cb_7", "file": "projects/meta/ARCHITECTURE.md § 4 (9-stage workflow + § 4 끝 narrative 정전화 누적 매트릭스 + paragraph 본문 11건)", "fact": "**본 milestone 정전화 paragraph 위치 candidate 2 (Option A)** — § 4 끝 신규 paragraph #12 row append + 본문 추가. 정합 = § 4 매트릭스 11건 누적 패턴 자연 확장. 본질 (B/C/D 부산물 / Word-fidelity drift / ROADMAP drift / Audit cascade / fact verify / lint / stability / cascade-sync / propose / hallucination / fixture smoke) 안 12번째 row = 'stage section 작성 task 본질'. 단 매트릭스 가중 large + paragraph 본문 add cost."},
    {"id": "cb_8", "file": "projects/meta/ARCHITECTURE.md § 6.1 (era 정책 + 9-stage-flattened era paragraph + 9-stage-bundled era paragraph)", "fact": "**본 milestone 정전화 paragraph 위치 candidate 3 (Option B)** — § 6.1 안 9-stage-flattened era paragraph 끝 자연 확장 (`AI Native § 7.1 컨텍스트 효율 면 두 번째 실 적용 milestone...` 부분 끝 신규 sentence). 정합 = 9-stage-flattened era 본질 = section 작성 task 자연 수렴 cause. 단 § 6.1 = era 정책 (디렉토리 명 + 산출 파일명 분류) 본질, section 작성 task 본질이 era 정의에 들어가긴 약."},
    {"id": "cb_9", "file": "projects/meta/ARCHITECTURE.md § 7.1 (AI Native 정의 + 3 면 매트릭스 + baseline)", "fact": "**본 milestone 정전화 paragraph 위치 candidate 4 (Option C)** — § 7.1 끝 신규 sub-paragraph (3 면 매트릭스 표 다음, '본 매트릭스는 후속 milestone 발의 평가 기준' 문장 직전 또는 직후). 정합 = AI Native § 7.1 컨텍스트 효율 면 직접 정합 (section 작성 task = AI 가 흡수 + 작성 본질). 단 § 7.1 = 면 정의 본질, sub-paragraph 추가는 § 7.x 신규 sub-section 도 자연."},
    {"id": "cb_10", "file": "projects/meta/ARCHITECTURE.md § 7 (AI Native 운영 + § 7.1 정의 + § 7.2 entry title 가이드)", "fact": "**본 milestone 정전화 paragraph 위치 candidate 5 (Option D)** — § 7 안 신규 sub-section § 7.3 'Stage 본질 (templated section 작성 task)'. 정합 = § 7 sub-section 누적 (§ 7.1 정의 + § 7.2 entry title 가이드) 후 § 7.3 자연 add. v6.0 = § 7 신규 도입 / v6.3 = § 7.2 신규 sub-section 추가 패턴 정합. AI Native 운영 sub-section 누적 = § 7 본질 정합."},
    {"id": "cb_11", "file": "projects/meta/milestones/v6.2/MILESTONE.md (9-stage-flattened era 도입 milestone)", "fact": "9-stage-flattened era 본질 source. v6.2 phase-1 + phase-2 도그푸드 자체. 본 milestone 정전화 paragraph 안 v6.2 cross-ref 의무 (era 도입 1차 source 인용)."}
  ],
  "options": [
    {"id": "opt_a", "label": "Option A — § 4 끝 신규 paragraph #12 row append + 본문 추가", "verdict": "PENDING (DESIGN 결정) — 매트릭스 cascade 본질 정합 (#1~#11 누적 후 #12 자연 add). v3.21 narrative 정전화 3 단계 패턴 cycle 안 § 4 매트릭스 row append 의무 (v3.21 패턴 (b) EXECUTE Edit 단계 정합). 단점: § 4 가중 large + 본 본질이 9-stage 단어 fidelity / drift / mechanism 본질과 결이 다름 (era 발현 본질에 가까움)."},
    {"id": "opt_b", "label": "Option B — § 6.1 안 9-stage-flattened era paragraph 끝 자연 확장", "verdict": "PENDING (DESIGN 결정) — 9-stage-flattened era 본질 = section 작성 task 자연 수렴 cause 직접 정합. era paragraph 안 sentence 1-2 추가 = lightweight. 단점: § 6.1 = era 분류 본질 (디렉토리 명 + 산출 파일명 + smoke 자동 식별), 본 본질이 era 정의에 들어가긴 약."},
    {"id": "opt_c", "label": "Option C — § 7.1 끝 신규 sub-paragraph", "verdict": "PENDING (DESIGN 결정) — AI Native § 7.1 컨텍스트 효율 면 직접 정합. v6.0 정의 → v6.1 schema → v6.2 디렉토리 평탄화 → v6.16 stage 본질 정전화 cascade 자연. 단점: § 7.1 = 면 정의 + baseline, sub-paragraph 누적 시 § 7.x 신규 sub-section 추가 정합 → Option D 와 trade-off."},
    {"id": "opt_d", "label": "Option D — § 7 안 신규 sub-section § 7.3 'Stage 본질'", "verdict": "PENDING (DESIGN 결정 — 본 milestone 추천 후보) — § 7 sub-section 누적 패턴 (§ 7.1 v6.0 + § 7.2 v6.3) 후 § 7.3 자연 add. AI Native 운영 차원 정합 + 정전 sub-section 분리 명료 + skill body cross-ref 인용 자연 (`ARCHITECTURE § 7.3 1차 source`). 단점: § 7 sub-section 누적 (3개), 매트릭스 cascade #12 row 별도 add 필요 시 Option A 와 보완 가능."},
    {"id": "opt_e", "label": "Option E — § 3 안 신규 sub-section § 3.7 'Stage 본질'", "verdict": "PENDING (DESIGN 결정) — § 3 정전 single source 본질 정합. 단점: § 3 = 하네스 엔지니어링 정의 (5요소 매트릭스 본질), stage 본질은 정의 sub-element 가 아니라 운영 패턴 본질 → § 7 가 더 정합 (DESIGN 단계 정합 본질 우위)."}
  ],
  "risks_identified": [
    {"id": "r_1", "description": "SKILL.md description 매칭이 너무 광범위 → 의도치 않은 auto-load (예: 'OPEN' 단어가 'OPEN 진입' 외 'open file' 등 일반어와 충돌)", "mitigation": "description 안 trigger condition narrow 명시 — 'milestone OPEN stage 진입' / 'projects/meta/milestones/v{X.Y}/MILESTONE.md ## INTENT 작성' 등 구체 path + 본질 명시. 회피 keyword (예: 일반 'open file') 명시 가능."},
    {"id": "r_2", "description": "skill 시범 후 사용자 실 사용 안 함 vector 부재 → 7 stage 확장 trigger 부재 → 시범 vacuous", "mitigation": "도그푸드 cycle 명시 — v6.17 (다음 milestone) OPEN/PROPOSE stage 진입 시 신규 skill auto-load evidence 확인. INTENT.motivation 안 도그푸드 첫 cycle = v6.17 명시 (이미 적용)."},
    {"id": "r_3", "description": "ARCHITECTURE 1차 source ↔ skill body cross-ref drift → 정전화 본질 약화", "mitigation": "skill body 안 ARCHITECTURE § X.Y 직접 인용 (단방향 derived). cascade-sync mechanism (v6.4) 안 marker 도입은 oos (cascade host ≥2 필요 = v6.10 L3 판정, 본 milestone 단일 host = 1차 source 단일 → 적용 외). 단방향 derived 본질 = SKILL.md frontmatter description 안 ARCHITECTURE 명시 인용 evidence."},
    {"id": "r_4", "description": "skill body 안 schema template 이 stale (실 schema 변경 시) → smoke 통과해도 skill 부정확", "mitigation": "skill body 안 schema = 메타 narrative ('의무 필드 = INTENT.goal + success_criteria[] + out_of_scope[] + dependencies[]' 형식, hardcode 제한). 실 schema 변경 시 ARCHITECTURE + skill 동기 갱신 의무 (단 cascade 본질 부재 자연 — skill = derived, ARCHITECTURE = 1차 → ARCHITECTURE 갱신 시 skill 후속 갱신 manual)."},
    {"id": "r_5", "description": "9 stage 중 2건만 시범 → 일관성 부재 (7 stage = manual / 2 stage = skill)", "mitigation": "본 milestone scope = 시범 본질 (사용자 결정 정합 — '1-2개 시범 먼저 → 포맷 검증 → 확장'). 일관성은 후속 milestone 자연 (v6.17+ 나머지 7 stage skill 확장 후 일관 도달). INTENT.oos_1 명시."},
    {"id": "r_6", "description": "harness-meta:harness-meta entry skill 과 stage skill 사이 trigger 충돌 — 동일 keyword (예: 'OPEN') 매칭 시 어느 skill auto-load?", "mitigation": "DESIGN 단계 결정 — entry skill = 9-stage workflow 진입점 (keyword: 'harness-meta', '/harness-meta', '하네스 개선') / stage skill = 단일 stage 진행 (keyword: 'OPEN 진입', 'PROPOSE 작성' 등 stage-specific). trigger keyword 본질 별 분리 자연 (충돌 부재 가설). DESIGN 단계 cross-check 의무."}
  ]
}
```

### External / codebase summary

ext_1 = Anthropic Claude Code Skill spec 본질 = YAML frontmatter (`---` markers) + Markdown body. frontmatter 필수 = `description` only (auto-invoke trigger source). 권장 = `name`. 선택 = `disable-model-invocation` / `allowed-tools` / `argument-hint`. body = 자유 Markdown — instructions / examples / sections. dir name = slash command 이름 (예: `stage-open` → `/stage-open`).

ext_2 = dynamic context injection (`!<command>` syntax) = 본 milestone scope 외 (정적 checklist + schema template 본질). 향후 stage-verify / stage-execute 등 확장 시 활용 가능.

codebase = (a) 기존 skills/ 5건 패턴 (harness-plan-verify 가장 가까운 reference) + (b) plugin.json `skills: ./skills/` add-to-default auto-discovery 정합 (sc_5 정합 evidence) + (c) ARCHITECTURE 안 정전화 paragraph 위치 candidate 5건 (cb_6~cb_10) — § 3 / § 4 / § 6.1 / § 7.1 / § 7 5 위치 options 추출.

### Options for canonical location

5 options (opt_a ~ opt_e) — DESIGN 단계 결정. 본 milestone 추천 후보 = **Option D (§ 7 신규 sub-section § 7.3)** — AI Native 운영 sub-section 누적 패턴 (§ 7.1 v6.0 + § 7.2 v6.3) 정합 + 정전 sub-section 분리 명료 + skill body cross-ref 인용 자연. 보강 후보 = Option A (§ 4 매트릭스 #12 row append + 본문) 와 보완 결합 가능 — Option D 본문 + Option A row 양방 (v3.21 narrative 정전화 3 단계 패턴 정합).

### Risks identified (6건)

r_1 (description 광범위 auto-load), r_2 (시범 vacuous), r_3 (1차/derived drift), r_4 (schema stale), r_5 (7-stage 일관성 부재), r_6 (entry skill ↔ stage skill trigger 충돌). 모두 DESIGN 단계 mitigation 결정.

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
