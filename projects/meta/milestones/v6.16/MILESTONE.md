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

### Spec

```json
{
  "decisions": [
    {"id": "D1", "decision": "정전화 위치 = Option D (§ 7 신규 sub-section § 7.3 'Stage 본질') + Option A (§ 4 매트릭스 #12 row append + 본문) 결합", "rationale": "Option D 본문 = AI Native 운영 sub-section 누적 패턴 (§ 7.1 v6.0 + § 7.2 v6.3) 자연 cascade + Option A row = § 4 매트릭스 11건 누적 후 #12 자연 append (v3.21 narrative 정전화 3 단계 패턴 정합). 두 host 양방 = cascade host ≥2 자연 도달 → v3.21 패턴 (a) DESIGN 1차 + (b) EXECUTE Edit cascade + (c) VERIFY grep 적용 자연. § 7.3 = 본문 1차 source / § 4 row = matrix entry 11건+1 cascade host."},
    {"id": "D2", "decision": "skill trigger 모델 = auto-load via description (Anthropic Skill spec 기본)", "rationale": "ext_1 검증 = description 매칭이 auto-invoke trigger 본질. 본 milestone scope 변경 부재 (기존 동작 정합). disable-model-invocation 부재 (사용자 명시 호출 부재 자연). description 안 trigger condition narrow 명시로 r_1 mitigation."},
    {"id": "D3", "decision": "entry skill (harness-meta:harness-meta) ↔ stage skill 관계 = 코existence + trigger keyword 본질 별 분리", "rationale": "entry skill description = '하네스 자체 개선 또는 프로젝트별 하네스 개선 세션 진입점 (9-stage workflow)' (워크플로우 진입). stage skill description = 'milestone OPEN/PROPOSE stage 진입 시 ## INTENT 또는 ## PROPOSE 작성' (단일 stage 진행). trigger keyword 본질 별 — entry = '/harness-meta', '하네스 개선' / stage-open = 'milestone OPEN', 'OPEN stage 진입' / stage-propose = 'milestone PROPOSE', 'PROPOSE stage 작성'. r_6 mitigation 본질."},
    {"id": "D4", "decision": "skill body 구조 = 4 H2 섹션 = '## 입력' (이전 stage 위치) + '## 작성할 것' (checklist + schema template) + '## 검증' (smoke 명령) + '## 관련' (ARCHITECTURE cross-ref)", "rationale": "INTENT sc_2/sc_3 정합 + harness-plan-verify N-step body 패턴 cross-validate. 4 H2 = 본질 최소. body 안 예시 narrative 부재 (sc_4 정합)."},
    {"id": "D5", "decision": "skill 자체 smoke 도입 = oos (본 milestone scope 외, v6.17+ 후속 자연)", "rationale": "INTENT oos_3 정합. 시범 2 skill 형식 안정화 dependency = skill 자체 smoke trigger 자연. 본 milestone 회귀 검증 = pre-commit 18 hook (기존) + INTENT success_criteria 항목별 manual verify."},
    {"id": "D6", "decision": "allowed-tools 명시 부재 (default = 모든 tool)", "rationale": "stage skill body 본질 = narrative checklist (LLM at runtime 작성 책임), 특정 tool 제한 부재 자연. harness-plan-verify (Read/Grep/Edit/context7) 대비 stage skill = 본질 다름 (검증 책임 vs 작성 책임). allowed-tools 명시 부재 = Claude 자율 tool 선택 본질 정합."},
    {"id": "D7", "decision": "5 관점 검토 = inline self-review (lightweight 1-phase 본질 정합)", "rationale": "INTENT oos_5 정합. v6.6~v6.15 lightweight 누적 패턴 + scope ~5-10 파일 변경. 5 관점 inline 결과는 본 DESIGN 안 별도 sub-section 안 흡수 (architecture / spec-drift / 회귀 risk / 보안 / scope contract)."},
    {"id": "D8", "decision": "cascade marker 도입 부재 (단방향 derived 본질 보존)", "rationale": "r_3 mitigation. ARCHITECTURE § 7.3 = 1차 source / skills/* = derived. 단방향 derived 본질 = cascade marker (`<!-- cascade-source: ... -->`) 부재 자연. v6.4 cascade-sync mechanism scope 외 (양방 host 본질 부재). 단 § 7.3 + § 4 row 양방 host 안 cross-ref 정전화 의무 (수동 grep — VERIFY 단계)."},
    {"id": "D9", "decision": "phase 분리 = phase-1 (ARCHITECTURE 정전화) + phase-2 (2 skill 추가)", "rationale": "본질 분리 — phase-1 = narrative 정전화 (단일 host 신규 sub-section + 매트릭스 row append) / phase-2 = derived artifact 생성 (2 SKILL.md). 본질 1개 (시범 + 정전화) 안 phase 2 = 변경 위치 분리 본질 (INTENT oos_5 정합). 각 phase 1 commit (conventional commits)."},
    {"id": "D10", "decision": "v3.21 narrative 정전화 3 단계 패턴 적용 = (a) RESEARCH 1차 source 식별 (opt_a/opt_d) → (b) EXECUTE Edit cascade (§ 7.3 본문 + § 4 #12 row + 본문 paragraph) → (c) VERIFY grep (§ 7.3 + § 4 row + 본문 paragraph 3 host cross-ref 정합)", "rationale": "본 milestone cascade host ≥2 자연 도달 (§ 7.3 + § 4 row + § 4 본문 paragraph = 3 host). v3.21 패턴 cycle 37 자연 발현. opt_d + opt_a 결합 결정 직접 정합."}
  ],
  "approach": {
    "overview": "ARCHITECTURE § 7.3 신규 sub-section + § 4 매트릭스 #12 row + § 4 끝 paragraph 본문 3 host 양방 정전화 (phase-1) → skills/stage-open + skills/stage-propose 2 SKILL.md 작성 (phase-2). v3.21 narrative 정전화 3 단계 패턴 cycle 37 자연 발현. Skill spec (ext_1) 정합 (YAML frontmatter + Markdown body, description auto-invoke trigger).",
    "sequence": [
      "phase-1 step-1: ARCHITECTURE.md § 7.2 다음에 § 7.3 'Stage 본질 (templated section 작성 task)' sub-section 신규 추가 — v6.2 9-stage-flattened era 이후 stage 본질 자연 수렴 paragraph + mechanical 자동화 누적 cascade 인용 (cascade_sync v6.4 / propose_next v6.5 / smoke 등) + manual narrative 작성 잔존 분리 + skill = derived checklist 정합 본질",
      "phase-1 step-2: § 4 끝 매트릭스 안 #12 row append — `v6.16 (2026-05-21) | stage = templated section 작성 task 본질 정전화 (9-stage-flattened era 자연 수렴) | milestones/v6.16/MILESTONE.md D1 + § 7.3 | boolean — skill description 안 ARCHITECTURE § 7.3 인용 grep + § 4 #12 row 존재 grep`",
      "phase-1 step-3: § 4 끝 paragraph 본문 추가 (matrix row 11건 후 본문 paragraph 11건 정합) — narrative archive 본질 보존",
      "phase-2 step-1: skills/stage-open/SKILL.md 작성 — frontmatter (name + description trigger narrow) + 4 H2 body",
      "phase-2 step-2: skills/stage-propose/SKILL.md 작성 — sc_3 동질 구조"
    ]
  },
  "phases": [
    {"id": "phase-1", "title": "ARCHITECTURE.md 정전화 (§ 7.3 신규 + § 4 #12 row + 본문)", "scope": "1 파일 (ARCHITECTURE.md) 3 위치 edit. cascade host ≥2 자연 도달 (§ 7.3 본문 + § 4 row + § 4 본문 paragraph)."},
    {"id": "phase-2", "title": "skills/stage-open + skills/stage-propose 2 SKILL.md 추가", "scope": "2 신규 파일 (skills/stage-open/SKILL.md + skills/stage-propose/SKILL.md). plugin.json 갱신 부재 (auto-discovery 정합)."}
  ],
  "risk_mitigation": [
    {"id": "rm_1", "risk_id": "r_1", "mitigation": "description 안 trigger condition narrow 명시 — stage-open: 'milestone OPEN stage 진입 시 새 milestone 디렉토리 (projects/meta/milestones/v{X.Y}/) + MILESTONE.md skeleton + ROADMAP entry 추가' + 일반 'open file' 회피 wording / stage-propose: 'milestone PROPOSE stage 작성 시 ## PROPOSE section 안 next_candidates 등재 + ROADMAP next_candidates[] append'. 본질 명시 = auto-load 정확도 향상."},
    {"id": "rm_2", "risk_id": "r_2", "mitigation": "INTENT.motivation 안 도그푸드 첫 cycle = v6.17 명시 (이미 적용). v6.17 OPEN stage 진입 시 skill auto-load evidence 확인 (v6.17 REPORT.md 안 lessons_learned). vacuous 시 별 milestone re-evaluation candidate (PROPOSE 등재)."},
    {"id": "rm_3", "risk_id": "r_3", "mitigation": "SKILL.md frontmatter description 안 'ARCHITECTURE § 7.3 1차 source' 명시 인용 + body 안 `## 관련` H2 안 ARCHITECTURE.md § 7.3 link 명시. 단방향 derived 본질 evidence."},
    {"id": "rm_4", "risk_id": "r_4", "mitigation": "skill body schema = 메타 narrative ('의무 필드 = ...' 형식, hardcode 제한). 실 schema 변경 시 ARCHITECTURE + skill 동기 갱신 manual (단방향 cascade)."},
    {"id": "rm_5", "risk_id": "r_5", "mitigation": "INTENT oos_1 명시 + 후속 milestone candidate (PROPOSE 등재). 시범 본질 = 일관성 자연 도달 dependency."},
    {"id": "rm_6", "risk_id": "r_6", "mitigation": "D3 정합 — trigger keyword 본질 별 분리. entry skill = '/harness-meta', '하네스 개선' / stage skill = 'OPEN/PROPOSE stage 진입' 등 stage-specific. 충돌 부재 가설."}
  ],
  "five_perspective_inline_review": {
    "architecture": {"verdict": "PASS", "detail": "§ 7.3 위치 정합 — AI Native 운영 sub-section 누적 패턴 (§ 7.1 정의 + § 7.2 entry title) 후 § 7.3 stage 본질 자연 cascade. § 3 (정전 single source) sub-section 가능 (Option E) vs § 7 (AI Native 운영) sub-section (Option D) trade-off — § 3 = 정의 본질 (5요소 매트릭스) / § 7 = 운영 본질 (3 면 매트릭스). stage 본질 = 운영 패턴 → § 7 정합 우위."},
    "spec_drift": {"verdict": "PASS-with-comments", "detail": "Anthropic Skill spec ext_1 검증 정합 — frontmatter (description 필수 + name 권장) + Markdown body. 본 milestone 구조 (4 H2 body) 정합. spec-drift spike 패턴 (v5.7) 적용 대상 부재 — context7 query result 명시 (frontmatter format), 추정 부재. P2: harness-plan-verify SKILL.md description multi-line YAML literal block (`|`) 패턴 vs 본 milestone single-line 분기 — DESIGN 결정 = single-line (body 안 detail 분리, sc_4 정합)."},
    "regression_risk": {"verdict": "PASS", "detail": "pre-commit 18 hook 회귀 0 보장 (smoke-spec-verification 이미 통과). 신규 추가 = ARCHITECTURE 3 위치 + 2 신규 파일 (skill). cross-ref drift 위험 = D8 단방향 derived 본질 + VERIFY grep cross-check. cascade-drift smoke 영향 0 (cascade marker 부재 자연)."},
    "security": {"verdict": "PASS-with-comments", "detail": "SKILL.md auto-load 보안 = description 매칭 narrow (rm_1) + allowed-tools 부재 = Claude 자율 (default permission scope 정합). P3: stage-open description 안 'projects/meta/milestones/v{X.Y}/' 경로 인용 = repo 내부 path 직접 명시 — 보안 risk 부재 (read/write scope 본질, traversal 회피). 단 v6.6 D10 path traversal 차단 narrative 정합 본질 (외부 path reject) 자연."},
    "scope_contract": {"verdict": "PASS", "detail": "INTENT sc_1~sc_7 + oos_1~oos_5 정합. phase-1 = ARCHITECTURE 정전화 (sc_1+sc_7) / phase-2 = 2 SKILL.md (sc_2+sc_3+sc_4+sc_5+sc_6). 본질 1개 (시범 + 정전화) + phase 2 (변경 위치 분리) + lightweight 1-phase 본질 (oos_5) 유지. v3.21 narrative 정전화 3 단계 패턴 cycle 37 자연 발현 (oos 명시 부재 자연)."}
  }
}
```

### Approach narrative

DESIGN 결정 핵심 = (D1) 정전화 위치 = Option D (§ 7.3 신규 sub-section) + Option A (§ 4 매트릭스 #12 row append + 본문) 결합 → cascade host 3 개 (§ 7.3 본문 + § 4 row + § 4 본문 paragraph) → v3.21 narrative 정전화 3 단계 패턴 cycle 37 자연 발현. (D2~D8) skill 구조 결정 → frontmatter description narrow + body 4 H2 + allowed-tools 부재 + cascade marker 부재 (단방향 derived). (D9~D10) phase 2 분리 (변경 위치 분리, 본질 단일 보존).

### 5 관점 inline self-review summary

5 관점 모두 PASS (architecture / regression_risk / scope_contract) 또는 PASS-with-comments (spec_drift P2 description single-line vs multi-line / security P3 repo 내부 path 인용 본질 자연). decisive 0 / P2 1건 (description single-line) + P3 1건 (path 인용) 모두 DESIGN 안 명시 흡수.

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-21",
    "approval_summary": "DESIGN 10 결정 (D1~D10) 일괄 승인 — 정전화 위치 Option D + A 결합 (§ 7.3 신규 sub-section + § 4 매트릭스 #12 row + 본문 paragraph) + skill trigger auto-load + entry skill 코existence + 4 H2 body + skill smoke oos + allowed-tools 부재 + 5 관점 inline review + cascade marker 부재 + phase 2 분리 + v3.21 패턴 cycle 37. 5 관점 5/5 PASS (P2 1건 + P3 1건 흡수). 6 risk mitigation 정합. EXECUTE phase-1 진입 게이트 통과."
  }
}
```

