---
id: context-gauge-and-stage-carryover
title: 컨텍스트 효율 게이지·stage carry-over 권고
version: v7.1
status: completed
---

# v7.1 — 컨텍스트 효율 게이지·stage carry-over 권고

> v7.0 6 mechanism 설치 후 **첫 실사용 (dogfood)** milestone — design-review N+가변 (Stage D) + RESEARCH Explore 병렬 (Stage C) + next_candidates 절제 (Stage I) 가 본 milestone 진행 자체에서 첫 실 trigger. AI Native § 7.1 컨텍스트 효율 면.

## INTENT

### Spec

```json
{
  "id": "context-gauge-and-stage-carryover",
  "title": "컨텍스트 효율 게이지·stage carry-over 권고",
  "goal": "statusline 에 실시간 컨텍스트 사용률 게이지를 표시하고, 각 stage 완료 시 carry-over 요약 블록 + /clear 권고를 제시하는 2 반쪽 컨텍스트 효율 mechanism 을 설치한다. v7.0 6 mechanism 의 첫 실사용 (dogfood) milestone.",
  "motivation": "candidate_draft 'stage-completion-context-clear-recommendation' 채택. 원안 핵심 'Claude 가 context % 자가추정 → 40% 시 /clear 권장' 은 검증 결과 전제 오류 — 세션 안 모델은 자기 컨텍스트 % 를 직접 읽지 못하고 (hook 도 컨텍스트 데이터 미수신, claude-code-guide verify, code.claude.com/docs hooks.md), 측정 자(尺) 부재였다. 그러나 statusline stdin JSON 에 context_window.used_percentage / remaining_percentage / exceeds_200k_tokens 가 실재 (statusline.md v2.1.132+ verify) → '게이지는 statusline 이 읽고, carry-over 는 stage 완료라는 결정적 trigger 에 묶는다' 2 반쪽으로 재설계. 두 반쪽은 한 loop 으로 결합 = bundling 정당성 — 게이지(WHEN: 컨텍스트가 높다는 신호) → carry-over + /clear(HOW: 안전하게 리셋하는 행동). 둘 다 AI Native § 7.1 컨텍스트 효율 면.",
  "success_criteria": [
    {"id": "sc_1", "criterion": "계기판 — statusline.sh 가 stdin context_window.used_percentage 를 파싱·표시 (bash-only, 'Python 의존 없음' 유지) + 컨텍스트 높을 때 시각 경고 마커. **gate 확장** — 기존 .harness.toml + harness-meta repo marker (projects/meta/ 등, version-track hook 패턴 정합) 양쪽에서 활성 → 사용자 본인 harness-meta 세션에도 게이지 표시. 표기는 모델 window size 의존 (1M vs 200k) — used_percentage 우선 + 정직한 라벨. 구버전 Claude Code (context_window 필드 부재, <v2.1.132) 또는 stdin 부재 시 graceful 빈칸 no-op (회귀 0)."},
    {"id": "sc_2", "criterion": "carry-over — stage 완료 시 제시할 carry-over 요약 블록 schema 정전화. **범위 = MILESTONE.md/ROADMAP 디스크에 이미 남지 않는 'in-flight 상태'만** (진행 중 결정·대기 질문·다음 행동) — 디스크 산출물과 중복 회피. /clear 권고 동반."},
    {"id": "sc_3", "criterion": "정전화 거주 — carry-over 블록 + /clear 권고 narrative 의 단일 source 위치 결정 (CLAUDE.md / SKILL / command 중) + ARCHITECTURE 정합 거명."},
    {"id": "sc_4", "criterion": "**검증 비대칭 명시** — 계기판 반쪽은 smoke 가능 (stdin JSON fixture → 출력 assert), carry-over 반쪽은 행동 지침이라 자기회고 검증 불가 (schema 존재 + 수동 1회 확인까지만). 이 비대칭을 VERIFY 에 솔직 반영. smoke 전체 PASS (statusline smoke 포함)."},
    {"id": "sc_5", "criterion": "v7.0 mechanism 첫 dogfood evidence 회고 (deliverable 아닌 관찰) — Stage C RESEARCH Explore 병렬 + Stage D design-review N+가변 + Stage I next_candidates 절제 실 trigger 여부 → REPORT lessons 흡수."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "자동 /clear 호출 — Claude Code hook event 가 /clear 를 trigger 할 mechanism 부재 (사용자 명시 호출 본질). 본 milestone 은 '권고'까지만."},
    {"id": "oos_2", "item": "세션 안 모델이 컨텍스트 % 를 직접 읽게 만드는 시도 — 불가 verify (모델은 statusline stdin 을 못 받음). carry-over trigger 는 % 가 아닌 'stage 완료' 결정적 신호."},
    {"id": "oos_3", "item": "auto-compaction 내부 임계값 조정 — 비공개 (code.claude.com/docs how-claude-code-works.md verify), 건드릴 수 없음."},
    {"id": "oos_4", "item": "statusline 의 settings.json 등록 mechanism 변경 — 기존 'statusLine.command' 명시 메커니즘 보존 (claude/CLAUDE.md 정합)."},
    {"id": "oos_5", "item": "모델 간 % 정규화 (1M↔200k 합성 단일 수치) — 게이지는 raw used_percentage 정직 표시만, 정규화 합성값 미산출."}
  ],
  "dependencies": [
    {"id": "dep_1", "ref": "v7.0 6 mechanism 설치 (commit 034f0e8~fb3e057)", "purpose": "본 milestone = 그 첫 실사용 (dogfood) 대상 — Stage C/D/I 에서 실 trigger."},
    {"id": "dep_2", "ref": "candidate_draft 'stage-completion-context-clear-recommendation' (detected 2026-05-22)", "purpose": "본 milestone origin — 채택 후 검증으로 trigger 전제 재설계."},
    {"id": "dep_3", "ref": "claude-code-guide verify (statusline.md / hooks.md / how-claude-code-works.md, v2.1.132+, 2026-05-25)", "purpose": "컨텍스트 % 신호 채널 권위 확인 — statusline stdin only (hook/모델 직접 부재)."},
    {"id": "dep_4", "ref": "claude/statusline/statusline.sh (현 stdin 무시 + 'Python 의존 없음' 제약)", "purpose": "계기판 반쪽의 수정 대상 + bash JSON 파싱 제약 source."}
  ]
}
```

### Narrative

본 milestone 은 candidate_draft `stage-completion-context-clear-recommendation` 를 채택하되, OPEN 직전 **전제 검증**으로 재설계한 결과다. 원안은 "Claude 가 stage 완료 시 컨텍스트 % 를 자가추정해 40% 넘으면 `/clear` 권장"이었으나 — 검증 결과 **세션 안 모델은 자기 컨텍스트 % 를 직접 읽지 못하고, hook 도 컨텍스트 데이터를 받지 못한다** (claude-code-guide verify). 즉 "연료 게이지 없이 연료 절반 규칙"이었다.

그러나 **statusline stdin JSON 에는 `context_window.used_percentage` 가 실재** (v2.1.132+). 게이지는 statusline(계기판)에만 들어오고 운전자(모델)는 주행 중 못 본다. 이 사실이 mechanism 을 **2 반쪽**으로 가른다:

- **계기판 (sc_1)**: `statusline.sh` 가 stdin 의 `used_percentage` 를 읽어 표시 + 임계 경고 마커 — 사용자가 보는 진짜 게이지. **gate 확장** (결정 [A]) — 현 statusline.sh 는 `.harness.toml` 부재 시 즉시 exit 하여 harness-meta repo (manifest 부재) 세션에선 게이지가 0 이었다. version-track hook 처럼 harness-meta repo marker 를 gate 에 추가해 사용자 본인 세션에도 표시.
- **carry-over + 권고 (sc_2/sc_3)**: stage 완료라는 **결정적 trigger** 에서 carry-over 요약 블록 제시 + "계기판이 높으면 `/clear` 고려" 권고 — % 자가추정 불요. **범위 좁힘** (결정 [C/F], 검토 D) — milestone 진행 상태는 이미 MILESTONE.md/ROADMAP 디스크에 남으므로, carry-over 는 **아직 디스크에 안 쓴 in-flight 상태** (진행 중 결정·대기 질문·다음 행동) 만 담아 중복 회피.

**두 반쪽 결합 정당성** (검토 F) — 느슨한 묶음이 아니라 **'게이지 보고 → 안전하게 리셋' 한 loop**: 게이지가 WHEN (컨텍스트 높음) 을 알리고, carry-over + /clear 가 HOW (상태 잃지 않고 리셋) 를 제공. 둘 다 § 7.1 컨텍스트 효율 면.

**검증 비대칭 솔직 명시** (검토 C, sc_4) — 계기판 반쪽은 stdin JSON fixture 로 smoke 검증 가능하나, carry-over 반쪽은 행동 지침이라 **자기회고 검증 불가** (memory: skill body observer limit 동류). schema 존재 + 수동 1회 확인까지만 — VERIFY 에 이 한계를 숨기지 않는다.

