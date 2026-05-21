# ROADMAP — meta

```json
{
  "project": "meta",
  "updated": "2026-05-21-v6.22-open",
  "schema_note": "v5.21+ schema A2: milestones[] = recent 3 completed + in_progress + deferred only. next_candidates[] = PROPOSE 발의 후보 (id/title/trigger/origin_milestone/target_version/description). 과거 completed entry archival = CHANGELOG.md (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill + v5.21 backfill 패턴). next_candidates[].id regex: ^[a-z0-9-]+$ (group-slug, path-safe). target_version regex: ^v[0-9]+\\.[0-9]+$ (semver). v5.21_roadmap-forward-looking-redesign-and-changelog-archival 정전화. trace 3중 보존 = REPORT.md + git log + CHANGELOG entry. entry title 가이드 = ARCHITECTURE.md § 7.2 4 원칙 (v6.0 정전화) — 한 entry = 한 본질 + ≤ 60자 + active form + detail 은 summary 안. candidate_draft[] entry schema (v6.5_claude-autonomous-milestone-proposal 정전화): 7 필드 = id/title/source/detected_at/rationale/category/decision_pending. category enum 2 값 = 'internal_synthesis' (v6.5 자율 발의 = 내부 ROADMAP + 최근 5 milestone PROPOSE + lessons P2 종합) | 'benchmark_external' (v4.0 벤치마크 cycle routine = 외부 GitHub + Claude Code release notes). smoke tests/smoke-candidate-draft-schema.sh 자동 강제.",
  "deferred_note": "v1.4_hook-narrative-separation + v1.4_design-review-trace + v1.5_research-cascade-grep-discipline = workflow self-improvement 본질, v3.13_pending-milestone-renumber-policy 결정 (2026-05-12) + v3.14_deferred-revaluation-cycle-2 (2026-05-13 동결 유지) 정합. v4.0 § 6.2 폐지 narrative 후 (memory feedback_section_6_2_abolished) 재발의 trigger 조건 = 외부 projects/<name> (name ≠ meta) 실 적용 milestone 누적 5건+ ∧ 사용자 명시 발의 AND. 자기참조 사이클 동결 정책 보존.",
  "candidate_draft": [],
  "milestones": [
    {
      "version": "v6.22",
      "id": "stage-skill-dogfood-cycle-2-evaluation",
      "title": "stage skill 도그푸드 cycle 2 평가",
      "status": "in_progress",
      "trigger": "B_byproduct",
      "milestones_path": "milestones/v6.22/MILESTONE.md#sub-milestones",
      "summary": "v6.19 PROPOSE candidates_named_only origin (v6.17 cycle 1 후속 + v6.18 stage skill 9 stage 확장 적용 후) — 본 milestone 진행 자체 = cycle 2 evidence. 9 stage skill auto-load 작동 여부 의식적 호출 없이 사후 회고 본질. v6.17 cycle 1 패턴 정합 — INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE 8 stage 각각 skill auto-load 발현 여부 + 부재 시 manual 호출 evidence 수집 → 본 milestone REPORT 단계 안 cycle 1 ↔ cycle 2 평가 narrative 작성."
    },
    {
      "version": "v6.21",
      "id": "bundled-skill-comprehensive-cross-audit",
      "title": "bundled skill 카탈로그 전수 책임 교차 점검",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v6.21/MILESTONE.md#sub-milestones",
      "summary": "v6.19 next_candidates 안 `bundled-skill-cross-audit` (D_design origin) scope 사용자 명시 확장 (2026-05-21) origin — `/simplify`+`/batch` 명칭 misattribution 발견 후 'Claude Code docs 안 모든 bundled skill 전수조사' 로 재정의. 통합 카탈로그 16건 (본 환경 실재 12건 + 부재 4건) dogfood evidence cycle 1 직접 호출 (`/fewer-permission-prompts`) + 15건 description+body Read fallback. 책임 매핑 표 16 row × 6 column (skill / 카테고리 / Anthropic 본질 / 본 repo 대응 / 결정 / 근거) + ARCHITECTURE § 4 끝 매트릭스 #15 row 신규 추가 (single host, d_2 정합). 핵심 outcome = **흡수 0 / 유지 16** — 본 repo 시스템 (9-stage workflow + 5 관점 review + cascade-sync + propose-next + audit-team + 자율 mechanism + plugin SKILL.md 14건) 책임 폭 우위 직접 evidence. 5 관점 review pass-with-comments 모두 (decisive 0 + P1 0 + P2 16 inline 흡수 + P3 12 PROPOSE candidates 거명). v3.21 narrative 정전화 3 단계 패턴 cycle 41 단일 host 본질 (v6.10 L3 가이드 정합 cycle 2). 8 lessons (L1~L3 P1 + L4~L7 P2 + L8 P3) + 7 next_candidates."
    },
    {
      "version": "v6.20",
      "id": "agent-type-syntax-adoption",
      "title": "Agent(agent_type) syntax 흡수",
      "status": "completed",
      "trigger": "B_byproduct",
      "milestones_path": "milestones/v6.20/MILESTONE.md#sub-milestones",
      "summary": "post-v6.19 audit session (2026-05-21, commit 192f374) origin — 4 자산 흡수 매트릭스 안 'full' 유일 1건. v2.1.33+ Claude Code Agent(agent_type) syntax 본 repo 안 첫 적용 사례 — agents/audit-orchestrator.md 신설 (~140 LOC, frontmatter tools: Agent(5 멤버 allowlist), Read, Bash, Edit, Grep, Glob) + cascade Edit 9 host (DESIGN 4 host minimum + EXECUTE 발견 5 추가) + 신규 smoke (tests/smoke-agent-frontmatter-schema.sh) 도입. opt_2 채택 (5 멤버 allowlist + Step 1~6 통합 orchestrator scope) — audit-team 외 agent spawn 차단 sandbox 효과. v3.21 cycle 40 self-host + v5.7 spike (c) 14번째. sc 6/6 PASS + risk 6/6 MITIGATED + smoke 19+1 PASS + verdict RESOLVED. 7 lessons (L1+L5 P1)."
    },
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
    },
    {
      "id": "task-completed-hook-audit-chain-poc",
      "title": "audit chain TaskCompleted hook PoC — Step 1~6 자동화",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.19",
      "target_version": "v6.x",
      "description": "본 세션 origin — v2.1.33+ TaskCompleted/SubagentStop hook event 로 audit-team Step N→N+1 trigger 표준화 가능성. 흡수 강도 = partial (사용자 게이트 Step 4↔5 양방향 dialogue hook payload schema 부재 / Step 6 synthesizer script invoke subagent 외 — 두 transition 외부 잔존). trigger = 다음 upbit audit cycle 안 PoC 적용 후 부분 자동화 가치 vs 추가 복잡도 trade-off 결정. PoC scope = Step 1→2→3→4 4 transition 중 hook 적용 가능 부분 evidence 수집."
    },
    {
      "id": "bundled-skill-cross-audit",
      "title": "bundled skill (/simplify /batch /run /verify) 책임 교차 점검",
      "trigger": "D_design",
      "origin_milestone": "v6.19",
      "target_version": "v6.x",
      "description": "본 세션 origin — 본 repo 5 관점 inline review 도그푸드 7 cycle + EXECUTE phase 분할 운영 vs 표준 bundled skill (/simplify 3 parallel review / /batch 5~30 unit decompose worktree / /run / /verify) 책임 1:1 대조 부재. 각 SKILL.md Read 후 흡수/유지 결정 4 sub-task. risk = bundled skill prompt-based playbook → 9-stage / cascade / propose-next workflow 종속성 결합 어려울 가능성. DESIGN 단계 = 4 skill 각각 흡수 가능 여부 결정 후 sub-milestone phase 분할."
    },
    {
      "id": "agents-md-sync-reassessment",
      "title": "agents-md-sync 자산 재권토 — 7 adapter 거주 0건 사실 기반 governance 결정",
      "trigger": "D_design",
      "origin_milestone": "v6.19",
      "target_version": "v6.x",
      "description": "본 세션 origin — AGENTS.md = Linux Foundation Agentic AI Foundation 안 2025-08 formalized 공식 오픈 표준 (20,000+ repos 채택, OpenAI/Anthropic/Block 공동 stewarded) 사실 확인. 본 repo 7 adapter 실측 거주 0건 → 현재 sync 실 효과 0, agents-md-sync subagent 잠재 가치만 (사용자 향후 adapter 작성 시 발현). 옵션 = (A) 자산 삭제 / (B) 7 adapter 중 1-2건 실제 생성 (잠재 가치 발현) / (C) AGENTS.md 자체 CLAUDE.md 안 통합 (canonical 단일화) / (D) 현 상태 유지. 사용자 의향 (Claude Code 외 multi-AI tool 사용 의도) 확인 선행 후 DESIGN 단계 결정."
    },
    {
      "id": "agent-frontmatter-agent-syntax-standalone-expansion",
      "title": "Agent(agent_type) syntax standalone subagent 확장",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.20",
      "target_version": "v6.x",
      "description": "v6.20 L5 P1 + INTENT oos_2 origin — 본 repo 안 첫 Agent(agent_type) literal 사용 사례 (audit-orchestrator.md) cycle 1 evidence 후 다른 standalone subagent (agents-md-sync / environment-auditor) frontmatter tools Agent(...) syntax 흡수 검토. 단 standalone subagent 본질 = agent 자체 spawn 책임 부재 (audit-orchestrator agent 의 5 멤버 allowlist 본질과 별 — standalone subagent 안 spawn 책임 없으면 Agent allowlist 의미 부재). evidence cycle 2 누적 시 발의 자연 (예: 다른 multi-agent orchestration 본질 발견 시)."
    },
    {
      "id": "audit-team-member-self-frontmatter-tools-restriction",
      "title": "audit-team 5 멤버 자체 frontmatter tools 강화",
      "trigger": "D_design",
      "origin_milestone": "v6.20",
      "target_version": "v6.x",
      "description": "v6.20 INTENT oos_1 origin (옵션 2 본질 'audit-team 5 멤버 frontmatter tools 명시' scope 축소 안). 5 멤버 자체 frontmatter tools 강화 (멤버끼리 상호 spawn 차단 syntax) candidate. 단 ext_2 spec 'transitive 비적용' 안 sub-agent 가 또 다른 sub-agent spawn 시 main restriction 비적용 = 본 candidate 본질 검증 필요 (5 멤버 자체가 sub-agent 위치 = main Claude restriction 비적용 → audit-orchestrator agent 의 5 멤버 allowlist 안 transitively spawn 가능 본질). DESIGN 단계 안 본질 가치 결정 후 발의 자연."
    },
    {
      "id": "cascade-host-minimum-narrative-canonicalization",
      "title": "cascade host minimum 표기 패턴 정전화",
      "trigger": "D_design",
      "origin_milestone": "v6.20",
      "target_version": "v6.x",
      "description": "v6.20 L2 P2 origin — DESIGN 단계 안 cascade host 매트릭스 narrative 시 'minimum N host (EXECUTE 안 실 확장 가능)' 표기 패턴 정전화 candidate. 본 milestone evidence = DESIGN d_5 4 host minimum 식별 → EXECUTE 안 발견 5 추가 = 9 host cascade (lightweight 자연 확장). v6.10 L3 패턴 정합 (cascade host 갯수 판정 기준 narrative 정전화) 후속 evidence stream. ARCHITECTURE § 6.2 narrative 정전화 3 단계 패턴 paragraph 안 본 minimum 표기 1 sentence 보강 candidate."
    },
    {
      "id": "v57-spike-cycle-cumulative-narrative-update",
      "title": "v5.7 spike 패턴 cycle 누적 narrative 갱신",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.20",
      "target_version": "v6.x",
      "description": "v6.20 L3 P2 origin — v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 cycle 14 도달 (v5.7 정전화 시 cycle 7 → v6.20 안 cycle 14 = 7 cycle 추가 누적). ARCHITECTURE § 6 spec-drift spike 패턴 paragraph 안 cycle 누적 narrative 갱신 candidate. 별 milestone 발의 trigger = cycle 15+ 도달 시 (자연 evidence 누적). 단일 cycle 누적 갱신 본질 = lightweight 1-phase 본질 자연."
    },
    {
      "id": "bundled-skill-environment-fact-verify",
      "title": "bundled skill 본 environment 실재 fact verify",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.21",
      "target_version": "v6.x",
      "description": "v6.21 L4 + spec-drift P3#2 origin — 본 환경 부재 4건 (`/simplify` + `/batch` + `/debug` + `/run-skill-generator`) Claude Code 버전 분기 또는 plugin 별도 install 추정 evidence. 본 milestone 안 직접 verify 부재 (oos_3 정합) → 별 candidate. scope = (a) Claude Code 버전 확인 + (b) plugin marketplace 안 4건 거주 검색 + (c) install 결정 또는 부재 fact 정전화."
    },
    {
      "id": "bundled-skill-vs-plugin-skill-cross-ref-narrative",
      "title": "bundled skill ↔ plugin SKILL 카테고리 cross-ref",
      "trigger": "D_design",
      "origin_milestone": "v6.21",
      "target_version": "v6.x",
      "description": "v6.21 L5 + architecture P3#2 origin — 두 카테고리 (Anthropic 표준 bundled skill vs 본 repo plugin SKILL.md 14건) 본질 분리 evidence. ARCHITECTURE § 7.3 안 cross-ref narrative 1 sentence 보강 candidate. trigger = bundled skill 흡수 결정 발생 시 (v6.21 outcome 흡수 0 → 본 trigger 부재, evidence 누적 후 발의 자연)."
    },
    {
      "id": "review-cycle-cost-marginal-default-decision",
      "title": "5 관점 review cycle marginal cost default 본질 결정",
      "trigger": "D_design",
      "origin_milestone": "v6.21",
      "target_version": "v6.x",
      "description": "v6.21 L6 + cost P2#1 origin — 5 관점 subagent 5 호출 ~40K (74% 토큰) marginal 본질 cycle 4 v6.4 converged 1.09배 이후. cycle 8 = 0.74배 추가 감소 직접 evidence. trigger = cycle 9+ 누적 시 default 본질 (subagent 5 vs inline self-review vs review 부재) 사용자 명시 결정 narrative 정전화."
    },
    {
      "id": "v321-single-host-pattern-judgment-narrative",
      "title": "v3.21 패턴 single host 본질 cycle 3+ 정전화",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.21",
      "target_version": "v6.x",
      "description": "v6.21 L7 + architecture P3#1 + dx P3#3 origin — v3.21 패턴 single host 본질 cycle 2 evidence 누적 (cycle 1 v6.10 + cycle 2 v6.21). v6.10 next_candidates `v321-pattern-application-judgment-criterion-narrative` trigger 충족 (cycle 3+ 도달 시 별 milestone 발의 자연 narrative 정합) — 본 cycle 2 evidence stream 누적 trigger. cycle 3+ 도달 시 § 6.2 paragraph 안 single host 판정 기준 1 sentence 보강."
    },
    {
      "id": "bundled-skill-vs-five-perspective-review-overlap-narrative",
      "title": "bundled review skill ↔ 본 repo 5 관점 review 중복 본질 narrative",
      "trigger": "D_design",
      "origin_milestone": "v6.21",
      "target_version": "v6.x",
      "description": "v6.21 dx P3#2 + security P3#3 origin — bundled skill `/code-review` + `/security-review` vs 본 repo 5 관점 review (DESIGN 안 architecture+spec-drift+cost+dx+security subagent 5 병렬) 책임 중복 본질 식별 evidence. 사용자 'review' 또는 'security' 자연어 trigger 시 분기 결정 narrative 정전화 candidate."
    },
    {
      "id": "dogfood-prompt-injection-isolation-narrative",
      "title": "dogfood 안 prompt injection 격리 narrative",
      "trigger": "D_design",
      "origin_milestone": "v6.21",
      "target_version": "v6.x",
      "description": "v6.21 security P3#2 origin — dogfood 16 호출 안 prompt injection 또는 indirect prompt injection 위험 (예: `/security-review` 가 MILESTONE.md Read → MILESTONE.md 안 적대적 instruction injection) 본 milestone 안 mitigation narrative 부재. 본 repo 자체 통제 source 자연 안전이나 별 candidate 자연 — dogfood 본질 (실 호출) 안 격리 본질 명시."
    },
    {
      "id": "run-skill-script-side-effect-candidate",
      "title": "`/run` 본 repo script 실행 side effect 검토",
      "trigger": "D_design",
      "origin_milestone": "v6.21",
      "target_version": "v6.x",
      "description": "v6.21 security P3#1 + spec-drift P2#2 origin — `/run` (부분 가능 5건 안) 본 repo 안 dev server 부재 → '본질 적용 가능 시 가능' 본질 모호. 본 repo 안 script (scripts/cascade_sync.py + propose_next.py + audit_fact_verify.py) 실행 dogfood candidate 자연 발현 시 사용자 통제 외 side effect 검토."
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
