---
id: install-strategy-reaudit
title: DESIGN v4.1
version: v4.1
stage: DESIGN
status: completed
---

# DESIGN — v4.1

## Spec

```json
{
  "decisions": [
    {
      "decision": "D1: Option D 채택 — Windows = NTFS junction (standard user 권한, Developer Mode 불요), Linux/macOS = symlink (기본 작동, 권한 자유). 사용자 명시 결정 (2026-05-13 AskUserQuestion 'Install 전략 default mechanism 결정' 안 'Option D — Junction Windows + Symlink Linux/macOS (Recommended)' 명시 선택).",
      "rationale": "Developer Mode 강제 onboarding 마찰 해소 + drift 회피 (junction = directory mount, 자동 반영) + cross-platform 정합 (junction Windows + symlink Linux/macOS). Junction Claude Code Desktop 인식은 OS file API reparse point transparency 근거 PASS (spec-drift 검토 결과). PowerShell 7.6 docs 안 `Junction` ItemType elevation note 부재 → standard user 권한 보장.",
      "alternatives_rejected": [
        "Option A (현 유지) — Developer Mode 강제 해소 부재, INTENT 사용자 명시 'option 2 분석 + 결정 + 실 메커니즘 변경 통합' 부합 약함",
        "Option B (Copy default) — drift 회피 위해 매번 재 install 의무 + 단일 source 정합 위배 (사용자 메모리 v1.75 Manual Context Injection 정전)",
        "Option C (환경 자동 detect 분기) — 복잡도 증가 + detect 로직 부담 (단일 narrative 우선)",
        "Option E (lightweight narrative only) — Option A 와 동일 risk + INTENT 사용자 명시 부합 약함"
      ]
    },
    {
      "decision": "D2: D7 mechanical sequence rewrite — 5 step (Backup → OS detect → Primary attempt by OS → Copy fallback → Cleanup retention). 현 4 step 안 OS detect step 신규 + Primary attempt 분기 narrative.",
      "rationale": "Architecture 관점 권고 정확 정합 (candidate (a) 채택, (b) narrative-only 거부 — B3 'agent absorbs mechanical work' 정전 위배). OS detect 가 Primary attempt 분기 정확성 보장.",
      "alternatives_rejected": [
        "narrative-only (candidate b) — B3 mechanical 책임 정전 위배",
        "현 4 step 보존 + Junction 후속 narrative 추가 — Primary attempt 분기 명확화 부재"
      ]
    },
    {
      "decision": "D3: component-installer subagent Bash 화이트리스트 갱신 — `New-Item -ItemType Junction` 추가 (PowerShell 7+ canonical). `mklink /J` (cmd.exe) 거부 — PowerShell only 정전 + parser surface 회피.",
      "rationale": "Architecture 권고 정확 정합. `New-Item -ItemType Junction` 가 PowerShell 7+ canonical 형식 — `mklink /J` 는 cmd.exe shell invocation 으로 화이트리스트 parser surface 추가.",
      "alternatives_rejected": [
        "`mklink /J` 추가 — cmd.exe shell invocation 부담",
        "화이트리스트 변경 부재 — Junction 시도 시 화이트리스트 위배"
      ]
    },
    {
      "decision": "D4: Cascade narrative 단일 source = `bootstrap/agents/CLAUDE.md § Install / Update / Cleanup 책임` (현 D7 mechanical sequence 정전 보존). 나머지 host (README + AGENTS + bootstrap/skills/CLAUDE.md + claude/CLAUDE.md + root CLAUDE.md + ARCHITECTURE.md + GUARDRAILS.md + verify.ps1/sh) = cross-ref 또는 mechanical 검증 만.",
      "rationale": "Architecture 권고 정확 정합 — D7 mechanical sequence 는 bootstrap/agents/CLAUDE.md § '신규 subagent / team 추가 절차' 정전 host. ARCHITECTURE § 3.1 는 정체성 narrative 정전 host (install 전략 자체 정전 host 아님 — 정체성 vs mechanical 책임 분리). § 6.2 단일 source 전략 정합.",
      "alternatives_rejected": [
        "ARCHITECTURE § 3.1 끝 install 전략 paragraph 추가 — 정체성 narrative ↔ mechanical narrative 책임 혼재",
        "다중 source 분산 — 정합 cascade 부담 + drift risk"
      ]
    },
    {
      "decision": "D5: v3.21 narrative 정전화 3 단계 패턴 적용 — (a) DESIGN 안 정확 문구 1차 source (D7 5 step + OS detect narrative + Junction same-volume 강제 narrative 정확 markdown code block) / (b) phase-1 EXECUTE 안 Edit tool 그대로 삽입 / (c) phase-2 VERIFY 안 grep 검증 키워드 ('Junction' + 'OS detect' + '5 step' cohesive 키워드 추출).",
      "rationale": "Architecture 권고 정확 정합. v3.18/v3.20/v3.21 3 cycle 누적 패턴 — Lightweight 모드 자기참조 narrative 정전화 본질. 본 milestone 은 lightweight 모드 아님 (scope 큼) but 3 단계 패턴 자체는 cycle 재사용 가능 craft.",
      "alternatives_rejected": [
        "3 단계 패턴 미적용 — DESIGN narrative 와 EXECUTE 산출물 사이 drift risk"
      ]
    },
    {
      "decision": "D6: phases 2 분할 — phase-1 mechanical (D7 sequence rewrite + component-installer 화이트리스트 + system prompt OS detect 로직) / phase-2 cascade narrative (7~10 host 갱신 + verify.ps1/sh A1 check 갱신 + GUARDRAILS.md L34 정정 + stale install.ps1 정정).",
      "rationale": "Architecture 권고 정확 정합. phase-1 = source-of-truth 변경 + atomic revert 가능 / phase-2 = downstream cascade narrative 동기 + 잔여 cleanup. v3.5/v3.1 bundle 선례 정합 (mechanical ≠ narrative 분리).",
      "alternatives_rejected": [
        "통합 1 phase — atomic revert 곤란 + commit diff 책임 혼재",
        "3+ phase 분할 — phase-1 + phase-2 만으로 의미 단위 충분 (over-engineering)"
      ]
    },
    {
      "decision": "D7: NTFS junction same-volume 강제 narrative — D7 step 3 Primary attempt by OS 안 명시. `~/.claude/` 와 `$HOME/harness-meta/` 가 다른 NTFS volume 일 때 fallback (symlink with admin 또는 copy) 분기 narrative 추가.",
      "rationale": "Spec-drift 검토 결과 권고 — NTFS junction = volume mount 메커니즘 (same-volume 강제). drive cross 시 부작용 회피 narrative 명시 의무. UNC path (remote share) 제외 narrative 도 cross-ref.",
      "alternatives_rejected": [
        "same-volume 강제 narrative 미명시 — 실 환경 안 silent fail risk",
        "drive cross 시 자동 symlink 시도 — Developer Mode 강제 재발생 risk"
      ]
    },
    {
      "decision": "D8: Stale narrative 정정 inventory (phase-2 안 cascade 흡수) — (a) claude/CLAUDE.md L23-26 'install.ps1이 본 디렉토리의 3 카테고리를 ~/.claude/{commands,hooks,statusline}/로 symlink' → 'component-installer subagent (또는 메인 Claude) 가 본 디렉토리의 3 카테고리를 ~/.claude/{commands,hooks,statusline}/로 OS 별 D7 sequence (Windows junction / Linux/macOS symlink) 배포' 등 narrative 정합 갱신 / (b) GUARDRAILS.md L34 legacy reference 확인 + 정합 narrative 갱신 (phase-2 안 실 grep + 결정) / (c) verify.ps1 L97 + verify.sh L96 A1 check 갱신 — Developer Mode A1 'required' → 'optional (junction default 시 불요)' narrative 갱신.",
      "rationale": "회귀 risk 검토 권고 흡수 — stale 4건 (claude/CLAUDE.md install.ps1 + GUARDRAILS.md L34 + verify.ps1/sh A1 check) 정합 cascade. INTENT.success_criteria 의 '필요 시 narrative cascade' 정합.",
      "alternatives_rejected": [
        "stale 정정 X — 다음 milestone 으로 carry-over → drift 누적 risk"
      ]
    },
    {
      "decision": "D9: ARCHITECTURE.md § 3.1 끝 install 전략 narrative 추가 X — 정전 source = bootstrap/agents/CLAUDE.md § D7 단독. ARCHITECTURE § 3.1 는 정체성 narrative 보존 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer paragraph).",
      "rationale": "D4 단일 source 정전 정합. INTENT.success_criteria #4 '필요 시 ARCHITECTURE.md § 3.1 끝 install 전략 narrative 추가' 가 '필요 시' 조건 — D4 결정에 따라 '미추가' 가 정합.",
      "alternatives_rejected": [
        "ARCHITECTURE § 3.1 끝 install 전략 paragraph 추가 — D4 단일 source 정전 위배 + 책임 혼재 (정체성 ↔ mechanical)"
      ]
    },
    {
      "decision": "D10: OS detect 메커니즘 — PowerShell 7+ `$IsWindows` / `$IsLinux` / `$IsMacOS` automatic variables 활용 (single Bash 안 PowerShell 7+ 호출). Bash uname fallback narrative 만 (단일 mechanism 우선).",
      "rationale": "Spec-drift 권고 흡수 — PowerShell 7+ docs `$IsWindows` automatic var 명시. component-installer 가 이미 PowerShell 안 작동 (Bash 화이트리스트 안 PowerShell 명령) → consistency 정전.",
      "alternatives_rejected": [
        "Bash uname only — PowerShell 7+ 정합 부재 (component-installer mechanism 분기)",
        "둘 다 (PowerShell + Bash) — 단일 mechanism 우선, 복잡도 회피"
      ]
    }
  ],
  "phases": [
    {
      "n": 1,
      "title": "D7 mechanical sequence rewrite + component-installer 갱신 (mechanical 단일 commit)",
      "scope": "bootstrap/agents/CLAUDE.md § 'Install / Update / Cleanup 책임' D7 mechanical sequence 4 step → 5 step rewrite (Backup → OS detect → Primary attempt by OS [Windows junction / Linux/macOS symlink] → Copy fallback → Cleanup retention, NTFS same-volume 강제 narrative 포함). component-installer.md Bash 화이트리스트 갱신 (`New-Item -ItemType Junction` 추가) + system prompt 안 OS detect 로직 ($IsWindows / $IsLinux / $IsMacOS) narrative 추가.",
      "affected_files": [
        "bootstrap/agents/CLAUDE.md",
        "bootstrap/agents/audit/project-harness-audit-team/component-installer.md",
        "projects/meta/milestones/v4.1/execute/phase-1.md (신규)"
      ],
      "rationale": "Mechanical source-of-truth 변경 단일 commit. atomic revert 가능 (phase-2 cascade narrative 부재 시 도 mechanical 정합 보존). v3.21 3 단계 패턴 (a) DESIGN 정확 문구 → (b) EXECUTE Edit 그대로 삽입 본 phase 안 적용.",
      "risks": [
        "R1 (component-installer system prompt 복잡도) — D3 화이트리스트 최소 추가 + D10 OS detect 단일 mechanism mitigation",
        "R2 (junction Claude Code 인식 미검증) — spec-drift 검토 OS file API transparency 근거 PASS, 사용자 환경 안 첫 install 후 ad-hoc 검증 narrative 권고"
      ]
    },
    {
      "n": 2,
      "title": "Cascade narrative 7~10 host 정합 + stale 정정 + verify 갱신 (narrative 단일 commit)",
      "scope": "6 host cross-ref narrative 갱신 (README + AGENTS + bootstrap/skills/CLAUDE.md + claude/CLAUDE.md + root CLAUDE.md + ARCHITECTURE.md 정합 검증) + claude/CLAUDE.md L23-26 stale install.ps1 정정 (D8a) + GUARDRAILS.md L34 legacy reference 정정 (D8b) + verify.ps1 L97 / verify.sh L96 A1 check 갱신 (Developer Mode optional narrative, D8c) + v3.21 3 단계 패턴 (c) grep 검증 키워드 7~10 host cohesive 확인.",
      "affected_files": [
        "README.md",
        "AGENTS.md",
        "bootstrap/skills/CLAUDE.md",
        "claude/CLAUDE.md",
        "CLAUDE.md (root)",
        "projects/meta/ARCHITECTURE.md (cross-ref 검증 only, narrative 추가 X per D9)",
        "GUARDRAILS.md",
        "verify.ps1",
        "verify.sh",
        "projects/meta/milestones/v4.1/execute/phase-2.md (신규)"
      ],
      "rationale": "Cascade narrative 동기 + 잔여 cleanup. phase-1 mechanical 변경 commit 후 즉시 cascade 따라야 drift 부재. v3.21 3 단계 패턴 (c) VERIFY grep 검증 본 phase 안 자연 실행 (commit 직전).",
      "risks": [
        "R3 (cascade 7~10 host drift 잔존) — D5 v3.21 3 단계 패턴 grep 검증 mitigation",
        "R4 (verify.ps1/sh A1 check 갱신 시 cross-platform 정합) — Windows A1 + macOS/Linux N/A narrative 분기 검증 의무",
        "R5 (GUARDRAILS.md L34 실 내용 미검증) — phase-2 안 Read 실 확인 후 결정"
      ]
    }
  ]
}
```

