# meta v1.18g-score-codebase-py-split — PLAN

세션 시작: 2026-04-29
직접 선행 세션:
- [`sessions/meta/v1.18c-scorer-package-manifest-na/`](../v1.18c-scorer-package-manifest-na/REPORT.md) — L6 verbatim: "score_codebase.py 자체가 1300+ 줄로 git tracked되며 '파일 크기 ≤500줄' 체크에서 -1점. 향후 score_codebase.py 자체 분할은 별 후속 (v1.18g+ 등 evidence-driven)"
- [`sessions/meta/v1.19-scorer-skill-distribution/`](../v1.19-scorer-skill-distribution/REPORT.md) — `bootstrap/skills/ai-ready-scorer/` source-of-truth 이관. 본 세션은 그 안의 `scripts/score_codebase.py` 재구조화

목적: `bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py` (현 1335줄, single file) → 5 모듈 분할로 자체 AI-Ready 루브릭의 "파일 크기 ≤500줄" 체크 회복. **harness-meta 점수 92→93** (S grade 유지, code_structure 12→13).

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1c(5) `bootstrap/skills/ai-ready-scorer/scripts/{score_codebase.py, utils.py, categories_quality.py, categories_ops.py, html_renderer.py}` = **5/5 meta** (글로벌 user-skill source-of-truth)
- **T1 경로 다수결** — meta scope (S1c) 5/5
- **T2 스펙 vs 값** — 글로벌 user-skill 자산 변경 → 모든 사용자 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.18c-scorer-package-manifest-na/REPORT.md` Lessons L6 (verbatim)**:

> **L6 — v1.19 이관 부수효과 (코드 구조 13→12)**: score_codebase.py 자체가 1300+ 줄로 git tracked되며 "파일 크기 ≤500줄" 체크에서 -1점. 본 세션 변경 무관, v1.19 이관의 자연 결과. 향후 score_codebase.py 자체 분할은 별 후속 (v1.18g+ 등 evidence-driven).

**Source 2 — `sessions/meta/v1.18c-scorer-package-manifest-na/REPORT.md` 다음 후보 (verbatim)**:

> | `v1.18g-score-codebase-py-split` | score_codebase.py 1300+ 줄 분할 (코드 구조 -1 회복). evidence-driven |

**Source 3 — `bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py:387-477` `score_code_structure` 함수 verbatim**:

> ```python
> # 파일 크기 적정 (≤500줄)
> oversized = [f for f in tracked if f.suffix in code_exts and f.is_file() and count_lines(f) > 500]
> ```

**Parsed sub-items (4)**:

1. **score_codebase.py 5 모듈 분할** — main entrypoint (~155줄) + utils (~280줄) + categories_quality (~370줄) + categories_ops (~265줄) + html_renderer (~280줄). 모두 ≤500줄 책임 명확
2. **절대 import (같은 디렉토리)** — `from utils import ...` 형식. 패키지화(`__init__.py`) 회피 (script invocation 호환 유지)
3. **외부 invocation API 불변** — `python score_codebase.py <repo_path>` 그대로
4. **Self-test** — harness-meta 자체 점수 92 → 93 (code_structure 12→13, "파일 크기 적정" 3/3 → 만점)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 패키지화 (`__init__.py` + `python -m ai_ready_scorer`) | 별 후속 evidence-driven (현 SKILL invocation `python script.py` 패턴 유지) |
| `generate_html()` 단일 함수 (278줄) 추가 분할 (template 분리) | 본 세션 scope 외 — 자체로 ≤500줄. HTML 템플릿 추출은 별 후속 |
| 7 score_* 카테고리 함수 → 7 파일 분할 | over-engineering. 4+3 그룹화로 충분 (≤500줄 보장) |
| 외부 API 변경 (CLI argv / 출력 형식) | 회귀 위험. 본 세션은 **순수 내부 재구조화** |
| 단위 테스트 추가 | 본 세션 scope 외 — 분할 검증은 baseline scorer 재실행으로 (harness-meta 92→93) |
| ai-ready-scorer SKILL.md 본문 갱신 | invocation API 불변 → 변경 0 |
| `~/.claude/skills/ai-ready-scorer/` symlink 재배포 | install-skills.sh가 디렉토리 symlink → 신규 .py 파일 자동 노출 |
| 컴파일된 `.pyc` 정리 | `__pycache__/` git 무관 (`.gitignore` 처리) |
| score_code_structure 룰 변경 (≤500줄 임계 자체) | 별 후속 — 본 세션은 룰 준수 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 Python 내부 재구조화 (1335줄 단일 파일 → 5 모듈, 같은 디렉토리 절대 import). Anthropic Claude Code spec / bash spec 의존 무. Python import semantics는 PEP 8 / docs.python.org 표준 (`sys.path[0] = script dir`)으로 안정 — v1.28 매트릭스 4 source 매칭 0 + §4-2 비등재 조건 충족 (Python 단발 인용 + harness-meta 내 재인용 가능성 0~1회) |
| **re-verify** | N/A |

## 1. 문제 (1335줄 → 자기 룰 위반)

### 현재 상태

`bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py`:
- **1335줄 단일 파일**
- 구조: imports (28) + 등급/메타 (18) + dataclasses (44) + utils (188) + 7 카테고리 score_* (632) + roi (22) + html_renderer (278) + run_audit/main (113)

### Self-violation

scorer 자체 룰 (`score_code_structure` 함수 387~477줄):

```python
# 파일 크기 적정 (≤500줄)
oversized = [f for f in tracked if f.suffix in code_exts and f.is_file() and count_lines(f) > 500]
```

→ score_codebase.py 자체가 oversized 목록에 포함 → harness-meta 점수 -1.

### Baseline 측정 (2026-04-29)

```
Total: 92.0/100 grade=S
code_structure: 12/15
  ✓ 소스/테스트 디렉토리 분리: 3/3
  ⚠ 파일 크기 적정 (≤500줄): 2/3 ← -1 (score_codebase.py 1335줄)
  ✓ 설정 분리: 3/3
  ✓ 패키지 매니페스트: 3/3
  ✓ 루트 평탄화 방지: 1/1
