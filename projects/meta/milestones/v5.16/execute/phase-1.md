# EXECUTE — v5.16 phase-1

```json
{
  "id": "v5.16",
  "phase": 1,
  "title": "3-layer narrative 정전화 동시 변경 (ARCHITECTURE § 4 끝 + agents D8 Note v5.16 + claude/commands `--audit` 분기 lint precheck step)",
  "status": "in_progress",
  "scope": "Layer A (ARCHITECTURE § 4 끝, v5.11 paragraph 직후) + Layer B (agents/project-harness-audit-team/CLAUDE.md D8 sequence Note v5.16) + Layer C (claude/commands/harness-meta.md `--audit` 분기 lint precheck step) 동시 정전화 + Stage B-E artifacts (INTENT/RESEARCH/DESIGN/APPROVE/milestones/ROADMAP) 동시 commit",
  "affected_files": [
    "projects/meta/ARCHITECTURE.md",
    "agents/project-harness-audit-team/CLAUDE.md",
    "claude/commands/harness-meta.md",
    "projects/meta/milestones/v5.16/execute/phase-1.md",
    "projects/meta/milestones/v5.16/INTENT.md",
    "projects/meta/milestones/v5.16/RESEARCH.md",
    "projects/meta/milestones/v5.16/DESIGN.md",
    "projects/meta/milestones/v5.16/APPROVE.md",
    "projects/meta/milestones/v5.16/milestones.md",
    "projects/meta/ROADMAP.md"
  ],
  "execution_notes": [
    "step 1: Layer A — ARCHITECTURE.md § 4 끝 (L137 v5.11 'Audit chain fact 인용 검증 의무' paragraph 직후, L139 ### 4.1 Bundling 직전) 위치에 D2.exact_text 삽입.",
    "step 2: Layer B — agents/project-harness-audit-team/CLAUDE.md ## Orchestration sequence (D8) 섹션 안 L68 v5.13 Note 직후 (L70 '병렬 가능성' 직전) 위치에 D3.exact_text Note (v5.16) 삽입.",
    "step 3: Layer C — claude/commands/harness-meta.md `--audit` 분기 sequence 안 L80 synthesizer fact 검증 step 직후 (L81 '사용자 명시 결정 게이트' 직전) 위치에 D4.exact_text step 삽입.",
    "step 4: smoke 회귀 검증 (pre-commit hook 자동 실행 — pre-commit 14 hook PASS 의무).",
    "step 5: git add (3 host + 6 milestone artifacts + ROADMAP = 10 파일) + commit (`feat(meta): v5.16 phase-1 — 3-layer narrative 정전화 (audit-output-markdown-lint-precheck)`).",
    "step 6: phase-1.md status complete + execution_notes 갱신."
  ],
  "commit": null
}
```

## narrative

### Layer A — ARCHITECTURE.md § 4 끝 (WHAT 정의)

D2.exact_text 정확 삽입. v5.11 paragraph 직후 = '검증 의무 군집' 일관성. v3.21 narrative 정전화 3 단계 패턴 Step 1 (DESIGN.D2.exact_text 1차 source) → Step 2 (EXECUTE 정확 삽입) 실행.

### Layer B — agents/project-harness-audit-team/CLAUDE.md D8 sequence Note v5.16 (WHERE 절차)

D3.exact_text 정확 삽입. v5.13 Note 직후 위치 = '직교 (fact 정확성 vs markdown 구조 lint)' 명시. installer Step 5 제외 명시.

### Layer C — claude/commands/harness-meta.md `--audit` 분기 lint precheck step (HOW 절차)

D4.exact_text 정확 삽입. L80 synthesizer fact 검증 step 직후 위치 = '의미 → 구조' 자연 sequence.

### Stage B-E artifacts 동시 commit (D7 (a) 패턴)

INTENT/RESEARCH/DESIGN/APPROVE/milestones/ROADMAP 6건 artifacts 를 phase-1 commit 안 동시 포함. v3.18~v3.21+v5.7~v5.13 1+1 commit 패턴 8번째 (도그푸드).

## 관련

- INTENT: [../INTENT.md](../INTENT.md)
- DESIGN: [../DESIGN.md](../DESIGN.md) (D2/D3/D4 exact_text 1차 source)
- APPROVE: [../APPROVE.md](../APPROVE.md)
- v3.21 패턴 source: [`../../../milestones/_archive/v3.21/REPORT.md`](../../../milestones/_archive/v3.21/REPORT.md)
