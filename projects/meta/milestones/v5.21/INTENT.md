# INTENT — v5.21 (또는 v6.0, RESEARCH 안 결정)

```json
{
  "id": "roadmap-forward-looking-redesign-and-changelog-archival",
  "title": "ROADMAP forward-looking 재정의 (recent 3건 + next_candidates only) + CHANGELOG.md v5.7~v5.20 14 entry backfill + completed entry CHANGELOG 이전 + cascade narrative",
  "version_candidate": ["v5.21", "v6.0"],
  "goal": "projects/meta/ROADMAP.md (+ projects/upbit/ROADMAP.md cascade) 를 사전적 의미 (이정표 = forward-looking 미래지향 계획표) 에 부합하는 thin entry list 로 재정의. 과거 completed entry 의 long narrative summary 를 CHANGELOG.md (Keep a Changelog v1.1.0 정합) 로 흡수 이전하고, ROADMAP 본문에는 recent 3건 + in_progress + next_candidates (PROPOSE 발의 후보) 만 보존. 동시 누락 발견된 CHANGELOG.md v5.7~v5.20 14 entry backfill 통합.",
  "motivation": "§ 4 끝 #3 narrative 'ROADMAP 단어 drift 수용' (v5.9_dictionary-semantics-integrated-audit 정전화) 는 ROADMAP 사전적 의미 (Merriam-Webster '목표를 향한 진행을 안내하는 상세 계획' / Cambridge 'step-by-step visibility') 와 실 상태 (v5.9 시점 50 entry / completed 46 / deferred 3 / in_progress 1 / pending 0, completed-dominant 92% / forward-looking 0%) 의 ~30~40% 부합도 를 drift 수용 narrative 로 default 채택. 사용자 명시 발의 (A_user, 2026-05-19) — drift 수용 → drift 해소 방향 첫 evidence-base trigger 사례. PROPOSE 70% drift (제안+등재 2 책임) 의 등재 책임이 ROADMAP forward-looking entry 로 자연 흡수. ROADMAP 비대화 해소 (현 ~1500 line → ~150 line 예상). 5요소 매핑 = Trace (혼재 임시방편 → narrative 대체, ARCHITECTURE § 3.3 매트릭스).",
  "success_criteria": [
    {
      "id": "sc_1",
      "description": "projects/meta/ROADMAP.md 안 `milestones[]` array length = 4 (in_progress 1 + recent completed 3) — next_candidates 는 별도 필드 또는 별도 section (RESEARCH 안 schema 결정)"
    },
    {
      "id": "sc_2",
      "description": "CHANGELOG.md 안 [v5.7] ~ [v5.20] 14 entry 역순 삽입 (Keep a Changelog v1.1.0 권장 위치 = [Unreleased] 아래 최상단부터 최신 → 과거)"
    },
    {
      "id": "sc_3",
      "description": "projects/meta/ROADMAP.md 안 과거 completed entry 41건 (v5.20 ~ v1.0_workflow-redesign, recent 3건 제외) summary narrative 가 CHANGELOG.md 안 동치 entry 로 이전됨 (역참조 cross-ref = milestones/v{X.Y}/REPORT.md). 일부 entry 는 이미 CHANGELOG 안 [v3.x] [v2.x] [v1.x] 으로 존재 — 중복 회피 + 누락 entry backfill"
    },
    {
      "id": "sc_4",
      "description": "ROADMAP 사전적 의미 부합도 ~30~40% → 95%+ (forward-looking entry 비중 ≥ 75%, completed entry 는 'recent' frame 정합 위치만)"
    },
    {
      "id": "sc_5",
      "description": "cascade host narrative drift 0 — root CLAUDE.md / AGENTS.md / README.md / claude/commands/harness-meta.md / GUARDRAILS.md / projects/meta/CLAUDE.md / projects/meta/ARCHITECTURE.md / tests/CLAUDE.md / docs/adr/ 안 ROADMAP entry 직접 참조 모두 갱신 (RESEARCH 안 grep inventory)"
    },
    {
      "id": "sc_6",
      "description": "tests/smoke-projects-scope-discipline.sh 통과 — schema 변경 시 smoke 동기 갱신 (RESEARCH 안 영향 분석 후 결정)"
    },
    {
      "id": "sc_7",
      "description": "pre-commit 14 hook 모두 PASS, 회귀 0"
    },
    {
      "id": "sc_8",
      "description": "milestone trace 보존 — 각 archived entry 의 milestones_path field 가 milestones/v{X.Y}/REPORT.md 또는 milestones/v{X.Y}_{slug}/REPORT.md 안 1차 source 유지 (git history + REPORT.md 자체 + CHANGELOG.md entry 3중 archival)"
    },
    {
      "id": "sc_9",
      "description": "INTENT/RESEARCH/DESIGN/APPROVE/PROPOSE schema smoke-spec-verification 통과 — 필드 누락 0 ([feedback_intent_md_schema_required](../../../../../../.claude/projects/C--Users-qkreh-harness-meta/memory/feedback_intent_md_schema_required.md) + [feedback_approve_md_schema_wrap](../../../../../../.claude/projects/C--Users-qkreh-harness-meta/memory/feedback_approve_md_schema_wrap.md) 정합)"
    }
  ],
  "out_of_scope": [
    {
      "id": "oos_1",
      "item": "9-stage workflow 자체 변경 (OPEN/INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE 단어/책임)",
      "reason": "본 작업은 Trace 메커니즘 재정의 — Workflow 자체 변경 아님. § 4 끝 #2 word-fidelity drift 수용 narrative (86.1% baseline) 는 그대로 유지. workflow self-improvement 자기참조 사이클 회피"
    },
    {
      "id": "oos_2",
      "item": "PROPOSE register 책임 분리 (10-stage 분리 = PROPOSE + REGISTER 2 stage)",
      "reason": "ROADMAP forward-looking 재정의로 PROPOSE register 책임의 의미는 부분 흡수되지만 단어/책임 자체 분리는 별 milestone. 본 milestone scope 폭주 회피"
    },
    {
      "id": "oos_3",
      "item": "INTENT/DESIGN/EXECUTE/RESEARCH 등 다른 stage 단어 부합 정정 (INTENT 80% / DESIGN 80% / RESEARCH 85% / EXECUTE 85% drift)",
      "reason": "본 milestone 은 ROADMAP 단어 (~30~40%) + PROPOSE 단어 (70%) drift 해소 본질. 다른 stage 단어 정정은 별 evidence-base trigger 필요"
    },
    {
      "id": "oos_4",
      "item": "ROADMAP-archive.md 신규 / milestones/ 디렉토리 archival 변경",
      "reason": "AskUserQuestion 1 결정 — CHANGELOG.md 흡수 채택. 별 archival 위치 신규 회피 (Keep a Changelog 정합 도구 하나 적은 관리 책임)"
    },
    {
      "id": "oos_5",
      "item": "projects/upbit/ROADMAP.md 동일 재정의 (upbit ROADMAP 도 forward-looking 재정의)",
      "reason": "upbit ROADMAP 은 외부 프로젝트 trace — 본 milestone scope 안 cascade narrative drift 0 검증 만, 본질 재정의 는 upbit repo 본 작업. 단 schema migration cascade (예: status field 통일) 는 RESEARCH 안 영향 분석 후 결정"
    },
    {
      "id": "oos_6",
      "item": "root ROADMAP.md (thin index) 본질 변경",
      "reason": "root ROADMAP.md 는 이미 thin index ({ projects: [...] }), 본 milestone 영향 부재. milestones[] 안 entry 없음 = 사전적 의미 부합 100%"
    }
  ],
  "dependencies": [
    {
      "id": "dep_1",
      "item": "§ 4 끝 #3 narrative 'ROADMAP 단어 drift 수용' (v5.9_dictionary-semantics-integrated-audit, projects/meta/ARCHITECTURE.md:151)",
      "reason": "정전화된 drift 수용 narrative 가 본 milestone evidence-base trigger 의 1차 source"
    },
    {
      "id": "dep_2",
      "item": "CHANGELOG.md 현 상태 ([v5.6]까지 backfill, v3.15_changelog-v3-backfill 패턴)",
      "reason": "본 milestone backfill scope (v5.7~v5.20) + archival 이전 본문 schema 정합"
    },
    {
      "id": "dep_3",
      "item": "v1.1_meta-as-project (2026-05-08) — root ROADMAP.md thin index 분리 patten",
      "reason": "projects/meta/ROADMAP.md 가 'milestone 등재 단일 source 책임' 으로 운용된 historical context — 본 milestone 안 archival 흡수 변경의 의미 분석 1차 source"
    },
    {
      "id": "dep_4",
      "item": "tests/smoke-projects-scope-discipline.sh",
      "reason": "ROADMAP schema 변경 시 smoke 호환성 검증 + 신 schema 정합 갱신 필요 여부 RESEARCH 안 분석"
    },
    {
      "id": "dep_5",
      "item": "AskUserQuestion 3 round 사전 결정 (2026-05-19 round)",
      "reason": "Q1 archival = CHANGELOG / Q2 recent 3건 / Q3 bump RESEARCH 일임 / 4 backfill scope = 합쳐서 → DESIGN approach 1차 source"
    }
  ],
  "harness_engineering_mapping": {
    "element": "Trace",
    "classification_target": "(c) 정전 sub-mechanism 분리 (forward-looking 부분 + past trace 부분)",
    "rationale": "현 ARCHITECTURE § 3.3 매트릭스 Trace 행 (c) = 이미 '정전 (메타 고유 차별화)'. 본 milestone 은 (c) 정전 status 변경 아님 — Trace 본질은 처음부터 정전. 변경 본질 = (b) mechanism cross-ref 갱신 — sub-mechanism 분리 (milestones[] forward-looking + next_candidates[] forward-looking + CHANGELOG.md past trace + REPORT.md + git history 다중 archival). § 3.6 신규 milestone 발의 평가 절차 정합 = '정전 요소의 sub-mechanism 보강'. 5 관점 architecture review P1 권고 흡수 (2026-05-19 review)"
  }
}
```