```

### Root cause

v1.19 이관 시 (`~/.claude/skills/` → `bootstrap/skills/`) 단일 파일 그대로 git tracked → 자기 룰 자가 위반. v1.18b/c는 콘텐츠 변경(57 line diff + N/A 분기)에 집중, 분할은 evidence-driven 보류 (v1.18c L6).

본 세션 **임계 충족**: harness-meta 자체 점수 측정 = direct evidence.

## 2. 결정 (R1 ~ R3)

### R1 — 5 모듈 분할 구조 (디테일 분석 D1~D10 반영)

같은 디렉토리 (`bootstrap/skills/ai-ready-scorer/scripts/`) 내 평탄 배치. **dataclasses는 utils.py로 이관** (D1 — circular import 회피, utils가 shared module):

| Module | Lines (예상) | Content |
|--------|-------------|---------|
| `score_codebase.py` (main entrypoint) | ~115 | imports + CATEGORY_META + run_audit + main |
| `utils.py` (shared types + helpers) | ~340 | dataclasses (Check/CategoryResult/AuditReport) + GRADE_MAP + grade + pct + 13 helpers |
| `categories_quality.py` | ~370 | score_documentation (73) + score_code_structure (91) + score_type_safety (84) + score_test_quality (119) — 정적 품질 4종 |
| `categories_ops.py` | ~265 | score_context_layer (60) + score_automation (113) + score_agentic_safety (69) + compute_roi_actions (22) — 운영 3종 + ROI |
| `html_renderer.py` | ~280 | generate_html (278줄 단일 함수, dict 기반 — dataclass 미참조) |

**모두 ≤500줄** + **acyclic dependency** (`utils ← {quality, ops, renderer} ← main`).

**Per-module imports**:

```python
# score_codebase.py
from utils import GRADE_MAP, grade, pct, Check, CategoryResult, AuditReport, git_tracked_files, detect_language, git_branch
from categories_quality import score_documentation, score_code_structure, score_type_safety, score_test_quality
from categories_ops import score_context_layer, score_automation, score_agentic_safety, compute_roi_actions
from html_renderer import generate_html

