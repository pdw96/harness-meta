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
| **하네스 자체 개선** | `~/harness-meta/sessions/meta/vX.Y-{name}/` | **수동 문서만** (PLAN.md + REPORT.md) |
| **프로젝트별 하네스 개선** | `~/harness-meta/sessions/{project}/vX.Y-{name}/` | **수동 문서만** |
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

## 절차 — 일반 (개선 모드, v1.36+ 8단계, v1.83+ milestone-aware)

v1.36에서 흐름 형식화 — 단계 3(ROADMAP 읽기) + 단계 5(5 관점 subagent) + 단계 6(Plan-verify) + 단계 9(REPORT + ROADMAP 갱신) 신규 추가. v1.83에서 milestone-phase 2-tier 도입 (ADR-006) — 단계 1/2/3/9가 milestone-aware로 확장.

### 1. 다음 버전 결정 (+ milestone 결정, v1.83+)

`~/harness-meta/sessions/<target>/` 디렉토리 스캔 → 최신 버전 + 1 (minor bump 기본). 하위 호환 깨지면 major bump.

Argument로 version 명시 가능: `/harness-meta <name> v1.3-refactor`. 없으면 자동.

**milestone 결정 (v1.83+, meta target만)**:

- 기존 활성 milestone 진행 중? → 해당 milestone에 phase 추가 (`milestones/M{N}-{slug}/ROADMAP.md` §"Phases" 표 갱신)
- 기존 milestone 완료 + 신규 주제? → 신규 milestone 선언 (다음 M-번호, `^M[1-9][0-9]*$`)
- 단발 작은 change? → 1-phase milestone wrap (일관성 — ADR-006 § "단발 처리")
- `milestones/` 디렉토리 스캔으로 최대 M-번호 확인 → +1 (creation-order)

### 2. `~/harness-meta/sessions/<target>/vX.Y-{name}/` 생성 (+ milestone 디렉토리, v1.83+)

```bash
mkdir -p ~/harness-meta/sessions/<target>/v1.3-{name}
```

`{name}`은 kebab-case slug. 변경 핵심 주제 요약.

**Meta target + 신규 milestone 시 (v1.83+)**:

```bash
mkdir -p ~/harness-meta/milestones/M{N}-{slug}/
# {PLAN,ROADMAP,REPORT}.md 3 파일 작성 (incremental lifecycle)
```

phase PLAN.md 맨 앞 frontmatter:

```yaml
---
milestone: M{N}-{slug}
milestone-id: M{N}
phase: <number>
---
```

### 3. ROADMAP 읽기 — 다음 세션 후보 정리 (v1.36+, v1.83+ milestone-aware)

target 결정에 따라 ROADMAP 읽기:

- **meta**: `~/harness-meta/sessions/meta/ROADMAP.md` (메타 전역) + (v1.83+) 활성 milestone의 `~/harness-meta/milestones/M{N}-{slug}/ROADMAP.md` (phase enumerate)
- **프로젝트**: `~/harness-meta/projects/<name>/ROADMAP.md` (Bootstrap S6에서 자동 생성됨, v1.36+)

§"다음 후보 (활성)" → §"Out of scope (trigger 대기)" → §"Schedule 후보" 순으로 검토. 후보가 0건이면 사용자와 새로 논의.

**Milestone 진행 중인 경우 (v1.83+)**: 활성 milestone의 ROADMAP §"Phases" 표에서 다음 phase 후보 우선 검토. 부재 시 메타 전역 ROADMAP §"Out of scope (trigger 대기)" 검토.

**AskUserQuestion 자동 invoke 분기**:

- 후보 0건 → `AskUserQuestion` (새 발의 scope 옵션 2~4안 제시)
- 후보 1건 → 그대로 진행
- 후보 2건+ → `AskUserQuestion` (어느 후보 진행?)

### 4. PLAN.md 초안 작성

`~/harness-meta/README.md` 템플릿 참고. 필수 섹션:

- (v1.83+ meta phase) **frontmatter** — `milestone: M{N}-{slug}` + `milestone-id: M{N}` + `phase: <n>` (PLAN.md 맨 앞 YAML)
- **세션 소속 근거** (S#/T# 명시, 3–5줄)
- **Scope inheritance (verbatim from 선행 세션)** — 선행 세션 sub-item 원문 인용. 이후 모든 구현은 이 목록에 매핑 가능해야 함 (**의무**, v1.10j). v1.83+ "선행 세션"은 "선행 phase OR 선행 milestone" 양쪽 가능
- **Out of scope (explicit rejection)** — 인접 발견 issue를 표로 명시. 빈 표 = "없음" 선언 (**의무**, v1.10j)
- **Spec verification (context7)** — 외부 spec drift 검증 표 5 sub-fields (library/topic/findings/drift/re-verify) + Citations 본문 list. drift=N/A 분기 시 모든 sub-field N/A (**의무**: sessions/meta/v1.24+ 및 sessions/<project>/v1.26+/v1.36+ + v1.83+ `milestones/M*/PLAN.md`). 상세: `~/harness-meta/bootstrap/docs/SPEC_VERIFICATION.md`
- **배경**: 이전 세션 링크 + 개선 동기
- **목표**: 체크박스 리스트
- **변경 대상**: 파일 경로 열거 (harness-meta repo 기준 + 필요 시 프로젝트 repo)
- **성공 기준**: 검증 가능한 체크박스
- (선택) **커밋 전략**, **후속 세션 연결**

두 섹션 규격 상세: `~/harness-meta/bootstrap/docs/OWNERSHIP.md` `## Scope contract`.
Spec verification § 규격 + SKILL `harness-plan-verify` 사용법: `~/harness-meta/bootstrap/docs/SPEC_VERIFICATION.md`.

**AskUserQuestion 자동 invoke**: 결정 분기점 발견 시 (예: 변경 파일 위치 / 정책 옵션 / 우선순위 충돌) 즉시 호출.

### 5. 다각적 병렬 검토 — 5 관점 subagent (가변, min 3, v1.36+)

PLAN 초안 작성 후 **다각적 병렬 검토**. 변경 파일 규모에 따라 가변:

| scope | 검토 관점 (병렬 실행) |
|------:|--------------------|
| 작음 (≤5 파일) | 3 관점 (① architecture / ② spec-drift / ⑤ scope contract) |
| 중간 (6~15) | 4 관점 (① architecture / ② spec-drift / ③ 회귀 / ⑤ scope contract) |
| 큼 (16+) | 5 관점 전체 |

**5 관점 매트릭스**:

| # | 관점 | agent type | 검토 포인트 |
|:-:|------|----------|-----------|
| 1 | architecture | `Plan` | 디렉토리 구조 / 파일 책임 / 변경 영향 |
| 2 | spec-drift | `general-purpose` (context7 invoke) | 외부 spec 정합 (Anthropic Claude Code docs) |
| 3 | 회귀 risk | `Explore` | 기존 smoke 21+ 영향 / verify.{ps1,sh} 영향 |
| 4 | 보안 | `general-purpose` (security-review SKILL invoke) | 새 SKILL의 side effect / 권한 / path traversal |
| 5 | scope contract | `Explore` | PLAN.md `Scope inheritance` ↔ 본문 매핑 / Out of scope verbatim 일치 |

**의견 충돌 처리**: 충돌 발견 시 `AskUserQuestion` 자동 invoke (각 충돌 1 question, 최대 4 question). 사용자 결정 → PLAN 갱신 → 단계 4 재진입.

### 6. Plan-verify (context7, v1.36+)

`harness-plan-verify` SKILL self-apply — PLAN의 `Spec verification (context7)` § sub-fields 5종 채우기 (library matrix lookup → topic 식별 → context7 query → drift 판정 → Citations 작성).

**AskUserQuestion 자동 invoke**: drift=yes 발견 시 (PLAN 수정? 사용자 무시?).

### 7. 사용자 PLAN 확정 + 진입 승인

5 관점 검토 + Plan-verify 결과 종합 → **AskUserQuestion** (항상 invoke)으로 승인 요청. 수정 사항 발견 시 PLAN 갱신 후 단계 4 재진입.

### 8. 구현 진행

- 사용자 논의 중심 (GSD Questioning 패턴) — main thread에서 처리
- `execute.py` 사용 안 함 (재귀 구조 회피)
- 각 작업 단위 커밋 (PLAN의 §"커밋 전략" 따름)
- harness-meta repo 변경은 **커밋 전 사용자 확인**

**AskUserQuestion 자동 invoke**: 구현 중 PLAN 외 의사결정 발견 시.

### 9. REPORT.md + ROADMAP 자동 갱신 (세션 종료 시, v1.36+)

#### 9-a. REPORT.md 작성

필수 섹션:

- **최종 결과**: 테스트 수, 신규 모듈, 변경 파일
- **구현 요약**: 각 목표 항목 → 실제 구현 + 커밋 해시
- **판정**: PLAN 체크박스 완수 여부
- **Spec verification (context7)** (**의무** v1.27+): 판정 § 직후. 5 sub-fields, drift=no/yes/N/A (post-hoc). 상세: `bootstrap/docs/SPEC_VERIFICATION.md §2-5`
- **Lessons Learned**
- **다음 후보 (보류)**

#### 9-b. ROADMAP 자동 갱신 (`harness-roadmap-update` SKILL invoke, v1.83+ 6-step)

REPORT 작성 직후 `harness-roadmap-update` SKILL 명시 invoke. SKILL이 6-step 진행 (v1.83+ frontmatter-insert 추가):

1. **Identify** — 본 세션 위치 / target ROADMAP 결정 (`sessions/meta/ROADMAP.md` 또는 `projects/<name>/ROADMAP.md` + v1.83+ `milestones/M{N}-{slug}/ROADMAP.md`)
2. **Validate (보안)** — `<name>` regex (`^[a-z0-9][a-z0-9_-]*$`) + realpath prefix 검증 + 메타 문자 차단 (v1.83+ M-번호 regex `^M[1-9][0-9]*$` 추가)
3. **Classify** — PLAN의 "Out of scope" 표 각 row를 5 trigger 종류 (A 외부 사용자 / B 회귀 / C 외부 환경 / D 설계 / E 정규화)에 매핑
4. **Sanitize** — ROADMAP 삽입 전 row 텍스트 sanitize (메타 문자 5종 fenced wrap + control character strip + 80 chars truncate)
5. **Update** — ROADMAP §"최근 완료" + §"Out of scope (trigger 대기)" + §"Schedule 후보" (해당 시) 갱신 + (v1.83+) milestone ROADMAP §"Phases" 표 갱신
6. **(v1.83+) Frontmatter-insert** — 신규 phase PLAN.md에 `milestone:` frontmatter 부재 시 자동 삽입 (idempotent, sed-based)

**AskUserQuestion 자동 invoke**: trigger 분류 애매 시.

#### 9-c. 프로젝트 추가/변경 시 체크리스트

- [ ] `~/harness-meta/projects/<name>/` **5종** 파일(ARCHITECTURE/DECISIONS/INTERVIEW/STACK/**ROADMAP** v1.36+) 작성·갱신
- [ ] `~/harness-meta/README.md` 대상 프로젝트 섹션 갱신 (신규 추가/삭제/이름 변경 시)
- [ ] 프로젝트 repo의 `.harness.toml` 최신 상태 확인

## AskUserQuestion 자동 invoke 운영 원칙 (v1.36+)

8단계 모두에서 결정 분기점 발견 시 자동 호출.

| 원칙 | 적용 |
|------|------|
| "결정 필요 → invoke" | 추론으로 단정 불가한 분기점 모두 |
| "애매하면 invoke" | 신뢰도 < 90% 시 (OWNERSHIP T5 답습) |
| 2~4 옵션 제시 | tool spec 한계 + 사용자 인지 부담 균형 |
| 첫 옵션 (Recommended) | 권장 명확 시만 |
| 단순 yes/no는 텍스트 | AskUserQuestion 남용 회피 |

**Trigger 매트릭스**:

| 단계 | invoke 조건 |
|:-:|-----------|
| 3 | 후보 0건 (새 발의) / 2건+ (어느 후보?) |
| 4 | PLAN 작성 중 결정 분기점 |
| 5 | 5 관점 의견 충돌 / 회귀 risk 발견 |
| 6 | drift=yes 발견 |
| 7 | 사용자 진입 승인 (항상) |
| 8 | 구현 중 PLAN 외 의사결정 |
| 9 | trigger 분류 애매 |

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

- `~/harness-meta/sessions/<target>/vX.Y/index.json`, `step{N}.md` 생성 (재귀 회피)
- `execute.py`를 하네스 개선에 호출 (GSD 부적합)
- 프로젝트 repo의 `phases/HARNESS_CHANGELOG.md` 신규 작성 (이건 레거시 보존용. 새 이력은 harness-meta/sessions/)

## 관련

- 구조 가이드: `~/harness-meta/README.md`
- `.harness.toml` 스펙: `~/harness-meta/bootstrap/manifest-schema.md`
- 철학·패턴: `~/harness-meta/bootstrap/docs/{PHILOSOPHY,PATTERNS}.md`
- 레거시 upbit 이력 (글로벌화 이전): `~/harness-meta/sessions/upbit/v1.1-legacy/ ~ v1.4-legacy/`
