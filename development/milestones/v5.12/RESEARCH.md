---
id: v5.12_bundled-skill-narrative-cleanup
title: RESEARCH v5.12
version: v5.12
stage: RESEARCH
status: completed
---

# RESEARCH — v5.12 bundled-skill-narrative-cleanup

## Spec

```json
{
  "external": [
    {
      "source": "context7 /websites/code_claude (glossary)",
      "url": "https://code.claude.com/docs/en/glossary",
      "topic": "Glossary > B > Bundled skills definition",
      "findings": "Bundled skills are prompt-based playbooks included with Claude Code, such as `/batch`, `/simplify`, `/debug`, and `/loop`. Unlike fixed-logic built-in commands, bundled skills provide Claude with detailed prompts, enabling it to orchestrate work, spawn agents, read files, and adapt to the user's codebase.",
      "drift": "v5.10 mapper-output.md L100/L102/L105/L180/L198/L215 안 '/review = bundled skill' 분류 = drift. spec 정의 = prompt-based playbook (`/simplify`·`/batch`·`/debug`·`/loop`), `/review` 부재."
    },
    {
      "source": "context7 /websites/code_claude (skills)",
      "url": "https://code.claude.com/docs/en/skills",
      "topic": "Bundled skills 명시 examples + Restrict Claude's skill access",
      "findings": "Claude Code includes several bundled skills like `/simplify`, `/batch`, `/debug`, `/loop`, and `/claude-api`. These skills are prompt-based ... Built-in commands like `/init`, `/review`, and `/security-review` are available through the Skill tool, while others like `/compact` are not.",
      "drift": "동일 — spec 안 bundled skills examples 안 `/review` 부재. `/review`·`/security-review`·`/init` 는 'built-in commands available through the Skill tool' 으로 별 sub-classification."
    },
    {
      "source": "context7 /websites/code_claude (slash-commands)",
      "url": "https://code.claude.com/docs/en/slash-commands",
      "topic": "Bundled skills § + built-in commands fixed logic",
      "findings": "pre-installed bundled skills like `/simplify`, `/batch`, `/debug`, `/loop`, `/claude-api` ... unlike most built-in commands that execute fixed logic",
      "drift": "동일 — spec 명시 'unlike most built-in commands that execute fixed logic' = built-in command 와 bundled skill 별 범주 (fixed-logic vs prompt-based playbook)."
    },
    {
      "source": "context7 /websites/code_claude (whats-new/2026-w16)",
      "url": "https://code.claude.com/docs/en/whats-new/2026-w16",
      "topic": "Skill tool can discover built-in commands",
      "findings": "Claude can now discover and execute built-in commands such as `/init`, `/review`, and `/security-review` through the Skill tool.",
      "drift": "없음 — spec source 정확. `/review` 등은 built-in command 분류 (bundled skill 아님)."
    },
    {
      "source": "context7 /websites/code_claude (changelog)",
      "url": "https://code.claude.com/docs/en/changelog",
      "topic": "Skill tool built-in slash command discovery",
      "findings": "The model can now discover and invoke built-in slash commands such as `/init`, `/review`, and `/security-review` using the Skill tool.",
      "drift": "없음 — 'built-in slash commands' 표현 정확."
    }
  ],
  "codebase": {
    "affected_files": [
      "agents/claude-docs-mapper.md (frontmatter description + L34 inline 정확화 + ## Role 다음 § Note)",
      "agents/harness-gap-analyzer.md (L43 다음 매트릭스 footnote)",
      "agents/component-proposer.md (L71 inline 정확화 + 표 다음 footnote)",
      "agents/project-harness-audit-team/CLAUDE.md (L17 다음 표 footnote)",
      "bootstrap/agents/CLAUDE.md (L155 다음 매트릭스 footnote)",
      "bootstrap/claude-code-catalog/README.md (L55 다음 표 footnote)",
      "projects/upbit/audit-2026-05-14/proposal-draft.md (L218 + L221 + L224 + L226 + L421 footnote 5 위치)",
      "projects/upbit/audit-2026-05-18/mapper-output.md (L100 + L102 + L105 + L180 + L198 + L215 [v5.12 정정] footnote 6 위치)",
      "projects/meta/milestones/v5.10/diff-vs-v1.17.md (L87 다음 D3 § narrative 안 [v5.12 정정] footnote)",
      "milestones/v5.12/execute/phase-1.md (Stage F 생성)"
    ],
    "untouched_files_explicit": [
      "projects/meta/ARCHITECTURE.md (L69 'built-in slash command' 일반 표현 — 도구 카탈로그 전반 인용 자연)",
      "CLAUDE.md / AGENTS.md / README.md (L3/L3/L4 동일 일반 표현)",
      "projects/upbit/audit-2026-05-18/proposal-draft.md (mapper-output.md 인용 narrative, 본 v5.12 안 mapper-output.md inline 정정 후 cascade 자연 — 추가 변경 부재)",
      "projects/meta/milestones/v5.10/PROPOSE.md + v5.11/PROPOSE.md (next_candidates 거명 narrative, forward-only policy 정합 보존)",
      "projects/meta/milestones/v5.10/execute/phase-1.md / phase-2.md (v5.10 EXECUTE narrative 보존)",
      "projects/meta/milestones/v5.10/REPORT.md / VERIFY.md / INTENT.md / RESEARCH.md / DESIGN.md / APPROVE.md (v5.10 산출물 보존, 본 v5.12 = mapper-output.md + diff-vs-v1.17.md 정정만)",
      "claude/commands/harness-meta.md (Stage A 안 audit chain fact 검증 절차 = v5.11 PROPOSE#1 별 후속 milestone scope, 본 v5.12 안 cycle 3 도달 → PROPOSE 진급 가능)"
    ],
    "current_state": "v5.10 mapper-output.md L100/L102/L105/L180/L198/L215 6 위치 + diff-vs-v1.17.md L87 1 위치 안 'bundled skill' 분류 narrative 거주 = drift origin (claude-docs-mapper agent 의 spec source 잘못된 해석). active source (agents/ 4건 + bootstrap/ 2건 + projects/upbit/audit-2026-05-14/proposal-draft.md 1건) 7 파일 안 cascade 미동기. 본 v5.12 = drift origin (2 파일 7 위치) + drift cascade target (7 파일 = 7 위치 active source) 동시 정정.",
    "target_state": "9 파일 안 정확 분류 narrative — '`/review`·`/security-review`·`/init` 는 Skill tool 안 discover + execute 가능 built-in command (fixed-logic, `code.claude.com/docs/en/skills` 명시). Bundled skill (prompt-based playbook, e.g., `/simplify`·`/batch`·`/debug`·`/loop`·`/claude-api`) 범주 아님 — 별 sub-classification, 직교'. v5.10 mapper-output.md + diff-vs-v1.17.md 안 inline [v5.12 정정] blockquote footnote 추가 (v5.11 L1 패턴 = agent 직접 산출 inline 정정 archive 정합)."
  },
  "options": [
    {
      "option": "A. scope 9 파일 cascade (drift origin + cascade target 동시 정정)",
      "pros": "drift 완전 해소 + v5.10 mapper hallucination cycle 3 evidence 흡수 + audit trail 보존 (v5.11 L1 패턴). 사용자 명시 결정 (Stage E APPROVE round decisive issue 해소 후) 정합.",
      "cons": "scope 확장 (7→9), 토큰 비용 증가. INTENT/RESEARCH/DESIGN 재작성 cascade.",
      "recommendation": "선택 (사용자 명시 결정)"
    },
    {
      "option": "B. v5.12 폐기 + v5.13 (audit chain fact verification 절차 정전화) 재발의",
      "pros": "audit chain hallucination cycle 3 trigger 충족 = v5.11 PROPOSE#1 정확 진급. 본 v5.12 scope 광범위 cascade 회피.",
      "cons": "drift cascade 7 파일 active source + 2 파일 v5.10 산출물 잔존 → 후속 milestone scope 안 다시 흡수 의무. 산출물 재작성 부담 동등.",
      "recommendation": "reject (사용자 명시 결정 A 채택)"
    },
    {
      "option": "C. drift cascade 채택 (D2 그대로, scope 7)",
      "pros": "토큰 절약.",
      "cons": "drift cascade 7 파일 신규 생산 — 부적합. spec-drift agent decisive issue 무시.",
      "recommendation": "reject (부적합)"
    }
  ],
  "risks_identified": [
    {
      "risk": "R1: 'bundled skill' 용어 / '`/review` 분류' narrative 5 source 안 정확 — RESEARCH 안 spec 재검증 spike 완료 후 drift origin 식별",
      "mitigation": "DESIGN.D2.exact_text 안 spec source URL `code.claude.com/docs/en/skills` + `glossary` cross-ref 명시 (각 정정 narrative 안 link 또는 footnote 포함)"
    },
    {
      "risk": "R2: 9 파일 동시 Edit → smoke 회귀 risk",
      "mitigation": "Stage F phase-1 1 commit + Stage G smoke 14 hook 전건 검증. 정정 본질 = narrative 표현만 (JSON schema / code logic 변경 부재) → 회귀 risk 낮음 (회귀 risk agent verdict pass)"
    },
    {
      "risk": "R3: 표 / 매트릭스 footnote 위치 일관성 (blockquote `> **Note**: ...` 또는 `> **[v5.12 정정]**: ...`)",
      "mitigation": "DESIGN.D6 채택 — blockquote 형식, 표/매트릭스 마지막 행 다음 1 line 위치. tests/CLAUDE.md L201 MD032/MD049 정합 (회귀 risk agent recommendation 정합)"
    },
    {
      "risk": "R4: claude-docs-mapper.md frontmatter description 변경 시 Claude Code plugin discovery 영향",
      "mitigation": "description 안 미세 변경만 (plugin discovery key = `name` 필드, description 영향 부재 — architecture agent verdict 정합)"
    },
    {
      "risk": "R5: v5.10 audit 산출물 (mapper-output.md + diff-vs-v1.17.md) inline 정정 = audit trail 변형 risk",
      "mitigation": "[v5.12 정정] blockquote footnote 추가 형식 = audit trail 보존 + 정정 narrative 동시 흡수. v5.11 L1 패턴 (agent 직접 산출 inline 정정 archive) 정합. mapper-output.md 6 + diff-vs-v1.17.md 1 = 7 위치 일관 형식"
    },
    {
      "risk": "R6: v1.17 audit-2026-05-14/proposal-draft.md '/review built-in' 표현 = spec 정합 (built-in command, fixed-logic) — 본 v5.12 안 변경 본질 부재",
      "mitigation": "v1.17 안 '/review built-in' 표현은 spec 정합 = 변경 부재 자연. 단 'Skill tool invocable sub-classification' footnote 추가 = 정보성 cross-ref (분류 정확화). sc_7 narrative = footnote 추가만 (inline 정정 부재)"
    },
    {
      "risk": "R7: audit chain hallucination cycle 3 trigger 충족 = v5.11 PROPOSE#1 진급 의무 — 본 v5.12 안 흡수 또는 PROPOSE.next_candidates#1 진급?",
      "mitigation": "memory feedback_subagent_fact_hallucination_correction.md cycle 3 direct evidence 도달 → v5.11 PROPOSE#1 trigger 충족 사실 진술. 본 v5.12 PROPOSE.next_candidates#1 안 'audit-chain-fact-verification-protocol-procedure' 진급 (trigger 조건 명시 충족 narrative) — 후속 milestone 거명 자연 (forward-only policy 정합)"
    }
  ]
}
```