# categories_quality.py
from utils import Check, file_exists_any, count_lines, count_docstrings_python, python_type_hint_ratio, file_content, is_shell_markdown_only_repo

# categories_ops.py
from utils import Check, CategoryResult, file_exists_any, count_lines, file_content, has_secret_pattern

# html_renderer.py — stdlib only (json, html, pathlib.Path)
# utils.py — stdlib only
```

**의존 그래프 (D2)**: `utils → {categories_quality, categories_ops, html_renderer} → score_codebase` 단방향 → CIRCULAR import 0 보장.

### R2 — Import 전략: 같은 디렉토리 절대 import

```python
# score_codebase.py (main)
from utils import grade, pct, git_tracked_files, detect_language, ...
from categories_quality import score_documentation, score_code_structure, score_type_safety, score_test_quality
from categories_ops import score_context_layer, score_automation, score_agentic_safety, compute_roi_actions
from html_renderer import generate_html
```

**근거**:
- Python `python <path>/score_codebase.py` 실행 시 `<path>` (script dir)이 `sys.path[0]`에 자동 추가 → 같은 디렉토리 모듈 절대 import 가능
- 패키지화 (`__init__.py` + relative import) 회피 — invocation 호환 (현 SKILL.md `python3 score_codebase.py` 그대로)
- circular import 회피 — main이 다른 모듈을 import만 하고, 다른 모듈은 main을 import 안 함 (단방향)
- `categories_quality.py` / `categories_ops.py`는 utils import 가능 (utility 단방향)
- `html_renderer.py`는 main의 dataclass 타입 힌트 필요? — 함수 signature `report: dict, output_path: Path` → dict 사용으로 dataclass 의존 없음 ✓

### R3 — Invocation API 불변

```bash
# 변경 없음
python ~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py <repo_path>
python ~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py <repo_path> --gate 70
python ~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py <repo_path> --json-only
```

argv / exit code / 출력 (JSON + HTML + stdout) 100% 동일.

## 3. 변경 대상 (1 수정 + 4 신규 + 2 신규 세션)

### 수정 (1)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py` | S1c | 1335줄 → ~155줄 (entry point + dataclass + main + run_audit). 14 utils + 7 score_* + roi + html → 4 신규 모듈로 이관 |

### 신규 (4)

| 경로 | scope | 역할 |
|------|------|------|
| `bootstrap/skills/ai-ready-scorer/scripts/utils.py` | S1c | 14 utility 함수 |
| `bootstrap/skills/ai-ready-scorer/scripts/categories_quality.py` | S1c | 정적 품질 카테고리 4종 score_* |
| `bootstrap/skills/ai-ready-scorer/scripts/categories_ops.py` | S1c | 운영 카테고리 3종 + compute_roi_actions |
| `bootstrap/skills/ai-ready-scorer/scripts/html_renderer.py` | S1c | generate_html |

### 신규 세션 (2)

| 경로 | scope |
|------|------|
| `sessions/meta/v1.18g-score-codebase-py-split/PLAN.md` | meta |
| `sessions/meta/v1.18g-score-codebase-py-split/REPORT.md` | meta |

### 변경 안 하는 파일 (회귀 0 보장)

| 경로 | 이유 |
|------|------|
| `bootstrap/skills/ai-ready-scorer/SKILL.md` | invocation API 불변 |
| `bootstrap/docs/SKILLS.md` | path 참조만, internal 변경 무관 |
| `install-skills.sh` / `install-skills.ps1` | 디렉토리 symlink — 신규 .py 자동 노출 |
| `tests/smoke-skills-install.sh` | SKILL.md 정합 검사만, 내부 .py 무관 |
| `verify.{ps1,sh}` | scorer 검증 0 |
| 모든 다른 smoke 8건 | scorer 무관 |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 + 4 § 의무 + Baseline 측정 (92/100, code_structure 12/15)
- [ ] **사용자 PLAN 확인**
- [ ] Stage A — `harness-plan-verify` SKILL 호출 → Spec verification § 채움
- [ ] Stage B — `utils.py` 신규 (14 함수 이관)
- [ ] Stage C — `categories_quality.py` 신규 (4 score_* 이관)
- [ ] Stage D — `categories_ops.py` 신규 (3 score_* + roi 이관)
- [ ] Stage E — `html_renderer.py` 신규 (generate_html 이관)
- [ ] Stage F — `score_codebase.py` 슬림화 (entrypoint + main만, import 추가)
- [ ] Stage G — Self-test: scorer 재실행 + 점수 92→93 확인 + JSON 동등성
- [ ] Stage H — 회귀 smoke 9건 + verify.ps1 38/38
- [ ] Stage I — REPORT.md
- [ ] **사용자 커밋 확인**

