---
name: harness-plan
description: Harness 1~4단계 — 탐색→요구사항→논의→PLAN.md 생성. /harness-plan 명시 호출로만 활성화.
disable-model-invocation: true
argument-hint: "[version/phase-name]"
allowed-tools: Read, Glob, Grep, Write(phases/**/PLAN.md), Edit(phases/**/PLAN.md), Bash(ls*), Bash(mkdir*), Bash(wc*)
model: opus
thinking: high
---

Harness 1~4단계: 탐색 → 요구사항 → 논의 → PLAN.md 생성

**역할 분담:**
- **오케스트레이터(이 command)가 직접 처리**: 사용자 대화 (논의, 질문, 승인), 경량 파일 Read, Write
- **Agent(subagent_type="harness-explore", model="opus")로 위임**: 코드 분석, 탐색, 호출 관계 / 설정 / 테스트 커버리지 수집

## Pre-flight Gate

1. `phases/ROADMAP.md` Read → 다음 마일스톤 version 확인 ("다음 마일스톤 미정"이면 사용자에게 ROADMAP 보강 요청)
2. `phases/index.json` Read → 해당 version 상태 확인
3. 이미 `PLAN.md`가 존재하면:
   - **수정 의도** (사용자가 명시) → 기존 PLAN.md를 Read 한 뒤 추가 논의 진행, 끝에 PLAN.md 업데이트
   - **그렇지 않으면** → "다음: `/harness-design`" 안내 후 중단
4. version과 phase-name 확정 후: `mkdir -p phases/{version}/{phase-name}`

## 0. Milestone 구성 (신규 — design에서 이동)

Plan 시작 전 milestone 전체 phase 구조를 먼저 선언한다. 이유:
- 1 milestone = 1 phase 암묵 가정 제거
- worktree 병렬 실행 필요 여부를 plan 단계에서 자동 판정 (Tier 4.5)
- 프로젝트 executor `--status`가 milestone 전체 진행률 정확히 표시

### 절차

1. `phases/{version}/milestone.json` 존재 확인
2. 없으면 사용자와 논의하여 **phase 수 / 각 phase 목적** 확정
   - ROADMAP.md의 해당 milestone 설명 참고
   - 1 phase로 충분하면 그대로 진행 (기존 패턴)
   - 2+ phase면 각각 `dir` slug + 독립성(`independent: true/false`) 결정
3. `phases/{version}/milestone.json` Write (예시):
   ```json
   {
     "version": "{version}",
     "name": "{Milestone Name}",
     "status": "in-progress",
     "phases": [
       {"dir": "0-foo", "status": "pending", "independent": true},
       {"dir": "1-bar", "status": "pending", "independent": true},
       {"dir": "2-baz", "status": "pending", "independent": false}
     ]
   }
   ```
4. 프로젝트 하네스가 worktree 권고 helper를 제공하는 경우 자동 판정:
   - phase 3+ 또는 `independent: true` 2+ → worktree 병렬 실행 권장 메시지 출력
   - 그 외 → silent (순차 실행)

### 독립성 판단 기준

`independent: true`는 다음 조건 **모두** 충족:
- 수정 파일 영역이 다른 phase와 겹치지 않음 (예: `src/module_a/*` vs `src/module_b/*`)
- 의존성 없음 (다른 phase 산출물 전제 X)
- merge 충돌 없음 예상

## Context Budget
- 프로젝트의 ARCHITECTURE·스코프 문서(예: `docs/scope/{version}/PRD.md`)만 직접 Read. 경로는 프로젝트 CLAUDE.md + `projects/{name}/ARCHITECTURE.md`에서 공급
- 코드 분석은 Agent(subagent_type="harness-explore", model="opus")로 위임
- 컨텍스트 무거워지면: "컨텍스트 부족 — /clear 후 다음 단계 권장"

---

> **Plan Mode 권장**: 탐색·논의 단계는 read/grep 중심. 필요 시 `Shift+Tab 2회`로 Plan Mode 진입하여 PLAN.md 작성 전까지 read-only 유지. `ExitPlanMode` 승인 후 write.

## 1. 탐색 (Explore)

직접 Read:
- `phases/ROADMAP.md` — Lessons Learned 포함
- 프로젝트 스코프 문서 (표준 패턴: `docs/scope/{version}/PRD.md`. 프로젝트가 다르면 CLAUDE.md가 override)
- 프로젝트 ARCHITECTURE 문서 (경로는 CLAUDE.md 참조. 예: `docs/core/ARCHITECTURE.md` 또는 `@~/harness-meta/projects/{name}/ARCHITECTURE.md` include)

**코드 분석은 harness-explore 에이전트에 위임:**
```
Agent(
  description="v2.0 코드 분석",
  subagent_type="harness-explore",
  model="opus",
  prompt="변경 대상 모듈 현재 구현, stub, 테스트 수, settings 필드 확인"
)
```

산출물: 현재 상태 요약.

## 2. 요구사항

- PRD에서 scope 추출 → 기능 목록 (P0/P1/P2)
- AC 구체화
- 숨겨진 요구사항 발굴 (warmup, 초기화, 경계값)

산출물: 요구사항 테이블.

## 3. 논의 (GSD Questioning 패턴)

### 철학
**사고 파트너지, 면접관이 아니다.**

### 규칙
- **체크리스트 금지** — 넓게 시작, 관심사를 파고들기
- **모호함 거부** — "좋은" → 뭐가? "간단한" → 어떻게?
- **추상→구체** — "실제로 사용하면?" "예시를 들면?"
- **에너지 따라가기** — 사용자가 강조한 것 파고들기
- **스코프 크립 방지** — ROADMAP 밖 → "별도 phase. 백로그에 기록?"
- **멈출 때 알기** — 뭘/왜/완료기준 이해하면 → 진행 제안

### 질문 유형 (영감으로, 체크리스트 아님)
- **동기**: "이게 왜 필요?" "지금은 어떻게?"
- **구체화**: "사용 과정을 걸어보세요" "실제로 어떻게 보이나요?"
- **명확화**: "X라고 했는데, A인가요 B인가요?"
- **완료**: "이게 동작하면 어떻게 알 수 있나요?"

### Anti-patterns
- 체크리스트 순회, 정형화 질문, 얕은 수용, 조급함, 기술 선제 질문

### "Claude 재량"
"네가 결정해" → PLAN.md에 기록, 설계/실행 시 자유.

## 4. PLAN.md 생성

**템플릿**: `.claude/skills/harness-plan/plan-template.md` Read 후 `phases/{version}/{phase-name}/PLAN.md`에 Write.

치환 플레이스홀더: `{version}`, `{phase-name}`, `{N}` (테스트 수).
채울 섹션:
- 현재 상태 (테스트 수, 변경 대상 모듈)
- 요구사항 표 (AC는 실행 커맨드, 우선순위 P0/P1/P2)
- 논의 결정 표 (주제 / 결정 / 근거)
- Claude 재량 항목, Step 설계 초안, Grey Areas

> **주의**: 7-Dimension 검증은 `/harness-design` 단계의 산출물. PLAN.md에는 포함 금지 (시점이 다름).

산출물 안내:
```
PLAN.md 생성 완료.
다음: /harness-design
컨텍스트 부족 시: /clear → /harness-design
```
