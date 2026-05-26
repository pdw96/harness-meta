# v8.8 execute — phase-2: smoke 검증 + 문서

## changes

1. **`tests/smoke-secret-scan.sh`** (신규) — 회귀 차단 10 checks (도메인 별 회귀 카테고리, dynamic):
   - Static 1 hook 파일+shebang / Static 2 hooks.json 등록
   - Dynamic A 정상 fixture no-op{} / B Docker Hub PAT / C JWT / D github_pat_(D-SEC-2) / E dot 없는 eyJ JWT 미매칭(grep `\.` literal dot, D-FP-2) / F settings.json HIGH exposure 차등(D-SEC-1) / G valid JSON 규약
   - Real harness-meta 현 settings.local.json FP=0 baseline(sc_4)
   - python3 부재 SKIP. pre-commit 미등재(manual run, user discretion).

2. **`claude/CLAUDE.md`** — 디렉토리 트리에 session-start-secret-scan.sh 1행 + Hook 정책 'SessionStart (session-start-secret-scan.sh)' 섹션 신설(gate/raw grep/warn-only/origin/글로벌 보호 확장).

3. **`tests/CLAUDE.md`** — smoke 매트릭스 '도메인 별 회귀' 표 1행 + active count 12→13 갱신.

## verification

| smoke | 결과 |
| --- | --- |
| smoke-secret-scan (신규) | PASS=10 FAIL=0 SKIP=0 |
| smoke-claude-md-drift | 13/13 PASS (smoke count 13=13 정합) |
| smoke-cross-ref | PASS=1 FAIL=0 (broken ref 0) |
| spec-verification | PASS=491 FAIL=0 |
| scope-contract | PASS=110 FAIL=0 |
| bundle-trigger / open-stage / entry-title / cascade-drift / candidate-draft / agent-frontmatter | 전부 PASS |

전체 active smoke FAIL=0 (sc_5 충족). sc_4 FP=0 baseline 실측 통과.

## commit

(milestone 단위 커밋 — VERIFY/REPORT/PROPOSE 후 사용자 확인)