## Approach

v4.1 milestone 의 implementation 전략은 9-stage workflow Stage F 안 2 phase 분할 (D6 정합). phase-1 (mechanical 변경) 안 (a) bootstrap/agents/CLAUDE.md § 'Install / Update / Cleanup 책임' D7 mechanical sequence rewrite — 4 step → 5 step (D2/D7/D10 정합, OS detect step 신규 + Primary attempt by OS 분기 + same-volume 강제 narrative) + (b) component-installer.md system prompt 안 Bash 화이트리스트 갱신 (D3 정합, `New-Item -ItemType Junction` 추가) + OS detect 로직 narrative 추가 단일 commit. phase-2 (cascade narrative 정합) 안 (a) 6 host narrative 갱신 (README + AGENTS + bootstrap/skills/CLAUDE.md + claude/CLAUDE.md + root CLAUDE.md + ARCHITECTURE.md cross-ref 검증) + (b) verify.ps1 + verify.sh A1 check 갱신 (Developer Mode optional narrative) + (c) GUARDRAILS.md L34 legacy reference 정정 + (d) stale install.ps1 거명 정정 (claude/CLAUDE.md L23-26) 단일 commit. Stage G VERIFY 안 v3.21 3 단계 패턴 (c) — grep 검증 키워드 ('Junction' + 'OS detect' + '5 step') 7~10 host cohesive 확인 + pre-commit 14 hook PASS + 회귀 0건.

