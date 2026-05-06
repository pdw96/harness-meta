# REPORT — v1.82 AGENTS.md drift fix

## 최종 결과

- **변경 파일**: 1건 (`AGENTS.md`)
- **변경 라인**: D1~D6 6건 (line 12 / 26 / 27 / 28-29 신규 / 32 / 59) — Edit 3 occurrence (1+ block + 1 + 1)
- **분량**: 62 → 63행 (+1행, ≤80행 baseline 제약 안전)
- **smoke 회귀**: 0 (claude-md-drift 16/16 + scope-contract 188/188 + cross-ref 1/1 + spec-verification 603/603)
- **신규 모듈**: 0 (docs-only stale fix)
- **세션 산출**: 본 디렉토리 PLAN.md + REPORT.md

## 구현 요약

### D1 — verify checks 라벨 정합 ✅

`AGENTS.md` line 12:

```diff
- - Verify installation: `pwsh verify.ps1` — runs auto-checks (Z/A/B/C/D/E/F/G).
+ - Verify installation: `pwsh verify.ps1` — runs Z/A/B/C/D/E/F/H/I auto-checks + G manual checklist (10 stages, v1.23+).
```

**근거**: README.md L95 정합. v1.23+에서 H/I auto-checks 추가 후 AGENTS.md 미갱신 stale.

### D2 — projects/ 5 fixed docs ✅

`AGENTS.md` line 27:

```diff
- - `projects/<name>/` — per-project harness architecture, 4 fixed docs: `ARCHITECTURE.md`, `DECISIONS.md`, `INTERVIEW.md`, `STACK.md`.
+ - `projects/<name>/` — per-project harness architecture, 5 fixed docs (v1.36+): `ARCHITECTURE.md`, `DECISIONS.md`, `INTERVIEW.md`, `STACK.md`, `ROADMAP.md`.
```

**근거**: root CLAUDE.md L32 "5종 고정" + README.md L153 "5 fixed docs (v1.36+)" 정합. v1.36-roadmap-unification에서 ROADMAP.md 추가됨.

### D3 — smoke 27 files ✅

`AGENTS.md` line 32:

```diff
- - `.github/workflows/ci.yml` — smoke tests (13 files) auto-run on push and pull_request.
+ - `.github/workflows/ci.yml` — smoke tests (27 files) auto-run on push and pull_request.
```

**근거**: root CLAUDE.md "smoke 27 매트릭스" + tests/CLAUDE.md "smoke 매트릭스 (현 27 파일)" + smoke-claude-md-drift Stage S4 PASS (27 = 실제 파일 수). v1.79 smoke-claude-md-drift.sh 도입 + 후속 smoke 추가로 26→27.

### D4 — Latest meta session 갱신 ✅

`AGENTS.md` line 59:

```diff
- - Latest meta session: [`sessions/meta/v1.15-ai-ready-boost/`](sessions/meta/v1.15-ai-ready-boost/) — CI automation + GUARDRAILS + .env.example + CHANGELOG (AI-Ready ROI top 5).
+ - Latest meta session: [`sessions/meta/v1.81-roadmap-housekeeping/`](sessions/meta/v1.81-roadmap-housekeeping/) — ROADMAP §3-E count-label sync + audit-date refresh. See [`sessions/meta/ROADMAP.md`](sessions/meta/ROADMAP.md) §8 "최근 완료" for full history.
```

**근거**: 66 세션 (v1.15→v1.81) stale. 보수적으로 v1.81 표기 (본 v1.82는 commit 후 ROADMAP.md SKILL 자동 갱신). 본문에 ROADMAP.md §8 cross-ref 추가 — 매 세션 latest 갱신 부담 회피 (drift cadence 완화). harness-roadmap-update SKILL이 매 REPORT 작성 후 ROADMAP §8/§9 자동 갱신 → AGENTS.md latest pointer는 ROADMAP §8로 redirect 정책.

### D5 — bootstrap/docs/ 8건 명시 ✅

`AGENTS.md` line 26:

```diff
- - `bootstrap/` — new-project onboarding assets: `manifest-schema.md`, `docs/OWNERSHIP.md`, `docs/AGENTS_MD_STRATEGY.md`, `docs/OVERLAY.md`. Templates: ...
+ - `bootstrap/` — new-project onboarding assets: `manifest-schema.md`, `docs/{OWNERSHIP,AGENTS_MD_STRATEGY,OVERLAY,SKILLS,SPEC_VERIFICATION,PERMISSION_PATTERN,DETECTION,INTERVIEW_FLOW}.md` (8 single-source docs). Templates: ...
```

**근거**: bootstrap/CLAUDE.md L17~L25 매트릭스 정합. brace-expansion 표기로 분량 절약 (1줄 유지).

### D6 — 5 모듈 CLAUDE.md 구조 언급 ✅

`AGENTS.md` line 28-29 (line 28 sessions row 보강 + 신규 line 29 module-level 언급):

