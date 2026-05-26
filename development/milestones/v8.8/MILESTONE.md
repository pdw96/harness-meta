---
id: settings-allowlist-secret-scan
title: settings allow-list 평문 secret SessionStart 스캔 자산 신설
version: v8.8
status: completed
---

# v8.8 — settings allow-list 평문 secret SessionStart 스캔 자산 신설

## INTENT

### Spec

```json
{
  "id": "settings-allowlist-secret-scan",
  "title": "settings allow-list 평문 secret SessionStart 스캔 자산 신설",
  "goal": "settings*.json (settings.json + settings.local.json) 의 permissions allow/deny 리스트 안 평문 secret(API key/PAT/JWT/평문 password 패턴)을 SessionStart 시점에 스캔해 경고하는 canonical hook 자산을 신설한다. 차단(deny) 아닌 경고(warn-only) — false positive 회피 + 작성자 판단 1차 source(price-compare hook 철학 정합). 자산은 harness-meta 경로 하드코딩 의존 없는 standalone 으로 설계해 (1) harness-meta 자신의 SessionStart hook 에 wiring(자기 보호) + (2) 외부 프로젝트에 그대로 재사용 가능하게 한다. 스캔 대상 필드 정확 범위 + secret 패턴 집합 + SessionStart 출력 규약은 RESEARCH/DESIGN 에서 확정.",
  "motivation": "5요소 = Constraint (가드레일 면). v8.7 price-compare audit 부수 발견 — Claude Code 가 과거 실행한 curl 명령을 settings.local.json permissions.allow 리스트에 통째 저장하며 유효 Docker Hub PAT + JWT(scope repo:admin) 평문 박제. 조사 결과 후보의 전제 2겹이 무너짐: (1) 확장 대상이라던 harness-meta secret-guard.py 가 부재 — 외부 price-compare 의 hook 은 audit-team 이 audit 그 자리에서 LLM 즉석 생성한 1회성 외부 부품이고 harness-meta 는 hook 소스/템플릿 라이브러리를 0건 보유. (2) allow 리스트 박제는 PreToolUse(Edit|Write) 로 구조적 관측 불가 — Claude Code 가 settings 파일을 직접 갱신하는 건 도구 호출이 아니고, claude-code-guide 확인상 allow 갱신을 발화하는 hook 이벤트 자체가 부재(공식 6 이벤트). 따라서 기존 hook 확장이 아니라 SessionStart 주기 스캔이라는 별도 메커니즘이 유일하게 viable. self-loop(책상)로는 절대 못 본 보안 격차가 외부 실 repo 운영 흔적에서만 노출 → 제품 보강.",
  "success_criteria": [
    {"id": "sc_1", "criterion": "canonical 스캐너 스크립트 신설 — settings*.json 의 permissions allow/deny 배열을 읽어 평문 secret 패턴 감지 시 경고(SessionStart 출력 규약 정합, 비차단), 정상/secret 부재 시 무반응(no-op). harness-meta 경로/컨텍스트 하드코딩 의존 부재(standalone)."},
    {"id": "sc_2", "criterion": "harness-meta 자신의 SessionStart hook 흐름에 스캐너 wiring — 매 세션 시작 시 harness-meta repo-local settings*.json 자동 스캔(도그푸드 자기 보호). 기존 SessionStart hook(version-track / session-init) 무손상 공존."},
    {"id": "sc_3", "criterion": "외부 재사용성 입증 — 스캐너가 임의 프로젝트의 .claude/settings*.json 에 그대로 동작(경로 인자화 또는 CWD-relative). audit-team 권고/배치 wiring 자체는 oos_1(후속)이나, 자산이 재사용 가능 형태임은 v8.8 에서 보장."},
    {"id": "sc_4", "criterion": "검증 — 모의 secret 박제 settings(dckr_pat/JWT) 주입 시 감지 + 정상 settings 무반응 케이스 통과. harness-meta 현 settings.local.json(현재 secret 부재 확인됨) 스캔 시 false positive 0."},
    {"id": "sc_5", "criterion": "기존 smoke 전체 무손상(FAIL=0) + 신규 hook 이 SessionStart 출력 규약 위반 0(잘못된 출력으로 세션 초기화 방해 없음). hooks.json 등록 정합."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "audit-team 권고/배치 wiring — claude-docs-mapper/component-proposer 가 본 스캐너를 외부 프로젝트에 권고하도록 하는 agent 지침 보강. 사용자가 v8.8 범위를 '자산 신설 + meta 자기적용'으로 좁힘. 외부 권고 메커니즘은 별도 후속(자산 재사용성 sc_3 은 보장하되 권고 자동화는 분리)."},
    {"id": "oos_2", "item": "allow 갱신 실시간 차단 — claude-code-guide 확인상 allow 갱신 발화 hook 이벤트 부재로 구조적 불가. 본 자산은 감지(SessionStart 주기 스캔)만, 실시간 차단 비목표."},
    {"id": "oos_3", "item": "자동 회수/secret 무효화/allow 항목 자동 제거 — 경고만(block 아님) 결정 정합. SessionStart 자동 파일 수정은 위험(세션 시작마다 settings 변형) → 경고 메시지에 수동 조치 안내만, 자동 제거 비채택."},
    {"id": "oos_4", "item": "외부 price-compare repo 의 기존 secret-guard.py 수정/교체 — 외부 부품은 harness-meta 미소유. 외부 repo 적용은 별도 외부 적용 trace."}
  ],
  "dependencies": [
    {"id": "dep_1", "ref": "development/milestones/v8.7/LIGHTWEIGHT.md", "purpose": "직접 origin — 부수 발견(settings.local.json:37-38 평문 PAT+JWT 박제) + L2(secret-guard Edit/Write 한정 scope 격차) + P1-2 후보."},
    {"id": "dep_2", "ref": "price-compare/.claude/hooks/secret-guard.py (외부 참조)", "purpose": "참조 패턴 — 4 secret regex(Docker Hub PAT/JWT/Anthropic key/평문 password) + 경고(warn-only) 철학. 단 PreToolUse 메커니즘은 본 자산과 다름(본 자산=SessionStart 스캔)."},
    {"id": "dep_3", "ref": "claude/hooks/ (session-start-version-track.sh, session-init.sh, hooks.json)", "purpose": "wiring host — harness-meta 기존 SessionStart hook 등록 구조. 신규 스캐너 등록 방식(별도 hook vs 기존 확장) RESEARCH 에서 확정."},
    {"id": "dep_4", "ref": "claude-code-guide 조사 결과(2026-05-27)", "purpose": "근거 — allow 갱신 hook 이벤트 부재(공식 6 이벤트) + PreToolUse 가 settings 내부 갱신 미관측 → SessionStart 스캔이 유일 viable 메커니즘. 후보 재설계 근거."},
    {"id": "dep_5", "ref": "development/ARCHITECTURE.md § 3 (5요소 Constraint)", "purpose": "정전 single source — 본 자산이 편입되는 Constraint(가드레일) 요소 매핑."}
  ]
}
```

