---
name: harness-plan-template
description: Harness PLAN.md 생성을 위한 템플릿과 작성 가이드. /harness-plan command가 Read하여 사용.
disable-model-invocation: true
---

# Harness PLAN.md Template

`/harness-plan` command의 4단계에서 이 skill의 `plan-template.md`를 Read하고
플레이스홀더를 치환하여 `phases/{version}/{phase-name}/PLAN.md`에 Write한다.

## 작성 순서

1. `plan-template.md` Read
2. `{version}`, `{phase-name}`, `{N}` 등 플레이스홀더 치환
3. 각 섹션 내용 채우기:
   - **현재 상태**: 테스트 수, 변경 대상 모듈 + 상태
   - **요구사항 표**: 기능별 AC + 우선순위 + 현재 코드 위치
   - **논의 결정 표**: 주제별 결정 + 근거
   - **Claude 재량 항목**: "네가 결정해" 사항 기록
   - **Step 설계 초안**: 단계별 모듈 + 책임 분할
   - **Grey Areas**: 모호하거나 추가 탐색 필요한 영역

## 작성 원칙

- **구체적으로**: "좋은 테스트" X → "테스트 31개 통과, coverage >80%" O
- **AC는 실행 커맨드** (예: `poetry run python -m pytest tests/test_X.py -v`; 실제 명령은 프로젝트 `.harness.toml [testing]` 또는 `CLAUDE.md` 참조)
- **우선순위 P0/P1/P2**: P0=필수 / P1=권장 / P2=선택
- **7-Dimension 검증 결과는 포함 금지** — 그건 `/harness-design` 산출물

## 관련 skill

- `harness-design/SKILL.md` — 7-Dimension 체크리스트
- `harness-ship/SKILL.md` — REPORT.md 템플릿 (phase 완료 보고)
