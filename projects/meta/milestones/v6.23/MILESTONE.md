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

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "SemVer (semver.org) — MAJOR.MINOR.PATCH semantic 본질", "finding": "1.0.0 정전화 (v6.23 = MAJOR 6 + MINOR 23). git tag annotated tag recommended. 직접 context7 query 부재 (lightweight scope) — version semantic 본질 거명만."},
    {"id": "ext_2", "source": "Keep a Changelog v1.1.0 표준", "finding": "CHANGELOG entry version 단일 source 본질. 본 repo CHANGELOG.md 안 v1.0~v5.21 archived 1줄 단축 + v6.0~v6.18 full entry + v6.19+ Releases 단일 source (cb_5 정합) — archival cycle 2 evidence (v5.21 + v6.19) 표준 정합."},
    {"id": "ext_3", "source": "Anthropic Claude Code spec — milestone version mechanism 패턴", "finding": "first-class 'milestone version mechanism' 패턴 부재 (v5.7 spec-drift spike 패턴 (c) 자체 정전화 분기 자연 정합). 본 repo 자체 컨벤션 본질 — version mechanism 정전 단일 source = ARCHITECTURE § 4.1 + § 6.1 + § 4 끝 매트릭스 #13 (cb_1/cb_2/cb_5)."}
  ],
  "codebase": [
    {"id": "cb_1", "ref": "projects/meta/ARCHITECTURE.md:186-200 § 4.1 Bundling paragraph", "finding": "bundling 정책 정전 1차 source — version 단위 1 milestone + sub-milestone phase 매핑 + milestones.md per version 위임. v6.23.1 평가 본질 1차 reference."},
    {"id": "cb_2", "ref": "projects/meta/ARCHITECTURE.md:230 § 6.1 v6.2 flattened era 정전화 paragraph", "finding": "직접 인용: 'bundling 본질 보존 (era 명명 분리 ≠ bundling 정책 폐기) — ## SUB_MILESTONES 섹션 안 흡수'. **misnomer evidence 1차 source** — INTENT motivation 안 'forward-only forsake' 표현 = 잘못된 인식 가능성 evidence direct."},
    {"id": "cb_3", "ref": "projects/meta/ARCHITECTURE.md:238 § 6.1 1-phase 정합 paragraph (v3.18 정전화)", "finding": "직접 인용: 'bundling 의미 grouping 본질 = 후속 candidates 가 ≥2 건일 때 자연 활용 도구, 단일 후속 시 1-phase 강제 분할 부재'. v6.16~v6.22 = 각 단일 후속 → 1-phase 자연 (강제 분할 부재 정합) + bundling cycle dormant 상태. **misnomer evidence 2차 source**."},
    {"id": "cb_4", "ref": "projects/meta/milestones/v6.16~v6.22/execute/ phase 실 카운트", "finding": "v6.16:2 / v6.17:1 / v6.18:1 / v6.19:2 / v6.20:3 / v6.21:1 / v6.22:1. 평균 1.57 phase + 1-phase 비율 5/7 ≈ 71.4%. ## SUB_MILESTONES 섹션 활용 0/7 = bundling cycle dormant 직접 evidence. INTENT motivation 안 '1-3 commit + 1-phase 평균 = 1:1 매핑' 표현 정합 (≈ 1:1 매핑 본질 정확)."},
    {"id": "cb_5", "ref": "projects/meta/ARCHITECTURE.md:180 § 4 끝 매트릭스 #13 row + paragraph (v6.19 정전화)", "finding": "v6.19 GitHub Release mechanism 정전 1차 source. commit msg marker `[release:v{X.Y}]` → git tag push --follow-tags → `gh release create --notes-file --target ${{ github.sha }}` workflow. 5 source 안 git tag + GitHub Release 자동 발급 본질 = 사용자 commit marker 통제 → 외부 1건 자동 발급."},
    {"id": "cb_6", "ref": "tests/smoke-spec-verification.sh:174,181", "finding": "frontmatter_required = ['id','title','version','stage','status'] (v3.0~v6.1 bundled era). v6.2+ flattened era 안 stage 제거 = 4 필드 (id/title/version/status). frontmatter `version` 필드 smoke 강제 — opt_5 (N=4 frontmatter version 제거) 채택 시 smoke 동기 변경 의무."},
    {"id": "cb_7", "ref": "5 source duplication 위치 (실 매핑)", "finding": "(1) frontmatter version → MILESTONE.md YAML (smoke 강제 cb_6) / (2) 디렉토리명 → projects/meta/milestones/v{X.Y}/ (smoke era detect 1차 source, tests/_era_detect.py) / (3) ROADMAP version → projects/meta/ROADMAP.md milestones[].version (propose_next + smoke-candidate-draft-schema 의존) / (4) git tag → release-publish.yml workflow 자동 발급 (cb_5) / (5) GitHub Release tag → gh release create 자동 발급 (git tag 1:1 매핑, cb_5). source 간 우선순위 narrative 부재 (risk_7)."},
    {"id": "cb_8", "ref": "projects/meta/milestones/v6.2~v6.22/ MILESTONE.md ## SUB_MILESTONES 패턴", "finding": "v6.2~v6.22 21 milestone 안 ## SUB_MILESTONES 섹션 활용 0. v6.23 = 첫 실 활용 cycle (자기참조 dogfood evidence direct). v6.2 era 도입 후 21 milestone dormant 상태 = bundling cycle dormant 본질 evidence 정합 (cb_2/cb_3/cb_4)."}
  ],
  "options": [
    {"id": "opt_1", "label": "v6.23.1-A 적극 활용 (bundling 적극 발의 본질 표준화)", "rationale": "## SUB_MILESTONES 활용 본질 표준화 + bundling 적극 발의 trigger 조건 narrative 정전화. evidence base = v6.23 자체 첫 활용 cycle. 단 v6.16~v6.22 micro milestone 자연 분리 본질 ↔ 적극 bundling 본질 충돌 위험 (risk_1, lightweight 1-phase 패턴 단절)."},
    {"id": "opt_2", "label": "v6.23.1-B 자연 발현 (현행 본질 명문화 — ≥2 sub trigger 시만)", "rationale": "cb_3 정전 본질 정확 정합 — '후속 candidates ≥2 건일 때 자연 활용 도구'. v6.16~v6.22 = 각 단일 본질 → 1-phase 자연 + v6.23 = ≥2 sub 자연 발현 → ## SUB_MILESTONES 활용. 현행 본질 명문화 + misnomer evidence 흡수. lightweight 정합."},
    {"id": "opt_3", "label": "v6.23.1-C 명시 표지 부재 (현행 미명시 본질 보존)", "rationale": "ARCHITECTURE narrative 변경 부재 + v6.23 활용 자체는 dogfood evidence direct (사실 진술만). 가장 lightweight 이나 misnomer evidence 흡수 부재 + 후속 cycle 안 같은 misnomer 반복 risk."},
    {"id": "opt_4", "label": "v6.23.2-A N=5 (현행 유지, 5 source duplication 인정)", "rationale": "trace 다중 본질 보존 + 변경 부재 churn 회피. risk_7 narrative 보강 (source-of-truth 우선순위 정전화) 동시 가능 — 5 source 본질 명문화 + 우선순위 정전화로 redundancy 인정 본질 정합."},
    {"id": "opt_5", "label": "v6.23.2-B N=4 (frontmatter version 제거)", "rationale": "smoke-spec-verification.sh frontmatter_required 4 → 3 필드 (id/title/status 보존, version 제거). frontmatter 안 version 본질 = 디렉토리명 직접 매핑 자연 (smoke 안 디렉토리명 추출). 단 smoke breaking change + 28 active milestone backfill 부담 (risk_4)."},
    {"id": "opt_6", "label": "v6.23.2-C N=3 (frontmatter + ROADMAP version 제거)", "rationale": "디렉토리명 + git tag + GitHub Release 3 source. ROADMAP milestones[].version 제거 시 propose_next + smoke-candidate-draft-schema + next_candidates target_version 본질 자연 매핑 동기 변경 의무 (risk_5). breaking change scope 확장."},
    {"id": "opt_7", "label": "v6.23.2-D N=2 또는 N=1 (extreme, 디렉토리명 제거)", "rationale": "source path 본질 부적합 — 디렉토리명 = smoke + cascade_sync + tests/_era_detect.py 의존 source. rejected default (본질 부적합)."}
  ],
  "risks_identified": [
    {"id": "risk_1", "description": "opt_1 (적극 활용) 채택 시 v6.16~v6.22 micro milestone 자연 분리 패턴 회귀 — 단일 후속도 ## SUB_MILESTONES 강제 활용 = lightweight 1-phase 패턴 단절", "mitigation": "opt_2 (자연 발현) 우선 채택 — ≥2 sub trigger 자연 발현 시만 활용 = lightweight 1-phase 본질 보존 + cb_3 정합. v6.23 자체 = ≥2 sub 자연 발현 evidence direct."},
    {"id": "risk_2", "description": "bundling narrative 변경 시 ## SUB_MILESTONES (v6.2+ flattened) vs milestones.md (v3.0~v6.1 bundled) dual era 충돌", "mitigation": "cb_2 정합 — v6.2 era 도입 시 이미 ## SUB_MILESTONES 안 bundling 본질 흡수 정전. era 정책 변경 부재 자연 (forward-only 정책 일관)."},
    {"id": "risk_3", "description": "git tag = source-of-truth 결정 (opt_5/opt_6) 채택 시 디렉토리명 mismatch 회귀 위험 (예: 디렉토리 v6.23 vs tag v6.23.1)", "mitigation": "디렉토리명 = primary source path 본질 보존 (smoke era detect + cascade_sync 의존). git tag 발급 시 디렉토리명 1:1 매핑 강제 narrative 정전화."},
    {"id": "risk_4", "description": "opt_5 (frontmatter version 제거) 채택 시 smoke 의존 회귀 — smoke-spec-verification.sh + cascade_sync.py + 28 active milestone backfill 부담", "mitigation": "opt_5 채택 시 smoke + cascade_sync 동기 변경 의무 + backfill cycle (v5.21 + v6.19 archival 패턴 정합)."},
    {"id": "risk_5", "description": "opt_6 (ROADMAP version 제거) 채택 시 propose_next mechanism + next_candidates target_version 자연 매핑 영향", "mitigation": "opt_6 채택 시 propose_next + smoke-candidate-draft-schema 동기 변경 의무 + ROADMAP entry 안 version 부재 시 디렉토리명 cross-ref 의존 narrative 정전화."},
    {"id": "risk_6", "description": "ARCHITECTURE narrative 정전화 (sc_3) 시 cascade host drift — § 4.1 + § 6.1 + § 4 끝 매트릭스 + CLAUDE.md root + 모듈 + tests/CLAUDE.md 잠재 host 다중", "mitigation": "v3.21 narrative 정전화 3 단계 패턴 자연 적용 — (a) DESIGN 1차 source 식별 + (b) EXECUTE Edit cascade + (c) VERIFY grep. v6.4 cascade-sync mechanism marker 적용 시 자동 검증 가능."},
    {"id": "risk_7", "description": "5 source 안 source-of-truth 우선순위 부재 (cb_7) — v6.19 paragraph 안 명시 부재", "mitigation": "ARCHITECTURE § 6.1 또는 § 4 끝 안 우선순위 narrative 정전화 (sc_3 정합) — 디렉토리명 = primary / frontmatter = redundant trace / ROADMAP = forward-looking trace / git tag = release trigger / GitHub Release = external visible trace 본질 명문화."}
  ]
}
```

### Narrative

본 RESEARCH 안 4 본질 (external 3 + codebase 8 + options 7 + risks_identified 7) 조사 outcome — v6.23.1 (bundling cycle) + v6.23.2 (git tag 단일 source) 평가 본질 evidence 직접 1차 source 인용 본위.

**핵심 finding 1: 'forward-only forsake' misnomer evidence** — INTENT motivation 안 표현 'v3.6/v4.0 후 forward-only forsake 본질' 은 cb_2/cb_3 정전 본질과 부분 정합. ARCHITECTURE § 6.1 안 v6.2 flattened era 정전화 paragraph (cb_2) 안 직접 인용: *'bundling 본질 보존 (era 명명 분리 ≠ bundling 정책 폐기) — ## SUB_MILESTONES 섹션 안 흡수'*. § 6.1 1-phase 정합 paragraph (cb_3) 안 직접 인용: *'bundling 의미 grouping 본질 = 후속 candidates 가 ≥2 건일 때 자연 활용 도구, 단일 후속 시 1-phase 강제 분할 부재'*. v6.16~v6.22 7 micro milestone (cb_4 통계 = 평균 1.57 phase / 1-phase 71.4% / ## SUB_MILESTONES 활용 0/7) = 각 단일 후속 → 1-phase 자연 (cb_3 정합) + bundling cycle dormant 상태 evidence direct. **실 본질** = bundling cycle 폐기 아님 (= dormant 도구) + v6.23 = 첫 ≥2 sub 자연 발현 cycle = ## SUB_MILESTONES 첫 실 활용. v6.23.1 옵션 narrative 재정의 자연 (재개 → opt_1 적극 활용 / 부분 → opt_2 자연 발현 = 현행 본질 명문화 / 유지 → opt_3 명시 표지 부재).

**핵심 finding 2: 5 source duplication 위치 + source-of-truth 우선순위 부재** — cb_5/cb_7 정합. 5 source = (1) frontmatter version + (2) 디렉토리명 + (3) ROADMAP milestones[].version + (4) git tag + (5) GitHub Release tag. v6.19 GitHub Release mechanism 도입 후 git tag + GitHub Release 2 source = 사용자 commit marker `[release:v{X.Y}]` 통제 → 자동 발급 (cb_5). 단 5 source 간 우선순위 narrative 부재 (risk_7). opt_4 (현행 N=5 유지) lightweight 정합 + risk_7 narrative 보강 (우선순위 정전화) 동시 가능. opt_5/opt_6 (frontmatter 또는 ROADMAP version 제거) 채택 시 smoke + cascade_sync + 28 active milestone backfill 부담 (risk_4/risk_5).

**Options 채택 분기 narrative** (DESIGN 결정 자연):

- v6.23.1: **opt_2 (자연 발현 = 현행 본질 명문화) 우선 lightweight + misnomer evidence 흡수 정합**. opt_1 (적극 활용) = lightweight 1-phase 패턴 단절 위험 (risk_1). opt_3 (명시 표지 부재) = misnomer evidence 흡수 부재 + 후속 cycle 같은 misnomer 반복 risk.
- v6.23.2: **opt_4 (N=5 현행 유지) 우선 lightweight + risk_7 우선순위 narrative 정전화 동시 가능**. opt_5/opt_6 = breaking change scope 확장 + smoke + cascade_sync 동기 변경 의무. opt_7 (extreme N=2/N=1) = source path 본질 부적합 (rejected default).

**External spec 부재 본질** — Anthropic Claude Code spec 안 first-class 'milestone version mechanism' 패턴 부재 (ext_3, v5.7 spec-drift spike (c) 자체 정전화 분기 자연 정합). SemVer + Keep a Changelog 표준 거명만 (직접 query 부재, lightweight scope 정합). 본 repo 자체 컨벤션 본질 = ARCHITECTURE § 4.1 + § 6.1 + § 4 끝 매트릭스 #13 단일 source (cb_1/cb_2/cb_5).

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
