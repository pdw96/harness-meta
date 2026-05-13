# DESIGN — v3.20_drift-narrative-canonicalization

```json
{
  "id": "v3.20_drift-narrative-canonicalization",
  "decisions": [
    {
      "decision_id": "D1",
      "decision": "narrative 위치 = ARCHITECTURE.md § 4 끝 (line 117 B/C/D 부산물 흡수 paragraph 직후, § 4.1 Bundling 헤더 직전)",
      "rationale": "단어 = 단일 책임 1:1 매핑 (line 103) + 9 stage 표 (line 105~115) + B/C/D 부산물 흡수 책임 (line 117) → drift 수용 (신규) 4 단계 narrative 자연 결속. 단어 책임 정의 영역 (§ 4 본문) 안 자연 위치. 사용자 명시 선택 (AskUserQuestion D1).",
      "alternatives_rejected": [
        "Option 2 (§ 4.1 Bundling 안 line 168 → 169) — drift narrative 본질 = 단어 책임 정의 영역 (§ 4) ↔ Bundling 영역 (§ 4.1) 책임 부적합",
        "Option 3 (§ 3.3 5요소 매트릭스) — § 3 단일 source 정합 정책 (§ 3.5 line 87) 위반 risk + drift narrative 가 정의 자체 변경 차원 § 3 책임 침범",
        "Option 4 (§ 6.2 Lightweight 안) — § 6 운용 정책 영역 ↔ drift 단어 책임 영역 (§ 4) 책임 혼재"
      ]
    },
    {
      "decision_id": "D2",
      "decision": "narrative 정확 문구 = '**Word-fidelity drift 수용** (v3.19_word-fidelity-audit-v2 진단 + v3.20_drift-narrative-canonicalization 정전화)' bold lead + 정량 cross-ref 3건 (평균 86.1% / APPROVE 100% / PROPOSE 70%) 본문 + v3.19 RESEARCH 1차 source link + drift 의도성 (pragmatic 절충) + § 6.2 동결 정책 cross-ref",
      "rationale": "v3.18 D3 정확 cross-ref 패턴 정합 (1 paragraph 안 정량 + source link + 정책 cross-ref). INTENT.success_criteria 2/3 검증 가능 (grep '86.1%' + 'APPROVE 100%' + 'PROPOSE 70%' + 'drift 의도성' 또는 동치 키워드).",
      "alternatives_rejected": [
        "긴 narrative (multi-paragraph 분할) — v3.18 패턴 정합 부재 + lightweight 모드 LOC cap 위반 risk",
        "정량 cross-ref 일부 (예: 평균만) — INTENT.success_criteria 2 위반"
      ]
    },
    {
      "decision_id": "D3",
      "decision": "단일 source 전략 = ARCHITECTURE.md 만 변경 + 다른 host (CLAUDE.md / 모듈 가이드 / harness-meta.md) cross-ref 추가 zero",
      "rationale": "v3.18 D1 Option 1 채택 패턴 정확 정합 (v1.4_cross-ref-propagation 정책 정합). § 3.5 단일 source 정합 narrative 직접 적용 — '본 § 3 (정의) 는 본 파일이 단일 source. 다른 문서는 cross-ref 만'. 본 milestone narrative 가 § 3 영역 아닌 § 4 영역이지만 단일 source 원칙은 ARCHITECTURE.md 전반 적용 (단순 narrative 확장 부재).",
      "alternatives_rejected": [
        "다른 host cross-ref 추가 (CLAUDE.md root § 워크플로우 또는 projects/meta/CLAUDE.md) — drift narrative cascade 책임 본 milestone scope 외 (cross-ref 무한 확장 risk)"
      ]
    },
    {
      "decision_id": "D4",
      "decision": "lightweight 모드 채택 (5 관점 subagent 생략 + 산출물 LOC cap < 800)",
      "rationale": "v3.6/v3.10/v3.13/v3.14/v3.17/v3.18/v3.19 누적 7/19 lightweight 패턴 정합 — narrative 정전화 (≤5 파일 + 충돌 부재 예상 + workflow self-improvement 본질). self_reference_policy: avoid 표지 명시 (§ 6.2 trigger 3건 충족).",
      "alternatives_rejected": [
        "일반 모드 (5 관점 subagent 검토) — scope 작음 (1 파일 변경 + narrative 1 paragraph) 대비 over-engineering, v3.18/v3.19 패턴 부재"
      ]
    },
    {
      "decision_id": "D5",
      "decision": "phase 분할 = 1 phase (ARCHITECTURE.md 1 paragraph 추가 + commit)",
      "rationale": "narrative 정전화 1 paragraph = 의미 단위 1건 → 1 phase 자연. v3.18 패턴 정합 (1-phase 1+1 commit 도그푸드). § 4.1 1-phase milestone 정합 narrative 정확 정합 (v3.17 진단 + v3.18 정전화).",
      "alternatives_rejected": [
        "다중 phase 분할 (예: phase-1 narrative 추가 + phase-2 cross-ref) — D3 단일 source 채택 결과 cross-ref 추가 zero → phase-2 scope 부재"
      ]
    },
    {
      "decision_id": "D6",
      "decision": "commit timing = (b) default (Stage G commit 안 INTENT/RESEARCH/DESIGN/APPROVE 4건 포함)",
      "rationale": "v3.17 L4 / v3.18 L3 / v3.19 L4 narrative — lightweight 1-phase 시 commit timing (b)/(c) 실 동치. (b) default 채택 → INTENT~APPROVE artifact 영구 보존 보장. phase-1 commit 안 = ARCHITECTURE.md 변경 + execute/phase-1.md / Stage G commit 안 = VERIFY/REPORT/PROPOSE/INTENT/RESEARCH/DESIGN/APPROVE/milestones.md 갱신.",
      "alternatives_rejected": [
        "(a) phase-1 commit 안 INTENT~APPROVE 포함 — 사용자 재량, lightweight 1-phase 시 (b) 와 실 동치"
      ]
    }
  ],
  "approach": "ARCHITECTURE.md § 4 끝 (line 117 직후, § 4.1 헤더 직전) 에 'Word-fidelity drift 수용' bold lead paragraph 1건 추가 — v3.19 진단 결과 (평균 86.1% / APPROVE 100% / PROPOSE 70%) + drift 의도성 (pragmatic 절충) + § 6.2 동결 정책 cross-ref + v3.19 RESEARCH 1차 source link 포함. 단일 source 전략 (D3) — 다른 host 변경 zero. lightweight 모드 (D4) — 5 관점 subagent 생략, 1 phase 1+1 commit, commit timing (b) default. milestones.md sub_milestones placeholder title 본 DESIGN 단계 정확 title 교체 (Stage D 의무 step, v3.5 도입).",
  "phases": [
    {
      "n": 1,
      "title": "ARCHITECTURE.md drift 수용 paragraph 추가 — § 4 끝 (line 117 직후) + commit",
      "scope": "ARCHITECTURE.md 안 § 4 끝 + 1 paragraph (drift narrative 정전화). 다른 host 변경 zero. 본 milestone 진단 결과 (v3.19) 외부 visible artifact 단일 source 보존.",
      "affected_files": [
        "projects/meta/ARCHITECTURE.md (drift narrative paragraph 추가 — line 117 직후)",
        "projects/meta/milestones/v3.20/execute/phase-1.md (본 phase 추적)",
        "projects/meta/milestones/v3.20/milestones.md (sub_milestones[0].title 정확 title 교체 + status complete + commit hash)"
      ],
      "rationale": "narrative 정전화 1 paragraph = 1 phase 자연 (D5). v3.18 / v3.19 패턴 정합 (1-phase 1+1 commit 도그푸드).",
      "risks": [
        "ARCHITECTURE.md 1 paragraph 추가 시 markdownlint MD031 (fenced code blocks blank lines) 또는 MD049 (emphasis style) trigger risk — pre-commit hook 자동 차단, v3.1 L1 mitigation 패턴 정합",
        "drift narrative 정확 문구 (D2) cohesive 부재 risk — VERIFY criteria_check 1:1 매핑 검증"
      ]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "R1 (narrative 위치 선택 narrowing)",
      "mitigation": "AskUserQuestion D1 사용자 명시 선택 (Option 1 § 4 끝) → 결정 사용자 위임, alternatives_rejected 안 옵션 2/3/4 raw 거명만 (v3.10 부산물 정책 정합)"
    },
    {
      "risk": "R2 (정확 문구 cohesive)",
      "mitigation": "D2 narrative 정확 문구 + VERIFY criteria_check 안 grep 검증 (정량 cross-ref 3건 + drift 의도성 키워드 + § 6.2 cross-ref) — 1:1 매핑 PASS 의무"
    },
    {
      "risk": "R3 (lightweight 5 관점 생략)",
      "mitigation": "v3.6~v3.19 누적 7/19 검증 패턴 정합 + self_reference_policy: avoid 표지 명시. 1 파일 변경 + ≤5 paragraph narrative 추가 = architecture 검토 본질 부재"
    },
    {
      "risk": "R4 (옵션 B/C trigger 해석)",
      "mitigation": "DESIGN.decisions D2 narrative 안 'drift 수용 = default, 실 변경 = evidence-base trigger 만' 명시 + Stage I PROPOSE 안 옵션 B/C 후속 candidate 거명만 (§ 6.2 동결 정합)"
    },
    {
      "risk": "R5 (lightweight 누적 8/20 = 40% 자기참조 모순)",
      "mitigation": "v3.17/v3.18/v3.19 narrative (lightweight 누적 동치화) 정합 — 진단 결과 narrative 정전화 (Option D 본질) + 사용자 명시 발의 (A_user) 충족 = § 6.2 정합. self_reference_policy: avoid 표지 명시"
    },
    {
      "risk": "R6 (cross-ref 누락)",
      "mitigation": "D3 단일 source 전략 명시 (다른 host cross-ref 추가 zero) — v3.18 D1 Option 1 패턴 정확 정합. cross-ref 누락 본질 부재 (단일 source 직접 적용)"
    }
  ],
  "byproduct_check": "DESIGN.decisions[i].rationale + phases[n].scope 모두 사실 진술 — 'PROPOSE.next_candidates 발의' / '별 milestone 분리' 등 forward propose 명령형 표현 부재 (v3.10 부산물 정책 정합)",
  "review": {
    "mode": "lightweight",
    "subagent_review_policy": "skipped (5 관점 subagent 생략, v3.6/v3.10/v3.13/v3.14/v3.17/v3.18/v3.19 패턴 정합)",
    "self_reference_policy": "avoid (workflow self-improvement 본질, § 6.2 자기참조 회피 표지)",
    "self_reference_rationale": "본 milestone 자체 1-phase 1+1 commit 도그푸드 = v3.18 D5 / v3.19 phase 패턴 정확 정합. 진단 결과 narrative 정전화 + Option D 본질 = drift 수용 narrative 가 자기 적용 결과 (도그푸드 자연)"
  }
}
```

