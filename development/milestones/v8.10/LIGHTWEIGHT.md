---
id: area4-recommendation-external-application-verify
title: 영역 4 권고 wiring 실효를 price-compare 실 audit으로 검증
version: v8.10
status: completed
---

# v8.10 — 영역 4 권고 wiring 실효를 price-compare 실 audit으로 검증

> 본 milestone = **가벼운 흐름** (4 섹션 트랙, ARCHITECTURE § 7.4). v8.9 영역 4 wiring 의 외부 적용 검증 trace — 컨설팅 자산 변경이 아닌 관찰이므로 9-stage 아닌 4 섹션 한 장 (v8.3/v8.5/v8.7 외부 적용 trace 선례 정합). 단 audit 중 검출된 wiring 결함의 실 수정은 별도 큰 건 후보로 분리 등록.

## 문제

v8.9 가 audit-team 에 '영역 4 — harness-meta canonical 자산' 권고 통로를 신설했으나, 그 **실효(audit 가 실제 secret-scan gap detect → 영역 4 매핑 분기 실행)는 정적 smoke 범위 밖**이었다(v8.9 L2, oos_2 — agent Task 텍스트 = LLM prompt-time 추론 지시문이라 정적 검증 불가). v8.4→v8.5 패턴(narrative 시뮬레이션 → 실 재audit 검증)처럼, 실 heterogeneous 프로젝트에서 audit 을 돌려 영역 4 분기 실작동 + over-recommend false-positive 0 을 검증해야 한다. verification-philosophy(v8.6) 제품 역량 검증 vector 정합.

추가로 OPEN 전 조사에서 **세션 동결 문제**가 드러났다 — agent 정의는 세션 시작 시 로드되어 hot-reload 안 됨(claude-code-guide docs 확인). v8.9 wiring 은 이번 세션 중 커밋됐으므로, live spawn 한 gap-analyzer 가 자기 instructions 에 영역 4 wiring 유무를 묻자 **"ABSENT"** 반환(실측) — 세션 시작 시점(pre-v8.9) 정의임이 확정. 진짜 검증은 정의 재로드가 선행돼야 한다.

## 결정

1. **`/reload-plugins` 로 agent 재로드** (사용자 실행) — docs 상 file-based agent 는 세션 재시작 필요로 명시되나, `/reload-plugins` 의 agent 적용 범위가 모호해 시도. 재로드 후 gap-analyzer 재probe 로 v8.9 반영 확인 후 진행(reload 미반영 시 fallback).
2. **price-compare working tree 실 audit** — project-scanner → harness-gap-analyzer(v8.9) live 실행. 외부 repo write 0(read-only chain, Step 5 component-installer 미spawn). v8.7 선례 정합.
3. **가벼운 흐름** — 외부 적용 관찰 trace = §7.4 작은 건. 단 wiring 결함 검출 시 별도 큰 건 후보 등록.

## 적용

검증 실행 (harness-meta repo 외부 — price-compare working tree 무손상):

- 사용자 `/reload-plugins` 실행 → "Reloaded: 5 plugins · 4 skills · **17 agents** · 4 hooks". gap-analyzer 재probe → 영역 4 wiring 3 구절(harness-meta-asset / 'harness-meta canonical 자산 gap (v8.9)' / 'README.md § 4') **그대로 인용** = v8.9 반영 실측 확인 (reload 전 "ABSENT" → reload 후 quote).
- project-scanner(price-compare) → harness_state.hooks 3건 = `arch-file-guard`(inline) / `secret-guard.py` / `git-push-guard.py`, claude_dir=true, settings_local_json=true, harness_kind=heterogeneous.
- harness-gap-analyzer(v8.9) live 실행 → Task 1 의 'harness-meta canonical 자산 gap (v8.9)' 분기가 `bootstrap/claude-code-catalog/README.md § 4` 를 실제 Read + gap 조건 대조 + `canonical_asset_gap_judgment` 필드 산출.

## 기록

**검증 결과** —

| 초점 | 결과 |
| --- | --- |
| (A) 영역 4 분기 실작동 | **확인** — gap-analyzer 가 § 4 Read + gap 조건(claude_dir ∧ name 토큰) 대조 + `canonical_asset_gap_judgment` 산출. wiring 이 텍스트가 아닌 실 분기로 동작(정적 smoke 미검증분 입증). |
| (B) over-recommend false-positive | **0** — price-compare 가 `secret-guard.py`(name 에 'secret' 토큰) 보유 → gap=false, 강요/중복 권고 안 함. heterogeneous 존중 lens 정합. |
| (C) detect 기준 결함 검출 | **name-token detect 가 너무 coarse** — `secret-guard.py`(PreToolUse Edit\|Write, write-time 차단) ↔ `session-start-secret-scan.sh`(SessionStart, settings*.json 저장 secret warn-only)는 **책임 직교**인데, d_2 의 name-token 매칭이 'secret' 토큰만 보고 gap=false 처리 → **잠재 false-negative**(실 settings allow-list 격차는 남는데 권고 억제). agent 가 이 한계를 투명 보고 + 사용자 게이트 이관(강제 권고 금지). |

**교훈** —

- (L1) **영역 4 wiring 실효 입증**: v8.9 가 설치한 영역 4 분기가 실 heterogeneous 프로젝트 audit 에서 실제 실행됨(§ 4 Read + 판정 산출). 정적 smoke 가 못 본 'agent prompt-time 분기 실작동'을 실 audit 으로 확인 — v8.9 L2 의 검증 공백을 외부 적용이 메움(v8.4→v8.5 패턴 재현, verification-philosophy 제품 역량 검증 vector 실증).
- (L2) **self-loop 로는 못 본 detect 결함**: d_2 의 name-token detect 기준이 'secret 토큰 보유 hook = 자작 secret-scan 보유'로 단정해, write-time guard(secret-guard.py)와 settings-scan(session-start-secret-scan.sh)의 직교를 구분 못 함. 책상(harness-meta 자기 settings, 단일 hook)에선 안 보이고 실 외부 프로젝트(유사명 직교 hook 보유)에서만 노출 — v8.7 보안 격차 교훈의 detect-logic 버전 재현.
- (L3) **`/reload-plugins` 가 file-based agent 재로드**: claude-code-guide docs 는 file-based agent 세션 재시작 필요로 보수 판정했으나, 실측상 `/reload-plugins` 가 17 agents 재로드 + probe 로 v8.9 반영 확인. harness-meta 도그푸딩 한계(같은 세션 내 자기 agent 변경 검증 불가)의 회피 경로 발견 — full 재시작 없이 in-session 검증 가능.

**후속** —

- (큰 건 후보) `area4-detect-criterion-refinement` — d_2 name-token detect 를 정련해 write-time guard ↔ settings-scan 직교를 구분(예: hook matcher/책임 기반 또는 § 4 표 '권고 case' 컬럼의 구조화 조건). 영역 4 wiring 결함의 실 수정 = 컨설팅 자산(agent) 변경 = 큰 건(v8.4 패턴 — 외부 적용 결함 검출 → 별 큰 건 승격). SCOPE_OUT_NOTES architecture(detect 기준 일반화) + `hook-asset-library-canonicalization` 후보와 테마 정합. 사용자 명시 결정 게이트 후 등재.
