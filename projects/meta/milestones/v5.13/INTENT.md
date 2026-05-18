# INTENT — v5.13 audit-chain-fact-verification-protocol-procedure

```json
{
  "id": "v5.13_audit-chain-fact-verification-protocol-procedure",
  "title": "audit chain 산출물 fact 검증 절차 정전화",
  "goal": "audit chain (project-scanner → harness-gap-analyzer → claude-docs-mapper → component-proposer) 4 멤버 산출물 안 외부 1차 source fact 인용 시 synthesizer 가 직접 검증하는 절차를 workflow 안에 정전화한다. Stage A OPEN 단계 또는 agents/project-harness-audit-team/CLAUDE.md 안 검증 책임을 명시적 step 으로 고정하여 hallucination cascade 재발을 구조적으로 차단한다.",
  "motivation": "v5.10~v5.12 세 milestone 을 거쳐 audit chain hallucination cycle 이 3 회 누적 관측되었다 — cycle 1 v5.10 (component-proposer 12 항목 표 hallucination, synthesizer overwrite 정정) / cycle 2 v5.11 (project-scanner claude_md_in_repo: false hallucination, inline 정정 archive) / cycle 3 v5.12 (mapper 'bundled skill 별칭' spec drift, 9 파일 cascade hybrid 정정). 현재 memory feedback_subagent_fact_hallucination_correction 에 검증 의무가 기록되어 있고 ARCHITECTURE.md § 4 끝 paragraph 로 정전화되어 있으나, workflow 절차 문서 (harness-meta.md command / audit-team CLAUDE.md) 안에는 검증 step 이 부재하다. synthesizer 가 '알아서 해야 한다'는 사후 교정 모델 → '절차 안에 내장'으로 전환하는 것이 본 milestone 의 목적이다.",
  "success_criteria": [
    "sc_1: agents/project-harness-audit-team/CLAUDE.md 또는 claude/commands/harness-meta.md (--audit 분기) 안에 'audit chain 산출물 fact 직접 검증' step 이 명시적으로 추가된다",
    "sc_2: 추가된 step 은 v3.21 narrative 정전화 3 단계 패턴 ((a) DESIGN.D2.exact_text 1차 source + (b) Stage F Edit 정확 삽입 + (c) VERIFY grep 3 키워드) 을 준수한다",
    "sc_3: ARCHITECTURE.md § 4 끝 기존 paragraph ('Audit chain fact 인용 검증 의무', v5.11 정전화) 와 신규 step 이 상호 cross-ref 하여 중복 없이 보완 관계를 형성한다",
    "sc_4: pre-commit 14 hook 모두 PASS, 회귀 0",
    "sc_5: smoke-spec-verification / smoke-scope-contract 모두 PASS"
  ],
  "out_of_scope": [
    "audit chain 4 멤버 agent 자체 구현 변경 (agent 내부 로직 수정 — 절차 문서 추가만)",
    "새 smoke test 추가 (기존 smoke 검증만 적용)",
    "upbit 등 외부 프로젝트 audit chain 실 호출 (절차 정전화 narrative 만)",
    "context7 multi-source 검증 의무 narrative 정전화 (v5.12 PROPOSE#3 별 후보)"
  ],
  "dependencies": {
    "predecessor": "v5.12_bundled-skill-narrative-cleanup (PROPOSE#1 carry-over, cycle 3 direct evidence 도달)",
    "successor": null
  }
}
```

## narrative

본 INTENT 는 workflow 절차 문서 안 fact 검증 step 부재 → 명시적 step 추가 단 하나의 목적에 집중한다. ARCHITECTURE.md § 4 끝 정전화 paragraph (v5.11) 는 '무엇을 해야 하는가'의 단일 source 이며, 본 milestone 은 '어디서 어떻게 하는가'의 절차 step 을 추가하는 작업이다. implementation detail (어느 파일, 어느 위치, 정확한 텍스트) 은 Stage D DESIGN 에서 결정한다.
