---
name: stage-approve
description: milestone APPROVE stage 작성 시 ## APPROVE section 안 사용자 명시 승인 게이트 (approval 객체 wrap, approved_by + approved_at + approval_method + scope_confirmed) mechanical task. 사용 case = 사용자가 'APPROVE stage 작성' / 'milestone APPROVE 진입' / '## APPROVE 섹션 작성' / 'EXECUTE 진입 승인' 언급 또는 9-stage workflow Stage E (사용자 명시 승인 게이트) 진행. SKIP = 'approve PR' 등 일반 승인 / GitHub PR approve. 본 skill = WORKFLOW.md § 2 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist.
---

# stage-approve — milestone APPROVE stage 작성 checklist

> 본 skill 은 `development/WORKFLOW.md` § 2 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist (단방향 derived, cascade marker 부재). 1차 source 변경 시 본 skill 후속 갱신 manual.

v6.18_stage-skill-expansion-7-stages 에서 도입 (v6.16 시범 OPEN+PROPOSE 후 7 stage 확장 cycle 2). 본 skill 은 9-stage workflow 안 Stage E (APPROVE 승인) 진행 시 forcing function 역할 — schema template + checklist 만 제공, 사용자 명시 승인 본질은 외부 (AskUserQuestion 또는 자연어 응답).

stage 단어 책임 (v2.0_workflow-word-fidelity 정합) = `승인` (approve) — DESIGN 결과를 EXECUTE 진입 전 사용자 명시 승인 게이트. word fidelity 100% 최고 부합 (WORKFLOW § 1 끝 #2 narrative 정합).

## 입력

이전 stage 위치 = `MILESTONE.md` 안 `## DESIGN` 섹션 (Stage D 산출물). DESIGN decisions + approach + phases 가 승인 대상 본질. 단 본 stage 안 작성 본질 = approval 메타데이터 (사용자 결정 trace) 보존.

읽을 곳:

- `projects/<name>/milestones/v{X.Y}/MILESTONE.md` 안:
  - `## DESIGN` → decisions / approach / phases (사용자 승인 대상)
  - `## INTENT` → sc / oos (승인 scope 본질)
- 사용자 명시 응답 (AskUserQuestion 또는 자연어 응답) — approval_method source

## 작성할 것

MILESTONE.md 안 `## APPROVE` H2 section 안 `### Spec` JSON 코드블록 + `### Narrative` 본문 작성.

### 1. `### Spec` 안 JSON schema

```json
{
  "approval": {
    "approved_by": "user",
    "approved_at": "{YYYY-MM-DD}",
    "approval_method": "{AskUserQuestion '진행 승인' round / 자연어 응답 '진행' / pre-PLAN round N 누적 결정 trace 등}",
    "scope_confirmed": [
      "{R_X round 결정 trace — 사용자 명시 결정 명시 reference}",
      "{...}"
    ]
  }
}
```

필드 정합 (smoke-spec-verification 안 강제):

- `approval`: top-level 직접 두지 말고 반드시 `approval` 객체 wrap (MEMORY `feedback_approve_md_schema_wrap` 직접 정합, v5.7 phase-1 1차 commit 회귀 evidence)
- `approval.approved_by`: literal `user` (사용자 명시 승인 본질 — Claude 자율 승인 금지)
- `approval.approved_at`: YYYY-MM-DD ISO 8601 date format
- `approval.approval_method`: 사용자 응답 method narrative (필수)
- `approval.scope_confirmed`: 사용자 명시 결정 trace array (pre-PLAN round 누적 결정 reference)

### 2. `### Narrative` 본문

승인 본질 narrative — 사용자 명시 승인 trace + scope 본질 confirm + EXECUTE 진입 의도 명시 1 paragraph (mechanical-heavy stage 본질, narrative 짧음 자연).

본 stage 본질 = 사용자 명시 승인 게이트 = Claude 자율 진행 금지 본질. CLAUDE.md root § 개발 프로세스 정합 — '~/harness-meta/ repo 변경은 커밋 전 사용자 확인 필수' 본 시점 활성.

## 검증

APPROVE stage 작성 후 회귀 차단 smoke:

```bash
bash tests/smoke-spec-verification.sh
```

기대 결과 = PASS. APPROVE 섹션 안 ```json``` 코드블록 형식 + `approval` 객체 wrap 강제 (top-level 직접 placement = FAIL '필드 누락: approval', MEMORY feedback 직접 evidence).

## 관련

1차 source narrative:

- [`development/WORKFLOW.md`](../../development/WORKFLOW.md) § 2 — Stage 본질 (templated section 작성 task) canonicalization paragraph
- [`development/WORKFLOW.md`](../../development/WORKFLOW.md) § 1 — 9-stage workflow Stage E (APPROVE) 책임 = `사용자 명시 승인 게이트 (approval.approved_by: "user" + date)`
- [`CLAUDE.md`](../../CLAUDE.md) (root) § 개발 프로세스 — `~/harness-meta/ repo 변경은 커밋 전 사용자 확인 필수` + `pre-commit hook 우회 (--no-verify) 는 사용자 명시 승인 후만`

운영 가이드:

- [`claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) — `/harness-meta` slash command Stage E (APPROVE) 본문

9 stage skill cross-ref (workflow 순서):

- `skills/stage-design/` — D. DESIGN stage (이전)
- `skills/stage-approve/` — E. APPROVE stage (본 skill)
- `skills/stage-execute/` — F. EXECUTE stage (다음 — 승인 후 진입)
- 나머지 6 stage skill = OPEN / INTENT / RESEARCH / VERIFY / REPORT / PROPOSE
