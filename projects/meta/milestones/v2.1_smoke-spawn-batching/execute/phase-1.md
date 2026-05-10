# execute/phase-1 — smoke-spec-verification.sh batched python3

```json
{
  "phase": 1,
  "status": "complete",
  "title": "smoke-spec-verification.sh batched python3 통합",
  "scope": "check_json_fields + check_execute_phase 의 per-call PYEOF heredoc → 단일 batched python3 heredoc + main() 함수 + def detect_era + def check_stage. milestone × stage 8 회 spawn → 1 회 spawn.",
  "affected_files": [
    "tests/smoke-spec-verification.sh",
    "projects/meta/milestones/v2.1_smoke-spawn-batching/execute/phase-1.md"
  ],
  "baseline": {
    "captured_at": "2026-05-10",
    "smoke_spec_verification": "PASS=99 FAIL=0 SKIP=80",
    "smoke_scope_contract": "PASS=15 FAIL=0 SKIP=23",
    "smoke_spec_verification_time_seconds": 66.4,
    "smoke_scope_contract_time_seconds": 12.4,
    "precommit_full_time_seconds": 93.3
  },
  "execution_notes": "phase-1 완료. Python heredoc 안 함수 분리 (D12: detect_era / extract_json / check_json_fields / check_execute_phase / check_stage / main) + heredoc quoting `<<'PYEOF'` (D13) + flush=True (D14) + def detect_era (D5/D15) + try/except per-milestone (D6/R2) + pathlib (D7/R3) + .as_posix() Windows 호환. 추가 발견: Windows cp949 콘솔에서 em dash (U+2014) UnicodeEncodeError → sys.stdout.reconfigure(encoding='utf-8') 추가 (smoke-python-entry-boilerplate § P2 패턴 v1.87 차용). 검증: 시간 66.4s → 0.63s (99.05% 감소, INTENT criteria #1 10s 이하 초과 달성). 동치: PASS 99→100 (+1=phase-1.md 자체 추가) / SKIP 80 (불변) / FAIL 0 (불변). 다른 4 smoke 회귀 0 (projects-scope-discipline / cross-ref / claude-md-drift / scope-contract 모두 PASS). shellcheck Passed (pre-commit hook 직접 검증)."
}
```

## 의도

phase-1 의 목표는 smoke-spec-verification.sh 의 per-call python3 spawn 패턴 (current ~150 회) 을 단일 batched python3 호출로 정정하는 것. DESIGN.D1~D17 에 따라 다음 의무 준수:

1. **함수 분리** (D12) — Python 안 def detect_era / def extract_json / def check_json_fields / def check_execute_phase / def check_stage / def main
2. **heredoc quoting** (D13) — `<<'PYEOF'` (single-quoted) 강제 → bash variable expansion 차단
3. **flush=True** (D14) — print 마다 flush 명시
4. **detect_era 일원화** (D5/D15) — Python 내부 def 만 source, bash detect_era 함수는 phase-2 에서 제거 (spec-verification 도 detect_era 갖는 통일 패턴)
5. **try/except per-milestone** (D6/R2) — 부분 실패 격리
6. **pathlib + glob** (D7/R3) — sys.argv 노출 0
7. **.as_posix()** — Windows backslash → forward slash (baseline 동치)

## 검증 (post 의무)

phase-1 commit 전 직접 실행:

```bash
# 1. 출력 동치 — PASS=99 FAIL=0 SKIP=80
bash tests/smoke-spec-verification.sh > /tmp/spec_post1.txt 2>&1
grep "=== 결과:" /tmp/spec_post1.txt
# Expected: === 결과: PASS=99 FAIL=0 SKIP=80 ===

# 2. 시간 측정 — 10s 이하
{ time bash tests/smoke-spec-verification.sh > /dev/null; } 2>&1 | grep real

# 3. baseline 라인 단위 diff (옵션) — 형식 동치 검증
diff /tmp/spec_baseline.txt /tmp/spec_post1.txt

# 4. shellcheck 통과
shellcheck tests/smoke-spec-verification.sh

# 5. 다른 4 smoke 회귀 0
bash tests/smoke-projects-scope-discipline.sh && bash tests/smoke-cross-ref.sh && bash tests/smoke-claude-md-drift.sh && bash tests/smoke-scope-contract.sh
```

## commit

`feat(meta): v2.1 phase-1 — smoke-spec-verification python3 spawn batching`
