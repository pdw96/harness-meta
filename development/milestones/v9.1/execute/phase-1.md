---
phase: phase-1
milestone: v9.1
status: completed
---

# v9.1 phase-1 — ARCHITECTURE.md 사전적 정의 정합 분리 (atomic mechanical)

## Spec

```json
{
  "phase": "phase-1",
  "status": "completed",
  "scope": "ARCHITECTURE.md (559 줄) 안 § 4/5/6/7/11 + § 7 sub-split (§ 7.3/7.4 → WORKFLOW / § 7.1/7.2 → OPERATIONS) → development/WORKFLOW.md (신규, 265 줄) + development/OPERATIONS.md (신규, 92 줄) 신설. 잔류 § (§ 1/2/3/8/9/10) 재번호 → 신 § 1/2/3/4/5/6 (구 § 9→신 § 4 / 구 § 10→신 § 5 / 구 § 8→신 § 6 재배치). cascade host 28 file 새 path/§ 매핑 + smoke 5 메시지 갱신 + CLAUDE.md root 안 신 cross-ref pointer 추가 (lazy load).",
  "changes": [
    {
      "type": "create",
      "path": "development/WORKFLOW.md",
      "description": "신규 워크플로우 단일 source (265 줄, 13KB). intro + § 1 9-stage workflow + bundling + § 1 끝 매트릭스 (구 § 4) + § 2 Stage 본질 (구 § 7.3, H3 → H2 promote) + § 3 가벼운 흐름 (구 § 7.4, H3 → H2 promote) + § 4 분야 발현 mechanism 6 sub (구 § 11). § 2/§ 3 안 d_7 cross-ref 양방향 명시 (OPERATIONS.md § 3 AI Native 정의 통합 본질 보존)."
    },
    {
      "type": "create",
      "path": "development/OPERATIONS.md",
      "description": "신규 운영 매뉴얼 단일 source (92 줄, 4KB). intro + § 1 비대칭 의도 (구 § 5) + § 2 era 정책 + § 2.1 era 정책 (구 § 6 + § 6.1) + § 3 AI Native 정의 (구 § 7.1, H3 → H2 promote) + § 4 Entry title 가이드 (구 § 7.2, H3 → H2 promote). § 3 안 d_7 cross-ref 명시 (WORKFLOW.md § 2/§ 3 실 적용 사례)."
    },
    {
      "type": "edit",
      "path": "development/ARCHITECTURE.md",
      "description": "슬림화 — § 4/5/6/7/11 + § 7 sub 본문 제거 (WORKFLOW/OPERATIONS 이동). 잔류 § 재번호 = 구 § 9 → 신 § 4 (3-way 직교) + 구 § 10 → 신 § 5 (Auto-Mode) + 구 § 8 → 신 § 6 (관련 문서 재배치). intro 안 신 cross-ref hub 추가 (WORKFLOW.md / OPERATIONS.md 1차 source pointer). 559 → 235 줄 (net -324, 토큰 30K → 12K). self-ref 1 line 변환 (§ 9.X → § 4.X 등)."
    },
    {
      "type": "edit",
      "path": "CLAUDE.md",
      "description": "root 안 신 cross-ref pointer paragraph 추가 (d_3 lazy load + d_9 정합) — '본질 분리 1차 source (v9.1+): ARCHITECTURE/WORKFLOW/OPERATIONS lazy load'. @import 부재 (always-loaded 17K 토큰 증가 회피, 본 milestone 1차 의도 직접 정합). + cascade host 안 ARCHITECTURE § 7 → OPERATIONS § 3 등 변환 6 line."
    },
    {
      "type": "edit",
      "path": "AGENTS.md / README.md / GUARDRAILS.md / ROADMAP.md / .gitignore / .pre-commit-config.yaml / development/CLAUDE.md / development/ROADMAP.md / tests/CLAUDE.md / claude/commands/* (3) / agents/* (4) / bootstrap/agents/CLAUDE.md / skills/stage-*/SKILL.md (9) + skills/lightweight-flow/SKILL.md / projects/upbit/ROADMAP.md",
      "description": "cascade host 26 file 새 path/§ 매핑 (link target + § N 동시 변환). Python script atomic — SECTION_MAP 안 long pattern first (4 끝 / 7.4 / 7.3 / 7.2 / 7.1 / 6.1 / 4.1 / 11 / 10 / 9 / 8 / 7 / 6 / 5 / 4) + link target path fix (link text ↔ target 정합). 104 line 1차 변환 + 61 line link target post-fix + 2 line manual (agents/design-review.md § 10.2 → § 5.2 / skills/stage-open/SKILL.md § 11.4 → WORKFLOW § 4.4)."
    },
    {
      "type": "edit",
      "path": "tests/smoke-*.sh (5)",
      "description": "smoke 5 (smoke-spec-verification / smoke-scope-contract / smoke-bundle-trigger / smoke-open-stage-discipline / smoke-entry-title-guideline) 안 ARCHITECTURE § 6/§ 6.1/§ 7.2/§ 7.4 comment + error message 인용 → 새 path/§ (OPERATIONS § 2/§ 2.1/§ 4 / WORKFLOW § 3). 11 line 변환. smoke 로직 자체 path-agnostic — message drift 본질 정합 (risk_2 mitigation)."
    },
    {
      "type": "edit",
      "path": "development/ROADMAP.md (manual)",
      "description": "L18 summary 안 cascade script 잘못 변환 정정 — historical narrative ('구 ARCHITECTURE.md 안 § 11 개 중' historical reference) 복원. updated 필드 v9.1-approve → 유지 (phase-1 안 commit 후 phase-2 갱신)."
    }
  ],
  "verification": [
    {
      "method": "smoke 5 PASS (phase-1 commit 전 사전 확인)",
      "result": "PASS",
      "detail": "smoke-spec-verification PASS=547 (v9.1 INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE flattened era H2 OK) + smoke-scope-contract PASS=122 (out_of_scope/approval OK) + smoke-bundle-trigger PASS + smoke-open-stage-discipline PASS (checked=71, historical skipped=1) + smoke-entry-title-guideline PASS (no violations). 회귀 0."
    },
    {
      "method": "drift grep 3 형식 검증 (risk_1 mitigation, v8.2 규율)",
      "result": "PASS",
      "detail": "Python grep `ARCHITECTURE\\.md.*§ (4|5|6|7|11)` --exclude milestones/** + projects/*/audit-* + CHANGELOG dated + ADR 잔존 stale = 4 건 (모두 false positive 또는 의도적 — 2 = CLAUDE.md L65/66 안 ARCHITECTURE § 4/§ 5 (신 ARCHITECTURE 정합 OK) + 1 = ROADMAP summary historical narrative 보존 + 1 = stage-design SKILL § 6.2 scope_out 거명 d_8 정합). 진짜 stale = 0."
    }
  ],
  "commit": "<phase-1 commit SHA 후속>"
}
```

