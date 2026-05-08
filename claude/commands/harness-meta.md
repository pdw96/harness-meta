---
name: harness-meta
description: 하네스 자체 개선 또는 프로젝트별 하네스 개선 세션 진입점 (7-stage workflow, 글로벌 harness-meta repo 기반)
argument-hint: "[project-name]"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Write
  - Edit
  - Bash(mkdir *)
  - Bash(git *)
  - Bash(bash *)
  - Bash(pwsh *)
  - Bash(uname *)
  - Bash(mv *)
  - Bash(cp *)
  - Bash(rm *)
model: sonnet
---

하네스 관련 milestone을 시작한다. 프로젝트 기능 개발(`phases/`)과 **분리**된 별도 흐름으로,
**글로벌 harness-meta repo** (`~/harness-meta/`)에 7-stage 흐름으로 기록된다.

## 7-stage workflow (v1.0+)

```
ROADMAP → MILESTONE → PLAN → RESEARCH → DESIGN → EXECUTE → VERIFY → REPORT
```

각 단계는 **단일 책임** + 상위 단계 산출물만 입력. 모든 산출물은 **MD + JSON 코드블록** 포맷.

| 단계 | 산출 파일 | 단일 책임 |
|------|---------|---------|
| ROADMAP | `~/harness-meta/projects/meta/ROADMAP.md` (meta) 또는 `~/harness-meta/projects/<name>/ROADMAP.md` (프로젝트) — root `~/harness-meta/ROADMAP.md` 는 thin index 만 | milestone 목록 (id/title/status/summary/trigger) |
| MILESTONE | `~/harness-meta/projects/meta/milestones/v{X.Y}_{slug}/` (meta) 또는 프로젝트 repo 내 milestones | 컨테이너 |
| PLAN | `.../PLAN.md` | 의도 (goal, success_criteria, scope) |
| RESEARCH | `.../RESEARCH.md` | 조사 (external findings, codebase, options, risks) |
| DESIGN | `.../DESIGN.md` | 결정 + phase 분할 + 사용자 approval gate |
| EXECUTE | `.../execute/phase-{n}.md` | per-phase 구현 (changes, commit) |
| VERIFY | `.../VERIFY.md` | 검증 (smoke, criteria_check vs PLAN) |
| REPORT | `.../REPORT.md` | 종합 (summary, lessons, next_candidates) |

## 대상 구분

| 대상 | 경로 | 진입 조건 |
|------|------|---------|
| **메타 milestone** | `~/harness-meta/projects/meta/milestones/v{X.Y}_{slug}/` | argument 부재 또는 `meta` 또는 CWD=harness-meta |
| **프로젝트별 하네스 개선** | (프로젝트 repo) `milestones/v{X.Y}_{slug}/` | argument=`<name>` + `~/harness-meta/projects/<name>/` 존재 + `.harness.toml` 존재 |
| **신규 프로젝트 도입** | 첫 milestone의 EXECUTE phase에서 처리 | argument=`<name>` + `~/harness-meta/projects/<name>/` 또는 `.harness.toml` 부재 |

## 대상 결정

Argument로 프로젝트 명시: `/harness-meta <name>` (hyphen↔underscore 동치).
없으면 CWD basename을 target으로 간주.

- `<name>`이 `meta`이거나 현재 repo가 `harness-meta`면 → **repo 자체 개선 모드**
- `~/harness-meta/projects/<name>/` 존재 + `.harness.toml` 존재 → **프로젝트별 개선 모드**
- 둘 다 부재 → **신규 도입 모드** (사용자 확인 후 첫 milestone 시작)

## 절차

### Stage A — ROADMAP read + 후보 결정

대상 ROADMAP 읽기:

- meta: `~/harness-meta/projects/meta/ROADMAP.md` (root `~/harness-meta/ROADMAP.md` 는 thin index — milestone 목록은 본 경로)
- 프로젝트: `~/harness-meta/projects/<name>/ROADMAP.md`

`milestones[]` 배열에서 `status: "pending"` 또는 신규 발의 검토.

**AskUserQuestion 자동 invoke**:

- 후보 0건 → 새 발의 옵션 2~4안 제시
- 후보 2건+ → 어느 후보 진행?