## 명료화

### 본 milestone 의 self-loop 인지

v5.8 정량 = 13 / 12 self-loop = 92.3% (v4.0~v5.7 baseline). 본 milestone 진입 시 self-loop +1 도달 가능 — 단 본 milestone scope = Trace 요소 재정의 (Workflow 자체 변경 부재) → workflow self-improvement 본질 아님. § 4 끝 #1 narrative (B/C/D 부산물 PROPOSE 흡수 책임) + #2 (word-fidelity drift 수용) + #3 (ROADMAP 단어 drift 수용) 중 #3 의 drift 해소 첫 사례 = evidence-base trigger 정당. 자기참조 cycle 인지 위 § 5 사항 명시 (PROPOSE next_candidates 안 후속 발의 회피 narrative).

### 사용자 명시 발의 trigger 정당화

memory `feedback_section_6_2_abolished` — § 6.2 폐지 narrative 후 workflow self-improvement 가 v4.0 정체성 (composer + integrator + maintainer) 에 자연 부합 안 함 정합 표현 의무. 본 milestone 본질:

- Workflow 자체 변경 = 부재 (9-stage 그대로) → workflow self-improvement 본질 아님
- Trace 메커니즘 재정의 = ROADMAP 단어 부합 + CHANGELOG 흡수 → § 3.3 5요소 매트릭스 Trace 행 (c) 정전 강화
- 외부 적용 vector 영향 = ROADMAP 사전적 의미 부합 100% 도달 시 ecosystem integrator 정체성 (외부 ROADMAP 컨벤션 정합) 자연 부합 일부 향상 — RESEARCH 안 정량 분석 후 검증

