# RESEARCH — v3.18_option-a-natural-adaptation-narrative

```json
{
  "id": "v3.18_option-a-natural-adaptation-narrative",
  "external": [
    {
      "source": "v3.17_phase-distribution-audit",
      "topic": "Option A narrative 1줄 추가 candidate",
      "findings": "v3.17 PROPOSE.next_candidates Option A 정의 = 'ARCHITECTURE § 6.1 bundling era 정의 + CLAUDE.md narrative 1줄 cross-ref' approach. lesson L1 implication = 'ARCHITECTURE § 6.1 bundling era 정의에 1-phase milestone 도 본 era 정합 narrative 1줄 추가 candidate'. RESEARCH 분포표 1-phase 12/17 = 70.6% 1차 source.",
      "drift": "Option A approach 안 'ARCHITECTURE § 6.1 + CLAUDE.md cross-ref' 양쪽 host 명시 — 단일 source 정합 검토 필요."
    },
    {
      "source": "사용자 명시 발의 (A_user)",
      "topic": "'Option A 진행해줘' 직접 선택",
      "findings": "v3.17 PROPOSE next_candidates 4 options 중 Option A 발의 trigger 충족 (사용자 명시 발의).",
      "drift": "없음"
    }
  ],
  "codebase": {
    "affected_files": [
      "projects/meta/ARCHITECTURE.md § 6.1 (narrative 1줄 추가 host, 1차 source)",
      "projects/meta/milestones/v3.18/INTENT.md (작성됨)",
      "projects/meta/milestones/v3.18/RESEARCH.md (본 파일)",
      "projects/meta/milestones/v3.18/DESIGN.md (Stage D)",
      "projects/meta/milestones/v3.18/APPROVE.md (Stage E)",
      "projects/meta/milestones/v3.18/VERIFY.md (Stage G)",
      "projects/meta/milestones/v3.18/REPORT.md (Stage H)",
      "projects/meta/milestones/v3.18/PROPOSE.md (Stage I)",
      "projects/meta/milestones/v3.18/milestones.md",
      "projects/meta/milestones/v3.18/execute/phase-1.md",
      "projects/meta/ROADMAP.md (entry status 갱신)"
    ],
    "untouched_files_explicit": [
      "CLAUDE.md root (line 45 'v3.0+ 9-stage-bundled era' 요약 1줄 — ARCHITECTURE § 6.1 cross-ref 이미 명시, 단일 source 정합 위배 회피 위해 본문 변경 zero)",
      "projects/meta/CLAUDE.md (단일 source 정합)",
      "claude/commands/harness-meta.md (워크플로우 절차 본문 변경 zero, INTENT out_of_scope #1)",
      "projects/meta/ARCHITECTURE.md § 6.2 (동결 정책 본문 변경 zero, INTENT out_of_scope #2)",
      "tests/ (smoke 추가/변경 zero, INTENT out_of_scope #4)",
      "AGENTS.md / README.md / GUARDRAILS.md (영문 host, cross-ref 변경 zero — 단일 source 정합 의무 정합)"
    ],
    "current_state": "ARCHITECTURE § 6.1 'bundling 정책' 섹션 (line 162~166) 안 bundling 의미 grouping / 분리 단위 / 운용 narrative 만 정의. 1-phase milestone (sub_milestones[] 1 entry placeholder 상태) 정합 narrative 부재. v3.7~v3.16 100% 1-phase 진행 사실과 era 정의 사이 stale narrative drift.",
    "target_state": "ARCHITECTURE § 6.1 'bundling 정책' 섹션 안 1-phase milestone 정합 narrative 1 paragraph (1~3 line) 추가. 단일 source 정합 유지 (CLAUDE.md root / projects/meta/CLAUDE.md / harness-meta.md 본문 변경 zero, cross-ref만 의무 정합)."
  },
  "options": [
    {
      "option_id": "1",
      "label": "ARCHITECTURE § 6.1 본문만 narrative 추가 (단일 source 우선)",
      "approach": "§ 6.1 'bundling 정책' 섹션 (line 162~166) 안 또는 직후 1-phase 정합 narrative 1 paragraph 추가. CLAUDE.md root line 45 본문 변경 zero — 기존 'v3.0+ 9-stage-bundled era — 같은 의미 단위 후속 candidates 를 version 단위 1 milestone (sub-milestone phase 매핑, milestones.md per version) 으로 통합' 요약 + ARCHITECTURE § 6.1 cross-ref 유지.",
      "pros": [
        "단일 source 정합 (narrative 본문 1곳, ARCHITECTURE § 6.1 단일 source)",
        "최소 변경 (1 file)",
        "v1.4_cross-ref-propagation 정합 (정의 host 1곳 + cross-ref N곳)",
        "Stage C/D/E 의문 부재 (host 선택 명확)"
      ],
      "cons": [
        "CLAUDE.md root line 45 요약문 1줄 stale 가능성 — '같은 의미 단위 후속 candidates 를 version 단위 1 milestone 통합' 표현이 1-phase 정합 함의 명시 부재 (해석 모호 가능)"
      ]
    },
    {
      "option_id": "2",
      "label": "ARCHITECTURE § 6.1 + CLAUDE.md line 45 둘 다 narrative 추가",
      "approach": "§ 6.1 본문 + CLAUDE.md root line 45 요약문 둘 다 1-phase 정합 narrative 추가 (cross-ref 명시).",
      "pros": [
        "CLAUDE.md root cascade narrative 명료화",
        "Claude Code 세션 자동 로드 시점 1-phase 정합 명시 표지"
      ],
      "cons": [
        "narrative 본문 중복 — 단일 source 정합 위배 risk",
        "v1.4_cross-ref-propagation 패턴 위배 (정의 host 1곳 + cross-ref N곳 정합)",
        "drift risk 증가 (host 2곳 동기 유지 부담)"
      ]
    },
    {
      "option_id": "3",
      "label": "ARCHITECTURE § 6.1 본문 + 모듈 CLAUDE.md (projects/meta/CLAUDE.md) cross-ref 1줄",
      "approach": "§ 6.1 본문 narrative + projects/meta/CLAUDE.md 모듈 가이드 cross-ref 1줄 (예: 'milestones/ 항목 1-phase 정합 narrative § 6.1 참조')",
      "pros": [
        "Option 1 + 모듈 cross-ref 보조",
        "단일 source 정합 유지 (narrative 본문 1곳)"
      ],
      "cons": [
        "추가 작업 (2 file 변경) — 1줄 cross-ref 효과 불확실",
        "현재 projects/meta/CLAUDE.md 이미 § 6.1 cross-ref 명시 (line 14) — 추가 cross-ref 중복"
      ]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "severity": "low",
      "description": "ARCHITECTURE § 6.1 narrative 1줄 추가 위치 결정 (line 162 'bundling 정책' 첫 줄 직후 vs line 166 운용 paragraph 직후) — DESIGN 단계 결정."
    },
    {
      "id": "R2",
      "severity": "low",
      "description": "narrative 정확 문구 결정 — INTENT.success_criteria #2 안 placeholder 문구 (예: '1-phase milestone (sub_milestones[] 1 entry) 도 본 era 정합 — sub_milestones[] 가 1 entry 라도 milestones.md 가 narrative 1차 source 책임 충족') 또는 동치 의미. DESIGN 단계 확정."
    },
    {
      "id": "R3",
      "severity": "low",
      "description": "단일 source 정합 위배 risk — Option 2 채택 시 narrative 본문 host 2곳 = drift risk. Option 1 채택으로 mitigate."
    },
    {
      "id": "R4",
      "severity": "low",
      "description": "본 milestone 자체가 workflow self-improvement 본질 (§ 6.1 narrative 변경 = ARCHITECTURE 본문 변경) — § 6.2 동결 정책 영역. lightweight 모드 + 사용자 명시 발의 (A_user) + v3.17 PROPOSE 직접 후속 = 3중 trigger 정합 표지."
    }
  ]
}
```

