# phase-7 — v2.2_smoke-controlled-comparison-pattern 흡수

```json
{
  "phase": 7,
  "status": "completed",
  "title": "tests/CLAUDE.md § '회귀 검증 절차' controlled 비교 패턴 명문화",
  "scope": [
    "tests/CLAUDE.md § '회귀 검증 절차' '기존 smoke 수정 시' 항목에 controlled 비교 4-step 패턴 추가",
    "milestones/v3.0/milestones.md sub-milestone-7 entry status: pending → completed"
  ],
  "rationale": "v2.1 lessons L3 — phase 검증 시 단순 baseline vs post 비교는 milestone 상태 변화로 PASS/SKIP 분포 차이 발생. controlled 비교 (git show HEAD:smoke.sh + diff CRLF 정규화) 가 동치 검증 강력 도구. narrative 명문화로 향후 smoke 수정 시 표준 절차 적용.",
  "decisions_referenced": ["D14 (commit ref + dependencies.absorbed_from)"],
  "absorbed_from": "v2.2_smoke-controlled-comparison-pattern",
  "verification": {
    "smoke_cross_ref": "PASS (tests/CLAUDE.md narrative 갱신, cross-ref 정합)",
    "smoke_claude_md_drift": "PASS (smoke 카운트 27 보존)",
    "no_code_change": "narrative 만 — 코드 변경 부재, 회귀 risk 0"
  }
}
```

## 작업 내용

1. **tests/CLAUDE.md § '회귀 검증 절차' '기존 smoke 수정 시'** 4-step controlled 비교 패턴 추가:
   - Step 1: baseline (`git show HEAD:tests/smoke-<name>.sh > /tmp/old.sh + bash /tmp/old.sh > /tmp/old.out`)
   - Step 2: post (`bash tests/smoke-<name>.sh > /tmp/new.out`)
   - Step 3: CRLF 정규화 diff (`diff <(tr -d '\r' < /tmp/old.out) <(tr -d '\r' < /tmp/new.out)`)
   - Step 4: 의도된 변경 (REPORT.lessons_learned narrative) vs 회귀 (phase commit revert, R5)

2. **milestones/v3.0/milestones.md** sub-milestone-7 entry status pending → completed

## execution_notes

- narrative 만 — 코드 / smoke 자체 변경 부재. 회귀 risk 0
- 본 패턴은 향후 smoke 수정 시 표준 절차 — milestone 상태 변화 영향 격리
- v3.0 자체에서도 phase-1, phase-2 commit 후 적용 가능했으나, 본 milestone 흡수 (phase-7) 로 명문화 — 향후 v3.x+ smoke 수정 시 재사용

## commit

```
feat(meta): v3.0 phase-7 — v2.2_smoke-controlled-comparison-pattern 흡수 (controlled 비교 4-step 패턴)
```
