---
name: harness
description: Harness 디스패처 — 현재 phase 상태 파악 후 다음 단계 안내
argument-hint: ""
tools: Read, Glob, Grep, Bash, Edit
model: sonnet
---

Harness 디스패처. `/harness` 실행 시 현재 상태를 파악하고 다음 단계를 안내한다.

## 워크플로우

| Command | 단계 | 모델 전략 |
|---------|------|-----------|
| `/harness-plan` | 1~4: 탐색→요구사항→논의→PLAN.md | 코드 분석: Agent(model="opus") 위임 |
| `/harness-design` | 5~7: 설계→7D→step 생성 | grey area + step 생성: Agent(model="opus") 위임 |
| `/harness-run` | 8~9: UAT(dry-run)→execute | 에러 분석: Agent(model="sonnet") 위임 |
| `/harness-ship` | 10: Goal-backward→/harness-review→REPORT→push | stub 분석: Agent(model="sonnet") 위임 |

commands = 경량 오케스트레이터 (사용자 대화 담당), 무거운 작업 = Agent(model=...) 위임.
**사용자 대화(논의, 승인)는 오케스트레이터가 직접 처리. Agent에 위임하지 않는다.**

> 상태 판단만 필요한 경우 `harness-dispatcher` subagent 활용 가능
> (`.claude/agents/harness-dispatcher.md`). main context 오염 방지용. 라우팅은 isolated.

## 상태 판단 (반드시 실행)

아래를 **Read**하여 다음 단계를 결정:

0. `phases/index.json` 미존재 시 → "phases/ 초기화가 필요합니다. ROADMAP.md를 확인하고 index.json + milestone.json을 생성하세요." 안내 후 `/harness-plan`
1. `phases/index.json` → status가 "completed"가 아닌 첫 번째 milestone의 version 확인. 모든 milestone 완료 시 → "전체 마일스톤 완료. ROADMAP.md에 다음 마일스톤을 추가하세요." 안내
2. 해당 version의 `phases/{version}/milestone.json` → 미존재 시 `/harness-plan` 안내. 존재하면 phase 목록에서 status="completed"가 아닌 첫 phase의 dir 확인
3. `phases/{version}/{phase-dir}/` 디렉토리에서 아래 파일 존재 확인:

| 파일 확인 | 결과 | 다음 |
|-----------|------|------|
| 디렉토리 없음 또는 PLAN.md 없음 | — | `/harness-plan` |
| PLAN.md 있고 step0.md 없음 | — | `/harness-design` |
| step 있고 index.json에 pending 존재 | — | `/harness-run` |
| 모든 step completed, REPORT.md 없음 | — | `/harness-ship` |
| REPORT.md 있음 | — | 이 phase 완료. 다음 phase 또는 마일스톤 안내 |

**사용자에게 구체적 경로 명시** (예: "대상: `phases/v1.5/2-foo-phase/`, 다음: `/harness-plan`")

## Safety Gates

라우팅 전 확인:
1. **Error state**: index.json에 error/blocked step → `--reset-step N` 또는 `--from-step N` 안내
2. **Lock file**: `.harness.lock` 존재 → PID 생존 시 다른 실행 진행 중, 죽은 PID는 자동 정리
3. **이전 phase 미완료**: 이전 milestone에 REPORT.md 없는 phase → 경고
4. **Dry-run 우선 권장**: 본 실행 전 `--dry-run`으로 구조/문서참조/프롬프트 크기 검증

## Gate 체계

| Gate | 동작 | 실패 시 |
|------|------|---------|
| **Pre-flight** | 전제 파일 존재 | 이전 단계로 라우팅 |
| **Revision** | 출력 품질 (7D, /harness-review) | 수정 후 재검증 (최대 3회) |
| **Escalation** | 해결 불가 | 사용자 결정 대기 |
| **Abort** | 치명적 상태 | 즉시 중단 + 상태 보존 |

## Anti-patterns

- **체크리스트 질문 금지** — 넓게 시작, 관심사를 파고들기
- **스코프 크립 금지** — ROADMAP 밖 → "별도 phase. 백로그?"
- **전체 파일 읽기 금지** — 프로젝트의 ARCHITECTURE·스코프 문서 경량만. 무거운 분석은 Agent 위임
- **오케스트레이터 직접 실행 금지** — 라우팅만. 분석/구현은 각 command가 담당
- **git add -A 금지** — 특정 파일만 stage

## Lessons Learned

- v0.1: Windows UTF-8 강제, docs 93% 압축, status 미업데이트 자동 error
- v0.2: stdin input= 통일, dry-run 분기, Stop hook 제거
- v1.0: API 500은 reset-step 복구, frozen+dict 비호환 → Optional 필드
- 하네스: agents는 사용자 대화 불가 → commands(오케스트레이터) + Agent(model=...) 위임 패턴
- v0.1.1 (2026-04-17): atomic lock(O_EXCL)+signal cleanup, --from-step 우선 적용, retry 메트릭 누적, dry-run mutation 차단
