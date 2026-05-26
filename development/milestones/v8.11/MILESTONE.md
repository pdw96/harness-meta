---
id: area4-detect-criterion-refinement
title: 영역 4 gap detect 기준을 matcher/책임 기반으로 정련
version: v8.11
status: completed
---

# v8.11 — 영역 4 gap detect 기준을 matcher/책임 기반으로 정련

## INTENT

### Spec

```json
{
  "id": "area4-detect-criterion-refinement",
  "title": "영역 4 gap detect 기준을 matcher/책임 기반으로 정련",
  "goal": "harness-gap-analyzer Task 1 의 d_2 (harness-meta canonical 자산 gap) detect 기준과 카탈로그 § 4 'session-start-secret-scan.sh' row 의 '권고 case (gap 조건)' 컬럼을, name-token 단독 매칭에서 matcher(SessionStart) + 책임 기반 판별로 정련한다. 목표 = write-time guard(secret-guard.py, matcher=Edit|Write)가 직교 책임의 settings-scan gap 을 'secret' 토큰만으로 잘못 억제하던 false-negative 제거.",
  "motivation": "v8.10 (C) 결함 origin — 실 price-compare audit 에서 검출. d_2 의 name-token 기준이 secret-guard.py(write-time 차단)와 session-start-secret-scan.sh(settings*.json 저장 secret warn-only)의 책임 직교를 구분 못 해, 'secret' 토큰 매칭만으로 gap=false 처리 → 실 settings allow-list 격차가 남는데도 권고 억제(잠재 false-negative). self-loop(harness-meta 자기 단일 hook 책상)에선 안 보이고 유사명 직교 hook 보유 외부 프로젝트에서만 노출 — verification-philosophy(v8.6) 제품 역량 검증 vector 가 검출한 결함의 실 수정. 컨설팅 자산(agent + catalog) 변경 = 큰 건(9-stage, v8.4 패턴 정합).",
  "success_criteria": [
    {
      "id": "sc_1",
      "criterion": "harness-gap-analyzer d_2 detect 기준이 발동시점(matcher==SessionStart 또는 동치) + 책임 조건을 포함 — name-token 단독 판별 제거. matcher 가 Edit|Write(write-time)인 hook(secret-guard.py 류)은 settings-scan gap 을 억제하지 못한다."
    },
    {
      "id": "sc_2",
      "criterion": "카탈로그 § 4 'session-start-secret-scan.sh' row 의 '권고 case (gap 조건)' 컬럼이 gap-analyzer 정련 기준과 정합하도록 matcher 기반으로 갱신됨 (name 토큰 단독 표현 제거)."
    },
    {
      "id": "sc_3",
      "criterion": "두 자산(gap-analyzer d_2 + 카탈로그 § 4)의 기준 표현이 단일 source 정합 — gap-analyzer 는 § 4 표를 1차 참조하고, 기준 본문 narrative 가 양쪽에 모순 없이 동일 본질."
    },
    {
      "id": "sc_4",
      "criterion": "smoke 전건 PASS (회귀 0) — 특히 smoke-cross-ref(§ 4 자산 path link) + smoke-spec-verification."
    },
    {
      "id": "sc_5",
      "criterion": "v8.10 (C) false-negative 시나리오(대상이 secret-guard.py[matcher=Edit|Write] 보유 + SessionStart settings-scan 미보유)에서 정련 기준이 gap=true 로 surface 함을 narrative 로 검증(실 외부 audit 재검증은 oos_2)."
    }
  ],
  "out_of_scope": [
    {
      "id": "oos_1",
      "item": "detect 기준 일반화 — § 4 '권고 case' 컬럼을 모든 미래 자산이 따르는 구조(event/matcher + 책임 필드)로 재설계. 자산 2건째 등록이 원래 trigger(§ 4 경량 인벤토리 note)이고 hook-asset-library-canonicalization 후보와 영역 겹침. 본 milestone 은 자산 1건 정밀 수정만(사용자 pre-PLAN 결정). SCOPE_OUT_NOTES + 후속 candidate."
    },
    {
      "id": "oos_2",
      "item": "정련 기준의 실 외부 적용 검증(price-compare 재audit으로 secret-guard.py 보유 프로젝트가 gap=true surface 확인). agent prompt-time 분기는 정적 smoke 밖이라 실 audit 필요 — v8.9→v8.10 패턴 정합. 후속 외부 적용 검증 candidate(사용자 게이트)."
    },
    {
      "id": "oos_3",
      "item": "project-scanner 변경 — scanner 가 이미 harness_state.hooks[].matcher 를 출력함을 OPEN 전 검증(project-scanner.md:55). 정련 기준의 입력 신호가 이미 존재하므로 scanner 수정 불요(v8.4식 upstream 함정 부재)."
    }
  ],
  "dependencies": [
    {
      "id": "dep_1",
      "ref": "v8.9 audit-team-asset-recommendation-catalog",
      "purpose": "본 milestone 이 정련하는 대상 — 영역 4 통로 + d_2 분기 + § 4 'session-start-secret-scan.sh' row 를 신설한 milestone."
    },
    {
      "id": "dep_2",
      "ref": "v8.10 area4-recommendation-external-application-verify",
      "purpose": "(C) 결함 검출 origin — 실 price-compare audit 에서 name-token 기준의 false-negative 한계를 노출(L2 교훈)."
    },
    {
      "id": "dep_3",
      "ref": "agents/project-scanner.md harness_state.hooks[].matcher 필드",
      "purpose": "정련 기준의 입력 신호 — 각 hook 의 발동시점(SessionStart vs Edit|Write)을 scanner 가 이미 출력하므로 matcher 기반 판별이 입력 측에서 성립."
    }
  ]
}
```