본 milestone 은 동시에 **v7.0 6 mechanism 의 첫 dogfood** — Stage C (RESEARCH Explore 병렬) / Stage D (design-review N+가변) / Stage I (next_candidates 절제) 가 진행 자체에서 첫 실 trigger 된다 (sc_5 회고 대상, deliverable 아닌 관찰).

## RESEARCH

### Spec

```json
{
  "external": [
    {
      "id": "ext_1",
      "source": "context7 /websites/code_claude — statusline.md 'Full JSON Schema for Status Line Command Input'",
      "finding": "statusline stdin JSON 안 context_window 객체 실재 확정 — { total_input_tokens, total_output_tokens, context_window_size, used_percentage, remaining_percentage, current_usage{...} }. used_percentage 는 정수 (예: 8). 상위 형제 필드로 exceeds_200k_tokens(boolean) + model{id,display_name} + version(예 '2.1.90'). INTENT 전제 (sc_1) 직접 확정 — 게이지 source 채널 실재."
    },
    {
      "id": "ext_2",
      "source": "context7 /websites/code_claude — statusline.md 'Context window fields' 단락",
      "finding": "context_window 객체 = '가장 최근 API 응답의 live context window'. As of v2.1.132 total_input_tokens/total_output_tokens 가 cumulative session total 이 아닌 current context usage 반영. **'첫 API 응답 전에는 둘 다 0'** — 즉 세션 극초기 또는 context_window 필드 부재(<v2.1.132) 시 graceful 처리 필요 (sc_1 회귀 0 요건 직접 근거). dep_3 의 v2.1.132+ 권위 확정."
    },
    {
      "id": "ext_3",
      "source": "context7 /websites/code_claude — statusline.md bash 예제 ('Display Context Window Usage with Progress Bar' / 'Multi-line status display')",
      "finding": "공식 bash 예제 3종 모두 `jq -r '.context_window.used_percentage // 0'` 로 파싱 + `PCT >= 90 RED / >= 70 YELLOW / else GREEN` 임계 색상 패턴 제시. **그러나 jq 는 외부 binary 의존** — statusline.sh L2 'bash-only, Python 의존 없음' 제약과 정합하나 jq 가용성은 별개 (Windows git-bash 환경 미보장). 임계 마커 색상 패턴은 그대로 차용 가능."
    },
    {
      "id": "ext_4",
      "source": "claude-code-guide verify (hooks.md / how-claude-code-works.md, dep_3 정합) + 본 milestone INTENT oos_2/oos_3",
      "finding": "컨텍스트 % 신호 채널은 statusline stdin 단일 — hook event 는 context_window 데이터 미수신 (SessionStart hook stdin schema 에 부재, 아래 cb_3 codebase 확인 정합), 세션 안 모델도 자기 % 직접 read 불가. auto-compaction 내부 임계값 비공개. → carry-over trigger 는 % 가 아닌 'stage 완료' 결정적 신호여야 함 (재설계 근거 확정)."
    }
  ],
  "codebase": [
    {
      "id": "cb_1",
      "ref": "claude/statusline/statusline.sh:2, :21-24, :27-35",
      "finding": "현 statusline.sh = (L2) 'bash-only. Python 의존 없음' 명시, (L21-24) MANIFEST(.harness.toml) 부재 시 즉시 exit 0 silent no-op, (L27-35) _extract() = grep+sed 로 TOML flat key 추출 (JSON 파서 부재). stdin 을 전혀 읽지 않음 — 계기판 반쪽은 stdin 읽기 + 중첩 JSON 필드 파싱 신규 추가 필요. harness-meta repo 는 .harness.toml 부재 → 현재 게이지 0 (sc_1 gate 확장 동기 확정)."
    },
    {
      "id": "cb_2",
      "ref": "claude/hooks/session-start-version-track.sh:20, :23",
      "finding": "version-track hook 의 harness-meta repo marker = (L20) `projects/meta/claude-code-version-log.md` 파일 존재, (L23) 부재 시 '{}' exit 0. statusline 의 .harness.toml gate 와 marker 가 다름 — 직접 재사용 불가하나 '특정 marker 파일 존재 → 활성' 패턴은 동형. gate 확장 = .harness.toml OR harness-meta marker 합집합 (sc_1 결정 [A] 구현 후보)."
    },
    {
      "id": "cb_3",
      "ref": "claude/hooks/session-init.sh:16 + session-start-version-track.sh (책임 주석)",
      "finding": "SessionStart hook 2종 (session-init = .harness.toml gate, version-track = marker gate) 모두 additionalContext JSON 주입 책임만 — context_window 데이터 미수신·미취급. ext_4 의 'hook 은 context % 채널 아님' codebase 측 확정. carry-over 를 hook 으로 자동화할 mechanism 부재 (oos_1 근거)."
    },
    {
      "id": "cb_4",
      "ref": "tests/integration/test-statusline-timeout.sh:26-78 + tests/fixtures/statusline-cmd/.harness.toml",
      "finding": "현 statusline smoke = fixture .harness.toml 파일 주입 방식 (stdin JSON 주입 부재). 계기판 반쪽 smoke (sc_4) 는 신규 패턴 필요 — stdin 으로 context_window JSON fixture 를 echo·pipe → 출력 assert. 기존 T1~T4 (fallback/cmd/timeout/no-op) 와 병존하는 신규 테스트 case 추가 형태."
    },
    {
      "id": "cb_5",
      "ref": "claude/CLAUDE.md (statusLine 등록 narrative) + agents/environment-auditor.md C2/C3",
      "finding": "statusLine 등록 = ~/.claude/settings.json 안 `statusLine:{type:'command',command:'...statusline.sh'}` (Plugin manifest 외 mechanism, 수동 1줄). 본 milestone 은 이 등록 메커니즘 불변 (oos_4) — statusline.sh 내부만 수정. environment-auditor C2/C3 가 등록 형식 검증 중."
    },
    {
      "id": "cb_6",
      "ref": "CLAUDE.md (root, 진입 narrative) + skills/stage-*/SKILL.md (9 stage forcing function) + claude/commands/harness-meta.md",
      "finding": "carry-over narrative 거주 후보 3곳 (sc_3): (a) root CLAUDE.md = 진입+CRITICAL 규칙 거주, 운영 원칙이라 부분 정합 / (b) stage skill = 각 stage 완료 forcing function 으로 timing 정합 높으나 'carry-over 는 단일 stage 아닌 stage 완료 일반' 이라 어느 skill 인지 모호 / (c) harness-meta.md = 세션 진입(start) 시점이라 stage 완료(close) timing 미스매치 = 낮음. DESIGN 결정 대상."
    }
  ],
  "options": [
    {
      "id": "opt_1",
      "label": "[채택 확정 — 배포용 fleet 전제] 중첩 JSON 파싱 = bash-native grep/sed (jq 비의존)",
      "rationale": "결정 근거 = statusline.sh 는 plugin 안 배포되는 글로벌 default (claude/CLAUDE.md) → fleet 전 소비자가 동일 스크립트 사용. (1) Git Bash (claude/CLAUDE.md CRITICAL: hook+statusline 모두 Windows Git Bash 의존) 는 jq 미동봉 → sc_1 표적 환경(사용자 본인 포함)에 jq 부재 실재 = 회귀 0 위반 위험. (2) 추출 대상은 used_percentage 정수 1개뿐 — 공식 docs 가 jq 쓰는 이유(다필드 추출)와 무관, grep -oE 단일 추출로 견고히 가능. (3) jq 채택해도 jq-부재 fallback=grep 경로 필요 → 이중 경로 회피. 폐기 = jq 의존 (배포 회귀 risk) + jq/grep 이중 경로 (복잡도). 단 risk_2 (키 중복) 회피 = bounded-substring 설계 필수 (아래)."
    },
    {
      "id": "opt_2",
      "label": "[채택 후보] gate 확장 = .harness.toml OR harness-meta marker 합집합",
      "rationale": "cb_2 의 version-track marker 패턴 차용 — .harness.toml 부재라도 projects/meta/ 또는 동류 marker 존재 시 활성. 사용자 본인 harness-meta 세션에도 게이지 표시 (sc_1 결정 [A]). 폐기 대안 = .harness.toml 단일 gate 유지 (harness-meta 세션 게이지 0 잔존, INTENT 동기 미달)."
    },
    {
      "id": "opt_3",
      "label": "[DESIGN 결정 — CLAUDE.md 우세] carry-over narrative 거주 = CLAUDE.md(always-loaded) vs stage skill(invoke-시-로드) vs command",
      "rationale": "cb_6 3 후보 재평가 — **결정적 사실 = CLAUDE.md 는 항상 컨텍스트 로드, stage skill 은 해당 skill 호출 시에만 로드**. carry-over 권고가 *모든* stage 경계(skill 명시 호출 없는 완료 포함)에서 작동하려면 always-loaded CLAUDE.md 가 stage skill 보다 신뢰성 높다 (stage skill = '그 방 들어갈 때만 켜지는 전등', 복도=모든 경계 미커버). command 후보는 세션 진입(start) 시점이라 stage 완료(close) timing 미스매치 = 최약. → CLAUDE.md 거주 + 1차 source ARCHITECTURE § 7.1 (컨텍스트 효율) 거명 우세, DESIGN d_X 단일 확정 (sc_3). .claude/rules/ 는 path-scoped mechanical rule 전용이라 cross-stage 행동 규약엔 부적합 (v7.0 T1.1 3-way 직교 정합)."
    },
    {
      "id": "opt_4",
      "label": "[채택] 게이지 표기 = raw used_percentage + context_window_size 라벨 (정규화 합성 미산출)",
      "rationale": "ext_1 의 context_window_size 로 1M vs 200k window 구분 가능 — used_percentage 는 이미 window 상대값이라 모델 무관 정직. oos_5 정합 (1M↔200k 단일 합성 수치 미산출). 임계 마커는 ext_3 의 70/90 색상 패턴 차용."
    }
  ],
  "risks_identified": [
    {
      "id": "risk_1",
      "description": "구버전 Claude Code (<v2.1.132, context_window 필드 부재) 또는 첫 API 응답 전 (ext_2: used_percentage 0/null) 또는 stdin 부재 시 게이지가 깨지거나 오표시 (sc_1 회귀 0 위반). 특히 '부재' 를 '0%' 로 표시하면 — 컨텍스트를 모르는 상태를 '거의 안 씀' 으로 오인시켜 거짓 안심 유발.",
      "mitigation": "present-but-0 vs absent **구분** — context_window 필드 자체 부재(또는 stdin 부재) 시 게이지 **전체 생략** (출력에 게이지 토큰 미추가, '0%' 표시 금지). 필드 존재 + 값 0/null (첫 응답 전) 도 동일하게 생략(또는 명시적 '—') 처리. 즉 `// 0` 산술 fallback 이 아니라 '필드 추출 실패 → 빈 문자열 분기'. DESIGN risk_mitigation 매핑 + cb_4 smoke 에 '필드 부재 fixture → 게이지 미출력' + 'used_percentage 존재 fixture → N% 출력' 두 case 대비."
    },
    {
      "id": "risk_2",
      "description": "JSON 안 used_percentage 키 중복 — context_window.used_percentage 외 rate_limits.five_hour.used_percentage / seven_day.used_percentage 도 존재 (ext_1 schema). naive `grep used_percentage` 는 오매칭 가능 (rate_limit 값을 context % 로 표시).",
      "mitigation": "**bounded-substring 한정** — `\"context_window\"` 다음부터 그 객체 경계(`\"current_usage\"` 또는 `\"exceeds_200k_tokens\"` 출현 전)까지 구간을 먼저 잘라낸 뒤 그 안에서만 used_percentage 매칭. ⚠ '첫 출현 한정'(schema 순서 의존)은 **불채택** — JSON 키 직렬화 순서는 보장되지 않아 Claude Code 가 순서 바꾸면 rate_limit 값 오매칭 (부실). bounded-substring 은 키 순서 무관하게 context_window 객체 안으로 범위 가둠. DESIGN 에서 정확 regex 확정 + smoke 로 rate_limit 동시 존재 fixture 의 context_window 값만 추출됨 assert."
    },
    {
      "id": "risk_3",
      "description": "carry-over 반쪽 검증 비대칭 (sc_4) — 행동 지침이라 '실제로 stage 완료 시 carry-over 가 제시됐는지' 자기회고 검증 불가 (memory: skill body observer limit 동류).",
      "mitigation": "VERIFY 에 비대칭 솔직 명시 — 계기판은 smoke PASS (stdin fixture assert), carry-over 는 schema 존재 + 수동 1회 확인까지만. 과잉 검증 주장 금지."
    },
    {
      "id": "risk_4",
      "description": "gate 확장 (opt_2) 이 의도치 않은 repo 에서도 게이지 활성화 — marker 패턴이 너무 넓으면 harness-meta 외 repo 오활성.",
      "mitigation": "marker = harness-meta 고유 경로 (projects/meta/ 또는 cb_2 의 claude-code-version-log.md 동류) 로 한정 — version-track hook 과 동일 specificity. DESIGN d_X 에서 정확 marker 확정."
    }
  ]
}
```

### Narrative

조사는 v7.0 RESEARCH Explore 병렬 mechanism 첫 dogfood 로 진행 — codebase 2 stream (statusline 내부 / hook gate·carry-over 거주) 을 병렬 Explore fan-out + 외부 1차 source (context7 statusline.md) 를 동시 query 했다 (sc_5 회고 대상).

**핵심 확정**: INTENT 전제가 외부 1차 source 로 직접 확정됐다 (ext_1) — statusline stdin JSON 안 `context_window.used_percentage` 가 실재하며, `exceeds_200k_tokens` / `context_window_size` 로 window 종류까지 구분된다. 계기판 반쪽은 실현 가능하다. ext_4 + cb_3 가 "hook·모델은 context % 채널이 아니다"를 codebase·docs 양면에서 확정 — carry-over 를 stage 완료 trigger 에 묶는 재설계가 정당하다.

**새로 드러난 risk 2건** — 둘 다 **context7 외부 query (ext_1/ext_2) 에서 표면화** (코드베이스 Explore 병렬이 찾은 게 아님 — sc_5 회고 정직성): (risk_2) JSON 안 `used_percentage` 키가 `context_window` 와 `rate_limits` 양쪽에 중복 존재해 naive grep 이 오매칭할 수 있다 → bounded-substring 으로 context_window 객체 경계 안에 범위를 가둔다 (키 순서 무보장이라 '첫 출현' 의존은 불채택). (risk_1) 첫 API 응답 전 / 구버전엔 필드가 0·부재인데, 이를 '0%' 로 표시하면 거짓 안심을 주므로 **부재 시 게이지 자체를 생략**한다 (`// 0` 산술 fallback 아님). 둘 다 DESIGN risk_mitigation + cb_4 smoke fixture 로 직접 흡수한다.

