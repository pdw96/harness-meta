# milestones — v4.1

본 파일은 v3.0+ 9-stage-bundled era 의 sub-milestone listing 단일 source. `version` 단위 1 milestone 안 후속 candidates 통합 (의미 단위 동일) — phase 매핑은 Stage D DESIGN 단계 `phases[]` 확정 후 본 `sub_milestones[]` 와 1:1 동기 갱신 의무 (`claude/commands/harness-meta.md` Stage D 끝 'Stage D 완료 직전 의무 step' 정합).

```json
{
  "version": "v4.1",
  "title": "Install 전략 자체 재검토 — Option D 채택 (Junction Windows + Symlink Linux/macOS) + D7 5 step rewrite + cascade narrative 12 host",
  "status": "completed",
  "sub_milestones": [
    {
      "phase": 1,
      "title": "D7 mechanical sequence rewrite + component-installer 갱신 (mechanical 단일 commit)",
      "status": "complete",
      "commit": "320fac9"
    },
    {
      "phase": 2,
      "title": "Cascade narrative 7~10 host 정합 + stale 정정 + verify 갱신 (narrative 단일 commit)",
      "status": "complete",
      "commit": "6f23506"
    }
  ]
}
```

## 의도

사용자 명시 발의 (A_user, 2026-05-13 /harness-meta 진입 round 안 'Install 전략 자체 재검토 milestone 신규 발의' 명시 선택). 본 v4.1 은 scope rewrite — 기존 v4.1_dev-tools-bootstrap (v4.0 PROPOSE #1+#2 bundle, OPEN~DESIGN 완료 후 사용자 의문 raise → APPROVE 게이트 안 rewrite 결정, commit 부재 상태에서 산출물 삭제) 폐기 후 install 전략 재검토 scope 로 v4.1 번호 재사용.

핵심 의문 = bootstrap/agents/CLAUDE.md D7 mechanical sequence 안 'Windows Developer Mode 의무, macOS/Linux 기본 동작' chain 자체. Symlink 채택 이유 (단일 source 정합 + 자동 반영) vs Developer Mode 강제 onboarding 마찰 trade-off 정전화.

## 관련

- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) (`milestones[]` 안 `v4.1_install-strategy-reaudit`)
- v4.0 D7 mechanical sequence (의문 source): [`../../../../bootstrap/agents/CLAUDE.md`](../../../../bootstrap/agents/CLAUDE.md) § 'Install / Update / Cleanup 책임'
- v4.0 DESIGN (D7 정전 source): [`../v4.0/DESIGN.md`](../v4.0/DESIGN.md)
- v4.0 PROPOSE #5 (dogfood-install-precondition, 본 의문 trigger): [`../v4.0/PROPOSE.md`](../v4.0/PROPOSE.md)
- 9-stage workflow: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md)
- ARCHITECTURE § 6.1 (bundling 정책): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)
