# meta v1.18d-scorer-stdout-encoding — PLAN

세션 시작: 2026-04-30
직접 선행 세션:

- [`sessions/meta/v1.18g-score-codebase-py-split/`](../v1.18g-score-codebase-py-split/) — score_codebase.py 분할 (본 세션 변경 대상 entry point)
- [`sessions/meta/v1.18g2-helper-threshold-revisit/`](../v1.18g2-helper-threshold-revisit/) — Stage C에서 cp949 UnicodeEncodeError 직접 관찰 (본 세션 evidence)

목적: Windows cp949 default stdout encoding 환경에서 emoji(🔍🏆⭐✅⚠️🚀❌) 출력 시 UnicodeEncodeError 발생 → JSON/HTML artifact는 생성되지만 console summary 표시 fail. `main()` 진입 시 `sys.stdout/sys.stderr.reconfigure(encoding='utf-8', errors='replace')`로 UTF-8 강제 → emoji + 한국어 출력 안전.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1c(1) `bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py` = **1/1 meta**
- **T1 경로 다수결** — meta scope 1/1
- **T2 스펙 vs 값** — scorer entry point 코드 = 모든 사용자 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.18g2-helper-threshold-revisit/REPORT.md` 다음 후보 § (verbatim)**:

> | `v1.18d-scorer-stdout-encoding` | Windows cp949 stdout UnicodeEncodeError fix (Stage C에서 재발 — JSON 생성은 성공이나 console print fail) |

**Source 2 — `sessions/meta/v1.35-scorer-other-na-categories/REPORT.md` 다음 후보 § (verbatim)**:

> | `v1.18d-scorer-stdout-encoding` | Windows cp949 stdout emoji UnicodeEncodeError fix |

**Source 3 — v1.18g2 Stage C 직접 관찰 evidence (verbatim from terminal output)**:

> ```
> UnicodeEncodeError: 'cp949' codec can't encode character '\U0001f3c6' in position 2: illegal multibyte sequence
> ```
>
> (line 153: `print(f"  {g_emoji} AI-Ready 점수: ...")` — 🏆 emoji cp949 encode fail)

**Parsed sub-items (1)**:

1. **stdout/stderr UTF-8 reconfigure** — `main()` 진입 직후. emoji + 한국어 print site 모두 안전 보장. JSON/HTML artifact 생성 path 유지

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 다른 모듈 (utils.py / categories_*.py / html_renderer.py) reconfigure | 본문에 직접 print 없음 (Grep 검증). main entry point만 |
| 글로벌 환경변수 `PYTHONIOENCODING=utf-8` 안내 | 본 fix가 자체 해결 — 사용자 사전 설정 불필요 |
| Python 3.6 호환성 보장 (`reconfigure` 메서드 부재) | 본 repo `from __future__ import annotations` 사용 — Python 3.10+ 가정 (Match 문법 미사용이지만 기존 의존성 정합) |
| HTML 대시보드 emoji 표시 (브라우저는 UTF-8 default — 영향 무) | 별 무관 |
| stdout buffering / line_buffering 변경 | 최소 변경 원칙 |
| Windows 외 OS 분기 검증 | Linux/macOS는 LANG=en_US.UTF-8 default — 영향 무 (reconfigure no-op) |
| 다른 emoji 사용 site 검증 (skill SKILL.md 등) | 본 score_codebase.py만 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (Python 표준 라이브러리 sys.stdout.reconfigure만 — Python 3.7+ stdlib 표준, 외부 docs 검증 불필요) |
| **re-verify** | N/A |

## 1. 문제

### Evidence (직접 관찰)

v1.18g2 Stage C에서 `python bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py . --json-only` 실행 시:

```
\U0001f50d �м� ��: harness-meta (C:\Users\qkreh\harness-meta)    ← 🔍 cp949 mojibake
✅ JSON: C:\Users\qkreh\harness-meta\ai-ready-report.json     ← ✅ mojibake
==================================================
Traceback (most recent call last):
  File "score_codebase.py", line 178, in <module>
    main()
  File "score_codebase.py", line 153, in main
    print(f"  {g_emoji} AI-Ready ����: {report.total_score:.0f}/100  ���: {report.grade}")
UnicodeEncodeError: 'cp949' codec can't encode character '\U0001f3c6' in position 2: illegal multibyte sequence
```

### Root cause

Windows 기본 console encoding = cp949 (한국어 환경). Python `sys.stdout.encoding`이 'cp949'로 설정되어 emoji(BMP 외 codepoint)를 encode 못 함:

| 출력 | encoding | 결과 |
|------|---------|:---:|
| 🔍 (`\U0001f50d`) | cp949 | mojibake (escape sequence) |
| ✅ (`✅`) | cp949 | mojibake |
| 🏆 (`\U0001f3c6`) | cp949 | **UnicodeEncodeError 즉시 fail** |

stderr는 errors='backslashreplace' default로 mojibake 형태 출력하지만 종료 안 됨. stdout은 errors='strict' default로 즉시 raise.

### 영향

- ✅ JSON artifact (`ai-ready-report.json`) — 생성 정상 (UTF-8 명시 write_text)
- ✅ HTML artifact (`ai-ready-dashboard.html`) — 생성 정상 (file write도 UTF-8)
- ❌ Console summary print — line 153 (🏆 emoji)에서 즉시 fail → 점수/등급 표시 불가
- ❌ ROI 액션 list (line 161~163, 🚀) — print 도달 안 함
- ❌ Final stdout JSON output (line 167) — 도달 안 함 → 스킬 파이프라인 stdout 캡처 fail

### 환경 의존성

- **Linux/macOS**: `LANG=en_US.UTF-8` default → stdout encoding=UTF-8 → 영향 무
- **Windows + cp949 (한국어)**: 영향 발현
- **Windows + UTF-8 (PYTHONIOENCODING=utf-8)**: 사용자 사전 설정 시 영향 무 (그러나 default가 cp949)

## 2. 결정

### R1 — `main()` 진입 직후 stdout/stderr reconfigure

```python
def main():
    # Windows cp949 default 환경에서 emoji + 한국어 출력 안전 보장 (v1.18d).
    # stdout/stderr 모두 UTF-8 + errors='replace' fallback (encode 불가 문자 → '?').
    for stream in (sys.stdout, sys.stderr):
        if hasattr(stream, "reconfigure"):
            try:
                stream.reconfigure(encoding="utf-8", errors="replace")
            except (AttributeError, ValueError, OSError):
                pass

    parser = argparse.ArgumentParser(...)
    # ... 기존 로직
