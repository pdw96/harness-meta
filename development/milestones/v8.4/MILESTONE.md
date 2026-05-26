---
id: audit-team-heterogeneous-harness-conflict-case
title: audit-team 충돌 매트릭스에 이종 하네스 충돌 case 추가
version: v8.4
status: completed
---

# v8.4 — audit-team 충돌 매트릭스에 이종 하네스 충돌 case 추가

## INTENT

### Spec

```json
{
  "id": "audit-team-heterogeneous-harness-conflict-case",
  "title": "audit-team 충돌 매트릭스에 이종 하네스 충돌 case 추가",
  "goal": "harness-gap-analyzer 충돌 detect 에 '기존 이종 하네스(비-harness-meta 방식, 예: gsd) vs harness-meta 신규 권고' 충돌 판정을 추가하고 project-scanner harness_state 에 방식 판정 힌트 1줄을 보강하여, audit-team 이 이미 하네스를 보유한 외부 프로젝트를 만났을 때 충돌 회피를 chain 초입(Step 2)에서 구조적으로 판정하도록 한다.",
  "motivation": "5요소 = Constraint (audit-team 이 위반하면 안 되는 '기존 자산 충돌 회피' 규칙). v8.3 price-compare 외부 적용에서 노출 + RESEARCH 정밀 조사로 진단 정정 — 'project-scanner 가 기존 하네스를 못 본다'는 부정확(harness_state 로 inventory 함). 진짜 gap = gap-analyzer Task2 충돌 매트릭스가 'custom vs Claude Code built-in'(bootstrap/agents/CLAUDE.md:132-141) 만 다루고 이종 하네스 충돌 축 부재 + orchestrator Step6 은 fact/lint 만이라 입력 전제 정정이 구조적으로 강제 안 됨(v8.3 정정은 ad-hoc, 다음 보장 없음).",
  "success_criteria": [
    {"id": "sc_1", "criterion": "harness-gap-analyzer 충돌 detect 에 '이종 하네스 vs harness-meta 권고' 충돌 판정 추가 — 기존 4 case(built-in 충돌)와 의미축이 다르므로 별도 case/블록. 조건(harness_state 비어있지 않음 + 비-harness-meta 방식) + 권장 결정(충돌 회피 우선: 기존 자산 존중·격차만 보강·워크플로우 강제 금지)."},
    {"id": "sc_2", "criterion": "project-scanner.md harness_state 에 방식 판정 힌트(harness_kind 추정: harness-meta/heterogeneous/mixed/blank) 1줄 보강 — gap-analyzer 가 case 판정에 쓸 신호."},
    {"id": "sc_3", "criterion": "1차 source(bootstrap/agents/CLAUDE.md)와 재게재(harness-gap-analyzer.md) 단일 source 정합 유지 — 한쪽만 갱신해 drift 발생 안 함."},
    {"id": "sc_4", "criterion": "v8.3 price-compare 시나리오 재대입 시 C1(gsd 워크플로우 충돌)이 Step2(gap-analyzer)에서 자동 분류됨을 narrative 로 검증(Step6 ad-hoc 아님)."},
    {"id": "sc_5", "criterion": "기존 audit-team 책임/9-stage 무손상 + smoke 전체 PASS(FAIL=0). built-in 충돌 4 case·fleet evolution 5 case 무변경."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "orchestrator Step 1.5 '전제 대조' step 신설(흐름 레벨 구조 변경) — 매트릭스/판정 보강이 동일 효과를 더 작게 달성하므로 보류(과적합 회피)."},
    {"id": "oos_2", "item": "project-scanner harness_state JSON schema 전면 재설계 — 힌트 1줄만, 새 강제 필드 도입 아님."},
    {"id": "oos_3", "item": "price-compare 실 재audit 실행 — narrative 시뮬레이션 검증만(1건 사례 과적합 회피, 실 재적용은 verification-philosophy-redefine 후속)."}
  ],
  "dependencies": [
    {"id": "dep_1", "ref": "development/milestones/v8.3/LIGHTWEIGHT.md", "purpose": "직접 origin — audit-team 백지전제 결함 관찰 + 후보 등록."},
    {"id": "dep_2", "ref": "bootstrap/agents/CLAUDE.md:132-141 (Conflict Resolution 4 case 매트릭스, 1차 source) + agents/harness-gap-analyzer.md:42-48 (재게재)", "purpose": "충돌 판정 변경 대상 — 단일 source 정합 의무(sc_3)."},
    {"id": "dep_3", "ref": "agents/project-scanner.md:50-57 (harness_state)", "purpose": "방식 판정 힌트(harness_kind) 보강 대상."}
  ]
}
```

