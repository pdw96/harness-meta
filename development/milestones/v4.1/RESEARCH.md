---
id: install-strategy-reaudit
title: RESEARCH v4.1
version: v4.1
stage: RESEARCH
status: completed
---

# RESEARCH — v4.1

## Spec

```json
{
  "external": [
    {
      "source": "Microsoft Windows Developer Mode 정책 (docs.microsoft.com/en-us/windows/uwp/get-started/enable-your-device-for-development)",
      "topic": "Windows symlink 생성 권한 정책",
      "findings": "Windows 안 symbolic link 생성은 default 권한으로 불가 — admin elevation (UAC) OR Developer Mode ON (Settings → System → For developers) 의무. PowerShell `New-Item -ItemType SymbolicLink` 가 Developer Mode 또는 admin shell 안에서만 작동. macOS/Linux 는 standard user 권한으로 `ln -s` 또는 `New-Item -ItemType SymbolicLink` (PowerShell 7+) 자유 작동.",
      "drift": "현 bootstrap/agents/CLAUDE.md D7 step 2 narrative 정확 정합 (Windows Developer Mode 의무, macOS/Linux 기본 동작) — drift 0. 다만 사용자 onboarding 마찰 trade-off 정전 narrative 부재."
    },
    {
      "source": "Windows symbolic link 대안 — junction (NTFS feature)",
      "topic": "Developer Mode 회피 가능 대안",
      "findings": "Windows NTFS junction point = directory level mount 메커니즘, standard user 권한으로 생성 가능 (`New-Item -ItemType Junction`). 동일 NTFS volume 강제 + 디렉토리 only (파일 X). symlink 와 동일 효과 (drift 0, 자동 반영) but Developer Mode 불요.",
      "drift": "현 D7 sequence 안 junction 후보 narrative 부재 — 본 milestone EXECUTE 단계 안 검토 의무."
    },
    {
      "source": "Hardlink — POSIX inode 공유 메커니즘",
      "topic": "또 다른 Developer Mode 회피 가능 대안",
      "findings": "POSIX hardlink (Windows 안 `New-Item -ItemType HardLink` 지원) = inode 동일성 보장 메커니즘. 파일 level only (디렉토리 X, Windows 제약). 같은 filesystem 강제. inode 동일성 → bootstrap/ 안 파일 delete + 재생성 시 hardlink 끊김 (git checkout 시 자주 발생) — drift risk 발생.",
      "drift": "hardlink 는 파일 level + 끊김 risk → harness-meta 사용 case 부적합 (디렉토리 단위 ~/.claude/agents/<name>/ 매핑 필요)."
    },
    {
      "source": "WSL (Windows Subsystem for Linux) 활용",
      "topic": "Linux filesystem 우회 옵션",
      "findings": "WSL 안 ext4 filesystem 사용 시 symlink 기본 작동 (standard user 권한). 단 WSL install 자체가 onboarding 마찰 누적 (Windows 사용자 추가 setup). ~/.claude/ 가 WSL 안 또는 Windows 안 인지 ambiguous (Claude Code Desktop 호환성 검증 의무).",
      "drift": "현 D7 sequence 안 WSL 후보 narrative 부재 — 단 본 milestone scope 외 (외부 환경 의존)."
    },
    {
      "source": "Copy 기반 install (D7 step 3 fallback 현 존재)",
      "topic": "현 fallback 의 default 화 가능성",
      "findings": "현 D7 step 3 'Symlink 실패 시 copy fallback' (Copy-Item -Recurse -Force / cp -r) 이 이미 존재. 본 fallback 을 default 로 전환 시 — Developer Mode 강제 해소 + 모든 OS 동등 작동. 단 drift 회피 위해 매번 재 install 의무 + 디스크 공간 2배 (source-of-truth + copy).",
      "drift": "현 narrative 안 'symlink default + copy fallback' 명시 — 본 의문 의 본질 = 'symlink default 가 정합한가'."
    },
    {
      "source": "code.claude.com/docs (context7 library /websites/code_claude)",
      "topic": "Claude Code 안 subagent / skill install 권장 메커니즘",
      "findings": "Claude Code spec 안 ~/.claude/{agents,skills,commands,hooks,statusline}/ 디렉토리 자체에 어떤 install 메커니즘 권장은 명시 부재 (사용자 자유). symlink / copy / direct 직접 작성 모두 가능. 단 'symlink 가 권장' 명시는 부재 → harness-meta 자체 결정.",
      "drift": "drift 0 — Claude Code spec 안 install 메커니즘 강제 부재 → harness-meta 자체 결정 자유."
    }
  ],
  "codebase": {
    "affected_files_inventory": [
      "bootstrap/agents/CLAUDE.md § 'Install / Update / Cleanup 책임 (v4.0 B3, component-installer 흡수)' D7 mechanical sequence 4 step 정전 (L42-57) — install 전략 narrative 1차 source",
      "bootstrap/skills/CLAUDE.md § '배포 (v4.0 B3 — component-installer 흡수)' L79-81 — 'bootstrap/agents/CLAUDE.md ... 단일 source' cross-ref 만 보유 (cascade)",
      "claude/CLAUDE.md § '배포 메커니즘' L23-26 — 'install.ps1이 본 디렉토리의 3 카테고리를 ~/.claude/{commands,hooks,statusline}/로 symlink' (stale narrative — install.ps1 폐기 v4.0 B3 후 갱신 누락)",
      "README.md L13-15 (Windows 11 + Developer Mode ON required) + L30-36 (Installation, natural language invocation) — 영문 사용자 진입점",
      "CLAUDE.md root L78-82 — '`harness-meta 설치해줘` 호출 → 메인 Claude 가 Bash (PowerShell `New-Item -ItemType SymbolicLink`) 로 ~/.claude/{commands,hooks,statusline,skills,agents}/ 자동 구성 (v4.0 B3, static install script 부재 — agent component-installer 가 mechanical 작업 흡수)'",
      "AGENTS.md (영문 agent context) — install 관련 narrative 잠재 존재 (RESEARCH 단계 grep 후 확인 의무)",
      "projects/meta/ARCHITECTURE.md § 3.1 끝 'harness-meta repo 정체성' paragraph (v4.0 도입) — install 전략 narrative 부재 (정전 source 누락)"
    ],
    "untouched_files_explicit": [
      "bootstrap/agents/audit/project-harness-audit-team/ 5 멤버 yaml frontmatter (install 메커니즘 narrative 무관, 멤버 자체 책임 정의만)",
      "tests/_inactive/ archive smoke (v3.6 archive 정합)",
      "claude/hooks/ + claude/statusline/ + claude/commands/ 실 hook/statusline/command 스크립트 (install 메커니즘 narrative 외, 스크립트 자체는 정합)",
      "bootstrap/skills/ 안 5 skill SKILL.md (install 메커니즘 narrative 무관)",
      "CHANGELOG.md (Stage I PROPOSE 후 사용자 결정 시 별도 entry 추가)",
      "v4.0 milestones/v4.0/ 산출물 (audit trail 보존, 정정 X)"
    ],
    "current_state": "Install 메커니즘 = D7 mechanical sequence (backup → symlink 시도 → copy fallback → cleanup retention) default. Windows Developer Mode 의무 narrative 6 host cascade (README + bootstrap/agents/CLAUDE.md + bootstrap/skills/CLAUDE.md + claude/CLAUDE.md + root CLAUDE.md + ARCHITECTURE 부재). claude/CLAUDE.md L23-26 안 stale narrative (install.ps1 거명, v4.0 B3 후 누락).",
    "target_state": "결정된 default mechanism + fallback decision narrative 정전화. 6 host cascade 안 정합 narrative (현 stale 1건 정정 + 정전 source 1건 ARCHITECTURE 추가 검토). Developer Mode 강제 trade-off 정량 narrative + 환경별 자동 분기 narrative (Developer Mode ON → symlink / OFF → junction 또는 copy)."
  },
  "options": [
    {
      "id": "option-A-status-quo",
      "name": "현 default 유지 — symlink 강제 + Developer Mode 강제 narrative 명확화",
      "pros": "변경 0 — 가장 작은 milestone scope. 현 narrative 정합 보존. drift 회피 강점 유지.",
      "cons": "Developer Mode 강제 onboarding 마찰 해소 부재. 사용자 의문 해결 narrative 만, 실 변경 없음 — INTENT.success_criteria 의 'option 2 분석 + 결정 + 실 메커니즘 변경 통합' 사용자 명시 부합 부족."
    },
    {
      "id": "option-B-copy-default",
      "name": "Copy default 전환 + symlink opt-in",
      "pros": "Developer Mode 강제 해소 — 모든 Windows 사용자 즉시 install 가능. 사용자 환경 ~/.claude/ stable (외부 path resolution 부재).",
      "cons": "Drift 회피 위해 매번 재 install 의무 (git pull 후 manual) — 개발자 onboarding 마찰 누적. 디스크 공간 2배. 사용자 직접 edit bootstrap/ 시 ~/.claude/ 미반영 — single source 정합 위배."
    },
    {
      "id": "option-C-environment-detect",
      "name": "환경 자동 detect + 분기 (Developer Mode ON → symlink / OFF → junction 또는 copy)",
      "pros": "사용자 환경 자동 적응 — onboarding 마찰 해소 + drift 회피 둘 다 보존. component-installer subagent 안 detect 로직 추가 가능 (Bash 안 PowerShell `Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense` 또는 동치 detect).",
      "cons": "복잡도 증가 — component-installer 안 분기 로직 + 사용자 환경별 narrative 6 host cascade. fallback decision (junction vs copy) narrative 별도 결정. Windows 외 OS 동작 보존 narrative 추가 cascade."
    },
    {
      "id": "option-D-junction-default-windows",
      "name": "Junction default Windows + symlink default Linux/macOS",
      "pros": "Developer Mode 강제 완전 해소 (junction = standard user 권한). drift 회피 강점 유지 (junction = directory mount 메커니즘). cross-platform 정합 (Linux/macOS symlink + Windows junction 동일 효과).",
      "cons": "Windows-specific narrative 추가 (junction 은 NTFS only — drive letter cross 시 부재). Claude Code Desktop 안 junction 인식 spec 검증 의무 (현 spec 안 unspecified). 새 메커니즘 narrative cascade 6 host."
    },
    {
      "id": "option-E-stale-narrative-cleanup-only",
      "name": "Lightweight — stale narrative 1건 (claude/CLAUDE.md install.ps1 거명) 정정 + ARCHITECTURE § 3.1 install 전략 narrative 1건 정전화",
      "pros": "최소 scope. 사용자 의문 해결 narrative 만 (실 변경 부재) — narrative 정전화 단일 source 결정 정합. lightweight 모드 (§ 6.2 trigger 충족) 자연.",
      "cons": "INTENT.success_criteria 의 'option 2 분석 + 결정 + 실 메커니즘 변경 통합' 사용자 명시 부합 약함 — Option A 와 동일 risk."
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "description": "Option C (환경 자동 detect) 채택 시 component-installer subagent system prompt 안 detect 로직 추가 필요 — yaml frontmatter 형식 정전 + 사용자 환경별 narrative cascade 복잡도 증가.",
      "category": "복잡도"
    },
    {
      "id": "R2",
      "description": "Option D (Junction Windows default) 채택 시 Claude Code Desktop 안 junction 인식 spec 미검증 — 실 환경 호환성 risk.",
      "category": "외부 spec 호환"
    },
    {
      "id": "R3",
      "description": "Option B (Copy default) 채택 시 사용자 직접 edit bootstrap/ 시 ~/.claude/ 미반영 — 사용자 메모리 'v1.75 Manual Context Injection' 정전 (single source 정합) 위배 risk.",
      "category": "single source 정합"
    },
    {
      "id": "R4",
      "description": "6 host cascade narrative 갱신 시 drift risk — README + bootstrap/{agents,skills}/CLAUDE.md + claude/CLAUDE.md + root CLAUDE.md + AGENTS.md + ARCHITECTURE.md 동기 의무. smoke-cross-ref + smoke-claude-md-drift 자동 검증 정합 보장.",
      "category": "cross-ref drift"
    },
    {
      "id": "R5",
      "description": "claude/CLAUDE.md L23-26 안 stale 'install.ps1' 거명 — v4.0 B3 후 narrative 누락. 본 milestone scope 안 자연 흡수 의무 (실 cascade 갱신).",
      "category": "stale narrative"
    },
    {
      "id": "R6",
      "description": "AGENTS.md 안 install 거명 잠재 — Stage D 진입 전 grep 의무 (현 RESEARCH 안 미검증, codebase.affected_files_inventory 안 '잠재 존재' 표지).",
      "category": "RESEARCH 부족"
    },
    {
      "id": "R7",
      "description": "도그푸드 — 본 milestone 자체 install 부재 환경 (사용자 ~/.claude/agents/ 안 component-installer subagent 실 install 부재) 에서 EXECUTE 단계 안 Agent tool 호출 자체 가능한가? 메인 Claude 가 Bash 으로 직접 처리 patten 정합 narrative 정전 필요.",
      "category": "도그푸드 자기참조"
    }
  ]
}
```

