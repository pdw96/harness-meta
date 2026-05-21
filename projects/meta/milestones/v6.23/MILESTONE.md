---
id: version-mechanism-integration-rethink
title: version mechanism 통합 재고
version: v6.23
status: open
---

# v6.23 — version mechanism 통합 재고

## INTENT

(미작성 — Stage B INTENT 에서 작성)

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
