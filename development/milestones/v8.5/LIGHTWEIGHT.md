---
id: price-compare-reaudit-conflict-verification
title: price-compare 실 재audit으로 v8.4 충돌 판정 실효 검증
version: v8.5
status: completed
---

# v8.5 — price-compare 실 재audit으로 v8.4 충돌 판정 실효 검증

> 본 milestone = **가벼운 흐름** (4 섹션 트랙, ARCHITECTURE § 7.4) 산출물. audit-team(컨설팅 자산)을 **돌려 검증한 관찰 trace** 이지 자산 자체의 변경이 아니므로 9-stage 아닌 4 섹션 한 장으로 처리 (v8.3 외부 적용 trace 선례 정합).

## 문제

v8.4(audit-team 이종 하네스 충돌 판정 보강)는 sc_4 를 **narrative 시뮬레이션**으로만 검증하고, 실 재audit 은 oos_3 로 `verification-philosophy-redefine` 후속에 분리했다 — "1건 사례 과적합 회피, 실 재적용은 후속". v8.4 PROPOSE `follow_up_natural` 도 동일하게 "price-compare 실 재audit 시 본 보강(Task 2.5)의 실효를 외부 vector 로 검증" 을 named.

사용자 발의로 그 실 검증을 수행했다. 핵심 제약: v8.3 에서 사용자 결정으로 **gsd(get-shit-done-cc)를 완전 삭제**(외부 커밋 `905e80f`)했으므로, v8.4 Task 2.5 가 겨냥한 heterogeneous 충돌(gsd vs harness-meta 권고) 시나리오는 현재 HEAD(`14bb1a3`)에 더는 존재하지 않는다. heterogeneous 상태는 gsd 제거 직전 커밋 `abfc174` 에만 보존됨.

## 결정

1. **두 상태 대조 audit** (사용자 결정) — (a) `abfc174` heterogeneous 상태(발화 기대) + (b) HEAD `14bb1a3` gsd-제거 상태(비발화 기대). 단일 상태가 아닌 대조로 "보강이 상태에 따라 정확히 분기" 함을 입증 (false positive/negative 양쪽 점검).
2. **비파괴 검증** — `abfc174` 는 `git worktree add` 로 격리 체크아웃(사용자 작업트리 `14bb1a3` 무손상). audit 산출물은 외부 repo working tree 아닌 임시 `.audit-output/` 에만.
3. **full audit-orchestrator chain** (사용자 결정) — Step 1~4 read-only 5멤버 전 chain. **Step 5(component-installer) 미spawn** (USER DECISION GATE 직전 정지, 외부 repo write/install 0).
4. **자산 변경 없음** — 본 작업은 검증 관찰 trace. audit-team mechanism 은 v8.4 에서 이미 보강 완료, 본 milestone 은 그 실효 확인만.

## 적용

검증 실행 (harness-meta repo 외부 — 산출물 trace 만 본 LIGHTWEIGHT.md):

- `git worktree add ~/pc-audit-hetero abfc174` → heterogeneous 상태 격리 체크아웃
- audit-orchestrator × 2 병렬 (heterogeneous worktree + HEAD) — 각 Step 1~4 read-only + Step 6 fact-verify, Step 5 미spawn
- 검증 후 `git worktree remove --force ~/pc-audit-hetero` + 양쪽 `.audit-output/` 제거 → 외부 repo 원상복구

harness-meta repo (본 trace):

- `development/milestones/v8.5/LIGHTWEIGHT.md` (본 파일)
- `development/ROADMAP.md` — `milestones[]` v8.5 entry + `updated` 갱신

## 기록

**검증 결과 (대조 audit)** — 보강이 상태에 따라 정확히 분기함이 실 외부 vector 에서 확인됨:

| 초점 | abfc174 (heterogeneous) | HEAD 14bb1a3 (gsd 제거) |
| --- | --- | --- |
| (A) harness_kind | `heterogeneous` (자작 agents 6/rules 3/skill 1 + `.planning/` 86파일 + CLAUDE.md `/gsd:*` 진입 지시 + `.harness.toml` 부재) | `harness-meta` (배치 hook 2종 자기선언 주석 + gsd 부재 + `.planning/` ABSENT) |
| (B) Task 2.5 | **발화** — Task 2(built-in 4 case) 이전 위치, '충돌 회피 우선' lens 활성 | **NO-OP** — 단일 harness-meta라 trigger 미충족 (기대대로) |
| (C) 판정 위치 | **Step 2 구조적** (Step 6 ad-hoc 아님) | false positive 없음 — 정상 격차(G1~G4) 억제 안 됨 |
| (D) 최종 권고 | 기존 자산 존중 + 격차 보강, **replace 0건** (워크플로우/도메인 agent/skill 신규 주입 명시 억제) | 정상 격차 권고 유지 |

v8.3 에서 Step 6 synthesizer 가 ad-hoc 으로 수행한 C1 충돌 회피 판정이, v8.4 보강 후 실 외부 vector 에서도 **Step 2 로 당겨져 구조적으로 강제**됨 — v8.4 sc_4 narrative 시뮬레이션이 실 audit 으로 재현됨.

**교훈** —

- (L1) **인벤토리 정정**: heterogeneous audit 지시문이 적은 "`.mcp.json` 5 MCP + gsd 플러그인 디렉토리" 는 `abfc174` worktree 에 실재 안 함(MCP 는 이후 커밋 추가). gsd 는 `.planning/` 상태 + CLAUDE.md 진입 지시로 작동했고, MCP 부재는 heterogeneous 판정에 영향 없음(agents+rules+skills+.planning 으로 확정). subagent 가 자발적으로 불일치를 정직 보고 — 비대칭 검증 default 정상 작동.
- (L2) **대조 검증의 가치**: 단일(발화) 상태만 봤으면 false positive(어디서나 발화) 가능성을 못 배제했을 것. 비발화 대조군이 lens 가 trigger 신호에만 반응함을 입증 — 1건 사례 과적합(v8.4 risk_1) 의 실 반증 1건.
- (L3) **검증철학 데이터**: self-loop(92.3% 내부) 로는 못 본 결함이 외부 vector 에서 검출(v8.3)되고 그 정정이 외부 vector 에서 실효 확인(본 milestone)됨 — 외부 적용을 1차 검증 vector 로 보는 `verification-philosophy-redefine`(v8.6) 의 첫 실 검증 데이터.

**후속** — v8.4 oos_1(orchestrator Step 1.5 전제 대조 step 신설) 은 이종 하네스 외부 사례 누적(현 1건) trigger 후 발의 후보 유지. 본 검증은 매트릭스 판정(Task 2.5)이 실 외부에서 충분히 작동함을 보여 흐름 레벨 step 의 시급성을 낮춤 — oos_1 보류 근거 보강.