**채택/폐기 결정** — opt_1 (bash-native grep, jq 비의존) **채택 확정 (배포용 fleet 전제)**: statusline.sh 는 plugin 안 배포되는 글로벌 default 라 fleet 전 소비자가 동일 스크립트를 쓰는데, Git Bash (Windows 의존 환경, sc_1 표적) 는 jq 미동봉이라 jq 의존 시 게이지가 일부 환경에서 조용히 죽는다 (회귀 0 위반). 추출 대상이 정수 1개뿐이라 grep 단일 추출로 견고히 가능 — risk_2 bounded-substring 만 전제. opt_2 (gate 확장 = .harness.toml OR harness-meta marker) 채택 후보: cb_2 version-track marker 패턴 차용. opt_4 (raw used_percentage + window 라벨, 정규화 합성 미산출) 채택, oos_5 정합. opt_3 (carry-over 거주) 재평가 — **always-loaded 인 CLAUDE.md 가 invoke-시-로드 인 stage skill 보다 모든 stage 경계 커버에 신뢰성 높아 우세** (§ 7.1 거명), DESIGN d_X 단일 확정 대상 (sc_3). 한편 **병렬 dogfood 의 실 이득은 risk 발견이 아니라 벽시계 단축 + statusline.sh 를 직접 안 읽어 메인 컨텍스트가 가벼웠던 것** (§ 7.1 컨텍스트 효율 면 그 자체) — sc_5 REPORT 정직 회고 대상.

## DESIGN

### Spec