### Narrative

본 milestone 은 v8.7 부수 발견(외부 price-compare settings.local.json allow 리스트에 평문 Docker Hub PAT + JWT 박제)의 보안 격차 보강이다. 당초 next_candidate(`secret-guard-settings-allowlist-scan`)는 "harness-meta 의 secret-guard.py 패턴을 확장"하는 것으로 적혔으나, OPEN 전 조사 라운드에서 **전제 2겹이 무너졌다** — (1) harness-meta 엔 확장할 secret-guard.py 가 애초에 없다(외부 hook 은 audit-team 즉석 생성 1회성 부품, harness-meta 미소유). (2) allow 리스트 박제는 `PreToolUse(Edit|Write)` 로 구조적으로 못 막는다(Claude Code 가 settings 파일을 직접 갱신 = 도구 호출 아님, allow 갱신 발화 hook 이벤트 부재). 비유하면 현관 자물쇠를 강화하려 했으나 도둑은 자물쇠 달 자리가 없는 뒷문으로 들어왔고, 막으려면 "정기 순찰"(SessionStart 스캔)이라는 다른 방식이 필요하다.

사용자 pre-INTENT 대화(2026-05-27)로 두 경계를 좁혔다 — (1) **자산 쓰임 = harness-meta 자기 보호 + 외부 재사용 둘 다**(standalone canonical 자산), (2) **감지 시 동작 = 경고만**(block 아님, price-compare hook 의 narrative-우선 철학 정합, false positive 회피). 단 외부 권고/배치 자동화(audit-team 지침 wiring)는 v8.8 범위에서 분리(oos_1) — 본 milestone 은 자산 신설 + harness-meta 자기적용 + 재사용 가능 형태 보장까지다. 스캔 대상 필드 정확 범위 / secret 패턴 집합 / SessionStart 출력 규약 / 등록 방식(신규 hook vs 기존 SessionStart 확장)은 RESEARCH 에서 Claude Code SessionStart hook 규약 + 기존 hooks.json 구조를 조사한 뒤 DESIGN 에서 확정한다.

