# REPORT — v1.83 milestone-phase 2-tier 인프라 도입 (M1 phase 1)

## 최종 결과

- **신규 파일**: 8건
  - `sessions/meta/v1.83-milestone-phase-infra/{PLAN,REPORT}.md` (2)
  - `milestones/M1-milestone-phase-infra/{PLAN,ROADMAP,REPORT}.md` (3, dogfood)
  - `milestones/M2-drift-detection-infra/{PLAN,ROADMAP,REPORT}.md` (3, retro)
  - `docs/adr/ADR-006-milestone-phase-2tier.md` (1)
- **갱신 파일**: 19건
  - 1순위 (5): `bootstrap/docs/{OWNERSHIP,SPEC_VERIFICATION}.md` + `claude/commands/harness-meta.md` + `CLAUDE.md` (root) + `sessions/CLAUDE.md`
  - 2순위 (4): `bootstrap/skills/audit/{harness-plan-verify,harness-roadmap-update}/SKILL.md` + `tests/CLAUDE.md` + `README.md` + `docs/adr/README.md`
  - smoke 4: `tests/smoke-{cross-ref,claude-md-drift,spec-verification,scope-contract}.sh`
  - retro frontmatter (5): `sessions/meta/v1.{79,79b,80,81,82}-*/PLAN.md`
- **smoke 회귀**: 0
  - smoke-cross-ref: PASS=1, FAIL=0
  - smoke-spec-verification: PASS=630, FAIL=0, SKIP=4 (M1 + M2 PLAN/REPORT 검증 통과)
  - smoke-scope-contract: PASS=194, FAIL=0
  - smoke-claude-md-drift: 16/16 PASS
  - smoke-roadmap-sync: PASS=31, FAIL=0, SKIP=93
  - **pre-commit (markdownlint + shellcheck + 4 smoke)** 모두 PASS
- **commit 분할**: 5건 (`8955f7c` smoke / `cb36299` PLAN / `938eec1` milestones+ADR / `701f984` 1순위 docs / `d84426b` 2순위 docs+frontmatter)

## 구현 요약

### A1 — milestones/ 디렉토리 인프라 ✅

`milestones/M{N}-{slug}/{PLAN,ROADMAP,REPORT}.md` 3 파일 컨테이너 도입. M-번호 정책 `^M[1-9][0-9]*$` (M0 금지, padding 없음, creation-order). ADR-006 `docs/adr/ADR-006-milestone-phase-2tier.md` 결정 기록.

### A2 — 양방향 linkage ✅

**Forward (phase → milestone)**: phase PLAN.md 맨 앞 YAML frontmatter:

```yaml
---
milestone: M{N}-{slug}
milestone-id: M{N}
phase: <number>
---
```

**Backward (milestone → phase)**: `milestones/M{N}/ROADMAP.md` §"Phases" 표.

### A3 — dogfood M1 ✅

`milestones/M1-milestone-phase-infra/{PLAN,ROADMAP,REPORT}.md` — 본 v1.83 자기 wrap. M1 phase 1 = `sessions/meta/v1.83-milestone-phase-infra/`. M1 ROADMAP §"Phases" 표 row 1건 (v1.83 = ✅).

### A4 — ADR-006 + ADR README ✅

`docs/adr/ADR-006-milestone-phase-2tier.md` 신규 (결정 + 배경 + 결과 + 트레이드오프). `docs/adr/README.md` 인덱스 표 row 추가.

### A5 — 1순위 6 docs 갱신 ✅

| 파일 | 변경 |
|------|------|
| `bootstrap/docs/OWNERSHIP.md` | S1d 신규 (`milestones/M{N}-{slug}/**`) + Evolution 조항 v1.83 (배경/결정/양방향 linkage/M-번호 정책/단발 wrap/Meta-only scope/Legacy 면제/Smoke 영향/선행 세션 확장) |
| `bootstrap/docs/SPEC_VERIFICATION.md` | §1-3 In scope에 `milestones/M*/PLAN.md` + `REPORT.md` 추가, §2 milestone PLAN/REPORT 의무 명시 |
| `claude/commands/harness-meta.md` | 8단계 milestone-aware (단계 1/2/3/4/9 확장) — milestone 결정 + 디렉토리 생성 + ROADMAP 읽기 + frontmatter 의무 + ROADMAP 갱신 6-step |
| `CLAUDE.md` (root) | 모듈 가이드 표 milestones/ 행 + 구조 규칙 milestone wrap 의무 (1+ phase) |
| `sessions/CLAUDE.md` | 디렉토리 트리 milestones/ 추가 + PLAN.md 작성 규약 frontmatter (v1.83+) + S1d row |
| `tests/smoke-spec-verification.sh` | L217/L261/L418 glob에 `milestones/M[1-9]*/PLAN.md` + `REPORT.md` 추가 + make_label milestone 분기 |