```json
{
  "decisions": [
    {
      "id": "d_1",
      "decision": "statusline.sh 구조 = stdin 을 스크립트 **최상단에서 1회 읽어** 변수 저장 (input=\"$(cat)\") → gate 판정 (d_2) → 게이지 조립 (d_3) → 기존 statusline_cmd / fallback 로직. stdin 은 1회만 소비 가능하므로 gate exit 분기보다 위에 위치해야 한다 (현 L18-24 는 manifest 부재 시 stdin 미독·즉시 exit — 게이지 불가). context_window.used_percentage 추출 = bash-native grep/sed (jq 비의존, opt_1) + **anchored-first-match** (risk_2, design-review spec-drift comment 흡수): `\"context_window\"` 출현 위치부터 입력 끝까지를 substring 으로 자른 뒤 그 안에서 **첫 `used_percentage` 정수** 매칭. 경계 *끝* 마커 (current_usage/exceeds_200k_tokens) 는 **불채택** — 키 순서 무보장 (risk_2 인정 전제) 하에서 used_percentage 가 current_usage 보다 뒤로 직렬화되면 끝-마커가 잘못 잘라낸다 (self-tension). 견고 근거 = current_usage 객체 안엔 used_percentage 부재 (토큰 카운트만, ext_1 schema) → context_window 출현 직후 첫 used_percentage 는 반드시 context_window 소속. rate_limits.*.used_percentage 는 rate_limits 가 context_window 뒤일 때만 substring 에 포함되며 그 경우에도 context_window.used_percentage 가 먼저 출현, rate_limits 가 앞이면 substring 진입 전 (양 순서 모두 안전).",
      "rationale": "opt_1 (채택 확정) + risk_2 mitigation + design-review spec-drift comment 흡수 (경계 끝-마커 self-tension → anchored-first-match 로 단순화). 'DESIGN 신규 발견' — RESEARCH 는 파싱 method 만 정했고 stdin 읽기 순서는 미명시. 현 statusline.sh 가 stdin 무시 + gate-우선-exit 구조라 stdin 을 gate 위로 올리는 재배치가 계기판 반쪽의 전제."
    },
    {
      "id": "d_2",
      "decision": "gate 확장 = `.harness.toml` 존재 **OR** harness-meta repo marker `projects/meta/claude-code-version-log.md` 존재 (둘 다 부재 시에만 게이지 생략·현행 no-op 유지). marker = version-track hook (session-start-version-track.sh:20) 과 **동일 파일** 채택 — version-track 과 specificity 일치 (risk_4) + projects/meta/ 디렉토리 단독 (너무 넓음) 회피. 단 기존 .harness.toml 경로 (statusline_cmd / minimal fallback) 동작은 **완전 불변** — marker gate 는 게이지 출력 자격만 추가, statusline_cmd 실행 로직 미접촉.",
      "rationale": "opt_2 채택 + risk_4 mitigation + cb_2 version-track marker 패턴 차용. claude-code-version-log.md 는 실재 확인 (harness-meta repo marker). harness-meta 세션 (manifest 부재) 게이지 0 → 표시 전환 (sc_1 결정 [A])."
    },
    {
      "id": "d_3",
      "decision": "게이지 표기 = `[ctx N%]` 형식 (raw used_percentage 정수 + % + 임계 마커, opt_4). 임계 마커 = used_percentage ≥ 90 위험 / ≥ 70 주의 / else 평상 (ext_3 의 70/90 패턴 차용, 색상 ANSI 대신 텍스트 마커 — statusline 단순성). **필드 부재·stdin 부재·값 비정수 시 게이지 토큰 전체 생략** ('0%' 표시 금지, risk_1) — `// 0` 산술 fallback 아닌 '추출 실패 → 빈 문자열 분기'. window size 정규화 합성값 미산출 (oos_5).",
      "rationale": "opt_4 채택 + risk_1 mitigation. used_percentage 는 이미 window 상대값이라 1M/200k 무관 정직. 부재를 0% 로 오표시하면 거짓 안심 (risk_1) → 생략."
    },
    {
      "id": "d_4",
      "decision": "게이지 ↔ 기존 출력 결합 = 게이지 문자열을 **prefix** 로 붙임. (a) .harness.toml 활성 + statusline_cmd → `{게이지}{cmd출력}` / (b) .harness.toml 활성 + cmd 부재 → `{게이지}[harness] {name}` / (c) marker-only (harness-meta 세션) → `{게이지}` 단독 (게이지 부재 시 빈 출력 = 현행 no-op 보존). 게이지 생략 시 (b)/(a) 는 기존 출력 그대로 = 회귀 0.",
      "rationale": "marker-only 경로엔 statusline_cmd 가 없어 게이지만 단독 출력. d_3 생략 분기가 모든 경로에서 '게이지 부재 → 기존 동작' 을 보장 (회귀 0, sc_1)."
    },
    {
      "id": "d_5",
      "decision": "carry-over 블록 + /clear 권고 narrative 단일 source = **root CLAUDE.md** (always-loaded). ARCHITECTURE § 7.1 (컨텍스트 효율 면) 에는 본 mechanism 1줄 등재 + '1차 source = CLAUDE.md' pointer 만 (정의 중복 회피). .claude/rules/ 부적합 (path-scoped mechanical rule 전용, cross-stage 행동 규약 아님 — v7.0 T1.1 3-way 직교).",
      "rationale": "opt_3 (always-loaded 우세) 확정 + sc_3. stage skill 은 invoke-시-로드라 '복도(모든 stage 경계)' 미커버. CLAUDE.md 거주로 토큰 비용 발생하나 (메모리 token-efficiency 충돌) → 블록 schema + 1줄 권고로 최소화 (d_6)."
    },
    {
      "id": "d_6",
      "decision": "carry-over 블록 schema (sc_2) = **디스크 미기록 in-flight 상태만** 4 항목: (1) 진행 중 결정 (아직 MILESTONE.md 에 안 쓴) / (2) 대기 중 질문 (사용자 게이트 pending) / (3) 다음 행동 (immediate next step) / (4) /clear 권고 1줄 ('계기판 [ctx N%] 가 높으면 본 블록 복사 후 /clear 고려'). MILESTONE.md/ROADMAP 디스크 산출물과 중복되는 항목 (완료 stage 요약 등) 명시 제외. always-loaded 부담 최소 위해 schema 자체를 짧게 유지.",
      "rationale": "sc_2 범위 좁힘 (검토 D, 결정 [C/F]) + d_5 토큰 최소화 정합. 디스크 중복 회피 = carry-over 의 유일 가치 (in-flight 상태 보존)."
    },
    {
      "id": "d_7",
      "decision": "검증 비대칭 솔직 명시 (sc_4) — 계기판 (phase-1) 은 smoke PASS (stdin JSON fixture → 출력 assert), carry-over (phase-2) 는 schema 존재 + 수동 1회 확인까지만 (자기회고 검증 불가, 과잉 검증 주장 금지). **추가 신규 smoke 의무** — stdin `cat` hang 회피 위해 기존 test-statusline-timeout.sh T1~T4 를 stdin redirect (`</dev/null` 또는 fixture JSON pipe) 형태로 갱신 + 신규 게이지 case (T5~T7) 추가.",
      "rationale": "sc_4 + risk_3 + 'DESIGN 신규 발견' (stdin hang). 기존 smoke 는 stdin redirect 부재 → input=$(cat) 추가 시 EOF 대기 hang. production 은 Claude Code 가 항상 JSON stdin 제공하나 smoke 는 명시 redirect 필요 = 회귀 0 전제."
    }
  ],
  "approach": "2 phase 분할 (계기판 / carry-over) = INTENT 2 반쪽 1:1. phase-1 (계기판) 먼저 — smoke 검증 가능한 절반이라 회귀 0 을 코드로 확정한 뒤 phase-2 (행동 지침, 검증 비대칭) 진행. phase-1 = statusline.sh 재구조화 (stdin 최상단 1회 읽기 → gate 확장 → 게이지 조립, d_1~d_4) + smoke 갱신 (d_7). phase-2 = root CLAUDE.md carry-over 블록 schema + /clear 권고 narrative (d_5/d_6) + ARCHITECTURE § 7.1 1줄 등재 (cascade host = CLAUDE.md 단일, § 7.1 은 pointer — cascade marker 신규 부재, 단방향 pointer). cascade 정합: 본 milestone 은 신규 cascade marker 를 만들지 않음 (carry-over 단일 source = CLAUDE.md, § 7.1 은 narrative pointer only → cascade_sync 대상 아님).",
  "phases": [
    {
      "phase": "phase-1",
      "scope": "계기판 — statusline.sh 재구조화: (1) stdin 최상단 1회 읽기 input=$(cat) (d_1) (2) used_percentage bounded-substring 추출 (d_1, risk_2) (3) gate 확장 .harness.toml OR claude-code-version-log.md marker (d_2) (4) 게이지 `[ctx N%]` + 70/90 임계 마커 조립, 부재 시 생략 (d_3, risk_1) (5) 게이지 prefix 결합 3 경로 (d_4).",
      "deliverable": "claude/statusline/statusline.sh (수정) + tests/integration/test-statusline-timeout.sh (T1~T4 stdin redirect 갱신 + T5~T7 게이지 case 추가) + tests/fixtures/ 신규 stdin JSON fixture (context_window 존재 / 부재 / rate_limit 중복 동시).",
      "verification": "bash tests/integration/test-statusline-timeout.sh (T1~T8 PASS) — T5: context_window.used_percentage=8 fixture → '[ctx 8%]' prefix 출력 / T6: 필드 부재 fixture → 게이지 미출력 (기존 동작) / T7: rate_limits.used_percentage 동시 존재 fixture → context_window 값만 추출 / T8: used_percentage 가 current_usage 뒤 + rate_limits 가 context_window 앞 fixture → 여전히 정확 추출 (anchored-first-match 키 순서 변동 회귀, design-review comment 흡수). 전체 smoke (bash tests/run-all.sh 또는 동치) PASS."
    },
    {
      "phase": "phase-2",
      "scope": "carry-over + 권고 — root CLAUDE.md 안 carry-over 블록 schema (in-flight 4 항목, d_6) + stage 완료 시 제시 행동 규약 + /clear 권고 narrative (d_5). ARCHITECTURE § 7.1 안 본 mechanism 1줄 등재 + '1차 source CLAUDE.md' pointer.",
      "deliverable": "CLAUDE.md (root, carry-over 섹션 신규) + projects/meta/ARCHITECTURE.md § 7.1 (1줄 등재 + pointer).",
      "verification": "schema 존재 확인 (grep) + smoke 전체 PASS (회귀 0). 행동 작동 = 자기회고 검증 불가 (d_7 비대칭) → 수동 1회 확인 (본 milestone REPORT 작성 시 carry-over 블록 실제 제시 여부 관찰). **always-loaded 추가 토큰 폭 1회 측정·기록** (design-review cascade-narrative comment 흡수, d_5 token-efficiency trade-off 정직 노출 — CLAUDE.md carry-over 섹션 추가 전후 라인/토큰 delta)."
    }
  ],
  "risk_mitigation": [
    {
      "risk_ref": "risk_1",
      "decision_ref": "d_3",
      "method": "present-but-0 vs absent 구분 — context_window 필드 부재·stdin 부재·값 비정수 시 게이지 토큰 전체 생략 (빈 문자열 분기, '0%' 금지). phase-1 smoke T6 (필드 부재 → 미출력) + T5 (존재 → N% 출력) 두 case 직접 assert."
    },
    {
      "risk_ref": "risk_2",
      "decision_ref": "d_1",
      "method": "anchored-first-match (design-review spec-drift comment 후 정정) — \"context_window\" 출현부터 입력 끝까지 substring 자른 뒤 첫 used_percentage 매칭. **경계 끝-마커 (current_usage/exceeds_200k_tokens) 불채택** — 키 순서 무보장 하에서 used_percentage 가 current_usage 뒤면 끝-마커가 오절단 (self-tension). 견고 근거 = current_usage 안 used_percentage 부재. phase-1 smoke = T7 (rate_limits.used_percentage 동시 존재 → context_window 값만) + T8 (used_percentage 가 current_usage 뒤 + rate_limits 가 context_window 앞 fixture → 여전히 정확 추출, 키 순서 변동 회귀) 양쪽 assert."
    },
    {
      "risk_ref": "risk_3",
      "decision_ref": "d_7",
      "method": "VERIFY 비대칭 솔직 — 계기판 smoke PASS / carry-over schema 존재 + 수동 1회. 과잉 검증 주장 금지 (memory: skill body observer limit 동류)."
    },
    {
      "risk_ref": "risk_4",
      "decision_ref": "d_2",
      "method": "marker = claude-code-version-log.md (version-track hook 과 동일 파일·specificity). projects/meta/ 디렉토리 단독 (너무 넓음) 불채택 — harness-meta 외 repo 오활성 차단."
    },
    {
      "risk_ref": "risk_5",
      "decision_ref": "d_7",
      "method": "[DESIGN 신규 발견] stdin cat hang — 기존 smoke 가 stdin redirect 부재라 input=$(cat) 추가 시 EOF 대기 hang. 기존 T1~T4 를 stdin redirect (</dev/null 또는 fixture pipe) 로 갱신. production 은 Claude Code 가 항상 JSON stdin 제공 (statusline.md) 이라 무관 — smoke 환경 전용 mitigation."
    }
  ],
  "five_perspective_review": {
    "method": "design-review subagent (v7.0 T1.3 N+가변, 첫 dogfood) — scope 작음(≤5 파일: statusline.sh / test / fixture / CLAUDE.md / ARCHITECTURE) → 검토 관점 4 (§ 11.2 작음 매트릭스 3~5). AskUserQuestion 게이트 후 4 관점 invoke. **단 design-review subagent 가 현 plugin cache 에 reload 안 됨 (사용 가능 목록 부재, version-tracker 동반 누락) → general-purpose agent 로 design-review mechanism (1 invoke 안 N분야 순차 통합 + read-only + 2묶음 산출) 모사 invoke. '설치≠사용' 분리 실 사례 (v7.0 lesson) — sc_5 REPORT 회고 input.",
    "perspectives": [
      {
        "perspective": "spec-drift",
        "verdict": "pass-with-comments",
        "comments": "stdin JSON schema 인용(ext_1~ext_3) ↔ d_1/d_3/d_4 정합 + risk_1(<v2.1.132 필드 부재) ↔ d_3 게이지 생략 분기 정확 반영. **comment(흡수 완료)**: bounded-substring 경계 끝-마커(current_usage/exceeds_200k_tokens) 가 키 순서 무보장(risk_2 인정 전제) 하에서 used_percentage 가 current_usage 뒤면 오절단 = self-tension → d_1/risk_2 를 anchored-first-match (context_window 출현 후 첫 used_percentage, current_usage 안 used_percentage 부재 근거) 로 정정 + smoke T8(키 순서 변동 fixture) 추가."
      },
      {
        "perspective": "regression",
        "verdict": "PASS",
        "comments": "기존 T1~T4(test-statusline-timeout.sh:36,44,53,71) 모두 stdin redirect 없이 호출 직접 확인 → input=$(cat) 추가 시 hang = risk_5 정확 포착 + d_7 갱신 의무 충분. marker 재사용(d_2) ↔ version-track hook gate(session-start-version-track.sh:20) = 동일 파일 읽기만, hook 은 write 안 함(L9 주석) → race·중복 0. marker(claude-code-version-log.md) Glob 실재 확인."
      },
      {
        "perspective": "scope-contract",
        "verdict": "PASS",
        "comments": "sc_1→d_1~d_4+phase-1 / sc_2→d_6 / sc_3→d_5 / sc_4→d_7+risk_3 / sc_5→REPORT 관찰(stage 적절, phase 매핑 불요) — 누락 sc 0. oos_5(정규화 미산출)→d_3 / oos_4(등록 mechanism 불변)→phase-1 'statusline.sh 내부만' / oos_1~3 침범 0. out_of_scope 침범 0 확인."
      },
      {
        "perspective": "cascade-narrative",
        "verdict": "PASS",
        "comments": "carry-over 단일 source=CLAUDE.md(d_5) ↔ § 7.1 pointer 정합. 신규 cascade marker 부재 = § 7.3 stage skill 선례(단방향 narrative pointer, cascade marker 부재 자연) 와 동형 → 옳음(cascade marker 는 양방향 정의 중복 drift 차단용). 3-way 직교(§ 9): carry-over=cross-stage 행동 규약 → always-loaded CLAUDE.md 적합 / path-scoped .claude/rules/ 부적합 = § 9 정의 정확 정합. **comment(d_7 흡수)**: always-loaded 토큰 비용은 d_5 자인 + d_6 schema 최소화 완화, VERIFY 에서 추가 토큰 폭 1회 측정 권고."
      }
    ]
  }
}
```

### Narrative

DESIGN 은 RESEARCH 의 충실한 options/risks 를 decisions 7건으로 정식화하되, **RESEARCH 에 안 잡힌 구현 순서 신규 발견 2건** 을 흡수했다: (1) stdin 1회 읽기 순서 — 현 statusline.sh 가 manifest 부재 시 stdin 미독·즉시 exit 구조라, stdin 을 최상단으로 올려야 게이지가 성립 (d_1). (2) stdin cat hang — 기존 smoke 가 stdin redirect 부재라 input=$(cat) 추가 시 hang → 기존 T1~T4 갱신 의무 (d_7, risk_5 신규).

**decisions ↔ risks ↔ sc 매핑**: d_1(opt_1+risk_2, sc_1) / d_2(opt_2+risk_4, sc_1) / d_3(opt_4+risk_1, sc_1) / d_4(결합 경로, sc_1) — 계기판 4 decision 이 sc_1 커버. d_5(opt_3, sc_3) / d_6(sc_2) — carry-over 2 decision. d_7(sc_4+risk_3+risk_5) — 검증 비대칭. risk_mitigation 5건 (risk_1~4 RESEARCH + risk_5 DESIGN 신규) 모두 decision_ref 매핑 + phase-1 smoke 직접 assert (risk_5 제외 — smoke 환경 자체 mitigation).

**cascade host**: 본 milestone 은 **신규 cascade marker 부재**. carry-over 단일 source = root CLAUDE.md (d_5), ARCHITECTURE § 7.1 은 narrative pointer only (정의 중복 회피라 hash-tracked marker 부적합). 따라서 cascade_sync 대상 아님 — VERIFY 에서 cascade_sync --check 는 기존 marker 무변경 PASS 확인까지만.

**5 관점 review (design-review N+가변 첫 dogfood)** — scope 작음(≤5 파일)이라 § 11.2 매트릭스상 4 관점 발현 (spec-drift / regression / scope-contract / cascade-narrative), AskUserQuestion 게이트 통과 후 invoke. **결과 = decisive FAIL 0** (regression / scope-contract / cascade-narrative PASS, spec-drift pass-with-comments). 단 spec-drift 에서 **흡수 가치 comment 1건** — bounded-substring 경계 끝-마커가 risk_2 의 '키 순서 무보장' 전제와 self-tension (used_percentage 가 current_usage 뒤면 오절단) → d_1/risk_2 를 **anchored-first-match** (context_window 출현 후 첫 used_percentage, current_usage 안 used_percentage 부재 근거) 로 정정 + smoke T8 (키 순서 변동 fixture) 추가로 즉시 흡수. cascade-narrative 의 토큰 측정 권고도 d_7 VERIFY 범위에 흡수. scope 외 거명 4건은 ## SCOPE_OUT_NOTES 로 분리 (next_candidates 자동 등재 부재, T1.2 정합).

**design-review N+가변 dogfood 정직 회고 (sc_5 input)** — (1) **mechanism 발현 정상 작동**: 4 관점 자동 발현 → AskUserQuestion 게이트 → invoke 흐름이 § 11 설계대로 진행. (2) **그러나 design-review subagent 자체는 현 세션 invoke 불가** — v7.0 에서 생성(agents/design-review.md 실재)됐으나 plugin cache 미reload 로 사용 가능 목록에서 누락 (version-tracker 동반) → general-purpose 로 mechanism 모사. '설치≠사용' (v7.0 lesson) 의 직접 후속 사례 = subagent 파일 생성 ≠ 현 세션 가용. (3) **실 이득**: review 가 RESEARCH/DESIGN 이 놓친 spec-drift self-tension 1건을 실제로 잡음 (inline self-review 였다면 동일 LLM 관성으로 놓쳤을 가능성) — 별 컨텍스트 분리의 가치.

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "approved_at": "2026-05-25",
    "approval_method": "자연어 명시 승인 ('APPROVE 작성하고 EXECUTE 진행해줘', 2026-05-25) — DESIGN 7 decision + design-review 4 관점 결과 (spec-drift comment anchored-first-match 흡수 완료) 검토 후 EXECUTE 진입 게이트 통과.",
    "scope_confirmed": [
      "d_1~d_4 (계기판 phase-1): stdin 최상단 1회 읽기 → gate 확장 → anchored-first-match 추출 → [ctx N%] prefix 결합, sc_1 커버 승인",
      "d_2 gate marker = claude-code-version-log.md (version-track hook 동일 파일, risk_4 specificity) 승인",
      "d_5/d_6 (carry-over phase-2): root CLAUDE.md always-loaded 단일 source + in-flight 4 항목 schema, sc_2/sc_3 승인",
      "d_7 검증 비대칭 솔직 명시 (계기판 smoke PASS / carry-over schema+수동 1회) + risk_5 stdin hang mitigation 승인",
      "design-review spec-drift comment 흡수 결과 (bounded-substring 끝-마커 → anchored-first-match + smoke T8) 승인",
      "2 phase 순서 (계기판 먼저 = 회귀 0 코드 확정 후 carry-over) 승인"
    ]
  }
}
```