## RESEARCH

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "claude-code-guide 조사(2026-05-27, dep_4)", "finding": "Claude Code 공식 hook 이벤트 6종(SessionStart/SessionEnd/UserPromptSubmit/Stop/StopFailure/PreToolUse/PostToolUse) 중 permissions.allow 갱신을 발화하는 이벤트 부재. PreToolUse(Edit|Write) 는 Claude Code 자체의 settings 파일 내부 갱신을 tool_input 으로 관측 불가(도구 호출 아님). → 실시간 차단 구조적 불가, SessionStart 주기 스캔(감지)만 viable."},
    {"id": "ext_2", "source": "SessionStart hook 출력 규약(기존 hook 2종 + CC issues #12671/#19346/#21643)", "finding": "출력 = {\"hookSpecificOutput\":{\"hookEventName\":\"SessionStart\",\"additionalContext\":\"<text>\"}}. 모든 분기 exit 0 + valid JSON 의무(아니면 SessionStart UI 에러). no-op 시 printf '{}'. additionalContext = Claude 가 보는 context 채널(기존 version-track/session-init 동일 사용) → 보안 경고를 여기 주입하면 Claude 가 사용자에게 relay/조치 가능."},
    {"id": "ext_3", "source": "price-compare/.claude/hooks/secret-guard.py(dep_2)", "finding": "참조 패턴 — 4 regex: Docker Hub PAT `dckr_pat_[A-Za-z0-9_-]{8,}` / JWT `eyJ[..]\\.[..]\\.[..]` / Anthropic key `sk-ant-[..]` / 평문 password `password\"{0,4}\\s*[:=]\\s*\"{0,4}[^\"\\s]{6,}`. 경고(warn-only) + Windows cp949 회피 reconfigure. 단 PreToolUse 메커니즘(tool_input 스캔)이라 본 자산(파일 스캔)과 입력 경로 다름."}
  ],
  "codebase": [
    {"id": "cb_1", "ref": "claude/hooks/hooks.json", "finding": "SessionStart[].hooks[] 에 이미 session-init.sh + session-start-version-track.sh 2종 array 등록. 3번째 command 항목 append = trivial. command 형식 = ${CLAUDE_PLUGIN_ROOT}/claude/hooks/<name>.sh."},
    {"id": "cb_2", "ref": "claude/hooks/session-init.sh + session-start-version-track.sh", "finding": "둘 다 bash-only(claude/CLAUDE.md CRITICAL 'hook bash-only, Windows Git Bash 의존'). session-init.sh 명시 설계 원칙 = '깊은 TOML/JSON 파싱 안 함'(grep+sed flat 추출만). JSON escape 4-step 공통 패턴(tr 제어문자 strip → sed backslash/quote/tab/CR → awk \\n join) 재사용 가능. gate = 파일 존재(version-track=log file / session-init=.harness.toml)."},
    {"id": "cb_3", "ref": "CLAUDE.md '글로벌 레이어는 CWD 무관 로드'", "finding": "plugin 활성 시 SessionStart hook 은 모든 세션(모든 프로젝트 CWD)에서 실행. → 스캐너를 CWD-relative(.claude/settings*.json) gate 로 두면 harness-meta 자기 보호 + 사용자가 작업하는 임의 프로젝트 자동 커버 동시 달성(sc_2 + sc_3 일부)."},
    {"id": "cb_4", "ref": ".claude/settings.local.json(harness-meta 현 상태)", "finding": "현재 평문 secret 부재(메인 Claude 직접 Read 확인). 단 line 14 에 과거 curl(docs URL, secret 없음) 저장 흔적 — allow 리스트에 명령 통째 저장되는 경로 실재 확인. FP 검증 baseline(스캔 시 0 hit 기대)."},
    {"id": "cb_5", "ref": "tests/ smoke 구조", "finding": "신규 hook 검증 = tests/smoke-*.sh 패턴(claude/CLAUDE.md '신규 smoke 로 dynamic 검증'). 모의 secret 박제 fixture 주입 + 정상 fixture 무반응 2 케이스 = smoke 형태로 회귀 차단 가능."}
  ],
  "options": [
    {"id": "opt_lang", "question": "스캐너 구현 언어", "A": "bash grep 기반(secret regex 를 settings*.json raw 파일에 직접 grep, JSON 구조 파싱 안 함)", "B": "Python(json 파싱 + allow[] 배열 순회)", "recommend": "A — bash-only 정책(cb_2) + session-init.sh '깊은 파싱 안 함' 철학 정합 + jq/python 의존 0. secret 이 어느 키에 있든 raw grep 으로 포착(allow[] 구조 파싱 불요). B 는 bash-only 위반 + 의존 추가."},
    {"id": "opt_reg", "question": "등록 방식", "A": "신규 독립 .sh 1개를 hooks.json SessionStart[].hooks[] 에 append", "B": "기존 session-init.sh/version-track.sh 확장", "recommend": "A — 기존 2-hook array 패턴 정합(cb_1) + 단일 책임(보안 스캔) 분리. B 는 기존 hook 책임 오염."},
    {"id": "opt_gate", "question": "실행 gate", "A": "$CLAUDE_PROJECT_DIR/.claude/settings*.json 존재(CWD-relative)", "B": "harness-meta marker(log file/.harness.toml)", "recommend": "A — 재사용성(sc_3) 핵심. CWD-relative gate 면 harness-meta + 임의 프로젝트 자동 동작(cb_3). B 는 harness-meta 전용으로 묶여 외부 재사용 불가."},
    {"id": "opt_out", "question": "감지 시 출력", "A": "additionalContext 에 경고 주입(Claude 가 사용자에게 relay)", "B": "systemMessage", "recommend": "A — 기존 SessionStart hook 전부 additionalContext 사용(ext_2). warn-only 결정 정합. exit 0 + valid JSON 의무 준수."}
  ],
  "risks_identified": [
    {"id": "risk_1", "risk": "false positive — JWT regex(eyJ..)가 정상 base64 blob 에, 평문 password regex 가 permission 패턴 문자열('password' 언급)에 오탐. settings.local.json 은 명령 패턴을 합법적으로 다수 보유.", "severity": "MEDIUM", "mitigation": "패턴 보수적 튜닝(prefix anchored: dckr_pat_/sk-ant-/ghp_ 등 명확 prefix 우선) + harness-meta 현 settings.local.json(secret 부재, cb_4) baseline 으로 FP=0 검증(sc_4). 경고 메시지에 '추정' 명시 + 작성자 판단 위임(warn-only)."},
    {"id": "risk_2", "risk": "글로벌 hook 이 매 세션·모든 프로젝트에서 실행(cb_3) → 성능/노이즈.", "severity": "LOW", "mitigation": "settings 파일 부재 시 즉시 {} no-op + grep 단발 빠름 + secret 부재 시 무반응. exit 0 valid JSON always."},
    {"id": "risk_3", "risk": "bash JSON escape 누락 시 SessionStart UI 에러(#12671 등).", "severity": "MEDIUM", "mitigation": "기존 session-init.sh 4-step escape 패턴(cb_2) 그대로 재사용. 모든 분기 printf '{}' or escaped JSON + exit 0."},
    {"id": "risk_4", "risk": "CRLF 라인 종결 시 $'\\r' 오류(claude/CLAUDE.md CRITICAL).", "severity": "LOW", "mitigation": ".gitattributes '*.sh text eol=lf' 기존 정합 + LF 작성."}
  ]
}
```

### Narrative

RESEARCH 결과 설계 방향이 명확히 수렴했다. 핵심 통찰은 **JSON 구조를 파싱하지 않는다**는 것 — allow 리스트의 배열 구조를 정확히 순회할 필요 없이, settings*.json raw 파일을 secret regex 로 직접 grep 하면 secret 이 어느 키(allow/deny/기타)에 있든 포착된다. 이는 (1) bash-only hook 정책(claude/CLAUDE.md CRITICAL)과 (2) session-init.sh 가 명시한 '깊은 TOML/JSON 파싱 안 함' 철학에 동시 정합하며, jq/python 의존을 0 으로 만든다. price-compare 의 secret-guard.py 가 Python 이었던 것은 PreToolUse tool_input(이미 구조화된 dict) 을 받았기 때문이고, 본 자산은 파일을 직접 읽으므로 메커니즘이 다르다.

등록은 기존 2-hook SessionStart array 에 신규 독립 .sh 1개를 append(opt_reg-A), gate 는 harness-meta marker 가 아닌 `.claude/settings*.json` 존재로 두어(opt_gate-A) 글로벌 레이어 CWD-무관 로드 특성상 harness-meta 자기 보호 + 사용자가 작업하는 임의 프로젝트 자동 커버를 동시에 달성한다(재사용성 sc_3 의 자연 충족). 출력은 기존 hook 전부가 쓰는 additionalContext 채널로 경고를 주입(opt_out-A)해 warn-only 결정과 정합한다.

남은 결정적 risk 는 false positive(risk_1) — JWT/password regex 가 합법적 명령 패턴에 오탐할 수 있다. 완화 = 명확한 prefix(dckr_pat_/sk-ant-/ghp_ 등) 우선의 보수적 패턴 + harness-meta 현 settings.local.json(secret 부재 확인, cb_4)을 baseline 으로 FP=0 검증. 정확한 secret 패턴 집합과 보수성 수준은 DESIGN 에서 확정한다.

## DESIGN

### Spec

```json
{
  "decisions": [
    {"id": "d_1", "decision": "신규 bash hook `claude/hooks/session-start-secret-scan.sh` 1개 신설 — settings*.json raw 파일을 secret regex 로 grep(JSON 구조 파싱 안 함). bash-only(opt_lang-A), 단일 책임 독립 hook(opt_reg-A).", "rationale": "opt_lang/opt_reg recommend 정합. bash-only 정책 + session-init.sh '깊은 파싱 안 함' 철학."},
    {"id": "d_2", "decision": "gate = $CLAUDE_PROJECT_DIR/.claude/settings.json + settings.local.json 존재(CWD-relative, opt_gate-A). 둘 다 부재 시 printf '{}'; exit 0.", "rationale": "재사용성(sc_3) — harness-meta marker 가 아닌 settings 파일 gate 로 글로벌 CWD-무관 hook 이 임의 프로젝트 자동 커버(cb_3)."},
    {"id": "d_3", "decision": "secret 패턴 = 보수적 prefix-anchored 집합만 — Docker Hub PAT `dckr_pat_[A-Za-z0-9_-]{8,}` / Anthropic `sk-ant-[A-Za-z0-9_-]{8,}` / GitHub classic PAT `gh[pousr]_[A-Za-z0-9]{20,}` / **GitHub fine-grained PAT `github_pat_[A-Za-z0-9_]{22,}`(D-SEC-2 추가 — classic `gh[pousr]_` 가 `github_pat_` 미매칭, v8.7 origin 도메인 정합)** / AWS access key id `AKIA[0-9A-Z]{16}` / JWT `eyJ[A-Za-z0-9_-]{8,}\\.[A-Za-z0-9_-]{8,}\\.[A-Za-z0-9_-]{8,}`. **price-compare 의 generic 평문 password regex 는 비채택**(FP 위험 risk_1).", "rationale": "risk_1 완화 — 명확 prefix 토큰만 = FP 최소. generic password 패턴은 permission 문자열 다수 보유한 settings.local.json 에서 오탐 높음. AWS 는 `AKIA` 한정(access key id) — `ASIA`(임시)/`AROA`/`AIDA` 는 FP 위험으로 의도 제외(FN 수용, D-FP-1). access key id 감지 시 메시지에 'secret access key 동반 점검' 안내."},
    {"id": "d_4", "decision": "감지 시 출력 = **systemMessage(사용자 UI 직접 표시) + additionalContext(Claude relay) 병용**(D-DRIFT-1 정정 — claude-code-guide 2026-05-27 확인: SessionStart 가 systemMessage universal field 지원, secret-guard.py:44-51 dual-channel 정합). warn-only — block/자동수정 부재(oos_3). 메시지(영문, AGENTS.md §8 locale — 기존 SessionStart hook 2종 영문 정합) = 감지 패턴명 + 'suspected' 명시 + **tracked 차등 통지**(settings.json = 공유·commit 위험 高 / settings.local.json = 통상 gitignore) + 환경변수·secret 매니저 분리 + allow 리스트 박제 시 수동 회수·무효화 안내.", "rationale": "D-DRIFT-1 decisive — additionalContext 단독은 Claude relay 누락 시 경고 소실. systemMessage 가 사용자 직접 가시성 보증(보안 자산 실효 핵심). D-SEC-1 — settings.json(commit) vs local(gitignore) 위험 차등이 보안 통지의 핵심 가치."},
    {"id": "d_5", "decision": "hooks.json SessionStart[].hooks[] 에 3번째 command append(${CLAUDE_PLUGIN_ROOT}/claude/hooks/session-start-secret-scan.sh). 기존 session-init/version-track 무손상.", "rationale": "cb_1 — 기존 2-hook array 패턴 정합."},
    {"id": "d_6", "decision": "JSON escape = session-init.sh 4-step 패턴(tr 제어문자 strip → sed backslash/quote/tab/CR → awk \\n join) 그대로 재사용. 모든 분기 exit 0 + valid JSON.", "rationale": "risk_3 완화 — 검증된 패턴 재사용, SessionStart UI 에러 회피."},
    {"id": "d_7", "decision": "회귀 차단 smoke 신설 `tests/smoke-secret-scan.sh` — (1) 모의 secret 박제 fixture(dckr_pat_/github_pat_/JWT 등) 감지 + (2) 정상 fixture 무반응 + (3) harness-meta 현 settings.local.json FP=0 baseline + **(4) grep `\\.` literal dot 보존 검증**(D-FP-2 — JWT 패턴 single-quote escape). + claude/CLAUDE.md Hook 정책 섹션 + 디렉토리 트리 갱신.", "rationale": "sc_4/sc_5 + cb_5 + 신규 hook 문서화 의무(claude/CLAUDE.md). D-FP-2 입력 grep escape 는 risk_3(출력 JSON escape)와 별개 — smoke 로 명시 검증."},
    {"id": "d_8", "decision": "phase-1 구현 함정 명시 — (a) grep 패턴 **single-quote 의무**(D-FP-2: double-quote 시 `\\.` 가 `.`(any char)로 떨어져 FP), (b) `settings*.json` glob **nullglob 또는 `[ -e ]` 가드**(매치 0건 시 literal 전개 방지), (c) 메시지 영문(locale §8).", "rationale": "design-review 구현 함정 흡수 — 설계 결함 아닌 EXECUTE 주의점."}
  ],
  "approach": "신규 bash hook 1개(파일 grep 스캐너) + hooks.json 등록 1줄 + smoke 1개 + 문서 갱신. JSON 파싱 회피로 bash-only + 의존 0 유지. 글로벌 CWD-무관 특성으로 자기 보호(sc_2) + 외부 재사용(sc_3) 동시 달성. warn-only(systemMessage 사용자 가시 + additionalContext) + 보수 패턴으로 FP=0 목표(sc_4).",
  "phases": [
    {"id": "phase-1", "title": "스캐너 hook + 등록", "scope": "claude/hooks/session-start-secret-scan.sh 신설(d_1~d_4,d_6,d_8) + hooks.json SessionStart append(d_5). LF 라인 종결. systemMessage+additionalContext 병용 출력.", "maps_to": ["sc_1", "sc_2", "sc_3", "sc_5"]},
    {"id": "phase-2", "title": "smoke 검증 + 문서", "scope": "tests/smoke-secret-scan.sh 신설(d_7, 4 케이스) + claude/CLAUDE.md Hook 정책/디렉토리 트리 갱신. 전체 smoke FAIL=0 확인.", "maps_to": ["sc_4", "sc_5"]}
  ],
  "risk_mitigation": [
    {"ref": "risk_1(FP)", "design_response": "d_3 보수 prefix-anchored 패턴 + generic password 비채택 + d_7 harness-meta settings.local.json FP=0 baseline 검증(design-review 실측 5 패턴 0 매치 확인). 경고 'suspected' 명시."},
    {"ref": "risk_2(글로벌 노이즈)", "design_response": "d_2 settings 부재 즉시 no-op + grep 단발 + secret 부재 시 무반응. **D-ARCH-1 — 타 프로젝트 settings 스캔은 의도된 보호 확장(sc_3)이며 노이즈 아님**(글로벌 hook CWD-무관 특성의 의도 활용)."},
    {"ref": "risk_3(출력 JSON escape)", "design_response": "d_6 검증된 4-step escape 재사용 + 모든 분기 exit 0 valid JSON."},
    {"ref": "risk_4(CRLF)", "design_response": ".gitattributes '*.sh text eol=lf' 기존 정합(design-review 실측 확인) + LF 작성. phase-1 검증."},
    {"ref": "risk_5(입력 grep escape, D-FP-2 신규)", "design_response": "d_8(a) 패턴 single-quote 의무 + d_7(4) smoke 로 `\\.` literal dot 보존 검증."}
  ],
  "design_review_resolution": "harness-meta:design-review 4 관점(security/spec-drift/architecture/false-positive-robustness) 완료. decisive 5건 전부 반영 — D-SEC-1(tracked 차등 통지 d_4) / D-SEC-2(github_pat_ 추가 d_3) / D-DRIFT-1(systemMessage 병용 d_4, claude-code-guide fact-verify 완료) / D-ARCH-1(risk_2 의도 보호 명시) / D-FP-2(grep single-quote escape d_8+d_7). 비-decisive 3건(D-FP-1 AKIA rationale / glob 가드 / locale) d_3/d_8 흡수. FP=0 baseline 실측 입증(design-review 가 실 settings.local.json 95 allow 항목에 5 패턴 grep 0 매치 확인)."
}
```

### Narrative

설계는 RESEARCH 의 수렴 방향을 그대로 확정한다 — JSON 구조를 파싱하지 않고 settings*.json raw 파일을 secret regex 로 grep 하는 단일 bash hook. 이 한 결정(d_1)이 bash-only 정책 + 의존 0 + 단순성을 동시에 만족시키는 핵심이다.

가장 신경 쓴 설계 판단은 두 가지다. (1) **gate 를 harness-meta marker 가 아닌 settings 파일 존재로 둔 것**(d_2) — 이로써 글로벌 레이어의 CWD-무관 로드 특성이 단점이 아닌 장점이 되어, 하나의 hook 이 harness-meta 자기 보호와 사용자가 작업하는 임의 프로젝트 커버를 동시에 한다. 외부 재사용성(sc_3)이 별도 작업 없이 자연 충족된다. (2) **secret 패턴을 보수적 prefix-anchored 집합으로 제한하고 price-compare 의 generic 평문 password regex 를 의도적으로 뺀 것**(d_3) — settings.local.json 은 permission 명령 패턴을 합법적으로 다수 보유하므로 generic password 패턴은 오탐(risk_1)이 높다. 명확한 prefix(dckr_pat_/sk-ant-/gh*_/AKIA/JWT) 만 잡아 FP=0 을 목표한다.

2 phase 로 분할 — phase-1(스캐너 + 등록)이 자산 본체, phase-2(smoke + 문서)가 회귀 차단 + 문서화. 다음으로 design-review 4 관점 검토를 거쳐 scope 정합을 확인한 뒤 APPROVE 게이트로 간다.

## APPROVE

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-27",
    "approval_summary": "사용자가 v8.8 설계(bash grep 스캐너 hook + systemMessage 사용자 가시 경고 + 보수 prefix-anchored 패턴 6종 + 2 phase) 대로 EXECUTE 진입 명시 승인('승인 — EXECUTE 진행', AskUserQuestion APPROVE 게이트). design-review 4 관점 decisive 5건 전부 반영 후 승인. 경계 = 경고만(차단/자동수정 없음) + audit-team 권고 wiring 은 oos_1 후속."
  }
}
```

