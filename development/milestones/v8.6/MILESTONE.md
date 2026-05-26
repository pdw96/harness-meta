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

### Spec

```json
{
  "external": [
    {
      "id": "ext_1",
      "source": "일반 SE 원칙 — dogfooding ('eat your own dog food', 내부 자가사용 검증) vs field/external validation (외부·현장 검증) 구분",
      "finding": "내부 자가사용(dogfooding)은 설계 정합·기본 동작을 빠르게 확인하나, 실제 사용자/이질 환경에서 통하는가(역량)는 외부·현장 검증으로만 입증된다 — 이 둘은 서로 대체 불가 다른 범주다. INTENT 요리사 비유(자기 시식 ≠ 손님 만족도)와 정합. 본 milestone 은 라이브러리/spec API 변경이 아닌 harness-meta 자체 운영철학 재정의이므로 외부 library spec drift 조사 대상 부재 — 외부 grounding 은 본 개념 구분 1건으로 충분 (실증 기반은 codebase v8.3/v8.5)."
    }
  ],
  "codebase": [
    {
      "id": "cb_1",
      "ref": "development/ARCHITECTURE.md § 3.3 5요소 매트릭스 Verification row (line 92)",
      "finding": "현 정전상 '검증(Verification)' 5요소 = '산출물 정합·schema·회귀 자동 검증' (smoke 27종 + pre-commit + VERIFY.md criteria_check). 즉 5요소 Verification 은 milestone 산출물 자기점검(책상 검증) 층위 전용 — '제품이 외부에서 통하는가(현장 역량)' 층위는 5요소에 부재. sc_1 분리 선언이 메울 gap 위치."
    },
    {
      "id": "cb_2",
      "ref": "development/ARCHITECTURE.md § 3.1 끝 v5.8 paragraph (line 77)",
      "finding": "living source 안 'self-loop 92.3%' + '운용 부합도 sub-metric 77.5%' 프레임이 거주 — 13건 중 12건 자기개발/1건 외부(upbit)를 정량화한 진단. 이 수치가 '검증 성숙도'처럼 읽히는 drift 의 1차 host (sc_3 재라벨 직접 대상). 과거 v5.x milestone 산출물 안 동일 표현 다수(grep 77 파일)는 oos_2 로 무손상 보존 — living ARCHITECTURE 표현만 정정 대상."
    },
    {
      "id": "cb_3",
      "ref": "development/ARCHITECTURE.md § 7.1 AI Native 운영 3면 매트릭스 (line 271~281) + 다중 AI 협업 row (line 279)",
      "finding": "§ 7 = '본 repo 가 어떻게 운영되는가(원칙/운영 방식)' 차원 (§ 3.1 정체성 '무엇을 만드는가'와 직교). '제품 역량을 어떻게 검증하는가(외부 vector)'는 운영 원칙 본질 → § 7 편입 후보. 단 self-loop 프레임(cb_2)은 § 3.1 에 있어 재라벨이 § 3.1/§ 3.3 인접 필요 — host 단일/분산 결정은 DESIGN 확정(risk_4)."
    },
    {
      "id": "cb_4",
      "ref": "CLAUDE.md 워크플로우 표 + ARCHITECTURE.md § 4 (9-stage) VERIFY(G) row",
      "finding": "9-stage 안 VERIFY(stage G) = 'smoke / criteria_check vs INTENT / verdict' = milestone 단위 자기점검. 즉 '검증' 단어가 (i) 9-stage VERIFY(G) + (ii) 5요소 Verification(cb_1) 두 곳에서 이미 '자기점검(책상)' 의미로 확립. 신설 '제품 역량 검증'은 세 번째 의미 — sc_4 경계 = 제품 층위만 신설하면 (i)(ii) 단어 정의 무손상(sc_5 FAIL=0 자연), 9-stage 단어 정의 변경은 큰 건이라 회피 대상."
    },
    {
      "id": "cb_5",
      "ref": "development/milestones/v8.3/LIGHTWEIGHT.md L41 + L45",
      "finding": "실증 1 — audit-team 암묵 전제 '신규 대상 = 하네스 백지'가 외부 이종 스택(price-compare: Next.js/TS/Prisma)에서 깨짐(이미 gsd+자작 하네스 보유). L41 명시: '이 전제 결함은 self-loop 92.3% 로는 절대 관찰 불가 — 외부·이종 검증의 가치를 직접 입증'. sc_2 근거 사례(외부에서만 결함 검출)."
    },
    {
      "id": "cb_6",
      "ref": "development/milestones/v8.5/LIGHTWEIGHT.md L49 + L54(L2) + L55(L3)",
      "finding": "실증 2 — 외부 vector(price-compare 대조 재audit: abfc174 heterogeneous vs HEAD)로 v8.4 보강의 실효 확인(L49: Step 6 ad-hoc 판정이 Step 2 구조적으로 당겨져 강제). L54: 비발화 대조군이 v8.4 risk_1 과적합을 실 반증. L55: '외부 적용을 1차 검증 vector 로 보는 v8.6 의 첫 실 검증 데이터' 자기 명명. sc_2 근거 사례(외부에서 정정 실효 확인)."
    }
  ],
  "options": [
    {
      "id": "opt_1",
      "label": "산출물 모양 = 문서 정전화 only (채택)",
      "rationale": "INTENT goal = '재정의(원칙 선언)' + oos_1(능동 의무화 비선택) + oos_3(mechanism 종속). working philosophy(§ 3.2 'narrative + 사용자 명시 gate 1차 source') + § 3.1 ('자동화가 1차 source 되면 narrative drift') 직접 정합 — 원칙은 narrative 로 선언하는 것이 정전. 실증 base 2건으로 mechanism 강제는 시기상조."
    },
    {
      "id": "opt_2",
      "label": "산출물 모양 = + 가벼운 mechanism (예: self-loop ratio tracker / 외부 vector counter smoke) (폐기)",
      "rationale": "폐기 — 2건 실증 base 에서 자동 지표화는 과적합(risk_1) + '자동화가 1차 source 화'하여 § 3.1 working definition 위반. 외부 적용 능동 추진(별도 후속) 확정 후 재고 가능. 본 milestone scope 밖(oos_3)."
    },
    {
      "id": "opt_3",
      "label": "검증 단어 경계 = '제품 역량 검증' 신층위만 신설, 기존 9-stage VERIFY + 5요소 Verification 정의 무손상 (채택)",
      "rationale": "채택 — cb_4 상 '검증'은 이미 '자기점검(책상)' 의미로 (i)9-stage VERIFY(G) + (ii)5요소 Verification 에 확립. 제품 층위만 별도 명명(예: '제품 역량 검증' = 외부 vector)하면 기존 두 단어 정의 손대지 않음 → sc_5 FAIL=0 자연 + 사용자 재승인 게이트 불필요. 경계 표(3중 의미 명시 구분)로 충돌 회피."
    },
    {
      "id": "opt_4",
      "label": "검증 단어 경계 = 9-stage VERIFY(G) 단어 정의 재정의 포함 (둘 다) (폐기)",
      "rationale": "폐기 — 9-stage 단어 정의 변경 = 컨설팅 자산(방법론) 영향 = 큰 건 + sc_5 단서상 범위 확대 시 사용자 재승인 게이트 발생. v2.0 단어-책임 1:1 매핑 정전을 흔들 risk 대비 실익 없음 — 제품 역량 검증은 milestone 자기점검과 본질이 달라 VERIFY(G) 재정의 불요."
    },
    {
      "id": "opt_5",
      "label": "정전화 host = § 3.1/§ 3.3 인접 신 paragraph(분리 선언 + self-loop 재라벨) 1차 source + § 7 pointer (DESIGN 확정 후보)",
      "rationale": "채택 후보 — sc_3 재라벨 대상(cb_2)이 § 3.1 에 있고 5요소 Verification gap(cb_1)도 § 3.3 이라 분리 선언은 § 3 권역이 자연. § 7(운영 원칙)엔 단방향 pointer(§ 7.3/§ 7.1 선례 동형, cascade marker 부재 자연)로 중복 회피(risk_4 mitigation). 정확 paragraph 위치/문안은 DESIGN 확정."
    }
  ],
  "risks_identified": [
    {
      "id": "risk_1",
      "description": "실증 base 2건(v8.3/v8.5)으로 '외부 vector = 1차 검증' 을 일반 원칙으로 정전화 시 over-claim(소표본 과적합).",
      "mitigation": "원칙 선언 + 근거를 '현 evidence 누적 2건(forward 누적)'으로 정직 표기 + v8.5 L2(대조군이 과적합 반증)를 reverse-evidence 로 인용. DESIGN d_X = 단정형('항상 외부에서만 통한다') 회피, '자기개발은 역량 증거 아님'의 negative claim 중심 서술."
    },
    {
      "id": "risk_2",
      "description": "'검증' 단어 3중 의미(9-stage VERIFY(G) / 5요소 Verification / 제품 역량 검증) 공존으로 독자·LLM 혼동.",
      "mitigation": "opt_3 채택 + DESIGN 안 경계 표(세 의미 명시 구분: '자기점검 = 책상' 2종 vs '제품 역량 = 현장' 1종) + 신층위에 구별 라벨('제품 역량 검증' = 외부 vector) 명명. sc_4 결정·근거 DESIGN 기록."
    },
    {
      "id": "risk_3",
      "description": "self-loop 92.3% 재라벨(cb_2)이 v5.8 정량 진단 trace 정합을 훼손하거나 과거 산출물 소급 수정으로 번질 위험.",
      "mitigation": "oos_2 정합 — 과거 v5.x milestone(grep 77 파일) 무손상, living ARCHITECTURE § 3.1 표현만 정정. 수치(92.3%) 자체 보존 + 해석만 재프레임('검증 성숙도'→'자기개발 trace 통계'). 재라벨 = 서술 정정이지 수치 소급 변경 아님."
    },
    {
      "id": "risk_4",
      "description": "검증 narrative 가 § 3.1 + § 3.3 + § 7 다중 host 분산 시 cascade drift.",
      "mitigation": "opt_5 — 1차 source 단일 host(§ 3 권역 신 paragraph) 지정 + § 7 는 단방향 pointer(§ 7.1/§ 7.3 pointer 선례 동형, cascade marker 부재 자연). cascade marker 필요 판단 시 DESIGN 에서 16-hex dummy 규약(.claude/rules/schema-discipline) 적용."
    }
  ]
}
```