### Narrative

사용자 자연어 명시 승인 ('APPROVE 작성하고 EXECUTE 진행해줘', 2026-05-25) 으로 EXECUTE 진입 게이트 통과 — CLAUDE.md root § 개발 프로세스 '~/harness-meta/ repo 변경은 커밋 전 사용자 확인 필수' 본질 정합. DESIGN 7 decision + design-review 4 관점 (decisive FAIL 0, spec-drift comment 즉시 흡수) 검토 결과를 scope 로 confirm. v7.0 retroactive 정식화와 달리 본 milestone 은 **forward 승인** — EXECUTE phase-1/phase-2 는 본 APPROVE 후 진행, 각 commit 은 별도 사용자 확인 (CLAUDE.md '커밋 전 사용자 확인') 게이트 보존.

## EXECUTE

### Spec

```json
{
  "phases_executed": [
    {"phase": "phase-1", "status": "completed", "deliverable_path": "execute/phase-1.md", "commits": [{"sha": "195ccc1", "message": "feat(meta): v7.1 phase-1 — statusline 컨텍스트 게이지 (계기판 반쪽)"}], "summary": "계기판 — statusline.sh 재구조화 (stdin 최상단 1회 읽기 → gate 확장 .harness.toml OR claude-code-version-log.md marker → context_window.used_percentage anchored-first-match 추출 → [ctx N%] prefix + 70/90 임계 마커, 부재 시 생략) + stdin JSON fixture 4종 + test-statusline-timeout.sh T1~T4 stdin redirect 갱신 + T5~T9 게이지 case (11/11 PASS). entry-title 게이트 정합 위해 v7.1 title ' + ' → 단일 본질 프레임 정정 동반."},
    {"phase": "phase-2", "status": "completed", "deliverable_path": "execute/phase-2.md", "commits": [{"sha": "cc3a149", "message": "feat(meta): v7.1 phase-2 — stage carry-over + /clear 권고 (행동 지침 반쪽)"}], "summary": "carry-over — root CLAUDE.md(always-loaded) 안 carry-over 블록 schema (in-flight 4 항목) + /clear 권고 narrative 단일 source + ARCHITECTURE § 7.1 pointer 1단락. 신규 cascade marker 부재 (§ 7.3 단방향 pointer 선례 동형). always-loaded 토큰 폭 +16 lines/+1119 bytes (≈ +6.4%) 1회 측정 기록."}
  ]
}
```

