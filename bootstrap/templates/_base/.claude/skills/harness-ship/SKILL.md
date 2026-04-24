---
name: harness-ship-template
description: Harness REPORT.md 템플릿 + Goal-backward 검증 가이드. /harness-ship command가 Read하여 사용.
disable-model-invocation: true
---

# Harness REPORT.md Template

`/harness-ship` command의 10-3 단계에서 이 skill의 `report-template.md`를 Read하고
step-output.json + PLAN.md 요구사항을 기반으로 `phases/{version}/{phase-name}/REPORT.md`에 Write한다.

## 작성 순서

1. `report-template.md` Read
2. Goal-backward 검증 (10-1):
   - PLAN.md 각 요구사항 R1~Rn → Truth / Artifact / Wiring / Tests 역추적
   - VERIFIED / ORPHANED / STUB / MISSING 판정
   - `harness-verifier` subagent로 자동화 가능
3. `/harness-review` 5항목 실행 (10-2):
   - 아키텍처 / 기술 스택 / 테스트 / CRITICAL / 빌드
4. `step{N}-output.json`에서 비용/시간/turns/재시도 추출
5. Lessons Learned: 새 시도, 실패, 개선점
6. 테스트 변화: before / after / delta

## 치환 대상

- `{phase-name}`, `{version}`
- Goal-backward 표 행: 요구사항별
- 실행 결과 표 행: step별 (step-output.json 메타)
- /harness-review 결과 표
- 산출물 요약, Lessons Learned, 테스트 변화

## 관련 skill

- `harness-plan/SKILL.md` — PLAN.md 원본 (요구사항 역추적)
- `harness-design/SKILL.md` — 7-Dimension 검증 체크리스트