### Narrative

조사 결과 본 milestone 의 두 결정적 경계(INTENT 가 RESEARCH 에 위임한 산출물 모양 + '검증' 단어 층위)가 모두 확정 가능한 근거에 도달했다.

**'검증' 단어 층위 (sc_4)** — 현 정전 source 상 '검증'은 이미 두 곳에서 '자기점검(책상 검증)' 의미로 확립돼 있다: (i) 9-stage VERIFY stage G(`smoke/criteria_check/verdict`, cb_4) + (ii) 5요소 Verification(`산출물 정합·schema·회귀 자동 검증`, cb_1, line 92). 신설할 '제품 역량 검증(외부 vector)'은 본질이 다른 세 번째 의미다. 따라서 경계는 **제품 층위만 별도 명명·신설(opt_3)** 하면 기존 두 단어 정의를 손대지 않아 sc_5(FAIL=0)가 자연 충족되고 사용자 재승인 게이트도 불필요하다 — 9-stage 단어 정의 재정의(opt_4)는 컨설팅 자산 변경 = 큰 건이고 실익이 없어 폐기. 혼동 위험(risk_2)은 DESIGN 안 3중 의미 경계 표로 차단한다.

**산출물 모양 (oos_3)** — INTENT goal 이 '재정의(원칙 선언)'이고 oos_1(능동 의무화 비선택)·oos_3(mechanism 종속)이 범위를 좁혔으므로, working philosophy(§ 3.2 narrative 1차 source, § 3.1 '자동화가 1차 source 화하면 drift')에 정합하는 **문서 정전화 only(opt_1)** 가 채택. self-loop ratio tracker 같은 mechanism(opt_2)은 2건 실증 base 에서 과적합이고 § 3.1 working definition 위반이라 폐기 — 외부 적용 능동 추진(별도 후속) 확정 후 재고 대상이다.

