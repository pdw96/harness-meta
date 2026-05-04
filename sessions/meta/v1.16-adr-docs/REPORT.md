# meta v1.16-adr-docs — REPORT

세션 완료: 2026-04-28
선행 세션: [`sessions/meta/v1.15-ai-ready-boost/`](../v1.15-ai-ready-boost/)

## 최종 결과

| 항목 | 결과 |
|------|------|
| AI-Ready 점수 | **78 → 84/100** (+6점) |
| 신규 파일 | 7 (docs/adr/ 6 + PLAN.md) |
| 수정 파일 | 2 (CLAUDE.md + score_codebase.py) |
| 버그 수정 | 2건 (Windows 경로 + Shell 테스트 인식) |

## 구현 요약

### Stage A~B — docs/adr/ 신설 (5건)

| 파일 | 내용 |
|------|------|
| `docs/adr/README.md` | ADR 인덱스 + 포맷 가이드 |
| `docs/adr/ADR-001-agents-md-source-of-truth.md` | AGENTS.md 단일 source of truth 결정 (v1.5) |
| `docs/adr/ADR-002-session-ownership-rules.md` | 세션 소속 S1–S7 + T1–T5 (v1.2) |
| `docs/adr/ADR-003-template-base-overlay.md` | `_base` + `<language>/` 2단계 배포 (v1.8, v1.11) |
| `docs/adr/ADR-004-permission-pattern.md` | `allowed-tools:` 6축 통합 (v1.10d, v1.10g) |
| `docs/adr/ADR-005-bootstrap-interview-flow.md` | 8-stage Bootstrap 흐름 (v1.10, v1.14) |

### Stage C — CLAUDE.md cross-ref

`docs/adr/README.md` 1줄을 "관련 문서" 섹션에 추가.

### Stage D — AI-Ready 스코어러 버그 2건

**버그 1 — Windows 경로 구분자** (`score_codebase.py:567`):

```python
# 수정: str(f) → f.as_posix()
ci_files = [f for f in tracked if ".github/workflows" in f.as_posix() ...]
```

- 원인: Windows에서 `str(Path(...))` = 백슬래시. `"/"` 포함 비교가 항상 False → `ci_files=[]` → CI 테스트 0점
- 효과: CI 테스트 자동화 0/2 → 2/2 (+2점)

**버그 2 — Shell 테스트 파일 미인식** (`score_codebase.py:472`):

```python
# 수정: tests/ 내 .sh 파일 포함
or (f.suffix == ".sh" and any(seg in f.parts for seg in ("test", "tests")))
```

- 원인: `test_*.py`, `*_test.py`, `*.spec.*` 패턴만 인식. `smoke-*.sh` 13개 누락
- 효과: 테스트 파일 2개 → 15개 (1/3 → 3/3, +2점)

## 점수 변동 상세

| 카테고리 | 이전 | 이후 | 변동 |
|---------|------|------|------|
| 문서화 | 12/15 | 12/15 | — |
| 코드 구조 | 11/15 | 11/15 | — |
| 타입 안전성 | 15/15 | 15/15 | — |
| **테스트 품질** | **7/15** | **11/15** | **+4** |
| **컨텍스트 레이어** | **13/15** | **15/15** | **+2** |
| 자동화 | 10/15 | 10/15 | — |
| 에이전틱 안전 | 10/10 | 10/10 | — |
| **합계** | **78** | **84** | **+6** |

## 판정

PLAN 체크박스 전원 완수.

- [x] `docs/adr/README.md` 생성
- [x] ADR-001~005 각 파일: 상태 "Accepted" + 세션 링크 + 결정/배경/결과 섹션
- [x] CLAUDE.md `docs/adr/` cross-ref 추가
- [x] `score_codebase.py`: `f.as_posix()` + `.sh` 테스트 인식
- [x] 재채점: 78 → 84/100 (목표 83 이상 달성)

## Lessons Learned

- **분석 전 구현 금지**: "진행"이라는 짧은 지시에 바로 구현하지 않고 "디테일하게 분석"을 먼저 수행한 결과, 진짜 누락(ADR)과 스코어러 버그 2건을 분리할 수 있었음. 분석 없이 진행했으면 scorer false negative를 실제 문제로 오인해 src/ 분리나 Dockerfile 추가 같은 불필요한 작업을 했을 것
- **Windows 경로 버그 패턴**: `str(Path)` 대신 `Path.as_posix()`는 Windows에서 경로 비교 시 기본 방어 패턴. 향후 scorer 확장 시 모든 경로 비교에 적용 의무
- **Shell repo 테스트 패턴**: `smoke-*.sh` 명명이 Python/JS 컨벤션과 다름. 향후 새 테스트 파일 추가 시 `test-*.sh` 또는 `test_*.sh`로 네이밍하면 기존 패턴과도 매칭됨

## 남은 과제 (Out of scope → 후속)

| 항목 | 현재 점수 | 후속 조건 |
|------|---------|---------|
| 테스트/소스 비율 (0/2) | Md repo라 소스 파일 0 → 비율 0 | 스코어러에 Md/Shell repo 예외 처리 추가 (evidence-driven) |
| 통합 테스트 (0/2) | `tests/integration/` 없음 | smoke 수 증가 시 자연 해소 가능 |
| Docker (0/2) | 해당 없음 | 불필요 |
| Lock file (0/1) | pyproject에 의존성 없음 | N/A |
