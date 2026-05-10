# PLAN — v2.0_workflow-word-fidelity

워크플로우 stage 단어 의미 부합 정정 — 7-stage → 9-stage 재명명·재분리.

```json
{
  "id": "v2.0_workflow-word-fidelity",
  "title": "워크플로우 stage 단어 의미 부합 정정 — 7-stage → 9-stage (OPEN/INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE)",
  "goal": "현 7-stage workflow의 4건 단어 미스매치 (MILESTONE 단어-책임 부정합 / PLAN 'intent only' narrowing / DESIGN 3 책임 혼재 / REPORT backward+forward 혼재) 전면 정정. 단어 = 단일 책임 1:1 매핑 원칙 관철. 새 9-stage = OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE (ROADMAP 은 입력 source).",
  "motivation": [
    "하네스 정의 (projects/meta/ARCHITECTURE.md § 3) 5요소 매트릭스 'Workflow' 행 정전화 — stage 이름이 그 자체로 책임을 표현해야 신규 발의 시 5요소 분류 신뢰도 + 외부 사용자 진입 장벽 ↓.",
    "MILESTONE 은 '이정표(달성 표지)' 의미인데 현 책임은 '컨테이너 디렉토리 생성' = 부정합. 또한 ROADMAP 의 milestones[] 항목과 단어 충돌 (같은 단어 두 layer 다른 의미).",
    "PLAN 은 일반적 외연 'what + how' 인데 현 책임은 'intent only' 로 narrow — 단어 외연과 어긋남.",
    "DESIGN 은 '설계(구조 결정)' 인데 현 책임은 decisions + phase 분할 + approval gate 3 혼재 — 단어 본의 ⊂ 현 책임.",
    "REPORT 는 'backward 종합' 인데 현 책임은 lessons (backward) + next_candidates registration (forward) 혼재."
  ],
  "success_criteria": [
    "projects/meta/ARCHITECTURE.md § 3 Workflow 매트릭스 행이 9-stage 명칭 + 1:1 단어-책임 매핑으로 갱신됨 (구 7-stage 거명 부재).",
    "claude/commands/harness-meta.md 가 9-stage workflow + Stage A~I 매핑 + 절차로 전면 재작성됨 (Stage A=OPEN, B=INTENT, C=RESEARCH, D=DESIGN, E=APPROVE, F=EXECUTE, G=VERIFY, H=REPORT, I=PROPOSE).",
    "단일 source 5곳 (root CLAUDE.md / projects/meta/CLAUDE.md / AGENTS.md / README.md / GUARDRAILS.md) cross-ref + 본문 거명 갱신 (구 7-stage 잔존 부재).",
    "모듈 가이드 4곳 (claude/CLAUDE.md / tests/CLAUDE.md / bootstrap/skills/CLAUDE.md / projects/meta/CLAUDE.md) 9-stage 정합 갱신.",
    "tests/smoke-* 와 claude/hooks/post-report-write.sh 가 새 파일명 패턴 (INTENT.md / APPROVE.md / PROPOSE.md) 검증·인지.",
    "Historical milestone 의 PLAN.md → INTENT.md git mv rename 완료 + 본문 cross-ref (PLAN.md 거명) 갱신. APPROVE.md / PROPOSE.md 는 historical 부재 (7-stage 시대 era 구분).",
    "era 구분 메커니즘 (smoke 또는 정책 명문화) 으로 historical (7-stage, APPROVE/PROPOSE 부재 허용) vs 신규 (9-stage, APPROVE/PROPOSE 의무) 회귀 차단.",
    "본 milestone 자체 산출물 (PLAN/RESEARCH/DESIGN/VERIFY/REPORT) 은 7-stage 포맷으로 작성 — 9-stage 는 본 milestone 완료 다음 milestone 부터 적용 (자기 참조 회피).",
    "pre-commit smoke 5 hook 모두 PASS, 기존 smoke 회귀 0.",
    "ROADMAP 의 v2.0 status: completed + push.",
    "MEMORY.md (사용자 메모리) 의 7-stage 거명 또는 stage 이름 거명 검토 — 잔존 시 사용자 확인 후 갱신."
  ],
  "out_of_scope": [
    "v1.4_design-review-trace (Stage E 5 관점 검토 raw 출력 보존) — 별 milestone.",
    "v1.4_hook-narrative-separation (post-report-write.sh inject 메시지 MD 분리) — 별 milestone.",
    "v1.5_legacy-narrative-cleanup (sessions/ stale + 4-tier narrative 정리) — 별 milestone (단 본 milestone 의 stage 이름 cascade 시 일부 자연 정리 가능 시점 도달하면 별 milestone 의 잔여 scope 협의).",
    "v1.5_research-cascade-grep-discipline (cascade grep 패턴 강화) — 별 milestone.",
    "ROADMAP 의 milestones[] 배열 항목명 변경 (entries 등) — Q3 결정: stage MILESTONE 만 OPEN 으로 변경, 항목명 유지.",
    "DESIGN 안 5 관점 검토 책임의 APPROVE 이전 — Q4 결정: DESIGN 안 유지, APPROVE 는 순수 사용자 승인 gate.",
    "PLAN 책임 확장 (phase·file·commit 포함) — Q2 round-2 결정: rename 만 (책임 유지)."
  ],
  "dependencies": {
    "blocks": [
      "(후행) 모든 신규 milestone — v2.0 완료 후 9-stage workflow 적용 의무"
    ],
    "blocked_by": [
      "v1.3_harness-engineering-definition (5요소 매트릭스 정의 — 본 milestone 이 'Workflow' 행 갱신)",
      "v1.4_cross-ref-propagation (단일 source 5곳 cross-ref 메커니즘 확립 — 본 milestone 이 그 cross-ref 갱신)"
    ]
  }
}
```

