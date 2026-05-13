# phase-6 — v2.2_smoke-cp949-encoding-pattern 흡수 (Windows cp949 패턴 강제)

```json
{
  "phase": 6,
  "status": "completed",
  "title": "Windows cp949 콘솔 인코딩 회피 패턴 — smoke 작성 표준 + D15 errors='replace' 통일",
  "scope": [
    "tests/CLAUDE.md § '흔한 함정' 6번째 항목 추가 (Windows cp949 + sys.stdout.reconfigure)",
    "tests/CLAUDE.md smoke 작성 5-step Step 3 (Generate) Python heredoc boilerplate 의무 명시",
    "tests/smoke-spec-verification.sh + tests/smoke-scope-contract.sh: reconfigure 호출에 errors='replace' 인자 추가 (D15 통일)",
    "milestones/v3.0/milestones.md sub-milestone-6 entry status: pending → completed"
  ],
  "rationale": "v2.1 lessons L1 — phase-1 첫 실행 Windows cp949 em dash UnicodeEncodeError 직접 발견. v3.0 자체 phase-1 에서도 동일 issue 잠재. 보안 D15 (S4 MEDIUM) — extract_json 의 errors='replace' 와 reconfigure 호출 errors 인자 통일. AST audit (smoke-python-entry-boilerplate § P2) 은 v1.87 시점 이미 활성 (재추가 부재).",
  "decisions_referenced": ["D14 (commit ref + dependencies.absorbed_from)", "D15 (errors='replace' 통일)"],
  "absorbed_from": "v2.2_smoke-cp949-encoding-pattern",
  "verification": {
    "smoke_spec_verification": "PASS (reconfigure 인자 추가, 출력 동치)",
    "smoke_scope_contract": "PASS (동일)",
    "smoke_python_entry_boilerplate": "PASS (P2 reconfigure encoding 검증 활성, errors 인자는 narrative 만 — fixture 변경 부재)"
  }
}
```

## 작업 내용

1. **tests/CLAUDE.md § '흔한 함정'** 표 6번째 항목 추가 — Windows cp949 콘솔 em dash UnicodeEncodeError 회피 패턴 + AST audit § P2 reference
2. **tests/CLAUDE.md § smoke 작성 5-step Step 3 (Generate)** Python heredoc 사용 시 의무 boilerplate (sys.stdout.reconfigure(encoding='utf-8', errors='replace'))
3. **tests/smoke-spec-verification.sh + smoke-scope-contract.sh** reconfigure 호출에 `errors='replace'` 인자 추가 (D15 통일, S4 MEDIUM mitigation)
4. **milestones/v3.0/milestones.md** sub-milestone-6 entry status pending → completed + summary narrative 갱신

## execution_notes

- AST audit (smoke-python-entry-boilerplate § P2) 은 v1.87 시점 이미 도입 — `__main__` + `print()` 보유 script 의 reconfigure 호출 의무 검증. 본 phase 는 fixture / 검증 본문 변경 없이 narrative + smoke heredoc errors 인자만 통일
- tests/CLAUDE.md narrative 강화로 향후 smoke 작성 시 자동 적용 강제 (Step 3 의무 boilerplate)
- 원 v2.2_smoke-cp949-encoding-pattern 의 책임 (3건 — narrative 추가 + Step 3 의무 + AST audit) 모두 보존: narrative 추가 ✓ / Step 3 의무 ✓ / AST audit 이미 활성

## commit

```
feat(meta): v3.0 phase-6 — v2.2_smoke-cp949-encoding-pattern 흡수 (Windows cp949 패턴 + D15 errors='replace')
```
