---
name: harness-design
description: Harness 5~7단계 — 설계→7-Dimension 검증→step 파일 생성
tools: Read, Glob, Grep, Write(phases/**), Edit(phases/**), Bash(ls*)
model: opus
thinking: high
---

Harness 5~7단계: Phase 설계 → 7-Dimension 검증 → 파일 생성

**오케스트레이터**: 경량 조율자. 무거운 분석/파일 생성은 Agent(model="opus")로 위임.

## Pre-flight Gate

1. `phases/{version}/{phase}/PLAN.md` 존재 → 없으면 `/harness-plan`
2. PLAN.md "Step 설계 초안" 섹션 확인 → 헤더만 있고 본문 없음(빈 줄/리스트 0개) → `/harness-plan`
3. `phases/ROADMAP.md` Lessons Learned Read → 과거 교훈 반영
4. 기존 `step*.md`가 이미 있으면 → 사용자에게 "재생성? (덮어쓰기)" 확인 후 진행

## Context Budget
- PLAN.md 요약 + 필요한 파일만 Read
- step.md 생성은 Agent(model="opus")에 위임하여 메인 컨텍스트 보호
- 컨텍스트 무거워지면: "컨텍스트 부족 — /clear 후 재개 권장"

---

## 5. Phase 설계

PLAN.md의 step 설계 초안 기반으로 상세 step 지침서 작성.

설계 원칙:
1. **Scope 최소화** — step 하나에 모듈 하나
2. **자기완결성** — 독립 Claude 세션. 외부 참조 금지.
3. **사전 준비 강제** — docs 경로 + 이전 step 파일 경로
4. **시그니처 수준 지시** — 인터페이스만, 핵심 규칙만 명시
5. **AC는 실행 커맨드** — 프로젝트 `.harness.toml [testing].test_cmd` 값을 사용 (추상 금지)
6. **주의사항 구체적** — "X를 하지 마라. 이유: Y"
7. **네이밍** — kebab-case slug

**Grey area 분석은 전용 subagent로 위임:**
```
Agent(
  subagent_type="harness-grey-area",
  description="v{X} grey area 분석",
  prompt="변경 대상: {module paths, 언어별 확장자}. PLAN.md: phases/v{X}/{phase}/PLAN.md"
)
```
→ 5개 차원 (Edge Cases / 인터페이스 호환성 / 숨겨진 의존성 / 상태 관리 / 성능) 분석 결과 반환.
Explore 에이전트는 일반 탐색, `harness-grey-area`는 하네스 특화 grey area 전담.

## 6. 7-Dimension 검증

**체크리스트**: `.claude/skills/harness-design/7d-checklist.md` Read.

7 차원 요약:
- **D1 정합성** / **D2 안전성** / **D3 성능** / **D4 완전성** / **D5 테스트** / **D6 운영** / **D7 데이터 흐름**

각 step.md 말미에 `## 7-Dimension 검증` 표 추가 (PASS/FAIL/근거).

### Revision Gate (최대 3회)
FAIL → 수정 → 재검증. 3회 초과 → **Escalation** (사용자 판단).

### 검증 결과 기록
- 각 step 본문 끝에 `## 7-Dimension 검증` 섹션을 추가하여 PASS/FAIL/근거 명시
- 전체 phase 차원 결과는 `phases/{version}/{phase}/REPORT.md`에 누적 (ship 단계에서 작성)

## 7. 파일 생성

**대량 파일 생성은 Agent에 위임:**
```
Agent(
  description="step 0-3 파일 생성",
  model="opus",
  prompt="PLAN.md 기반으로 step0.md~step3.md 생성. 각 step에 Pre-mortem 포함."
)
```

생성 대상:
- `phases/{version}/{phase}/index.json`
- `phases/{version}/{phase}/step{N}.md`

> **milestone.json**: `/harness-plan`의 Step 0에서 미리 생성됨. design 단계에서는 해당 phase의 `status=pending`만 확인. 미존재 시 → `/harness-plan` Step 0으로 회귀.

산출물 안내:
```
step 파일 생성 완료.
다음: /harness-run
컨텍스트 부족 시: /clear → /harness-run
```
