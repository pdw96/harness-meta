# RESEARCH — v4.0

```json
{
  "version": "v4.0",
  "id": "harness-composer-pivot",
  "external": [
    {
      "source": "context7 library ID /websites/code_claude (7393 snippets, score 81.68, Source Reputation: High)",
      "verified": "2026-05-13 본 세션 안 resolve-library-id + query-docs 직접 시험 — URL path 보존 확인 (https://code.claude.com/docs/en/*)",
      "indexed_pages": [
        "https://code.claude.com/docs/en/sub-agents (subagent yaml frontmatter + .claude/agents/ 구조)",
        "https://code.claude.com/docs/en/agent-sdk/subagents (Agent SDK AgentDefinition python/typescript)",
        "https://code.claude.com/docs/en/agent-sdk/overview (Agent tool + allowedTools 필수)",
        "https://code.claude.com/docs/en/agent-teams (multi-instance Claude Code coordination, team lead pattern)",
        "https://code.claude.com/docs/en/best-practices (security-reviewer 정의 예 + .claude/agents/ 권장)"
      ]
    },
    {
      "source": "Subagent vs Agent Team 차이 (context7 evidence 직접 인용)",
      "quote": "Agent teams allow you to coordinate multiple Claude Code instances working together. One session acts as the team lead, assigning tasks and synthesizing results, while teammates work independently in their own context windows and communicate directly with each other. Unlike subagents, which run within a single session, you can interact with individual teammates directly.",
      "implication": "v4.0 phase-5 첫 적용 = subagents-based team (single session multi-delegation, Agent tool 호출). 실 multi-instance agent teams 패턴은 v4.1+ 후속 candidate (phase-5 narrative 안 기대 정합 표지)."
    },
    {
      "source": "agent team 자연어 prompt 패턴 (context7 query 결과)",
      "quote_excerpt": "I'm designing a CLI tool... Create an agent team to explore this from different angles: one teammate on UX, one on technical architecture, one playing devil's advocate.",
      "implication": "multi-perspective team 패턴 (devil's advocate / 다른 angle) 이 공식 권장. v4.0 phase-5 4 멤버 (scanner / analyzer / mapper / proposer) 도 multi-perspective 본질 정합."
    }
  ],
  "codebase": [
    {
      "category": "identity_host_grep",
      "evidence": "grep 'project harness composer|harness engineering|글로벌 통합 레이어|아키텍처 기록소' 9 files",
      "phase_1_cascade_targets": [
        "root CLAUDE.md (정체성 1차 sketch line 3~5)",
        "projects/meta/ARCHITECTURE.md (§ 3 working definition 단일 source)",
        "AGENTS.md (영문, cross-ref 1줄 추가 대상)",
        "README.md (cross-ref 1줄)",
        "projects/meta/CLAUDE.md (cross-ref 1줄)"
      ],
      "incidental_matches_archive_targets": [
        "projects/meta/milestones/v3.6/RESEARCH.md",
        "projects/meta/milestones/v1.4_cross-ref-propagation/RESEARCH.md",
        "projects/meta/milestones/v1.3_harness-engineering-definition/RESEARCH.md (정의 origin, archive 대상)"
      ]
    },
    {
      "category": "section_6_2_polish_range",
      "evidence": "grep '^### 6\\.2' projects/meta/ARCHITECTURE.md",
      "lines": "182 (paragraph 시작: '### 6.2 Lightweight 모드 정책 (v3.6_overengineering-audit 도입)') ~ ~210 (paragraph 끝)",
      "polish_strategy": "phase-1 안 paragraph 제거 또는 § 변환 (header 보존하되 본문 'v4.0 pivot 으로 폐지' narrative 1줄 표지). 단, § 6.2 선례 cross-ref (v3.6/v3.10/v3.11/v3.13~v3.21) 들이 archive 이전되므로 cross-ref 자동 무력화 — 추가 cleanup 불필요"
    },
    {
      "category": "archive_target_count",
      "evidence": "Glob 'projects/meta/milestones/v*/INTENT.md' + 'PLAN.md'",
      "counts": {
        "9_stage_era_INTENT_md": "21건 (v1.0/v1.1*/v1.2/v1.3/v1.4*/v2.1 + v3.0~v3.21)",
        "7_stage_era_PLAN_md": "6건 (v1.84~v1.88 + v2.0_workflow-word-fidelity)",
        "v4_0_self_exclude": "projects/meta/milestones/v4.0/ — 본 milestone, archive 외 위치 유지"
      },
      "strategy": "phase-2 안 `projects/meta/milestones/v3.21/` 이하 (그리고 v3.x/v2.x/v1.x 모두) → `projects/meta/milestones/_archive/v{X.Y}/` 일괄 git mv. v4.0/ 만 새 위치 (`projects/meta/milestones/v4.0/`) 유지"
    },
    {
      "category": "claude_commands_inventory",
      "evidence": "Glob 'claude/commands/*.md'",
      "current_count": 1,
      "files": ["claude/commands/harness-meta.md"],
      "phase_6_target": "동일 파일 안 `--audit` opt-in 분기 추가 (`if [ \"$mode\" = \"audit\" ]; then ... call audit-team ...`). freeform 기본 동작 보존"
    },
    {
      "category": "install_skills_pattern_inventory",
      "evidence": "bootstrap/skills/CLAUDE.md 읽기 결과",
      "pattern_elements": [
        "디렉토리 구조: bootstrap/skills/<category>/<name>/SKILL.md (2-tier source) → ~/.claude/skills/<name>/ (1-tier dest, install-skills 자동 평탄화)",
        "frontmatter: name + description + allowed-tools + (disable-model-invocation | user-invocable | model | effort)",
        "install flag: -All / -List / -CopyMode / -Cleanup (-Yes)",
        "backup 위치: ~/.claude/backups/skills/<name>.<YYYYMMDD-HHMMSS>/",
        "sentinel: _* prefix 모든 segment 거부 (regex ^[a-z0-9] + enumerate case _*)",
        "auto lookup: legacy <name> 단독 입력 시 <category>/<name> 자동 prefix"
      ],
      "phase_3_application": "install-agents.{ps1,sh} 는 위 패턴 그대로 복사 (destination 만 ~/.claude/agents/, 카테고리 audit/+dev-tools/ 동일)"
    },
    {
      "category": "tests_inactive_sentinel_reference",
      "evidence": "v3.6_overengineering-audit phase-2 도입 (memory project_v3.6_overengineering_audit)",
      "pattern": "tests/_inactive/ — smoke 22건 archive, _* sentinel 자동 skip (pre-commit hook + manual run 모두)",
      "phase_2_application": "projects/meta/milestones/_archive/ 동일 sentinel 정합. smoke (smoke-projects-scope-discipline.sh 등) 가 milestones/ 안 _archive/ skip 검증 필요"
    }
  ],
  "options": [
    {
      "decision_id": 1,
      "topic": "scope (B1 vs B2)",
      "rejected": "B1 (small, 4 phase — scaffold/migration 만)",
      "accepted": "B2 (전면 재설계, 8 phase)",
      "rationale": "B1 추천 사유 '거대 milestone 회피 (§ 6.2 정합)' 이 § 6.2 자체 폐지로 무너짐 (사용자 round 4 짚음). '전면 재설계' 본질 = 새 정체성 실 동작 구성요소가 v4.0 안에 있어야 의미 상실 해결"
    },
    {
      "decision_id": 2,
      "topic": "subagent vs agent team",
      "rejected": "옵션 1 (단일 subagent 만), 옵션 2 (둘 다 별개 instances)",
      "accepted": "옵션 3 (team 단독, 멤버 4 = 단일 subagent들. 단일 사용은 멤버 단독 호출)",
      "rationale": "정체성 '서브에이전트, 에이전트 팀도 만들 수 있어야 해' 의 '도' = 둘 다. team 이 본질 (분석/매핑/proposal = 3 책임 분리 자연), 단일은 멤버 자연 부속. context7 evidence (subagents vs agent teams 페이지 분리) 정합"
    },
    {
      "decision_id": 3,
      "topic": "/harness-meta <name> 동작 변경 범위",
      "rejected": "b2 (완전 교체 audit-driven 기본)",
      "accepted": "b1 (freeform 보존 + --audit opt-in)",
      "rationale": "기존 행동 회귀 0 + 새 기능 opt-in 안전. v4.x 안에서 default 전환 검토 가능"
    },
    {
      "decision_id": 4,
      "topic": "벤치마크 cycle 대상/주기",
      "rejected": "c2 (on-demand)",
      "accepted": "c1 (주 1회 routine, schedule skill, GitHub + Claude Code release notes)",
      "rationale": "정체성 '매일매일 최신 자료' 충족. schedule skill 이미 활성 (시스템 reminder 노출)"
    },
    {
      "decision_id": 5,
      "topic": "built-in slash command 활용 방식",
      "rejected": "d1 (매뉴얼만), d3 (자동 추적 별도)",
      "accepted": "d2 (매뉴얼 + agent team 안 활용 + /harness-meta orchestration 안 호출)",
      "rationale": "claude-docs-mapper 책임 (docs + built-in slash + plugin/MCP 매핑) 자연 통합. d3 의 신규 추적은 phase-7 벤치마크 cycle 안 자연 포함"
    },
    {
      "decision_id": 6,
      "topic": "conflict resolution + agent fleet lifecycle",
      "rejected": "e1 (자동 삭제), e2 (자동 mix)",
      "accepted": "e3 (audit → propose → 사용자 명시 결정) + 매트릭스 2종 (conflict 4 case + fleet 5 case)",
      "rationale": "9-stage 워크플로우 정체성 정합 (milestone 단위 명시 결정). 자동화 < 사용자 결정"
    },
    {
      "decision_id": 7,
      "topic": "install script (ps1/sh 비대칭 진단 후속)",
      "rejected": "옵션 A (.ps1 only 통일 — install script 유지) / B1 (install-agents 만 폐기) / B2 (install-skills.sh 추가 폐기) — 점진 폐기",
      "accepted": "B3 — install.ps1 + install-skills.ps1 + install-skills.sh 3 파일 모두 폐기 + 4 host narrative cleanup + agent (component-installer) 가 mechanical 작업 흡수",
      "rationale": "사용자 round 8 짚음 ('script 가 없어도 각 ai agent 가 프로젝트 분석해서 만들어 줄 수 있다'). 정체성 본질 정합 — install script = static mechanical layer / agent = dynamic audit + propose + apply (e3 정책 자연). ps1/sh 미러 부담 자체 소멸. 첫 진입 (~/.claude/ 비어있을 때) = Claude Code 안 자연어 호출 (README + root CLAUDE.md 안 1줄 instruction)"
    },
    {
      "decision_id": 8,
      "topic": "team 멤버 수 (component-proposer 단일 vs proposer + installer 분리)",
      "rejected": "4 멤버 (component-proposer 가 분석+제안+apply 통합)",
      "accepted": "5 멤버 (component-proposer (read-only 제안) + component-installer (write apply) 책임 분리)",
      "rationale": "e3 정책 정합 — propose ≠ apply 책임 분리 자연. proposer = 분석 + draft (read-only, 위험 0) / installer = 사용자 명시 결정 후 mechanical apply (Bash New-Item SymbolicLink / Copy-Item / Remove-Item / backup/cleanup). 단일 멤버에 분석+apply 통합 시 e3 워크플로우 안 'apply 직전 사용자 게이트' 자연성 상실"
    }
  ],
  "risks_identified": [
    "(1) 5 host identity paragraph cascade drift — 5 host 한 번에 정전화 시 wording 미세 차이. mitigation: 단일 source (ARCHITECTURE § 3) + 4 host cross-ref 1줄 (v1.4_cross-ref-propagation 패턴), smoke-cross-ref autofix 활용",
    "(2) § 6.2 폐지 후 자기참조 milestone 재발 — 동결 정책 폐지 후 cycle 재발 risk. mitigation: 새 정체성이 자연 가드레일 (자기참조 milestone 자체가 새 정체성에 부합 안 함), B2 scope 자체가 본질 직접 구현",
    "(3) git mv history 보존 ≥ 95% threshold — _archive/ 이전 시 git rename detection 기본 50% 임계. mitigation: phase-2 안 `git log --follow <file>` 검증 + per-file 확인 + git config diff.renames=true 활용",
    "(4) smoke 회귀 (_archive/ sentinel) — sentinel 자동 skip 미작동 시 inactive 22 + active 6 분류 깨짐. mitigation: tests/_inactive/ 선례 grep 검증, phase-2 안 smoke 직접 실행 확인 step",
    "(5) install-agents.{ps1,sh} ↔ install-skills 패턴 충돌 — 두 install script 가 ~/.claude/{skills,agents}/ 동시 처리 시 backup/conflict 정책 차이. mitigation: install-skills 패턴 그대로 복사, destination 만 차별 (~/.claude/skills/ vs ~/.claude/agents/)",
    "(6) phase-5 LOC 비대화 — 4 멤버 markdown + bootstrap/agents/CLAUDE.md + install-agents + matrix narrative 합쳐 ~1000 LOC risk. mitigation: 4 멤버는 frontmatter + 짧은 prompt ≤ 50 line each, narrative 는 bootstrap/agents/CLAUDE.md 단일 source",
    "(7) /harness-meta <name> --audit 동작 회귀 — freeform 분기 영향. mitigation: phase-6 conditional 분기 (`if mode==audit then call team else freeform`), freeform default 유지",
    "(8) 벤치마크 cycle routine 산출물 host 미정 — schedule skill cron 결과 어디로? mitigation: DESIGN 단계에서 ROADMAP candidate vs issue draft vs 별도 host 결정",
    "(9) 도그푸드 audit run 결과 모순 — audit-team 이 자기 자신 추가 멤버 제안 시 in-loop 처리 risk. mitigation: phase-8 narrative 안 'v4.1+ 후속 candidate 만 거명, in-loop 처리 금지' 명시",
    "(10) CHANGELOG breaking `!` 마커 cascade — semver 정합. mitigation: phase-8 안 root README + CHANGELOG + .harness.toml schema 영향 검토 + grep cascade 검증",
    "(11) install script 폐기 후 첫 진입 (clone 후 ~/.claude/ 비어있을 때) onboarding 자연성 — 사용자가 어떻게 첫 trigger? mitigation: README + root CLAUDE.md 안 1줄 instruction (예: 'Claude Code 안에서 harness-meta 설치해줘 호출 → 메인 Claude 가 Bash (PowerShell New-Item -ItemType SymbolicLink) 로 자동 진행'). component-installer subagent 또는 메인 Claude 가 mechanical 작업",
    "(12) 기존 사용자 환경 영향 — ~/.claude/skills/ 의 5 symlink (ai-ready-scorer / harness-plan-verify / harness-roadmap-update / mindvault / developer-profile) 가 install-skills.ps1 으로 설치된 상태. 폐기 후 reinstall 또는 cleanup 시 누가? mitigation: phase-3 narrative 안 migration step 명시 — 기존 symlink 보존 (현 상태 유효), 신규 component 또는 정리 필요 시 component-installer 호출 (또는 메인 Claude 직접). 단순 deletion 회피"
  ]
}
```

## external

### context7 `/websites/code_claude` 검증 결과 (사전 완료 2026-05-13)

- **library ID**: `/websites/code_claude`
- **Snippets**: 7393 (Source Reputation: High, Benchmark Score: 81.68)
- **URL path 보존**: `https://code.claude.com/docs/en/*` 정확 인덱싱

