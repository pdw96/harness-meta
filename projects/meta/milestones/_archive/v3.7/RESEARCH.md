# RESEARCH — v3.7 smoke-posttooluse-9stage-tests

```json
{
  "external": [
    {
      "source": "claude/hooks/post-report-write.sh",
      "topic": "INTENT/APPROVE/PROPOSE 분기 메시지",
      "findings": "L136-141: INTENT → 'INTENT.md 작성 감지 (9-stage era). 다음: RESEARCH.md 작성으로 진행 (/harness-meta).'; APPROVE → 'APPROVE.md 작성 감지 (9-stage era). 사용자 명시 승인 게이트 — approval.approved_by=\\'user\\' + date 확인 후 EXECUTE 진입. 미승인 상태에서 EXECUTE 진입 금지 (/harness-meta).'; PROPOSE → 'PROPOSE.md 작성 감지 (9-stage era). next_candidates 를 ROADMAP milestones[] 에 status:\\'pending\\' 등록 + ROADMAP v2.0 status:\\'completed\\' 갱신 + 사용자 확인 후 push (/harness-meta).'",
      "drift": "없음 — hook 메시지와 test 예상값 직접 매핑 가능"
    }
  ],
  "codebase": {
    "affected_files": [
      "tests/_inactive/smoke-posttooluse-hook.sh"
    ],
    "untouched_files": [
      "claude/hooks/post-report-write.sh (hook 기능 변경 없음)",
      "tests/ 내 active smoke (회귀 검증 대상이나 변경 없음)"
    ],
    "current_state": "smoke-posttooluse-hook.sh: Stage 1 (3 static) + Stage 2 (19 dynamic, Tests A~S). INTENT/APPROVE/PROPOSE 검증 부재. tests/_inactive/ archive 위치.",
    "target_state": "Stage 1 (3 static, 변경 없음) + Stage 2 (22 dynamic, Tests A~V — T/U/V 3건 추가). 총 25 checks."
  },
  "options": [
    {
      "option": "A — _inactive smoke에 tests T/U/V 추가 (현 위치 유지)",
      "pros": ["v3.6 archive 정책 준수", "scope 최소화", "단일 파일 변경", "pre-commit 영향 없음"],
      "cons": ["자동 실행 안 됨 (manual run만)"]
    },
    {
      "option": "B — active 승격 + tests T/U/V 추가",
      "pros": ["pre-commit 자동 검증"],
      "cons": ["v3.6 § 6.2 archive 정책 위반", "scope 초과 (INTENT out_of_scope 명시)"]
    }
  ],
  "risks_identified": [
    "hook 메시지가 변경될 경우 test 예상값 미스매치 (낮음 — hook 은 stable)",
    "tests A~S 와 새 T/U/V 의 BASE 경로 불일치 시 NOOP 반환 오인 (주의 필요 — v3.0+ 9-stage-bundled era 경로 패턴 확인 필요)"
  ]
}
```