## Narrative

본 phase-1 은 v9.1 의 atomic mechanical 본질 — DESIGN d_1~d_9 + RESEARCH cb_2 active update target 28 file 일괄 적용. Python script 안 atomic slice + H2 renumber + self-ref + cascade host + link target fix 4 단계 수행. 단일 commit 안 묶음 — phase-2 (검증 only) 분리 (d_2 정합).

cascade 변환 안 risk_1 (cascade 누락 grep 3 형식 규율) + risk_2 (smoke 메시지 drift) + risk_3 (historical trace 오인 갱신, exclude 5 path 적용) + risk_4 (재번호 cascade 한 번에 정합) + risk_5 (lazy load CLAUDE.md @import 폐기) + risk_6 (§ 7 sub-split cross-ref 양방향) + risk_7 (§ 6.2 scope_out 거명) 모두 mitigation 적용. 단 cascade 변환 중 발견된 추가 drift 본질 = development/ROADMAP.md L18 summary 안 historical narrative ('ARCHITECTURE.md 안 § 11 개') 가 cascade script 안 잘못 변환됨 — Codex 검토 패턴 정합 (v9.1 RESEARCH 안 cb_2 정정 동일 패턴) manual Edit 으로 복원.

검증 = smoke 5 PASS + drift grep 잔존 0 (false positive 4 제외). EXECUTE phase-2 (active smoke 15 전체 PASS + drift 정합 finalize) 진입 가능.

## delta 통계

- 신규 파일 2: development/WORKFLOW.md (265 줄, 13KB) + development/OPERATIONS.md (92 줄, 4KB)
- 슬림 파일 1: development/ARCHITECTURE.md (559 줄 → 235 줄, net -324 LOC, 토큰 30K → 12K)
- cascade host edit: 28 file (root 7 + development 3 + tests 1 + claude/commands 3 + agents 4 + bootstrap 1 + skills 10 + projects/upbit 1) + smoke 5 메시지 = 33 file
- git diff stat (HEAD vs phase-1 working tree, .claude/* 제외): 32 files changed, +140 -462 (ARCHITECTURE.md 단독 +19 -343 LOC), 신규 2 file 추가 후 net 추정 +35 LOC

## phase-2 진입 게이트

phase-2 scope = active smoke 15 전체 PASS + drift grep 0 검증 (sc_6 통과 evidence). 잔존 issue 발견 시 phase-2 안 정정 (phase-1 회귀 trace 보존). 다음 commit = `docs(meta): [v9.1 EXECUTE phase-2]` 형식.