### Narrative

v8.3 price-compare 외부 적용에서 audit-team 이 '이미 이종 하네스(gsd)를 보유한 외부 프로젝트' 를 만났고, 충돌 회피 판단이 chain 끝(Step6 synthesizer)에서 ad-hoc 으로 일어났다. RESEARCH 정밀 조사 결과 '못 본다(scan 누락)' 가 아니라 '본 결과를 충돌 회피로 연결하는 판정이 매트릭스에 없다' 가 진짜 gap 임을 확정했다 — 기존 충돌 4 case 는 'custom vs Claude Code built-in' 축 전용(bootstrap/agents/CLAUDE.md:134 명시). 본 milestone 은 그 빠진 축('이종 하네스 vs harness-meta 권고')을 gap-analyzer 충돌 detect 에 **최소 보강**하여 정정을 Step6→Step2 로 당긴다. audit-team 은 외부 제공 컨설팅 도구이므로 규모가 작아도 §7.4 상 9-stage 큰 건이며, 1건 사례 과적합을 피해 흐름 레벨 step 신설(oos_1)은 보류한다.

## RESEARCH

### Spec

```json
{
  "external": [],
  "codebase": [
    {"id": "cb_1", "ref": "agents/project-scanner.md:30-67", "finding": "Step1 scanner 가 harness_state(claude_dir/agents[]/commands[]/hooks[]/claude_md/claude_md_identity/harness_toml)로 기존 하네스를 완전 inventory. 단 '백지 vs harness-meta vs 이종' 방식 판정 신호 부재 — raw list 만."},
    {"id": "cb_2", "ref": "agents/harness-gap-analyzer.md:38-51 (Task2)", "finding": "Task2 = bootstrap/agents/CLAUDE.md § Conflict Resolution 4 case 매트릭스 재게재 + 각 custom 정의별 case 분류. 4 case 전부 'custom vs Claude Code built-in' 축. '대상의 기존 이종 하네스 vs harness-meta 가 새로 권고하는 것' 충돌 축은 부재."},
    {"id": "cb_3", "ref": "bootstrap/agents/CLAUDE.md:132-141", "finding": "충돌 매트릭스 1차 source(v4.0). line134 정의 = 'Custom(bootstrap/agents/) vs Claude Code built-in'. gap-analyzer.md 는 재게재 host. ∴ 변경은 1차 source + 재게재 양쪽 동기 필요(단일 source 정합)."},
    {"id": "cb_4", "ref": "agents/audit-orchestrator.md:69-91 (Step6)", "finding": "Step6 = synthesizer fact verify(audit_fact_verify.py) + markdown lint precheck 전용. '입력 전제 vs 스캔 현실 대조'는 정의된 책임 아님 — v8.3 정정은 chain 에 정의 안 된 ad-hoc. 구조적 강제 부재 확인."},
    {"id": "cb_5", "ref": "bootstrap/agents/CLAUDE.md:145-153 (Fleet Lifecycle 5 case)", "finding": "fleet evolution 5 case(scope 확장/분할/신규/통합/삭제)는 본 충돌 축과 직교 — 무변경 대상(sc_5). built-in 4 case 와도 직교."}
  ],
  "options": [
    {"id": "opt_1", "label": "기존 4 case 매트릭스에 5번째 행 추가 — 비채택", "rationale": "매트릭스 정의가 'custom vs built-in'(cb_3 line134) 명시 — 이종 하네스 충돌은 다른 축이라 같은 표에 끼우면 의미 혼선. REJECT."},
    {"id": "opt_2", "label": "gap-analyzer Task2 에 별도 판정 블록(예: '이종 하네스 충돌 회피') + bootstrap 1차 source 동기 — 채택 후보", "rationale": "의미축 분리 보존 + 최소 변경. project-scanner harness_kind 힌트(sc_2)가 입력 신호. DESIGN 확정."},
    {"id": "opt_3", "label": "orchestrator Step1.5 전제 대조 step 신설 — 보류(oos_1)", "rationale": "흐름 레벨 구조 변경 = 더 큼. 매트릭스 보강이 동일 효과를 작게 달성하므로 1건 사례 단계에선 과함."}
  ],
  "risks_identified": [
    {"id": "risk_1", "severity": "medium", "risk": "1건 사례(price-compare) 기반 과적합 — gsd 특화 판정이 일반 이종 하네스에 안 맞을 수 있음.", "mitigation": "harness_kind 를 '비-harness-meta 방식 일반'으로 추상화 + 권장 결정을 '충돌 회피 우선' 원칙 1줄로 둠(특정 도구명 hardcode 회피)."},
    {"id": "risk_2", "severity": "low", "risk": "1차 source(bootstrap) ↔ 재게재(gap-analyzer.md) drift.", "mitigation": "sc_3 단일 source 정합 + smoke-cross-ref 검증."}
  ]
}
```

