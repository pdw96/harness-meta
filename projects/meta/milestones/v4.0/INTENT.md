# INTENT — v4.0

```json
{
  "version": "v4.0",
  "id": "harness-composer-pivot",
  "title": "정체성 전면 재설계 — project harness composer + Claude Code ecosystem integrator + agent fleet maintainer (B2 scope, 8 phase, breaking major bump v3→v4)",
  "goal": "harness-meta repo 정체성을 'project harness composer + Claude Code ecosystem integrator + agent fleet maintainer' 로 전면 재정의 + B2 scope 전면 재설계 (8 phase) — identity 5 host + § 6.2 폐지 + 메타 _archive + bootstrap/agents/ + install script 3개 폐기 (B3) + Claude Code 도구 카탈로그 + 5 멤버 agent team (component-installer 분리) + /harness-meta --audit opt-in + 벤치마크 cycle routine + CHANGELOG/도그푸드",
  "motivation": "v3.17~v3.21 5건 누적 자기참조 정전화 cycle + upbit v1.16 이후 외부 적용 정체 = 본 repo 원 목적 분리. 사용자 명시 진단 (2026-05-13 세션 `/clear` 직후) '의미 상실' + 새 정체성 정의 라운드 8회 진행. 정체성 본질 = 'AI agent 가 프로젝트 분석 + mechanical 작업까지 흡수' — install script 도 agent 가 담당 (사용자 round 8 짚음: 'script 가 없어도 각 ai agent 가 프로젝트 분석해서 만들어 줄 수 있다'). § 6.2 self-improvement 동결 정책은 새 정체성에 의해 자연 해소 (정체성 본질 직접 구현 milestone 이 자기참조 cycle 회피).",
  "success_criteria": [
    "(1) root CLAUDE.md + projects/meta/ARCHITECTURE.md (§ 3 단일 source) + AGENTS.md + README.md + projects/meta/CLAUDE.md 5 host 안 새 정체성 paragraph 정전화 — wording 단일 source (ARCHITECTURE § 3) + 4 host cross-ref 1줄 (v1.4_cross-ref-propagation 선례 정합)",
    "(2) ARCHITECTURE.md § 6.2 (line 182~205 ~30 line) workflow self-improvement 동결 정책 paragraph 폐지 + 폐지 narrative 표지 (v4.0 pivot 사유 cross-ref 1줄)",
    "(3) projects/meta/milestones/_archive/ 디렉토리 신규 + 메타 v1.0~v3.21 전체 git mv (`git log --follow` history 보존 ≥ 95% per file) + tests/_inactive/ 선례 정합 _* sentinel 자동 skip 검증",
    "(4) upbit milestone (projects/upbit/milestones/, v1.4~v1.16) 현 위치 보존 — projects/upbit/ROADMAP.md milestone entry 변경 0",
    "(5) bootstrap/agents/ 디렉토리 신규 (audit/ + dev-tools/ 카테고리 placeholder) + bootstrap/agents/CLAUDE.md (두 층 구조 narrative + conflict resolution 4 case 매트릭스 + agent fleet lifecycle 5 case 매트릭스 + install/update/cleanup 책임 narrative — component-installer 담당, mechanical 작업 = Bash New-Item SymbolicLink / Copy-Item / Remove-Item)",
    "(6) install script 3 파일 폐기 — install.ps1 + install-skills.ps1 + install-skills.sh 모두 삭제 (B3 결정) + 4 host narrative cleanup (root CLAUDE.md install 명령 섹션 / bootstrap/skills/CLAUDE.md 배포 섹션 / README install instruction / AGENTS 참조) — install 책임이 agent 로 이전 narrative 정전화",
    "(7) Claude Code 도구 카탈로그 매뉴얼 1 파일 (bootstrap/claude-code-catalog/README.md 또는 동치 host) — code.claude.com/docs (context7 /websites/code_claude primary) + built-in slash command 인벤토리 + plugin/MCP 인벤토리 통합 + 자주 묻는 query 카탈로그 ≥ 3건 (subagents / hooks / agent-teams)",
    "(8) 첫 agent team `project-harness-audit-team` — 5 멤버 subagent 정의 (project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer (read-only 제안) / component-installer (write apply)) + orchestration narrative (호출 순서 scanner → analyzer → mapper → proposer → 사용자 명시 결정 → installer + 결과 통합) + bootstrap/agents/audit/ 안 배치",
    "(9) /harness-meta <name> 동작 변경 — claude/commands/harness-meta.md 안 `--audit` opt-in 분기 추가 (audit team 자동 호출 + component proposal 산출 + 사용자 명시 결정 후 installer 호출). freeform 기본 동작 보존 (회귀 0)",
    "(10) 벤치마크 cycle routine — `schedule` skill 활용 주 1회 cron (GitHub 인기 repo + Claude Code release notes/changelog 검토). 산출물 = fleet evolution + conflict resolution proposal (e3 정책 자동 생성, 사용자 명시 결정 대기). 산출물 host = ROADMAP candidate draft 또는 issue draft",
    "(11) conflict resolution 4 case 매트릭스 narrative 정전화 (bootstrap/agents/CLAUDE.md) — superset (delete) / 유사 다른 책임 (mix) / 부분 cover (mix default + 보완) / 무관 (둘 다 keep)",
    "(12) agent fleet lifecycle 5 case 매트릭스 narrative 정전화 — scope 확장 / 분할 / 신규 / 통합 / 삭제. e3 결정 워크플로우 명시",
    "(13) pre-commit 14 hook 모두 PASS + 회귀 0 (smoke active 6 PASS + _archive/ sentinel skip 검증 + inactive 22+ 유지)",
    "(14) semver major bump (v3 → v4) — root README + CHANGELOG.md [v4.0] entry breaking `!` 마커 표지 + .harness.toml schema 영향 검토 (필요 시 1.1 → 2.0)",
    "(15) 도그푸드 검증 — harness-meta 자체에 project-harness-audit-team audit run 1회 + 결과 합리성 확인 (audit-team 이 자기 자신 추가 멤버 제안하는 모순 회피, 모순 case 는 v4.1+ 후속 candidate 만 거명, in-loop 처리 금지)",
    "(16) ROADMAP entry v4.0 신규 (in_progress → completed) + 메타 v1.0~v3.21 entry archive 표지 narrative (status 'completed' 유지하되 era 분리 표지 별도 archive 섹션)"
  ],
  "out_of_scope": [
    "(A) 9-stage 워크플로우 본문 변경 — 도구로서 유지, 정체성 재정의의 본질이 아님",
    "(B) upbit milestone (v1.4~v1.16) _archive/ 이전 — A2 결정 정합, 외부 적용 사례 reference 가치"
  ],
  "dependencies": [
    "context7 /websites/code_claude library ID (7393 snippets, score 81.68, 본 세션 검증 완료) — claude-docs-mapper team 멤버 + plugin 매뉴얼 1차 source",
    "agent teams docs (https://code.claude.com/docs/en/agent-teams) — multi-instance vs single-session subagents 차이 evidence, v4.0 첫 적용은 subagents-based team",
    "ARCHITECTURE.md § 6.2 (line 182~205) paragraph (폐지 대상) + § 3 5요소 매트릭스 (정체성 정의 host)",
    "tests/_inactive/ 디렉토리 (smoke _* sentinel skip 패턴 선례) — _archive/ 동일 검증 reference",
    "bootstrap/skills/CLAUDE.md (글로벌 skill 매트릭스 + 두 층 패턴) — bootstrap/agents/CLAUDE.md narrative 복사 기반 (단 install 책임은 agent 로 이전)",
    "schedule skill (이미 활성, 시스템 reminder 노출) — 벤치마크 cycle routine 실행 인프라",
    "claude/commands/harness-meta.md (현 1 slash command) — `/harness-meta <name> --audit` opt-in 동작 추가 host",
    "기존 install.ps1 + install-skills.ps1 + install-skills.sh (폐기 대상 3 파일) + 4 host narrative (root CLAUDE.md + bootstrap/skills/CLAUDE.md + README + AGENTS)",
    "Bash tool (PowerShell `New-Item -ItemType SymbolicLink` / `Copy-Item` / `Remove-Item` / `~/.claude/backups/agents/<name>.<YYYYMMDD-HHMMSS>/`) — component-installer 의 mechanical 작업 entry"
  ],
  "trigger": "A_user",
  "self_reference_policy": "pivot",
  "non_goals_explicit": [
    "B1 small scope 거부 — 사용자 명시 round 4 짚음 ('전면 재설계 milestone 으로 phase 구분'), 추천 철회 후 B2 채택",
    "본 milestone 이 또 self-referential 거대 milestone 되는 회피 — § 6.2 동결 정책 자체를 폐지하므로 self_reference_policy: 'pivot' 표지로 의도성 명시",
    "9-stage 워크플로우 변경 — 도구로서 유지",
    "archive 대상 milestone 의 historical 가치 부정 회피 — git mv (history 보존) + _archive/ 디렉토리 유지 (삭제 아님)",
    "단일 subagent 별도 정의 추가 회피 — 옵션 3 결정 정합, 단일 사용 case 는 team 멤버 단독 호출",
    "install script 점진 폐기 (B1/B2) 거부 — B3 채택 (모두 폐기, 깨끗한 v4.0 정전화). 사용자 round 8 짚음 'script 가 없어도 ai agent 가 만들어 줄 수 있다' 직접 적용",
    "신규 install-agents.{ps1,sh} 생성 회피 — agent (component-installer) 가 mechanical 작업 흡수, script 미러 부담 자체 소멸"
  ]
}
```

