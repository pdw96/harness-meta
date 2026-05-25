# phase-1 — v4.1

```json
{
  "id": "install-strategy-reaudit",
  "version": "v4.1",
  "phase": 1,
  "title": "D7 mechanical sequence rewrite + component-installer 갱신 (mechanical 단일 commit)",
  "status": "complete",
  "scope": "bootstrap/agents/CLAUDE.md § 'Install / Update / Cleanup 책임' D7 mechanical sequence 4 step → 5 step rewrite (Option D: Junction Windows default + Symlink Linux/macOS, OS detect step 신규 + Primary attempt by OS 분기 + NTFS same-volume 강제 narrative + ad-hoc 검증 권고). component-installer.md Bash 화이트리스트 갱신 + system prompt OS detect 로직 narrative 추가.",
  "affected_files": [
    "bootstrap/agents/CLAUDE.md",
    "bootstrap/agents/audit/project-harness-audit-team/component-installer.md",
    "projects/meta/milestones/v4.1/execute/phase-1.md (본 파일)"
  ],
  "execution_notes": "v3.21 3 단계 패턴 (b) — DESIGN 안 정확 markdown code block (D7 5 step 정확 narrative + 화이트리스트 v4.1 갱신 narrative + ad-hoc 검증 권고) EXECUTE 안 Edit tool 으로 그대로 삽입. phase-2 안 v3.21 3 단계 패턴 (c) grep 검증."
}
```

## EXECUTE 단계 narrative

### (a) bootstrap/agents/CLAUDE.md D7 rewrite

현 D7 narrative (line 46-53) 4 step → 5 step 갱신. DESIGN.md 안 정확 markdown code block 1차 source 그대로 삽입.

### (b) component-installer.md 갱신

현 화이트리스트 (system prompt 안 정전) — `New-Item` / `Copy-Item` / `Remove-Item` / `Move-Item` / `Test-Path` / `Get-ChildItem`. 갱신 = `New-Item -ItemType Junction` 명시 추가 + `pwsh -Command` (OS detect 위) 추가 + `ln -s` / `cp -r` / `mv` / `rm -rf` (cleanup only) 명시 추가. OS detect 로직 narrative 추가.

## commit narrative

```text
feat(meta): v4.1 phase-1 — D7 mechanical sequence rewrite (Option D Junction + Symlink) + component-installer 화이트리스트 갱신
```

## 관련

- DESIGN: [`../DESIGN.md`](../DESIGN.md) (D2 / D3 / D5 / D7 / D10 정확 narrative)
- milestones.md sub_milestones phase-1: [`../milestones.md`](../milestones.md)