### Stage B — MILESTONE 컨테이너 생성

vX.Y 결정: 기존 `~/harness-meta/projects/meta/milestones/` (meta) 또는 프로젝트 repo `milestones/` (프로젝트) 의 최신 vX.Y +1 (단조 증가). breaking change면 major bump.

```bash
# meta
mkdir -p ~/harness-meta/projects/meta/milestones/v{X.Y}_{slug}/execute
# 프로젝트
mkdir -p <project-repo>/milestones/v{X.Y}_{slug}/execute
```

ROADMAP의 `milestones[]` 배열에 신규 항목 추가 (`status: "in_progress"`).

### Stage C — PLAN.md 작성 (intent only)

```
milestones/v{X.Y}_{slug}/PLAN.md
```

JSON 필드:

- `id`, `title`, `goal` (1-2 문장), `motivation`
- `success_criteria` (관측 가능한 결과 list)
- `out_of_scope` (명시적 제외 list)
- `dependencies` (선행/후행 milestone)

⚠️ phase list / file list / commit 메시지 등 implementation detail은 **DESIGN.md로 미룸**.

### Stage D — RESEARCH.md 작성 (findings only)

```
milestones/v{X.Y}_{slug}/RESEARCH.md
```

JSON 필드:

- `external` (사용자 의도 / 외부 spec 검증 결과 list — source/topic/findings/drift)
- `codebase` (affected_files, untouched_files, current_state, target_state)
- `options` (대안별 pros/cons — raw 분석)
- `risks_identified` (예상 리스크 list)

⚠️ 결정 (decisions)은 **DESIGN.md로 미룸**.

### Stage E — DESIGN.md 작성 (decisions + phase 분할 + approval)

```
milestones/v{X.Y}_{slug}/DESIGN.md
```

JSON 필드:

- `decisions` (decision/rationale/alternatives_rejected)
- `approach` (전체 전략 요약)
- `phases` (n / title / scope / affected_files / rationale / risks)
- `risk_mitigation` (risk/mitigation 매핑)
- `approval` (approved_by / date)

**다각적 병렬 검토 — 5 관점 subagent (가변, min 3)**:

| scope | 검토 관점 |
|------:|--------|
| 작음 (≤5 파일) | 3 관점 (architecture / spec-drift / scope contract) |
| 중간 (6~15) | 4 관점 (+ 회귀 risk) |
| 큼 (16+) | 5 관점 전체 (+ 보안) |

| # | 관점 | agent type | 검토 포인트 |
|:-:|------|----------|-----------|
| 1 | architecture | `Plan` | 디렉토리 구조 / 파일 책임 / 변경 영향 |
| 2 | spec-drift | `general-purpose` (context7 invoke) | 외부 spec 정합 |
| 3 | 회귀 risk | `Explore` | 기존 smoke / verify 영향 |
| 4 | 보안 | `general-purpose` (security-review SKILL invoke) | side effect / 권한 / path traversal |
| 5 | scope contract | `Explore` | PLAN.success_criteria ↔ DESIGN.phases 매핑 |

**의견 충돌 처리**: 충돌 발견 시 `AskUserQuestion` 자동 invoke (각 충돌 1 question, 최대 4 question).

**사용자 approval (필수 게이트)**: 5 관점 검토 결과 + DESIGN.md 종합 → `AskUserQuestion`으로 승인 받음 → `approval.approved_by: "user"` + `approval.date: YYYY-MM-DD` 갱신. 미승인 시 EXECUTE 진입 금지.

### Stage F — EXECUTE (phase별 진행, 각 phase = 1 commit)

각 phase 진행:

1. `execute/phase-{n}.md` 작성 (status: `in_progress`)
2. 변경 파일 수정 (Edit/Write) — DESIGN.phases[n].affected_files 정합
3. smoke 회귀 검증 (pre-commit hook 자동 실행)
4. `git add` + commit (conventional commits, 메시지: `feat(meta): v{X.Y} phase-{n} — <주제>`)
5. `execute/phase-{n}.md` status `complete` + execution_notes 갱신

**AskUserQuestion 자동 invoke**: 구현 중 PLAN/DESIGN 외 의사결정 발견 시.