## Risk mitigation

- risk: R1: component-installer subagent system prompt 안 detect 로직 + 분기 narrative 복잡도; mitigation: D3 화이트리스트 최소 추가 (Junction 1건) + D10 단일 mechanism ($IsWindows automatic var) — Bash + PowerShell 이중 path 회피.
- risk: R2: NTFS junction Claude Code Desktop 인식 spec 미검증 (직접 명시 부재); mitigation: OS file API reparse point transparency 근거 PASS (spec-drift 검토). 사용자 환경 첫 install 후 ad-hoc 검증 narrative 권고 — D7 sequence 안 'install 후 ~/.claude/agents/<name>/ junction 안 yaml frontmatter 인식 확인' narrative 추가.
- risk: R3: Cascade 7~10 host narrative 갱신 drift 잔존; mitigation: D5 v3.21 3 단계 패턴 (c) grep 검증 ('Junction' + 'OS detect' + '5 step' cohesive 키워드 cohesive) 의무 + smoke-cross-ref + smoke-claude-md-drift 자동 검증 + phase-2 commit 직전 self-check.
- risk: R4: verify.ps1/sh A1 check 갱신 시 cross-platform 정합 (Windows A1 'required' → 'optional', Linux/macOS N/A 보존); mitigation: phase-2 안 verify.ps1 L97 + verify.sh L96 동시 검증 + cross-platform narrative 분기 명시 (D8c).
- risk: R5: GUARDRAILS.md L34 실 내용 미검증 — legacy reference 의 정확 narrative 파악 부족; mitigation: phase-2 안 실 Read 후 narrative 결정 (D8b). 잔존 시 정정, 정합 시 보존.
- risk: R6: AGENTS.md L3 long matching line 미검증 — RESEARCH 안 'Omitted long matching line' 표지; mitigation: phase-2 안 AGENTS.md L3 실 Read + narrative 정합 확인. install / SymbolicLink 거명 시 narrative 갱신.
- risk: R7: 도그푸드 모순 — 본 milestone 자체 실행 환경 안 component-installer subagent install 부재 (사용자 ~/.claude/agents/ 안 미 install) → Agent tool 직접 호출 부재. 메인 Claude 가 Bash 으로 직접 처리 patten 정합 narrative 정전 필요.; mitigation: 본 milestone EXECUTE 단계 자체 = 메인 Claude 가 Bash 직접 처리 (Agent tool 호출 X). 도그푸드 narrative = REPORT lessons_learned 안 명시 — v4.0 PROPOSE #5 cross-ref.