**정전화 host + 재라벨 (sc_1/sc_3)** — 분리 선언이 메울 gap(5요소 Verification 이 책상 층위 전용, cb_1)과 재라벨 대상(self-loop 92.3% 프레임, cb_2, § 3.1 line 77)이 모두 § 3 권역에 있어 1차 source 는 § 3.1/§ 3.3 인접 신 paragraph, § 7 는 단방향 pointer(opt_5)가 자연이다. 재라벨은 수치(92.3%) 보존 + 해석만 재프레임('검증 성숙도'→'자기개발 trace 통계')이며 과거 milestone 산출물(grep 77 파일)은 oos_2 로 무손상(risk_3 mitigation). 정전화의 실증 기반은 일화가 아니라 cb_5(v8.3 — 외부에서만 audit-team 백지전제 결함 검출, L41 'self-loop 로는 절대 관찰 불가') + cb_6(v8.5 — 외부 대조 audit 으로 v8.4 보강 실효 확인 + L2 대조군이 과적합 반증) 2건이며, 각각 외부 vector 의 '결함 검출'과 '정정 실효' 양면을 입증해 sc_2 근거로 직접 인용된다. 외부 grounding(ext_1)은 dogfooding↔field-validation 일반 구분 1건으로 충분 — 본 milestone 은 library/spec 변경이 아닌 자체 운영철학 재정의라 spec drift 조사 대상이 부재하다.

## DESIGN

### Spec

