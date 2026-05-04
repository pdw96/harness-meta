# meta v1.69-python-newline-audit — PLAN

세션 시작: 2026-05-04
직접 선행 세션:

- [`sessions/meta/v1.65-fix-v8-separator/`](../v1.65-fix-v8-separator/REPORT.md) — V8 fix Python write에 `newline='\n'` 명시 도입. REPORT "다음 후보 (보류)"에 본 v1.69 trigger 명시
- [`sessions/meta/v1.51-roi-action-bug-fix/`](../v1.51-roi-action-bug-fix/) — ROI 액션 산출 버그 fix (score_codebase.py 직접 수정)
- [`sessions/meta/v1.49-scorer-html-na-ui/`](../v1.49-scorer-html-na-ui/) — html_renderer.py 직접 수정

목적: ai-ready-scorer 실 산출물 (JSON + HTML) Python `write_text(..., encoding="utf-8")`에 `newline="\n"` 추가. Windows에서 Python 텍스트 모드 default CRLF translation 방지 → cross-platform 산출물 일관성 확보.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1c(2) `bootstrap/skills/audit/ai-ready-scorer/scripts/{score_codebase.py, html_renderer.py}` + meta(2) `sessions/meta/v1.69-.../{PLAN,REPORT}.md` + meta(1) `sessions/meta/ROADMAP.md` = 5/5 meta
- **T1 경로 다수결** — meta scope 5/5 (S1c 글로벌 user-skill = 메타 소유)
- **T2 스펙 vs 값** — Python text mode newline 처리 정책 = 모든 플랫폼 산출물 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.65-fix-v8-separator/REPORT.md` "다음 후보 (보류)" § (verbatim)**:

> "smoke/hook Python write CRLF 오염 재발 evidence. `newline='\n'` 일괄 적용"

**Source 2 — `sessions/meta/ROADMAP.md` §3-E `v1.65d-python-newline-audit` row (verbatim)**:

> `v1.65d-python-newline-audit | smoke/hook Python write CRLF 오염 재발 evidence. newline='\n' 일괄 적용 | v1.65 REPORT`

**Source 3 — `sessions/meta/v1.65-fix-v8-separator/REPORT.md` Lessons § (verbatim 인용)**:

> "Python 기본 text write는 Windows에서 CRLF 출력. `open(p, 'w', encoding='utf-8', newline='\n')` 명시로 LF 보존."

**Parsed sub-items (2)**:

1. **score_codebase.py:153 `json_path.write_text` newline 명시** — JSON 산출물 LF 보존
2. **html_renderer.py:314 `output_path.write_text` newline 명시** — HTML 산출물 LF 보존

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `tests/smoke-detect-language.sh` `write_text` 5개소 (51/52/73/74/96) — tempdir fixture | 검증 결과 영향 0 (fixture 콘텐츠는 길이 1줄, CRLF/LF 차이 무관) |
| `tests/smoke-roi-regression.sh` / `smoke-agentic-safety-na.sh` Python | stdout/mock only — 파일 write 없음 |
| `bootstrap/skills/dev-tools/mindvault/SKILL.md:58` Python snippet | SKILL doc (사용자 환경 종속, 본 repo 산출물 아님) |
| `install.ps1` `Set-Content` / `install-skills.ps1` `Set-Content` 3개소 | 별 도메인 (PowerShell, Python 무관) — 별 후속 evidence-driven |
| smoke `--fix` mode 추가 (다른 smoke들에 newline 자동 패치 검사) | 별 후속 (smoke 자가 검증 인프라, 본 세션 scope 외) |
| pathlib `write_text` newline 인자 Python <3.10 호환 fallback | Python 3.10+ 본 repo 표준 (ai-ready-scorer scripts는 Python 3.10+ 가정) |
| `bootstrap/skills/audit/ai-ready-scorer/scripts/utils.py` 등 다른 모듈 write | grep 결과 0건 (현재 write 없음) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | (Python 표준 라이브러리 — Context7 매트릭스 외) |
| **topic** | `pathlib.Path.write_text` `newline` 파라미터 / Python text mode universal newline / CRLF translation 정책 |
| **findings** | see citations below |
| **drift** | no — Python 3.10+ `pathlib.Path.write_text(data, encoding=None, errors=None, newline=None)` 4번째 인자로 newline 지원 (Python docs 공식). `newline='\n'` 명시 시 universal newline translation 비활성화, raw LF write |
| **re-verify** | Python 3.10+ pathlib API breaking change 발생 시 (현재 stable spec) |

**Citations**:

- C1 — `pathlib.Path.write_text(data, encoding=None, errors=None, newline=None)` — Python 3.10+ `newline` 인자 추가 (Source: `https://docs.python.org/3/library/pathlib.html#pathlib.Path.write_text`)
- C2 — Python text mode universal newline default behavior — Windows에서 `\n` → `\r\n` 자동 변환. `newline='\n'`로 비활성화 (Source: `https://docs.python.org/3/library/functions.html#open` newline 파라미터 spec)

