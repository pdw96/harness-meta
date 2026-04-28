# meta v1.16-adr-docs — PLAN

세션 시작: 2026-04-28
직접 선행 세션: [`sessions/meta/v1.15-ai-ready-boost/`](../v1.15-ai-ready-boost/PLAN.md) — AI-Ready 스킬 신설

목적: AI-Ready 감사(2026-04-28, 78/100) 결과 기반 두 가지 개선 동시 진행:
1. `docs/adr/` 신설 — harness-meta 핵심 결정 5건 ADR 형식 기록 (+2점)
2. AI-Ready 스코어러 버그 2건 수정 — Windows 경로 구분자 + Shell 테스트 인식 (+3점)

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S3(7) `docs/adr/*` + S3(1) `CLAUDE.md` + S1a(1) `~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py` = 9건
- **T1 경로 다수결** — S3 8/9, S1a 1/9 → 전부 meta scope
- **T5** — `~/.claude/skills/` 수정은 S1a 근접(글로벌 레이어) → 기본값 meta

## Scope inheritance (verbatim from 선행 세션 + 사용자 발의)

**Source 1 — 2026-04-28 AI-Ready 감사 결과 (verbatim)**:
> "ADR 문서 추가 [단기/2점] docs/ADR.md 또는 docs/adr/ 디렉토리에 핵심 아키텍처 결정 기록"

**Source 2 — 2026-04-28 사용자 발의 "다 같이" (verbatim)**:
> "다 같이" — (디테일 분석 후) ADR + 스코어러 버그 2건 동시 진행

**Parsed sub-items (4)**:

1. **`docs/adr/` + ADR-001~005** — harness-meta 핵심 결정 5건 ADR 형식 기록
2. **CLAUDE.md cross-ref** — `docs/adr/` 1줄 추가
3. **스코어러 Windows 경로 구분자 버그** — `str(f)` → `f.as_posix()` (CI 탐지 실패 수정)
4. **스코어러 Shell 테스트 파일 인식** — `tests/`의 `.sh` 파일을 test_files에 포함

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `tests/integration/` 추가 — shell repo에 통합 테스트 개념 모호 | 후속 미정 |
| `src/` 디렉토리 분리 — Markdown/Shell repo 구조상 부적합 | 해당 없음 |
| Lock file 추가 — pyproject.toml에 실제 의존성 없음 | 해당 없음 (N/A) |
| Docker 컨테이너화 — 이 repo 성격상 불필요 | 해당 없음 |
| 테스트 파일 15개 달성 — 13개 smoke 파일, threshold 미달은 실제 한계 | 후속 smoke 추가 시 자연 해소 |
| 스코어러 언어 탐지 개선 (Md 리포 처리) | 후속 evidence-driven |

## 1. 배경

### AI-Ready 감사 분석 (2026-04-28)

상세 분석에서 발견된 실제 상황:

| 항목 | 보고된 점수 | 실제 원인 | 분류 |
|------|---------|---------|------|
| CI 테스트 없음 | 0/2 | `str(f)` Windows 백슬래시 vs `/` 미매칭 → `ci_files=[]` | **스코어러 버그** |
| 테스트 2개 | 1/3 | `smoke-*.sh` 13개가 `test_*/spec.*` 패턴 미매칭 | **스코어러 버그** |
| ADR 없음 | 0/2 | `docs/adr/`, `DECISIONS.md` 루트 없음 | **실제 누락** |
| src/ 없음 | 1/3 | Shell/Docs repo에 src/ 불필요 | 개념 미스매치 |
| Lock file 없음 | 0/1 | pyproject.toml에 dependencies 없음 | N/A |

### 스코어러 버그 상세

**버그 1 — Windows 경로 구분자** (`score_codebase.py:565`):
```python
# 현재 (잘못됨)
ci_files = [f for f in tracked if ".github/workflows" in str(f)]
# Windows에서 str(f) = "C:\\...\\harness-meta\\.github\\workflows\\ci.yml"
# → "/" 구분자가 "\" 경로에서 불일치 → ci_files = []

# 수정
ci_files = [f for f in tracked if ".github/workflows" in f.as_posix() or ".gitlab-ci" in f.as_posix()]
# f.as_posix() = 항상 "/"로 정규화
```

