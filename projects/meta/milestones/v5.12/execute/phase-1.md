# EXECUTE — v5.12 phase-1

```json
{
  "id": "v5.12_bundled-skill-narrative-cleanup",
  "phase": 1,
  "title": "9 파일 안 'Skill tool 안 invoke 가능 built-in command' 분류 정확화 + v5.10 mapper drift cascade 정정",
  "status": "complete",
  "scope": "9 파일 cascade (active 7 + drift origin 2)",
  "affected_files": [
    "agents/claude-docs-mapper.md",
    "agents/harness-gap-analyzer.md",
    "agents/component-proposer.md",
    "agents/project-harness-audit-team/CLAUDE.md",
    "bootstrap/agents/CLAUDE.md",
    "bootstrap/claude-code-catalog/README.md",
    "projects/upbit/audit-2026-05-14/proposal-draft.md",
    "projects/upbit/audit-2026-05-18/mapper-output.md",
    "projects/meta/milestones/v5.10/diff-vs-v1.17.md",
    "milestones/v5.12/execute/phase-1.md"
  ],
  "changes": [
    {"file": "agents/claude-docs-mapper.md", "change": "frontmatter description 정확화 (built-in slash command [`/init`·`/review`·`/security-review` 등] + bundled skill [`/simplify`·`/batch`·`/debug`·`/loop`·`/claude-api` 등]) + L34 inline footnote (Skill tool invocable narrative) + ## Role 다음 § Note 추가 (audit chain hallucination cycle 3 cascade 명시)"},
    {"file": "agents/harness-gap-analyzer.md", "change": "L43 다음 매트릭스 footnote 추가 (Built-in 일반 + Skill tool invocable 3 명령 sub-classification)"},
    {"file": "agents/component-proposer.md", "change": "L71 inline 정확화 (`/review` → `/review (Skill tool invocable built-in command)`) + 표 다음 footnote 추가"},
    {"file": "agents/project-harness-audit-team/CLAUDE.md", "change": "L17 다음 표 footnote 추가 (gap-analyzer/mapper 책임 컬럼 built-in 일반 + Skill tool invocable 3 명령 sub-classification)"},
    {"file": "bootstrap/agents/CLAUDE.md", "change": "L155 다음 매트릭스 footnote 추가 (Conflict Resolution + Agent Fleet Lifecycle 매트릭스 안 built-in 일반 narrative)"},
    {"file": "bootstrap/claude-code-catalog/README.md", "change": "L55 다음 표 footnote 추가 (built-in slash command 표 안 `/init`·`/review`·`/security-review` Skill tool invocable + `/loop` bundled skill 분류 + 다른 built-in fixed-logic only)"},
    {"file": "projects/upbit/audit-2026-05-14/proposal-draft.md", "change": "L218 § 7 직후 + L428 표 직후 2 footnote 추가 (정보성 cross-ref, '/review built-in' 표현은 spec 정합, Skill tool invocable sub-classification 명시)"},
    {"file": "projects/upbit/audit-2026-05-18/mapper-output.md", "change": "L181 JSON 코드블록 직후 + L198 N2-C1 narrative + L215 docs validation narrative 3 [v5.12 정정] footnote 추가 (drift origin 명시, audit chain hallucination cycle 3, spec 정합 narrative cross-ref)"},
    {"file": "projects/meta/milestones/v5.10/diff-vs-v1.17.md", "change": "L91 § D3 narrative 다음 [v5.12 정정] footnote 추가 (mapper correction = drift cascade, spec 정합 narrative cross-ref)"}
  ],
  "commit": "ed3ddbd",
  "execution_notes": "9 파일 cascade hybrid 정정 (inline 4 + footnote 5). DESIGN.D2.exact_text 정확 삽입. v3.21 narrative 정전화 3 단계 패턴 (c) EXECUTE Edit 완료. Stage G VERIFY 안 grep 3 키워드 검증 base 준비."
}
```

## narrative

Stage F EXECUTE phase-1 — 9 파일 안 DESIGN.D2.exact_text 정확 삽입 (hybrid: inline 4 + footnote 5).

### Edit 순서

1. agents/claude-docs-mapper.md (frontmatter description + L34 inline + ## Role 다음 § Note 추가)
2. agents/harness-gap-analyzer.md (L43 다음 매트릭스 footnote)
3. agents/component-proposer.md (L71 inline + 표 다음 footnote)
4. agents/project-harness-audit-team/CLAUDE.md (L17 다음 표 footnote)
5. bootstrap/agents/CLAUDE.md (L155 다음 매트릭스 footnote)
6. bootstrap/claude-code-catalog/README.md (L55 다음 표 footnote)
7. projects/upbit/audit-2026-05-14/proposal-draft.md (5 위치 footnote)
8. projects/upbit/audit-2026-05-18/mapper-output.md (6 위치 [v5.12 정정] footnote)
9. projects/meta/milestones/v5.10/diff-vs-v1.17.md (L87 다음 [v5.12 정정] footnote)

### footnote 형식 (D6 정합)

- 일반 정확화 (active 6 파일): `> **Note**: \`/review\`·\`/security-review\`·\`/init\` 는 Skill tool 안 discover + execute 가능 built-in command (fixed-logic, \`code.claude.com/docs/en/skills\` 명시). Bundled skill (prompt-based playbook, e.g., \`/simplify\`·\`/batch\`·\`/debug\`·\`/loop\`·\`/claude-api\`) 범주 아님 — 별 sub-classification, 직교.`
- v1.17 proposal-draft (D7 정합, 정보성 cross-ref): `> **Note**: 본 narrative 안 '/review built-in' 표현은 spec 정합 (built-in command, fixed-logic). 추가 sub-classification — \`/review\` 는 Skill tool 안 discover + execute 가능 (\`code.claude.com/docs/en/skills\` 명시). Bundled skill (prompt-based playbook, \`/simplify\`·\`/batch\` 등) 범주 아님.`
- v5.10 audit 산출물 (D8 정합, audit trail 보존): `> **[v5.12 정정]**: 본 narrative 안 '/review = bundled skill' 분류는 audit chain hallucination cycle 3 origin (cycle 1 v5.10 proposer / cycle 2 v5.11 scanner / cycle 3 v5.12 mapper). spec 정합 narrative = '/review·/security-review·/init = Skill tool 안 discover + execute 가능 built-in command (fixed-logic). Bundled skill (prompt-based playbook, /simplify·/batch·/debug·/loop·/claude-api) 범주 아님'. v5.12 INTENT.goal + DESIGN.D2.exact_text 참조.`

### Stage G VERIFY 검증 base

- grep 키워드 3건: `Skill tool 안 invoke|discover + execute`, `built-in command`, `code.claude.com/docs/en/skills`
- pre-commit 14 hook 전건 PASS 검증

### commit message

`feat(meta): v5.12 phase-1 — bundled-skill narrative cleanup 9 파일 정정 + audit chain hallucination cycle 3 mapper drift cascade`