## narrative

본 RESEARCH 는 v5.12 milestone 의 조사 — context7 5 source (skills + glossary + slash-commands + whats-new/2026-w16 + changelog) 재검증 + 9 파일 안 drift 위치 + 7 risks_identified.

### context7 spec source 정확 분류 (5 source 일치)

1. **glossary > B > Bundled skills**: "Bundled skills are prompt-based playbooks ... such as `/batch`, `/simplify`, `/debug`, and `/loop`. **Unlike fixed-logic built-in commands**, bundled skills provide Claude with detailed prompts..."
2. **skills § Bundled skills**: "Claude Code includes several bundled skills like `/simplify`, `/batch`, `/debug`, `/loop`, and `/claude-api`."
3. **slash-commands § Bundled skills**: "pre-installed bundled skills like `/simplify`, `/batch`, `/debug`, `/loop`, `/claude-api` ... unlike most built-in commands that execute fixed logic"
4. **skills § Restrict Claude's skill access**: "Built-in commands like `/init`, `/review`, and `/security-review` are available through the Skill tool, while others like `/compact` are not."
5. **whats-new/2026-w16 + changelog**: "Claude can now discover and execute built-in commands such as `/init`, `/review`, and `/security-review` through the Skill tool."

**정확 분류 narrative**:

- **Bundled skills** = prompt-based playbook (`/simplify`·`/batch`·`/debug`·`/loop`·`/claude-api`)
- **Built-in commands** = fixed-logic (`/init`, `/review`, `/security-review`, `/compact`, `/doctor` 등)
- 일부 built-in (`/init`, `/review`, `/security-review`) = Skill tool 안 discover + execute 가능 = 별 sub-classification (직교, **bundled skill 범주 아님**)

### v5.10 mapper hallucination origin 식별 (audit chain cycle 3)

v5.10 mapper-output.md L100/L102/L105/L180/L198/L215 6 위치 + diff-vs-v1.17.md L87 1 위치 = '/review = bundled skill' 잘못된 분류 = drift origin. v5.10 mapper agent 가 spec source `code.claude.com/docs/en/skills` 안 'A few built-in commands available through the Skill tool' 표현을 'built-in command 가 아닌 bundled skill' 으로 잘못 해석 = audit chain hallucination cycle 3 도달.

### v5.7 spec-drift spike 3 단계 패턴 (a) RESEARCH 안 spec 재검증 spike 완료

본 RESEARCH 안 context7 5 query (skills + glossary + slash-commands + whats-new + changelog) = drift origin (v5.10 mapper L100~L215 + diff-vs-v1.17.md L87) 식별 + spec source 정확 분류 narrative 1차 거주. v5.7 spec-drift spike 14 번째 cycle (v3.21 narrative 정전화 3 단계 + v5.7 spec-drift spike 패턴 도그푸드).

### 9 파일 안 drift 위치 (sc_1~sc_9 매핑)

INTENT.success_criteria sc_1~sc_9 = 9 파일 안 정확 위치 매핑. sc_8 + sc_9 = drift origin 정정 (v5.10 mapper-output.md 6 위치 + diff-vs-v1.17.md 1 위치 = 7 위치). sc_1~sc_7 = drift cascade target 정정 (active source 7 파일).

### options 3 + 사용자 명시 결정 채택

- 옵션 A: 사용자 명시 결정 (Stage E APPROVE round) — 선택
- 옵션 B: v5.12 폐기 + v5.13 재발의 — reject (사용자 결정)
- 옵션 C: drift cascade 채택 — reject (부적합)

### risks_identified 7건 mitigation

R1~R7 = 위 JSON 안 명시. R7 = v5.11 PROPOSE#1 trigger 충족 사실 진술 + 본 v5.12 PROPOSE.next_candidates#1 진급 narrative (forward-only policy 정합).
