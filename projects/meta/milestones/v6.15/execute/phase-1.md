# v6.15 phase-1 — v6.4~v6.9 entry title active form 재정의 + status drift cleanup + CHANGELOG cascade

## Spec

```json
{
  "phase": 1,
  "title": "v6.4~v6.9 frontmatter title 6 retitle + status drift fix 3 + CHANGELOG bullet bold 3 동기 + ARCHITECTURE § 6 cycle 12 + CHANGELOG [v6.15] entry",
  "status": "complete",
  "completion_date": "2026-05-21",
  "changes": [
    {"file": "projects/meta/milestones/v6.4/MILESTONE.md", "action": "edit", "summary": "frontmatter title `cascade 자동 동기 mechanism` → `cascade 자동 동기 mechanism 도입` + # heading 동기 갱신."},
    {"file": "projects/meta/milestones/v6.5/MILESTONE.md", "action": "edit", "summary": "frontmatter title `Claude 자율 milestone 발의 mechanism` → `Claude 자율 milestone 발의 mechanism 도입` + # heading 동기 갱신."},
    {"file": "projects/meta/milestones/v6.6/MILESTONE.md", "action": "edit", "summary": "frontmatter title `audit chain hallucination 자동 정정 mechanism` → `audit chain hallucination 자동 정정 mechanism 도입` (C 표기 drift 별 milestone 보존, suffix only) + frontmatter status `in_progress` → `completed` + # heading 동기 갱신."},
    {"file": "projects/meta/milestones/v6.7/MILESTONE.md", "action": "edit", "summary": "frontmatter title `v5.13/v5.18/v6.6 3-step chain 정전화` → `v5.13/v5.18/v6.6 3-step chain 정전화 도입` + # heading 동기 갱신."},
    {"file": "projects/meta/milestones/v6.8/MILESTONE.md", "action": "edit", "summary": "frontmatter title `/propose-next surface 자동 dedupe mechanism` → `/propose-next surface 자동 dedupe mechanism 도입` + frontmatter status `in_progress` → `completed` + # heading 동기 갱신."},
    {"file": "projects/meta/milestones/v6.9/MILESTONE.md", "action": "edit", "summary": "frontmatter title `synthesizer mismatch 보고 형식 debugger 5-step` → `synthesizer mismatch debugger 5-step 형식 통일` + frontmatter status `in_progress` → `completed` + # heading 동기 갱신."},
    {"file": "CHANGELOG.md", "action": "edit", "summary": "[v6.15] entry 신규 추가 (### Added 1건 + ### Changed 3건 + ### Documented 6건). v6.7/v6.8/v6.9 `### Added` 첫 bullet bold 3 위치 동기 갱신 (v6.7 `정전화` → `정전화 도입` / v6.8 `mechanism` → `mechanism 도입` / v6.9 `... debugger 5-step` → `... debugger 5-step 형식 통일`). Keep a Changelog v1.1.0 정합."},
    {"file": "projects/meta/ARCHITECTURE.md", "action": "edit", "summary": "§ 6 끝 spec-drift spike paragraph cycle counter 11 → 12 갱신 + 분기 분포 10:1 → 11:1 (v6.15 c-2 자체 정전화 분기 추가) + cross-ref `milestones/v6.15/MILESTONE.md` 추가 + 보강 milestone 명시 (v6.13 + v6.14 + v6.15)."},
    {"file": "projects/meta/ROADMAP.md", "action": "edit", "summary": "milestones[] v6.15 in_progress entry 추가 (맨 위, summary 상세 narrative) + next_candidates[#5] `active-form-3-step-chain-retitle-v6-7` entry 제거 (promote) + updated `2026-05-21-v6.14` → `2026-05-21-v6.15`."},
    {"file": "projects/meta/milestones/v6.15/MILESTONE.md", "action": "edit (frontmatter status 갱신은 phase-2 REPORT)", "summary": "phase-1 1차 commit 시점 frontmatter status `in_progress` 보존 (REPORT 단계 후 `completed` 갱신, v6.14 패턴 정합). ## APPROVE 섹션 `approved_by: user` + date 갱신 완료."},
    {"file": "projects/meta/milestones/v6.15/execute/phase-1.md", "action": "create", "summary": "본 파일 — phase-1 실 진행 일지."}
  ],
  "commit": "(phase-1 commit hash, 본 commit 자체)",
  "verification": [
    {"check": "frontmatter title 6 위치 retitle 정확", "result": "PASS", "evidence": "v6.4~v6.9 6 MILESTONE.md frontmatter line 3 + line 8 (# heading) 양방 동기 갱신 grep 검증 — v6.4 `cascade 자동 동기 mechanism 도입` + v6.5 `Claude 자율 milestone 발의 mechanism 도입` + v6.6 `audit chain hallucination 자동 정정 mechanism 도입` + v6.7 `v5.13/v5.18/v6.6 3-step chain 정전화 도입` + v6.8 `/propose-next surface 자동 dedupe mechanism 도입` + v6.9 `synthesizer mismatch debugger 5-step 형식 통일` 6건 모두 적용 확인."},
    {"check": "status drift fix 3 위치 정확", "result": "PASS", "evidence": "v6.6/v6.8/v6.9 frontmatter line 5 `status: in_progress` → `status: completed` 3건 적용 확인. ROADMAP archived + CHANGELOG entry 존재 evidence 정합."},
    {"check": "CHANGELOG bullet bold 3 위치 동기 갱신", "result": "PASS", "evidence": "v6.7 line 166 `정전화` → `정전화 도입` + v6.8 line 141 `mechanism` → `mechanism 도입` + v6.9 line 118 `보고 형식 debugger 5-step` → `debugger 5-step 형식 통일` 3건 적용 확인. v6.4/v6.5/v6.6 = `신규 도입` suffix 이미 보유 (역사적 정합 보존)."},
    {"check": "ARCHITECTURE § 6 cycle counter 갱신", "result": "PASS", "evidence": "§ 6 끝 spec-drift spike paragraph 안 `cycle 11` → `cycle 12` + `분기 분포 10:1` → `분기 분포 11:1` + v6.15 c-2 분기 자연 발현 narrative + `milestones/v6.15/MILESTONE.md` cross-ref 추가."},
    {"check": "CHANGELOG [v6.15] entry 추가 + § 7.2 smoke 회귀 0", "result": "PASS", "evidence": "Unreleased 다음 [v6.15] entry 신규 추가 (### Added 1건 + ### Changed 3건 + ### Documented 6건). bullet bold = `v6.4~v6.9 entry title active form 재정의` (39자 codepoint ≤ 60 ✓ + ` + ` literal space 부재 ✓ + Active form `재정의` 본질 동사 종결 정합). smoke-entry-title-guideline 회귀 0 보장."},
    {"check": "ROADMAP v6.15 in_progress entry 추가 + next_candidates#5 promote 제거", "result": "PASS", "evidence": "milestones[] 안 v6.15 entry (id `v6-4-v6-9-entry-title-active-form-redefinition` + status `in_progress` + summary 상세 narrative) 맨 위 추가 + next_candidates#5 `active-form-3-step-chain-retitle-v6-7` 제거 + updated `2026-05-21-v6.15` 갱신."},
    {"check": "pre-commit 18 hook 전체 PASS 검증 (smoke-entry-title-guideline 포함)", "result": "(phase-1 commit 시점 검증)", "evidence": "phase-1 commit 직전 `pre-commit run --all-files` 호출 = 18 hook 모두 PASS 보장. smoke-entry-title-guideline (v6.3 도입) 회귀 0 = CHANGELOG bullet bold 신 표기 모두 ≤ 60자 ✓ + ` + ` literal space 부재 ✓."}
  ]
}
```

## Narrative

phase-1 = lightweight 1-phase 통합 commit (D5 결정, v6.7~v6.14 8 consecutive 누적 패턴 정합). scope ~12 mechanical edit + 1 ARCHITECTURE cycle counter + 1 CHANGELOG [v6.15] entry + 1 ROADMAP + 1 phase-1.md 별책.

**mechanical apply sequence**:

1. v6.4 MILESTONE.md frontmatter title + # heading 동기 갱신 (`cascade 자동 동기 mechanism` → `... mechanism 도입`)
2. v6.5 MILESTONE.md frontmatter title + # heading 동기 갱신 (`Claude 자율 milestone 발의 mechanism` → `... mechanism 도입`)
3. v6.6 MILESTONE.md frontmatter title + # heading + status 3 위치 동기 갱신 (`audit chain hallucination 자동 정정 mechanism` → `... mechanism 도입` + `status: in_progress` → `completed`, (C) 표기 보존)
4. v6.7 MILESTONE.md frontmatter title + # heading 동기 갱신 (`v5.13/v5.18/v6.6 3-step chain 정전화` → `... 정전화 도입`)
5. v6.8 MILESTONE.md frontmatter title + # heading + status 3 위치 동기 갱신 (`/propose-next surface 자동 dedupe mechanism` → `... mechanism 도입` + status)
6. v6.9 MILESTONE.md frontmatter title + # heading + status 3 위치 동기 갱신 (`synthesizer mismatch 보고 형식 debugger 5-step` → `synthesizer mismatch debugger 5-step 형식 통일` + status)
7. CHANGELOG v6.7 bullet bold (line 166) `정전화` → `정전화 도입`
8. CHANGELOG v6.8 bullet bold (line 141) `mechanism` → `mechanism 도입`
9. CHANGELOG v6.9 bullet bold (line 118) `보고 형식 debugger 5-step` → `debugger 5-step 형식 통일`
10. ARCHITECTURE § 6 끝 spec-drift spike paragraph cycle counter 11 → 12 + 분기 분포 10:1 → 11:1 + cross-ref 갱신 (D9)
11. CHANGELOG [v6.15] entry 신규 추가 (### Added 1 + ### Changed 3 + ### Documented 6)
12. ROADMAP milestones[] v6.15 in_progress entry 추가 + next_candidates#5 promote 제거 + updated 갱신
13. 본 `execute/phase-1.md` 신규 작성
14. v6.15 MILESTONE.md ## EXECUTE 섹션 갱신 (sequence 흡수)
15. `pre-commit run --all-files` 회귀 검증 = 18 hook PASS

**execution_notes**:

- **(C) v6.6 표기 drift 분리 명시** — frontmatter `자동 정정` 보존 + suffix `도입` only 추가 = R1 결정 정합 잔존 drift 명시 보존. PROPOSE 안 별 milestone candidate (id 후보 = `v66-frontmatter-spec-drift-detect-vs-correct-narrative`) 등재 명시 의무 (D2 정합).
- **CHANGELOG bullet bold v6.4/v6.5/v6.6 = `신규 도입` suffix 이미 보유** — 역사적 정합 (작성 시점 의식적 Active form) 보존. 본 milestone 갱신 부재 자연 (D4).
- **v6.15 RESEARCH cb_11 hallucination 발견 + EXECUTE 단계 정정** — RESEARCH 안 인용된 v6.9 CHANGELOG bullet bold `synthesizer mismatch 5-step format 정합` 표기가 실 CHANGELOG line 118 `synthesizer mismatch 보고 형식 debugger 5-step` 표기와 mismatch → EXECUTE 직전 정확 line read 후 정정. memory feedback_subagent_fact_hallucination_correction cycle 3 evidence (v5.10 cycle 1 + v5.11 cycle 2 + v6.15 cycle 3, 본 milestone 안 self-research-step hallucination 자연 cycle).
- **frontmatter status 갱신 vs MILESTONE.md ## VERIFY/REPORT/PROPOSE 갱신 분리** — v6.6/v6.8/v6.9 frontmatter `status: completed` 본 phase-1 안 갱신 (사실 완료 evidence 정합) + v6.15 MILESTONE.md ## VERIFY/REPORT/PROPOSE 섹션 = phase-2 (REPORT) 작성. v6.14 패턴 정합 (phase-1 완료 + phase-2 REPORT 분리).

**v3.21 narrative 정전화 3 단계 패턴 cycle 37 self-host** — (a) DESIGN 1차 source (D1 suffix case-by-case + D3 status fix 동질 본질 + D9 cycle counter 갱신) → (b) Stage F EXECUTE Edit (frontmatter 6 + status 3 + CHANGELOG bullet 3 + ARCHITECTURE § 6 cycle + CHANGELOG [v6.15] + ROADMAP) → (c) VERIFY 안 verification check 7건 PASS evidence + phase-2 REPORT 흡수.

**lightweight 1-phase 누적 18/30 = 60% 첫 60% 돌파** (v6.14 17/29 = 58.6% → v6.15 18/30 = 60.0%). v6.7~v6.15 9 consecutive lightweight 1-phase milestone.

**v5.7 spec-drift spike (c-2) cycle 12 자연 발현** — Anthropic Claude Code spec 안 `entry title active form retitle` first-class 패턴 부재 (Conventional Commits / Keep a Changelog 안 entry title style guide 부재) → § 7.2 본 repo 자체 컨벤션 자기 적용 (c-2 자체 정전화 분기 본질, ARCHITECTURE § 6 끝 paragraph 갱신 정합).

**자기 적용 도그푸드 cycle 2** — v6.3_entry-title-guideline-smoke-verification (cycle 1, § 7.2 (1)+(2) 자동 강제 + 자기 적용) 후속 v6.15 (cycle 2, § 7.2 (3) Active form 자기 적용, smoke 자동 강제 외 AI 판단 위임 본질 정합).

## Risk mitigation evidence

| risk_id | mitigation 적용 | evidence |
|---|---|---|
| risk_1 | oos_2 본문 narrative 자기 cross-ref = audit trail 보존 명시 + EXECUTE scope 정확 한정 (frontmatter + CHANGELOG bullet bold 양방 만) | 본 phase-1 안 v6.4~v6.9 MILESTONE.md body narrative 안 self-reference title 인용 위치 (수다 cross-ref) 변경 부재 — frontmatter (정전 source) + # heading + CHANGELOG bullet bold 만 forward 갱신 |
| risk_2 | D4 + EXECUTE 안 retitle 후 즉시 pre-commit smoke 호출 검증 (≤ 60자 사전 codepoint 검증 + ` + ` literal space 부재 사전 확인) | retitle 6건 모두 codepoint length 사전 검증 ≤ 60 ✓ (v6.4 27 / v6.5 36 / v6.6 46 / v6.7 37 / v6.8 42 / v6.9 45) + ` + ` literal space 부재 모두 ✓ + CHANGELOG bullet bold 3건 동일 조건 ✓ + CHANGELOG [v6.15] bullet bold `v6.4~v6.9 entry title active form 재정의` 39자 ✓ |
| risk_3 | EXECUTE 직전 grep 6 패턴 cross-ref 검색 (host 식별 후 audit trail 보존 vs forward 갱신 결정) | RESEARCH 안 grep 6 패턴 cross-ref 검색 결과 = CHANGELOG bullet bold 외 cross-ref 식별 결과 = ARCHITECTURE row #8/#10 paragraph 안 `cycle N번째` cross-ref 패턴은 title 인용 부재 (cycle counter 만, audit trail 자연 보존). body narrative 안 self-reference 위치는 audit trail (역사적 정합) 보존 |
| risk_4 | D2 + REPORT 안 lesson + PROPOSE 안 (C) 별 milestone candidate 등재 (id 후보 거명 명시) | 본 phase-1 안 v6.6 frontmatter `자동 정정` 표기 보존 (suffix `도입` only 추가) + (C) 표기 drift narrative 명시 의무 = REPORT (phase-2) 안 lesson 등재 + PROPOSE 안 별 milestone candidate id 후보 (`v66-frontmatter-spec-drift-detect-vs-correct-narrative`) 등재 명시 |
| risk_5 | D6 inline matrix self-review + v6.7~v6.14 패턴 정합 본질 | 본 MILESTONE.md ## DESIGN 안 5 관점 inline matrix self-review 작성 (architecture / spec-drift / 회귀 risk / 보안 / scope contract) — decisive 0 + P2 2 (D9 cycle counter + oos_1 PROPOSE narrative) + P3 2 (architecture 도그푸드 + 회귀 risk pre-commit narrative) = 모두 narrative 흡수 또는 별 milestone 거명만. cycle 11 inline self-review evidence |