### Subagent vs Agent Team 본질 차이 (context7 직접 인용)

> "Agent teams allow you to coordinate multiple Claude Code instances working together. One session acts as the team lead, assigning tasks and synthesizing results, while teammates work independently in their own context windows and communicate directly with each other. Unlike subagents, which run within a single session, you can interact with individual teammates directly."

- **Subagents** (`.claude/agents/<name>.md`): single session multi-delegation, Agent tool 호출
- **Agent teams** (`code.claude.com/docs/en/agent-teams`): multi-instance Claude Code 세션 coordination, team lead + teammates 독립 context window

**v4.0 phase-5 첫 적용 = subagents-based team** (옵션 3, single session multi-delegation 패턴). 실 multi-instance agent teams 패턴은 v4.1+ 후속 (phase-5 narrative 안 기대 정합 표지).

## codebase

### 5 identity host (phase-1 cascade 대상)

| Host | 역할 |
|---|---|
| root `CLAUDE.md` | 1차 sketch 위치 (한국어, 사용자 primary context) |
| `projects/meta/ARCHITECTURE.md` § 3 | **단일 source** (working definition + 5요소 매트릭스) |
| `AGENTS.md` | 영문 cross-ref 1줄 |
| `README.md` | cross-ref 1줄 |
| `projects/meta/CLAUDE.md` | cross-ref 1줄 (lazy load subdir guide) |