### A6 — 2순위 5 docs 갱신 ✅

| 파일 | 변경 |
|------|------|
| `bootstrap/skills/audit/harness-plan-verify/SKILL.md` | 적용 대상에 milestone PLAN 추가 + Step 1 path detection에 milestone 분기 + frontmatter `milestone:` 인식 |
| `bootstrap/skills/audit/harness-roadmap-update/SKILL.md` | 5-step → 6-step (Step 6 frontmatter-insert) + Step 1 milestone 분기 + Step 2 M-번호 regex `^M[1-9][0-9]*$` + allowed-tools 확장 |
| `tests/CLAUDE.md` | smoke 매트릭스 milestone-aware 표기 (spec-verification + scope-contract + cross-ref) |
| `README.md` | "Directory layout" milestones/ 노드 추가 (영문) |
| `docs/adr/README.md` | ADR-006 인덱스 row |

### A7 — smoke 4 갱신 ✅

| 파일 | 변경 |
|------|------|
| `tests/smoke-cross-ref.sh` | L77 `_VER_SESS` regex에 `milestones/M\d+/` 추가 (immutable history 제외) + git rev-parse 우선 (worktree 호환) |
| `tests/smoke-spec-verification.sh` | L217/L261/L418 glob 확장 + make_label milestone 분기 (위 A5에 흡수) |
| `tests/smoke-scope-contract.sh` | L207 enumerate_plans glob에 `milestones/M[1-9]*/PLAN.md` 추가 |
| `tests/smoke-claude-md-drift.sh` | git rev-parse 우선 (worktree 호환) |

### A8 — M2 retro 사례 ✅

`milestones/M2-drift-detection-infra/{PLAN,ROADMAP,REPORT}.md` 신규 (5 phase wrap):

| # | Phase | 세션 | 종료 일자 |
|:-:|-------|------|---------|
| 1 | claude-md-drift-smoke | v1.79 | 2026-05-05 |
| 2 | claude-md-drift-precommit | v1.79b | 2026-05-05 |
| 3 | precommit-hook-entry-policy | v1.80 | 2026-05-05 |
| 4 | roadmap-housekeeping | v1.81 | 2026-05-06 |
| 5 | agents-md-drift-fix | v1.82 | 2026-05-06 |

각 phase PLAN.md 5건에 frontmatter `milestone: M2-drift-detection-infra` + phase 1~5 추가 (immutable history 회피 위해 `<!-- milestone wrap: v1.83 retro classify (ADR-006) -->` 주석 동반).

## 판정

- [x] A1: `milestones/M{N}-{slug}/{PLAN,ROADMAP,REPORT}.md` 3 파일 규격 신설 + M-번호 정책 ✅
- [x] A2: 양방향 linkage 메커니즘 (frontmatter + ROADMAP §"Phases") ✅
- [x] A3: dogfood — M1 자기 wrap ✅
- [x] A4: ADR-006 + ADR README ✅
- [x] A5: 1순위 6 docs 갱신 ✅
- [x] A6: 2순위 5 docs 갱신 ✅
- [x] A7: smoke 4 갱신 (worktree 호환 추가) ✅
- [x] A8: M2 retro — 3 파일 + 5 PLAN frontmatter ✅
- [x] smoke 5종 회귀 0 ✅
- [x] pre-commit hook 4종 PASS ✅
- [x] dogfood 검증 — M1 자기 wrap 정상 작동 ✅

**판정**: PLAN 8 sub-item 모두 구현 완료. 1:1 매핑 정합.

## Spec verification (context7)

| sub-field | value |
|-----------|-------|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — milestone-phase 2-tier 구조는 본 repo 내부 정책 신설 (sessions/meta/ROADMAP.md / OWNERSHIP.md / SPEC_VERIFICATION.md 모두 자체 단일 소스). Anthropic Claude Code docs (Frontmatter / Slash commands) 외부 spec 의존 0 — phase PLAN.md frontmatter `milestone:` 필드는 자체 정의 |
| **re-verify** | N/A |

**Citations**: 없음 (drift=N/A 분기, 외부 spec 의존 0).

## Lessons Learned

### L1 — 외부 phase 등록 + 인프라 동시 도입 시 dogfooding이 가장 명확한 검증

