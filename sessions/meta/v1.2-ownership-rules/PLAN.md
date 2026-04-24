# meta v1.2-ownership-rules — PLAN

세션 시작: 2026-04-24
선행 세션: [`sessions/meta/v1.1-global-smoke-test/`](../v1.1-global-smoke-test/REPORT.md)
목적: 하네스 관련 세션을 **어느 디렉토리에 귀속시킬지** 판단하는 규약을 명문화한다.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: `~/harness-meta/{README.md, CLAUDE.md (신규), bootstrap/docs/OWNERSHIP.md (신규), claude/commands/harness-meta.md}` → 전부 S1/S2/S3 (글로벌/repo-소유).
- **T1 경로 다수결** + **T2 스펙 범주** (분류 규약 자체가 meta repo의 스펙) → `sessions/meta/`.
- 본 PLAN이 정의하는 scope 분류(S#) 및 tie-breaker(T#)는 `bootstrap/docs/OWNERSHIP.md`가 최종 소스. 본 PLAN은 그 규약을 만드는 세션이므로 귀납적 자기참조 문제는 없음.

## 배경

v1.1 REPORT §판정 및 §Lessons Learned에 기록된 구조적 결함:

- `/harness-meta` command가 "세션 소속"을 **CWD basename** 기준으로 결정
- 실제 "소유권"은 **변경 대상이 속한 scope**여야 함 (CWD ≠ 변경 대상)
- v1.1 smoke test가 CWD=upbit에서 실행됐으나 대상은 글로벌 레이어 → 초기에 `sessions/upbit/`에 잘못 생성 후 `sessions/meta/`로 이동
- 이 분류 오류는 사용자 지적으로만 정정 가능했음 → 재발 방지용 규약 부재

본 세션은 그 규약(scope 분류 S1–S7 + tie-breaker T1–T5)을 단일 문서로 고정한다.

## 목표

- [ ] **Scope 분류 S1–S7** 명문화 (물리 경로 → 소유 세션 디렉토리)
- [ ] **Tie-breaker T1–T5** 명문화 (경계 케이스 판단 규칙)
- [ ] **PLAN 템플릿의 "세션 소속 근거" 섹션** 의무화 (모든 차후 PLAN 상단에 3줄 자체 판정)
- [ ] **Evolution 조항** — L3(코어 추출) 시 S5 재분류 예고
- [ ] `~/harness-meta/CLAUDE.md` 신규 — upbit/CLAUDE.md 스타일. repo 정체성·규칙·명령어·구조 요약 + `@bootstrap/docs/OWNERSHIP.md` import
- [ ] `~/harness-meta/README.md` 재작성 — 설명서 기조. "대상 프로젝트 목록" 제거, 설치·구조·사용법·트러블슈팅 중심
- [ ] `~/harness-meta/claude/commands/harness-meta.md` 갱신 — 기존 "대상 구분" 표 유지 + "세션 소속 판단" 소섹션 신설 + OWNERSHIP 링크
- [ ] 본 세션 REPORT 말미에 v1.1 사례를 **motivating example**로 명시 (과거 REPORT 불변)

## 범위

**포함**:
- S1–S7 / T1–T5 정의
- Evolution 조항 (L3 추출 시나리오)
- OWNERSHIP.md 단일 소스화 + README/CLAUDE/command에서 참조
- PLAN 템플릿에 "세션 소속 근거" 섹션 규격 추가

**제외**:
- 과거 세션(v1.0-bootstrap, v1.1-global-smoke-test, upbit 레거시 v1.1~v1.4) **사후 재분류·수정 없음** — 이미 올바른 위치로 이동 완료, 과거 REPORT는 불변
- 새 종류의 세션 유형 추가 (예: `sessions/shared/`) — 현 2축(meta / <project>) 유지
- `~/harness-meta/projects/upbit/` 내용 수정 — 본 규약의 meta scope 밖
- 프로젝트 repo(`upbit/` 등) 변경 — 본 세션은 `~/harness-meta/` repo만 건드림
- bootstrap/templates/ 언어별 뼈대 작성 (별도 세션 후보)
- `install.ps1` 수정 (별도 세션 후보)

## 변경 대상

### 신규 파일 (2)

| 경로 | scope | 역할 |
|------|-------|------|
| `~/harness-meta/CLAUDE.md` | S3 | repo 진입점. Claude Code가 세션 시작 시 자동 로드. upbit/CLAUDE.md 스타일로 작성. `@bootstrap/docs/OWNERSHIP.md` import |
| `~/harness-meta/bootstrap/docs/OWNERSHIP.md` | S2 | scope 분류 규약 단일 소스. S1–S7 + T1–T5 + Evolution + PLAN 템플릿 규격 |

### 수정 파일 (2)

| 경로 | scope | 변경 |
|------|-------|------|
| `~/harness-meta/README.md` | S3 | 설명서 기조로 재작성. "대상 프로젝트" 섹션 삭제. 설치·구조·사용법·트러블슈팅 중심. OWNERSHIP 1줄 언급 + 링크 |
| `~/harness-meta/claude/commands/harness-meta.md` | S1 | "대상 구분" 표는 유지. "세션 소속 판단" 소섹션 신설 (S/T 규약 요약 + 링크) |

### 세션 기록 (2)

| 경로 | 역할 |
|------|------|
| `~/harness-meta/sessions/meta/v1.2-ownership-rules/PLAN.md` | 본 파일 |
| `~/harness-meta/sessions/meta/v1.2-ownership-rules/REPORT.md` | 구현 후 작성 |

## Scope 분류 (S1–S7) — 결정 사항

| # | Scope | 물리 경로 | 소유 세션 |
|---|-------|----------|----------|
| S1 | 글로벌 UX | `~/harness-meta/claude/**` (commands·agents·skills·hooks·statusline·output-styles) | `sessions/meta/` |
| S2 | Bootstrap 자산 | `~/harness-meta/bootstrap/**` (manifest-schema, templates, interview, docs) | `sessions/meta/` |
| S3 | Repo 정책·설치 | `~/harness-meta/{README.md, CLAUDE.md, install.ps1}` | `sessions/meta/` |
| S4 | 프로젝트 아키텍처 문서 | `~/harness-meta/projects/<name>/**` (ARCHITECTURE·DECISIONS·INTERVIEW·STACK) | `sessions/<name>/` |
| S5 | 프로젝트 실행기 코드 | `<proj>/scripts/harness/**`, `scripts/tests/harness/**`, `scripts/execute.py` | `sessions/<name>/` |
| S6 | 프로젝트 매니페스트·Claude 설정 | `<proj>/{.harness.toml, .claude/, .mcp.json, docs/GUARDRAILS.md, docs/HARNESS.md}` | `sessions/<name>/` |
| S7 | **비즈니스 코드 (체계 외)** | `<proj>/{bot,core,config,infra,docs/core,docs/scope,…}` | meta 세션 대상 아님 (`/harness-plan`~`/harness-ship`) |

## Tie-breakers (T1–T5) — 결정 사항

| ID | 규칙 | 적용 |
|----|------|------|
| T1 | **경로 다수결** — 세션이 건드리는 파일의 scope 다수파가 소유. 동률 시 T2 적용 | 1차 판정 |
| T2 | **스펙 vs 값** — 스키마/규약은 meta, 해당 스펙의 인스턴스는 project | 스키마·규약 변경 시 |
| T3 | **검증 대상 기준** — 코드 수정 없는 검증 세션은 "검증 대상"의 소유자를 따름. CWD 무관 | v1.1 smoke test 패턴 |
| T4 | **크로스 커팅은 분할** — 스펙 변경 + 각 프로젝트 적용이 필요하면 두 세션(`sessions/meta/` + `sessions/<name>/`)으로 분리. 상호 링크 | `.harness.toml` schema bump |
| T5 | **애매하면 meta** — 어느 scope에도 명확히 속하지 않으면 meta. 빈틈 자체가 meta 개선 소재 | 신종 자산 도입 |

## Evolution 조항

- **L3 (코어 추출)**: 현재 `<proj>/scripts/harness/**`(S5)는 프로젝트 repo 소유. 향후 별도 repo로 추출 시 S5가 S1과 유사한 "글로벌 자산" 성격으로 승격될 수 있음 (H-ADR-001 트레이드오프).
- **규약 개정 트리거**: L3 시점에 본 OWNERSHIP.md 개정 세션(`sessions/meta/vX.Y-ownership-l3/`) 진행.
- **스키마 진화**: `.harness.toml schema_version = "1.0"` → "1.1" 이상 bump 시 T4에 따라 meta + 각 project 2 세션 분할.

## PLAN 템플릿 — "세션 소속 근거" 섹션 규격

차후 모든 PLAN.md 상단에 의무 배치. 형식:

```markdown
## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/{target}/`

**근거**:
- 변경 파일: <S# 분류>
- <T# 적용 내용>
```

- 3줄 이내 권장, 최대 5줄. 길어지면 규약 불명료 신호 → meta 개선 후보.
- "근거" 절에 **어떤 S#/T# 조합이 적용됐는지** 명시 — 사후 감사(audit) 가능.

## Grey Areas — 결정 (세션 내 논의 완료)

| ID | 질문 | 결정 |
|----|------|------|
| G1 | 매트릭스 배치 | 단일 소스 `bootstrap/docs/OWNERSHIP.md`. README는 설명서로 재작성 + 1줄 언급. CLAUDE.md 신설 후 `@bootstrap/docs/OWNERSHIP.md` import. `harness-meta.md` command는 요약 + 링크 |
| G2 | command 갱신 방식 | 기존 "대상 구분" 표 유지 + "세션 소속 판단" 소섹션 신설 |
| G3 | 과거 세션 retro-fitting | 수행 안 함. v1.2 REPORT에서 v1.1을 motivating example로만 언급 |
| G4 | PLAN 템플릿 강제 | 의무. "세션 소속 근거" 섹션 규격을 OWNERSHIP.md에 명시 |
| G5 | L3 추출 시 재분류 | Evolution 조항으로 명시 |

## 성공 기준

- [ ] `~/harness-meta/bootstrap/docs/OWNERSHIP.md` 신규 — S1–S7, T1–T5, Evolution, PLAN 템플릿 규격 4개 블록 모두 포함
- [ ] `~/harness-meta/CLAUDE.md` 신규 — upbit/CLAUDE.md와 구조 유사 (프로젝트 정체성 · 규칙 · 명령어 · 구조 · `@import`). `@bootstrap/docs/OWNERSHIP.md` 명시적 import
- [ ] `~/harness-meta/README.md` — "대상 프로젝트" 섹션 없음. "설치 → 구조 → 사용법 → 트러블슈팅" 순 설명서 구조. OWNERSHIP 1줄 언급 + 링크
- [ ] `~/harness-meta/claude/commands/harness-meta.md` — "세션 소속 판단" 소섹션 존재, OWNERSHIP.md 링크 존재. 기존 "대상 구분" 표 유지
- [ ] 본 PLAN의 self-apply 검증: 변경 4 파일 모두 S1/S2/S3 → T1 다수결로 meta 소유 (REPORT에서 재확인)
- [ ] REPORT 말미에 v1.1 smoke test 오분류 사례를 motivating example로 인용

## 커밋 전략

단일 커밋 제안. 4 파일 변경 + 세션 2 파일은 원자적 논리 단위.

```
docs(meta): sessions/meta/v1.2-ownership-rules — ownership S1–S7 / T1–T5 codification

- add: bootstrap/docs/OWNERSHIP.md (S1–S7 + T1–T5 + Evolution + PLAN 템플릿 규격)
- add: CLAUDE.md (upbit/CLAUDE.md 스타일, @bootstrap/docs/OWNERSHIP.md import)
- rewrite: README.md (설명서 기조, 대상 프로젝트 섹션 제거)
- update: claude/commands/harness-meta.md (세션 소속 판단 소섹션 신설)
- motivating example: v1.1-global-smoke-test 초기 오분류 사례
```

사용자 확인 후 `~/harness-meta` repo에 커밋.

## 후속 세션 연결

- **직접 연결**: 다음 PLAN부터 "세션 소속 근거" 섹션 자동 적용 대상
- **보류 후보**:
  - `sessions/meta/vX-bootstrap-templates/` — bootstrap/templates/ 뼈대 작성 (v1.0-bootstrap 범위 제외분)
  - `sessions/meta/vX-install-verify/` — install.ps1 post-install 자가 검증
  - `sessions/upbit/vX-milestone-status-sync/` — v1.1 REPORT KI-1 해결 (상위 phases/index.json 자동 전파)
- **Evolution 트리거 예고**: L3(코어 추출) 또는 `.harness.toml` schema bump 시점에 본 OWNERSHIP 개정 세션 별도 진행
