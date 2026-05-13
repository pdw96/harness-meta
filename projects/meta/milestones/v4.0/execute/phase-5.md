# phase-5 — 첫 agent team `project-harness-audit-team` (5 멤버 + orchestration)

```json
{
  "phase": 5,
  "version": "v4.0",
  "id": "harness-composer-pivot",
  "title": "첫 agent team project-harness-audit-team — 5 멤버 subagent 정의 + orchestration narrative",
  "status": "in_progress",
  "commit": null,
  "changes": [
    "bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md 신규 (orchestration narrative, D8 sequence scanner→analyzer→mapper→proposer→사용자 게이트→installer, 5 멤버 매트릭스, 사용 case 3건)",
    "project-scanner.md 신규 (멤버 1/5, tools: Read+Glob+Grep, model: sonnet) — 코드베이스 scan + 메타데이터 JSON",
    "harness-gap-analyzer.md 신규 (멤버 2/5, tools: Read+Grep+Bash, model: sonnet) — 3 축 gap detection (harness gap + builtin conflict 4 case + fleet evolution 5 case)",
    "claude-docs-mapper.md 신규 (멤버 3/5, tools: mcp__plugin_context7_context7__*+WebFetch, model: sonnet) — gap → Claude Code 도구 카탈로그 매핑",
    "component-proposer.md 신규 (멤버 4/5, tools: Write, model: sonnet) — proposal draft markdown 생성 + 사용자 결정 게이트 표지 (e3)",
    "component-installer.md 신규 (멤버 5/5, tools: Bash+Edit+Read, model: opus) — D7 sequence (backup → symlink → fallback → cleanup) + Bash 명령 화이트리스트 (D1 security)"
  ],
  "affected_files": [
    "bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md (신규)",
    "bootstrap/agents/audit/project-harness-audit-team/project-scanner.md (신규)",
    "bootstrap/agents/audit/project-harness-audit-team/harness-gap-analyzer.md (신규)",
    "bootstrap/agents/audit/project-harness-audit-team/claude-docs-mapper.md (신규)",
    "bootstrap/agents/audit/project-harness-audit-team/component-proposer.md (신규)",
    "bootstrap/agents/audit/project-harness-audit-team/component-installer.md (신규)"
  ],
  "criteria_met": {
    "INTENT_sc_8": "첫 agent team project-harness-audit-team — 5 멤버 (D1 tools allowlist + model 정합, installer 만 opus 위험 격상) + orchestration (D8 순차 sequence + 사용자 게이트 between proposer 와 installer + 병렬 가능성 narrative 표지)"
  },
  "design_compliance": {
    "D1_tools_allowlist": "5 멤버 tools 정확 적용 (scanner [Read,Glob,Grep] / analyzer [Read,Grep,Bash] / mapper [context7 + WebFetch] / proposer [Write] / installer [Bash+Edit+Read])",
    "D7_mechanical_sequence": "component-installer.md 안 D7 4 step (backup → symlink → copy fallback → cleanup retention) 명시",
    "D8_orchestration_sequence": "CLAUDE.md 안 순차 호출 + 병렬 가능성 narrative + 사용자 게이트 between proposer 와 installer",
    "D1_security_whitelist": "component-installer.md 안 Bash 명령 화이트리스트 명시 (New-Item / Copy-Item / Move-Item / Remove-Item / Test-Path / Get-ChildItem / mkdir / ln / cp / mv / rm-rf cleanup 만)"
  }
}
```

## narrative

### 5 멤버 책임 매트릭스 (D1)

| 멤버 | 권한 | model | system prompt LOC |
|---|---|---|---|
| project-scanner | read-only | sonnet | ~45 |
| harness-gap-analyzer | read-only | sonnet | ~50 |
| claude-docs-mapper | read-only | sonnet | ~55 |
| component-proposer | Write only (draft) | sonnet | ~60 |
| component-installer | write apply | **opus** | ~70 |

### Orchestration sequence (D8)

scanner → analyzer → mapper → proposer → **사용자 게이트** → installer.

병렬 가능성 narrative 표지 — Steps 1~3 read-only 이므로 Step 1 결과 받으면 Step 2/3 병렬 가능. 단순성 우선 순차 default.

### e3 정책 정합

- propose ≠ apply 책임 분리 (proposer ↔ installer 사이 사용자 게이트)
- proposer = Write (draft) / installer = write apply (mechanical)
- 사용자 결정 부재 시 installer 호출 금지

### LOC 추정 vs 실 (mitigation D6 phase-5 LOC 비대화 risk)

DESIGN risk_mitigation (6) "5 멤버는 frontmatter + 짧은 prompt ≤ 50 line each" — 실제는 ~45~70 line. 일부 overflow (component-installer 70 line) — D7 sequence + 화이트리스트 narrative 가 명시 필요. 수용 trade-off.

## commit (pending 사용자 확인)

```
feat(meta): v4.0 phase-5 — 첫 agent team project-harness-audit-team (5 멤버 + orchestration)

bootstrap/agents/audit/project-harness-audit-team/ 신규 디렉토리 — 5 멤버 markdown:
- project-scanner (read-only, sonnet) — 코드베이스 scan + 메타데이터 JSON
- harness-gap-analyzer (read-only, sonnet) — 3 축 gap detection (harness + 4 case + 5 case)
- claude-docs-mapper (read-only, sonnet) — gap → Claude Code 도구 카탈로그 매핑 (context7)
- component-proposer (Write draft, sonnet) — proposal draft markdown + e3 게이트 표지
- component-installer (write apply, opus) — D7 sequence + Bash 명령 화이트리스트 (D1 security)

CLAUDE.md — orchestration (D8 순차 + 사용자 게이트 between proposer/installer) +
사용 case (--audit / 자연어 / 도그푸드).
```

## 관련

- INTENT: [`../INTENT.md`](../INTENT.md) — success_criteria (8)
- DESIGN: [`../DESIGN.md`](../DESIGN.md) D1 / D7 / D8
- bootstrap/agents/CLAUDE.md (단일 source 정책): [`../../../../bootstrap/agents/CLAUDE.md`](../../../../bootstrap/agents/CLAUDE.md)
- 도구 카탈로그 (mapper 1차 source): [`../../../../bootstrap/claude-code-catalog/README.md`](../../../../bootstrap/claude-code-catalog/README.md)
