# ROADMAP — meta

```json
{
  "project": "meta",
  "updated": "2026-05-20-v6.11",
  "schema_note": "v5.21+ schema A2: milestones[] = recent 3 completed + in_progress + deferred only. next_candidates[] = PROPOSE 발의 후보 (id/title/trigger/origin_milestone/target_version/description). 과거 completed entry archival = CHANGELOG.md (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill + v5.21 backfill 패턴). next_candidates[].id regex: ^[a-z0-9-]+$ (group-slug, path-safe). target_version regex: ^v[0-9]+\\.[0-9]+$ (semver). v5.21_roadmap-forward-looking-redesign-and-changelog-archival 정전화. trace 3중 보존 = REPORT.md + git log + CHANGELOG entry. entry title 가이드 = ARCHITECTURE.md § 7.2 4 원칙 (v6.0 정전화) — 한 entry = 한 본질 + ≤ 60자 + active form + detail 은 summary 안. candidate_draft[] entry schema (v6.5_claude-autonomous-milestone-proposal 정전화): 7 필드 = id/title/source/detected_at/rationale/category/decision_pending. category enum 2 값 = 'internal_synthesis' (v6.5 자율 발의 = 내부 ROADMAP + 최근 5 milestone PROPOSE + lessons P2 종합) | 'benchmark_external' (v4.0 벤치마크 cycle routine = 외부 GitHub + Claude Code release notes). smoke tests/smoke-candidate-draft-schema.sh 자동 강제.",
  "deferred_note": "v1.4_hook-narrative-separation + v1.4_design-review-trace + v1.5_research-cascade-grep-discipline = workflow self-improvement 본질, v3.13_pending-milestone-renumber-policy 결정 (2026-05-12) + v3.14_deferred-revaluation-cycle-2 (2026-05-13 동결 유지) 정합. v4.0 § 6.2 폐지 narrative 후 (memory feedback_section_6_2_abolished) 재발의 trigger 조건 = 외부 projects/<name> (name ≠ meta) 실 적용 milestone 누적 5건+ ∧ 사용자 명시 발의 AND. 자기참조 사이클 동결 정책 보존.",
  "candidate_draft": [],
  "milestones": [
    {
      "version": "v6.11",
      "id": "id-regex-validation-smoke",
      "title": "ROADMAP next_candidates[].id schema regex 자동 검증 smoke 도입",
      "status": "completed",
      "trigger": "B_regression",
      "milestones_path": "milestones/v6.11/MILESTONE.md#sub-milestones",
      "summary": "v6.10 L4 origin 직접 해소 — v6.10 OPEN 시 ROADMAP next_candidates#3 안 한국어 id (`spec-drift-review-regex-vs-실-사용-mismatch-guideline`) 가 schema_note `^[a-z0-9-]+$` 위반 발견. v6.10 안 영문 변환 직접 적용 만 (smoke 부재) → 회귀 차단 mechanism 부재. 해소 = `tests/smoke-candidate-draft-schema.sh` 안 Stage 3 신규 추가 (candidate-related umbrella 자연 확장) — projects/*/ROADMAP.md 안 next_candidates[].id regex `^[a-z0-9-]+$` 검증 + v6.10 L7 가이드라인 자기 적용 (smoke hardcode regex + projects/meta/ROADMAP.md schema_note 일치 검증, 2 위치 drift 자동 차단). lightweight 1-phase 통합 (v6.6~v6.10 누적 패턴 정합). pre-PLAN 2 round + 5 관점 inline self-review (decisive 0 / P2 3 / P3 2)."
    },
    {
      "version": "v6.10",
      "id": "spec-drift-regex-actual-usage-mismatch-guideline",
      "title": "spec-drift 검토 regex·실 사용 함께 검증 가이드라인 도입",
      "status": "completed",
      "trigger": "B_regression",
      "milestones_path": "milestones/v6.10/MILESTONE.md#sub-milestones",
      "summary": "v6.2 L7 origin 직접 해소 — `milestones_path` anchor (`#sub-milestones`) 처리 mismatch (regex 통과 vs 실 파일 검사 불일치) 가 RESEARCH/DESIGN 단계 spec-drift agent 안 식별 안 됨. 해소 = `claude/commands/harness-meta.md` 5 관점 review 표 안 spec-drift 행 (line 193) description 보강 = `외부 spec 정합` → `외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토`. 1 위치 정정 only — cascade host 부재 (5 관점 review 표 = harness-meta.md 단일 source, ARCHITECTURE/CLAUDE.md 는 거명만) + smoke 신규 부재 (Round 4 결정, evidence base 약 + lightweight 정합) + ARCHITECTURE narrative 부재 (5 관점 일반화 = oos_1, L7 1건 evidence 부재). v6.6~v6.9 lightweight 1-phase 누적 패턴 정합. id 영문 변환 = ROADMAP next_candidates#3 등재 한국어 id → schema_note `^[a-z0-9-]+$` 정합 (변환 trace INTENT.Motivation 안 보존). 4 round pre-PLAN + 5 관점 inline self-review (decisive 0 / P2 1 / P3 4 모두 narrative 흡수 또는 별 milestone 거명만). v3.21 narrative 정전화 cycle 36 적용 대상 부재 (단일 host) — 패턴 misapplication 회피 결정 정합. v5.7 spec-drift spike (c) 발현 대상 부재 (외부 spec 인용 안 함, 본 case 자체 spec-drift 검토 patterns 보강)."
    },
    {
      "version": "v6.9",
      "id": "synthesizer-mismatch-report-5step-format",
      "title": "synthesizer mismatch 보고 형식 debugger 5-step",
      "status": "completed",
      "trigger": "B_byproduct",
      "milestones_path": "milestones/v6.9/MILESTONE.md#sub-milestones",
      "summary": "v6.8 도그푸드 2차 cycle (2026-05-20, commit e844f27) candidate_draft surface delta 안 최우선 valid 1건 origin. Claude Code debugger subagent 5-step prompt (`1. Capture / 2. Identify / 3. Isolate / 4. Implement minimal fix / 5. Verify`, https://code.claude.com/docs/en/sub-agents, context7 verified) 정합 mismatch 보고 형식 도입. scripts/audit_fact_verify.py 안 3 detect function (boolean/table/numeric) mismatch dict schema 5-step 통일 (6 필드: method 보존 + capture/identify/isolate/fix/verify, isolate method-specific dict 보존). 책임 분리 = script Capture/Identify/Isolate 3 자동 채움 (deterministic) + Fix/Verify 2 빈 슬롯 (null, LLM/사용자 채움 — v6.6 R1 자율 = 검출 only + v6.7 3-step chain 정합). scope = audit_fact_verify only (Round 4 결정 vacuous trim — propose_next.py mismatch detect 부재) + ARCHITECTURE § 4 끝 매트릭스 #10 row + paragraph enhancement (v6.7 #10 + v6.8 #9 enhancement 패턴 정합, 신 row 부재) + cascade host 2 (root CLAUDE.md L135 audit chain hallucination blockquote + audit-team CLAUDE.md Note v6.6) + tests/smoke-audit-fact-verify.sh Stage 6 신규 (5-step schema 강제 + 도그푸드 PASS=8 FAIL=0). pre-PLAN 4 round + Round 5 review (수용 → EXECUTE) + 5 관점 inline self-review cycle 7 (decisive 0 + P2 3 + P3 2 = 5 issue 모두 narrative 흡수 또는 별 milestone 거명만). v3.21 narrative 정전화 cycle 35 + v5.7 spec-drift spike (c) 9번째 + AI Native § 7.1 다중 AI 협업 면 cycle 보강 (v6.6 mechanism enhancement) + lightweight 1-phase 누적 12/24 = 50% (첫 돌파) + archival cycle 9번째 (v6.6 → CHANGELOG)."
    },
    {
      "version": "v1.4_hook-narrative-separation",
      "title": "hook hard-code 메시지 narrative 분리 (post-report-write.sh)",
      "status": "deferred",
      "trigger": "D_design",
      "summary": "v1.3 § 3.1 명료화 단락 거명 자동화 #2 'hook hard-code'. post-report-write.sh inject 메시지를 shell 안에 박지 않고 MD 파일에 분리, hook 은 단순 reader.",
      "deferred_reason": "workflow self-improvement 본질, v3.13/v3.14 동결 결정 정합. v4.0 § 6.2 폐지 후 재발의 trigger 조건 = 외부 적용 5건+ ∧ 사용자 명시 발의 AND."
    },
    {
      "version": "v1.4_design-review-trace",
      "title": "Stage E 5 관점 검토 raw 출력 보존 (milestones/.../design-review/)",
      "status": "deferred",
      "trigger": "D_design",
      "summary": "v1.3 § 3.3 매트릭스 'Trace' = 정전 + 메타 고유 차별화이나 현재 Stage E subagent 5 관점 검토 결과는 DESIGN.md 통합 후 raw 출력 소실. milestones/v{X.Y}_*/design-review/{architecture,spec-drift,...}.md 로 보존.",
      "deferred_reason": "workflow self-improvement 본질, v3.13/v3.14 동결 결정 정합. v4.0 § 6.2 폐지 후 재발의 trigger 조건 = 외부 적용 5건+ ∧ 사용자 명시 발의 AND."
    },
    {
      "version": "v1.5_research-cascade-grep-discipline",
      "title": "RESEARCH cascade grep 패턴 강화 (relative/절대/symlink)",
      "status": "deferred",
      "trigger": "B_regression",
      "summary": "v1.4 lessons_learned #1 — RESEARCH 단계 cascade list grep 이 relative path (`../ARCHITECTURE.md`) 누락 (1건). claude/commands/harness-meta.md 또는 RESEARCH 템플릿 보강 — cascade RESEARCH 시 relative + 절대 + symlink 모두 grep 패턴 강화 의무 명시.",
      "deferred_reason": "workflow self-improvement 본질, v3.13/v3.14 동결 결정 정합. v4.0 § 6.2 폐지 후 재발의 trigger 조건 = 외부 적용 5건+ ∧ 사용자 명시 발의 AND."
    }
  ],
  "next_candidates": [
    {
      "id": "post-report-write-hook-flattened-era-trigger",
      "title": "post-report-write hook 자동 flattened era 분기",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.2",
      "target_version": "v6.x",
      "description": "v6.2 D8 결정 = hook trigger 부재 (단순함 우선). architecture P2 #1 deferred 등재. MILESTONE.md edit 시 ## REPORT 섹션 신규 출현 자동 검출 logic = Edit/Write hook 안 diff 분석. 토큰 비용 vs 자동화 trade-off DESIGN 단계 안 결정."
    },
    {
      "id": "spec-drift-spike-pattern-c-design-immediate-narrative",
      "title": "spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 narrative 보강",
      "trigger": "D_design",
      "origin_milestone": "v6.2",
      "target_version": "v6.x",
      "description": "v6.2 L4 origin — D16 (ext_2 DESIGN 즉시 정정) = v5.7 정전화 패턴 (c) 분기 세 번째 자연 발현. ARCHITECTURE § 6 끝 spec-drift spike paragraph 안 (c) DESIGN 즉시 정정 vs Stage F spike 두 분기 명료 명시 보강."
    },
    {
      "id": "ai-native-3-dimension-integration",
      "title": "AI Native 3 면 통합 (major)",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.0",
      "target_version": "v7.0",
      "description": "v6.1~v6.6 시리즈 완성 후 3 면 cross-mechanism 통합. v7.0 major bump (시리즈 통합). (v6.2 OPEN 시 시리즈 5→6 milestone)"
    },
    {
      "id": "citation-method-auto-detect-mechanism",
      "title": "인용 method 자동 검출 mechanism (cycle 4 evidence)",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.6",
      "target_version": "v6.x",
      "description": "v6.6 oos_2 origin — cycle 4 v6.5 외부 vector P1#1 fact 부재 evidence. path:line + fact 부재 판정 = LLM 추론 필요 → script-only 불가능 (v6.6 scope 외). LLM call + 재귀 hallucination 위험 mitigation narrative + 토큰 비용 trade-off DESIGN 단계 결정 후 후속 milestone 자연."
    },
    {
      "id": "audit-fact-verify-numeric-lookup-auto-trigger",
      "title": "수치 method lookup 자동 trigger (evidence 도달 시)",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.6",
      "target_version": "v6.x",
      "description": "v6.6 architecture P2#1 origin — risk_3 mitigation 안 'evidence 도달 시 lookup 추가 PROPOSE candidate 자연' narrative 만 (자동 trigger 부재). audit-fact-verify cycle 안 numeric mismatch 발견 시 lookup 추가 PROPOSE candidate 자동 발의 mechanism (PostToolUse hook 또는 별 trigger)."
    },
    {
      "id": "active-form-3-step-chain-retitle-v6-7",
      "title": "v6.7 entry title Active form retitle candidate",
      "trigger": "D_design",
      "origin_milestone": "v6.7",
      "target_version": "v6.x",
      "description": "v6.7 5 관점 inline self-review dictionary-semantics P3#1 origin. entry title `v5.13/v5.18/v6.6 3-step chain 정전화` (3) Active form 약 ('정전화' 명사 종결, v6.x 누적 패턴). retitle candidate 거명만 — '3-step chain narrative 정전화 도입' 등. v6.x 후속 milestone scope."
    },
    {
      "id": "cascade-sync-blockquote-content-auto-sync-mechanism",
      "title": "cascade-sync blockquote 본문 자동 동기 mechanism (marker hash 외)",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.7",
      "target_version": "v6.x",
      "description": "v6.7 L3 origin — cascade-sync mechanism = marker hash 만 자동 갱신, blockquote 본문 수동 동기 (Edit) 직접 evidence. blockquote 본문 자동 동기 mechanism = LLM 추론 필요 (source paragraph → blockquote 압축) → script-only 불가능 + 재귀 hallucination 위험 (v6.6 oos_2 패턴 정합). DESIGN 단계 결정 후 후속 milestone 자연."
    },
    {
      "id": "v6-7-as-external-cascade-cycle-1-evidence",
      "title": "v6.4 cascade-sync mechanism 외부 cycle counter 정전화",
      "trigger": "D_design",
      "origin_milestone": "v6.7",
      "target_version": "v6.x",
      "description": "v6.7 L5 origin — v6.4 mechanism 첫 외부 활용 (v6.5/v6.6 self-host 후) 직접 evidence. ARCHITECTURE § 4 끝 #8 paragraph 안 'external cascade cycle 1 = v6.7' counter 정전화 candidate. cascade-sync mechanism 성숙도 evidence."
    },
    {
      "id": "propose-next-lessons-p2-dedupe-scope-extension",
      "title": "lessons_learned P2 항목 dedupe scope 포함",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.8",
      "target_version": "v6.x",
      "description": "v6.8 oos_3 origin — 현 script lessons_p2_count = count only (title/id 추출 부재). dedupe 대상 자체 부재 → 별 milestone 안 lessons title 추출 logic 추가 후 dedupe scope 확장. P2 lessons title 추출 regex + dedupe scope 합산 narrative DESIGN 단계 결정."
    },
    {
      "id": "propose-next-legacy-era-id-backfill",
      "title": "PROPOSE entries 안 id 부재 era 자동 backfill",
      "trigger": "D_design",
      "origin_milestone": "v6.8",
      "target_version": "v6.x",
      "description": "v6.8 oos_1 origin — id 우선 + title fallback 안전망 보존 (legacy era v3~v5 PROPOSE 안 id 부재 안전 처리). 자동 backfill = scope 확장 mechanism. archival 본질 + legacy era 영향 분석 + cascade impact narrative DESIGN 단계 결정."
    },
    {
      "id": "smoke-candidate-related-umbrella-split-trigger",
      "title": "smoke-candidate-draft-schema umbrella 책임 분리 trigger 가이드라인",
      "trigger": "D_design",
      "origin_milestone": "v6.8",
      "target_version": "v6.x",
      "description": "v6.8 L4 origin — D9 결정 = 두 source 'candidate-related' umbrella 자연 정합 (lightweight 정합) 이나 미래 신규 source 추가 시 분리 trigger 조건 narrative 부재. 향후 third source (예: lessons_learned scope) 추가 시 umbrella 확장 vs 분리 결정 가이드라인 candidate."
    },
    {
      "id": "five-perspective-review-table-cascade-narrative",
      "title": "5 관점 review 표 cascade narrative ARCHITECTURE/CLAUDE.md 인용 보강",
      "trigger": "D_design",
      "origin_milestone": "v6.10",
      "target_version": "v6.x",
      "description": "v6.10 L2 origin — 5 관점 review 표 = harness-meta.md 단일 source. ARCHITECTURE.md L124 + CLAUDE.md root L38 안 `5 관점 검토` 거명만 → 향후 인용 narrative 보강 candidate (v3.21 패턴 적용 대상 자연 도달 — 단일 host → 다중 host 전환). evidence 누적 시 별 milestone 발의."
    },
    {
      "id": "v321-pattern-application-judgment-criterion-narrative",
      "title": "v3.21 패턴 적용 판정 기준 narrative 정전화 (cascade host 갯수)",
      "trigger": "D_design",
      "origin_milestone": "v6.10",
      "target_version": "v6.x",
      "description": "v6.10 L3 origin — v3.21 narrative 3 단계 패턴 적용 대상 판정 기준 = cascade host 갯수 (≥2 → 패턴 적용 / =1 → 적용 대상 부재). 본 milestone 안 자연 발현 (단일 host 적용 outcome 회피). ARCHITECTURE § 6.2 narrative 정전화 3 단계 패턴 paragraph 안 판정 기준 narrative 1 sentence 보강 후보. 단 별 milestone 발의 trigger = 또 다른 단일 host case 발견 시 (evidence 누적 자연)."
    }
  ]
}
```

## 의도 (v5.21+ schema A2)

본 ROADMAP 은 **forward-looking 이정표** — 사전적 의미 (Merriam-Webster '목표를 향한 진행을 안내하는 상세 계획' / Cambridge 'step-by-step visibility') 정합. `milestones[]` = 현재 진행 (in_progress) + 최근 완료 (recent 3건, carry-over context) + deferred (재발의 trigger 조건 보유) + `next_candidates[]` = PROPOSE 발의 후보 (forward-looking 본질).

**과거 completed entry archival** = [`../../CHANGELOG.md`](../../CHANGELOG.md) (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill + v5.21 backfill 패턴). trace 3중 보존:

1. **CHANGELOG.md entry** — 외부 visible artifact (release note 동치)
2. **milestones/v{X.Y}/REPORT.md** — milestone 종합 backward (lessons + delta)
3. **git log** — 원자 commit history + diff

## v5.21 정전화 1차 source

본 schema redesign 정전화 = [`milestones/v5.21/`](milestones/v5.21/) (RESEARCH + DESIGN + REPORT). [`ARCHITECTURE.md`](ARCHITECTURE.md) § 4 끝 #3 narrative 본질 변경 (drift 수용 → drift 해소 사례 정전화).

## 관련 문서

- 운영 가이드 (root): [`../../CLAUDE.md`](../../CLAUDE.md)
- ARCHITECTURE: [`ARCHITECTURE.md`](ARCHITECTURE.md)
- subdirectory CLAUDE.md (lazy load): [`CLAUDE.md`](CLAUDE.md)
- 최근 완료 milestone: [`milestones/v6.2/`](milestones/v6.2/) (completed, 2026-05-19 — milestone 산출물 디렉토리 평탄화 / 9-stage-flattened era)
- 과거 completed milestone (v1.0 ~ v5.20) 종합: [`../../CHANGELOG.md`](../../CHANGELOG.md) — entry 별 REPORT.md cross-ref
- Archive (v4.0 phase-2 분리): `milestones/_archive/v1.0_*` ~ `v3.21/` (역사적 디렉토리 보존)

## 비고

본 ROADMAP 은 v5.21_roadmap-forward-looking-redesign-and-changelog-archival (2026-05-19) 에서 schema A2 재설계. 이전 schema (v3.0+ 9-stage-bundled era, v3.0_milestones-restructure 도입) 는 `milestones[]` 단일 array 안 forward + past 혼재 = ~30~40% 부합 drift (v3.19/v5.9 정전화). v5.21 schema A2 는 `milestones[]` + `next_candidates[]` 명료 이원 분리 + CHANGELOG.md archival 흡수 = ~95%+ 부합 도달. 본 파일이 meta 진행/완료/후보 trace 의 단일 source — 단 past trace 본질은 CHANGELOG.md 위임.
