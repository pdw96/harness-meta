---
name: harness-run
description: Harness 8~9단계 — UAT dry-run → execute.py 실행
tools: Read, Glob, Grep, Bash(python3 scripts/execute.py*), Bash(python scripts/execute.py*), Bash(git status*), Bash(git diff*)
model: sonnet
---

Harness 8~9단계: UAT dry-run → execute.py 실행

**오케스트레이터**: 직접 Bash 실행. 에러 분석 시 Agent(model="sonnet") 위임.

## Pre-flight Gate

1. `phases/{version}/{phase}/PLAN.md` 존재 → 없으면 `/harness-plan`
2. `phases/{version}/{phase}/index.json` 존재 → 없으면 `/harness-design`
3. `phases/{version}/{phase}/step0.md` 존재 → 없으면 `/harness-design`
4. index.json steps 수 = step*.md 파일 수 → 불일치면 `/harness-design`

---

## 8. UAT

```bash
python3 scripts/execute.py {version}/{phase-name} --dry-run
```

확인 항목 (실패 시 즉시 design 단계로 복귀):
- step 파일 존재 (step{N}.md)
- step 번호 연속성 (0, 1, 2, ...)
- 문서 경로 유효성 (`/docs/...` 참조 모두 실제 파일 매칭)
- 프롬프트 크기 (~150K tokens 미만 권장)
- `[DRY-RUN] Total prompt: N chars` 출력으로 비용 사전 가늠

UAT는 read-only이므로 lock·branch checkout·index mutation을 하지 않는다.

## 9. 실행

사용자 승인 후:

```bash
python3 scripts/execute.py {version}/{phase-name} --push-per-step
```

### 에러 복구 명령

| 명령 | 동작 | 사용 시점 |
|------|------|----------|
| `--status` | 진행 현황만 출력 (무변경) | 어디까지 됐는지 확인 |
| `--reset-step N` | step N 하나만 pending으로 (이후 step 유지) | API 500 등 일시 장애 |
| `--from-step N` | step N부터 끝까지 모두 pending으로 | 설계 변경, 이전 산출물 무효화 |

### 에러 대응

1. **API 500 / timeout**: `--reset-step N` 후 재실행 (코드 문제 아님)
2. **코드 에러 (재시도 3회 모두 실패)**: step.md 지침 부족. 에러 분석은 Agent(model="sonnet")로 위임:
   ```
   Agent(
     description="step N 에러 분석",
     model="sonnet",
     prompt="phases/{version}/{phase}/step{N}-output.json의 stderr·exitCode와 step{N}.md를 비교하여 지침 부족·모순을 식별. 수정안 제시."
   )
   ```
3. **blocked**: 사용자 개입 필요 (API 키, 외부 의존성 등). 해결 후 `--reset-step N`

### 실행 완료 후

**커밋/push 금지.** 반드시 `/harness-ship`으로 리뷰 먼저.

산출물 안내:
```
실행 완료. 리뷰 전 커밋/push 금지.
다음: /harness-ship
컨텍스트 부족 시: /clear → /harness-ship
```