## EXECUTE

2 phase 완료 (별책 = `execute/phase-{n}.md`).

- **phase-1** (스캐너 hook + 등록) — `claude/hooks/session-start-secret-scan.sh` 신설(bash raw grep, 보수 패턴 6종, systemMessage+additionalContext warn-only, JSON escape 4-step 재사용) + `hooks.json` SessionStart append. 수동 4 케이스 검증 PASS (FP baseline {} / Docker+JWT 감지 / 정상 no-op / github_pat_ 감지 + dot 없는 eyJ JWT 거부). 상세 = `execute/phase-1.md`.
- **phase-2** (smoke + 문서) — `tests/smoke-secret-scan.sh` 신설(10 checks) + `claude/CLAUDE.md`(트리+Hook 정책 섹션) + `tests/CLAUDE.md`(매트릭스 행+count 12→13). 전체 active smoke FAIL=0. 상세 = `execute/phase-2.md`.

## VERIFY

### Spec

```json
{
  "smoke": {
    "smoke-secret-scan(신규)": "PASS=10 FAIL=0 SKIP=0",
    "smoke-claude-md-drift": "13/13 PASS (smoke count 13=13)",
    "smoke-cross-ref": "PASS=1 FAIL=0 (broken ref 0)",
    "smoke-spec-verification": "PASS=491 FAIL=0 (v8.8 8 stage 섹션 OK)",
    "smoke-scope-contract": "PASS=110 FAIL=0 (out_of_scope+approval gate)",
    "기타(bundle-trigger/open-stage/entry-title/cascade-drift/candidate-draft/agent-frontmatter)": "전부 PASS",
    "verdict": "전체 active smoke FAIL=0"
  },
  "criteria_check": [
    {"id": "sc_1", "criterion": "canonical 스캐너 신설(grep 감지/no-op/standalone)", "status": "MET", "evidence": "claude/hooks/session-start-secret-scan.sh — settings*.json raw grep, 감지 시 systemMessage 경고 / secret 부재 시 {} no-op. CLAUDE_PROJECT_DIR 인자화 = harness-meta 경로 하드코딩 부재. smoke Dynamic A/B/C/D 입증."},
    {"id": "sc_2", "criterion": "harness-meta SessionStart wiring + 기존 hook 무손상", "status": "MET", "evidence": "hooks.json SessionStart[].hooks[] 3번째 append(session-init/version-track 무손상). smoke Static 2 + 전체 smoke FAIL=0(기존 hook 회귀 0)."},
    {"id": "sc_3", "criterion": "외부 재사용성(임의 프로젝트 .claude/settings*.json 동작)", "status": "MET", "evidence": "gate=$CLAUDE_PROJECT_DIR/.claude/settings*.json(CWD-relative). smoke 가 mktemp 임의 디렉토리 fixture 로 동작 입증 = 임의 프로젝트 재사용 가능. audit-team 권고 wiring 은 oos_1(후속) — 자산 재사용 형태는 보장."},
    {"id": "sc_4", "criterion": "모의 secret 감지 + 정상 무반응 + 현 settings.local.json FP=0", "status": "MET", "evidence": "smoke Dynamic B(Docker)/C(JWT)/D(github_pat_) 감지 + A(정상) no-op + Real(harness-meta 현 settings.local.json) FP=0. phase-1 수동 4 케이스 + design-review 실측 5 패턴 0 매치 교차 확인."},
    {"id": "sc_5", "criterion": "기존 smoke FAIL=0 + 출력 규약 위반 0 + hooks.json 정합", "status": "MET", "evidence": "8 active smoke sweep FAIL=0. smoke Dynamic G — A~F 출력 전부 json.load 통과(exit 0 + valid JSON SessionStart 규약). hooks.json 등록 정합(Static 2)."}
  ],
  "design_decisions_verified": [
    {"ref": "D-DRIFT-1", "verified": "systemMessage 출력 = 사용자 UI 직접 표시(claude-code-guide fact). smoke Dynamic B/F 가 systemMessage 필드 검증."},
    {"ref": "D-FP-2", "verified": "grep `\\.` literal dot 강제 = smoke Dynamic E(dot 없는 eyJ → JWT 미매칭)로 직접 입증."},
    {"ref": "D-SEC-1", "verified": "settings.json HIGH exposure 차등 통지 = smoke Dynamic F 입증."},
    {"ref": "D-SEC-2", "verified": "github_pat_ fine-grained PAT 감지 = smoke Dynamic D 입증."}
  ],
  "verdict": "RESOLVED"
}
```

