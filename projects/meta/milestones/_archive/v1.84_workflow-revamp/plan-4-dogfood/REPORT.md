# PLAN-4: dogfood — REPORT

**완료일**: 2026-05-06
**상태**: ✅ 완료 (single phase, plan-3과 통합 commit)

## 최종 결과

- **변경 파일 5개** (plan-3 + plan-4 + milestone REPORT 통합 commit):
  - `tests/smoke-scope-contract.sh` (plan-3 — milestone glob 1행)
  - `milestones/v1.84_workflow-revamp/plan-3-smoke-verify/PLAN.md` (작성)
  - `milestones/v1.84_workflow-revamp/plan-3-smoke-verify/REPORT.md` (작성)
  - `milestones/v1.84_workflow-revamp/plan-4-dogfood/PLAN.md` (작성)
  - `milestones/v1.84_workflow-revamp/plan-4-dogfood/REPORT.md` (작성, 본 파일)
  - `milestones/v1.84_workflow-revamp/REPORT.md` (작성, milestone-level 전체)

## 구현 요약

본 PLAN은 milestone 자기 검증 + Stage E 직전 단계. plan-2 commit 16분+ + smoke-scope-contract 변경 2회 lost 사례에서 사용자 결정으로 plan-3 + plan-4 + milestone REPORT를 **통합 1 commit으로 단순화**.

### 통합 commit 내역

| 변경 | 출처 | 설명 |
|------|------|------|
| `tests/smoke-scope-contract.sh` | plan-3 phase-1 | enumerate glob에 `milestones/v[0-9]*_*/PLAN.md` 1행 추가 |
| `plan-3-smoke-verify/{PLAN,REPORT}.md` | plan-3 | 작업 산출 |
| `plan-4-dogfood/{PLAN,REPORT}.md` | plan-4 | 작업 산출 (본 파일 포함) |
| `milestones/v1.84_workflow-revamp/REPORT.md` | plan-4 | milestone-level 전체 요약 |

### Stage E 진행 (commit 후)

1. smoke 4종 회귀 0 확인 (pre-commit hook 자동 실행)
2. **AskUserQuestion** — `git push` 진입 승인 (사용자 personal CLAUDE.md "커밋·배포 전 확인 요청" 정합)
3. `git push origin claude/upbeat-ptolemy-cda2f1`
4. `gh pr create` + main 머지 (squash 권장)

## 판정

| 성공 기준 | 결과 |
|---------|:----:|
| milestone REPORT.md 작성 | ✅ |
| plan-3 + plan-4 + smoke 통합 commit | ⏳ commit 진행 시 확정 |
| smoke 회귀 0 | ⏳ pre-commit hook 결과 |
| 사용자 push 명시 동의 | ⏳ Stage E |
| main 머지 | ⏳ Stage E |

## Lessons Learned

- **L1 — pre-commit stash race condition**: `[INFO] Stashing unstaged files` + `[INFO] Restored changes` 사이에 다른 process가 변경하면 restore 시점에 conflict 또는 silent lost. 본 milestone에서 ROADMAP / smoke-scope-contract 각 1회 lost (cache patch로 복구). **후속 §3-B `pre-commit-stash-safety`** 또는 stash 회피 전략 (`pre-commit run --all-files` 후 commit 분리) 검토.
- **L2 — phase별 commit 분리의 한계**: 4 PLAN x N phase = 7+ commit이 dogfood 첫 회차에 너무 fine-grained. 사용자 결정으로 plan-3+plan-4 통합 → 5 commit on branch (revert + plan-1 통합 + plan-2 + plan-3+4 통합). 후속 milestone부터는 phase별 commit 가능 (cached hooks).
- **L3 — milestone-summary 정책의 dogfood 검증**: §8에 v1.84 row 1줄만 stamp + 4 PLAN의 phase 상세는 milestone REPORT.md에 보관. ROADMAP 비대화 차단 forward-only 단조 적용 확인.

## 후속 (이 plan + 본 milestone 외)

- §3-B: `pre-commit-stash-safety` (stash race condition 회피, evidence 2건 누적)
- §3-A: `project-workflow-extension` (이미 §3-A 등록)
- §3-B: `smoke-cross-ref-false-positive-fix` (이미 §3-B 등록)

## 관련

- 본 PLAN: [PLAN.md](PLAN.md)
- milestone PLAN: [../PLAN.md](../PLAN.md)
- milestone REPORT: [../REPORT.md](../REPORT.md)
