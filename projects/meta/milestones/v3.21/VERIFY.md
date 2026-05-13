# VERIFY — v3.21_narrative-canonicalization-3step-pattern

```json
{
  "id": "v3.21_narrative-canonicalization-3step-pattern",
  "smoke_tests": [
    {
      "name": "pre-commit hook 14건",
      "command": "git commit (phase-1 commit 03c1830 시 자동 실행)",
      "result": "PASS",
      "output": "fix end of files / trim trailing whitespace / check for merge conflicts / check yaml (skipped) / check for added large files / shellcheck (skipped) / markdownlint / Smoke smoke-projects-scope-discipline / Smoke smoke-spec-verification (PASS 290 FAIL 0 SKIP 110) / Smoke smoke-scope-contract / Smoke smoke-cross-ref-integrity / Smoke smoke-claude-md-drift (skipped) / Smoke smoke-bundle-trigger / Smoke smoke-open-stage-discipline = 14 hook 모두 PASS (실 실행 9 + skipped 5)"
    },
    {
      "name": "grep 키워드 검증 (3단계 패턴 (c) 단계 자기 적용 도그푸드)",
      "command": "grep -c '<키워드>' projects/meta/ARCHITECTURE.md",
      "result": "PASS",
      "output": "Narrative 정전화 3단계 패턴 = 1 / v3.18_option-a-natural-adaptation-narrative = 2 / v3.20_drift-narrative-canonicalization = 2 / v3.21_narrative-canonicalization-3step-pattern = 1 / (a) DESIGN 안 정확 문구 1차 source = 1 / (b) phase-1 EXECUTE Edit 그대로 삽입 = 1 / (c) VERIFY grep 검증 키워드 = 1 / lightweight 모드 default = 1 / 도그푸드 = 4 = 9 키워드 모두 ≥1 PASS"
    },
    {
      "name": "ARCHITECTURE.md paragraph 1건 추가 검증",
      "command": "git diff HEAD^ HEAD -- projects/meta/ARCHITECTURE.md",
      "result": "PASS",
      "output": "+2 line (paragraph 1건 = bold lead + 3 단계 정의 + cross-ref + 적용 trigger + 도그푸드 표지) — § 6.2 'Workflow self-improvement 동결 정책' paragraph 직후 + '선례' subsection 직전 정확 위치"
    },
    {
      "name": "워크플로우 본문 변경 zero 검증",
      "command": "git diff HEAD^ HEAD --stat | grep harness-meta.md",
      "result": "PASS",
      "output": "claude/commands/harness-meta.md 변경 0 (워크플로우 본문 불변, INTENT.out_of_scope #1 정합)"
    },
    {
      "name": "smoke 추가 zero 검증",
      "command": "git diff HEAD^ HEAD --stat | grep 'tests/'",
      "result": "PASS",
      "output": "tests/* 변경 0 (smoke 추가 zero, INTENT.out_of_scope #2 정합)"
    },
    {
      "name": "다른 host cross-ref 추가 zero 검증 (단일 source 전략)",
      "command": "git diff HEAD^ HEAD --stat",
      "result": "PASS",
      "output": "변경 파일 8건 = ARCHITECTURE.md + ROADMAP.md + v3.21 milestone 산출물 6건. CLAUDE.md root / projects/meta/CLAUDE.md / harness-meta.md / CHANGELOG.md / AGENTS.md / README.md / GUARDRAILS.md 변경 0 = 단일 source 전략 (D3) 정확 정합"
    }
  ],
  "manual_checks": [
    {
      "check": "3단계 패턴 자기 적용 도그푸드",
      "result": "PASS",
      "notes": "(a) DESIGN.md ## Phase 1 정확 narrative 정문구 섹션 안 markdown code block 정확 문구 1차 source = OK / (b) phase-1 EXECUTE 안 Edit tool 정확 문구 그대로 삽입 commit 03c1830 = OK / (c) VERIFY 안 grep 검증 9 키워드 모두 PASS = OK. 자기참조 cycle 3번째 (v3.18 + v3.20 + v3.21) 완성"
    },
    {
      "check": "lightweight 모드 표지 (5 관점 subagent 생략)",
      "result": "PASS",
      "notes": "DESIGN.review.mode: lightweight / subagent_review_policy: skipped / self_reference_policy: avoid 명시. v3.6/v3.10/v3.13/v3.14/v3.17/v3.18/v3.19/v3.20 누적 8/20 패턴 9번째 적용. 9/21 = 42.9% (v3.20 40% 첫 돌파 후 추가 cycle)"
    },
    {
      "check": "INTENT.out_of_scope 7건 사실 진술 (v3.10 부산물 정책 정합)",
      "result": "PASS",
      "notes": "out_of_scope 7건 모두 negative scope 사실 진술 — '워크플로우 본문 변경' / 'smoke 추가' / '다른 host cross-ref' / 'v3.20 carry-over' / '5 관점 subagent' / '다른 host 거명' / 'L4 외 lessons'. 후속 milestone 발의 명령형 ('별 milestone 으로') 부재"
    },
    {
      "check": "byproduct_check (DESIGN.decisions[i].rationale + phases[n].scope 사실 진술)",
      "result": "PASS",
      "notes": "DESIGN.byproduct_check 직접 명시. forward propose 명령형 ('PROPOSE.next_candidates 발의 narrative' / '별 milestone 분리') 부재 — v3.10 부산물 정책 정합"
    }
  ],
  "criteria_check": [
    {
      "criterion_id": "SC1",
      "criterion": "3단계 패턴 narrative 단일 source 위치 host 1곳 결정",
      "result": "PASS",
      "evidence": "D1 = ARCHITECTURE.md § 6.2 Lightweight 모드 안 ('Workflow self-improvement 동결 정책' 직후, '선례' 직전) — 사용자 명시 선택 Option 3 AskUserQuestion"
    },
    {
      "criterion_id": "SC2",
      "criterion": "host 안 정확 문구 (markdown code block + 3 단계 (a)/(b)/(c) + v3.18/v3.20 cross-ref + 적용 trigger) 신규 paragraph 1건 추가",
      "result": "PASS",
      "evidence": "grep 9 키워드 모두 ≥1 PASS — 'Narrative 정전화 3단계 패턴' = 1 / '(a) DESIGN 안 정확 문구 1차 source' = 1 / '(b) phase-1 EXECUTE Edit 그대로 삽입' = 1 / '(c) VERIFY grep 검증 키워드' = 1 / v3.18 cross-ref = 2 / v3.20 cross-ref = 2 / v3.21 cross-ref = 1 / 'lightweight 모드 default' (적용 trigger) = 1 / '도그푸드' (자기 적용 표지) = 4. 정확 문구 1 paragraph (+2 line)"
    },
    {
      "criterion_id": "SC3",
      "criterion": "본 milestone 자체가 3단계 패턴 자기 적용 도그푸드 — DESIGN 정확 문구 + EXECUTE Edit 그대로 + VERIFY grep 검증",
      "result": "PASS",
      "evidence": "(a) DESIGN.md ## Phase 1 정확 narrative 정문구 섹션 (markdown code block) / (b) phase-1 EXECUTE 안 Edit tool 정확 문구 그대로 (commit 03c1830 +2 line) / (c) VERIFY grep 9 키워드 모두 ≥1 PASS. 자기참조 cycle 3번째 = 3 cycle 누적 정전화 권장 trigger 정확 충족"
    },
    {
      "criterion_id": "SC4",
      "criterion": "워크플로우 본문 (Stage A~I 9-stage 절차) 변경 zero",
      "result": "PASS",
      "evidence": "git diff HEAD^ HEAD --stat 안 claude/commands/harness-meta.md 변경 0 (INTENT.out_of_scope #1 정합)"
    },
    {
      "criterion_id": "SC5",
      "criterion": "smoke 추가 / 변경 zero",
      "result": "PASS",
      "evidence": "git diff HEAD^ HEAD --stat 안 tests/* 변경 0 (INTENT.out_of_scope #2 정합)"
    },
    {
      "criterion_id": "SC6",
      "criterion": "다른 host cross-ref 추가 zero (단일 source 전략, v3.18 D1 패턴 정합)",
      "result": "PASS",
      "evidence": "변경 파일 8건 = ARCHITECTURE.md + ROADMAP.md + v3.21 산출물 6건. CLAUDE.md root / projects/meta/CLAUDE.md / harness-meta.md / CHANGELOG.md / AGENTS.md / README.md / GUARDRAILS.md 변경 0 = D3 단일 source 전략 정확 정합"
    },
    {
      "criterion_id": "SC7",
      "criterion": "pre-commit 14 hook PASS + 회귀 0",
      "result": "PASS",
      "evidence": "phase-1 commit 03c1830 시 pre-commit 14 hook 모두 PASS (실 실행 9 + skipped 5), 회귀 0"
    },
    {
      "criterion_id": "SC8",
      "criterion": "산출물 LOC 총 ≤700 line (lightweight cap 1500 권고 약 47% 활용)",
      "result": "PASS",
      "evidence": "phase-1 commit 03c1830 = 521 insertions (8 files, +1 deletion = ROADMAP.md updated date 갱신). 521 line ≤ 700 target ≤ 1500 cap. v3.17 ~495 / v3.18 ~400 / v3.19 ~575 / v3.20 ~503 / v3.21 ~521 = 평균 ~499 line (5 cycle 누적 안정)"
    }
  ],
  "verdict": "pass",
  "regressions": []
}
```

