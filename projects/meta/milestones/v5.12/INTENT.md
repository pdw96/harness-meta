# INTENT — v5.12 bundled-skill-narrative-cleanup

```json
{
  "id": "v5.12_bundled-skill-narrative-cleanup",
  "title": "/review·/security-review·/init 'Skill tool 안 invoke 가능 built-in command' 분류 정확화 + v5.10 mapper hallucination cascade 정정 (audit chain hallucination cycle 3 도달)",
  "goal": "harness-meta 안 active source (agents/ + bootstrap/ + projects/upbit/audit-2026-05-14/proposal-draft.md) 7 파일 안 '`/review`, `/security-review`, `/init`' 분류 narrative 를 spec source 정확 표현 ('Skill tool 안 discover + execute 가능 built-in command') 으로 정확화 + v5.10 audit-2026-05-18/mapper-output.md 6 위치 inline 정정 + v5.10 diff-vs-v1.17.md 1 위치 inline 정정 — 총 9 파일 cascade. v5.10 mapper hallucination ('/review = bundled skill', built-in command 가 아닌) = drift origin 식별 + 정정 narrative cascade.",
  "motivation": "v5.11 PROPOSE.next_candidates#4 (`meta-review-bundled-skill-narrative-cleanup`) carry-over — 사용자 명시 발의 (A_user, 2026-05-18). Stage E APPROVE 게이트 5 관점 (사용자 명시 요구) subagent 검토 안 spec-drift agent 가 발견한 decisive issue 흡수 → milestone scope 재정의. context7 spec 정확 분류 (Glossary > B > Bundled skills + Skills §Bundled skills): **Bundled skills = prompt-based playbook (`/simplify`, `/batch`, `/debug`, `/loop`, `/claude-api`)**. **Built-in commands = fixed-logic (`/init`, `/review`, `/security-review`, `/compact`, `/doctor` 등)**. 일부 built-in (`/init`, `/review`, `/security-review`) = Skill tool 안 discover + execute 가능 (별 sub-classification, 직교 — bundled skill 범주 아님). **v5.10 mapper-output.md L100/L102/L105/L180/L198/L215 = '/review = bundled skill' 잘못된 분류 = drift origin = audit chain hallucination cycle 3 도달** (cycle 1 v5.10 proposer 12 항목 / cycle 2 v5.11 scanner `claude_md_in_repo: false` / cycle 3 본 v5.12 발견 mapper '/review 분류'). memory feedback_subagent_fact_hallucination_correction.md cycle 3 direct evidence + v5.11 PROPOSE#1 trigger 충족. v1.17 proposal-draft '/review built-in' 표현 = spec 정합 (built-in command 정확) — v5.10 mapper 정정 narrative 자체가 drift cascade origin. v3.21 narrative 정전화 3 단계 패턴 + v5.7 spec-drift spike 3 단계 패턴 도그푸드 cycle 추가.",
  "success_criteria": [
    "sc_1: agents/claude-docs-mapper.md 안 frontmatter description + L34 안 '`/review`·`/security-review`·`/init`' 거명 위치 안 'Skill tool 안 invoke 가능 built-in command' 분류 narrative 정확화 (spec source URL `code.claude.com/docs/en/skills` cross-ref)",
    "sc_2: agents/harness-gap-analyzer.md 안 L43 다음 (4 case 매트릭스 footnote) 안 정확 분류 narrative 추가",
    "sc_3: agents/component-proposer.md 안 L71 '/review' inline 정확화 + 표 다음 footnote 추가",
    "sc_4: agents/project-harness-audit-team/CLAUDE.md 안 L17 다음 footnote 추가",
    "sc_5: bootstrap/agents/CLAUDE.md 안 L155 다음 (4 case 매트릭스 footnote) 안 정확 분류 narrative 추가",
    "sc_6: bootstrap/claude-code-catalog/README.md 안 L55 다음 (built-in slash command 표 footnote) 안 정확 분류 narrative 추가",
    "sc_7: projects/upbit/audit-2026-05-14/proposal-draft.md 안 L218 + L221 + L224 + L226 + L421 5 위치 footnote 추가 ('/review built-in' = 정확, Skill tool invocable sub-classification 명시)",
    "sc_8: projects/upbit/audit-2026-05-18/mapper-output.md 안 L100 + L102 + L105 + L180 + L198 + L215 6 위치 inline 정정 ([v5.12 정정] blockquote footnote 추가 — v5.10 mapper hallucination = drift origin 명시, audit trail 보존 v5.11 L1 패턴 정합)",
    "sc_9: projects/meta/milestones/v5.10/diff-vs-v1.17.md 안 L87 다음 D3 § narrative 안 [v5.12 정정] footnote 추가 (v5.10 D3 narrative 자체가 drift cascade)",
    "sc_10: v5.7 spec-drift spike 3 단계 패턴 도그푸드 — RESEARCH 안 context7 skills + glossary + slash-commands + whats-new + changelog 5 source 재검증 spike + DESIGN.D2.exact_text 1차 source narrative 명시 + EXECUTE 정확 삽입 + VERIFY grep 키워드 3건 (`Skill tool 안 invoke`, `built-in command`, `code.claude.com/docs/en/skills`) 검증",
    "sc_11: smoke 14 hook 모두 PASS, 회귀 0"
  ],
  "out_of_scope": [
    "ARCHITECTURE.md L69 + CLAUDE.md L3 + AGENTS.md L3 + README.md L4 안 'built-in slash command' 일반 표현 정정 — 일반 Claude Code 도구 카탈로그 인용 narrative 자연 (해당 표현 안 `/review`·`/security-review`·`/init` 거명 부재, code.claude.com/docs/ 도구 전반 인용)",
    "다른 built-in command (`/doctor`, `/config`, `/loop`, `/clear`, `/model`, `/help` 등) 분류 narrative 변경 — spec 안 '`/init`, `/review`, `/security-review`' 3 명령만 Skill tool 안 invocable 명시, 다른 built-in command 는 Skill tool invocable 부재 (`/loop` 은 bundled skill, 별도)",
    "harness-meta 외부 자기 (예: upbit repo `~/upbit/`) 안 narrative 정정 — projects/upbit/audit-2026-05-14/proposal-draft.md + audit-2026-05-18/mapper-output.md 는 harness-meta 안 거주하여 본 scope 포함, 단 upbit repo 본체 (`~/upbit/`) 안 narrative 는 외부 scope",
    "v5.10 PROPOSE.md / v5.11 PROPOSE.md next_candidates narrative 안 v5.10 mapper 정정 cycle 거명 변경 — 후속 milestone 거명 본질 보존 (forward-only policy 정합)",
    "claude/commands/harness-meta.md Stage A 안 audit chain fact 검증 절차 추가 — v5.11 PROPOSE#1 (audit-chain-fact-verification-protocol-procedure) 별 후속 milestone scope. 본 v5.12 안 cycle 3 도달 = v5.11 PROPOSE#1 trigger 충족 → PROPOSE.next_candidates#1 진급 등재 가능"
  ],
  "dependencies": [
    "선행: v5.11_audit-chain-fact-verification-discipline (PROPOSE#4 carry-over source, completed 2026-05-18)",
    "선행: v5.10_external-audit-team-second-call-with-diff (mapper-output.md = drift origin, completed 2026-05-18)",
    "선행: v1.17_upbit-audit-team-first-call (proposal-draft.md = drift cascade target, completed 2026-05-14)",
    "후행: 본 milestone 완료 시 audit chain hallucination cycle 3 lesson + v5.11 PROPOSE#1 trigger 충족 (next_candidate 진급 가능)"
  ]
}
```

