# milestones — v3.10

```json
{
  "version": "v3.10",
  "title": "9-stage stage 영역 침범 narrative 명료화 — INTENT/RESEARCH/DESIGN 부산물 정의 + PROPOSE 흡수 책임",
  "status": "in_progress",
  "sub_milestones": [
    {
      "phase": 1,
      "title": "Stage B/C/D/I 정의 narrative 보강 + ARCHITECTURE § 4 cascade",
      "status": "in_progress",
      "commit": null
    }
  ]
}
```

## 의도 (요약)

v2.0_workflow-word-fidelity 의 "단어 = 단일 책임 1:1 매핑" 원칙 운영 안 영역 침범 3건 정량 확인 (현 세션 진단):

| # | 산출물 | 침범 내용 | 침범 대상 |
|---|--------|----------|----------|
| 1 | `projects/meta/milestones/v3.6/INTENT.md` L19~21 | `out_of_scope` entry 안 "**별 milestone 분리**" 명시 (3건) | PROPOSE 책임 |
| 2 | `projects/meta/milestones/v3.6/DESIGN.md` L65 | phase-3 `scope` = "PROPOSE.md next_candidates 안 ... 발의 narrative" | PROPOSE 책임 |
| 3 | `projects/meta/milestones/v1.4_cross-ref-propagation/RESEARCH.md` | `untouched_files_explicit` 6건 묶음 → v1.5_legacy-narrative-cleanup 직접 발의 | PROPOSE 책임 |

옵션 A 채택 = 자연 부산물로 재해석. 본 milestone 의 실 작업 후보:

- `claude/commands/harness-meta.md` Stage B/C/D 정의 보강 — `out_of_scope` / `untouched_files_explicit` / `decisions[i]` 의 (a) negative scope 명세 vs (b) 후속 발의 의미 분리 narrative 명시
- PROPOSE 단계의 통합 흡수 책임 명문화 — B/C/D 부산물 → PROPOSE.next_candidates 흡수 경로 단일 origin
- 자기참조 부합 (도그푸드) — 본 milestone 자체가 보강된 narrative 첫 적용

상세 의도·success_criteria·out_of_scope·dependencies 는 Stage B `INTENT.md` 작성 시 확정.

## sub_milestone 분할

OPEN 단계 시점에서 정확한 phase 분할 미확정 — Stage D DESIGN 단계에서 `phases[]` 확정 후 `sub_milestones[]` 1:1 동기 갱신 (placeholder title 교체).

## § 6.2 정합성

본 발의 = workflow self-improvement 카테고리 (`claude/commands/harness-meta.md` 변경). `projects/meta/ARCHITECTURE.md` § 6.2 'workflow self-improvement 동결 정책' 적용 대상이나, **A_user trigger** (사용자 명시 발의) 예외 경로 부합. `INTENT.dependencies` 안 § 6.2 예외 경로 narrative 명시 의무.

## 관련

- ROADMAP entry: `projects/meta/ROADMAP.md` `milestones[]` (status: in_progress)
- 직접 선행: `v2.0_workflow-word-fidelity` (원칙 정의), `v3.6_overengineering-audit` (§ 6.2 동결 정책)
- 워크플로우 진입점: `claude/commands/harness-meta.md`