## narrative

본 DESIGN 은 **lightweight 모드 정합** — 6 decisions (D1~D6) + 1 phase + 6 risk_mitigation + 5 관점 subagent 생략 (review.mode: lightweight).

D1 narrative 위치 (§ 4 끝) = 사용자 명시 선택 (AskUserQuestion). D2 정확 문구 (정량 cross-ref 3건 + drift 의도성 + § 6.2 cross-ref) = INTENT.success_criteria 2/3 검증 가능. D3 단일 source = v3.18 D1 Option 1 패턴 정확 정합. D4 lightweight = v3.6~v3.19 누적 7/19 검증 패턴. D5 1 phase + D6 commit timing (b) = v3.17/v3.18/v3.19 정합.

`decisions[i].rationale` + `phases[n].scope` 모두 사실 진술 — forward propose 명령형 부재 (v3.10 부산물 정책 정합).

## Phase 1 정확 narrative 정문구

ARCHITECTURE.md § 4 line 117 직후 삽입 paragraph (D2 정확 문구):

```markdown
**Word-fidelity drift 수용** (v3.19_word-fidelity-audit-v2 진단 + v3.20_drift-narrative-canonicalization 정전화): 위 9-stage 단어 = 단일 책임 1:1 매핑 (v2.0_workflow-word-fidelity 정정) 은 ideal 목표이며, 실 운용 부합도는 9 stage 평균 ~86.1% (APPROVE 100% 최고 부합 / PROPOSE 70% 최대 drift / OPEN 90% / INTENT 80% / RESEARCH 85% / DESIGN 80% / EXECUTE 85% / VERIFY 95% / REPORT 90%) — `projects/meta/milestones/v3.19/RESEARCH.md` 정량 1차 source. drift 의도성 = pragmatic 절충: 단일 책임 100% 부합 추구 시 workflow 비대화 risk (예: PROPOSE register 책임 분리 = 10-stage breaking change v4.0). drift 수용은 § 6.2 workflow self-improvement 동결 정책과 정합 — 진단 결과 narrative 정전화 (본 paragraph) 가 default, 실 변경 (10-stage 분리 / ROADMAP 재정의 / 단어 변경) 은 evidence-base trigger 만.
```

## milestones.md sub_milestones 동기 갱신 (Stage D 의무 step, v3.5 도입)

`projects/meta/milestones/v3.20/milestones.md` sub_milestones[0] placeholder title 본 DESIGN phase-1 title 정확 교체:

- placeholder: `<placeholder, Stage D DESIGN 단계에서 정확한 phase 분할 후 갱신>`
- 정확 title: `ARCHITECTURE.md drift 수용 paragraph 추가 — § 4 끝 (line 117 직후) + commit`

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- milestones.md: [`milestones.md`](milestones.md)
- v3.19 진단 origin: [`../v3.19/`](../v3.19/) (RESEARCH 부합도 표 + PROPOSE next_candidates#1 source)
- v3.18 패턴 1차: [`../v3.18/`](../v3.18/) (D1 Option 1 단일 source 패턴 source)
- ARCHITECTURE.md insertion target: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 4 끝 (line 117 직후)
- § 6.2 cross-ref target: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2
