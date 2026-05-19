---
id: ai-native-operation-reframe-and-entry-title-guideline
title: AI Native 운영 reframe + entry title 가이드 정전화
version: v6.0
stage: VERIFY
status: completed
---

# VERIFY — v6.0

## Spec

```json
{
  "criteria_check": [
    {
      "sc_id": "sc_1",
      "description": "ARCHITECTURE.md 안 'AI Native 운영' 정의 신규 § (1 paragraph + 3 면 매트릭스)",
      "status": "PASS",
      "evidence": "ARCHITECTURE.md L228 § 7 'AI Native 운영' + L230 §§ 7.1 정의 + 3 면 매트릭스 hardcode (컨텍스트 효율 + 자율성 + 다중 AI 협업)"
    },
    {
      "sc_id": "sc_2",
      "description": "ROADMAP/CHANGELOG entry title 가이드 정전화 (4 원칙)",
      "status": "PASS",
      "evidence": "ARCHITECTURE.md L244 §§ 7.2 Entry title 가이드 4 원칙 hardcode (P1~P4)"
    },
    {
      "sc_id": "sc_3",
      "description": "가장 긴 long-title 3~5건 retitle (D4 정정 후 7건 = 4 ROADMAP + 3 CHANGELOG)",
      "status": "PASS",
      "evidence": "ROADMAP 4 entry retitle (v6.0 self-dogfood + v5.21 + v5.20 + v5.19) + CHANGELOG 3 bullet header retitle. artifact 5건 title 동기"
    },
    {
      "sc_id": "sc_4",
      "description": "cascade host 동기 갱신 (D11 정정 후 6 host)",
      "status": "PASS",
      "evidence": "6 cascade host 'AI Native 운영' cross-ref — CLAUDE.md L8 / projects/meta/CLAUDE.md L5 / AGENTS.md L5 / README.md L5 / projects/meta/ROADMAP.md schema_note / CHANGELOG.md [v6.0] entry"
    },
    {
      "sc_id": "sc_5",
      "description": "회귀 0 (pre-commit 14 hook PASS)",
      "status": "PASS",
      "evidence": "commit 04bdcf2 안 pre-commit 14 hook 모두 PASS (단 markdownlint MD012 1회 + smoke-cross-ref --fix 1회 정정 후 재 commit 시 모두 PASS)"
    },
    {
      "sc_id": "sc_6",
      "description": "schema smoke-spec-verification 통과 (필드 누락 0)",
      "status": "PASS",
      "evidence": "smoke-spec-verification PASS — INTENT/RESEARCH/DESIGN/APPROVE 산출물 schema 정합 (memory feedback_intent_md_schema_required + feedback_approve_md_schema_wrap 정합)"
    }
  ],
  "verdict": "pass"
}
```

## Smoke tests

- pre-commit 14 hook (commit 04bdcf2 자동 실행) — command: git commit (pre-commit hook 자동); result: PASS (단 markdownlint 첫 시도 시 MD012 1회 / smoke-cross-ref 첫 시도 시 --fix 1회 — 정정 후 재 commit 시 모두 PASS); output: end-of-file-fixer / trailing-whitespace / check-merge-conflict / check-yaml / check-added-large-files / shellcheck / markdownlint / smoke-projects-scope-discipline / smoke-spec-verification / smoke-scope-contract / smoke-cross-ref (--fix 정정) / smoke-claude-md-drift / smoke-bundle-trigger / smoke-open-stage-discipline 모두 PASS

## Manual checks

