# DESIGN — v6.0

```json
{
  "id": "ai-native-operation-reframe-and-entry-title-guideline",
  "title": "AI Native 운영 reframe + entry title 가이드 정전화",
  "version": "v6.0",
  "decisions": [
    {
      "id": "D1",
      "decision": "'AI Native 운영' 정의 위치 = ARCHITECTURE.md § 7 신규 (관련 문서 → § 8 shift, architecture decisive 흡수)",
      "rationale": "architecture review decisive 1건 흡수 — ARCHITECTURE.md 현 § 1 ~ § 7 구조 (§ 7 = '관련 문서', L226~232, 7 line)에서 § 7 신규 'AI Native 운영' 추가 시 기존 § 7 → § 8 shift. shift 영향 검증 — 'ARCHITECTURE.md § 7' 인용 grep 9 파일 (v6.0 자체 milestone artifact 또는 historical _archive 만), 본 milestone artifact 외 cross-ref drift 0. 신규 § 7 = 정전 정의 (§ 3) ~ era 정책 (§ 6) 흐름 안 자연 (정의 + workflow + 비대칭 + 변경 주의 + AI Native 운영 + 관련 문서). § 3.1 기존 v4.0 정체성 paragraph 와 cross-ref (D9 양방향). § 3.3 5요소 매트릭스 안 Trace + Context 행 sub-mechanism cross-ref 갱신",
      "alternatives_rejected": ["opt_1 (§ 3.1 끝 paragraph 보완) — § 3.1 비대화", "opt_3 (§ 3.3 매트릭스 row) — cross-element 본질 표현 어려움", "§ 5 / § 6 사이 신규 — 변경 주의 다음에 자연 안 함"]
    },
    {
      "id": "D2",
      "decision": "entry title 가이드 위치 = ARCHITECTURE.md § 7 안 sub-section '7.2 Entry title 가이드 (4 원칙)' (RESEARCH opt_4 채택)",
      "rationale": "정의 § 안 = 1 위치 단일 source. Trace mechanism 직접 부합. ROADMAP schema_note 안 짧은 cross-ref 추가 (opt_5 부분 흡수)",
      "alternatives_rejected": ["opt_5 (schema_note 안 전체 hardcode) — CHANGELOG bullet header 가이드와 분리"]
    },
    {
      "id": "D3",
      "decision": "Entry title 4 원칙 hardcode (RESEARCH 명료화 § 안 preliminary 정전화)",
      "rationale": "사용자 답답함 직접 mitigation + LLM 컨텍스트 효율 baseline 부합",
      "principles": [
        "(P1) 한 entry = 한 본질 — bundling 시에도 모자 본질만 title 안",
        "(P2) ≤ 60자 (한국어, 영문 약 120자) — 한 화면 안 시각 흡수 + LLM context efficiency",
        "(P3) Active form + 짧은 동사구 시작 — '재정의 / 도입 / 정전화 / 분리 / 통합 / 흡수 / 갱신' 같은 본질 동사",
        "(P4) Detail 은 summary 필드로 분리 — title 은 '무엇' / summary 는 '왜 + 어떻게 + 결과 + cross-ref'"
      ]
    },
    {
      "id": "D4",
      "decision": "retitle 대상 = 7 entry (ROADMAP 4 + CHANGELOG 3, D10 self-dogfood 통합) — scope contract decisive 흡수",
      "rationale": "scope contract review decisive 1건 흡수 — D10 self-dogfood (v6.0 본 entry title 자체 retitle) 통합 시 ROADMAP `milestones[]` 안 retitle 대상 = 4건 (v5.20 / v5.19 / v5.21 + v6.0 본 milestone) + CHANGELOG.md 안 동치 bullet header 3건 (v5.20/v5.19/v5.21, v6.0 은 신규 entry 작성 시 가이드 정합) = 총 7 entry. RESEARCH opt_7 (6 entry) 정정. scope 적정 (lightweight 1 phase, ~95 line)",
      "alternatives_rejected": ["opt_6 (ROADMAP만 3) — ROADMAP ↔ CHANGELOG drift", "전체 15+ retitle — scope 폭주", "6 entry (v6.0 self 제외) — D10 self-dogfood 위배"]
    },
    {
      "id": "D5",
      "decision": "retitle 원본 정보 보존 — detail 은 각 entry 의 summary 필드 안 흡수 (RESEARCH risk_3 mitigation)",
      "rationale": "title 안 'A + B + C + D' 4 본질 중 모자만 title / 나머지 3 본질은 summary 안 자연 흡수. 본문 손실 0. CHANGELOG bullet header 도 동치 — bullet header 가 짧고, detail bullet 본문은 그대로",
      "verification": "EXECUTE 안 retitle 별 검증 — original 안 모든 본질 단어가 (title + summary) 안 등장 grep 검증"
    },
    {
      "id": "D6",
      "decision": "archival 순서 = retitle 먼저 + archival 후 (RESEARCH risk_7 mitigation)",
      "rationale": "retitle 후 v5.19 entry 가 archival cycle (recent 3 = v6.0 + v5.21 + v5.20 보존) 안 자연 이전 — CHANGELOG 안 v5.19 entry 본문은 이미 retitle 된 형태 + ROADMAP entry 제거. 작업 흐름 자연"
    },
    {
      "id": "D7",
      "decision": "phase 분할 = 1 phase (lightweight 모드)",
      "rationale": "scope ~90 line / 6 파일 = lightweight 정합 (memory `feedback_token_efficiency_priority` + ARCHITECTURE § 6.2 → 폐지 후 lightweight 자연 default). 1 phase = ARCHITECTURE § 7 신규 + 6 retitle + cascade 4 host + CHANGELOG [v6.0] entry + ROADMAP archival cycle 통합"
    },
    {
      "id": "D8",
      "decision": "5 관점 검토 → 3 관점 한정 (architecture / scope contract / 회귀 risk)",
      "rationale": "scope 작음 (6 파일, harness-meta.md L186 기준 = 중간 4 관점). 단 사용자 비개발자 (memory user_non_developer_role) + 산출물 단순화 본질 (self-dogfood) = 3 관점 한정 정당. spec-drift 는 RESEARCH ext_1~ext_3 안 이미 검증 (Keep a Changelog + LLM context efficiency + audit hallucination evidence). 보안 = retitle / 정의 정전화 = side effect 부재"
    },
    {
      "id": "D9",
      "decision": "'AI Native 운영' ↔ v4.0 정체성 관계 narrative — 3 면 매트릭스 = 운영 원칙 / v4.0 정체성 = 책임 정의 (양방향 cross-ref, architecture P1#2 흡수)",
      "rationale": "두 차원 cross-ref — v4.0 (composer + integrator + maintainer) = '본 repo 가 무엇을 만드는가' (책임 / 결과물) / 'AI Native 운영' (컨텍스트 효율 + 자율성 + 다중 AI 협업) = '본 repo 가 어떻게 운영되는가' (원칙 / 운영 방식). 두 차원 직교 — § 7 안 §§ 7.1 (정의 + 3 면 매트릭스) 안 narrative 명시 (forward). architecture P1#2 흡수 = § 3.1 끝 v4.0 정체성 paragraph 안 신규 § 7 cross-ref 추가 (backward). 양방향 cross-ref 정합"
    },
    {
      "id": "D10",
      "decision": "Self-dogfood 통합 — v6.0 ROADMAP entry title + milestone artifact 4건 (INTENT/RESEARCH/DESIGN/milestones.md) 안 title 동기 retitle (architecture P1#3 흡수)",
      "rationale": "본 milestone 본질 = entry title 가이드 정전화 — 본 milestone 자체 entry title 이 가이드 위배 시 narrative 모순. 현 v6.0 entry title (84자) + INTENT.title / RESEARCH.title / DESIGN.title / milestones.md title 모두 동치 84자 = 5 위치 self-dogfood 위반 evidence. retitle 후보: 'AI Native 운영 reframe + entry title 가이드 정전화' (~32자, 4 원칙 정합)",
      "verification": "EXECUTE 안 5 위치 동기 갱신 — ROADMAP v6.0 entry title + INTENT/RESEARCH/DESIGN/milestones.md 안 title field 동기. 가이드 4 원칙 정합 검증"
    },
    {
      "id": "D11",
      "decision": "cascade host 4 → 6 (AGENTS.md + README.md 추가, architecture P1#1 흡수)",
      "rationale": "architecture P1#1 흡수 — AGENTS.md L3 (영문 정체성 paragraph 'project harness composer + Claude Code ecosystem integrator + agent fleet maintainer' 동치) + README.md L3 (한국어 동치 paragraph) 안 'AI Native 운영' cross-ref 추가. 현 cascade 4 (CLAUDE.md root + projects/meta/CLAUDE.md + projects/meta/ROADMAP.md schema_note + CHANGELOG.md) + AGENTS.md + README.md = 총 6 host. 영문 onboarding (AGENTS.md) + 한국어 onboarding (README.md) 안 정체성 cross-ref 정합"
    },
    {
      "id": "D12",
      "decision": "Archival 단어 명료화 (scope contract P2#4 흡수) — 'archival' = ROADMAP entry 제거만, CHANGELOG entry 이미 보유 = 보존",
      "rationale": "scope contract P2#4 흡수 — v5.19 entry archival cycle 안 CHANGELOG.md L34 이미 [v5.19] entry 보유 (v5.21 archival 시 이미 작성). 본 milestone archival 작업 = ROADMAP `milestones[]` 안 v5.19 entry 제거 만 (CHANGELOG entry 는 이미 보유, retitle 후 본문 동기). 'CHANGELOG 이전' 단어 = retitle 후 본문 정합 의미 (실 entry 이전 작업 부재). narrative 명료화 — PROPOSE 단계 안 ROADMAP entry 제거 단어 사용"
    }
  ],
  "approach": "ARCHITECTURE.md 안 § 7 'AI Native 운영' 신규 § 정전화 (§§ 7.1 정의 + 3 면 매트릭스 + v4.0 cross-ref + §§ 7.2 Entry title 가이드 4 원칙) + 기존 § 7 (관련 문서) → § 8 shift → ROADMAP milestones[] 안 4 entry retitle (v5.20 / v5.19 / v5.21 + v6.0 self-dogfood) + milestone artifact 4건 (INTENT/RESEARCH/DESIGN/milestones.md) 안 title field 동기 갱신 → CHANGELOG.md 안 3 bullet header 동기 retitle (v5.20/v5.19/v5.21) + [v6.0] entry 신규 → ROADMAP archival (v5.19 entry 제거, CHANGELOG entry 보존) → cascade 6 host narrative 동기 갱신 (CLAUDE.md / projects/meta/CLAUDE.md / projects/meta/ROADMAP.md schema_note + 신규 AGENTS.md / README.md / § 3.1 backward cross-ref) → § 3.1 끝 paragraph 안 신규 § 7 backward cross-ref 추가. 1 phase 1 commit (lightweight).",
  "phases": [
    {
      "n": 1,
      "title": "ARCHITECTURE § 7 신규 + 7 retitle + cascade 6 host + § 3.1 backward + § 8 shift",
      "scope": "(a) projects/meta/ARCHITECTURE.md 안 § 7 'AI Native 운영' 신규 (§§ 7.1 정의 + 3 면 매트릭스 + v4.0 cross-ref + §§ 7.2 Entry title 가이드 4 원칙 hardcode) + 기존 § 7 (관련 문서) → § 8 shift. (b) projects/meta/ARCHITECTURE.md § 3.1 끝 paragraph 안 신규 § 7 backward cross-ref 추가 (D9). (c) projects/meta/ROADMAP.md 안 milestones[] entry retitle 4 (v5.20 / v5.19 / v5.21 + v6.0 self-dogfood, D10) + schema_note 안 entry title 가이드 cross-ref. (d) 본 milestone artifact 4건 안 title field 동기 갱신 (INTENT.md / RESEARCH.md / DESIGN.md / milestones.md, D10 self-dogfood 통합). (e) CHANGELOG.md 안 [v5.20] / [v5.19] / [v5.21] bullet header 동기 retitle + [v6.0] entry 신규. (f) ROADMAP archival (v5.19 entry 제거, CHANGELOG entry 이미 보유 보존, D12). (g) cascade host 6 위치 narrative — root CLAUDE.md / projects/meta/CLAUDE.md / AGENTS.md / README.md / projects/meta/ROADMAP.md schema_note / CHANGELOG.md cross-ref (D11).",
      "affected_files": [
        "projects/meta/ARCHITECTURE.md",
        "projects/meta/ROADMAP.md",
        "CHANGELOG.md",
        "CLAUDE.md",
        "projects/meta/CLAUDE.md",
        "AGENTS.md",
        "README.md",
        "projects/meta/milestones/v6.0/INTENT.md",
        "projects/meta/milestones/v6.0/RESEARCH.md",
        "projects/meta/milestones/v6.0/DESIGN.md",
        "projects/meta/milestones/v6.0/milestones.md",
        "projects/meta/milestones/v6.0/execute/phase-1.md"
      ],
      "phase_allowed_tools": ["Write", "Edit", "Read", "Grep"],
      "rationale": "1 phase = lightweight 모드. 본 milestone 본질 (정의 + 가이드 + 첫 변경) 통합 1 commit. EXECUTE Edit 위주 (v3.21 narrative 정전화 3 단계 패턴 cycle 25 도그푸드, 본 milestone = (a) DESIGN 1차 = 본 문서 + (b) EXECUTE Edit + (c) VERIFY grep). scope 정량 ~95 line / 12 파일 (artifact 4 + cascade 6 + execute/phase-1.md + ROADMAP + ARCHITECTURE 통합).",
      "risks": ["retitle 시 detail 손실 (D5 mitigation)", "cascade 6 host narrative drift (VERIFY grep mitigation)", "§ 7 → § 8 shift 안 cross-ref drift (grep 검증 결과 9 파일 = 본 milestone artifact + historical _archive 만, 외부 cross-ref 0)"]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "RESEARCH.risk_1 self-loop (workflow self-improvement)",
      "mitigation": "본 milestone 본질 = Trace 메커니즘 재정의 (entry title 형식) — workflow 단어/책임 변경 부재. v5.21 동질 (Trace 정전화) + § 6.2 폐지 narrative 정합 (memory feedback_section_6_2_abolished)"
    },
    {
      "risk": "RESEARCH.risk_2 narrative drift",
      "mitigation": "cascade 4 host 작음 (10 host 대비). v3.21 패턴 (DESIGN 1차 + EXECUTE Edit + VERIFY grep) 적용. VERIFY 안 'AI Native' / 'Entry title' keyword grep 검증"
    },
    {
      "risk": "RESEARCH.risk_3 retitle 정보 손실",
      "mitigation": "D5 — detail 은 summary 필드 안 흡수, EXECUTE 안 retitle 별 검증 (original 본질 단어 grep 매핑)"
    },
    {
      "risk": "RESEARCH.risk_4 schema smoke 부재",
      "mitigation": "본 milestone scope 외 (oos_2 정합). 향후 v6.1+ 안 smoke 추가 가능 narrative (PROPOSE.next_candidates 안 cross-ref)"
    },
    {
      "risk": "RESEARCH.risk_5 사용자 부담 (비개발자)",
      "mitigation": "D8 3 관점 검토 + 스무고개 방식 매 round 게이트. memory user_non_developer_role + feedback_iterative_dialog 직접 적용"
    },
    {
      "risk": "RESEARCH.risk_6 'AI Native' ↔ v4.0 관계 미명료",
      "mitigation": "D9 두 차원 직교 narrative — § 7.1 안 명시"
    },
    {
      "risk": "RESEARCH.risk_7 archival overlap",
      "mitigation": "D6 retitle 먼저 → archival 후 순서"
    }
  ],
  "perspectives_review_summary": {
    "관점_1_architecture (Plan)": {
      "verdict": "pass-with-comments",
      "decisive": 1,
      "p1": 3,
      "p2": 5,
      "absorption_status": "decisive (§ 7 collision) → D1 정정 (§ 7 신규 + 기존 § 7 → § 8 shift). P1 흡수: P1#1 (AGENTS/README cross-ref) → D11 / P1#2 (§ 3.1 backward cross-ref) → D9 / P1#3 (artifact title 동기) → D10. P2 5건 = (schema_note cross-ref / § 3.3 매트릭스 row / title self-evaluation / archival 단어 / phase_allowed_tools schema) — D2/D5/D12 부분 흡수, 나머지 후속 milestone candidate"
    },
    "관점_2_scope_contract (Explore)": {
      "verdict": "pass-with-comments",
      "decisive": 1,
      "p1": 5,
      "p2": 5,
      "absorption_status": "decisive (D10 self-dogfood retitle 수 6→7) → D4 정정 (retitle 7 entry = 4 ROADMAP + 3 CHANGELOG). P1 5건 = (cascade 위치 명시 / archival 순서 / 매트릭스 형식 / D8 schema smoke / v4.0 cross-ref 위치) — EXECUTE 안 phase-1.md 자연 흡수. sc_coverage = sc_1~sc_6 모두 covered (sc_3 partial → D10 통합 후 covered)"
    },
    "관점_3_regression_risk (Explore)": {
      "verdict": "pass-with-comments",
      "decisive": 0,
      "p1": 5,
      "p2": 5,
      "smoke_inventory_count": 7,
      "absorption_status": "decisive 0 (3건 모두 none/정합). P1 5건 모두 low/none. smoke_inventory 7 active smoke = 모두 회귀 risk none ~ medium (smoke-claude-md-drift = cascade narrative drift, VERIFY grep 의무로 mitigation). pre-commit 14 hook 정확 = active 7 smoke + 5 baseline + shellcheck + markdownlint"
    },
    "skipped_관점": "spec-drift (RESEARCH ext_1~ext_3 안 이미 검증) / 보안 (retitle / 정의 정전화 = side effect 부재)",
    "summary": "3 관점 모두 pass-with-comments. decisive 2건 (architecture § 7 collision + scope contract retitle 수) 모두 D1/D4 정정 안 흡수. P1 13건 모두 D9~D12 안 흡수 또는 EXECUTE 안 자연 흡수. 회귀 risk none/low — pre-commit 14 hook PASS 가능"
  }
}
```