### Approval narrative

사용자 명시 승인 (2026-05-21) — DESIGN 안 10 결정 일괄 통과. EXECUTE phase-1 (ARCHITECTURE.md § 7.3 신규 + § 4 매트릭스 #12 row + 본문 paragraph) → phase-2 (skills/stage-open + skills/stage-propose 2 SKILL.md) 진행 허가.

본 milestone = lightweight 1-phase 본질 (oos_5 정합) 안 phase 2 (변경 위치 분리) — 본질 단일 (시범 + 정전화) 유지 + scope ~5-10 위치 변경.

## EXECUTE

### phase-1 — ARCHITECTURE 정전화 (3 host)

별책: [`execute/phase-1.md`](execute/phase-1.md).

3 edit in `projects/meta/ARCHITECTURE.md`:

1. **§ 7.3 신규 sub-section** (line 273) — `### 7.3 Stage 본질 (templated section 작성 task)` + bold lead paragraph + canonicalization paragraph
2. **§ 4 매트릭스 #12 row append** (line 148) — v6.16 정전화 row
3. **§ 4 본문 paragraph 추가** (anchor `section-4-end-row-12`) — fixture-based smoke paragraph 다음

v3.21 narrative 정전화 3 단계 패턴 cycle 37 — (a) RESEARCH 1차 source (opt_d+opt_a) → (b) EXECUTE Edit 3 host → (c) VERIFY grep (다음 stage). AI Native § 7.1 컨텍스트 효율 면 third cycle (v6.0 → v6.2 → v6.16).

smoke 점검 — cross-ref PASS (1/0) + claude-md-drift PASS (13/13). pre-commit 18 hook 전체 검증은 phase-2 commit 시점.

### phase-2 — skills/stage-open + skills/stage-propose 2 SKILL.md 추가

별책: [`execute/phase-2.md`](execute/phase-2.md).

2 신규 파일:

1. **skills/stage-open/SKILL.md** — milestone OPEN stage 진입 시 mechanical task 3건 (디렉토리 생성 + MILESTONE.md skeleton + ROADMAP entry 추가) checklist + schema template. frontmatter description trigger narrow (4 keyword) + SKIP 2 keyword 명시 (rm_1 mitigation). body 4 H2 (입력 / 작성할 것 / 검증 / 관련).
2. **skills/stage-propose/SKILL.md** — milestone PROPOSE stage 작성 시 mechanical task 2건 (## PROPOSE 섹션 + ROADMAP next_candidates[] append) checklist + schema template. frontmatter description trigger narrow (3 keyword) + SKIP 2 keyword 명시. body 4 H2.

Skill spec 정합 (Anthropic Claude Code Skill spec, RESEARCH ext_1) — frontmatter (`---` markers + YAML) + description multi-line + body 자유 Markdown. plugin.json `skills: ./skills/` add-to-default 자동 인식 정합 (sc_5).

ARCHITECTURE § 7.3 1차 source 인용 (단방향 derived, r_3 mitigation) — 두 SKILL.md body lead paragraph 안 직접 명시.

## VERIFY

### Spec

```json
{
  "smoke": {
    "pre_commit_all_files": "PASS — 18 hook 모두 통과 (fix end of files / trim trailing whitespace / check for merge conflicts / check yaml / check for added large files / shellcheck / markdownlint / 11 smoke). full run `pre-commit run --all-files`.",
    "spec_verification": "PASS=364 FAIL=0 SKIP=160 — v6.16#intent + #research + #design + #approve PASS, #verify/#report/#propose SKIP (작성 전, VERIFY commit 후 fill). phase-1.md + phase-2.md 별책 phase/status OK.",
    "cross_ref": "PASS (1/0 broken ref) — projects/meta/ARCHITECTURE.md § 7.3 + § 4 #12 row + § 4 본문 paragraph 3 host cross-ref + milestones/v6.16/MILESTONE.md cross-ref 정합.",
    "claude_md_drift": "PASS (13/13 stages) — root ↔ 모듈 CLAUDE.md drift 부재. bootstrap/skills/CLAUDE.md + claude/CLAUDE.md + tests/CLAUDE.md + projects/meta/CLAUDE.md 안 신규 skill 인용 부재 자연 (sub-directory guide scope 외).",
    "markdownlint": "PASS — L2 EXECUTE 도중 발견 (stage-propose/SKILL.md outer markdown fence 충돌 MD031) → outer fence 폐기 + narrative lead 패턴 정정 → 회귀 0."
  },
  "criteria_check": [
    {"id": "sc_1", "result": "PASS", "evidence": "ARCHITECTURE.md § 7.3 신규 sub-section (line 273 onwards) — bold lead paragraph (★ stage 본질 자연 수렴) + canonicalization paragraph 1건 (v6.16 정전화 narrative — v6.2 era + v6.4~v6.9 mechanical cascade + skill = derived + 시범 scope + v3.21 cycle 37 + AI Native § 7.1 third cycle 명시). DESIGN D1 결정 (Option D 위치) 정합."},
    {"id": "sc_2", "result": "PASS", "evidence": "skills/stage-open/SKILL.md 신규 (149 line). frontmatter (`name: stage-open` + description multi-trigger narrow 4 keyword + SKIP 2 keyword). body 4 H2 = ## 입력 (이전 stage 부재, ROADMAP next_candidates trigger source) / ## 작성할 것 (3 task: dir 생성 + MILESTONE.md skeleton + ROADMAP entry) / ## 검증 (smoke 2건) / ## 관련 (1차 source cross-ref + 후속 stage skill cross-ref)."},
    {"id": "sc_3", "result": "PASS", "evidence": "skills/stage-propose/SKILL.md 신규 (128 line). frontmatter (`name: stage-propose` + description multi-trigger narrow 3 keyword + SKIP 2 keyword). body 4 H2 = ## 입력 (## REPORT 안 lessons trigger source) / ## 작성할 것 (2 task: ## PROPOSE 섹션 + ROADMAP next_candidates[] append) / ## 검증 (smoke 2건) / ## 관련 (1차 source + 별 mechanism /propose-next cross-ref)."},
    {"id": "sc_4", "result": "PASS", "evidence": "두 SKILL.md body 예시 narrative (실 milestone 인용) 부재 grep 확인 — checklist (필수 필드 목록) + schema template (frontmatter skeleton + section 구조) 만. DESIGN 5 관점 review P2 (description multi-line vs single-line) 안 single-line 선택 정합."},
    {"id": "sc_5", "result": "PASS", "evidence": ".claude-plugin/plugin.json `skills: ./skills/` add-to-default 명시 (v5.1+ auto-discovery). 신규 skills/stage-open + skills/stage-propose 디렉토리 추가 시 plugin.json 변경 부재 (sc_5 정합)."},
    {"id": "sc_6", "result": "PASS", "evidence": "pre-commit 18 hook 전체 PASS (full `pre-commit run --all-files`). smoke-spec-verification PASS=364 FAIL=0 SKIP=160. cross-ref / claude-md-drift / cascade-drift / candidate-draft-schema / audit-fact-verify 모두 PASS."},
    {"id": "sc_7", "result": "PASS", "evidence": "두 SKILL.md body lead paragraph 안 직접 명시 — '본 skill 은 projects/meta/ARCHITECTURE.md § 7.3 Stage 본질 (templated section 작성 task) 1차 source 의 derived checklist (단방향 derived, cascade marker 부재). 1차 source 변경 시 본 skill 후속 갱신 manual.' grep `ARCHITECTURE.md.*7.3` PASS 양방. v6.10 L3 판정 (cascade host ≥2 → 본 milestone 단일 1차 source = 적용 외) 정합."}
  ],
  "v321_cycle_37_verify_grep": {
    "host_1": "§ 7.3 (line 273) — `### 7.3 Stage 본질 (templated section 작성 task)` 헤딩 존재",
    "host_2": "§ 4 매트릭스 #12 row (line 148) — `| 12 | v6.16 (2026-05-21) | stage 본질 = templated section 작성 task 정전화...` row 존재",
    "host_3": "§ 4 본문 paragraph (line 176, anchor section-4-end-row-12) — `**stage 본질 = templated section 작성 task 정전화 및 skill 시범 도입**` paragraph 존재",
    "result": "PASS — 3 host cross-ref 정합 grep 확인 (cascade host ≥2 자연 도달)"
  },
  "risk_mitigation_check": [
    {"risk_id": "r_1", "status": "MITIGATED", "evidence": "두 SKILL.md description trigger narrow + SKIP keyword 명시 (rm_1 정합). 실 auto-load 정확도 evidence = v6.17 도그푸드 cycle 검증 자연 (이후)."},
    {"risk_id": "r_2", "status": "PENDING (v6.17 도그푸드 cycle)", "evidence": "INTENT.motivation + skill body 안 v6.17 도그푸드 첫 cycle 명시. vacuous 시 별 milestone re-evaluation candidate (PROPOSE 등재 자연)."},
    {"risk_id": "r_3", "status": "MITIGATED", "evidence": "sc_7 PASS — 두 SKILL.md body lead 안 직접 § 7.3 인용 + 단방향 derived 명시. cascade marker 부재 자연 (v6.10 L3 판정 정합)."},
    {"risk_id": "r_4", "status": "MITIGATED", "evidence": "skill body schema = 메타 narrative ('의무 필드 = ...' 형식, hardcode 제한). 실 schema 변경 시 manual 동기 갱신 명시."},
    {"risk_id": "r_5", "status": "ACKNOWLEDGED", "evidence": "INTENT oos_1 명시 + PROPOSE 단계 후속 milestone candidate 등재 (별 milestone 자연)."},
    {"risk_id": "r_6", "status": "MITIGATED", "evidence": "D3 정합 — trigger keyword 본질 별 분리. entry skill = workflow 진입 keyword / stage skill = 단일 stage keyword. 충돌 부재 가설 (v6.17 도그푸드 실 검증 자연)."}
  ],
  "verdict": "PASS — INTENT 7 success_criteria 전부 PASS + 6 risk mitigation 4 MITIGATED + 1 PENDING (도그푸드 자연) + 1 ACKNOWLEDGED (oos) + v3.21 cycle 37 (c) VERIFY grep 3 host 정합 + pre-commit 18 hook 전체 PASS. REPORT + PROPOSE 진입 게이트 통과."
}
```

### v3.21 narrative 정전화 3 단계 패턴 cycle 37 (c) VERIFY grep evidence

3 host cross-ref grep 정합 (line:
148/176/273):

- **host_1** (line 148) — § 4 매트릭스 #12 row append (`| 12 | v6.16 (2026-05-21) | stage 본질 = templated section 작성 task 정전화 ...`)
- **host_2** (line 176) — § 4 본문 paragraph (anchor `section-4-end-row-12`, `**stage 본질 = templated section 작성 task 정전화 및 skill 시범 도입**` lead)
- **host_3** (line 273) — § 7.3 신규 sub-section (`### 7.3 Stage 본질 (templated section 작성 task)`)

cascade host ≥2 자연 도달 — v3.21 패턴 적용 정합 (v6.10 L3 판정 = host ≥2 → 적용). cycle 37 (v6.15 cycle 36 직접 후속) 자연 발현.

### AI Native § 7.1 third cycle evidence

컨텍스트 효율 면 누적 cycle 3 (v6.0 → v6.2 → v6.16) — § 7.3 본문 안 직접 명시.

## REPORT

(미작성 — Stage H REPORT 에서 작성)

## PROPOSE

(미작성 — Stage I PROPOSE 에서 작성)

## SUB_MILESTONES

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음)
