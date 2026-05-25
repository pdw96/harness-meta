# Claude Code 버전 추적 log

본 file = Claude Code 버전 + 사용 가능 기능 자동 추적 (T1.6 mechanism source, v7.0).

- **자동 검출** = SessionStart hook ([`../../claude/hooks/session-start-version-track.sh`](../claude/hooks/session-start-version-track.sh)) 이 매 세션 `claude --version` stdout 을 context 로 주입 (출력 전용 — log 기록 안 함).
- **manual 보강** = version-tracker subagent ([`../../agents/version-tracker.md`](../agents/version-tracker.md)) 가 사용자 명시 trigger 시 context7 로 docs 조사 후 매트릭스 + 버전 gate 보강.
- **단일 writer** = Claude (메인) 또는 version-tracker 만 본 file write (정정 #4, 경합 + churn 제거). hook 은 기록하지 않음.
- **거주 본질** = meta scope long-lived 참조 (milestone 산출물 외 — 디스크 보존 자연).

## Current state

- **Claude Code version**: 2.1.150 (Claude Code) — last updated: 2026-05-25
- **검출 source**: 본 세션 직접 확인 (`claude --version`) + SessionStart hook 주입
- **사용 가능 기능 매트릭스** (정밀 버전 gate = version-tracker context7 보강 예정):

  | 기능 | 현 환경 (2.1.150) | 비고 |
  |---|:-:|---|
  | Auto-Mode (`permissions.defaultMode: "auto"`) | ✓ | T1.5 적용 대상 |
  | `.claude/rules/` | ✓ | T1.1 적용 대상 (repo-local) |
  | Hook (SessionStart / PostToolUse / SubagentStop / TaskCompleted) | ✓ | SessionStart + PostToolUse 본 repo 활용 중 |
  | Extended Thinking | ✓ | — |
  | Background sessions | ✓ | — |
  | `/ultrareview` | ✓ | 사용자 trigger 빌링 본질 |
  | `/code-review` (구 `/simplify` 리브랜딩) | ✓ | v2.1.147+ 리브랜딩, 현 2.1.150 ≥ 2.1.147 → 활성 |

  > 버전 gate 표기는 docs 주차 표기 ("2026-wNN") 기준이 정확 (정정 #2) — 위 매트릭스는 현 환경 실재 여부만 우선 기록, 정밀 gate 는 version-tracker context7 조사 후 보강.

## History

### 2026-05-25 — initial entry (v7.0 T1.6 단계 a)

- version = 2.1.150
- 도입 = T1.6 버전추적 mechanism (SessionStart hook + version-tracker subagent + 본 log)
- delta = v7 design carry-over 기준 환경 2.1.146 → 현 2.1.150 (4 patch 갱신). 첫 entry 가 바로 실 버전 변경 포착 — `/simplify` → `/code-review` 리브랜딩 (v2.1.147+) 이 현 2.1.150 에서 활성 전환됨.
- detect source = 본 세션 직접 확인 (`claude --version`)