## v6.0 retitle 후보 (preliminary)

| Entry | 현행 (자 수) | Retitle 후보 (자 수) |
|---|---|---|
| v5.20 | "audit-team 외부 호출 cycle 7 + ARCHITECTURE § 4 끝 7 paragraph 매트릭스화 + agent namespace prefix cascade — stability 3 cycle 연속 (5+6+7) + v5.19 PROPOSE#4+#8 동시 흡수 + Plugin spec v5.0+ namespace 정합" (175) | "audit cycle 7 + § 4 매트릭스화 + namespace cascade" (45) |
| v5.19 | "audit-team 외부 호출 cycle 6 — upbit 대상 + v5.17 cycle 5 diff + v5.18 Input Verification + 검증 method 분리 효과 검증 + ecosystem integrator vector 6건 누적 + stability cycle 첫 완성" (158) | "audit cycle 6 + Input Verification 효과 검증" (32) |
| v5.21 | "ROADMAP forward-looking 재정의 (recent 3건 + next_candidates only) + CHANGELOG.md v5.7~v5.20 14 entry backfill + completed 41건 archival + cascade 7 host narrative" (139) | "ROADMAP forward-looking 재정의 + CHANGELOG archival" (35) |
| v6.0 (self) | "9-stage 자동 전환 + per-stage 최소 권한 원칙 (PoLP) + 사전적 정의 1:1 매핑 강화" (84, 첫 원안) | "AI Native 운영 reframe + entry title 가이드 정전화" (32) |

