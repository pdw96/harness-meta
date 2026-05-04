# meta v1.18d-scorer-stdout-encoding — REPORT

세션 종료: 2026-04-30
선행 세션:

- [`sessions/meta/v1.18g-score-codebase-py-split/`](../v1.18g-score-codebase-py-split/) — score_codebase.py 분할 (entry point)
- [`sessions/meta/v1.18g2-helper-threshold-revisit/`](../v1.18g2-helper-threshold-revisit/) — Stage C에서 cp949 evidence 직접 관찰

## 최종 결과

| 항목 | 결과 |
|------|------|
| 수정 파일 | `score_codebase.py` line 121-130 (10 lines: 주석 3 + for loop 7) + `EVIDENCE_DRIVEN_ROADMAP.md` §8 +1 row |
| Windows cp949 emoji 출력 | ❌ UnicodeEncodeError → ✅ 정상 표시 |
| Console summary | 🏆 + 게이지 바 + 점수/등급 정상 출력 |
| 회귀 | 0 (artifact 점수/등급 변동 0 — 파일 카운트만 +4 신규 sessions/ 반영) |

## 구현 요약

### Stage A — score_codebase.py reconfigure block

`main() -> None:` 진입 직후 (line 122-130):

```python
def main() -> None:
    # Windows cp949 default 환경에서 emoji + 한국어 출력 안전 보장 (v1.18d).
    # stdout/stderr 모두 UTF-8 + errors='replace' fallback (encode 불가 문자 → '?').
    # Linux/macOS는 이미 UTF-8 default → reconfigure no-op.
    for stream in (sys.stdout, sys.stderr):
        if hasattr(stream, "reconfigure"):
            try:
                stream.reconfigure(encoding="utf-8", errors="replace")
            except (AttributeError, ValueError, OSError):
                pass

    parser = argparse.ArgumentParser(...)
    # ... 기존 로직
```

방어 layer 3중:

1. `hasattr(stream, "reconfigure")` — Python 3.7 이전 또는 io.TextIOWrapper 외 stream 보호
2. `try/except (AttributeError, ValueError, OSError)` — reconfigure 호출 실패 시 silent skip
3. `errors="replace"` — encode 불가 codepoint → '?' fallback (raise 회피)

### Stage B — Windows cp949 환경 검증

**실행 명령**: `python bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py .`

**Console output** (검증 통과):

```
🔍 분석 중: harness-meta (C:\Users\qkreh\harness-meta)
✅ JSON: C:\Users\qkreh\harness-meta\ai-ready-report.json
✅ HTML: C:\Users\qkreh\harness-meta\ai-ready-dashboard.html

==================================================
  🏆 AI-Ready 점수: 93/100  등급: S
==================================================
  문서화          ████████░░ 12/15 [A]
  코드 구조        ████████░░ 13/15 [A]
  타입 안전성       ██████████ 15/15 [S]
  테스트 품질       ██████████ 15/15 [S]
  컨텍스트 레이어     ██████████ 15/15 [S]
  자동화          ████████░░ 13/15 [A]
  에이전틱 안전      ██████████ 10/10 [S]
==================================================

{"json": "...", "html": "...", "score": 93.0, "grade": "S"}
```

이전 v1.18g2 Stage C 출력 (실패 evidence):

```
\U0001f50d �м� ��: harness-meta ...    ← 🔍 mojibake
✅ JSON: ...                            ← (stderr — backslashreplace)
==================================================
Traceback (most recent call last):
  File "score_codebase.py", line 153, in main
    print(f"  {g_emoji} AI-Ready ...")
UnicodeEncodeError: 'cp949' codec can't encode character '\U0001f3c6'
```

**비교 매트릭스**:

| 출력 site | line | emoji | v1.18d 전 (cp949) | v1.18d 후 (UTF-8) |
|----------|:---:|:---:|:---:|:---:|
| stderr "분석 중" | 137 | 🔍 | mojibake | ✅ 정상 |
| stderr "JSON:" | 143 | ✅ | mojibake | ✅ 정상 |
| stderr "HTML:" | 148 | ✅ | mojibake | ✅ 정상 |
| **stdout "AI-Ready 점수"** | 153 | 🏆 | ❌ **즉시 raise** | ✅ 정상 |
| stdout 카테고리 게이지 | 157 | (한국어) | (도달 안 함) | ✅ 정상 |
| stdout ROI | 161 | 🚀 | (도달 안 함) | ✅ 정상 |
| stdout final JSON | 167 | (없음) | (도달 안 함) | ✅ 정상 |

### Stage C — Artifact 회귀 검증

JSON/HTML 재생성 후 git diff:

```
ai-ready-dashboard.html | 4 ++--
ai-ready-report.json    | 4 ++--
score_codebase.py       | 10 ++++++++++
```

artifact diff 내역:

- 파일 카운트 342 → 346 (신규 sessions/ 4 파일 추가 — v1.31b PLAN/REPORT + v1.18d PLAN + 변경 score_codebase.py)
- 생성 timestamp 차이

**점수/등급 변동 0**: total_score=93.0, grade=S, 7 카테고리 동일 (회귀 0 보장 확인).

## 판정 (PLAN 체크박스)

| 목표 | 결과 |
|------|:---:|
| `score_codebase.py` `main()` 진입 직후 reconfigure block (~7 lines) | ✅ (10 lines: 주석 3 + 코드 7) |
| stdout + stderr 모두 reconfigure | ✅ |
| errors='replace' fallback | ✅ |
| hasattr + try/except 방어 (회귀 0) | ✅ (3중 layer) |
| Windows cp949 검증: 🏆 + AI-Ready 점수 정상 표시 | ✅ |
| 회귀 0: artifact 점수/등급 변동 0 | ✅ (파일 카운트 +4만 신규 sessions/ 반영) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (Python 표준 라이브러리 sys.stdout.reconfigure만; Python 3.7+ stdlib 표준). 구현 중 신규 spec drift 없음 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — Direct evidence 관찰의 가치** ⭐: v1.18g2 Stage C에서 cp949 fail을 **본인이 직접 관찰** → 본 v1.18d evidence가 명확. 추측이 아닌 실제 traceback에서 line 153 + `\U0001f3c6` (🏆) 정확 식별. v1.35 REPORT "다음 후보" §에서 진행 후보로 listing되었지만 evidence는 v1.18g2에서 실측 → "cross-session evidence accumulation" 패턴.

- **L2 — 3중 방어 layer 패턴**: hasattr + try/except + errors='replace'의 3중 방어. 한 layer 실패 시 다음 layer가 catch → 회귀 위험 0. 향후 비슷한 환경 의존 fix (Windows path / locale 등)에 답습 가능.

- **L3 — entry point only fix 의 minimality**: utils.py / categories_*.py / html_renderer.py에 print 부재 (Grep 검증) → main() 한 곳만 reconfigure. 모듈 import side-effect 0. 본 패턴 = "entrypoint 책임 명확화" — 모듈은 print 안 하고 entrypoint만 stdout/stderr 다룬다는 단일 책임 원칙.

- **L4 — JSON/HTML artifact 회귀 0 보장**: reconfigure는 **stdout/stderr만** 영향, file write에는 영향 무 (write_text는 자체 encoding="utf-8" 명시). artifact는 timestamp + 파일 카운트만 변동. 점수/등급 동일 — fix가 의도된 영향 범위(console 출력)만 변경 ✓.

## 다음 후보 (보류)

| 항목 | 조건 |
|------|------|
| `v1.18d2-multi-script-encoding` | 다른 글로벌 user-skill scripts/*.py에서 동일 evidence 발생 시. 공통 helper module 추출 검토 |
| README Windows 사용자 안내 (`chcp 65001`) | 사전 설정 안내 — 본 fix가 자체 해결하므로 불필요. 사용자 명시 요청 시만 별 후속 |