## 의도 (narrative)

본 milestone 은 사전 의문 round 3회 (총 13 question 사용자 결정) 후 진입. 결정 트레이스:

- **Round 1 (scope)**: A안 — 4건 전부 정정. B안 (MILESTONE 1건만) 또는 C안 (MILESTONE+REPORT 2건) 보다 ambitious.
- **Round 1 (versioning)**: v2.0 major bump (breaking change 명시).
- **Round 1 (migration)**: git mv 전부 rename + cascade ref 갱신.
- **Round 2 (stage 수)**: 9-stage 까지 허용 (단어 = 단일 책임 원칙).
- **Round 2 (PLAN)**: rename → INTENT (책임 그대로).
- **Round 2 (DESIGN)**: DESIGN(decisions+phase) + APPROVE 분리.
- **Round 2 (REPORT)**: REPORT(lessons) + PROPOSE 분리.
- **Round 3 (stage 카운트)**: ROADMAP 제외 — OPEN~PROPOSE = 9 stage.
- **Round 3 (APPROVE 책임)**: DESIGN 안 5 관점 검토 유지 + APPROVE 는 gate 만.

본 PLAN.md 는 의도만 — phase 분할 / 파일별 변경 detail / commit 메시지 / cascade 영향 enumerate 는 RESEARCH.md 와 DESIGN.md 로 미룸.

## 자기 참조 회피 정책

본 milestone 자체는 **현 7-stage workflow** 로 진행 — 산출물 (PLAN.md/RESEARCH.md/DESIGN.md/VERIFY.md/REPORT.md) 은 7-stage 포맷. 9-stage 는 본 milestone 의 산출물이므로 진행 중에는 적용 불가 (chicken-and-egg). 새 9-stage 는 다음 milestone 부터 의무 적용.

## 관련

- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 정의 (정전 single source): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3
- ROADMAP: [`../../ROADMAP.md`](../../ROADMAP.md)
- 슬래시 커맨드 정의: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md)
