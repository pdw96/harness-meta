# EXECUTE phase-1 — v1.4_infra-minimization

```json
{
  "phase": 1,
  "title": "drift smoke 2건 제거 + tests/CLAUDE.md L7 count 동기 cascade",
  "status": "complete",
  "commit": "3f918d3",
  "scope_from_design": "DESIGN.phases[0] — narrative 책임 부재 + 매트릭스 미거명 + pre-commit 미연결 = drift 2건 단순 제거. tests/CLAUDE.md L7 count 1줄 갱신은 drift 제거의 기계적 cascade (smoke-claude-md-drift 회귀 차단 hook 통과 의무) — 매트릭스 표 narrative 강화는 Phase 2 책임.",
  "affected_files": [
    "tests/smoke-l5-readme-link-cleanup.sh (삭제)",
    "tests/smoke-v1.1.sh (삭제)",
    "tests/CLAUDE.md (L7 count 1줄 갱신: '현 29 파일' → '현 27 파일')",
    "projects/meta/milestones/v1.4_infra-minimization/execute/phase-1.md"
  ],
  "drift_evidence_4tier_vs_7stage": [
    {
      "file": "tests/smoke-l5-readme-link-cleanup.sh",
      "L1_comment": "# v1.10h2 smoke — AGENTS.md.tmpl L5 'See [README.md](README.md) for project overview...' 제거",
      "era": "4-tier (v1.10h2 시기) — 1회성 cleanup smoke, AGENTS.md.tmpl L5 의 README link 잔존 검증",
      "7stage_relevance": "부재 — 7-stage spec (v1.0+) 의 PLAN/RESEARCH/DESIGN/VERIFY/REPORT JSON schema 검증과 무관, bootstrap/skeletons/AGENTS.md.tmpl 의 1회성 정정 검증",
      "narrative_responsibility_in_matrix": "tests/CLAUDE.md '현행 29 파일' 매트릭스 표 (핵심 정책 / 인프라 / 도메인 회귀) 어디에도 등재 부재 → narrative 1차 source 책임 명시 부재 → 인프라 잔존 정당성 부재"
    },
    {
      "file": "tests/smoke-v1.1.sh",
      "L1_comment": "# v1.1 manifest fixture smoke — v1.6 bash hook/statusline이 v1.1 신규 필드 파싱 정상 + 회귀 없음",
      "era": "4-tier era 의 schema v1.1 시점 (v1.6 bash hook era) — schema-v1.1-full fixture 기반 hook + statusline 동작 회귀 검증",
      "7stage_relevance": "부재 — 7-stage milestone 산출물 (PLAN/RESEARCH/DESIGN/VERIFY/REPORT) 검증 책임 부재, 4-tier schema v1.1 fixture 의 hook 동작 검증만",
      "narrative_responsibility_in_matrix": "tests/CLAUDE.md 매트릭스 미등재 → narrative 책임 부재"
    }
  ],
  "changes": [
    {
      "file": "tests/smoke-l5-readme-link-cleanup.sh",
      "action": "delete",
      "rationale": "4-tier era 잔존, 매트릭스 미거명, pre-commit 미연결, 7-stage 무관 = drift. DESIGN D2 결정."
    },
    {
      "file": "tests/smoke-v1.1.sh",
      "action": "delete",
      "rationale": "4-tier era 잔존, 매트릭스 미거명, pre-commit 미연결, 7-stage 무관 = drift. DESIGN D2 결정."
    },
    {
      "file": "tests/CLAUDE.md",
      "edits": [
        {
          "anchor": "L7 '## smoke 매트릭스 (현 29 파일)'",
          "action": "rewrite L7",
          "new_content": "## smoke 매트릭스 (현 27 파일)"
        }
      ],
      "rationale": "drift 2건 제거의 기계적 count cascade. smoke-claude-md-drift hook 의 'smoke count 정합' 검증 통과 의무. 매트릭스 표 narrative 강화 (active vs inactive 컬럼 등) 는 Phase 2 단일 책임 — Phase 1 은 count 1줄만 갱신."
    }
  ],
  "narrative_replacement_mechanism_per_design_d9": {
    "summary": "DESIGN D9 (a/b/c) 1:1 매핑 — drift 2건 제거의 narrative 대체 메커니즘",
    "mappings": {
      "a_tests_claude_md_matrix": "drift 2건 매트릭스 미거명 → narrative 1차 source 책임 부재 → 단순 제거가 곧 narrative 정합 (책임 부재 인프라 부재)",
      "b_user_manual_run_leverage": "drift 2건 = active 미연결 + 매트릭스 미등재 = manual run leverage 명시 부재 → 인프라 잔존 정당성 부재 자체가 narrative 대체 정당성",
      "c_design_decisions_trace": "본 phase-1.md drift_evidence_4tier_vs_7stage 필드 + DESIGN D2 alternatives_rejected = narrative 대체 결정의 영속 trace (Trace 5요소 정전)"
    }
  },
  "expected_commit_message": "feat(meta): v1.4 phase-1 — drift smoke 2건 제거 (smoke-l5 / smoke-v1.1) + tests/CLAUDE.md count 동기",
  "verification_post_commit": [
    "ls tests/smoke-l5-readme-link-cleanup.sh 2>/dev/null → not found (삭제 확인)",
    "ls tests/smoke-v1.1.sh 2>/dev/null → not found (삭제 확인)",
    "grep '현 27 파일' tests/CLAUDE.md → 1 hit (L7 갱신 확인)",
    "grep '현 29 파일' tests/CLAUDE.md → 0 hit (L7 stale 제거 확인)",
    "ls tests/smoke-*.sh | wc -l → 27 (실제 카운트 정합)",
    "pre-commit run --all-files → smoke-projects-scope-discipline / smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift 5 hook PASS (특히 smoke-claude-md-drift 의 count 정합 검증)"
  ],
  "execution_notes": "drift smoke 2건 (smoke-l5-readme-link-cleanup.sh / smoke-v1.1.sh) 단순 제거 + tests/CLAUDE.md L7 count 1줄 갱신 (현 29 → 27). 실제 ls tests/smoke-*.sh 카운트 = 27 정합 검증. pre-commit 5 hook 모두 PASS (markdownlint / smoke-projects-scope-discipline / smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift) — 특히 smoke-claude-md-drift 의 'smoke count 정합' 검증 통과 (drift 차단 hook 회귀 차단 책임 작동 확인). commit 3f918d3, 8 files changed (563 insertions / 56 deletions — milestone 산출물 4건 신규 + ROADMAP 갱신 + tests/CLAUDE.md 1줄 + drift 2건 삭제). 회귀 0. drift 2건 narrative 대체 메커니즘 = DESIGN D9 (a) tests/CLAUDE.md 매트릭스 미거명 = narrative 책임 부재 / (b) manual run leverage 명시 부재 / (c) 본 phase-1.md drift_evidence_4tier_vs_7stage 필드 + DESIGN D2 alternatives_rejected = 영속 trace 1:1 매핑 확정."
}
```

## 진행

phase-1 = 4-tier era 잔존 drift smoke 2건 단순 제거 + tests/CLAUDE.md L7 count 1줄 cascade. DESIGN.decisions[1] (D2) 결정의 직접 실행. drift_evidence_4tier_vs_7stage 필드 = scope contract 검토 권고 #3 (smoke-l5/v1.1 코드 review 증거 보존) 반영. narrative_replacement_mechanism_per_design_d9 = D9 1:1 매핑 영속 trace.
