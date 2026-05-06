---
name: harness-meta
description: 하네스 자체 개선 또는 프로젝트 부트스트랩 세션 진입점 (글로벌 harness-meta repo 기반)
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
  - Bash(sed *)
  - Bash(uname *)
  - Bash(mv *)
  - Bash(cp *)
  - Bash(rm *)
model: sonnet
---

하네스 관련 세션을 시작한다. 프로젝트 기능 개선(`phases/`)과 **분리**된 별도 흐름으로,
**글로벌 harness-meta repo** (`~/harness-meta/`)에 기록된다.

## 대상 구분

| 대상 | 경로 | 방식 |
|------|------|------|
| 프로젝트 기능 phase | `{project}/phases/{version}/{phase-dir}/` | `/harness-plan`~`/harness-ship` + 프로젝트 executor 자동 |
| **메타 milestone (v1.84+)** | `~/harness-meta/milestones/v{X.Y}_{slug}/` | **수동 문서만** (4-tier: milestone PLAN + N PLAN + 각 PLAN의 phase + milestone REPORT) |
| **레거시 메타 세션** | `~/harness-meta/sessions/meta/vX.Y-{name}/` | v1.0~v1.82 forward-only (신규 작성 금지, ROADMAP만 유지) |
| **프로젝트별 하네스 개선** | `~/harness-meta/sessions/{project}/vX.Y-{name}/` | **수동 문서만** (project-workflow-extension까지 유지) |
| **신규 프로젝트 도입 (bootstrap)** | `~/harness-meta/sessions/{project}/v0.1-bootstrap/` | 인터뷰 + 생성 |

## 대상 결정

Argument로 프로젝트 명시: `/harness-meta <name>` (hyphen↔underscore 동치).
없으면 CWD basename을 target으로 간주.

- `<name>`이 `meta`이거나 현재 repo가 `harness-meta`면 → **repo 자체 개선 모드**
- `~/harness-meta/projects/<name>/` 존재 + 타겟 프로젝트에 `.harness.toml` 존재 → **프로젝트별 하네스 개선 모드**
- `~/harness-meta/projects/<name>/` 부재 또는 `.harness.toml` 부재 → **Bootstrap 모드** (사용자 확인 후 진입)

## 세션 소속 판단

**중요**: 위의 "대상 결정"은 **argument / CWD 기반 추론**이다. 실제 세션이 `sessions/meta/`에 갈지 `sessions/<name>/`에 갈지는 **변경 대상의 scope**가 결정한다 — CWD 무관.

판정 규약은 `~/harness-meta/bootstrap/docs/OWNERSHIP.md`의 **S1–S7 scope 분류** + **T1–T5 tie-breaker**를 단일 소스로 삼는다.

요약:

- **S1–S3** (글로벌 UX / bootstrap / repo 정책) → `sessions/meta/`
- **S4–S6** (프로젝트 아키텍처 문서 / 실행기 코드 / 매니페스트) → `sessions/<name>/`
- **S7** (비즈니스 코드) → 본 체계 대상 아님 (`/harness-plan`~`/harness-ship`)

경계 케이스 판정 순서: **T1 경로 다수결** → **T2 스펙 vs 값** → **T3 검증 대상 기준** → **T4 크로스 커팅 분할** → **T5 애매하면 meta**.

