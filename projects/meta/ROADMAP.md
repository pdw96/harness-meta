# ROADMAP — meta

```json
{
  "project": "meta",
  "updated": "2026-05-20",
  "schema_note": "v5.21+ schema A2: milestones[] = recent 3 completed + in_progress + deferred only. next_candidates[] = PROPOSE 발의 후보 (id/title/trigger/origin_milestone/target_version/description). 과거 completed entry archival = CHANGELOG.md (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill + v5.21 backfill 패턴). next_candidates[].id regex: ^[a-z0-9-]+$ (group-slug, path-safe). target_version regex: ^v[0-9]+\\.[0-9]+$ (semver). v5.21_roadmap-forward-looking-redesign-and-changelog-archival 정전화. trace 3중 보존 = REPORT.md + git log + CHANGELOG entry. entry title 가이드 = ARCHITECTURE.md § 7.2 4 원칙 (v6.0 정전화) — 한 entry = 한 본질 + ≤ 60자 + active form + detail 은 summary 안. candidate_draft[] entry schema (v6.5_claude-autonomous-milestone-proposal 정전화): 7 필드 = id/title/source/detected_at/rationale/category/decision_pending. category enum 2 값 = 'internal_synthesis' (v6.5 자율 발의 = 내부 ROADMAP + 최근 5 milestone PROPOSE + lessons P2 종합) | 'benchmark_external' (v4.0 벤치마크 cycle routine = 외부 GitHub + Claude Code release notes). smoke tests/smoke-candidate-draft-schema.sh 자동 강제.",
  "deferred_note": "v1.4_hook-narrative-separation + v1.4_design-review-trace + v1.5_research-cascade-grep-discipline = workflow self-improvement 본질, v3.13_pending-milestone-renumber-policy 결정 (2026-05-12) + v3.14_deferred-revaluation-cycle-2 (2026-05-13 동결 유지) 정합. v4.0 § 6.2 폐지 narrative 후 (memory feedback_section_6_2_abolished) 재발의 trigger 조건 = 외부 projects/<name> (name ≠ meta) 실 적용 milestone 누적 5건+ ∧ 사용자 명시 발의 AND. 자기참조 사이클 동결 정책 보존.",
  "candidate_draft": [],
  "milestones": [
    {
      "version": "v6.5",
      "id": "claude-autonomous-milestone-proposal",
      "title": "Claude 자율 milestone 발의 mechanism",
      "status": "in_progress",
      "trigger": "B_byproduct",
      "milestones_path": "milestones/v6.5/MILESTONE.md#sub-milestones",
      "summary": "v6.0 INTENT.oos_4 origin (AI Native § 7.1 '자율성' 면 첫 실 적용). v6.4 cascade-sync hybrid 패턴 정합 — `/propose-next` slash command + `scripts/propose_next.py` (deterministic core) + smoke (read-only output validation) 3 컴포넌트 예상. pre-PLAN 3 round (2026-05-20): (1) 자율 범위 = candidate 제안까지만 (사용자 결정 게이트 보존, 스무고개 부합) / (2) Trigger = 명시 slash command (v6.4 hybrid 정합) / (3) Input source = 최소 세트 (ROADMAP next_candidates[] + 최근 5 milestone REPORT.md PROPOSE 거명만 + lessons_learned). RESEARCH/DESIGN 안 출력 형식 + 분석 logic + 출력 host 결정."
    },
    {
      "version": "v6.4",
      "id": "cascade-auto-sync-mechanism",
      "title": "cascade 자동 동기 mechanism",
      "status": "completed",
      "trigger": "B_byproduct",
      "milestones_path": "milestones/v6.4/MILESTONE.md#sub-milestones",
      "summary": "v6.0 INTENT.oos_3 origin (AI Native § 7.1 '다중 AI 협업' 면 첫 실 적용). v3.21 narrative 정전화 3 단계 패턴 수동 cycle 28 누적 cost 자동화 — `scripts/cascade_sync.py` (deterministic core, ~220 LOC) + `claude/commands/cascade-sync.md` (slash command UX orchestrator) + `tests/smoke-cascade-drift.sh` (read-only drift detect) + ARCHITECTURE § 4 끝 매트릭스 #8 row + paragraph 본문 정전화 (explicit `<a id=\"section-4-end-row-8\">` anchor). 도그푸드 cycle 29 self-host (root CLAUDE.md marker + cascade narrative 1 줄 blockquote = mechanism 자체 적용 첫 sync). 2 phase 2 commit — phase-1 (mechanism + smoke + § 4 끝 #8 + tests/CLAUDE.md cascade + INTENT sc_4 fact 정정 inline + MD012 inline 정정) / phase-2 (root CLAUDE.md marker + 도그푸드 + ROADMAP archival v6.1 + CHANGELOG [v6.4]). pre-commit 16 hook 모두 PASS. 5 관점 subagent 병렬 검토 cycle 4 = pass-with-comments × 5 + decisive 0 + P1 11 흡수 + P2 27 PROPOSE 거명만. v5.7 spec-drift spike 패턴 (c) 5번째 자연 발현 (marker format 자체 컨벤션). archival cycle 4번째 (v6.1 → CHANGELOG)."
    },
    {
      "version": "v6.3",
      "id": "entry-title-guideline-smoke-verification",
      "title": "entry title 가이드 smoke 자동 검증",
      "status": "completed",
      "trigger": "D_design",
      "milestones_path": "milestones/v6.3/MILESTONE.md#sub-milestones",
      "summary": "v6.0 DESIGN.D11_p2 origin + v6.2 OPEN 안 v6.3 shift 결정. ARCHITECTURE § 7.2 entry title 가이드 4 원칙 중 (1) ' + ' P1 mechanical proxy + (2) ≤ 60자 자동 강제 smoke 도입 + corrective 41+3건 일괄 정정 (meta ROADMAP 4 + upbit ROADMAP 15 + CHANGELOG bullet 21+3, title 만 retitle id 보존). (3) Active form + (4) Detail summary 분리 = AI 판단 위임 (oos_1+oos_2). 신규 tests/smoke-entry-title-guideline.sh (V1 algo + lookbehind/lookahead non-whitespace regex + length-bounded ReDoS 차단 + SIZE_LIMIT FAIL). 2 phase 2 commit — phase-1 (cb8950c smoke + cascade tests/CLAUDE.md + tmpfile fixture self-check) / phase-2 (pending corrective + cascade 5 host + ARCHITECTURE § 7.2 paragraph + CHANGELOG [v6.3] + .pre-commit-config.yaml 등재 + ROADMAP archival v6.0). 5 관점 subagent 병렬 검토 pass-with-comments × 5 / decisive 0 / P1 21 모두 DESIGN edit 흡수 + P2 14 PROPOSE 거명만 (lightweight). AI Native § 7.1 Verification 면 첫 실 적용 milestone. v3.21 narrative 정전화 cycle 28 + v5.7 spec-drift spike 패턴 (c) 4번째 자연 발현 + archival cycle 4번째 + feedback_subagent_parallel_review_evidence cycle 2 확장 (35 vs 20 = 1.75배). pre-PLAN 3 round + 1 stage round / 7 lessons + 14 P2 거명만."
    },
    {
      "version": "v6.2",
      "id": "milestone-artifact-directory-flattening",
      "title": "milestone 산출물 디렉토리 평탄화 (단일 파일 통합)",
      "status": "completed",
      "trigger": "B_byproduct",
      "milestones_path": "milestones/v6.2/MILESTONE.md#sub-milestones",
      "summary": "v6.1 PROPOSE#1 origin (AI Native § 7.1 컨텍스트 효율 면 cycle 2). 9-stage-flattened era 도입 — MILESTONE.md 단일 본책 (YAML frontmatter 4 필드 + H2 9 섹션) + execute/phase-{n}.md 별책 (b) 하이브리드. (1) v6.2~ 신규만 (v3.0~v6.1 28 active 디렉토리 era 보존). pre-PLAN 6 결정 + 5 관점 subagent 병렬 검토 (decisive 0 / P1 11 + P2 9 모두 흡수) + 2 phase (phase-1 smoke 4종 + cascade 12 host / phase-2 atomic commit 자체 retrofit). 2 commit (059206c + 171d4f4). 29 files / +1309 / -615. smoke 4종 PASS + pre-commit 14 hook PASS, 회귀 0. v3.21 narrative 정전화 cycle 27 도그푸드 완성. 7 lessons + 3 next_candidates 등재."
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
      "id": "audit-chain-hallucination-auto-correction",
      "title": "audit chain hallucination 자동 정정 mechanism",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.0",
      "target_version": "v6.6",
      "description": "v5.18 Input Verification + v5.13 fact 검증 수동 cycle 9+ 자동화. 다중 AI 협업 면. v6.0 INTENT.oos_5 origin. (v6.2 OPEN 시 v6.5→v6.6 shift)"
    },
    {
      "id": "ai-native-3-dimension-integration",
      "title": "AI Native 3 면 통합 (major)",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.0",
      "target_version": "v7.0",
      "description": "v6.1~v6.6 시리즈 완성 후 3 면 cross-mechanism 통합. v7.0 major bump (시리즈 통합). (v6.2 OPEN 시 시리즈 5→6 milestone)"
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
