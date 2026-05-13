# DESIGN — v3.18_option-a-natural-adaptation-narrative

```json
{
  "id": "v3.18_option-a-natural-adaptation-narrative",
  "mode": "lightweight",
  "self_reference_policy": "avoid (workflow self-improvement 본질, § 6.2 자기참조 회피 표지)",
  "subagent_review_policy": "skipped (lightweight 모드, v3.6/v3.10/v3.13/v3.14/v3.17 선례 정합 — 5번째 적용)",
  "decisions": [
    {
      "id": "D1",
      "decision": "Option 1 (단일 source 우선) 채택 — ARCHITECTURE § 6.1 본문만 narrative 1 paragraph 추가, CLAUDE.md root 및 모듈 CLAUDE.md 본문 변경 zero (기존 § 6.1 cross-ref 유지)",
      "rationale": "단일 source 정합 (narrative 본문 1곳) + v1.4_cross-ref-propagation 패턴 정합 (정의 host 1곳 + cross-ref N곳) + 최소 변경 (1 file). Option 2 (host 2곳) 단일 source 위배 risk, Option 3 (모듈 cross-ref 추가) projects/meta/CLAUDE.md line 14 이미 § 6.1 cross-ref 보유 중복.",
      "alternatives_rejected": [
        "Option 2 (ARCHITECTURE § 6.1 + CLAUDE.md root 본문 둘 다) — 단일 source 위배 + drift risk 증가",
        "Option 3 (ARCHITECTURE § 6.1 + projects/meta/CLAUDE.md cross-ref 추가) — 모듈 CLAUDE.md 이미 § 6.1 cross-ref 보유, 추가 cross-ref 중복"
      ]
    },
    {
      "id": "D2",
      "decision": "narrative 추가 위치 = ARCHITECTURE § 6.1 'bundling 정책' 섹션 line 166 '**운용**: ...' paragraph 직후 (= line 167 자기참조 부합 paragraph 직전) 새 paragraph 1건 삽입",
      "rationale": "운용 narrative 직후 = 자연스러운 cascade (bundling 운용 → 1-phase 정합 narrative → 자기참조 부합 narrative). 후보 A (line 162 'bundling 정책' 첫 줄 직후) 는 bundling 정의보다 먼저 1-phase 등장 = 정의 순서 부적합. 후보 C (자기참조 부합 후 + breaking change 전) 도 가능하나, 운용 직후가 bundling 의미와 가장 직접 연관.",
      "alternatives_rejected": [
        "후보 A (line 162 'bundling 정책' 첫 줄 직후) — bundling 정의 순서 부적합",
        "후보 C (자기참조 부합 paragraph 후) — bundling 의미 cascade 약화"
      ]
    },
    {
      "id": "D3",
      "decision": "narrative 정확 문구 = '**1-phase milestone 정합 (v3.17_phase-distribution-audit 진단)**: 같은 의미 단위 후속 candidates 가 1건 (= sub_milestones[] 1 entry) 일 때도 본 era 정합 — milestones.md 가 narrative 1차 source 책임 충족하면 phase 다중 통합 (≥2 건 자연 활용) 와 1-phase 정전화 (1 건) 두 경로 모두 정상. v3.7~v3.16 = 100% 1-phase, v3.x 전체 = 12/17 = 70.6% (v3.17 RESEARCH 분포표 1차 source).'",
      "rationale": "RESEARCH 문구 후보 1 채택 (정량 수치 + 1차 source cross-ref 포함). 문구 2 (짧은 변형) 는 진단 milestone cross-ref 약화. 정확 수치 (70.6%) + v3.17 cross-ref 명시 → narrative 1차 source 명료.",
      "alternatives_rejected": [
        "문구 2 (짧은 변형) — 진단 milestone cross-ref 약화 + 정량 수치 명료성 약화",
        "수치 부재 narrative — 본 정전화 의도 (정량 데이터 자연 적응) 약화"
      ]
    },
    {
      "id": "D4",
      "decision": "phase 분할 = 단일 phase 1 feat commit (+ Stage G chore commit) — v3.17 패턴 정합 도그푸드",
      "rationale": "본 milestone 산출물 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE + milestones.md + execute/phase-1.md = 9 file) + ARCHITECTURE § 6.1 narrative 1 paragraph 추가 (= 1 file 갱신) 한 묶음. 분할 비효율. **자기참조 모순 도그푸드 표지** — '1-phase 정합 narrative 정착 milestone' 자체가 1-phase = v3.17 lesson L6 패턴 정확 정합.",
      "alternatives_rejected": [
        "2-phase 분할 (narrative 추가 phase-1 + 산출물 작성 phase-2) — 단일 작업 묶음 분할 비효율"
      ]
    },
    {
      "id": "D5",
      "decision": "INTENT~APPROVE commit timing = v3.17 패턴 정합 (phase-1 feat commit + Stage G chore commit 2-commit)",
      "rationale": "v3.15/v3.16/v3.17 누적 3건 동일 패턴 + v3.17 lesson L4 ((b)/(c) 실 동치 운용) 정합.",
      "alternatives_rejected": [
        "단일 commit 패턴 (모든 산출물 1 commit) — commit hash placeholder 부재 risk"
      ]
    },
    {
      "id": "D6",
      "decision": "phase-1 title 확정 = 'v3.18 narrative 1줄 추가 (ARCHITECTURE § 6.1 1-phase 정합 paragraph) + 진단 산출물 통합 작성 (INTENT/RESEARCH/DESIGN/APPROVE + milestones.md + execute/phase-1.md) + ROADMAP entry'",
      "rationale": "본 milestone phase-1 실 작업 범위 1:1. milestones.md sub_milestones[0].title placeholder 교체 source. Stage D 완료 직전 의무 step (v3.5 phase-2 도입) 정합.",
      "alternatives_rejected": [
        "더 짧은 title — 작업 범위 1:1 매핑 약화"
      ]
    }
  ],
  "approach": "단일 phase 1+1 commit lightweight 모드. ARCHITECTURE § 6.1 'bundling 정책' 섹션 line 166 paragraph 직후 새 paragraph 1건 추가 (D2 위치 + D3 문구). 단일 source 정합 (D1). 본 milestone 자체가 1-phase 도그푸드 = v3.17 lesson L6 패턴 정합.",
  "phases": [
    {
      "n": 1,
      "title": "v3.18 narrative 1줄 추가 (ARCHITECTURE § 6.1 1-phase 정합 paragraph) + 진단 산출물 통합 작성 (INTENT/RESEARCH/DESIGN/APPROVE + milestones.md + execute/phase-1.md) + ROADMAP entry",
      "scope": "ARCHITECTURE.md § 6.1 narrative 1 paragraph 추가 + 본 milestone 디렉토리 9 file 작성 + ROADMAP entry 등재 (status: in_progress). 워크플로우 절차 본문 변경 zero, smoke 추가 zero, CLAUDE.md root / 모듈 CLAUDE.md 본문 변경 zero.",
      "affected_files": [
        "projects/meta/ARCHITECTURE.md (§ 6.1 narrative 1 paragraph 추가)",
        "projects/meta/milestones/v3.18/INTENT.md (작성됨)",
        "projects/meta/milestones/v3.18/RESEARCH.md (작성됨)",
        "projects/meta/milestones/v3.18/DESIGN.md (본 파일)",
        "projects/meta/milestones/v3.18/APPROVE.md (Stage E 작성)",
        "projects/meta/milestones/v3.18/VERIFY.md (Stage G 작성)",
        "projects/meta/milestones/v3.18/REPORT.md (Stage H 작성)",
        "projects/meta/milestones/v3.18/PROPOSE.md (Stage I 작성)",
        "projects/meta/milestones/v3.18/milestones.md (작성됨, Stage D sub_milestones[0].title 교체)",
        "projects/meta/milestones/v3.18/execute/phase-1.md (Stage F 작성)",
        "projects/meta/ROADMAP.md (entry 등재 in_progress + Stage I completed 갱신)"
      ],
      "rationale": "ARCHITECTURE § 6.1 narrative 추가 + 산출물 통합 한 묶음. v3.17 lesson L6 도그푸드 패턴 정합.",
      "risks": [
        "R1/R2 위치/문구 — D2/D3 확정 흡수",
        "R3 단일 source 위배 — D1 채택 mitigate",
        "R4 자기참조 — lightweight 모드 + 사용자 명시 발의 + v3.17 PROPOSE 직접 후속 3중 표지"
      ]
    }
  ],
  "risk_mitigation": [
    {"risk_id": "R1", "mitigation": "D2 위치 결정 = line 166 운용 paragraph 직후 (자기참조 부합 paragraph 직전)"},
    {"risk_id": "R2", "mitigation": "D3 정확 문구 결정 = 진단 milestone cross-ref + 정량 수치 (70.6%) 포함"},
    {"risk_id": "R3", "mitigation": "D1 Option 1 채택 = ARCHITECTURE § 6.1 본문 1곳 narrative + CLAUDE.md root / 모듈 CLAUDE.md cross-ref 변경 zero"},
    {"risk_id": "R4", "mitigation": "lightweight 모드 표지 + 5 관점 subagent 생략 + 사용자 명시 발의 (A_user) + v3.17 PROPOSE 직접 후속 = 4중 자기참조 차단 표지. v3.6/v3.10/v3.13/v3.14/v3.17 선례 5건 정합."}
  ]
}
```

## narrative

### 자기참조 모순 도그푸드 표지 (v3.17 lesson L6 정합)

본 milestone 자체가 **1-phase 1+1 commit lightweight 모드** = '1-phase 정합 narrative 정착' 의 정확한 도그푸드. v3.17 lesson L6 ('workflow self-improvement 본질 milestone 의 lightweight + 회피 표지 + 도그푸드 3종 세트') 패턴 정합.

### Stage D 완료 직전 의무 step (v3.5 phase-2 도입)

D6 phase-1 title 확정 직후 → milestones.md sub_milestones[0].title placeholder 교체. 본 DESIGN 작성 직후 Edit.
