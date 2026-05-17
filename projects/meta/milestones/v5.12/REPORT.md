# REPORT — v5.12 bundled-skill-narrative-cleanup

```json
{
  "id": "v5.12_bundled-skill-narrative-cleanup",
  "summary": "사용자 명시 발의 (A_user, 2026-05-18) — v5.11 PROPOSE.next_candidates#4 carry-over. Stage E APPROVE 게이트 5 관점 (사용자 명시 요구) subagent 검토 안 spec-drift agent decisive issue 발견 ('bundled skill 별칭' = spec drift) → scope 재정의 + D2.exact_text 재작성 (8→9 파일 cascade). context7 5 source (glossary + skills + slash-commands + whats-new + changelog) 재검증 결과 정확 분류 = Bundled skills (prompt-based playbook, `/simplify`·`/batch`·`/debug`·`/loop`·`/claude-api`) vs Built-in commands (fixed-logic). 일부 built-in (`/init`·`/review`·`/security-review`) = Skill tool 안 discover + execute 가능 (별 sub-classification, 직교, **bundled skill 범주 아님**). v5.10 mapper-output.md L100/L102/L105/L180/L198/L215 6 위치 + diff-vs-v1.17.md L87 = drift origin = audit chain hallucination cycle 3 도달 (cycle 1 v5.10 proposer / cycle 2 v5.11 scanner / cycle 3 본 v5.12 mapper). v5.11 PROPOSE#1 trigger 조건 (사용자 명시 발의 ∧ evidence cycle 3 도달) 충족 = Stage I PROPOSE.next_candidates#1 진급. scope 9 파일 cascade hybrid 정정 (inline 4 + footnote 5). 4 관점 subagent 검토 verdict = architecture pass_with_comments / spec-drift fail with decisive issue (흡수 후 PASS) / 회귀 risk pass / scope contract pass. 1 phase 1+1 commit 패턴 (phase-1 ed3ddbd + Stage G+H+I 통합 chore). v5.7 spec-drift spike 3 단계 + v3.21 narrative 정전화 3 단계 패턴 14 번째 cycle 도그푸드 완성. INTENT.success_criteria 11건 (sc_1~sc_11) 모두 PASS (9 PASS + 2 PASS_WITH_NOTE). pre-commit 14 hook 모두 PASS, 회귀 0.",
  "delta": {
    "files_changed": 12,
    "files_added": 6,
    "files_deleted": 0,
    "files_changed_list": [
      "agents/claude-docs-mapper.md (+4/-2)",
      "agents/component-proposer.md (+3/-1)",
      "agents/harness-gap-analyzer.md (+2)",
      "agents/project-harness-audit-team/CLAUDE.md (+2)",
      "bootstrap/agents/CLAUDE.md (+2)",
      "bootstrap/claude-code-catalog/README.md (+2)",
      "projects/meta/ROADMAP.md (+9)",
      "projects/meta/milestones/v5.10/diff-vs-v1.17.md (+2)",
      "projects/upbit/audit-2026-05-14/proposal-draft.md (+4)",
      "projects/upbit/audit-2026-05-18/mapper-output.md (+4/-2)"
    ],
    "files_added_list": [
      "projects/meta/milestones/v5.12/INTENT.md",
      "projects/meta/milestones/v5.12/RESEARCH.md",
      "projects/meta/milestones/v5.12/DESIGN.md",
      "projects/meta/milestones/v5.12/APPROVE.md",
      "projects/meta/milestones/v5.12/execute/phase-1.md",
      "projects/meta/milestones/v5.12/milestones.md"
    ],
    "modules_affected": [
      "agents/ (4 파일 — mapper / gap-analyzer / proposer / project-harness-audit-team)",
      "bootstrap/ (2 파일 — agents/CLAUDE.md / claude-code-catalog/README.md)",
      "projects/upbit/audit-2026-05-14/ (1 파일 — proposal-draft.md, v1.17 산출물 정보성 footnote)",
      "projects/upbit/audit-2026-05-18/ (1 파일 — mapper-output.md, v5.10 산출물 [v5.12 정정] footnote)",
      "projects/meta/milestones/v5.10/ (1 파일 — diff-vs-v1.17.md, v5.10 산출물 [v5.12 정정] footnote)",
      "projects/meta/milestones/v5.12/ (6 파일 — 9-stage 산출물)",
      "projects/meta/ROADMAP.md (v5.12 entry in_progress → completed pending)"
    ]
  },
  "lessons_learned": [
    {
      "id": "L1",
      "lesson": "audit chain hallucination cycle 3 origin = claude-docs-mapper agent spec source 잘못된 해석 ('A few built-in commands available through the Skill tool' → 'built-in command 가 아닌 bundled skill' 잘못 해석)",
      "evidence": "v5.10 mapper-output.md L100/L102/L105/L180/L198/L215 6 위치 안 '/review = bundled skill' 분류. context7 glossary + skills + slash-commands 재검증 결과 'Bundled skills' = prompt-based playbook 정의, `/review` 부재. cycle 3 direct evidence 도달.",
      "implication": "memory feedback_subagent_fact_hallucination_correction.md cycle 3 direct evidence → v5.11 PROPOSE#1 trigger 조건 충족. PROPOSE.next_candidates#1 진급 narrative (Stage I)."
    },
    {
      "id": "L2",
      "lesson": "Stage E APPROVE 게이트 5 관점 subagent 호출 (사용자 명시 요구) 안 spec-drift agent decisive issue 발견 = scope 재정의 trigger 정상 작동",
      "evidence": "round 1 (Stage A 진입 전) 자체 결정 round 안 'bundled skill 별칭' 표현 채택 → Stage D DESIGN 안 D2.exact_text 명시 → Stage E 5 관점 검토 안 spec-drift agent decisive issue 발견 → scope 재정의 (7→9 파일) + D2.exact_text 재작성.",
      "implication": "lightweight 모드 (5 관점 subagent 생략) 가 자연 default 아님 — narrative 정전화 본질 milestone 안 spec-drift agent 호출 의무 narrative (PROPOSE.next_candidates 가능)."
    },
    {
      "id": "L3",
      "lesson": "harness-meta 안 informal 용어 ('bundled skill 별칭') 가 spec source 안 정의된 용어 ('bundled skill' = prompt-based playbook) 와 충돌 시 = informal 용어 폐기 + spec 정합 narrative 채택 본질",
      "evidence": "v1.17/v5.10 mapper origin informal 용어 'bundled skill' = harness-meta 자체 별칭. spec source 안 'bundled skill' = prompt-based playbook 정의 (`/simplify`·`/batch`·`/debug`·`/loop`·`/claude-api`). 두 정의 충돌 → spec 정합 narrative 채택 (v5.12 D2.exact_text).",
      "implication": "harness-meta 안 informal 용어 도입 시 spec source 안 동일 용어 존재 검증 의무. v5.12 cycle 후속 narrative cleanup candidate 가능."
    },
    {
      "id": "L4",
      "lesson": "9 파일 cascade hybrid 정정 (inline 4 + footnote 5) = 위치별 narrative density 정합 패턴",
      "evidence": "거명 명시 위치 (claude-docs-mapper L34 + component-proposer L71 + bootstrap/claude-code-catalog README 표 + claude-docs-mapper § Note) = inline 정확화. 거명 부재 일반 표현 위치 (gap-analyzer 매트릭스 + audit-team 표 + bootstrap agents 매트릭스 + v1.17 proposal-draft + v5.10 mapper-output + v5.10 diff-vs-v1.17) = footnote 추가.",
      "implication": "narrative 정전화 milestone 안 D1 hybrid 결정 본질 - 거명 명시 vs 부재 위치 분기 명시."
    },
    {
      "id": "L5",
      "lesson": "v5.10 audit 산출물 [v5.12 정정] footnote 형식 = audit trail 보존 + 정정 narrative 동시 흡수 (v5.11 L1 패턴 정합)",
      "evidence": "v5.10 mapper-output.md 3 [v5.12 정정] + diff-vs-v1.17.md 1 [v5.12 정정] = 4 footnote 추가. v5.11 L1 패턴 ('agent 직접 산출 inline 정정 archive vs synthesizer 임시 산출 overwrite' 비대칭 default) 정합 — agent 직접 산출 (mapper output / diff-vs-v1.17) = inline 정정 (overwrite 부재).",
      "implication": "v5.11 L1 패턴 cycle 2 적용 (v5.11 cycle 2 → v5.12 cycle 3). 후속 audit 산출물 정정 cycle 4+ 가능."
    },
    {
      "id": "L6",
      "lesson": "v1.17 proposal-draft.md '/review built-in' 표현 = spec 정합 보존 (inline 정정 부재) + 정보성 footnote 추가만 = D7 분기 narrative",
      "evidence": "v1.17 narrative 안 '/review built-in' = spec 정합 (built-in command, fixed-logic). v5.10 mapper-output.md 의 '/review built-in' → 'bundled skill' 정정 narrative 자체가 drift origin. v1.17 = drift cascade target 안 변경 부재 자연 + 정보성 cross-ref footnote 추가만.",
      "implication": "drift origin vs drift cascade target 분리 본질 — origin (v5.10 mapper) inline 정정, cascade target 안 정정 본질 부재 시 (v1.17 = 이미 spec 정합) 정보성 footnote 추가만."
    },
    {
      "id": "L7",
      "lesson": "context7 5 source 재검증 spike = drift origin 식별 핵심 도구 — spec source 4+ 다중 인용 검증 cycle 패턴",
      "evidence": "RESEARCH 안 context7 query 5 source (glossary + skills + slash-commands + whats-new + changelog) = drift origin (v5.10 mapper-output.md) 식별 + spec source 정확 narrative 1차 거주. 5 source 일관 명시 = spec 정합 확신 누적.",
      "implication": "narrative 정전화 milestone 안 RESEARCH context7 query 4+ source 다중 인용 의무 narrative (워크플로우 강화 후속 milestone 가능)."
    }
  ]
}
```