## narrative

본 VERIFY 는 **검증 (smoke / criteria_check / verdict)** 단일 책임 — INTENT.success_criteria 8건 1:1 매핑 + smoke 6건 + manual_checks 4건. verdict: pass.

`criteria_check` 8건 모두 PASS — SC1 (host 위치) / SC2 (정확 문구 + grep) / SC3 (자기 적용 도그푸드) / SC4 (워크플로우 변경 zero) / SC5 (smoke 변경 zero) / SC6 (단일 source) / SC7 (pre-commit) / SC8 (LOC cap).

`smoke_tests` 6건 모두 PASS — pre-commit 14 hook + grep 9 키워드 + paragraph 1건 + 워크플로우 zero + smoke zero + 다른 host zero.

`manual_checks` 4건 모두 PASS — 3단계 패턴 자기 적용 도그푸드 + lightweight 표지 + INTENT.out_of_scope 사실 진술 + byproduct_check.

## 3단계 패턴 (c) 단계 자기 적용 도그푸드

본 VERIFY 자체가 3단계 패턴 **(c) VERIFY grep 검증 키워드** 단계 자기 적용 — DESIGN.md ## Phase 1 정확 narrative 정문구 섹션 안 markdown code block (a) 정확 문구 안 cohesive 키워드 9건 직접 추출 → grep 검증 모두 ≥1 PASS. (a) 와 (b) 의 정합 직접 검증.

## 관련

- INTENT.success_criteria (8건 source): [`INTENT.md`](INTENT.md)
- DESIGN (decisions D1~D6 source): [`DESIGN.md`](DESIGN.md)
- execute/phase-1.md (commit 03c1830): [`execute/phase-1.md`](execute/phase-1.md)
- ARCHITECTURE.md (insertion target): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2
- 3단계 패턴 정확 paragraph: `projects/meta/ARCHITECTURE.md` line ~200 (v3.21 phase-1 commit 03c1830 후)