### Narrative

v8.10 의 실 price-compare audit 이 영역 4 wiring 의 실효를 입증하면서 동시에 detect 기준의 결함 (C) 을 노출했다 — `harness-gap-analyzer` d_2 의 gap 조건이 `harness_state.hooks[].name` 에 `secret`/`scan` 토큰 부재로만 판별하다 보니, **책임이 전혀 다른** 두 hook 을 같은 것으로 본다. `secret-guard.py` 는 파일에 secret 을 **쓰려 할 때 막는** PreToolUse(Edit|Write) write-time guard 이고, `session-start-secret-scan.sh` 는 settings\*.json 에 **이미 박힌** secret 을 SessionStart 시점에 찾아 경고하는 자산이다. 이름의 'secret' 토큰만으로 전자가 후자를 cover 한다고 단정하면, 실제 settings allow-list 격차가 남는데도 gap=false 로 권고가 억제되는 false-negative 가 발생한다.

본 milestone 은 이 기준을 **발동시점(matcher) + 책임 기반 판별**로 정련한다. OPEN 전 사용자 pre-PLAN 대화에서 두 가지가 확정됐다 — (1) `project-scanner` 가 이미 hook 별 `matcher` 를 출력하므로(`project-scanner.md:55`) 입력 측 보강이 불요(v8.4 식 'upstream 에 진짜 gap' 함정 부재) + (2) 수정 범위 = 이 자산 하나의 기준 정밀 수정만, 기준 구조 일반화는 자산 2건째 등록이 원 trigger 이므로 SCOPE_OUT(oos_1). 고칠 곳은 `harness-gap-analyzer.md` d_2 단락과 카탈로그 README § 4 '권고 case' 컬럼 두 군데이며, 단일 source 정합(sc_3)으로 gap-analyzer 는 § 4 표를 참조한다. 컨설팅 자산(agent + catalog) 변경이라 §7.4 상 규모가 작아도 9-stage 의무다.

## RESEARCH

### Spec

