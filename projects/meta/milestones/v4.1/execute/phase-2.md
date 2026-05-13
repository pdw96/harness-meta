# phase-2 — v4.1

```json
{
  "id": "install-strategy-reaudit",
  "version": "v4.1",
  "phase": 2,
  "title": "Cascade narrative 7~10 host 정합 + stale 정정 + verify 갱신 (narrative 단일 commit)",
  "status": "complete",
  "scope": "phase-1 mechanical 변경 (D7 5 step + component-installer 화이트리스트) 이후 cascade narrative 동기 — 7~10 host narrative 갱신 (README.md L13-18 Developer Mode 강제 → optional + L36 install narrative 정합 / AGENTS.md L15 / root CLAUDE.md L82 / claude/CLAUDE.md L23-26 stale install.ps1 정정 + L60/L67/L80 추가 거명 4건 정정 / claude/commands/harness-meta.md L327 install.ps1 거명 정정 / GUARDRAILS.md L34 install.ps1 정정 / verify.ps1 L94-100 A1 check info-level 격하 + Check-Info 함수 신규 / verify.sh L96 A1 narrative 갱신 / ARCHITECTURE § 3.1 install 거명 보존 D9 정합 확인).",
  "affected_files": [
    "README.md (Windows requirements + Installation narrative)",
    "AGENTS.md (Installation L15)",
    "CLAUDE.md (root L82 install narrative)",
    "claude/CLAUDE.md (L23-26 배포 메커니즘 rewrite + L60/L61/L67/L80 4건 install.ps1 거명 정정)",
    "claude/commands/harness-meta.md (L327 install.ps1 거명 정정)",
    "GUARDRAILS.md (L34 H5 narrative)",
    "verify.ps1 (L55 Check-Info 신규 + L94-100 A1 check info-level 격하)",
    "verify.sh (L95-96 A1 narrative 갱신)",
    "projects/meta/milestones/v4.1/execute/phase-2.md (본 파일)"
  ],
  "execution_notes": "v3.21 3 단계 패턴 (c) grep 검증 — 'Junction' + 'OS detect' + '5 step' + 'same.*volume' + 'Primary attempt by OS' cohesive 키워드 cohesive 확인. bootstrap/agents/CLAUDE.md (phase-1 D7 단일 source) 안 5 키워드 모두 present 보장. cascade host (README + AGENTS + root CLAUDE + claude/CLAUDE.md + GUARDRAILS) 안 'junction' / 'OS detect' / 'D7' cross-ref 키워드 present. install.ps1 거명 0건 보장 grep. ARCHITECTURE § 3.1 (D9 결정 정합) install 전략 narrative 미추가 — 'mechanical install/update/cleanup 도 agent (component-installer) 가 직접 담당 — static install script 부재' 추상 narrative 보존."
}
```

## v3.21 3 단계 패턴 (c) — grep 검증 결과

### (c.1) bootstrap/agents/CLAUDE.md D7 5 키워드 cohesive

phase-1 안 정전된 D7 narrative — 'Junction' / 'OS detect' / '5 step' / 'same.*volume' / 'Primary attempt by OS' / 'New-Item -ItemType Junction' / 'pwsh -Command' cohesive 키워드 모두 bootstrap/agents/CLAUDE.md § Install/Update/Cleanup 안 present.

### (c.2) install.ps1 거명 inventory 0건 보장

cascade 7 host 안 install.ps1 거명 잔존 0건 — phase-2 안 6 위치 정정:

- claude/CLAUDE.md L60/L61/L67/L80 (4건)
- claude/commands/harness-meta.md L327 (1건)
- GUARDRAILS.md L34 (1건)

### (c.3) cascade host 안 junction / D7 키워드 cross-ref

- README.md L13-18: "v4.1+ NTFS junction default" + "Developer Mode ON — optional" + "Junction default Windows"
- AGENTS.md L15: "Junction (Windows) / SymbolicLink (Linux/macOS)" + "5-step D7 sequence"
- CLAUDE.md (root) L82: "Junction Windows 또는 SymbolicLink/ln -s Linux/macOS" + "D7 sequence: backup → OS detect → primary attempt by OS → copy fallback → cleanup retention"
- claude/CLAUDE.md L23-26: "OS 별 D7 5 step sequence (Windows junction / Linux/macOS symlink)"
- GUARDRAILS.md L34: "D7 5 step sequence (v4.1: Windows junction / Linux/macOS symlink)"

### (c.4) ARCHITECTURE § 3.1 (D9 정합)

ARCHITECTURE.md § 3.1 L67 안 'mechanical install/update/cleanup 도 agent (`component-installer`) 가 직접 담당 — static install script 부재' 추상 narrative 보존. install 메커니즘 detail (junction vs symlink) 거명 부재 (D9 정합).

## commit narrative

```text
feat(meta): v4.1 phase-2 — cascade narrative 7~10 host 정합 + stale install.ps1 6건 정정 + verify A1 info-level 격하
```

## 관련

- DESIGN: [`../DESIGN.md`](../DESIGN.md) (D4 / D5 / D6 / D8 / D9 cascade 결정)
- phase-1: [`phase-1.md`](phase-1.md) (D7 5 step rewrite + component-installer)
- milestones.md sub_milestones phase-2: [`../milestones.md`](../milestones.md)
