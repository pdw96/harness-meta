---
id: changelog-header-path-drift-reconcile
title: CHANGELOG 헤더의 v8.0 meta 경로 drift 정합
version: v8.14
status: completed
---

# v8.14 — CHANGELOG 헤더의 v8.0 meta 경로 drift 정합

## 문제

CHANGELOG.md 헤더(line 3) 의 navigation pointer 가 v8.0_reclassify-meta-as-development (meta 를 `projects/meta/` → `development/` 재분류) 이후 깨진 경로 `projects/meta/milestones/v{X.Y}/REPORT.md` 를 가리킨다. v8.13 archival 정합 검토 중 사용자 요청("CHANGELOG 정합 반영 필요한지 확인")으로 부수 발견됐다. backtick 안 경로라 `smoke-cross-ref` 의 검출 범위 밖(코드 블록/backtick 제외 spec)이라 v8.0 이후 잠복했다.

scope 구분 — 헤더 line 3 은 독자가 detail 기록을 찾는 **CURRENT 운영 pointer** 라 해소 대상. line 29/103/152/390+ 등 `projects/meta/` 참조는 모두 **날짜 있는 historical CHANGELOG entry 내부 서술** = Keep a Changelog append-only 불변 기록 + v8.0 이 milestone-내부 historical ref 를 보존한 원칙과 동일 → scope 외 (historical 보존).

## 결정

가벼운 흐름 (좁은 mechanical 문서 수정, 컨설팅 자산 무영향 — 승격 기준상 작은 건). v8.13(큰 건, archival 메커니즘) scope 에 끼우면 scope 오염이라 별 milestone 분리.

수정 = 헤더 line 3 경로를 `development/milestones/` 로 정합하되 era 정확도 동반 보강 — v6.2+ 9-stage-flattened era(MILESTONE.md `## REPORT`) 가 헤더에 누락돼 있어 함께 추가 + v6.20+ release note 단일 source = GitHub Releases note 추가 (헤더가 "where to find detail" 정확히 가리키도록). dated entry 내부 ref 는 무손상.

## 적용

- `CHANGELOG.md:3` (edit) — navigation pointer 경로 `projects/meta/milestones/` → `development/milestones/` 정합 + v6.2+ flattened era(MILESTONE.md ## REPORT) 명시 추가 + v6.20+ GitHub Releases 단일 source note 추가.
- commit: `docs(meta): [v8.14] CHANGELOG 헤더 v8.0 meta 경로 drift 정합` (SHA pending)

## 기록

검증 = `smoke-cross-ref` + `smoke-spec-verification` + `smoke-open-stage-discipline` + `smoke-bundle-trigger` PASS 기대 (LIGHTWEIGHT.md 4 섹션 + ROADMAP entry 형식). 본 수정은 backtick 밖 경로가 아니라 헤더 prose 라 cross-ref 영향 없음.

교훈 = backtick 안 경로 참조는 `smoke-cross-ref`(코드/backtick 제외)가 못 잡아 v8.0 같은 대규모 경로 이동 시 잠복한다 — 향후 대규모 디렉토리 이동 시 backtick 경로도 수동 grep 점검 필요(자동 검출 밖). 후속 자연 = 없음 (dated historical entry 내부 ref 는 의도적 보존).