## 1. 문제 (CRLF 산출물 잠재 risk)

### 현재 상태

`ai-ready-scorer`의 두 실 산출물:

| 산출물 | 생성 위치 | newline 명시 |
|-------|----------|:------------:|
| `ai-ready-report.json` | `score_codebase.py:153` | ❌ 미명시 → Windows CRLF |
| `ai-ready-dashboard.html` | `html_renderer.py:314` | ❌ 미명시 → Windows CRLF |

### Risk

1. **Cross-platform diff 잡음** — Windows에서 생성한 산출물이 Linux/macOS 사용자와 git diff에서 line ending 차이 발생
2. **CI/CD 회귀 risk** — Linux CI가 Windows 사용자 산출물 검증 시 CRLF/LF 불일치
3. **JSON parser 호환성** — 대부분 호환되나 일부 strict parser는 CRLF 거부
4. **HTML diff 가독성** — git diff에서 HTML 변경분 추적 시 CRLF 노이즈

### 영향 범위

- v1.65 PLAN/REPORT에 evidence 명시 (smoke `--fix` 한정 적용)
- 본 세션은 score_codebase.py + html_renderer.py 양쪽으로 확장 (산출물 직접 영향)
- harness-meta 자체 audit 시 `python score_codebase.py ~/harness-meta`로 ai-ready-report.json 생성 — 본 fix로 LF 일관성 확보

## 2. 결정 (R1)

### R1 — `newline="\n"` 명시 추가

**score_codebase.py:153**:

```python
# Before
json_path.write_text(json.dumps(report_dict, ensure_ascii=False, indent=2), encoding="utf-8")

# After
json_path.write_text(json.dumps(report_dict, ensure_ascii=False, indent=2), encoding="utf-8", newline="\n")
```

**html_renderer.py:314**:

```python
# Before
output_path.write_text(html, encoding="utf-8")

# After
output_path.write_text(html, encoding="utf-8", newline="\n")
```

### Python 3.10+ 호환성 (R1 prerequisite)

`pathlib.Path.write_text`의 `newline` 인자는 **Python 3.10+에서 추가** (PEP 위반 없음, Python 공식 docs 명시). 본 repo는 Python 3.10+ 표준 (`.harness.toml` runtime_version 또는 ai-ready-scorer 자체 가정).

Python <3.10 환경 fallback은 Out of scope (현재 사용자 등장 0).

### 검증 방법

```bash
# Linux 또는 Git Bash on Windows
cd ~/harness-meta
python bootstrap/skills/audit/ai-ready-scorer/scripts/score_codebase.py .

# 산출물 line ending 확인
file ai-ready-report.json     # → "JSON data, ASCII text" (CRLF면 "with CRLF line terminators")
file ai-ready-dashboard.html  # → "HTML document, UTF-8 Unicode text"

# 또는 hexdump로 line ending 직접 확인
hexdump -C ai-ready-report.json | head -2 | grep -E '0d 0a' && echo "CRLF detected" || echo "LF clean"
```

## 3. 변경 대상 (2 수정)

| 경로 | scope | 변경 | 라인 |
|------|------|------|:----:|
| `bootstrap/skills/audit/ai-ready-scorer/scripts/score_codebase.py` | S1c | `write_text(..., newline="\n")` 추가 | 153 |
| `bootstrap/skills/audit/ai-ready-scorer/scripts/html_renderer.py` | S1c | `write_text(..., newline="\n")` 추가 | 314 |

