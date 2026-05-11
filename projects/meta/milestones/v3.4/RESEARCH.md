# RESEARCH — v3.4 open-stage-milestones-md-protocol

```json
{
  "id": "v3.4_open-stage-milestones-md-protocol",
  "external": [
    {
      "source": "v3.3_ci-inactive-smoke-cleanup REPORT lessons_learned L1",
      "topic": "OPEN stage milestones.md 동시 생성 gap 발견",
      "findings": "v3.3 phase-1 첫 commit 시점에서 milestones.md inline 생성으로 회피했으나, OPEN 단계 직후 verify 또는 별 작업 시 smoke-bundle-trigger FAIL 가능성 발견. v3.4 후속 등재.",
      "drift": "none"
    },
    {
      "source": "v3.1_workflow-policy-fine-tuning phase-1/3 narrative (R1 CRITICAL mitigation)",
      "topic": "milestones.md 의무화 + smoke-bundle-trigger 도입 narrative 1차 source",
      "findings": "v3.1 phase-3 smoke-bundle-trigger 도입 시점에서 status: in_progress 또는 completed entry 의 milestones_path 검증 + 실 파일 존재 검증 자동 강제. status: pending 은 continue (정상 — OPEN 미완료).",
      "drift": "none — 자동 강제 메커니즘 일관"
    },
    {
      "source": "v3.2_workflow-narrative-strengthening phase-1 (Stage F 선결 조건 게이트 블록)",
      "topic": "milestones.md 선결 의무 narrative — Stage F EXECUTE 진입 전",
      "findings": "claude/commands/harness-meta.md Stage F 진입 직전 게이트 블록 추가 — milestones.md 즉시 작성 의무 + skeleton 최소 필드 (version + sub_milestones[]) 명시. 그러나 OPEN 단계 자체 절차 (mkdir + ROADMAP entry 갱신) 와 분리되어 시간 격차 존재.",
      "drift": "OPEN ↔ EXECUTE 사이 ROADMAP in_progress 전환 시점부터 milestones.md 미보유 상태 가능 (smoke FAIL 잠재)"
    },
    {
      "source": "ARCHITECTURE.md § 6.1 era 정책 표 9-stage-bundled 행",
      "topic": "9-stage-bundled era 표지 정의",
      "findings": "디렉토리 명 ^v\\d+\\.\\d+$ + milestones.md (sub-milestone listing per version) + 7 산출물 + execute/phase-{n}.md. 즉 era 표지 자체에 milestones.md 가 포함 — 표지가 누락된 상태는 era 미식별 = 4-tier 또는 skip 분기 (tests/_era_detect.py).",
      "drift": "narrative 1차 source 측면 일관"
    }
  ],
  "codebase": {
    "affected_files": [
      "claude/commands/harness-meta.md (Stage A OPEN 절차 step 1~6 → step 1~7 또는 step 5 인라인 확장)",
      "projects/meta/milestones/v3.4/execute/phase-1.md (신규 — 본 milestone 자체 단일 phase)"
    ],
    "untouched_files": [
      "ARCHITECTURE.md § 6.1 (era 정책 본문 변경 없음 — 표지 정의 이미 milestones.md 포함)",
      "tests/smoke-bundle-trigger.sh (검증 로직 변경 없음 — 본 milestone 은 절차 명문화 한정)",
      "tests/_era_detect.py (era 분류 로직 변경 없음 — milestones.md 보유 시 9-stage-bundled 표지 식별)",
      "tests/smoke-spec-verification.sh / smoke-scope-contract.sh (era 분기 로직 변경 없음)",
      "root CLAUDE.md L19 워크플로우 표 Stage A 행 (현재 '컨테이너 마운트 + ROADMAP entry in_progress' — 'milestones.md 동시 생성' 추가 또는 보수 유지 결정은 DESIGN 단계)",
      "projects/meta/CLAUDE.md 모듈 가이드 행 (milestones.md 거명 이미 존재 — 보수 유지 또는 OPEN 시점 의무 narrative 추가 결정은 DESIGN 단계)"
    ],
    "current_state": {
      "claude/commands/harness-meta.md Stage A OPEN 절차 (L67-84)": "6 step — (1) ROADMAP 읽기 (2) pending entry 검토 (3) AskUserQuestion (4) vX.Y 결정 (5) mkdir 컨테이너 (6) ROADMAP entry 추가. milestones.md 생성 단계 부재.",
      "claude/commands/harness-meta.md Stage F 선결 조건 게이트 블록 (L165-174)": "milestones/v{X.Y}/milestones.md 즉시 작성 의무 명시 + skeleton 최소 필드 (version + sub_milestones[]) + INTENT~APPROVE commit 시점 3 패턴. v3.1 L2 CRITICAL mitigation cross-ref.",
      "smoke-bundle-trigger.sh L92-95": "status == 'pending' 시 continue. status == 'in_progress' 또는 'completed' entry 의 milestones_path 필드 + 실 파일 존재 검증 의무.",
      "_era_detect.py L18-27": "9-stage-bundled era 표지 = 디렉토리 명 ^v\\d+\\.\\d+$ (밑줄 부재) + milestones.md 존재. 부재 시 다른 era 또는 skip 분류."
    },
    "target_state": {
      "claude/commands/harness-meta.md Stage A OPEN 절차": "7 step (또는 step 5 인라인 확장) — milestones.md 스켈레톤 생성 단계 추가. 위치는 ROADMAP entry 갱신 (현 step 6) 직전 또는 직후 (DESIGN 단계 결정). skeleton 최소 필드 명시 = version + sub_milestones[] (phase-1 status: in_progress).",
      "Stage F 선결 조건 게이트 블록": "보수 유지 또는 narrative 단순화 (OPEN 단계로 시점 이동했으므로 Stage F 에서는 '이미 OPEN 단계에서 생성됨, 확인만' narrative 로 가능). 결정은 DESIGN 단계.",
      "root CLAUDE.md / projects/meta/CLAUDE.md cascade": "보수 유지 또는 narrative 강화 (DESIGN 단계 결정)."
    }
  },
  "options": [
    {
      "option": "A. step 6 직후 신규 step 7 추가 (mkdir → ROADMAP entry → milestones.md)",
      "pros": [
        "기존 step 1~6 narrative 보존 (회귀 risk 최소)",
        "ROADMAP entry 의 milestones_path 와 실 파일 1:1 매핑 명확 (entry 의 milestones_path 가 가리키는 위치 = 직후 생성)",
        "Stage F 선결 조건 게이트 narrative 와 동일 skeleton (version + sub_milestones[] + phase-1 status: in_progress) 재활용 가능"
      ],
      "cons": [
        "step 카운트 6 → 7 증가 (narrative 분량 미세 증가)"
      ]
    },
    {
      "option": "B. step 5 (mkdir) 인라인 확장 — mkdir + milestones.md 동시 작성",
      "pros": [
        "step 카운트 6 유지 (narrative 분량 동일)",
        "물리적 파일 생성 (mkdir + Write) 을 단일 step 으로 그룹화 — '컨테이너 마운트' 의미 부합"
      ],
      "cons": [
        "step 5 책임 분량 증가 (단일 책임 원칙 약화)",
        "ROADMAP entry 갱신 (step 6) 보다 milestones.md 생성 시점이 앞당겨짐 — entry milestones_path 필드와 동시성 narrative 약화"
      ]
    },
    {
      "option": "C. step 6 (ROADMAP entry 추가) 인라인 확장 — entry 추가와 동시에 milestones.md 작성",
      "pros": [
        "step 카운트 6 유지",
        "ROADMAP entry 의 status: in_progress 전환과 milestones.md 생성이 단일 step 안에 결합 — smoke-bundle-trigger 의 status 기반 검증 분기와 narrative 부합"
      ],
      "cons": [
        "step 6 책임 분량 증가",
        "ROADMAP entry 갱신은 '메타 source 갱신', milestones.md 작성은 '컨테이너 산출물 생성' — 책임 다름에도 결합 (단일 책임 원칙 약화)"
      ]
    },
    {
      "option": "D. Stage F 선결 조건 게이트 블록 narrative 변경 없이 OPEN 단계 시점만 보강 (cross-ref 추가)",
      "pros": [
        "Stage F 게이트 narrative 보존 (DRY 위배 회피)",
        "재발 가능성 미세 — 절차 명문화 자체가 cross-ref 1줄"
      ],
      "cons": [
        "절차 강제력 약화 — Claude 가 cross-ref 만 보고 실 단계 누락 가능",
        "본 milestone 의 의도 (절차 step 명시 추가) 와 정면 충돌"
      ]
    }
  ],
  "risks_identified": [
    "R1: Stage F 선결 조건 게이트 블록과 narrative 중복 — DRY 위배 가능. mitigation = OPEN 단계 단순 step + Stage F 게이트 narrative '이미 OPEN 단계에서 생성됨, 확인만' 으로 책임 분리 (DESIGN 단계 결정).",
    "R2: skeleton 최소 필드 narrative cascade — claude/commands/harness-meta.md 1곳 vs ARCHITECTURE.md § 6.1 / Stage F 게이트 블록 등 N 곳 동기 유지 부담. mitigation = 단일 source 위치 (= Stage F 게이트 블록 또는 § 6.1) 거명 + OPEN 단계 step 은 reference only.",
    "R3: phase-1 sub_milestone title placeholder 정책 — OPEN 시점에서는 정확한 phase 분할 미확정. mitigation = '확정 전 placeholder 허용, Stage D DESIGN 단계에서 정확한 title 로 갱신' narrative 명시 (본 v3.4 milestones.md 자체가 이 패턴 차용 — '비고' 섹션 narrative).",
    "R4: 자기참조 부합 (도그푸드) 위배 가능 — v3.4 OPEN 단계 자체가 본 절차를 수행하지 않으면 자기참조 위배. mitigation = 본 OPEN 단계 commit 전 milestones.md 작성 완료 (이미 충족, 본 INTENT/RESEARCH 작성 시점에서 검증).",
    "R5: 회귀 risk — 절차 step 추가만으로 smoke 자동 동작 변경 없음. mitigation = smoke-bundle-trigger / smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift 5 active hook 모두 PASS 확인. pre-commit 6 hook 모두 PASS 의무.",
    "R6: 단일 source 정합 — root CLAUDE.md L19 워크플로우 표 Stage A 행 narrative ('컨테이너 마운트 + ROADMAP entry in_progress') 갱신 여부 결정 필요. mitigation = '컨테이너 마운트' 의미에 milestones.md 동시 생성 함의 narrative 추가 또는 표 행 보수 유지 (DESIGN 단계 결정)."
  ]
}
```

