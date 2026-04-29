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

## 절차 — 일반 (개선 모드)

### 1. 다음 버전 결정

`~/harness-meta/sessions/<target>/` 디렉토리 스캔 → 최신 버전 + 1 (minor bump 기본).
하위 호환 깨지면 major bump.

Argument로 version 명시 가능: `/harness-meta <name> v1.3-refactor`. 없으면 자동.

### 2. `~/harness-meta/sessions/<target>/vX.Y-{name}/` 생성

```bash
mkdir -p ~/harness-meta/sessions/<target>/v1.3-{name}
```

`{name}`은 kebab-case slug. 변경 핵심 주제 요약.

### 3. PLAN.md 작성

`~/harness-meta/README.md` 템플릿 참고. 필수 섹션:

- **세션 소속 근거** (S#/T# 명시, 3–5줄)
- **Scope inheritance (verbatim from 선행 세션)** — 선행 세션 sub-item 원문 인용. 이후 모든 구현은 이 목록에 매핑 가능해야 함 (**의무**, v1.10j)
- **Out of scope (explicit rejection)** — 인접 발견 issue를 표로 명시. 빈 표 = "없음" 선언 (**의무**, v1.10j)
- **Spec verification (context7)** — 외부 spec drift 검증 표 5 sub-fields (library/topic/findings/drift/re-verify) + Citations 본문 list. drift=N/A 분기 시 모든 sub-field N/A (**의무**: sessions/meta/v1.24+ 및 sessions/<project>/v1.26+). 상세: `~/harness-meta/bootstrap/docs/SPEC_VERIFICATION.md`
- **배경**: 이전 세션 링크 + 개선 동기
- **목표**: 체크박스 리스트
- **변경 대상**: 파일 경로 열거 (harness-meta repo 기준 + 필요 시 프로젝트 repo)
- **성공 기준**: 검증 가능한 체크박스
- (선택) **커밋 전략**, **후속 세션 연결**

두 섹션 규격 상세: `~/harness-meta/bootstrap/docs/OWNERSHIP.md` `## Scope contract`.
Spec verification § 규격 + SKILL `harness-plan-verify` 사용법: `~/harness-meta/bootstrap/docs/SPEC_VERIFICATION.md`.

### 4. 구현 진행

- 사용자 논의 중심 (GSD Questioning 패턴) — main thread에서 처리
- `execute.py` 사용 안 함 (재귀 구조 회피)
- 각 작업 단위 커밋
- harness-meta repo 변경은 **커밋 전 사용자 확인**

### 5. REPORT.md 작성 (세션 종료 시)

필수 섹션:
- **최종 결과**: 테스트 수, 신규 모듈, 변경 파일
- **구현 요약**: 각 목표 항목 → 실제 구현 + 커밋 해시
- **판정**: PLAN 체크박스 완수 여부
- **Lessons Learned**
- **다음 후보 (보류)**

### 6. 프로젝트 추가/변경 시 체크리스트

- [ ] `~/harness-meta/projects/<name>/` 4종 파일(ARCHITECTURE/DECISIONS/INTERVIEW/STACK) 작성·갱신
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

- `~/harness-meta/sessions/<target>/vX.Y/index.json`, `step{N}.md` 생성 (재귀 회피)
- `execute.py`를 하네스 개선에 호출 (GSD 부적합)
- 프로젝트 repo의 `phases/HARNESS_CHANGELOG.md` 신규 작성 (이건 레거시 보존용. 새 이력은 harness-meta/sessions/)

## 관련

- 구조 가이드: `~/harness-meta/README.md`
- `.harness.toml` 스펙: `~/harness-meta/bootstrap/manifest-schema.md`
- 철학·패턴: `~/harness-meta/bootstrap/docs/{PHILOSOPHY,PATTERNS}.md`
- 레거시 upbit 이력 (글로벌화 이전): `~/harness-meta/sessions/upbit/v1.1-legacy/ ~ v1.4-legacy/`