## 5. 성공 기준

### 기능

- [ ] 5 파일 모두 ≤500줄
- [ ] `python score_codebase.py <repo_path>` 정상 실행
- [ ] JSON 출력 schema 변경 0 (baseline JSON과 의미적 동등)
- [ ] HTML 출력 변경 0
- [ ] argv / exit code 동등 (--gate / --json-only / --output-dir)

### Self-test

- [ ] harness-meta 점수 92 → 93 (code_structure 12 → 13)
- [ ] "파일 크기 적정 (≤500줄)" 체크: 2/3 → 3/3 (oversized 0)
- [ ] grade S 유지 (90+)

### 회귀

- [ ] 회귀 smoke 9건 PASS
- [ ] verify.ps1 38/38 PASS

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.18g-score-codebase-py-split — score_codebase.py 5 모듈 분할 (자기 룰 회복)

- update: bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py (1335줄 → ~155줄, entrypoint + main만)
- add: bootstrap/skills/ai-ready-scorer/scripts/utils.py (14 utility, ~280줄)
- add: bootstrap/skills/ai-ready-scorer/scripts/categories_quality.py (정적 품질 4종, ~370줄)
- add: bootstrap/skills/ai-ready-scorer/scripts/categories_ops.py (운영 3종 + ROI, ~265줄)
- add: bootstrap/skills/ai-ready-scorer/scripts/html_renderer.py (generate_html, ~280줄)
- add: sessions/meta/v1.18g-score-codebase-py-split/{PLAN,REPORT}.md

Scope: 글로벌 user-skill 자가 룰 회복. invocation API 불변 (python score_codebase.py <repo>).
- harness-meta 자체 점수 92 → 93 (code_structure 12 → 13, "파일 크기 ≤500줄" 만점)
- 절대 import (같은 디렉토리), 패키지화 회피
- 회귀 smoke 9/9 + verify.ps1 38/38

Baseline measurement (Stage Z): score 92/100, code_structure 12/15, oversized=[score_codebase.py:1335]
After split (Stage G): score 93/100, code_structure 13/15, oversized=[]
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|-----------|---|
| `v1.18h-html-template-extract` | `generate_html` 278줄 → 템플릿 분리. evidence-driven (HTML 변경 빈도 누적 시) |
| `v1.18i-package-promotion` | `__init__.py` + `python -m ai_ready_scorer` 패키지화. evidence-driven (외부 사용자 등장 시) |
| `v1.22-skills-categories` | bootstrap/skills/`<cat>`/`<name>` 2단계. 5+ skill 누적 후 |

## 8. Lessons Forward (예상)

- **L1 — 자기 룰 적용 (dogfood)**: scorer가 자기 자신을 평가. 분할로 자가 위반 해소. AI-Ready 점수 시스템의 self-bootstrap evidence
- **L2 — 같은 디렉토리 절대 import은 script invocation 호환 유지**: `python <path>/script.py` 시 `<path>`가 sys.path[0] → 패키지화 없이 모듈 분리 가능
- **L3 — 책임 그룹화 (4+3 카테고리)** vs 1 함수당 1 파일: 7 카테고리 함수 → 2 파일 (정적/운영) 그룹화로 over-engineering 회피 + ≤500줄 보장
- **L4 — Baseline + after measurement**: harness-meta 자체를 measurable target → 92→93 정량 evidence (가설 0)
