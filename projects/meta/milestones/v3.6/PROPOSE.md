# PROPOSE — v3.6 overengineering-audit

```json
{
  "version": "v3.6",
  "id": "overengineering-audit",
  "next_candidates": [
    {
      "id": "upbit_v1.1_upbit-cross-ref-cleanup_activation",
      "title": "권고 #7 적용 — upbit 외부 적용 첫 evidence-base trigger (v1.1_upbit-cross-ref-cleanup 활성화)",
      "trigger_type": "A_user",
      "trigger": "사용자 명시 `/harness-meta upbit` 발의. ARCHITECTURE.md § 6.2 'workflow self-improvement 동결 정책' 의 'evidence-base trigger' 부합 첫 사례 — 외부 프로젝트 실 적용으로 harness 가치 검증. upbit/ROADMAP.md 안 v1.1_upbit-cross-ref-cleanup status: pending → in_progress 전환 + INTENT 작성 (upbit repo 측 cross-ref 정리, A_user trigger 가장 시급)",
      "rationale": "v3.6 권고 #7 직접 적용. 본 milestone phase-3 narrative 거명만, 실 발의는 사용자 명시 trigger 대기 (release train 거부 정합). upbit pending 3건 (v1.4_statusline-cmd-migration / v1.4_manifest-upgrade-1-1 / v1.1_upbit-cross-ref-cleanup) 중 v1.1 우선 (A_user + 가장 단순)"
    },
    {
      "id": "v3.6_deferred_recheck",
      "title": "Deferred v3.6_milestones-md-validation-extension + v3.7_workflow-narrative-strengthening-v2 재발의 여부 결정",
      "trigger_type": "E_priority",
      "trigger": "upbit 외부 적용 milestone 1건 완료 후, 그 정량 데이터 (예: harness가 실제 upbit 작업에서 milestones.md inverse drift / INTENT motivation phrasing 정합 문제를 노출했는지) 기반 재평가",
      "rationale": "v3.6 권고 #1 (workflow self-improvement 동결) 정합 — deferred 2건이 모두 workflow narrative 강화 / smoke 자체 강화 (workflow self-improvement) 성격. evidence-base trigger 없이 자동 재발의 금지. 외부 적용 1건 후 정량 데이터로 재발의 가치 평가. **default 권고: 동결 유지** (v3.7 narrative 강화 v2 는 자기참조 사이클의 가장 직접 신호)"
    },
    {
      "id": "v4.0_breaking-change-candidates",
      "title": "권고 #2/#3/#5 후속 candidates — 9-stage trim / 5 관점 trim / 4 era forward migration",
      "trigger_type": "D_design",
      "trigger": "upbit 외부 적용 2건+ 완료 후, 정량 데이터 (실제 5 관점 검토가 결정에 기여했는지 / 9-stage 어느 단계가 회피 trigger 였는지 / 4 era forward migration 비용 vs 가치) 기반 사용자 명시 발의. **breaking change 후보** → major bump (v4.0) 가능성",
      "rationale": "v3.6 권고 #2/#3/#5 는 본 milestone scope 외 (D2). 즉시 적용시 자기참조 사이클 재진입 + breaking change. evidence-base trigger 만 — release train 거부. v3.6 § 6.2 정책 정합. 본 candidates 등재 자체가 미래 발의 trigger 보장 + 자동 등재는 회피"
    }
  ],
  "propose_summary": "본 milestone (v3.6_overengineering-audit) 결과 자기참조 사이클 (workflow self-improvement) 가 진단 + 부분 mitigate 됨. 잔여 권고 3건 (#2/#3/#5) 은 evidence-base trigger 대기. upbit 외부 적용 발의 (#7) 가 다음 자연 step — 본 milestone 가치의 외부 검증. v3.6/v3.7 deferred 재발의는 외부 적용 후 정량 데이터 기반."
}
```

## 비고

본 PROPOSE.md 31줄 (cap < 80줄 정합).
