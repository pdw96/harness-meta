# EXECUTE phase-4 — smoke + hooks 패턴 갱신 (era 자동 식별 + APPROVE/PROPOSE 분기)

```json
{
  "phase": 4,
  "title": "smoke + hooks 패턴 갱신 — .pre-commit-config.yaml / smoke 6건 / post-report-write.sh (구체 변경 명시)",
  "status": "complete",
  "scope_recap": "(a) .pre-commit-config.yaml — 활성 5 hook 정합 / (b) smoke-spec-verification.sh — era 자동 식별 (APPROVE+PROPOSE 동시 부재 = 7-stage / 둘 다 존재 = 9-stage / 4-tier era skip) + 9-stage schema 7종 검증 / (c) smoke-scope-contract.sh — DESIGN.approval → APPROVE.md.approval era 분기 + harness-meta.md 안내 grep 갱신 / (d) smoke-posttooluse-hook.sh — 키워드 9-stage 거명 / (e) smoke-roadmap-sync.sh + smoke-cross-ref.sh + smoke-claude-md-drift.sh — 9-stage 정합 / (f) claude/hooks/post-report-write.sh — file pattern 정규식에 PROPOSE.md / APPROVE.md / INTENT.md 추가, inject 메시지 분기 (REPORT → PROPOSE 안내, APPROVE → EXECUTE 진입 게이트 안내, PROPOSE → ROADMAP 등록 안내). pre-commit 5 hook 모두 PASS 의무.",
  "changes": [
    "tests/smoke-spec-verification.sh — milestone 디렉토리 안 era 자동 식별 (APPROVE+PROPOSE 동시 부재 + PLAN 존재 = 7-stage / INTENT+APPROVE+PROPOSE 모두 존재 = 9-stage / sub-plan 구조 = 4-tier skip). era 분기 후 schema 차별화 검증 (7-stage = PLAN/RESEARCH/DESIGN/VERIFY/REPORT 5종, 9-stage = INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE 7종)",
    "tests/smoke-scope-contract.sh — DESIGN.approval (7-stage) / APPROVE.md.approval (9-stage) era 분기 검증 + harness-meta.md grep 패턴 'approval.approved_by' 유지 (legacy 호환)",
    "tests/smoke-posttooluse-hook.sh — 9-stage 키워드 거명 (PROPOSE.md / APPROVE.md / INTENT.md 패턴 추가)",
    "claude/hooks/post-report-write.sh — file pattern 정규식 (RESEARCH|DESIGN|VERIFY|REPORT|execute/[^/]+|INTENT|APPROVE|PROPOSE)\\.md$ + write 시점 분기 inject 메시지 (REPORT → PROPOSE 안내, APPROVE → 사용자 승인 + EXECUTE 진입 게이트 명시, PROPOSE → ROADMAP 등록 안내)",
    "(검토) .pre-commit-config.yaml — 5 hook 패턴 검토 (변경 부재 가능)",
    "(검토) tests/smoke-roadmap-sync.sh + smoke-cross-ref.sh + smoke-claude-md-drift.sh — 9-stage 거명 정합 검토"
  ],
  "execution_notes": "phase 4 = 자동 회귀 차단. 본 phase commit 시 pre-commit 5 hook 모두 PASS 의무. R4 + R8 + R10 mitigation. era 자동 식별 메커니즘 (D10) 의 smoke 보조 부분 구현.",
  "commit": "feat(meta): v2.0 phase-4 — smoke era 자동 식별 + APPROVE/PROPOSE 분기 + post-report-write hook 메시지 분기"
}
```