모든 PLAN.md 상단에 **"세션 소속 근거" 섹션** (3–5줄, 적용된 S#/T# 명시) 의무. 상세: `~/harness-meta/bootstrap/docs/OWNERSHIP.md`.

## 절차 — 메타 milestone (v1.84+ 5-Stage)

v1.84에서 4-tier 워크플로우 도입 — `ROADMAP > milestone > N PLAN > 각 PLAN의 phase`.
v1.83 milestone-phase 2-tier (`d8ada7b`)는 폐기 (revert `295bd16`). 본 흐름은 그 superseded 정의.

**4-tier 식별자 매트릭스**:

| 계층 | 경로 | 식별자 |
|------|------|--------|
| ROADMAP (전역) | `sessions/meta/ROADMAP.md` | 1 파일 |
| milestone | `milestones/v{X.Y}_{slug}/` | vX.Y (sessions/meta/와 통합 번호 공간, 단조 증가) |
| PLAN | `milestones/v{X.Y}_{slug}/plan-{n}-{slug}/` | 1, 2, 3, ... (milestone당) |
| phase | `plan-{n}-{slug}/phase-{m}/` (디렉토리 옵션) | 1, 2, 3, ... (PLAN당, commit 단위) |

**파일 분포**:

- **milestone PLAN.md** (무거운 §): 세션 소속 근거 / Scope inheritance / Out of scope / Spec verification / 4 PLAN 사전 선언 / commit 매트릭스
- **plan-{n}/PLAN.md** (가벼운 §): 목표 / phase 표 / 변경 파일 / 성공 기준 / 의존성
- **plan-{n}/REPORT.md**: 각 PLAN 완료 시 작성
- **milestone REPORT.md**: 모든 PLAN 완료 후 작성 (전체 요약, ROADMAP §8 머금)

### Stage A — ROADMAP read+update (전역)

ROADMAP 읽기:

- **meta**: `~/harness-meta/sessions/meta/ROADMAP.md`
- **프로젝트** (legacy until project-workflow-extension): `~/harness-meta/projects/<name>/ROADMAP.md`

§"다음 후보 (활성)" → §"Out of scope (trigger 대기)" → §"Schedule 후보" 순으로 검토.

**AskUserQuestion 자동 invoke 분기**:

- 후보 0건 → `AskUserQuestion` (새 발의 scope 옵션 2~4안 제시)
- 후보 1건 → 그대로 진행
- 후보 2건+ → `AskUserQuestion` (어느 후보 진행?)

### Stage B — milestone 컨테이너 생성 + milestone PLAN.md

vX.Y 결정: `sessions/meta/` + `milestones/`의 최신 vX.Y +1 (단조 증가, minor bump). 하위 호환 깨지면 major bump.

```bash
mkdir -p ~/harness-meta/milestones/v{X.Y}_{slug}/{plan-1-{slug-1},plan-2-{slug-2},...}
```

milestone PLAN.md 작성 (무거운 §):

- **세션 소속 근거** (S#/T# 명시, 3–5줄)
- **Scope inheritance (verbatim from 선행 세션)** — 선행 세션 sub-item 원문 인용. 이후 모든 구현은 이 목록에 매핑 가능해야 함 (**의무**, v1.10j)
- **Out of scope (explicit rejection)** — 인접 발견 issue를 표로 명시. 빈 표 = "없음" 선언 (**의무**, v1.10j)
- **Spec verification (context7)** — 외부 spec drift 검증 표 5 sub-fields (library/topic/findings/drift/re-verify) + Citations 본문 list. drift=N/A 분기 시 모든 sub-field N/A (**의무**: milestones/v1.84+ 및 sessions/<project>/v1.26+). 상세: `~/harness-meta/bootstrap/docs/SPEC_VERIFICATION.md`
- **배경**: 폐기 대상 / 선행 세션 link
- **N PLAN 사전 선언** (Phase 매트릭스): 각 PLAN의 slug + phase 수 + 변경 파일 + commit 메시지
- **성공 기준**: 검증 가능한 체크박스
- (선택) **commit 매트릭스**, **후속 세션**

규격 상세: `~/harness-meta/bootstrap/docs/OWNERSHIP.md` `## Scope contract`.
Spec verification § + SKILL `harness-plan-verify` 사용법: `~/harness-meta/bootstrap/docs/SPEC_VERIFICATION.md`.

**AskUserQuestion 자동 invoke**: 결정 분기점 발견 시 (예: PLAN 분할 / 정책 옵션 / 우선순위 충돌) 즉시 호출.

### Stage C — N PLAN 사전 설계 (각 plan-{n}/PLAN.md)

milestone PLAN의 N PLAN 사전 선언에 따라 각 `plan-{n}-{slug}/PLAN.md` 작성 (가벼운 §):

- **목표** (체크박스)
- **Phase 매트릭스** (phase 번호 / 변경 파일 / commit 메시지)
- **변경 파일** (집계)
- **성공 기준**
- **의존성** (선행/후행 PLAN)

milestone PLAN.md의 사전 선언과 정합 의무 — PLAN 추가/변경 시 milestone PLAN.md 갱신 (drift 차단).

**다각적 병렬 검토 — 5 관점 subagent (가변, min 3)**:

| scope | 검토 관점 (병렬 실행) |
|------:|--------------------|
| 작음 (≤5 파일) | 3 관점 (① architecture / ② spec-drift / ⑤ scope contract) |
| 중간 (6~15) | 4 관점 (① architecture / ② spec-drift / ③ 회귀 / ⑤ scope contract) |
| 큼 (16+) | 5 관점 전체 |

| # | 관점 | agent type | 검토 포인트 |
|:-:|------|----------|-----------|
| 1 | architecture | `Plan` | 디렉토리 구조 / 파일 책임 / 변경 영향 |
| 2 | spec-drift | `general-purpose` (context7 invoke) | 외부 spec 정합 (Anthropic Claude Code docs) |
| 3 | 회귀 risk | `Explore` | 기존 smoke 21+ 영향 / verify.{ps1,sh} 영향 |
| 4 | 보안 | `general-purpose` (security-review SKILL invoke) | 새 SKILL의 side effect / 권한 / path traversal |
| 5 | scope contract | `Explore` | milestone PLAN.md `Scope inheritance` ↔ 각 plan-{n}/PLAN 본문 매핑 / Out of scope verbatim 일치 |

**의견 충돌 처리**: 충돌 발견 시 `AskUserQuestion` 자동 invoke (각 충돌 1 question, 최대 4 question). 사용자 결정 → milestone/PLAN 갱신 → Stage B 재진입.

**Plan-verify (context7)**: `harness-plan-verify` SKILL self-apply — milestone PLAN의 `Spec verification` § sub-fields 채우기. drift=yes 시 `AskUserQuestion`.

**사용자 PLAN 확정**: 5 관점 + Plan-verify 결과 종합 → `AskUserQuestion` (항상 invoke)으로 진입 승인.

### Stage D — phase 진행 (각 phase = 1 commit)

각 plan-{n}-{slug}/ 안의 phase-{m}/ 진행:

1. 변경 파일 수정 (Edit/Write) — milestone PLAN의 변경 파일 매트릭스 정합
2. smoke 회귀 검증 (해당 phase 범위 — pre-commit hook 자동 실행)
3. `git add` + commit (conventional commits, 메시지: `feat(meta): v{X.Y} plan-{n} phase-{m} — <주제>`)
4. (옵션) `phase-{m}/NOTES.md` 작성 (구현 노트)

각 PLAN 완료 시 `plan-{n}-{slug}/REPORT.md` 작성 — 목표 체크박스 / 구현 요약 / 변경 파일 / Lessons Learned.

**AskUserQuestion 자동 invoke**: 구현 중 PLAN 외 의사결정 발견 시.

`execute.py` 사용 금지 (재귀 구조 회피). 사용자 논의 중심 (GSD Questioning 패턴).

### Stage E — milestone REPORT + push + main 머지

모든 PLAN 완료 후:

1. **milestone REPORT.md 작성** (`milestones/v{X.Y}_{slug}/REPORT.md`):
   - 최종 결과 (테스트 수 / 신규 모듈 / 변경 파일 수)
   - 각 PLAN별 구현 요약 (commit 해시)
   - 판정 (milestone PLAN 체크박스 완수)
   - **Spec verification (context7)** (post-hoc, **의무** v1.27+, 판정 § 직후)
   - Lessons Learned
   - 다음 후보 (§3 trigger 등록 candidates)

2. **ROADMAP 자동 갱신** (`harness-roadmap-update` SKILL invoke):
   - 5-step (Identify / Validate / Classify / Sanitize / Update)
   - §"최근 완료" + §"Out of scope" + §"Schedule" 갱신
   - milestone 단위 1 row (phase 상세는 milestone REPORT 위임 → §8 ~50% 축소)

3. **사용자 확인** (`AskUserQuestion`) → push:

   ```bash
   git push origin <worktree-branch>
   ```

4. **PR 생성 + main 머지** (사용자 결정):

   ```bash
   gh pr create --title "milestone v{X.Y}_{slug}" --body "..."
   ```

   merge 전략: squash (단일 milestone commit으로 main 통합).

### AskUserQuestion 자동 invoke 운영 원칙 (v1.84+)

5-Stage 모두에서 결정 분기점 발견 시 자동 호출.

| 원칙 | 적용 |
|------|------|
| "결정 필요 → invoke" | 추론으로 단정 불가한 분기점 모두 |
| "애매하면 invoke" | 신뢰도 < 90% 시 (OWNERSHIP T5 답습) |
| 2~4 옵션 제시 | tool spec 한계 + 사용자 인지 부담 균형 |
| 첫 옵션 (Recommended) | 권장 명확 시만 |
| 단순 yes/no는 텍스트 | AskUserQuestion 남용 회피 |

**Trigger 매트릭스**:

| Stage | invoke 조건 |
|:-:|-----------|
| A | ROADMAP 후보 0건 (새 발의) / 2건+ (어느 후보?) |
| B | milestone PLAN 작성 중 결정 분기점 / Plan-verify drift=yes |
| C | 5 관점 의견 충돌 / 회귀 risk 발견 / 사용자 진입 승인 (항상) |
| D | 구현 중 PLAN 외 의사결정 |
| E | trigger 분류 애매 / push 전 (항상) |

#### Stage E 후 프로젝트 추가/변경 시 체크리스트

- [ ] `~/harness-meta/projects/<name>/` **5종** 파일(ARCHITECTURE/DECISIONS/INTERVIEW/STACK/**ROADMAP** v1.36+) 작성·갱신
- [ ] `~/harness-meta/README.md` 대상 프로젝트 섹션 갱신 (신규 추가/삭제/이름 변경 시)
- [ ] 프로젝트 repo의 `.harness.toml` 최신 상태 확인

## 절차 — Bootstrap 모드 (신규 프로젝트 도입, 8-stage)

타겟 프로젝트에 `.harness.toml` 부재 + `~/harness-meta/projects/<name>/` 부재 감지 시. v1.14 흐름 — 상세는 `~/harness-meta/bootstrap/docs/INTERVIEW_FLOW.md`.

| Stage | 주체 | 산출 |
|------|------|------|
| **S0 모드 진입** | 본 슬래시 명령 | 사용자에게 "프로젝트 <name>에 하네스 미설치. Bootstrap 모드 진입?" 확인 |
| **S1 감지** | `~/harness-meta/bootstrap/detect-project.sh` (v1.9) | TOML snippet (lang/pm/test_cmd 힌트). 결과는 인터뷰 default로 사용 |
| **S2 인터뷰** | `~/harness-meta/bootstrap/interview.md` | 코어 6 (Q1-Q6) + 옵션 1 (Q10) + 자유 1 (Q13 optional) = **7 유효 질문** + 자동 10 (manifest 7: Q7/Q8/Q9 포함 + AGENTS.md 콘텐츠 3). 한 번에 표시·답변 |
| **S3 manifest 작성+미리보기+검증** | `render-manifest.sh` + Claude (Write + Bash grep) | `.harness.toml` 렌더링 → 인라인 미리보기 → 사용자 확정 → 파일 작성 → round-trip 검증 (name/code_dir/phases_dir) |
| **S4 부수 자산** (v1.10b sub-step a-e) | Claude (skeletons/ 기반) | a) `<proj>/AGENTS.md` (영문 baseline) / b) `<proj>/CLAUDE.md` (3 import) / c) `<proj>/CLAUDE.override.md` (Q13 시만) / d) `<proj>/{guardrails}` placeholder / e) `<proj>/{phases_dir}/.gitkeep` |
| **S5 .claude/ 배포** | uname OS 분기 → `install-project-claude.{ps1,sh}` | `<proj>/.claude/` 14 파일 |
| **S6 아키텍처+세션 기록** | Claude (skeletons/projects/ + skeletons/sessions/) | `~/harness-meta/projects/<name>/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK}.md` + `sessions/<name>/v0.1-bootstrap/{PLAN,REPORT}.md` |
| **S7 후속 안내** | Claude (텍스트) | `/config → Output style "Harness Engineer"` 선택 + GUARDRAILS 작성 + code_dir 골격 (v1.11+ overlay) + ARCHITECTURE.md 관측/CI 항목 채우기 안내 |

**Idempotency**: 재실행 시 `.harness.toml` 존재하면 abort + 사용자에게 backup 후 재진입 확인. backup 위치: `<proj>/.harness/backups/manifest.<YYYYMMDD-HHMMSS>.toml` + `.gitignore`에 `.harness/backups/` 자동 append.

**TOML 안전성**: 사용자 입력에 `"`, `'`, `\n`, `$`, `\` 5종 포함 시 render-manifest.sh가 거부 (exit 2). Claude가 재입력 요구.

**Cross-platform**: bash 4+ 필수 (render-manifest.sh가 indirect expansion 사용). macOS 시스템 bash 3.2 → `brew install bash` 안내 (exit 3).

## 금지

- `milestones/v{X.Y}_{slug}/index.json`, `step{N}.md` 생성 (재귀 회피)
- `~/harness-meta/sessions/meta/v1.83+/` 신규 작성 (v1.84+는 `milestones/` 사용)
- `execute.py`를 하네스 개선에 호출 (GSD 부적합)
- 프로젝트 repo의 `phases/HARNESS_CHANGELOG.md` 신규 작성 (이건 레거시 보존용. 새 이력은 harness-meta/milestones/ 또는 sessions/)

## 관련

- 구조 가이드: `~/harness-meta/README.md`
- `.harness.toml` 스펙: `~/harness-meta/bootstrap/manifest-schema.md`
- 철학·패턴: `~/harness-meta/bootstrap/docs/{PHILOSOPHY,PATTERNS}.md`
- 레거시 upbit 이력 (글로벌화 이전): `~/harness-meta/sessions/upbit/v1.1-legacy/ ~ v1.4-legacy/`