본 retitle 후보는 EXECUTE 안 최종 확정 (D5 verification 적용 — 모든 본질 단어가 summary 안 흡수 검증).

## 'AI Native 운영' 정의 preliminary (DESIGN 안 정전화 본문)

> 본 repo (harness-meta) 운영의 본질은 **AI Native 운영** — 본 repo 의 산출물 (ROADMAP / CHANGELOG / milestone 산출물 / cascade narrative) 이 AI (Claude / 다른 LLM agent) 에 의해 가장 자주 흡수되고 활용되며, AI 의 컨텍스트 효율 + 자율성 + 다중 AI 협업 친화도가 운영 품질의 1차 measure 다. v4.0 정체성 (composer + integrator + maintainer) 이 '본 repo 가 무엇을 만드는가' (책임 / 결과물) 라면, AI Native 운영은 '본 repo 가 어떻게 운영되는가' (원칙 / 운영 방식) — 두 차원 직교 보완.
>
> **AI Native 운영 3 면 매트릭스**:
>
> 1. **컨텍스트 효율** — AI 가 한 자료 (예: ROADMAP entry list) 를 흡수할 때 토큰 비용 + 본질 파악 신속. 한 entry = 한 본질 / detail 은 별 필드 / 짧은 title.
> 2. **자율성** — AI 가 사용자 명령 모호해도 의도 추출 + milestone 발의 + 진행 + 회고 가능. 사용자 명시 결정 게이트 보존 + AI 가 주도 결정 책임 흡수.
> 3. **다중 AI 협업** — audit-team / external agent / context7 등 여러 AI 사이 컨텍스트 공유 + 책임 분리 명료 + fact 검증 자동.
>
> 본 매트릭스는 후속 milestone 발의 평가 기준 — 신규 milestone 이 3 면 중 어느 면을 향상시키는가 명시.

## Entry title 가이드 preliminary (§§ 7.2 hardcode 본문)

> ROADMAP `milestones[]` entry / CHANGELOG bullet header / 기타 entry-form artifact 안 title 작성 시 다음 4 원칙 의무:
>
> 1. **한 entry = 한 본질** — bundling 시 (v3.0+ bundling era) 모자 본질만 title 안. 'A + B + C + D' 합치기 형식 금지. 나머지 본질은 summary 필드 안.
> 2. **≤ 60자 (한국어, 영문 약 120자)** — 한 화면 안 시각 흡수 + LLM context efficiency baseline. 60자 위 = 분류 정확도 감소 + grep keyword false-positive 증가 (RESEARCH ext_2 evidence).
> 3. **Active form + 짧은 동사구 시작** — '재정의 / 도입 / 정전화 / 분리 / 통합 / 흡수 / 갱신' 같은 본질 동사. 명사구 시작 회피.
> 4. **Detail 은 summary 필드로 분리** — title 은 '무엇' / summary 는 '왜 + 어떻게 + 결과 + cross-ref'.

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- ARCHITECTURE.md § 7 정전화 위치 (phase 1 target): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)
- milestones.md spec: [`milestones.md`](milestones.md) (phase 분할 D7 정합)