### § 6.2 폐지 범위

- **시작**: ARCHITECTURE.md line 182 (`### 6.2 Lightweight 모드 정책 (v3.6_overengineering-audit 도입)`)
- **끝**: ~line 210 (paragraph 끝, ~30 line 범위)
- **선례 cross-ref 자동 무력화**: 메타 v3.6/v3.10~v3.21 entry 들이 `_archive/` 이전 후 § 6.2 cross-ref 자동 무력화 — 추가 cleanup 불필요

### Archive 대상 메타 milestone 카운트

- 9-stage era INTENT.md: **21건** (v1.0~v2.1 의 v1.0/v1.1*/v1.2/v1.3/v1.4*/v2.1 + v3.0~v3.21)
- 7-stage era PLAN.md: **6건** (v1.84~v1.88 + v2.0_workflow-word-fidelity)
- 4-tier era 보존 (v1.84~v1.88 이미 PLAN.md 포함, 5건)
- **v4.0/ 자체는 보존** — archive 외 위치 (`projects/meta/milestones/v4.0/` 유지)

### `claude/commands/` slash command 현 카운트

- **1 건**: `claude/commands/harness-meta.md`
- phase-6 동작 변경 host = 동일 파일 안 `--audit` opt-in 분기 추가

## options (post-decision evidence)

