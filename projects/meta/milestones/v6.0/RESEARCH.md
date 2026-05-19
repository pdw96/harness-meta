# RESEARCH — v6.0

```json
{
  "id": "ai-native-operation-reframe-and-entry-title-guideline",
  "title": "AI Native 운영 reframe + entry title 가이드 정전화",
  "version": "v6.0",
  "external": [
    {
      "id": "ext_1",
      "source": "Keep a Changelog v1.1.0 (https://keepachangelog.com/en/1.1.0/) — 본 repo CHANGELOG.md 안 명시 정합",
      "topic": "entry title / heading 형식 spec",
      "findings": "Keep a Changelog spec 안 entry heading 형식 = `## [version] - YYYY-MM-DD`. 본 spec 은 'version + date' 만 규정 — title 별 문구는 부재. 본 repo CHANGELOG.md 안 추가 narrative 는 ### Added/Changed/Fixed 아래 bullet 안 굵게 처리 (예: **audit-team 외부 호출 cycle 7 + § 4 끝 7 paragraph 매트릭스화 + ...**). bullet header 도 동치 long-text 패턴. ROADMAP milestones[] entry title 는 본 spec 적용 외 — repo 자체 schema (id/version/title/status/summary/...)",
      "drift": "Keep a Changelog spec 자체는 본 milestone 안 변경 부재. 단 본 repo 안 bullet header narrative + ROADMAP entry title narrative 가 본 milestone 정전화 대상"
    },
    {
      "id": "ext_2",
      "source": "AI / LLM 컨텍스트 효율 일반 baseline (LLM token economy)",
      "topic": "AI 가 자료 흡수 시 effective context limit + 본질 파악 cost",
      "findings": "LLM (Claude Sonnet 4.6 1M context) 안 한 자료 = 한 chunk 일 때 (예: ROADMAP `milestones[]` array) — list 안 각 entry 의 title 만 먼저 scan 후 본질 결정 패턴. title 이 길고 multi-purpose 시 (a) 분류 정확도 감소 (entry 가 N 본질 = N 카테고리 fit, 정확 1 카테고리 매칭 어려움), (b) grep / glob 시 keyword 매칭 비용 증가 (title 안 keyword 다수 = false-positive 다수), (c) 사용자 명령 ('지난 v5.20 뭐였지?') 응답 시 title 흡수 후 summary 까지 읽어야 본질 파악 (RAM 안 entry 분류 불가). 짧은 title (≤60자, 단일 본질) = 위 3 비용 동시 감소",
      "drift": "본 baseline 은 LLM 일반 원칙 — 본 repo 안 entry title 175자 / 158자 / 139자 (v5.20 / v5.19 / v5.21) 모두 60자 baseline 위. drift 직접 evidence"
    },
    {
      "id": "ext_3",
      "source": "본 repo memory feedback_subagent_fact_hallucination_correction (cycle 9+ 누적)",
      "topic": "긴 title 안 audit chain agent hallucination evidence",
      "findings": "v5.10 ~ v5.18 안 audit chain 9 cycle 누적 hallucination evidence — agent 가 ROADMAP entry 본문 (title + summary) 흡수 시 multi-purpose title 안 일부 본질 만 픽업 + 나머지 누락 / 잘못 매핑. v5.10 component-proposer 12 항목 표 hallucination (cycle 1) + v5.11 scanner `claude_md_in_repo: false` hallucination (cycle 2) + v5.12 mapper bundled skill 분류 hallucination (cycle 3) — 모두 일부분 'A + B + C + D' title 안 본질 파악 실패와 연결",
      "drift": "본 milestone scope = 본 evidence 안 직접 후속 mitigation — entry title 단순화 = agent hallucination root cause 일부 자연 감소"
    }
  ],
  "codebase": {
    "affected_files": [
      "projects/meta/ARCHITECTURE.md ('AI Native 운영' 정의 신규 § + entry title 가이드 sub-section — DESIGN 안 정확 위치 결정)",
      "projects/meta/ROADMAP.md (milestones[] 안 가장 긴 3~5 entry retitle, summary 안 detail 흡수)",
      "CHANGELOG.md ([v5.20] / [v5.19] / [v5.21] bullet header 동치 retitle + [v6.0] entry 신규)",
      "CLAUDE.md (root, 'AI Native 운영' cross-ref 추가)",
      "projects/meta/CLAUDE.md (모듈 가이드, cross-ref)",
      "claude/commands/harness-meta.md (간단 cross-ref 가능, 본 milestone 안 우선순위 낮음 — DESIGN 안 결정)",
      "projects/meta/milestones/v6.0/execute/phase-1.md"
    ],
    "untouched_files_explicit": [
      "claude/commands/harness-{stage}.md (v6.0 첫 원안 mechanism, 본 milestone 폐기 oos_1)",
      "agents/ (mechanism (2) 안 stage agent, 본 milestone 폐기 oos_1)",
      "claude/hooks/* (자동 전환 mechanism, 본 milestone 폐기 oos_1)",
      "tests/smoke-* (회귀 0 검증만, schema 갱신 부재)",
      "agents/project-harness-audit-team/* (audit-team 분리, 본 milestone scope 외)",
      "skills/* (skill 5건, 본 milestone scope 외)",
      "projects/upbit/* (외부 프로젝트, 본 milestone scope 외)"
    ],
    "current_state": "ROADMAP `milestones[]` 안 가장 긴 3 active title — v5.20 (175자), v5.19 (158자), v5.21 (139자), v6.0 본 (84자, 본 milestone 본인). 모두 'A + B + C + D' 합치기 형식. CHANGELOG.md 안 동치 bullet header (각 [v5.x] 안 굵게 처리) 도 동치 패턴. ARCHITECTURE.md 안 'AI Native 운영' 정의 부재 — v4.0 정체성 (composer + integrator + maintainer) 만 § 3.1 끝 paragraph. entry title 가이드 부재. 사용자 답답함 = 'ROADMAP/CHANGELOG entry title 이 가장 자주 눈에 들어옴, 이름만 읽어도 피로'.",
    "target_state": "ARCHITECTURE.md 안 'AI Native 운영' 정의 신규 § (1 paragraph + 3 면 매트릭스). entry title 가이드 정전화 (4 원칙 hardcode). 가장 긴 3 active entry retitle (v5.20 / v5.19 / v5.21) — ≤ 60자 + 한 본질 + active form. detail 은 각 entry 의 summary 필드 안 흡수. CHANGELOG.md 안 [v5.20] / [v5.19] / [v5.21] bullet header 동기 retitle. CLAUDE.md / projects/meta/CLAUDE.md 안 cross-ref. CHANGELOG [v6.0] entry 신규. v5.19 entry archival cycle (recent 3 = v6.0 + v5.21 + v5.20 보존, v5.19 → CHANGELOG 이전, DESIGN 안 결정 — 본 milestone retitle 대상 v5.19 가 archival 대상이 될 수도)."
  },
  "options": [
    {
      "id": "opt_1",
      "name": "'AI Native 운영' 정의 위치 = ARCHITECTURE.md § 3.1 끝 paragraph 보완 (v4.0 정체성 옆)",
      "description": "현 § 3.1 끝 'harness-meta repo 정체성 (composer + integrator + maintainer, v4.0 도입)' paragraph 직후 신규 paragraph append — 'AI Native 운영' 정의 + 3 면 매트릭스",
      "pros": ["v4.0 정체성 narrative 와 직접 cross-ref 자연", "§ 3.1 가 정체성 단일 source 정합 (§ 3.5 정합)"],
      "cons": ["§ 3.1 비대화 (현재 ~10 line, 추가 시 ~30 line)", "3 면 매트릭스 = 표 또는 list — § 3.1 narrative 흐름 단절"]
    },
    {
      "id": "opt_2",
      "name": "'AI Native 운영' 정의 위치 = ARCHITECTURE.md § 7 신규 (§ 4 / § 6 와 별)",
      "description": "ARCHITECTURE.md 끝 § 7 'AI Native 운영' 신규 — 1 paragraph + 3 면 매트릭스 + entry title 가이드 sub-section",
      "pros": ["단일 § = 독립 narrative, AI 컨텍스트 효율 향상 (한 § 흡수 시 본질 1건)", "entry title 가이드도 본 § 안 흡수 가능 (Trace mechanism 관련)"],
      "cons": ["§ 7 신규 = ARCHITECTURE 구조 추가 (현 § 3 / § 4 / § 6 + § 6.1 / § 6.2)", "§ 3.1 정체성 narrative 와 cross-ref 필요"]
    },
    {
      "id": "opt_3",
      "name": "'AI Native 운영' 정의 위치 = ARCHITECTURE.md § 3.3 5요소 매트릭스 안 신규 row 또는 sub-section",
      "description": "현 § 3.3 5요소 매트릭스 (Context / Workflow / Constraint / Verification / Trace) 안 'AI Native 운영' 을 sub-mechanism 으로 흡수 — 각 요소 안 sub-row 추가",
      "pros": ["5요소 매트릭스 single source 정합", "각 요소 안 AI Native 면 매핑 자연"],
      "cons": ["매트릭스 row 폭주 (5 → 5 + 3 = 8 row)", "'AI Native 운영' 의 cross-element 본질 표현 어려움 (3 면 = Context + Workflow + Trace + Verification 동시 영향)"]
    },
    {
      "id": "opt_4",
      "name": "entry title 가이드 위치 = ARCHITECTURE.md § 7 안 sub-section (AI Native § 안)",
      "description": "정의 § 7 안 sub-section 'Entry title 가이드' — 4 원칙 hardcode",
      "pros": ["정의 ↔ 가이드 cross-ref 1 위치", "Trace mechanism 직접 부합"],
      "cons": ["§ 7 본문 길어짐"]
    },
    {
      "id": "opt_5",
      "name": "entry title 가이드 위치 = projects/meta/ROADMAP.md schema_note 안 확장",
      "description": "현 ROADMAP.md schema_note (line 7) 안 'entry title 가이드' 추가 = ROADMAP entry 작성 시 직접 reference",
      "pros": ["entry 작성 시 가장 가까운 위치 = 강제력 향상", "ARCHITECTURE.md 비대화 회피"],
      "cons": ["schema_note 비대화", "CHANGELOG.md bullet header 가이드와 분리 (CHANGELOG schema_note 부재)"]
    },
    {
      "id": "opt_6",
      "name": "retitle 대상 = 가장 긴 active 3 entry (v5.20 / v5.19 / v5.21)",
      "description": "active milestone (in_progress + recent completed + deferred) 안 ≥ 100자 title 만 retitle",
      "pros": ["scope 작음 (3 retitle)", "사용자 답답함 직접 mitigation"],
      "cons": ["CHANGELOG.md 안 다른 long-bullet header 그대로 (cycle 1 이후 retitle 후속 milestone 의무)"]
    },
    {
      "id": "opt_7",
      "name": "retitle 대상 = 가장 긴 active 3 + CHANGELOG 안 동치 bullet header 3 = 총 6 retitle",
      "description": "opt_6 + CHANGELOG.md [v5.20] / [v5.19] / [v5.21] 안 굵게 처리된 bullet header 도 동기 retitle (한 entry = title + summary 정합 유지)",
      "pros": ["ROADMAP title ↔ CHANGELOG bullet header 1:1 동기 (cycle 1 완료)", "사용자 답답함 양 위치 (ROADMAP + CHANGELOG) 동시 mitigation"],
      "cons": ["scope 약간 증가 (3 → 6)"]
    }
  ],
  "risks_identified": [
    {
      "id": "risk_1",
      "category": "self_loop",
      "risk": "본 milestone = AI Native 운영 reframe = 본 repo 자체 운영 본질 변경 = self-improvement 본질 — v4.0 § 6.2 폐지 narrative 정합 의무 (memory feedback_section_6_2_abolished)",
      "severity": "P2",
      "mitigation_candidate": "INTENT 명료화 § '본 milestone 첫 원안 폐기 narrative' 안 이미 흡수. 단 본 milestone 본질 = workflow self-improvement 가 아닌 Trace 메커니즘 재정의 — v5.21 동질 (Trace 정전화)"
    },
    {
      "id": "risk_2",
      "category": "narrative_drift",
      "risk": "ARCHITECTURE.md 안 'AI Native 운영' 정의 신규 + cascade host narrative drift risk — v3.21 narrative 정전화 3 단계 패턴 cycle 25+ 적용 비용",
      "severity": "P2",
      "mitigation_candidate": "본 milestone 안 cascade scope = ARCHITECTURE.md + CLAUDE.md + projects/meta/CLAUDE.md + CHANGELOG.md (4 위치, 10 host 대비 작음). v3.21 패턴 적용 — DESIGN 1차 + EXECUTE Edit + VERIFY grep"
    },
    {
      "id": "risk_3",
      "category": "retitle_information_loss",
      "risk": "long-title retitle 시 detail 본질 일부 누락 risk — title 안 'A + B + C + D' 의 4 본질 중 일부가 summary 안 자연 흡수 안 될 수 있음",
      "severity": "P1",
      "mitigation_candidate": "각 retitle 대상 entry 의 summary 필드 안 detail 모두 흡수 검증 — DESIGN 안 retitle 패턴 정전화 + EXECUTE 안 entry 별 직접 검증"
    },
    {
      "id": "risk_4",
      "category": "schema_smoke",
      "risk": "title 길이 가이드 (≤ 60자) 가 smoke-spec-verification 안 검증되지 않음 — 향후 long-title 재발 risk",
      "severity": "P2",
      "mitigation_candidate": "본 milestone scope 외 (oos_2 와 동질). 단 DESIGN 안 후속 milestone (v6.1+) 안 smoke 추가 narrative cross-ref"
    },
    {
      "id": "risk_5",
      "category": "user_burden",
      "risk": "사용자 비개발자 + 스무고개 방식 — RESEARCH/DESIGN 안 결정 게이트 다수 시 사용자 인지 부담 증가",
      "severity": "P2",
      "mitigation_candidate": "DESIGN 안 결정 게이트 최소화 — option 결정 (정의 위치 / 가이드 위치 / retitle scope) 통합 1 round AskUserQuestion"
    },
    {
      "id": "risk_6",
      "category": "v4.0_identity_relationship",
      "risk": "'AI Native 운영' 정의 ↔ v4.0 정체성 (composer + integrator + maintainer) 관계 narrative 미명료 시 cascade drift",
      "severity": "P1",
      "mitigation_candidate": "DESIGN 안 'AI Native 운영' = v4.0 정체성 보완 (대체 아님) narrative 정전화. 3 면 매트릭스 = 운영 원칙 / v4.0 정체성 = 책임 정의 — 두 차원 cross-ref"
    },
    {
      "id": "risk_7",
      "category": "archival_overlap",
      "risk": "v5.21 archival cycle (recent 3 보존, 가장 오래된 completed CHANGELOG 이전) 가 본 milestone retitle 대상 (v5.19) 과 overlap — v5.19 가 PROPOSE 안 archival 시 retitle 작업이 archival 안 흡수 가능",
      "severity": "P2",
      "mitigation_candidate": "DESIGN 안 retitle 순서 결정 — (a) retitle 먼저 + archival 시 retitle 된 본문 이전 / (b) archival 먼저 + CHANGELOG 안 v5.19 동기 retitle"
    }
  ],
  "preliminary_options_summary": {
    "정의_위치": "opt_2 (§ 7 신규) 권장 — 독립 narrative + AI 컨텍스트 효율 + entry title 가이드 sub-section 자연 흡수. § 3.1 cross-ref 추가",
    "가이드_위치": "opt_4 (§ 7 안 sub-section) 권장 — 정의 ↔ 가이드 1 위치, Trace mechanism 직접 부합. ROADMAP schema_note (opt_5) 안 짧은 cross-ref 추가",
    "retitle_scope": "opt_7 (3 ROADMAP + 3 CHANGELOG = 6 retitle) 권장 — ROADMAP ↔ CHANGELOG 1:1 동기 자연. scope 적정 (lightweight 1 phase 정합)",
    "archival_순서": "DESIGN 안 결정 — Option (a) retitle 먼저 + archival 시 retitle 된 본문 이전 권장 (작업 흐름 자연)"
  }
}
```

## 명료화

### Entry title 가이드 4 원칙 (preliminary 정의 — DESIGN 안 확정)

1. **한 entry = 한 본질** — bundling 시에도 모자 본질만 title 안. 'A + B + C + D' 형식 회피
2. **≤ 60자 (한국어)** — LLM 효율 baseline + 한 화면 안 시각 흡수
3. **active form + 짧은 동사구 시작** — '재정의 / 도입 / 정전화 / 분리 / 통합 / 흡수 / 갱신' 같은 본질 동사
4. **detail 은 summary 필드 안 분리** — title 은 '무엇' / summary 는 '왜 + 어떻게 + 결과 + cross-ref'

예시 변환 (preliminary):

| Original (현행) | Retitle (예) |
|---|---|
| audit-team 외부 호출 cycle 7 + ARCHITECTURE § 4 끝 7 paragraph 매트릭스화 + agent namespace prefix cascade — stability 3 cycle 연속 (5+6+7) + v5.19 PROPOSE#4+#8 동시 흡수 + Plugin spec v5.0+ namespace 정합 (175자) | audit cycle 7 + § 4 매트릭스화 + namespace cascade (45자) |
| audit-team 외부 호출 cycle 6 — upbit 대상 + v5.17 cycle 5 diff + v5.18 Input Verification + 검증 method 분리 효과 검증 + ecosystem integrator vector 6건 누적 + stability cycle 첫 완성 (158자) | audit cycle 6 + Input Verification 효과 검증 (32자) |
| ROADMAP forward-looking 재정의 (recent 3건 + next_candidates only) + CHANGELOG.md v5.7~v5.20 14 entry backfill + completed 41건 archival + cascade 7 host narrative (139자) | ROADMAP forward-looking 재정의 + CHANGELOG archival (35자) |

### scope 정량

- ARCHITECTURE.md 안 § 7 신규 = ~1 paragraph + 3 면 매트릭스 + 4 원칙 + 예시 표 = ~50 line
- ROADMAP retitle = 3 entry × ~5 line modify = ~15 line edit
- CHANGELOG retitle = 3 bullet header × ~3 line modify = ~9 line edit
- CHANGELOG [v6.0] entry 신규 = ~10 line
- CLAUDE.md / projects/meta/CLAUDE.md cross-ref = ~2 line each

총 ~90 line / 6 파일 / 1 phase / 1 commit (lightweight 모드 정합)

### Archival cycle 검토

v5.21 archival 정책 = recent 3 + in_progress + deferred. 본 milestone (v6.0) in_progress 추가 시 recent 3 = v5.21 + v5.20 + v5.19 보존. v5.19 entry archival 시점 = 본 milestone PROPOSE 단계 (next_candidates 등재 직후). 단 본 milestone 안 v5.19 title retitle 작업 = archival 전 적용 → archival 안 retitle 된 본문 이전 (작업 흐름 자연).

## 관련

- INTENT: [`INTENT.md`](INTENT.md) (의도 + success_criteria + out_of_scope)
- v5.21 archival cycle 1차 source: [`../v5.21/`](../v5.21/) (recent 3 schema 정전화)
- v4.0 정체성 narrative: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.1 끝 (보완 대상)
- v3.21 narrative 정전화 3 단계 패턴: cycle 25 도그푸드 누적
