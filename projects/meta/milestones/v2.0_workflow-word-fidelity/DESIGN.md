# DESIGN — v2.0_workflow-word-fidelity

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "9-stage workflow 도입: OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE (ROADMAP 은 입력 source, stage 카운트 제외)",
      "rationale": "단어 = 단일 책임 1:1 매핑 원칙. 사용자 의문 round 2~3 결정 (10 단어 → 9 stage 카운트 = ROADMAP 제외)",
      "alternatives_rejected": [
        "10-stage (ROADMAP 포함) — 7-stage 명명 정체성 완전 변경",
        "9-stage (REPORT+PROPOSE 묶음) — PROPOSE 단일 책임 흐림",
        "7-stage 유지 + rename 만 — 책임 분리 회피"
      ]
    },
    {
      "id": "D2",
      "decision": "MILESTONE → OPEN rename (stage 만, ROADMAP milestones[] 항목명 유지)",
      "rationale": "MILESTONE 단어 자체 부정합 (이정표 ≠ 컨테이너 생성). OPEN = '컨테이너 열기' 명료. ROADMAP 의 milestones[] 항목은 '이정표' 의미로 적절하므로 유지 (Q3 결정).",
      "alternatives_rejected": ["INIT", "SCAFFOLD", "OPEN_MILESTONE", "milestones[] → entries[] 항목명 동시 변경"]
    },
    {
      "id": "D3",
      "decision": "PLAN → INTENT rename (책임 그대로 — intent only)",
      "rationale": "PLAN 외연 'what + how' vs 현 'intent only' 부정합. INTENT = '의도' 정확. 책임 변동 없음 (Q2 round 2 결정).",
      "alternatives_rejected": ["PLAN 유지 + 책임 확장 (phase·file·commit 포함)", "PLAN 유지 + ARCHITECTURE 명문화"]
    },
    {
      "id": "D4",
      "decision": "DESIGN 책임 = decisions + approach + phases + risk_mitigation 유지 (현 7-stage 와 동일). 5 관점 검토는 DESIGN 안 유지.",
      "rationale": "phase 분할은 design 외연 (UX/시스템 design 분야 phase 분할 일반). 5 관점 검토 = design 품질 검증 → DESIGN 책임. APPROVE 는 순수 gate (Q4 round 3 결정).",
      "alternatives_rejected": ["phase 분할을 INTENT 로 이동 (Q2 round 2 거부)", "DECIDE+APPROVE 분리"]
    },
    {
      "id": "D5",
      "decision": "APPROVE 신규 stage = 사용자 명시 승인 gate. 산출 APPROVE.md (approved_by / date / approval_summary).",
      "rationale": "approval gate 는 governance 영역, design 외연 외. 분리 시 단어 = 책임 1:1. CI/CD 'approve' 패턴 정합 (RESEARCH external#2).",
      "alternatives_rejected": [
        "DESIGN 안 sub-step 명문화 (book-keeping 만, 분리 효과 약함)",
        "5 관점 검토도 APPROVE 로 이동 (approval gate 단일 책임 흐림)"
      ]
    },
    {
      "id": "D6",
      "decision": "REPORT 책임 = summary + delta + lessons_learned (backward only). next_candidates 책임은 PROPOSE 로 분리.",
      "rationale": "REPORT = backward 종합 단어 부합. next_candidates = forward action → PROPOSE 단어 정확. SRE post-mortem 컨벤션 정합 (RESEARCH external#2).",
      "alternatives_rejected": [
        "REPORT 유지 + sub-step 명문화",
        "next_candidates 자체 제거 (사용자 수동 ROADMAP 등록 — workflow 정합 약화)"
      ]
    },
    {
      "id": "D7",
      "decision": "PROPOSE 신규 stage = next_candidates ROADMAP 등록. 산출 PROPOSE.md (next_candidates list — id/title/trigger/trigger_type).",
      "rationale": "forward-looking 단일 책임. ROADMAP 등록은 PROPOSE 안에서 actual operation. (RESEARCH option O4 A안)",
      "alternatives_rejected": ["A + propose_summary narrative (REPORT.lessons 와 중복)"]
    },
    {
      "id": "D8",
      "decision": "Historical migrate scope = 7-stage era 11개 milestone 의 PLAN.md → INTENT.md git mv + 본문 cross-ref 갱신. 4-tier era (v1.84~v1.88) 는 rename 제외.",
      "rationale": "4-tier era 의 PLAN.md 는 다른 책임 (어셈블 plan 단위). era 보존 정책 일관 (Q4 round 1 결정 + RESEARCH codebase historical_migrate).",
      "alternatives_rejected": [
        "전체 historical (4-tier 포함) rename — era 책임 차이 무시",
        "rename 회피 — Q4 round 1 결정 위반"
      ]
    },
    {
      "id": "D9",
      "decision": "Historical milestone 에 APPROVE.md / PROPOSE.md placeholder 부재 — 7-stage era 식별 표지로 사용",
      "rationale": "Historical 은 7-stage 시대 산출. APPROVE/PROPOSE 부재가 era 식별 자연스러움. 사용자 Q4 round 1 결정.",
      "alternatives_rejected": ["빈 placeholder 추가 (era 식별 손실)"]
    },
    {
      "id": "D10",
      "decision": "era 구분 메커니즘 = ARCHITECTURE.md § 6 era 정책 명문화 (4-tier / 7-stage / 9-stage 3 era) + smoke 최소 보조 — smoke-spec-verification 가 milestone 디렉토리 안 'APPROVE.md AND PROPOSE.md 동시 부재' 시 7-stage era 로 분류, INTENT.md 부재 + PLAN.md 존재 시 7-stage era, INTENT/APPROVE/PROPOSE 모두 존재 시 9-stage era. era 분기 후 schema 차별화 검증 (7-stage = PLAN/RESEARCH/DESIGN/VERIFY/REPORT 5종, 9-stage = INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE 7종)",
      "rationale": "narrative 1차 source + smoke 보조 (RESEARCH option O2 C안). 자동화는 narrative 보조 원칙 (ARCHITECTURE.md § 3.1). era marker 는 별도 파일 부재 — 산출 파일명 자체로 era 자동 추론 (단순 + drift 회피).",
      "alternatives_rejected": ["narrative 만 (smoke 회귀 차단 부재)", "smoke 만 (narrative 정전 약화)", "era marker file 추가 (.era 등 — 산출물 외 인프라 추가, ARCHITECTURE § 3.1 'narrative 1차' 약화)"]
    },
    {
      "id": "D11",
      "decision": "v1.x pending milestone 4건 (v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_legacy-narrative-cleanup / v1.5_research-cascade-grep-discipline) 은 본 v2.0 의 out_of_scope. 사후 별 milestone 으로 처리.",
      "rationale": "사용자 R1 결정 (A안). 본 milestone scope 폭증 회피 + 토큰 효율.",
      "alternatives_rejected": ["B (사후 v2.x renumber 별 milestone)", "C (본 v2.0 안 renumber)"]
    },
    {
      "id": "D12",
      "decision": "본 milestone 자체는 7-stage 포맷으로 진행 (자기참조 회피). 산출 파일명 PLAN.md / DESIGN.md / REPORT.md 유지. 9-stage 는 v2.1+ 부터 의무 적용.",
      "rationale": "9-stage 는 본 milestone 의 산출물 — 진행 중 적용 시 chicken-and-egg. ARCHITECTURE.md § 6 era 정책 명문화 (R7 mitigation).",
      "alternatives_rejected": ["진행 중 일부 9-stage 적용 (혼동 risk)"]
    },
    {
      "id": "D13",
      "decision": "Stage 영문자 매핑: A=OPEN / B=INTENT / C=RESEARCH / D=DESIGN / E=APPROVE / F=EXECUTE / G=VERIFY / H=REPORT / I=PROPOSE (ROADMAP 은 입력 source, stage 카운트 외)",
      "rationale": "9 stage = A~I 자연 매핑. ROADMAP read 는 OPEN 직전 입력 단계.",
      "alternatives_rejected": ["A=ROADMAP 포함 (10 stage)", "G=VERIFY+REPORT 묶음 (PROPOSE 가 H)"]
    }
  ],
  "approach": "ARCHITECTURE.md § 3 정전 single source 의 Workflow 행 + § 3.3 Constraint/Trace 행 + § 4 7-stage 섹션을 9-stage 로 갱신 (phase 1) → claude/commands/harness-meta.md 전면 재작성 (phase 2) → 단일 source cascade 5곳 + 모듈 가이드 3곳 갱신 (phase 3) → smoke + hooks 패턴 갱신 (phase 4) → historical 7-stage era 11개 git mv + 본문 cross-ref (phase 5) → cascade minor + MEMORY.md (phase 6). 본 milestone 자체는 7-stage 포맷, 9-stage 는 v2.1+ 부터 의무. 모든 phase commit 은 pre-commit hook 정상 통과 의무 — `--no-verify` 사용 금지 (R4 mitigation).",
  "phases": [
    {
      "n": 1,
      "title": "정전 single source 정의 갱신 — ARCHITECTURE.md § 3.3 Workflow/Constraint/Trace + § 4 + § 6 era 정책",
      "scope": "projects/meta/ARCHITECTURE.md 의 § 1 디렉토리 트리 (line 20-27) 산출물 표기 — 9-stage 7종 (INTENT/RESEARCH/DESIGN/APPROVE/execute/VERIFY/REPORT/PROPOSE) 으로 enumerate + 각 줄 주석을 9-stage 단어 책임으로 갱신 / § 2 module 책임 line 44 / § 3.3 Workflow row line 64 (9-stage 명칭 + (c) '정전 (v1.0_workflow-redesign + v2.0_workflow-word-fidelity 로 확립)') + § 3.3 Constraint row line 65 (b) 'DESIGN.approval' → 'APPROVE.md.approved_by' 갱신 + § 3.3 Trace row line 67 (b) 'PLAN/RESEARCH/DESIGN/VERIFY/REPORT' enumerate → 'INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE' (7종) 갱신 / § 3.6 line 81 'PLAN.motivation 또는 DESIGN.decisions' → 'INTENT.motivation 또는 DESIGN.decisions' / § 4 7-stage 섹션 (line 85-91) → 9-stage 전면 재작성 / § 6 line 102-104 era 정책 (4-tier / 7-stage / 9-stage 3 era 명문화 — 각 era 의 milestone 식별 키 + 산출물 schema + 본 milestone 자기참조 era 표지 D12 명시). projects/meta/ROADMAP.md 의 v2.0 entry summary 카운트 정정 ('14 milestone' → '11 milestone').",
      "affected_files": [
        "projects/meta/ARCHITECTURE.md",
        "projects/meta/ROADMAP.md (v2.0 entry summary 카운트 정정)",
        "projects/meta/milestones/v2.0_workflow-word-fidelity/execute/phase-1.md"
      ],
      "rationale": "ARCHITECTURE.md § 3 = 정전 single source. 본 phase 가 그 source 갱신 → 후속 phase 의 cascade 의 truth 기준. § 3.3 Workflow 외 Constraint (DESIGN.approval → APPROVE.md.approved_by) + Trace (산출물 enumerate) 행도 cascade 영향 대상 — architecture 검토 critical_issue#3 반영.",
      "risks": ["R5 (cross-ref drift) — 본 phase 자체는 source 갱신 만, cascade 는 phase 3 에서"]
    },
    {
      "n": 2,
      "title": "claude/commands/harness-meta.md 9-stage 전면 재작성",
      "scope": "claude/commands/harness-meta.md 전면 재작성 — 7-stage workflow 표 → 9-stage 표, Stage A~G → A~I 매핑, 절차 (Stage A ROADMAP read + 후보 결정 → Stage A=OPEN ... → Stage I=PROPOSE), 산출 파일명 (PLAN.md → INTENT.md, APPROVE.md / PROPOSE.md 추가), AskUserQuestion trigger 표 갱신, 금지 목록 (4-tier 추가, 7-stage 유지 — 본 milestone 자체 era 보존).",
      "affected_files": [
        "claude/commands/harness-meta.md",
        "projects/meta/milestones/v2.0_workflow-word-fidelity/execute/phase-2.md"
      ],
      "rationale": "사용자 진입 path. 9-stage 절차의 1차 source. Stage E 5 관점 검토 / Stage E APPROVE 게이트 / Stage I PROPOSE 등 신규 절차 명시.",
      "risks": ["R3 (재작성 시 세부 누락) — 현 7-stage 의 모든 절차 1:1 매핑 후 9-stage 추가 stage 명시"]
    },
    {
      "n": 3,
      "title": "단일 source cascade 5곳 + 모듈 가이드 3곳 — root CLAUDE.md / projects/meta/CLAUDE.md / AGENTS.md / README.md / GUARDRAILS.md / claude/CLAUDE.md / tests/CLAUDE.md / bootstrap/skills/CLAUDE.md",
      "scope": "8곳 갱신: (a) root CLAUDE.md 워크플로우 매트릭스 9-stage 표 / (b) projects/meta/CLAUDE.md subdirectory guide 산출물 거명 / (c) AGENTS.md 영문 9-stage 거명 / (d) README.md 9-stage 거명 / (e) GUARDRAILS.md H8 (DESIGN.approval gate) → APPROVE.md gate 갱신 + § 4 Scope contract 9-stage 갱신 / (f) claude/CLAUDE.md 7-stage 거명 / (g) tests/CLAUDE.md 7-stage 거명 + smoke 매트릭스 갱신 / (h) bootstrap/skills/CLAUDE.md 7-stage 거명. 정의 본문 중복 부재 직접 검증 (cascade grep 'PLAN.md|DESIGN.md|REPORT.md|7-stage|MILESTONE' 5곳 host).",
      "affected_files": [
        "CLAUDE.md",
        "projects/meta/CLAUDE.md",
        "AGENTS.md",
        "README.md",
        "GUARDRAILS.md",
        "claude/CLAUDE.md",
        "tests/CLAUDE.md",
        "bootstrap/skills/CLAUDE.md",
        "projects/meta/milestones/v2.0_workflow-word-fidelity/execute/phase-3.md"
      ],
      "rationale": "ARCHITECTURE § 3.5 단일 source 정합 보장. 5곳 host + 모듈 가이드 3곳 모두 9-stage 명명 일치.",
      "risks": ["R5 (cross-ref drift)"]
    },
    {
      "n": 4,
      "title": "smoke + hooks 패턴 갱신 — .pre-commit-config.yaml / smoke 6건 / post-report-write.sh (구체 변경 명시)",
      "scope": "(a) .pre-commit-config.yaml — 활성 5 hook (smoke-projects-scope-discipline / smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift) 패턴 검토, 9-stage 정합 보장. (b) tests/smoke-spec-verification.sh — milestone 디렉토리 안 era 자동 식별 (D10) 추가: APPROVE.md AND PROPOSE.md 동시 부재 + PLAN.md 존재 = 7-stage era → 7-stage schema (PLAN/RESEARCH/DESIGN/VERIFY/REPORT 5종) 검증, INTENT.md 존재 + APPROVE.md 존재 + PROPOSE.md 존재 = 9-stage era → 9-stage schema (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE 7종) 검증, v1.84~v1.88 = 4-tier era → schema 검증 skip. (c) tests/smoke-scope-contract.sh — 'DESIGN.approval' 키워드 검증을 era 분기: 7-stage = DESIGN.approval / 9-stage = APPROVE.md.approved_by + date ISO-8601. (d) tests/smoke-posttooluse-hook.sh — 키워드 갱신 (9-stage 거명). (e) tests/smoke-roadmap-sync.sh + tests/smoke-cross-ref.sh + tests/smoke-claude-md-drift.sh — 9-stage 거명 정합 검토. (f) claude/hooks/post-report-write.sh — file pattern 정규식에 PROPOSE.md 추가, inject 메시지 분기: REPORT.md write 시 'PROPOSE 단계 진행 안내', APPROVE.md write 시 '사용자 명시 승인 후 EXECUTE 진입 안내' (보안 검토 R3 권고), PROPOSE.md write 시 'ROADMAP 등록 확인 안내' (Spec-drift 검토 권고 #2). 본 phase commit 시 pre-commit smoke 5 hook 모두 PASS 의무 검증 (R4 mitigation, --no-verify 금지).",
      "affected_files": [
        ".pre-commit-config.yaml",
        "tests/smoke-spec-verification.sh",
        "tests/smoke-scope-contract.sh",
        "tests/smoke-posttooluse-hook.sh",
        "tests/smoke-roadmap-sync.sh",
        "tests/smoke-cross-ref.sh",
        "tests/smoke-claude-md-drift.sh",
        "claude/hooks/post-report-write.sh",
        "projects/meta/milestones/v2.0_workflow-word-fidelity/execute/phase-4.md"
      ],
      "rationale": "자동 회귀 차단. era 식별 메커니즘 (D10) 의 smoke 보조 부분. R4 + R8 + R10 mitigation. 회귀 risk 검토 fail verdict 의 핵심 정정 — 3 smoke + 1 hook 1:1 매핑 명시.",
      "risks": ["R4 (활성 5 hook 회귀)", "R8 (smoke-scope-contract APPROVE 키워드)", "R10 (post-report-write.sh PROPOSE 패턴 누락)"]
    },
    {
      "n": 5,
      "title": "Historical 7-stage era 11개 milestone PLAN.md → INTENT.md git mv + 본문 cross-ref 갱신",
      "scope": "7-stage era 11개 (v1.0_workflow-redesign / v1.1×6 / v1.2_post-report-write-message-rewrite / v1.3_harness-engineering-definition / v1.4_infra-minimization / v1.4_cross-ref-propagation) 의 PLAN.md → INTENT.md git mv. 각 milestone 디렉토리 내부 본문 (RESEARCH/DESIGN/VERIFY/REPORT/execute/phase-N.md) 의 'PLAN.md' 거명 → 'INTENT.md' 갱신. 본 phase commit 후 grep 'PLAN.md' 잔존 검증 (본 v2.0 milestone PLAN.md 본인만 잔존, 나머지 0).",
      "affected_files": [
        "projects/meta/milestones/v1.0_workflow-redesign/PLAN.md → INTENT.md (+ 디렉토리 내 본문 cross-ref)",
        "projects/meta/milestones/v1.1_design-phases-execute-tracking-automation/PLAN.md → INTENT.md (+ 본문)",
        "projects/meta/milestones/v1.1_post-report-write-hook-update/PLAN.md → INTENT.md (+ 본문)",
        "projects/meta/milestones/v1.1_meta-as-project/PLAN.md → INTENT.md (+ 본문)",
        "projects/meta/milestones/v1.1_smoke-precommit-rewrite/PLAN.md → INTENT.md (+ 본문)",
        "projects/meta/milestones/v1.1_agents-md-cleanup/PLAN.md → INTENT.md (+ 본문)",
        "projects/meta/milestones/v1.1_readme-cleanup/PLAN.md → INTENT.md (+ 본문)",
        "projects/meta/milestones/v1.2_post-report-write-message-rewrite/PLAN.md → INTENT.md (+ 본문)",
        "projects/meta/milestones/v1.3_harness-engineering-definition/PLAN.md → INTENT.md (+ 본문)",
        "projects/meta/milestones/v1.4_infra-minimization/PLAN.md → INTENT.md (+ 본문)",
        "projects/meta/milestones/v1.4_cross-ref-propagation/PLAN.md → INTENT.md (+ 본문)",
        "projects/meta/milestones/v2.0_workflow-word-fidelity/execute/phase-5.md"
      ],
      "rationale": "Historical 7-stage era 식별 표지 강화 (INTENT 명명 = 7-stage era 산출물). 4-tier era (v1.84~v1.88) 는 rename 제외 (D8). git mv 11개 + 본문 cross-ref 갱신을 1 commit 으로 묶어 era migration 단일 revert 단위 보장 (보안 검토 R1 권고).",
      "risks": ["R2 (cross-ref 누락) — phase commit 후 grep 'PLAN.md' 잔존 검증 의무 (본 v2.0 milestone 자체 PLAN.md 본인만 허용)"]
    },
    {
      "n": 6,
      "title": "Cascade minor + MEMORY.md 검토",
      "scope": "CHANGELOG.md (v2.0 entry 추가) / docs/adr/ADR-006-workflow-revamp.md (9-stage transition 후속 ADR 추가 또는 본문 갱신) / docs/adr/ADR-002-session-ownership-rules.md (PLAN 거명 검토) / projects/upbit/ARCHITECTURE.md / projects/upbit/ROADMAP.md / .markdownlintignore / bootstrap/skills/audit/harness-roadmap-update/SKILL.md / bootstrap/skills/audit/harness-plan-verify/SKILL.md / bootstrap/skills/dev-tools/mindvault/SKILL.md. 마지막으로 ~/.claude/projects/.../memory/MEMORY.md (사용자 메모리) 7-stage 거명 검토 — 발견 시 사용자 확인 후 갱신 (R6 mitigation).",
      "affected_files": [
        "CHANGELOG.md",
        "docs/adr/ADR-006-workflow-revamp.md (또는 ADR-007 신규)",
        "docs/adr/ADR-002-session-ownership-rules.md",
        "projects/upbit/ARCHITECTURE.md",
        "projects/upbit/ROADMAP.md",
        ".markdownlintignore",
        "bootstrap/skills/audit/harness-roadmap-update/SKILL.md",
        "bootstrap/skills/audit/harness-plan-verify/SKILL.md",
        "bootstrap/skills/dev-tools/mindvault/SKILL.md",
        "(사용자 확인 후) ~/.claude/projects/C--Users-qkreh-harness-meta/memory/MEMORY.md 또는 신규 memory file",
        "projects/meta/milestones/v2.0_workflow-word-fidelity/execute/phase-6.md"
      ],
      "rationale": "잔존 7-stage 거명 정리 + 사용자 메모리 동기. R6 mitigation. 본 phase 가 Stage F 의 마지막 — phase 6 commit 후 즉시 Stage G (VERIFY + REPORT 작성 + ROADMAP v2.0 status: completed 갱신 + 사용자 확인 후 push) 진입.",
      "risks": ["R6 (MEMORY 동기 누락) — 사용자 확인 게이트 의무, ~/.claude 외부 path 쓰기는 별 commit 분리 (보안 검토 R4 권고)"]
    }
  ],
  "risk_mitigation": [
    {"risk": "R1 (v1.x pending 4건 conflict)", "mitigation": "D11 — out_of_scope, 사후 별 milestone"},
    {"risk": "R2 (PLAN.md → INTENT.md cross-ref 누락)", "mitigation": "phase 5 commit 후 grep 'PLAN.md' 잔존 검증 (본 v2.0 milestone 본인만 허용)"},
    {"risk": "R3 (commands 재작성 세부 누락)", "mitigation": "phase 2 — 현 7-stage 절차 1:1 매핑 표 작성 후 9-stage 추가 stage 명시"},
    {"risk": "R4 (활성 5 hook 회귀)", "mitigation": "phase 4 commit 시 pre-commit 5 hook 전수 PASS 검증"},
    {"risk": "R5 (cross-ref drift)", "mitigation": "phase 3 — 5 host (CLAUDE/AGENTS/README/projects/meta/CLAUDE/GUARDRAILS) cascade grep 본문 중복 부재 직접 검증"},
    {"risk": "R6 (MEMORY 동기 누락)", "mitigation": "phase 6 — 사용자 확인 게이트"},
    {"risk": "R7 (자기참조 era 표지)", "mitigation": "D12 — ARCHITECTURE.md § 6 era 정책 명문화"},
    {"risk": "R8 (smoke-scope-contract APPROVE 키워드)", "mitigation": "phase 4 — 1:1 매핑 명시"},
    {"risk": "R9 (사용자 muscle memory)", "mitigation": "phase 2 — Stage 영문자 (A~I) 매핑 명확화 + 1줄 책임 명시"},
    {"risk": "R10 (post-report-write.sh PROPOSE 패턴 누락 — 회귀 risk 검토 critical)", "mitigation": "phase 4 (f) — file pattern 정규식에 PROPOSE.md 추가 + write 시점 분기 inject 메시지 (REPORT/APPROVE/PROPOSE 각각)"}
  ],
  "approval": {
    "approved_by": "user",
    "date": "2026-05-10",
    "approval_summary": "5 관점 병렬 검토 (architecture / spec-drift / 회귀 risk / 보안 / scope contract) 완료 — 회귀 risk 1 fail + 4 pass-with-comments. DESIGN 정정 8건 반영 (D10 era 자동 식별 구체화 / approach --no-verify 금지 + § 3.3 Constraint·Trace cascade / phase 1 § 3.3 행 cascade + 디렉토리 트리 7종 + ROADMAP 카운트 11 정정 / phase 4 6항목 a~f 구체화 / phase 5 git mv 단일 commit + 본문 cross-ref 묶음 / phase 6 Stage G 진입 명시 + MEMORY 별 commit / R10 추가 / ROADMAP entry 정정) 후 5 관점 모두 pass 재평가. 사용자 명시 승인 — phase 1부터 순차 EXECUTE 진입."
  }
}
```

## 의도 (narrative)

본 DESIGN 은 13 결정 + 6 phase 분할 + 9 risk_mitigation 매핑. 사용자 의문 round 3회 결정 (총 13 question) 의 종합:

- **D1~D7**: 9-stage workflow 채택 + stage 명칭/책임 매핑 (사용자 round 1~2 결정)
- **D8~D9**: Historical migration 정밀화 (D8: 7-stage era 11개만 rename, 4-tier 제외 / D9: APPROVE/PROPOSE 부재 = era 표지)
- **D10**: era 구분 메커니즘 (narrative + smoke 보조)
- **D11**: v1.x pending 4건 out_of_scope (R1 결정)
- **D12**: 자기참조 회피 정책 (R7)
- **D13**: Stage 영문자 (A~I) 매핑

phase 분할 6개 — 의미적 응집도 우선:

1. ARCHITECTURE.md 정의 갱신 (정전 single source)
2. claude/commands/harness-meta.md 재작성 (사용자 진입 path)
3. cascade 8곳 (host 5 + 모듈 3) 갱신
4. smoke + hooks 갱신 (회귀 차단)
5. Historical 11개 git mv + 본문 cross-ref
6. cascade minor + MEMORY 동기

**approval gate**: 5 관점 병렬 검토 (architecture / spec-drift / 회귀 risk / scope contract / 보안) 결과 + 본 DESIGN 종합 → 사용자 명시 승인 후 EXECUTE 진입.

## 관련

- PLAN: [`PLAN.md`](PLAN.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- 정의 (cascade target): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3 + § 4 + § 6