## narrative

본 INTENT 는 v5.12 milestone 의 의도 — spec-drift agent 발견 (Stage E APPROVE 5 관점 검토) decisive issue 흡수 후 scope 재정의. v5.10 mapper-output.md '/review = bundled skill' 분류가 spec drift = audit chain hallucination cycle 3 도달 → 9 파일 cascade 정정.

### context7 spec source 정확 분류 (5 source 재검증)

1. `code.claude.com/docs/en/glossary` > B > Bundled skills: "Bundled skills are **prompt-based playbooks** included with Claude Code, such as `/batch`, `/simplify`, `/debug`, and `/loop`. **Unlike fixed-logic built-in commands**, bundled skills provide Claude with detailed prompts..."
2. `code.claude.com/docs/en/skills` § Bundled skills: "Claude Code includes several bundled skills like `/simplify`, `/batch`, `/debug`, `/loop`, and `/claude-api`. These skills are prompt-based..."
3. `code.claude.com/docs/en/slash-commands` § Bundled skills: "pre-installed bundled skills like `/simplify`, `/batch`, `/debug`, `/loop`, `/claude-api` ... unlike most built-in commands that execute fixed logic"
4. `code.claude.com/docs/en/skills` § Restrict Claude's skill access: "Built-in commands like `/init`, `/review`, and `/security-review` are available through the Skill tool, while others like `/compact` are not."
5. `code.claude.com/docs/en/whats-new/2026-w16` + `changelog`: "Claude can now discover and execute built-in commands such as `/init`, `/review`, and `/security-review` through the Skill tool."

