# APPROVE — v4.0

```json
{
  "version": "v4.0",
  "id": "harness-composer-pivot",
  "approval": {
    "approved_by": "user",
    "approved_at": "2026-05-13",
    "stage": "APPROVE",
    "scope": "B2 (전면 재설계, 8 phase) + B3 (install script 3개 폐기) + 옵션 3 (team 단독, 5 멤버 component-installer 분리), 9 decisions (D1~D9), 12 risk_mitigation, 5 관점 self-review (pass / pass-with-comments, 3 흡수 권고 직접 반영)"
  },
  "approval_context": "사용자 명시 '승인' (2026-05-13 세션 라운드 8 후속, DESIGN.md 산출 직후). 추가 결정적 이슈 0. 5 관점 추가 subagent 호출 불요 (self-review narrative 보존 채택). lightweight 모드 거부 — § 6.2 폐지 milestone 본질, full review 진행.",
  "scope_locked": {
    "in_scope_phases": [
      "phase-1: Identity 5 host + § 6.2 폐지",
      "phase-2: 메타 v1~v3.21 _archive/ git mv (upbit 보존)",
      "phase-3: bootstrap/agents/ scaffold + CLAUDE.md + install script 3개 폐기 + 4 host narrative cleanup",
      "phase-4: Claude Code 도구 카탈로그 매뉴얼",
      "phase-5: 첫 agent team 5 멤버 + orchestration",
      "phase-6: /harness-meta <name> --audit opt-in",
      "phase-7: 벤치마크 cycle routine",
      "phase-8: CHANGELOG breaking + 도그푸드 검증"
    ],
    "out_of_scope": [
      "9-stage 워크플로우 본문 변경",
      "upbit milestone (v1.4~v1.16) _archive/ 이전"
    ]
  },
  "execute_protocol": {
    "phase_progression": "순차 (phase-1 → phase-8)",
    "commit_per_phase": "1 commit each (phase-3 만 2 commit 허용 — bootstrap scaffold + install 폐기 분리)",
    "user_confirm_before_commit": "각 phase 의 모든 변경 완료 후 commit 직전 사용자 확인 필수 (글로벌 user 정책 정합)",
    "pre_commit_hook": "14 hook 모두 PASS 의무, 우회 금지"
  }
}
```

## narrative

사용자 명시 승인 (2026-05-13). EXECUTE 진입 게이트 통과. 다음 stage = phase-1 실 진행 (5 host identity 재작성 + § 6.2 폐지).

## 관련

- DESIGN: [`DESIGN.md`](DESIGN.md)
- INTENT: [`INTENT.md`](INTENT.md)
- milestones: [`milestones.md`](milestones.md)
- 1차 source: 본 세션 사용자 명시 '승인' (2026-05-13)
