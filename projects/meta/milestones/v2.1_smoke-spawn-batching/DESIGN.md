# DESIGN — v2.1_smoke-spawn-batching

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "Approach A 채택 — 단일 batched python3 호출 (사용자 결정 2026-05-10)",
      "rationale": "spawn 1회로 단일화, bash 측 변경 최소, 책임/출력/exit 동치. 절감 효과 가장 큼 (66s → ~5s 예상).",
      "alternatives_rejected": ["Approach A2 (stage 별 batching, 절감 작음)", "Approach B (.sh→.py 재작성, 변경 범위 과대)", "Approach C (jq 외부 의존)"]
    },
    {
      "id": "D2",
      "decision": "두 smoke 를 별도 phase 로 분리 (각 1 commit)",
      "rationale": "phase-1 (spec-verification) 패턴 정전 후 phase-2 (scope-contract) 재사용. 회귀 발견 시 git revert 격리 가능 + 1 phase = 1 commit 컨벤션 준수.",
      "alternatives_rejected": ["단일 phase 통합 (혹시 회귀 시 rollback 단위 비대)"]
    },
    {
      "id": "D3",
      "decision": "smoke-scope-contract Stage 3 (harness-meta.md grep) 은 bash 유지",
      "rationale": "Stage 3 는 단일 grep 2회 < 0.1s, batching 효과 미미. Python 혼재 시 가독성 비용 > 시간 효과. Stage 1/2 만 batched python.",
      "alternatives_rejected": ["Stage 3 도 Python 통합 (가독성 손해)"]
    },
    {
      "id": "D4",
      "decision": "stdout 형식 — Python 안에서 ✓/✗/- prefix 직접 print",
      "rationale": "bash 측 파싱 단순화 (✓ → PASS, ✗ → FAIL, - → SKIP grep 카운트). tests/CLAUDE.md § '출력 패턴' 표준 그대로 + 행 위치만 Python 안으로 이동. 사용자 / 다른 parser 영향 없음.",
      "alternatives_rejected": ["TSV 형식 출력 후 bash 가 변환 (bash 측 변경 늘어남)"]
    },
    {
      "id": "D5",
      "decision": "detect_era 일원화 — bash detect_era() 함수 phase-2 에서 제거 + Python 안 def detect_era 만 source (옵션 e)",
      "rationale": "현 bash detect_era() (smoke-scope-contract.sh L126~138) 와 batched Python 의 detect_era 가 1:1 매핑되면 drift risk (architecture review #5 발견). 옵션 (a) bash 제거 + Python source / (b) tests/_era_detect.py 분리 import / (c) 1:1 매핑 + drift 검증 smoke 신규 중 (a) 채택 — Stage 1+2 가 batched Python 으로 이동하므로 bash detect_era 호출자 0 → 안전 제거. 9-stage(INTENT+APPROVE+PROPOSE 동시) / 7-stage(PLAN.md) / 7-stage historical(INTENT.md only, hotfix 43472b7) / skip(4-tier 또는 부재) 4 분기. 두 smoke 의 def detect_era 동치 보장은 본 milestone 에서 동시 작성 + VERIFY 단계 자동 분기 동치 검증으로 mitigation (D16).",
      "alternatives_rejected": ["옵션 b: tests/_era_detect.py 분리 (새 파일 추가 = scope 확장 + Python module import 안 spawn 비용)", "옵션 c: 1:1 매핑 + drift 검증 smoke 추가 (out_of_scope#7 active smoke 갯수 변경 위반)", "Python 안 era 분기 inline (보존 의무 명료성 손해)"]
    },
    {
      "id": "D6",
      "decision": "try/except per-milestone 격리",
      "rationale": "R2/R6 mitigation — 한 milestone JSON parse 실패가 다른 milestone 검증을 중단하면 안 됨. 각 milestone × stage iteration 마다 try/except + FAIL 라인 출력.",
      "alternatives_rejected": ["전체 try/except (한 실패 = 전체 abort)"]
    },
    {
      "id": "D7",
      "decision": "pathlib.Path + glob.glob 사용 — sys.argv 노출 0",
      "rationale": "R3 mitigation (MSYS2 path translation) — bash 인자로 milestone 경로 전달하지 않고 Python 내부에서 enumerate. tests/CLAUDE.md § '흔한 함정' v1.70 사례 회피.",
      "alternatives_rejected": ["bash 가 milestone enumerate 후 인자 전달 (MSYS2 risk)"]
    },
    {
      "id": "D8",
      "decision": "검증 로직 동치 의무 — 변경 전후 PASS/FAIL/SKIP 카운트 1:1 일치",
      "rationale": "INTENT.success_criteria #4 직접 매핑. VERIFY.md 에 baseline 캡처 + post 비교 기록 의무.",
      "alternatives_rejected": ["검증 로직 부분 단순화 (책임 변경 = scope 위반)"]
    },
    {
      "id": "D9",
      "decision": "tests/CLAUDE.md 매트릭스 narrative 변경 없음",
      "rationale": "본 milestone 은 구현만 변경, 책임/카운트/카테고리 그대로. v1.4_infra-minimization 정신 준수 (narrative 1차 source 안정성).",
      "alternatives_rejected": ["시간 정보 추가 (책임 narrative 와 무관, 구현 detail 의 narrative 침투)"]
    },
    {
      "id": "D10",
      "decision": ".pre-commit-config.yaml 변경 없음",
      "rationale": "entry (`bash tests/smoke-*.sh`) / files 패턴 / 순서 그대로. autofix wrapper 미경유 (두 smoke 모두 --fix 부재) 도 그대로.",
      "alternatives_rejected": ["wrapper 경유로 변경 (--fix 미지원이라 무의미)"]
    },
    {
      "id": "D11",
      "decision": "5 관점 검토 — 3 관점 채택 (architecture / 회귀 risk / scope contract). spec-drift 생략",
      "rationale": "scope = 작음 (≤5 파일, 본건 2 파일). spec-drift 는 외부 spec 의존 거의 없음 (Python stdlib pathlib/re/json + bash 내장). 검증 인프라 변경의 회귀 risk 가 핵심 → spec-drift 자리에 회귀 risk 대체.",
      "alternatives_rejected": ["4 관점 (+spec-drift)", "5 관점 전체 (+ 보안)"]
    },
    {
      "id": "D12",
      "decision": "Python heredoc 내부 함수 분리 의무 — def check_json_fields, def check_execute_phase, def detect_era, def main",
      "rationale": "architecture review #2 — 단일 100~150 라인 heredoc 가독성 우위는 함수 분리 시. flat script 로 두면 logic 파악 비용 ↑. main() 함수 안에서 milestone enumerate + 각 stage iteration + per-result print(✓/✗/-) 일관 호출.",
      "alternatives_rejected": ["flat script (가독성 손해)"]
    },
    {
      "id": "D13",
      "decision": "heredoc quoting `<<'PYEOF'` (single-quoted) 강제",
      "rationale": "architecture review A3 — 100라인 heredoc 안 Python f-string `${...}` 와 bash variable expansion 충돌 가능. single-quoted heredoc 으로 expansion 완전 차단. 기존 helper 함수 (check_json_fields 등) 도 이미 `<<'PYEOF'` 사용 → 패턴 일관.",
      "alternatives_rejected": ["unquoted heredoc + 개별 escape (실수 risk)"]
    },
    {
      "id": "D14",
      "decision": "Python `print(..., flush=True)` 의무 — 각 result 라인 즉시 flush",
      "rationale": "architecture review #4 — 단일 spawn 안에서 결과 라인이 buffer 에 쌓이다 한꺼번에 flush 되면 사용자 / pre-commit framework 가 진행 상황 파악 불가. 각 ✓/✗/- print 시 flush=True 명시.",
      "alternatives_rejected": ["sys.stdout.flush() 끝 1회 (진행 표시 손실)"]
    },
    {
      "id": "D15",
      "decision": "spec-verification 의 era 분기도 Python detect_era 로 명시 통합 — 두 smoke 의 era 식별 패턴 통일",
      "rationale": "architecture review A1 — 현 spec-verification 은 detect_era 함수 부재 (파일 존재 여부로 stage SKIP 분기). batching 후 Python 안에서 두 smoke 모두 def detect_era 동일 정의 사용 → 식별 패턴 통일 + 향후 era 추가 시 갱신 1회로 일원화. 단 두 smoke 안에 동일 함수 본문 (drift risk) 는 D16 VERIFY 동치 검증으로 mitigation.",
      "alternatives_rejected": ["spec-verification 만 inline 분기 유지 (패턴 분산)"]
    },
    {
      "id": "D16",
      "decision": "VERIFY.md 에 baseline 캡처 + edge case 검증 + era 분기 동치 자동 검증 의무",
      "rationale": "회귀 review R8 (PASS/FAIL/SKIP 카운트 동치) + R4 (era 4 분기 보존) + R12 (post-report-write.sh era inject 메시지 동치) 자동 검증 명령어를 VERIFY.md 에 명시. 회귀 review agent 가 제시한 검증 스크립트 (변경 전 baseline 캡처 / phase 별 카운트 비교 / edge case 주입 / 4 분기 milestone 1+ 검증) 직접 차용.",
      "alternatives_rejected": ["VERIFY 시 임시 검증 (재현성 약함)"]
    },
    {
      "id": "D17",
      "decision": "REPORT.md 에 시간 측정 baseline + post 결과 + 시간 단축 비율 별첨 의무",
      "rationale": "architecture review #7 — D9 (tests/CLAUDE.md narrative 변경 없음) 보존하되 시간 측정 라이프사이클 정보는 milestone trace 가치. REPORT.summary + delta 에 baseline (66.4s/12.4s/93.3s) 와 post 결과 + % 감소 기록.",
      "alternatives_rejected": ["tests/CLAUDE.md 매트릭스에 시간 컬럼 추가 (narrative 1차 source 침투, D9 위반)"]
    }
  ],
  "approach": "두 smoke 의 helper function (check_*) 의 per-call PYEOF heredoc 을 main 안의 단일 python3 heredoc 으로 통합. Python 안에서 milestone enumerate (pathlib + glob) + detect_era + per-stage 검증 + line-per-result stdout (✓/✗/- prefix) 를 모두 수행. bash main 은 단일 spawn 으로 Python 호출 + 결과 reading + PASS/FAIL/SKIP 카운트. spec-verification 의 Stage 1~9 모두 batched, scope-contract 의 Stage 1+2 batched / Stage 3 (harness-meta.md grep) bash 유지. 출력 형식 / exit code / 책임 / 카운트 동치 보존 의무.",
  "phases": [
    {
      "n": 1,
      "title": "smoke-spec-verification.sh batched python3 통합",
      "scope": "check_json_fields + check_execute_phase + main 8 stage loop → 단일 python3 heredoc + bash 결과 reader",
      "affected_files": [
        "tests/smoke-spec-verification.sh",
        "projects/meta/milestones/v2.1_smoke-spawn-batching/execute/phase-1.md"
      ],
      "rationale": "spec-verification 이 가장 큰 병목 (66s) — 우선 처리. 본 phase 에서 batched python 패턴 정전 → phase-2 에서 동일 패턴 재사용.",
      "risks": ["R2 traceback 누출", "R4 era 분기 누락", "R5 phase-N regex 차이", "R6 single SyntaxError", "R8 카운트 동치", "R10 자기 검증 게이트"]
    },
    {
      "n": 2,
      "title": "smoke-scope-contract.sh batched python3 통합 (Stage 1+2) + Stage 3 bash 유지",
      "scope": "check_out_of_scope + check_approval + detect_era → 단일 python3 heredoc (Stage 1+2). Stage 3 bash grep 유지. phase-1 패턴 재사용.",
      "affected_files": [
        "tests/smoke-scope-contract.sh",
        "projects/meta/milestones/v2.1_smoke-spawn-batching/execute/phase-2.md"
      ],
      "rationale": "phase-1 의 batched python 패턴 정전 후 동일 패턴 적용. Stage 3 bash 유지로 가독성 확보 (D3).",
      "risks": ["R4 era 분기 (특히 INTENT.md only historical migrate hotfix 43472b7)", "R8 카운트 동치", "R9 bash + python 혼재 가독성"]
    }
  ],
  "risk_mitigation": [
    {"risk_id": "R1", "mitigation": "stdout ✓/✗/- prefix 형식 보존 (D4) — Python 안에서 직접 print + flush=True (D14)"},
    {"risk_id": "R2", "mitigation": "Python try/except per-milestone (D6) — 부분 실패 격리. main() 함수 안 iteration 마다 try/except + FAIL 라인 print"},
    {"risk_id": "R3", "mitigation": "pathlib.Path + glob.glob 사용 (D7) — sys.argv 노출 0"},
    {"risk_id": "R4", "mitigation": "Python def detect_era 함수 (D5/D15) — 9-stage / 7-stage PLAN / 7-stage INTENT-only (hotfix 43472b7) / skip 4 분기 보존. VERIFY 단계에서 4 분기 각 1+ milestone 자동 검증 (D16)"},
    {"risk_id": "R5", "mitigation": "Python re.match(r'^phase-[0-9]+\\.md$', name) — bash grep -qE 동치"},
    {"risk_id": "R6", "mitigation": "Stage F phase commit 자체가 pre-commit 자기 검증 통과 의무 — SyntaxError 즉시 노출 보호 메커니즘 (R10 와 짝). + heredoc quoting `<<'PYEOF'` (D13)"},
    {"risk_id": "R7", "mitigation": "Stage F 후 shellcheck 자동 검증 (pre-commit hook) 통과 확인"},
    {"risk_id": "R8", "mitigation": "VERIFY.md 에 변경 전 PASS/FAIL/SKIP 카운트 baseline + 변경 후 비교 + edge case (milestone 0건 / JSON parse error / 빈 array / approval=null) 주입 검증 기록 의무 (D8/D16)"},
    {"risk_id": "R9", "mitigation": "smoke-scope-contract.sh 안 명시 주석 — Stage 1+2 Python / Stage 3 bash 분리 사유 (D3 rationale)"},
    {"risk_id": "R10", "mitigation": "각 phase commit 자체가 회귀 즉시 노출 — 변경 검증 게이트 작용 (보호 메커니즘)"},
    {"risk_id": "R11", "mitigation": "heredoc quoting `<<'PYEOF'` (D13) — bash variable expansion 차단 → Python f-string `${...}` 충돌 회피. shellcheck SC2016 자동 차단"},
    {"risk_id": "R12", "mitigation": "post-report-write.sh era inject 메시지 동치 — VERIFY 단계 자동 검증 (D16) + smoke-posttooluse-hook 회귀 0 확인"},
    {"risk_id": "R13", "mitigation": "두 smoke 의 def detect_era 본문 동일성 — 본 milestone phase-1/2 동시 작성 + VERIFY 4 분기 동치 출력 자동 검증 (D5/D16). 향후 era 추가 시 양쪽 갱신 의무는 후속 PROPOSE candidate (tests/_era_detect.py 분리) 로 이연"}
  ]
}
```

## 5 관점 검토 (3 관점 채택)

scope = 작음 (affected_files 2 파일) → 표준 3 관점 (architecture / spec-drift / scope contract). 본 milestone 은 외부 spec 의존 거의 없음 + 검증 인프라 변경의 회귀 risk 가 핵심 → **spec-drift 자리에 회귀 risk 대체** (D11).

| # | 관점 | agent type | 검토 포인트 |
|:-:|------|----------|-----------|
| 1 | architecture | `Plan` | 디렉토리/파일 책임 / Python heredoc 통합의 가독성 / phase 분리 적정성 |
| 2 | 회귀 risk | `Explore` | 기존 5 active smoke + pre-commit pipeline + verify.sh 영향 / era 분기 동치 / 출력 contract 동치 |
| 3 | scope contract | `Explore` | INTENT.success_criteria 7건 ↔ DESIGN.phases 2건 1:1 매핑 + out_of_scope 7건 보존 |

5 관점 raw 결과는 본 narrative 아래 § "검토 결과" 에 통합 기록 (별도 design-review/ 분리는 v1.4_design-review-trace 후속 milestone 에서 처리).

## 검토 결과

3 관점 병렬 sub-agent 검토 결과 (2026-05-10):

### 1. architecture (Plan agent) — pass-with-comments

**verdict**: 채택 Approach A 와 phase 분리는 architecturally 타당하나, 단일 source 위반 (D5 detect_era 이중 구현) + heredoc quoting 명시 부족 + tests/CLAUDE.md affected_files implicit 분류가 보강 필요.

**발견 7건 + 추가 risk 3건 (A1~A3)**:

| # | 발견 | DESIGN 반영 |
|:-:|---|---|
| 1 | phase 분리 (D2) 적정 — 통합 더 좋은 case 없음 | 유지 |
| 2 | 단일 heredoc 가독성 — 함수 분리 패턴 우월 | **D12 추가 (def 함수 분리 의무)** |
| 3 | bash + python 혼재 (D3) 가독성 비용 정당화 | D3 rationale 보강 (Stage 3 책임 grep 3회 이상 시 trigger) |
| 4 | 출력 contract (D4) Python 직접 print 견고 | **D14 추가 (flush=True 의무)** |
| 5 | detect_era 동치 구현 (D5) — 단일 source 위반 ⚠️ | **D5 보강 (옵션 e: bash 제거 + Python 일원화) + D15 (spec-verification 통합)** |
| 6 | phase 단위 (2개) 적정 | 유지 |
| 7 | tests/CLAUDE.md affected_files 누락 | **D17 추가 (REPORT 시간 측정 별첨 의무)**, D9 narrative 변경 없음 유지 |
| A1 | spec-verification era 식별 inconsistency | **D15 (spec-verification Python detect_era 통합)** |
| A2 | tests/_lib.py 공통 모듈 분리 옵션 미언급 | PROPOSE 후속 candidate 의무 (D5 alternatives_rejected 옵션 b 로 명시) |
| A3 | shellcheck SC2016 / heredoc quoting | **D13 추가 (`<<'PYEOF'` single-quoted 강제) + R11 추가** |

### 2. 회귀 risk (Explore agent) — pass-with-comments

**verdict**: DESIGN 구조 건전. R4 era 분기 + R8 카운트 동치 + R2 traceback 격리 가 critical, VERIFY 단계 검증 명령어 명시 부재.

**risk 평가 (R1~R10) + 추가 risk 2건 (R11~R12)**:

- 기존 R1~R10 평가: 모두 mitigation 적정. R2/R4/R8 가 critical (구현 시점 직접 감사 의무).
- R11 — heredoc quoting (architecture A3 와 동일) → D13/R11 mitigation
- R12 — post-report-write.sh era inject 메시지 동치 → D16 VERIFY 자동 검증

**Stage G 회귀 검증 명령어 list** (회귀 review agent 직접 제시): VERIFY.md 작성 시 그대로 차용 — baseline 캡처 → phase 후 카운트 비교 → edge case 주입 (milestone 0건 / JSON parse error / phase-N regex 위반) → 4 분기 milestone 검증 → 다른 4 smoke 회귀 0 → 시간 측정 임계 검증 → traceback 격리 검증 → 자기 검증 게이트.

### 3. scope contract (Explore agent) — pass-with-comments

**verdict**: Forward 매핑 7건 모두 검증 가능 ✓ + Backward out_of_scope 7건 모두 보존 ✓. D11 검토 관점 변경 (spec-drift → 회귀 risk) transparency + DESIGN.phases.affected_files implicit 분류 개선 권고.

**Forward 매핑 (success_criteria 7건 → DESIGN.phases)**:

| # | success_criteria | 매핑 | 검증 |
|:-:|---|---|---|
| 1 | spec-verification 10s 이하 | phase-1 | `time bash tests/smoke-spec-verification.sh` |
| 2 | scope-contract 5s 이하 | phase-2 | `time bash tests/smoke-scope-contract.sh` |
| 3 | pre-commit 30s 이하 | phase-1+2 | `time pre-commit run --all-files` |
| 4 | PASS/FAIL/SKIP 동치 | D8/D16 | baseline 캡처 + 비교 |
| 5 | 4 smoke 회귀 0 | D10 untouched | `pre-commit run --all-files` |
| 6 | era 자동 식별 동치 | D5/D15/D16 | 4 분기 milestone 1+ 검증 |
| 7 | --fix mode 정합 | D10 unchanged | smoke -v grep --fix 부재 |

**Backward (out_of_scope 7건)**: 모두 ✓ 보존 (DESIGN 위반 없음).

**추가 권고**:

1. INTENT.md 에 review_perspectives 필드 (향후 milestone 템플릿) — **본 milestone 은 적용 보류, harness-meta.md 갱신 후속 candidate**
2. DESIGN.phases.verify_targets 필드 (affected_files + implicit untouched) — **후속 candidate**
3. era 분기 baseline 라인번호 추가 — **D16 으로 흡수 (VERIFY 자동 검증 명령어 명시)**

### 의견 충돌

**없음** — 3 관점 모두 pass-with-comments + 권고 사항 모두 DESIGN 갱신으로 흡수 가능. AskUserQuestion 추가 invoke 불필요.

### DESIGN 갱신 결과

D5 (detect_era 일원화 옵션 e), D12 (Python 함수 분리), D13 (heredoc quoting), D14 (flush=True), D15 (spec-verification era 통합), D16 (VERIFY 자동 검증 의무), D17 (REPORT 시간 측정 의무) 7개 decision 추가/보강. R11 (heredoc quoting) / R12 (post-report-write.sh 메시지) / R13 (def detect_era drift) 3 risk + mitigation 추가. 검토 후 모든 권고 흡수.

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- 정의 (정전 single source): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3 5요소 매트릭스
- tests/ 모듈 가이드: [`../../../../tests/CLAUDE.md`](../../../../tests/CLAUDE.md)