### Narrative

INTENT.success_criteria 5건 전부 MET. 핵심 검증은 sc_4(FP=0) — design-review 가 실 settings.local.json 95 allow 항목에 5 패턴 grep 0 매치를 실측했고, smoke Real check 가 동일 baseline 을 회귀로 박제했다. design-review decisive 5건 중 자동 검증 가능한 4건(D-DRIFT-1/D-FP-2/D-SEC-1/D-SEC-2)을 smoke 케이스로 직접 입증해, 설계 정정이 구현에 실제 반영됐음을 기계적으로 확인했다. 기존 hook 2종 + 전체 active smoke 회귀 0(sc_5). verdict = RESOLVED.

## REPORT

### Spec

```json
{
  "summary": "v8.7 부수 발견(settings.local.json allow 리스트 평문 PAT/JWT 박제)의 보안 격차를, SessionStart 시점 settings*.json raw grep 스캐너 canonical hook 자산으로 보강. warn-only(systemMessage 사용자 가시 + additionalContext) + 보수 prefix-anchored 패턴 6종 + CWD-relative gate(자기 보호 + 임의 프로젝트 커버). 산출 = hook 1(session-start-secret-scan.sh) + hooks.json 등록 + smoke 1(10 checks) + 문서 2(claude/CLAUDE.md, tests/CLAUDE.md). sc 5/5 MET, verdict RESOLVED.",
  "delta": [
    {"from": "원 후보(secret-guard.py settings 스캔 확장)", "to": "SessionStart 스캐너 신설(재설계)", "reason": "OPEN 전 조사로 전제 2겹 붕괴 — harness-meta 에 확장할 secret-guard.py 부재(외부 즉석 부품) + allow 박제는 PreToolUse 구조적 불가(발화 이벤트 부재). 기존 hook 확장 ❌ → 별 메커니즘 신설."},
    {"from": "additionalContext 단독(초기 DESIGN)", "to": "systemMessage + additionalContext 병용", "reason": "D-DRIFT-1 — claude-code-guide 확인상 SessionStart 가 systemMessage universal field 지원, 사용자 직접 가시성이 보안 경고 실효 핵심."},
    {"from": "price-compare 4 패턴(generic password 포함)", "to": "보수 6 패턴(generic password 제외 + github_pat_ 추가)", "reason": "D-SEC-2(fine-grained PAT 누락 보강) + risk_1(generic password FP 위험 제외)."}
  ],
  "lessons_learned": [
    {"id": "L1", "priority": "P1", "lesson": "PROPOSE 단계 next_candidate 문구는 '방향 가설'이지 '확정 스펙'이 아니다. v8.8 후보('secret-guard.py 확장')는 실제와 2겹 어긋났고(자산 부재 + 메커니즘 불가), OPEN 전 조사 라운드가 9-stage 전체의 헛디딤을 막았다. 큰 건 진입 전 후보 전제 재검증은 필수 — v8.7 기록조차 조건부('패턴 자체 확장이면')로 의심을 남겼던 것을 조사가 확정 거짓으로 판정."},
    {"id": "L2", "priority": "P1", "lesson": "외부 spec fact-verify 의 결정적 역할 — design-review 는 read-only codebase 라 외부 spec(SessionStart systemMessage 지원 여부)을 미검증으로 flag 했고, 메인 Claude 가 claude-code-guide 로 확인해 additionalContext 단독→병용 정정. '검출(design-review flag) / 정정(메인 fact-verify)' 비대칭 분업(MEMORY feedback_subagent_fact_hallucination_correction)이 실 작동."},
    {"id": "L3", "priority": "P2", "lesson": "글로벌 hook 의 CWD-무관 특성을 단점이 아닌 장점으로 활용 — gate 를 harness-meta marker 가 아닌 .claude/settings*.json 존재(CWD-relative)로 두니 자기 보호(sc_2) + 사용자 작업 임의 프로젝트 커버(sc_3)를 한 hook 으로 동시 달성. 설계 한 결정이 2 criteria 충족."},
    {"id": "L4", "priority": "P2", "lesson": "보안 자산이 의외로 간단 — settings 를 JSON 파싱하지 않고 raw grep 하면 secret 이 어느 키에 있든 포착되고, bash-only 정책 + 의존 0 + session-init.sh '깊은 파싱 안 함' 철학에 동시 정합. 복잡한 JSON 순회 회피가 견고성·이식성을 높임."},
    {"id": "L5", "priority": "P3", "lesson": "SessionStart 스캔의 본질적 한계(L2 보안) = 사후 감지. allow 박제 그 세션 안(재시작 전)에는 침묵. 실시간 차단은 발화 hook 이벤트 부재로 구조적 불가(oos_2). warn-only + tracked 차등 통지(D-SEC-1)로 damage 인지 가속이 현실적 최선."}
  ],
  "trace": ["development/milestones/v8.8/MILESTONE.md (본 산출)", "execute/phase-1.md + phase-2.md", "git log (milestone 단위 commit, 사용자 확인 후)", "CHANGELOG.md (REPORT 시점 archival 후보)"]
}
```