## narrative

본 REPORT 는 v5.12 milestone 의 backward 종합. 7 lessons (L1~L7) + 12 files changed + 6 files added + 회귀 0 + verdict PASS.

### round 1 → round 2 cascade narrative

- **round 1** (Stage A 진입 전 자체 결정): D1 scope 7 + D2 'bundled skill 별칭' + D3 v5.7 spec-drift spike + D4 외부 vector 포함. INTENT/RESEARCH/DESIGN 1차 작성.
- **round 2** (Stage E APPROVE 게이트, 사용자 명시 5 관점 요구): 4 관점 subagent 검토 (Plan architecture / general-purpose spec-drift + context7 / Explore 회귀 risk / Explore scope contract) → spec-drift agent decisive issue 발견 ('bundled skill 별칭' = spec drift) → 사용자 명시 결정 옵션 A 채택 (scope 재정의 + D2.exact_text 재작성 + v5.10 mapper-output.md + diff-vs-v1.17.md cascade 포함). INTENT/RESEARCH/DESIGN cascade 재작성. scope 7→9 파일.

### audit chain hallucination cycle 3 도달 (L1 lesson 신규 origin)

- **cycle 1** (v5.10): proposer 12 항목 → synthesizer overwrite (memory feedback origin)
- **cycle 2** (v5.11): scanner `claude_md_in_repo: false` → inline 정정 archive (memory feedback cycle 2 direct)
- **cycle 3** (본 v5.12): mapper `/review = bundled skill` 분류 → drift cascade 9 파일 + inline 정정 archive (memory feedback cycle 3 direct evidence)

