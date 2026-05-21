# Changelog

User-facing highlights for the harness-meta repo. For detailed change records, see `projects/meta/milestones/v{X.Y}/REPORT.md` (v3.0+ 9-stage-bundled era) 또는 `projects/meta/milestones/v{X.Y}_{slug}/REPORT.md` (v2.0~v2.1 9-stage / v1.0~v1.4 7-stage era).

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/) at the `.harness.toml` schema level.

`!` after a version marker denotes a breaking change.

## [Unreleased]

## [v6.18] - 2026-05-21

### Added

- **나머지 7 stage skill 일괄 도입** — v6.16 시범 + v6.17 cycle 1 PASS 후 INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT 7 stage skill 일괄 도입 = 9 stage 전체 cover. body 구조 v6.16 동일 (4 H2). ARCHITECTURE § 7.3 + § 4 #12 row + § 4 본문 3 host cascade enhancement. v3.21 cycle 38 + AI Native § 7.1 third cycle enhancement.

## [v6.17] - 2026-05-21

### Added

- **stage skill 도그푸드 cycle 1 평가** — v6.16 시범 2 skill 첫 실 사용 evidence cycle (의식적 호출 안 함 + 사후 회고). Layer 1 (description auto-inject) + Layer 2 (body) 분리. evidence stream 6건 → INTENT 7 sc PASS → verdict = RESOLVED. v6.16 r_2 PENDING → RESOLVED.

## [v6.16] - 2026-05-21

### Added

- **stage-templated-task 정전화 및 OPEN/PROPOSE skill 시범 도입** — 사용자 자연어 관찰 origin (`open 진입이 아니라 open 작성` 표현 차이). v6.2 era 이후 stage 본질 = MILESTONE.md H2 section 작성 task 자연 수렴 (v6.4~v6.9 mechanical cascade 누적 후 manual narrative 작성 잔존) → ARCHITECTURE § 7.3 신규 + § 4 #12 row + 본문 paragraph 3 host 정전화 + skills/stage-open + skills/stage-propose 2 SKILL.md 시범. INTENT 7 sc PASS + 6 risk mitigation + v3.21 cycle 37 + AI Native § 7.1 third cycle.

### Changed

- **ARCHITECTURE 3 host 정전화 (§ 7.3 / § 4 row / § 4 본문)** — v3.21 narrative 정전화 3 단계 패턴 cycle 37 자연 발현 (v6.10 L3 판정 host ≥2 정합). cascade host 3 양방.
- **ROADMAP v6.16 completed entry 갱신 및 v6.13 archival** — recent 3 = v6.16/v6.15/v6.14. v6.13 entry 제거 (CHANGELOG [v6.13] canonical 보존). next_candidates[] 3건 append. updated `2026-05-21-v6.16`.

### Documented

- **AI Native § 7.1 third cycle** — v6.0 → v6.2 → v6.16 누적 3 cycle. § 7.3 안 직접 명시.
- **Skill spec context7 verified** — `--- YAML frontmatter (description 필수 + name 권장) + Markdown body 자유` (`/websites/code_claude` query). dir name = slash command.
- **lessons L1+L2 P1 누적 2건** — L1 phase-{n}.md schema mismatch (YAML frontmatter + JSON `status` 누락) → schema-strict 신규 file 작성 시 직전 milestone reference 의무 정전화 candidate. L2 SKILL.md outer markdown fence MD031 충돌 → outer fence 폐기 + narrative lead 패턴 candidate.
- **entry skill 대 stage skill 토폴로지 분리 evidence** — v1.75 SKILL 인프라 거부 memory (sub-agent injection 맥락) ≠ stage skill (main Claude template). 충돌 부재 확인.
- **lightweight 10/24 = 41.7% 누적 (phase 2 분리 첫 cycle)** — phase 다중 = 위치 분리, 본질 1개 보존. v6.7~v6.16 lightweight 누적.

## [v6.15] - 2026-05-21

### Added