```json
{
  "decisions": [
    {
      "id": "d_1",
      "decision": "자기개발(meta self-loop = 책상 검증)과 제품 역량 검증(외부 적용 = 현장 검증)을 명시적으로 다른 범주로 분리 선언 — 두 범주 정의 + 각각의 검증 방식 + '자기개발 횟수(~200 milestone)는 제품 역량 검증의 증거가 아님'을 ARCHITECTURE § 3 신 paragraph 에 명문화. paragraph 두괄 = negative 명제('자기개발 횟수는 제품 역량 검증 증거 아님') 우선, 요리사 비유(자기 시식 ≠ 손님 만족도)는 보조 후순.",
      "rationale": "sc_1 직접. opt_1(문서 정전화 only) + ext_1(dogfooding↔field-validation 일반 구분) grounding. 두괄 명제 우선 = design-review dx comment 흡수 — LLM-reader grep/의미 매칭에 명제가 비유보다 강(비유 먼저 오면 핵심 명제가 비유 안에 묻힘). 인간 독자용 비유는 보존하되 후순(MEMORY user_non_developer_role 균형)."
    },
    {
      "id": "d_2",
      "decision": "외부 적용(upbit/price-compare 등)을 제품 컨설팅 자산의 1차 역량 검증 vector 로 정전화 — v8.3(cb_5, 외부에서만 audit-team 백지전제 결함 검출) + v8.5(cb_6, 외부 대조 audit 으로 v8.4 보강 실효 확인 + 과적합 반증) 2건을 근거 사례로 명시 인용.",
      "rationale": "sc_2 직접. cb_5/cb_6 = 외부 vector 의 '결함 검출'·'정정 실효' 양면 실증. 일화 아닌 원칙으로 정전화할 evidence 확보."
    },
    {
      "id": "d_3",
      "decision": "'검증' 단어 경계 = '제품 역량 검증(외부 vector)' 신층위만 신설하고 기존 9-stage VERIFY(stage G) + 5요소 Verification 정의는 무손상 유지. ARCHITECTURE § 3 신 paragraph 안 3중 의미 경계 표 — '책상 vs 현장' 단일 축 2:1 그룹핑 + **host 컬럼 의무**(각 라벨이 어느 source 에 정의되는가): (i) 9-stage VERIFY(G)=§ 4 stage 표 / (ii) 5요소 Verification=§ 3.3 row / (iii) 제품 역량 검증=§ 3.1 신 paragraph. host 컬럼으로 LLM-reader 가 '검증' 단어 만났을 때 어느 라벨인지 disambiguate.",
      "rationale": "sc_4 + opt_3 채택. cb_4 상 '검증'은 이미 (i)9-stage VERIFY(G) + (ii)5요소 Verification 두 곳에서 '자기점검(책상)' 의미 확립 — 제품 층위만 별도 명명하면 단어 정의 손대지 않아 sc_5 FAIL=0 자연 + 사용자 재승인 게이트 불요. opt_4(9-stage 재정의)는 큰 건이라 폐기. **단어-책임 1:1 매핑(v2.0) 위반 아님** — '한 단어=세 책임'이 아니라 '세 라벨=세 책임'(design-review spec-drift 확정). host 컬럼 = design-review dx decisive 흡수 (§ 7.1 컨텍스트 효율 + § 3.5 단일 source 정합)."
    },
    {
      "id": "d_4",
      "decision": "self-loop 92.3% / 운용 부합도 77.5% 프레임(§ 3.1 line 77, v5.8 paragraph)을 재라벨 — 수치 자체는 보존하고 해석만 명시 라벨로 정정. 재라벨 본질 = (a) '이 수치를 제품 역량 검증 증거로 오독하는 외부 독자 착시 차단' 명시 라벨 + (b) sc_1 분리 선언과의 명시적 연결('이 수치는 제품 역량 증거 아님') + (c) 'v4.0~v5.7, 13 milestone 기준 시점 고정 수치'임을 명시(현 시점 비율로 오독 차단). living § 3.1 표현만 정정, 과거 v5.x milestone(grep 77 파일) 무손상.",
      "rationale": "sc_3 + risk_3 mitigation. oos_2 정합 — 재라벨 = 서술 정정이지 수치 소급 변경 아님. design-review spec-drift comment 흡수: v5.8 원문은 이미 'drift 진단'(긍정 지표 아님)이므로 재라벨 = '긍정→통계 강등' 아닌 '착시 차단 명시 라벨 추가 + sc_1 연결 + 시점 고정'. 수치 stale 가능성(v5.8~v8.5 이후 milestone 누적)도 (c)로 해소."
    },
    {
      "id": "d_5",
      "decision": "정전화 host = ARCHITECTURE § 3 권역 신 paragraph 1차 source(§ 3.1 끝, d_1~d_4 흡수) + § 3.3 Verification row 명료화 절(자기점검 층위 명시 + 신 paragraph pointer) + § 7.1 단방향 pointer. 산출물 = 문서 only(mechanism 부재), cascade marker 부재 자연(§ 7.1/§ 7.3 단방향 pointer 선례 동형).",
      "rationale": "opt_5 + risk_4 mitigation. self-loop 재라벨 대상(cb_2, § 3.1)과 5요소 Verification gap(cb_1, § 3.3)이 모두 § 3 권역이라 1차 source 단일 host 가 자연. § 7(운영 원칙)은 중복 회피 위해 단방향 pointer."
    },
    {
      "id": "d_6",
      "decision": "기존 9-stage workflow 단어 정의 + smoke 27종 전부 무변경 — DESIGN 산출물은 ARCHITECTURE.md narrative edit 뿐(스키마/단어/smoke 판정 미변경). sc_4 결과가 'd_3 = 제품 층위만'으로 확정돼 sc_5 단서(범위 확대 시 재승인) trigger 미발생.",
      "rationale": "sc_5 직접. RESEARCH opt_3 채택으로 범위 확대 회피 확정 — 사용자 재승인 게이트 불요. smoke FAIL=0 가 phase 검증으로 보장."
    }
  ],
  "approach": "단일 phase(문서 정전화 only) — 본 milestone 은 INTENT goal '재정의(원칙 선언)'이고 oos_1(능동 의무화 비선택)·oos_3(mechanism 종속)으로 범위가 좁혀져 산출물이 ARCHITECTURE.md narrative edit 뿐이다. phase-1 = § 3 권역 정전화 3 부분(§ 3.1 끝 신 paragraph 본체 + § 3.3 Verification row 명료화 절 + § 7.1 단방향 pointer)을 한 logical 단위로 작성. cascade host = § 3 신 paragraph 단일 1차 source(§ 7 는 pointer만, cascade marker 부재 자연). 검증 = smoke FAIL=0(sc_5/d_6) + cascade_sync --check(드리프트 0) + 사용자 확인(원칙 선언 문안). ROADMAP milestones[] in_progress→completed 전환 + CHANGELOG/PROPOSE 후속 candidate 는 REPORT/PROPOSE stage 책임이라 EXECUTE phase 밖.",
  "phases": [
    {
      "phase": "phase-1",
      "scope": "ARCHITECTURE.md § 3 권역 정전화 — (a) § 3.1 끝 신 paragraph: 자기개발(책상)≠제품 역량 검증(현장) 분리 선언(d_1) + 외부 적용 1차 vector 정전화 + v8.3/v8.5 근거 인용(d_2) + self-loop 92.3% 재프레임(d_4) + 3중 의미 경계 표(d_3). (b) § 3.3 Verification row 에 '자기점검(책상) 층위' 명시 절 + 신 paragraph pointer(d_5). (c) § 7.1 3면 매트릭스 인근 단방향 pointer(d_5).",
      "deliverable": "development/ARCHITECTURE.md (§ 3.1 끝 신 paragraph + § 3.3 row 명료화 + § 7.1 pointer 3 edit) + development/milestones/v8.6/execute/phase-1.md (변경 trace).",
      "verification": "bash tests/smoke-spec-verification.sh (PASS, FAIL=0 — d_6/sc_5) + python scripts/cascade_sync.py --check (marker 보유 host drift 0 — risk_4) + 사용자 확인. ★ 검증 책임 분리(design-review dx 흡수): cascade_sync --check 는 marker 기반이라 § 3↔§ 7 단방향 pointer(marker 부재 자연)는 자동 추적 안 함 → § 7 pointer 정합은 사용자 확인 책임."
    }
  ],
  "risk_mitigation": [
    {
      "risk_ref": "risk_1",
      "decision_ref": "d_2",
      "method": "근거를 '현 evidence 누적 2건(forward 누적)'으로 정직 표기 + v8.5 L2(대조군이 과적합 반증)를 reverse-evidence 로 인용. d_2 서술은 단정형('항상 외부에서만 통한다') 회피, '자기개발은 역량 증거 아님'의 negative claim 중심."
    },
    {
      "risk_ref": "risk_2",
      "decision_ref": "d_3",
      "method": "d_3 = 제품 층위만 신설(기존 단어 무손상) + 신 paragraph 안 3중 의미 경계 표(9-stage VERIFY(G)/5요소 Verification = 자기점검·책상 vs 제품 역량 검증 = 현장·외부)로 명시 구별. 신층위 구별 라벨 = '제품 역량 검증(외부 vector)'."
    },
    {
      "risk_ref": "risk_3",
      "decision_ref": "d_4",
      "method": "oos_2 정합 — 과거 v5.x milestone 무손상, living § 3.1 표현만 정정. 수치(92.3%/77.5%) 보존 + 해석만 재프레임. 재라벨 = 서술 정정이지 수치 소급 변경 아님."
    },
    {
      "risk_ref": "risk_4",
      "decision_ref": "d_5",
      "method": "1차 source 단일 host(§ 3 신 paragraph) 지정 + § 7 단방향 pointer(§ 7.1/§ 7.3 선례 동형, cascade marker 부재 자연). cascade_sync --check 로 drift 0 확인. 다중 host 분산 회피."
    }
  ],
  "five_perspective_review": {
    "method": "subagent design-review N+가변 호출 (architecture / spec-drift / dx 3 관점 — 순수 narrative milestone 이라 security/performance 제외, v7.0 T1.3 N+가변 정합). 전체 verdict = pass-with-comments, decisive 1건(dx host 컬럼) 즉시 흡수 완료(d_3) + 비결정적 3건 흡수(d_1 두괄 명제/d_4 재라벨 정밀화/phase-1 cascade_sync 책임 분리).",
    "perspectives": [
      {
        "perspective": "architecture",
        "verdict": "PASS",
        "comments": "host 결정(§ 3 1차 source + § 7 단방향 pointer)이 § 3(정의)/§ 7(운영 방식) 직교 구조에 정확 정합 — '제품 역량 검증'의 정의는 5요소 Verification 이 못 메운 gap(cb_1)이라 § 3 권역 적합, 운영 연결만 § 7 pointer. d_5 '단방향 pointer 선례 동형' 주장이 실재 선례 2건(ARCHITECTURE.md:283 § 7.1 / :300 § 7.3)으로 grounding 확인. 결정적 이슈 없음. scope-out: 5요소 Verification 정의를 제품 역량 층위까지 확장(6번째 차원)할지는 oos_1 후속 candidate."
      },
      {
        "perspective": "spec-drift",
        "verdict": "pass-with-comments",
        "comments": "단어-책임 1:1 매핑(v2.0) 위반 없음 확정 — 3중 의미는 '한 단어=세 책임'(위반) 아니라 '세 라벨=세 책임'(정합), d_3 경계 표가 정전 강화. d_4 self-loop 재라벨 ↔ oos_2 충돌 없음(living § 3.1 단일 정정, 수치 trace 보존). comment(비결정적): v5.8 원문은 이미 drift 진단 프레임이라 재라벨 본질 = '착시 차단 명시 라벨 + sc_1 연결'(d_4 흡수) + '시점 고정 수치 명시'(d_4 (c) 흡수). 모두 흡수 완료."
      },
      {
        "perspective": "dx",
        "verdict": "pass-with-comments",
        "comments": "decisive 1건(즉시 흡수): 3중 의미 경계 표에 host 컬럼 의무 — LLM-reader 가 '검증' 단어 만났을 때 어느 라벨인지 disambiguate 필수(d_3 흡수). 비결정적: § 3.1 신 paragraph 두괄 = negative 명제 우선/비유 보조(d_1 흡수), cascade_sync --check 가 marker-부재 § 7 pointer 자동 검출 못 함 → 사용자 확인 책임 분리(phase-1 verification 흡수). entry-title 가이드(§ 7.2) 4원칙 + smoke-entry-title-guideline 통과 예상."
      }
    ]
  }
}
```