```diff
- - `sessions/meta/vX.Y-<slug>/` and `sessions/<project>/vX.Y-<slug>/` — session records as `PLAN.md` + `REPORT.md` pairs only.
+ - `sessions/meta/vX.Y-<slug>/` and `sessions/<project>/vX.Y-<slug>/` — session records as `PLAN.md` + `REPORT.md` pairs only. `sessions/meta/ROADMAP.md` is an operational-docs exception (v1.36+, follow-up trigger view).
+ - Module-level guides (v1.73+): `bootstrap/CLAUDE.md`, `bootstrap/skills/CLAUDE.md`, `claude/CLAUDE.md`, `tests/CLAUDE.md`, `sessions/CLAUDE.md` — Claude Code on-demand loads these when working inside the corresponding directory.
```

**근거**: root CLAUDE.md L9~L19 "모듈별 가이드 (v1.73+ on-demand 로드)" 정합. 다른 AI 도구도 module-level CLAUDE.md 자동 로드 가능성 가시화 + sessions/ ROADMAP 예외 1줄 보강 (D2 단순 수치 정합 외 구조 정확성 향상).

## 판정

PLAN 체크박스 8/8 ✅:

- [x] D1 verify checks 라벨 정합 ✅
- [x] D2 projects/ 5 fixed docs ✅
- [x] D3 smoke 27 files ✅
- [x] D4 latest meta session v1.81 ✅
- [x] D5 bootstrap/docs/ 8건 명시 ✅
- [x] D6 5 모듈 CLAUDE.md 언급 추가 ✅
- [x] 분량 ≤80행 (62→63행) ✅
- [x] smoke 3종 회귀 0 (claude-md-drift + spec-verification + scope-contract, +cross-ref 보너스) ✅

## Spec verification (context7)

| sub-field | value |
|-----------|-------|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — AGENTS.md drift 정정은 **본 repo 내부 사실 정합**(verify 명령 옵션 / projects 디렉토리 구조 / smoke count / latest session / bootstrap/docs/ 명시 / 5 모듈 CLAUDE.md 언급). 외부 agents.md 오픈 표준 자체 변경 0 — 내부 stale 정보 갱신만 |
| **re-verify** | N/A |

**Citations**: 없음 (drift=N/A 분기, 외부 spec 의존 0).

PLAN drift=N/A → REPORT drift=N/A (`smoke-spec-verification.sh` Stage 7 OK 분기 정합).

## Lessons Learned

- **L1 — AGENTS.md latest session stale 패턴**: v1.5(2026-04 도입) ~ v1.82(2026-05-06) 약 1개월간 latest pointer 1회만 갱신(v1.15) → 66 세션 stale. **redirect 정책 채택**: latest pointer 명시 대신 `ROADMAP.md §8 "최근 완료"` cross-ref로 redirect — harness-roadmap-update SKILL 자동 갱신 활용. 향후 latest pointer 수동 갱신 부담 0.
- **L2 — bootstrap/docs/ 명시 brace-expansion**: 8건 docs를 한 줄에 표기 (`docs/{OWNERSHIP,AGENTS_MD_STRATEGY,...}.md`) → AGENTS.md 80행 제약 안전. 향후 신규 docs 추가 시 brace-expansion 내부에 1 segment 추가만으로 정합 유지 (외부 가독성도 유지).
- **L3 — drift=N/A 분기 부분 N/A 함정 재학습**: 1차 PLAN 작성 시 library/topic/findings 채움 → smoke FAIL=1. 외부 spec 변경 0 + 내부 정합 작업이면 5 sub-field 전부 N/A 의무. v1.81 PLAN 형식 답습 후 PASS=603. v1.76/v1.81 패턴 1차 재학습.
- **L4 — AGENTS.md ↔ root CLAUDE.md drift는 smoke-claude-md-drift 미감지**: 본 v1.82 발견 6건 중 5건은 root CLAUDE.md / README.md / tests/CLAUDE.md 사실과 mismatch이지만 smoke-claude-md-drift는 5 모듈 CLAUDE.md만 검사 (S1~S4). AGENTS.md 자동 drift 감지 인프라 부재 — `v1.83-agents-md-drift-smoke` 후속 (drift 재발 evidence 1+ 시) §3-B 등록.

## 후속 세션 (보류)

§3-B 신규 등록 (evidence 1+ 진척 → 3+ 누적 시 진입):

| 후속 세션 | Trigger 조건 |
|---------|------------|
| `v1.83-agents-md-drift-smoke` | AGENTS.md ↔ root CLAUDE.md / README.md / tests/CLAUDE.md / ROADMAP §8 자동 drift 감지 smoke 신설. 본 v1.82가 1차 evidence 0→1 진척. 재발 (drift evidence 3+) 시 진입 valid |

§3-A 잠재 등록 (사용자 trigger 시):

| 후속 세션 | Trigger 조건 |
|---------|------------|
| `v1.82b-sync-agents-execution` | 사용자가 7 adapter 동기화 (CLAUDE.md / GEMINI.md / .cursor/rules/main.mdc 등) 필요 시 `sync-agents.{ps1,sh} --source-wins` 실행. 본 repo는 source-of-truth(AGENTS.md)만 갱신 — adapter 파일 동기화는 사용자 결정 |

**선행 세션**: [`../v1.81-roadmap-housekeeping/`](../v1.81-roadmap-housekeeping/) — ROADMAP audit 후 인접 영역 (`AGENTS.md`) 추가 audit 트리거. v1.76/v1.81 cleanup 패턴 답습.
