# RESEARCH — v3.17_phase-distribution-audit

```json
{
  "id": "v3.17_phase-distribution-audit",
  "external": [
    {
      "source": "사용자 명시 의문 (A_user trigger)",
      "topic": "milestone 하나에 phase 가 1개로 진행되는 게 이해가 안 간다",
      "findings": "v3.0+ 9-stage-bundled era 도입 narrative (같은 의미 단위 후속 candidates 를 version 단위 1 milestone (sub-milestone phase 매핑) 으로 통합) 와 실 진행 패턴 (1-phase 12/17 = 70.6%) 사이 정량 괴리 의문. INTENT.success_criteria 본 의문 답변 책임 1:1 매핑.",
      "drift": "OPEN 시점 estimate 11/17 = 64.7% 였으나 RESEARCH 정확 측정 결과 12/17 = 70.6% (drift +1 milestone)"
    }
  ],
  "codebase": {
    "affected_files": [
      "projects/meta/ROADMAP.md (entry summary 본문 — 1-phase 11→12 정정 cascade)",
      "projects/meta/milestones/v3.17/INTENT.md (success_criteria 정확 측정 cascade)",
      "projects/meta/milestones/v3.17/RESEARCH.md (본 파일, 1차 source)",
      "projects/meta/milestones/v3.17/DESIGN.md",
      "projects/meta/milestones/v3.17/APPROVE.md",
      "projects/meta/milestones/v3.17/VERIFY.md",
      "projects/meta/milestones/v3.17/REPORT.md",
      "projects/meta/milestones/v3.17/PROPOSE.md",
      "projects/meta/milestones/v3.17/milestones.md",
      "projects/meta/milestones/v3.17/execute/phase-1.md"
    ],
    "untouched_files_explicit": [
      "claude/commands/harness-meta.md (워크플로우 변경 zero, INTENT out_of_scope #1)",
      "projects/meta/ARCHITECTURE.md § 6.1 (bundling era 정의 본문 변경 zero, INTENT out_of_scope #3)",
      "projects/meta/ARCHITECTURE.md § 6.2 (동결 정책 본문 변경 zero, INTENT out_of_scope #2)",
      "tests/ (smoke 추가/변경 zero, INTENT out_of_scope #4)",
      "CHANGELOG.md (실 워크플로우 변경 zero → CHANGELOG entry 작성 본 milestone 시 보류 정합 — REPORT 안 narrative 거명)"
    ],
    "current_state": "v3.0~v3.16 17 milestone 완료. ROADMAP 본문에 각 entry summary 안 'X phase / X commit / lightweight 모드 명시' 분산 기록. 1차 source 통합 분포표 없음.",
    "target_state": "v3.17 RESEARCH.md 안 17 milestone 분포표 1차 source (markdown table + JSON 둘 다). 1-phase milestone 12/17 = 70.6% / lightweight 모드 6/17 = 35.3% 정량 확정."
  },
  "distribution_table_v3_x": {
    "schema": "version | phase_count | commit_count | mode | trigger | self_reference_avoidance | sub_milestones_meaningful",
    "rows": [
      {"version": "v3.0",  "id": "milestones-restructure",              "phase_count": 8, "commit_count": 8, "mode": "standard",     "trigger": "A_user",        "self_ref_avoid": false, "sub_milestones_meaningful": "yes (v2.2_* 4건 흡수 + 신 구조 첫 적용 도그푸드)"},
      {"version": "v3.1",  "id": "workflow-policy-fine-tuning",         "phase_count": 3, "commit_count": 3, "mode": "standard",     "trigger": "B_regression",  "self_ref_avoid": false, "sub_milestones_meaningful": "yes (v3.0 PROPOSE 3건 + lessons L10 통합 — bundling 첫 후속 사례)"},
      {"version": "v3.2",  "id": "workflow-narrative-strengthening",    "phase_count": 3, "commit_count": 3, "mode": "standard",     "trigger": "C_improvement", "self_ref_avoid": false, "sub_milestones_meaningful": "yes (v3.1 lessons L2/L3/L5/L6/L9 narrative 공백 4건 통합)"},
      {"version": "v3.3",  "id": "ci-inactive-smoke-cleanup",           "phase_count": 1, "commit_count": 1, "mode": "standard",     "trigger": "B_regression",  "self_ref_avoid": false, "sub_milestones_meaningful": "no (단일 commit, sub_milestones listing 무의미)"},
      {"version": "v3.4",  "id": "open-stage-milestones-md-protocol",   "phase_count": 1, "commit_count": 1, "mode": "standard",     "trigger": "C_improvement", "self_ref_avoid": false, "sub_milestones_meaningful": "no"},
      {"version": "v3.5",  "id": "open-stage-discipline-strengthening", "phase_count": 2, "commit_count": 2, "mode": "standard",     "trigger": "B_regression",  "self_ref_avoid": false, "sub_milestones_meaningful": "yes (v3.4 lessons L1 + L3 bundle)"},
      {"version": "v3.6",  "id": "overengineering-audit",               "phase_count": 3, "commit_count": 3, "mode": "lightweight",  "trigger": "A_user",        "self_ref_avoid": true,  "sub_milestones_meaningful": "yes (3개 권고 #1/#4/#6/#7 분할)"},
      {"version": "v3.7",  "id": "smoke-posttooluse-9stage-tests",      "phase_count": 1, "commit_count": 1, "mode": "standard",     "trigger": "B_regression",  "self_ref_avoid": false, "sub_milestones_meaningful": "no"},
      {"version": "v3.8",  "id": "inactive-smoke-cd-path-fix",          "phase_count": 1, "commit_count": 1, "mode": "standard",     "trigger": "C_improvement", "self_ref_avoid": false, "sub_milestones_meaningful": "no"},
      {"version": "v3.9",  "id": "inactive-smoke-git-mv-checklist",     "phase_count": 1, "commit_count": 1, "mode": "standard",     "trigger": "C_improvement", "self_ref_avoid": false, "sub_milestones_meaningful": "no"},
      {"version": "v3.10", "id": "stage-byproduct-clarification",       "phase_count": 1, "commit_count": 1, "mode": "lightweight",  "trigger": "A_user",        "self_ref_avoid": true,  "sub_milestones_meaningful": "no"},
      {"version": "v3.11", "id": "legacy-narrative-cleanup",            "phase_count": 1, "commit_count": 1, "mode": "lightweight",  "trigger": "C_improvement", "self_ref_avoid": true,  "sub_milestones_meaningful": "no"},
      {"version": "v3.12", "id": "deprecated-skill-narrative-cleanup",  "phase_count": 1, "commit_count": 1, "mode": "lightweight",  "trigger": "C_improvement", "self_ref_avoid": true,  "sub_milestones_meaningful": "no"},
      {"version": "v3.13", "id": "pending-milestone-renumber-policy",   "phase_count": 1, "commit_count": 1, "mode": "lightweight",  "trigger": "A_user",        "self_ref_avoid": true,  "sub_milestones_meaningful": "no"},
      {"version": "v3.14", "id": "deferred-revaluation-cycle-2",        "phase_count": 1, "commit_count": 1, "mode": "lightweight",  "trigger": "A_user",        "self_ref_avoid": true,  "sub_milestones_meaningful": "no"},
      {"version": "v3.15", "id": "changelog-v3-backfill",               "phase_count": 1, "commit_count": 1, "mode": "lightweight",  "trigger": "A_user",        "self_ref_avoid": true,  "sub_milestones_meaningful": "no"},
      {"version": "v3.16", "id": "changelog-unreleased-position-cleanup","phase_count": 1, "commit_count": 1, "mode": "lightweight",  "trigger": "C_improvement", "self_ref_avoid": true,  "sub_milestones_meaningful": "no"}
    ],
    "aggregates": {
      "total_milestones": 17,
      "by_phase_count": {
        "1": 12,
        "2": 1,
        "3": 3,
        "8": 1
      },
      "one_phase_ratio": "12/17 = 70.6%",
      "multi_phase_ratio": "5/17 = 29.4%",
      "by_mode": {
        "standard": 11,
        "lightweight": 6
      },
      "lightweight_ratio": "6/17 = 35.3%",
      "lightweight_consecutive_recent": "v3.10~v3.16 안 6건 (v3.10/v3.11/v3.12/v3.13/v3.14/v3.15/v3.16) — 단 v3.10 후 v3.11/v3.12/v3.13/v3.14/v3.15/v3.16 = 누적 6건 consecutive",
      "sub_milestones_meaningful": {
        "yes": 5,
        "no": 12
      },
      "sub_milestones_meaningful_yes_ratio": "5/17 = 29.4% (v3.0/v3.1/v3.2/v3.5/v3.6 — 모두 v3.6 이전 또는 v3.6 자체)",
      "by_trigger": {
        "A_user": 6,
        "B_regression": 4,
        "C_improvement": 7
      },
      "trend_post_v3.6": {
        "milestones": "v3.7~v3.16 = 10건",
        "1_phase_count": "10/10 = 100%",
        "lightweight_count": "6/10 = 60% (v3.10~v3.16, v3.10 부터 누적 consecutive)",
        "interpretation": "v3.6_overengineering-audit (§ 6.2 동결 정책 도입) 이후 100% 1-phase. v3.10 부터 lightweight 모드 consecutive 누적."
      }
    }
  },
  "phase_distribution_markdown": {
    "header": "v3.x 17 milestone phase count 분포 (1차 source)",
    "table_md": "| version | phase | commit | mode | trigger | self-ref avoid | sub-milestones 의미 |\n|---------|-------|--------|------|---------|----------------|---------------------|\n| v3.0    | 8     | 8      | std        | A_user        | no  | yes |\n| v3.1    | 3     | 3      | std        | B_regression  | no  | yes |\n| v3.2    | 3     | 3      | std        | C_improvement | no  | yes |\n| v3.3    | 1     | 1      | std        | B_regression  | no  | no  |\n| v3.4    | 1     | 1      | std        | C_improvement | no  | no  |\n| v3.5    | 2     | 2      | std        | B_regression  | no  | yes |\n| v3.6    | 3     | 3      | lightweight | A_user       | yes | yes |\n| v3.7    | 1     | 1      | std        | B_regression  | no  | no  |\n| v3.8    | 1     | 1      | std        | C_improvement | no  | no  |\n| v3.9    | 1     | 1      | std        | C_improvement | no  | no  |\n| v3.10   | 1     | 1      | lightweight | A_user       | yes | no  |\n| v3.11   | 1     | 1      | lightweight | C_improvement | yes | no  |\n| v3.12   | 1     | 1      | lightweight | C_improvement | yes | no  |\n| v3.13   | 1     | 1      | lightweight | A_user       | yes | no  |\n| v3.14   | 1     | 1      | lightweight | A_user       | yes | no  |\n| v3.15   | 1     | 1      | lightweight | A_user       | yes | no  |\n| v3.16   | 1     | 1      | lightweight | C_improvement | yes | no  |"
  },
  "options": [
    {
      "option_id": "A",
      "label": "현 상태 자연 적응 narrative 추가 (no workflow change)",
      "approach": "진단만 박고 워크플로우 본문 변경 zero. 1-phase 다수는 lightweight 모드 자연 적응이라는 해석만 ARCHITECTURE.md / CLAUDE.md narrative 1줄 cross-ref. PROPOSE.next_candidates 안 후속 milestone 1건 거명 (실 적용 후속, 사용자 명시 발의 시).",
      "pros": [
        "v3.6 § 6.2 동결 정책 정합 — workflow self-improvement 사이클 회피",
        "최소 변경 (진단 only, decision-only)",
        "사용자 의문 답변 + 정량 데이터 보존 + 후속 발의 자유도 보장"
      ],
      "cons": [
        "1-phase 70.6% 자체가 'bundling era' 명칭과 모순 — 해석만으로는 명칭 정합 미해결",
        "후속 milestone 발의 trigger 부재 시 자연 적응 그대로 누적"
      ]
    },
    {
      "option_id": "B",
      "label": "milestone 단위 합리화 — v4.0 breaking major bump",
      "approach": "1-phase milestone 을 상위 'rolling milestone' 의 phase 로 편입 + ARCHITECTURE § 6.1 era 정책 재정의 + smoke 분기 추가. major bump. v3.0 선례 정합 (v2 → v3 재구성).",
      "pros": [
        "bundling 본질 복권 — 1 version 안 sub-milestone phase ≥ 2 강제",
        "milestones.md sub_milestones listing 의미 회복"
      ],
      "cons": [
        "자기참조 사이클 재진입 — § 6.2 동결 정책 정면 위배",
        "era 또 변경 → cascade narrative 갱신 비용 (CLAUDE.md / ARCHITECTURE / harness-meta.md / tests/CLAUDE.md / smoke 6+ 위치)",
        "v3.6 lessons L3 narrative cap 정합 미충족"
      ]
    },
    {
      "option_id": "C",
      "label": "§ 6.2 동결 완화 — 후속 candidate ROADMAP 등재 자연화",
      "approach": "§ 6.2 'default 동결 권고' 를 'workflow self-improvement 한정 동결' 으로 한정. 비-workflow 후속 candidate 는 ROADMAP 자연 등재 → bundling source 회복. minor bump.",
      "pros": [
        "bundling source 메마름 해소",
        "v3.6 § 6.2 도입 의도 유지 (workflow self-improvement 만 동결)",
        "후속 milestone phase 다중 가능성 회복"
      ],
      "cons": [
        "non-workflow vs workflow 경계 모호 — 새 분류 비용",
        "release train 재발 risk (v3.6 진단 발견 9/24 사례 재발)",
        "현 v3.11~v3.16 6건 lightweight + 1-phase 가 모두 narrative cleanup 본질 (workflow 변경 zero) — § 6.2 동결 영향 아닌 작업 본질 영향 가능성"
      ]
    },
    {
      "option_id": "D",
      "label": "진단 결과 해석 — 'bundling era' 명칭 narrative 1줄 정정 (1-phase 자연 적응)",
      "approach": "ARCHITECTURE § 6.1 'bundling era' 정의에 '1-phase milestone 도 본 era 정합 — sub-milestones[] listing 은 1 entry 라도 narrative 1차 source 책임 충족' narrative 1줄 추가. milestones.md 의 sub_milestones 1 entry 도 유효 정전화.",
      "pros": [
        "최소 변경 (narrative 1줄)",
        "v3.6 § 6.2 동결 정합",
        "현 상태 그대로 정전화"
      ],
      "cons": [
        "bundling 본질 (다중 통합) 사실상 폐기 — 명칭 정정만",
        "v3.0 도입 motivation 일부 무력화"
      ]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "severity": "medium",
      "description": "본 milestone 자체가 workflow self-improvement 본질 — § 6.2 동결 정책 정면 영역. lightweight 모드 + decision-only + 5 관점 subagent 생략으로 자기참조 회피 표지하나, 진단 만 으로도 후속 milestone trigger source 가 됨."
    },
    {
      "id": "R2",
      "severity": "low",
      "description": "v3.x 17 milestone 분포표 OPEN 시점 사용자 보고 11/17 = 64.7% vs RESEARCH 정확 측정 12/17 = 70.6% drift +1 milestone. INTENT.md success_criteria + ROADMAP entry summary cascade 정정 필요."
    },
    {
      "id": "R3",
      "severity": "low",
      "description": "PROPOSE.next_candidates ROADMAP 등재 0건 (§ 6.2 default 동결 정합) 시 본 milestone 진단 결과 후속 행동 자연 누락 risk. 사용자 명시 발의 (A_user) 시 만 후속 milestone 진행 → 영구 보류 가능성."
    },
    {
      "id": "R4",
      "severity": "low",
      "description": "trigger 분류 분포 (A_user 6 / B_regression 4 / C_improvement 7) 가 1-phase 패턴과 강한 상관관계 보이지 않음 → 원인 추정 (a) § 6.2 동결 부작용 와 (c) lightweight 모드 누적 동치화 사이 결정적 구분 어려움. 진단 결과는 '3축 모두 부분 기여' narrative 로 정착 가능성."
    }
  ]
}
```

