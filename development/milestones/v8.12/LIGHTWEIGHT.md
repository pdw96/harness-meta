---
id: area4-detect-refinement-external-verify
title: 정련된 영역 4 detect 기준 실효를 price-compare 실 audit으로 검증
version: v8.12
status: completed
---

# v8.12 — 정련된 영역 4 detect 기준 실효를 price-compare 실 audit으로 검증

> 본 milestone = **가벼운 흐름** (4 섹션 트랙, ARCHITECTURE § 7.4). v8.11 정련 기준의 외부 적용 검증 trace — 컨설팅 자산 변경이 아닌 관찰이므로 9-stage 아닌 4 섹션 한 장 (v8.3/v8.5/v8.7/v8.10 외부 적용 trace 선례 정합). v8.9→v8.10 검증 공백 패턴의 닫힘 단계.

## 문제

v8.11 이 영역 4 detect 기준을 name-token 단독 → **발동 시점(event)이 SessionStart 인 hook ∧ secret/scan 책임 토큰 (write-time `Edit|Write` guard 제외)** 으로 정련했으나, 그 **실효(정련 기준이 실 audit 에서 secret-guard.py 보유 프로젝트를 gap=true 로 surface = 과억제 false-negative 교정)는 agent prompt-time 분기라 정적 smoke 밖**이었다 (v8.11 oos_2, L3 — agent Task 텍스트 = LLM prompt-time 추론 지시문이라 정적 검증 불가). v8.9→v8.10 패턴 정합 — 실 heterogeneous 프로젝트에서 audit 을 돌려 (A) 정련 기준이 false-negative 를 실제 교정 + (B) over-recommend false-positive 0 을 검증해야 한다.

추가로 OPEN 전 조사에서 **세션 동결 문제가 재현**됐다 (v8.10 L3 동형). live spawn 한 gap-analyzer 에 자기 d_2 기준을 묻자 reload 전 **옛 name-token 기준**(`hooks[].name 에 secret/scan 토큰 부재`)을 인용 — v8.11 정련본이 아닌 세션 시작 시점(pre-v8.11) 정의임이 실측 확정. 진짜 검증은 정의 재로드가 선행돼야 한다.

## 결정

1. **`/reload-plugins` 로 agent 재로드** (사용자 실행, v8.10 선례) — 재로드 후 gap-analyzer 재probe 로 v8.11 정련본(event-gate 기준) 반영 확인 후 진행.
2. **price-compare working tree 실 audit** — audit-orchestrator Step 1~4 read-only chain (project-scanner → harness-gap-analyzer → claude-docs-mapper → component-proposer). 외부 repo write 0 (Step 5 component-installer 미spawn). v8.7/v8.10 선례 정합.
3. **가벼운 흐름** — 외부 적용 관찰 trace = §7.4 작은 건. 컨설팅 자산 변경 아님 (관찰).

## 적용

검증 실행 (harness-meta repo 외부 — price-compare working tree 무손상, read-only):

- **reload 전 probe** → gap-analyzer 가 옛 name-token 기준(`hooks[].name 에 secret/scan 토큰 부재 → gap surface`) 인용 = 세션 동결 재현 실측.
- 사용자 `/reload-plugins` 실행 → "Reloaded: 5 plugins · 4 skills · **17 agents** · 4 hooks". **재probe** → gap-analyzer 가 v8.11 정련본 그대로 인용: `발동 시점(event)이 SessionStart 인 secret-scan 책임 hook 부재` + `write-time guard Edit|Write (예 secret-guard.py) 는 책임 직교라 제외 → SessionStart gate 탈락` = v8.11 반영 실측 확인 (reload 전 옛 기준 → reload 후 정련본).
- **대상 상태** (project-scanner): `secret-guard.py`(PreToolUse `Edit|Write` write-time guard, 헤더 명시) + `git-push-guard.py`(Bash) 보유, **SessionStart secret-scan 책임 hook 부재**(`grep SessionStart .claude/` 0건), claude_dir=true, harness_kind=heterogeneous.
- **audit-orchestrator Step 1~4** → gap-analyzer d_2(session-start-secret-scan.sh) 판정 산출. fact-verify(v5.13 직접 매핑) 동반.