## narrative

### 발의 맥락 (라운드 8)

2026-05-13 세션 `/clear` 직후 사용자 명시 발의:

1. **진단**: "harness-meta 가 의미 상실한 느낌"
2. **옵션 선택**: (b) 정체성 재정의
3. **정체성 명시 (round 1)**: "각 프로젝트에 harness engineering 구성 — code.claude.com/docs 도구 활용 + 적재적소 component 생성 + GitHub 인기 저장소 벤치마크 + 서브에이전트, 에이전트 팀"
4. **결정적 이슈 라운드 2**: plugin 위임 + 두 층 + A2
5. **라운드 3~4**: B1 (small) → B2 (전면 재설계) 전환
6. **라운드 5**: 옵션 3 team 단독 + d2 + e3
7. **라운드 6**: agent fleet 5 case lifecycle
8. **라운드 7**: ps1/sh 비대칭 + install script 자체 의문 → "ai agent 가 만들어 줄 수 있다" 짚음
9. **라운드 8**: **B3 (install script 3개 모두 폐기) + 5번째 멤버 component-installer 분리 확정**

### 신 정체성 (단일 source 1차 sketch)

> **harness-meta = project harness composer + Claude Code ecosystem integrator + agent fleet maintainer**
>
> 대상 프로젝트를 분석하고, [code.claude.com/docs](https://code.claude.com/docs/) 의 Claude Code 도구 카탈로그 (docs + built-in slash command + plugin/MCP) 를 활용하여 적재적소에 필요한 harness 구성요소(subagent / agent team / hook / skill / slash command / statusline / MCP server / plugin)를 만들어 배치한다. mechanical install/update/cleanup 도 agent (component-installer) 가 직접 담당 — static install script 부재. GitHub 인기 저장소 + Claude Code release notes 를 정기 벤치마크하여 업그레이드를 검토하고, agent fleet 자체의 lifecycle (scope 확장 / 분할 / 신규 / 통합 / 삭제) 도 관리한다. 글로벌 자산은 `bootstrap/` 하위, 프로젝트 특화 자산은 `projects/<name>/.claude/` 하위 두 층 구조. Custom 과 built-in 충돌 / fleet evolution 모두 `audit → propose → 사용자 명시 결정 → apply` 워크플로우 (e3) 적용.

최종 정전화 host = `projects/meta/ARCHITECTURE.md` § 3. 다른 4 host 는 cross-ref 1줄.

### B2 + B3 scope phase 8건

| Phase | 내용 |
|---|---|
| **1** | Identity 5 host 재작성 + § 6.2 폐지 |
| **2** | 메타 v1~v3.21 → `_archive/` git mv |
| **3** | `bootstrap/agents/` scaffold + CLAUDE.md (정책 narrative) + **install script 3개 폐기 + 4 host narrative cleanup** |
| **4** | Claude Code 도구 카탈로그 매뉴얼 |
| **5** | 첫 agent team `project-harness-audit-team` (**5 멤버**, component-installer 분리) |
| **6** | `/harness-meta <name> --audit` opt-in |
| **7** | 벤치마크 cycle routine (schedule skill) |
| **8** | CHANGELOG breaking + 도그푸드 검증 |

### 5 멤버 team 구성 (옵션 3 + B3 정합)

| 멤버 | 책임 | 권한 | tools |
|---|---|---|---|
| `project-scanner` | 코드베이스 scan, 메타데이터 추출 | read-only | Read, Glob, Grep |
| `harness-gap-analyzer` | 현 harness 상태 진단 + gap + built-in 충돌 + fleet evolution case detection | read-only | Read, Grep, Bash |
| `claude-docs-mapper` | code.claude.com/docs + built-in slash + plugin/MCP 매핑 | read-only | mcp__context7__*, WebFetch |
| `component-proposer` | 적재적소 component proposal 생성 (4 case + 5 case 매트릭스 기반) | read-only | Write (proposal draft) |
| **`component-installer`** | **사용자 명시 결정 후 mechanical apply** (symlink/copy/backup/cleanup) | **write** | **Bash (New-Item SymbolicLink / Copy-Item / Remove-Item), Edit** |

e3 정책 정합 — proposer (read-only) ≠ installer (write) 책임 분리 = audit ≠ apply.

### Self-reference 표지

`self_reference_policy: pivot` — § 6.2 동결 정책 자체 폐지하므로 'avoid' 회피 표지 부적합. B2 + B3 scope 자체가 정체성 본질 직접 구현 (install layer 도 agent 흡수) = self-reference 회피 자연.

## 관련

- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) `v4.0_harness-composer-pivot` (in_progress)
- milestones.md: [`milestones.md`](milestones.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- 폐지 대상 paragraph: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2 (line 182~205)
- 정의 최종 host: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3
- context7 1차 source: library ID `/websites/code_claude`
- agent teams docs: `https://code.claude.com/docs/en/agent-teams`
- 두 층 구조 reference: [`../../../bootstrap/skills/CLAUDE.md`](../../../bootstrap/skills/CLAUDE.md)
- 폐기 대상 install script (B3): `../../../install.ps1` + `../../../install-skills.ps1` + `../../../install-skills.sh`
- 4 host narrative cleanup target: root CLAUDE.md + bootstrap/skills/CLAUDE.md + README + AGENTS
