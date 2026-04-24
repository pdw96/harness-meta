---
name: harness-design-7d-checklist
description: Harness 7-Dimension 검증 체크리스트. /harness-design command가 Read하여 step 파일 설계 시 7D 평가.
disable-model-invocation: true
---

# Harness 7-Dimension Checklist

Phase 설계 시 각 step이 아래 7개 차원에서 PASS/FAIL/근거를 명시해야 한다.

## 사용 순서

1. 각 step.md 작성 완료 후 step 본문 끝에 `## 7-Dimension 검증` 섹션 추가
2. `7d-checklist.md` Read하여 각 차원별 항목 체크
3. FAIL 항목은 근거와 함께 기록 → Revision Gate (최대 3회) 후 Escalation

## Revision Gate

- FAIL 발견 시 → step.md 수정 → 재검증 (최대 3회)
- 3회 초과 → Escalation (사용자 판단 요청)

## 기록 위치

- **step별**: 각 `step{N}.md` 말미에 결과 표
- **phase 전체**: `/harness-ship`에서 `REPORT.md`에 누적

## 관련 skill

- `harness-plan/SKILL.md` — PLAN.md 템플릿 (요구사항)
- `harness-ship/SKILL.md` — REPORT.md 템플릿 (최종 결과)
