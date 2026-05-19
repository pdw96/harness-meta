---
phase: 1
status: in_progress
---

# v6.3 EXECUTE phase-1 — 신규 smoke 구현 + cascade tests/CLAUDE.md + 자체 self-check

## Spec

```json
{
  "phase": 1,
  "name": "신규 tests/smoke-entry-title-guideline.sh 구현 + tmpfile fixture controlled 비교 4-step + tests/CLAUDE.md cascade (smoke 매트릭스 row + L7 'active 7→8' + 현행 hook 표 8 row)",
  "status": "in_progress",
  "changes": [
    {"file": "tests/smoke-entry-title-guideline.sh", "action": "created", "loc": "~140 lines", "purpose": "ARCHITECTURE § 7.2 (1) ' + ' P1 mechanical proxy + (2) ≤ 60자 자동 강제. V1 algo (python heredoc + json.load + regex + SIZE_LIMIT 100KB FAIL). entry-form artifact closed-set = projects/*/ROADMAP.md milestones+next_candidates+candidate_draft + CHANGELOG.md bullet bold."},
    {"file": "tests/CLAUDE.md", "action": "updated", "loc": "L7 caption + smoke 매트릭스 row 추가 + 현행 hook 표 8 row + v6.3 phase-2 narrative cascade", "purpose": "cascade host #2 (D8) — 'active 7→8' / row '핵심 정책 검증' 카테고리 / 현행 hook 표 'smoke-entry-title-guideline (v6.3) active' row 추가."}
  ],
  "self_check": {
    "method": "tmpfile fixture controlled 비교 4-step (HARNESS_META_ROOT=tmpdir + 가짜 ROADMAP/CHANGELOG)",
    "step_1": "clean fixture (0 violation) → smoke PASS ✓",
    "step_2": "violation 주입 ('A + B' + 82자 long-title + 'R1+R2' false-positive guard) → smoke FAIL detect 2건 (1+2 위반) ✓ — R1+R2 false-positive 회피 검증",
    "step_3": "정정 후 → smoke PASS ✓",
    "step_4": "CHANGELOG bullet bold form 'another + violating + bullet ...' → smoke FAIL detect 1+2 위반 ✓"
  },
  "acceptance_gates": [
    {"id": "a", "gate": "smoke 구현 완료", "status": "PASS"},
    {"id": "b", "gate": "controlled 비교 4-step PASS (tmpfile fixture)", "status": "PASS"},
    {"id": "c", "gate": "v6.3 자체 entry title PASS (22자, ' + ' 부재)", "status": "PASS — ROADMAP milestones[0].title 자동 검증"},
    {"id": "d", "gate": "기존 11 hook 모두 PASS (신규 smoke .pre-commit-config.yaml 미등재 임시, phase-2 안 등재)", "status": "PENDING — pre-commit run --all-files 검증 의무"},
    {"id": "e", "gate": "tests/CLAUDE.md cascade 후 smoke-claude-md-drift PASS", "status": "PASS — smoke count 정합 13/13"}
  ]
}
```

## Phase-1 narrative

### D6 정정 narrative (사이드 effect)

원안 D6 phase-1 acceptance (d) = "pre-commit 12 hook 모두 PASS" — 신규 smoke .pre-commit-config.yaml 등재 후 즉시 ~43 violation FAIL → pre-commit 차단 → commit 불가. 따라서 D6 자연 정정 — phase-1 안 = smoke 작성 + cascade tests/CLAUDE.md + 자체 self-check (.pre-commit-config.yaml 등재 보류) / phase-2 안 = corrective ~43건 + .pre-commit-config.yaml 등재 + ARCHITECTURE § 7.2 paragraph + CHANGELOG [v6.3] + ROADMAP retitle.

v6.2 phase 패턴 (phase-1 schema 정전 + cascade / phase-2 retrofit + 도그푸드) 정합. D11 hook 등재 phase 매핑은 phase-2 안.

