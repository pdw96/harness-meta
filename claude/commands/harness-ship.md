---
name: harness-ship
description: Harness 10단계 — Goal-backward 검증 → /harness-review → REPORT → commit → push
tools: Read, Glob, Grep, Bash(git*), Bash(python3*), Bash(python*), Edit(phases/**), Write(phases/**)
model: opus
thinking: high
---

Harness 10단계: Goal-backward 검증 → /harness-review → REPORT.md → commit → push

**오케스트레이터**: 직접 검증 실행. stub 분석 시 Agent(model="sonnet") 위임.

## Pre-flight Gate

1. `phases/{version}/{phase}/index.json` 읽기 → 모든 step completed 확인 → pending/error면 `/harness-run`
2. `phases/{version}/{phase}/REPORT.md` 존재하면 → "이미 배포 완료" 안내
3. `phases/{version}/{phase}/PLAN.md` 읽어서 맥락 복원
4. 현재 git 브랜치 확인

**CRITICAL: 리뷰 PASS 전까지 커밋/push 절대 금지.**

---

> **Plan Mode 권장**: 10-1 Goal-backward 검증은 read/grep 중심. 필요 시 `Shift+Tab 2회`로 Plan Mode 진입하여 검증 완료 후 REPORT.md / commit 단계로.

## 10-1. Goal-backward 검증 (GSD verify-phase 패턴)

**핵심 원칙: Task 완료 ≠ Goal 달성**

### Step A: Must-haves 수립
PLAN.md의 **각 요구사항(R1~Rn)**에서 역방향 도출:
1. **Truths** — 이 기능이 달성되려면 무엇이 TRUE여야 하는가?
2. **Artifacts** — 그 Truths가 성립하려면 어떤 파일이 EXIST해야 하는가?
3. **Wiring** — 그 파일들이 시스템에 CONNECTED되어야 하는가?
4. **Tests** — 그 Truths를 증명하는 테스트가 PASS하는가?

> **검증 자동화**: `harness-verifier` subagent에 위임 가능.
> ```
> Agent(subagent_type="harness-verifier",
>       description="Goal-backward 검증",
>       prompt="phase_path=v{X}/{phase}, plan_path=phases/v{X}/{phase}/PLAN.md")
> ```
> → 판정 표 (VERIFIED/ORPHANED/STUB/MISSING) 반환. 사용자는 Revision Gate 여부만 확인.

### Step B: Artifact 검증 (4단계)

| 레벨 | 검증 | 방법 |
|------|------|------|
| **1. Exists** | 파일 존재 | `Glob` 또는 `ls` |
| **2. Substantive** | 실제 구현 (stub 아님) | Grep: `TODO|FIXME|PLACEHOLDER|pass$|return None.*stub` |
| **3. Wired** | 시스템에 연결 | Grep: `import.*{module}` + 사용처 확인 |
| **4. Functional** | 실제 동작 | `pytest` 관련 테스트 실행 |

### Step C: 판정

| Exists | Substantive | Wired | Functional | 판정 |
|--------|-------------|-------|------------|------|
| O | O | O | O | VERIFIED |
| O | O | X | - | ORPHANED (실패: 미연결 코드는 dead code) |
| O | X | - | - | STUB (실패) |
| X | - | - | - | MISSING (실패) |

STUB/MISSING/ORPHANED → **Revision Gate**: 사용자 보고, 수정 후 재검증.

> STUB 정규식 `pass$`은 빈 클래스 본문 등 정상 코드도 잡을 수 있으니, hit한 라인은 반드시 사람이 한 번 더 확인한다.

## 10-2. /harness-review 체크리스트 (5항목)

1. **아키텍처 준수** — 프로젝트 ARCHITECTURE 문서 Read (경로는 프로젝트 CLAUDE.md 참조) → 구조 대조
2. **기술 스택 준수** — 프로젝트 DECISIONS/ADR 문서 Read → 금지 의존성·패턴 Grep (구체 규칙은 프로젝트 CLAUDE.md 공급)
3. **테스트 존재** — 프로젝트 테스트 커맨드 실행 (예: `poetry run python -m pytest tests/ -q --tb=short`; 실제는 `.harness.toml [testing].test_cmd` 또는 `CLAUDE.md` 참조)
4. **CRITICAL 규칙** — 프로젝트 CLAUDE.md의 CRITICAL 섹션 Read → 해당 금지 패턴 Grep (예: 특정 디렉토리에 특정 코드 금지, 특정 API 직접 접근 금지)
5. **빌드 가능** — 프로젝트 빌드 검증 커맨드 (테스트·타입체크·린트) **각각 분리 실행** (`&&`로 묶으면 앞 단계 실패 시 뒤가 누락됨):
   ```bash
   # 예시 (Python/Poetry 프로젝트). 실제 명령은 `.harness.toml [testing]` 참조
   poetry run python -m pytest tests/ -q
   poetry run mypy <src> --strict
   poetry run ruff check <src>
   ```

### Revision Gate
FAIL → 수정 → 재검증 (최대 3회). 3회 초과 → **Escalation** (사용자 판단).

## 10-3. REPORT.md 생성

**템플릿**: `.claude/skills/harness-ship/report-template.md` Read 후 `phases/{version}/{phase-name}/REPORT.md`에 Write.

채울 내용:
- Goal-backward 표 (10-1 결과)
- 실행 결과 표 (`step*-output.json` 메타: 시간/비용/turns/재시도)
- `/harness-review` 결과 표 (10-2 5항목)
- 산출물 요약, Lessons Learned, 테스트 변화 (before/after/delta)

## 10-4. 상태 파일 동기화

- `phases/ROADMAP.md` — 완료 정보 + Lessons Learned 추가
- `phases/index.json` — 해당 milestone status "completed" + completed_at 업데이트
- `phases/{version}/milestone.json` — execute.py `_finalize`가 자동 갱신. 누락 시 수동 보정
- 하네스 자체를 수정한 경우는 **glob harness-meta repo의 `sessions/{project}/vX.Y-{name}/REPORT.md`**에 기록 (`/harness-meta` 세션 사용). 프로젝트 repo의 `phases/HARNESS_CHANGELOG.md`는 레거시 v0.x~v1.4 용도로만 남는다.

## 10-5. 커밋 + Push

**사전 확인**: `git status`로 working tree clean 확인. main checkout 전 dirty면 사용자에게 stash/commit 여부 질문.

```bash
git add phases/{version}/{phase}/REPORT.md phases/ROADMAP.md \
       phases/{version}/{phase}/index.json phases/{version}/milestone.json \
       phases/index.json
git commit -m "chore({phase}): mark phase completed + review report"

# main 이동 전 dirty 확인 (리뷰 중 새로 바뀐 파일이 남아있을 수 있음)
git status --porcelain | head -1     # 비어있으면 OK

git checkout main
git pull origin main --ff-only       # fast-forward 아니면 abort → 사용자 판단
git merge feat-{phase-name} --no-edit
git push origin main
git branch -d feat-{phase-name}
```

> `pull --ff-only` 실패 = 원격에 다른 커밋이 있다는 뜻. 임의 rebase/merge 대신 사용자에게 보고.

산출물 안내:
```
Phase 완료.
다음 마일스톤: /clear → /model sonnet → /harness
```