## narrative

### Option 1 (단일 source 우선) 권장

3 options 중 Option 1 (§ 6.1 본문만 narrative 추가) 권장 — 단일 source 정합 + 최소 변경 + v1.4_cross-ref-propagation 패턴 정합. CLAUDE.md root line 45 요약문 변경 zero (단일 source 정합 위배 회피).

### narrative 정확 위치 후보

- **후보 A**: § 6.1 line 162 'bundling 정책 (9-stage-bundled era, v3.0+): version (= 1 milestone) 단위로 의미 단위 후속 candidates 를 묶음.' 직후
- **후보 B**: § 6.1 line 166 '**운용**: ...' 항목 직후 또는 paragraph 끝
- **후보 C**: § 6.1 bundling 정책 섹션 끝 + 자기참조 부합 (line 168) 사이 새 paragraph

DESIGN 단계에서 D1 (위치) + D2 (정확 문구) 결정.

### narrative 정확 문구 후보

- **문구 1**: `**1-phase milestone 정합 (v3.17_phase-distribution-audit 도입)**: 같은 의미 단위 후속 candidates 가 1건 (= sub_milestones[] 1 entry) 일 때도 본 era 정합 — milestones.md 가 narrative 1차 source 책임 충족하면 phase 다중 통합은 자연 활용 (≥2 건 시) 또는 1-phase 정전화 (1 건 시) 두 경로 모두 정상.`
- **문구 2**: 더 짧은 변형 — `**1-phase 정합**: sub_milestones[] 1 entry 도 본 era 정합 (v3.17 진단 결과 70.6%). 후속 candidates ≥2 건 자연 통합 / 1 건 1-phase 정전화 모두 정상.`

DESIGN 단계에서 정확 문구 + 위치 1:1 매핑 확정.
