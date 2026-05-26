---
id: price-compare-coexistence-audit
title: price-compare 이종 fleet 공존 audit 능동 재수행
version: v8.7
status: completed
---

# v8.7 — price-compare 이종 fleet 공존 audit 능동 재수행

> 본 milestone = **가벼운 흐름** (4 섹션 트랙, ARCHITECTURE § 7.4) 산출물. audit-team(컨설팅 자산)을 **돌려 외부 적용한 관찰 trace** 이지 자산 자체의 변경이 아니므로 9-stage 아닌 4 섹션 한 장으로 처리 (v8.3/v8.5 외부 적용 trace 선례 정합). audit 중 audit-team 도구 자체 결함이 새로 검출되면 그때 v8.4 처럼 별도 큰 건으로 승격.

## 문제

`verification-philosophy-redefine`(v8.6)은 외부 적용을 **제품 역량 검증의 1차 vector** 로 정전화했고, 그 후속 `external-application-active-drive`(v8.6 oos_1, next_candidates v8.7)를 "원칙 선언 → 외부 능동 추진" 의 실행으로 named 했다. v8.6 L1 자기참조 lesson: 정전화 자체는 self-loop(책상)로 수행됐으므로 이 원칙이 "외부에서 통한다" 는 입증은 외부 적용 능동 추진으로만 가능.

사용자 발의로 대상 = **price-compare**(Next.js/TS/Prisma/k8s — upbit Python 트레이딩과 이질) 심화로 결정. 착수 전 현 상태 재조사에서 v8.3/v8.5 대비 변화가 확인됨:

- HEAD 변동 없음 (`14bb1a3`, 원격 push 안 됨, `.harness.toml` 여전히 부재)
- v8.5(2026-05-26) 이후 **새 자작 fleet 이 untracked 로 성장** — `.claude/agents/` 6 도메인 subagent(backend·db·devops·frontend·marketing·reviewer) + `.claude/rules/` 3종(deployment·improvement-workflow·meeting-workflow) + `.claude/skills/features/` + `settings.json`

즉 v8.3 의 핵심 교훈(audit-team 의 "신규=백지" 전제가 외부에서 깨짐 — price-compare 는 이미 자작 하네스 보유)이 **새 형태로 재현**됐다. gsd 는 905e80f 로 제거됐으나 사용자가 그 자리에 6 도메인 agent fleet 을 새로 구축. v8.7 의 본질 = 단순 부품 추가가 아니라 **이 살아있는 이종 fleet 과 harness-meta 권고의 공존 관계 설정** — v8.4 가 추가한 이종 하네스 충돌 case 와 v8.6 검증철학의 첫 **능동** 실 무대(v8.5 는 과거 커밋 대조 검증, v8.7 은 현 working tree 의 살아있는 fleet 대상).

## 결정

1. **현 HEAD(`14bb1a3`) + untracked fleet 그대로 audit** (사용자 결정) — v8.5 와 달리 과거 커밋 worktree 가 아닌 현재 살아있는 working tree(자작 6 agent + rules + skill 포함) 대상. price-compare 가 실제로 운영 중인 상태를 본다.
2. **full audit-orchestrator chain** (사용자 결정) — Step 1~4 read-only 5멤버 전 chain + Step 6 fact-verify. **Step 5(component-installer) 미spawn** — read-only 권고까지만, 외부 repo write/install 0 (USER DECISION GATE 직전 정지).
3. **충돌 회피 + 격차 보강 관점** — v8.4 이종 하네스 충돌 case 가 살아있는 fleet 에서 어떻게 발화하는지 + 기존 6 agent fleet 을 존중하며 어떤 격차를 보강 권고하는지 분리 관찰.
4. **자산 변경 없음** — 본 작업은 외부 적용 관찰 trace. audit 중 audit-team mechanism 자체 결함이 새로 검출되면 별도 큰 건(9-stage)으로 승격.

## 적용

검증 실행 (harness-meta repo 외부 — price-compare working tree 무손상):

- audit-orchestrator 단일 invoke → Step 1~4 read-only 5멤버 chain(project-scanner → harness-gap-analyzer → claude-docs-mapper → component-proposer) + Step 6 synthesizer fact-verify
- **Step 5(component-installer) 미spawn** — read-only 권고까지만. price-compare working tree write 0건 / install 0건. audit 산출물은 임시 위치조차 안 쓰고 synthesizer 응답으로 직접 반환
- P0-1(평문 secret 박제) 주장은 메인 Claude 가 `settings.local.json:37-38` 직접 Read 로 재검증 (subagent 외부 1차 source fact 인용 검증 의무) — 박제 실재 확인

