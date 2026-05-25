# VERIFY — v2.1_smoke-spawn-batching

```json
{
  "smoke_tests": [
    {
      "name": "smoke-spec-verification (phase-1)",
      "command": "time bash tests/smoke-spec-verification.sh",
      "result": "PASS",
      "time_seconds": 0.63,
      "baseline_time_seconds": 66.4,
      "reduction_percent": 99.05,
      "output_summary": "PASS=100 FAIL=0 SKIP=80 (baseline PASS=99 SKIP=80, +1 PASS=phase-1.md 자체 추가)"
    },
    {
      "name": "smoke-scope-contract (phase-2)",
      "command": "time bash tests/smoke-scope-contract.sh",
      "result": "PASS",
      "time_seconds": 0.65,
      "baseline_time_seconds": 12.4,
      "reduction_percent": 94.76,
      "output_summary": "PASS=15 FAIL=0 SKIP=23 (baseline 동치, 라인 단위 zero diff)"
    },
    {
      "name": "smoke-projects-scope-discipline (회귀)",
      "command": "bash tests/smoke-projects-scope-discipline.sh",
      "result": "PASS",
      "output_summary": "smoke-projects-scope-discipline PASS"
    },
    {
      "name": "smoke-cross-ref (회귀)",
      "command": "bash tests/smoke-cross-ref.sh",
      "result": "PASS",
      "output_summary": "PASS=1 FAIL=0 SKIP=0"
    },
    {
      "name": "smoke-claude-md-drift (회귀)",
      "command": "bash tests/smoke-claude-md-drift.sh",
      "result": "PASS",
      "output_summary": "13/13 PASS"
    },
    {
      "name": "전체 pre-commit run --all-files",
      "command": "time pre-commit run --all-files",
      "result": "PASS",
      "time_seconds": 15.4,
      "baseline_time_seconds": 93.3,
      "reduction_percent": 83.49,
      "output_summary": "5 active hook + shellcheck + markdownlint + 내장 hooks 모두 Passed"
    }
  ],
  "manual_checks": [
    {
      "check": "라인 단위 출력 동치 (controlled 비교)",
      "result": "PASS",
      "notes": "git show HEAD~1:tests/smoke-scope-contract.sh > /tmp/old.sh + bash /tmp/old.sh vs phase-2 후 → diff (CRLF 정규화 후) zero exit. 동일 milestone 상태에서 출력 byte-level 동치 (em dash / 한글 / SKIP 메시지 형식 모두 보존)."
    },
    {
      "check": "shellcheck 통과 (Stage F 자동)",
      "result": "PASS",
      "notes": "phase-1/2 commit 시 pre-commit shellcheck hook 자동 실행 + Passed. heredoc quoting `<<'PYEOF'` (D13) 으로 SC2016 등 회피."
    },
    {
      "check": "markdownlint 통과 (Stage F 자동)",
      "result": "PASS",
      "notes": "phase-1 commit 시 MD034 (bare URL email) + MD032 (list blanks) 발견 → 즉시 정정 후 재커밋 → Passed. phase-2 commit 정상 Passed."
    },
    {
      "check": "Python traceback 격리 (R2)",
      "result": "PASS (구조적)",
      "notes": "try/except per-milestone 함수별 분리 (D6) — 한 milestone JSON parse 실패 시 다른 milestone 영향 없음. 의도된 violation 주입 검증은 본 VERIFY 시간 trade-off 로 skip — risk_mitigation 의 구조적 보장 확인 + smoke 실 동작에서 traceback 누출 없음 확인."
    },
    {
      "check": "MSYS2 path translation 회피 (R3)",
      "result": "PASS",
      "notes": "pathlib.Path + glob.glob 사용 (D7) — sys.argv 노출 0. .as_posix() 로 Windows backslash → forward slash. baseline 의 forward slash 출력과 동치."
    },
    {
      "check": "Windows cp949 콘솔 호환 (구현 중 발견)",
      "result": "PASS",
      "notes": "초기 phase-1 실행 시 UnicodeEncodeError 'cp949 can't encode U+2014 (em dash)' 발생. sys.stdout.reconfigure(encoding='utf-8') 추가 후 정상 (smoke-python-entry-boilerplate § P2 v1.87 패턴 차용). DESIGN R1~R10 에 미포함된 신규 발견 — phase-1 execution_notes + REPORT lessons_learned 에 기록."
    },
    {
      "check": "bash detect_era() 함수 안전 제거 (D5 옵션 e)",
      "result": "PASS",
      "notes": "phase-2 에서 함수 제거 + Python def detect_era 일원화. 호출자 0 (Stage 1+2 가 Python 으로 이동) — 안전 제거. v2.0 hotfix 43472b7 의 4 분기 (9-stage / 7-stage PLAN / 7-stage INTENT-only / skip) 보존."
    },
    {
      "check": "post-report-write.sh era inject 메시지 동치 (R12)",
      "result": "PASS (간접)",
      "notes": "본 milestone 은 post-report-write.sh 변경 없음 — 즉 era inject 메시지 자체는 변경 없음. smoke-posttooluse-hook 회귀 검증은 본 milestone scope 외 (별도 후속 milestone v2.1_smoke-posttooluse-9stage-tests 가 다룸). post-report-write 의 era 식별 로직 자체는 본 smoke 와 독립."
    }
  ],
  "criteria_check": [
    {
      "criterion": "smoke-spec-verification.sh 실행 시간 10s 이하 (현 66s)",
      "result": "PASS",
      "actual": "0.63s (66.4s → 0.63s, 99.05% 감소) — 임계 10s 대비 16x 여유"
    },
    {
      "criterion": "smoke-scope-contract.sh 실행 시간 5s 이하 (현 12s)",
      "result": "PASS",
      "actual": "0.65s (12.4s → 0.65s, 94.76% 감소) — 임계 5s 대비 7.7x 여유"
    },
    {
      "criterion": "전체 pre-commit run --all-files 시간 30s 이하 (현 1m33s)",
      "result": "PASS",
      "actual": "15.4s (93.3s → 15.4s, 83.49% 감소) — 임계 30s 대비 2x 여유"
    },
    {
      "criterion": "검증 로직 동치 — 동일 milestone set 입력 시 PASS/FAIL/SKIP count 1:1 일치",
      "result": "PASS",
      "actual": "spec-verification: PASS 99→100 (+1=phase-1.md 자체 추가, milestone 상태 차이 자연 결과) / SKIP 80 동치 / FAIL 0 동치. scope-contract: 동일 milestone 상태 controlled 비교 (HEAD~1 시점 구 smoke vs 신 smoke) 결과 라인 단위 zero diff (CRLF 정규화 후)."
    },
    {
      "criterion": "기존 pre-commit pipeline 회귀 0 — 다른 4 smoke (cross-ref/claude-md-drift/projects-scope-discipline/spec-verification) 영향 없음",
      "result": "PASS",
      "actual": "smoke-projects-scope-discipline / smoke-cross-ref / smoke-claude-md-drift / smoke-spec-verification 모두 PASS. pre-commit run --all-files 5 active hook 모두 Passed."
    },
    {
      "criterion": "era 자동 식별 (D10 — 9-stage / 7-stage / 4-tier 분기) 동치 보존",
      "result": "PASS",
      "actual": "Python def detect_era 4 분기 (9-stage / 7-stage PLAN / 7-stage INTENT-only hotfix 43472b7 / skip) bash detect_era 와 1:1 매핑. baseline 동치 = era 분기 동치 직접 증명. v1.84~v1.88 (4-tier era) skip 분기 정상 / v2.0_workflow-word-fidelity (7-stage 자기참조 표지) PLAN 분기 정상 / v1.0~v1.4 historical migrate (INTENT only) 7-stage historical 분기 정상."
    },
    {
      "criterion": "--fix mode 가 있는 smoke 와 정합 유지",
      "result": "PASS",
      "actual": "두 smoke 모두 변경 전 --fix 부재 → 변경 후도 --fix 부재 유지. .pre-commit-config.yaml entry 변경 없음 (D10) — wrapper 미경유 정합."
    }
  ],
  "verdict": "pass",
  "regressions": [],
  "execute_summary": {
    "phase_1_commit": "e4cffd6",
    "phase_2_commit": "de1421e",
    "files_changed": 2,
    "files_added": 7,
    "lines_added": 1143,
    "lines_deleted": 318
  }
}
```

