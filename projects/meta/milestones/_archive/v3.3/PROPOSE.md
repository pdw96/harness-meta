# PROPOSE — v3.3 ci-inactive-smoke-cleanup

```json
{
  "id": "v3.3",
  "next_candidates": [
    {
      "id": "v3.4_open-stage-milestones-md-protocol",
      "title": "OPEN stage 절차에 milestones.md 스켈레톤 동시 생성 명문화",
      "trigger": "v3.3 L1 — bundle-trigger smoke가 in_progress 전환 즉시 milestones_path + 실 파일 존재 요구. harness-meta.md Stage A OPEN 절차에 '동시에 milestones.md 스켈레톤 생성' 단계 미명시.",
      "trigger_type": "C_improvement"
    },
    {
      "id": "v2.1_smoke-posttooluse-9stage-tests",
      "title": "smoke-posttooluse-hook.sh에 INTENT/APPROVE/PROPOSE 신규 패턴 검증 추가",
      "trigger": "v2.0 lessons next_candidates#2 — 기존 pending",
      "trigger_type": "B_regression"
    }
  ],
  "propose_summary": "v3.3 L1이 OPEN stage 프로토콜 gap을 드러냈다. v3.4에서 harness-meta.md Stage A OPEN 절차를 갱신하면 이후 모든 v3.x milestone에서 bundle-trigger 신규 fail 재발을 방지할 수 있다."
}
```
