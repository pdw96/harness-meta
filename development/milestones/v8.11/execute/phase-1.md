# v8.11 EXECUTE — phase-1: detect 기준 matcher/책임 기반 정련

> 별책 (본책 = `../MILESTONE.md` ## EXECUTE). 단일 phase — 자산 2곳 동시 Edit + smoke 회귀.

## changes

### 1. `agents/harness-gap-analyzer.md` (d_2 단락, 라인 38)

d_2 inline 예시를 **pointer + 1줄** 로 정련 (d_3 — 판별 로직 본체는 § 4, 자기완결 기준 재기재 금지):

- before: `harness_state.hooks[].name 에 secret/scan 토큰 부재 → gap surface` (name-token 단독, v8.10 (C) 결함)
- after: `발동 시점(event)이 SessionStart 인 secret-scan 책임 hook 부재 → gap surface` + 구체 판별(matcher/event SessionStart ∧ secret/scan 책임 토큰, write-time guard `Edit|Write` 책임 직교 제외, `secret-guard.py` 류는 SessionStart gate 탈락 → gap 억제 못 함) 은 § 4 표가 canonical + d_4 투명보고 문구

### 2. `bootstrap/claude-code-catalog/README.md` (§ 4 표, 라인 109)

§ 4 'session-start-secret-scan.sh' row 의 '권고 case (gap 조건)' 컬럼 = **canonical 판별 진술** 로 갱신:

- before: `claude_dir=true ∧ hooks list 의 hook name 에 secret/scan 토큰 부재`
- after: `claude_dir=true ∧ 발동 시점(event)이 SessionStart 인 hook 중 settings 파일 secret scan 책임 hook 부재. 판별 = matcher/event 가 SessionStart ∧ name 에 secret/scan 토큰 — write-time guard(matcher Edit|Write, 예 secret-guard.py) 책임 직교 제외(gap 억제 못 함). 모호 시 투명 보고 + 사용자 게이트`
- 표 안 pipe(`Edit|Write`) = `\|` escape (markdown table cell 정합)

## commit

(commit = 사용자 확인 게이트 후 — CLAUDE.md `~/harness-meta/` repo 변경은 커밋 전 사용자 확인 필수)

## verification (phase-1)

VERIFY stage 참조 — smoke-spec-verification + smoke-cross-ref + smoke-secret-scan 전건 PASS(회귀 0, sc_4) + sc_5 narrative 추적.
