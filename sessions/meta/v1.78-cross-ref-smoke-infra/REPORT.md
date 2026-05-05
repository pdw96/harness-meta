# REPORT — v1.78 Cross-ref smoke infra

## 최종 결과

- **변경 파일**: 4건 — `tests/smoke-cross-ref.sh` (신규) + `tests/CLAUDE.md` (수정) + 본 세션 PLAN/REPORT
- **신규 smoke**: 1건 — `smoke-cross-ref.sh` (Stage 1 검출 + `--fix` mode)
- **post-run 검증**: harness-meta PASS=1 FAIL=0 SKIP=0 (broken=0 확인)
- **E2E 검증**: fixture violation 주입 → FAIL=1 → `--fix` 2행 삭제 + .bak 생성 → PASS=1
- **smoke 회귀**: 0
  - `tests/smoke-scope-contract.sh`: PASS=176 FAIL=0 SKIP=0
  - `tests/smoke-spec-verification.sh`: PASS=549 FAIL=0 SKIP=4

## 구현 요약

| # | Goal (PLAN sub-item) | Implementation | 상태 |
|--:|---------------------|---------------|:----:|
| C1 | `tests/smoke-cross-ref.sh` 신설 | Python3 heredoc 2개 — Stage 1(검출) + `--fix`(행 삭제). `@path` repo root 절대 + markdown link 파일 위치 기준 상대 양방향 resolve | ✅ |
| C2 | backtick false positive filter | ` ``` ` 코드 블록 state machine + inline backtick `re.sub` 이중 제거. false positive 0건 (harness-meta 196 refs 중 코드 블록/backtick 내부 전량 제외) | ✅ |
| C3 | default 실행 → harness-meta PASS | `bash tests/smoke-cross-ref.sh` → PASS=1 FAIL=0 SKIP=0 (broken=0) | ✅ |
| C4 | E2E violation 주입 → FAIL → --fix → PASS | fixture 2행(존재하지 않는 `@path` + `[text](broken.md)`) 주입 → FAIL=1 → `--fix` 행 삭제 + .bak 생성 → PASS=1 | ✅ |
| C5 | 기존 smoke 회귀 0 (2종 PASS) | `smoke-spec-verification.sh` PASS=549 + `smoke-scope-contract.sh` PASS=176 — 회귀 0 | ✅ |

PLAN `Scope inheritance` 2 sub-item (C1/C2) ↔ REPORT 구현 2건 **1:1 매핑** 정합. C3~C5는 PLAN "성공 기준" 검증 항목.

## 판정

- [x] C1: `tests/smoke-cross-ref.sh` 신설 (`@path` + markdown link 양방향 resolve)
- [x] C2: backtick false positive filter (코드 블록 state machine + inline backtick `re.sub`)
- [x] C3: `bash tests/smoke-cross-ref.sh` → harness-meta PASS (broken=0)
- [x] C4: E2E violation 주입 → FAIL → `--fix` → PASS (fixture 2행 삭제 + .bak)
- [x] C5: 기존 smoke 2종 PASS — 회귀 0 (smoke-spec-verification 549/549 + smoke-scope-contract 176/176)
- [x] `tests/CLAUDE.md` §smoke 매트릭스 "도메인 별 회귀" 1 row 추가
- [x] PLAN `Scope inheritance` 2 sub-item ↔ REPORT 구현 2건 1:1 매핑

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 순수 bash/python3 내부 스크립트, 외부 spec 의존 없음 |
| **re-verify** | N/A |

**Citations**: N/A (PLAN N/A → REPORT N/A 자연 진화 — Stage 7 cross-file 일관성 OK case)

## Lessons Learned

- **L1 — `sessions/**/v*-*/*.md` 제외 범위 정밀화**: 초기 설계에서 `sessions/**` 전체 제외 시 `sessions/CLAUDE.md` + `sessions/meta/ROADMAP.md` (living docs)가 누락됨. architecture 관점 검토에서 발견 → `_VER_SESS = re.compile(r'^sessions/[^/]+/v\d+\.\d+[^/]*/[^/]+\.md$')` 버전 디렉토리만 제외로 정밀화.
- **L2 — `python3 - arg1 arg2 <<'PYEOF'` 패턴 필수**: `python3 <<'PYEOF' arg1 arg2` 구문은 Python이 첫 번째 인자를 실행 모듈로 해석 → `can't find '__main__' module` 오류. `python3 - arg1 arg2 <<'PYEOF'` (`-` stdin 명시)가 올바른 패턴 — v1.70 MSYS2 sys.argv 경유 패턴과 동일 맥락.
- **L3 — Windows cp949 UnicodeEncodeError (v1.18d 패턴 재확인)**: `--fix` Python 섹션 상단 `sys.stdout.reconfigure(encoding='utf-8', errors='replace')` 없이 `✓` 출력 시 cp949 인코딩 오류. v1.18d 패턴 필수 — 신규 python3 heredoc 작성 시 stdout reconfigure 항상 첫 라인.

## 다음 후보 (보류)

- **`v1.78b` — `.pre-commit-config.yaml`에 smoke-cross-ref hook 추가**: broken ref 재발 evidence 또는 사용자 요구 시 trigger. 현재 harness-meta PASS=0 (broken ref 0건) — 재발 없으면 pre-commit hook 불필요.

## 선행 / 후속 세션

- **선행**: [`v1.77-cross-ref-broken-link-fix/`](../v1.77-cross-ref-broken-link-fix/) — 수동 audit 4건 fix + L1 Lesson (backtick filter 필수) → 본 세션 Scope inheritance source
- **후속 (잠재)**: `v1.78b` — pre-commit hook 등록 (broken ref 재발 evidence 시)