- **v6.4~v6.9 entry title active form 재정의** — ROADMAP next_candidates[#5] origin (v6.7 5 관점 inline self-review dictionary-semantics P3#1). v6.4~v6.9 6 milestone frontmatter title 안 명사 종결 누적 패턴 (mechanism 4 / 정전화 1 / 5-step 1) → ARCHITECTURE § 7.2 (3) Active form 원칙 자기 적용 retitle. case-by-case suffix = v6.4/v6.5/v6.6/v6.7/v6.8 = `도입` + v6.9 = `통일`. 6 frontmatter title + 6 `# heading` 동기 갱신 + CHANGELOG v6.7/v6.8/v6.9 bullet bold 3 위치 동기 갱신.

### Changed

- **v6.6/v6.8/v6.9 frontmatter status drift fix** — `status: in_progress` 잔존 → `completed` 갱신 (실 milestone 완료 evidence — ROADMAP archived + CHANGELOG entry 존재). 부수 frontmatter cleanup umbrella 본질 흡수 (사용자 결정 (A)+(B) 정합).
- **ROADMAP milestones[] 안 v6.15 in_progress entry 추가** — v5.21+ schema A2 정합. next_candidates[#5] `active-form-3-step-chain-retitle-v6-7` entry 제거 (promote). updated `2026-05-21-v6.15`. v6.12 archival = REPORT 시점 자연.
- **ARCHITECTURE § 6 spec-drift cycle 11 → 12 갱신** — v6.13 + v6.14 보강 → v6.15 보강. 분기 분포 10:1 → 11:1 (c-2 자체 정전화 우세 evidence 강화). v6.15 = Conventional Commits / Keep a Changelog 안 entry title style guide 부재 → § 7.2 본 repo 자체 컨벤션 자기 적용 (c-2 분기 자연).

### Documented

- **v6.6 frontmatter 표기 drift 별 milestone PROPOSE 거명** — (C) `자동 정정` ↔ R1 결정 `검출 only` 표기 drift 본 milestone scope 외 (oos_1 정합, spec-drift 본질). REPORT lesson + PROPOSE 안 별 milestone candidate id 후보 등재.
- **자기 적용 도그푸드 cycle 2** — v6.3 entry-title-guideline-smoke-verification (cycle 1, § 7.2 (1)+(2) 자동 강제 + 자기 적용) → v6.15 (cycle 2, § 7.2 (3) Active form 자기 적용, smoke 자동 강제 외 AI 판단 위임 본질).
- **lightweight 1-phase 9 consecutive 누적** — v6.7~v6.15 9 consecutive lightweight 1-phase milestone. lightweight 18/30 = 60% 첫 60% 돌파.
- **v5.7 spec-drift spike (c-2) cycle 12 누적** — Conventional Commits / Keep a Changelog 안 entry title style guide 부재 → § 7.2 본 repo 자체 컨벤션 자기 적용 (c-2 자체 정전화 분기 본질).
- **v6.15 RESEARCH cb_11 hallucination 자연 정정** — RESEARCH 안 v6.9 CHANGELOG bullet bold = `synthesizer mismatch 5-step format 정합` 인용이 실 `synthesizer mismatch 보고 형식 debugger 5-step` 표기와 mismatch → EXECUTE 단계 안 정확 line read 후 정정. fact verification cycle 안 hallucination 자연 발견 evidence (memory feedback_subagent_fact_hallucination_correction cycle 3).
- **5 관점 inline self-review cycle 11 evidence** — cycle 10 (v6.14 = decisive 0 + P2 0 + P3 자연) → cycle 11 (v6.15 = decisive 0 + P2 2 + P3 2 = 4 issue, 모두 narrative 흡수 또는 별 milestone 거명만).

## [v6.14] - 2026-05-21

### Added

- **audit-fact-verify NUMERIC_LOOKUP cycle 7 evidence 자연 확장** — `scripts/audit_fact_verify.py` 안 NUMERIC_LOOKUP empty {} no-op fallback 의 cycle 7 v5.17 evidence (scanner-output cycle 5 line 130 JSON 형식 `claude_md_lines: 148` + `claude_md_bytes: 9158` wc -l/-c 실측 정정) 자연 도달 = 2 entry 자연 추가. callable = `lambda: len((REPO_ROOT / 'CLAUDE.md').read_text(encoding='utf-8').splitlines())` + `lambda: len((REPO_ROOT / 'CLAUDE.md').read_text(encoding='utf-8').encode('utf-8'))` (Python stdlib cross-platform safe = universal newlines + utf-8 encoding 명시). v6.6 BOOLEAN_LOOKUP callable signature `Callable[[], bool]` 정합 보존 (round 9 (Y) lookup signature 변경 폐기 결정 정합).
- **smoke-audit-fact-verify Stage 3 numeric-mismatch fixture** — `tests/fixtures/audit-fact-verify/numeric-mismatch/scanner-output.md` 신규 (stated value 999999 unlikely large cross-platform stable, lookup actual 실측 ≠ 999999 → mismatch detect 2건 → exit 1 FAIL). smoke .sh Stage 3 안 `run_case "numeric-mismatch" 1` 추가 + header narrative 7 fixture sub-dir 갱신.
- **audit-team CLAUDE.md Note v6.14** — v5.13 + v5.16 + v5.18 + v6.6 Note 누적 5번째. NUMERIC_LOOKUP cycle 7 evidence 통합 + mechanism context scope 본질 명시 (harness-meta repo 한정 cover, target project 외부 repo context oos, v6.6 D10 path traversal 차단 narrative 정합).

### Changed

- **ROADMAP milestones[] 안 v6.14 in_progress → completed entry** — v5.21+ schema A2 정합 (recent 3 = v6.13/v6.12/v6.11 보존, v6.14 신규 추가). v6.10 archival 완료 (OPEN stage). updated `2026-05-21-v6.14`.
- **ARCHITECTURE § 4 끝 #10 narrative 보강** — v6.6 / v6.9 enhancement 누적 3번째. 매트릭스 row #10 안 'v6.14 NUMERIC_LOOKUP cycle 7 evidence + context scope narrative' cell 추가. paragraph 끝 안 v6.14 enhancement sub-narrative append (mechanism context scope 본질 명시 + cycle 7 evidence 통합 + pre-PLAN 11 round 누적 결정 trace).
- **ARCHITECTURE § 6 spec-drift spike cycle counter 갱신** — cycle 9 (v4.2 + v5.6 + v6.2~v6.9 9 cycle, v6.13 안 cycle 9 표기) → cycle 11 (v6.13 + v6.14 흡수 = v4.2 / v5.6 / v6.2 / v6.3 / v6.4 / v6.5 / v6.6 / v6.8 / v6.9 / v6.13 / v6.14 11 cycle). 분기 분포 8:1 → 10:1 (c-2 자체 정전화 우세 evidence 강화).

### Documented

- **pre-PLAN 11 round 누적 결정 trace** — round 1~4 scope precision (citation method literal MVP → evidence sample 분석 → citation method evidence cover 0% → NUMERIC_LOOKUP cycle 7 redirect) / round 5 finding (v6.6 BOOLEAN_LOOKUP REPO_ROOT vs target project context mismatch 약점) / round 6 (identity 갱신 + audit_dir parent traversal) / round 7~8 (INTENT sketch + 검토) / round 9 finding (target project = harness-meta 외부 별 git repo + v6.6 D10 path traversal 차단 narrative 외부 path 불허 = mechanism 자체 작동 불가능) / round 10 (Y) 회귀 + (P1) 전면 재작성 / round 11 false mismatch 검증 (MILESTONE.md 안 backtick wrapped reference 매칭 부재).
- **v5.7 spec-drift spike 패턴 (c) 자연 발현 11번째** — context7 query `/websites/code_claude` 4 source (debugger 5-step / subagent chain / `$CLAUDE_PROJECT_DIR` / `parent_tool_use_id`) 안 'subagent fact verification target project context callable lookup signature' first-class 패턴 부재 = 자기 정전화 자연 (v6.6 D12 정합).
- **mechanism context scope 본질 자기 한계 인정 narrative** — BOOLEAN/NUMERIC lookup callable scope = harness-meta repo (REPO_ROOT 기준) context 한정 cover, target project (외부 repo) context 검증 oos. 외부 context 검증 mechanism 필요 시 별 milestone 자연 (scanner agent.md `target_project_root` field 명시 + path traversal narrative 갱신).
- **lightweight 1-phase 누적 17/29 = 58.6% 보강** (v6.13 16/28 = 57.1% → v6.14 17/29 = 58.6%). v6.6~v6.14 9 consecutive lightweight 1-phase milestone 누적.
- **도그푸드 cycle 33 self-host PASS** — `python scripts/audit_fact_verify.py --dir projects/meta/milestones/v6.14/` 호출 시 MILESTONE.md 안 BOOLEAN/NUMERIC key 인용 부재 (모두 backtick wrapped reference) → detect empty pass 자연 (round 11 false mismatch 검증 통과 evidence).
- **5 관점 inline self-review cycle 10 evidence** — cycle 9 (v6.13 = 5 issue) → cycle 10 (v6.14 = decisive 0 + P3 정합 자연, P2 0건). lightweight inline 누적 patterns.

## [v6.13] - 2026-05-21

### Added

- **spec-drift spike paragraph narrative 보강** — v6.2 L4 origin (v5.7 정전화 패턴 (c) 분기 세 번째 자연 발현) 직접 해소. ARCHITECTURE § 6 끝 spec-drift spike paragraph 안 4 정정 항목 inline edit = (a) 첫 줄 '정정 cycle 3 단계' → '정정 cycle 4 단계' 1 워드 정정 (본문 (a)(b)(c)(d) 4 step 매핑 정합) + (b) (c) step 안 두 분기 명료 분리 표기 = `(c) 정정 시점 분기 = (c-1) Stage F EXECUTE 안 실 spike (실 호출 / 실 spec 검증) 또는 (c-2) DESIGN 안 즉시 정정` (naming convention 명시) + (c) '자연 발현 origin 2건' → '자연 발현 누적 cycle 9 (v4.2 / v5.6 / v6.2 / v6.3 / v6.4 / v6.5 / v6.6 / v6.8 / v6.9), 분기 분포 8:1 (c-2 vs c-1)' sentence 갱신 + (d) 분기 본질 분리 sentence 추가 = `분기 본질 = 외부 spec 명시 부재 정도 (자체 정전화 = spec 자체 부재 → c-2 / 외부 spec 검증 = binary 검증 필요 → c-1). 누적 분포 8:1 = 자체 정전화 cycle 우세 evidence`.

### Changed

- **ROADMAP milestones[] 안 v6.13 in_progress → completed entry** — v5.21+ schema A2 정합 (recent 3 = v6.12/v6.11/v6.10 보존, v6.13 신규 추가). next_candidates[] 안 `spec-drift-spike-pattern-c-design-immediate-narrative` entry promote 제거 (12 → 11). updated `2026-05-21-v6.13`.

### Documented

- **scope (소) — v6.10 동질 패턴 정합** — paragraph 1 위치 only (lightweight 1-phase). v6.10 L3 narrative (v3.21 패턴 적용 판정 기준 = cascade host 갯수 ≥2 → 패턴 적용 / =1 → 적용 대상 부재) 직접 정합 = 단일 host 정전화 자연. cascade host 추가 = scope 확장 → 별 milestone candidate (oos_2 보존).
- **자기참조 도그푸드 cycle 10 자연 발현** — 본 milestone 자체 = v5.7 spike (c-2) DESIGN 즉시 정정 분기 10번째 자연 발현 (Anthropic spec 안 spec-drift spike pattern 표준 부재 → 자체 정전화 자연). 단 paragraph 안 cycle 9 만 표기 (현 시점 evidence 누적, cycle 10 PROPOSE candidate 명시 + 후속 milestone 흡수 자연, L4 P2 결정 정합).
- **분기 분포 8:1 evidence** — c-2 (DESIGN 즉시 정정) 8건 = v4.2 + v6.2 ~ v6.9 (cascade marker format / audit chain fact verification / debugger subagent format / dedupe mechanism 등 본 repo 자체 컨벤션 mechanism 도입) / c-1 (Stage F spike) 1건 = v5.6 (settings.json enabled key binary 검증). 본 repo 자체 컨벤션 mechanism 도입 시 외부 spec 검증 → 부재 시 자체 정전화 분기가 더 흔한 자연 발현 패턴 사실 진술.
- **lightweight 1-phase 누적 16/28 = 57.1% 보강** (v6.12 15/27 = 55.6% → v6.13 16/28 = 57.1%). v6.6~v6.13 8 consecutive lightweight 1-phase milestone 누적.
- **v3.21 narrative 정전화 3 단계 패턴 적용 대상 부재** (cycle 카운트 보존) — 본 milestone cascade host = 1 (spike paragraph 자체 only). v6.10 L3 판정 기준 (≥2 → 적용 / =1 → 적용 대상 부재) 정합. cycle 카운트 보존 (cycle 36 적용 대상 부재).
- **5 관점 inline self-review cycle 9 evidence** — cycle 8 (v6.12 = 6 issue) → cycle 9 (v6.13 = decisive 0 + P2 3 + P3 2 = 5 issue, 모두 narrative 흡수 또는 별 milestone 거명만).

## [v6.12] - 2026-05-20

### Added

- **smoke-candidate-draft-schema fixture sub-dir 자동화 도입** — v6.11 lessons L3 origin 직접 해소 (v6.11 안 violation 주입 controlled 비교가 수동 = bash + python heredoc 1 종, id regex만). `tests/smoke-candidate-draft-schema.sh` 안 Stage 4 신규 추가 (umbrella 확장, R1) + `tests/fixtures/candidate-draft-schema/` 7 sub-dir 신규 (normal + violation-{id, category, missing-field, detected_at, rationale-too-long, source-empty}). v6.6 `smoke-audit-fact-verify` 안 6 sub-dir fixture 패턴 동질 mechanism 적용 cycle 2 (fixture-based smoke 자동화 패턴 정전화).
- **Stage 1 logic 5 신규 검증 항목 추가** — (i) id regex `^[a-z0-9-]+$` + (ii) detected_at ISO 8601 (`^\d{4}-\d{2}-\d{2}$`) + (iii) rationale length ≤ 500자 (codepoint len) + (iv) source non-empty + (v) decision_pending non-empty. `validate_candidate_draft()` 함수 추출 (Stage 1 logic 안 + Stage 4 fixture loop 안 silent 호출 재사용). 책임 분리 = Stage 3 책임 (next_candidates[].id regex) 보존, Stage 1 = candidate_draft[] 자체 책임 (scope 다름, 중복 부재).
- **ARCHITECTURE § 4 끝 매트릭스 #11 row · paragraph 본문 신규** — `fixture-based smoke 자동화 패턴 cycle 2` 정전화 (cascade host 3 = smoke + tests/CLAUDE.md + ARCHITECTURE, v3.21 narrative 정전화 3 단계 패턴 cycle 3 자연 발현, R3). v6.6 cycle 1 → v6.12 cycle 2 evidence + Anthropic Claude Code spec 안 first-class fixture 패턴 부재 (v5.7 spec-drift spike (c) 10번째 자연 발현).

### Changed

- **smoke 매트릭스 행 description Stage 1·2·3·4 4 단계 명시** — tests/CLAUDE.md 안 smoke-candidate-draft-schema 행 description = Stage 1 (v6.5 + v6.12 logic 확장 5 항목) · Stage 2 (v6.8) · Stage 3 (v6.11) · Stage 4 (v6.12) 4 단계 책임 명시 + fixture 패턴 cycle 2 (v6.6 → v6.12) 명시. 보조 cascade 정합.
- **ROADMAP milestones[] 안 v6.12 in_progress entry 추가** — v5.21+ schema A2 정합 (recent 3 = v6.11/v6.10/v6.9 보존, v6.12 in_progress 추가). candidate_draft[] 안 v6.12 entry promote 제거 (v6.12 milestones[] 등재 시 자연 흡수). v6.11 PROPOSE 안 거명 candidate `candidate-draft-id-regex-extension` (Stage 3 확장 본질, ROADMAP 등재 부재 = lightweight 정합) 자연 흡수 — 본 milestone 안 Stage 1 추가 = mechanism 위치 다름 (책임 분리) + 검증 effect 동일 (candidate_draft[].id regex 자동 차단). updated `2026-05-20-v6.12`.

### Documented

- **v6.6 cycle 1 → v6.12 cycle 2 fixture 패턴 evidence** — controlled 비교 자동화 mechanism (sub-dir + expected exit code mapping + validate() 함수 재호출) 본 repo 자체 정전화 cycle 2 도달. v6.6 = `audit_fact_verify.py --dir` subprocess / v6.12 = `validate_candidate_draft()` in-process — 책임 단일 source 분리 본질 동일. evidence-base trigger 2건 도달 시 정전화 자연 (v6.6 + v6.12).
- **v3.21 narrative 정전화 3 단계 패턴 cycle 3 적용** — cascade host 3 (smoke 자체 + tests/CLAUDE.md 매트릭스 행 + ARCHITECTURE § 4 끝 #11 row + paragraph) 동시 갱신. (a) RESEARCH 1차 source 식별 (cb_1~cb_6) + (b) EXECUTE Edit 3 host + (c) VERIFY grep 수동 (cascade-sync marker opt out, R3). cascade-sync marker 자동 drift 차단 별 candidate `cascade-sync-blockquote-content-auto-sync-mechanism` 보존.
- **lightweight 1-phase 누적 15/27 = 55.6% 보강** (v6.11 14/26 = 53.8% → v6.12 15/27 = 55.6%). v6.6~v6.12 7 consecutive lightweight 1-phase milestone 누적.
- **archival cycle 12번째 (v6.9 → CHANGELOG)** — v5.21+ schema A2 정합 (recent 3 = v6.12/v6.11/v6.10 보존). v6.11 안 archival narrative ('v6.11 completed 처리 시 v6.8 archival 자연') 패턴 정합. ROADMAP milestones[] 안 v6.9 entry 제거 (CHANGELOG [v6.9] entry 본문 보존).
- **5 관점 inline self-review cycle 8 evidence** — cycle 7 (v6.11 = 5 issue) → cycle 8 (v6.12 = decisive 0 + P2 4 + P3 2 = 6 issue, 모두 narrative 흡수 또는 별 milestone 거명만).
- **EXECUTE 직전 round 5 정정 — 책임 분리 명료화** — INTENT/DESIGN 안 `Stage 3 책임 보존` narrative 가 candidate_draft[].id regex 검증 부재 evidence 발견 → 책임 분리 (Stage 1 = candidate_draft / Stage 3 = next_candidates) 명료화 + Stage 1 안 5 신규 검증 (4 → 5). pre-PLAN round 의무 + 메모리 `feedback_iterative_pre_plan_review` 정합.

## [v6.11] - 2026-05-20

### Added

- **ROADMAP next_candidates[].id schema regex 자동 검증 smoke 도입** — v6.10 L4 origin 직접 해소 (v6.10 OPEN 시 next_candidates#3 안 한국어 id `spec-drift-review-regex-vs-실-사용-mismatch-guideline` schema_note `^[a-z0-9-]+$` 위반 발견 → 영문 변환 직접 적용만, 회귀 차단 mechanism 부재). `tests/smoke-candidate-draft-schema.sh` 안 Stage 3 신규 추가 (candidate-related umbrella 자연 확장) — projects/*/ROADMAP.md 안 `next_candidates[].id` regex `^[a-z0-9-]+$` 검증. id 부재 entry SKIP (legacy era 안전, 별 candidate `propose-next-legacy-era-id-backfill` 보존).
- **v6.10 L7 가이드라인 자기 적용 (regex·schema_note 일치 검증)** — Stage 3 안 projects/meta/ROADMAP.md schema_note 본문 안 regex 명시값 (`^[a-z0-9-]+$`) substring 검증. smoke hardcode 와 2 위치 drift 자동 차단 — schema_note 변경 시 smoke 자동 fail → 사용자 명시 정정 게이트. v6.10 L7 가이드라인 (regex·패턴 안 실 사용 logic 함께 검토) 본 milestone 본질 자기 적용.

### Changed

- **smoke 매트릭스 행 description Stage 1·2·3 3 단계 명시** — tests/CLAUDE.md 안 smoke-candidate-draft-schema 행 description = Stage 1 (v6.5) · Stage 2 (v6.8) · Stage 3 (v6.11) 3 단계 책임 명시 + v5.7 spec-drift spike 패턴 (c) 10번째 자연 발현 표기. 보조 cascade 정합.
- **ROADMAP milestones[] 안 v6.11 in_progress entry 추가** — v5.21+ schema A2 정합 (recent 3 = v6.10/v6.9/v6.8 보존, v6.11 in_progress 추가). next_candidates#11 (id-regex-validation-smoke) entry 제거 (promote). updated `2026-05-20-v6.11`. archival 대상 부재 (v6.11 completed 처리 시 v6.8 archival 자연).

### Documented

- **v6.10 L7 가이드라인 자기 적용 evidence** — v6.10 직후 milestone (v6.11) 본질 = regex·패턴 안 실 사용 logic 함께 검토 mechanism 도입. 가이드라인 → smoke 자동 강제 cycle (L7 narrative cascade 정합).
- **lightweight 1-phase 누적 14/26 = 53.8% 보강** (v6.10 13/25 = 52% → v6.11 14/26 = 53.8%). v6.6~v6.11 6 consecutive lightweight 1-phase milestone 누적.
- **v3.21 narrative 정전화 3 단계 패턴 적용 대상 부재 (cycle 카운트 보존)** — 본 milestone cascade host ≤ 2 (smoke 본체 + tests/CLAUDE.md 매트릭스 행) → v6.10 L3 판정 기준 (≥2 → 적용 / =1 → 적용 대상 부재) 정합. cycle 카운트 보존 (cycle 36 적용 대상 부재).
- **violation 주입 controlled 비교 패턴 도그푸드** — 임시 한국어 id entry 주입 → smoke FAIL 정상 (exit 1 + 위반 entry id 정확 검출) → 복원 → smoke PASS 회귀 0 양방향 검증. tests/CLAUDE.md 회귀 검증 절차 정합.
- **5 관점 inline self-review cycle 9 evidence** — cycle 8 (v6.10 = 5 issue) → cycle 9 (v6.11 = decisive 0 + P2 3 + P3 2 = 5 issue, 모두 narrative 흡수 또는 별 milestone 거명만).

## [v6.10] - 2026-05-20

### Added

- **spec-drift 검토 regex·실 사용 함께 검증 가이드라인 도입** — v6.2 L7 origin 직접 해소 (`milestones_path` anchor `#sub-milestones` 처리 mismatch — `tests/smoke-bundle-trigger.sh` regex 통과 vs 실 파일 검사 logic 불일치 가 RESEARCH/DESIGN 단계 spec-drift agent 안 식별 안 됨). `claude/commands/harness-meta.md` 5 관점 review 표 안 spec-drift 행 (line 193) description 보강 = `외부 spec 정합` → `외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토`. `/` 구분자 — 다른 4 행 (architecture `디렉토리 구조 / 파일 책임 / 변경 영향` 등) 패턴 정합.

### Changed

- **ROADMAP milestones[]·next_candidates 갱신 (v6.7 archival)** — schema A2 recent 3 정합 (v5.21 도입 archival cycle 10번째 사례, recent 3 = v6.10/v6.9/v6.8). id 영문 변환 = ROADMAP next_candidates#3 등재 한국어 id (`spec-drift-review-regex-vs-실-사용-mismatch-guideline`) → 본 milestone OPEN 시 영문 (`spec-drift-regex-actual-usage-mismatch-guideline`) — schema_note `^[a-z0-9-]+$` 정합 + 의미 동치 (변환 trace MILESTONE.md INTENT.Motivation 안 보존).
- **title active form 약 강화** — `... 가이드라인` 명사 종결 → `... 가이드라인 도입` verb suffix. ARCHITECTURE § 7.2 entry title 가이드 4 원칙 (2) active form 정합 — 자기 적용만 (v6.7 retitle candidate `active-form-3-step-chain-retitle-v6-7` 별 milestone 보존, oos_5).

### Documented

- **v3.21 narrative 정전화 3 단계 패턴 적용 대상 부재** — 5 관점 review 표 = `claude/commands/harness-meta.md` 단일 source. ARCHITECTURE.md L124 + CLAUDE.md root L38 은 `5 관점 검토` 거명만 (표 5 관점 정의 부재) → cascade host 부재. 패턴 misapplication 회피 결정 정합 (v3.21 패턴 = 여러 host 흩어진 narrative 통합용, 단일 host case 적용 외).
- **v5.7 spec-drift spike (c) 발현 대상 부재** — 본 case 외부 spec 인용 부재 (sub-agent prompt 정의 안 보강 문구 형태). 본 case 자체 = spec-drift 검토 patterns 자체 보강 (메타 본질).
- **5 관점 inline self-review cycle 8 evidence** — cycle 7 (v6.9 = 5 issue) → cycle 8 (v6.10 = decisive 0 + P2 1 + P3 4 = 5 issue, 모두 narrative 흡수 또는 별 milestone 거명만).
- **lightweight 1-phase 누적 13/25 = 52% 보강** (v6.9 12/24 = 50% → v6.10 13/25 = 52%).
- **archival cycle 10번째** — v6.6 (v6.9) / v6.7 (v6.10) archival.

## [v6.9] - 2026-05-20

### Added

- **synthesizer mismatch debugger 5-step 형식 통일** — v6.8 도그푸드 2차 cycle (2026-05-20, commit e844f27) candidate_draft surface delta 안 최우선 valid 1건 origin. Claude Code debugger subagent 5-step prompt (`1. Capture / 2. Identify / 3. Isolate / 4. Implement minimal fix / 5. Verify`, <https://code.claude.com/docs/en/sub-agents>) 정합 mismatch 보고 형식 도입. `scripts/audit_fact_verify.py` 안 3 detect function (boolean/table/numeric) mismatch dict schema 5-step 통일 (6 필드: method 보존 + capture/identify/isolate/fix/verify, isolate method-specific dict 보존 = boolean/numeric `{stated, actual, key}` / table `{source_ref, issue}`). 책임 분리 = script Capture/Identify/Isolate 3 자동 채움 (deterministic) + Fix/Verify 2 빈 슬롯 (`null`, LLM/사용자 채움 — v6.6 R1 + v6.7 3-step chain 정합).
- **tests/smoke-audit-fact-verify.sh Stage 6 신규** — v6.9 5-step schema 강제 검증 (boolean-mismatch fixture 호출 + stdout JSON parse + 6 필드 + `fix=null` + `verify=null` 강제). 기존 fixture 재사용 (신규 부재). PASS=8 FAIL=0.

### Changed

- **ARCHITECTURE § 4 끝 매트릭스 #10 row 와 paragraph enhancement** — v6.6 audit chain hallucination 자동 검출 mechanism 의 output schema enhancement (별 mechanism 부재 → 신 row #11 부재, v6.7 #10 + v6.8 #9 enhancement 패턴 정합). row #10 column 2/3/4 갱신 (Stage 6 추가 명시). paragraph 끝 안 v6.9 5-step 형식 enhancement 1 paragraph 추가 (외부 spec 직접 인용 + 책임 분리 + 미래 script 정합 의무 narrative).
- **root CLAUDE.md audit chain hallucination blockquote 보강** — v6.9 5-step 형식 enhancement 1 줄 추가 (cascade host 2). cascade-sync marker hash 자동 갱신 (`b16102818b6970fa` → `3398cd3daea60c64`).
- **audit-team CLAUDE.md Note v6.6 안 5-step schema 인용** — Step 6 stdout 안 mismatch dict 6 필드 schema 인용 추가 (cascade host 2). isolate method-specific dict 보존 명시.
- **scripts/propose_next.py 변경 0 (Round 4 vacuous trim)** — propose_next.py 안 mismatch detect logic 자체 부재 → vacuous trim 자연 (oos_3). scope (b) '둘 다 + 일반 정전화' 본질 = ARCHITECTURE row #10 enhancement 안 '미래 script 정합 의무' narrative 으로 보존.
- **ROADMAP milestones[] archival v6.6 entry** — schema A2 recent 3 정합 (v5.21 도입 archival cycle 9번째 사례, recent 3 = v6.9/v6.8/v6.7).

### Documented

- **v3.21 narrative 정전화 3 단계 패턴 cycle 35 누적** — cycle 34 (v6.8 cascade host 1) → cycle 35 (v6.9 cascade host 2 = root CLAUDE.md + audit-team CLAUDE.md, audit-team CLAUDE.md cascade marker 부재 직접 인용).
- **v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 9번째 자연 발현** — Anthropic Claude Code debugger subagent 5-step 외부 spec 인용 정합 (context7 verified) → 자체 정전화 자연. 누적 = v4.2/v5.6/v6.2/v6.3/v6.4/v6.5/v6.6/v6.8/v6.9.
- **5 관점 inline self-review cycle 7 evidence** — cycle 6 (v6.8 = 5 issue) → cycle 7 (v6.9 = decisive 0 + P2 3 + P3 2 = 5 issue, 모두 narrative 흡수 또는 별 milestone 거명만).
- **lightweight 1-phase 누적 12/24 = 50% 첫 돌파** (v6.8 11/23 = 47.8% → v6.9 12/24 = 50.0%).
- **archival cycle 9번째** — v6.5 (v6.8) / v6.6 (v6.9) archival.

## [v6.8] - 2026-05-20

### Added

- **/propose-next surface 자동 dedupe mechanism 도입** — v6.5 mechanism 외부 cycle 1 evidence (2026-05-20, commit ed44bed — surface 9건 중 8건 duplicate = 89%) origin. `scripts/propose_next.py` 안 dedupe logic 직접 도입 (deterministic, LLM 누락 risk 0 + token cost 0). `candidate_titles` (list of str) → `candidate_items` (list of `{id, title, status}`) breaking 교체 — status enum 2 값 `delta` (신규 surface 대상) / `passing` (이미 next_candidates 또는 candidate_draft 안 등재). matching key = id 우선 (`{1,64}` group-slug regex 추출) + title fallback (legacy era v3~v5 안전망). dedupe scope = `next_candidates[]` + `candidate_draft[]` 양쪽 (이미 인지한 후보 통합 의미, buffer 안 entry 재 surface 위험 0).
- **scripts/propose_next.py 안 ENTRY_BLOCK_REGEX 와 ID_REGEX 신규** — flat dict entry block 매칭 (length-bounded `{1,2000}`) + id 필드 추출 length-bounded regex (`{1,64}` group-slug). 둘 다 ReDoS 차단 정합 (v6.5 D10 sec P1 패턴 직접 연계).
- **scripts/propose_next.py 안 cross_validate.dedupe_stats 4 필드** — `delta_count` + `passing_count` + `known_ids_count` + `known_titles_count`. LLM Step 2 narrative 입력 (passing 통계 only).
- **scripts/propose_next.py NAMED_ONLY_REGEX 종결자 명시** — pre-existing lazy match `(.*?)\]` 가 entry rationale 안 `[]` 문자열 안 `]` 잘림 회귀 차단 (v6.5 PROPOSE 안 rationale `"candidate_draft[]..."` evidence). 종결자 `\]\s*[,}]` 변경.

### Changed

- **claude/commands/propose-next.md Step 2 prompt 재정의** — `status: delta` 우선 surface + passing 통계 only narrative ('이미 N건 등재 (passing). 신규 M건 (delta) 우선 검토'). delta 0건 case 별도 narrative ('신규 후보 부재 + passing 통계 보고'). 비유 표현 가이드 3 entry 추가 (`status: delta` / `status: passing` / `dedupe_stats`).
- **tests/smoke-candidate-draft-schema.sh Stage 2 확장** — `scripts/propose_next.py --scan` 호출 + `cross_validate.dedupe_stats` 4 필드 검증 + `enumerated_milestones[].candidate_items` 3 필드 (id/title/status) + status enum 2 값 강제. 'candidate-related schema 강제' umbrella 책임 자연 (D9, 별 smoke 신규 회피 lightweight 정합).
- **ARCHITECTURE § 4 끝 매트릭스 #9 row 와 paragraph 보강** — v6.5 propose-next mechanism 의 enhancement (별 mechanism 부재 → 신 row #11 부재, v6.7 #10 enhancement 패턴 정합). row #9 verification method 안 Stage 1 + Stage 2 분리 표기. paragraph 본문 안 v6.8 surface 자동 dedupe 확장 1 paragraph 추가 (3~4 sentences narrative + matching key + scope + Step 2 prompt 본질).
- **root CLAUDE.md L130 propose-next blockquote 본문 보강** — v6.8 surface 자동 dedupe 확장 1 줄 추가 (cascade host 1). cascade-sync marker hash 자동 갱신 (`5af4794bf53712fa` → `2313949d4ddfff70`).
- **ROADMAP milestones[] archival v6.5 entry** — schema A2 recent 3 정합 (v5.21 도입 archival cycle 8번째 사례). CHANGELOG [v6.5] entry 안 보존.

### Documented

- **v3.21 narrative 정전화 3 단계 패턴 cycle 34 누적** — cycle 33 (v6.7 self-host) → cycle 34 (v6.8 cascade host 1 = root CLAUDE.md propose-next blockquote).
- **v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 8번째 자연 발현** — Anthropic Claude Code spec 안 'dedupe / enumerate filter' 표준 패턴 부재 → 자체 정전화 자연. 누적 = v4.2/v5.6/v6.2/v6.3/v6.4/v6.5/v6.6/v6.8.
- **AI Native § 7.1 '자율성' 면 second cycle** — v6.5 first (Claude 자율 candidate 제안) / v6.8 second (script 자율 dedupe 분리 + LLM surface 책임 축소).
- **5 관점 inline self-review cycle 6 evidence** — cycle 5 (v6.7 = 2 issue) → cycle 6 (v6.8 = decisive 0 + P2 3 + P3 2 = 5 issue, 모두 narrative 흡수 또는 별 milestone 거명만).
- **lightweight 1-phase 통합 본질** — v6.7 1-phase narrative-only → v6.8 1-phase mechanism 확장 (script + slash + smoke + ARCHITECTURE + cascade 한 본질 통합).

## [v6.7] - 2026-05-20

### Added

- **audit chain 운영 책임 분리 3-step chain narrative 정전화 도입** — ARCHITECTURE § 4 끝 #10 paragraph 안 audit chain hallucination 자동 검출 mechanism (v6.6 도입) 의 운영 책임 분리 = 3-step chain — (a) 수동 1차 source (`v5.13_audit-chain-fact-verification-protocol-procedure` 3 method + `v5.18_audit-chain-direct-read-and-verification-depth` 검증 method 분리) → (b) 자동 검출 (본 v6.6 mechanism Step 6 자동 호출) → (c) 수동 정정 (사용자/orchestrator, R1 자율 = 검출 only 결정 정합). 검출 (b 자동) ↔ 정정 (c 수동) 비대칭 default = memory `feedback_subagent_fact_hallucination_correction` 직접 정합 + cycle 4 evidence (v5.10/v5.11/v5.12/v6.5).
- **CHANGELOG [v6.7] entry** — release note 동치 외부 visible artifact (Keep a Changelog v1.1.0 정합).

### Changed

- **root CLAUDE.md L135 blockquote 본문 보강** — 운영 책임 분리 3-step chain 짧은 인용 1 줄 추가 (cascade host 2 = ARCHITECTURE + root CLAUDE.md). cascade-sync marker hash 자동 갱신 (`0446710b892034da` → `b16102818b6970fa`).
- **ROADMAP milestones[] archival v6.4 entry** — schema A2 recent 3 정합 (v5.21 도입 archival cycle 7번째 사례). CHANGELOG [v6.4] entry 안 보존.

### Documented

- **v3.21 narrative 정전화 3 단계 패턴 cycle 33 누적** — cycle 32 = v6.6 self-host → cycle 33 = v6.7 self-host.
- **v6.4 cascade-sync mechanism 첫 외부 cycle** — v6.5/v6.6 = self-host (mechanism 도입 milestone 자체 적용) → v6.7 = 다른 milestone cascade (audit chain 3-step chain narrative 정전화). cascade-sync 성숙도 직접 evidence.
- **AI Native § 7.1 '다중 AI 협업' 면 third cycle** — v6.4 first (cascade-sync 자동화) / v6.6 second (audit fact verify 자동 검출) / v6.7 third (narrative 정전화 형식).
- **audit chain hallucination cycle 5 자체 정전화** — cycle 4 evidence (v5.10/v5.11/v5.12/v6.5) → cycle 5 = v6.7 narrative 정전화 자체 (3-step chain 흐름 명료화).
- **5 관점 inline self-review cycle 5 evidence** — subagent cycle 4 (v6.6 = 18건 converged) → cycle 5 (inline, 2 issue: spec-drift P2#1 D5 R1 풀어쓰기 흡수 + dictionary-semantics P3#1 self-retitle 거명만). lightweight 본질 milestone 자연 정합 evidence + memory `feedback_token_efficiency_priority` 직접 정합.
- **lightweight 1-phase 통합 본질** — v6.4/v6.5/v6.6 = mechanism 도입 2-phase vs v6.7 = narrative-only 1-phase. ARCHITECTURE § 6.1 v3.18 정전화 narrative 직접 evidence (mechanism 부재 → 1-phase 자연).

## [v6.6] - 2026-05-20

### Added

- **audit chain hallucination 자동 검출 mechanism 신규 도입** — AI Native § 7.1 '다중 AI 협업' 면 second cycle (v6.0 INTENT.oos_5 origin, v6.4 cascade-sync 첫 cycle 후속). v5.13/v5.18 정전화 절차 (synthesizer 직접 source 매핑 검증 + boolean/표/수치 method 분리) 수동 cycle 9+ script-only 자동화. 3 컴포넌트 hybrid (v6.4/v6.5 패턴 정합 — facing 대상만 다름 = orchestrator) — `scripts/audit_fact_verify.py` (deterministic core, ~250 LOC, stdlib only re+json+pathlib, BOOLEAN_LOOKUP callable lookup 5 evidence-base 항목 + 표 schema column 매핑 + NUMERIC_LOOKUP empty no-op fallback) + `agents/project-harness-audit-team/CLAUDE.md` Note v6.6 신규 (Step 6 synthesizer step + 4 agent 표 column 본질 명시 + 인용 method 후속 narrative) + `tests/smoke-audit-fact-verify.sh` (fixture-based read-only, 6 sub-dir + path traversal Stage 5). 자율 범위 = 검출 only (자동 정정 부재 — 재귀 hallucination 위험 차단 + 사용자 결정 게이트 보존, R1 결정).
- **smoke-audit-fact-verify.sh 신규 도입** — pre-commit hook 11건째 등재 (`scripts/audit_fact_verify.py` + smoke 자체 + `tests/fixtures/audit-fact-verify/.*\.md$` trigger). 7 stage PASS = boolean × 2 + table × 2 + numeric + empty + Stage 5 path traversal 차단.
- **ARCHITECTURE § 4 끝 매트릭스 #10 row 와 paragraph 본문 정전화** — audit chain hallucination 자동 검출 mechanism 사용법 + 책임 분리 narrative + 인용 method oos_2 + Agent SDK json_schema 미채택 사유 + 외부 spec 부재 자기 정전화 narrative. explicit `<a id="section-4-end-row-10">` anchor.
- **tests/fixtures/audit-fact-verify/ 6 fixture sub-dir 신규** — cycle 1~3 evidence 모방 (boolean-normal/boolean-mismatch/table-normal/table-mismatch/numeric-normal/empty-targets). audit chain 4 agent 산출물 모방 (scanner-output.md / mapper-output.md).
- **audit-team CLAUDE.md Step 6 sequence 추가** — synthesizer fact verify (orchestrator script invoke, subagent 부재). v4.0 5 단계 → 6 단계. agent fleet matrix 5 행 유지 (deterministic execution).
- **CHANGELOG [v6.6] entry** — release note 동치 외부 visible artifact (Keep a Changelog v1.1.0 정합).

### Changed

- **.pre-commit-config.yaml smoke-audit-fact-verify hook 등재** — local 10 → 11 hook. 총 pre-commit hook 17 → 18.
- **tests/CLAUDE.md cascade** — active 10→11 caption + smoke-audit-fact-verify row + 현행 hook 표 v6.6 11 row.
- **root CLAUDE.md 안 audit-fact-verify cascade marker 인용 도그푸드** — `### audit chain hallucination 자동 검출 (v6.6+)` sub-section + marker comment (expected-hash 자동 갱신) + 1 줄 blockquote. cycle 32 self-host (mechanism 도입 milestone 안 mechanism 자체 적용).
- **harness-meta.md `--audit` 분기 Step 6 narrative 추가** — `python scripts/audit_fact_verify.py --dir <audit-output>` 자동 호출 + v5.13/v5.16/v5.18 절차 정합 + R1 결정 정합 (검출 only).
- **agents/project-harness-audit-team/CLAUDE.md Note v6.6 추가** — v5.13 + v5.16 + v5.18 누적 4번째. 자동 mechanism 본질 + 표 schema 표준화 의무 (D3 4 agent column) + 인용 method 후속 narrative.
- **ROADMAP milestones[] archival v6.3 entry** — schema A2 recent 3 정합 (v5.21 도입 archival cycle 6번째 사례). CHANGELOG [v6.3] entry 안 보존.
- **ROADMAP candidate_draft[0] 삭제** — v6.5 phase-2 도그푸드 append entry 가 next_candidates[3] 와 중복 → Stage A entry 시 candidate_draft[0] 삭제 결정 (사용자 명시 선택). v6.5 lessons 후보 (dedup 의무) = 별 milestone PROPOSE 거명.

### Documented

- **AI Native § 7.1 '다중 AI 협업' 면 second cycle** — v6.4 cascade-sync (첫 번째: narrative 정전화 3 단계 패턴 (b) 자동화) 후속 = audit chain hallucination 자동 검출 (v5.13/v5.18 절차 자동 실행).
- **v3.21 narrative 정전화 3 단계 패턴 cycle 32 self-host** — mechanism 도입 milestone 안 mechanism 자체 적용 = root CLAUDE.md marker + ARCHITECTURE § 4 끝 #10 paragraph cascade.
- **v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 7번째 자연 발현** — D12 외부 spec 안 first-class 'audit chain fact verification' 패턴 부재 → 자기 정전화 자연 (context7 evidence = code-reviewer + Agent Hook for Test Verification 2종만). v4.2+v5.6+v6.2+v6.3+v6.4+v6.5+v6.6 누적.
- **archival cycle 6번째 사례** — v6.3 entry CHANGELOG archival 흡수, ROADMAP milestones[] recent 3 = v6.6 + v6.5 + v6.4 (schema A2 정합).
- **5 관점 subagent 병렬 검토 cycle 5 evidence** — 18건 (P1 7 + P2 11), v6.4 (38건) → v6.5 (32건) → v6.6 (18건) 누적 converged trend. feedback_subagent_parallel_review_evidence cycle 5 누적.
- **audit chain hallucination cycle 4 자체 정전화** — v5.10 (component-proposer 12 항목 표) + v5.11 (project-scanner boolean) + v5.12 (mapper bundled-skill 오분류) + v6.5 (외부 vector P1#1 fact 부재) = cycle 4 direct evidence. v5.13/v5.18 수동 절차 → v6.6 script-only 자동 검출 진화.

## [v6.5] - 2026-05-20

### Added

- **Claude 자율 milestone 발의 mechanism 신규 도입** — AI Native § 7.1 '자율성' 면 첫 실 적용 (v6.0 INTENT.oos_4 origin). v6.4 cascade-sync hybrid 패턴 정합 3 컴포넌트 — `scripts/propose_next.py` (deterministic core, ~190 LOC, argparse `--scan`/`--list-candidates` read-only, 1차 디렉토리 enumerate semver desc 최근 5 + 2차 ROADMAP/CHANGELOG cross-validate, input validation 3축 length/charset/path traversal + JSON round-trip self-check + fixed argument list) + `claude/commands/propose-next.md` (slash command UX orchestrator, LLM prompt 5-step + 최우선 1건 우선 보고 + 비유 표현 가이드 D12) + `tests/smoke-candidate-draft-schema.sh` (read-only schema validation 단일 책임). 자율 범위 = candidate 제안까지만 (사용자 결정 게이트 보존, 스무고개 방식 milestone 결정 선호 자연 부합).
- **smoke-candidate-draft-schema.sh 신규 도입** — pre-commit hook 10건째 등재 (`ROADMAP\.md$` trigger). 단일 책임 = ROADMAP `candidate_draft[]` 안 7 필드 (id/title/source/detected_at/rationale/category/decision_pending) 강제 + category enum 2 값 (`internal_synthesis`|`benchmark_external`) 강제. python3 부재 시 SKIP exit 0 (환경 가드) + SIZE_LIMIT 100KB FAIL.
- **ARCHITECTURE § 4 끝 매트릭스 #9 row와 paragraph 본문 정전화** — Claude 자율 milestone 발의 mechanism 사용법 + 책임 분리 narrative + category enum 2 값 분리 명시 + 자율 범위 정의. explicit `<a id="section-4-end-row-9">` anchor.
- **ROADMAP schema_note candidate_draft entry schema 정전화** — 7 필드 정의 + category enum 2 값 + smoke 자동 강제 narrative.
- **CHANGELOG [v6.5] entry** — release note 동치 외부 visible artifact (Keep a Changelog v1.1.0 정합).

### Changed

- **.pre-commit-config.yaml smoke-candidate-draft-schema hook 등재** — local 9 → 10 hook. 총 pre-commit hook 16 → 17.
- **tests/CLAUDE.md cascade** — active 9→10 caption + smoke-candidate-draft-schema row + 현행 hook 표 v6.5 10 row.
- **root CLAUDE.md 안 자율 발의 cascade marker 인용 도그푸드** — `### Claude 자율 milestone 발의 (v6.5+)` sub-section + marker comment + 1 줄 blockquote. cycle 30 self-host (mechanism 도입 milestone 안 mechanism 자체 적용).
- **bootstrap/agents/CLAUDE.md cascade narrative 갱신** — v4.0 phase-7 벤치마크 cycle narrative + v6.5 자율 발의 mechanism 두 본질 공존 명시. v4.0 sub-classification 3축 = `benchmark_external` enum 값의 세부 분류 흡수.
- **ROADMAP candidate_draft[] A1 1건 append 도그푸드** — `audit-chain-hallucination-auto-correction` (target_version v6.6, category internal_synthesis) entry. mechanism 자체 1 회 호출 결과 첫 실 작동 evidence + 사용자 검토 대기 staging area.
- **ROADMAP milestones[] archival v6.2 entry** — schema A2 recent 3 정합 (v5.21 도입 archival cycle 5번째 사례). CHANGELOG [v6.2] entry 안 보존.

### Documented

- **AI Native § 7.1 '자율성' 면 첫 실 적용** — v6.0 정의 → v6.1 컨텍스트 효율 cycle 1 → v6.2 cycle 2 → v6.3 Verification 첫 실 적용 → v6.4 다중 AI 협업 첫 실 적용 → v6.5 자율성 첫 실 적용. Claude 능동 발의 + 사용자 최종 결정 = AI native 협업 본질.
- **v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 6번째 자연 발현** — v4.2 + v5.6 + v6.2 + v6.3 + v6.4 + v6.5 누적. smoke-candidate-draft-schema 도입 narrative 안 자체 인용.
- **v3.21 narrative 정전화 3 단계 패턴 cycle 30 self-host** — mechanism 도입 milestone 안 mechanism 자체 적용 = root CLAUDE.md marker + ARCHITECTURE § 4 끝 #9 paragraph cascade.
- **v3.21 narrative 정전화 3 단계 패턴 cycle 31 cascade-sync 결합** — v6.4 mechanism 자체가 v6.5 narrative cascade 안 첫 실 작동. drift 자동 detect (placeholder 0000 vs actual 5af4794bf53712fa) → `--apply` 호출 → hash 자동 갱신 → smoke 자동 PASS. v6.4 × v6.5 두 cycle 결합.
- **audit chain hallucination cycle 4 자연 발현 inline 정정** — 5 관점 외부 vector agent P1#1 ('v4.0/PROPOSE.md:54 category fleet-evolution 명시' 주장) → grep 검증 결과 v4.0/PROPOSE.md 안 `category` 0 매치 fact 부재. memory feedback_subagent_fact_hallucination_correction direct evidence cycle 4 (cycle 1 v5.10 / cycle 2 v5.11 / cycle 3 v5.12). v5.13/v5.18 fact 검증 절차 4번째 실전.
- **archival cycle 5번째 사례** — v6.2 entry CHANGELOG archival 흡수, ROADMAP milestones[] recent 3 = v6.5 + v6.4 + v6.3 (schema A2 정합).
- **5 관점 subagent 병렬 검토 cycle 4 evidence** — 32건 (P1 12 + P2 20), v6.4 (38건) 대비 0.84배 converged trend 유지. feedback_subagent_parallel_review_evidence cycle 4 누적.
- **scan 작업 도그푸드 본질 정전화** — phase-2 본질 = scan mechanism 작동 검증 (도그푸드) 자체. candidate 결정 자체는 사용자 차후 review, mechanism 호출/출력/LLM summary/사용자 응답 cycle 작동 evidence 가 1차.

## [v6.4] - 2026-05-20

### Added

- **cascade 자동 동기 mechanism 신규 도입** — v3.21 narrative 정전화 3 단계 패턴 (b) EXECUTE Edit cascade 단계 수동 cycle (v3.18~v6.3 누적 28+) 자동화. `scripts/cascade_sync.py` (deterministic core, ~220 LOC, argparse `--check`/`--apply` + enumerate + hash compare + edge case a-f + path traversal 차단 + HTML escape 차단 + external URL skip + anchor → paragraph 매핑) + `claude/commands/cascade-sync.md` (slash command UX orchestrator, LLM prompt 5-step + Bash tool fixed argument) + `tests/smoke-cascade-drift.sh` (delegate to script `--check`, read-only drift detect). marker format `<!-- cascade-source: <path>#<anchor> expected-hash:<16-hex> -->` = 본 repo 자체 컨벤션.
- **smoke-cascade-drift.sh 신규 도입** — pre-commit hook 9건째 등재 (`.md$` trigger, 16번째 hook). `--apply` 갱신 책임은 scripts/cascade_sync.py 단독, smoke 는 read-only.
- **ARCHITECTURE § 4 끝 매트릭스 #8 row 와 paragraph 본문 정전화** — cascade sync mechanism 사용법 + 책임 분리 narrative + '자동' 두 의미 분리 + marker format 자체 컨벤션 명시. explicit `<a id="section-4-end-row-8">` anchor.
- **CHANGELOG [v6.4] entry** — release note 동치 외부 visible artifact (Keep a Changelog v1.1.0 정합).

### Changed

- **`.pre-commit-config.yaml` smoke-cascade-drift hook 등재** — local 8 → 9 hook. 총 pre-commit hook 15 → 16. INTENT sc_4 narrative inline 정정 (v6.3 narrative "11→12" + 본 초안 "12→13" 모두 mismatch → 실 15→16 fact 검증).
- **tests/CLAUDE.md cascade** — L7 'active 8→9' caption + 핵심 정책 검증 표 smoke-cascade-drift row + 현행 hook 표 v6.4 9 row.
- **root CLAUDE.md 안 cascade marker 인용 도그푸드** — `### cascade 자동 동기 (v6.4+)` sub-section + marker comment + 1 줄 blockquote (≤ 4 줄 정합, claude-md-drift S3 안전). cycle 29 self-host (mechanism 도입 milestone 안 mechanism 자체 적용).

### Documented

- **AI Native § 7.1 '다중 AI 협업' 면 첫 실 적용** — v6.0 정의 → v6.1 컨텍스트 효율 cycle 1 → v6.2 cycle 2 → v6.3 Verification 첫 실 적용 → v6.4 다중 AI 협업 첫 실 적용. 1 AI (orchestrator) + script (deterministic) 협업 cycle 자동화.
- **v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 5번째 자연 발현 cycle** — v4.2 + v5.6 + v6.2 + v6.3 + v6.4. RESEARCH ext_1-3 context7 query 안 Anthropic Claude Code spec 표준 cascade marker / dependency tracking 패턴 0건 → marker format 본 repo 자체 컨벤션 즉시 정전화.
- **5 관점 subagent 병렬 검토 cycle 4 evidence** — pass-with-comments × 5 / decisive 0 / P1 11 + P2 27 = v6.3 (35건) 대비 1.09배 안정. feedback_subagent_parallel_review_evidence cycle 4 누적 evidence (cycle 1 6 → cycle 2 20 → cycle 3 35 → cycle 4 38).
- **archival cycle 4번째 사례** — v6.1 entry CHANGELOG archival 흡수, ROADMAP milestones[] recent 3 = v6.4 + v6.3 + v6.2 (schema A2 정합, v5.21 도입 cycle 4 = v6.2 + v6.3 + v6.4).
- **v3.21 narrative 정전화 3 단계 패턴 cycle 29 (self-host)** — mechanism 도입 milestone 안 mechanism 자체 적용 = root CLAUDE.md marker + ARCHITECTURE § 4 끝 #8 paragraph cascade. 자기참조 cycle 첫 자동화 적용.
- **EXECUTE inline fact 검증 lessons** — pre-commit hook count fact mismatch (v6.3 narrative + INTENT 초안 모두 부정확) 인지 + 실 측정 정정. v5.11 fact 검증 의무 패턴 self 검증 첫 명시 사례.

## [v6.3] - 2026-05-20

### Added

- **smoke-entry-title-guideline.sh 신규 도입** — ARCHITECTURE § 7.2 entry title 가이드 4 원칙 중 (1) 한 entry = 한 본질 ' + ' literal space + lookbehind/lookahead non-whitespace P1 mechanical proxy + (2) ≤ 60자 Python len() codepoint 자동 강제. (3) Active form + (4) Detail summary 분리 = AI 판단 위임 (자동 검증 제외). pre-commit hook 8건째 등재 (CHANGELOG.md trigger 첫 도입).
- **smoke 자동 강제 narrative § 7.2 paragraph 정전화** — '(1)+(2) auto / (3)+(4) AI 판단 위임' 단일 source. enumerate scope = projects/*/ROADMAP.md milestones/next_candidates/candidate_draft title 필드 + CHANGELOG.md bullet bold header.
- **CHANGELOG [v6.3] entry** — release note 동치 외부 visible artifact (Keep a Changelog v1.1.0 정합).

### Changed

- **entry title corrective 일괄 정정 — 3 source 총 41건** — meta ROADMAP 4건 + upbit ROADMAP 15건 + CHANGELOG bullet 21건 + 잔존 3건 미세 정정 (61자 → 56자 이하). title 만 retitle, id 보존 (cascade scope 자연 한정). milestone 산출물 (REPORT.md / milestones.md / MILESTONE.md frontmatter) historical artifact 동결.
- **tests/CLAUDE.md cascade** — L7 'active 7→8' caption + smoke 매트릭스 row 추가 (smoke-entry-title-guideline) + 현행 hook 표 8 row + v6.3 phase narrative.
- **.pre-commit-config.yaml** — smoke-entry-title-guideline hook 등재 (local 7→8). files: `ROADMAP\.md$\|projects/.*/ROADMAP\.md$\|CHANGELOG\.md$` (3 smoke trigger overlap = 책임 직교, CHANGELOG-trigger 첫 도입).

### Documented

- **AI Native § 7.1 'Verification' 면 첫 실 적용** — v6.0 정의 → v6.1 컨텍스트 효율 cycle 1 → v6.2 cycle 2 → v6.3 Verification 면 첫 milestone. Constraint 면과 직교.
- **v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 4번째 자연 발현 cycle** — v4.2 + v5.6 + v6.2 + v6.3. RESEARCH ext_2/ext_3 안 Conventional Commits 50/72 부재 + Keep a Changelog over-claim 즉시 정정.
- **5 관점 subagent 병렬 검토 cycle 2 evidence** — pass-with-comments × 5 / decisive 0 / P1 21 + P2 14 = v6.2 (20건) 대비 1.75배. feedback_subagent_parallel_review_evidence 확장.
- **archival cycle 3번째 사례** — v6.0 entry CHANGELOG archival 흡수, ROADMAP milestones[] recent 3 = v6.3 + v6.2 + v6.1 (schema A2 정합, v5.21 도입 cycle 3 = v6.2 도그푸드 + v6.3 = cycle 4).
- **v3.21 narrative 정전화 3 단계 패턴 cycle 28** — (1) DESIGN 1차 source + (2) EXECUTE Edit + (3) VERIFY grep. 본 milestone 본질 = mechanism creation 1차 + narrative 정전화 cascade 2차 (사이드 effect).

## [v6.2] - 2026-05-19

### Changed

- **milestone 산출물 디렉토리 평탄화 — 9-stage-flattened era 도입** — 1 milestone 디렉토리 = `MILESTONE.md` 단일 본책 (YAML frontmatter 4 필드 + H2 9 섹션 = `## INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE/SUB_MILESTONES`) + `execute/phase-{n}.md` 별책 (b) 하이브리드 채택. (1) v6.2~ 신규만 적용 — v3.0~v6.1 28 active milestone 디렉토리 era 보존 (forward-only 정책 정합, era 분기 자연 확장). AI 1 Read 으로 milestone 전체 흡수 (AI Native § 7.1 컨텍스트 효율 면 cycle 2). pre-PLAN 6 round 결정.
- **`tests/_era_detect.py` 9-stage-flattened 신규 분류** — 검사 순서 우선 (MILESTONE.md 존재 첫 검사, milestones.md 보다 우선). phase-2 retrofit 일시 동시 존재 케이스 deterministic 보장 (D6).
- **smoke 4종 era 분기** — spec-verification (H2 grep + JSON 추출, 8 stage 분기 모두 정합) / scope-contract (`extract_json(fp, h2_name=None)` 시그니처 확장 + era 분기) / bundle-trigger (regex era 양립 `^milestones/(_archive/)?v[0-9]+\.[0-9]+/(MILESTONE\.md(#sub-milestones)?\|milestones\.md)$` + anchor strip 로직) / open-stage-discipline (페어링 양립 — MILESTONE.md OR milestones.md).
- **cascade 12 host 정전화** (v3.21 narrative 3 단계 패턴 cycle 27) — `ARCHITECTURE.md` § 6.1 표 5 row + flattened era paragraph + `CLAUDE.md` (root + projects/meta + claude + tests) + `claude/commands/harness-meta.md` + `_era_detect.py` + smoke 4종 + smoke-posttooluse-hook (Test W) + post-report-write hook (narrative + grep).
- **YAML frontmatter 4 필드 reduction** — bundled era 5 필드 (id/title/version/stage/status) → flattened era 4 필드 (id/title/version/status). stage 필드 제거 = milestone-level 통합 표지 (H2 섹션 자체가 stage 표지, D3).

### Added

- **`post-report-write.sh` MILESTONE.md NOOP grep 패턴** — `projects/[^/]+/milestones/v[^/]+/MILESTONE\.md$` 매칭 시 NOOP (milestones.md 패턴 정합, D8). flattened era hook trigger 부재 = 사용자 manual PROPOSE 진행 (단순함 우선).
- **`tests/_inactive/smoke-posttooluse-hook.sh` Test W** — Write + MILESTONE.md → NOOP {} 검증 (25→26 checks, architecture P1 #2).

### Documented

- **5 관점 subagent 병렬 검토 패턴** — architecture (Plan agent) + spec-drift / regression / security / dictionary-semantics (general-purpose 4건) 병렬 호출. 결과: pass-with-comments × 4 + pass × 1 / decisive 0 / P1 11 + P2 9 모두 흡수. v6.1 inline self-review (P1 5 + P2 1) 대비 P1+P2 누적 2.4배 증가 — 객관 검토자 가치 evidence.
- **v3.21 narrative 정전화 3 단계 패턴 cycle 27 도그푸드 완성** — phase-1 schema 정전 (ARCHITECTURE § 6.1 paragraph) + phase-2 자체 retrofit (MILESTONE.md 단일 통합) + VERIFY grep drift 0.
- **archival cycle 적용** — v5.21 entry → CHANGELOG 보존, ROADMAP `milestones[]` 제거 — recent 3 = v6.2 + v6.1 + v6.0 (schema A2 정합, v5.21 도입 cycle 3번째 사례).
- **atomic commit N:1 매핑 narrative 정전화 (source hash 포함)** — phase-2 retrofit (git rm 5건 + git add MILESTONE.md = 단일 commit) 안 commit 메시지 source 5 파일 phase-1 hash (059206c) 인용 = git history 추적 보존 패턴 (D17, architecture P1 #3 + regression P1 #2 cross-cover).

## [v6.1] - 2026-05-19

### Changed

- **milestone 산출물 schema = Anthropic 정합 하이브리드** — YAML frontmatter (id/title/version/stage/status, 5 필드) + 축소 JSON 코드 블록 (smoke 강제 필드만, id/title 제거) + Markdown body (motivation/dependencies/risk_mitigation 등 자연어 흡수). C4 옵션 채택 (DESIGN D1). context7 외부 source 직접 정합 × 2 (Anthropic sub-agent + plugin agent 패턴, RESEARCH ext_2/ext_3).
- **smoke-spec-verification.sh 자동 식별** — extract_frontmatter() 함수 신규 (PyYAML 의존 없음, regex + line split) + check_json_fields() 자동 분기. 신규 schema (frontmatter 존재) = frontmatter id/title/version/stage/status 검증 + JSON id/title 자동 제외. 현 schema (부재) = backward compat 보존.
- **active 28 milestone backfill** — meta v4.0~v4.3 + v5.0~v5.21 + v6.0 (27) + upbit v1.4 (1) × ~6-7 artifact = 189 artifact migrated. scripts/v6_1_migrate.py 임시 (사용 후 삭제, D6 정합). 정량: JSON top 32.3→13.9 (-57.1%, sc_1 ✓) + nested 106→60.1 (-43.3%, sc_1 ACK 미충족) + YAML +34.5.
- **cascade 5 host 정전화** (v3.21 narrative 3 단계 패턴 cycle 26) — `CLAUDE.md` § '구조 규칙' + `projects/meta/ARCHITECTURE.md` § 3.3 Workflow + `claude/commands/harness-meta.md` 9-stage 안내 + `AGENTS.md` 영문 2 위치 + `tests/CLAUDE.md` smoke-spec-verification 설명.
- **markdownlint config** — MD025 `front_matter_title: ""` 비활성 (frontmatter title + 본문 H1 공존 허용) + MD037 비활성 (underscore 식별자 emphasis 오인 회피, `tests/_inactive/` 등 path 보존).

### Documented

- **pre-PLAN 7-round dialog 패턴 누적 evidence** — 후보 선택 / 감축 기준 / 적용 범위 / 유지 필드 / 디렉토리 분리 / DESIGN 옵션 / APPROVE. memory `feedback_iterative_pre_plan_review` 정합. 비개발자 친화 (memory `user_non_developer_role`) + 스무고개 방식 (`feedback_iterative_dialog`) 정합.
- **v3.21 narrative 정전화 3 단계 패턴 cycle 26 도그푸드 완성** — (a) DESIGN D8 1차 source + (b) EXECUTE phase-2 Edit + (c) VERIFY grep drift 0.
- **archival cycle 적용** — v5.21 도입 cycle 의 2번째 사례 (v5.20 entry → CHANGELOG 보존, ROADMAP `milestones[]` 제거 — recent 3 = v6.1 + v6.0 + v5.21).

## [v6.0] - 2026-05-19

### Added

- **AI Native 운영 § 7 신규 (정의/3면 매트릭스/entry title 가이드)** — `projects/meta/ARCHITECTURE.md` § 7 'AI Native 운영' 신규 정전화: §§ 7.1 정의 + 3 면 매트릭스 (컨텍스트 효율 + 자율성 + 다중 AI 협업) + v4.0 정체성 cross-ref (책임/결과물 ↔ 운영원칙/운영방식 두 차원 직교 보완) + §§ 7.2 Entry title 가이드 4 원칙 hardcode (한 entry = 한 본질 / ≤60자 / active form / detail은 summary로). 기존 § 7 (관련 문서) → § 8 shift. § 3.1 끝 paragraph 안 신규 § 7 backward cross-ref 추가 (양방향 정합).

### Changed

- **ROADMAP/CHANGELOG 4+3 retitle (self-dogfood)** — `projects/meta/ROADMAP.md` milestones[] 4 entry (v6.0 self-dogfood + v5.21 + v5.20 + v5.19) title 가이드 4 원칙 정합 retitle (각 84~175자 → 32~52자). milestone artifact 4건 (INTENT/RESEARCH/DESIGN/milestones.md) title field 동기 갱신. CHANGELOG.md 안 [v5.21]/[v5.20]/[v5.19] bullet header 동기 retitle. v6.0 entry title self-dogfood — 본 milestone 자체가 가이드 4 원칙 정합 (~32자).
- **v6.0 첫 원안 폐기 → AI Native 운영 reframe** — 첫 원안 (9-stage 자동 전환 + per-stage 최소 권한 원칙 PoLP) 은 Stage E 직전 사용자 명시 결정 게이트 안 취소. round 안 사용자 비개발자 명시 + 스무고개 방식 선호 발의 (memory `user_non_developer_role` + `feedback_iterative_dialog` 신규 정전화). 본 milestone trace = git log 부재 (commit 부재) + INTENT.dep_5 narrative.
- **cascade 6 host narrative 동기** — root CLAUDE.md / projects/meta/CLAUDE.md / AGENTS.md / README.md / projects/meta/ROADMAP.md schema_note ('entry title 가이드 § 7.2 참조' cross-ref) / 본 CHANGELOG entry. v3.21 narrative 정전화 3 단계 패턴 cycle 25 도그푸드.
- **ROADMAP archival cycle — v5.19 entry ROADMAP 제거** — v5.21 archival 패턴 두 번째 적용. recent 3 = v6.0 + v5.21 + v5.20 보존 (in_progress 1 + completed 2 + deferred 3 = milestones[] length 6). v5.19 entry CHANGELOG.md 이미 보유 (v5.21 archival 시 작성) — 본 milestone 안 작업 = ROADMAP entry 제거 만 (DESIGN.D12 명료화).

## [v5.21] - 2026-05-19

### Added

- **CHANGELOG.md v5.7 ~ v5.20 14 entry backfill** — 누락 14 entry 역순 삽입 (Keep a Changelog v1.1.0 정합). 분류 = Changed 6 (audit cycle 5건 + narrative cleanup 1건) + Added 6 (신규 산출물 4건 — v5.10/v5.13/v5.16/v5.18 + 정전화 2건 — v5.7/v5.8) + Fixed 2 (hallucination cycle 정정 — v5.11/v5.12). DESIGN.D9.category_mapping_rule 정합.
- **ROADMAP `next_candidates[]` 별도 필드 신규** — schema A2 — `{id, title, trigger, origin_milestone, target_version, description}` entry. validation regex hardcode = id `^[a-z0-9-]+$` + target_version `^v[0-9]+\.[0-9]+$` (DESIGN.D2.schema_validation_pattern_source). v6.0_workflow-automation-and-least-privilege 거명.

### Changed

- **ROADMAP forward-looking 재정의 (CHANGELOG archival 흡수)** — `projects/meta/ROADMAP.md` schema A2 재설계: `milestones[]` = recent 3 completed + in_progress + deferred only (length 7) + `next_candidates[]` 별도 필드 신규 (PROPOSE 발의 후보, length ≥ 1). 과거 completed entry 41건 (v5.17 ~ v1.0_workflow-redesign) → CHANGELOG.md archival 이전 (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill 패턴). ROADMAP 사전적 의미 (이정표 = forward-looking) 부합도 ~30~40% → ~95%+ 도달. § 4 끝 #3 narrative 본질 변경 (drift 수용 → drift 해소 첫 evidence-base trigger 사례). PROPOSE drift 70% → ~90% 부분 자연 해소 (등재 위치 명료화, 단 register 책임 분리 아님). v3.21 narrative 정전화 3 단계 패턴 cycle 23 도그푸드. v6.0_workflow-automation-and-least-privilege 별 milestone 예약 (next_candidates[]).
- **commands/harness-meta.md archival cycle 절차 (Stage A/I)** — Stage A in_progress entry 추가 narrative + Stage I `next_candidates[]` 등재 + archival cycle 신규 step 3 (completed > 3 시 CHANGELOG 이전, DESIGN.D11). PROPOSE register 책임 분리 아님 명시.
- **claude/hooks/post-report-write.sh L173 PROPOSE 메시지 갱신** — `ROADMAP milestones[] 에 status:pending 등록` → `ROADMAP next_candidates[] 필드에 등재 (v5.21+ schema A2) + archival cycle`. (smoke-posttooluse-hook 가 `tests/_inactive/` 거주 = pre-commit 자동 차단 부재, 수동 검증 권고).
- **tests/smoke-bundle-trigger.sh L93 deferred 분기 추가** — `status in ("pending", "deferred")` 시 milestones_path 검증 skip (v1.x flat era deferred entry 자연 보존).
- **cascade 7 host narrative 동기** — root CLAUDE.md L33 + L60 (workflow 단어 책임 표 ROADMAP row + schema entry) / bootstrap/agents/CLAUDE.md L198 (next_candidates[] 정식 등재) / projects/meta/ARCHITECTURE.md (L91 Trace mechanism + § 4 끝 #2/#3 paragraph + L165 bundling schema entry).

자세히: [`projects/meta/milestones/v5.21/REPORT.md`](projects/meta/milestones/v5.21/REPORT.md).

## [v5.20] - 2026-05-19

### Changed

- **audit cycle 7 — § 4 매트릭스화 / namespace cascade** — stability cycle 두 번째 완성 (cycle 5+6+7 동일 upbit baseline + R1+R2 3 cycle 연속 APPLIED + 신규 proposal 0건 converged). v5.19 PROPOSE#4+#8 + spec-drift D1 동시 흡수. § 4 끝 매트릭스 (7 narrative paragraph) 신규 + L135 vector count 6→7. agent namespace prefix cascade 7 위치 (Plugin spec v5.0+ namespace 정합). hallucination 2건 mapper origin + cascade inline 정정. narrative effect isolation 한계 첫 확인. v3.21 narrative 정전화 3 단계 패턴 cycle 21+22 도그푸드. 4 commit / 7 lessons. 자세히: [`projects/meta/milestones/v5.20/REPORT.md`](projects/meta/milestones/v5.20/REPORT.md)

## [v5.19] - 2026-05-19

### Changed

- **audit cycle 6 — Input Verification 효과 검증** — upbit cycle 6 + v5.18 Input Verification H2 sub-section + 검증 method 분리 narrative 첫 실전 + stability cycle 첫 완성 (cycle 5+6 사이 upbit commit 0 + R1+R2 2 cycle 연속 APPLIED + 신규 gap 2 cycle 연속 0건). hallucination 0건 (혼합 origin, 분리 evidence cycle 7+ 필요). MD034 11건 inline 정정 (mapper-output.md). ecosystem integrator vector 6건 누적. self-loop monotonic 감소 (78.3% → 76%, 19/25). v3.21 cycle 19+20 도그푸드. 2 commit / 7 lessons. 자세히: [`projects/meta/milestones/v5.19/REPORT.md`](projects/meta/milestones/v5.19/REPORT.md)

## [v5.18] - 2026-05-18

### Added

- **audit chain agent prompt Input Verification H2 신규** — Read tool 보유 멤버 (scanner / harness-gap-analyzer) 직접 Read 의무 / Read tool 부재 멤버 (claude-docs-mapper / component-proposer) D10 우회 패턴 = orchestrator inline 첨부 본문 직접 인용. v5.13 절차 정전화 2 위치 안 '검증 method 분리 (boolean/표/수치 별 매핑 method)' sub-narrative 흡수. v5.17 PROPOSE#1+#4 통합 (audit chain hallucination cycle 9 누적 trigger). v3.21 cycle 19 도그푸드. 1 phase 통합 commit (2e44260, 8 파일 72+/2-). 7 lessons. 자세히: [`projects/meta/milestones/v5.18/REPORT.md`](projects/meta/milestones/v5.18/REPORT.md)

## [v5.17] - 2026-05-18

### Changed

- **audit-team 외부 호출 cycle 5** — upbit cycle 5 + v5.15 cycle 4 diff + v5.16 lint precheck 절차 첫 실전 적용 + v5.13 fact 검증 절차 세 번째 실전 (cycle 7+8+9 = 8건 inline 정정). ecosystem integrator vector 5건 누적. v1.20 R1+R2 stability. self-loop 78.3% (monotonic 감소). v3.21 cycle 18 도그푸드. 2 commit / 7 lessons. 자세히: [`projects/meta/milestones/v5.17/REPORT.md`](projects/meta/milestones/v5.17/REPORT.md)

## [v5.16] - 2026-05-18

### Added

- **audit chain markdown lint precheck 절차 정전화** — audit chain 산출물 산출 4 멤버 (project-scanner/harness-gap-analyzer/claude-docs-mapper/component-proposer, D8 Step 1~4) markdown 산출물의 markdownlint MD022 (blanks-around-headings) + MD031 (blanks-around-fences) + MD032 (blanks-around-lists) 3 rule 위반 사전 방지 절차 narrative 정전화. v5.13 3-layer cross-ref 구조 패턴 정합 (Layer A § 4 끝 paragraph + Layer B D8 Note v5.16 + Layer C --audit step). v5.15 PROPOSE#2 carry-over (v5.14 L7 + v5.15 L5 누적 2 사례). v3.21 cycle 17 도그푸드. lightweight 12/30 = 40% 첫 돌파. 1 phase 2 commit (be138c2 + 55c6dfa). 7 lessons. 자세히: [`projects/meta/milestones/v5.16/REPORT.md`](projects/meta/milestones/v5.16/REPORT.md)

## [v5.15] - 2026-05-18

### Changed

- **audit-team 외부 호출 cycle 4** — upbit cycle 4 + v5.14 cycle 3 diff + v5.13 fact 검증 절차 두 번째 실전 적용. ecosystem integrator vector 4건 누적 = self-loop 카운팅 정전화 (17/21=81% 정확 누적). 4 산출물 + diff-vs-cycle3 (v1.19 apply 4 항목 효과 검증 sub-section). v1.20 milestone trigger candidate. v3.21 cycle 16 도그푸드. 7 lessons. 자세히: [`projects/meta/milestones/v5.15/REPORT.md`](projects/meta/milestones/v5.15/REPORT.md)

## [v5.14] - 2026-05-18

### Changed

- **audit-team 외부 호출 cycle 3 — v5.13 fact 검증 절차 첫 실전** — upbit cycle 3 + v5.10 audit diff. v5.13 3-layer 정전화 절차 첫 실전 = 4 산출물 안 총 5건 hallucination inline 정정 (scanner 1 + mapper 1 + proposer 3). gap: G1(stale cp 지속) / G2(CLAUDE.md symlink narrative 신규) / G3(session-init hook 지속) / S2(spike-investigator 재활성). 사용자 4건 모두 Accept → v1.19 upbit milestone trigger. ARCHITECTURE.md L135 vector count 2건→3건. 2-phase 2 commit (0335d01 + chore). 7 lessons. 자세히: [`projects/meta/milestones/v5.14/REPORT.md`](projects/meta/milestones/v5.14/REPORT.md)

## [v5.13] - 2026-05-18

### Added

- **audit chain fact 검증 절차 3-layer 정전화 (WHAT/WHERE/HOW)** — `claude/commands/harness-meta.md` --audit 분기 proposal-draft 직후 synthesizer fact 직접 검증 step + `agents/project-harness-audit-team/CLAUDE.md` D8 sequence 코드블록 직후 Note (v5.13) + ARCHITECTURE.md § 4 끝 cross-ref append. v5.12 PROPOSE#1 carry-over (cycle 3 evidence 도달). 3 관점 검토 pass_with_comments + blocking 없음. v3.21 cycle 15 도그푸드. 1-phase Lightweight. commit 5d673ba + chore. 7 lessons. 자세히: [`projects/meta/milestones/v5.13/REPORT.md`](projects/meta/milestones/v5.13/REPORT.md)

## [v5.12] - 2026-05-18

### Fixed

- **`/review`·`/security-review`·`/init` Skill invoke 분류 정확화** — v5.10 mapper-output.md L100/L102/L105/L180/L198/L215 6 위치 + diff-vs-v1.17.md L87 = drift origin = audit chain hallucination cycle 3 도달 (cycle 1 v5.10 proposer / cycle 2 v5.11 scanner / cycle 3 본 v5.12 mapper). v5.11 PROPOSE#1 trigger 충족. Stage E APPROVE 5 관점 검토 decisive issue 발견 후 scope 7→9 파일 재정의. hybrid 정정 (inline 4 + footnote 5). v3.21 cycle 14 도그푸드. 1 phase 2 commit (ed3ddbd + 74f99df). 7 lessons. 자세히: [`projects/meta/milestones/v5.12/REPORT.md`](projects/meta/milestones/v5.12/REPORT.md)

## [v5.11] - 2026-05-18

### Fixed

- **audit chain fact 인용 검증 의무 § 4 paragraph 정전화** — memory `feedback_subagent_fact_hallucination_correction` 누적 2 cycle direct evidence 도달 (v5.10 component-proposer 12 항목 표 hallucination + v5.11 project-scanner `claude_md_in_repo: false` hallucination). v5.10 audit chain 4 산출물 안 14 위치 inline 정정 (O1 archive with correction narrative, audit trail 보존). v5.10 PROPOSE#4 entry block stale 표지 + 정정 narrative. v3.21 cycle 13 도그푸드. 1 phase 2 commit (a6fcf4e + chore). 7 lessons. 자세히: [`projects/meta/milestones/v5.11/REPORT.md`](projects/meta/milestones/v5.11/REPORT.md)

## [v5.10] - 2026-05-18

### Added

- **외부 audit-team 두 번째 실 호출 (upbit) § 4 cascade drift** — v5.9 PROPOSE#5 사용자 선택 후 Stage A OPEN 안 v1.17 (2026-05-14) 'first call' 사실 발견 → 'second call + diff' scope 재조정. audit chain 4 멤버 read-only 재호출 (`projects/upbit/audit-2026-05-18/` 안 4 산출물). proposer agent hallucination 1건 → synthesizer overwrite 정정 (L1). v3.21 cycle 12 도그푸드. 2 phase 2 commit (36d364b + 2bd6baa). 7 lessons. 자세히: [`projects/meta/milestones/v5.10/REPORT.md`](projects/meta/milestones/v5.10/REPORT.md)

## [v5.9] - 2026-05-17

### Changed

- **사전적 의미 vs 실 책임 3 축 통합 부합도 audit — § 4 paragraph 정전화** — 축 A (harness-meta name) 77.5% 운용 / 축 B (9-stage) 86.1% baseline (v3.19 baseline 유지) / 축 C (ROADMAP) ~30~40% (v5.21 drift 해소 trigger 1차 source) 진단. ARCHITECTURE § 4 끝 #3 paragraph 정전화 (옵션 B 사용자 명시). lightweight 모드 5 cycle 누적 + v3.21 cycle 11 도그푸드. 2 commit (08b1719 + chore). 7 lessons. 자세히: [`projects/meta/milestones/v5.9/REPORT.md`](projects/meta/milestones/v5.9/REPORT.md)

## [v5.8] - 2026-05-17

### Added

- **v4.0 정체성 ↔ 실 운용 vector drift 진단 — § 3.1 paragraph 정전화** — 12 meta self-loop + 1 외부 v1.17 audit-team 완전 작동 = 92.3% self-loop / sub-metric 가중 평균 77.5% (composer 50% + integrator 60% + maintainer 70%). round 2 RESEARCH 보강 § A1~A9 + round 4 D2 전면 재작성 cascade. lightweight 모드 자기 검토 4번째. v3.21 cycle 10 도그푸드. 1-phase 2 commit (f4fef24 + chore). 7 lessons. 자세히: [`projects/meta/milestones/v5.8/REPORT.md`](projects/meta/milestones/v5.8/REPORT.md)

## [v5.7] - 2026-05-16

### Added

- **spec-drift spike 패턴 ARCHITECTURE § 6 정전화** — v4.2 + v5.6 두 origin 자연 발현 spec-drift spike 패턴 (RESEARCH 추정 → DESIGN 식별 → Stage F spike or DESIGN 즉시 정정 → DESIGN.decisions hardcode 4 단계) ARCHITECTURE.md § 6 본문 안 bold lead paragraph 1건 정전화. v3.21 narrative 정전화 3 단계 패턴 cycle 9 완성. Lightweight + 1-phase 2 commit (da94db7 + ff21e0a). 7 lessons. 자세히: [`projects/meta/milestones/v5.7/REPORT.md`](projects/meta/milestones/v5.7/REPORT.md)

## [v5.6] - 2026-05-14

### Added

- **environment-auditor Stage B 확장 (BP3/BP4 통합 검증 신규)** — Stage B 가 5 sub-step (B0/BP1/BP2/BP3/BP4) 으로 확장. BP3 = `claude plugin list --json` 출력 안 `harness-meta@harness-meta` entry 의 `enabled: true` 검증 (python3/jq parse, regex fallback). BP4 = G AUTO 부분 통합 single sub-step (commands/harness-meta.md 파일 존재 + skills/*/SKILL.md list + @ROADMAP.md grep + projects/meta/CLAUDE.md 파일 존재 + 5 subdir CLAUDE.md list). 10 stage 매트릭스 narrative 보존.
- **environment-auditor Bash 화이트리스트 § 확장** — `claude plugin list` / `claude plugin list --json` (read-only side-effect-free) + `Get-Command claude` (pwsh) / `command -v claude` (bash) D8 fallback 사전 check. `claude plugin details` 채택 회피 (docs 미등재).

### Changed

- **environment-auditor § G 5 항목 책임 표기 추가** — G 5 항목 (G1~G5) narrative 보존 + 각 항목에 'AUTO 부분 (BP4 흡수) + MANUAL 부분 (G 잔존)' 책임 표기. G 본질 = '실 세션 효과 인식, audit 책임 외'. 분류 기준 = audit 책임 (binary 상태 검증) 단일 책임 매핑.
- **D11 disabled 상태 분기 narrative — `/reload-plugins` cross-ref** — `claude plugin disable harness-meta` 후 audit 시 WARN 메시지 + `/reload-plugins` slash command 세션 적용 narrative 흡수 (spec-drift 4 관점 검토 권고).
- **bootstrap/agents/CLAUDE.md L110 cascade drift fix (v5.5 누락)** — environment-auditor 책임 narrative 안 'B Symlink 또는 Junction 무결성' (v5.5 이전 narrative 잔존) → 'B Plugin install + activation 검증 (5 sub-step, v5.5 Plugin 전환 + v5.6 BP3/BP4 신규)' 동기.

## [v5.5] - 2026-05-14

### Changed

- **environment-auditor Stage B — Plugin install 검증으로 전면 교체** — 기존 Stage B (Symlink/Junction 무결성 B1~B6) 를 Plugin install 검증 (B0 cache 존재 + BP1 agents/ + BP2 skills/) 으로 교체. v5.0+ Plugin install 환경에서 실질적 헬스 체크 수행.
- **environment-auditor A1 (Developer Mode 체크) 삭제** — Plugin install 기반으로 Developer Mode 의존 없음 — 불필요한 check 제거.
- **environment-auditor 해결 방안 narrative** — `harness-meta 설치해줘` → `claude plugin install harness-meta@harness-meta` 로 갱신.

### Removed

- **skills/harness-roadmap-update SKILL.md install-skills 행 삭제** — v4.0 에서 폐기된 install-skills 스크립트 패턴 참조 제거.

## [v5.4] - 2026-05-14

### Changed

- **marketplace.json `source: "./"` 현행 유지 결정 (spec 검증)** — context7 Claude Code Plugin spec 재검증: Git repository marketplace (GitHub shorthand + local clone)에서 plugin entry source = `"./"` (relative path)가 spec-correct. GitHub source 객체 (`{ "source": "github", "repo": "..." }`)는 URL-based marketplace 전용 — Git repository marketplace에 적용 부적절. 코드 변경 없음, 결정 근거 milestone 산출물(v5.4 RESEARCH/DESIGN)에 영구 보존.

### Fixed

- **§ 6.2 cross-ref 잔존 drift 해소 (v4.0 cleanup cascade 누락)** — v4.0_harness-composer-pivot 에서 § 6.2 폐지 narrative 도입했으나 active 3 위치 cascade 누락. v5.4 사용자 review 중 발견 → 즉시 fix: `projects/meta/ARCHITECTURE.md` L129 (drift 수용 narrative) + `tests/CLAUDE.md` L9 (smoke 매트릭스 narrative) + L294 (archive narrative). `projects/meta/milestones/v5.4/PROPOSE.md` 신규 작성 안 잘못된 사용도 동시 fix.

## [v5.3] - 2026-05-14

### Added

- **외부 marketplace 등록 — GitHub shorthand onboarding (clone 불요)** — `claude plugin marketplace add pdw96/harness-meta` 를 PRIMARY 설치 경로로 추가. 기존 local clone 경로 (`~/harness-meta`) 는 ALTERNATIVE (로컬 dev / 오프라인) 로 재배치. GitHub shorthand 는 전체 repo clone → `.claude-plugin/marketplace.json` `"source": "./"` 정상 작동 (context7 spec 확인). marketplace.json 변경 없음.
- **cascade 7 파일 갱신** — `README.md` + `AGENTS.md` + `CLAUDE.md` + `agents/component-installer.md` + `bootstrap/agents/CLAUDE.md` + `projects/meta/ARCHITECTURE.md` + `Makefile` 안 install narrative 에 Option A (GitHub shorthand) / Option B (로컬 clone) 병렬 표기 적용.

## [v5.2] - 2026-05-14

### Fixed

- **agents functional audit path stale drift 해소** — `environment-auditor.md` + `harness-gap-analyzer.md` + `component-installer.md` + `bootstrap/claude-code-catalog/README.md` 내부 functional path (glob 대상 경로 + 신규 추가 위치 명시) 갱신. v5.1 Phase 1+2 git mv (agents/ flat + skills/ flat) 후 잔존 stale path 완전 해소. (`bootstrap/agents/audit/`, `bootstrap/skills/{audit,dev-tools}/` → `agents/`, `skills/` 신 위치).

## [v5.1] - 2026-05-14

### Fixed

- **Plugin 구성요소 인식 spec drift 해소** — `claude plugin details` Agents (0) + Skills (1 of 5) 인식 부족 (v5.0 VERIFY R1 drift 직접 후속). agents 필드 제거 (plugin_root `./agents/` default discovery) + skills 필드 `./bootstrap/skills/` → `./skills/` (1단계 flat) — 7 agents + 5 skills 전체 인식.

### Added

- **`agents/` (plugin_root standard location, v5.1+)** — 7 subagent `.md` 파일 `bootstrap/agents/` 에서 1단계 flat 재배치 (git mv). `bootstrap/agents/` = CLAUDE.md narrative-only 컨테이너 보존.
- **`skills/` (plugin_root standard location, v5.1+)** — 5 skill 디렉토리 `bootstrap/skills/{audit,dev-tools}/` 에서 1단계 flat 재배치 (git mv). `bootstrap/skills/` = CLAUDE.md narrative-only 컨테이너 보존.
- **cascade narrative 9 host 갱신** — `bootstrap/{agents,skills}/CLAUDE.md` + `GUARDRAILS.md` + `claude/CLAUDE.md` + `CLAUDE.md (root)` + `AGENTS.md` + `projects/meta/ARCHITECTURE.md § 3.1` + `bootstrap/claude-code-catalog/README.md` + `CHANGELOG.md`.

## [v5.0]! - 2026-05-14

### Breaking changes

- **Install 정책 전면 재설계** — harness-meta repo 자체를 **Claude Code Plugin** 으로 변환. `.claude-plugin/plugin.json` (manifest, paths 명시) + `.claude-plugin/marketplace.json` (local marketplace, source = `.`) 신규. 사용자 onboarding flow 전면 갱신 — 표준 명령 `claude plugin marketplace add ~/harness-meta` + `claude plugin install harness-meta@harness-meta` 채택 (v4.0_harness-composer-pivot ecosystem integrator 정체성 정합 두 번째 major bump).
- **자연어 호출 `~~harness-meta 설치해줘~~` 폐기** (deprecated since v5.0, v5.0+ 환경에서는 비활성) — historical narrative 만 보존. v4.1 D7 mechanical sequence (Backup → OS detect → SymbolicLink/Junction → Copy fallback → Cleanup retention) 도 historical 보존, 신규 환경 안 적용 부재.
- **component-installer agent 책임 분리** — custom component lifecycle (산출물 mechanical apply + plugin.json paths 갱신 + ad-hoc 검증, verifier) 책임 보존 + Plugin install lifecycle (mechanical) Claude Code CLI 위임. D7 sequence 본문은 historical 만 보존.
- **사용자 명시 manual cleanup 권고** — v4.x 환경 안 `~/.claude/agents/` 안 5 멤버 audit-team SymbolicLink (project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer / component-installer) 잔존 시 dual-active 회피 위해 수동 제거 narrative (OS 별 정확 명령 = README.md#installation).

### Added

- **`.claude-plugin/plugin.json`** — Plugin manifest (name=harness-meta, version=5.0.0, paths 명시 = agents/commands/hooks/skills replace-default + add-to-default). 7 멤버 (5 team + 2 standalone) 자동 인식 paths 명시.
- **`.claude-plugin/marketplace.json`** — local marketplace 등재 (single plugin, source = `.`).
- **`claude/hooks/hooks.json`** — Plugin schema PostToolUse Write|Edit + SessionStart matcher (existing `claude/hooks/{post-report-write,session-init}.sh` 매핑, `${CLAUDE_PLUGIN_ROOT}` 변수 활용).
- **README/AGENTS/CLAUDE Installation section 갱신** — `claude plugin marketplace add` + `claude plugin install` 표준 명령 narrative + migration cleanup OS 분기 (Linux/macOS `rm` + Windows PowerShell `Remove-Item`) + deprecation 표지.
- **ARCHITECTURE.md § 3.1 Install 정책 Plugin spec 채택** — Plugin 채택 narrative 정전화. v4.3 'Install 정책 본질 + Plugin spec 대안' paragraph 는 'Historical narrative' subsection 으로 source 보존.
- **bootstrap/agents CLAUDE.md Install/Update/Cleanup 책임** — Plugin spec 채택 + component-installer 책임 분리 narrative.
- **cascade narrative deprecation 표지 14 host** — 모든 install/symlink/junction/D7 키워드 사용 host 안 'deprecated since v5.0, v5.0+ 환경에서는 비활성' 표지 추가 (v3.21 narrative 정전화 3 단계 패턴 8 번째 cycle).
- **5 관점 검토 모두 PASS/PASS_WITH_COMMENTS (FAIL 0, 충돌 0)** + 7 권고 흡수 (D6 commands precedent + hooks.json minimum schema + D10 책임 분리 구체화 + D3 PowerShell 동치 + D9 dual-active 검출 step 5 + D2 'v5.0+ 환경에서는 비활성' 명시).

### Removed

- **`bootstrap/claude-code-catalog/README.md.bak`** — v4.0 phase-4 산출물 backup 추정 cleanup (untracked .bak 파일 제거).

## [v4.2] - 2026-05-14

### Added

- **`bootstrap/agents/audit/environment-auditor.md`** — standalone subagent (read-only audit). `verify.{ps1,sh}` + `verify-lib.{ps1,sh}` 4 script 폐기 후 흡수. 10 stage 매트릭스 (Z 플랫폼 / A 환경 / B Symlink 또는 Junction 무결성 / C settings.json / D Hook / E Statusline / F backup / I Frontmatter V1~V10 / J PostToolUse / G Runtime-only). Bash 화이트리스트 (read-only 만, write 일체 금지).
- **`bootstrap/agents/audit/agents-md-sync.md`** — standalone subagent (write drift sync, default `-Check`). `sync-agents.{ps1,sh}` 폐기 후 흡수. 7 adapter (CLAUDE / GEMINI / .github/copilot / .cursor / CONVENTIONS / .clinerules / .roo) SHA-256 drift 감지 + sync. e3 정책 게이트 (default `-Check` drift detect / `-SourceWins` write = 사용자 명시 결정 후).
- **`bootstrap/agents/CLAUDE.md` § Audit/Sync 책임** — standalone subagent vs team 책임 경계 narrative 정전화 (standalone = 자연어 사용자 호출 / team = e3 cycle 5 멤버 순차).
- **`projects/meta/ARCHITECTURE.md` § 3.1 끝 paragraph** — 'mechanical 본질 vs Claude Code spec 의무 컴포넌트 분리' narrative 정전화 (단일 source, v3.21 narrative 정전화 3 단계 패턴 6 cycle 누적). spec 의무 컴포넌트 (`claude/hooks/{session-init.sh, post-report-write.sh}` + `claude/statusline/statusline.sh`) agent 흡수 불가능 narrative.
- **Makefile `make verify` target stub** — stub message + agent 안내 (v4.0 phase-3 install stub 패턴 정합). 외부 cron/CI 끊김 시 명시 안내.

### Removed

- **6 script git rm (mechanical 폐기)** — `verify.ps1` + `verify.sh` + `verify-lib.ps1` + `verify-lib.sh` + `sync-agents.ps1` + `sync-agents.sh`. 총 -1667 LOC. v4.0 phase-3 install script 폐기 패턴 정합 (mechanical 본질 agent 흡수).
- **2 inactive smokes git rm** — `tests/_inactive/smoke-sync-agents.sh` + `tests/_inactive/smoke-verify-sh-parity.sh`. 참조 대상 폐기 = 의미 zero. 총 -222 LOC.
- **`claude/CLAUDE.md`** Hook 추가 시 절차 안 'verify.{ps1,sh} 갱신' line 폐기.
- **`tests/CLAUDE.md`** inactive smoke 표 2 row (`smoke-sync-agents.sh` + `smoke-verify-sh-parity.sh`) 제거.

## [v4.0]! - 2026-05-13

### Breaking changes

- **정체성 전면 재정의** — harness-meta 가 'project harness composer + Claude Code ecosystem integrator + agent fleet maintainer' 로 pivot. 단일 source = `projects/meta/ARCHITECTURE.md` § 3.1 끝 paragraph. 5 host (root CLAUDE.md / AGENTS / README / projects/meta/CLAUDE.md / ARCHITECTURE) cross-ref 정전화.
- **§ 6.2 동결 정책 폐지** — 구 "Lightweight 모드 정책 + Workflow self-improvement 동결 + Narrative 정전화 3단계 + 선례 2건" paragraph 모두 ARCHITECTURE.md 안 제거. 새 정체성이 자연 가드레일.
- **install script 3개 폐기 (B3)** — `install.ps1` + `install-skills.ps1` + `install-skills.sh` 모두 삭제 (총 -1484 LOC). mechanical install/update/cleanup 작업은 agent (`component-installer`) 가 흡수 (D7 sequence). 첫 진입 = Claude Code 안 자연어 호출 (`harness-meta 설치해줘`).
- **메타 milestone 40 디렉토리 → `_archive/`** — v1.0~v3.21 모든 milestone 디렉토리 `projects/meta/milestones/_archive/` 일괄 git mv (history 보존). v4.0/ 만 활성 위치 유지. upbit (`projects/upbit/`) 현 위치 보존 (A2).

### Added

- **`bootstrap/agents/`** — 글로벌 subagent + agent team source-of-truth 디렉토리 신설. 두 층 구조 (글로벌 vs 프로젝트 특화 `projects/<name>/.claude/agents/`).
- **`bootstrap/agents/CLAUDE.md`** — 정책 narrative (두 층 + conflict resolution 4 case 매트릭스 + agent fleet lifecycle 5 case 매트릭스 + D7 mechanical sequence + 신규 추가 절차 + 벤치마크 cycle).
- **`bootstrap/claude-code-catalog/README.md`** — Claude Code 도구 카탈로그 단일 host (code.claude.com/docs context7 `/websites/code_claude` + built-in slash command 인벤토리 + plugin/MCP 인벤토리 + 자주 묻는 query 카탈로그).
- **첫 agent team `project-harness-audit-team`** (5 멤버) — `bootstrap/agents/audit/project-harness-audit-team/`:
  - `project-scanner` (read-only) — 코드베이스 scan + 메타데이터 JSON
  - `harness-gap-analyzer` (read-only) — 3 축 gap detection
  - `claude-docs-mapper` (read-only, mcp context7) — gap → 도구 카탈로그 매핑
  - `component-proposer` (Write draft, e3 게이트) — proposal draft markdown
  - `component-installer` (write apply, opus, Bash 화이트리스트) — D7 mechanical
- **`/harness-meta <name> --audit` opt-in** — `claude/commands/harness-meta.md` Stage A entry 안 conditional 분기. flag 명시 시 audit team 자동 호출, freeform default 보존 (회귀 0).
- **벤치마크 cycle routine** — `schedule` skill 활용 주 1회 cron (GitHub 인기 repo + Claude Code release notes/changelog). 산출물 host = `projects/meta/ROADMAP.md` 안 `candidate_draft[]` 신 필드 (e3 정책 정합).

### Changed

- **smoke `_archive/` sentinel 자동 skip** — `tests/smoke-bundle-trigger.sh` + `tests/smoke-cross-ref.sh` regex 안 `(_archive/)?` optional group 추가.
- **`bootstrap/skills/CLAUDE.md`** — 배포 섹션 + 신규 user-skill 추가 절차 안 install-skills.{ps1,sh} 명령 reference 제거. `bootstrap/agents/CLAUDE.md` 단일 source cross-ref.
- **ROADMAP `schema_note`** — `candidate_draft[]` 신 필드 정의 추가 (id/title/source/detected_at/rationale/category/decision_pending).

### Removed

- `install.ps1` (534 line) — root install script
- `install-skills.ps1` (610 line) — Windows user-skill install
- `install-skills.sh` (340 line) — POSIX user-skill install
- ARCHITECTURE.md § 6.2 (line 182~205) — paragraph 4건 (Lightweight + Workflow 동결 + Narrative 정전화 3단계 + 선례 2건)

### Migration

기존 `~/.claude/skills/` 5 symlink (ai-ready-scorer / harness-plan-verify / harness-roadmap-update / mindvault / developer-profile) 보존 — 현 작동 유지. 신규 install / reinstall / cleanup 필요 시 Claude Code 안 자연어 호출 (`harness-meta 설치해줘`) 또는 `component-installer` subagent 호출.

## [v3.16] - 2026-05-13

### Changed

- CHANGELOG.md [Unreleased] 섹션을 Keep a Changelog v1.1.0 권장 위치(최상단)로 이동. 5 항목(CI / pre-commit / GUARDRAILS / .env.example / CHANGELOG) 을 v1.0~v1.4 entry로 귀속. [v3.15] entry 추가 (backfill 완료 기록). Lightweight 모드 누적 6건째. 단일 phase 1 commit (`e9dffa1`). pre-commit 14 hook PASS, 회귀 0.

## [v3.15] - 2026-05-13

### Added

- CHANGELOG.md v3.0~v3.14 14 entry backfill — v3.0 `!` BREAKING 마커 + v3.1~v3.14 13 entry 역순 삽입. Keep a Changelog v1.1.0 정합. Lightweight 모드 단일 phase 1 commit (`d3eddaa` + Stage G `74afedb`). pre-commit 14 hook PASS, 회귀 0.

## [v3.14] - 2026-05-13

### Changed

- ROADMAP `deferred_note` — `v3.14_deferred-revaluation-cycle-2` cycle 2 verdict 갱신 (옵션 A 동결 유지). v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_research-cascade-grep-discipline 3 entry `deferred_reason` 안 cycle 2 cross-ref 추가.
- v3.13 cycle 1 직접 후속 — § 6.2 재발의 trigger 조건 (1) PASS (10건 누적) ∧ 조건 (2) FAIL (direct 0 + indirect 0 + reverse 5) = AND FAIL → 재발의 trigger 미충족.
- Lightweight 모드 단일 phase 1 commit (`f50ad5d` + `a5a9178`). pre-commit 14 hook PASS, 회귀 0.

## [v3.13] - 2026-05-12

### Changed

- ROADMAP — v1.x pending 3건 (`v1.4_hook-narrative-separation` / `v1.4_design-review-trace` / `v1.5_research-cascade-grep-discipline`) status `pending` → `deferred` + `deferred_reason` 신 필드 + `deferred_note` 갱신.
- § 6.2 workflow self-improvement 동결 정책 직접 적용 — 외부 `projects/<name>` (name ≠ meta) 실 적용 milestone 1건 완료 + 정량 데이터 기반 명시 발의 trigger 조건 부재 시 동결 유지.
- v2.0_workflow-word-fidelity lessons `next_candidates#1` origin 사용자 명시 선택 (A_user 재분류).

### Added

- `renumbered_from` 필드 도입 — `v2.1_pending-milestone-renumber-policy` (v1.x era pending) → v3.13 forward-only renumber 첫 정식 사용.
- Lightweight 모드 자연 적용 (`a86334c`) — 5 관점 subagent 검토 생략, 산출물 LOC ~673 (baseline 850 미만). 1 phase 1 commit, pre-commit 14 hook PASS, 회귀 0.

## [v3.12] - 2026-05-12

### Changed

- `bootstrap/skills/audit/harness-{plan-verify,roadmap-update}/SKILL.md` — `sessions/` 거명 9건 일괄 정리. DEPRECATED 블록 내 역사적 서술 보존.
- Lightweight 모드 1 phase 1 commit (`446485b`), pre-commit 14 hook PASS, 회귀 0.

## [v3.11] - 2026-05-12

### Changed

- Stale narrative 3위치 일괄 정리: `claude/CLAUDE.md` L39 PostToolUse 섹션 9-stage-bundled era 표기 + `projects/upbit/ARCHITECTURE.md` L106 현행 안내 stale path + `CHANGELOG.md` L3 era 카테고리 정합화 (3 era).
- `v1.5_legacy-narrative-cleanup` (v1.x era pending) → v3.11 forward-only renumber (`renumbered_from` 필드 도입 첫 사례).
- Lightweight 모드 1 phase 1 commit (`40faa23`), pre-commit 14 hook PASS, 회귀 0.

## [v3.10] - 2026-05-11

### Changed

- `claude/commands/harness-meta.md` — Stage B/C/D 정의에 (a) 사실 진술 vs (b) 후속 발의 의미 분리 narrative 추가.
- Stage I (PROPOSE) — Stage B/C/D 부산물 통합 흡수 책임 + `A_user` dual origin 명시.
- `projects/meta/ARCHITECTURE.md` § 4 9-stage 표 직후 cross-ref 1줄 추가.
- Lightweight 모드 1 phase 1 commit (`4e1981f`). 도그푸드 정합 (산출물 안 forward propose 명령형 부재 grep 검증). pre-commit 14 hook PASS, 회귀 0.

## [v3.9] - 2026-05-12

### Added

- `tests/CLAUDE.md` — '회귀 검증 절차' 섹션 하단 `### smoke 파일 이동(git mv) 시 체크리스트` subsection 4단계 추가.
- 1 phase 1 commit (`9587f52`), pre-commit 14 hook PASS, 회귀 0.

## [v3.8] - 2026-05-11

### Fixed

- `tests/_inactive/` 이동 후 `cd '$(dirname $0)/..'` 가 `tests/` 로 잘못 해석되는 버그 8 파일 일괄 수정 (→ `../..`): `smoke-detect-language` / `smoke-roi-regression` / `smoke-backup-cleanup` / `smoke-bootstrap-agents-md` / `smoke-bootstrap-render` / `smoke-skills-install` / `smoke-sync-agents` / `smoke-python-entry-boilerplate`.

### Added

- `tests/CLAUDE.md` — inactive smoke 경로 규약 1줄 추가.
- 1 phase 1 commit (`2e25eff`), pre-commit 14 hook PASS, 대표 inactive smoke 2건 6/6 PASS.

## [v3.7] - 2026-05-11

### Added

- `tests/smoke-posttooluse-hook.sh` — INTENT/APPROVE/PROPOSE 9-stage 테스트 3건 (Tests T/U/V) 추가, 25/25 PASS. 헤더 카운트 19 → 22.
- v2.0_workflow-word-fidelity 의 INTENT/APPROVE/PROPOSE 분기 coverage gap 보완 (`absorbed_from: v2.1_smoke-posttooluse-9stage-tests`).
- 1 phase 1 commit (`030e68e`), pre-commit 14 hook PASS, 회귀 0.

## [v3.6] - 2026-05-11

### Added

- `projects/meta/ARCHITECTURE.md` § 6.2 — workflow self-improvement 동결 정책 narrative 신설 (lightweight 모드 trigger 3건 + narrative cap 정책 + 재발의 trigger 조건).
- `tests/_inactive/` — inactive smoke 22 archive (git mv, CI 정책 정합).

### Changed

- `.github/workflows/ci.yml` — inactive smoke 22 archive 정합화.
- Lightweight 모드 자기참조 회피 표지 적용 (v2.0_workflow-word-fidelity 선례 chicken-and-egg 회피) — 5 관점 subagent 검토 생략 + 산출물 LOC cap.
- 3 phase / 3 commit (`4ef8a74` + `9ba1eb1` + Stage G+H+I 통합), pre-commit 14 hook PASS, 회귀 0.

## [v3.5] - 2026-05-11

### Added

- `tests/smoke-open-stage-discipline.sh` 신규 + pre-commit hook 등록 (13 → 14 active).
- `claude/commands/harness-meta.md` Stage D 끝 sub-section 'Stage D 완료 직전 의무 step' — `phases[]` 확정 후 `milestones.md sub_milestones` 1:1 동기 갱신 의무.

### Changed

- `tests/CLAUDE.md` 매트릭스 5 영역 갱신 (헤더 28 → 29 / narrative 7 active / 핵심 정책 검증 표 row + 현행 hook 표 row + inactive 22 active 카운트).
- v3.0+ 9-stage-bundled era 두 번째 bundle 사례 (첫: v3.1). 2 phase 2 commit (`35c621c` + `a4aa8c7`), pre-commit 14 hook PASS (3회), 회귀 0.

## [v3.4] - 2026-05-11

### Changed

- `claude/commands/harness-meta.md` Stage A OPEN 절차에 step 7 신규 추가 — `milestones/v{X.Y}/milestones.md` 스켈레톤 즉시 작성 (v3.0+ 9-stage-bundled era 의무, narrative 1차 source).
- Stage F 선결 조건 게이트 블록 narrative 미세 갱신 — DRY 회피 + 보조 검증 step 명시.
- Skeleton 최소 필드 narrative 1차 source 위치 Stage F 게이트 → Stage A step 7 로 이동.
- 자기참조 부합 (도그푸드) — v3.4 OPEN 단계 자체가 본 절차 첫 적용.
- 단일 phase 1 commit (`c3c35a9`), pre-commit 13 hook PASS, 회귀 0.

## [v3.3] - 2026-05-11

### Changed

- `.github/workflows/ci.yml` — glob 28건 → active 6건 명시 배열 (`ACTIVE_SMOKES`). inactive smoke 16건 CI 제외로 즉시 green 복구.
- inactive smoke 파일 보존.
- 1 phase 1 commit (`14b36ff`), pre-commit 13 hook PASS, 회귀 0.

## [v3.2] - 2026-05-11

### Changed

- `claude/commands/harness-meta.md` Stage F 선결 조건 게이트 블록 신규 — milestones.md 선결 의무 CRITICAL + INTENT~APPROVE commit 시점 3 패턴.
- `tests/CLAUDE.md` — controlled 비교 cp949 mojibake 정상 작동 narrative.
- Skeleton 매트릭스 2 row — era 분류 vs schema 책임 분리 + status 기반 분기.
- 3 phase 3 commit (`1220a2d` + `6483d1b` + `de7f62a`), pre-commit 13 hook PASS, 회귀 0.

## [v3.1] - 2026-05-10

### Added

- `tests/smoke-bundle-trigger.sh` 신규 + pre-commit 등록 (12 → 13 hook, 자동 강제 누적).
- `milestones/v3.0/milestones.md` 신규 (R1 CRITICAL mitigation — v3.0+ 9-stage-bundled era narrative 1차 source).

### Changed

- `tests/CLAUDE.md` § '흔한 함정' 7번째 row 추가 — markdownlint trap narrative (MD049 spec 직접 인용).
- Historical era 적용 결정 — forward-only 강제 (v3.0 milestones.md unchanged D12 사용자 결정 P1).
- v3.0+ 9-stage-bundled era 첫 후속 통합 milestone 사례 (도그푸드 누적).
- 3 phase 3 commit (`0a86598` + `4bd4ec6` + `d136b2f`), pre-commit 13 hook PASS, 회귀 0.

## [v3.0]! - 2026-05-10

### Changed (BREAKING)

- milestone hierarchy 재구성 — `milestones/v{X.Y}_{slug}/` flat → `milestones/v{X.Y}/` (sub-id 부재) + `milestones.md` (sub-milestone listing per version) + version > sub-milestone > phase 계층화.
- ROADMAP `milestones[]` schema 변경 — `{version, id (group-slug), title, status, summary, trigger, milestones_path?}` 신 schema. v2.0~v2.1 / v1.0~v1.4 보존 entry 는 기존 schema (`id` flat = `v{X.Y}_{slug}`) 유지 (forward-only).
- smoke era 분기 도입 — `tests/_era_detect.py` 분리 (v2.2_era-detect-shared-module 흡수).
- 자기참조 부합 — v3.0 자체가 신 구조 첫 적용 사례 (도그푸드).
- breaking change → major bump (v2 → v3).

### Added

- `projects/meta/milestones/v3.0/milestones.md` (sub-milestone listing per version) 도입.
- v2.2_* 4건 흡수 (`absorbed_milestones`: `v2.2_era-detect-shared-module` phase-2 / `v2.2_smoke-cp949-encoding-pattern` phase-6 / `v2.2_smoke-controlled-comparison-pattern` phase-7 / `v2.2_historical-7stage-stage1-decision` phase-8).
- 8 phase (smoke era branching → `_era_detect.py` 분리 → 정책 명문화 → ROADMAP schema 변경 → `milestones.md` → cp949 / controlled-comparison / historical-decision 잔여 흡수).

## [v2.1] - 2026-05-10

### Performance

- `tests/smoke-spec-verification.sh` — per-call python3 spawn (~150회) 패턴을 단일 batched python3 호출로 통합. 66.4s → 0.63s (99.05% 감소).
- `tests/smoke-scope-contract.sh` — Stage 1+2 batched python3 + Stage 3 bash 유지 + bash `detect_era()` 함수 제거 (Python 일원화). 12.4s → 0.65s (94.76% 감소).
- 전체 `pre-commit run --all-files` — 93.3s → 15.4s (83.49% 감소).

### Fixed

- Windows cp949 콘솔에서 em dash (U+2014) `UnicodeEncodeError` 회피 — `sys.stdout.reconfigure(encoding='utf-8')` 추가 (`smoke-python-entry-boilerplate § P2` v1.87 패턴 차용).

## [v2.0]! - 2026-05-10

### Changed (BREAKING)

- 7-stage workflow → 9-stage workflow (`ROADMAP (입력 source) → OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE`). 단어 = 단일 책임 1:1 매핑 정정.
- milestone 산출 파일명: `PLAN.md → INTENT.md` rename, `APPROVE.md` / `PROPOSE.md` 신규.
- Historical 7-stage era (v1.0~v1.4) 11개 milestone 의 PLAN.md → INTENT.md `git mv` 마이그레이션 (history 보존). 4-tier era (v1.84~v1.88) 는 era 보존 정책 적용.
- ARCHITECTURE.md § 3.3 5요소 매트릭스 — 'Workflow' 행 9-stage 갱신 + 'Constraint' 행 APPROVE.md.approved_by gate + 'Trace' 행 산출 7종 enumerate.
- Smoke (smoke-spec-verification / smoke-scope-contract) 에 era 자동 식별 메커니즘 추가 — 산출 파일명 자체로 9-stage / 7-stage / 4-tier era 분기 검증.

### Added

- `APPROVE.md` (사용자 명시 승인 게이트) + `PROPOSE.md` (next_candidates ROADMAP 등록 forward 분리) 신규 stage 산출물.
- ARCHITECTURE.md § 6 era 정책 명문화 (4-tier / 7-stage / 9-stage 3 era 매트릭스 + 본 v2.0 milestone 자기참조 표지 명시).
- claude/hooks/post-report-write.sh — 9-stage era file pattern + write 시점 분기 inject 메시지 (REPORT → PROPOSE 안내, APPROVE → EXECUTE 진입 게이트, PROPOSE → ROADMAP 등록 안내).

## [v1.14] - 2026-04-28

### Changed

- Bootstrap interview simplified: 10 stages → 8 stages, 13 questions → 7 questions

## [v1.13] - 2026-04-28

### Added

- English `README.md` rewrite + `AGENTS.md` update (open-source entry)

## [v1.12] - 2026-04-27

### Changed

- `_base` skills + Python overlay fully translated to English

## [v1.11b] - 2026-04-27

### Added

- `bootstrap/templates/python/.claude/` overlay content — `harness-python` skill (env check + mypy → ruff → pytest quality gate, package-manager auto-detection)

## [v1.11] - 2026-04-27

### Added

- Language overlay infrastructure (`bootstrap/templates/<language>/.claude/` directory convention + Phase 2 merge logic in `install-project-claude.{sh,ps1}` + `harness-*` naming convention + 10-language matrix)

## [v1.10j] - 2026-04-27

### Added

- Scope contract discipline — `PLAN.md` "Scope inheritance" + "Out of scope" sections now mandatory (over-scope drift prevention)

## [v1.10c–v1.10h3] - 2026-04-26 ~ 2026-04-27

### Added

- Bootstrap AGENTS.md content defaults: `bootstrap_version` stamp, `install_cmd` (17 package-manager matrix), `license` 4-tier detection (SPDX header → multi-file dual → boilerplate 12 patterns → metadata 4 sources)

### Changed

- AGENTS.md L5 license line policy: 3-way rendering (Case 1/2/3) + `MAX_LENGTH=80` (EULA abuse guard)

## [v1.10] - 2026-04-26

### Added

- Bootstrap interview 10-stage flow (`/harness-meta <new-name>` mode)

## [v1.9] - 2026-04-25

### Added

- `bootstrap/detect-project.sh` — auto-detects language / package manager / test commands

### Changed

- `install-project-claude.{sh,ps1}` legacy cleanup logic (v1.9b)

## [v1.8] - 2026-04-25

### Changed (BREAKING)

- Global `claude/` layer reduced to 3 items (`commands/harness-meta.md`, `hooks/session-init.sh`, `statusline/statusline.sh`)
- `bootstrap/templates/_base/.claude/` introduced for project-level distribution
- Existing projects must run `install-project-claude.{ps1,sh}` to recover slash commands

### Changed

- `_base/.claude/commands/` 6 files migrated to `_base/.claude/skills/*/SKILL.md` (Anthropic preferred format) — v1.8b

## [v1.7] - 2026-04-25

### Added

- `.harness.toml` schema v1.1 (additive only): `runtime_version`, `locale`, `statusline_cmd`, `statusline_timeout_ms`, `state_file`, `[agents]`, `[build]`, `format_cmd`

### Deprecated

- `[project].python_version` → use `runtime_version` (retained for backward compatibility)

## [v1.6] - 2026-04-24

### Changed (BREAKING)

- Removed Python dependency from global hooks/statusline (bash-only). Multi-language project support unblocked.

## [v1.5] - 2026-04-24

### Added

- AGENTS.md open-standard adoption strategy + symlink/copy dual deployment (`bootstrap/docs/AGENTS_MD_STRATEGY.md`)

## [v1.0–v1.4] - 2026-04 (early)

### Added

- Initial harness-meta bootstrap: global symlink installer, session ownership rules (S1–S7 + T1–T5 tie-breakers), `.harness.toml` schema v1.0, project architecture document set (ARCHITECTURE / DECISIONS / INTERVIEW / STACK)
- `.github/workflows/ci.yml` — smoke tests auto-run on push and pull_request
- `.pre-commit-config.yaml` + `.markdownlint.json` + `.markdownlintignore` — shellcheck + markdownlint enforcement (frontmatter-based directories excluded)
- `GUARDRAILS.md` — meta-repo session behavior guardrails (forbidden actions, confirmation-required operations, scope contract obligations)
- `.env.example` — `HARNESS_META_ROOT` environment variable reference
- `CHANGELOG.md` — this file

For details on v1.10 and earlier, see `sessions/meta/` directly.