**사용자 명시 승인 없이 `--no-verify` 사용 금지** (pre-commit hook 우회는 명시 승인 게이트만).

### Stage G — VERIFY.md + REPORT.md + ROADMAP 갱신 + push

모든 phase 완료 후:

1. **VERIFY.md 작성** (`milestones/v{X.Y}_{slug}/VERIFY.md`):
   - `smoke_tests` (name/command/result/output)
   - `manual_checks` (check/result/notes)
   - `criteria_check` (PLAN.success_criteria 1:1 매핑)
   - `verdict` (pass | fail), `regressions`

2. **REPORT.md 작성** (`milestones/v{X.Y}_{slug}/REPORT.md`):
   - `summary` (1-3 문단 narrative)
   - `delta` (files_changed/added/deleted, modules_affected)
   - `lessons_learned`
   - `next_candidates` (id/trigger/trigger_type)

3. **ROADMAP 갱신** — `milestones[]` 배열에서 본 milestone `status: "completed"`로 갱신. `next_candidates`는 ROADMAP `milestones[]`에 `status: "pending"` + `trigger` 필드로 등록.

4. **사용자 확인** (`AskUserQuestion`) → push:

   ```bash
   git push origin <branch>
   ```

5. **PR 생성 + main 머지** (사용자 결정):

   ```bash
   gh pr create --title "milestone v{X.Y}_{slug}" --body "..."
   ```

## AskUserQuestion 자동 invoke 운영 원칙

| 원칙 | 적용 |
|------|------|
| "결정 필요 → invoke" | 추론으로 단정 불가한 분기점 모두 |
| "애매하면 invoke" | 신뢰도 < 90% 시 |
| 2~4 옵션 제시 | tool spec 한계 + 사용자 인지 부담 균형 |
| 첫 옵션 (Recommended) | 권장 명확 시만 |
| 단순 yes/no는 텍스트 | AskUserQuestion 남용 회피 |

**Stage별 trigger**:

| Stage | invoke 조건 |
|:-:|-----------|
| A | ROADMAP 후보 0건 (새 발의) / 2건+ (어느 후보?) |
| C | PLAN 작성 중 결정 분기점 |
| D | RESEARCH 중 결정 분기점 |
| E | 5 관점 의견 충돌 / 회귀 risk / **사용자 approval (항상)** |
| F | 구현 중 PLAN/DESIGN 외 의사결정 |
| G | trigger 분류 애매 / push 전 (항상) |

## 신규 프로젝트 도입

`<name>` 부재 시 (즉 `~/harness-meta/projects/<name>/` 부재 + 타겟 `.harness.toml` 부재) — 첫 milestone (예: `v0.1_setup`)의 EXECUTE phase에서 다음 산출:

- `~/harness-meta/projects/<name>/{ARCHITECTURE,ROADMAP}.md` (2종)
- 타겟 프로젝트 `.harness.toml` (manifest)
- 타겟 프로젝트 `.claude/` 배포 (`install.ps1` 또는 별도 스크립트)

별도 "Bootstrap 모드" 없음 — 첫 milestone이 곧 setup.

## 금지

- `<milestone-dir>/index.json`, `step{N}.md` 생성 (재귀 회피)
- `projects/meta/milestones/v1.84~v1.88/` 4-tier 포맷으로 신규 milestone 작성 (historical 보존, 신규는 v1.0+ 7-stage만)
- root `ROADMAP.md` 에 milestone 직접 기재 (thin index 위배 — `tests/smoke-projects-scope-discipline.sh` 가 차단)
- `--no-verify` 사용자 명시 승인 없이 사용
- `execute.py`를 하네스 개선에 호출 (GSD 부적합)

## 관련

- 운영 가이드: `~/harness-meta/CLAUDE.md`
- 프로젝트 thin index: `~/harness-meta/ROADMAP.md`
- 활성 milestone (메타): `~/harness-meta/projects/meta/ROADMAP.md` + `~/harness-meta/projects/meta/CLAUDE.md` (lazy load)
- 모듈 가이드: `~/harness-meta/{claude,bootstrap/skills,tests}/CLAUDE.md`
- ADR: `~/harness-meta/docs/adr/README.md`
