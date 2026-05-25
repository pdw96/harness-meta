---
name: harness-roadmap-update
description: |
  REPORT.md 작성 직후 development/ROADMAP.md 또는 projects/<name>/ROADMAP.md 자동 갱신.
  "최근 완료" 항목 추가 + PLAN의 "Out of scope" 표를 "Out of scope (trigger 대기)" §에
  5 trigger 종류 분류와 함께 이관. v1.36+ harness-meta 8단계 흐름의 단계 9 산출.

  **TRIGGER**:
  - 사용자가 "ROADMAP 갱신", "roadmap 업데이트", "roadmap sync", "ROADMAP 작성" 언급
  - 메타 또는 프로젝트 세션 REPORT.md 작성 직후 (단계 9 명시 절차)
  - /harness-roadmap-update 명시 호출
  - 사용자가 "Out of scope를 trigger로 옮겨" 같은 분류 작업 요청

  **SKIP**:
  - REPORT.md가 아직 작성 안 됨 → 단계 9 진입 자격 미충족
  - target ROADMAP path가 보안 검증 실패 (`..` / 절대경로 / 메타 문자) → AskUserQuestion 자동 invoke로 재입력 요청
disable-model-invocation: true
allowed-tools:
  - Read
  - Glob
  - Grep
  - Edit(development/ROADMAP.md)
  - Edit(projects/*/ROADMAP.md)
  - Write(development/ROADMAP.md)
  - Write(projects/*/ROADMAP.md)
model: sonnet
---

> **⚠️ DEPRECATED (v1.0_workflow-redesign 이후, 2026-05-08)**
>
> 본 SKILL은 v1.0 이전의 `sessions/meta/ROADMAP.md` 4-tier 포맷 기반. v1.0+ 7-stage 흐름에서는 ROADMAP 갱신이 Stage G의 명시 단계로 통합되어 별도 SKILL invoke 불필요. 현재 frontmatter `Edit(sessions/meta/ROADMAP.md)` 등 path 참조는 broken (sessions/ v1.0 phase-5에서 제거됨). v1.1_meta-as-project (2026-05-08) 이후 meta ROADMAP은 `development/ROADMAP.md`로 이관됨.
>
> **재작성 후보**: v1.1_smoke-precommit-rewrite 또는 별도 후속 milestone 에서 7-stage + projects/<name>/ROADMAP.md 정합으로 재설계 검토. 본 파일은 historical 보존.

# harness-roadmap-update — ROADMAP 자동 갱신 SKILL (DEPRECATED)

`sessions/meta/v1.36-roadmap-unification-and-flow/`에서 도입. harness-meta 8단계 흐름의 **단계 9** 자동화 — REPORT.md 작성 직후 ROADMAP "최근 완료" + "Out of scope (trigger 대기)" 자동 갱신.

## 1. 위치 + 역할

| 항목 | 값 |
|------|-----|
| Source | `~/harness-meta/skills/harness-roadmap-update/SKILL.md` |
| Target ROADMAP (meta) | `sessions/meta/ROADMAP.md` |
| Target ROADMAP (project) | `projects/<name>/ROADMAP.md` |
| Invocation | `disable-model-invocation: true` — 사용자 명시 또는 단계 9 절차에서만 |

## 2. 5-step 흐름

### Step 1 — Identify

본 세션의 위치 결정:

```
session_dir=$(dirname "$PLAN_or_REPORT_path")     # e.g., sessions/meta/v1.36-...
session_target=$(basename "$(dirname "$session_dir")")  # e.g., "meta" or "<project>"

if [ "$session_target" = "meta" ]; then
    target_roadmap="sessions/meta/ROADMAP.md"
else
    target_roadmap="projects/$session_target/ROADMAP.md"
fi
```

### Step 2 — Validate (보안)

`<name>` / `<target>` 파라미터 보안 검증 (interview.md Q13 sanity 답습):

