# PLAN-4: dogfood — milestone REPORT.md + Stage E push/머지

milestone PLAN ([../PLAN.md](../PLAN.md))의 마지막 PLAN. 전체 milestone 자기 검증 + Stage E.

## 목표

- `milestones/v1.84_workflow-revamp/REPORT.md` 작성 (milestone-level 전체 요약)
- 본 plan-4 PLAN+REPORT 작성
- smoke 회귀 검증 (4종 PASS 확인)
- Stage E 푸시 + 사용자 확인 후 main 머지

## Phase 매트릭스 (단순화 — single phase)

| Phase | 변경 파일 | Commit |
|:-:|---------|--------|
| 1 | `milestones/v1.84_workflow-revamp/REPORT.md` (milestone-level 전체) + plan-4 PLAN+REPORT + plan-3 PLAN+REPORT + smoke-scope-contract glob 1행 (단순화 통합) | `docs(meta): v1.84 plan-3+plan-4 통합 + milestone REPORT.md (Stage E 직전)` |

## 단순화 사유

사용자 결정 (2026-05-06): plan-2 commit 16분+ 진행 + smoke-scope-contract.sh 변경 lost (pre-commit stash race condition 2회차) → plan-3+plan-4+milestone REPORT 통합 1 commit으로 단순화. dogfood 의의 일부 약화 수용 (commit 매트릭스 retro 갱신).

## Stage E 절차

1. milestone REPORT.md 작성 완료 + plan-3+plan-4 통합 commit
2. smoke 4종 회귀 0 확인 (`pre-commit run --all-files` 또는 개별 smoke)
3. **AskUserQuestion** — push 진입 승인 (사용자 확인 의무)
4. `git push origin claude/upbeat-ptolemy-cda2f1` (사용자 명시 동의 후)
5. PR 생성 (`gh pr create`) + main 머지 (squash) — 사용자 결정

## 의존성

- 선행: plan-1, plan-2, plan-3 모두 완료 (working tree에 plan-3/smoke 변경 보존)
- 후행: 없음 (milestone 종료)

## 성공 기준

- [ ] milestone REPORT.md 전체 요약
- [ ] plan-3 + plan-4 + smoke + milestone REPORT 통합 commit
- [ ] smoke 4종 회귀 0
- [ ] 사용자 push 명시 동의
- [ ] main 머지 완료 (Stage E)