harness-meta repo (본 trace):

- `development/milestones/v8.7/LIGHTWEIGHT.md` (본 파일)
- `development/ROADMAP.md` — `milestones[]` v8.7 entry + `next_candidates[]` 안 `external-application-active-drive` 소비 + `updated` 갱신

## 기록

**audit 결과** — v8.4 이종 하네스 충돌 보강이 살아있는 6 agent fleet 에서 false positive 없이 정확히 발화:

| 초점 | 결과 |
| --- | --- |
| (A) harness_kind | `mixed` → **heterogeneous 우선**(보수적 충돌 회피). 자작 fleet(agents 6 + rules 3 + skill 1 + settings.json) + harness-meta hook 2종(v8.3 배치, 자기선언 주석) 혼재 + `.harness.toml` 부재 |
| (B) Task 2.5 | **발화** — Step 2 구조적 위치(Step 6 ad-hoc 아님). chain 초입에서 heterogeneous 판정 후 Task 1·2·3 을 '충돌 회피 우선' lens 로 재평가 분기 |
| (C) 충돌 회피 | **replace 억제 5건** — 자작 reviewer(OWASP+PIPA 특화) / 6 도메인 fleet / 자작 워크플로우 2종 / 인라인 hook / features skill 모두 존중. replace 0건 |
| (D) 격차 보강 | P0-1 평문 secret 박제 회수(시급) + P1-2 secret-guard settings 스캔 확장 + P2-3 agent description trigger 구체화 + P2-4 `.harness.toml` **보류 권고**(자기 방법론 주입 회피). 모두 `extend`/`adopt`, 신규 구축/replace 0 |
| (E) fact-verify | hallucination 0건. boolean/수치/표 3 method 직접 매핑 일치 (audit_fact_verify.py 는 REPO_ROOT 한정 → 외부엔 v5.13/v5.18 수동 검증 적용) |

**부수 발견 (audit scope 밖, 보안 사고)** — `settings.local.json:37-38` allow 리스트에 **유효 Docker Hub PAT(`dckr_pat_...`) + JWT(scope `repo:admin`) 평문 박제**. Claude Code 가 과거 실행한 curl 명령이 allow 리스트에 통째 저장되며 secret 유입. 기존 secret-guard.py 는 Edit/Write 만 감시 → settings 파일 자체 박제는 미커버. 메인 Claude 직접 Read 로 실재 재확인. **즉시 회수+무효화 + allow 항목 제거 권고** (사용자 명시 결정 게이트 — 본 milestone 은 외부 repo write 0).

**교훈** —

- (L1) **능동 외부 vector 실효**: v8.5 는 과거 커밋(`abfc174`) 대조 검증이었으나 v8.7 은 현 working tree 의 살아있는 fleet 대상 첫 **능동** 적용. v8.4 보강이 시뮬레이션·과거커밋이 아닌 실 운영 상태에서도 Step 2 구조적 발화 — `verification-philosophy-redefine`(v8.6) 의 "외부에서 통한다" 입증 첫 능동 데이터.
- (L2) **self-loop 로는 못 본 보안 격차**: P0-1 평문 secret 박제는 외부 실 repo 의 실 운영 흔적(과거 curl 실행)에서만 노출됨 — 책상(self-loop)에선 발생 불가한 패턴. secret-guard.py 의 Edit/Write 한정 scope 가 settings allow 리스트 유입 경로를 못 막는 격차도 외부에서만 검출 (v8.3 교훈의 보안 버전 재현).
- (L3) **이종 fleet 존중 정합**: 6 도메인 자작 agent + 자작 워크플로우 2종을 replace 0건으로 존중하며 직교 격차만 extend 권고 — harness-meta 정체성('적재적소 부품 배치, 기존 자산 존중') 이 살아있는 이종 fleet 에서 실 작동.

**후속** —

- P1-2(secret-guard.py 의 settings*.json allow 항목 스캔 확장) 는 harness-meta **자산 변경**(컨설팅 도구 hook 로직 보강) → 별도 큰 건 후보. 단 외부 price-compare 의 hook 은 외부 적용 부품이고, harness-meta repo 의 secret-guard 패턴 자체 확장이면 9-stage 승격 검토.
- v8.4 oos_1(orchestrator Step 1.5 전제 대조 step 신설) 은 이종 하네스 외부 사례 누적 trigger 후 발의 후보 유지 — 본 건으로 누적 2건(v8.5 대조 + v8.7 능동). Task 2.5 가 능동 적용에서도 충분히 작동해 흐름 레벨 step 시급성은 여전히 낮음.
