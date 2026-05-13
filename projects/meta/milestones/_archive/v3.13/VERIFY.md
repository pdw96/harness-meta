# VERIFY — v3.13 pending-milestone-renumber-policy

본 milestone 의 검증 (smoke / manual / criteria_check / verdict). 9-stage workflow Stage G.

```json
{
  "id": "v3.13_pending-milestone-renumber-policy",
  "smoke_tests": [
    {
      "name": "pre-commit run --all-files",
      "command": "pre-commit run --all-files",
      "result": "PASS (14 hook 모두 PASS, Skipped 부재)",
      "output": "fix end of files / trim trailing whitespace / check for merge conflicts / check yaml / check for added large files / shellcheck / markdownlint / smoke-projects-scope-discipline / smoke-spec-verification (7-stage JSON schema 정합) / smoke-scope-contract (out_of_scope + DESIGN.approval gate) / smoke-cross-ref / smoke-claude-md-drift / smoke-bundle-trigger / smoke-open-stage-discipline — 14 Passed."
    },
    {
      "name": "smoke-bundle-trigger 직접 실행",
      "command": "bash tests/smoke-bundle-trigger.sh",
      "result": "PASS",
      "output": "smoke-bundle-trigger PASS — v3.13 entry (status: in_progress, milestones_path: 'milestones/v3.13/milestones.md', 실 파일 존재) 검증 통과 + 같은 version 1건 강제 부합 + v1.x_{slug} historical entry skip 정상."
    },
    {
      "name": "smoke-open-stage-discipline 직접 실행",
      "command": "bash tests/smoke-open-stage-discipline.sh",
      "result": "PASS",
      "output": "smoke-open-stage-discipline PASS (9-stage-bundled checked=15, historical skipped=18) — v3.13/milestones.md 페어링 정합 + 디렉토리 명 '^v\\d+\\.\\d+$' 표지 부합."
    },
    {
      "name": "smoke-projects-scope-discipline 직접 실행",
      "command": "bash tests/smoke-projects-scope-discipline.sh",
      "result": "PASS",
      "output": "smoke-projects-scope-discipline PASS — root ROADMAP thin index + projects/meta/ROADMAP.md milestones[] 보유 + projects/upbit/ROADMAP.md 동일 정합."
    }
  ],
  "manual_checks": [
    {
      "check": "ROADMAP entry 3건 status 'pending' → 'deferred' 갱신 확인",
      "result": "PASS",
      "notes": "v1.4_hook-narrative-separation (L181) / v1.4_design-review-trace (L188) / v1.5_research-cascade-grep-discipline (L202) 모두 status 'deferred' 확인."
    },
    {
      "check": "ROADMAP entry 3건 deferred_reason 신 필드 추가 확인",
      "result": "PASS",
      "notes": "각 entry 에 deferred_reason 필드 추가 (§ 6.2 cross-ref + workflow 영향 본질 + 재발의 trigger 조건 + v3.13 거명) 확인."
    },
    {
      "check": "ROADMAP `deferred_note` 갱신 (v3.6 + v3.13 narrative 누적) 확인",
      "result": "PASS",
      "notes": "L7 deferred_note 안 (1) 기존 v3.6 narrative 보존 + (2) v3.13 결정 narrative 추가 + (3) entry 거명 (v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_research-cascade-grep-discipline) 명시 확인."
    },
    {
      "check": "v3.13 entry status 유지 (in_progress) 확인 — PROPOSE 책임 분리 (D5)",
      "result": "PASS",
      "notes": "v3.13 entry status 'in_progress' 유지. Stage I PROPOSE 단계에서 'completed' 갱신 예정."
    },
    {
      "check": "milestones.md sub_milestones[0].title placeholder 교체 + phase-1 status/commit 갱신",
      "result": "PASS",
      "notes": "Stage D 완료 직전 의무 step (v3.5) 부합 — sub_milestones[0].title = 'ROADMAP entry 3건 deferred 처리 + deferred_note 갱신' + status: complete + commit: a86334c 갱신 확인."
    },
    {
      "check": "INTENT~APPROVE 4 산출물 + milestones.md + execute/phase-1.md 최종 = Stage G commit 안 포함 패턴 (b) 부합",
      "result": "PASS",
      "notes": "phase-1 commit (a86334c) 에는 ROADMAP.md + execute/phase-1.md 만 포함. INTENT.md / RESEARCH.md / DESIGN.md / APPROVE.md + milestones.md = Stage G/H/I commit 안 통합 예정 (패턴 b 채택, 산출물 영구 보존 보장)."
    },
    {
      "check": "Lightweight 모드 표지 + 5 관점 자기 검토 narrative cascade 확인",
      "result": "PASS",
      "notes": "milestones.md self_reference_policy: 'avoid' + self_reference_rationale + INTENT.md § Lightweight 모드 표지 + DESIGN.md § 5 관점 자기 검토 + APPROVE.md § 5 관점 검토 결과 표 — 4 위치 cascade 정합."
    }
  ],
  "criteria_check": [
    {
      "criterion": "SC1: ROADMAP v1.4_hook-narrative-separation status 'pending' → 'deferred'",
      "result": "PASS",
      "evidence": "L181 status: 'deferred' 확인 (phase-1 commit a86334c)"
    },
    {
      "criterion": "SC2: ROADMAP v1.4_design-review-trace status 'pending' → 'deferred'",
      "result": "PASS",
      "evidence": "L188 status: 'deferred' 확인"
    },
    {
      "criterion": "SC3: ROADMAP v1.5_research-cascade-grep-discipline status 'pending' → 'deferred'",
      "result": "PASS",
      "evidence": "L202 status: 'deferred' 확인"
    },
    {
      "criterion": "SC4: 위 3건 entry deferred_reason 필드 + § 6.2 cross-ref + 재발의 trigger 조건 명시",
      "result": "PASS",
      "evidence": "3 entry 모두 deferred_reason 필드 추가 — '§ 6.2 ... 재발의 trigger 조건 (외부 projects/<name>, name ≠ meta 실 적용 milestone 1건 완료 후 정량 데이터에 근거한 명시 발의) 충족 시 재발의. v3.13_pending-milestone-renumber-policy 결정 (2026-05-12).' 패턴 일관."
    },
    {
      "criterion": "SC5: ROADMAP `deferred_note` 갱신 (v3.6 narrative + v3.13 결정 누적)",
      "result": "PASS",
      "evidence": "L7 deferred_note 안 'v3.6 narrative' (보존) + '추가로 v1.4_hook-narrative-separation + v1.4_design-review-trace + v1.5_research-cascade-grep-discipline (v1.x era pending, v2.0_workflow-word-fidelity lessons next_candidates#1 origin) 도 v3.13_pending-milestone-renumber-policy (2026-05-12) 결정으로 defer' 추가 확인."
    },
    {
      "criterion": "SC6: milestones.md sub_milestones[] DESIGN phases[] 1:1 동기 갱신",
      "result": "PASS",
      "evidence": "Stage D 직후 placeholder 교체 + Stage G 시점 status/commit 동기 — sub_milestones[0]: {phase: 1, title: 'ROADMAP entry 3건 deferred 처리 + deferred_note 갱신', status: 'complete', commit: 'a86334c'}."
    },
    {
      "criterion": "SC7: pre-commit 14 hook 모두 PASS (회귀 0, --no-verify 우회 부재)",
      "result": "PASS",
      "evidence": "pre-commit run --all-files 결과 14 hook 모두 PASS (Skipped 부재). --no-verify 사용 부재. phase-1 commit a86334c 통과."
    }
  ],
  "verdict": "pass",
  "regressions": [],
  "summary": "INTENT.success_criteria 7건 모두 PASS. pre-commit 14 hook + smoke 직접 3건 모두 PASS, 회귀 0. § 6.2 동결 정책 적용 narrative + ROADMAP entry status 갱신 + deferred_reason 신 필드 + deferred_note 누적 narrative 모두 정합. Lightweight 모드 4 위치 cascade 부합 (milestones.md / INTENT / DESIGN / APPROVE). v3.13 entry status 갱신은 Stage I PROPOSE 책임."
}
```

## smoke 직접 실행 결과 요약

```
$ pre-commit run --all-files
... (14 hook 모두 Passed, Skipped 부재)

$ bash tests/smoke-bundle-trigger.sh
smoke-bundle-trigger PASS

$ bash tests/smoke-open-stage-discipline.sh
smoke-open-stage-discipline PASS (9-stage-bundled checked=15, historical skipped=18)

$ bash tests/smoke-projects-scope-discipline.sh
smoke-projects-scope-discipline PASS
```

## 관련

- INTENT.success_criteria 7건: [`INTENT.md`](INTENT.md)
- DESIGN.phases[0]: [`DESIGN.md`](DESIGN.md)
- APPROVE: [`APPROVE.md`](APPROVE.md)
- phase-1 실 commit (a86334c): [`execute/phase-1.md`](execute/phase-1.md)
