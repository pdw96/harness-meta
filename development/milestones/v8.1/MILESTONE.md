---
id: meta-lightweight-flow-design
title: meta 가벼운 흐름을 컨설팅 자산으로 도입
version: v8.1
status: in_progress
---

# v8.1 — meta 가벼운 흐름을 컨설팅 자산으로 도입

## INTENT

### Spec

```json
{
  "id": "meta-lightweight-flow-design",
  "title": "meta 가벼운 흐름을 컨설팅 자산으로 도입",
  "goal": "작은 meta-work 용 **가벼운 흐름**(문제→결정→적용→기록 4섹션 한 장)을 설계하고, 이를 meta 전용이 아니라 외부 프로젝트도 쓸 수 있는 **컨설팅 자산**으로 정전화한 뒤 meta 에 먼저 적용·검증한다. 무거운 9단계는 '큰 건'(컨설팅 자산 변경) 전용으로 남기고 가벼운 흐름과 두 갈래 공존시킨다. v8.0 재구성의 2단계.",
  "motivation": "v8.0(meta→development/ 재분류)의 oos_1+oos_2 후속이자 사용자 pre-PLAN 대화(2026-05-26)로 본질 격상. harness-meta 의 정체성은 **harness engineering 컨설턴트**(다른 프로젝트에 harness 를 만들어주는 존재) — 그렇다면 9단계 무거운 절차는 '고객 납품물(방법론·도구)을 바꾸는 큰 건'에나 맞고, 작은 meta-work(자기 사무실 운영)에 그걸 강제해온 것은 본말전도였다. 그 봉합이 lightweight 1-phase 모드(9단계 형식만 거치고 실질 1장)와 동결 정책(자기참조 milestone deferred) 두 반창고. v6.23 표본이 증거 — 9단계 전부 거친 산출이 자기 장부정리 문단 1개. 실데이터도 확증: development/ milestone 30건 중 압도적 다수가 1-phase(가벼움), v7.0 급 큰 건은 드묾. 가벼운 흐름은 그 다수가 원래 있어야 할 자리이며, 외부 제공 컨설팅 자산으로 격상하면 upbit 등에도 '작은 변경은 가벼운 트랙'을 제공할 수 있다.",
  "success_criteria": [
    {"id": "sc_1", "criterion": "가벼운 흐름 정의(4섹션 = 문제→결정→적용→기록)와 그 산출물 schema 가 1차 source(ARCHITECTURE.md)에 정전화. 9단계와의 관계(두 갈래 공존)도 명문화."},
    {"id": "sc_2", "criterion": "가벼운 흐름을 강제/안내하는 mechanism(skill 또는 template + 필요 시 smoke)이 설치되고, meta 와 외부 프로젝트 양쪽에 적용 가능한 형태(컨설팅 자산)로 구성됨."},
    {"id": "sc_3", "criterion": "승격 기준 명문화 — '컨설팅 자산(방법론·도구)에 영향 = 큰 건(9단계) / 내부·작은 조정 = 가벼운 흐름'이 판단 가능하게 1차 source 에 기록. v8.1 자체가 큰 건(9단계)인 근거 포함."},
    {"id": "sc_4", "criterion": "두 반창고 처리 — lightweight 1-phase 모드는 가벼운 흐름이 대체함을 명시(은퇴) + 동결 정책은 meta≠project 재분류·컨설턴트 프레임 하에서 재평가한 결과(은퇴/유지/조건부)를 기록."},
    {"id": "sc_5", "criterion": "meta 검증 — 가벼운 흐름이 실제 meta-work 에 작동함을 입증(예시 산출물 1건 작성 또는 도그푸드). 가벼운 흐름 산출물이 검증 mechanism(smoke 등)을 통과."},
    {"id": "sc_6", "criterion": "기존 9단계 워크플로우 무손상 + smoke 전체 PASS(FAIL=0). 두 갈래 공존 — 가벼운 흐름 도입이 9단계 정의/skill/smoke 판정을 깨뜨리지 않음."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "upbit 등 외부 프로젝트에 가벼운 흐름 **실제 적용** — 자산은 외부도 쓸 수 있게 설계하되, 실 적용은 후속(v8.x). 사용자 결정 '자산 설계 + meta 검증까지'. v8.0 oos_5(외부 구조 미변경) 점진주의 정합."},
    {"id": "oos_2", "item": "검증철학 재정의(dogfooding 은퇴, 외부 적용을 1차 검증 vector 로) — v8.2 별도 후속(v8.0 oos_3). 본 milestone 은 가벼운 흐름 도입까지."},
    {"id": "oos_3", "item": "9단계 워크플로우 자체의 단어 정의/MILESTONE.md schema/smoke 판정 로직 변경 — 큰 건은 계속 9단계. 가벼운 흐름은 별 트랙 추가일 뿐, 9단계를 폐기·축소하지 않음(두 갈래 공존)."}
  ],
  "dependencies": [
    {"id": "dep_1", "ref": "development/milestones/v8.0/MILESTONE.md (oos_1+oos_2)", "purpose": "본 milestone 의 직접 origin — 1단계(위치 재분류) 완료 후 2단계(가벼운 흐름+반창고 은퇴)로 명시 분기. 부트스트랩('마지막 9단계 milestone' 선언)의 재해석 source."},
    {"id": "dep_2", "ref": "사용자 pre-PLAN 대화 (2026-05-26) — 7항 결론", "purpose": "goal/motivation/sc 결정 직접 origin. 정체성(컨설턴트)·흐름 실물(4섹션)·두 갈래 공존·승격 기준·v8.1=9단계·범위(meta 검증까지)·반창고 처리 합의."},
    {"id": "dep_3", "ref": "memory project-harness-meta-as-consultant", "purpose": "정체성 = harness engineering 컨설턴트. 가벼운 흐름을 '컨설팅 자산'으로 격상하는 본질 근거 + 승격 기준의 판단 축(고객 납품물 vs 내부 운영)."},
    {"id": "dep_4", "ref": "development/ARCHITECTURE.md § 3(정의) + § 4(9-stage) + § 7(AI Native)", "purpose": "가벼운 흐름 정의가 정전화될 위치 + 9단계와의 관계 명문화 대상. § 7 AI Native(컨텍스트 효율·자율성) 정합 검증."},
    {"id": "dep_5", "ref": "development/ROADMAP.md deferred_note(동결 정책) + CLAUDE.md lightweight 1-phase 거명", "purpose": "두 반창고의 1차 source — sc_4 은퇴/재평가 대상 enumerate. RESEARCH 에서 정밀 좌표화."}
  ]
}
```

