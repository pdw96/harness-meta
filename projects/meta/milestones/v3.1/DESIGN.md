# DESIGN — v3.1_workflow-policy-fine-tuning

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "phase-2 milestones.md historical 적용 결정 = 옵션 (a) forward-only 강제",
      "rationale": "v3.0_milestones-restructure ARCHITECTURE.md § 6.1 forward-only 정책 직접 일관 — historical 디렉토리 (v1.x~v2.1) unchanged. v2.x 9-stage flat 구조 (sub-milestone 부재, 각 milestone 자체 디렉토리) → milestones.md 의 sub_milestones[] phase 매핑 본질 부적합. v3.0+ 9-stage-bundled era 의무 sign (ARCHITECTURE.md § 6.1 표) 과 동치. 옵션 (a) ≈ (c) 로 본질 동치, narrative 명료화 위해 (a) 채택. INTENT.out_of_scope OS1 (옵션 (b) 시 실제 retroactive 작업) 자동 회피 — (a) 채택으로 (b) 비용 발생 부재.",
      "alternatives_rejected": [
        "(b) v2.x retroactive — historical 변경, forward-only 정책 위반, git mv 위험, 본질 부적합 (flat 구조 + sub-milestone 부재). 추가로 OS1 (실제 retroactive 작업) 비용 발생 — (a) 채택으로 자동 회피",
        "(c) 신규만 — (a) 와 사실상 동치, 구분 모호"
      ]
    },
    {
      "id": "D2",
      "decision": "phase-3 bundling trigger smoke = 옵션 (B) tests/smoke-bundle-trigger.sh 신규",
      "rationale": "smoke 매트릭스 narrative '단일 책임 원칙' 일관 — bundling validation 은 'projects scope discipline' (root thin index) 와 다른 책임. smoke 명 의미 정합 ('bundle-trigger' 명료). smoke 카운트 27 → 28, helper 부재. extract_json_block 같은 코드 중복은 작은 비용 (<30줄, smoke 파일 단일화 정신) — refactor 분리 대신 직접 구현.",
      "alternatives_rejected": [
        "(A) smoke-projects-scope-discipline 확장 — 두 책임 혼재 (단일 책임 위배), smoke 명 의미 부정합",
        "신규 helper 모듈 (`tests/_roadmap_parse.py`) 도입 — bundling smoke 1건 만으로는 helper 분리 부담 과대, 향후 smoke 추가 시 검토"
      ]
    },
    {
      "id": "D3",
      "decision": "phase-3 신규 smoke 의 pre-commit 등록 = 옵션 등록 (12 → 13 hook)",
      "rationale": "v3.0 lessons L10 actionable 정신 (자동 차단 우선) — narrative-only 정책의 자동 강제 누적 (5요소 매트릭스 'Constraint' 정전). ROADMAP.md commit 시 자동 차단으로 사용자 명시 게이트 보조. pre-commit 시간 증가 ~0.6s (smoke-projects-scope-discipline 0.65s 와 동등 추정) — 무시 가능.",
      "alternatives_rejected": [
        "미등록 (manual run leverage) — narrative-only 와 동치, 자동 강제 부재로 정책 효과 제한"
      ]
    },
    {
      "id": "D4",
      "decision": "scope = 3 sub-milestone (PROPOSE 1:1 매핑)",
      "rationale": "PROPOSE 3건 (markdownlint trap / milestones.md historical / bundle-trigger smoke) 1:1 매핑. markdownlint 자동 강제 추가 (4번째 sub-milestone) 옵션은 scope creep — markdownlint hook 자체가 이미 차단, narrative 만이 정신.",
      "alternatives_rejected": [
        "4 sub-milestone (markdownlint MD032/MD049 사전 차단 smoke 추가) — scope creep, markdownlint hook 중복, INTENT.out_of_scope 명시"
      ]
    },
    {
      "id": "D5",
      "decision": "phase 단위 = 3 phase (sub-milestone 1:1)",
      "rationale": "sub-milestone 1:1 phase 매핑 (v3.0 패턴 일관). phase-1 markdownlint narrative / phase-2 historical 결정 / phase-3 bundling smoke. 각 1 commit. R7 (phase-2 narrative-only 통합 가능) 거부 — 단일 책임 원칙 일관 + commit 분리 추적성 보존. phase-2 narrative-only 도 독립적 commit 가치 보유 (결정 context 추적 — historical era 적용 결정 narrative 가 향후 milestone 또는 era 도입 시 reference 가능). scope contract SC5 권고 흡수.",
      "alternatives_rejected": [
        "2 phase (phase-1+2 narrative 통합, phase-3 smoke) — 단일 책임 원칙 위배, commit 분리 추적성 손실. phase-2 결정 context 가 phase-1 narrative 와 섞이면 향후 reference 시 분리 어려움"
      ]
    },
    {
      "id": "D6",
      "decision": "phase 순서 = phase-1 (narrative) → phase-2 (결정) → phase-3 (smoke)",
      "rationale": "narrative-only (phase-1) → 결정 narrative (phase-2) → 자동 강제 (phase-3) 순. 가벼운 변경 → 무거운 변경 (smoke 신규 + pre-commit 등록) 누적. phase-3 smoke 가 ROADMAP.md 의 v3.1 entry validation 시 phase-1/2 commit 후 갱신된 ROADMAP 입력 검증 가능 (controlled).",
      "alternatives_rejected": [
        "phase-3 → phase-1 → phase-2 (smoke 선결, narrative 후) — 자기참조 검증 의미 없음 (smoke 가 ROADMAP 만 검증, narrative 부재 무관)"
      ]
    },
    {
      "id": "D7",
      "decision": "milestones/v3.1/milestones.md 작성 시점 = phase-1 시작 시 spec 섹션 + sub_milestones[] skeleton (status: in_progress) → phase 별 status 갱신",
      "rationale": "v3.0 패턴 일관 — milestones.md 가 sub-milestone 진행 상태 추적 source. phase 별 commit 시 status: pending → in_progress → completed 갱신. spec picture-frame 은 v3.0 spec 섹션 cross-ref (ARCHITECTURE.md § 6.1 + v3.0 milestones.md spec).",
      "alternatives_rejected": [
        "Stage F 시작 직후 1회 작성 (in_progress → completed 갱신 부재) — phase별 추적 손실"
      ]
    },
    {
      "id": "D8",
      "decision": "smoke-bundle-trigger.sh 검증 책임 = (1) 같은 version 값 v3.0+ entry 1건 강제 (= bundling 의미), (2) v3.0+ entry milestones_path 필드 보유 + 형식 검증, (3) historical entry 무시 (forward-only)",
      "rationale": "ARCHITECTURE.md § 6.1 'bundling 정책' 의 핵심: version 단위 1 milestone. 정량 검사 가능. milestones_path 검증은 v3.0 신 schema 일관 (milestones.md 위치 명시). historical entry 는 v3.0 정책 부담 부재 — id flat / version 필드 부재 시 PASS.",
      "alternatives_rejected": [
        "의미 단위 grouping AI 판정 (모듈/주제 추론) — INTENT.out_of_scope 명시 (보수적 검사만)",
        "milestones_path 검증 부재 — schema 정합 손실"
      ]
    },
    {
      "id": "D9",
      "decision": "smoke-bundle-trigger.sh entry 형식 = direct (`bash tests/smoke-bundle-trigger.sh`, --fix 미지원)",
      "rationale": "tests/CLAUDE.md § 'Pre-commit hook entry 정책' (v1.80+) 분기: --fix 미지원 = direct. 본 smoke 는 ROADMAP 콘텐츠 drift 검증 — 자동 정정 불가 (사용자 결정). 기존 smoke-projects-scope-discipline 와 entry 형식 일관.",
      "alternatives_rejected": [
        "wrapper 경유 (precommit-autofix-or-fail.sh) — --fix 미지원 시 부적절"
      ]
    },
    {
      "id": "D10",
      "decision": "phase-3 smoke 작성 시 표준 절차 적용 = batched python3 heredoc + cp949 reconfigure errors='replace' + controlled 비교 4-step",
      "rationale": "v2.1 lessons L1 (batched python3 spawn) + v3.0 phase-6 흡수 (cp949) + v3.0 phase-7 흡수 (controlled 비교). tests/CLAUDE.md § 흔한 함정 6번째 항목 + Step 3 boilerplate + § 회귀 검증 절차 의무. AST audit (smoke-python-entry-boilerplate § P2) 자동 강제.",
      "alternatives_rejected": [
        "표준 절차 부분 적용 — 기존 smoke 와 일관성 손실, AST audit fail 가능"
      ]
    },
    {
      "id": "D11",
      "decision": "phase-1 markdownlint trap narrative 위치 = tests/CLAUDE.md § '흔한 함정' 표 7번째 row 추가",
      "rationale": "v3.0 lessons L10 actionable 직접 인용. § '흔한 함정' 표는 6 row (현재) → 7 row. 'markdownlint MD032/MD049 자동 차단' 함정 명 + 증상 (underscore emphasis 오인 + list 빈 줄 부재) + 회피 (백틱 escape + 빈 줄 의무). 표 narrative 1차 source 정신 일관.",
      "alternatives_rejected": [
        "별 § 신규 (예: § 'markdownlint 작성 함정') — 표 통합 정신 위배, narrative 분산",
        "tests/CLAUDE.md 안 § '작성 규약' 추가 — 'Bash 호환성' 같은 코드 작성 규약과 markdown 작성 규약 혼재"
      ]
    },
    {
      "id": "D12",
      "decision": "phase-2 결정 narrative 위치 = ARCHITECTURE.md § 6.1 'forward-only era 영구화 trade-off' 단락 단일. v3.0 milestones.md unchanged (architecture 권고 P1 흡수, 사용자 결정 2026-05-10)",
      "rationale": "ARCHITECTURE.md § 6.1 정전 single source 정책 (5요소 매트릭스 'Trace' 정전 + 단일 source 정책 일관). 'forward-only' 단락 안에 historical era 적용 결정 (옵션 a 채택) narrative 추가 1단락. v3.0 산출 영구 보존 정신 — v3.0 milestones.md 본문 unchanged (architecture P1 권고 + 사용자 결정), 단방향 cross-ref 만 ARCHITECTURE.md § 6.1 안에서 v3.0 milestones.md 를 가리키는 형태로 (필요 시).",
      "alternatives_rejected": [
        "milestones.md spec 섹션 자체 변경 (v3.0 phase-5 spec 변경) — v3.0 산출 보존 정신 위배",
        "별 host 추가 (CLAUDE.md / projects/meta/CLAUDE.md) — narrative 분산",
        "v3.0 milestones.md 상단 cross-ref 1줄 추가 (D12 원안) — architecture P1 권고 흡수, 사용자 결정 P1 수용"
      ]
    },
    {
      "id": "D13",
      "decision": "본 milestone 자체 markdownlint MD032/MD049 회피 self-check = 모든 phase commit 전 markdownlint 사전 검증 + smoke-cross-ref --fix 자동 (spec-drift S3 + 회귀 risk R7/R4 흡수)",
      "rationale": "본 milestone INTENT/RESEARCH/DESIGN/APPROVE.md 안 `v3.1`/`v3.0` 등 underscore 부재 (`v{X.Y}_{slug}` 패턴은 phase 별 id 인용 시만 발생, 백틱 escape). 강조 직후 list 패턴은 v3.0 INTENT 패턴 학습 후 본 milestone 작성 시 회피. phase 별 commit 전 사전 self-check 의무 — phase-1/2/3 모두 (spec-drift S3 흡수). 추가로 phase-1 commit 전 `bash tests/smoke-cross-ref.sh --fix` 자동 실행 (회귀 risk R4 흡수) — markdown link 자동 정정.",
      "alternatives_rejected": [
        "사전 self-check 부재 — markdownlint hook 차단 시 phase 재작업 필요",
        "phase-1 만 self-check (다른 phase 부재) — phase-2 ARCHITECTURE.md narrative 추가 시 새 위반 trigger 위험"
      ]
    },
    {
      "id": "D14",
      "decision": "자기참조 부합 (도그푸드) 명시 — milestones/v3.1/ 자체가 v3.0+ 9-stage-bundled era 의무 부합 (sub-id 부재 디렉토리 + milestones.md + INTENT~PROPOSE 산출 7종 + execute/phase-{n}.md). milestones.md sub_milestones.dependencies 안 phase 순서 명시 (scope contract SC2 + SC1 흡수)",
      "rationale": "v3.0 D7 자기참조 부합 패턴 일관 — 새 era 도입 후 첫 후속 milestone 도 도그푸드. self_reference_compliance: true. milestones.md sub_milestones[] dependencies 표현: phase-1=[], phase-2=[1], phase-3=[2] (D6 phase 순서 1→2→3 직접 매핑). scope contract SC1 권고 (dependency 표현 상세화) + SC2 권고 (자기참조 implicit → explicit) 흡수.",
      "alternatives_rejected": [
        "자기참조 회피 표지 (v2.0 선례) — 본 milestone 은 era 신규 도입 부재 (v3.0 era 후속), 회피 trigger 부재"
      ]
    },
    {
      "id": "D15",
      "decision": "phase 별 commit 직후 tests/CLAUDE.md 동기화 책임 분리 — phase-1 (§ '흔한 함정' 7번째 row) / phase-3 (§ smoke 매트릭스 카운트 27 → 28 + § Pre-commit 통합 5 → 6 active hook). 회귀 risk R2 흡수",
      "rationale": "tests/CLAUDE.md 변경이 phase-1 (narrative 추가) + phase-3 (카운트 갱신) 분리 책임. 임시 불일치 (phase-1 commit 후 phase-3 commit 전 카운트 27 보존) 는 의도된 (commit 분리 추적성). smoke-claude-md-drift 의 카운트 검증은 phase-3 commit 후 PASS. phase-2 안 tests/CLAUDE.md 변경 부재.",
      "alternatives_rejected": [
        "통합 (모든 변경 phase-1 또는 phase-3 단일) — 책임 분리 손실, commit 추적성 손실"
      ]
    },
    {
      "id": "D16",
      "decision": "phase-3 신규 smoke 가 detect_era (tests/_era_detect.py) 미호출 — ROADMAP entry schema 직접 검사 (architecture P3 흡수)",
      "rationale": "smoke-bundle-trigger.sh 의 책임 = ROADMAP `milestones[]` entry schema (`version` 필드 + `id` 필드 분리) 직접 검사. era 분류 (`tests/_era_detect.py`) 는 milestone 디렉토리 분류 책임 — 별 책임. v3.0+ 신 schema entry 표지 = `version` 필드 존재 (forward-only 조건). historical entry (id flat = `v{X.Y}_{slug}`, version 필드 부재) skip — 책임 분리 정합 (architecture P3 권고 흡수).",
      "alternatives_rejected": [
        "detect_era 호출 — era 분류와 schema 검증 책임 혼재 위험"
      ]
    },
    {
      "id": "D17",
      "decision": "milestones.md spec 섹션 작성 명세 (D7 보강) — spec 섹션 cross-ref = ARCHITECTURE.md § 6.1 (1줄) + v3.0/milestones.md spec 섹션 (1줄), 본문 spec 정의 직접 복제 부재 (spec-drift S2 흡수)",
      "rationale": "v3.0 phase-5 흡수 spec-drift 권고 (picture-frame 의무) 정신 일관 — milestones.md spec 섹션 의 본문 spec 정의는 v3.0/milestones.md 단일 source, v3.1/milestones.md 는 cross-ref 만. picture-frame 정신 보존 + 단일 source 일관.",
      "alternatives_rejected": [
        "spec 본문 복제 (v3.0 → v3.1) — picture-frame 정신 위배, 단일 source 위반",
        "cross-ref 부재 — picture-frame 권고 누락"
      ]
    },
    {
      "id": "D18",
      "decision": "phase-1 narrative MD049 spec 직접 인용 = '백틱 escape — markdownlint MD049 spec: \"intra-word emphasis is restricted to asterisk to avoid unwanted emphasis for words containing internal underscores\"' (spec-drift S1 흡수)",
      "rationale": "tests/CLAUDE.md § '흔한 함정' 7번째 row 안 MD049 회피 narrative 작성 시 markdownlint 공식 spec 직접 인용. 권위 강화 + 외부 spec 단일 source 정합. spec-drift S1 권고 흡수.",
      "alternatives_rejected": [
        "spec 인용 부재 (현 narrative 만) — drift 검토 시 권위 부족"
      ]
    }
  ],
  "approach": "v3.0_milestones-restructure 의 직접 후속 (PROPOSE 3건 + lessons L10) 을 통합 milestone 1건 (sub-milestone 3 = phase 3) 으로 적용. v3.0+ 9-stage-bundled era 첫 후속 사례 도그푸드 — milestones/v3.1/ 신 구조 + milestones.md (sub_milestones[] 3건). 가벼운 변경 (narrative + 결정 + smoke 1건) 부담 작은 milestone — 5 관점 검토 시 'scope contract' 가 main concern (INTENT.success_criteria 8건 ↔ DESIGN.phases 3건 매핑). phase 순서: narrative (phase-1) → 결정 (phase-2) → 자동 강제 smoke (phase-3) 누적. 모든 phase 1 commit (conventional `feat(meta): v3.1 phase-{n} — <주제>`).",
  "phases": [
    {
      "n": 1,
      "title": "tests/CLAUDE.md § '흔한 함정' 7번째 항목 — markdownlint MD032/MD049 trap narrative",
      "scope": [
        "milestones/v3.1/milestones.md 신규 (phase-1 시작 직후 즉시 작성, 회귀 risk R1 mitigation — detect_era 9-stage-bundled 인식 보장) + spec 섹션 cross-ref (D17 — ARCHITECTURE.md § 6.1 + v3.0/milestones.md spec 섹션, 본문 spec 정의 복제 부재) + sub_milestones[] 3건 skeleton (phase-1 status: in_progress, phase-2/3 status: pending) + dependencies 표현 (D14: phase-1=[], phase-2=[1], phase-3=[2])",
        "tests/CLAUDE.md § '흔한 함정' 표 7번째 row 추가 (markdownlint 자동 차단 함정) + 증상 (underscore emphasis 오인 + list 빈 줄 부재) + 회피 (백틱 escape + 강조 직후 빈 줄 의무) + MD049 spec 직접 인용 (D18 흡수)",
        "tests/CLAUDE.md § '흔한 함정' 헤더 narrative 갱신 ('6 evidence-base' → '7 evidence-base')",
        "milestones/v3.1/execute/phase-1.md (status: in_progress → 완료 후 status: complete)",
        "phase-1 commit 전 self-check (D13): markdownlint --all-files + smoke-cross-ref --fix 자동 실행"
      ],
      "affected_files": [
        "tests/CLAUDE.md",
        "projects/meta/milestones/v3.1/milestones.md",
        "projects/meta/milestones/v3.1/execute/phase-1.md"
      ],
      "rationale": "v3.0 lessons L10 직접 인용 narrative — 자동 강제 부재, 사용자 안내만. milestones.md 작성 시점 phase-1 시작 직후 (D7 + R1 mitigation) — detect_era 가 v3.1 디렉토리를 9-stage-bundled era 로 인식하기 위해 milestones.md 존재 의무. D14 dependencies 명시 (자기참조 부합).",
      "risks": ["R4 (본 milestone 산출물 자체 markdownlint 위반 가능, D13 mitigation)", "R1 (milestones.md 부재 시 detect_era 오인, scope 안에서 mitigate)"]
    },
    {
      "n": 2,
      "title": "ARCHITECTURE.md § 6.1 — milestones.md historical era 적용 결정 (forward-only 강제)",
      "scope": [
        "ARCHITECTURE.md § 6.1 'forward-only era 영구화 trade-off' 단락 안 또는 직후에 historical 결정 narrative 추가 (1단락) — 옵션 (a) forward-only 강제 채택 + rationale (v2.x 9-stage flat 구조 = sub-milestone 부재, milestones.md 부적합) + 단방향 cross-ref 'spec picture-frame: v3.0 milestones.md' 1줄 (D12 + D17)",
        "projects/meta/milestones/v3.0/milestones.md unchanged (D12 — architecture P1 권고 흡수, 사용자 결정 2026-05-10)",
        "milestones/v3.1/milestones.md sub_milestones[] phase-1 status: completed → phase-2 status: in_progress → completed 갱신",
        "milestones/v3.1/execute/phase-2.md",
        "phase-2 commit 전 self-check (D13): markdownlint --all-files (ARCHITECTURE.md 새 underscore identifier 인용 가능 — `v2.x_*` 같은 패턴 백틱 escape)"
      ],
      "affected_files": [
        "projects/meta/ARCHITECTURE.md",
        "projects/meta/milestones/v3.1/milestones.md",
        "projects/meta/milestones/v3.1/execute/phase-2.md"
      ],
      "rationale": "narrative-only (구현 부담 0). v3.0 정책 일관 (forward-only 강제). 5 관점 spec-drift 검토 권고 흡수 (D12 갱신 — v3.0 milestones.md unchanged).",
      "risks": ["R1 (의견 충돌 — 사용자 결정 P1 수용으로 mitigate)"]
    },
    {
      "n": 3,
      "title": "tests/smoke-bundle-trigger.sh 신규 + pre-commit 등록 (12 → 13 hook)",
      "scope": [
        "tests/smoke-bundle-trigger.sh 신규 작성 (단일 책임 — bundling validation)",
        "검증 책임 (D8): (1) 같은 version 값 v3.0+ entry 1건 강제, (2) v3.0+ entry milestones_path 필드 형식 검증, (3) historical entry 무시 (forward-only). detect_era 미호출 — ROADMAP entry schema 직접 검사 (D16)",
        "표준 절차 적용 (D10): batched python3 heredoc + cp949 reconfigure errors='replace' + AST audit boilerplate (smoke-python-entry-boilerplate § P2 PASS)",
        ".pre-commit-config.yaml 안 신규 hook 등록 (entry: direct, files: ROADMAP\\.md$|projects/.*/ROADMAP\\.md$)",
        "tests/CLAUDE.md § smoke 매트릭스 1 row 추가 (smoke-bundle-trigger.sh) + smoke 카운트 27 → 28 + § Pre-commit 통합 5 → 6 active hook (D15 — phase-3 책임)",
        "controlled 비교 4-step (v3.0 phase-7 흡수) — phase-3 신규 smoke 의 ROADMAP 입력 검증 (의도된 변경 narrative 기록 = 신규 검증 추가, 입력 데이터 변경 부재). v3.1 디렉토리 신규로 인한 smoke-spec-verification / smoke-scope-contract 입력 변화는 별 검증 (R6 mitigation Stage G — 동일 4-step 패턴 적용)",
        "milestones/v3.1/milestones.md sub_milestones[] phase-2 status: completed → phase-3 status: in_progress → completed",
        "milestones/v3.1/execute/phase-3.md",
        "phase-3 commit 전 self-check (D13): markdownlint --all-files + AST audit (smoke-python-entry-boilerplate)"
      ],
      "affected_files": [
        "tests/smoke-bundle-trigger.sh",
        ".pre-commit-config.yaml",
        "tests/CLAUDE.md",
        "projects/meta/milestones/v3.1/milestones.md",
        "projects/meta/milestones/v3.1/execute/phase-3.md"
      ],
      "rationale": "자동 강제 누적 (5요소 매트릭스 'Constraint' 정전). 단일 책임 원칙 일관 (D2). pre-commit 등록 D3. detect_era 미호출 책임 분리 (D16). 표준 절차 (D10) + tests/CLAUDE.md 동기화 phase 분리 (D15).",
      "risks": [
        "R2 (smoke 가 v3.0 도그푸드 entry 검증 시 PASS 보장 — controlled 비교 phase-3 입력 + Stage G v3.1 입력 변화 별 4-step)",
        "R3 (historical entry 오인 가능성 — D8 (3) version 필드 부재 시 즉시 skip mitigate)",
        "R5 (pre-commit 등록 의견 충돌 — D3 등록 권장)",
        "R6 (smoke-spec-verification / smoke-scope-contract 의 v3.1 자동 식별 PASS 보장 — Stage G controlled 비교)"
      ]
    }
  ],
  "risk_mitigation": [
    {
      "risk_id": "R1",
      "mitigation": "5 관점 검토 시 spec-drift / scope contract 가 forward-only 강제 권고 (D1 결정 일관) — 의견 충돌 부재 예상. 사용자 결정 분기 발견 시 AskUserQuestion 자동 invoke (Stage D 운영 원칙)."
    },
    {
      "risk_id": "R2",
      "mitigation": "phase-3 smoke 작성 후 controlled 비교 4-step (v3.0 phase-7 흡수) 의무: HEAD baseline + post 출력 동치 검증. 의도된 변경 (v3.0 entry 신 schema 검증 PASS) 은 narrative 기록 (REPORT.lessons_learned)."
    },
    {
      "risk_id": "R3",
      "mitigation": "smoke logic 안 `version` 필드 부재 entry 는 즉시 continue (skip) — historical (id flat) PASS 보장. 단위 검증: ROADMAP.md 안 v1.x/v2.x entry 모두 skip → 검사 부재 → PASS."
    },
    {
      "risk_id": "R4",
      "mitigation": "본 milestone INTENT/RESEARCH/DESIGN/APPROVE.md 작성 시 (a) underscore identifier 백틱 escape (`v{X.Y}_{slug}`), (b) 강조 직후 list 시 빈 줄 의무 적용. phase-1 commit 전 markdownlint --all-files 사전 검증."
    },
    {
      "risk_id": "R5",
      "mitigation": "D3 (pre-commit 등록) 권장 — 자동 차단 누적 정신. 5 관점 검토 시 의견 충돌 가능성 낮음 (narrative + 자동 강제 의무 정합)."
    },
    {
      "risk_id": "R6",
      "mitigation": "Stage G VERIFY 에서 smoke-spec-verification + smoke-scope-contract 의 v3.1 디렉토리 자동 식별 PASS 검증 (controlled 비교). 회귀 시 detect_era 함수 (tests/_era_detect.py) drift 검사."
    },
    {
      "risk_id": "R7",
      "mitigation": "D5 거부 — 단일 책임 원칙 + commit 분리 추적성 보존. phase-2 narrative-only 가 가벼운 phase 지만 별 commit 정신 일관."
    }
  ],
  "five_perspective_review": {
    "scope": "중간 (~7 파일 수정) → 4 관점 검토 (architecture / spec-drift / 회귀 risk / scope contract)",
    "perspectives": [
      "1. architecture (Plan agent) — 디렉토리 구조 / 파일 책임 / 변경 영향",
      "2. spec-drift (general-purpose, context7) — markdownlint MD032/MD049 spec 정합 + semver minor bump",
      "3. 회귀 risk (Explore) — 기존 smoke / verify 영향 (smoke-spec-verification / smoke-scope-contract / smoke-projects-scope-discipline 회귀)",
      "4. scope contract (Explore) — INTENT.success_criteria 8건 ↔ DESIGN.phases 3건 매핑"
    ]
  }
}
```

## 5 관점 검토 결과 (Stage D 다각적 병렬 검토)

scope = 중간 (~7 파일 수정 + sub-milestone 3 + 산출 7종) → 4 관점 검토 (2026-05-10):

1. **architecture** (Plan agent) — verdict: pass-with-comments (4 권고 P1~P4)
2. **spec-drift** (general-purpose, context7) — verdict: pass-with-comments (3 권고 S1~S3)
3. **회귀 risk** (Explore) — verdict: pass-with-comments (7 권고 R1~R7)
4. **scope contract** (Explore) — verdict: pass-with-comments (5 권고 SC1~SC5)

5번째 관점 (보안) — scope 큼 (16+ 파일) 시만 활성. 본 milestone 작은~중간 (~7 파일) 으로 보안 검토 부담 부재 (narrative + 결정 + 1 smoke 만, side effect / 권한 / path traversal 부재).

## 검토 권고 흡수

자동 흡수 (DESIGN.decisions / phases 갱신):

- **P2** (모든 phase affected_files 에 milestones.md 명시) → 이미 phases[].affected_files 명시, 정합
- **P3** (smoke detect_era 미호출 명시) → D16 신규
- **P4** (R6 controlled 비교 4-step 적용 대상 명료화) → phase-3.scope + R6 mitigation 강화 (phase-3 입력 + Stage G v3.1 입력 변화 분리)
- **S1** (D11 narrative MD049 spec 직접 인용) → D18 신규
- **S2** (D7 milestones.md skeleton 명세 강화) → D17 신규 (cross-ref 2건 + 본문 복제 부재)
- **S3** (D13 self-check phase 별 확장) → D13 갱신 (phase-1/2/3 모두)
- **R1** (phase-1 시작 전 milestones.md 즉시 생성, CRITICAL) → phase-1.scope 첫 항목 + phase-1.risks 명시
- **R2** (각 phase commit 직후 tests/CLAUDE.md 동기화) → D15 신규 (phase-1 / phase-3 분리)
- **R3** (phase-3 표준 절차 체크리스트) → phase-3.scope 표준 절차 명시 + smoke-python-entry-boilerplate § P2 PASS
- **R4** (phase-1 commit 전 smoke-cross-ref --fix) → D13 갱신
- **R5** (smoke 책임 D8 일관) → D8 보존 + D16 추가
- **R6** (controlled 비교 4-step) → phase-3.scope + Stage G VERIFY 명시
- **R7** (markdownlint self-check) → D13 갱신
- **SC1** (D6 dependency 표현 상세화) → D14 신규 (sub_milestones[].dependencies = [[], [1], [2]])
- **SC2** (SC6 implicit → explicit) → D14 신규 (자기참조 부합 명시)
- **SC4** (D1 alternatives_rejected (b) 거부 근거 강화) → D1 alternatives_rejected 안 retroactive 비용 narrative
- **SC5** (D5 R7 거부 근거 명시) → D5 rationale 안 narrative-only 도 commit 분리 가치 narrative

사용자 결정 흡수:

- **P1** (v3.0 milestones.md cross-ref 추가 vs 제거) — **제거** 채택 (사용자 결정 2026-05-10, AskUserQuestion). D12 갱신 — v3.0 milestones.md unchanged.

## 의견 충돌 결과

5 관점 검토 의견 충돌 1건 (architecture P1 vs spec-drift D7/D17 정신) → 사용자 결정 (P1 제거) 으로 해소. 그 외 권고 모두 자동 흡수 (충돌 부재).

## 관련

- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 정전 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1 bundling 정책
- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- v3.0 DESIGN (5 관점 검토 패턴 reference): [`../v3.0/DESIGN.md`](../v3.0/DESIGN.md)
- tests/ 모듈 가이드: [`../../../../tests/CLAUDE.md`](../../../../tests/CLAUDE.md) § 'Pre-commit hook entry 정책'