## narrative

### 핵심 관찰 1: v3.6 이후 100% 1-phase

v3.7~v3.16 (= 10 milestone) 안 1-phase count = **10/10 = 100%**. v3.6_overengineering-audit (§ 6.2 동결 정책 도입, 2026-05-11) 이후 단일 phase milestone 만 등장. 정량 강한 시점-효과.

### 핵심 관찰 2: lightweight 모드 누적 consecutive

v3.10~v3.16 안 lightweight 모드 = **7건 consecutive** (v3.10 stage-byproduct-clarification 부터 v3.16 changelog-unreleased-position-cleanup 까지 단 1건 break 도 없음). v3.7~v3.9 (post v3.6) 가 standard 모드였으나 v3.10 부터 lightweight 모드가 consecutive 정착. lightweight = 1-phase 암묵 동치 형성 patterns evidence.

### 핵심 관찰 3: sub-milestones listing 의미 충족 = 5/17

v3.0 / v3.1 / v3.2 / v3.5 / v3.6 만 sub-milestones listing 이 의미 있음 (= ≥2 phase + 각 phase 가 독립 sub-주제). 나머지 12 milestone 은 sub-milestones[] 가 1 entry placeholder 만 → milestones.md per version 도입 본래 의도 (sub-milestone listing 1차 source) 실 작동 비율 **5/17 = 29.4%**.

