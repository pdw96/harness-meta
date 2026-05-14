# REPORT — v5.2 agent-functional-path-cleanup

```json
{
  "milestone": "v5.2_agent-functional-path-cleanup",
  "summary": "v5.1 Phase 1+2 git mv (agents/ flat + skills/ flat) 후 잔존하던 functional audit path stale 5건을 1-phase 1 commit 으로 완전 해소. sc_1~sc_7 모두 PASS, pre-commit 14 hook PASS, 회귀 0건. Lightweight 모드 + commit timing (b) 적용. RESEARCH 발견 3건 (component-installer.md×2 + catalog README) 을 Option B 로 통합 — 후속 B_regression 발의 불요.",
  "delta": {
    "files_changed": 5,
    "files_added": 0,
    "files_deleted": 0,
    "tracking_files_added": 5,
    "commit": "c4edde7",
    "net_loc": "+47 / -5",
    "modules_affected": [
      "agents/environment-auditor.md (functional path 갱신)",
      "agents/harness-gap-analyzer.md (functional path 갱신)",
      "agents/component-installer.md (신규 추가 위치 + plugin.json skills 필드 갱신)",
      "bootstrap/claude-code-catalog/README.md (신규 멤버 작성 위치 갱신)",
      "CHANGELOG.md ([v5.2] Fixed entry 추가)"
    ]
  },
  "lessons_learned": [
    {
      "id": "L1",
      "lesson": "v5.1 cascade scope 'narrative 중심' vs 'functional path 중심' 분리 패턴 — v5.1 VERIFY regressions 등재 → v5.2 즉각 후속 패턴 (B_regression carry-over lifecycle 정상 작동)"
    },
    {
      "id": "L2",
      "lesson": "Lightweight 모드 sc_3 manual check 패턴 — bootstrap/ 거명 4건 전수 확인 후 CROSS_REF_OK vs functional path 분류 명시. grep 결과 0건 ≠ '거명 없음' (cross-ref 존재 허용 = sc_3 functional path 한정)"
    },
    {
      "id": "L3",
      "lesson": "Option B RESEARCH 발견 통합 패턴 — sc_4 'functional path 잔존 시 추가 fix' INTENT 사전 허용으로 RESEARCH discovery 흡수. 1-phase scope 확장 자연 수용."
    }
  ]
}
```