## narrative

### Install 전략 5 후보 비교 매트릭스

| Option | onboarding 마찰 | drift 회피 | cross-platform | Claude Code spec 정합 | 복잡도 |
|---|:-:|:-:|:-:|:-:|:-:|
| A (현 유지) | ✗ Developer Mode 강제 | ✓ symlink 자동 반영 | ✓ Linux/macOS 기본 | ✓ unspecified (자유) | 0 |
| B (Copy default) | ✓ Developer Mode 불요 | ✗ 매번 재 install | ✓ 모든 OS 동등 | ✓ unspecified | 0 |
| C (환경 detect 분기) | ✓ 자동 적응 | ✓ symlink 유지 (ON) / junction (OFF) | ✓ OS 별 분기 narrative | ✓ unspecified | 2 (detect 로직 + 분기) |
| D (Junction Windows default) | ✓ Developer Mode 불요 | ✓ junction 자동 반영 | ✓ Windows junction + Linux/macOS symlink | △ junction 인식 미검증 | 1 (Windows narrative) |
| E (lightweight narrative only) | ✗ Developer Mode 강제 보존 | ✓ symlink 보존 | ✓ 보존 | ✓ 보존 | 0 |

### 사용자 의문 본질 정리

'왜 Developer Mode 켜야 하는가' = 'Symlink 채택 자체가 정합한가' + 'Onboarding 마찰 vs drift 회피 trade-off 정량 분석 부재'. Option A/E 는 narrative 만, Option B/C/D 는 실 메커니즘 변경. INTENT.success_criteria 사용자 명시 (option 2 분석 + 결정 + 실 메커니즘 변경 통합) → **Option B / C / D 중 결정 필요** (Stage D APPROVE 게이트). Option A / E 는 사용자 명시 부합 약함.

### Untouched / risks 부산물 정책 (v3.10)

본 RESEARCH.codebase.untouched_files_explicit + risks_identified 모두 **사실 진술** — '본 milestone 의 영향 부재 파일' 또는 '식별 risk' 만. '별 milestone 으로' 같은 forward propose 명령형 부재 (v3.10 단일 origin 강제).

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- D7 mechanical sequence 정전 source: [`../../../../bootstrap/agents/CLAUDE.md`](../../../../bootstrap/agents/CLAUDE.md) § 'Install / Update / Cleanup 책임'
- cascade 6 host: README.md L13-15, L30-36 + bootstrap/{agents,skills}/CLAUDE.md + claude/CLAUDE.md L23-26 (stale) + root CLAUDE.md L78-82 + AGENTS.md (잠재)
- Microsoft Developer Mode 정책 (외부 spec): docs.microsoft.com/en-us/windows/uwp/get-started/enable-your-device-for-development
- 9-stage workflow Stage D: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md)
