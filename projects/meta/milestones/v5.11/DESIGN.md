---
id: v5.11_audit-chain-fact-verification-discipline
title: DESIGN v5.11
version: v5.11
stage: DESIGN
status: completed
---

# DESIGN — v5.11 audit-chain-fact-verification-discipline

## Spec

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "정전화 host = projects/meta/ARCHITECTURE.md § 4 끝 L135 cascade drift paragraph 직후 + § 4.1 Bundling 헤더 (L137) 직전 = 단일 paragraph 1건. 다른 host (bootstrap/agents/CLAUDE.md / agents/project-harness-audit-team/CLAUDE.md / claude/commands/harness-meta.md 등) 변경 0.",
      "rationale": "v3.20 + v3.21 + v5.7 + v5.8 + v5.9 + v5.10 단일 source 전략 6 cycle 누적 정합. v5.10 cascade drift paragraph 와 의미 인접 + cycle 2 evidence 직접 연관 = 동일 host § 4 끝 묶음 자연. 다른 host 변경 시 다중 source drift risk + lightweight LOC cap 압박.",
      "alternatives_rejected": [
        "A1: agents/project-harness-audit-team/CLAUDE.md (5 멤버 매트릭스 직후) — 도구 거주 host 으로 자연이나 ARCHITECTURE 의 정의 단일 source 책임 위배 + ARCHITECTURE 안 v5.10 cascade drift paragraph 와 분리 = cross-ref 비대칭",
        "A2: bootstrap/agents/CLAUDE.md (상위 진입) — agent fleet 정책 narrative 거주 host 이나 audit chain fact 검증 narrative 의 특수 본질 약화"
      ]
    },
    {
      "id": "D2",
      "decision": "정전화 paragraph 정확 문구 (markdown code block) — v3.21 narrative 정전화 3 단계 패턴 (a) 1차 source. EXECUTE Edit tool 안 그대로 삽입 (b). VERIFY grep 검증 키워드 3건 (c) = (1) 'Audit chain fact 인용 검증 의무' / (2) 'v5.11_audit-chain-fact-verification-discipline' / (3) 'cycle 2 도달 trigger'.",
      "rationale": "v3.21 3 단계 패턴 13 번째 cycle 도그푸드. 정확 문구 1차 source 책임 = DESIGN.md 안 markdown code block, EXECUTE Edit 안 'old_string' 'new_string' 정확 매칭 가능, VERIFY grep 안 키워드 cohesive 추출 가능.",
      "exact_text": "**Audit chain fact 인용 검증 의무** (v5.11_audit-chain-fact-verification-discipline 정전화): audit chain 4 멤버 (`project-scanner` / `harness-gap-analyzer` / `claude-docs-mapper` / `component-proposer`) 산출물 안 외부 1차 source fact 인용 시 synthesizer (메인 Claude orchestrator) 의 직접 매핑 검증 의무. evidence cycle 2 도달 trigger — (1) v5.10 L1 `component-proposer` 12 항목 표 hallucination (django/ai-ready-scorer 등 upbit 무관) → synthesizer overwrite 정정 + (2) v5.10 `project-scanner` `claude_md_in_repo: false` hallucination → 3 산출물 (analyzer/mapper/proposal-draft) cascade 흡수 + v5.10 PROPOSE.next_candidates#4 안 5 차 위치 인용 누적 stale → v5.11 정정. 검증 운용 의무 — (a) audit chain 산출물 안 fact 인용 (boolean / 표 / 수치) 발견 시 synthesizer 가 직접 source (예: 파일 존재 여부 `ls` / 파일 내용 `Read`) 매핑 검증, (b) hallucination 발견 시 산출물 archive 보존 + 정정 narrative inline 추가 (overwrite 회피, audit trail 보존) + cascade 흡수 위치 (ROADMAP entry / PROPOSE.next_candidates / 다른 carry-over milestone) 동기 정정. 진단 + audit chain 산출물 1차 source = [`milestones/v5.11/RESEARCH.md`](milestones/v5.11/RESEARCH.md) + [`milestones/v5.10/RESEARCH.md`](milestones/v5.10/RESEARCH.md) + [`../upbit/audit-2026-05-18/`](../upbit/audit-2026-05-18/).",
      "alternatives_rejected": [
        "A1: 절차 변경 (claude/commands/harness-meta.md Stage A 또는 Stage D 안 fact 검증 step 신규) — workflow self-improvement 본질 strongest 재진입 risk. § 6.2 폐지 narrative 정합 약화. narrative 정전화만 절차 변경 부재 default.",
        "A2: 짧은 1-2 line — v3.21 3 단계 패턴 정합 약화 + evidence cycle 2 정량 + 검증 운용 의무 narrative 모두 1 paragraph 흡수 필요"
      ]
    },
    {
      "id": "D3",
      "decision": "옵션 O1 (archive with correction narrative) 채택 — v5.10 audit-2026-05-18/ 4 산출물 안 14 위치 inline 정정 + 정정 cross-ref narrative 추가. audit trail 보존 + 추적성. v5.10 PROPOSE.md next_candidates#4 entry block 도 동일 패턴 (entry 보존 + stale 표지 + 정정 narrative).",
      "rationale": "RESEARCH.options_recommendation 정합. memory feedback_subagent_fact_hallucination_correction 안 'evidence 보존' 원칙 정합. v5.10 L1 component-proposer hallucination overwrite (synthesizer 산출 표지 부재) 와 본 scanner-output.md (agent 직접 산출 표지 존재) 비대칭 정합.",
      "alternatives_rejected": [
        "O2_overwrite_full — audit trail 손실, evidence 추적성 손실",
        "O3_meta_correction_md_separate — 별도 파일 단일성 약화, cascade grep 효율 저하"
      ]
    },
    {
      "id": "D4",
      "decision": "1 phase Lightweight 모드 — 5 관점 subagent 생략 + 자기참조 회피 표지 + LOC cap ~1500 (산출물 7종 + execute/phase-1.md + milestones.md).",
      "rationale": "audit chain fact 검증 narrative 정전화 = workflow self-improvement 의 인접 본질 (audit team = workflow 의 한 layer). lightweight 누적 11/28 = 39.3% 갱신 (v5.10 까지 10/27 → 본 v5.11 = 11/28). v3.6 § 6.2 폐지 narrative 정합 + v3.20 / v3.21 / v5.7 / v5.8 / v5.9 / v5.10 lightweight 패턴 정합."
    },
    {
      "id": "D5",
      "decision": "INTENT~APPROVE commit 시점 (b) default — Stage G+H+I 통합 chore commit 안 INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE 7건 + milestones.md 포함. phase-1 commit 안 ARCHITECTURE.md edit + audit 4 산출물 inline 정정 + v5.10 PROPOSE.md next_candidates#4 정정 + execute/phase-1.md 포함.",
      "rationale": "1-phase lightweight default (v5.7~v5.10 정합). 산출물 영구 보존 보장 + commit timing 안정성."
    },
    {
      "id": "D6",
      "decision": "v1.17 audit chain hallucination 부재 사실 진술 흡수 — sc_5 verdict = 정정 작업 불요. RESEARCH 검증 결과 (v1.17 RESEARCH.md L75 + REPORT.md L56 안 정확 fact 'CLAUDE.md:54 SymbolicLink/install.ps1 narrative' = hallucination 부재) 사실 진술로 본 milestone 안 흡수.",
      "rationale": "사용자 sc_5 명시 결정 (RESEARCH 단계 v1.17 검증 포함) 결과 = 검증 완료 + 결과 negative (부재 확인). 본 milestone scope 외 정정 작업 부재 사실 진술 — VERIFY.criteria_check 안 sc_5 = PASS_WITH_NOTE (v1.17 cycle 정상 작동, 정정 작업 불요)."
    },
    {
      "id": "D7",
      "decision": "ROADMAP v5.10 entry summary 정정 = 부재 (stale 부재). v5.10 entry summary 안 'L1 component-proposer hallucination' 만 명시 (작성 시점 사실, scanner hallucination 은 본 v5.11 신규 발견 fact). 정정 위치 = v5.10 PROPOSE.md next_candidates#4 entry block 안 origin + rationale + decision 만.",
      "rationale": "RESEARCH affected_files ROADMAP entry 정정 가능성 검증 결과 = grep 위치 line 16 (본 v5.11 entry, 정확 정정 narrative 자체 거주) + line 25 (v5.10 entry, scanner hallucination 미언급, 작성 시점 사실). ROADMAP entry summary 안 stale fact 부재 = 정정 작업 부재. 실 정정 위치 = v5.10 PROPOSE.md next_candidates#4 entry block.",
      "alternatives_rejected": [
        "A1: ROADMAP v5.10 entry summary 안 'scanner hallucination 사실 cascade 정정' 추가 — 본 v5.11 신규 발견 fact 의 v5.10 entry 안 retroactive 흡수 = entry 작성 시점 사실 보존 원칙 위배"
      ]
    },
    {
      "id": "D8",
      "decision": "v5.10 PROPOSE.md next_candidates#4 entry block (line 22~28) 정정 narrative 패턴 — 원본 entry 보존 + 'stale 표지' inline 추가 + 정정 cross-ref [`milestones/v5.11/`](milestones/v5.11/) 추가. id `upbit-claude-md-repo-root-creation` decision 필드 = '거명만 (ROADMAP 등재 zero)' → '거명만 (ROADMAP 등재 zero) — v5.11 정정: 대상 파일 (upbit/CLAUDE.md) 이미 존재 (v1.17 phase-3 commit a856ddc, 9430 bytes), origin scanner-output.md fact hallucination 확정' 형태.",
      "rationale": "audit trail 보존 (D3 O1 정합) + inline 정정 narrative = 후속 검색 시 stale fact + 정정 fact 동시 노출."
    },
    {
      "id": "D9",
      "decision": "자기참조 부합 (도그푸드) — 본 milestone 자체가 audit chain fact 인용 검증 의무 narrative 정전화 의 첫 도그푸드. RESEARCH 단계 v1.17 audit chain hallucination 부재 검증 + scanner-output.md hallucination 확정 검증 = synthesizer 직접 매핑 검증 의무 D2 narrative 부합. v5.10 cascade drift paragraph 와 인접 위치 정전화 = narrative 의미 인접 cascade 자연.",
      "rationale": "v3.0+ 9-stage-bundled era 자기참조 부합 원칙 (도그푸드). v3.21 narrative 정전화 3 단계 패턴 13 번째 cycle 도그푸드 의도 정합. lightweight 모드 자기참조 회피 표지 와 동시 적용 (도그푸드 ↔ 회피 표지 비대칭은 v3.18 + v3.20 + v3.21 + v5.10 누적 5 cycle 정합)."
    }
  ],
  "phases": [
    {
      "n": 1,
      "title": "ARCHITECTURE narrative 정전화 + audit 4 산출물 14 위치 inline 정정 + v5.10 PROPOSE.md next_candidates#4 정정 + milestones.md 동기",
      "scope": "ARCHITECTURE.md (D2 exact_text 1 paragraph 삽입, ~12-18 line) + projects/upbit/audit-2026-05-18/{scanner,analyzer,mapper,proposal-draft}-output.md (14 위치 inline 정정) + projects/meta/milestones/v5.10/PROPOSE.md (next_candidates#4 entry block 정정) + projects/meta/milestones/v5.11/milestones.md (sub_milestones 1:1 동기) + projects/meta/milestones/v5.11/execute/phase-1.md (신규 작성)",
      "affected_files": [
        "projects/meta/ARCHITECTURE.md",
        "projects/upbit/audit-2026-05-18/scanner-output.md",
        "projects/upbit/audit-2026-05-18/analyzer-output.md",
        "projects/upbit/audit-2026-05-18/mapper-output.md",
        "projects/upbit/audit-2026-05-18/proposal-draft.md",
        "projects/meta/milestones/v5.10/PROPOSE.md",
        "projects/meta/milestones/v5.11/milestones.md",
        "projects/meta/milestones/v5.11/execute/phase-1.md"
      ],
      "rationale": "1 phase lightweight default (v5.7~v5.10 누적 4 cycle 정합 + D4). ARCHITECTURE 정전화 + 4 산출물 정정 + PROPOSE.md 정정 + milestones.md 동기 = 단일 commit 안 atomic apply.",
      "risks": [
        "ARCHITECTURE.md § 4 끝 paragraph 정전화 위치 안 v5.10 paragraph 와 위치 인접 시 narrative drift 재발 risk (R1 정합)",
        "audit 4 산출물 안 markdown table 안 fact (e.g., scanner L150 표) 정렬 깨짐 risk (R2 정합)",
        "v5.10 PROPOSE.md next_candidates#4 entry block 안 inline 정정 narrative 길이 추가 시 다른 entry 와 비대칭 risk"
      ]
    }
  ]
}
```

## Approach

단일 phase Lightweight Edit 적용 — (a) ARCHITECTURE.md § 4 끝 L135 cascade drift paragraph 직후 + § 4.1 Bundling 헤더 (L137) 직전에 D2 exact_text paragraph 삽입 (단일 source). (b) v5.10 audit-2026-05-18/ 4 산출물 안 14 위치 inline 정정 narrative 추가 (O1 archive with correction). (c) v5.10 PROPOSE.md next_candidates#4 entry block 안 stale 표지 + 정정 cross-ref 추가. (d) milestones.md sub_milestones[] 1:1 동기 갱신 (placeholder title → 정확 phase title). (e) execute/phase-1.md 작성 (status: in_progress → complete). 본 milestone 자체가 자기 검증 (audit chain hallucination 정정 후 narrative 정전화) 도그푸드.

## Risk mitigation

- risk: R1: ARCHITECTURE § 4 끝 narrative drift 재발; mitigation: phase-1 EXECUTE 안 grep 'Narrative cascade drift' 단일 위치 확인 (v5.10 paragraph 거주 확인) + D2 exact_text 안 v5.10 paragraph cross-ref 명시 ('evidence cycle 2 도달 trigger' narrative 안 (1) v5.10 L1 + (2) v5.10 project-scanner = 두 origin 통합)
- risk: R2: markdown table 정렬 깨짐; mitigation: phase-1 EXECUTE 안 Edit 직후 markdown 시각 검증 + pre-commit markdownlint hook 의존 + inline 정정 narrative 는 표 외부 (e.g., bullet list 하단 또는 narrative paragraph 안) 배치
- risk: R3: ROADMAP v5.10 entry summary 길이 추가; mitigation: D7 결정 — ROADMAP 정정 부재 (stale 부재 확인). 실 정정 위치 = v5.10 PROPOSE.md next_candidates#4 entry block 단일
- risk: R4: 자기참조 cycle 재진입; mitigation: lightweight 모드 적용 (D4) + § 6.2 폐지 narrative 정합 + v5.10 cascade drift paragraph 와 패턴 정합 (narrative 정전화 only, 절차 변경 부재 — D2 A1 alternatives_rejected 정합)
- risk: R5: v1.17 audit chain hallucination 부재 검증 누락; mitigation: RESEARCH 단계 grep 검증 완료 (v1.17 RESEARCH.md L75 + REPORT.md L56 = hallucination 부재 확정). D6 결정으로 사실 진술 흡수.

## narrative

본 DESIGN 은 v5.11 milestone 의 설계 단일 source. RESEARCH 결과 + INTENT.success_criteria 흡수 + 9 결정 (D1~D9) + 1 phase Lightweight + 5 risk_mitigation.

### 5 관점 subagent 생략 narrative (lightweight 모드 자기참조 회피 표지)

audit chain fact 검증 narrative 정전화 = workflow self-improvement 의 인접 본질 (audit team = workflow 의 한 layer). 5 관점 subagent (architecture / spec-drift / 회귀 risk / scope contract / 보안) 호출 시 본 milestone 자체에 대한 self-loop 강화 risk (v5.10 까지 자기참조 회피 표지 cycle 10 누적 정합).

대안 검증 = D1~D9 9 결정 안 alternatives_rejected 자체 흡수 + RESEARCH options 비교 안 4 options 평가 + risk_mitigation 5 risks_identified 1:1 매핑 = 5 관점 review 의 정상 작동 대체 evidence.

### D2 exact_text 1차 source 책임

D2 안 `exact_text` JSON 필드 = v3.21 narrative 정전화 3 단계 패턴 (a) 1차 source. Stage F EXECUTE 안 Edit tool 의 `new_string` 정확 매칭 + Stage G VERIFY 안 grep 키워드 3건 (D2 정합) cohesive 추출 가능.

### 자기참조 도그푸드 narrative (D9)

본 milestone 자체가 audit chain fact 인용 검증 의무 narrative 정전화 의 첫 도그푸드 — RESEARCH 단계 v1.17 audit chain hallucination 부재 검증 + scanner-output.md hallucination 확정 검증 = synthesizer 직접 매핑 검증 의무 D2 narrative 부합. lightweight 모드 자기참조 회피 표지 와 동시 적용 = 비대칭 정합 (v3.18 + v3.20 + v3.21 + v5.10 누적 5 cycle 정합).

### decisions / phases 부산물 정책 정합 (v3.10)

`decisions[i].rationale` + `phases[n].scope` 모두 (a) 사실 진술만 — '본 milestone 의 결정 / 단계 범위'. 후속 milestone 명명 표현 부재. v3.10_stage-byproduct-clarification 정합. 후속 candidate origin 가능성은 Stage I PROPOSE 통합 흡수.

### milestones.md sub_milestones 동기 갱신 (v3.5 phase-2 의무 step)

Stage D 완료 직전 의무 step (v3.5_open-stage-discipline-strengthening phase-2 도입) — phases[1] 확정 후 milestones/v5.11/milestones.md sub_milestones[0] placeholder title 교체 = phase-1 정확 title (ARCHITECTURE narrative 정전화 + audit 4 산출물 14 위치 inline 정정 + v5.10 PROPOSE.md next_candidates#4 정정 + milestones.md 동기). Stage E APPROVE 진입 전 갱신 완료.
