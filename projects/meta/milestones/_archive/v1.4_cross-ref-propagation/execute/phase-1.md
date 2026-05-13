# EXECUTE phase-1 — v1.4_cross-ref-propagation

```json
{
  "phase": 1,
  "title": "Cross-ref 1줄 일괄 추가 (3 host) + AGENTS Status 일반화",
  "status": "complete",
  "commit": "df3ea89",
  "scope_from_design": "Context 정전 보강 — 3 host 에 정의 § 3 cross-ref 1줄 standalone header/block 추가, AGENTS.md L82-84 Status 섹션 일반화",
  "affected_files": [
    "AGENTS.md",
    "README.md",
    "projects/meta/CLAUDE.md",
    "projects/meta/milestones/v1.4_cross-ref-propagation/execute/phase-1.md"
  ],
  "changes": [
    {
      "file": "AGENTS.md",
      "edits": [
        {
          "anchor": "between '## Workflow' (L45) and '## Boundaries' (L64), after L62 'All milestone artifacts are MD files with JSON code blocks for structured data.'",
          "action": "insert new section",
          "new_content": "## Harness engineering definition\n\n**Harness engineering definition** (canonical single source): [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 3 — working definition + 5-element matrix (Context / Workflow / Constraint / Verification / Trace). New milestones must map to one of these five elements."
        },
        {
          "anchor": "L82-84 Status section",
          "action": "rewrite",
          "new_content": "## Status\n\nPublic repository, MIT licensed. Milestone history: see [`projects/meta/ROADMAP.md`](projects/meta/ROADMAP.md)."
        }
      ]
    },
    {
      "file": "README.md",
      "edits": [
        {
          "anchor": "L4 tagline 직후 (between L4 'Operational manual ...' and L6 main paragraph)",
          "action": "insert new standalone block (1-line `>` quote pattern matching tagline style)",
          "new_content": "> **Harness engineering definition** (canonical single source): [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 3 — working definition + 5-element matrix (Context / Workflow / Constraint / Verification / Trace). New milestones must map to one of these five elements."
        }
      ]
    },
    {
      "file": "projects/meta/CLAUDE.md",
      "edits": [
        {
          "anchor": "H1 직후 (after L1 '# projects/meta/ — Subdirectory Guide', before L3 '@ROADMAP.md')",
          "action": "insert 1-line cross-ref",
          "new_content": "**하네스 엔지니어링 정의** (정전 single source): [`ARCHITECTURE.md`](ARCHITECTURE.md) § 3 — working definition + 5요소 매트릭스 (Context / Workflow / Constraint / Verification / Trace). 신규 milestone 발의는 본 정의 5요소 중 하나에 매핑."
        }
      ]
    }
  ],
  "expected_commit_message": "feat(meta): v1.4 phase-1 — 정의 cross-ref 3 host 추가 + AGENTS Status 일반화",
  "verification_post_commit": [
    "grep '하네스 엔지니어링 정의' projects/meta/CLAUDE.md → 1 hit (H1 직후)",
    "grep 'Harness engineering definition' AGENTS.md README.md → 각각 1 hit",
    "grep -c 'Public repository, MIT licensed' AGENTS.md → 1 (Status 갱신)",
    "grep 'v1.1_agents-md-cleanup' AGENTS.md → 0 (Status stale 제거)",
    "smoke pre-commit hook PASS (markdownlint / spec-verification / scope-contract / cross-ref / claude-md-drift)"
  ],
  "execution_notes": "AGENTS.md L64-66 신규 § 추가 + L82 Status 갱신, README.md L5 cross-ref 1줄 추가, projects/meta/CLAUDE.md L3 cross-ref 1줄 추가. grep 검증 모두 PASS — 정의 본문 ('하네스 엔지니어링은 agent 의 행동을') drift 0 (host 4곳 0, projects/meta/ARCHITECTURE.md 만 매치). pre-commit smoke 5건 모두 PASS (markdownlint / projects-scope-discipline / spec-verification / scope-contract / cross-ref / claude-md-drift). commit df3ea89, 8 files changed (3 host + 4 milestone artifacts + ROADMAP), 617 insertions / 4 deletions."
}
```

## 진행

phase-1 = 3 host 에 정의 § 3 cross-ref 1줄 standalone header/block 추가 + AGENTS.md Status 섹션 일반화. 모두 additive (deletion 0), DESIGN.decisions[1] 결정 phase 순서 (phase-1 → phase-2 cascade → phase-3 GUARDRAILS) 의 첫 단계.