### Narrative

조사로 결함 좌표를 3겹으로 확정했다(cb_1 scanner 판정신호 부재 / cb_2 gap-analyzer 축 부재 / cb_4 orchestrator 전제대조 부재). 최소·정합 해법은 opt_2 — 의미축이 다른 별도 판정 블록을 gap-analyzer 에 두고 1차 source(bootstrap)와 동기하며, scanner 에 harness_kind 힌트를 더해 입력 신호를 만든다. opt_1(같은 표 5행)은 의미 혼선으로, opt_3(흐름 step)은 과함으로 배제. 과적합 risk 는 도구명 hardcode 회피 + 원칙 1줄 추상화로 완화한다.

## DESIGN

### Spec

```json
{
  "decisions": [
    {"id": "D1", "decision": "opt_2 채택 — gap-analyzer 에 '이종 하네스 충돌 회피' 별도 판정 블록 추가(기존 4 case 표 불변). 1차 source(bootstrap/agents/CLAUDE.md)에 정의 + harness-gap-analyzer.md 에 재게재 동기."},
    {"id": "D2", "decision": "project-scanner.md Task2(Harness 현 상태) + Output 예시에 harness_kind 판정 힌트 1줄 추가 — harness_state 가 채워졌고 harness_toml=false 이며 정체성/구조가 비-harness-meta 면 'heterogeneous' 추정. 강제 필드 아닌 추정 힌트(oos_2)."},
    {"id": "D3", "decision": "권장 결정 문구 = 도구명(gsd) hardcode 회피, '비-harness-meta 방식 하네스 광범위 보유 시 충돌 회피 우선 — 기존 자산 존중·격차만 보강·워크플로우/중복 agent 강제 금지' 원칙형(risk_1 완화)."},
    {"id": "D4", "decision": "design-review subagent(N+ 가변) 생략 — 변경이 매트릭스 블록 1개 + 힌트 1줄로 좁고 외부 spec drift 무관(external=[]). inline 5관점 약식 검토로 대체."}
  ],
  "approach": "단일 phase mechanical edit — (1) bootstrap/agents/CLAUDE.md 충돌 섹션에 '이종 하네스 충돌 회피' 판정 블록 추가, (2) agents/harness-gap-analyzer.md Task2 에 동일 판정 재게재, (3) agents/project-scanner.md 에 harness_kind 힌트 1줄. 그 후 sc_4 narrative 시뮬레이션 + smoke.",
  "phases": [
    {"id": "phase-1", "name": "이종 하네스 충돌 판정 보강 (3 파일 edit)", "files": ["bootstrap/agents/CLAUDE.md", "agents/harness-gap-analyzer.md", "agents/project-scanner.md"], "commit": "feat(meta): [v8.4] audit-team 이종 하네스 충돌 판정 보강"}
  ],
  "risk_mitigation": [
    {"ref": "risk_1", "design": "D3 원칙형 문구 — 특정 도구 비종속."},
    {"ref": "risk_2", "design": "D1 양쪽 동기 + smoke-cross-ref."}
  ],
  "inline_5_review": {
    "architecture": "기존 4 case 표·fleet 5 case 무손상, 별도 블록 추가라 구조 충돌 0(sc_5).",
    "spec_drift": "Claude Code 외부 spec 무관(internal agent 정의) — drift 위험 없음.",
    "scope": "INTENT sc_1~sc_5 ↔ phase-1 직접 정합. oos_1(흐름 step)·oos_3(실 재audit) 범위 외 준수.",
    "trace": "변경 = agent .md 3개 + 본 MILESTONE.md. v8.3 origin cross-ref 보존.",
    "over_engineering": "최소 변경(블록1+힌트1) 확인 — opt_1/opt_3 배제로 과확장 회피."
  }
}
```

### Narrative