## narrative

본 RESEARCH 의 핵심 발견 = 현행 Stage A OPEN 절차 (6 step) 와 Stage F 선결 조건 게이트 블록 (v3.2 phase-1 도입) 사이 시간 격차. 두 절차는 narrative 1차 source (claude/commands/harness-meta.md) 안에 존재하나 동일 산출물 (milestones.md) 의 생성 시점만 다름. smoke-bundle-trigger 의 status 기반 검증 분기 (pending → continue / in_progress|completed → 검증 의무) 와 시간 격차가 결합되어, OPEN 직후 in_progress 전환 + milestones.md 미보유 의 가능성 발생.

옵션 A (step 6 직후 신규 step 7 추가) 가 narrative 보존 + ROADMAP entry milestones_path 와 실 파일 1:1 매핑 명확화 + Stage F 게이트 narrative 재활용 측면에서 권장. 옵션 B/C 는 책임 분량 증가 + 단일 책임 약화 trade-off, 옵션 D 는 본 milestone 의도와 정면 충돌. DESIGN 단계에서 옵션 A vs B/C 최종 결정.

자기참조 부합 (R4) = 본 OPEN 단계 commit 전 milestones.md 작성 완료 (이미 충족). 본 RESEARCH 작성 시점 (Stage C, 컨테이너 mkdir 직후 + ROADMAP in_progress 직후 + milestones.md 생성 직후) 에서 자기참조 부합 검증 완료 = 도그푸드 패턴 정상 작동.
