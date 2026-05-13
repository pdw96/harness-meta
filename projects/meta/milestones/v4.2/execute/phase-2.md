# phase-2 — 6 script 폐기 + Makefile stub + inactive smokes git rm (mechanical)

```json
{
  "phase": 2,
  "title": "6 script 폐기 + Makefile stub + inactive smokes git rm (mechanical)",
  "status": "in_progress",
  "affected_files": [
    "verify.ps1 (git rm)",
    "verify.sh (git rm)",
    "verify-lib.ps1 (git rm)",
    "verify-lib.sh (git rm)",
    "sync-agents.ps1 (git rm)",
    "sync-agents.sh (git rm)",
    "Makefile (L1/L6/L19~24 갱신)",
    "tests/_inactive/smoke-sync-agents.sh (git rm)",
    "tests/_inactive/smoke-verify-sh-parity.sh (git rm)",
    "projects/meta/milestones/v4.2/execute/phase-2.md (실행 노트)"
  ],
  "execution_notes": "DESIGN.phases[2] 정합. R1 mitigation grep 재검증 완료 — verify-lib 외부 active source 부재 (verify.ps1 + verify.sh 자체 source 만, _archive + tests/_inactive/smoke-verify-sh-parity.sh 외 거명 부재). 6 script (verify.{ps1,sh} + verify-lib.{ps1,sh} + sync-agents.{ps1,sh}) git rm — 1750+ LOC 폐기. 2 inactive smokes (tests/_inactive/smoke-sync-agents.sh + smoke-verify-sh-parity.sh) git rm — 참조 대상 폐기 = 의미 zero (D3). Makefile verify target = stub message + agent 안내 (D4, v4.0 phase-3 install stub 패턴 정합). external cron/CI 끊김 시 명시 안내 (R3 mitigation). phase-1 안 신규 subagent 2 배포 후 본 phase 진행 — agent 부재 gap window 회피 (D5 phase 분할).",
  "commit_message": "feat(meta): v4.2 phase-2 — 6 script + 2 inactive smokes git rm + Makefile verify stub (verify/sync mechanical 폐기)"
}
```

## 작업 결과

- `verify.ps1` git rm (~628 LOC)
- `verify.sh` git rm (~595 LOC)
- `verify-lib.ps1` git rm (~30 LOC)
- `verify-lib.sh` git rm (~30 LOC)
- `sync-agents.ps1` git rm (~172 LOC)
- `sync-agents.sh` git rm (~212 LOC)
- `tests/_inactive/smoke-sync-agents.sh` git rm (~122 LOC)
- `tests/_inactive/smoke-verify-sh-parity.sh` git rm (~100 LOC)
- `Makefile` 갱신 — L6 help text stub + L19~24 verify target stub message (5줄, agent 안내)

총 폐기 ~1889 LOC + Makefile 6줄 갱신.

## 관련

- DESIGN.phases[2]: [`../DESIGN.md`](../DESIGN.md)
- phase-1 (agent fleet 신규): [`phase-1.md`](phase-1.md)
- phase-3 (cascade narrative): [`phase-3.md`](phase-3.md) (작업 예정)
