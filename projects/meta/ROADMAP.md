# ROADMAP — meta

```json
{
  "project": "meta",
  "updated": "2026-05-21-v6.19-completed",
  "schema_note": "v5.21+ schema A2: milestones[] = recent 3 completed + in_progress + deferred only. next_candidates[] = PROPOSE 발의 후보 (id/title/trigger/origin_milestone/target_version/description). 과거 completed entry archival = CHANGELOG.md (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill + v5.21 backfill 패턴). next_candidates[].id regex: ^[a-z0-9-]+$ (group-slug, path-safe). target_version regex: ^v[0-9]+\\.[0-9]+$ (semver). v5.21_roadmap-forward-looking-redesign-and-changelog-archival 정전화. trace 3중 보존 = REPORT.md + git log + CHANGELOG entry. entry title 가이드 = ARCHITECTURE.md § 7.2 4 원칙 (v6.0 정전화) — 한 entry = 한 본질 + ≤ 60자 + active form + detail 은 summary 안. candidate_draft[] entry schema (v6.5_claude-autonomous-milestone-proposal 정전화): 7 필드 = id/title/source/detected_at/rationale/category/decision_pending. category enum 2 값 = 'internal_synthesis' (v6.5 자율 발의 = 내부 ROADMAP + 최근 5 milestone PROPOSE + lessons P2 종합) | 'benchmark_external' (v4.0 벤치마크 cycle routine = 외부 GitHub + Claude Code release notes). smoke tests/smoke-candidate-draft-schema.sh 자동 강제.",
  "deferred_note": "v1.4_hook-narrative-separation + v1.4_design-review-trace + v1.5_research-cascade-grep-discipline = workflow self-improvement 본질, v3.13_pending-milestone-renumber-policy 결정 (2026-05-12) + v3.14_deferred-revaluation-cycle-2 (2026-05-13 동결 유지) 정합. v4.0 § 6.2 폐지 narrative 후 (memory feedback_section_6_2_abolished) 재발의 trigger 조건 = 외부 projects/<name> (name ≠ meta) 실 적용 milestone 누적 5건+ ∧ 사용자 명시 발의 AND. 자기참조 사이클 동결 정책 보존.",
  "candidate_draft": [],
  "milestones": [
    {
      "version": "v6.19",
      "id": "changelog-github-releases-migration",
      "title": "GitHub Releases hybrid migration 도입",
      "status": "completed",
      "trigger": "B_regression",
      "milestones_path": "milestones/v6.19/MILESTONE.md#sub-milestones",
      "summary": "v6.18 evidence (CHANGELOG.md = 99998 bytes / SIZE_LIMIT 100000 -2 한계 + v6.17/v6.18 entry 1줄 단축 압박 누적) origin — next_candidates#12 promote. pre-PLAN 5 round 결정 (2026-05-21, 이전 세션 API Error 후 새 세션 재진행) — R1 migration scope = hybrid (신규 v6.19+ Releases + 과거 v1.0~v6.18 CHANGELOG.md 잔존 + 단축) / R2 과거 77 entry 단축 형태 = ID + title + REPORT link 1줄 (~80 byte × 77 ≈ 6KB / size 99998 → ~10KB, -90%) / R3 v6.19+ git tag + GitHub Release 발급 = GitHub Actions 자동 (commit msg trigger, 사용자 통제 본질 = commit msg 작성 자체) / R4 trigger pattern = explicit marker `[release:v{X.Y}]` (false positive 0) / R5 Release body = MILESTONE.md ## REPORT 섹션 추출. scope = .github/workflows/release-publish.yml 신규 + CHANGELOG.md 77 entry 단축 + v6.19 = CHANGELOG 마지막 entry (hybrid 분기 marker). 본질 = SIZE_LIMIT 회귀 회피 + trace 3중 보존 (CHANGELOG short / REPORT.md full / git log + git tag + GitHub Releases)."
    },
    {
      "version": "v6.18",
      "id": "stage-skill-expansion-7-stages",
      "title": "나머지 7 stage skill 일괄 도입",
      "status": "completed",
      "trigger": "B_byproduct",
      "milestones_path": "milestones/v6.18/MILESTONE.md#sub-milestones",
      "summary": "v6.16 oos_1 + v6.17 cycle 1 PASS evidence (PROPOSE narrative 안 명시 trigger 충족) origin — next_candidates#12 promote. scope = 나머지 7 stage (INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT) skill 일괄 도입 (R1 일괄 결정). body 구조 = v6.16 시범 패턴 동일 (4 H2: 입력 / 작성할 것 / 검증 / 관련, R2 일관성 우선 결정 — rm_5 일관성 mitigation 자연 도달). 도그푸드 evaluation = v6.17 패턴 반복 (의식적 호출 안 함 + 사후 회고, R3 cycle 2 evidence 결정 — 본 milestone 자체가 7 stage skill cycle 2 evidence stream). cascade host = ARCHITECTURE § 7.3 + § 4 #12 row + § 4 본문 paragraph 3 host (v6.16 row enhancement, 신 row 부재 — v6.7 v513-v518-v66 chain enhancement 패턴 정합) + 2 시범 skill (skills/stage-open + skills/stage-propose) narrative cascade (R4 결정). pre-PLAN 4 round (2026-05-21) — R1 scope / R2 body 구조 / R3 evaluation / R4 cascade host."
    },
    {
      "version": "v6.17",
      "id": "stage-skill-dogfood-cycle-1-evaluation",
      "title": "stage skill 도그푸드 cycle 1 평가",
      "status": "completed",
      "trigger": "B_byproduct",
      "milestones_path": "milestones/v6.17/MILESTONE.md#sub-milestones",
      "summary": "v6.16 r_2 PENDING + rm_2 mitigation 본질 — 본 milestone 자체가 skills/stage-open + skills/stage-propose auto-load 첫 evidence cycle. v6.16 OPEN/PROPOSE stage skill 시범 도입 후 첫 실 사용 evidence cycle. pre-PLAN 2 round (2026-05-21) — round 1: candidate 결정 = v6.16 PROPOSE 직접 후속 (stage-skill-dogfood-cycle-1-evaluation, target v6.17 명시) / round 2: evidence 수집 method = 의식적 호출 안 함 + 사후 회고 (자연성 최대, description 매칭 실 작동 evidence 본질). scope = Evidence-only lightweight 1-phase (drift 발견 시 별 milestone 자연 분기, oos_1 7-stage 확장 / oos_3 skill smoke / 신규 candidate 자연). v6.16 r_2 PENDING 해소 본질 (PASS = RESOLVED, vacuous = description trigger 재고). v3.21 narrative 정전화 3 단계 패턴 적용 대상 자연 검토 (skills/* derived 단방향, cascade host 부재 자연)."
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
    },
    {
      "id": "changelog-github-releases-migration",
      "title": "CHANGELOG.md GitHub Releases migration 평가 및 적용",
      "trigger": "B_regression",
      "origin_milestone": "v6.18",
      "target_version": "v6.x",
      "description": "v6.18 evidence (CHANGELOG size 103425 bytes SIZE_LIMIT 100000 초과 → entry 단축 후 99998 = 한계 -2). 4 GitHub 기능 분석 결과 = Releases 1차 후보 (Keep a Changelog 표준 정합 + tag 의존 + API 자동화). DESIGN 단계 결정 = (a) migration scope (전체 v1.0~ archival 또는 v6.x 신규만) + (b) git tag 발급 정책 (각 milestone = tag push or 일괄 backfill) + (c) repo 안 CHANGELOG.md 잔존 vs 완전 제거 + (d) Keep a Changelog format 안 Releases UI 매핑 자동화 (release-please 등) + (e) v6.17/v6.18 단축 entry 복원 (Releases 안 풀 본문). 별 milestone 발의 trigger = SIZE_LIMIT 추가 회귀 (다음 milestone REPORT 시점 자연 도달)."
    },
    {
      "id": "smoke-schema-strict-discipline-canonicalization",
      "title": "smoke schema-strict 강제 본질 정전화",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.18",
      "target_version": "v6.x",
      "description": "v6.18 L1 origin — smoke 자동 강제 forcing function evidence 누적 cycle 2 (v6.17 L4 RESEARCH options + v6.18 RESEARCH options + EXECUTE phase-{n}.md status 2건). frontmatter id/title + JSON spec 필드 강제 본질 schema documentation 정전화 candidate. 별 milestone 발의 trigger = 3+ cycle 누적 후 자연. DESIGN 단계 결정 = schema documentation 위치 (skills/* SKILL.md ## 검증 sub-section 또는 ARCHITECTURE § 7.3 sub-narrative) + scope (frontmatter / JSON spec 필드 + 강제 smoke 매핑 표)."
    },
    {
      "id": "skill-format-self-smoke-introduction",
      "title": "skill 자체 smoke 도입 (frontmatter, body 구조 자동 검증)",
      "trigger": "D_design",
      "origin_milestone": "v6.16",
      "target_version": "v6.x",
      "description": "v6.16 oos_3 origin — 시범 2 skill 형식 안정화 + 7 stage 확장 evidence 후 skill 형식 검증 smoke trigger 자연. scope = tests/smoke-skill-format.sh (frontmatter `name` + `description` 필수 + body 4 H2 강제 + ARCHITECTURE 1차 source 인용 grep). cycle 4 evidence (시범 2 + 확장 7 + 추가 N) 누적 시 발의 자연."
    },
    {
      "id": "v6-19-first-release-trigger-verification",
      "title": "v6.19 첫 release Actions trigger evidence verification",
      "trigger": "B_regression",
      "origin_milestone": "v6.19",
      "target_version": "v6.x",
      "description": "v6.19 sc_5 + ri_2 + ri_6 PENDING resolution 본질. REPORT commit msg `[release:v6.19]` marker → Actions workflow trigger → release 발급 evidence verification. 첫 release 본문 안 한국어 multi-byte rendering + markdown link 깨짐 (r_7+ri_3 polish) inline 확인 → 후속 milestone 자연. trigger = REPORT commit 후 자연 평가."
    },
    {
      "id": "milestone-md-report-link-polish-mechanism",
      "title": "release body markdown link polish mechanism 도입",
      "trigger": "D_design",
      "origin_milestone": "v6.19",
      "target_version": "v6.x",
      "description": "v6.19 oos_6 + r_7 + ri_3 origin — 첫 Release 발급 evidence 안 markdown link (relative path) GitHub Release UI 안 broken. polish = release-publish.yml 안 link 변환 logic (relative → absolute URL `https://github.com/{owner}/{repo}/blob/{tag}/{path}`). DESIGN 단계 = 변환 scope + timing + regex 복잡성 trade-off."
    },
    {
      "id": "range-entry-archive-link-recovery",
      "title": "CHANGELOG range entry archive link 회복 mechanism",
      "trigger": "D_design",
      "origin_milestone": "v6.19",
      "target_version": "v6.x",
      "description": "v6.19 ri_4 + L7 origin — shrink_changelog.py 19 entry link 부재 (range entry 단일 path 매핑 모호 — v1.0–v1.4 등). 본질 정보 손실 자연 인정 후 회복 candidate = range entry 다수 directory link 또는 git log commit hash link. trigger = archival cycle 세 번째 자연."
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
