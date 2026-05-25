# phase-1 — smoke era branching (선결)

```json
{
  "phase": 1,
  "status": "completed",
  "title": "smoke era branching — 4 era 인식 (4-tier / 7-stage / 9-stage / 9-stage-bundled)",
  "scope": [
    "tests/smoke-spec-verification.sh detect_era 함수 4 era 분기 추가 + milestone iteration glob 패턴 갱신 (v*_* → v[0-9]*)",
    "tests/smoke-scope-contract.sh 동일 갱신 (detect_era 본문 동일 — phase-2 _era_detect.py 분리 직전)",
    "claude/hooks/post-report-write.sh: 9-stage-bundled era (milestones/v{X.Y}/ 패턴) 인식 + milestones.md 매치 제외 (D16)"
  ],
  "rationale": "자기참조 부합 INTENT~APPROVE commit (phase-3) 시 신 era 인식 의무 (R2 mitigation). phase-2 _era_detect.py 분리 직전 두 smoke 4 era 동시 갱신 — drift 잠재 1 phase (phase-1 → phase-2) 만 존재.",
  "decisions_referenced": ["D6 (8 phase + phase-5 swap)", "D10 (9-stage-bundled era 표지 = 디렉토리 패턴 + milestones.md 존재)", "D13 (APPROVE go/no-go gate)", "D16 (post-report-write.sh milestones.md 매치 제외)"],
  "go_no_go_gate": {
    "post_commit": [
      "smoke-spec-verification.sh 실행 → 기존 3 era milestone (4-tier v1.84~v1.88, 7-stage v1.0~v1.4, 9-stage v2.0~v2.1) PASS 보존",
      "smoke-scope-contract.sh 실행 → 동일 PASS 보존",
      "milestones/v3.0/ (9-stage-bundled era 후보) 인식 — milestones.md 부재 시 9-stage 로 fallback (현재 milestones.md 미작성, phase-5 작성 예정)"
    ]
  }
}
```

## 작업 내용

1. **smoke-spec-verification.sh**:
   - L85-94 `detect_era` 함수: 9-stage-bundled era 분기 추가 (milestones.md 존재 + 디렉토리 명 v{X.Y} 패턴 = `^v\d+\.\d+$`)
   - L169 glob 패턴: `v*_*` → `v[0-9]*` (밑줄 없는 v3.0 도 포함)

2. **smoke-scope-contract.sh**:
   - 동일 갱신 (L83-92 detect_era + L159 glob)
   - phase-2 _era_detect.py 분리 직전 임시 중복 (drift 잠재 1 phase)

3. **post-report-write.sh**:
   - L130-144 패턴 매칭: `milestones/v[^/]+/...` 패턴은 v3.0 (밑줄 없음) 도 인식 가능 → 변경 불필요
   - 단 milestones.md 매치 제외 추가 (D16): RESEARCH|DESIGN|VERIFY 라인에 milestones.md 부재 명시 (현재 정규에 milestones.md 매치 없으므로 안전, 명시적 NOOP 추가)

## execution_notes

- detect_era 갱신은 두 smoke 모두 동일 본문 (D5/D15 일원화 source) — phase-2 에서 tests/_era_detect.py 분리 후 두 smoke 가 import 하면 drift 0
- glob 패턴 v[0-9]* — fnmatch (Path.glob) 에서 v + 숫자 + 임의. v3.0 / v1.84_xxx / v2.0_xxx 모두 매치
- 4-tier era milestone (v1.84~v1.88) 은 INTENT/APPROVE/PROPOSE/PLAN 부재 → 9-stage-bundled / 9-stage / 7-stage 모두 매치 안 됨 → "skip" fallback
- 9-stage-bundled era 의 정의 (D10): 디렉토리 명 ^v\d+\.\d+$ (밑줄 부재) + milestones.md 존재 동시 충족. 본 phase-1 시점 milestones.md 미작성 → milestones/v3.0/ = 7-stage fallback (PROPOSE.md 부재 → 9-stage 매치 안 됨, INTENT.md 존재로 7-stage 분류). phase-5 milestones.md 작성 후 9-stage-bundled 로 변환
- ROADMAP entry 도 본 phase-1 commit 에 포함 (OPEN 단계 작업, 임시 schema "id": "v3.0_milestones-restructure" flat 형식 — phase-4 에서 신 schema 변환)
- smoke 실행 결과: smoke-spec-verification PASS=109 FAIL=0 SKIP=81 / smoke-scope-contract PASS=17 FAIL=0 SKIP=23 (회귀 0, v3.0 phase-1.md 인식)
- v3.0 의 APPROVE.md 검증은 transition state — 현재 era=7-stage fallback 으로 SKIP (legacy DESIGN.approval 부재). phase-5 commit (milestones.md 작성) 후 era=9-stage-bundled 로 분류되어 APPROVE.md 검증 활성화 (R2 mitigation transient cost)

## commit

```
feat(meta): v3.0 phase-1 — smoke era branching (4 era 인식)
```
