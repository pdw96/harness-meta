# RESEARCH — v2.0_workflow-word-fidelity

```json
{
  "external": [
    {
      "source": "사용자 의문 round 1~3 (총 13 question)",
      "topic": "단어 의미 부합 정정 scope + 새 stage 명칭 + migration 범위 + stage 카운트 방식",
      "findings": [
        "Round 1 — scope: A안 (4건 전부) / version: v2.0 major bump / migration: git mv 전부 rename",
        "Round 2 — stage 수: 9-stage 까지 허용 / PLAN: rename → INTENT (책임 그대로) / DESIGN: DESIGN(decisions+phase) + APPROVE 분리 / REPORT: REPORT(lessons) + PROPOSE 분리",
        "Round 3 — 카운트: ROADMAP 제외, OPEN~PROPOSE = 9 stage / version: v2.0 / historical migrate: PLAN.md → INTENT.md rename + cascade ref / APPROVE 책임: 5 관점 검토 DESIGN 안 유지, APPROVE 는 gate 만"
      ],
      "drift": "사용자 의도와 PLAN.success_criteria 1:1 매핑 — drift 없음"
    },
    {
      "source": "일반 SE 워크플로우 컨벤션 (Twelve-Factor / GitOps / RUP / Agile / Cynefin)",
      "topic": "stage 이름 = 단일 책임 1:1 매핑 원칙 외부 사례",
      "findings": [
        "GitOps: plan / apply / verify — 단어 자체가 책임 명료 (Terraform 영향)",
        "CI/CD: build / test / deploy / approve / promote — approve 게이트 분리 일반",
        "GitHub deployment: pending_approval gate 별도 entity 분리",
        "Post-mortem: SRE 컨벤션 — 'lessons learned' (backward) 와 'action items' (forward) 분리. action items 는 별 ticket/issue 로 트래킹 (REPORT 안에 inline 등록 안 함)"
      ],
      "drift": "현 7-stage 의 REPORT.next_candidates 는 SRE post-mortem 컨벤션과 어긋남 — PROPOSE 분리가 외부 컨벤션 정합. APPROVE 분리도 CI/CD 패턴 정합."
    },
    {
      "source": "단어 사전적 외연 (Oxford / Webster + 일반 SE 용례)",
      "topic": "MILESTONE / PLAN / DESIGN / REPORT 의 단어 자체 외연 vs 현 7-stage 책임",
      "findings": [
        "MILESTONE: '도달한 표지·이정표' — 컨테이너 생성 작업과 부정합. 현 책임은 'open container' 의미에 부합.",
        "PLAN: 'what + how' 둘 다 포함 (계획). 현 책임 'intent only' 는 INTENT(의도) 단어가 더 정확.",
        "DESIGN: '구조 결정' — decisions/approach 부합. phase 분할 (= 작업 plan) 은 design 외연에 들어갈 수 있으나 (ID/UX 분야에서는 design = phase 분할 포함), approval gate 는 governance 영역으로 design 단어 외연 외.",
        "REPORT: 'backward 종합 보고' — lessons/summary 부합. next_candidates registration (forward action) 은 PROPOSE 단어가 정확."
      ],
      "drift": "MILESTONE 1건 자체 부정합, PLAN 1건 narrowing, DESIGN 1건 hybrid (approval 부분만), REPORT 1건 hybrid (next_candidates 부분만)"
    }
  ],
  "codebase": {
    "affected_files_critical": [
      "claude/commands/harness-meta.md (전면 재작성 — 9-stage 절차 + Stage A~I 매핑)",
      "CLAUDE.md (root, 워크플로우 섹션 매트릭스 갱신)",
      "projects/meta/CLAUDE.md (subdirectory guide)",
      "projects/meta/ARCHITECTURE.md (§ 1 디렉토리 트리 line 20-27 / § 2 line 44 / § 3.3 Workflow row line 64 / § 3.6 line 81 / § 4 7-stage 섹션 line 85-91 / § 6 line 102-104 era 정책)",
      "projects/meta/ROADMAP.md (v2.0 entry 추가 완료 — Stage B 산출물)"
    ],
    "affected_files_single_source_cross_ref": [
      "AGENTS.md (영문 요약, 정의 cross-ref host)",
      "README.md (사용자 진입, 정의 cross-ref host)",
      "GUARDRAILS.md (정전 single source 5곳 중 하나, H 매트릭스 H8 = DESIGN.approval gate → APPROVE.md gate 갱신, § 4 7-stage Scope contract 갱신)"
    ],
    "affected_files_module_guides": [
      "claude/CLAUDE.md (글로벌 레이어 가이드)",
      "tests/CLAUDE.md (smoke 매트릭스, --fix mode 패턴, pre-commit)",
      "bootstrap/skills/CLAUDE.md (글로벌 user-skill 매트릭스)"
    ],
    "affected_files_smoke_hooks": [
      "claude/hooks/post-report-write.sh (PostToolUse hook — REPORT.md 패턴 + inject 메시지 7-stage 거명)",
      "tests/smoke-spec-verification.sh (JSON schema 검증 — PLAN/DESIGN/REPORT/VERIFY 파일 존재 + JSON 코드블록 schema)",
      "tests/smoke-scope-contract.sh (DESIGN.approval 게이트 검증 — APPROVE.md 로 책임 이전)",
      "tests/smoke-posttooluse-hook.sh (hook 동작 검증 — 키워드)",
      "tests/smoke-roadmap-sync.sh (ROADMAP 동기화 검증)",
      "tests/smoke-cross-ref.sh (cross-ref 검증, autofix 가능)",
      "tests/smoke-claude-md-drift.sh (CLAUDE.md drift 검증)",
      ".pre-commit-config.yaml (pre-commit hook 5건 패턴)"
    ],
    "affected_files_historical_migrate": [
      "7-stage era milestone PLAN.md → INTENT.md git mv (11개): v1.0_workflow-redesign / v1.1_design-phases-execute-tracking-automation / v1.1_post-report-write-hook-update / v1.1_meta-as-project / v1.1_smoke-precommit-rewrite / v1.1_agents-md-cleanup / v1.1_readme-cleanup / v1.2_post-report-write-message-rewrite / v1.3_harness-engineering-definition / v1.4_infra-minimization / v1.4_cross-ref-propagation",
      "Historical milestone 본문 cross-ref (PLAN.md 거명) 갱신 — 위 11개 milestone 내부 PLAN/RESEARCH/DESIGN/VERIFY/REPORT/execute/phase-N.md 본문에서 'PLAN.md' 거명 시 'INTENT.md' 로 rewrite",
      "4-tier era milestone (v1.84~v1.88, 5개 + sub-plan-N/PLAN.md): rename 제외 — 4-tier 시대 'PLAN.md' 는 다른 책임 (어셈블 plan 단위), era 보존 정책 적용. ARCHITECTURE.md § 6 era 정책에서 명문화."
    ],
    "affected_files_cascade_minor": [
      "CHANGELOG.md (v1.x 시리즈 표기에 7-stage 거명 시 갱신)",
      "docs/adr/ADR-002-session-ownership-rules.md (sessions/ era + PLAN 거명)",
      "docs/adr/ADR-006-workflow-revamp.md (7-stage 거명 — workflow revamp ADR 자체이므로 9-stage transition ADR 추가 또는 본문 갱신)",
      "projects/upbit/ARCHITECTURE.md (PLAN.md 거명 검토)",
      "projects/upbit/ROADMAP.md (7-stage 거명 검토)",
      ".markdownlintignore (PLAN.md 패턴 거명 검토)",
      "bootstrap/skills/audit/harness-roadmap-update/SKILL.md (이미 deprecated, 7-stage 거명 검토)",
      "bootstrap/skills/audit/harness-plan-verify/SKILL.md (이미 deprecated 추정)",
      "bootstrap/skills/dev-tools/mindvault/SKILL.md (PLAN.md 거명 검토)"
    ],
    "untouched_files_explicit": [
      "v1.84~v1.88 historical 4-tier milestone 디렉토리 — era 보존 정책",
      "execute/phase-{n}.md 파일명 — 변경 부재 (EXECUTE stage 명칭 유지)",
      "VERIFY.md / RESEARCH.md 파일명 — 변경 부재 (단어 부합)",
      "ROADMAP의 milestones[] 배열 항목명 — Q3 결정에 따라 유지"
    ],
    "current_state": "7-stage workflow (ROADMAP → MILESTONE → PLAN → RESEARCH → DESIGN → EXECUTE → VERIFY → REPORT). 산출 파일 5종 (PLAN/RESEARCH/DESIGN/VERIFY/REPORT.md) + execute/phase-{n}.md. ARCHITECTURE.md § 3 단일 source.",
    "target_state": "9-stage workflow (OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE) + ROADMAP 입력 source. 산출 파일 7종 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE.md) + execute/phase-{n}.md. ARCHITECTURE.md § 3 + § 4 갱신, era 정책 명문화 (4-tier / 7-stage / 9-stage 3 era)."
  },
  "options": [
    {
      "id": "O1",
      "topic": "v1.x pending milestone 4건 (v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_legacy-narrative-cleanup / v1.5_research-cascade-grep-discipline) 처리",
      "alternatives": [
        {
          "name": "A — out_of_scope 유지 + 별도 의문 round",
          "pros": "본 milestone scope 폭증 회피, 토큰 효율",
          "cons": "v2.0 완료 후 v1.x 명명에 9-stage workflow 적용 어색"
        },
        {
          "name": "B — v1.x → v2.x renumber 별 milestone",
          "pros": "era 명명 vs workflow 일치",
          "cons": "별 milestone 1건 추가, 의존성 생김"
        },
        {
          "name": "C — 본 milestone 안에서 v1.x → v2.x renumber",
          "pros": "한 번에 정리",
          "cons": "scope 폭증, 본 milestone 책임 외연 어긋남"
        }
      ]
    },
    {
      "id": "O2",
      "topic": "era 구분 메커니즘 (4-tier vs 7-stage vs 9-stage)",
      "alternatives": [
        {
          "name": "A — ARCHITECTURE.md § 6 era 정책 명문화 (3 era 매트릭스)",
          "pros": "narrative 1차 source, 자동화 의존 최소화",
          "cons": "smoke 가 era 자동 식별 안 함 — 수동 점검 필요"
        },
        {
          "name": "B — smoke 가 milestone 디렉토리 era 자동 식별 + 검증 차별화",
          "pros": "회귀 자동 차단",
          "cons": "smoke 인프라 추가 — narrative 보조 원칙에 추가 부담"
        },
        {
          "name": "C — A + B 혼합 (narrative 1차 + smoke 최소 보조)",
          "pros": "narrative 정합 + 자동 회귀 차단",
          "cons": "smoke 1건 추가 — 토큰 비용"
        }
      ]
    },
    {
      "id": "O3",
      "topic": "APPROVE.md JSON schema 형식",
      "alternatives": [
        {
          "name": "A — 단순 (approved_by / date / approval_summary)",
          "pros": "최소, 기존 DESIGN.approval 필드 직접 이전",
          "cons": "검토 결과 trace 부재 (5 관점 검토는 DESIGN 안에 있음 — APPROVE 는 단순 gate 만)"
        },
        {
          "name": "B — 검토 결과 요약 포함 (review_summary / approval / date)",
          "pros": "approval 근거 명시",
          "cons": "DESIGN 본문과 중복 risk"
        }
      ]
    },
    {
      "id": "O4",
      "topic": "PROPOSE.md JSON schema 형식",
      "alternatives": [
        {
          "name": "A — next_candidates list (id/title/trigger/trigger_type) + ROADMAP 등록 명시",
          "pros": "현 REPORT.next_candidates 그대로 이전",
          "cons": "REPORT 와 책임 분리 명시 필요 — REPORT 는 lessons 만"
        },
        {
          "name": "B — A + propose_summary (narrative)",
          "pros": "추론 근거 명시",
          "cons": "REPORT.lessons 와 중복 risk"
        }
      ]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "risk": "v1.x pending milestone 4건과 9-stage workflow 명명 conflict (v1.5 명명에 9-stage 적용 시 era 혼동)",
      "severity": "high",
      "mitigation_candidate": "O1 결정 — out_of_scope 유지 (D안)"
    },
    {
      "id": "R2",
      "risk": "Historical PLAN.md → INTENT.md rename 시 본문 cross-ref 누락",
      "severity": "medium",
      "mitigation_candidate": "phase 분할에서 git mv 직후 grep 'PLAN.md' 잔존 0 검증 + 본문 cross-ref 명시 단계 추가"
    },
    {
      "id": "R3",
      "risk": "claude/commands/harness-meta.md 전면 재작성 — Stage E 5 관점 검토 trigger 등 세부 누락",
      "severity": "medium",
      "mitigation_candidate": "DESIGN.phases 의 commands 재작성 phase 에서 현 7-stage 의 모든 절차 1:1 매핑 + 9-stage 추가 stage 명시"
    },
    {
      "id": "R4",
      "risk": "smoke / hook 패턴 변경 — 기존 활성 5 hook 회귀",
      "severity": "high",
      "mitigation_candidate": "phase 단위 commit 시 pre-commit smoke 5 hook 모두 PASS 확인. 실패 시 즉시 fix forward."
    },
    {
      "id": "R5",
      "risk": "ARCHITECTURE.md § 3 단일 source 변경 → cascade host 5곳 (CLAUDE.md / AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md) cross-ref drift",
      "severity": "medium",
      "mitigation_candidate": "v1.4_cross-ref-propagation 의 cascade RESEARCH 패턴 재사용 — 5곳 grep 본문 중복 부재 직접 검증"
    },
    {
      "id": "R6",
      "risk": "MEMORY.md (사용자 메모리) 의 v1.75 / v1.88 / 7-stage 거명 — 본 milestone 후 stale 가능성",
      "severity": "low",
      "mitigation_candidate": "Stage F 마지막 phase 에서 사용자 확인 후 MEMORY.md 검토 (7-stage 거명 → 9-stage 갱신 또는 era 표기 추가)"
    },
    {
      "id": "R7",
      "risk": "본 milestone 자체가 7-stage 포맷으로 진행되므로 PLAN.md / DESIGN.md / REPORT.md 파일명 사용 — 본 milestone 완료 후에도 그 파일명 유지 (er a 표지)",
      "severity": "low",
      "mitigation_candidate": "ARCHITECTURE.md § 6 era 정책 명문화 — 'v2.0_workflow-word-fidelity 자체는 7-stage 포맷, 자기참조 회피, v2.1+ 부터 9-stage'."
    },
    {
      "id": "R8",
      "risk": "tests/smoke-scope-contract.sh 가 'DESIGN.approval' 키워드 검증 — APPROVE.md 로 이전 후 smoke 가 검증할 새 위치 (APPROVE.md 의 approved_by) 갱신 누락",
      "severity": "high",
      "mitigation_candidate": "DESIGN.phases 의 smoke 갱신 phase 에서 1:1 매핑 명시"
    },
    {
      "id": "R9",
      "risk": "9-stage 가 7-stage 보다 길어져 사용자 muscle memory 영향 — 슬래시 커맨드 사용성 저하",
      "severity": "low",
      "mitigation_candidate": "Stage 영문자 (A~I) 매핑 명확화. 절차 narrative 에 stage 별 책임 1줄 명시 (slash command 본문)."
    }
  ]
}
```

## 의도 (narrative)

본 RESEARCH 는 cascade 영향 범위 정확 enumerate (총 30+ 파일 영향) + 4 옵션 raw 분석 + 9 risk identify. 결정은 DESIGN.decisions 로 미룸.

핵심 발견:

- **affected_files 분류 5 카테고리**: critical (5) / single-source cross-ref (3) / module guides (3) / smoke+hooks (8) / historical migrate (11) / cascade minor (9). 총 30+ 파일.
- **historical migrate 정밀화**: 7-stage era 11개 milestone 만 PLAN.md → INTENT.md rename. 4-tier era (v1.84~v1.88) 는 era 보존 정책 — rename 제외.
- **R1 (v1.x pending 4건)** 가 가장 큰 미해결 risk — 본 milestone scope 외 결정 필요.
- **R8 (smoke-scope-contract.sh)** 가 가장 직접적 회귀 risk — DESIGN 에서 1:1 매핑 명시 의무.

## 관련

- PLAN: [`PLAN.md`](PLAN.md)
- 정의 (cascade target): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3 + § 4
- 슬래시 커맨드 (전면 재작성 target): [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md)