사용자 발의 timing — v5.20 audit cycle 7 stability 도달 (cycle 5+6+7 동일 baseline) 후 사용자 자체 사전 의미 부합 round 명시 → § 4 끝 #3 narrative 의 'evidence-base trigger' 충족 가능 (RESEARCH 안 정량 trigger 분석).

## 관련

- 사용자 명시 발의 round 1차 source: 2026-05-19 round AskUserQuestion 1 (선검토 후 결정) + round 2 (방향 결정 = 사용자 자연어 제안 "ROADMAP -> MILESTONES -> ... 미래지향 + 최근 완료 + PROPOSE 제안") + round 3 (archival CHANGELOG / recent 3건 / bump RESEARCH 일임) + round 4 (backfill scope 합쳐서)
- 1차 source narrative: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 4 끝 #3 ROADMAP 단어 drift 수용 (L151)
- 정량 evidence baseline: [`../v5.9/RESEARCH.md`](../v5.9/RESEARCH.md) § axis_c_roadmap_word
- Keep a Changelog 정합 baseline: [`../_archive/v3.15/REPORT.md`](../_archive/v3.15/REPORT.md) + [`../_archive/v3.16/REPORT.md`](../_archive/v3.16/REPORT.md)
- milestones.md spec: [`milestones.md`](milestones.md) (sub-milestone listing, DESIGN 안 phase 결정 후 갱신)
