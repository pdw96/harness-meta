---
id: version-mechanism-integration-rethink
title: version mechanism 통합 재고
version: v6.23
status: open
---

# v6.23 — version mechanism 통합 재고

## INTENT

### Spec

```json
{
  "id": "version-mechanism-integration-rethink",
  "title": "version mechanism 통합 재고",
  "goal": "milestone version mechanism 본질 (bundling cycle 본질 + git tag 단일 source 본질) 통합 재고 lightweight 1 cycle — 두 본질 평가 + 결정 outcome 도달 + ARCHITECTURE narrative 정전화. 실 적용은 결정 outcome 따라 v6.24+ 별 milestone 자연 분기.",
  "motivation": "candidate_draft[] 2 entry promote (2026-05-22) origin — (a) milestone-bundling-cycle-resumption: v3.0 도입 후 v3.6 lightweight 모드 정착 + v4.0 정체성 § 3.1 정전화 후 forward-only forsake 본질 + v6.16~v6.22 7 micro milestone (각 1-3 commit + 1-phase 평균 = 1:1 매핑) 누적 → v3.0+ 9-stage-bundled era 본질 자연 trigger. (b) github-tag-as-single-version-source: v6.19 GitHub Release mechanism 도입 후 git tag 자동 발급 본질 도달 → 5 source duplication (frontmatter version + 디렉토리명 + ROADMAP milestones[].version + git tag + GitHub Release tag) redundancy 의문. 두 본질 = milestone version mechanism 단일 본질 안 자연 통합. 본 milestone 진행 자체 = ## SUB_MILESTONES 섹션 첫 실 활용 cycle dogfood evidence direct (v6.2~v6.22 모두 '부재' 패턴 누적).",
  "success_criteria": [
    {"id": "sc_1", "criterion": "v6.23.1 bundling cycle 재개 평가 outcome 1 결정 도달 (재개 / 부분 재개 / 유지 중 하나, 사용자 명시 결정 게이트 통과)"},
    {"id": "sc_2", "criterion": "v6.23.2 git tag 단일 source 평가 outcome 1 결정 도달 (5 source 안 보존 source count N 결정, N ∈ {1,2,3,4,5}, 사용자 명시 결정 게이트 통과)"},
    {"id": "sc_3", "criterion": "ARCHITECTURE.md paragraph 1건+ 정전화 — bundling 본질 = § 4.1 1차 host, git tag 본질 = § 6.1 후보 (정확 host DESIGN 결정 자연)"},
    {"id": "sc_4", "criterion": "lightweight 1-phase 본질 보존 (v6.6~v6.22 14 consec + v6.23 = 15 consec 연장)"},
    {"id": "sc_5", "criterion": "## SUB_MILESTONES 섹션 첫 실 활용 cycle dogfood evidence direct capture (REPORT lessons 안 1+ trace)"},
    {"id": "sc_6", "criterion": "5 관점 review pass (decisive 0, inline 또는 subagent — review-cycle-cost-marginal-default-decision next_candidate trigger 후 결정 자연)"},
    {"id": "sc_7", "criterion": "smoke 전체 PASS (smoke-spec-verification + smoke-entry-title-guideline + cascade-drift 외 active smoke)"}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "실 적용 (frontmatter version 필드 제거 / 디렉토리명 정책 변경 / bundling cycle 재개 후 v6.23.X sub 흡수 등) — 평가 outcome 따라 별 milestone v6.24+ 자연 분기. 본 milestone 사용자 명시 round 1 결정 = lightweight scope 정합."},
    {"id": "oos_2", "item": "역행 (retroactive bundling — 기존 v6.16~v6.22 7 micro milestone 흡수) 본질 — 평가 outcome 안 옵션 narrative 만 (실 흡수는 별 milestone 결정 자연)."},
    {"id": "oos_3", "item": "5 source 안 GitHub Release tag 제거 본질 — v6.19 외부 visible artifact 본질 보존 자연 (Release UI source 본질 = git tag 1:1 매핑, 제거 시 v6.19 자산 손실)."}
  ],
  "dependencies": [
    {"id": "dep_1", "ref": "v3.0_milestones-restructure (2026-05-10) — 9-stage-bundled era 도입 + bundling trigger 정책 정전화", "purpose": "v6.23.1 bundling cycle 재개 평가 본질 origin source — bundling 본질 (의미 단위 확대 + version 단위 1 milestone + sub-milestone phase 매핑) 정전화 paragraph 참조."},
    {"id": "dep_2", "ref": "v3.6_overengineering-audit (2026-05-11) — lightweight 모드 도입 + workflow self-improvement 동결 정책", "purpose": "v6.23.1 bundling cycle 본질 ↔ lightweight 모드 본질 상충 가능성 평가 source — v3.6 후 v6.16~v6.22 lightweight 14 consec 자연 forward-only 본질."},
    {"id": "dep_3", "ref": "v4.0_harness-composer-pivot (2026-05-13) — 정체성 § 3.1 정전화 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer)", "purpose": "v6.23.1 bundling 본질 ↔ § 3.1 정체성 가드레일 안 부합도 평가 source — workflow 변경 본질 정체성 자연 부합 여부."},
    {"id": "dep_4", "ref": "v6.2_milestone-artifact-directory-flattening (2026-05-19) — 9-stage-flattened era 도입 + MILESTONE.md 단일 본책 + execute/ 별책", "purpose": "v6.23 본질 = ## SUB_MILESTONES 섹션 첫 실 활용 cycle (v6.2 도입 후 v6.22 까지 '부재' 패턴 누적). v6.23.1 bundling 본질 ↔ flattened era ## SUB_MILESTONES 본질 자연 통합 evidence direct."},
    {"id": "dep_5", "ref": "v6.19 GitHub Release mechanism — git tag 자동 발급 본질 도입", "purpose": "v6.23.2 git tag 단일 source 평가 본질 origin source — v6.19 mechanism 도입 후 5 source duplication 본질 자연 발견 evidence."},
    {"id": "dep_6", "ref": "ROADMAP candidate_draft[] 2 entry promote (milestone-bundling-cycle-resumption + github-tag-as-single-version-source, 2026-05-22)", "purpose": "본 milestone OPEN 직접 origin — 사용자 명시 3 본질 결정 (scope lightweight + 1 goal 통합 + narrative 정전화 포함) 후 promote 결정."}
  ]
}
```

