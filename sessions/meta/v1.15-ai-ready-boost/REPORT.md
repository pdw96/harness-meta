# meta v1.15-ai-ready-boost — REPORT

세션 종료: 2026-04-28
직접 선행: `/ai-ready-scorer` 결과 (53/100, 등급 C) + [`v1.14-bootstrap-simplify/`](../v1.14-bootstrap-simplify/REPORT.md)

## 최종 결과

| 항목 | 수치 |
|------|------|
| 신규 파일 | 7 |
| 수정 파일 | 3 |
| Smoke 회귀 | 0 / 13 (PASS 13/13) |
| AI-Ready 예상 회복 | +11점 (53 → 64+) |
| 변경 scope | S3 단일 (메타 repo 정책·설치 영역) |

## 구현 요약

| Stage | 산출 | 비고 |
|------|------|------|
| A | `.github/workflows/ci.yml` | smoke 13건 자동 실행 (push + PR), bash 4+ 검증, ubuntu-latest, timeout 10min |
| B | `.pre-commit-config.yaml` + `.markdownlint.json` + `.markdownlintignore` | shellcheck (severity warning) + markdownlint. I1: MD041 disable + frontmatter 디렉토리 3종 ignore. I2: mixed-line-ending hook 자체 제거 (.gitattributes 정합) |
| C | `GUARDRAILS.md` | 6 § (목적 / 금지 H1-H9 9 / 위험 C1-C8 8 / Scope contract / Smoke / References) + Evolution 조항 |
| D | `.env.example` + `.gitignore` `.env` append | `HARNESS_META_ROOT` 단일 변수 + 사용처 명시 (install/hook/statusline/tests) |
| E | `CHANGELOG.md` | Keep a Changelog 1.1.0 + SemVer (영문, I5). v1.0~v1.14 highlight 추출 + Unreleased 섹션 |
| F | `README.md` + `AGENTS.md` 갱신 | I3 — README "Optional dev tooling" 섹션 신설 (영문, pre-commit + CI + .env). I4 — AGENTS.md "Project structure" 섹션에 GUARDRAILS/CHANGELOG/.github/.pre-commit-config/.env.example 5건 cross-ref + "Latest meta session" v1.15 갱신 |
| G | Smoke 회귀 | 13/13 PASS (HARNESS_META_ROOT=$PWD 환경변수 export 후) |

## 판정

PLAN.md 5 성공 기준 모두 충족:

- [x] `.github/workflows/ci.yml` 존재 + smoke 13건 자동 호출 (`for f in tests/smoke-*.sh`)
- [x] `.pre-commit-config.yaml` + `.markdownlint.json` + `.markdownlintignore` 존재 (I1+I2 반영)
- [x] `GUARDRAILS.md` 존재 + 6 § 작성
- [x] `.env.example` 존재 + `HARNESS_META_ROOT` 명시 (영문)
- [x] `CHANGELOG.md` 존재 + Keep a Changelog 형식 (영문)
- [x] `README.md` pre-commit 안내 (영문) + GUARDRAILS/CHANGELOG cross-ref
- [x] `AGENTS.md` GUARDRAILS/CHANGELOG/CI cross-ref 추가
- [x] `.gitignore` `.env` append
- [x] 기존 smoke 13건 회귀 0
- [ ] AI-Ready 재측정 — 사용자 확인 후 `/ai-ready-scorer` 재실행 (커밋 전후 변동 가능)

## 변경 파일 매트릭스

| 분류 | 파일 | scope | 라인 수 (대략) |
|------|------|------|---------------|
| 신규 | `.github/workflows/ci.yml` | S3 | 50 |
| 신규 | `.pre-commit-config.yaml` | S3 | 30 |
| 신규 | `.markdownlint.json` | S3 | 11 |
| 신규 | `.markdownlintignore` | S3 | 8 |
| 신규 | `GUARDRAILS.md` | S3 | 100 |
| 신규 | `.env.example` | S3 | 11 |
| 신규 | `CHANGELOG.md` | S3 | 80 |
| 수정 | `README.md` | S3 | +20 (Optional dev tooling 섹션 + Key docs 2 행) |
| 수정 | `AGENTS.md` | S3 | +8 (Project structure 5 행 + Key docs 3 행) |
| 수정 | `.gitignore` | S3 | +5 (.env 항목) |

