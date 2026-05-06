# PLAN — v1.82 AGENTS.md drift fix

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: `AGENTS.md` 1건 — root-level repo 자산, OWNERSHIP S3 (Repo 정책·설치 — README/CLAUDE/install.{ps1,sh}/AGENTS.md) 명시 매핑 정합
- T1 다수결 — S3 1/1 = meta 단독
- T2 보강 — AGENTS.md는 영문 baseline 단일 인스턴스이지만 `bootstrap/docs/AGENTS_MD_STRATEGY.md` 스펙의 "본 repo 자체에 적용한 결과" 즉 **스펙 source** 위치 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source — 사용자 발의 (2026-05-06 세션, AskUserQuestion 답변, audit 발견 후 scope 확정)** (verbatim):

> "ROADMAP/CLAUDE.md audit. v1.81 직후 추가 cleanup. 5 모듈 CLAUDE.md drift 또는 ROADMAP §3 trigger row 재분류 점검 (trivial scope, v1.76/v1.81 패턴)"
>
> audit 결과 ROADMAP §3 + 5 모듈 CLAUDE.md drift는 0건이지만, 인접 영역 **AGENTS.md**에 6건 stale drift 발견 (D1~D6). 사용자가 "6건 일괄 정정 (Recommended)" 채택.

**Parsed sub-items (6)**:

1. **D1 verify checks 라벨** — L12 `Z/A/B/C/D/E/F/G` → `Z/A/B/C/D/E/F/H/I auto-checks + G manual` (v1.23+ 정합)
2. **D2 projects/ 5 fixed docs** — L27 `4 fixed docs: ARCHITECTURE/DECISIONS/INTERVIEW/STACK` → 5종 (v1.36+ ROADMAP.md 추가)
3. **D3 smoke 27 files** — L31 `smoke tests (13 files)` → `27 files` (v1.79 smoke-claude-md-drift.sh 도입 후 정합)
4. **D4 latest meta session** — L58 `v1.15-ai-ready-boost` → `v1.81-roadmap-housekeeping` (66 세션 stale 정정)
5. **D5 bootstrap/docs/ 8건 명시** — L26 3건만 (`OWNERSHIP / AGENTS_MD_STRATEGY / OVERLAY`) → 8건 (`SKILLS / SPEC_VERIFICATION / PERMISSION_PATTERN / DETECTION / INTERVIEW_FLOW` 5건 누락 보강)
6. **D6 5 모듈 CLAUDE.md 구조 언급** — v1.73+ 도입 module-level CLAUDE.md (`bootstrap/CLAUDE.md` / `bootstrap/skills/CLAUDE.md` / `claude/CLAUDE.md` / `tests/CLAUDE.md` / `sessions/CLAUDE.md`) AGENTS.md "Project structure" §에 1줄 언급 추가

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `sync-agents.{ps1,sh}` 자동 실행 — 7 adapter (CLAUDE/GEMINI/Cursor/Cline 등) AGENTS.md 동기화 | 사용자 수동 실행 (본 repo는 source-of-truth만 갱신) |
| `smoke-agents-md-drift.sh` 신설 — AGENTS.md ↔ root CLAUDE.md drift 자동 감지 | `v1.83-agents-md-drift-smoke` (후속 §3-B trigger, drift 재발 evidence 1+ 시) |
| AGENTS.md 60~80행 baseline 분량 제약 위반 검토 | 본 세션 정정 후 분량 ≤80행 유지 확인 (D6 1줄 추가 후 점검) |
| README.md cross-ref 추가 보강 | 후속 evidence-driven (현재 README.md drift 0건 — audit 결과) |
| `sessions/meta/ROADMAP.md` §"최근 완료" v1.82 entry 추가 | 본 세션 REPORT 작성 후 `harness-roadmap-update` SKILL 자동 (단계 9-b) |

## Spec verification (context7)

| sub-field | value |
|-----------|-------|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — AGENTS.md drift 정정은 **본 repo 내부 사실 정합** (verify 명령 옵션 / projects 디렉토리 구조 / smoke count / latest session / bootstrap/docs/ 명시 / 5 모듈 CLAUDE.md 언급). 외부 agents.md 오픈 표준 자체 변경 0 — 본 PLAN은 내부 stale 정보 갱신만 |
| **re-verify** | N/A |

**Citations**: 없음 (drift=N/A 분기, 외부 spec 의존 0). 본 repo `bootstrap/docs/AGENTS_MD_STRATEGY.md` §1/§2/§8 (분량 60~80행 / 언어 영문 / 매핑 매트릭스)은 내부 docs로 별도 spec verification 대상 아님.

## 배경

