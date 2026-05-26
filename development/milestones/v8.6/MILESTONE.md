---
id: verification-philosophy-redefine
title: 검증철학을 외부 적용 1차 vector로 재정의
version: v8.6
status: in_progress
---

# v8.6 — 검증철학을 외부 적용 1차 vector로 재정의

## INTENT

### Spec

```json
{
  "id": "verification-philosophy-redefine",
  "title": "검증철학을 외부 적용 1차 vector로 재정의",
  "goal": "harness-meta 의 '자기개발'(meta self-loop, ~200 milestone)과 '제품 역량 검증'(컨설팅 자산이 실제로 통하는가)을 명시적으로 다른 범주로 분리 선언하고, 외부 적용(upbit/price-compare 등)을 제품 역량 검증의 1차 vector 로 정전화한다. 구체 산출물 모양(문서 정전화 only vs + 가벼운 mechanism)과 '검증' 단어 두 층위(9-stage VERIFY = milestone 자기점검 / 제품 역량 검증 = 외부 vector)의 경계 처리는 RESEARCH 조사 후 DESIGN 에서 확정한다.",
  "motivation": "5요소 = Verification (harness engineering 5요소 중 Verification 면의 메타 재정의). v8.0 meta≠project 재분류가 구조(디렉토리)는 분리했으나 '검증철학'은 미결로 oos_3 분리됐다. 핵심 착시 = 자기개발 횟수(~200건)를 '제품이 외부에서 통한다'는 증거로 혼동(dogfooding 착시) — 요리사가 자기 음식 맛본 횟수를 손님 만족도로 착각하는 것. v8.3(외부 이종 스택에서만 audit-team 백지전제 결함이 관찰됨) + v8.5(외부 vector 로 v8.4 보강 실효 확인 + 대조군이 과적합 risk 반증) 2건이 '외부 vector 의 검증 우위'를 실증 — 이제 일화가 아닌 원칙으로 정전화할 실증 기반이 확보됐다.",
  "success_criteria": [
    {"id": "sc_1", "criterion": "자기개발(설계 정합 = 책상 검증) ≠ 제품 역량 검증(외부 적용 = 현장 검증) 분리가 1차 source 에 명시적으로 선언 — 두 범주 정의 + 각각의 검증 방식 + 자기개발 횟수가 역량 검증 증거 아님을 명문화."},
    {"id": "sc_2", "criterion": "외부 적용이 제품 컨설팅 자산의 1차 역량 검증 vector 임이 정전화 — v8.3/v8.5 실증 2건이 근거 사례로 인용(외부에서만 결함 검출 + 외부에서 정정 실효 확인)."},
    {"id": "sc_3", "criterion": "기존 자기지표 표현(self-loop 92.3% 등 '검증 성숙도'로 읽히던 프레임) drift 정리 — '검증 증거'가 아닌 '자기개발 trace 통계'로 재라벨 또는 표현 정정(소급 milestone 수정 아닌 서술 정정)."},
    {"id": "sc_4", "criterion": "'검증' 단어 두 층위(9-stage VERIFY vs 제품 역량 검증)의 경계가 RESEARCH 조사로 확정되고, 단어 충돌 없이 정합(경계 결정 = 제품 층위만 건드림 / 둘 다 중 RESEARCH 판단). 결정과 근거가 DESIGN 에 기록."},
    {"id": "sc_5", "criterion": "기존 9-stage workflow 단어 정의 + smoke 전체 무손상(FAIL=0). 단 sc_4 결과가 '둘 다(VERIFY 단계 재정의 포함)'로 나오면 DESIGN 에서 범위 재평가(범위 확대 시 사용자 재승인 게이트)."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "새 외부 프로젝트 능동 확보/외부 적용 의무화 — 본 milestone 은 '재정의'(원칙 선언)까지. 사용자가 은퇴 의미를 '분리 선언'으로 좁혔고 '능동 의무화'는 비선택. 외부 적용 능동 추진은 별도 후속."},
    {"id": "oos_2", "item": "과거 ~200 milestone VERIFY 섹션 소급 재라벨 — forward-looking 원칙 선언. 역사적 산출물은 보존(self-referential 정합, era 보존 정책 동형)."},
    {"id": "oos_3", "item": "산출물이 mechanism 으로 결정될 경우의 구체 구현 — 모양(문서 only vs + mechanism)이 RESEARCH/DESIGN 에서 미정이므로, 구현 상세는 그 결정에 종속(현 INTENT 는 모양 미확정)."}
  ],
  "dependencies": [
    {"id": "dep_1", "ref": "development/ROADMAP.md v8.0 entry + v8.0 milestone (oos_3)", "purpose": "직접 origin — meta≠project 재분류 후 '검증철학 dogfooding 은퇴'를 별도 후속으로 분리한 발의 근거."},
    {"id": "dep_2", "ref": "development/milestones/v8.3/LIGHTWEIGHT.md", "purpose": "첫 실증 — 외부 이종 스택에서만 audit-team 백지전제 결함이 관찰됨(self-loop 로는 불가). 외부 vector 검증 우위 사례 1."},
    {"id": "dep_3", "ref": "development/milestones/v8.5/LIGHTWEIGHT.md", "purpose": "둘째 실증 — 외부 vector(price-compare 대조 audit)로 v8.4 보강 실효 확인 + 대조군이 과적합 risk 반증. 외부 vector 검증 우위 사례 2."},
    {"id": "dep_4", "ref": "development/ARCHITECTURE.md § 3(5요소 Verification) + § 7(AI Native 운영)", "purpose": "재정의가 편입될 후보 위치 — 정확한 host 섹션은 RESEARCH 에서 확정."}
  ]
}
```

### Narrative

본 milestone 은 v8.0 이 구조(디렉토리)로 분리한 meta≠project 재분류의 **개념적 후속** — 검증철학을 정전화한다. 사용자 pre-INTENT 대화(2026-05-26)로 '은퇴'의 의미를 **폐지가 아닌 재해석**으로 좁혔다: harness-meta 는 자기 자신을 만드는 도구라 dogfooding(자기개발)은 불가피하고 계속돼야 하나, 자기개발 횟수를 '제품이 외부에서 통한다'는 역량 검증 증거로 **착각**하는 것이 문제다(요리사의 자기 시식 ≠ 손님 만족도). 따라서 목표는 자기개발(책상 검증)과 제품 역량 검증(현장 검증 = 외부 적용)을 명시적으로 다른 범주로 **분리 선언**하고, 외부 적용을 후자의 1차 vector 로 정전화하는 것이다.

두 가지 결정적 경계는 사용자 판단으로 RESEARCH 에 위임됐다 — (1) 산출물 모양(문서 정전화 only vs + 가벼운 mechanism), (2) '검증' 단어 두 층위(9-stage VERIFY = milestone 자기점검 / 제품 역량 검증 = 외부 vector)의 경계. 이 둘이 본 milestone 의 최종 범위를 가르므로 RESEARCH 에서 현 ARCHITECTURE/ROADMAP 의 검증 관련 서술을 전수 조사한 뒤 DESIGN 에서 확정한다. 정전화의 실증 기반은 일화가 아니라 v8.3 + v8.5 외부 vector 검증 우위 2건이다.

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

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음)
