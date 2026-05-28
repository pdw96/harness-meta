---
name: stage-report
description: milestone REPORT stage 작성 시 ## REPORT section 안 종합 backward (summary / delta / lessons_learned) mechanical task. 사용 case = 사용자가 'REPORT stage 작성' / 'milestone REPORT 진입' / '## REPORT 섹션 작성' / 'lessons 정리' 언급 또는 9-stage workflow Stage H (종합 backward) 진행. SKIP = 'report bug' / 'report a issue' 등 일반 보고 / 다른 도메인. 본 skill = WORKFLOW.md § 2 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist.
---

# stage-report — milestone REPORT stage 작성 checklist

> 본 skill 은 `development/WORKFLOW.md` § 2 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist (단방향 derived, cascade marker 부재). 1차 source 변경 시 본 skill 후속 갱신 manual.

v6.18_stage-skill-expansion-7-stages 에서 도입 (v6.16 시범 OPEN+PROPOSE 후 7 stage 확장 cycle 2). 본 skill 은 9-stage workflow 안 Stage H (REPORT 보고) 진행 시 forcing function 역할 — schema template + checklist 만 제공, narrative judgment 은 LLM at runtime.

stage 단어 책임 (v2.0_workflow-word-fidelity 정합) = `보고` (report) — milestone 종합 backward (summary + delta + lessons_learned). v5.21 archival 정합 — 본 stage 안 recent 3 초과 archival 처리 책임 (= GitHub Release 발행 + milestones[] trim, v6.19+ GitHub Releases / v8.13 정합. CHANGELOG.md 는 v6.19 까지 historical).

## 입력

이전 stage 위치 = `MILESTONE.md` 안 `## VERIFY` 섹션 (Stage G 산출물). VERIFY verdict + criteria_check + smoke 결과 가 REPORT summary 본질 source.

읽을 곳:

- `projects/<name>/milestones/v{X.Y}/MILESTONE.md` 안:
  - `## INTENT` → goal / motivation (summary 본질 source)
  - `## VERIFY` → verdict / criteria_check (delta 본질 source)
  - `## EXECUTE` → phases_executed / commits (delta 정량 source)
- git log — commit count + 40-hex SHA + diff (delta 정량 source)
- `projects/<name>/ROADMAP.md` — `milestones[]` recent 3 초과 시 archival 대상 식별

## 작성할 것

MILESTONE.md 안 `## REPORT` H2 section 안 `### Spec` JSON 코드블록 + `### Narrative` 본문 작성. + (recent 3 초과 시) GitHub Release 발행 + milestones[] trim (아래 § 3).

### 1. `### Spec` 안 JSON schema

```json
{
  "summary": "{본 milestone 종합 narrative — goal + motivation + verdict 결과 요약 1~3 sentence}",
  "delta": {
    "files_created": "{정량}",
    "files_edited": "{정량}",
    "files_created_list": ["{path}"],
    "files_edited_list": ["{path}"],
    "loc_approx": "{+N -M LOC narrative}",
    "commits": "{commit count 또는 '사용자 확인 후 commit 자연' 명시}",
    "smoke": "{smoke 결과 narrative — pre-commit 18 hook PASS 또는 정정 cycle 명시}"
  },
  "lessons_learned": [
    {
      "id": "L1",
      "priority": "{P1|P2|P3}",
      "description": "{lesson 본질 narrative — 미래 milestone 도움 본질}",
      "context": "{lesson origin context — 본 milestone 안 trigger 발생 시점 narrative}",
      "next_action_candidate": "{후속 milestone candidate narrative 또는 '거명만 보존' / '별 milestone 발의 부재' 명시}"
    }
  ]
}
```

필드 정합:

- `lessons_learned[].id`: regex `^L\d+$` (L1, L2, ...)
- `lessons_learned[].priority`: enum 3 값 (P1 = 즉시 흡수 본질 / P2 = 후속 milestone candidate / P3 = 거명만 보존)

### 2. `### Narrative` 본문

종합 backward narrative — goal 달성 evidence + delta 정량 요약 + lessons 핵심 본질 1~3 paragraph. LLM judgment 본질 — lessons 분류 (P1/P2/P3) 정합 + next_action_candidate ↔ PROPOSE next_candidates 매핑 본질.

