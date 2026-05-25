# DESIGN — v1.4_cross-ref-propagation

```json
{
  "id": "v1.4_cross-ref-propagation",
  "decisions": [
    {
      "decision": "Phase 순서 = phase-1 cross-ref 일괄 → phase-2 docs/ARCHITECTURE.md 폐기 cascade → phase-3 GUARDRAILS.md 전면 재작성",
      "rationale": "architecture agent 권고. § 3.5 단일 source list 갱신 (docs/ARCH 제거 + projects/meta/CLAUDE.md 추가) 이 phase-2 cascade 안에서 처리되어, phase-3 GUARDRAILS rewrite 시점에 host 가 이미 single source list 정합 상태. 반대 순서 (GUARDRAILS 먼저) 는 phase-3 cascade 까지 § 3.5 list 와 live 상태 불일치 transient — narrative trace 손상 risk.",
      "alternatives_rejected": [
        "PLAN 잠정 순서 (phase-1 → GUARDRAILS → docs/ARCH cascade) — § 3.5 transient 불일치 + GUARDRAILS rewrite 안의 정의 cross-ref 가 미정정 list 안에서 self-referencing risk",
        "2-phase (cross-ref + GUARDRAILS / docs/ARCH cascade) — phase-1 의 5 file 변경량 격차 + cross-ref 추가 (1~2줄) + GUARDRAILS 전면 재작성 (~70~90줄) 책임 혼재",
        "4-phase (host 별 + docs/ARCH) — phase 수 과다, AGENTS·README·projects/meta/CLAUDE 의 cross-ref 1줄 추가는 같은 책임 (Context 정전 보강) 으로 commit 분리 필요 X"
      ]
    },
    {
      "decision": "Cross-ref 위치 = 4 host 모두 standalone header/block (Key docs 표 항목 description 갱신 사용 X)",
      "rationale": "spec-drift agent 권고. host 별 가시성 + § 3.5 grep 강제 + root CLAUDE.md L8 표본 일관. AGENTS.md = 신규 § 'Harness engineering definition' (Workflow L45 ↔ Boundaries L64 사이). README.md = L4 tagline 직후 1줄 standalone block (above the fold, 외부 방문자 즉시 인지). projects/meta/CLAUDE.md = H1 직후 (lazy load 발화 시점). GUARDRAILS.md = § 1 목적 안 (L19 직후, '본 파일은 INTENT.md 작성 단계에서 자동 참조' 줄과 first-class peer).",
      "alternatives_rejected": [
        "Key docs 표 항목 description 갱신 — 가시성 sub-bullet 약화 + 표 폭 widening (architecture R9)",
        "host 자연 위치 (cross-host 일관성 약화) — Claude 가 host 별 다른 위치 학습 필요"
      ]
    },
    {
      "decision": "Cross-ref 1줄 형식 = 언어별 표본 통일",
      "rationale": "spec-drift agent 권고. 한국어 host (projects/meta/CLAUDE.md / GUARDRAILS.md) = root CLAUDE.md L8 verbatim. 영문 host (AGENTS.md / README.md) = 'Harness engineering definition (canonical single source): [projects/meta/ARCHITECTURE.md § 3] — working definition + 5-element matrix (Context / Workflow / Constraint / Verification / Trace). New milestones must map to one of these five elements.' 한국어 root L8 의 4 semantic load (label / canonical-source / 5-element / mapping obligation) 모두 보존.",
      "alternatives_rejected": [
        "'single source of truth' (SSOT 약어 overload) — 'canonical single source' 가 § 3.5 의미 더 정확",
        "'engineering principles' / 'design principles' — '정의 (working definition)' load 손상 (§ 3.1 추수 X)",
        "'five-element framework' — § 3.3 heading ('5요소 매트릭스') 와 drift",
        "AGENTS·README 별도 영문 (캐주얼) — host 별 일관성 약화"
      ]
    },
    {
      "decision": "R8 (§ 3.5 단일 source list 갱신) 처리 = phase-2 cascade 안에서 처리, out_of_scope #1 위반 X 명시",
      "rationale": "architecture + spec-drift agent 합의. L76 의 cross-ref list 갱신 (docs/ARCHITECTURE.md 제거 + projects/meta/CLAUDE.md 추가) 은 정의 본문 (working_definition / philosophy / matrix) 갱신이 아닌 'cross-ref 목록 정정'. broken link cleanup 과 동등. PLAN.out_of_scope #1 ('정의 본문 자체 갱신') 의 본문 = § 3.1 working definition + § 3.2 philosophy + § 3.3 matrix 본체. § 3.5 의 cross-ref list 는 본문이 아닌 metadata.",
      "alternatives_rejected": [
        "R8 별도 phase 분리 — cascade 의 다른 5곳 (L5/L46/L102/L112) 과 책임 동질 (모두 docs/ARCH 거명 제거), 별도 phase 분리 필요 X",
        "R8 out_of_scope 분류 (별개 milestone) — phase-2 cascade 후 § 3.5 list 가 docs/ARCH 거명 잔존 = inconsistent state, 본 milestone 안에서 처리 의무"
      ]
    },
    {
      "decision": "GUARDRAILS H/C 매트릭스 fate = spec-drift agent 권고안 전체 채택",
      "rationale": "spec-drift agent 의 항목별 7-stage 시대 정합 검토 결과 명확. 외부 spec (Conventional Commits / SemVer) 정합 + 7-stage 구조적 precluded 항목 제거 + DESIGN.approval gate 정전화. H7 (execute.py / phases/) 제거: 부재 도구 거명. H9 (sessions/index.json/step{N}.md) 제거: 7-stage 구조적 precluded (산출물 화이트리스트 = PLAN~REPORT + execute/phase-{n}.md). C2~C6 (bootstrap/templates/_base / install-project-claude / manifest-schema / docs) 제거: 부재 디렉토리. C2 자리 'bootstrap/skills/** 변경' 1줄 대체 (실제 존재 + opt-in install). C8 reframe: SemVer concept 유지하되 path 4-tier 제거 (`projects/meta/milestones/v{X+1}.0_{slug}/` 진입 시 마이그레이션 가이드 의무).",
      "alternatives_rejected": [
        "spec-drift 일부만 채택 (예: H7 keep) — 부재 도구 거명 잔존, 정전 host 자격 미달",
        "GUARDRAILS scope 축소 (cross-ref + sessions/ path 갱신만) — bootstrap C2~C6 부재 디렉토리 거명 잔존, host 정전화 미완. 사용자 의문 round 2 결정 (전면 재작성) 답습"
      ]
    },
    {
      "decision": "GUARDRAILS § 4 'Scope contract 의무' 7-stage 정합 재구성",
      "rationale": "현재 § 4 = 4-tier 'sessions/meta/v1.10j-scope-contract-discipline/' 시대 의무 (3 섹션: 세션 소속 근거 / Scope inheritance / Out of scope, S#/T# verbiage, '선행 세션 verbatim'). 7-stage 시대 정합 = INTENT.md 의무 3 필드 (success_criteria / out_of_scope / dependencies). tests/smoke-spec-verification.sh + tests/smoke-scope-contract.sh 가 schema 강제 — § 4 가 narrative 강제 source 로 재정의.",
      "alternatives_rejected": [
        "§ 4 keep (4-tier verbiage 유지) — 7-stage 시대 narrative drift, 'sessions/' / 'S#/T#' obsolete reference",
        "§ 4 제거 (smoke 만 의존) — narrative + 파일 trace 우선 정의 § 3.1 명료화 단락 정신 위반 (smoke = 보조 메커니즘, narrative = 1차 source)"
      ]
    },
    {
      "decision": "GUARDRAILS 신규 H10 'DESIGN.approval gate 부재 EXECUTE 진입' 추가",
      "rationale": "spec-drift agent 권고. 현재 GUARDRAILS H1~H9 / C1~C8 어디에도 'DESIGN.approval 필수 게이트' 명시 부재. 정의 § 3.3 매트릭스 'Constraint' 의 (b) 메커니즘 cross_ref 에 'DESIGN.approval (approved_by: \"user\" + date)' 거명되어 있으나 GUARDRAILS host 자체 강제 부재 — 정의 § 3.3 의 정전 메커니즘이 host 에 미반영. H10 추가로 정전성 확보.",
      "alternatives_rejected": [
        "C9 (위험 작업) 분류 — DESIGN.approval gate 부재 = '위험 작업' 보다 '금지 행동' (hard rule) 분류 적절. EXECUTE 진입 자체 차단 의무.",
        "신규 룰 추가 X (smoke 만) — 정의 § 3.3 'Constraint' 정전 보강 미완"
      ]
    },
    {
      "decision": "Cross-ref 4 host 의 정확한 anchor 줄 = phase-1 affected_files 명시 화이트리스트",
      "rationale": "v1.3 risk_mitigation[5] 정신 답습. EXECUTE 단계 affected_files 화이트리스트 강제 (DESIGN.phases[*].affected_files 외 file 수정 = scope 위반). phase-1 affected_files = AGENTS.md / README.md / projects/meta/CLAUDE.md / projects/meta/milestones/v1.4_cross-ref-propagation/execute/phase-1.md (4 항목). GUARDRAILS.md 는 phase-3 으로 이동 (cross-ref 추가 + 전면 재작성 동일 phase 안에서 처리).",
      "alternatives_rejected": [
        "GUARDRAILS cross-ref add 만 phase-1 안 + 본문 rewrite phase-3 — phase-1 의 GUARDRAILS L19 직후 1줄 추가 후 phase-3 에서 같은 host 전면 재작성 = 의미 중복. phase-3 안에서 통합."
      ]
    },
    {
      "decision": "AGENTS Status 섹션 일반화 정확한 문구 = 'Public repository, MIT licensed. Milestone history: see [projects/meta/ROADMAP.md](projects/meta/ROADMAP.md).' (2줄 통합)",
      "rationale": "사용자 결정 (의문 round 1) = '일반화 — Milestone history: see ...'. spec-drift agent options[1] (Status + history 통합 2줄) 가 외부 가시성 (Public/MIT licensed 메타 정보 보존) + history ROADMAP 위임 양립. 1줄 형 (단순 'Milestone history: see') 은 repo 상태 메타 정보 손실. 섹션 자체 제거는 LICENSE 별도 위임 필요 — 변경량 증대.",
      "alternatives_rejected": [
        "1줄 형 'Milestone history: see [projects/meta/ROADMAP.md]' — Public/MIT licensed 메타 정보 손실",
        "섹션 자체 제거 — LICENSE 별도 위임 필요, 변경량 증대"
      ]
    },
    {
      "decision": "SC#5 grep boundary 명시 = living dependencies (code/docs/configs) only, milestone artifacts 제외",
      "rationale": "scope contract agent 권고. v1.3 DESIGN.decisions[6] 의 narrative trace 보존 정신 답습. 본 milestone 의 PLAN/RESEARCH/DESIGN/VERIFY/REPORT + execute/phase-{n}.md 는 docs/ARCHITECTURE.md 거명 다수 (historical narrative). milestone artifacts 가 docs/ARCH 폐기 결정 / cascade 처리 / 후속 분석 narrative 의 전제 — grep 0 적용 시 narrative trace 손상. 'repo-wide grep 0' = `grep -r 'docs/ARCHITECTURE' --exclude-dir=projects/meta/milestones --exclude-dir=.git`.",
      "alternatives_rejected": [
        "grep 모든 파일 (milestone artifacts 포함) — 본 PLAN/RESEARCH/DESIGN 자체에 'docs/ARCHITECTURE' 다수 거명, SC#5 충족 불가",
        "grep 화이트리스트 (cascade 7곳만) — repo-wide 범위 의도 (cascade 누락 검출) 손상"
      ]
    },
    {
      "decision": "smoke 신규 추가 OFF (정의 cross-ref drift 검증 자동화)",
      "rationale": "v1.3 DESIGN.decisions[7] 정신 답습. PLAN.out_of_scope #4 명시 ('신규 smoke 추가'). 정의 § 3.1 명료화 단락 거명 자동화 #3 'smoke 키워드 강제' = 임시방편 분류. 정의 cross-ref drift 검증은 narrative + 파일 trace 우선 정신상 GUARDRAILS H/C 매트릭스 + DESIGN.approval gate (narrative gate) 가 1차 source.",
      "alternatives_rejected": [
        "smoke 신규 추가 (smoke-definition-cross-ref.sh) — out_of_scope #4 침범 + 정의 § 3.1 명료화 단락 정신 (smoke 키워드 강제 = 임시방편) 위반"
      ]
    },
    {
      "decision": "VERIFY.md 의 baseline CI status 측정 = pre-EXECUTE 시점 + post-EXECUTE 시점 비교",
      "rationale": "회귀 risk agent 권고. 12 inactive bootstrap-related smokes 가 .github/workflows/ci.yml 안에서 active (CI 만 실행, pre-commit X). v1.4 변경 전 후 baseline 비교가 회귀 검증의 신뢰성 확보. 단 이는 VERIFY.md 의 검증 명세 — 본 DESIGN 결정으로 VERIFY.smoke_tests 항목에 baseline 비교 명시 의무.",
      "alternatives_rejected": [
        "baseline 측정 없이 post-EXECUTE PASS 만 확인 — 12 inactive smokes 가 v1.4 전부터 FAIL 이면 잘못 v1.4 책임 귀속 risk"
      ]
    }
  ],
  "approach": "3-phase 분할: (1) cross-ref 1줄 일괄 추가 (3 host: AGENTS.md / README.md / projects/meta/CLAUDE.md) + AGENTS Status 섹션 일반화. (2) docs/ARCHITECTURE.md 폐기 + cascade 6곳 정리 (ROADMAP.md L43 + projects/meta/ARCHITECTURE.md L5/L46/L76/L102/L112) + § 3.5 단일 source list 갱신 (docs/ARCH 제거 + projects/meta/CLAUDE.md 추가). (3) GUARDRAILS.md 전면 재작성 — sessions/→milestones/, bootstrap C2~C6 제거 (대체 1줄), H/C 매트릭스 7-stage 정합 (H7/H9 제거, H1/H6 path 갱신, H8 keep, C8 reframe), § 4 Scope contract 7-stage 정합, 신규 H10 DESIGN.approval gate, § 1 목적 안 정의 cross-ref 1줄. 각 phase = 1 commit (총 3 commit), Stage G (VERIFY/REPORT/ROADMAP) 별도 +1 = 총 4 commit.",
  "phases": [
    {
      "phase": 1,
      "title": "Cross-ref 1줄 일괄 추가 (3 host) + AGENTS Status 일반화",
      "scope": "Context 정전 보강 — 3 host 에 정의 § 3 cross-ref 1줄 standalone header/block 추가, AGENTS.md L82-84 Status 섹션 'Public repository, MIT licensed. Milestone history: see [projects/meta/ROADMAP.md]' 2줄 일반화",
      "affected_files": [
        "AGENTS.md",
        "README.md",
        "projects/meta/CLAUDE.md",
        "projects/meta/milestones/v1.4_cross-ref-propagation/execute/phase-1.md"
      ],
      "rationale": "phase-1 은 순수 additive (deletion 0) — phase-2/3 의 cascade 와 의존 관계 0. 각 host 의 cross-ref 형식이 phase-3 GUARDRAILS rewrite 안의 cross-ref 형식 표본 역할 (phase-3 cross-ref 추가가 phase-1 의 형식과 일관성).",
      "risks": [
        "AGENTS.md 신규 § 'Harness engineering definition' 추가 시 § Workflow / § Boundaries 사이 위치 — markdownlint MD024 (sibling header duplicate) risk 0 (신규 § 명 unique)",
        "README.md L4 tagline 직후 1줄 추가 시 본문 흐름 — '> Operational manual' 줄과 같은 `>` quote 패턴 채택, 일관성 보존",
        "projects/meta/CLAUDE.md H1 직후 추가 시 @ROADMAP.md (L3) 와 markdown 충돌 risk 0",
        "AGENTS Status 갱신 시 v1.0~v1.3 명시 거명 0 검증 — grep 'v1.0_workflow-redesign' / 'v1.1_meta-as-project' / 'v1.1_readme-cleanup' / 'v1.1_agents-md-cleanup' / 'v1.2_post-report-write-message-rewrite' / 'v1.3_harness-engineering-definition' 모두 AGENTS.md 안에서 0 확인"
      ]
    },
    {
      "phase": 2,
      "title": "docs/ARCHITECTURE.md 폐기 + cascade 정리 (6곳) + § 3.5 단일 source list 갱신",
      "scope": "책임 중복 host 폐기 cleanup — docs/ARCHITECTURE.md git rm + ROADMAP.md L43 cross-ref 줄 제거 + projects/meta/ARCHITECTURE.md 5곳 (L5 인용 / L46 § 2 모듈 책임 표 row / L76 § 3.5 list / L102 § 6 / L112 § 7) docs/ARCH 거명 제거 + § 3.5 list 갱신 (docs/ARCH 제거 + projects/meta/CLAUDE.md 추가, 결과 5곳: root CLAUDE.md / AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md)",
      "affected_files": [
        "docs/ARCHITECTURE.md",
        "ROADMAP.md",
        "projects/meta/ARCHITECTURE.md",
        "projects/meta/milestones/v1.4_cross-ref-propagation/execute/phase-2.md"
      ],
      "rationale": "phase-2 가 phase-3 의 prerequisite — § 3.5 list 갱신이 host (GUARDRAILS) 자체의 정전 가정 (single source list 일원) 의 전제. 또한 docs/ARCH 폐기 후 phase-3 GUARDRAILS rewrite 시 docs/ARCH 거명 대체 의무 (혹시 GUARDRAILS rewrite 안에 docs/ARCH 거명 부주의 추가 risk 사전 차단).",
      "risks": [
        "L46 § 2 모듈 책임 표 row 제거 시 markdown table 정렬 (1행 제거 = 6행 → 5행). markdownlint 점검 의무",
        "L76 § 3.5 list 갱신 시 cross-ref 거명 list 가 5곳 (root CLAUDE.md / AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md) — projects/meta/CLAUDE.md 신규 거명 추가는 phase-1 commit 후에만 의미 (cross-ref 미추가 host 거명 시 self-referencing 부정합), 단 phase-1 → phase-2 순서로 이미 보장",
        "L5 인용 줄 제거 시 § 1 도입부 본문 흐름 — '글로벌 시스템 도식: docs/ARCHITECTURE.md' 거명 제거 후 '운영 가이드: root CLAUDE.md. 영문 요약: AGENTS.md.' 만 남김 (글로벌 시스템 도식 책임은 § 1 디렉토리 트리 흡수, R11 mitigation)",
        "git rm docs/ARCHITECTURE.md 시 .github/workflows/ci.yml / .pre-commit-config.yaml / smoke 22종 안의 docs/ARCH 거명 cascade 영향 0 (RESEARCH grep 결과 live 파일에 거명 부재 — milestone artifacts + ai-ready-report.json + bootstrap/skills 의 generic 패턴만)",
        "smoke-cross-ref.sh 가 docs/ARCH 폐기 후 broken ref 검출 risk — cascade 6곳 모두 정리 후 smoke PASS 의무 (post-execute 회귀 검증)"
      ]
    },
    {
      "phase": 3,
      "title": "GUARDRAILS.md 전면 재작성 (cross-ref + sessions/→milestones/ + bootstrap 제거 + H/C 7-stage 정합 + 신규 H10)",
      "scope": "host 자체 정전화 — sessions/ 거명 0 (milestones/v{X.Y}_{slug}/ 갱신), bootstrap C2~C6 제거 (C2 자리 'bootstrap/skills/** 변경' 1줄 대체), H7/H9 제거, H1/H6 path 갱신, H8 keep, H2~H5 keep, C1 keep, C7 keep, C8 reframe (`projects/meta/milestones/v{X+1}.0_{slug}/` 마이그레이션 가이드), 신규 H10 'DESIGN.approval gate 부재 EXECUTE 진입' 추가, § 4 Scope contract 7-stage 정합 (PLAN.success_criteria + out_of_scope + dependencies), § 1 목적 안 정의 § 3 cross-ref 1줄 추가 (root CLAUDE.md L8 verbatim), § 6 References / Evolution sessions/ path 갱신",
      "affected_files": [
        "GUARDRAILS.md",
        "projects/meta/milestones/v1.4_cross-ref-propagation/execute/phase-3.md"
      ],
      "rationale": "phase-2 에서 docs/ARCH 폐기 + § 3.5 list 갱신 후 phase-3 시점의 host (GUARDRAILS) 가 single source list 일원으로 정합 상태. GUARDRAILS rewrite 안의 정의 cross-ref 추가가 self-referential 부정합 0. 변경량 가장 큰 phase 이므로 single phase + single commit + 단일 책임.",
      "risks": [
        "GUARDRAILS rewrite 시 markdownlint MD024 (sibling header duplicate) risk — H1~H8 / C1, C7, C8 (H9 H10 신설) 의 헤더 명 unique 검증 의무",
        "C2~C6 row 제거 시 § 3 위험 작업 매트릭스 table 정렬 (5행 제거 = 8행 → 3행). markdownlint 점검 + table pipe alignment 의무",
        "신규 H10 추가 시 § 2 금지 행동 매트릭스 (현재 H1~H9, H7/H9 제거 후 H1~H6 + H8 = 7행, 신규 H10 = 8행). H 번호 재할당 vs 기존 번호 보존 결정 — 기존 번호 보존 (H7/H9 부재 + H10 신설 = 'H1~H6, H8, H10') 또는 재할당 (H1~H8) — 재할당 선택 (audit 명료)",
        "§ 1 목적 안 정의 cross-ref 추가 시 L19 직후 위치 — '본 파일은 INTENT.md 작성 단계에서 자동 참조' 줄과 first-class peer (spec-drift agent 권고)",
        "scope creep risk R7 — H/C 매트릭스 항목 수정이 본 milestone 의 cross-ref 전파 정신 벗어나 'GUARDRAILS 정전화' 별개 milestone 분량 가능. 명시 화이트리스트 (4 작업: sessions/→milestones/, bootstrap 제거, 항목 수정, 정의 cross-ref) 강제, 5번째 작업 (예: 신규 § 추가) = scope 위반",
        "GUARDRAILS rewrite 후 § 1 목적의 'INTENT.md 작성 단계에서 자동 참조' 가 7-stage smoke (smoke-spec-verification / smoke-scope-contract) 와 align — 의미 일관성 검증 의무"
      ]
    }
  ],
  "risk_mitigation": [
    {"risk_id": "R1", "risk": "정의 본문 / 5요소 매트릭스 가 cross-ref 추가 host 4곳에 누설 → drift", "mitigation": "root CLAUDE.md L8 표본 형식 (5요소 이름 + 운영 게이트 1줄, 정의 본문 복제 X) 강제. EXECUTE 후 grep 검증 — '하네스 엔지니어링은 agent 의 행동을' (working_definition L52) live 파일 (milestone artifacts 제외) grep 0, 'Context.*Workflow.*Constraint.*Verification.*Trace' table 형식 grep 0 (cross-ref 1줄 안 5요소 이름 거명은 OK, table 형식만 차단)."},
    {"risk_id": "R2", "risk": "GUARDRAILS § 4 Scope contract 의무 의미 변경 시 정전 가치 약화", "mitigation": "DESIGN.decisions[6] 명시 — 4-tier 'sessions/' / 'S#/T#' / '선행 세션 verbatim' 거명만 7-stage 정합 표현 (PLAN.success_criteria + out_of_scope + dependencies) 으로 갱신, 의미 (Scope contract 강제) 보존. tests/smoke-spec-verification.sh + tests/smoke-scope-contract.sh 가 schema 강제 source — § 4 가 narrative source."},
    {"risk_id": "R3", "risk": "docs/ARCHITECTURE.md 폐기 시 cascade 정리 누락 → broken link", "mitigation": "phase-2 affected_files 화이트리스트 (docs/ARCHITECTURE.md / ROADMAP.md / projects/meta/ARCHITECTURE.md) — 5곳 cascade (L5/L46/L76/L102/L112) 모두 처리. EXECUTE 후 grep 'docs/ARCHITECTURE' (live 파일, milestone artifacts 제외) 결과 0 검증 + smoke-cross-ref.sh PASS 의무."},
    {"risk_id": "R4", "risk": "AGENTS.md Status 섹션 일반화로 외부 가시성 약화", "mitigation": "DESIGN.decisions[9] 결정 — 2줄 통합 'Public repository, MIT licensed. Milestone history: see [projects/meta/ROADMAP.md].' 채택. 메타 정보 (Public/MIT) 보존 + history ROADMAP 위임."},
    {"risk_id": "R5", "risk": "phase 순서 잘못 시 cascade 누락 또는 transient 불일치", "mitigation": "DESIGN.decisions[1] 결정 — phase-1 → phase-2 cascade → phase-3 GUARDRAILS rewrite. § 3.5 list 갱신이 GUARDRAILS rewrite prerequisite. 각 phase commit 후 smoke 회귀 검증 의무."},
    {"risk_id": "R6", "risk": "잔존 sessions/ stale + bootstrap 부재 거명 본 milestone scope 외", "mitigation": "PLAN.out_of_scope + RESEARCH.untouched_files_explicit 명시. REPORT.next_candidates 에 v1.4_infra-minimization (smoke / bootstrap 부재) + v1.5_legacy-narrative-cleanup (claude/hooks 주석 / claude/CLAUDE.md L39 / CHANGELOG.md L3 / projects/upbit historical) 후속 등록 의무."},
    {"risk_id": "R7", "risk": "scope creep — phase-3 GUARDRAILS rewrite 시 H/C 매트릭스 항목 수정이 'GUARDRAILS 정전화' 별개 milestone 분량", "mitigation": "DESIGN.decisions[5] 명시 — spec-drift 권고안 4 작업 (sessions/→milestones/, bootstrap 제거, H/C 항목 수정 spec 정합, 신규 H10) 만. 5번째 작업 (예: 신규 § 추가, H/C 의미 변경) 부재 강제."},
    {"risk_id": "R8", "risk": "§ 3.5 단일 source list 갱신 → 본문 vs cross-ref list 경계 모호", "mitigation": "DESIGN.decisions[3] 명시 — § 3.5 cross-ref list 는 정의 본문이 아닌 metadata. PLAN.out_of_scope #1 위반 X. cascade phase-2 안에서 처리."},
    {"risk_id": "R9", "risk": "markdownlint MD024 (sibling header duplicate) GUARDRAILS rewrite 시 H/C 헤더 명 충돌", "mitigation": "phase-3 commit 전 markdownlint --config .markdownlint.json GUARDRAILS.md 로컬 점검 의무. .pre-commit-config.yaml 의 markdownlint hook PASS 의무."},
    {"risk_id": "R10", "risk": "AGENTS.md L4 'see README.md' 와 README.md cross-ref 추가 atomicity", "mitigation": "phase-1 single commit 안에서 3 host 동시 갱신 — atomicity 보장 (architecture R10 mitigation)."},
    {"risk_id": "R11", "risk": "12 inactive bootstrap-related smokes 가 CI 에서 v1.4 전부터 FAIL 이면 잘못 v1.4 책임 귀속", "mitigation": "DESIGN.decisions[11] 결정 — VERIFY.md baseline CI status (pre-EXECUTE) + post-EXECUTE 비교 의무. baseline 측정은 phase-1 commit 전 수행, 결과 VERIFY.smoke_tests 안에 baseline 결과 + post 결과 양쪽 기록."},
    {"risk_id": "R12", "risk": "Successors_anticipated 버전 (v1.5_*) ROADMAP entries (v1.4_*) 불일치", "mitigation": "PLAN.dependencies.successors_anticipated 갱신 (v1.5_* → v1.4_*, 본 DESIGN 작성 전 처리됨). v1.3 PLAN/REPORT.next_candidates + ROADMAP entry 와 정합."},
    {"risk_id": "R13", "risk": "GUARDRAILS H 번호 재할당 vs 기존 번호 보존 audit 명료성", "mitigation": "phase-3.risks 명시 — 재할당 채택 (H7/H9 제거 후 H1~H6 + H8 = 7개, 신규 H10 추가 시 H1~H8 재할당). audit 명료성 우선. § 2 매트릭스 표 row 정렬 일관."}
  ],
  "out_of_scope_temptation_mitigations": [
    {"out_of_scope_id": "#1 (정의 본문 갱신)", "temptation_phase": "phase-2", "mitigation": "DESIGN.decisions[3] (§ 3.5 list = metadata, body ≠) 명시. phase-2.affected_files 화이트리스트 = projects/meta/ARCHITECTURE.md (5 line edits), § 3.1 / § 3.2 / § 3.3 본문 수정 0."},
    {"out_of_scope_id": "#3 (CHANGELOG.md 갱신)", "temptation_phase": "phase-1 (AGENTS Status 일반화 시)", "mitigation": "phase-1.affected_files 화이트리스트 = AGENTS.md / README.md / projects/meta/CLAUDE.md (CHANGELOG.md 부재). next_candidates 에 v1.5_legacy-narrative-cleanup 등록."},
    {"out_of_scope_id": "#5 (hook / settings 변경)", "temptation_phase": "phase-2 (cascade 시 post-report-write.sh L2 stale 주석 유혹)", "mitigation": "phase-2.affected_files 화이트리스트 = docs/ARCHITECTURE.md / ROADMAP.md / projects/meta/ARCHITECTURE.md (claude/hooks/* 부재). next_candidates 에 v1.5_legacy-narrative-cleanup 등록."}
  ],
  "five_element_mapping_verification": {
    "primary": "Context",
    "primary_rationale_confirmed": "scope contract agent 검증 — manual injection 컨벤션의 약점 (host 4곳 cross-ref 부재) 보강. lazy load (projects/meta/CLAUDE.md) + 영문 host (AGENTS / README) + GUARDRAILS 진입 시 정의 host 인지 가능. 적절.",
    "secondary": "Trace",
    "secondary_rationale_confirmed": "GUARDRAILS rewrite + docs/ARCH 폐기 = git history 영속, primary Trace 메커니즘 (milestones/v{X.Y}_*/execute/phase-{n}.md + REPORT.md) 자체 변경 0. 부수 분류 적절.",
    "secondary_reclassification_considered": "GUARDRAILS rewrite 가 PLAN→DESIGN→EXECUTE→VERIFY→REPORT narrative 강제 source 로 재정의 시 'Constraint' 정전 보강 으로 변경 가능 (신규 H10 DESIGN.approval gate 가 Constraint 의 (b) 메커니즘 정전화). 단 본 milestone 의 1차 의도 = Context (cross-ref 전파), Constraint 는 GUARDRAILS rewrite 부수 효과. secondary = Trace 유지, Constraint 부수 (tertiary) 분류 가능하나 § 3.6 평가 절차 = 'PLAN.motivation 또는 DESIGN.decisions 에 명시' = primary + secondary 충분."
  },
  "approval": {
    "approved_by": "user",
    "date": "2026-05-09",
    "approval_pending_user_review": false,
    "user_review_summary": "13 결정 + 13 risk_mitigation + 3 out_of_scope_temptation_mitigations + 5_element_mapping verification. 4 관점 subagent 검토 (architecture / spec-drift / 회귀 risk / scope contract) 결과 사용자 결정 4건 모두 반영 (phase 순서 / cross-ref 위치 / successors 버전 / GUARDRAILS H/C fate). EXECUTE 진입은 사용자 명시 approval 후."
  }
}
```

