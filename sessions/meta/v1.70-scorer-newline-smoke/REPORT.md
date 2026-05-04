# meta v1.70-scorer-newline-smoke — REPORT

세션 완료: 2026-05-05
선행 세션: [`sessions/meta/v1.69-python-newline-audit/`](../v1.69-python-newline-audit/REPORT.md)

## 최종 결과

- **신규 파일**: `tests/smoke-scorer-output-newline.sh` (1건)
- **smoke 결과**: 5/5 PASS (정적 2 + 동적 3)
- **회귀**: roi-regression 6/6 + detect-language 6/6 + agentic-safety-na 5/5 = 17/17 PASS

## 구현 요약

### `tests/smoke-scorer-output-newline.sh` 신설

**Stage 1 (정적 2)**:

- S1: `score_codebase.py`에 `newline=` 선언 존재 확인 (grep)
- S2: `html_renderer.py` 동상

**Stage 2 (동적 3)**:

- D1: `python3 score_codebase.py <repo> --output-dir <tmpdir>` 실행 exit 0
- D2: `ai-ready-report.json` byte-level CRLF=0 검증
- D3: `ai-ready-dashboard.html` byte-level CRLF=0 검증

**기술적 결정 — sys.argv 경로 전달**:
초안 구현에서 Python `-c` 코드 문자열에 bash `$JSON_PATH`를 직접 삽입(`open('$JSON_PATH', 'rb')`)하면 Windows Python이 MSYS `/tmp/tmp.xxx` 경로를 찾지 못하는 버그 발생.

원인: MSYS2 shell은 별도 인자(argv)로 전달 시 `/tmp/...` → `C:\...\Temp\...` 자동 번역. 그러나 `-c` 문자열 내 리터럴은 번역하지 않음.

해결: `python3 -c "... open(sys.argv[1], 'rb') ..." "$PATH"` 패턴으로 경로를 argv 경유 전달. 이 방식은 MSYS2의 자동 번역이 적용되어 Python이 올바른 Windows 경로를 수신.

**아키텍처 검토 반영** — D1 실패 시 D2/D3 guard:

```bash
if python3 ... ; then
    ok "D1 ..."
    # D2/D3 실행
else
    fail "D1 ..."
    fail "D2 skip"
    fail "D3 skip"
fi
```

## 판정

- [x] `tests/smoke-scorer-output-newline.sh` 존재 + 실행 가능
- [x] `bash tests/smoke-scorer-output-newline.sh` → 5/5 PASS
- [x] 기존 smoke 회귀 0 (17/17 PASS)
- [x] `score_codebase.py`에서 `newline=` 제거 시 S1 FAIL 감지 (정적 grep으로 보장)

## Spec verification (context7)

| sub-field | 값 |
| ----------- | --- |
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 구현 중 외부 spec 의존 없음. Python stdlib + 내부 smoke 패턴 재사용. MSYS2 path translation 발견은 내부 환경 특성 (공식 문서 변경 아님) |
| **re-verify** | N/A |

## Lessons Learned

**L1 — MSYS2 path translation은 argv에만 적용**: bash에서 Python -c 호출 시 POSIX path를 문자열 리터럴로 삽입하면 Windows Python이 해석 실패. argv 경유(`sys.argv[1]`)로 전달하면 MSYS2가 자동 번역. → Windows Git Bash 환경에서 bash↔Python 경로 공유 시 일반 원칙으로 적용.

**L2 — 동적 테스트 D1 guard 패턴**: D1(실행 성공) 실패 시 하위 D2/D3를 명시 `fail` 처리해야 카운터가 정합. skip 처리 시 PASS/FAIL 합산에서 누락됨.

## 다음 후보

- `v1.69d-precommit-scorer-smoke` — pre-commit에 본 smoke 등록 필요 evidence 발생 시
- (ROADMAP §3-E `v1.69d` trigger 해소, 신규 후속 아직 없음)