## 4. 목표

- [x] CRLF audit — Python write 호출 grep
- [x] PLAN.md 작성
- [ ] **5 관점 검토** (architecture / spec-drift / scope contract — 3 관점, 변경 ≤5 파일)
- [ ] **사용자 PLAN 확정**
- [ ] Stage A — score_codebase.py:153 newline 추가
- [ ] Stage B — html_renderer.py:314 newline 추가
- [ ] Stage C — 검증 (harness-meta 자체 audit 실행, 산출물 line ending 확인)
- [ ] Stage D — REPORT.md
- [ ] Stage E — `harness-roadmap-update` SKILL invoke (ROADMAP §3-B v1.65d 항목 ✅ 완료 표기 + §8 entry 추가)
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] score_codebase.py:153에 `newline="\n"` 추가됨
- [ ] html_renderer.py:314에 `newline="\n"` 추가됨
- [ ] `python score_codebase.py ~/harness-meta` 실행 → JSON + HTML 산출물 LF 보존 확인 (`hexdump` 또는 `file` 검증)
- [ ] 기존 smoke 21+ 회귀 0 (ai-ready-scorer 자체 smoke가 line ending 검증 없음, 단순 추가만)
- [ ] **회귀 0** — 산출물 콘텐츠 동일 (score 결과 변동 0)

## 6. 커밋 전략

```
fix(meta): sessions/meta/v1.69-python-newline-audit — ai-ready-scorer 산출물 newline='\n' 명시

- update: bootstrap/skills/audit/ai-ready-scorer/scripts/score_codebase.py:153 (JSON write_text newline 추가)
- update: bootstrap/skills/audit/ai-ready-scorer/scripts/html_renderer.py:314 (HTML write_text newline 추가)
- add: sessions/meta/v1.69-.../{PLAN,REPORT}.md
- update: sessions/meta/ROADMAP.md §3-B v1.65d ✅ 완료 + §8 entry

Scope: ai-ready-scorer 실 산출물 (JSON + HTML) Windows CRLF translation 방지.
- pathlib.Path.write_text newline='\n' 명시 (Python 3.10+ 표준 spec)
- v1.65 REPORT trigger 이행 — smoke 단일 파일 fix → scorer 산출물 양쪽 확장

Out of scope:
- smoke-detect-language.sh tempdir fixture (검증 결과 무관)
- install.ps1 Set-Content (별 도메인 PowerShell)
- smoke 자가 검증 (--fix mode 추가) — 별 후속

회귀 0 — 산출물 콘텐츠 동일, line ending만 LF 일관성 확보.
```

## 7. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.69b-smokes-newline-audit` | 다른 smoke (--fix 추가 도입 시) Python write 발견 시 동일 패턴 적용. 현재 evidence 0 |
| `v1.69c-powershell-set-content` | Windows PowerShell `Set-Content` 산출물 newline drift evidence 발생 시 (현재 install.ps1만 사용 — settings.json은 PS default 허용) |
| **`v1.69d-scorer-newline-smoke`** | **산출물 line ending 회귀 방지 smoke 신설 (`tests/smoke-scorer-output-newline.sh`). hexdump CRLF 0건 assertion. evidence: 본 v1.69 fix 회귀 방지 + 미래 scorer 모듈 변경 시 재발 차단** |
| `vX-cross-platform-output-policy` | 모든 산출물 line ending 통일 정책 단일 소스 docs (evidence 누적 후) |

## 8. Lessons Forward (예상)

- **L1 — `newline='\n'` 명시는 cross-platform 산출물 일관성의 1줄 비용** — Python text mode universal newline default가 Windows에서 CRLF → 명시적 LF 보존으로 git diff 잡음 차단
- **L2 — pathlib `write_text` newline 인자는 Python 3.10+ 신규 기능** — open() built-in의 newline 파라미터를 pathlib에 흡수. spec drift 가능성 낮음 (Python 표준 docs anchor)
- **L3 — v1.65 evidence-driven 후속의 정확한 trigger 매칭** — smoke 1 파일 fix → scorer 산출물 2 파일 확장. 동일 root cause (Windows CRLF), 다른 적용 영역