```json
{
  "external": [
    {
      "id": "ext_1",
      "source": "claude/hooks/hooks.json:14-31 (실 hooks 등록) + agents/environment-auditor.md:48 (C5 검사)",
      "finding": "실 hooks.json 의 SessionStart 항목 객체는 matcher 필드 자체가 부재(이벤트 키 'SessionStart' 가 곧 trigger). PreToolUse/PostToolUse 만 matcher 패턴('Write|Edit') 보유. 즉 'matcher' 라는 단어는 hooks.json 안에서 PreToolUse 류에만 literal 로 존재 — SessionStart 는 event 키로 표현. 정련 기준 문구는 literal `matcher=='SessionStart'` 동치 대신 '발동 시점(event)이 SessionStart' 로 표현해야 정합."
    }
  ],
  "codebase": [
    {
      "id": "cb_1",
      "ref": "agents/project-scanner.md:55 (output 예시) + Task 2(라인 33)",
      "finding": "project-scanner 는 각 hook 을 `{name, matcher}` 로 정규화 출력하며 예시가 `{\"name\": \"session-init.sh\", \"matcher\": \"SessionStart\"}` — SessionStart event 를 matcher 값으로 흡수. PreToolUse Edit|Write hook(secret-guard.py 류)은 `matcher: \"Edit|Write\"` 로 출력될 것. 따라서 scanner output 의 matcher 값만으로 SessionStart vs write-time guard 판별 가능 = 정련 기준의 입력 신호가 이미 존재(oos_3 = scanner 수정 불요 확정)."
    },
    {
      "id": "cb_2",
      "ref": "agents/harness-gap-analyzer.md:38 (d_2 단락)",
      "finding": "현 d_2 기준 = `claude_dir == true ∧ harness_state.hooks[].name 에 secret/scan 토큰 부재 → gap surface`. name-token 단독 = (C) 결함 root. 단락은 § 4 표를 Read 해 '권고 case' 컬럼 대조하라고 지시하면서도 inline worked example 에 name-token 기준을 박아둠 — 이 inline 예시가 § 4 컬럼과 동시 갱신 대상(sc_2+sc_3)."
    },
    {
      "id": "cb_3",
      "ref": "bootstrap/claude-code-catalog/README.md:109 (§ 4 표 '권고 case (gap 조건)' 컬럼)",
      "finding": "현 컬럼 = `claude_dir=true ∧ hooks list 의 hook name 에 secret/scan 토큰 부재(자작 secret-scan hook 미보유)`. 이것이 기준의 canonical 진술(gap-analyzer 가 참조). 정련 = name-token 을 'SessionStart event hook ∧ 책임=settings 파일 secret scan' 으로 교체."
    },
    {
      "id": "cb_4",
      "ref": "agents/claude-docs-mapper.md:39 + component-proposer.md:75",
      "finding": "두 멤버는 detect 기준을 인코딩하지 않음 — mapper 는 `source=='harness-meta-asset'` 분기로 § 4 매핑만, proposer 는 '권고 case' 를 권고 근거로 인용만. 따라서 정련 대상은 gap-analyzer d_2 + § 4 컬럼 정확히 2곳(sc_3 단일 source 정합 범위 확정). cascade-source marker 부재(agents/ grep 0건) → 자동 동기 없음, 2곳 manual 정합."
    }
  ],
  "options": [
    {
      "id": "opt_1",
      "label": "채택 — 발동시점(SessionStart event) gate + 책임(settings secret scan) 토큰 결합",
      "rationale": "scanner 가 이미 주는 matcher/event 값으로 SessionStart 판별 + 기존 secret/scan 토큰을 책임 신호로 격하 결합. secret-guard.py(event=Edit|Write)는 SessionStart gate 탈락 → gap 억제 못 함 = (C) false-negative 해소. 최소 변경 + scope 정합(oos_1 일반화 회피)."
    },
    {
      "id": "opt_2",
      "label": "폐기 — SessionStart event 단독(토큰 무시)",
      "rationale": "임의 SessionStart hook(version-track 등)이 gap 억제 → 과억제. 책임 신호 없이 너무 느슨, 반대 방향 false-negative. 폐기."
    },
    {
      "id": "opt_3",
      "label": "폐기 — scanner 가 hook 본문 introspect 해 책임 직접 판정",
      "rationale": "scanner 가 hook .sh 내용 읽어 '설정파일 scan 여부' 판정 = scanner 변경(oos_3) + read-only 민감정보 정책 위배 risk. 본 milestone scope 밖, 과설계. 폐기."
    },
    {
      "id": "opt_4",
      "label": "폐기 — § 4 '권고 case' 컬럼을 event/책임 구조 필드로 일반 재설계",
      "rationale": "모든 미래 자산용 구조화 = oos_1 일반화. 자산 2건째 등록이 원 trigger(§ 4 경량 인벤토리 note) + hook-asset-library-canonicalization 영역 겹침. 본 milestone 1건 정밀 수정 결정(사용자)에 위배. 폐기(SCOPE_OUT_NOTES 등재)."
    }
  ],
  "risks_identified": [
    {
      "id": "risk_1",
      "description": "matcher 어휘 불일치 — 실 hooks.json SessionStart 객체엔 matcher 필드 부재(event 키로 표현)인데 project-scanner 는 matcher 값으로 'SessionStart' 흡수. 기준 문구를 literal `matcher=='SessionStart'` 로 박으면 hooks.json 직접 대조 시 혼란.",
      "mitigation": "기준 문구를 '발동 시점(event)이 SessionStart 인 hook' 로 표현(scanner 정규화 matcher 값 OR event 키 양쪽 수용). DESIGN d_X 에서 정확 문구 확정."
    },
    {
      "id": "risk_2",
      "description": "잔여 false-negative — SessionStart event 이면서 우연히 secret/scan 토큰 보유하나 책임이 settings-scan 아닌 hook 이 gap 억제할 잔여 가능성.",
      "mitigation": "책임 narrative('settings*.json 저장 secret 을 SessionStart 에 scan') 명시 + 판정 모호 시 agent 투명 보고 + 사용자 게이트 이관(v8.10 (C) 패턴 보존). 완전 introspection 은 oos_3 — 과설계 회피."
    },
    {
      "id": "risk_3",
      "description": "단일 source drift — gap-analyzer inline 예시와 § 4 컬럼이 따로 갱신돼 모순날 risk(cascade marker 부재라 자동 동기 없음).",
      "mitigation": "§ 4 컬럼을 canonical 기준 진술로, gap-analyzer 는 § 4 참조 + § 4 와 동일 문구의 최소 예시만 유지(sc_3). EXECUTE 시 두 곳 동시 commit."
    }
  ]
}
```

### Narrative

조사로 세 가지가 확정됐다. **(1) 입력 신호는 이미 있다** — `project-scanner` 가 각 hook 을 `{name, matcher}` 로 정규화 출력하고 예시(`project-scanner.md:55`)가 SessionStart 를 matcher 값으로 흡수하므로, write-time guard(`secret-guard.py` → `matcher: "Edit|Write"`)와 SessionStart 자산은 scanner output 단계에서 이미 구분 가능하다. scanner 수정은 불요(oos_3 확정). **(2) 정련 대상은 정확히 2곳** — `harness-gap-analyzer.md:38` 의 d_2 inline 예시 + 카탈로그 `README.md:109` 의 § 4 '권고 case' 컬럼. `claude-docs-mapper`/`component-proposer` 는 detect 기준을 인코딩하지 않아(컬럼명 참조만) 손대지 않으며, cascade-source marker 도 부재(자동 동기 없음 → 2곳 manual 정합, risk_3). **(3) 어휘 주의** — 실 hooks.json 의 SessionStart 항목은 matcher 필드가 없고 event 키로 표현되므로(`hooks.json:14-31`), 기준 문구는 literal `matcher=='SessionStart'` 동치가 아닌 '발동 시점(event)이 SessionStart 인 hook' 로 표현해야 한다(risk_1).

채택 옵션은 **opt_1 — 발동시점(SessionStart event) gate + 책임(settings secret scan) 토큰 결합**이다. 기존 name-token 을 '책임 신호'로 격하하고 그 앞에 SessionStart event gate 를 두면, secret-guard.py 처럼 event 가 Edit|Write 인 hook 은 gate 에서 탈락해 gap 을 억제하지 못한다 — (C) false-negative 의 직접 해소다. SessionStart event 단독(opt_2)은 version-track 같은 무관 SessionStart hook 까지 억제해 반대 방향 false-negative 를 낳고, scanner introspection(opt_3)·컬럼 구조 일반화(opt_4)는 각각 scope(oos_3)·scope(oos_1) 밖이라 폐기했다. 잔여 모호(SessionStart ∧ secret 토큰이나 책임 다름)는 agent 투명 보고 + 사용자 게이트로 흡수(v8.10 (C) 패턴 보존, risk_2) — 완전 introspection 은 과설계다.

## DESIGN

### Spec

```json
{
  "decisions": [
    {
      "id": "d_1",
      "decision": "harness-gap-analyzer.md:38 d_2 inline 예시를 '발동 시점(event)이 SessionStart 인 secret-scan 책임 hook 부재 → gap surface' 로 교체. 정본 문구 = '발동 시점(event)이 SessionStart 인 hook' (literal `matcher=='SessionStart'` 동치 회피 — spec-drift decisive). write-time guard(matcher `Edit|Write`, 예: secret-guard.py)는 책임 직교라 SessionStart gate 탈락 → gap 억제 못 함 명시.",
      "rationale": "opt_1 채택. scanner 가 SessionStart 를 matcher 값으로 정규화 흡수(cb_1)하나 실 hooks.json SessionStart 객체엔 matcher 필드 부재(ext_1) — literal 동치는 직접 대조 시 혼란(risk_1). design-review spec-drift decisive: sc_1 의 `matcher==SessionStart` 가 아닌 risk_1 mitigation 의 'event 표현' 을 정본으로 고정."
    },
    {
      "id": "d_2",
      "decision": "카탈로그 README.md:109 § 4 'session-start-secret-scan.sh' row 의 '권고 case (gap 조건)' 컬럼을 matcher 기반 canonical 진술로 갱신: 'claude_dir=true ∧ 발동 시점이 SessionStart 인 hook 중 settings 파일 secret scan 책임 hook 부재(판별: harness_state.hooks[] 의 matcher/event 가 SessionStart ∧ name 에 secret/scan 토큰. write-time guard matcher Edit|Write 는 책임 직교 — 제외)'. 같은 표 apply 방식 컬럼의 'SessionStart 등록' 어휘와 정합 유지.",
      "rationale": "opt_1 + sc_2. § 4 컬럼이 기준의 canonical 진술(gap-analyzer 가 Read 참조). name-token 단독을 SessionStart event gate + 책임 토큰 결합으로 교체."
    },
    {
      "id": "d_3",
      "decision": "§ 4 컬럼 = 판별 로직 본체(canonical), gap-analyzer d_2 = pointer + 1줄 예시로 제한. d_2 inline 예시 = 'matcher/event 가 SessionStart 인 secret-scan 책임 hook 부재 시 gap (구체 판별 컬럼은 § 4 표 참조)'. 판별 로직을 d_2 에 자기완결로 재기재 금지(architecture comment). EXECUTE 단일 commit 으로 2곳 동시 갱신.",
      "rationale": "sc_3 + risk_3. cascade marker 부재(cb_4, grep 0건)라 자동 동기 없음 → 2곳 manual 동시 commit 의무. architecture comment: '최소 예시' 해석 폭으로 inline 이 다시 자기완결 기준으로 부풀 risk → pointer + 1줄로 명시 제한."
    },
    {
      "id": "d_4",
      "decision": "SessionStart event ∧ secret/scan 토큰이나 책임 모호(settings-scan 아님 가능) 시 agent 투명 보고 + 사용자 게이트 이관 문구 보존 — 강제 권고 금지. 두 자산 갱신 문구에 모두 1구절 유지.",
      "rationale": "sc_5 + risk_2. 완전 introspection(opt_3)은 scanner 변경(oos_3)+민감정보 정책 위배라 폐기. 모호 시 surface(과경고) 쪽으로 기우는 보수 default = 보안상 안전 fail 방향(security PASS)."
    },
    {
      "id": "d_5",
      "decision": "detect 기준 일반화(§ 4 컬럼을 모든 미래 자산 구조 필드로 재설계)는 SCOPE_OUT — ## SCOPE_OUT_NOTES 등재. 본 milestone 은 자산 1건(session-start-secret-scan.sh) 정밀 수정만.",
      "rationale": "oos_1 + opt_4 폐기. 자산 2건째 등록이 원 trigger(§ 4 경량 인벤토리 note), hook-asset-library-canonicalization 후보와 영역 겹침. 사용자 pre-PLAN 결정(이 항목만 정밀 수정)."
    }
  ],
  "approach": "단일 phase(phase-1) — gap-analyzer.md:38 + README.md:109 두 파일을 동일 matcher 기반 기준으로 동시 Edit 후 smoke 회귀 검증. § 4 = canonical 진술(판별 로직 본체), gap-analyzer = § 4 참조 pointer + 1줄 예시(d_3). cascade-source marker 부재 확인(cb_4)이라 cascade_sync 무관. 정본 어휘 = '발동 시점(event)이 SessionStart 인 hook'(d_1, spec-drift decisive 반영).",
  "phases": [
    {
      "phase": "phase-1",
      "scope": "gap-analyzer d_2 inline 예시(pointer+1줄) + § 4 '권고 case' 컬럼(canonical 판별) 동시 정련. d_4 투명보고 문구 양쪽 보존.",
      "deliverable": "agents/harness-gap-analyzer.md(d_2 단락) + bootstrap/claude-code-catalog/README.md(§ 4 row '권고 case' 컬럼) 2 파일 Edit",
      "verification": "smoke-spec-verification + smoke-cross-ref(§ 4 자산 path link) + smoke-secret-scan 전건 PASS(회귀 0, sc_4) + sc_5 narrative 검증(secret-guard.py 보유+SessionStart settings-scan 미보유 시 gap=true surface 추적)"
    }
  ],
  "risk_mitigation": [
    {
      "risk_ref": "risk_1",
      "decision_ref": "d_1",
      "method": "정본 문구를 '발동 시점(event)이 SessionStart 인 hook' 로 고정(literal matcher==SessionStart 회피). scanner 정규화 matcher 값 OR hooks.json event 키 양쪽 수용. sc_1 검증은 VERIFY 에서 '또는 동치'가 event-키 표현 포함함을 명시."
    },
    {
      "risk_ref": "risk_2",
      "decision_ref": "d_4",
      "method": "책임 narrative('settings*.json 저장 secret 을 SessionStart 에 scan') 명시 + 모호 시 투명 보고 + 사용자 게이트. 완전 introspection 회피(과설계)."
    },
    {
      "risk_ref": "risk_3",
      "decision_ref": "d_3",
      "method": "§ 4 = canonical, gap-analyzer = pointer + 1줄(자기완결 기준 재기재 금지). EXECUTE 단일 commit 2곳 동시 갱신."
    }
  ],
  "five_perspective_review": {
    "method": "subagent (harness-meta:design-review) N+ 가변 3 관점 병렬 — architecture / spec-drift / security (v7.0 T1.3 거명 기반 선택, 본 변경의 결정적 면만). DESIGN 작성 전 proposed decisions d_1~d_5 검토 후 흡수.",
    "perspectives": [
      {
        "perspective": "architecture",
        "verdict": "pass-with-comments",
        "comments": "단일 source 정합(sc_3) + 정련 대상 정확히 2곳(d_2+§ 4) 진단을 codebase 직접 Read 로 확인(숨은 4·5번째 파일 부재). comment(decisive 아님): d_3 '최소 예시' 해석 폭으로 inline 이 자기완결 기준으로 부풀 risk → DESIGN 에서 'pointer + 1줄, 판별 본체는 § 4' 명시 권고 → d_3 에 흡수."
      },
      {
        "perspective": "spec-drift",
        "verdict": "pass-with-comments",
        "comments": "matcher 어휘 실재 대조(hooks.json SessionStart=matcher 필드 부재 / scanner=matcher 값 흡수) → d_1 어휘 결정이 핵심 방어, 정확. decisive comment: sc_1 본문에 literal `matcher==SessionStart` 잔존 ↔ d_1/risk_1 'event 표현' 충돌. INTENT 동결이라 sc_1 텍스트는 불변, DESIGN d_1 정본 문구를 'event 표현' 으로 고정해 흡수(d_1 반영). § 4 표 내부 apply 컬럼 'SessionStart 등록' 어휘 정합 권고 → d_2 반영."
      },
      {
        "perspective": "security",
        "verdict": "PASS",
        "comments": "정련 방향 = gap surface 증가(false-negative 제거) = 보호 강화. secret-guard.py(write-time)↔session-start-secret-scan.sh(저장분 scan) 책임 직교 사실 확인(secret-guard.py 는 harness-meta 내 정의 부재 = 외부 1회성 부품, v8.3/v8.7/v8.8 narrative 뒷받침). risk_2 잔여 누수를 d_4 보수 default(모호 시 surface)로 흡수 = 안전 fail 방향. comment: sc_5 narrative-only 한계(실 보호 효과는 oos_2 까지 미확정)를 REPORT 에 정직 기재."
      }
    ]
  }
}
```

### Narrative

설계 결정 d_1~d_5 는 RESEARCH 의 opt_1 채택 + risk_1~3 mitigation 을 1:1 매핑한다. 핵심은 d_1 — name-token 단독 판별을 '발동 시점(event)이 SessionStart 인 hook ∧ secret/scan 책임 토큰' 결합으로 교체해 write-time guard(secret-guard.py, event=Edit|Write)가 SessionStart gate 에서 탈락하게 한다. design-review spec-drift 가 짚은 decisive comment 를 흡수해 **정본 문구는 sc_1 의 literal `matcher==SessionStart` 가 아닌 '발동 시점(event)이 SessionStart 인 hook'** 로 고정한다(실 hooks.json SessionStart 객체엔 matcher 필드 부재 — risk_1). architecture comment 도 d_3 에 흡수 — § 4 컬럼이 판별 로직 본체(canonical)이고 gap-analyzer d_2 는 pointer + 1줄 예시로 제한해, '최소 예시' 가 다시 자기완결 기준으로 부풀지 않게 명문화했다.

cascade host 는 부재다 — cb_4 가 `agents/` cascade-source marker grep 0건을 확인했고, detect 기준은 정확히 2곳(gap-analyzer d_2 + § 4 컬럼)에만 있으며 claude-docs-mapper/component-proposer 는 인코딩하지 않는다. 따라서 두 곳 manual 동시 commit(d_3, risk_3)이 단일 source 정합의 mechanism 이다. design-review 3 관점 모두 FAIL 0 (architecture/spec-drift = pass-with-comments, security = PASS) — 세 결정적 우려(matcher 어휘 / 보안 보호 약화 / 단일 source drift)가 모두 d_1~d_4 로 처리됨을 확인했다. scope 외 거명(oos_1 일반화 / oos_2 실 외부 검증 / oos_3 scanner 함정 부재 / sc_1 어휘 finding)은 ## SCOPE_OUT_NOTES 에 보존한다.

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-27",
    "approval_summary": "설계 확정(d_1~d_5) + design-review 3관점(architecture/spec-drift/security) FAIL 0 제시 후 사용자 '승인, EXECUTE 진행해' 명시. 자산 2곳(harness-gap-analyzer.md:38 d_2 + README.md:109 § 4 권고 case 컬럼) 동시 정련 = SessionStart event gate + 책임 토큰 결합, 정본 문구 'event 표현' 고정. 커밋은 EXECUTE 후 별도 확인 게이트."
  }
}
```