## 종합 narrative

DESIGN 단계 핵심 결정 13건이 4 관점 subagent 검토 + 사용자 의문 round (5건) + 사용자 4건 결정 의 통합 산출. PLAN.deferred_to_design 5건 모두 결정 완료 (phase 분할 / cross-ref 형식 / GUARDRAILS scope / cascade list / Status 문구). architecture agent 권고 (phase 순서) + spec-drift agent 권고 (cross-ref 위치 standalone + GUARDRAILS H/C 항목 별 fate) + scope contract agent 권고 (successors v1.4_* 유지 + SC#5 grep boundary) + 회귀 risk agent 권고 (baseline CI status + markdownlint) 모두 결정에 반영.

## 5요소 매핑 (정의 § 3.6 의무)

`five_element_mapping_verification` 키 명시. primary = Context 정전 보강 (manual injection 컨벤션 약점 — host 4곳 cross-ref 부재 — 보강), secondary = Trace 부수 (git history 영속, primary Trace 메커니즘 자체 변경 0). Constraint 부수 효과 (GUARDRAILS 신규 H10 DESIGN.approval gate) 도 식별되었으나 1차 의도 외, narrative 안에 거명만.

## EXECUTE 진입 게이트

`approval.approved_by: "user"` + `approval.date: YYYY-MM-DD` 갱신 시까지 phase-1 commit 진입 금지. 사용자 명시 approval 의무.