### Narrative

본 milestone (v6.23) 은 **milestone version mechanism 본질 통합 재고 lightweight 1 cycle** — 두 sub-milestone 본질 (v6.23.1 bundling cycle 재개 평가 + v6.23.2 git tag 단일 version source 평가) 이 milestone version mechanism 단일 본질 안 자연 통합. `/propose-next` mechanism 평가 도중 사용자 명시 3 본질 결정 (2026-05-22, scope lightweight + goal 1 통합 + narrative 정전화 포함) 후 candidate_draft[] 2 entry promote origin 직접.

**Origin 본질** (2 sub-milestone → MILESTONE.md ## SUB_MILESTONES 자연 통합):

- **v6.23.1 bundling cycle 재개 평가**: v3.0_milestones-restructure (2026-05-10) 도입 후 v3.6_overengineering-audit (2026-05-11) lightweight 모드 정착 + v4.0_harness-composer-pivot (2026-05-13) 정체성 § 3.1 정전화 후 forward-only forsake 본질. v6.16~v6.22 7 micro milestone (각 1-3 commit + 1-phase 평균 = 1:1 매핑) 누적 → v3.0+ 9-stage-bundled era 본질 자연 trigger 발생. 평가 outcome = 재개 / 부분 재개 / 유지 중 결정 본질.
- **v6.23.2 git tag 단일 version source 평가**: v6.19 GitHub Release mechanism 도입 후 git tag 자동 발급 본질 도달 → 5 source duplication (frontmatter version + 디렉토리명 `milestones/v{X.Y}/` + ROADMAP `milestones[].version` + git tag + GitHub Release tag) redundancy 의문. 평가 outcome = 5 source 안 보존 source count N 결정 본질 (N ∈ {1..5}).

**자기참조 도그푸드 본질** — 본 milestone 진행 자체 = ## SUB_MILESTONES 섹션 첫 실 활용 cycle (v6.2_milestone-artifact-directory-flattening 도입 후 v6.22 까지 '부재' 패턴 누적). v6.23.1 bundling 본질 평가 cycle 안 ## SUB_MILESTONES 섹션 실 활용 evidence direct (자기참조 cycle, v6.16 시범 → v6.17 cycle 1 → v6.22 cycle 2 stage skill 도그푸드 패턴 정합).

**Scope 본질** (사용자 명시 round 1 결정, 권장) — 평가 + 결정만 (lightweight 1-phase v6.6~v6.22 14 consec 연장 → 15 consec). 실 적용 (frontmatter version 필드 제거 / 디렉토리명 변경 / bundling cycle 재개 후 v6.23.X sub 흡수 등) 은 결정 outcome 따라 별 milestone v6.24+ 자연 분기 — `oos_1` 정합. 잘못 결정 후 churn 회피 본질.

**Narrative 정전화 본질** (사용자 명시 round 3 결정, 권장) — 평가 outcome 결정 후 ARCHITECTURE.md paragraph 1건+ 정전화. bundling 본질 = § 4.1 1차 host 명확 (현 188 line 부터 bundling 정책 정전 단일 source), git tag 본질 = § 6.1 era 정책 후보 (version mechanism 정합) — 정확 host 위치는 DESIGN 단계 결정 자연. v6.6~v6.22 lightweight 패턴 정합 (1-phase 1+1 commit = phase commit + sync/cascade commit 본질 자연).

## RESEARCH

(미작성 — Stage C RESEARCH 에서 작성)

## DESIGN

(미작성 — Stage D DESIGN 에서 작성)

## APPROVE

(미작성 — Stage E APPROVE 에서 사용자 명시 승인)

## EXECUTE

(미작성 — Stage F EXECUTE 에서 phase 별 작성. 본책 = phase 진행 요약, 별책 = `execute/phase-{n}.md`)

## VERIFY

(미작성 — Stage G VERIFY 에서 작성)

## REPORT

(미작성 — Stage H REPORT 에서 작성)

## PROPOSE

(미작성 — Stage I PROPOSE 에서 작성)

## SUB_MILESTONES

본 milestone = **2 sub-milestone 통합 본질** (v6.2+ flattened era ## SUB_MILESTONES 첫 실 활용 cycle, v6.2~v6.22 모두 "부재" 패턴 누적 후 본 cycle 자체가 도그푸드 자연). 두 본질 = version mechanism 단일 본질 안 자연 통합 — bundling cycle 재개 (의미 단위 확대) + git tag 단일 source (version 표기 정리) = 모두 milestone version mechanism 정합 본질.

### v6.23.1 — milestone bundling cycle 재개 평가

- **origin**: candidate_draft[] entry `milestone-bundling-cycle-resumption` (2026-05-22 promote, 사용자 명시 결정)
- **본질**: v6.16~v6.22 7 micro milestone 누적 패턴 (각 1-3 commit + 1-phase 평균 = 1:1 매핑) → v3.0+ 9-stage-bundled era 본질 자연 trigger. version 단위 1 milestone + sub-milestone phase 매핑 본질 resume 결정.
- **scope**: bundling trigger 본질 재정의 (현 forward-only forsake 본질 backlash 평가) + retroactive bundling 본질 vs forward bundling 본질 분기 + milestones.md 컨테이너 본질 재도입 평가 + v6.2+ flattened era ↔ bundled era cohabitation 본질.

### v6.23.2 — git tag 단일 version source migration 평가

- **origin**: candidate_draft[] entry `github-tag-as-single-version-source` (2026-05-22 promote, 사용자 명시 결정)
- **본질**: 현 5 source duplication (frontmatter version + 디렉토리 명 milestones/v{X.Y}/ + ROADMAP milestones[].version + git tag + GitHub Release tag) = v6.19 mechanism 도입 후 GitHub tag 자동 발급 본질 도달 → 로컬 version 관리 redundancy 본질 의문.
- **scope**: frontmatter version 필드 제거 본질 가능성 + smoke schema 영향 분석 + ROADMAP milestones[].version 동기 본질 자동화 (git tag → ROADMAP sync mechanism) + 디렉토리 명 source-of-truth 본질 결정 + 5 source 안 어디까지 제거 가능 + 어디는 trace 본질 보존 결정.

**자기참조 도그푸드 본질** — 본 milestone 본질 = ## SUB_MILESTONES 섹션 첫 실 활용 cycle 자체가 v6.23.1 (bundling cycle 재개) 평가 evidence direct. 본 milestone 진행 자체 = bundling 본질 실 활용 evidence direct (자기참조 cycle, v6.16 시범 → v6.17 cycle 1 → v6.22 cycle 2 stage skill 도그푸드 패턴 정합).