### Narrative

사용자가 EXECUTE 진입을 명시 승인했다(2026-05-27). 승인 대상 = DESIGN d_1~d_5 (gap-analyzer d_2 inline 예시 + § 4 '권고 case' 컬럼을 matcher 기반 기준으로 동시 정련, 정본 어휘 'event 표현', SCOPE_OUT = 기준 일반화/실 외부 검증/scanner 수정). 커밋은 EXECUTE 산출 후 별도 사용자 확인 게이트(CLAUDE.md 커밋 전 확인 필수 정합).

## EXECUTE

phase-1 (단일 phase) 진행 — 별책 `execute/phase-1.md` 참조.

- **phase-1**: gap-analyzer d_2 inline 예시(pointer + 1줄, 판별 본체 § 4 참조) + 카탈로그 § 4 '권고 case' 컬럼(canonical 판별) 동시 정련. 정본 어휘 = '발동 시점(event)이 SessionStart 인 hook'(d_1). write-time guard(`Edit|Write`) 책임 직교 제외 + d_4 투명보고 문구 양쪽 보존. smoke 회귀 0 확인. (commit = 사용자 확인 게이트 후)

## VERIFY

### Spec

```json
{
  "smoke": [
    {"id": "smoke-cross-ref", "result": "PASS=1 FAIL=0", "note": "§ 4 자산 path markdown link drift 0 — README.md:109 row link 무손상"},
    {"id": "smoke-secret-scan", "result": "PASS=10 FAIL=0", "note": "session-start-secret-scan.sh 자산 자체 회귀 0"},
    {"id": "smoke-agent-frontmatter-schema", "result": "PASS", "note": "harness-gap-analyzer.md frontmatter 무손상"},
    {"id": "smoke-spec-verification", "result": "PASS=507 FAIL=0", "note": "v8.11 MILESTONE.md 8 stage 산출 schema 정합"},
    {"id": "smoke-cascade-drift", "result": "all hosts in sync", "note": "cascade marker 부재 정합 — drift 0"},
    {"id": "기타 8건", "result": "전건 PASS FAIL=0", "note": "claude-md-drift 13/13 / scope-contract 114 / bundle-trigger / candidate-draft 11 / projects-scope / entry-title / open-stage / audit-fact-verify 9"}
  ],
  "criteria_check": [
    {"sc": "sc_1", "verdict": "MET", "evidence": "harness-gap-analyzer.md:38 d_2 = '발동 시점(event)이 SessionStart 인 secret-scan 책임 hook 부재' 로 교체. name-token 단독 판별 제거 + write-time guard(Edit|Write)는 SessionStart gate 탈락 → gap 억제 못 함 명시. 정본 어휘 'event 표현'(literal matcher==SessionStart 회피, risk_1)."},
    {"sc": "sc_2", "verdict": "MET", "evidence": "README.md:109 § 4 '권고 case' 컬럼 = 'matcher/event 가 SessionStart ∧ name 에 secret/scan 토큰, write-time guard Edit|Write 제외' canonical 진술로 갱신. name 토큰 단독 표현 제거."},
    {"sc": "sc_3", "verdict": "MET", "evidence": "§ 4 = canonical 판별 본체, gap-analyzer d_2 = pointer + 1줄(§ 4 참조 명시). 양쪽 동일 본질('SessionStart event ∧ secret/scan 책임 토큰, write-time guard 제외'). 동시 Edit, cascade-drift PASS."},
    {"sc": "sc_4", "verdict": "MET", "evidence": "smoke 13건 전건 PASS FAIL=0 (회귀 0). 특히 smoke-cross-ref + smoke-spec-verification PASS."},
    {"sc": "sc_5", "verdict": "MET (narrative)", "evidence": "false-negative 시나리오 추적 — 대상이 secret-guard.py(matcher=Edit|Write) 보유 + SessionStart settings-scan 미보유 시: 정련 기준은 SessionStart event gate 를 secret-guard.py 가 충족 못 하므로 'secret-scan 책임 hook 부재' 판정 → gap=true surface. 즉 v8.10 (C) 의 false-negative(gap=false 억제)가 정련 후 gap=true 로 교정됨을 narrative 로 확인. 실 외부 audit 재검증은 oos_2(후속)."}
  ],
  "verdict": "RESOLVED"
}
```