설계 결정은 opt_2 의 구체화다. 기존 충돌 4 case 표는 손대지 않고(D1), 의미축이 다른 '이종 하네스 충돌 회피' 판정을 별도 블록으로 1차 source(bootstrap)에 정의한 뒤 gap-analyzer 재게재에 동기한다. scanner 에는 harness_kind 추정 힌트 1줄(D2)을 더해 gap-analyzer 가 쓸 입력 신호를 만든다. 권장 결정은 특정 도구(gsd) 비종속 원칙형 문구(D3)로 과적합을 막는다. 변경이 좁고 외부 spec 무관이라 design-review subagent 는 생략하고 inline 5관점 약식 검토로 대체했다(D4) — 5관점 모두 통과(구조 충돌 0 / drift 무관 / scope 정합 / trace 보존 / 최소 변경). EXECUTE 는 단일 phase mechanical edit 후 sc_4 narrative 시뮬레이션 + smoke 로 검증한다.

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-26",
    "approval_summary": "DESIGN opt_2(이종 하네스 충돌 회피 별도 판정 블록) 승인. 3 파일 최소 변경(bootstrap/agents/CLAUDE.md 1차 source + harness-gap-analyzer.md 재게재 + project-scanner.md harness_kind 힌트), 도구명 hardcode 회피 원칙형 문구, orchestrator 흐름 step 보류(oos_1), design-review 생략 + inline 5관점 약식 검토 — 모두 승인. EXECUTE 단일 phase 진행, 커밋 전 재확인 조건."
  }
}
```

### Narrative

사용자 명시 승인 (2026-05-26) — "승인, EXECUTE 진행해줘". DESIGN 4 결정(D1~D4) + 범위 경계(oos_1 흐름 step 보류 / oos_3 실 재audit 보류) 그대로 수용. EXECUTE 진입 게이트 통과.

## EXECUTE

### Spec

```json
{
  "phases": [
    {"id": "phase-1", "name": "이종 하네스 충돌 판정 보강", "status": "done", "files_changed": 3, "detail": "execute/phase-1.md", "commit": "feat(meta): [v8.4] audit-team 이종 하네스 충돌 판정 보강 (pending)"}
  ]
}
```

### Narrative

단일 phase mechanical edit 완료 — (1) `bootstrap/agents/CLAUDE.md` 신규 `## 이종 하네스 충돌 회피 판정` 섹션(1차 source), (2) `agents/harness-gap-analyzer.md` `### Task 2.5` 재게재, (3) `agents/project-scanner.md` harness_kind 힌트(Task + JSON). 기존 4 case·5 case 매트릭스 불변. 상세 = `execute/phase-1.md`. 커밋은 VERIFY 후 사용자 승인 게이트.

## VERIFY

### Spec

```json
{
  "smoke": {"smoke-cross-ref": "PASS", "smoke-spec-verification": "PASS=473 FAIL=0 SKIP=273", "pre-commit": "18 hook 전부 Passed"},
  "criteria_check": [
    {"id": "sc_1", "verdict": "PASS", "evidence": "bootstrap/agents/CLAUDE.md 신규 § 이종 하네스 충돌 회피 판정 — 기존 4 case 표 불변(별도 축). harness_kind 4값 권장 결정 표."},
    {"id": "sc_2", "verdict": "PASS", "evidence": "project-scanner.md Task2 harness_kind 추정 규칙 1줄 + Output JSON harness_state.harness_kind 필드(grep 2건)."},
    {"id": "sc_3", "verdict": "PASS", "evidence": "bootstrap(1차)↔gap-analyzer(재게재) 동기 확인 + smoke-cross-ref PASS. drift 0."},
    {"id": "sc_4", "verdict": "PASS", "evidence": "price-compare 재대입 시뮬레이션(아래 narrative) — harness_kind=heterogeneous → Task 2.5 가 Step2 에서 충돌 회피 분류, Step6 ad-hoc 아님."},
    {"id": "sc_5", "verdict": "PASS", "evidence": "smoke 473 PASS FAIL=0, built-in 4 case·fleet 5 case 무변경, pre-commit 18 hook PASS."}
  ],
  "verdict": "RESOLVED"
}
```

### Narrative (sc_4 시뮬레이션)

v8.3 price-compare 입력을 보강된 chain 에 재대입: project-scanner 가 `harness_state` = {agents:[6], rules:[3], hooks:[PreToolUse], harness_toml:false, claude_md_identity:비-harness-meta} → **harness_kind=heterogeneous** 추정. gap-analyzer 가 Task 2 (built-in 충돌) **이전** Task 2.5 에서 heterogeneous 판정 → '충돌 회피 우선' lens 활성 → Task 1 gap 을 '신규 구축' 이 아닌 '격차 보강' 으로, 워크플로우/중복 agent 권고를 '강제 금지' 로 자동 분류. 즉 v8.3 에서 Step 6 (synthesizer) 가 ad-hoc 으로 수행한 C1 충돌 회피 판정이 **Step 2 로 당겨져 구조적으로 강제됨**. 결함 정정 확인.