### 핵심 관찰 4: phase 분포 표 사용자 첫 보고 drift

OPEN 시점 사용자 첫 보고 = `1-phase 11건 (65%)` 였으나 RESEARCH 정확 측정 = **12건 (70.6%)** — drift +1 milestone (v3.4 추가 발견). 11/17 = 64.7% vs 12/17 = 70.6%. INTENT.success_criteria + ROADMAP entry summary cascade 정정 후 RESEARCH 가 1차 source.

### 원인 추정 3축 evidence

| 축 | 가설 | direct evidence | counter-evidence |
|----|------|------------------|------------------|
| (a) § 6.2 동결 부작용 | v3.6 § 6.2 도입 후 후속 candidate ROADMAP 등재 차단 → bundling source 메마름 → 1-phase milestone 만 진행 | v3.7~v3.16 100% 1-phase / v3.6 직전 v3.0~v3.5 = mixed (1~8 phase) | v3.7~v3.9 standard 모드 1-phase = § 6.2 동결 직접 영향 아님 (lightweight 미적용) |
| (b) milestone 입자 자체가 작음 | 사용자 발의 + 자연 발의 모두 1 commit 가치 작업 단위로 들어옴 (narrative cleanup / smoke fix / ROADMAP entry) | v3.7~v3.16 10건 모두 narrative cleanup 또는 smoke fix (1 file ~ ≤5 file 영향) | v3.6 자체 3-phase (lightweight 인데도 3 분할) — 작업 본질이 작아서가 아니라 분할 가능성 있음 |
| (c) lightweight 모드 누적 동치화 | v3.10~v3.16 7건 consecutive lightweight → '간소화 = 1-phase' 암묵 동치 | v3.10 이후 7건 모두 1-phase + lightweight | v3.7~v3.9 1-phase 인데 standard 모드 — lightweight 가 1-phase 필요조건 아님 |

3축 모두 부분 기여, 단일 결정적 원인 부재. R4 risk 정합.

### 해결책 후보 (Option A~D)

상기 `options` 4개 안 — RESEARCH 단계는 raw 분석만, decision 은 DESIGN 단계 책임.