**버그 2 — Shell 테스트 파일 인식** (`score_codebase.py:472-477`):
```python
# 현재 — Python/JS 패턴만
test_files = [f for f in tracked
    if (f.name.startswith("test_") or f.name.endswith("_test.py")
        or "_test." in f.name or "spec." in f.name)]
# smoke-*.sh 13개 전부 누락

# 수정 — tests/ 디렉토리 내 .sh 추가
test_files = [f for f in tracked if f.is_file() and (
    f.name.startswith("test_") or f.name.endswith("_test.py")
    or "_test." in f.name or f.name.startswith("test.") or "spec." in f.name
    or (f.suffix == ".sh" and any(seg in f.parts for seg in ("test", "tests")))
)]
```

### ADR 필요성

harness-meta의 핵심 결정(AGENTS.md 채택, 세션 소속 규약, Permission 패턴 등)이 session PLANs에 분산.
`docs/adr/`으로 AI 에이전트가 단일 경로에서 과거 결정을 탐색 가능하게 함.
현재 `docs/`에는 `ARCHITECTURE.md`만 존재.

## 2. ADR 대상 5건

| # | 파일 | 핵심 결정 | 확정 세션 |
|---|------|---------|---------|
| ADR-001 | `agents-md-source-of-truth.md` | AGENTS.md를 프로젝트 컨텍스트 단일 source of truth 채택 | v1.5 |
| ADR-002 | `session-ownership-rules.md` | 세션 소속 S1–S7 + T1–T5 규약 | v1.2 |
| ADR-003 | `template-base-overlay.md` | `_base` + `<language>/` overlay 2단계 배포 구조 | v1.8 + v1.11 |
| ADR-004 | `permission-pattern.md` | frontmatter `allowed-tools:` 6축 통합 | v1.10d + v1.10g |
| ADR-005 | `bootstrap-interview-flow.md` | 8-stage Bootstrap 인터뷰 + 자동 적용 10건 | v1.10 + v1.14 |

## 3. 변경 대상

### harness-meta repo (신규 7 + 수정 1)

| 경로 | 변경 |
|------|------|
| `docs/adr/README.md` | 신규 — ADR 인덱스 + 포맷 가이드 |
| `docs/adr/ADR-001-agents-md-source-of-truth.md` | 신규 |
| `docs/adr/ADR-002-session-ownership-rules.md` | 신규 |
| `docs/adr/ADR-003-template-base-overlay.md` | 신규 |
| `docs/adr/ADR-004-permission-pattern.md` | 신규 |
| `docs/adr/ADR-005-bootstrap-interview-flow.md` | 신규 |
| `CLAUDE.md` | 수정 — "관련 문서" § `docs/adr/` 1줄 추가 |

### 스코어러 스킬 (수정 1)

| 경로 | 변경 |
|------|------|
| `~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py` | 버그 2건: `str(f)→f.as_posix()` + `.sh` 테스트 인식 |

## 4. 목표

- [ ] Stage A — `docs/adr/README.md` 생성
- [ ] Stage B — ADR-001~005 생성
- [ ] Stage C — `CLAUDE.md` cross-ref 추가
- [ ] Stage D — 스코어러 버그 2건 수정
- [ ] Stage E — AI-Ready 재채점 검증
- [ ] Stage F — REPORT.md 작성 + 커밋

## 5. 성공 기준

- [ ] `docs/adr/README.md` 존재
- [ ] ADR-001~005 각 파일: 상태 "Accepted" + 세션 링크 + 결정/배경/결과 3섹션
- [ ] CLAUDE.md `docs/adr/` cross-ref 1줄
- [ ] `score_codebase.py`: `f.as_posix()` 사용 + `.sh` 테스트 인식
- [ ] 재채점: 78 → 83/100 이상 (ADR+2 + CI+2 + 테스트카운트+1)

## 6. 커밋 전략

단일 커밋:
```
docs(meta): v1.16-adr-docs — docs/adr/ 5건 + ai-ready-scorer 버그 2건 수정

harness-meta:
- add: docs/adr/{README.md, ADR-001~005} (핵심 결정 5건)
- update: CLAUDE.md (관련 문서 § docs/adr/ 추가)

ai-ready-scorer 스킬:
- fix: Windows 경로 구분자 str(f) → f.as_posix() (CI 탐지 버그)
- fix: tests/*.sh를 test_files에 포함 (smoke 13개 누락 버그)

AI-Ready 78 → 83점 목표
```