**정확 분류 narrative**:

- **Bundled skills** (prompt-based playbook 정의): `/simplify`, `/batch`, `/debug`, `/loop`, `/claude-api`
- **Built-in commands** (fixed-logic): `/init`, `/review`, `/security-review`, `/compact`, `/doctor` 등 (fixed-logic execution)
- 일부 built-in (`/init`, `/review`, `/security-review`) = Skill tool 안 discover + execute 가능 (별 sub-classification, **bundled skill 범주 아님**)

### audit chain hallucination cycle 3 도달

- **cycle 1** (v5.10): component-proposer 12 항목 표 hallucination (django/ai-ready-scorer 등 upbit 무관) → synthesizer overwrite (memory feedback_subagent_fact_hallucination_correction.md L1 origin)
- **cycle 2** (v5.11): project-scanner `claude_md_in_repo: false` hallucination → inline 정정 archive (v5.11 L6 lesson)
- **cycle 3 (본 v5.12 발견)**: claude-docs-mapper `/review = bundled skill` 분류 hallucination → drift cascade 7 파일 (v5.10 mapper-output.md 6 위치 + diff-vs-v1.17.md 1 위치) → 본 v5.12 = 9 파일 cascade 정정

**memory feedback_subagent_fact_hallucination_correction.md cycle 3 direct evidence 도달**. **v5.11 PROPOSE#1 trigger 조건 충족** (사용자 명시 발의 ∧ cycle 3 도달) → next_candidate 진급 가능 (PROPOSE.md 안 등재).

### scope 9 파일

| # | 파일 | 안 'built-in' 또는 '/review' 표현 거주 위치 |
|:-:|------|----------------------|
| 1 | `agents/claude-docs-mapper.md` | description (frontmatter) + L34 inline 정확화 + ## Role 다음 § Note 추가 |
| 2 | `agents/harness-gap-analyzer.md` | L43 다음 매트릭스 footnote |
| 3 | `agents/component-proposer.md` | L71 inline 정확화 + 표 다음 footnote |
| 4 | `agents/project-harness-audit-team/CLAUDE.md` | L17 다음 표 footnote |
| 5 | `bootstrap/agents/CLAUDE.md` | L155 다음 매트릭스 footnote |
| 6 | `bootstrap/claude-code-catalog/README.md` | L55 다음 표 footnote |
| 7 | `projects/upbit/audit-2026-05-14/proposal-draft.md` | L218 + L221 + L224 + L226 + L421 footnote (5 위치) |
| 8 | `projects/upbit/audit-2026-05-18/mapper-output.md` | **L100 + L102 + L105 + L180 + L198 + L215 inline [v5.12 정정] footnote (6 위치)** |
| 9 | `projects/meta/milestones/v5.10/diff-vs-v1.17.md` | **L87 다음 D3 § narrative 안 [v5.12 정정] footnote** |

### 정정 본질 (D2 새 결정)

context7 spec source 5 location 안 정확 분류:

> `/review`·`/security-review`·`/init` 는 Skill tool 안 discover + execute 가능 built-in command (fixed-logic, `code.claude.com/docs/en/skills` + `glossary` 명시). Bundled skill (prompt-based playbook, e.g., `/simplify`, `/batch`, `/debug`, `/loop`, `/claude-api`) 범주 아님 — 별 sub-classification, 직교.

### v5.10 mapper-output.md 6 위치 + diff-vs-v1.17.md 1 위치 정정 narrative (audit trail 보존)

v5.11 L1 패턴 = agent 직접 산출 inline 정정 archive (overwrite 부재). 각 위치 안 `> **[v5.12 정정]**: ...` blockquote footnote 추가.

### vector evidence sub-metric (D4 갱신)

- self-loop 본질 = 7 파일 (mapper agent + audit-team + bootstrap + gap-analyzer + proposer + v5.10 mapper-output.md + v5.10 diff-vs-v1.17.md)
- 외부 vector 일부 = 2 파일 (v1.17 audit-2026-05-14/proposal-draft.md + v5.10 audit-2026-05-18 = 외부 audit cascade)
- self-loop 누적 + ecosystem integrator vector cascade 정정 동시 흡수