본 v1.83은 인프라 도입(milestones/) + 자기 자신 wrap(M1) + retro 사례(M2)를 한 세션에 포함. dogfood로 인해 인프라가 실 사용 가능한지 즉시 검증됨 — smoke 통과뿐 아니라 **실제 milestone PLAN/ROADMAP/REPORT 작성 시점의 ergonomics**도 평가 가능.

### L2 — Pre-commit hook 충돌 패턴 — staged smoke fix 우선

처음 commit 1 (PLAN.md 단독)에서 `Stashed changes conflicted with hook auto-fixes... Rolling back`. 원인: pre-commit이 staged version의 smoke를 사용하므로, smoke 본인 갱신을 먼저 staging하지 않으면 OLD version이 실행됨. 해결: smoke 갱신을 commit 1로 우선 배치 → 후속 commit은 새 smoke 사용.

### L3 — YAML Frontmatter는 파일 맨 앞 의무 (markdownlint MD003 회피)

retro 5 PLAN.md에 frontmatter 추가 시 처음에 `<!-- comment -->` → `---\n...\n---` 순서로 작성 → markdownlint MD003 (heading-style) 다수 발생. `---`이 setext heading underline으로 인식됐기 때문. 정정: frontmatter를 파일 맨 앞으로, comment는 그 후 (`---\n...\n---\n\n<!-- comment -->`).

### L4 — markdownlint MD060 deprecated (markdownlint v0.34+)

npx markdownlint-cli2 (v0.22.1)가 MD060 (table-column-style) 다수 검출했지만, pre-commit의 markdownlint-cli v0.42.0 (markdownlint v0.40+)에서는 MD060 deprecated. 따라서 외부 도구로 검증 시 MD060 무시 가능. v1.82 PLAN.md도 동일 패턴이 commit 통과한 이유.

### L5 — Worktree 환경에서 smoke는 git rev-parse 우선

`smoke-cross-ref.sh` + `smoke-claude-md-drift.sh`는 `HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"`로 main repo fallback. worktree에서 실행 시 main repo 스캔 → `.claude/worktrees/...` 경로 broken ref 다수 검출. 해결: `git rev-parse --show-toplevel` 우선 (v1.66 spec-verification + scope-contract 패턴 답습).

### L6 — Incremental milestone lifecycle은 사전 phase enumerate 부담 0

M1은 본 v1.83 진행 중에도 `ROADMAP.md` §"Phases" 표가 점진 추가 가능 (현재 1 phase, 후속 phase 추가 시 row 추가). evidence-driven 원칙 정합. milestone PLAN은 "범위 선언"만 의무, 전체 phase 사전 매핑 불필요.

### L7 — Retro classification은 별도 milestone (M2)이 명확

본 v1.83을 M1 (인프라 도입)으로 분류하고, retro 사례 (v1.79~v1.82)는 별도 M2로 분리. 이유: M1 = forward declaration (현재), M2 = backward retro (historical). 두 종류 milestone의 lifecycle이 다르므로 (M1은 진행 중, M2는 즉시 ✅ 종료) 분리가 명확.

## 다음 후보 (보류, evidence-driven)

| 후속 세션 후보 | 분류 | Trigger 조건 |
|--------------|:--:|------------|
| `v1.84-milestone-retro-batch1` | A | 명백 cluster 5~7건 retro (e.g., scorer-na v1.43~v1.55, smoke-autofix v1.60~v1.65). v1.83 인프라 안정화 후 (~1주) |
| `v1.85-milestone-retro-batch2` | A | 단발 15~18건 wrap. v1.84 완료 후 |
| `v1.86-milestone-verification` | A | 모든 retro 후 잔존 정정 + 통계 |
| `project-milestone-extension` | A | projects/upbit/ROADMAP.md milestone 수요 evidence 발생 시 |
| `v1.83b-milestone-fix-mode` | B | smoke `--fix` mode에 milestone-aware skeleton 자동 삽입 evidence 발생 시 |
| `v1.83c-milestone-frontmatter-helper` | E | phase PLAN.md frontmatter 누락 evidence 3+ 시 (자동 추가 도구) |
| `harness-roadmap-update-auto-retro` | E | 자동 retro 추천 기능 evidence 3+ 시 |

## 후속 세션 연결

- **선행**: `v1.82-agents-md-drift-fix` (M2 마지막 phase, milestone-aware 도입 직전)
- **후속**: 위 표 참조 — 점진 retro (M3+) + 인프라 개선 evidence-driven
- **AGENTS.md latest pointer**: `sessions/meta/ROADMAP.md` §8 cross-ref redirect 정책 (v1.82 도입) 활용 — 본 v1.83은 §8에 entry 추가 후 latest 자동 반영
