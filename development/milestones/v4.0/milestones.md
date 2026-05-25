# milestones — v4.0

```json
{
  "version": "v4.0",
  "title": "정체성 전면 재설계 — project harness composer + Claude Code ecosystem integrator + agent fleet maintainer (B2 scope, 8 phase, breaking major bump v3→v4)",
  "status": "in_progress",
  "self_reference_policy": "pivot",
  "self_reference_rationale": "본 milestone 은 워크플로우 self-improvement 가 아닌 repo 정체성 전면 재정의 — ARCHITECTURE.md § 6.2 동결 정책 자체를 폐지하는 더 큰 단위. 'avoid' 회피 표지 부적합 → 새 정체성 ('project harness composer + Claude Code ecosystem integrator + agent fleet maintainer') 으로의 pivot 표지. B2 scope (전면 재설계) 자체가 새 정체성 실 동작 구성요소를 v4.0 안에 직접 구현 = self-reference 회피 자연 (도그푸드 정합). 추가 정체성 본질 적용 — install script (mechanical layer) 폐기 + agent (dynamic) 가 install/update/cleanup 흡수 (B3 채택).",
  "sub_milestones": [
    {
      "phase": 1,
      "title": "Identity 5 host 재작성 + § 6.2 폐지 + 3 host 안 install narrative cleanup 통합 (옵션 B) — projects/meta/ARCHITECTURE.md (§ 3.1 끝 paragraph + § 6.2 line 182~205 제거 + § 6.1 끝 폐지 표지) + root CLAUDE.md (정체성 + install 섹션 cleanup) + AGENTS.md (tagline + Commands 섹션 cleanup) + README.md (tagline + Installation 섹션 cleanup) + projects/meta/CLAUDE.md (정체성 cross-ref 확장)",
      "status": "pending",
      "commit": null
    },
    {
      "phase": 2,
      "title": "메타 v1.0 ~ v3.21 → projects/meta/milestones/_archive/ git mv (history 보존 ≥ 95%) + ROADMAP era 분리 표지 + smoke _* sentinel skip 검증 (tests/_inactive/ 선례 정합). upbit (v1.4~v1.16) 현 위치 유지 (A2)",
      "status": "pending",
      "commit": null
    },
    {
      "phase": 3,
      "title": "bootstrap layer 재구성 (옵션 B 후속) — bootstrap/agents/ scaffold (audit/, dev-tools/) + bootstrap/agents/CLAUDE.md (두 층 + conflict 4 case + fleet 5 case + install/update/cleanup narrative — component-installer 담당) + install.ps1 + install-skills.{ps1,sh} 3 파일 폐기 + bootstrap/skills/CLAUDE.md 배포 섹션 cleanup (3 host install narrative cleanup 은 phase-1 안 통합 완료)",
      "status": "pending",
      "commit": null
    },
    {
      "phase": 4,
      "title": "Claude Code 도구 카탈로그 매뉴얼 (bootstrap/claude-code-catalog/README.md 또는 동치 host) — code.claude.com/docs (context7 /websites/code_claude primary) + built-in slash command 인벤토리 + plugin/MCP 인벤토리 통합 + 자주 묻는 query 카탈로그 ≥ 3건 (subagents / hooks / agent-teams)",
      "status": "pending",
      "commit": null
    },
    {
      "phase": 5,
      "title": "첫 agent team `project-harness-audit-team` — 5 멤버 subagent 정의 (project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer (read-only 제안) / component-installer (write apply, e3 정책 분리)) + orchestration narrative (호출 순서 + 결과 통합 + e3 정책 적용). bootstrap/agents/audit/ 안 배치",
      "status": "pending",
      "commit": null
    },
    {
      "phase": 6,
      "title": "/harness-meta <name> 동작 변경 — claude/commands/harness-meta.md 안 `--audit` opt-in 분기 추가 (audit team 자동 호출 + component proposal 산출 + 사용자 명시 결정 후 component-installer 호출). freeform 기본 동작 보존 (b1 — 회귀 0)",
      "status": "pending",
      "commit": null
    },
    {
      "phase": 7,
      "title": "벤치마크 cycle routine — `schedule` skill 활용 주 1회 cron (GitHub 인기 repo + Claude Code release notes/changelog 검토). 산출물 = fleet evolution proposal + conflict resolution proposal (e3 정책 자동 생성, 사용자 명시 결정 대기). 산출물 host = ROADMAP candidate draft",
      "status": "pending",
      "commit": null
    },
    {
      "phase": 8,
      "title": "CHANGELOG.md [v4.0] entry (breaking `!` 마커) + root README semver major bump narrative + 도그푸드 검증 (harness-meta 자체에 project-harness-audit-team audit run, 결과 합리성 확인, v4.1+ 후속 candidate 만 거명)",
      "status": "pending",
      "commit": null
    }
  ]
}
```

## narrative

사용자 명시 발의 (A_user trigger, 2026-05-13 세션 `/clear` 직후 진단 + 새 정체성 정의 라운드 8회) — 8 결정 확정:

| # | 결정 | 채택 옵션 | 사유 |
|---|---|---|---|
| 1 | scope | B2 (전면 재설계, 8 phase) | B1 근거 (§ 6.2 동결) 자체가 폐지 대상 |
| 2 | subagent vs team | 옵션 3 (team 단독) | 정체성 "team 도" 본질 + 단일은 멤버 자연 부속 |
| 3 | `/harness-meta` 동작 | b1 (freeform 보존 + `--audit` opt-in) | 회귀 0 |
| 4 | 벤치마크 cycle | c1 (주 1회 routine, schedule skill) | "매일매일 최신 자료" 정합 |
| 5 | built-in slash 활용 | d2 (매뉴얼 + team + orchestration) | claude-docs-mapper 자연 매핑 |
| 6 | conflict + fleet lifecycle | e3 (audit → propose → 사용자 결정) | 9-stage 워크플로우 본질 |
| **7** | **install script** | **B3 (모두 폐기, agent 가 mechanical 흡수)** | **정체성 본질 정합 — script 미러 부담 소멸** |
| **8** | **team 멤버 수** | **5 (component-installer 분리, proposer read-only / installer write)** | **e3 정책 정합 — propose ≠ apply 책임 분리** |

매트릭스 2종 (e3 정책 적용):

- **conflict resolution (4 case)**: superset (delete) / 유사 다른 책임 (mix) / 부분 cover (mix default + 보완) / 무관 (둘 다 keep)
- **agent fleet lifecycle (5 case)**: scope 확장 / 분할 / 신규 추가 / 통합 / 삭제

## 관련

- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) `v4.0_harness-composer-pivot`
- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- 1차 source: 본 세션 사용자 발의 (2026-05-13, `/clear` 직후 8 라운드)
- 폐지 대상: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2 (line 182~205)
- 정의 최종 host: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3
- context7 1차 source: library ID `/websites/code_claude` (7393 snippets, score 81.68)
- 두 층 구조 reference: [`../../../bootstrap/skills/CLAUDE.md`](../../../bootstrap/skills/CLAUDE.md)
- agent teams docs: `https://code.claude.com/docs/en/agent-teams`
- 폐기 대상 install script: `../../../install.ps1` + `../../../install-skills.ps1` + `../../../install-skills.sh`