### Narrative

EXECUTE 는 DESIGN approach 의 2 phase 순서 (계기판 먼저 = smoke 로 회귀 0 확정 후 carry-over) 대로 진행 — 2 commit (195ccc1 / cc3a149). 각 phase 별책 = `execute/phase-{n}.md` (changes / verification / commit trace). 각 commit 전 사용자 명시 확인 게이트 통과 (forward 승인, APPROVE 정합).

phase-1 도중 처리 본질 — pre-commit `smoke-entry-title-guideline` 가 v7.1 title 의 ' + ' (두-본질 P1 마커) 를 차단 → 본 milestone 이 스스로 '2 반쪽 1 mechanism' 으로 정의하므로 단일 본질 ('컨텍스트 효율') 프레임으로 title 정정 (ROADMAP + MILESTONE.md 일관 갱신) 후 재커밋. EXECUTE 중 gate 가 실제로 작동한 사례 (entry-title smoke 도그푸드).

## VERIFY

### Spec

```json
{
  "smoke": {
    "method": "pre-commit 전체 (7 lint/format + 12 smoke hook) + statusline 통합 테스트 (tests/integration/test-statusline-timeout.sh, pre-commit 외)",
    "result": "pre-commit 19 hook 전체 Passed (FAIL=0) + statusline 통합 T1~T9b 11/11 PASS",
    "detail": "pre-commit run --all-files → markdownlint/shellcheck/end-of-files 등 7 + smoke 12 (spec-verification 442/0, entry-title PASS, cascade-drift in-sync, claude-md-drift 13/13 등) 모두 Passed. statusline 통합 = T5 [ctx 8%] / T6 빈 출력 / T7 rate_limit 오매칭 회피 / T8 키 순서 변동 [ctx 42%] / T9a 75%* / T9b 95%!. EXECUTE 중 entry-title FAIL 1건 발생 → title 정정 후 PASS (회귀 0 복구)."
  },
  "criteria_check": [
    {"sc_ref": "sc_1", "verdict": "PASS", "evidence": "계기판 — statusline.sh:0(stdin 1회 읽기)~73(_join) + test-statusline-timeout.sh T5~T9b 11/11 PASS (commit 195ccc1). gate 확장 = harness-meta marker-only 세션 sanity '[ctx 37%]' 직접 확인. used_percentage 우선 + 부재 시 생략 (Python 의존 없음 유지, bash-native grep)."},
    {"sc_ref": "sc_2", "verdict": "PASS", "evidence": "carry-over — CLAUDE.md § 개발 프로세스 안 carry-over 블록 schema (in-flight 4 항목: 진행 중 결정 / 대기 질문 / 다음 행동 / [ctx N%]→/clear) 정전화, grep 'carry-over' 4회 (commit cc3a149). 범위 = 디스크 미기록 in-flight 상태만 (MILESTONE.md/ROADMAP 중복 회피) 명문."},
    {"sc_ref": "sc_3", "verdict": "PASS", "evidence": "정전화 거주 — carry-over 단일 source = root CLAUDE.md (always-loaded, d_5) 확정. ARCHITECTURE § 7.1 = '컨텍스트 효율 면 mechanism (v7.1)' 1단락 pointer only (정의 중복 회피). .claude/rules/ 부적합 (cross-stage 행동 규약, § 9 3-way 직교 정합)."},
    {"sc_ref": "sc_4", "verdict": "PASS", "evidence": "검증 비대칭 명시 — 계기판 smoke 가능 (T5~T9b assert) / carry-over 자기회고 불가 (schema 존재 grep + 수동 1회까지만, risk_3). 본 VERIFY 안 비대칭 솔직 반영 (과잉 검증 주장 0). smoke 전체 PASS (statusline 포함)."},
    {"sc_ref": "sc_5", "verdict": "PASS", "evidence": "v7.0 mechanism 첫 dogfood evidence 관찰 capture 완료 (deliverable 아님) — RESEARCH Explore 병렬 (RESEARCH narrative) + design-review N+가변 4 관점 (DESIGN five_perspective_review, spec-drift comment 실 흡수) + next_candidates 절제 (## SCOPE_OUT_NOTES 거명만, 자동 등재 0). 종합 synthesis = REPORT lessons 흡수 (stage scope 정합)."}
  ],
  "risk_check": [
    {"risk_ref": "risk_1", "mitigation_verdict": "MITIGATED", "evidence": "필드/값 부재 → '0%' 거짓 안심 회피 = 게이지 토큰 전체 생략 (빈 문자열 분기). T6 (context_window 부재 fixture → 빈 출력) assert PASS."},
    {"risk_ref": "risk_2", "mitigation_verdict": "MITIGATED", "evidence": "used_percentage 키 중복 (context_window vs rate_limits) → anchored-first-match (context_window 출현 후 첫 used_percentage, current_usage 안 부재 근거). T7 (rate_limit 50/99 동시 → [ctx 8%]) + T8 (키 순서 변동 → [ctx 42%]) 양쪽 assert PASS."},
    {"risk_ref": "risk_3", "mitigation_verdict": "ACKNOWLEDGED", "evidence": "carry-over 검증 비대칭 (행동 지침 자기회고 불가) — schema 존재 + 수동 1회 확인까지만 한계 솔직 인정 (memory: skill body observer limit 동류). 과잉 검증 주장 금지 정합. fix 아닌 한계 acknowledge."},
    {"risk_ref": "risk_4", "mitigation_verdict": "MITIGATED", "evidence": "gate 확장 과활성 회피 = marker 를 claude-code-version-log.md (version-track hook 동일 파일·specificity) 로 한정. projects/meta/ 디렉토리 단독 (너무 넓음) 불채택. harness-meta 외 repo 미활성 (marker 부재 시 현행 no-op)."},
    {"risk_ref": "risk_5", "mitigation_verdict": "MITIGATED", "evidence": "[DESIGN 신규] stdin cat hang — 기존 T1~T4 를 stdin redirect (</dev/null) 갱신. production 은 Claude Code 가 항상 JSON stdin 제공이라 무관 (smoke 환경 전용). T1~T9b 11/11 hang 없이 완료."}
  ],
  "verdict": "RESOLVED"
}
```

