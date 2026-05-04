# meta v1.13-opensource-entry — PLAN

세션 시작: 2026-04-28
선행 세션: [`sessions/meta/v1.12-base-skills-i18n/`](../v1.12-base-skills-i18n/PLAN.md) — _base + python overlay 전체 영문화

목적: 오픈소스 방문자(GitHub 방문자, 비Claude 사용자, 잠재 기여자)가 repo를 이해하고 사용할 수 있는 **영문 진입점** 완비. `README.md` 영문 재작성 + `AGENTS.md` 최신화.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S3(2) `README.md` + `AGENTS.md` = **2/2 meta** (repo 정책·설명서)
- **T1 경로 다수결** — S3 전건
- **T2 스펙 vs 값** — repo 공개 문서 = 모든 사용자/기여자에 영향 → meta

## Scope inheritance (verbatim from 사용자 발의)

**Source — 사용자 발의 (2026-04-28) verbatim**:

> "다 해야할거같은데" (오픈소스 multi-language 호환 맥락 — v1.12, v1.13, v1.14)

**Parsed sub-items (2)**:

1. **`README.md` 영문 재작성** — 현재 한국어 README를 영문으로 재작성. 오픈소스 방문자 진입점.
2. **`AGENTS.md` 최신화** — v1.11b(python overlay), v1.12(i18n), language overlay 시스템 반영 + 기여자 안내 보강.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `CLAUDE.md` 영문화 | 한국어 유지 (Claude Code 전용 상세 가이드 — 사용자 작업 언어) |
| `bootstrap/docs/*.md` 영문화 | 별도 세션 (관리자 문서 — evidence-driven) |
| `CONTRIBUTING.md` / `SECURITY.md` / `.github/` 작성 | AGENTS.md에서 v1.25 예정으로 명시됨 — evidence-driven |
| v1.14 Bootstrap 단순화 | 후속 세션 |

## 1. 변경 내용 설계

### 1-1. README.md — 영문 재작성

**전략**: 기존 한국어 README를 대체하는 영문 README 작성. `CLAUDE.md`가 한국어 상세 운영 가이드이므로 README는 **오픈소스 방문자용** 역할에 집중.

**구조** (기존 12개 섹션 → 8개로 축약):

1. **What is this** — 1단락 개요
2. **Requirements** — 최소 요구사항 (cross-platform: Windows primary, macOS/Linux secondary)
3. **Installation** — 2-stage install (Global + Per-project)
4. **Directory layout** — 구조 요약
5. **Activating a project** — `.harness.toml` 최소 예시
6. **Usage** — 명령 표 (harness-plan ~ harness-ship + harness-meta)
7. **Language overlay** (v1.11+) — Python + 추가 언어 overlay 소개
8. **Key docs** — 링크 목록
9. **License** — MIT

**언어 정책**:

- README.md → 영문 (오픈소스 표준)
- 기존 한국어 내용은 `CLAUDE.md`에 이미 포함 → README.ko.md 별도 생성 **안 함** (중복 관리 부담)

### 1-2. AGENTS.md — 최신화

**갱신 항목**:

| 현재 | 갱신 내용 |
|------|---------|
| Commands: `_base/.claude/` 17 파일 | 파일 수 업데이트 (v1.8b skills migration 이후) |
| Project structure: `claude/` 섹션 | language overlay (v1.11+) 추가 |
| Key docs: 최신 세션 항목 | v1.12-base-skills-i18n으로 업데이트 |
| (없음) | `bootstrap/docs/OVERLAY.md` 추가 |
| (없음) | Python overlay (`harness-python`) 언급 추가 |
| Boundaries | 최신 가이드라인 확인 |
| Status | v1.25 기여 예정 여전히 유효 확인 |

## 2. 변경 대상 (2 수정)

| 경로 | scope | 변경 |
|------|------|------|
| `README.md` | S3 | 한국어 전체 → 영문 재작성 |
| `AGENTS.md` | S3 | 최신 변경사항 반영 + 기여자 안내 보강 |

## 3. 성공 기준

- [ ] `README.md` 영문으로 재작성 완료
- [ ] `README.md`: 설치 가이드 (2-stage), 디렉토리 구조, language overlay, key docs 포함
- [ ] `AGENTS.md`: v1.11b/v1.12 반영, Python overlay 언급, OVERLAY.md 링크
- [ ] `AGENTS.md`: 최신 세션 링크 업데이트
- [ ] 한국어 잔존: README에 0건 (AGENTS.md는 기존부터 영문)
