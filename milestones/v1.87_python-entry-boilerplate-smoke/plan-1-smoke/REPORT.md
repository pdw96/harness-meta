# plan-1-smoke — REPORT

## 최종 결과

- 변경 파일: 4 (1 신규 smoke + 2 docs + 1 PLAN follow-up)
- 신규: `tests/smoke-python-entry-boilerplate.sh` (~140 lines, AST 기반)
- smoke 6종 PASS — 새 smoke 8/8 dogfood + 3/3 E2E + 회귀 0 (claude-md-drift 16/16 + scope-contract 196/196 + cross-ref 1/1 + roadmap-sync 31/31 + spec-verification 608/608 SKIP=4)
- commit: `3abb7f9`

## 구현 요약

- [x] **`tests/smoke-python-entry-boilerplate.sh` 신규** — AST 기반 Python entry-point 정적 audit
  - Stage 1+2 (dogfood): `bootstrap/skills/**/*.py` 8건 audit
  - Stage 3 (E2E): mktemp fixture violation P1/P2 + clean 3 case detect
  - `python3 -` heredoc 위임 (`ast.walk` + `ast.parse`) — multi-line `write_text(...)` 호출 paren-aware (regex 미흡 회피)
  - P1: `\.write_text\(...\)` 호출의 `kw.arg == "newline"` 부재 시 violation
  - P2: 모듈 레벨 `if __name__ == "__main__":` block + `print(` Call + `\.reconfigure\(.*encoding=...)` 부재 시 violation
- [x] **`tests/CLAUDE.md` 갱신** — `## smoke 매트릭스 (현 27 파일)` → `(현 28 파일)` + "도메인 별 회귀" 섹션에 1 row 추가 (`smoke-scorer-output-newline.sh` 직후)
- [x] **`CLAUDE.md` (root) 갱신** — `tests/` 행 "smoke 27 매트릭스" → "smoke 28 매트릭스"
- [x] **plan-1-smoke/PLAN.md line 30** markdownlint MD038 fix — pipe escape + 공백 backtick 조합 위반 → 일반 prose로 재작성

## 판정

milestone PLAN.md 성공 기준 6 체크박스 모두 완수:

- [x] `tests/smoke-python-entry-boilerplate.sh` 신규 생성 — Stage 1 (P1) + Stage 2 (P2) + Stage 3 (E2E)
- [x] dogfood: harness-meta 8 `.py` 모두 PASS (P1 violation 0 + P2 violation 0)
- [x] E2E fixture: violation P1 → FAIL detect / violation P2 → FAIL detect / clean → PASS
- [x] `tests/CLAUDE.md` smoke matrix count 27→28 + 1 row 추가
- [x] `CLAUDE.md` (root) "smoke 27 매트릭스" → "smoke 28 매트릭스"
- [x] 회귀 0 (5 smoke regression PASS)

## Spec verification (context7)

| sub-field | 값 |
|---|---|
| library | Python (`/websites/python_3_10`) |
| topic | `pathlib.Path.write_text(newline=)` + `io.TextIOWrapper.reconfigure(encoding=)` |
| findings | (1) `Path.write_text(data, encoding=None, errors=None, newline=None)` — newline 파라미터 Python 3.10 추가, `None` (default) 시 universal newline 변환 (Windows CRLF), `"\n"` 명시 시 LF byte-level 보존. (2) `TextIOWrapper.reconfigure(*, encoding, errors, newline, line_buffering, write_through)` Python 3.7+ — `sys.stdout` TextIOWrapper 인스턴스 reconfigure 가능, cp949 환경 emoji UnicodeEncodeError 차단. |
| drift | no |
| re-verify | 24 months (Python stdlib stable API) |

**Citations**:

- `/websites/python_3_10/library/pathlib.html` — `Path.write_text()` signature + newline 인자
- `/websites/python_3_10/library/io.html` — `TextIOWrapper.reconfigure()` (Python 3.7 추가)

post-hoc 정합 — PLAN context7 검증 결과 그대로 유지 (drift=no, 검증 후 코드 변경 없음).

## Lessons Learned

- **L1: AST > regex for Python pattern matching**. 1차 설계는 정규식 + paren-counter였으나 string literal 안 paren (예: `f"hello (world)"`)에서 false count 위험. `ast.parse` + `ast.walk`로 전환 — call site 정확 detect + multi-line aware. 향후 v1.88 Bash entry boilerplate smoke에서도 (Bash AST 부재로) 다른 접근 필요.

- **L2: Worktree 환경에서 smoke 검증 시 `HARNESS_META_ROOT="$(pwd)"` override 필수**. `smoke-claude-md-drift.sh` line 14는 `HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"` → 기본 main repo 스캔. v1.86 milestone L2/L3 lesson 재확인 — 본 smoke도 동일 패턴 채택했으나 worktree 검증 시 override 의무. `tests/CLAUDE.md`에 명시 검토 (post-hoc 후속 §3-E 등록 가치 검토).

- **L3: markdownlint MD038 — backtick 안 escaped pipe + 공백 조합은 "spaces inside code span" 위반**. table syntax 문서화 시 backtick 회피 + 일반 prose 작성 권장. pre-commit이 잡아줘서 commit 전 정정 가능 (autofix-or-fail wrapper 미적용 hook이라 manual fix).

- **L4: pipefail + mapfile + process substitution 조합 안전성**. `mapfile -t PY_FILES < <(find ... | sort)`는 find 빈 결과여도 exit 0 (find 동작 정상). pipefail 활성화에서도 무탈. `find` 자체가 디렉토리 부재 시 exit 1 → 본 smoke는 `bootstrap/skills/` 항상 존재 가정 가능 (defensive `2>/dev/null` 추가).

- **L5: post-hoc Spec verification §은 PLAN 결과 그대로 유지**. 구현 중 spec drift 발견 시만 갱신 — 본 세션은 Python stdlib 사용, 검증 후 변경 0건이라 drift=no 그대로.