8 결정 확정 (B2 / 옵션 3 / b1 / c1 / d2 / e3 + 매트릭스 2종 / **B3 install script 폐기 / 5 멤버 component-installer 분리**). 각 결정의 reject vs accept 옵션 + 사유는 JSON `options_post_decision[]` 명시. 추가 결정적 이슈 없음 (사용자 round 8 명시).

## risks_identified (10건)

JSON `risks_identified[]` 명시. DESIGN 단계 risk_mitigation 입력 직접 적용 — phase 별 mitigation 분배:

- phase-1: risks (1), (2)
- phase-2: risks (3), (4)
- phase-3: risks (5), (6) 부분
- phase-4: (없음)
- phase-5: risks (6) 부분, (9) 부분
- phase-6: risks (7)
- phase-7: risks (8)
- phase-8: risks (9), (10)

## narrative

본 RESEARCH 는 사용자 6 결정 (B2 / 옵션 3 / b1 / c1 / d2 / e3) 의 evidence 정리 + 현 상태 정량 grep + context7 외부 source 검증 + 10 risks 식별. 모든 결정이 이미 INTENT 단계에서 확정 — RESEARCH 의 핵심 산출은:

(a) **external evidence** — context7 검증 + agent teams docs 차이 명시 (subagents-based vs multi-instance teams)
(b) **codebase evidence** — 5 host 위치 + § 6.2 line 182~205 + archive 대상 27건 메타 + claude/commands/ 1건
(c) **options post-decision** — 6 결정 reject/accept 사유 정전화
(d) **10 risks** — DESIGN 안 risk_mitigation 직접 입력

본 milestone 자체가 § 6.2 폐지 milestone — lightweight 모드 적용 불가 (정책 자체가 폐지 대상). 대신 self_reference_policy: 'pivot' 표지로 의도성 명시. 5 관점 subagent 검토는 DESIGN 단계에서 진행 (lightweight 모드 거부, full review).

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- milestones: [`milestones.md`](milestones.md)
- context7 library ID: `/websites/code_claude` (7393 snippets, score 81.68)
- agent teams docs: `https://code.claude.com/docs/en/agent-teams`
- subagents docs: `https://code.claude.com/docs/en/sub-agents`
- best practices (security-reviewer 정의 예): `https://code.claude.com/docs/en/best-practices`
- 5 host 1차 source (정의 정전화 target): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3
- 폐지 대상 paragraph: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2 (line 182~205)
- 두 층 구조 reference: [`../../../bootstrap/skills/CLAUDE.md`](../../../bootstrap/skills/CLAUDE.md)
- `_archive/` sentinel 선례: `tests/_inactive/` (v3.6_overengineering-audit phase-2)
- v1.4_cross-ref-propagation 선례 (5 host cascade 패턴): ROADMAP entry
