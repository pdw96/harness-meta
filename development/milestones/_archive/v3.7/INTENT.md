# INTENT — v3.7 smoke-posttooluse-9stage-tests

```json
{
  "id": "v3.7",
  "title": "smoke-posttooluse-hook.sh INTENT/APPROVE/PROPOSE 9-stage 테스트 추가",
  "goal": "post-report-write.sh 가 v2.0_workflow-word-fidelity 에서 추가한 INTENT.md / APPROVE.md / PROPOSE.md write trigger 검증을 tests/_inactive/smoke-posttooluse-hook.sh 에 보완한다.",
  "motivation": "v2.0 phase-4 에서 9-stage era 패턴 (INTENT/APPROVE/PROPOSE) 이 post-report-write.sh 에 추가됐으나, smoke-posttooluse-hook.sh 는 해당 패턴 검증 없이 archive 됐다. PLAN.md / REPORT.md / execute/phase-N.md 는 테스트되지만 INTENT.md → RESEARCH 안내 / APPROVE.md → 승인 게이트 / PROPOSE.md → next_candidates 안내 메시지 분기가 동적 검증 0 상태. hook 변경 시 이 분기가 조용히 깨질 수 있다.",
  "success_criteria": [
    "smoke T: Write + INTENT.md → additionalContext에 'RESEARCH' 키워드 포함 확인",
    "smoke U: Write + APPROVE.md → additionalContext에 'approved_by' 또는 'EXECUTE' 키워드 포함 확인",
    "smoke V: Write + PROPOSE.md → additionalContext에 'next_candidates' 또는 'ROADMAP' 키워드 포함 확인",
    "기존 tests A~S 회귀 0 (new tests 추가 후 기존 22 checks 동일 PASS)",
    "smoke 파일은 tests/_inactive/ 위치 유지 (v3.6 archive 정책 준수 — active 승격 없음)"
  ],
  "out_of_scope": [
    "smoke-posttooluse-hook.sh 의 active 승격 (tests/ 이동) — v3.6 § 6.2 archive 정책",
    "post-report-write.sh 기능 변경",
    "RESEARCH.md / DESIGN.md / VERIFY.md write trigger 추가 (OTHER 분기로 이미 처리됨, 추가 검증 불필요)",
    "pre-commit 등록"
  ],
  "dependencies": {
    "upstream": ["v2.0_workflow-word-fidelity (post-report-write.sh 9-stage 패턴 추가 완료)"],
    "downstream": []
  }
}
```
