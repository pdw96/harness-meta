# v8.4 phase-1 — 이종 하네스 충돌 판정 보강

## Changes

3 파일 mechanical edit (DESIGN D1~D3 정합):

1. **`bootstrap/agents/CLAUDE.md`** (충돌 매트릭스 1차 source) — Conflict Resolution 4 case 섹션과 Agent Fleet Lifecycle 섹션 사이에 `## 이종 하네스 충돌 회피 판정 (v8.4, e3 정책)` 신규 섹션 추가. 기존 4 case 표 불변(D1). `harness_kind` 4 값(heterogeneous/harness-meta/mixed/blank) 권장 결정 표 + Task 2 선행 명시 + 도구명 비종속 원칙형 origin narrative(D3).

2. **`agents/harness-gap-analyzer.md`** — Task 2 와 Task 3 사이에 `### Task 2.5 — 이종 하네스 충돌 회피 판정 (Task 2 이전 선행, v8.4)` 추가. bootstrap 1차 source 재게재 + 단일 source 정합 명시(sc_3) + heterogeneous 판정 시 Task 1/2 결과 '충돌 회피 lens' 재평가 지시.

3. **`agents/project-scanner.md`** — Task 2(Harness 현 상태)에 harness_kind 추정 규칙 1줄(D2) + Output Format JSON `harness_state` 에 `"harness_kind": "heterogeneous"` 필드 추가(추정 힌트, 강제 아님 — oos_2).

## Commit

`feat(meta): [v8.4] audit-team 이종 하네스 충돌 판정 보강` (pending — VERIFY 후 사용자 커밋 승인 게이트).