### Narrative

성공기준 5건 전부 MET — sc_1~sc_4 는 실 edit + smoke 13건 전건 PASS(FAIL 0)로 객관 검증, sc_5 는 narrative 추적으로 false-negative 교정을 확인했다. 정련 기준 하에서 write-time guard(`secret-guard.py`, matcher=Edit|Write)는 'SessionStart event' gate 를 충족하지 못하므로 더 이상 settings-scan gap 을 억제하지 못한다 — v8.10 (C) 가 노출한 false-negative 의 직접 교정이다. 단 sc_5 는 narrative-only 검증(security perspective comment 정합) — agent prompt-time 분기의 실 audit 재검증은 정적 smoke 밖이라 oos_2(price-compare 재audit, 후속 candidate)로 남는다. verdict = RESOLVED.

## REPORT

### Spec

```json
{
  "summary": "v8.10 (C) 결함(harness-gap-analyzer d_2 name-token detect 가 write-time guard 와 settings-scan 의 책임 직교를 구분 못 해 false-negative) 실 수정. 자산 2곳(gap-analyzer.md:38 d_2 pointer + README.md:109 § 4 '권고 case' 컬럼 canonical)을 '발동 시점(event)이 SessionStart 인 hook ∧ secret/scan 책임 토큰, write-time guard Edit|Write 제외' 기준으로 동시 정련. design-review 3관점 FAIL 0, smoke 13건 전건 PASS, sc 5/5 MET.",
  "delta": [
    {"area": "agents/harness-gap-analyzer.md", "change": "d_2 inline 예시를 name-token 단독 → SessionStart event gate + 책임 토큰 결합 pointer(판별 본체 § 4 참조, 1줄 예시). write-time guard 제외 + d_4 투명보고 문구."},
    {"area": "bootstrap/claude-code-catalog/README.md", "change": "§ 4 'session-start-secret-scan.sh' row '권고 case (gap 조건)' 컬럼을 matcher 기반 canonical 판별 진술로 갱신(Edit|Write 책임 직교 제외 명시)."},
    {"area": "development/milestones/v8.11/", "change": "MILESTONE.md(8 stage + SUB_MILESTONES + SCOPE_OUT_NOTES) + execute/phase-1.md 신설. ROADMAP next_candidates→milestones in_progress→completed."}
  ],
  "lessons_learned": [
    {"id": "L1", "priority": "P1", "lesson": "INTENT 동결 필드(sc_1)의 literal 표현이 EXECUTE drift source 가 될 수 있다 — sc_1 의 `matcher==SessionStart` 가 risk_1(literal 회피)과 표면 충돌. mechanism = DESIGN 이 정본 문구('event 표현')를 별도 고정하면 INTENT 텍스트 불변으로도 drift 봉합. spec-drift design-review 가 이 미세 충돌을 decisive 로 잡음 = N+ 가변 관점 검토의 실효."},
    {"id": "L2", "priority": "P2", "lesson": "단일 source 정합 = canonical 1곳(§ 4) + pointer 1곳(d_2, 자기완결 재기재 금지). '최소 예시' 의 해석 폭 자체가 drift source — architecture comment 흡수해 'pointer + 1줄' 로 명시 제한. cascade marker 부재 host 는 manual 동시 commit 이 유일 mechanism."},
    {"id": "L3", "priority": "P1", "lesson": "detect-logic 결함의 origin 이 self-loop(harness-meta 자기 단일 hook 책상) 아닌 외부 적용(v8.10 (C), 유사명 직교 hook 보유 프로젝트)에서만 노출 → 본 milestone 이 실 수정. verification-philosophy(v8.6) 제품 역량 검증 vector 가 검출 → v8.4 패턴(외부 검출 → 큰 건 승격) 재현. 단 수정의 실효(정련 기준이 실제 gap=true surface)는 다시 외부 audit 검증 필요(oos_2) — v8.9→v8.10 검증 공백 패턴 재현."}
  ],
  "verdict": "RESOLVED"
}
```

