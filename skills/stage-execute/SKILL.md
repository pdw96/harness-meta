---
name: stage-execute
description: milestone EXECUTE stage 작성 시 ## EXECUTE section 본책 (phase 진행 요약) + execute/phase-{n}.md 별책 (per-phase 구현 상세 changes + commit) mechanical task. 사용 case = 사용자가 'EXECUTE stage 진입' / 'milestone EXECUTE 진입' / 'phase-1 진행' / '## EXECUTE 섹션 작성' 언급 또는 9-stage workflow Stage F (per-phase 구현) 진행. SKIP = 'execute query' / 'execute SQL' 등 다른 도메인 / shell command execute. 본 skill = ARCHITECTURE.md § 7.3 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist.
---

# stage-execute — milestone EXECUTE stage 작성 checklist

> 본 skill 은 `development/ARCHITECTURE.md` § 7.3 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist (단방향 derived, cascade marker 부재). 1차 source 변경 시 본 skill 후속 갱신 manual.

v6.18_stage-skill-expansion-7-stages 에서 도입 (v6.16 시범 OPEN+PROPOSE 후 7 stage 확장 cycle 2). 본 skill 은 9-stage workflow 안 Stage F (EXECUTE 실행) 진행 시 forcing function 역할 — schema template + checklist 만 제공, 실제 구현 narrative 은 LLM at runtime.

stage 단어 책임 (v2.0_workflow-word-fidelity 정합) = `실행` (execute) — DESIGN phases[] 기반 per-phase 구현 + commit. 본책 (MILESTONE.md ## EXECUTE) = phase 진행 요약, 별책 (execute/phase-{n}.md) = per-phase 상세 changes + commit trace.

## 입력

이전 stage 위치 = `MILESTONE.md` 안 `## APPROVE` 섹션 (Stage E 산출물). APPROVE 사용자 명시 승인 후 진입 본질. DESIGN phases[] 안 phase 별 scope + deliverable 가 본 stage 진행 source.

읽을 곳:

- `projects/<name>/milestones/v{X.Y}/MILESTONE.md` 안:
  - `## APPROVE` → approval 객체 (승인 게이트 통과 확인)
  - `## DESIGN` → phases[] / approach / risk_mitigation (구현 source)
  - `## INTENT` → sc[] (검증 기준 source)

## 작성할 것

본책 (MILESTONE.md ## EXECUTE section) + 별책 (execute/phase-{n}.md 파일 N건) 두 본질 분리. v6.2+ 9-stage-flattened era 정합 (ARCHITECTURE § 6.1).

### 1. 본책 — MILESTONE.md `## EXECUTE` H2 section

`### Spec` JSON 코드블록 + `### Narrative` 본문 작성.

```json
{
  "phases_executed": [
    {
      "phase": "phase-1",
      "status": "{completed|in_progress|blocked}",
      "deliverable_path": "execute/phase-1.md",
      "commits": [
        {
          "sha": "{40-hex git SHA 또는 'pending'}",
          "message": "{conventional commit subject}"
        }
      ],
      "summary": "{본 phase 진행 narrative 요약 — 별책 안 상세 참조}"
    }
  ]
}
```

필드 정합:

- `phases_executed[].phase`: regex `^phase-\d+$` (DESIGN phases[].phase 정합)
- `commits[].sha`: 40-hex 또는 `pending` (commit 전 작성 시)

### 2. 별책 — `execute/phase-{n}.md` per-phase 파일

phase 별 1 파일. 본 파일은 MILESTONE.md 외부 별책 — phase 진행 상세 narrative + 산출물 list + commit trace.

별책 schema (frontmatter + body):

```yaml
---
phase: phase-{n}
milestone: v{X.Y}
status: {completed|in_progress|blocked}
---

# v{X.Y} phase-{n} — {scope title}

## Spec

```json
{
  "phase": "phase-{n}",
  "scope": "{본 phase scope narrative}",
  "changes": [
    {
      "type": "{create|edit|delete|rename}",
      "path": "{repo 안 파일 path}",
      "description": "{변경 narrative}"
    }
  ],
  "verification": [
    {
      "method": "{smoke|lint|manual|pre-commit}",
      "result": "{PASS|FAIL|SKIP}",
      "detail": "{검증 결과 narrative}"
    }
  ],
  "commit": {
    "sha": "{40-hex 또는 pending}",
    "message": "{conventional commit message}"
  }
}
```

## Narrative

phase 진행 narrative 본문 — 결정 trace + 도중 발견 issue + mitigation 본질 작성.

```

별책 필드 정합:

- frontmatter `phase`: regex `^phase-\d+$` (smoke-spec-verification phase 필드 강제, v3.21 L2 evidence)
- frontmatter `milestone`: regex `^v\d+\.\d+$`
- frontmatter `status`: enum 3 값

### 3. commit 진행

CLAUDE.md root § 개발 프로세스 정합 — `repo 변경은 커밋 전 사용자 확인 필수`. EXECUTE 도중 발생 모든 commit = 사용자 확인 후 진행. conventional commits prefix (`docs(meta):` / `feat(meta):` / `fix(meta):` / `chore(meta):`).

`--no-verify` 우회 = 사용자 명시 승인 후만 (pre-commit hook 실패 시 root cause 분석 우선).

## 검증

EXECUTE stage 진행 후 회귀 차단 smoke:

```bash
bash tests/smoke-spec-verification.sh
```

기대 결과 = PASS. EXECUTE 섹션 안 ```json``` 코드블록 + execute/phase-{n}.md 별책 안 frontmatter (phase + milestone + status) 강제 검증.

pre-commit 18 hook 전체 검증:

```bash
git add . && git commit  # pre-commit 자동 실행
```

= 모든 smoke (18 hook) 통과 시 commit 진행 자연.

## 관련

1차 source narrative:

- [`development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 7.3 — Stage 본질 (templated section 작성 task) canonicalization paragraph
- [`development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 4 — 9-stage workflow Stage F (EXECUTE) 책임 = `per-phase 구현 (changes, commit)`
- [`development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 6.1 — 9-stage-flattened era (v6.2+) 본책+별책 분리 본질
- [`CLAUDE.md`](../../CLAUDE.md) (root) § 개발 프로세스 — commit 전 사용자 확인 필수 + --no-verify 우회 게이트

운영 가이드:

- [`claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) — `/harness-meta` slash command Stage F (EXECUTE) 본문

9 stage skill cross-ref (workflow 순서):

- `skills/stage-approve/` — E. APPROVE stage (이전 — 승인 게이트)
- `skills/stage-execute/` — F. EXECUTE stage (본 skill)
- `skills/stage-verify/` — G. VERIFY stage (다음)
- 나머지 6 stage skill = OPEN / INTENT / RESEARCH / DESIGN / REPORT / PROPOSE
