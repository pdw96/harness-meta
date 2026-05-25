---
description: harness-meta milestone 산출물 + cascade marker 안 schema 의무 필드 — APPROVE.md approval wrap / INTENT.md id+title / cascade marker 16-hex dummy
paths:
  - "projects/*/milestones/**/APPROVE.md"
  - "projects/*/milestones/**/INTENT.md"
  - "**/*.md"
---

# schema-discipline — milestone 산출물 + cascade marker schema 의무

## APPROVE.md — approval 객체 wrap 의무

`approved_by` / `date` / `approval_summary` 3 필드 = `approval` 객체 안 wrap (top-level 직접 금지). top-level 에 두면 `smoke-spec-verification` Stage 5 FAIL ("필드 누락: approval"). 정확 schema 예시 = `development/milestones/v5.7/APPROVE.md`.

## INTENT.md — id + title 필드 의무

top-level 안 `id` (9-stage-bundled era v3.0+ = `v{X.Y}_{group-slug}`) + `title` (ROADMAP entry title 정합) 두 필드 항상 포함. 누락 시 `smoke-spec-verification` FAIL ("필드 누락: id,title").

## cascade marker — 16-hex dummy 의무

신규 cascade marker (`<!-- cascade-source: <path>#<anchor> expected-hash:<hash> -->`) 작성 시 hash 값 = **16-hex dummy** (`0000000000000000`) 사용. `cascade_sync.py` regex `expected-hash:[0-9a-f]{16}` 매칭 정합. PLACEHOLDER 영문 사용 시 regex 매칭 부재 → silent skip → drift detect 무력화.
