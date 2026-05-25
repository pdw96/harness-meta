---
phase: phase-1
milestone: v7.1
status: completed
---

# v7.1 phase-1 — 계기판: statusline.sh 컨텍스트 게이지

## Spec

```json
{
  "phase": "phase-1",
  "status": "completed",
  "scope": "계기판 — statusline.sh 가 stdin context_window.used_percentage 를 읽어 [ctx N%] 게이지 prefix 표시 (70/90 임계 마커, 부재 시 생략) + gate 확장 (.harness.toml OR harness-meta marker) + smoke T1~T4 stdin redirect 갱신 + T5~T9 게이지 case 추가. sc_1 커버.",
  "changes": [
    {"type": "edit", "path": "claude/statusline/statusline.sh", "description": "재구조화 — (d_1) stdin 최상단 1회 읽기 input=$(cat) 를 gate exit 위로 이동 + context_window.used_percentage anchored-first-match 추출 (\"context_window\" 출현~EOF slice 안 첫 used_percentage 정수, current_usage 안 used_percentage 부재 근거로 키 순서 무관). (d_2) gate 확장 = .harness.toml OR projects/meta/claude-code-version-log.md marker (version-track hook 동일 파일). (d_3) [ctx N%] + 70/90 임계 텍스트 마커 (* 주의 / ! 위험), 필드/값 부재 시 게이지 생략 ('0%' 금지, risk_1). (d_4) _join 헬퍼로 게이지 prefix 결합 3 경로 (cmd / fallback / marker-only), 게이지 부재 시 본문 그대로 = 회귀 0."},
    {"type": "create", "path": "tests/fixtures/statusline-stdin/context-present.json", "description": "context_window.used_percentage=8 + current_usage + context_window_size 1M fixture (T5)."},
    {"type": "create", "path": "tests/fixtures/statusline-stdin/context-absent.json", "description": "context_window 부재 + rate_limits 만 존재 fixture (T6, risk_1)."},
    {"type": "create", "path": "tests/fixtures/statusline-stdin/ratelimit-dup.json", "description": "context_window.used_percentage=8 + rate_limits.used_percentage 50/99 동시 fixture (T7, risk_2)."},
    {"type": "create", "path": "tests/fixtures/statusline-stdin/keyorder.json", "description": "rate_limits 가 context_window 앞 + used_percentage 가 current_usage 뒤 = 42 fixture (T8, anchored-first-match 키 순서 변동 회귀)."},
    {"type": "edit", "path": "tests/integration/test-statusline-timeout.sh", "description": "T1~T4 stdin redirect (</dev/null) 갱신 (risk_5 cat hang 회피) + T5~T8 게이지 case (DESIGN 명시) + T9a/T9b 임계 마커 (75%→* / 95%→!, d_3 deliverable 커버, DESIGN T5~T8 대비 자연 확장 — 임계 마커 미검증 gap 보완). marker-only tmpdir (claude-code-version-log.md 모사) 신규."}
  ],
  "verification": [
    {"method": "bash tests/integration/test-statusline-timeout.sh", "result": "PASS", "detail": "T1~T9b 11/11 PASS — T5 [ctx 8%] / T6 빈 출력 (게이지 생략) / T7 rate_limit 오매칭 회피 [ctx 8%] / T8 키 순서 변동 [ctx 42%] / T9a 75%* / T9b 95%!."},
    {"method": "marker-only sanity", "result": "PASS", "detail": "echo '{...used_percentage:37}' | CLAUDE_PROJECT_DIR=harness-meta bash statusline.sh → '[ctx 37%]' — harness-meta repo 세션 (manifest 부재) 게이지 활성 확인 (gate 확장 동기 충족, sc_1 결정 [A])."},
    {"method": "smoke 회귀", "result": "PASS", "detail": "smoke-spec-verification 442/0 + smoke-cross-ref 1/0 + smoke-claude-md-drift 13/13."}
  ],
  "deviations": [
    {"id": "dev_1", "note": "DESIGN phase-1 verification 은 T5~T8 명시 — 구현 시 T9a/T9b (임계 마커 75%* / 95%!) 추가. d_3 가 70/90 임계 마커를 deliverable 로 정의하나 T5~T8 fixture 값 (8/부재/8/42) 이 모두 <70 이라 마커 분기 미검증 gap 발생 → 같은 phase 안 자연 보완 (scope 확장 아님, d_3 deliverable 직접 검증). VERIFY 정직 기록."}
  ],
  "commit": "195ccc1"
}
```

## Narrative

phase-1 = INTENT 2 반쪽 중 **계기판** (smoke 검증 가능한 절반). DESIGN d_1~d_4 를 statusline.sh 단일 파일 재구조화로 구현했다.

**핵심 재구조화** (d_1) — 현 statusline.sh 는 manifest 부재 시 stdin 을 읽기도 전에 즉시 exit 하는 구조였다. stdin 은 1회만 소비 가능하므로 `input=$(cat)` 를 스크립트 최상단 (gate exit 위) 으로 올려야 게이지가 성립한다. 추출은 jq 비의존 bash-native (opt_1, fleet 배포 전제 — Git Bash 에 jq 미동봉) — `"context_window"` 출현부터 EOF 까지 slice 후 첫 `used_percentage` 정수 매칭 (**anchored-first-match**, design-review spec-drift comment 흡수). current_usage 객체 안엔 used_percentage 가 부재하므로 (token count 만) slice 안 첫 used_percentage 는 키 순서와 무관하게 반드시 context_window 소속 — risk_2 (rate_limits 키 중복) 를 키 순서 무보장 하에서도 견고히 회피한다.

**검증** — smoke T5~T8 (DESIGN 명시) + T9a/T9b (임계 마커, 자연 보완) 11/11 PASS. risk_1 (부재 → '0%' 거짓 안심) 은 T6 (빈 출력) 로, risk_2 는 T7 (rate_limit 동시) + T8 (키 순서 변동) 양쪽으로, risk_5 (stdin cat hang) 는 T1~T4 stdin redirect 갱신으로 직접 흡수했다. harness-meta repo marker-only 세션에서 `[ctx 37%]` 게이지 활성도 확인 (gate 확장, sc_1 결정 [A]).

**deviation 1건** (정직 기록) — DESIGN 은 T5~T8 만 명시했으나 그 fixture 값이 모두 <70 이라 d_3 의 70/90 임계 마커가 미검증으로 남는 gap 이 있었다. 같은 phase 안에서 T9a/T9b 로 자연 보완 (d_3 deliverable 직접 검증, scope 확장 아님).