- check: ARCHITECTURE.md § 7 신규 + § 8 shift (D1); result: PASS; notes: grep `^## 7\.|^## 8\.` 결과 = 'L228: ## 7. AI Native 운영' + 'L253: ## 8. 관련 문서' 정합
- check: 'AI Native' keyword cascade 6 host 등장 (D11); result: PASS; notes: grep 결과 13 파일 등장 = 6 cascade host (CLAUDE.md root + projects/meta/CLAUDE.md + AGENTS.md + README.md + projects/meta/ARCHITECTURE.md + CHANGELOG.md) + projects/meta/ROADMAP.md (schema_note) + v6.0 artifact 6건
- check: ROADMAP milestones[] = v6.0 + v5.21 + v5.20 (v5.19 archival 완료); result: PASS; notes: grep `"version": "v(5.19|5.20|5.21|6.0)"` 결과 = L12 v6.0 + L21 v5.21 + L30 v5.20 (v5.19 부재 = archival 정합, D12)
- check: milestone artifact 5건 title field 동기 (D10 self-dogfood); result: PASS; notes: INTENT.md L7 + RESEARCH.md L7 + DESIGN.md L7 + APPROVE.md L7 + milestones.md spec.title 모두 'AI Native 운영 reframe + entry title 가이드 정전화' 동기 (milestones.md = '...(self-dogfood)' 추가) — 가이드 4 원칙 정합 (≤ 60자 / 한 본질 / active form / detail summary)
- check: v6.0 entry title self-dogfood (84자 → 32자, D10); result: PASS; notes: ROADMAP v6.0 entry title = 'AI Native 운영 reframe + entry title 가이드 정전화' (32자) — 가이드 4 원칙 정합
- check: CHANGELOG [v6.0] entry 신규 + bullet header 3 retitle (D4); result: PASS; notes: CHANGELOG.md L11 [v6.0] - 2026-05-19 entry 신규 + L34 v5.21 + L46 v5.20 + L52 v5.19 bullet header 동기 retitle (ROADMAP title 와 1:1)
- check: smoke --fix 결과 (REPORT.md cross-ref 2행 자동 삭제); result: 수용 후 자연 보강 예정; notes: ARCHITECTURE.md:253 + CHANGELOG.md:24 REPORT.md cross-ref 행이 smoke-cross-ref --fix 안 자동 삭제 (REPORT.md 부재 = broken ref). Stage H REPORT.md 작성 후 cross-ref 자연 보강. 단 본 milestone 시점 trace 보존 부족 — REPORT.md 안 명시 narrative 의무

## Regressions

(empty)

## Smoke fix acknowledgement

smoke-cross-ref --fix 안 ARCHITECTURE.md:253 + CHANGELOG.md:24 REPORT.md cross-ref 2행 자동 삭제 = 수용. Stage H REPORT.md 작성 시 자연 cross-ref 추가. 단 본 시점 trace 부재 narrative — REPORT.md 안 명시 의무.

## v3.21 narrative 정전화 3 단계 패턴 cycle 25 도그푸드 검증

본 milestone = (a) DESIGN 1차 = DESIGN.md L228 D1 narrative + DESIGN.md L185 § 7 정의 preliminary + L195 §§ 7.2 가이드 preliminary / (b) EXECUTE Edit = ARCHITECTURE.md § 7 + § 3.1 backward + ROADMAP/CHANGELOG retitle + cascade 6 host / (c) VERIFY grep = 본 § (cascade 6 host keyword 등장 검증 + § 7/§ 8 numbering 검증 + archival 검증). 3 단계 통합 PASS — cycle 25 도그푸드 완성.

## 관련

- DESIGN: [`DESIGN.md`](DESIGN.md) (D1~D12)
- 검증 대상 host (6 cascade): [`../../../CLAUDE.md`](../../../CLAUDE.md) / [`../../CLAUDE.md`](../../CLAUDE.md) / [`../../../AGENTS.md`](../../../AGENTS.md) / [`../../../README.md`](../../../README.md) / [`../../ROADMAP.md`](../../ROADMAP.md) / [`../../../CHANGELOG.md`](../../../CHANGELOG.md)
- ARCHITECTURE.md § 7 신규 + § 8 shift: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)
- commit: `04bdcf2` (13 파일 769+/28-)