## 기록

**검증 결과** —

| 초점 | 결과 |
| --- | --- |
| (A) false-negative 교정 | **확인 — gap=true** (v8.10 옛 기준의 gap=false 직접 교정). 정련 기준이 `secret-guard.py`(matcher `Edit\|Write`)를 SessionStart gate 에서 정확히 제외 → 'secret' 토큰 보유에도 gap 억제 못 함. **실질도 옳음**: secret-guard.py 는 write payload(`tool_input.content`/`new_string`)만 scan, settings.local.json:37-38 에 이미 박힌 평문 secret 은 절대 못 잡음 = SessionStart 자산이 커버할 직교 책임. |
| (B) over-recommend false-positive | **0** — 유일 canonical-자산 권고 = `session-start-secret-scan.sh`(`adopt`, 격차보강, replace 아님). price-compare 미보유분이라 중복 0. secret-guard.py replace 권고 0(직교 write-time guard 로 존중, heterogeneous lens 정합). |
| fact-verify | **mismatch 0, hallucination 0** — boolean(SessionStart hook 부재 / secret-guard.py Edit\|Write 등록 / 평문 secret 존재) + count(over-recommend 0) 전건 1차 source 검증. |

**교훈** —

- (L1) **v8.11 정련 기준 실효 입증**: event-gate 기준이 실 heterogeneous audit 에서 write-time guard(secret-guard.py)를 정확히 제외해 gap=true 를 surface — v8.10 (C) 가 노출한 name-token false-negative 의 직접 교정을 실 audit 으로 확인. **v8.9(통로 신설)→v8.10(통로 실효 검증 + 결함 검출)→v8.11(결함 수정)→v8.12(수정 실효 검증)** 검증 체인이 닫혔다. verification-philosophy(v8.6) 제품 역량 검증 vector 가 검출한 결함이 외부 적용으로 검출되고 외부 적용으로 교정 확인됨 — self-loop 책상으론 닫을 수 없던 루프.
- (L2) **세션 동결 재현 + reload 회피 경로 재확인**(v8.10 L3 동형): reload 전 probe = 옛 name-token, reload 후 probe = v8.11 event-gate. agent 정의 변경의 실작동은 정적 smoke 불가, 실 spawn + `/reload-plugins` 가 유일 검증 경로 — memory `reference_reload_plugins_agent_inflight_verify` 재확인. 방금 커밋 아닌 직전 커밋(v8.11)도 세션이 그 전 상태로 로드되면 동결 적용됨을 실측(commit 시점 ≠ 세션 로드 시점).
- (L3) **부수 재확인 — price-compare 평문 secret 미회수**: settings.local.json:37-38 의 평문 Docker Hub PAT(`dckr_pat_…`) + JWT 가 v8.7 발견 이후 **아직 회수 안 됨**. 정련 기준이 surface 한 gap=true 가 실제 보호 필요(SessionStart scan 이 잡을 대상)를 정확히 가리킨다 = 정련의 substantive 정당성 방증. 단 외부 repo write 0 이라 회수는 사용자 몫(별도 권고).

**후속** —

- **검증 체인 닫힘** — v8.9→v8.12 영역 4 통로 신설·실효·결함·수정·수정실효 5 단계 완결. 즉시 후속 없음.
- (보류 유지) `area4-detect-criterion-generalization`(v8.11 oos_1, target v9.0) — § 4 '권고 case' 컬럼을 모든 자산 구조 필드로 일반화. 원 trigger=자산 2건째 등록 **미충족** + `hook-asset-library-canonicalization` 후보와 영역 겹침. 사용자 명시 결정 게이트 전까지 next_candidates[] 미등재.
