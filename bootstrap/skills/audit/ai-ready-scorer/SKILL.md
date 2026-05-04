---
name: ai-ready-scorer
description: |
  임의의 git 리포지토리를 AI-Ready 루브릭(100점, 7개 카테고리)으로 감사하고 JSON 점수표 + 한국어 HTML 대시보드 + ROI 우선순위 액션 리스트를 산출한다.

  **TRIGGER**: 다음 상황에서 반드시 이 스킬을 사용:
  - "AI-Ready 점수", "AI 준비도", "codebase audit", "AI-readiness score", "코드베이스 감사"
  - "이 리포지토리 AI-Ready한지 봐줘", "우리 코드 AI 에이전트가 잘 다룰 수 있어?"
  - "코드베이스 점수 매겨줘", "어떤 부분을 고쳐야 AI가 잘 쓸 수 있어?"
  - "AI 친화적 코드베이스인지", "Claude/Cursor/Copilot가 잘 이해할 수 있는 구조?"
  - CI 파이프라인이나 pre-commit에서 AI-readiness 게이트 추가 요청
---

# AI-Ready Codebase Scorer

임의의 git 리포지토리를 7개 카테고리 100점 루브릭으로 감사하고 세 가지 산출물을 생성한다:

1. `ai-ready-report.json` — 기계 판독 가능한 점수표
2. `ai-ready-dashboard.html` — 한국어 HTML 대시보드 (레이더 차트 + 카테고리 카드)
3. 대화에 ROI 우선순위 액션 리스트 출력

## 7개 카테고리

| # | 카테고리 | 만점 | 핵심 질문 |
|---|---------|------|---------|
| 1 | 문서화 | 15 | README·CLAUDE.md·docstring이 AI가 읽기에 충분한가? |
| 2 | 코드 구조 | 15 | 모듈 경계가 명확하고 파일이 적정 크기인가? |
| 3 | 타입 안전성 | 15 | 타입 힌트·스키마가 AI의 추론을 돕는가? |
| 4 | 테스트 품질 | 15 | AI가 변경 후 회귀를 감지할 수 있는가? |
| 5 | 컨텍스트 레이어 | 15 | CLAUDE.md·가드레일·ADR이 에이전트 행동을 안내하는가? |
| 6 | 자동화 | 15 | CI·lint·pre-commit이 AI 실수를 자동 차단하는가? |
| 7 | 에이전틱 안전 | 10 | .env 노출·위험 명령 차단·권한 제어가 있는가? |

상세 기준: `references/rubric.md` 참조.

## 워크플로우

### 1단계 — 레포 경로 확인

사용자가 경로를 지정하지 않으면 현재 작업 디렉토리를 사용한다. 경로가 git 리포지토리인지 확인:

```bash
git -C <repo_path> rev-parse --is-inside-work-tree 2>/dev/null
```

git 리포지토리가 아니면 사용자에게 알리고 중단한다.

### 2단계 — 스코어링 스크립트 실행

```bash
python3 <skill_dir>/scripts/score_codebase.py <repo_path> --output-dir <repo_path>
```

`<skill_dir>`는 이 SKILL.md가 있는 디렉토리다. Windows에서는 `python` 명령을 시도한다.

스크립트가 두 파일을 생성한다:

- `<repo_path>/ai-ready-report.json`
- `<repo_path>/ai-ready-dashboard.html`

### 3단계 — 결과 요약 출력

JSON을 읽어 다음 형식으로 대화에 출력한다:

```
## 🎯 AI-Ready 점수: XX/100 (등급: A)

| 카테고리 | 점수 | 만점 | 등급 |
|---------|------|------|------|
| 문서화  | 12   | 15   | A    |
...

📊 대시보드: ai-ready-dashboard.html (브라우저에서 열기)
```

### 4단계 — ROI 액션 리스트 출력

JSON의 `roi_actions` 배열에서 상위 5개를 출력한다:

```
## 🚀 ROI 우선순위 액션 TOP 5

1. [즉시/3점] CLAUDE.md 생성 — AI 에이전트 행동 가이드 부재. 1시간 내 생성 가능.
2. [즉시/2점] .env.example 추가 — 비밀 키 노출 위험 차단.
...
```

ROI 컬럼 설명:

- **즉시/단기/중기**: 구현 난이도 (파일 생성 / 설정 / 리팩토링)
- **N점**: 이 조치로 회복되는 점수

### 5단계 — 대시보드 열기 (선택)

사용자에게 브라우저에서 `ai-ready-dashboard.html`을 열겠냐고 묻는다. 원하면:

```bash
# Windows
start <repo_path>/ai-ready-dashboard.html
# macOS
open <repo_path>/ai-ready-dashboard.html
# Linux
xdg-open <repo_path>/ai-ready-dashboard.html
```

## 출력 파일 위치

기본값: 리포지토리 루트. `--output-dir`로 변경 가능.

## CI 게이트 모드

사용자가 "CI에서 점수 X점 미만이면 실패" 같은 요청을 하면:

```bash
python3 score_codebase.py <repo_path> --gate 70
# 70점 미만이면 exit code 1 반환
```

## 주의사항

- 스크립트는 읽기 전용 분석만 수행 (파일 수정 없음)
- 대용량 리포 (파일 >10,000개)는 분석에 수 초 소요됨
- 언어 미지원 시 해당 카테고리 일부 체크 skip (점수에 명시)