### Narrative

VERIFY verdict = **RESOLVED** — sc 5/5 PASS + risk 5/5 처리 (MITIGATED 4 + ACKNOWLEDGED 1). 계기판 반쪽 (sc_1) 은 statusline 통합 T5~T9b 11/11 + pre-commit 19 hook 전체로 정량 PASS, carry-over 반쪽 (sc_2/sc_3) 은 schema 정전화 + 단일 source 거주로 PASS.

**검증 비대칭 솔직 반영** (sc_4, risk_3) — 본 milestone 의 핵심 정직성은 두 반쪽의 검증 가능성이 다르다는 것을 숨기지 않는 데 있다. 계기판은 stdin JSON fixture 로 assert 가능했으나 (risk_1 T6 / risk_2 T7+T8 직접 흡수), carry-over 는 행동 지침이라 '실제 stage 완료 시 제시됐는지' 자기회고 검증이 불가하다 (risk_3 ACKNOWLEDGED — MITIGATED 아님). schema 존재 (grep 4회) + 수동 1회 확인까지만, 과잉 검증 주장은 하지 않았다.

**EXECUTE 중 gate 작동** — entry-title smoke 가 v7.1 title 의 ' + ' 를 실제로 차단했고 (도그푸드), 단일 본질 프레임 정정 후 회귀 0 복구. risk_5 (stdin hang) 도 T1~T4 redirect 갱신으로 사전 차단됐다. sc_5 (v7.0 6 mechanism 첫 dogfood) 관찰은 capture 완료 — 종합 synthesis 는 REPORT lessons 로 위임 (stage scope 정합).

## REPORT

### Spec

```json
{
  "summary": "컨텍스트 효율 mechanism 2 반쪽 (계기판 + carry-over) 을 설치, verdict RESOLVED. 계기판 = statusline.sh 가 stdin context_window.used_percentage 를 anchored-first-match 로 읽어 [ctx N%] 게이지 prefix 표시 (gate 확장으로 harness-meta 본인 세션에도 활성). carry-over = stage 완료 결정적 trigger 에 디스크 미기록 in-flight 상태 블록 + /clear 권고 (root CLAUDE.md always-loaded 단일 source). 원안 'Claude 가 context % 자가추정' 전제 오류 (모델·hook 은 % 채널 아님) 를 OPEN 직전 검증으로 2 반쪽 재설계한 것이 본 milestone 의 핵심. 동시에 v7.0 6 mechanism 의 첫 dogfood.",
  "delta": {
    "files_created": 6,
    "files_edited": 5,
    "files_created_list": ["tests/fixtures/statusline-stdin/context-present.json", "tests/fixtures/statusline-stdin/context-absent.json", "tests/fixtures/statusline-stdin/ratelimit-dup.json", "tests/fixtures/statusline-stdin/keyorder.json", "projects/meta/milestones/v7.1/MILESTONE.md", "projects/meta/milestones/v7.1/execute/phase-1.md + phase-2.md"],
    "files_edited_list": ["claude/statusline/statusline.sh", "tests/integration/test-statusline-timeout.sh", "CLAUDE.md", "projects/meta/ARCHITECTURE.md", "projects/meta/ROADMAP.md"],
    "loc_approx": "코드/문서 +172 -31 (statusline.sh +77 / test +81 / CLAUDE.md +16 / fixtures 4) + milestone 산출물 +524 (MILESTONE.md + 별책 2)",
    "commits": "3 (195ccc1 phase-1 / cc3a149 phase-2 / 7d007ef EXECUTE+VERIFY) + REPORT/PROPOSE commit 후속 (사용자 확인 게이트)",
    "smoke": "pre-commit 19 hook 전체 Passed (FAIL=0) + statusline 통합 T1~T9b 11/11 PASS. EXECUTE 중 entry-title FAIL 1건 → title 정정 후 PASS 복구 (회귀 0)."
  },
  "lessons_learned": [
    {"id": "L1", "priority": "P1", "description": "'설치≠사용' (v7.0 lesson) 의 직접 후속 사례 — design-review subagent 가 v7.0 에서 파일 생성(agents/design-review.md 실재)됐으나 현 세션 plugin cache 미reload 로 사용 가능 목록에서 누락 (version-tracker 동반) → general-purpose agent 로 mechanism 모사. subagent 파일 생성 ≠ 현 세션 가용. 신규 agent 도입 milestone 은 '같은 세션 invoke 가능 여부' 를 deliverable 검증에서 분리해야 함.", "context": "DESIGN five_perspective_review 진행 시 design-review subagent invoke 시도 → 사용 가능 agent 목록 부재 확인.", "next_action_candidate": "거명만 보존 (PROPOSE 사용자 명시 결정 게이트). plugin cache reload 시점 mechanism 은 v7.0 후속 본질."},
    {"id": "L2", "priority": "P1", "description": "RESEARCH Explore 병렬 dogfood 의 실 이득은 'risk 발견' 이 아니라 벽시계 단축 + 메인 컨텍스트 경량 (statusline.sh 를 직접 안 읽고 결론만 받음 = § 7.1 컨텍스트 효율 그 자체). 정직 회고 — 새로 드러난 risk 2건 (used_percentage 키 중복 / 필드 부재 0% 오표시) 은 codebase Explore 가 아니라 context7 외부 query (ext_1/ext_2) 에서 표면화. 병렬의 가치를 'risk 더 찾음' 으로 과장하지 않음.", "context": "RESEARCH 안 codebase 2 stream + 외부 context7 동시 query 진행 후 회고.", "next_action_candidate": "거명만 보존 — 병렬 dogfood evidence 누적 (v7.0 설치 후 첫 실 trigger)."},
    {"id": "L3", "priority": "P1", "description": "design-review N+가변 의 가치 evidence — review 가 RESEARCH/DESIGN 이 놓친 spec-drift self-tension 1건 (bounded-substring 경계 끝-마커가 risk_2 '키 순서 무보장' 전제와 충돌) 을 실제 검출 → anchored-first-match 로 정정 + smoke T8 추가. inline self-review 였다면 동일 LLM 관성으로 놓쳤을 가능성 — 별 컨텍스트 분리가 관성을 깬 직접 사례.", "context": "DESIGN five_perspective_review spec-drift 관점 comment.", "next_action_candidate": "거명만 보존 — design-review N+가변 (T1.3) 첫 dogfood evidence."},
    {"id": "L4", "priority": "P2", "description": "entry-title gate (smoke-entry-title-guideline) 가 EXECUTE 중 실제로 v7.1 title 의 ' + ' 를 차단 (도그푸드). 2 반쪽 bundling milestone 은 OPEN 시점에 title 의 entry-title (' + ' P1) 정합을 사전 확인하는 게 효율적 — EXECUTE 중 재커밋 cost 회피.", "context": "phase-1 첫 commit 시 pre-commit smoke-entry-title-guideline FAIL.", "next_action_candidate": "거명만 보존 (PROPOSE 사용자 명시 결정 게이트) — OPEN stage skill 또는 propose-next 안 title 사전 검증 권고 candidate 여지."},
    {"id": "L5", "priority": "P2", "description": "검증 비대칭 패턴 누적 3번째 — carry-over (always-loaded 행동 지침, 자기회고 검증 불가) = skill body observer limit (v6.17) + skill body evaluation (memory) 동류. always-loaded 행동 규약의 '실제 작동 여부' 검증 한계가 반복 표면화 → 외부 instrumentation 없이는 schema 존재 + 수동 1회가 상한.", "context": "phase-2 carry-over 검증 비대칭 (sc_4, risk_3 ACKNOWLEDGED).", "next_action_candidate": "거명만 보존 — 행동 규약 외부 instrumentation 본질은 누적 후 발의 (1건으론 근거 부족)."},
    {"id": "L6", "priority": "P3", "description": "commit message 에 '/' (슬래시 명령) 또는 작은따옴표 포함 시 PowerShell here-string (@'...'@) 이 Bash 툴에서 작은따옴표를 조기 종료 → pathspec 오류. git commit -F 메시지 파일 경유 패턴이 안전.", "context": "phase-1 재커밋 + phase-2 커밋 시 @'...'@ 안 ' + ' / /clear 깨짐.", "next_action_candidate": "거명만 보존 (도구 운영 lesson, milestone 발의 부재)."}
  ]
}
```

