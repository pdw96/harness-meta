---
id: v6.6_audit-chain-hallucination-auto-correction_phase-1
title: mechanism 본질 — script + smoke + fixture
version: v6.6
phase: 1
status: complete
---

# v6.6 phase-1 — mechanism 본질 (script + smoke + fixture)

## Spec

```json
{
  "phase": 1,
  "title": "mechanism 본질 — script + smoke + fixture",
  "status": "complete",
  "changes": [
    {
      "file": "scripts/audit_fact_verify.py",
      "action": "create",
      "lines": "~250 LOC (D1 parser 우선 stdlib only re+json+pathlib, D2 callable lookup, D10 path traversal 차단, D11 stdlib only no PyYAML, D12 자기 정전화 자연)",
      "summary": "audit chain 4 agent 산출물 (.md) 안 boolean/표/수치 3 method fact 인용 자동 detect → mismatch 보고. BOOLEAN_LOOKUP 5 evidence-base 항목 (cycle 2 v5.11 자연 확장) + NUMERIC_LOOKUP empty 초기 no-op fallback. safe_resolve() = REPO_ROOT prefix 검증 + symlink reject. CLI = `--dir <audit-output> [--strict]` (v6.4/v6.5 정합). exit 0/1/2."
    },
    {
      "file": "tests/smoke-audit-fact-verify.sh",
      "action": "create",
      "summary": "fixture-based read-only contract 검증. 6 fixture sub-dir × expected exit code + Stage 5 path traversal (D10 보안 P1#1) reject 검증. python3 환경 가드 + SKIP fallback."
    },
    {
      "file": "tests/fixtures/audit-fact-verify/boolean-normal/scanner-output.md",
      "action": "create",
      "summary": "boolean fact 5종 모두 정합 (BOOLEAN_LOOKUP 자연 매핑). expected exit 0."
    },
    {
      "file": "tests/fixtures/audit-fact-verify/boolean-mismatch/scanner-output.md",
      "action": "create",
      "summary": "cycle 2 v5.11 evidence 모방 — `claude_md_in_repo: false` (실제 true). expected exit 1 + boolean mismatch."
    },
    {
      "file": "tests/fixtures/audit-fact-verify/table-normal/mapper-output.md",
      "action": "create",
      "summary": "표 안 source_path column 3 row 모두 실 존재 (CLAUDE.md, projects/meta/ARCHITECTURE.md, ROADMAP.md). expected exit 0."
    },
    {
      "file": "tests/fixtures/audit-fact-verify/table-mismatch/mapper-output.md",
      "action": "create",
      "summary": "cycle 1 v5.10 + cycle 3 v5.12 evidence 모방 — 표 row 안 `source_path: projects/meta/nonexistent-fact.md` 부재. expected exit 1 + table mismatch."
    },
    {
      "file": "tests/fixtures/audit-fact-verify/numeric-normal/scanner-output.md",
      "action": "create",
      "summary": "numeric pattern 3 인용 (loc_estimate/total_milestones/active_smoke_count) — NUMERIC_LOOKUP empty 초기 no-op fallback. expected exit 0."
    },
    {
      "file": "tests/fixtures/audit-fact-verify/empty-targets/scanner-output.md",
      "action": "create",
      "summary": "fact 인용 0 건 plain narrative. edge case (no detect targets). expected exit 0."
    },
    {
      "file": ".pre-commit-config.yaml",
      "action": "edit",
      "summary": "v6.6 smoke-audit-fact-verify hook 추가 (local 11번째, direct entry, files: pattern = script + smoke + fixture 자체)"
    },
    {
      "file": "tests/CLAUDE.md",
      "action": "edit",
      "summary": "smoke 매트릭스 11 hook active + 본 row 추가 + 현행 hook 표 row 추가 + 총 hook count 갱신 (10 → 11)"
    },
    {
      "file": "projects/meta/milestones/v6.6/MILESTONE.md",
      "action": "edit",
      "summary": "Stage A entry (MILESTONE.md 스켈레톤) + Stage B INTENT + Stage C RESEARCH + Stage D DESIGN (12 decisions + 5 관점 검토 결과 narrative) + Stage E APPROVE + SUB_MILESTONES sub_milestones[] 1:1 동기 (phase-1 complete + phase-2 in_progress)"
    },
    {
      "file": "projects/meta/ROADMAP.md",
      "action": "edit (Stage A)",
      "summary": "candidate_draft[0] 삭제 + milestones[] 안 v6.6 in_progress entry 최상단 추가 + next_candidates[3] 제거 (이미 in_progress 진입)"
    },
    {
      "file": "projects/meta/milestones/v6.6/execute/phase-1.md",
      "action": "create",
      "summary": "본 phase-1 spec/execution_notes (자체 신규)"
    }
  ],
  "execution_notes": "Stage F EXECUTE phase-1 (mechanism 본질). pre-PLAN 4 round 결정 (R1~R4) + 5 관점 subagent 병렬 검토 (pass × 2 + pass-with-comments × 3 + decisive 0) + P1 7건 흡수 (DESIGN.D2/D3/D5/D10 보강 + D11/D12 신규) + 사용자 명시 APPROVE 후 진입. script + smoke + fixture 6 sub-dir + .pre-commit-config.yaml + tests/CLAUDE.md 등재 일괄 작업. 실 smoke 호출 결과 = 7 stage 모두 PASS (boolean × 2 + table × 2 + numeric + empty + path traversal). 도그푸드 = phase-2 안 본 milestone 산출물 (MILESTONE.md ## INTENT/RESEARCH/DESIGN) fact 검증 (mechanism 자체 적용 cycle 32 self-host).",
  "commit": "<phase-1 commit 후 갱신>"
}
```

## Changes

phase-1 변경 본질 = mechanism 본질 자체 작동 검증 + INTENT~APPROVE artifact 영구 보존 (commit 시점 default (b) 정합 — phase-1 commit 안 INTENT/RESEARCH/DESIGN/APPROVE 본문 포함).

## Execution Notes

- `scripts/audit_fact_verify.py` 작성 직후 fixture 6 case manual 호출 검증 — 모두 expected exit code (0/1/0/1/0/0) 정확.
- `tests/smoke-audit-fact-verify.sh` 작성 후 자체 호출 = 7 stage PASS (boolean × 2 + table × 2 + numeric + empty + path traversal Stage 5).
- D10 보안 narrative 안 path prefix = 처음 `projects/` 한정 명시했으나 fixture (`tests/fixtures/audit-fact-verify/`) cover 위해 REPO_ROOT prefix 로 자연 확장. DESIGN.D10 narrative 정합 — 안전성 동치 (REPO_ROOT 외부 reject).
- D11/D12 신규 결정 narrative = phase-2 안 ARCHITECTURE § 4 끝 #10 paragraph 안 자연 흡수 (자기 정전화 자연 narrative).
- pre-commit hook 11번째 등재 (`.pre-commit-config.yaml` + `tests/CLAUDE.md` 양자 cascade).
