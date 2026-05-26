---
id: research-cascade-grep-discipline
title: RESEARCH cascade host grep 3 형식 규율 보강
version: v8.2
status: completed
---

# v8.2 — RESEARCH cascade host grep 3 형식 규율 보강

> 본 milestone = harness-meta 첫 **가벼운 흐름** (4 섹션 트랙, ARCHITECTURE § 7.4) 산출물 — v8.1 도그푸드. 작은 mechanical 보강 (skill 1 곳 grep 규율 1 블록) 이라 9-stage 무거운 절차 대신 4 섹션 한 장으로 처리.

## 문제

deferred `v1.5_research-cascade-grep-discipline` (B_regression, v1.4 lessons #1 origin) — RESEARCH 단계에서 cascade host (1차 source ↔ host narrative) 를 grep enumerate 할 때 **relative path** (`../ARCHITECTURE.md`) 1건이 누락되어 cascade host 1건이 미검출됐다. 동결 정책 (자기참조 milestone 동결) 으로 v3.13/v3.14 이후 deferred 보존돼 왔으나, v8.1 에서 동결 정책이 은퇴하고 가벼운 흐름 창구가 열리면서 — 좁은 mechanical 보강 (큰 건 아님) 으로 재분류되어 본 가벼운 흐름의 도그푸드 대상이 됐다 (v8.1 d_7).

scope = RESEARCH 시 cascade host grep 패턴이 relative + 절대 + symlink/anchor 3 형식을 모두 커버하도록 규율 1 줄 명문화. (자산 변경 아닌 기존 skill 보강 = 가벼운 흐름 적격, v8.1 § 7.4 승격 기준 정합.)

## 결정

`skills/stage-research/SKILL.md` 의 `## 입력` 안 'cascade host 조사 grep 규율' 블록을 추가한다 — host enumerate grep 이 (1) relative path / (2) 절대·repo-root path / (3) symlink·anchor 변형 3 형식 모두 커버 의무 명시.

근거: v6.4 `cascade_sync.py` (marker 기반 자동 동기) 가 marker-있는 host 는 cover 하나, **marker 미부착 narrative host enumerate 는 여전히 manual grep** — 따라서 manual grep 패턴 규율이 여전히 유효 (자동화로 완전 대체되지 않음). 단 큰 건 (RESEARCH 템플릿 schema 변경 / claude/commands/harness-meta.md 분기 재작성) 은 불필요 — skill checklist 1 블록이면 충분 (가벼운 흐름 적정 scope).

## 적용

변경 1 건:

- `skills/stage-research/SKILL.md` `## 입력` — '★ cascade host 조사 grep 규율 (v8.2 가벼운 흐름 — deferred v1.5 해소)' 블록 추가. 3 형식 (relative / 절대·repo-root / symlink·anchor) + v1.4 lessons #1 origin + `cascade_sync.py` marker 자동화 보완 관계 + `grep -rE '\.\./|development/|#'` 패턴 예시.

commit: phase-2 안 통합 (pending → 사용자 commit 승인 후 갱신).

## 기록

**검증** — `bash tests/smoke-cross-ref.sh` PASS (stage-research SKILL.md 안 신규 링크 부재, 기존 cross-ref 무손상) + `pre-commit run --all-files` 18 hook PASS. 본 LIGHTWEIGHT.md 자체가 `tests/smoke-spec-verification.sh` 4-section-lightweight era 검증 (frontmatter 4 필드 + ## 문제/## 결정/## 적용/## 기록) 통과 = v8.1 sc_5 (가벼운 흐름 mechanism 실작동) 직접 입증. `tests/_era_detect.py` 가 본 디렉토리 (`development/milestones/v8.2/`, LIGHTWEIGHT.md 존재 + MILESTONE.md 부재) 를 `4-section-lightweight` 로 식별.

**교훈** — (1) 가벼운 흐름 첫 도그푸드가 실제 deferred 1건을 해소 = 자산 설계 + meta 검증 동시 달성 (v8.1 범위 정합). (2) 9-stage 였다면 INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE 8 섹션 ceremony 가 필요했을 'skill 1 줄 보강' 이 4 섹션 한 장으로 압축 — v6.23 표본 (9-stage 산출이 자기 장부정리 문단 1개) 의 본말전도 해소 직접 evidence.

**후속** — deferred 잔여 2건 (`v1.4_hook-narrative-separation` / `v1.4_design-review-trace`) 은 v8.1 phase-2 에서 next_candidates 로 전환 (실 처리 아님). 본 v8.2 는 v1.5 1건만 도그푸드 해소. cascade host 조사가 향후 marker 전면 부착으로 완전 자동화되면 본 manual grep 규율은 자연 dormant (별 가벼운 흐름 candidate 자연).