- **선행 세션**: `v1.81-roadmap-housekeeping` (2026-05-06) — ROADMAP §3-E count 라벨 정합 + audit 일자 갱신. 그 직후 사용자가 "ROADMAP/CLAUDE.md audit" 추가 cleanup 요청
- **audit 결과**: ROADMAP §3 + 5 모듈 CLAUDE.md drift 0건. 단 **AGENTS.md L12/L27/L31/L58/L26 + 전체 구조** 6건 stale 발견
- **stale 심각도**: D4 (latest meta session v1.15 → v1.81)는 66 세션 누락 — 외부 방문자 (타 AI 도구 사용자) 신뢰도 직접 영향. AGENTS.md는 60,000+ 프로젝트 표준이라 외부 가시성 큼
- **AGENTS.md 갱신 cadence 부재**: v1.5-agents-md-strategy(2026-04) 도입 후 일부 stale (verify L12 v1.23+, smoke count v1.79, ROADMAP D2 v1.36+, latest session D4 v1.15→v1.81)
- v1.76/v1.81 패턴 답습 — 단일 파일 cleanup, 1 commit, 5 관점 검토 skip (trivial scope ROI)

## 목표

- [ ] D1: AGENTS.md L12 `Z/A/B/C/D/E/F/G` → `Z/A/B/C/D/E/F/H/I auto-checks + G manual` (v1.23+ 정합)
- [ ] D2: AGENTS.md L27 `4 fixed docs: ARCHITECTURE.md, DECISIONS.md, INTERVIEW.md, STACK.md` → 5종 (`ROADMAP.md` 추가)
- [ ] D3: AGENTS.md L31 `smoke tests (13 files)` → `27 files`
- [ ] D4: AGENTS.md L58 `v1.15-ai-ready-boost` → `v1.81-roadmap-housekeeping` 또는 본 v1.82 (commit 시점 기준 — REPORT 작성 단계에서 결정, 보수적으로 v1.81 유지 + roadmap-update SKILL이 자동 갱신)
- [ ] D5: AGENTS.md L26 bootstrap/docs/ 명시 8건 (현재 3건 → 추가 5건: SKILLS / SPEC_VERIFICATION / PERMISSION_PATTERN / DETECTION / INTERVIEW_FLOW)
- [ ] D6: AGENTS.md "Project structure" §에 5 모듈 CLAUDE.md 구조 (v1.73+) 1줄 언급 추가
- [ ] AGENTS.md 분량 ≤80행 유지 확인 (현재 62행 → +5~7행 예상, ≤80 안전)
- [ ] smoke 3종 회귀 0 (claude-md-drift + spec-verification + scope-contract)

## 변경 대상

| 파일 | 변경 |
|------|------|
| `AGENTS.md` | D1~D6 정정, 단일 commit (~6 occurrence) |
| `sessions/meta/v1.82-agents-md-drift-fix/PLAN.md` | 본 파일 (신규) |
| `sessions/meta/v1.82-agents-md-drift-fix/REPORT.md` | 세션 종료 시 작성 |

## 성공 기준

- [ ] AGENTS.md D1~D6 정정 결과 root CLAUDE.md / README.md / 5 모듈 CLAUDE.md / ROADMAP §1 공통 사실과 정합
- [ ] AGENTS.md 분량 ≤80행 유지
- [ ] smoke-claude-md-drift PASS 16/16 (회귀 0)
- [ ] smoke-spec-verification PASS (회귀 0 — 본 PLAN/REPORT § 정합)
- [ ] smoke-scope-contract PASS (회귀 0)
- [ ] 단일 commit (`docs(meta): sessions/meta/v1.82-agents-md-drift-fix — AGENTS.md drift 6건 정정`)

## 커밋 전략

단일 commit — AGENTS.md 6건 정정 + PLAN.md + REPORT.md 동시. 사용자 확인 후 `git add` 명시 파일만.

## 검토 절차

- **5 관점 검토 skip** — trivial scope (1 파일 + docs-only + v1.76/v1.81 패턴 동일). AGENTS.md는 외부 방문자 영향이 크지만 **변경 내용은 사실 정합**(매뉴얼 보강 X)이라 architectural decision 부재
- **Plan-verify (단계 6)** — drift=N/A 분기 self-apply 완료 (위 § 채움)
- **Plan 확정 (단계 7)** — 사용자 진입 승인 별도 invoke

## 후속 세션 연결

- **선행**: `v1.81-roadmap-housekeeping` (2026-05-06) — ROADMAP audit 후 인접 영역 (`AGENTS.md`) 추가 audit 트리거
- **후속 (잠재)**:
  - `v1.83-agents-md-drift-smoke` (§3-B trigger) — AGENTS.md ↔ root CLAUDE.md 자동 drift 감지 smoke. 본 v1.82가 1차 evidence 0→1 진척. 재발 (drift evidence 3+) 시 진입 valid
  - `v1.82b-sync-agents-execution` (§3-A trigger) — 사용자가 7 adapter 동기화 (CLAUDE.md / GEMINI.md / .cursor/rules/main.mdc 등) 필요 시 `sync-agents.{ps1,sh} --source-wins` 실행. 본 repo는 source-of-truth(AGENTS.md)만 갱신