### Narrative

DESIGN 은 RESEARCH 5 option 채택 결과를 6 decision 으로 고정했다 — d_1(분리 선언, sc_1) + d_2(외부 vector 1차 정전화 + v8.3/v8.5 근거, sc_2) + d_3(검증 단어 경계 = 제품 층위만, sc_4) + d_4(self-loop 재라벨, sc_3) + d_5(정전화 host = § 3 1차 source + § 7 pointer) + d_6(9-stage 단어/smoke 무손상, sc_5). sc_1~sc_5 ↔ d_1~d_6 가 1:1 직접 매핑되고, risk_1~risk_4 가 각각 d_2/d_3/d_4/d_5 에 mitigation 결선된다. 산출물은 opt_1(문서 only) 채택으로 ARCHITECTURE.md § 3 권역 3 edit 단일 phase 에 수렴 — mechanism 부재(oos_3), 9-stage 단어 정의·smoke 무변경(d_6 → sc_5 FAIL=0 자연, 사용자 재승인 게이트 미발생).

cascade host 는 § 3 신 paragraph 단일 1차 source 다. § 3.3 Verification row 명료화 절과 § 7.1 pointer 는 1차 source 를 가리키는 단방향 pointer 로, cascade marker 부재가 § 7.1(ARCHITECTURE.md:283)·§ 7.3(:300) 단방향 pointer 선례와 동형이다(design-review architecture 가 선례 2건 grounding 확인). 따라서 risk_4(다중 host drift)는 단일 1차 source 지정으로 해소되고, cascade_sync --check 는 marker 보유 host 만 추적하므로 § 7 pointer 정합은 사용자 확인 책임으로 분리 명시했다(design-review dx 흡수).