### controlled 비교 4-step 결과 (self-check)

| Step | 의도 | 결과 | False-positive guard |
|:-:|---|:-:|---|
| 1 | clean fixture (0 위반) | PASS ✓ | — |
| 2 | violation 주입 (' + ' + > 60자 + R1+R2 양옆 비공백) | FAIL 2건 detect ✓ | R1+R2 검출 안 함 (`(?<=\S) \+ (?=\S)` lookbehind/lookahead 작동) |
| 3 | 정정 후 | PASS ✓ | — |
| 4 | CHANGELOG bullet bold 양식 | FAIL 1+2 위반 detect ✓ | length-bounded `{1,500}` 정상 작동 |

tmpfile fixture = 실 ROADMAP/CHANGELOG unchanged (regression p1_5 정합). HARNESS_META_ROOT 환경변수 override 활용.

### 실측 위반 41건 (phase-2 corrective 대상)

| Source | 위반 entries | 위반 원칙 분포 |
|---|---:|---|
| meta ROADMAP | 4건 | milestones[3] v6.0 ('+'만) + milestones[6] v1.5 deferred ('+') + next_candidates[0/2] (둘 모두 '+' 또는 > 60자) |
| upbit ROADMAP | 16건 | 대부분 milestones[] (v1.4~v1.20 사이 long-title + ' + ') |
| CHANGELOG bullet | 21건 | 다수 ' + ' 위반 + 일부 > 60자 |
| **합계** | **41** | (v6.2 자체 D8 narrative 안 detail 보강 시 cross-cohort 변동) |

phase-2 안 41건 모두 title retitle (id 보존, milestone 산출물 동결 D9 정합).

## Commit 메시지 draft

```
feat(meta): v6.3 phase-1 — smoke-entry-title-guideline.sh 도입 + tests/CLAUDE.md cascade

v6.3 entry-title-guideline-smoke-verification 첫 phase — ARCHITECTURE § 7.2
entry title 가이드 4 원칙 중 (1) ' + ' P1 mechanical proxy + (2) ≤ 60자
자동 강제 smoke 도입. (3) Active form + (4) Detail summary 분리 = AI 판단
위임 (자동 검증 제외, oos_1+oos_2).

새 파일:
- tests/smoke-entry-title-guideline.sh (V1 algo, python heredoc + regex)

갱신 파일:
- tests/CLAUDE.md (L7 'active 7→8' caption + 매트릭스 row + 현행 hook 표 row)
- projects/meta/milestones/v6.3/MILESTONE.md (OPEN/INTENT/RESEARCH/DESIGN/APPROVE)
- projects/meta/milestones/v6.3/execute/phase-1.md (phase 별책)
- projects/meta/ROADMAP.md (v6.3 in_progress + next_candidates 제거)

self-check (tmpfile fixture controlled 비교 4-step):
- Step 1 clean fixture → PASS ✓
- Step 2 violation 주입 (' + ' + > 60자) → FAIL 2 detect (R1+R2 false-positive 차단)
- Step 3 정정 후 → PASS ✓
- Step 4 CHANGELOG bullet bold → FAIL detect ✓

pre-PLAN 3 round + 5 관점 subagent 병렬 검토 (pass-with-comments × 5 / decisive 0 /
P1 21건 DESIGN edit 흡수 / P2 14건 PROPOSE deferred 예정).

phase-2 예약 = .pre-commit-config.yaml hook 등재 + corrective 41건 일괄 정정 +
ARCHITECTURE § 7.2 paragraph + CHANGELOG [v6.3] entry + ROADMAP retitle.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
```

## Cross-ref

- 상위: [`../MILESTONE.md`](../MILESTONE.md) (INTENT + RESEARCH + DESIGN + APPROVE)
- 다음: [`phase-2.md`](phase-2.md) (corrective + cascade 후속)