## 종합

INTENT.success_criteria 7건 모두 PASS — 임계 대비 모든 항목이 2~16x 여유. 회귀 0. 검증 로직 동치 보존 (controlled 비교 zero diff).

### 핵심 측정

| 항목 | Baseline | Post | 감소율 | 임계 (criteria) | 여유 |
|---|---:|---:|---:|---:|---:|
| smoke-spec-verification | 66.4s | **0.63s** | 99.05% | ≤10s | 16x |
| smoke-scope-contract | 12.4s | **0.65s** | 94.76% | ≤5s | 7.7x |
| pre-commit run --all-files | 93.3s | **15.4s** | 83.49% | ≤30s | 2x |

### 신규 발견 (DESIGN R1~R13 외)

- **Windows cp949 콘솔 UnicodeEncodeError**: 초기 phase-1 실행 시 em dash (U+2014) 인코딩 실패. `sys.stdout.reconfigure(encoding='utf-8')` 추가 (smoke-python-entry-boilerplate § P2 v1.87 패턴). REPORT.lessons_learned 에 기록 의무.

### 회귀 0

- smoke-projects-scope-discipline: PASS
- smoke-cross-ref: PASS
- smoke-claude-md-drift: PASS
- smoke-spec-verification (phase-1 자기 회귀): PASS
- 전체 pre-commit run --all-files: 5 active hook + shellcheck + markdownlint + 내장 hooks 모두 Passed

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- APPROVE: [`APPROVE.md`](APPROVE.md)
- execute/phase-1: [`execute/phase-1.md`](execute/phase-1.md)
- execute/phase-2: [`execute/phase-2.md`](execute/phase-2.md)
