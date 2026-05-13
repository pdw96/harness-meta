# RESEARCH — v3.20_drift-narrative-canonicalization

```json
{
  "id": "v3.20_drift-narrative-canonicalization",
  "external": [
    {
      "source": "v3.19_word-fidelity-audit-v2 RESEARCH",
      "topic": "9-stage 단어-책임 부합도 정량 측정",
      "findings": "9 stage 부합도 추정 (Merriam-Webster 정의 vs 실 운용 책임) — OPEN 90% / INTENT 80% / RESEARCH 85% / DESIGN 80% / APPROVE 100% / EXECUTE 85% / VERIFY 95% / REPORT 90% / PROPOSE 70%. 평균 (90+80+85+80+100+85+95+90+70) / 9 ≈ 86.1%. 최고: APPROVE 100% (단일 책임 완벽). 최저: PROPOSE 70% (register 책임 침범 가장 큼)",
      "cross_ref": "projects/meta/milestones/v3.19/RESEARCH.md L106~131"
    },
    {
      "source": "v3.19 RESEARCH.options Option D",
      "topic": "drift 수용 narrative 정전화 옵션 정의",
      "findings": "'ARCHITECTURE.md 안 word-fidelity drift 수용 narrative paragraph 추가 — drift 의 의도성 / pragmatic 절충 정전화. 변경 없음 (산출물만 정전화). v3.18 패턴 정합 (단일 source narrative).' Pros: v3.18 패턴 정합 + 외부 visible artifact 안 자기 진단 결과 영구 정전화 + lightweight 정합. Cons: 본 milestone (v3.19) 진단만 → 별 milestone 분리 자연.",
      "cross_ref": "projects/meta/milestones/v3.19/RESEARCH.md L184~196"
    },
    {
      "source": "v3.19 PROPOSE.next_candidates#1",
      "topic": "본 milestone trigger source",
      "findings": "id: v3.X_drift-narrative-canonicalization, trigger: C_improvement, trigger_type: deferred, trigger_condition: '사용자 명시 발의 (A_user) — v3.19 진단 결과 narrative 정전화 효과 평가 후 발의. § 6.2 default 동결 정합 (narrative 변경만이지만 워크플로우 self-improvement 본질).'",
      "cross_ref": "projects/meta/milestones/v3.19/PROPOSE.md L6~16"
    },
    {
      "source": "v3.18_option-a-natural-adaptation-narrative",
      "topic": "narrative 정전화 패턴 1차 source",
      "findings": "v3.17 진단 결과 → ARCHITECTURE § 6.1 안 1-phase milestone 정합 paragraph 1건 신규 (line 168). 단일 source narrative 정합 (D1 Option 1 채택), lightweight 5번째 적용 (5 관점 subagent 생략), 1-phase 1+1 commit 도그푸드.",
      "cross_ref": "projects/meta/ARCHITECTURE.md line 168, projects/meta/milestones/v3.18/"
    }
  ],
  "codebase": {
    "affected_files": [
      "projects/meta/ARCHITECTURE.md (drift narrative paragraph 1건 추가 — Stage D 위치 확정)",
      "projects/meta/milestones/v3.20/INTENT.md (작성 완료)",
      "projects/meta/milestones/v3.20/RESEARCH.md (본 파일)",
      "projects/meta/milestones/v3.20/DESIGN.md (Stage D)",
      "projects/meta/milestones/v3.20/APPROVE.md (Stage E)",
      "projects/meta/milestones/v3.20/execute/phase-1.md (Stage F)",
      "projects/meta/milestones/v3.20/VERIFY.md (Stage G)",
      "projects/meta/milestones/v3.20/REPORT.md (Stage H)",
      "projects/meta/milestones/v3.20/PROPOSE.md (Stage I)",
      "projects/meta/milestones/v3.20/milestones.md (Stage D sub_milestones 1:1 동기)",
      "projects/meta/ROADMAP.md (v3.20 entry in_progress → completed 갱신, Stage I)"
    ],
    "untouched_files_explicit": [
      "claude/commands/harness-meta.md (워크플로우 본문) — out_of_scope #1 정합, 변경 zero",
      "projects/meta/ARCHITECTURE.md § 6.2 동결 정책 본문 — out_of_scope #3 정합",
      "projects/meta/ARCHITECTURE.md § 4 9-stage 표 본문 (Stage 행 / 단어 책임 정의) — out_of_scope #7 정합, drift 자체 수정 아닌 수용",
      "tests/ smoke 모두 — out_of_scope #4 정합",
      "CHANGELOG.md — Stage I PROPOSE 시점 검토 candidate (별 milestone 후보, 사실 진술)",
      "CLAUDE.md (root) / claude/CLAUDE.md / tests/CLAUDE.md / projects/meta/CLAUDE.md — cross-ref 단일 source 정합 (v1.4_cross-ref-propagation 정책)"
    ],
    "current_state": {
      "architecture_md_sections": "§ 1 디렉토리 / § 2 모듈 / § 3 정의 (3.1~3.6) / § 4 9-stage workflow + bundling / § 4.1 Bundling / § 5 비대칭 의도 / § 6 변경 시 주의 + era 정책 (6.1 era / 6.2 lightweight) / § 7 관련 문서",
      "section_4_layout": "line 97 § 4 헤더 / line 99~101 9-stage 흐름 다이어그램 / line 103 단어 책임 narrative / line 105~115 9 stage 표 / line 117 B/C/D 부산물 PROPOSE 흡수 책임 paragraph (v3.10 정전화) / line 119 § 4.1 헤더",
      "drift_narrative_absent": "ARCHITECTURE.md 안 word-fidelity drift 수용 narrative 부재 — v3.19 진단 결과 (86.1% 평균 / 100% APPROVE / 70% PROPOSE) 가 milestone 산출물 안에만 보존, 외부 visible 단일 source (ARCHITECTURE.md) 안 cross-ref 부재",
      "v3.18_narrative_position_precedent": "1-phase milestone 정합 paragraph = § 4.1 Bundling 안 line 168 (운용 paragraph 직후) — narrative 1차 source 위치 선례"
    },
    "target_state": {
      "narrative_canonical_host": "ARCHITECTURE.md 안 drift 수용 paragraph 1건 (Stage D 위치 확정)",
      "expected_loc_delta": "+5~10 line (1 paragraph)",
      "workflow_body_change_count": 0,
      "smoke_change_count": 0
    }
  },
  "options": [
    {
      "option_id": "1",
      "title": "§ 4 끝 (B/C/D 부산물 흡수 paragraph 직후, line 117 → 118 사이)",
      "approach": "§ 4 9-stage 단어 책임 정의 (line 105~115 표 + line 117 B/C/D 부산물 흡수 paragraph) 직후 drift 수용 paragraph 1건 추가 — § 4.1 Bundling 헤더 직전.",
      "pros": [
        "단어 = 단일 책임 1:1 매핑 narrative (line 103) + 9 stage 표 (line 105~115) + B/C/D 부산물 흡수 책임 (line 117) → drift 수용 (신규) 연결 자연 — 'ideal 100% 부합 vs 현 86.1% 평균 drift 수용' 4 단계 narrative 순서",
        "§ 4.1 Bundling 헤더 직전 위치 = era 분기 narrative 진입 직전 = word-fidelity narrative 결속 자연",
        "v3.18 narrative 정전화 패턴 약한 정합 (§ 4.1 안이 아닌 § 4 안 ↔ v3.18 § 4.1 안)"
      ],
      "cons": [
        "§ 4 본문 (9-stage 단어 책임 정의) 안 drift 수용 narrative 추가 = '단어 책임 정의 + drift 수용' 같은 § 안 공존 — 약한 책임 혼재 risk (단어 책임 정의 본문 vs era 운용 narrative 분리 부재)",
        "§ 4.1 Bundling header 가 line 119 → line 124 부근 push down (1 paragraph 만큼)"
      ]
    },
    {
      "option_id": "2",
      "title": "§ 4.1 Bundling 안 1-phase milestone 정합 paragraph 직후 (line 168 → 169 사이)",
      "approach": "§ 4.1 Bundling 안 line 168 1-phase milestone 정합 paragraph 직후 drift 수용 paragraph 1건 추가 — '자기참조 부합' paragraph 직전.",
      "pros": [
        "v3.18 narrative 위치 (1-phase paragraph) 와 인접 = '진단 결과 정전화 narrative' 묶음 자연",
        "§ 4.1 Bundling = era 운용 narrative 영역 → drift 수용 (era 운용 결과 narrative) 와 책임 동치"
      ],
      "cons": [
        "drift narrative 본질 = 단어 책임 정의 영역 (§ 4 본문) ↔ Bundling 영역 (§ 4.1) 책임 부적합",
        "§ 4.1 안 paragraph 수 증가 (현재 6 paragraph + 표 → 7 paragraph) — § 4.1 비대화"
      ]
    },
    {
      "option_id": "3",
      "title": "§ 3.3 5요소 매트릭스 'Workflow' 행 (c) 분류 안 + 별 sub-section",
      "approach": "§ 3.3 매트릭스 Workflow 행 (c) 분류 = 정전 narrative 안 부합도 정전화 + § 3.7 신규 sub-section 'Workflow word-fidelity 수용' 추가.",
      "pros": [
        "§ 3 정전 정의 영역 — 단어 책임 부합도 측정 자체가 워크플로우 정전화 차원",
        "5요소 매트릭스 안 정전 분류 (c) 보강 narrative 정합"
      ],
      "cons": [
        "§ 3 단일 source 책임 = working definition + 5요소 매트릭스 — drift narrative 가 정의 자체 변경 (drift 수용 = 단어 책임 1:1 매핑 정의 미달) → § 3 책임 침범",
        "§ 3.5 단일 source 정합 narrative (line 87) 위반 risk — § 3 본문 중복 또는 신규 sub-section 추가는 cross-ref 정책 위반",
        "v3.18 narrative 위치 (§ 4.1) 와 분리 — 진단 결과 정전화 패턴 분산"
      ]
    },
    {
      "option_id": "4",
      "title": "§ 6.2 Lightweight 모드 정책 안 보강",
      "approach": "§ 6.2 lightweight 모드 정책 안 'workflow self-improvement 동결 정책' 직후 drift 수용 narrative 추가 — '단어 책임 100% 부합 추구 부재' 정전화.",
      "pros": [
        "§ 6.2 = workflow self-improvement 동결 정책 host — drift 수용 narrative 와 본질 정합 (100% 부합 추구 부재 = 동결 정책 rationale 보강)"
      ],
      "cons": [
        "§ 6.2 = 운용 정책 영역 (trigger 조건 + 적용 시 차이 + 선례) ↔ drift narrative = 단어 책임 영역 (§ 4) 부적합",
        "drift narrative 위치가 § 6 era 정책 영역 = era 분기 narrative 와 책임 혼재"
      ]
    }
  ],
  "risks_identified": [
    {
      "risk_id": "R1",
      "risk": "narrative 위치 선택 (4 옵션) → DESIGN 단계 결정 narrowing risk (RESEARCH options 부산물 정책 v3.10 침범 가능성)",
      "severity": "낮음",
      "mitigation": "options pros/cons 는 raw 분석만 — DESIGN.decisions 안 채택 옵션 명시 + 비채택 alternatives_rejected 안 옵션 거명 (v3.10 부산물 정책 정합)"
    },
    {
      "risk_id": "R2",
      "risk": "drift 수용 narrative 정확 문구 (drift 의도성 / pragmatic 절충 / 정량 cross-ref 3건 cohesive) DESIGN 단계 확정 risk",
      "severity": "낮음",
      "mitigation": "INTENT.success_criteria 2/3 안 narrative 정확 문구 + 정량 cross-ref 3건 + drift 의도성 narrative 검증 가능 — DESIGN 안 정확 문구 확정 + VERIFY criteria_check 1:1 매핑"
    },
    {
      "risk_id": "R3",
      "risk": "lightweight 모드 5 관점 subagent 생략 → 위치 선택 (§ 4 vs § 4.1 vs § 3 vs § 6.2) architecture 검토 누락 risk",
      "severity": "낮음",
      "mitigation": "v3.6/v3.10/v3.13/v3.14/v3.17/v3.18/v3.19 누적 7/19 검증된 lightweight 패턴 정합 — narrative 정전화 + ≤5 파일 + 충돌 부재 예상. self_reference_policy: avoid 표지 명시"
    },
    {
      "risk_id": "R4",
      "risk": "drift 수용 narrative 가 옵션 B/C (실 변경) trigger 로 해석 risk",
      "severity": "낮음",
      "mitigation": "DESIGN.decisions 안 옵션 B/C 채택 아님 명시 + § 6.2 동결 trigger 미충족 narrative + Stage I PROPOSE 안 옵션 B/C 후속 candidate 거명 (§ 6.2 동결 정합)"
    },
    {
      "risk_id": "R5",
      "risk": "본 milestone 자체가 lightweight 모드 누적 8/20 = 40% — '자기참조 모순 표지' 의도 vs '워크플로우 진단 동결 위반' 해석 충돌 risk",
      "severity": "낮음",
      "mitigation": "v3.17/v3.18/v3.19 narrative (lightweight 누적 동치화) 정합 — 진단 결과 narrative 정전화만 + 사용자 명시 발의 (A_user) 충족 = § 6.2 정합. 본 milestone 은 narrative 정전화 본질 (Option D), 실 워크플로우 변경 부재"
    },
    {
      "risk_id": "R6",
      "risk": "ARCHITECTURE.md 1 paragraph 추가 후 다른 host (CLAUDE.md / 모듈 가이드) cross-ref 누락 risk",
      "severity": "낮음",
      "mitigation": "v1.4_cross-ref-propagation 정책 정합 — ARCHITECTURE.md 단일 source 정합 유지 (§ 3.5 narrative), 다른 host 는 cross-ref 만 (정의 본문 중복 금지). 본 milestone 은 ARCHITECTURE.md 단일 source 추가만, cross-ref 추가는 v3.18 D1 Option 1 채택 패턴 정합 (v3.20 도 단일 source narrative 전략)"
    }
  ]
}
```

## narrative

본 RESEARCH 는 **lightweight 모드 정합** — external 4건 (v3.19 진단 결과 source 3건 + v3.18 패턴 1차 source) + codebase 정량 (ARCHITECTURE.md § 4 layout + drift narrative 부재) + options 4건 raw 분석 (§ 4 끝 vs § 4.1 안 vs § 3.3 vs § 6.2) + risks 6건.

`options` pros/cons 는 raw 분석만 (v3.10 부산물 정책 정합) — DESIGN.decisions 안 최종 채택 + alternatives_rejected 안 비채택 옵션 거명.

`untouched_files_explicit` 5건 + `risks_identified` 6건 모두 사실 진술 — 후속 milestone 명명 표현 부재 (v3.10 부산물 정책 정합).

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- milestones.md: [`milestones.md`](milestones.md)
- v3.19 진단 origin: [`../v3.19/`](../v3.19/) (RESEARCH 부합도 표 + PROPOSE next_candidates#1 source)
- v3.18 정전화 패턴 1차: [`../v3.18/`](../v3.18/) (단일 source narrative 정합 패턴)
- bundling 정책: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- workflow 자기참조 동결: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2