→ v5.11 PROPOSE#1 trigger 조건 충족 = Stage I PROPOSE.next_candidates#1 진급 narrative.

### v3.21 narrative 정전화 3 단계 패턴 14 번째 cycle 도그푸드 완성 (L7 lesson)

(a) RESEARCH 안 context7 5 source 재검증 + drift origin 식별 → (b) DESIGN.D2.exact_text 1차 source narrative → (c) Stage F EXECUTE 9 파일 Edit + Stage G VERIFY grep 3 키워드 PASS.

누적 cycle: v3.18 + v3.20 + v3.21 + v4.1 + v4.2 + v4.3 + v5.0 + v5.7 + v5.8 + v5.9 + v5.10 + v5.11 + 본 v5.12 = 13 누적 + 14 번째 cycle 완성.

### Stage F→G→H→I 통합 narrative

- Stage F: phase-1 (commit `ed3ddbd`) — 9 파일 cascade hybrid 정정 + execute/phase-1.md + milestones.md + ROADMAP entry in_progress
- Stage G: VERIFY.md 작성 — pre-commit 14 hook PASS + grep 3 키워드 PASS + criteria_check 11/11 PASS
- Stage H: REPORT.md 작성 — 7 lessons (L1~L7) + delta 종합
- Stage I (예정): PROPOSE.md 작성 — next_candidates 거명 + ROADMAP completed 갱신 + Stage G+H+I 통합 chore commit