5 관점 검토는 design-review subagent 를 architecture/spec-drift/dx 3 관점(순수 narrative 라 security/performance 제외, v7.0 T1.3 N+가변)으로 호출해 전체 pass-with-comments 를 받았다. 결정적 이슈 1건(dx — 3중 의미 경계 표 host 컬럼)은 d_3 에 즉시 흡수했고, 비결정적 comment 3건(d_1 두괄 명제 우선 / d_4 재라벨 정밀화 = '착시 차단 + sc_1 연결 + 시점 고정' / phase-1 cascade_sync 책임 분리)도 모두 흡수했다. 질문이 제기한 3개 긴장 — host 선택(§ 3 vs § 7), 3중 의미의 단어-책임 1:1 매핑 위반 여부, self-loop 재라벨 ↔ oos_2 충돌 — 은 모두 1차 source 검증으로 충돌 없음이 확정됐다. scope 외 거명(5요소 6번째 차원 확장 / 외부 적용 누적 카운터 / skill 계열 제품 역량 노출)은 ## SCOPE_OUT_NOTES 에 자동 등재 금지로 보존한다.

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-26",
    "approval_summary": "사용자가 DESIGN(§ 3 권역 3 edit 문서 정전화 only — d_1 자기개발≠제품 역량 검증 분리 선언 + d_2 외부 vector 1차 정전화 + d_3 검증 단어 경계 제품 층위만 신설 + d_4 self-loop 92.3% 재라벨 + d_5 host § 3 1차 source/§ 7 pointer + d_6 9-stage·smoke 무손상)으로 EXECUTE 진입을 '진행' 명시 승인. design-review 3관점 pass-with-comments + decisive 1건/비결정적 3건 전부 흡수 후 게이트 통과."
  }
}
```

### Narrative

EXECUTE 진입 게이트 — 사용자가 DESIGN 제시(2026-05-26) 후 '진행' 으로 명시 승인했다. 승인 범위 = phase-1 단일(ARCHITECTURE.md § 3 권역 3 edit, 문서 정전화 only, mechanism 부재). sc_4 결과가 d_3('제품 층위만')으로 확정돼 sc_5 단서(범위 확대 시 재승인) trigger 미발생 — 본 승인이 EXECUTE 전 범위를 cover.

## EXECUTE

phase-1 (단일) 완료 — ARCHITECTURE.md § 3 권역 3 edit (문서 정전화 only, 별책 [`execute/phase-1.md`](execute/phase-1.md)):

- **(a) § 3.1 끝 신 paragraph** — 검증철학 분리 선언(두괄 negative 명제 + 책상/현장 2 범주 + 외부 vector 1차 정전화 v8.3/v8.5 근거 + self-loop 92.3% 재라벨 + '검증' 3중 의미 경계 표 host 컬럼). d_1~d_4 흡수.
- **(b) § 3.3 Verification row** — '자기점검=책상 검증 층위' 명시 절 + § 3.1 pointer. 기존 정의 무손상(d_6).
- **(c) § 7.1** — '제품 역량 검증(외부 vector) 연결' 단방향 pointer (정의 1차 source = § 3.1, cascade marker 부재 자연). risk_4 mitigation.

검증 = smoke FAIL=0(d_6/sc_5) + cascade in sync. 커밋 = 사용자 명시 대기.

## VERIFY

### Spec

```json
{
  "smoke": [
    {"check": "tests/smoke-spec-verification.sh", "result": "PASS=482 FAIL=0 SKIP=290", "note": "v8.6#intent/research/design 전부 OK + 9-stage 산출물 schema 무손상 (d_6/sc_5)"},
    {"check": "tests/smoke-entry-title-guideline.sh", "result": "PASS (no violations)", "note": "ROADMAP entry title 무변경 — ' + ' literal 부재 + ≤60자"},
    {"check": "scripts/cascade_sync.py --check", "result": "all 1 host(s) in sync", "note": "ARCHITECTURE 100KB 초과 WARN skip(자동검증 밖). § 3↔§ 7 단방향 pointer = marker 부재라 사용자 확인 책임(risk_4/design-review dx)"}
  ],
  "criteria_check": [
    {"sc": "sc_1", "verdict": "MET", "evidence": "§ 3.1 신 paragraph 두괄 negative 명제('자기개발 횟수는 제품 역량 검증 증거 아님') + 책상/현장 2 범주 분리 정의 + 각 검증 방식 + '보장하는 것/못 하는 것' 명문화. 1차 source 명시 선언 완료."},
    {"sc": "sc_2", "verdict": "MET", "evidence": "§ 3.1 신 paragraph '제품 역량 검증 = 외부 적용이 1차 역량 검증 vector' 정전화 + v8.3(L41 외부 결함 검출) + v8.5(L49/L54 정정 실효+과적합 반증) 근거 사례 cross-ref 인용."},
    {"sc": "sc_3", "verdict": "MET", "evidence": "§ 3.1 신 paragraph 'self-loop 92.3% 재라벨' 절 — 수치 보존 + 'v4.0~v5.7 시점 고정' + '자기개발 trace 통계이지 검증 성숙도 아님' 재프레임. 과거 milestone 무손상(oos_2)."},
    {"sc": "sc_4", "verdict": "MET", "evidence": "'검증' 3중 의미 경계 표(라벨/층위/본질/host 4 컬럼) — 제품 층위만 신설, 9-stage VERIFY(G)+5요소 Verification 정의 무손상. design-review spec-drift '단어-책임 1:1 위반 없음(세 라벨 세 책임)' 확정. 경계 결정+근거 DESIGN d_3 기록."},
    {"sc": "sc_5", "verdict": "MET", "evidence": "smoke FAIL=0(spec-verification 482 PASS) + 9-stage 단어 정의·smoke 27종 무변경(d_6). sc_4 결과 d_3='제품 층위만'이라 범위 확대 trigger 미발생 → 사용자 재승인 게이트 불필요."}
  ],
  "verdict": "RESOLVED"
}
```

### Narrative

sc_1~sc_5 전부 MET, verdict RESOLVED. 5 success_criteria 가 § 3.1 신 paragraph 단일 host 에 흡수 — 분리 선언(sc_1) + 외부 vector 정전화(sc_2) + self-loop 재라벨(sc_3) + 검증 단어 경계 표(sc_4) + 무손상(sc_5). smoke 3종(spec-verification FAIL=0 / entry-title PASS / cascade in sync) 회귀 차단 통과로 d_6 가 sc_5 를 보장한다. 단, cascade_sync --check 는 ARCHITECTURE 100KB 초과 WARN skip + § 3↔§ 7 단방향 pointer(marker 부재)라 자동 추적 밖이므로 § 7.1 pointer 정합은 사용자 확인 책임으로 분리 명시했다(design-review dx 흡수, 결함 아닌 선례 동형 설계 자연 귀결). risk_1~risk_4 mitigation 이 모두 EXECUTE 산출에 반영됐다 — 실증 '현 evidence 2건 forward 누적' 정직 표기(risk_1) / 3중 경계 표(risk_2) / 수치 보존 재라벨(risk_3) / 단일 1차 source+pointer(risk_4).

## REPORT

### Spec

```json
{
  "summary": "v8.0 meta≠project 재분류의 개념적 후속(oos_3 origin) — 검증철학을 정전화. 자기개발(meta self-loop, 책상 검증)과 제품 역량 검증(외부 적용, 현장 검증)을 ARCHITECTURE § 3.1 신 paragraph 에 명시 분리 선언하고, 외부 적용을 제품 컨설팅 자산의 1차 역량 검증 vector 로 정전화. self-loop 92.3% 수치는 '자기개발 trace 통계'로 재라벨(수치 보존). '검증' 단어 3중 의미(9-stage VERIFY(G)/5요소 Verification = 책상 vs 제품 역량 검증 = 현장)는 제품 층위만 신설로 경계(기존 단어 무손상). 산출물 = 문서 정전화 only(§ 3.1 신 paragraph 1차 source + § 3.3 row 명료화 + § 7.1 단방향 pointer).",
  "delta": [
    {"item": "INTENT 대비 delta", "detail": "두 결정적 경계(산출물 모양 + 검증 단어 층위)가 RESEARCH 에서 opt_1(문서 only) + opt_3(제품 층위만)으로 확정 → DESIGN/EXECUTE 무이탈. sc_4 가 '제품 층위만'이라 sc_5 범위 확대 trigger 미발생 = 사용자 재승인 게이트 불필요."},
    {"item": "design-review 흡수", "detail": "3관점(architecture PASS / spec-drift·dx pass-with-comments) decisive 1건(경계 표 host 컬럼) + 비결정적 3건(두괄 명제/재라벨 정밀화/cascade_sync 책임 분리) 전부 흡수. 3개 긴장(host 선택/단어-책임 위반/재라벨↔oos_2) 1차 source 충돌 없음 확정."},
    {"item": "scope_out 거명", "detail": "5요소 6번째 차원 확장 / 외부 적용 누적 카운터 / skill 계열 제품 역량 노출 3건 = ## SCOPE_OUT_NOTES 보존(PROPOSE 게이트 후만 등재)."}
  ],
  "lessons_learned": [
    {"id": "L1", "priority": "P1", "lesson": "dogfooding 착시 = 자기개발 횟수(~200)를 제품 역량 증거로 혼동. 이 milestone 자체가 검증철학 정전화를 self-loop 로 수행(책상 검증)했으므로, 본 정전화의 '제품 역량' 입증은 외부 적용 능동 추진(별도 후속, oos_1)으로만 가능 — 정전화 ≠ 역량 검증."},
    {"id": "L2", "priority": "P2", "lesson": "'검증' 같은 다의어는 host 컬럼(어디에 정의되는가)이 LLM-reader disambiguation 의 핵심 — design-review dx decisive. 개념 나열만으론 독자가 실제 텍스트에서 역추적 불가."},
    {"id": "L3", "priority": "P2", "lesson": "수치 재라벨은 '값 삭제/수정'이 아니라 '해석 라벨 추가 + 시점 고정 명시'로 trace 무손상 가능(oos_2 정합). v5.8 원문이 이미 drift 진단이라 '긍정→통계 강등'이 아닌 '오독 차단 라벨'이 정확한 본질이었음(design-review spec-drift 정밀화)."},
    {"id": "L4", "priority": "P3", "lesson": "ARCHITECTURE 100KB 초과로 cascade_sync WARN skip + 단방향 pointer marker 부재 = 자동 검증 밖 영역이 누적됨. 현재는 사용자 확인 책임으로 분리하나, 파일 크기/marker 정책은 후속 관찰 대상."}
  ]
}
```

### Narrative

본 milestone 은 v8.0 이 구조(디렉토리)로 분리한 meta≠project 재분류의 개념적 후속을 완결했다 — 검증철학을 ARCHITECTURE § 3.1 에 정전화. 핵심 성과 = '자기개발 횟수는 제품 역량 검증의 증거가 아니다'라는 negative 명제를 1차 source 에 두괄로 고정하고, 외부 적용을 제품 역량의 1차 검증 vector 로 선언(v8.3/v8.5 실증 2건 근거)한 것이다. 자기 자신을 만드는 도구라는 harness-meta 의 본질상 dogfooding 은 계속되나, 그 횟수를 역량 증거로 혼동하던 착시(self-loop 92.3% 프레임)를 재라벨로 해소했다.

가장 중요한 lesson(L1)은 자기참조적이다 — 본 검증철학 정전화 자체가 self-loop(책상 검증)로 수행됐으므로, '이 원칙이 외부에서 통한다'는 입증은 외부 적용 능동 추진(oos_1, 별도 후속)으로만 가능하다. 즉 정전화는 원칙 선언이지 역량 검증이 아니며, 이 milestone 은 자기 자신에게 그 구분을 적용한다. design-review 가 1차 source 검증으로 3개 긴장을 모두 충돌 없음으로 확정했고, decisive 1건(host 컬럼)을 포함한 4 comment 를 전부 흡수해 verdict RESOLVED 에 도달했다.

## PROPOSE

### Spec

```json
{
  "next_candidates": [
    {
      "id": "external-application-active-drive",
      "title": "외부 적용 능동 추진 — 제품 역량 검증 vector 실행",
      "trigger": "A_user",
      "origin_milestone": "v8.6",
      "target_version": "v8.7",
      "rationale": "v8.6 oos_1 direct origin — v8.6 은 검증철학 '재정의(원칙 선언)'까지였고 외부 적용 능동 추진/의무화는 비선택으로 분리됐다. L1 자기참조 lesson: 정전화는 self-loop(책상)로 수행됐으므로 이 원칙이 '외부에서 통한다'는 입증은 외부 적용 능동 추진으로만 가능. 새 외부 프로젝트 확보 또는 기존(upbit/price-compare) 심화 적용 = 제품 역량 검증 vector 실행. 사용자 명시 발의 게이트 필요.",
      "decision_pending": "사용자 명시 결정 전까지 next_candidates[] append 보류 (v7.0 T1.2 정합)"
    }
  ],
  "scope_out_carryover": [
    "5요소 Verification 정의를 제품 역량 층위까지 확장(6번째 차원)할지 — 외부 적용 능동 추진 후속과 함께 재고 (## SCOPE_OUT_NOTES architecture)",
    "외부 적용 누적 카운터 / 갱신 가능 trace 표현 — opt_2 폐기(과적합) 후 외부 적용 충분 누적 시 재고 (## SCOPE_OUT_NOTES spec-drift)",
    "skill 계열(stage-verify 등)에 '제품 역량 검증' 개념 노출 필요 여부 — 외부 적용 능동 추진 시 별도 candidate (## SCOPE_OUT_NOTES dx)"
  ]
}
```

### Narrative

본 milestone 의 1차 forward candidate = `external-application-active-drive`(v8.7 target) — v8.6 oos_1 의 직접 origin 이자 L1 자기참조 lesson 의 자연 귀결이다. v8.6 이 검증철학을 '원칙 선언'으로 정전화했으니, 그 원칙이 실제 외부에서 통한다는 입증은 외부 적용 능동 추진으로만 가능하다(self-loop 정전화 ≠ 제품 역량 검증). ## SCOPE_OUT_NOTES 3건(5요소 차원 확장 / 외부 적용 카운터 / skill 제품 역량 노출)은 모두 외부 적용 누적에 종속되는 후속이라 본 candidate 와 테마 정합 — 능동 추진이 누적되면 자연 재고된다.

v7.0 T1.2 정합 — 위 next_candidate 는 거명까지이며 ROADMAP `next_candidates[]` 실 append 는 사용자 명시 결정 게이트 후만 수행한다(자동 append 폐지).

## SUB_MILESTONES

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음)

## SCOPE_OUT_NOTES

> Stage D design-review 안 scope 외 거명 (v7.0 T1.3 — 자동 candidate 등재 금지, PROPOSE stage 사용자 명시 결정 게이트 후만 next_candidates[] 등재).

- **5요소 Verification 정의 확장 여부** — 본 milestone 은 d_3 으로 5요소 Verification 정의를 무손상 유지하고 '제품 역량 검증'을 § 3 paragraph 별도 범주로 둔다. 장기적으로 'Verification 5요소가 책상 층위만 cover 하는가, 제품 역량 층위까지 6번째 차원/확장으로 cover 해야 하는가'는 외부 적용 능동 추진(oos_1) 후속과 함께 재고 candidate. (architecture)
- **외부 적용 누적 카운터 / 갱신 가능 trace 표현** — opt_2(self-loop ratio tracker / 외부 vector counter) 폐기(과적합 risk_1) 후, 외부 적용이 능동 추진으로 충분히 누적되면 'self-loop 92.3% 같은 시점 고정 수치 대신 갱신 가능한 trace 표현' 재고 candidate. (spec-drift)
- **skill 계열 제품 역량 검증 개념 노출** — § 7.3 derived skill(stage-verify 등)은 본 milestone scope 밖(d_5/d_6 narrative edit 뿐). 후속 외부 적용 능동 추진 시 skill 계열에 '제품 역량 검증' 개념 노출 필요 여부 별도 candidate. (dx)
