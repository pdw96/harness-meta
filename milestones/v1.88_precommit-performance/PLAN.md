# milestone PLAN — v1.88_precommit-performance

## 세션 소속 근거 (self-apply)

**세션 소속**: `milestones/v1.88_precommit-performance/` (S1d milestone 4-tier 트리)

**근거**:

- 변경 파일: `.pre-commit-config.yaml` (S3) + `tests/CLAUDE.md` (S3 / module docs)
- S3 다수파 → `sessions/meta/` 소유 → v1.84+ 체계에서 `milestones/v1.88_*/` 컨테이너
- T1: 경로 모두 S3 (repo 정책·설치) — meta 소유

## Scope inheritance (verbatim from ROADMAP §2)

**Source — `sessions/meta/ROADMAP.md` §2 "다음 후보 (활성)" (verbatim)**:

> `v1.88-precommit-performance` — **40 min wall-clock** for 5 pre-commit cycle (v1.87 milestone,
> 2026-05-07 worktree `claude/upbeat-ptolemy-cda2f1`). 매 commit 시 spec-verification full repo
> (`~/harness-meta`) 스캔 + scope-contract / cross-ref / claude-md-drift 4종 — worktree 변경
> 0 파일도 전수 검사. user productivity 강한 hit (단일 사례 임계 도달).
> 옵션: (a) `pass_filenames: true` + git diff 스코핑 (b) `--fix` retry 비용 회피 mechanism
> (autofix-or-fail wrapper 1-pass화) (c) markdownlint --fix auto-apply

**Parsed sub-items (1)**:

1. **pre-commit 4종 smoke hook 성능 개선** — `always_run: true` 제거 + `files:` 패턴 추가로
   비관련 커밋 시 smoke skip (사용자 L1 선택 2026-05-07)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| L2: `pass_filenames: true` + smoke 파일-레벨 증분 검사 (608→N 축소) | evidence-driven 후속 (L1 효과 측정 후) |
| 1-pass autofix — `precommit-autofix-or-fail.sh` auto-stage 변경 (v1.64 safe-abort 역전) | 사용자 비동의 2026-05-07 |
| markdownlint `--fix` 자동 적용 | evidence-driven 후속 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | pre-commit (`pre-commit/pre-commit-hooks` v5.0.0 + pre-commit framework) |
| **topic** | `always_run`, `files`, `pass_filenames` hook 필드 상호작용 — skip 조건 |
| **findings** | `files:` 패턴 설정 + `always_run` 미설정 → staged 파일 중 `files:` 매칭 없으면 hook skip. `pass_filenames: false` 유지 → hook 호출 시 파일명 미전달 (full scan 동일). pre-commit v2.x+ 이후 일관 동작. |
| **drift** | no — `files:` / `always_run` / `pass_filenames` 필드 의미론 v1.x부터 변경 없음. 현 config `rev: v5.0.0` 정합. |
| **re-verify** | pre-commit major version bump (v5→v6) 시 또는 `files:` 정규식 엔진 변경 공지 시 |

**Citations**:

- C1 — pre-commit 공식 문서: "always_run — if true, runs even when no files match." (`https://pre-commit.com/#creating-new-hooks`)
- C2 — pre-commit 공식 문서: "files — A pattern of filenames to run on. The hook will run only if at least one of the files in the commit matches the pattern." (동일 URL)

## 배경

v1.87 milestone (`milestones/v1.87_python-entry-boilerplate-smoke/`) 작업 중 5회 커밋에
40분 소요. 원인: 4개 local hook 모두 `always_run: true` + `pass_filenames: false` 조합.

**시간 구조 추정** (Windows Git Bash subprocess 오버헤드 ~75ms/호출 기준):

- smoke-spec-verification: 608건 × ~3 grep/awk 호출 = ~136초 (~2.3분)
- smoke-scope-contract: 196건 × ~3 호출 = ~44초 (~0.7분)
- smoke-cross-ref + claude-md-drift: ~30초
- 합계: **~3.5분/커밋** → 5커밋 × (일부 fix 재시도) = **~40분**

**개선 목표**: shell/Python/YAML-only 커밋 시 4개 smoke hook 완전 skip →
해당 커밋 타입에서 pre-commit 시간 **~3.5분 → <30초** (non-smoke hook만 실행).

## N PLAN 사전 선언

| # | slug | phase 수 | 변경 파일 | commit 메시지 |
|:-:|------|---------|---------|-------------|
| 1 | `scope-guards` | 2 | `.pre-commit-config.yaml`, `tests/CLAUDE.md` | `chore(meta): v1.88 plan-1 — pre-commit files: 가드 + always_run 제거` |

### Plan-1 phase 매트릭스

| phase | 변경 파일 | 내용 |
|-------|---------|------|
| 1 | `.pre-commit-config.yaml` | 4 local hook — `always_run: true` 제거 + `files:` 패턴 추가 |
| 2 | `tests/CLAUDE.md` | §"현행 4 hook 현황" 표 `files:` 컬럼 추가 + 정책 설명 갱신 |

## 성공 기준

- [ ] `.pre-commit-config.yaml`: 4 local hook에 `always_run: true` 없음
- [ ] `.pre-commit-config.yaml`: 4 local hook 각각 의미론적 `files:` 패턴 존재
- [ ] `pre-commit run --all-files` → 4 smoke 모두 PASS (기존 동작 회귀 없음)
- [ ] shell-only 스테이징 → 4 smoke hook 미실행 확인
- [ ] `tests/CLAUDE.md` §hook 현황표 `files:` 정보 반영
- [ ] ROADMAP §8 stamp + §2 해소 처리
