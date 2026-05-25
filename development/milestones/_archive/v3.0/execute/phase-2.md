# phase-2 — tests/_era_detect.py 분리 (v2.2_era-detect-shared-module 흡수)

```json
{
  "phase": 2,
  "status": "completed",
  "title": "detect_era 함수 단일 source 분리 — 두 smoke drift 방지",
  "scope": [
    "tests/_era_detect.py 신규 (D5/D15 일원화 source) — 4 era 분류 함수 + docstring",
    "tests/smoke-spec-verification.sh: detect_era 정의 제거 (호출 부재 — 사용 안 함, dead code 정리)",
    "tests/smoke-scope-contract.sh: detect_era 정의 제거 + sys.path.insert + import _era_detect"
  ],
  "rationale": "v2.1 lessons L4 (architecture A2) — 두 smoke 의 def detect_era 본문 동일 → 향후 era 추가 시 양쪽 갱신 의무 = drift risk. tests/_era_detect.py 단일 source 분리 + import 로 drift 0. spec-verification 은 detect_era 호출 부재 (era 분기 안 함) → 정의 제거 (정합). scope-contract 는 Stage 1+2 era 분기 호출 → import. v3.0 D6 swap 으로 phase-1 직후 즉시 적용 (drift 잠재 1 phase 단축).",
  "decisions_referenced": ["D6 (8 phase + phase-5 swap)", "D14 (commit ref + dependencies.absorbed_from)", "D5 (D5/D15 일원화 source)"],
  "absorbed_from": "v2.2_era-detect-shared-module",
  "verification": {
    "smoke_spec_verification": "PASS=109 FAIL=0 SKIP=81 (phase-1 동일, 회귀 0)",
    "smoke_scope_contract": "PASS=17 FAIL=0 SKIP=23 (phase-1 동일, 회귀 0)",
    "import_compat": "Windows Git Bash + sys.path.insert(0, 'tests') 정상 (cwd=HARNESS_META_ROOT)"
  }
}
```

## 작업 내용

1. **tests/_era_detect.py 신규**:
   - detect_era 함수 (4 era 분류) + docstring (era 분류 규칙 narrative)
   - import 의존: re + pathlib.Path
   - smoke heredoc 안 import: `sys.path.insert(0, 'tests'); from _era_detect import detect_era`

2. **smoke-spec-verification.sh**:
   - detect_era 함수 정의 제거 (호출 부재 — dead code 정리)
   - 주석으로 _era_detect.py 분리 narrative 보존 (era 분기 검증은 smoke-scope-contract.sh 책임)

3. **smoke-scope-contract.sh**:
   - detect_era 정의 제거
   - sys.path.insert + import _era_detect 추가
   - Stage 1+2 era 분기 코드 (in ("9-stage", "9-stage-bundled")) 보존

## execution_notes

- import 정합: sys.path.insert(0, 'tests') 로 batched python heredoc 안에서 import 가능. cwd=HARNESS_META_ROOT (smoke 진입 시 cd 지점). Windows Git Bash + Python 3.10+ 정상
- detect_era 분류 결과 동치 — 4 era 분류 본문 변경 0 (단순 분리)
- smoke 회귀 0 (phase-1 baseline 동일)
- v2.2_era-detect-shared-module 의 책임 (drift 방지) 완전 보존 — ROADMAP entry 제거는 phase-4 에서

## commit

```
feat(meta): v3.0 phase-2 — tests/_era_detect.py 분리 (v2.2_era-detect-shared-module 흡수)
```