```

### R2 — 구현 의사결정 매트릭스

| 결정 | 옵션 | 채택 | 사유 |
|------|------|:---:|------|
| 위치 | (a) module top / (b) main() 진입 / (c) print site 별 wrapping | **(b)** | entrypoint만 영향 — 모듈 import 시 부작용 0 |
| 대상 stream | stdout only / **stdout+stderr** | **stdout+stderr** | line 137/143/148/173 stderr emoji 다수 (🔍✅❌) |
| errors fallback | 'strict' / 'replace' / 'backslashreplace' | **'replace'** | encode 불가 문자 → '?' fallback. 다른 출력 차단 회피 |
| reconfigure 부재 처리 | (a) raise / (b) **silent skip** | **(b)** | Python 3.7+ stdlib 표준이므로 사실상 항상 존재. 방어적 hasattr 검사 |
| 예외 catch | 단일 except / **3종 (AttributeError + ValueError + OSError)** | **3종** | reconfigure spec error 가능 — 안전 fallback |
| Linux/macOS 영향 | 0 / verify | **0** (no-op) | 이미 UTF-8이라면 reconfigure no-op |

### R3 — 검증 시나리오

| Case | 환경 | 기대 결과 |
|------|------|:---:|
| Windows cp949 + emoji print | reconfigure 후 | ✅ 정상 출력 |
| Linux UTF-8 + emoji | reconfigure 후 (no-op) | ✅ 정상 |
| Windows UTF-8 (`PYTHONIOENCODING=utf-8`) | reconfigure 후 (no-op) | ✅ 정상 |
| reconfigure 미지원 환경 (드물게) | hasattr=False → silent skip | ⚠️ 기존 cp949 동작 (회귀 0) |
| `errors='replace'` 발동 (BMP 외 codepoint 인코딩 불가) | '?' fallback | ⚠️ 표시 깨짐, 실행 계속 |

## 3. 변경 대상

### 수정 (1)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py` | S1c | R1 — `main()` 진입 직후 stdout/stderr UTF-8 reconfigure (~7 lines: comment 1 + for loop 6) |

### 신규 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.18d-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.18d-.../REPORT.md` | meta | Stage D 종료 |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 (R1~R3 + 6 결정 매트릭스)
- [ ] **사용자 진입 확인**
- [ ] Stage A — score_codebase.py `main()` 진입 직후 reconfigure block 추가
- [ ] Stage B — 검증 (Windows cp949 환경에서 emoji 출력 정상화)
- [ ] Stage C — REPORT.md + 본 세션 archive 갱신 (EVIDENCE_DRIVEN_ROADMAP §8)
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `score_codebase.py` `main()` 진입 직후 reconfigure block (~7 lines)
- [ ] stdout + stderr 모두 reconfigure
- [ ] errors='replace' fallback
- [ ] hasattr + try/except 방어 (회귀 0)
- [ ] Stage B Windows 검증: console에 🏆 emoji + AI-Ready 점수 정상 표시
- [ ] 회귀 0: JSON/HTML artifact 생성 path 유지 (reconfigure는 stdout만 영향)
- [ ] artifact 재생성 후 git diff (코드 변경만 — JSON/HTML 변동 0 확인)

## 6. 커밋 전략

```
fix(meta): sessions/meta/v1.18d-scorer-stdout-encoding — Windows cp949 emoji UnicodeEncodeError 차단

- fix: bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py
  (main() 진입 직후 sys.stdout/sys.stderr.reconfigure(UTF-8, errors='replace')
   hasattr + try/except 3종으로 회귀 0 보장)
- update: bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md
  (§8 확정 세션 list: v1.18d 추가)
- add: sessions/meta/v1.18d-scorer-stdout-encoding/{PLAN,REPORT}.md

Root cause: Windows cp949 default stdout encoding이 emoji (🏆🔍✅⭐) 인코딩 불가.
v1.18g2 Stage C에서 직접 관찰 — JSON/HTML 생성 정상이나 console summary fail.

Decision: main() entry reconfigure (R1) — stdout+stderr 둘 다, errors='replace' fallback.
Linux/macOS no-op (이미 UTF-8). 회귀 0.
References: v1.18g2 Stage C terminal output + v1.35 REPORT 다음 후보 §.
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|-----------|---|
| `v1.18d2-multi-script-encoding` | 다른 글로벌 user-skill scripts/*.py에서 동일 evidence 발생 시. 공통 helper module 추출 검토 |
| 다른 globals 차원 fix | 사용자 PowerShell `chcp 65001` 안내 (사전 설정) — README 안내 별 후속 |