### Narrative

v8.11 은 v8.10 의 실 price-compare audit 이 노출한 detect-logic 결함 (C) 를 실 수정했다. name-token 단독 판별을 '발동 시점(event)이 SessionStart 인 hook ∧ secret/scan 책임 토큰' 결합으로 교체해, write-time guard(`secret-guard.py`, Edit|Write)가 직교 책임의 settings-scan gap 을 억제하던 false-negative 를 제거했다. § 4 컬럼이 canonical 판별 진술, gap-analyzer d_2 는 pointer + 1줄로 단일 source 정합을 유지한다.

세 lesson 이 남는다 — (L1) INTENT 동결 필드의 literal 표현이 drift source 가 될 수 있고 DESIGN 정본 문구 고정이 봉합 mechanism, spec-drift design-review 가 이 미세 충돌을 잡은 것이 N+ 가변 관점의 실효다. (L2) '최소 예시' 의 해석 폭 자체가 drift source 라 'pointer + 1줄' 명시 제한이 필요. (L3) detect-logic 결함 origin 이 외부 적용에서만 노출됐고 수정의 실효도 다시 외부 audit 검증이 필요 — v8.9→v8.10 의 검증 공백 패턴이 재현되므로 oos_2(price-compare 재audit)가 자연 후속이다. verdict = RESOLVED.