## narrative

### 10 decisions 분포

- **D1** (Option D 채택): 사용자 명시 결정
- **D2, D3, D6, D10** (mechanical 변경 결정): Architecture / Spec-drift 권고 흡수
- **D4, D5, D9** (cascade 단일 source + 3 단계 패턴): Architecture 권고 정합
- **D7** (NTFS same-volume 강제): Spec-drift 권고 흡수
- **D8** (stale 정정 inventory): 회귀 risk 권고 흡수

### 4 관점 검토 결과 (scope 큼 = 4~5 관점, 본 milestone 4 관점 진행)

4 관점 모두 **pass-with-comments** + 의견 충돌 0건. 권고 모두 D1~D10 안 자동 흡수.

| # | 관점 | verdict | 흡수 권고 |
|:-:|---|---|---|
| 1 | architecture | pass-with-comments | D2 (5 step) + D3 (화이트리스트) + D4 (단일 source) + D5 (3 단계 패턴) + D6 (phases 2 분할) |
| 2 | spec-drift | pass-with-comments | D7 (same-volume) + D10 (OS detect mechanism) + R2 mitigation (junction 인식 narrative) |
| 3 | 회귀 risk | pass-with-comments | D8 (stale 정정 inventory: claude/CLAUDE.md install.ps1 + GUARDRAILS.md L34 + verify.ps1/sh A1) — cascade host 7 → 10 확장 |
| 4 | scope contract | pass-with-comments | (criteria ↔ phases 매핑 자유도 OK / out_of_scope forward propose 0 / affected_files Stage D 정정 / milestones.md 갱신 의무) — REPORT 안 'v4.1 rewrite narrative 선례 부재 명확화' 권고 (non-blocking, Stage H 반영) |