## Lessons Learned

### L1 — AI-Ready 스코어러는 일반 코드 레포 가정. 메타 repo는 Out of scope 표가 영구 기록 역할

스코어러가 `pyproject.toml` / Docker / `src/` / 통합 테스트 등을 권고했으나, 메타 repo는 markdown+shell 중심 → 부적용. **Out of scope 표가 "이 항목은 본 repo에 부적용임"을 영구 기록**. 향후 v1.X 세션에서 동일 권고 발생 시 본 PLAN의 Out of scope 표를 1차 참조 가능.

### L2 — pre-commit 설계 시 `.gitattributes` 정합 의무

초기 PLAN은 `mixed-line-ending --fix=lf` 포함 → `.gitattributes`의 `*.ps1 text eol=crlf`와 충돌. 검토 단계 (I2)에서 사전 발견 → hook 자체 제거. **교훈**: 신규 lint/format 도구 도입 시 기존 `.gitattributes` / `.editorconfig` 정합 필수.

### L3 — Markdownlint MD041은 frontmatter-기반 파일에 부적합

Claude Code의 SKILL.md / agent.md / output-style.md는 YAML frontmatter (`---`)로 시작 = MD041 위반. 17 파일이 영향받음 → MD041 disable + `.markdownlintignore`로 frontmatter 디렉토리 명시 제외 (이중 보호). **교훈**: Anthropic 공식 frontmatter 포맷과 markdownlint 기본 룰 충돌 — 신규 frontmatter 디렉토리 추가 시 ignore append 의무 (GUARDRAILS R3 가이드).

### L4 — CHANGELOG.md vs sessions/ 보완 관계

sessions/ = audit trail (Claude 관점, 한국어). CHANGELOG.md = 사용자 highlight (외부 소비자 관점, 영문). 둘 다 필요 — sessions/는 검색 진입점, CHANGELOG는 단일 진입점. **L4 인스턴스**: AGENTS.md "Latest meta session" 행은 매 세션 갱신 의무 (본 세션도 v1.14 → v1.15 갱신). 향후 자동화 (release-please / git-cliff)는 v1.15b+.

### L5 — GUARDRAILS는 PLAN.md "세션 소속 근거" 섹션과 commands → skills 표준 채택의 자연스러운 연장

기존 mechanism (OWNERSHIP.md S#/T#, Scope contract, PERMISSION_PATTERN.md frontmatter)이 산재 → 단일 진입점 GUARDRAILS.md로 통합. 신규 룰 추가 비용은 낮으나 **금지/위험 분류 이분법 (Hard rule vs Confirmation)**이 핵심 — Hard rule은 무조건 거부, Confirmation은 PLAN 명시 후 진행.

## 다음 후보 (보류)

| 후속 세션 | 트리거 조건 |
|-----------|------------|
| `v1.15b-changelog-automation` | CHANGELOG.md 수동 운영 3+ 세션 누적 후 release-please 또는 git-cliff 도입 |
| `v1.15c-ci-windows-runner` | `install-project-claude.ps1` 회귀 의심 evidence 누적 시 |
| `v1.15d-ci-fixture-cache` | smoke 13건 누적 시간 1+ 분 도달 시 actions/cache 도입 |
| `v1.15e-guardrails-evolution` | Hard/Confirmation rule 위반 사례 발생 시 신규 룰 추가 |
| `v1.21-cross-platform-install` | verify.ps1에 CI/pre-commit 검증 통합 |

## 후속 안내

- **사용자 액션**:
  1. (선택) `pip install pre-commit && pre-commit install` — 로컬 commit-time 검증 활성화
  2. (선택) `/ai-ready-scorer` 재실행으로 점수 회복 확인 (53 → 64+ 예상)
  3. 커밋 전 본 REPORT.md 검토 + `git status` 확인
- **CI 활성화**: 본 PR이 main에 merge되는 시점부터 push/PR마다 smoke 자동 실행
- **GUARDRAILS 적용**: 차기 meta 세션부터 PLAN.md 작성 시 GUARDRAILS H1-H9 / C1-C8 자동 참조 의무