| 검증 | 거부 조건 |
|------|---------|
| Regex | `^[a-z0-9][a-z0-9_-]*$` 위반 시 abort |
| Realpath | `realpath` 결과가 `$HARNESS_META_ROOT/{sessions/meta,projects}` prefix 매치 안 하면 abort |
| Path traversal | `..`, 절대경로, null byte, 메타 문자 (`@`, `{{`, `}}`, `<!--`, `<script`) 검출 시 abort |
| Symlink loop | target이 symlink면 1-hop resolve 후 prefix 재검증 (depth 2+ 거부) |

위반 시 abort + `AskUserQuestion` 자동 invoke (재입력).

### Step 3 — Classify (Out of scope → trigger)

PLAN의 `## Out of scope (explicit rejection)` 표 각 row를 **5 trigger 종류**에 매핑:

| 종류 | 의미 | 예시 |
|:----:|-----|------|
| **A** | 외부 사용자 등장 | "Python 사용자 등장 시 evidence" |
| **B** | 회귀 / 장애 evidence | "smoke FAIL 발생 시" |
| **C** | 외부 환경 변화 | "PyPI unpublish / upstream archived 시" |
| **D** | 설계 결정 선행 | "타입 안전성 redesign prerequisite" |
| **E** | 정규화 우선순위 미달 | "evidence 3+ 사례 누적 시" |

분류 애매 시 (PLAN row의 trigger 조건이 불명확) → `AskUserQuestion` 자동 invoke (5 옵션 제시).

### Step 4 — Sanitize

ROADMAP 삽입 전 row 텍스트 sanitize (interview.md Q13 + license MAX_LENGTH 80 답습):

```python
def sanitize_row(text: str) -> str:
    # 메타 문자 5종 검출
    if any(meta in text for meta in ['@', '{{', '}}', '<!--', '<script']):
        text = f'```text\n{text}\n```'
    # control character strip
    text = re.sub(r'[\x00-\x1F\x7F]', '', text)  # ANSI escape, null byte 제거
    # AskUserQuestion 옵션 텍스트는 80 chars truncate
    if option_context and len(text) > 80:
        text = text[:77] + '...'
    return text
```

### Step 5 — Update

`Edit` tool로 target ROADMAP 갱신 (atomic, single read-modify-write):

1. **§ "최근 완료"** — 본 세션 row 추가 (날짜 + 세션 alias + 1줄 요약)
2. **§ "Out of scope (trigger 대기)"** — Step 3 분류·Step 4 sanitize된 row 추가 (5 trigger 종류 컬럼)
3. **§ "Schedule 후보"** — 해당 시 갱신 (예: 본 세션이 정기 점검 대상 신설)

## 3. 보안 정책

| Risk | 방어 |
|------|------|
| Path traversal (`..`) | Step 2 realpath prefix 검증 |
| Symlink loop | 1-hop resolve only, depth 2+ abort |
| Markdown injection | Step 4 메타 문자 5종 fenced wrap |
| Control character | Step 4 strip |
| `skills/harness-roadmap-update/` 자체 편집 | `allowed-tools`에 본 path 없음 (자기 수정 차단) |

## 4. 한계

- **description trigger opportunistic** — Claude의 자동 호출 보장 무. backstop은 단계 9 명시 절차 (slash command 본문) + `tests/smoke-roadmap-sync.sh --fix`
- **deterministic 자동 호출**은 PostToolUse hook (v1.36b 후속)
- **매번 사용자 명시 invoke** — `disable-model-invocation: true`로 silent 호출 차단

## 5. 관련 문서

- 상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md) · [`../../README.md`](../../README.md)
- 8단계 흐름: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md)
- mindvault 패턴 답습 (`disable-model-invocation`): [`../mindvault/SKILL.md`](../mindvault/SKILL.md)
- harness-plan-verify 5-step 답습: [`../harness-plan-verify/SKILL.md`](../harness-plan-verify/SKILL.md)
