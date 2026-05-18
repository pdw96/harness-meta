# DESIGN — v5.13 audit-chain-fact-verification-protocol-procedure

```json
{
  "id": "v5.13_audit-chain-fact-verification-protocol-procedure",
  "decisions": [
    {
      "id": "D1",
      "decision": "Option O3 채택 — harness-meta.md --audit 분기 step 추가 + audit-team CLAUDE.md D8 외부 Note 추가 + ARCHITECTURE.md § 4 끝 cross-ref 갱신 (3 파일)",
      "rationale": "두 workflow 진입 경로 (slash command 실행자 + D8 orchestration 독자) 모두 coverage + ARCHITECTURE § 4 끝 기존 paragraph 와 3-layer 상호 cross-ref (정의 → orchestration → workflow step) 완성. architecture review 권고 1 + scope contract review 권고 1 흡수.",
      "alternatives_rejected": [
        "O1 단독 (audit-team CLAUDE.md 독자 coverage 부재)",
        "O2 단독 (harness-meta.md workflow 실행 경로 내 step 부재)"
      ]
    },
    {
      "id": "D2",
      "decision": "exact_text 3 unit 정의 (v3.21 narrative 정전화 3 단계 패턴 — DESIGN D2 1차 source)",
      "rationale": "각 삽입 위치별 정확 텍스트를 DESIGN 에서 1차 source 로 정의하고 Stage F Edit 에서 그대로 삽입 — VERIFY grep 키워드 3개 사전 확정.",
      "exact_text": {
        "harness_meta_md_step": "  → [synthesizer] audit chain 산출물 fact 직접 검증 (fact 인용·boolean·표·수치 발견 시 직접 source 매핑 검증, ARCHITECTURE.md § 4 끝 'Audit chain fact 인용 검증 의무' 정의 준수)",
        "audit_team_note": "> **Note** (v5.13): synthesizer (메인 Claude orchestrator) 는 Step 1~4 각 멤버 산출물 안 fact 인용 (boolean / 표 / 수치) 발견 시 직접 source 매핑 검증 의무 (v5.13_audit-chain-fact-verification-protocol-procedure 절차화). hallucination 발견 시 (a) 산출물 archive 보존 + 정정 narrative inline 추가 + cascade 흡수 위치 동기 정정. 정의 단일 source: [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 4 끝 '**Audit chain fact 인용 검증 의무**' paragraph (v5.11 정전화). 절차 step: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) `--audit` 분기.",
        "architecture_cross_ref_append": " 절차화 (v5.13): [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) `--audit` 분기 안 synthesizer fact 검증 step + [`../../agents/project-harness-audit-team/CLAUDE.md`](../../agents/project-harness-audit-team/CLAUDE.md) D8 sequence 섹션 Note.",
        "verify_grep_keywords": ["fact 직접 검증", "Audit chain fact 인용 검증 의무", "v5.13"]
      },
      "alternatives_rejected": [
        "D8 코드블록 내부 Step 삽입 — subagent 책임 vs synthesizer 책임 혼재 위험 (architecture review 권고 3 흡수)"
      ]
    },
    {
      "id": "D3",
      "decision": "1-phase Lightweight — 3 파일 단일 phase-1 commit",
      "rationale": "변경 scope = 텍스트 3 unit 삽입 (구현 없음). 1-phase 패턴 정합 (lightweight 13/29 누적). cascade drift 동기화 보장 (architecture review 권고 4 흡수).",
      "alternatives_rejected": [
        "2-phase (harness-meta.md + audit-team 별도 commit) — scope 분할 이점 없음"
      ]
    },
    {
      "id": "D4",
      "decision": "harness-meta.md --audit 분기 삽입 위치: proposal-draft.md 산출 직후 / 사용자 결정 게이트 직전",
      "rationale": "fact 검증 목적 = 사용자에게 proposal-draft 넘기기 전 hallucination 정정. architecture review 권고 2 흡수.",
      "alternatives_rejected": []
    },
    {
      "id": "D5",
      "decision": "ARCHITECTURE.md § 4 끝 paragraph (L137) 끝에 cross-ref append",
      "rationale": "sc_3 '상호 cross-ref' 필수 충족. scope contract review 권고 1 흡수. paragraph 전체 재작성 불요 — append 로 minimal drift.",
      "alternatives_rejected": [
        "ARCHITECTURE § 4 끝 paragraph 전체 재작성 — 기존 정전화 내용 불변 원칙 위배"
      ]
    }
  ],
  "approach": "ARCHITECTURE.md § 4 끝 기존 paragraph (WHAT 정의) + harness-meta.md --audit 분기 step (WHERE/HOW 절차) + audit-team CLAUDE.md D8 Note (orchestration 맥락 책임 명시) 3-layer 보완 구조 완성. v3.21 narrative 정전화 3 단계 패턴 (D2 exact_text → F Edit → G grep) 15 번째 cycle.",
  "phases": [
    {
      "n": 1,
      "title": "3 파일 fact 검증 step/note/cross-ref 삽입",
      "scope": "claude/commands/harness-meta.md --audit 분기 step 추가 + agents/project-harness-audit-team/CLAUDE.md D8 외부 Note 추가 + projects/meta/ARCHITECTURE.md § 4 끝 cross-ref append",
      "affected_files": [
        "claude/commands/harness-meta.md",
        "agents/project-harness-audit-team/CLAUDE.md",
        "projects/meta/ARCHITECTURE.md",
        "projects/meta/milestones/v5.13/execute/phase-1.md"
      ],
      "rationale": "3 삽입 단위 원자적 1 commit — cascade drift 동기화 + 1-phase lightweight",
      "risks": "ARCHITECTURE.md § 4 끝 append 위치 확인 필요 (기존 paragraph 말미 정확 매핑)"
    }
  ],
  "risk_mitigation": [
    {
      "risk": "ARCHITECTURE.md § 4 끝 paragraph append 위치 오인",
      "mitigation": "Stage F EXECUTE 전 Read ARCHITECTURE.md L137 정확 확인 후 Edit (old_string 명시 정합)"
    },
    {
      "risk": "harness-meta.md --audit 분기 step 삽입 후 proposal-draft 산출 흐름 단절",
      "mitigation": "삽입 위치 = proposal-draft.md 직후 줄 → 기존 흐름 유지 (단순 줄 추가)"
    }
  ],
  "review_summary": {
    "architecture": "pass_with_comments — 4 권고 흡수 (D1/D4/D2/D3 각각 반영)",
    "spec_drift": "pass_with_comments — blocking 없음, frontmatter short-alias 기존 사항 (scope 외)",
    "scope_contract": "pass_with_comments — cross-ref 3-layer + execute/phase-1.md affected_files 의무 명시"
  }
}
```

## 관점 검토 요약

| # | 관점 | 결과 | 핵심 권고 흡수 |
|:-:|------|------|-------------|
| 1 | architecture | pass_with_comments | D4 삽입 위치 / D2 Note 외부 배치 / D5 cross-ref 필수화 / D3 단일 phase |
| 2 | spec-drift | pass_with_comments | blocking 없음 — D8 Note 외부 배치 D8 sequence cross-ref 확인 권고 |
| 3 | scope contract | pass_with_comments | sc_3 3-layer cross-ref / execute/phase-1.md affected_files 의무 |

충돌 없음 → AskUserQuestion 불필요.

## D2 exact_text 삽입 매핑

| 파일 | 삽입 위치 | 텍스트 unit |
|------|---------|-----------|
| `claude/commands/harness-meta.md` | `--audit` 분기 코드블록 L79 (`→ proposal-draft.md 산출`) 직후 | `harness_meta_md_step` |
| `agents/project-harness-audit-team/CLAUDE.md` | D8 sequence 코드블록 종료 직후, `병렬 가능성` paragraph 직전 | `audit_team_note` |
| `projects/meta/ARCHITECTURE.md` | L137 paragraph 끝 마침표 직전 (기존 문장 말미) | `architecture_cross_ref_append` |