### Narrative

v8.8 의 가장 큰 가치는 산출물 자체보다 **후보 전제가 거짓임을 OPEN 전에 잡은 것**이다(L1). next_candidate 가 "secret-guard.py 확장"으로 적혀 있었으나 (1) 그 파일이 harness-meta 에 없고 (2) 적힌 메커니즘(PreToolUse)이 구조적으로 불가능했다 — 둘 다 조사 라운드 전에는 보이지 않았다. 이 경험은 'self-loop 로는 못 본 격차의 외부 검출'(v8.7 교훈)의 한 층위 더 — '후보 문구를 그대로 믿으면 9-stage 를 통째로 헛디딘다'.

자산 자체는 단순하고 견고하다(L4) — JSON 파싱 없이 raw grep, bash-only, 의존 0. 글로벌 hook 의 CWD-무관 특성을 gate 설계로 장점화해 자기 보호와 외부 재사용을 한 번에 얻었다(L3). 남은 한계는 사후성(L5)이나, 실시간 차단이 구조적으로 불가능한 이상 warn-only + tracked 차등 통지가 최선이다.

## PROPOSE

### Spec

```json
{
  "next_candidates": [
    {
      "id": "secret-scan-audit-team-recommendation-wiring",
      "title": "audit-team이 secret-scan 자산을 외부에 권고하도록 지침 보강",
      "trigger": "D_design",
      "origin_milestone": "v8.8",
      "target_version": "v8.9",
      "rationale": "v8.8 oos_1 direct origin — v8.8 은 자산 신설 + harness-meta 자기적용 + 재사용 가능 형태까지였고 외부 권고 wiring 은 분리됐다. 후속 = claude-docs-mapper/component-proposer 가 secret 격차 발견 시 본 SessionStart 스캐너를 권고 component 로 매핑하도록 agent 지침 보강. 컨설팅 자산(agent) 변경 = 큰 건.",
      "decision_pending": "사용자 명시 결정 전까지 next_candidates[] append 보류 (v7.0 T1.2 정합)"
    },
    {
      "id": "hook-asset-library-canonicalization",
      "title": "hook 자산 라이브러리 디렉토리 구조 정전화",
      "trigger": "D_design",
      "origin_milestone": "v8.8",
      "target_version": "v9.0",
      "rationale": "v8.8 motivation 핵심 진단 = harness-meta 가 hook 소스/템플릿 라이브러리 0건 보유(audit-team 이 매번 즉석 생성). session-start-secret-scan.sh 가 첫 canonical hook 자산 — 향후 재사용 hook 자산 보관·버전관리 구조 정전화 후보(design-review scope-out 거명). 구조 변경 가능성 = major bump 후보.",
      "decision_pending": "사용자 명시 결정 전까지 next_candidates[] append 보류 (v7.0 T1.2 정합)"
    }
  ]
}
```

### Narrative

v8.8 의 직접 후속은 oos_1 — 본 스캐너 자산을 audit-team 이 외부 프로젝트에 권고/배치하도록 agent 지침을 보강하는 것이다(secret-scan-audit-team-recommendation-wiring). 이로써 '자산 신설(v8.8) → 외부 권고 자동화(후속)'의 컨설팅 자산 완결. 더 넓게는 hook 자산 라이브러리 구조 정전화(design-review scope-out 거명) 가 motivation 진단('hook 템플릿 0건')의 근본 후속이다. 둘 다 컨설팅 자산 변경 = 큰 건이며, v7.0 T1.2 정책에 따라 사용자 명시 결정 후에만 next_candidates 에 등재한다.

## SUB_MILESTONES

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음)
