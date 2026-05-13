# execute/phase-2 — smoke-scope-contract.sh batched python3

```json
{
  "phase": 2,
  "status": "complete",
  "title": "smoke-scope-contract.sh batched python3 통합 (Stage 1+2) + Stage 3 bash 유지 + bash detect_era() 제거",
  "scope": "check_out_of_scope + check_approval per-call PYEOF heredoc → 단일 batched python3 (Stage 1+2). Stage 3 (harness-meta.md grep) bash 유지 (D3). bash detect_era() 함수 제거 (D5 옵션 e — Stage 1+2 가 Python 으로 이동하므로 호출자 0). phase-1 batched python 패턴 재사용.",
  "affected_files": [
    "tests/smoke-scope-contract.sh",
    "projects/meta/milestones/v2.1_smoke-spawn-batching/execute/phase-2.md"
  ],
  "baseline": {
    "captured_at": "2026-05-10",
    "smoke_scope_contract": "PASS=15 FAIL=0 SKIP=23",
    "smoke_scope_contract_time_seconds": 12.4
  },
  "execution_notes": "phase-2 완료. phase-1 batched python 패턴 재사용 — 함수 분리 / heredoc quoting / flush=True / try/except per-milestone / pathlib / .as_posix() / sys.stdout.reconfigure. detect_era 4 분기 동치 보존 (9-stage / 7-stage PLAN / 7-stage INTENT-only hotfix 43472b7 / skip). Stage 1+2 batched python (Stage 3 bash 유지, D3) + COUNT_FILE 통한 카운트 합산. bash detect_era() 함수 제거 — Python 일원화 (D5 옵션 e). 추가 정정: era='7-stage' 시 fp=PLAN.md 만 (INTENT.md fallback 제거) — bash 원본 동작 보존 (historical migrate Stage 1 SKIP 의도된 동작인지 후속 milestone 검토 의무). 검증: 시간 12.4s → 0.65s (94.76% 감소, INTENT criteria #2 5s 이하 초과 달성). 동치: HEAD 시점 (구 smoke) 와 라인 단위 완전 동치 (CRLF 정규화 후 zero diff, 동일 milestone 상태 controlled 비교). 다른 4 smoke 회귀 0 (projects-scope-discipline / cross-ref / claude-md-drift / spec-verification 모두 PASS). 전체 pre-commit run --all-files: 1m33s → 15.4s (83.49% 감소, criteria #3 30s 이하 초과 달성). 5 active hook 모두 PASS + shellcheck Passed + markdownlint Passed."
}
```

## 검증 (post 의무)

```bash
# 1. 출력 동치 — PASS=15 FAIL=0 SKIP=23
bash tests/smoke-scope-contract.sh > /tmp/scope_post2.txt 2>&1
grep "=== 결과:" /tmp/scope_post2.txt

# 2. 시간 측정 — 5s 이하
{ time bash tests/smoke-scope-contract.sh > /dev/null; } 2>&1 | grep real

# 3. era 분기 동치 (4 분기) — 출력 라인 grep
# 9-stage milestone: v2.0_workflow-word-fidelity (INTENT+APPROVE+PROPOSE 모두)
# 7-stage PLAN milestone: v2.0_workflow-word-fidelity 자기참조 표지 (PLAN.md 만)
# 7-stage INTENT-only milestone: v1.4_infra-minimization 등 (PLAN→INTENT migrate)
# skip era: v1.84~v1.88

# 4. 다른 4 smoke 회귀 0
bash tests/smoke-projects-scope-discipline.sh
bash tests/smoke-cross-ref.sh
bash tests/smoke-claude-md-drift.sh
bash tests/smoke-spec-verification.sh   # phase-1 자체 회귀

# 5. 전체 pre-commit 시간 (criteria #3: 30s 이하)
time pre-commit run --all-files
```

## commit

`feat(meta): v2.1 phase-2 — smoke-scope-contract python3 spawn batching (12s→~2s)`