narrative judgment 본질 보존 — LLM at runtime, schema template forcing function 보조.

### 3. ROADMAP archival 처리 (recent 3 초과 시)

v5.21+ schema A2 정합 — `milestones[]` 안 recent 3 + in_progress + deferred 만 보존. 본 milestone 완료 시 milestones[] 안 4 completed 누적 시 가장 오래된 1 entry archival. archival = 두 반쪽 (① milestones[] recent 3 trim + ② 잘라낸 entry 영구 보존 = GitHub Release, v6.19+ / v8.13 정합).

> **트랙별 archival trigger** (v8.13, WORKFLOW § 3): **9-stage = 본 REPORT/PROPOSE 시점** (아래 절차) / **가벼운 흐름 = LIGHTWEIGHT.md `## 기록` 작성 시점** (PROPOSE 부재 → `## 기록` 이 archival 책임 흡수, stage-report SKILL 대신 lightweight-flow SKILL). 공통 안전망 = `tests/smoke-roadmap-archival.sh` (completed ≤ 3 강제).

archival 절차 (9-stage):

1. `projects/<name>/ROADMAP.md` (또는 `development/ROADMAP.md`) 안 가장 오래된 completed entry 식별 (recent 3 초과)
2. 해당 version 의 **GitHub Release 발행** — merge commit msg 에 marker `[release:v{X.Y}]` 포함 (push 시 `release-publish.yml` 자동 발행) 또는 `workflow_dispatch` (version input). release body = MILESTONE.md `## REPORT` (9-stage) / LIGHTWEIGHT.md `## 기록` (가벼운 흐름) 자동 추출. **발행 = outward-facing → 사용자 확인 후**.
3. ROADMAP `milestones[]` 안 본 entry 제거 (**발행 후 trim** — publish-then-trim, forward 가시성 보존)
4. trace 3중 보존 = REPORT.md/LIGHTWEIGHT.md ## 기록 + git log + GitHub Release

본 stage 안 archival 진행 = v5.21 정전화 이후 의무 (recent 3 초과 시). CHANGELOG.md 는 v6.19 까지 historical hybrid (신규 entry 추가 단속).

## 검증

REPORT stage 작성 후 회귀 차단 smoke:

```bash
bash tests/smoke-spec-verification.sh
```

기대 결과 = PASS. REPORT 섹션 안 ```json``` 코드블록 형식 + summary 필드 강제 검증.

archival 진행 시 추가 smoke:

```bash
bash tests/smoke-projects-scope-discipline.sh
```

= root ROADMAP.md thin index 정합 + projects/<name>/ROADMAP.md 단일 source 차단 검증.

## 관련

1차 source narrative:

- [`development/WORKFLOW.md`](../../development/WORKFLOW.md) § 2 — Stage 본질 (templated section 작성 task) canonicalization paragraph
- [`development/WORKFLOW.md`](../../development/WORKFLOW.md) § 1 — 9-stage workflow Stage H (REPORT) 책임 = `종합 backward (summary, delta, lessons_learned)`
- [`development/WORKFLOW.md`](../../development/WORKFLOW.md) § 1 끝 #3 row — ROADMAP forward-looking redesign + CHANGELOG archival (v5.21 정전화)

운영 가이드:

- [`CLAUDE.md`](../../CLAUDE.md) — root 운영 가이드 + commit message conventional commits 정합
- [`claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) — `/harness-meta` slash command Stage H (REPORT) 본문
- [`.github/workflows/release-publish.yml`](../../.github/workflows/release-publish.yml) — archival 대상 release note 발행 (GitHub Releases 단일 source, v6.19+ / v8.13 두 트랙)
- [`CHANGELOG.md`](../../CHANGELOG.md) — v6.19 까지 historical hybrid release note (신규 entry 추가 단속)

9 stage skill cross-ref (workflow 순서):

- `skills/stage-verify/` — G. VERIFY stage (이전)
- `skills/stage-report/` — H. REPORT stage (본 skill)
- `skills/stage-propose/` — I. PROPOSE stage (다음)
- 나머지 6 stage skill = OPEN / INTENT / RESEARCH / DESIGN / APPROVE / EXECUTE