### Narrative

본 milestone 의 핵심 성취는 **전제 오류를 OPEN 직전 검증으로 잡아 재설계한 것**이다. 원안 ('Claude 가 stage 완료 시 컨텍스트 %를 자가추정해 40% 넘으면 /clear') 은 "연료 게이지 없이 연료 절반 규칙"이었다 — 세션 안 모델도 hook 도 컨텍스트 % 채널이 아니다. statusline stdin 에만 `context_window.used_percentage` 가 실재한다는 사실이 mechanism 을 계기판(statusline 이 읽음) + carry-over(stage 완료 trigger 에 묶음) 2 반쪽으로 갈랐고, verdict RESOLVED 로 둘 다 안착했다.

**delta** — 코드/문서 9 파일 (+172 -31), milestone 산출물 3 파일 (+524), commit 3 (+REPORT/PROPOSE 후속). 계기판은 정량 smoke (statusline 11/11 + pre-commit 19 hook), carry-over 는 schema 정전화 + always-loaded 토큰 폭 1회 측정 (+1119 bytes ≈ +6.4%, 정직 노출).

**lessons 핵심** — v7.0 6 mechanism 첫 dogfood 가 P1 3건을 낳았다: (L1) design-review subagent 가 파일은 있으나 현 세션 invoke 불가 = '설치≠사용' 직접 후속, (L2) RESEARCH 병렬의 실 이득은 risk 발견이 아니라 컨텍스트 경량 — risk 2건은 오히려 외부 context7 query 에서 나왔다는 정직 회고, (L3) design-review 가 inline 이었다면 놓쳤을 spec-drift self-tension 1건을 실제 검출. P2 2건 (L4 entry-title 사전 검증 / L5 검증 비대칭 누적 3번째), P3 1건 (L6 commit -F 패턴) 은 거명만 보존 — v7.0 T1.2 정합 (next_candidates append = PROPOSE 사용자 명시 결정 게이트 후만, lessons 자동 enumerate 폐지).

## PROPOSE

### Spec

```json
{
  "next_candidates": [
    {
      "id": "open-stage-entry-title-precheck",
      "title": "OPEN stage title entry-title 사전 검증 권고 추가",
      "trigger": "B_regression",
      "origin_milestone": "v7.1",
      "target_version": "v7.2",
      "description": "L4 origin — entry-title gate (smoke-entry-title-guideline) 가 본 milestone EXECUTE 중 v7.1 title 의 ' + ' 를 실제 차단 (도그푸드). 2 반쪽 bundling milestone 은 OPEN 시점에 title 의 ' + ' P1 정합을 사전 확인하면 EXECUTE 중 재커밋 cost 회피. stage-open skill 또는 propose-next 안 title 사전 검증 checklist 1줄 추가 후보."
    }
  ],
  "next_candidates_named_only": [
    "always-loaded 행동 규약 (carry-over 등) 외부 instrumentation — L5 검증 비대칭 누적 3번째 (skill body observer limit v6.17 동류). 자기회고 검증 불가의 상한을 깰 외부 계측 본질이나 1건 근거 부족, 누적 후 발의.",
    "statusline stdin JSON fixture 라이브러리화 (SCOPE_OUT_NOTES regression) — model display_name 등 향후 statusline 기능 추가 시 재사용 fixture 일반화. 본 milestone 은 fixture 3종 추가까지만.",
    "cascade 매트릭스 단방향-pointer 분류 row 명문화 (SCOPE_OUT_NOTES cascade-narrative) — carry-over 의 'CLAUDE.md 1차 source ↔ § 7.x pointer + cascade marker 부재' 패턴이 § 7.3 stage skill 선례와 동형. 동류 누적 시 § 4 매트릭스에 분류 row 명문화 여지, 1건으론 부족.",
    "plugin cache reload 시점 mechanism (L1, v7.0 후속) — subagent 파일 생성 후 현 세션 가용까지의 gap 을 좁히는 본질. v7.0 '설치≠사용' lesson 직접 후속이나 별 milestone 발의 불확정."
  ]
}
```

### Narrative

본 milestone 의 forward 후보는 lessons P2/P3 + ## SCOPE_OUT_NOTES 4 관점 거명에서 추출했다. **실 등재 의도 후보 1건** = `open-stage-entry-title-precheck` (L4 origin, B_regression) — entry-title gate 가 EXECUTE 중 실제 차단한 evidence 가 있어 OPEN 시점 사전 검증이 cost 절감 본질로 구체적이다.

나머지 4건 (행동 규약 외부 instrumentation / fixture 라이브러리화 / cascade 단방향-pointer row / plugin cache reload) 은 **거명만** — 모두 1건 근거 부족 또는 별 milestone 발의 불확정 (누적 후 발의 본질). v7.0 T1.2 정합 — ROADMAP `next_candidates[]` 실 append 는 **사용자 명시 결정 게이트 후만** 진행 (lessons 자동 enumerate 폐지, 부산물 cycle 차단). 본 PROPOSE 작성 = 후보 분석까지, 실 등재 결정은 사용자 게이트에 위임.

## SUB_MILESTONES

본 milestone = **컨텍스트 효율 mechanism 2 반쪽 통합** (계기판 + carry-over). 검증 결과 (claude-code-guide, code.claude.com/docs/en/statusline.md, v2.1.132+) — 컨텍스트 % 실시간 신호는 **statusline stdin JSON `context_window.used_percentage`** 에만 존재 (hook ❌ / 세션 안 모델 직접 ❌). 따라서 "계기판은 statusline 이 읽고, carry-over 는 stage 완료 결정적 trigger 에 묶는다" 2 반쪽 분리.

> **Stage D 동기 완료**: 아래 phase 분할 + title 은 DESIGN `phases[]` 확정 내용과 1:1 동기 (OPEN placeholder 갱신).

```json
{
  "version": "v7.1",
  "title": "컨텍스트 효율 게이지·stage carry-over 권고",
  "status": "completed",
  "sub_milestones": [
    {
      "phase": 1,
      "title": "계기판 — statusline.sh 재구조화 (stdin 1회 읽기 → gate 확장(.harness.toml OR claude-code-version-log.md marker) → context_window.used_percentage anchored-first-match 추출 → [ctx N%] 게이지 prefix + 70/90 임계 마커, 부재 시 생략) + smoke T1~T4 stdin redirect 갱신 + T5~T8 게이지 case",
      "status": "completed",
      "commit": "195ccc1"
    },
    {
      "phase": 2,
      "title": "carry-over + 권고 — root CLAUDE.md carry-over 블록 schema (in-flight 4 항목) + /clear 권고 narrative (always-loaded 단일 source) + ARCHITECTURE § 7.1 1줄 등재 pointer",
      "status": "completed",
      "commit": "cc3a149"
    }
  ]
}
```

## SCOPE_OUT_NOTES

design-review N+가변 (v7.0 T1.3) 첫 dogfood 안 4 관점 review 가 거명한 scope 외 본질. **next_candidates 자동 등재 부재** — PROPOSE stage 안 사용자 명시 결정 게이트 후만 등재 (§ 11.4 + T1.2 정합). 거명만.

```json
{
  "scope_out_notes": [
    {
      "perspective": "spec-drift",
      "note": "context7 statusline.md schema 재확인 후속 — ext_1~ext_3 는 RESEARCH 시점 query 결과, review 는 인용 매핑 검증만 (직접 재query 안 함, read-only scope). v2.1.132 이후 schema 키/순서 변동 시 anchored-first-match 전제 (current_usage 안 used_percentage 부재) 재검토 필요.",
      "out_reason": "구현 후 회귀 관찰 대상 — 본 milestone scope 외."
    },
    {
      "perspective": "regression",
      "note": "statusline smoke fixture 의 stdin JSON pipe 패턴 (cb_4) 을 재사용 가능한 fixture 라이브러리로 일반화 — 향후 다른 statusline 기능 (model display_name 등) 추가 시.",
      "out_reason": "본 milestone 은 stdin fixture 3종 추가까지만 (라이브러리화는 후속 본질)."
    },
    {
      "perspective": "scope-contract",
      "note": "sc_5 dogfood 회고 (v7.0 6 mechanism 첫 trigger 평가) 는 REPORT lessons 흡수 대상. 본 review 자체가 design-review N+가변 (T1.3) 첫 evidence.",
      "out_reason": "deliverable 아닌 관찰 — REPORT stage scope (DESIGN scope 외)."
    },
    {
      "perspective": "cascade-narrative",
      "note": "carry-over 의 '단방향 pointer + cascade marker 부재' 패턴이 § 7.3 stage skill 선례와 동형 — 동류 'CLAUDE.md 1차 source ↔ § 7.x pointer' 누적 시 § 4 cascade 매트릭스에 단방향-pointer 분류 row 명문화 여지.",
      "out_reason": "패턴 1건으론 명문화 근거 부족 — 누적 후 발의 본질, 본 milestone scope 외."
    }
  ]
}
```