### Stage D 완료 직전 의무 step (v3.5 phase-2)

`phases[]` 확정 직후 → `milestones/v4.1/milestones.md sub_milestones[]` 1:1 동기 갱신 (placeholder title 교체) 의무. **본 DESIGN 작성 직후 동기 실행** (Stage E APPROVE 진입 전).

### decisions / phases 부산물 정책 (v3.10)

본 DESIGN.decisions[i].rationale + phases[n].scope 모두 **사실 진술** — 'PROPOSE.md next_candidates 발의 narrative' 같이 forward propose 책임 직접 거명 부재. R7 도그푸드 narrative 안 REPORT lessons_learned 거명만 (PROPOSE 흡수 부재).

### v3.21 3 단계 패턴 적용 — DESIGN 1차 source 정확 문구

#### D7 mechanical sequence rewrite (bootstrap/agents/CLAUDE.md 안 정확 삽입 narrative)

```markdown
### Component-installer mechanical sequence (D7, v4.1 갱신 — Option D: Junction Windows + Symlink Linux/macOS)

1. **Backup 우선** — 기존 `~/.claude/<category>/<name>/` 존재 시 `~/.claude/backups/<category>/<name>.<YYYYMMDD-HHMMSS>/` git mv (또는 Move-Item)
2. **OS detect** (v4.1 신규) — PowerShell 7+ automatic variable `$IsWindows` / `$IsLinux` / `$IsMacOS` 활용. Bash 안 PowerShell 직접 호출 패턴 — `pwsh -Command '$IsWindows'`.
3. **Primary attempt by OS** (v4.1 갱신):
   - **Windows**: NTFS junction 시도 — `New-Item -ItemType Junction -Path ~/.claude/<category>/<name> -Target <repo>/bootstrap/<category>/<name>` (standard user 권한, Developer Mode 불요). **Same NTFS volume 의무** — `~/.claude/` 와 `$HOME/harness-meta/` 가 다른 drive 일 때 step 4 fallback 분기. UNC path (remote share) 제외.
   - **Linux/macOS**: symlink 시도 — `New-Item -ItemType SymbolicLink ...` (PowerShell 7+) 또는 `ln -s ...` (standard user 권한, 기본 작동)
4. **Primary 실패 시 copy fallback** — `Copy-Item -Recurse -Force` 또는 `cp -r` (Windows drive cross / Linux 권한 issue / OS 제약 시)
5. **Cleanup retention** — default retain 3 backup + grace 7 days, `--yes` flag 으로 실 삭제 (default dry-run)

`component-installer` system prompt 안 허용 Bash 명령 화이트리스트 (v4.1 갱신): `New-Item` (`-ItemType SymbolicLink` / `-ItemType Junction`) / `Copy-Item` / `Remove-Item` / `Move-Item` / `Test-Path` / `Get-ChildItem` / `ln -s` / `cp -r` / `mv` / `rm -rf` (cleanup only) / `pwsh -Command` (OS detect) (D1 security mitigation).

**첫 install 후 ad-hoc 검증 권고** (R2 mitigation): Windows junction 인식 확인 — `Get-ChildItem ~/.claude/agents/<name>/` 안 yaml frontmatter resolve 보장 + Claude Code session 안 subagent_type 등재 확인.
```