## PROPOSE

### Spec

```json
{
  "next_candidates": [
    {
      "id": "area4-detect-refinement-external-verify",
      "title": "정련된 영역 4 detect 기준 실효를 price-compare 실 audit으로 검증",
      "trigger": "A_user",
      "origin_milestone": "v8.11",
      "target_version": "v8.12",
      "rationale": "v8.11 oos_2 — 정련 기준(SessionStart event gate + 책임 토큰)의 실효는 정적 smoke 밖(agent prompt-time 분기, L3). v8.9→v8.10 패턴 정합 — secret-guard.py 보유 price-compare working tree 에서 정련 기준이 실제 gap=true surface(과억제 false-negative 교정) + over-recommend false-positive 0 을 실 audit 으로 검증. 가벼운 흐름(외부 적용 관찰 trace = §7.4 작은 건) 적격.",
      "decision_pending": "사용자 명시 결정 전까지 next_candidates[] append 보류 (v7.0 T1.2 정합)"
    },
    {
      "id": "area4-detect-criterion-generalization",
      "title": "영역 4 detect 기준을 모든 자산 구조 필드로 일반화",
      "trigger": "D_design",
      "origin_milestone": "v8.11",
      "target_version": "v9.0",
      "rationale": "v8.11 oos_1 + SCOPE_OUT_NOTES #1. § 4 '권고 case' 컬럼을 모든 미래 자산이 따르는 구조(event/matcher + 책임 필드)로 재설계 — 자산 2건째 등록이 원 trigger(현재 미충족). hook-asset-library-canonicalization 과 영역 겹침 → bundling 적격.",
      "decision_pending": "사용자 명시 결정 전까지 next_candidates[] append 보류 (v7.0 T1.2 정합, 자산 2건째 trigger 미충족)"
    }
  ]
}
```