### Narrative

본 INTENT 는 v8.0 재구성의 **2단계** — 1단계(meta 를 development/ 로 위치 재분류)가 '사무실과 납품물을 헷갈리지 말자'였다면, 2단계는 그 사무실에 맞는 **가벼운 작업 흐름**을 들이는 일이다.

핵심 전환은 사용자 pre-PLAN 대화에서 나왔다. harness-meta 를 **harness engineering 컨설턴트**로 보면, 9단계 무거운 절차는 '고객 납품물(방법론·도구)을 바꾸는 큰 건'에나 어울리고 작은 meta-work 엔 과하다. 그 과함을 임시 봉합한 게 lightweight 1-phase 모드와 동결 정책 두 반창고다(motivation). 그래서 (1) 4섹션 한 장 가벼운 흐름을 정전화하고(sc_1), (2) 그것을 강제/안내하는 mechanism 을 설치하되 meta 전용이 아니라 **외부도 쓸 컨설팅 자산**으로 만들고(sc_2), (3) '큰 건 9단계 / 작은 건 가벼운 흐름' 승격 기준을 명문화하며(sc_3), (4) 두 반창고를 은퇴/재평가하고(sc_4), (5) meta 에 먼저 적용해 검증한다(sc_5). 9단계는 폐기가 아니라 큰 건 전용으로 **공존**한다(sc_6, oos_3).

**범위 경계** — 사용자 결정으로 '자산 설계 + meta 검증까지'이고, upbit 실 적용(oos_1)·검증철학 재정의(oos_2)는 후속으로 분리한다. **부트스트랩** — v8.1 자체는 '새 컨설팅 자산을 추가하는 큰 건'이므로 9단계로 진행한다. 이로써 v8.0 의 '마지막 9단계 milestone' 선언은 'meta 전용' 가정이 '외부 제공 자산'으로 격상되며 자연 갱신된다(dep_1).

