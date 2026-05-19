---
id: v5.12_bundled-skill-narrative-cleanup
title: DESIGN v5.12
version: v5.12
stage: DESIGN
status: completed
---

# DESIGN — v5.12 bundled-skill-narrative-cleanup

## Spec

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "정정 위치 처리 = hybrid (inline 정확화 [거명 명시] + footnote 추가 [거명 부재 일반 표현 또는 audit trail 보존])",
      "rationale": "거명 명시 위치 (claude-docs-mapper.md L34 + component-proposer.md L71 + bootstrap/claude-code-catalog/README.md L52~L55 표 + projects/upbit/audit-2026-05-14/proposal-draft.md 5 위치) → inline 정확화. 거명 부재 일반 'built-in' 표현 위치 (harness-gap-analyzer.md 매트릭스 + project-harness-audit-team/CLAUDE.md 표 + bootstrap/agents/CLAUDE.md 매트릭스) → footnote 추가. v5.10 audit 산출물 (mapper-output.md + diff-vs-v1.17.md) → [v5.12 정정] blockquote footnote 추가 (v5.11 L1 audit trail 보존 패턴 정합).",
      "alternatives_rejected": [
        "옵션 X (모든 위치 변경 부재) — cascade 일관성 약화",
        "옵션 Y (모든 일반 표현 inline 정정) — 토큰 폭증"
      ]
    },
    {
      "id": "D2",
      "decision": "정확화 narrative 단어 선택 = '`/review`·`/security-review`·`/init` 는 Skill tool 안 discover + execute 가능 built-in command (fixed-logic, `code.claude.com/docs/en/skills` 명시). Bundled skill (prompt-based playbook, e.g., `/simplify`·`/batch`·`/debug`·`/loop`·`/claude-api`) 범주 아님 — 별 sub-classification, 직교'",
      "exact_text": "`/review`·`/security-review`·`/init` 는 Skill tool 안 discover + execute 가능 built-in command (fixed-logic, `code.claude.com/docs/en/skills` 명시). Bundled skill (prompt-based playbook, e.g., `/simplify`·`/batch`·`/debug`·`/loop`·`/claude-api`) 범주 아님 — 별 sub-classification, 직교.",
      "rationale": "context7 5 source 안 정확 분류 — Bundled skills = prompt-based playbook (glossary + skills + slash-commands 명시 examples). Built-in commands = fixed-logic. 일부 built-in (`/review`·`/security-review`·`/init`) = Skill tool invocable sub-classification, 직교. v5.10 mapper-output.md '/review = bundled skill' 분류 = drift cascade origin → 본 D2 정확 narrative 9 파일 cascade.",
      "alternatives_rejected": [
        "옵션 A (이전 D2 'bundled skill 별칭') — spec drift cascade",
        "옵션 B (단순 'Skill tool invokable built-in command') — bundled skill 범주 부재 명시 누락"
      ]
    },
    {
      "id": "D3",
      "decision": "phase 분할 = 1 phase (9 파일 동시 정정, 1 commit, conventional commits `feat(meta): v5.12 phase-1 — bundled-skill narrative cleanup 9 파일 정정 + audit chain hallucination cycle 3 mapper drift cascade`)",
      "rationale": "정정 본질 = narrative 표현만 (JSON schema / code logic 변경 부재). 9 파일 의미 단위 (mapper drift origin + cascade target 동일 narrative cleanup). v3.17 phase-distribution-audit 안 1-phase 정합. 토큰 효율 + Stage F 단순화.",
      "alternatives_rejected": [
        "옵션 B (2 phase: 7 cascade target / 2 drift origin) — 의미 단위 같음, 분할 본질 부재"
      ]
    },
    {
      "id": "D4",
      "decision": "5 관점 subagent 검토 = 사용자 명시 결정 4 관점 완료 (architecture pass_with_comments / spec-drift fail with decisive issue / 회귀 risk pass / scope contract pass)",
      "rationale": "사용자 명시 요구 (Stage E APPROVE round) 4 관점 호출 완료. spec-drift decisive issue 흡수 후 scope 재정의 (7→9 파일) + D2.exact_text 재작성. architecture 3 recommendations + 회귀 risk 3 recommendations + scope contract 3 recommendations 모두 흡수 narrative DESIGN/RESEARCH/INTENT cascade 갱신.",
      "alternatives_rejected": [
        "lightweight 모드 (5 관점 생략) — 사용자 명시 결정 거부, decisive issue 발견 부재 risk"
      ]
    },
    {
      "id": "D5",
      "decision": "commit 시점 = (b) Stage G commit 안 INTENT/RESEARCH/DESIGN/APPROVE 4건 + VERIFY/REPORT/PROPOSE 3건 + ROADMAP completed + milestones.md 동기 = phase-1 + chore 2 commit 패턴",
      "rationale": "memory project_v3.21_narrative-canonicalization-3step-pattern.md 안 1+1 commit 패턴 정합. v3.21+v5.7+v5.8+v5.9+v5.10+v5.11 = 6 cycle 누적 = 14 번째 cycle 도그푸드.",
      "alternatives_rejected": [
        "옵션 (a) phase-1 commit 안 포함 — 산출물 영구 보존 약함",
        "옵션 (c) 별도 chore commit 추가 — 3 commit 토큰 비용 증가"
      ]
    },
    {
      "id": "D6",
      "decision": "footnote 형식 = blockquote (`> **Note**: ...` 또는 `> **[v5.12 정정]**: ...`) 인용 형식, 매트릭스/표 마지막 행 다음 1 line 위치 + tests/CLAUDE.md L201 MD032/MD049 정합",
      "rationale": "Markdown 일관성 + 본문 흐름 분리 + audit trail 보존 (v5.10 산출물 안 [v5.12 정정] 표지). 9 파일 cascade 안 위치 일관. 회귀 risk agent recommendation 정합.",
      "alternatives_rejected": [
        "옵션 (a) HTML <aside> — Markdown 일관성 약화",
        "옵션 (b) 인라인 괄호 표현 — 표 안 행 폭 증가"
      ]
    },
    {
      "id": "D7",
      "decision": "v1.17 audit-2026-05-14/proposal-draft.md 5 위치 정정 = footnote 추가만 ('/review built-in' 표현은 spec 정합 = 변경 부재, Skill tool invocable sub-classification 정보성 footnote 추가)",
      "rationale": "v1.17 안 '/review built-in' = spec 정합 (built-in command, fixed-logic) → inline 정정 부재 자연. 단 'Skill tool 안 discover + execute 가능' sub-classification 정보성 footnote 추가 = cross-ref 강화 (sc_7 매핑). R6 mitigation 정합.",
      "alternatives_rejected": [
        "옵션 (a) v1.17 안 '/review built-in' inline 정정 — spec 정합 표현 변경 부재 자연 (drift 부재)"
      ]
    },
    {
      "id": "D8",
      "decision": "v5.10 audit 산출물 (mapper-output.md + diff-vs-v1.17.md) 정정 = [v5.12 정정] blockquote footnote 추가 (audit trail 보존, inline overwrite 부재)",
      "rationale": "v5.11 L1 패턴 = agent 직접 산출 inline 정정 archive (overwrite 부재). v5.10 mapper-output.md L100/L102/L105/L180/L198/L215 6 위치 + diff-vs-v1.17.md L87 1 위치 = 7 위치 모두 [v5.12 정정] blockquote footnote 추가. 정정 narrative 안 'v5.10 mapper hallucination cycle 3 = drift origin, spec 정합 narrative 는 v5.12 INTENT.goal + DESIGN.D2.exact_text 참조' cross-ref.",
      "alternatives_rejected": [
        "옵션 (a) inline overwrite — audit trail 변형 risk, v5.11 L1 패턴 위배"
      ]
    },
    {
      "id": "D9",
      "decision": "audit chain hallucination cycle 3 trigger 충족 사실 진술 → PROPOSE.next_candidates#1 'audit-chain-fact-verification-protocol-procedure' 진급 (v5.11 PROPOSE#1 carry-over, trigger 조건 명시 충족 narrative)",
      "rationale": "memory feedback_subagent_fact_hallucination_correction.md cycle 3 direct evidence 도달 = v5.11 PROPOSE#1 trigger 조건 (사용자 명시 발의 ∧ evidence cycle 3 도달) 충족. forward-only policy 정합 — 본 v5.12 안 절차 정전화 직접 흡수 부재, PROPOSE.next_candidates#1 거명 후 사용자 명시 발의 의무.",
      "alternatives_rejected": [
        "옵션 (a) 본 v5.12 안 절차 정전화 직접 흡수 — scope 폭증 + § 6.2 폐지 narrative 정합 약화 risk"
      ]
    }
  ],
  "phases": [
    {
      "n": 1,
      "title": "9 파일 안 'Skill tool 안 invoke 가능 built-in command' 분류 정확화 + v5.10 mapper drift cascade 정정",
      "scope": "agents/claude-docs-mapper.md (frontmatter description + L34 inline 정확화 + ## Role 다음 § Note) + agents/harness-gap-analyzer.md (L43 다음 매트릭스 footnote) + agents/component-proposer.md (L71 inline 정확화 + 표 다음 footnote) + agents/project-harness-audit-team/CLAUDE.md (L17 다음 표 footnote) + bootstrap/agents/CLAUDE.md (L155 다음 매트릭스 footnote) + bootstrap/claude-code-catalog/README.md (L55 다음 표 footnote) + projects/upbit/audit-2026-05-14/proposal-draft.md (L218 + L221 + L224 + L226 + L421 footnote 5 위치) + projects/upbit/audit-2026-05-18/mapper-output.md (L100 + L102 + L105 + L180 + L198 + L215 [v5.12 정정] footnote 6 위치) + projects/meta/milestones/v5.10/diff-vs-v1.17.md (L87 다음 [v5.12 정정] footnote)",
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
      "rationale": "1 phase = 의미 단위 동일 (mapper drift origin + cascade target 동일 narrative cleanup). 정정 본질 narrative 만 (JSON schema / code logic 변경 부재). 토큰 효율 + Stage F 단순화.",
      "risks": [
        "R2 (smoke 회귀 risk, 14 hook 검증 mitigation)",
        "R3 (footnote 위치 모호 — D6 채택 mitigation)",
        "R5 (v5.10 audit trail 변형 — D8 채택 [v5.12 정정] footnote 추가 mitigation)",
        "R6 (v1.17 변경 부재 자연 — D7 footnote 추가만)"
      ]
    }
  ]
}
```

## Approach

v5.7 spec-drift spike 3 단계 패턴 도그푸드 14 번째 cycle. (a) RESEARCH 안 context7 5 source (skills + glossary + slash-commands + whats-new + changelog) 재검증 spike 완료 + drift origin (v5.10 mapper-output.md L100~L215 + diff-vs-v1.17.md L87) 식별 → (b) DESIGN.D2.exact_text 1차 source narrative '`/review`·`/security-review`·`/init` 는 Skill tool 안 discover + execute 가능 built-in command (fixed-logic, code.claude.com/docs/en/skills 명시). Bundled skill (prompt-based playbook, e.g., `/simplify`·`/batch`·`/debug`·`/loop`·`/claude-api`) 범주 아님' 정확 표현 → (c) Stage F phase-1 안 9 파일 Edit (hybrid: inline 4 + footnote 5, D1+D6+D7+D8 정합) → Stage G VERIFY 안 grep 키워드 3건 (`Skill tool 안 invoke`, `built-in command`, `code.claude.com/docs/en/skills`) PASS 검증.

## Risk mitigation

- risk: R1 'bundled skill' / '`/review` 분류' spec drift; mitigation: RESEARCH 안 context7 5 source 재검증 spike 완료 + DESIGN.D2.exact_text 안 spec source URL cross-ref 명시
- risk: R2 9 파일 동시 Edit smoke 회귀; mitigation: Stage G 안 14 hook 검증, 회귀 risk agent verdict pass
- risk: R3 footnote 위치 모호; mitigation: D6 채택 (blockquote 형식, 표/매트릭스 마지막 행 다음 1 line 위치, MD032/MD049 정합)
- risk: R4 claude-docs-mapper.md frontmatter description 변경 영향; mitigation: description 안 미세 변경만 + architecture agent verdict pass
- risk: R5 v5.10 audit trail 변형; mitigation: D8 채택 ([v5.12 정정] blockquote footnote 추가, audit trail 보존, v5.11 L1 패턴 정합)
- risk: R6 v1.17 안 '/review built-in' 변경 부재 자연; mitigation: D7 채택 (footnote 추가만, inline 정정 부재 — spec 정합 표현 보존)
- risk: R7 audit chain hallucination cycle 3 trigger 충족; mitigation: D9 채택 (PROPOSE.next_candidates#1 진급 narrative, forward-only policy 정합)

## Five perspective review result

- **architecture**: {"verdict": "pass_with_comments", "recommendations_absorbed": ["claude-docs-mapper.md dual treatment 명시 (D1)", "phase-1.md 8→10 location count (affected_files 9+1 phase-1.md)", "VERIFY negative grep (Category 3 host 침범 검증)"]}
- **spec_drift**: {"verdict": "fail (decisive issue 흡수)", "recommendations_absorbed": ["D2.exact_text 재작성", "INTENT.goal + sc 일괄 교체", "out_of_scope #4 제거 + scope 확장", "RESEARCH.external 4번째 source 추가 (총 5 source)"]}
- **regression_risk**: {"verdict": "pass", "recommendations_absorbed": ["pre-commit 14 hook full-pass 검증 (Stage F commit 직전)", "markdownlint MD032/MD049 self-check", "blockquote 위치 일관성 verify"]}
- **scope_contract**: {"verdict": "pass", "recommendations_absorbed": ["D2.exact_text 정확 삽입 위치 9 double-check", "Stage G grep 키워드 검증 명시", "v1.17 audit trail 흡수 narrative 정확성 검증"]}

## narrative

본 DESIGN 은 v5.12 milestone 의 설계 — 9 결정 (D1~D9) + 1 phase + 7 risk_mitigation + 5 관점 검토 결과 (architecture pass_with_comments / spec-drift fail with decisive issue 흡수 / 회귀 risk pass / scope contract pass).

### Stage E APPROVE round 안 5 관점 subagent 검토 결과 흡수

**spec-drift agent decisive issue 흡수** (가장 중요):

- 발견: '`/review`·`/security-review`·`/init` = bundled skill' 분류 = spec drift. spec source 안 'bundled skill' 정의 = prompt-based playbook (`/simplify`·`/batch`·`/debug`·`/loop`·`/claude-api`). `/review` 등은 built-in command (fixed-logic), Skill tool invocable sub-classification (직교).
- 흡수: D2.exact_text 재작성 + INTENT.goal + sc + RESEARCH.external 5 source cascade 갱신 + scope 7→9 파일 (drift origin v5.10 mapper-output.md 6 위치 + diff-vs-v1.17.md 1 위치 추가).

**architecture / 회귀 risk / scope contract** = 위 JSON 안 명시.

### v5.7 spec-drift spike 3 단계 패턴 도그푸드 (b) DESIGN 단계 완료

D2.exact_text = 정확 분류 narrative 1차 source:

> `/review`·`/security-review`·`/init` 는 Skill tool 안 discover + execute 가능 built-in command (fixed-logic, `code.claude.com/docs/en/skills` 명시). Bundled skill (prompt-based playbook, e.g., `/simplify`·`/batch`·`/debug`·`/loop`·`/claude-api`) 범주 아님 — 별 sub-classification, 직교.

이 exact_text = Stage F EXECUTE 안 각 위치 정확 삽입 base. Stage G VERIFY 안 grep 키워드 3건 (`Skill tool 안 invoke`, `built-in command`, `code.claude.com/docs/en/skills`) 검증 base.

### D1 hybrid 정정 위치 처리 (9 파일)

- **inline 정확화** (거명 명시 4 파일):
  - `agents/claude-docs-mapper.md` L34 (`예: /review, /security-review, /init` 다음 inline 정확화)
  - `agents/component-proposer.md` L71 (`/review` → `/review (Skill tool invocable)`)
  - `bootstrap/claude-code-catalog/README.md` L52~L55 표 안 Source 컬럼 정확화
  - `agents/claude-docs-mapper.md` ## Role 다음 § Note 추가 (frontmatter description 보완)
- **footnote 추가** (거명 부재 일반 표현 또는 audit trail 보존 5 파일):
  - `agents/harness-gap-analyzer.md` L43 다음 매트릭스 footnote
  - `agents/project-harness-audit-team/CLAUDE.md` L17 다음 표 footnote
  - `bootstrap/agents/CLAUDE.md` L155 다음 매트릭스 footnote
  - `projects/upbit/audit-2026-05-14/proposal-draft.md` 5 위치 footnote (정보성 cross-ref, D7)
  - `projects/upbit/audit-2026-05-18/mapper-output.md` 6 위치 [v5.12 정정] footnote (D8)
  - `projects/meta/milestones/v5.10/diff-vs-v1.17.md` 1 위치 [v5.12 정정] footnote (D8)

### D9 audit chain hallucination cycle 3 trigger 충족 narrative

memory feedback_subagent_fact_hallucination_correction.md cycle 3 direct evidence 도달 → v5.11 PROPOSE#1 trigger 조건 (사용자 명시 발의 ∧ evidence cycle 3 도달) 충족. 본 v5.12 PROPOSE.next_candidates#1 안 `audit-chain-fact-verification-protocol-procedure` 진급 (forward-only policy 정합).