### Narrative

자연 후속은 v8.9→v8.10 패턴의 재현이다 — v8.11 이 detect 기준을 정련했으나 그 실효(정련 기준이 실 audit 에서 secret-guard.py 보유 프로젝트를 gap=true 로 surface)는 agent prompt-time 분기라 정적 smoke 밖이다(oos_2, L3). price-compare working tree 재audit 으로 (A) 정련 기준이 false-negative 를 실제 교정하는지 + (B) over-recommend false-positive 0 을 검증하는 `area4-detect-refinement-external-verify` 를 제안한다 — 외부 적용 관찰 trace 라 가벼운 흐름(§7.4) 적격. detect 기준 일반화(oos_1)는 자산 2건째 등록 trigger 미충족이라 등재 보류. next_candidates[] 실 append 는 사용자 명시 결정 후만(v7.0 T1.2).

## SUB_MILESTONES

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음)

## SCOPE_OUT_NOTES

> v7.0 T1.3 — DESIGN design-review(architecture/spec-drift/security) 안 scope 외 거명 보존. next_candidates 자동 append 부재 — PROPOSE stage 안 사용자 명시 결정 후만 등재.

1. **detect 기준 일반화 (oos_1, opt_4 폐기)** — § 4 '권고 case' 컬럼을 모든 미래 자산이 따르는 구조(event/matcher + 책임 필드)로 재설계. 본 milestone 은 자산 1건 정밀 수정만. 원 trigger = 자산 2건째 등록(README § 4 경량 인벤토리 note) + `hook-asset-library-canonicalization` 후보와 영역 겹침. 후속 candidate (사용자 게이트).
2. **정련 기준 실 외부 적용 검증 (oos_2)** — price-compare 재audit 으로 secret-guard.py 보유 프로젝트가 실제 gap=true surface 하는지 확인. agent prompt-time 분기는 정적 smoke 밖(v8.9→v8.10 패턴). security perspective 와 직접 연결 — sc_5 narrative-only 라 실 보호 효과는 이 검증까지 미확정. 후속 외부 적용 검증 candidate (사용자 게이트).
3. **project-scanner 변경 (oos_3) — 확정 불요** — scanner 가 이미 `harness_state.hooks[].matcher` 출력(project-scanner.md:55 직접 확인). 입력 신호 존재 → 수정 불요, v8.4 식 upstream 함정 부재. 거명 보존용(후속 아님).
4. **[우연 발견] sc_1 문구 안 literal `matcher==SessionStart` 잔존** — INTENT success_criterion(MILESTONE.md sc_1) 텍스트가 risk_1 회피 대상 literal 표현 보유. INTENT 동결이라 수정 대상 아니나 DESIGN d_1 정본 문구('event 표현')로 흡수 → 본 milestone scope 안 처리. 별도 후속 불요(거명만).