## RESEARCH

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": ".claude-plugin/plugin.json:18 (`\"skills\": \"./skills/\"`)", "finding": "Claude Code plugin spec — skills 필드가 `./skills/` 디렉토리 전체를 스캔해 SKILL.md 를 자동 발견. 새 skill 폴더 추가 시 plugin.json 수정 불필요(자동 인식). ∴ 가벼운 흐름 skill 을 plugin 배포 자산(외부 제공 가능)으로 만들기 용이 — 컨설팅 자산 본질 정합."},
    {"id": "ext_2", "source": "skills/stage-*/SKILL.md frontmatter (Anthropic Claude Code skill 표준)", "finding": "SKILL.md = frontmatter(name/description) + body. description 은 system reminder 자동 inject + plugin auto-discovery 매칭 (memory feedback_skill_description_auto_inject 정합). 새 가벼운 흐름 skill 도 동일 표준 따름 — trigger keyword + SKIP 조건 명시."}
  ],
  "codebase": [
    {"id": "cb_1", "ref": "development/ARCHITECTURE.md § 3(정의+5요소) / § 4:111-130(9-stage) / § 6.1(era) / § 7(AI Native)", "finding": "정전 single source 구조. 9단계 1차 source = § 4 본체(111-130), '단어=단일 책임 1:1 매핑' 원칙 = :117(v2.0_workflow-word-fidelity). 9단계 cross-ref host = 루트 CLAUDE.md / development/CLAUDE.md / claude/commands/harness-meta.md (참조만)."},
    {"id": "cb_2", "ref": "development/ARCHITECTURE.md § 4 끝 매트릭스(:135~:150)", "finding": "narrative 정전화 누적 매트릭스 = #1~#16(#15 결번, 직접 grep 확인 — 조사 agent '14행' 보고는 부정확). 행 형식 = `#/v{X.Y}(YYYY-MM-DD)/본질 한 문장/1차 source path/검증 method(boolean·표·수치 분류 + 예시 명령)`. 새 mechanism 등재 = #17 append."},
    {"id": "cb_3", "ref": "development/ARCHITECTURE.md:259 (§ 6.2 폐지 narrative, v4.0_harness-composer-pivot)", "finding": "v4.0(2026-05-13) 에 구 § 6.2 의 'Lightweight 모드 정책(v3.6 도입)' + 'Workflow self-improvement milestone 동결 정책' + 'Narrative 정전화 3단계 패턴' **모두 폐지 선언**. 새 정체성(§ 3.1)이 자연 가드레일. ∴ lightweight 는 '정책'으로선 이미 죽음 — 운영 관행만 잔존. 동결 정책도 명목상 폐지 선언됨."},
    {"id": "cb_4", "ref": "development/ROADMAP.md:8 deferred_note + :48~:70 deferred entry(v1.4/v1.5 3건)", "finding": "그러나 동결 정책은 deferred_note 에 **재발의 조건과 함께 잔존** — 조건 = '외부 projects/<name>(name≠meta) 실 적용 milestone 누적 5건+ ∧ 사용자 명시 발의 AND'. upbit 가 12건 도달(조건1 충족, projects/upbit/ROADMAP.md v1_16_note) + 조건2(사용자 발의) 대기. → cb_3 폐지 선언과 deferred_note 잔존 사이 **drift** 가 v8.1 재평가 대상."},
    {"id": "cb_5", "ref": "CHANGELOG.md (lightweight 1-phase 13개 정량 거명)", "finding": "lightweight 1-phase 는 정책 폐지(cb_3) 후에도 'lightweight 누적 N/M = X%' 형태로 CHANGELOG 에 정량 추적 — 즉 매 milestone 이 1-phase 로 자연 수렴하는 **운영 관행**. 가벼운 흐름이 이 관행의 자리를 정식 흐름으로 대체."},
    {"id": "cb_6", "ref": "skills/stage-*/SKILL.md (9-stage skill 구조)", "finding": "stage skill = frontmatter(name/description) + 4 H2 body(## 입력 / ## 작성할 것 / ## 검증 / ## 관련) + ARCHITECTURE § 7.3 derived checklist(cascade marker 부재, manual 갱신). 새 가벼운 흐름 skill 도 동형 구성 가능."},
    {"id": "cb_7", "ref": "tests/smoke-spec-verification.sh + tests/_era_detect.py:21-42", "finding": "detect_era() 가 디렉토리명 regex + 파일 존재로 5 era 분기 — 9-stage-flattened(`^v\\d+\\.\\d+$` + MILESTONE.md, 우선 검사) / bundled(+milestones.md) / 9-stage / 7-stage(PLAN.md) / skip. 가벼운 흐름 = 새 분기(예: + LIGHTWEIGHT.md) 추가. 단 flattened 가 MILESTONE.md 우선 검사라 새 분기 삽입 순서 주의."},
    {"id": "cb_8", "ref": "tests/ 12 active smoke", "finding": "조사 — 가벼운 흐름 도입 시 6건 무수정(entry-title/candidate-draft/frontmatter류) + 5건 경로/era 확장(spec-verification/scope-contract/bundle-trigger/open-stage-discipline/cross-ref) + 1건 자연 skip(cascade-drift, 4섹션은 cascade marker 부재). 회귀 차단 핵심 = 기존 9단계 milestone E2E PASS 유지."},
    {"id": "cb_9", "ref": "development/ARCHITECTURE.md plugin 배포 vs repo-local 구분 + .claude-plugin/plugin.json", "finding": "plugin 배포(공유) = skills/agents/commands/hooks / repo-local = .claude/rules + settings + development/ + tests/. 가벼운 흐름 자산은 skill/template = plugin 배포(외부 제공 가능) + 산출물 거주 = 프로젝트 repo(프로젝트별). 컨설팅 자산 = 방법론(plugin) / 산출물(프로젝트)."},
    {"id": "cb_10", "ref": "skills/harness-plan-verify/SKILL.md:4-9 + claude/commands/harness-meta.md(분기)", "finding": "9단계가 이미 '메타 + 프로젝트 양쪽 지원'(harness-plan-verify v1.36+) — 외부 공용 자산 선례. /harness-meta meta(repo 자체) vs <name>(.harness.toml 존재 시 프로젝트) 분기. meta = development/milestones 본체 / upbit = projects/upbit/는 참조 view(산출물은 upbit repo). 가벼운 흐름도 동일 양쪽 지원 패턴 적용 가능."}
  ],
  "options": [
    {"id": "opt_1", "label": "정전화 위치 = § 7.4 신설(AI Native 운영 구체 사례) — 채택 후보", "rationale": "가벼운 흐름은 § 7.1 컨텍스트 효율 면의 직접 구체 사례 + § 7.3 stage 본질(9단계 templated task)과 대조 배치 자연. 대안 = § 3.7(5요소 특수형) / § 4 끝(workflow 일부). DESIGN 에서 확정."},
    {"id": "opt_2", "label": "mechanism = skill 1개 + LIGHTWEIGHT.md template(4섹션) + smoke era 확장", "rationale": "9-stage skill 패턴(cb_6) 동형 + forcing function 보존. plugin 자동 배포(ext_1)로 외부 제공. skill=narrative checklist / template=schema 강제 / smoke=회귀 차단 3종 분담."},
    {"id": "opt_3", "label": "산출물 위치 = milestones/v{X.Y}/LIGHTWEIGHT.md (flattened era 동일 hierarchy)", "rationale": "era-detect 호환(cb_7) + ROADMAP milestones_path 동일 구조. 외부는 projects/<name>/milestones/v{X.Y}/LIGHTWEIGHT.md 로 parametrize(cb_10). 대안 = 별도 lightweight-flows/ 카탈로그(분리 명확하나 era-detect 복잡)."},
    {"id": "opt_4", "label": "두 반창고 처리 = lightweight 정책 폐지 재확인(가벼운 흐름이 관행 정식 대체) + 동결 정책 deferred_note 정리", "rationale": "cb_3 §6.2 폐지 선언 정합 + memory '§6.2 거론 금지' 정합 — 동결 정책을 '§6.2 부활'이 아니라 '컨설턴트 정체성 하 deferred_note drift 정리'로 프레이밍. 재발의 조건/잔존 narrative 를 v8.1 결정으로 갱신."},
    {"id": "opt_5", "label": "9단계 전면 폐기 후 가벼운 흐름 단일화 — 폐기", "rationale": "REJECT — pre-PLAN '두 갈래 공존' 결정 역행 + 큰 건(컨설팅 자산 변경) 엄밀성 상실. v8.0 oos_4(9단계 의미 불변) 정합 위반."}
  ],
  "risks_identified": [
    {"id": "risk_1", "description": "§ 6.2 폐지 선언(cb_3)과 deferred_note 동결 정책 잔존(cb_4) drift — 동결 정책 재평가 시 memory '§ 6.2 policy 거론 금지'(feedback_section_6_2_abolished)와 충돌 가능.", "mitigation": "동결 정책을 '§ 6.2 부활/재논의'가 아니라 '컨설턴트 정체성 하 deferred_note narrative 정리(drift 해소)'로 프레이밍. DESIGN d_X 에서 정확히 — deferred milestone 3건의 처리 방향(은퇴/유지/조건 갱신)을 사용자 게이트로."},
    {"id": "risk_2", "description": "smoke era 확장(4-section 분기 추가)이 _era_detect.py 검사 순서상 기존 9단계 milestone 을 오분류할 위험(flattened 가 MILESTONE.md 우선 검사).", "mitigation": "LIGHTWEIGHT.md 분기를 파일명으로 명확 구분 + 삽입 순서 신중(flattened 검사 전/후 결정) + 기존 30 milestone E2E PASS 확인(EXECUTE 검증). cb_7/cb_8 정합."},
    {"id": "risk_3", "description": "가벼운 흐름 vs 9단계 '승격 기준'이 모호하면 운영자(사용자/Claude)가 어느 트랙 쓸지 혼란 — 가벼운 게 기본이라며 큰 건도 가볍게 처리하는 오용.", "mitigation": "sc_3 승격 기준('컨설팅 자산 영향=9단계 / 내부·작은 조정=가벼운 흐름')을 1차 source 에 판단 예시와 함께 명문화 + v8.1 자체가 큰 건(9단계)인 근거를 worked example 로."},
    {"id": "risk_4", "description": "v8.1 범위가 'meta 검증까지'(oos_1)라 외부 제공 자산이 upbit 실 적용 없이 설계만 — 외부 공용성이 실증 안 된 반쪽 검증 위험.", "mitigation": "skill/template 을 plugin 배포 형태(공유 가능 구조, cb_9) + 산출물 위치를 프로젝트별 parametrize(opt_3)로 설계해 '외부 적용 준비 완료' 상태까지. 실 적용은 oos_1 후속(v8.x) 명시 — 설계 검증 ≠ 적용 검증 분리."},
    {"id": "risk_5", "description": "가벼운 흐름 '기록'(4섹션 1장)이 9단계 REPORT 대비 trace(REPORT+CHANGELOG+git 3중 보존, § 3.3 5요소 Trace) 약화 우려.", "mitigation": "'기록' 섹션이 검증 결과+교훈+후속을 압축 보존 + git/CHANGELOG 3중 보존은 동일 유지. 큰 건은 9단계라 풍부한 trace 유지(두 갈래 공존). DESIGN 5 관점 중 trace 관점 점검."}
  ]
}
```

### Narrative

본 RESEARCH 핵심 발견 = **두 반창고의 현황이 비대칭**이다. lightweight 1-phase 는 v4.0 § 6.2 폐지(cb_3)로 '정책'으로선 이미 죽었고 CHANGELOG 정량 거명(cb_5)으로 보듯 **운영 관행**만 잔존 — 가벼운 흐름이 이 관행의 자리를 정식 흐름으로 대체하면 자연 은퇴. 반면 동결 정책은 명목상 폐지(cb_3)됐으나 deferred_note 에 재발의 조건과 함께 잔존하고 upbit 가 카운트(12건)를 추적(cb_4) — **폐지 선언과 실제 잔존 사이 drift** 가 핵심 재평가 대상이다. memory '§ 6.2 거론 금지' 정합하게, 이를 '§ 6.2 부활'이 아니라 '컨설턴트 정체성 하 deferred_note narrative 정리'로 다룬다(risk_1, opt_4).

**mechanism** = skill 1개 + LIGHTWEIGHT.md template(4섹션) + smoke era 확장 3종 분담(opt_2) — 기존 9-stage skill(cb_6) + era-detect(cb_7) + plugin 자동 배포(ext_1) 인프라를 그대로 재사용. **외부 제공 자산** 본질은 'skill/template = plugin 배포(공유) / 산출물 거주 = 프로젝트 repo(프로젝트별)'로 분해(cb_9) — 9단계가 이미 메타+프로젝트 양쪽 지원(cb_10)하는 선례를 따른다.

**정전화 위치**(opt_1) = § 7.4 신설이 후보(AI Native § 7.1 컨텍스트 효율 면의 구체 사례 + § 7.3 stage 본질과 대조) — DESIGN 에서 확정. **승격 기준**(risk_3) 명문화와 **trace 보존**(risk_5)은 DESIGN 5 관점 검토에서 점검한다. v8.1 범위가 'meta 검증까지'(risk_4)라 외부 공용성은 '적용 준비 완료' 구조까지 설계하고 실 적용은 oos_1 후속으로 분리한다.

## DESIGN

### Spec

```json
{
  "decisions": [
    {"id": "d_1", "decision": "가벼운 흐름 정의(4섹션 = ## 문제 / ## 결정 / ## 적용 / ## 기록)와 9단계와의 관계(두 갈래 공존)·승격 기준을 ARCHITECTURE.md **§ 7.4 신설**에 정전화. § 4(9-stage)는 무수정 — 가벼운 흐름은 별 트랙 추가일 뿐.", "rationale": "opt_1 — § 7.1 컨텍스트 효율 면의 직접 구체 사례 + § 7.3 stage 본질(9단계 templated task)과 대조 배치 자연. sc_1+sc_3."},
    {"id": "d_2", "decision": "mechanism 3종 = (a) skill 신설 `skills/lightweight-flow/SKILL.md`(9-stage skill 동형 4 H2: 입력/작성할것/검증/관련) + (b) `LIGHTWEIGHT.md` template(frontmatter 4 필드 id/title/version/status + 4 H2 섹션, 각 ### Spec JSON + ### Narrative 선택) + (c) smoke era 확장.", "rationale": "opt_2 — 기존 9-stage skill(cb_6)+era-detect(cb_7)+plugin 자동 배포(ext_1) 인프라 재사용. skill=narrative checklist / template=schema / smoke=회귀 차단. sc_2."},
    {"id": "d_3", "decision": "산출물 위치 = `development/milestones/v{X.Y}/LIGHTWEIGHT.md`(meta) / `projects/<name>/milestones/v{X.Y}/LIGHTWEIGHT.md`(외부). _era_detect.py 에 `4-section-lightweight` 분기 추가 — 디렉토리명 `^v\\d+\\.\\d+$` + LIGHTWEIGHT.md 존재, **MILESTONE.md 검사보다 뒤**(flattened 우선 보존).", "rationale": "opt_3 — flattened era 동일 hierarchy + era-detect 호환. 검사 순서로 9단계 오분류 회피(risk_2). sc_2+sc_6."},
    {"id": "d_4", "decision": "승격 기준 명문화(§ 7.4 안) = '컨설팅 자산(방법론·도구, 외부 제공물)에 영향 = 큰 건 → 9단계 / 내부·작은 조정 = 가벼운 흐름'. v8.1 자신을 worked example 로(새 컨설팅 자산 추가 = 큰 건 = 9단계).", "rationale": "risk_3 mitigation + sc_3. 컨설턴트 정체성(memory project-harness-meta-as-consultant) 판단 축 = 고객 납품물 vs 내부 운영."},
    {"id": "d_5", "decision": "lightweight 1-phase = § 6.2 폐지(v4.0, cb_3)로 이미 '정책' 종료 — v8.1 은 '가벼운 흐름이 운영 관행의 자리를 정식 흐름으로 대체'를 § 7.4 에 1줄 명시(재폐지 아님). CHANGELOG 정량 거명(cb_5)은 historical 보존.", "rationale": "cb_3 정합 — 이미 폐지된 정책 재폐지 회피. sc_4 전반부."},
    {"id": "d_6", "decision": "동결 정책 **은퇴**(사용자 결정) — ROADMAP deferred_note 의 동결 정책 + 재발의 조건 narrative 제거/갱신 + deferred 3건(v1.4×2/v1.5)을 next_candidates[](가벼운 흐름 후보)로 전환. 컨설턴트 정체성 하 '자기참조 루프 우려'가 가벼운 흐름 창구 도입으로 무의미해짐 프레이밍.", "rationale": "risk_1 — memory '§ 6.2 거론 금지' 정합('§ 6.2 부활' 아닌 'deferred_note drift 해소'). cb_3 §6.2 폐지 선언과 cb_4 deferred_note 잔존 drift 종결. sc_4 후반부."},
    {"id": "d_7", "decision": "도그푸드 = deferred 1건 `v1.5_research-cascade-grep-discipline`(3건 중 가장 작고 mechanical)을 v8.1 안에서 실제 가벼운 흐름(`development/milestones/v8.1/LIGHTWEIGHT-dogfood-v1.5.md` 또는 별 디렉토리)으로 1장 처리 → 가벼운 흐름 mechanism 실작동 입증.", "rationale": "sc_5 — 예시 산출물 1건이 아니라 실 deferred 해소로 도그푸드(사용자 결정 '실처리'). APPROVE 에서 대상 deferred 최종 확인."},
    {"id": "d_8", "decision": "외부 제공 구조 = skill/template = plugin 배포(공유, .claude-plugin/plugin.json skills 자동 인식) + 산출물 거주 = 프로젝트별(meta=development/ / 외부=projects/<name>/). v8.1 = meta 검증까지, upbit 실 적용은 oos_1 후속.", "rationale": "cb_9+cb_10 — 9단계 메타+프로젝트 양쪽 지원 선례. risk_4 — '적용 준비 완료' 구조까지 설계, 실 적용 분리."},
    {"id": "d_9", "decision": "5 관점 review = **subagent**(design-review, 5 perspectives: architecture/spec-drift/security/performance/dx) — 사용자 결정. 동결 정책 drift 정리·trace 보존 등 미묘 결정 다수라 escalate.", "rationale": "v7.0 T1.3 design-review N+ 가변 mechanism 첫 dogfood + memory feedback_subagent_parallel_review_evidence(inline 대비 누적 증가)."},
    {"id": "d_10", "decision": "design-review decisive 4건 흡수 — (A-1) phase-1 approach+deliverable 에 'ARCHITECTURE § 6.1 era 표 row 추가' 명시(§ 6.1:253 'era N+1 추가 시 § 6.1 표 + _era_detect.py 갱신 의무'). (A-2) d_6 deferred→next_candidates 전환 시 schema 변환 의무 — version(`v1.5_research-cascade-grep-discipline`)→id slug 재작성(regex `^[a-z0-9-]+$`) + target_version 부여(regex `^v[0-9]+\\.[0-9]+$`) + title ≤60자 ∧ ' + ' 부재 점검. (SD-1) LIGHTWEIGHT.md frontmatter status enum 값 EXECUTE 시 정의(4섹션 흐름 = `completed` 단일 또는 `draft`/`completed`). (DX-3) 가벼운 흐름 '## 기록'의 CHANGELOG/Release trace 편입 방식을 § 7.4 에 1줄 명시(release-publish.yml 이 `## REPORT` H2 만 awk 추출 → '## 기록' 미인식, 대체 trace 명시).", "rationale": "design-review FAIL 0 / 흡수 권고 4. § 3.3 Trace 5요소 + § 6.1 era 갱신 의무 + next_candidates schema 정합 보강. minor DX-1(승격 기준 반례 1건 추가)은 EXECUTE 재량."}
  ],
  "approach": "본 milestone = v8.1 자체가 '새 컨설팅 자산 추가 = 큰 건'이라 9단계 + 2-phase. **phase-1 = 정전화 + mechanism 설치**: (a) ARCHITECTURE.md § 7.4 신설(가벼운 흐름 4섹션 정의 + 두 갈래 공존 + 승격 기준 worked example) + § 4 끝 매트릭스 #17 append(가벼운 흐름 mechanism) (b) skill 신설 skills/lightweight-flow/SKILL.md (c) LIGHTWEIGHT.md template 정의(§ 7.4 안 또는 skill 안) (d) smoke era 확장 — tests/_era_detect.py 4-section-lightweight 분기 + ARCHITECTURE § 6.1 era 표 row 추가(§ 6.1:253 갱신 의무, d_10 A-1) + smoke-spec-verification/scope-contract/open-stage-discipline/bundle-trigger/cross-ref enumerate·페어링 확장 (e) cascade host(CLAUDE.md/development/CLAUDE.md 등) narrative 동기. **phase-2 = 반창고 은퇴 + 도그푸드**: (f) 동결 정책 은퇴 — ROADMAP deferred_note 동결 narrative 정리 + deferred 3건 next_candidates 전환 (g) lightweight 운영 관행 대체 1줄(d_5) (h) deferred 1건(v1.5) 실제 가벼운 흐름 1장 처리(도그푸드, sc_5) (i) 기존 9단계 30 milestone E2E PASS 확인. 각 phase 끝 smoke 검증. cascade host = ARCHITECTURE § 7.4(1차 source) → 루트 CLAUDE.md(워크플로우 진입) + development/CLAUDE.md(모듈 가이드) narrative.",
  "phases": [
    {"phase": "phase-1", "scope": "정전화(§ 7.4 신설 + 매트릭스 #17) + mechanism 설치(skill + LIGHTWEIGHT.md template + smoke era 확장) + cascade host 동기", "deliverable": "development/ARCHITECTURE.md § 7.4 + skills/lightweight-flow/SKILL.md + tests/_era_detect.py + 관련 smoke + CLAUDE.md 동기. 별책 execute/phase-1.md", "verification": "(1) bash tests/smoke-spec-verification.sh PASS + 기존 30 milestone 무손상 (2) bash tests/smoke-open-stage-discipline.sh PASS (3) bash tests/smoke-cross-ref.sh PASS (4) python scripts/cascade_sync.py --check no drift (5) plugin skill 자동 인식 확인(skills/lightweight-flow/ 존재)"},
    {"phase": "phase-2", "scope": "동결 정책 은퇴(deferred_note 정리 + deferred 3건 candidate 전환) + lightweight 관행 대체 명시 + deferred 1건(v1.5) 가벼운 흐름 도그푸드 실처리", "deliverable": "development/ROADMAP.md(deferred_note + next_candidates) + v1.5 LIGHTWEIGHT 도그푸드 산출물 + 관련 narrative. 별책 execute/phase-2.md", "verification": "(1) bash tests/smoke-candidate-draft-schema.sh PASS (2) 도그푸드 LIGHTWEIGHT.md 가 새 4-section smoke 통과(sc_5 입증) (3) pre-commit run --all-files 전체 PASS (4) grep 동결 정책 잔존 narrative 0(활성 파일)"}
  ],
  "risk_mitigation": [
    {"risk_ref": "risk_1", "decision_ref": "d_6", "method": "동결 정책을 '§ 6.2 부활'이 아닌 '컨설턴트 정체성 하 deferred_note drift 해소'로 프레이밍(memory §6.2 거론 금지 정합). deferred 3건 처리 = 사용자 결정(은퇴+candidate 전환) 완료."},
    {"risk_ref": "risk_2", "decision_ref": "d_3", "method": "LIGHTWEIGHT.md era 분기를 MILESTONE.md 검사 뒤에 삽입(flattened 우선 보존) + 기존 30 milestone E2E PASS 확인(phase-1 검증 (1))."},
    {"risk_ref": "risk_3", "decision_ref": "d_4", "method": "승격 기준 § 7.4 명문화 + v8.1 자신을 worked example('큰 건이라 9단계')로 판단 가능성 입증."},
    {"risk_ref": "risk_4", "decision_ref": "d_8", "method": "skill/template plugin 배포(공유 구조) + 산출물 위치 프로젝트별 parametrize = '외부 적용 준비 완료'까지. 실 적용 oos_1 분리."},
    {"risk_ref": "risk_5", "decision_ref": "d_1", "method": "가벼운 흐름 '## 기록' 섹션이 검증+교훈+후속 압축 보존 + git/CHANGELOG 3중 trace 동일 유지. 큰 건은 9단계라 풍부 trace. design-review trace 관점 점검."}
  ],
  "five_perspective_review": {
    "method": "subagent (design-review) — 5 perspectives 병렬 검토 완료. decisive 4건(A-1/A-2/SD-1/DX-3) d_10 흡수, scope 외 4건 ## SCOPE_OUT_NOTES.",
    "perspectives": [
      {"perspective": "architecture", "verdict": "pass-with-comments", "comments": "§ 7.4 신설 위치 정합(§ 7.1 컨텍스트 효율 면 + § 7.3 stage 본질 인접) + § 4 9-stage 무수정 정합(oos_3). decisive A-1 — phase-1 에 § 6.1 era 표 row 추가 누락(ARCHITECTURE:253 의무, approach 가 _era_detect/smoke 만 거명). decisive A-2 — d_6 deferred→next_candidates schema 변환 의무 누락(deferred entry schema ≠ next_candidates schema). 매트릭스 #17 append 정합(#16 마지막). → d_10 흡수."},
      {"perspective": "spec-drift", "verdict": "pass-with-comments", "comments": "LIGHTWEIGHT.md frontmatter 4 필드 = flattened MILESTONE.md 동일 스키마(Anthropic YAML frontmatter 정합) + skill plugin.json:18 자동 인식 정합 + _era_detect 분기 삽입 순서 오분류 없음 확인. comment SD-1 — LIGHTWEIGHT.md status enum 값 미정의 → d_10 흡수."},
      {"perspective": "security", "verdict": "PASS", "comments": "순수 문서·schema·smoke 작업, 실행권한 변화 0. plugin 배포 노출 = 워크플로우 방법론(4섹션 구조)뿐, credential/내부경로 노출 없음. .claude/rules+settings 는 plugin manifest 미포함(repo-local) 불변."},
      {"perspective": "performance", "verdict": "PASS", "comments": "era 분기 +1 = O(1) stat 1회/milestone, flattened 우선 보존이라 기존 30 milestone 첫 분기 즉시 반환 — 복잡도 미미. 가벼운 흐름 4섹션 1장 = § 7.1 컨텍스트 효율 직접 향상(v6.23 표본 토큰 over-spend 해소), memory feedback_token_efficiency_priority 정합."},
      {"perspective": "dx", "verdict": "pass-with-comments", "comments": "승격 기준 판단 축('고객 납품물 vs 내부 운영') 명료 + v1.5 도그푸드 선택 적절(3건 중 가장 작고 mechanical, B_regression 성격 representative). comment DX-1 — 승격 기준 반례(가벼운 흐름 부적합 예) 1건 추가 권고(EXECUTE 재량). decisive DX-3 — 가벼운 흐름 '## 기록'의 CHANGELOG/Release trace 편입 미명시(release-publish.yml `## REPORT` H2 만 추출 → § 3.3 Trace 5요소 구멍) → d_10 흡수."}
    ]
  }
}
```

### Narrative

본 DESIGN = 9 decisions + 2-phase + 5 risk_mitigation + subagent 5 관점 검토(d_9). 핵심 결정 trace: 정전화 위치 = § 7.4 신설(d_1), mechanism 3종 = skill+template+smoke era 확장(d_2/d_3), 승격 기준 명문화(d_4), 두 반창고 = lightweight 폐지 재확인(d_5) + 동결 정책 은퇴(d_6, 사용자 결정), 도그푸드 = deferred v1.5 실처리(d_7, sc_5), 외부 제공 = plugin 공유+산출물 프로젝트별(d_8).

**전략** — v8.1 자체가 '새 컨설팅 자산 추가 = 큰 건'이라 9단계로 진행(부트스트랩 해소, INTENT 정합). phase-1 에 정전화+mechanism(회귀 위험 집중)을 묶어 기존 30 milestone E2E 무손상 검증, phase-2 에 반창고 은퇴+도그푸드(가치 입증)를 분리. **cascade host** = ARCHITECTURE § 7.4 가 1차 source, CLAUDE.md 2 host 가 narrative 참조(v3.21 정전화 3단계 (a) DESIGN 본질).

**동결 정책 은퇴 프레이밍**(risk_1) — memory '§ 6.2 거론 금지' 정합하게, 동결 정책을 정책으로 재논의하지 않고 'deferred_note 에 남은 동결 narrative 가 컨설턴트 정체성·가벼운 흐름 창구 도입으로 무의미해짐(drift 해소)'으로 다룬다. deferred 3건은 가벼운 흐름 후보로 전환하고 그중 v1.5 를 도그푸드로 실처리한다. 5 관점 검토는 design-review subagent 로 호출 후 본 섹션에 반영한다.

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "approved_at": "2026-05-26",
    "approval_method": "다라운드 pre-PLAN 대화(정체성=컨설턴트 → 흐름 실물 4섹션 → 두 갈래 공존 → 승격 기준 → 부트스트랩 v8.1=9단계 → 범위 meta 검증까지 → 반창고 처리) 후 OPEN~DESIGN 디스크 기록 + design-review subagent decisive 4건 흡수. AskUserQuestion 'DESIGN 으로 APPROVE 박고 EXECUTE 진행?' 에 '승인 + EXECUTE 는 새 세션에서' 응답.",
    "scope_confirmed": [
      "R1: 정체성 = harness-meta 는 harness engineering 컨설턴트 (외부에 harness 제공). memory project-harness-meta-as-consultant 저장 합의.",
      "R2: 흐름 실물 = 4섹션 한 장(문제→결정→적용→기록), preview 선택으로 확정.",
      "R3: 흐름 관계 = 두 갈래 공존 — 큰 건(컨설팅 자산 변경) 9단계 / 작은 건 가벼운 흐름.",
      "R4: 승격 기준 = 고객 납품물(방법론·도구) 영향 = 큰 건 / 내부·작은 조정 = 가벼운 흐름.",
      "R5: 범위 = 가벼운 흐름을 외부 제공 컨설팅 자산으로 설계 + meta 검증까지. upbit 실 적용은 후속(oos_1).",
      "R6: 부트스트랩 = v8.1 자체는 '새 컨설팅 자산 추가 = 큰 건'이라 9단계로 진행.",
      "R7: 동결 정책 = 은퇴 + deferred 3건 가벼운 흐름 후보 전환 + deferred 1건(v1.5) 도그푸드 실처리(사용자 결정).",
      "R8: DESIGN 확정 — 10 decisions + 2-phase + design-review decisive 4건(A-1/A-2/SD-1/DX-3) d_10 흡수, EXECUTE 진입 승인.",
      "R9: 세션 경계 = OPEN~APPROVE 이 세션 디스크 기록 / EXECUTE~PROPOSE /clear 후 새 세션 (v8.0 R5 carry-over 증발 방지 패턴)."
    ]
  }
}
```

