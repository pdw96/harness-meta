# PROPOSE — v3.1_workflow-policy-fine-tuning

```json
{
  "next_candidates": [
    {
      "id": "v3.2_workflow-stage-narrative-strengthening",
      "title": "claude/commands/harness-meta.md Stage F 절차 narrative 강화 — milestones.md 선결 의무 + INTENT~APPROVE commit 시점 명문화",
      "trigger": "C_improvement",
      "trigger_type": "lessons_learned (v3.1 L2 + L6)",
      "summary": "v3.1 lessons L2 (milestones.md 선결 의무, R1 CRITICAL) + L6 (INTENT~APPROVE commit 시점) 직접 후속. claude/commands/harness-meta.md Stage F 절차 narrative 강화 — (1) EXECUTE phase-1 첫 항목 = milestones.md 즉시 작성 의무 (detect_era 9-stage-bundled 인식 보장) (2) INTENT~APPROVE commit 시점 옵션 (a) phase-1 commit 안 포함 / (b) Stage G commit 안 포함 / (c) 별 'Stage B-E' commit 명문화. v3.0 D7 패턴 + v3.1 R1 mitigation 패턴 일관."
    },
    {
      "id": "v3.2_smoke-skeleton-responsibility-separation",
      "title": "tests/CLAUDE.md § 'Skeleton 선택 매트릭스' 책임 분리 row 추가 — era 분류 vs schema 검증",
      "trigger": "C_improvement",
      "trigger_type": "lessons_learned (v3.1 L3)",
      "summary": "v3.1 lessons L3 (smoke detect_era 미호출 D16 의 책임 분리 효과) 직접 후속. tests/CLAUDE.md § 'Skeleton 선택 매트릭스' 안 신규 row 추가 — '책임 분리: era 분류 (detect_era 호출) vs entry schema 검증 (직접 검사)' 명료화. 두 책임 혼재 회피 권고. 향후 신규 smoke 작성 시 책임 분리 의무화."
    },
    {
      "id": "v3.2_controlled-comparison-cp949-narrative",
      "title": "tests/CLAUDE.md § '회귀 검증 절차' controlled 비교 narrative 강화 — cp949 mojibake 정상 작동 + 가독성 trade-off",
      "trigger": "C_improvement",
      "trigger_type": "lessons_learned (v3.1 L5)",
      "summary": "v3.1 lessons L5 (controlled 비교 4-step violation 주입 시 cp949 mojibake 정상 작동) 직접 후속. tests/CLAUDE.md § '회귀 검증 절차' controlled 비교 narrative 안 cp949 mojibake 출력은 errors='replace' 의도된 동작 명문화 + 한글 가독성 우선 시 출력 인코딩 강제 옵션 (bash tests/smoke.sh 2>&1 | iconv -f utf-8 -t cp949) narrative 추가."
    },
    {
      "id": "v3.2_smoke-status-based-validation-branching",
      "title": "tests/CLAUDE.md § 'Skeleton 선택 매트릭스' status 기반 검증 분기 row 추가 — pending vs in_progress/completed",
      "trigger": "B_regression",
      "trigger_type": "lessons_learned (v3.1 L9, post-EXECUTE discovery)",
      "summary": "v3.1 lessons L9 (smoke status 기반 검증 분기, post-EXECUTE discovery) 직접 후속. tests/CLAUDE.md § 'Skeleton 선택 매트릭스' 안 신규 row 추가 — 'status 기반 검증 분기: pending (= 시작 전 / 디렉토리 부재 가능, milestones_path 부재 허용) vs in_progress/completed (= 디렉토리 + milestones_path 의무)' 명료화. 신규 smoke 작성 시 status 인식 의무화."
    }
  ],
  "propose_summary": "v3.1 lessons_learned 후속 candidates 3건 모두 같은 모듈 (claude/commands/ + tests/) + 같은 주제 (workflow narrative 강화) 영향. 분류: 'workflow stage narrative 강화' 의 의미 단위 grouping. v3.1 자체와 같은 bundling trigger 조건 만족 → v3.2 통합 milestone 가능. 또는 단독 milestone N건 분리 (release train 부적합 case). 사용자 결정 (PROPOSE 후 ROADMAP 등록 시).",
  "ROADMAP_operations": [
    "v3.1 entry status: in_progress → completed (본 milestone 완료) — 적용 완료",
    "v3.2 통합 entry 1건 신규 (사용자 결정 2026-05-10, v3.1 패턴 재현 — 같은 모듈 + 같은 주제 의미 단위 grouping). status: pending, trigger: C_improvement, 4 sub-milestone candidates: workflow-stage-narrative-strengthening / smoke-skeleton-responsibility-separation / controlled-comparison-cp949-narrative / smoke-status-based-validation-branching — 적용 완료"
  ]
}
```

## next_candidates 종합

3건 후속 모두 같은 모듈 (claude/commands/ + tests/) + 같은 주제 (workflow narrative 강화) 영향:

1. **workflow stage narrative 강화** (lessons L2 + L6) — claude/commands/harness-meta.md Stage F 절차 narrative 강화 (milestones.md 선결 + INTENT~APPROVE commit 시점)
2. **smoke skeleton 책임 분리** (lessons L3) — tests/CLAUDE.md § 'Skeleton 선택 매트릭스' 책임 분리 row 추가
3. **controlled 비교 cp949 narrative** (lessons L5) — tests/CLAUDE.md § '회귀 검증 절차' controlled 비교 narrative 안 cp949 mojibake 정상 작동 명문화

3건 모두 같은 모듈 (tests/ + claude/commands/) + 같은 주제 (workflow / smoke 작성 narrative 강화) 영향 → **v3.2 통합 milestone (sub-milestone 3건) bundling 가능** (v3.1 패턴 재현, bundling 정책 일상 운용 사례 누적). 또는 단독 milestone N건 분리.

## ROADMAP 갱신 작업

다음 작업 진행 시 사용자 확인:

1. v3.1 entry status: `in_progress` → `completed`
2. next_candidates 3건 ROADMAP entry 신규 등록 (신 schema, status: pending) — 또는 v3.2 통합 entry 1건 (사용자 결정)
3. INTENT/RESEARCH/DESIGN/APPROVE.md untracked 4건 + VERIFY.md / REPORT.md / PROPOSE.md / milestones.md / phase-{1,2,3}.md 갱신 = Stage G+H+I commit (v3.0 패턴 일관)

## push + PR 결정

local commit 3건 (phase-1 / phase-2 / phase-3) + Stage G+H+I commit 예정 (VERIFY/REPORT/PROPOSE 추가). 사용자 확인 후 push:

```bash
git push origin main
# 또는 PR 생성:
gh pr create --title "milestone v3.1_workflow-policy-fine-tuning" --body "..."
```

## 관련

- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 정전 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- INTENT: [`INTENT.md`](INTENT.md)
- VERIFY: [`VERIFY.md`](VERIFY.md) (verdict: pass)
- REPORT: [`REPORT.md`](REPORT.md) (8 lessons_learned)
- ROADMAP: [`../../ROADMAP.md`](../../ROADMAP.md)
