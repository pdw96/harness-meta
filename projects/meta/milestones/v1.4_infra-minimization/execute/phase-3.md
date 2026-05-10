# EXECUTE phase-3 — v1.4_infra-minimization

```json
{
  "phase": 3,
  "title": "ARCHITECTURE.md § 3.3 'Verification' (c) 정전화 + (b) smoke 카운트 갱신 + § 3.5 cascade grep host 5곳 본문 중복 부재 검증",
  "status": "in_progress",
  "commit": null,
  "scope_from_design": "DESIGN.phases[2] — 정의 § 3.3 매트릭스 'Verification' 행 (c) 갱신 = 정전 + (b) smoke 카운트 22 → 27 cascade 갱신 (Phase 1 drift 2건 제거 결과). § 3.5 cascade host 5곳 (root CLAUDE.md / AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md) 본문 중복 부재 grep 검증 결과 phase-3.md 에 기록. cascade grep 패턴은 v1.4_cross-ref-propagation phase-3.md L31 pattern 재활용.",
  "affected_files": [
    "projects/meta/ARCHITECTURE.md (§ 3.3 매트릭스 'Verification' 행 (b)+(c) 갱신)",
    "projects/meta/milestones/v1.4_infra-minimization/execute/phase-3.md"
  ],
  "changes": [
    {
      "file": "projects/meta/ARCHITECTURE.md",
      "edits": [
        {
          "anchor": "§ 3.3 매트릭스 'Verification' 행 (b) 컬럼 — 'smoke 22종'",
          "action": "rewrite (b) 셀",
          "new_content": "[`../../tests/`](../../tests/) smoke 27종 + pre-commit hook (.pre-commit-config.yaml) + `.github/workflows/ci.yml` + `VERIFY.md` (criteria_check)"
        },
        {
          "anchor": "§ 3.3 매트릭스 'Verification' 행 (c) 컬럼 — '혼재 — VERIFY.md narrative = 정전. smoke shell 인프라 = 임시방편 (후속 v1.4_infra-minimization 평가 대상)'",
          "action": "rewrite (c) 셀",
          "new_content": "**정전** — VERIFY.md narrative 가 1차 source. smoke shell / install / verify 인프라 는 narrative 보조 (drift 항목 제거 후 잔존 인프라가 [`tests/CLAUDE.md`](../../tests/CLAUDE.md) 매트릭스에 회귀 차단 책임 명시 — active 5 = pre-commit 강제, inactive 22 = manual run leverage)"
        }
      ],
      "rationale": "DESIGN D4 결정 표기 직접 적용. (c) 셀 markdown link 표기 (architecture 검토 권고 #4) 반영 — 현행 (b) 컬럼 cross-ref 패턴과 일관성. (b) 컬럼 카운트 cascade 갱신 (22 → 27) Phase 1 drift 2건 제거 결과 반영."
    }
  ],
  "cascade_grep_results_d6": {
    "purpose": "§ 3.5 단일 source 정합 직접 검증 — cross-ref host 5곳 (root CLAUDE.md / AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md) 정의 본문·매트릭스 중복 부재 확인",
    "patterns_grepped": [
      "Context.*Workflow.*Constraint.*Verification.*Trace (5요소 매트릭스 표 형식)",
      "smoke shell 인프라 = 임시방편|혼재 — VERIFY\\.md narrative (구 (c) 분류 본문 형식)",
      "정전 — VERIFY\\.md narrative 가 1차 source (신규 (c) 본문 형식)",
      "하네스 엔지니어링은 agent 의 행동을 (정의 § 3.1 본문 형식)"
    ],
    "host_results": {
      "CLAUDE.md (root)": "5요소 cross-ref 1줄 only (L8) — 매트릭스 표 형식 0, (c) 분류 본문 0, 정의 § 3.1 본문 0. 정상 cross-ref.",
      "AGENTS.md": "5요소 영문 cross-ref 1 paragraph — 'New milestones must map to one of these five elements'. 매트릭스 표 형식 0, (c) 분류 본문 0. 정상 cross-ref.",
      "README.md": "5요소 영문 cross-ref 1 standalone block (L5 직후 quote) — 'Harness engineering definition' 1줄. 매트릭스 표 형식 0, (c) 분류 본문 0. 정상 cross-ref.",
      "projects/meta/CLAUDE.md": "5요소 한국어 cross-ref 1줄 (H1 직후) — '하네스 엔지니어링 정의'. 매트릭스 표 형식 0, (c) 분류 본문 0. 정상 cross-ref.",
      "GUARDRAILS.md": "5요소 한국어 cross-ref § 1 안 1줄 + § 6 References 거명 — '하네스 엔지니어링 정의'. 매트릭스 표 형식 0, (c) 분류 본문 0. 정상 cross-ref."
    },
    "verdict": "5 host 모두 단일 source 정합 보장. 본 phase 의 ARCHITECTURE § 3.3 (c) 갱신 cascade 영향 zero — 본문 중복 부재 = 다른 host 갱신 의무 부재. § 3.5 정신 직접 작동 확인."
  },
  "expected_commit_message": "feat(meta): v1.4 phase-3 — ARCHITECTURE § 3.3 매트릭스 'Verification' 정전화 + § 3.5 cascade grep host 5곳 검증",
  "verification_post_commit": [
    "grep '정전 — VERIFY.md narrative 가 1차 source' projects/meta/ARCHITECTURE.md → 1 hit ((c) 셀 갱신 확인)",
    "grep 'smoke shell 인프라 = 임시방편' projects/meta/ARCHITECTURE.md → 0 hit (구 표기 제거 확인)",
    "grep '혼재 — VERIFY' projects/meta/ARCHITECTURE.md → 0 hit (구 분류 표기 제거 확인)",
    "grep 'smoke 27종' projects/meta/ARCHITECTURE.md → 1 hit ((b) 카운트 cascade 갱신 확인)",
    "grep 'smoke 22종' projects/meta/ARCHITECTURE.md → 0 hit (구 카운트 제거 확인)",
    "5 host cascade — root CLAUDE.md / AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md 본문 중복 부재 (cascade_grep_results_d6 verdict)",
    "pre-commit run --all-files → 5 hook PASS"
  ],
  "execution_notes": null
}
```

## 진행

phase-3 = ARCHITECTURE § 3.3 'Verification' 행 (b) + (c) 갱신 + § 3.5 cascade grep host 5곳 본문 중복 부재 trace 보존. DESIGN.decisions[3] (D4) 결정의 직접 실행 + DESIGN.decisions[5] (D6) cascade grep 검증. 본 milestone 의 핵심 정전화 산출.