### Narrative

사용자 명시 승인 완료 (2026-05-26). 본 APPROVE 가 EXECUTE 진입 게이트 — CLAUDE.md root § 개발 프로세스('~/harness-meta/ repo 변경은 커밋 전 사용자 확인 필수') 정합. 다라운드 pre-PLAN 대화로 정체성(컨설턴트)·흐름 실물(4섹션)·두 갈래 공존·승격 기준·부트스트랩·범위·반창고 처리 7항을 합의했고, design-review subagent 가 decisive 4건을 발견해 d_10 으로 흡수했다.

**세션 경계**(R9) — OPEN→INTENT→RESEARCH→DESIGN→APPROVE 까지 맥락이 살아있는 본 세션에서 디스크에 박혔다. EXECUTE 부터는 /clear 후 새 세션이 본 MILESTONE.md(## DESIGN approach (a)~(i) step + 각 phase verification + ## RESEARCH cb_1~10 + d_10 decisive 흡수 4건)를 읽고 자족 진행한다. 도그푸드 대상 = deferred `v1.5_research-cascade-grep-discipline` 확정.

## EXECUTE

### Spec

```json
{
  "phases_executed": [
    {
      "phase": "phase-1",
      "status": "completed",
      "deliverable_path": "execute/phase-1.md",
      "commits": [
        {"sha": "81b692a", "message": "feat(meta): [v8.1] phase-1 — 가벼운 흐름 (4 섹션 트랙) 정전화 + mechanism 설치"}
      ],
      "summary": "ARCHITECTURE § 7.4 신설 (4 섹션 정의 + 두 갈래 공존 + 승격 기준 worked example + LIGHTWEIGHT.md template + ## 기록 trace 편입) + § 4 매트릭스 #17 + § 6.1 era 표 row + skill skills/lightweight-flow/ + smoke era 확장 (_era_detect 4-section-lightweight 분기 + spec-verification/open-stage/bundle-trigger/scope-contract) + cascade host 동기 (root/development/tests CLAUDE.md). design-review decisive 4건 (A-1/A-2/SD-1/DX-3) 흡수. 기존 55 milestone E2E 무손상 + pre-commit 18 hook PASS. 별책 상세 = execute/phase-1.md"
    },
    {
      "phase": "phase-2",
      "status": "completed",
      "deliverable_path": "execute/phase-2.md",
      "commits": [
        {"sha": "pending", "message": "feat(meta): [v8.1] phase-2 — 반창고 은퇴 (동결 정책) + v8.2 가벼운 흐름 도그푸드"}
      ],
      "summary": "동결 정책 은퇴 (ROADMAP deferred_note 정리 + deferred 3건 → next_candidates 전환 (v1.4×2) / v1.5 도그푸드 실처리) + lightweight 1-phase 관행 대체 명시 + 도그푸드 development/milestones/v8.2/LIGHTWEIGHT.md (deferred v1.5 RESEARCH cascade grep 규율 해소, 가벼운 흐름 mechanism 실작동 입증) + 기존 milestone E2E PASS. 별책 상세 = execute/phase-2.md"
    }
  ]
}
```

### Narrative

2-phase 진행 (DESIGN approach 정합). **phase-1** = 정전화 + mechanism 설치 (회귀 위험 집중) — 기존 milestone E2E 무손상 검증. **phase-2** = 반창고 은퇴 + 도그푸드 (가치 입증). 각 phase 끝 smoke 검증 + 1 phase = 1 commit (§ 4 정합, 커밋 전 사용자 확인). design-review decisive 4건 (A-1 era 표 갱신 / A-2 next_candidates schema 변환 / SD-1 status enum / DX-3 기록 trace) phase 별 흡수. commit SHA 는 사용자 commit 승인 후 갱신 (pending → 40-hex).

## VERIFY

(미작성 — Stage G VERIFY 에서 작성)

## REPORT

(미작성 — Stage H REPORT 에서 작성)

## PROPOSE

(미작성 — Stage I PROPOSE 에서 작성)

## SUB_MILESTONES

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음)

## SCOPE_OUT_NOTES

design-review 5 관점 검토 안 scope 외 거명 (next_candidates 자동 등재 부재 — PROPOSE stage 사용자 명시 결정 게이트 후만, § 11.4 정합):

- **v1.4 deferred 2건**(hook-narrative-separation / design-review-trace)의 실처리 — v8.1 은 next_candidates 전환만, 실 처리는 후속(도그푸드는 v1.5 1건만).
- **가벼운 흐름 ↔ 9단계 "중간 건"**(애매 규모) 운영 lessons 축적 — 가벼운 흐름 실사용 누적 후 후속 candidate.
- **tests/CLAUDE.md smoke 매트릭스 표기 drift** ("active 7" vs "12 hook" 혼재, v8.1 무관 기존 잔존) 정리 — 후속.
- **skill body 본질 결정** (§ 7.4 derived checklist vs 독립 narrative) — 미묘점, EXECUTE scope 안 흡수 가능.