#### phase-1 EXECUTE 안 Edit tool 그대로 삽입 narrative

위 markdown code block 안 narrative 가 phase-1 EXECUTE 의 Edit tool 정확 문구 1차 source. EXECUTE 안 그대로 삽입.

#### phase-2 VERIFY 안 grep 검증 키워드

`grep -E 'Junction|OS detect|5 step|same.*volume|Primary attempt by OS|component-installer system prompt' bootstrap/agents/CLAUDE.md` — cohesive 키워드 cohesive 확인.

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- 4 관점 검토 source: 본 session conversation 직접 (Plan + general-purpose + 2 Explore agent 병렬 invoke 결과)
- D7 mechanical sequence 정전 host: [`../../../../bootstrap/agents/CLAUDE.md`](../../../../bootstrap/agents/CLAUDE.md)
- component-installer subagent: [`../../../../bootstrap/agents/audit/project-harness-audit-team/component-installer.md`](../../../../bootstrap/agents/audit/project-harness-audit-team/component-installer.md)
- v3.21 narrative 정전화 3 단계 패턴 (선례): [`../_archive/v3.21/milestones.md`](../_archive/v3.21/milestones.md)
- 9-stage workflow Stage D 완료 의무: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md)
- Microsoft NTFS junction docs (외부 spec): <https://learn.microsoft.com/en-us/sysinternals/downloads/junction>
- PowerShell 7.6 `New-Item` docs (외부 spec): <https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item>