## REPORT

### Spec

```json
{
  "summary": "audit-team 의 이종 하네스 충돌 회피를 chain 초입(Step 2)에서 구조적으로 판정하도록 최소 보강(3 파일). 1차 source(bootstrap) § 신규 + gap-analyzer Task 2.5 재게재 + project-scanner harness_kind 힌트. v8.3 결함(Step6 ad-hoc 정정)을 Step2 로 당김.",
  "delta": "INTENT sc_1~sc_5 전부 PASS, verdict RESOLVED. 범위 정확 준수 — oos_1(흐름 step 신설)·oos_3(실 재audit) 보류, 기존 4 case/5 case 무변경. 변경 LOC 작음(블록 1 + Task 1 + 힌트 1줄).",
  "lessons_learned": [
    {"id": "L1", "lesson": "진단 정정의 가치 — v8.3 LIGHTWEIGHT 의 '백지=못 본다' 가 RESEARCH 1차 source 직접 read 로 '본다 but 분기 안 함' 으로 정정. 후보 등록 시 진단과 milestone RESEARCH 진단이 다를 수 있으며, 코드 직접 확인이 scope 를 좁힌다(매트릭스 1행 ≪ 흐름 step 신설)."},
    {"id": "L2", "lesson": "의미축 분리 — 기존 충돌 4 case(custom vs built-in)에 5번째 행으로 억지로 끼우지 않고 별도 축(이종 하네스 vs harness-meta)으로 둠. 1차 source 정의 문구(line134)가 축을 명시했기에 혼선 회피 가능했다."},
    {"id": "L3", "lesson": "§7.4 트랙 판단 = 규모 아닌 자산 성격. audit-team(외부 제공 컨설팅 도구)은 변경이 작아도 9-stage. 중간에 규모로 가벼운 흐름 강등을 시도했으나 '고객 납품물 vs 내부 운영' 판단 축으로 정정 — v8.2(내부 도구)와의 대조가 기준."}
  ]
}
```

### Narrative

본 milestone 은 v8.3 외부 적용에서 노출된 audit-team 결함을 최소 변경으로 정정했다. 핵심은 RESEARCH 정밀 조사가 후보 등록 시 진단('백지 전제로 못 본다')을 '스캔은 하나 충돌 회피로 연결하는 판정이 빠졌다' 로 정정한 것(L1) — 이로써 흐름 레벨 step 신설(과함)이 아닌 매트릭스 별도 축 보강(최소)으로 scope 가 좁혀졌다. 변경은 1차 source(bootstrap) + 재게재(gap-analyzer) + 입력 신호(scanner harness_kind) 3 파일이며 단일 source 정합을 유지했다(L2). audit-team 이 외부 제공 컨설팅 도구라 규모와 무관하게 9-stage 로 진행한 것이 §7.4 판단 축 정합이었다(L3).

## PROPOSE

### Spec

```json
{
  "next_candidates": [
    {"id": "audit-orchestrator-premise-reconcile-step", "title": "orchestrator Step 1.5 전제 대조 step 신설", "trigger": "D_design", "rationale": "본 milestone oos_1 — 매트릭스 판정으로 충분했으나, 이종 하네스 외부 사례가 더 누적되면(현 1건) 흐름 레벨에서 '입력 전제 vs 스캔 현실' 대조를 orchestrator Step 1.5 로 명시하는 더 견고한 구조 가능. 사례 누적 trigger 후 발의 후보(지금 ROADMAP append 는 과적합 — 사용자 명시 결정 후만, v7.0 T1.2)."}
  ],
  "follow_up_natural": "verification-philosophy-redefine(v8.0 oos_3) 에서 price-compare 실 재audit 시 본 보강(Task 2.5)의 실효를 외부 vector 로 검증 — oos_3(시뮬레이션만)의 실 검증 분리."
}
```

### Narrative

후속은 두 갈래다. (1) orchestrator Step 1.5 전제 대조 step(oos_1) — 본 milestone 은 매트릭스 판정으로 최소 해결했으나, 이종 하네스 외부 사례가 더 쌓이면 흐름 레벨 강화가 정당해진다. 1건 사례 단계에선 과적합이라 사례 누적을 trigger 로 두고 지금 ROADMAP append 는 보류(v7.0 T1.2 — 사용자 명시 결정 후만). (2) 본 보강의 실효 검증은 verification-philosophy-redefine 에서 price-compare 실 재audit(외부 vector)로 — oos_3 시뮬레이션 검증의 실 검증 분리.

## SUB_MILESTONES

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음)
