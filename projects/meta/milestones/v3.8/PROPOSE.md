# PROPOSE — v3.8 inactive-smoke-cd-path-fix

```json
{
  "next_candidates": [
    {
      "id": "v3.9_inactive-smoke-git-mv-checklist",
      "title": "smoke git mv 시 dirname 경로 자동 갱신 절차 명문화 (harness-meta.md 또는 tests/CLAUDE.md)",
      "trigger": "smoke 파일을 디렉토리 간 이동 시 경로 오류 재발 방지",
      "trigger_type": "C_improvement"
    }
  ],
  "propose_summary": "v3.8 L1 (git mv 후 dirname 경로 자동 수정 부재) 에서 발의. v3.6 권고 #4 smoke _inactive/ 이동 시 체크리스트 누락이 root cause — 향후 smoke git mv 절차에 dirname 깊이 검토 단계 추가 고려. 단, 현 workflow self-improvement 동결 정책 (v3.6 ARCHITECTURE § 6.2) 에 따라 외부 적용에서 동일 문제가 재발할 때 trigger 결정."
}
```
