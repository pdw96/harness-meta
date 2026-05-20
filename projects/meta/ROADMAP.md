# ROADMAP — meta

```json
{
  "project": "meta",
  "updated": "2026-05-20-v6.8",
  "schema_note": "v5.21+ schema A2: milestones[] = recent 3 completed + in_progress + deferred only. next_candidates[] = PROPOSE 발의 후보 (id/title/trigger/origin_milestone/target_version/description). 과거 completed entry archival = CHANGELOG.md (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill + v5.21 backfill 패턴). next_candidates[].id regex: ^[a-z0-9-]+$ (group-slug, path-safe). target_version regex: ^v[0-9]+\\.[0-9]+$ (semver). v5.21_roadmap-forward-looking-redesign-and-changelog-archival 정전화. trace 3중 보존 = REPORT.md + git log + CHANGELOG entry. entry title 가이드 = ARCHITECTURE.md § 7.2 4 원칙 (v6.0 정전화) — 한 entry = 한 본질 + ≤ 60자 + active form + detail 은 summary 안. candidate_draft[] entry schema (v6.5_claude-autonomous-milestone-proposal 정전화): 7 필드 = id/title/source/detected_at/rationale/category/decision_pending. category enum 2 값 = 'internal_synthesis' (v6.5 자율 발의 = 내부 ROADMAP + 최근 5 milestone PROPOSE + lessons P2 종합) | 'benchmark_external' (v4.0 벤치마크 cycle routine = 외부 GitHub + Claude Code release notes). smoke tests/smoke-candidate-draft-schema.sh 자동 강제.",
  "deferred_note": "v1.4_hook-narrative-separation + v1.4_design-review-trace + v1.5_research-cascade-grep-discipline = workflow self-improvement 본질, v3.13_pending-milestone-renumber-policy 결정 (2026-05-12) + v3.14_deferred-revaluation-cycle-2 (2026-05-13 동결 유지) 정합. v4.0 § 6.2 폐지 narrative 후 (memory feedback_section_6_2_abolished) 재발의 trigger 조건 = 외부 projects/<name> (name ≠ meta) 실 적용 milestone 누적 5건+ ∧ 사용자 명시 발의 AND. 자기참조 사이클 동결 정책 보존.",
  "candidate_draft": [
    {
      "id": "synthesizer-mismatch-report-5step-format",
      "title": "synthesizer mismatch 보고 형식 debugger 5-step",
      "source": "v6.6 MILESTONE.md ## PROPOSE next_candidates #6 (synthesizer-mismatch-report-5step-format) + v6.8 도그푸드 2차 cycle (2026-05-20) delta surface 안 최우선 valid 1건 (false positive 2건 제외)",
      "detected_at": "2026-05-20",
      "rationale": "Claude Code debugger subagent prompt 5-step 형식 (Capture/Identify/Isolate/Fix/Verify, https://code.claude.com/docs/en/sub-agents) 정합 mismatch 보고 형식. 현재 scripts/audit_fact_verify.py + scripts/propose_next.py stdout JSON 형식 → 5-step structured 형식 변경 narrative. v6.6 PROPOSE 안 거명만 처리되었으나 ROADMAP 미등재 상태. 외부 spec 정합 mechanism 우선 후속 candidate.",
      "category": "internal_synthesis",
      "decision_pending": "(a) 적용 scope = audit_fact_verify mismatch만 / (b) propose_next dedupe mismatch도 포함 / (c) 둘 다 + 미래 mismatch 보고 일반 형식 정전화. 책임 분리 = mechanical core vs LLM narrator 안 mismatch 형식 본질 (script vs prompt) 결정 + 5-step 형식 변경의 구체 schema."
    }
  ],
  "milestones": [
    {
      "version": "v6.8",
      "id": "propose-next-surface-dedupe-mechanism",
      "title": "/propose-next surface 자동 dedupe mechanism",
      "status": "completed",
      "trigger": "B_byproduct",
      "milestones_path": "milestones/v6.8/MILESTONE.md#sub-milestones",
      "summary": "v6.5 mechanism 외부 cycle 1 evidence (2026-05-20, commit ed44bed) origin — scan 출력 안 enumerated_milestones 9건 중 8건 (89%) 이 이미 next_candidates[] 등재 → LLM surface 시 duplicate 위험. v6.5 mechanism enhancement (별 mechanism 부재 → ARCHITECTURE § 4 끝 row #11 부재, v6.7 #10 enhancement 패턴 정합). scripts/propose_next.py 안 dedupe logic 직접 도입 (deterministic, LLM 누락 risk 0 + token cost 0) — candidate_titles → candidate_items 교체 (breaking, status enum 2 값 'delta' / 'passing') + matching key id 우선 + title fallback + scope next_candidates + candidate_draft 양쪽 + dedupe_stats 4 필드 (delta_count + passing_count + known_ids_count + known_titles_count). claude/commands/propose-next.md Step 2 prompt 재정의 (delta 우선 surface + passing 통계 only narrative + 비유 표현 3 entry 추가). ARCHITECTURE § 4 끝 #9 row + paragraph 보강 (verification method Stage 1 + Stage 2 분리 표기 + v6.8 dedupe 확장 paragraph 추가). cascade host 1 = root CLAUDE.md propose-next blockquote 본문 보강 + cascade-sync marker hash 자동 갱신. tests/smoke-candidate-draft-schema.sh Stage 2 확장 (script invoke + candidate_items + dedupe_stats schema 검증). 도그푸드 1 회 호출 = delta 21 / passing 7 / known_ids 9 / known_titles 9 (28건 items 5 milestones, 89% duplicate → 25% passing 자연 도달). lightweight 1-phase 통합 commit. pre-PLAN 4 round + Round 5 review = 5 round 안 핵심 결정 11건 흡수. 5 관점 inline self-review cycle 6 (decisive 0 + P2 3 + P3 2). v3.21 narrative 정전화 cycle 34 + v5.7 spec-drift spike (c) 8번째 (v4.2/v5.6/v6.2/v6.3/v6.4/v6.5/v6.6/v6.8) + AI Native § 7.1 '자율성' 면 second cycle (v6.5 first) + lightweight 11/23 = 47.8% (40% 첫 돌파) + archival cycle 8번째 (v6.5 archival). 8 lessons (L1~L3 P1 + L4~L8 P2) + 3 next_candidates 등재."
    },
    {
      "version": "v6.7",
      "id": "v513-v518-v66-3step-chain-narrative-canonicalization",
      "title": "v5.13/v5.18/v6.6 3-step chain 정전화",
      "status": "completed",
      "trigger": "D_design",
      "milestones_path": "milestones/v6.7/MILESTONE.md#sub-milestones",
      "summary": "v6.6 5 관점 spec-drift P2#3 + ROADMAP next_candidates[] #6 origin. ARCHITECTURE § 4 끝 #10 paragraph 안 audit chain hallucination 자동 검출 mechanism 의 운영 책임 분리 3-step chain (수동 v5.13/v5.18 1차 source → 자동 v6.6 검출 → 수동 정정 사용자/orchestrator) narrative + 비대칭 default (synthesizer 자동 vs 사용자 수동) 1 sentence 정전화 + cycle 4 evidence (v5.10/v5.11/v5.12/v6.5) 인용. cascade host 2 (ARCHITECTURE + root CLAUDE.md L135 blockquote 본문 보강) v6.4 cascade-sync mechanism 활용 첫 외부 cycle (v6.5/v6.6 = self-host vs v6.7 = 다른 milestone cascade). lightweight 1-phase 통합 commit. v3.21 narrative 정전화 cycle 33 + audit chain hallucination cycle 5 자체 정전화 + AI Native § 7.1 '다중 AI 협업' 면 third cycle + archival cycle 7번째 (v6.4 → CHANGELOG). pre-PLAN 4 round (A 옵션 + cascade host 제외 + detail 분석 3 의문 + 승인) + 5 관점 inline self-review (subagent 부재, lightweight + 토큰 효율 정합) = decisive 0 + P2 1 흡수 + P3 1 거명만 + 8 lessons (L1~L3 P1 + L4~L8 P2, L8 = v5.7 spec-drift spike (c) 8번째 즉시 정정) + 3 next_candidates 등재."
    },
    {
      "version": "v6.6",
      "id": "audit-chain-hallucination-auto-correction",
      "title": "audit chain hallucination 자동 검출 mechanism",
      "status": "completed",
      "trigger": "B_byproduct",
      "milestones_path": "milestones/v6.6/MILESTONE.md#sub-milestones",
      "summary": "v6.0 INTENT.oos_5 origin (AI Native § 7.1 '다중 AI 협업' 면 second cycle — 첫 번째 = v6.4 cascade-sync). v5.13/v5.18 정전화 절차 (synthesizer 직접 source 매핑 검증 + boolean/표/수치 method 분리) 수동 cycle 9+ script-only 자동화 (자율 = 검출 only, R1 결정). 3 컴포넌트 hybrid (v6.4/v6.5 정합) — scripts/audit_fact_verify.py (~250 LOC, stdlib only re+json+pathlib, BOOLEAN_LOOKUP callable + 표 schema column 매핑 + NUMERIC_LOOKUP empty no-op) + agents/project-harness-audit-team/CLAUDE.md Note v6.6 (Step 6 + 4 agent 표 column 본질, D3/D5) + tests/smoke-audit-fact-verify.sh (fixture 6 sub-dir + Stage 5 path traversal, D4/D6). ARCHITECTURE § 4 끝 매트릭스 #10 row + paragraph 정전화 + cascade 7 host (root CLAUDE.md + audit-team + harness-meta.md + tests/CLAUDE.md + .pre-commit-config.yaml + CHANGELOG + ROADMAP). pre-PLAN 4 round (R1 검출 only / R2 --audit 자동 / R3 v5.13 3 method / R4 3 컴포넌트 hybrid) + 5 관점 subagent 병렬 검토 cycle 5 (pass × 2 + pass-with-comments × 3, decisive 0, P1 7 흡수 + P2 11 거명만). v3.21 narrative 정전화 cycle 32 + v5.7 spec-drift spike (c) 7번째 + archival cycle 6번째 + audit chain hallucination cycle 4 자체 정전화 (v5.10/v5.11/v5.12/v6.5)."
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
      "id": "spec-drift-review-regex-vs-실-사용-mismatch-guideline",
      "title": "spec-drift 검토 regex 와 실 사용 함께 검증 가이드라인",
      "trigger": "B_regression",
      "origin_milestone": "v6.2",
      "target_version": "v6.x",
      "description": "v6.2 L7 origin — phase-2 안 milestones_path anchor (#sub-milestones) 처리 mismatch (regex 통과 vs 실 파일 검사) 가 RESEARCH/DESIGN 식별 안 됨. spec-drift agent prompt 안 'regex pattern + 실 사용 logic 함께 검토' 가이드라인 명시."
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
