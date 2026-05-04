# meta v1.18g-score-codebase-py-split — REPORT

세션 종료: 2026-04-29
PLAN: [`PLAN.md`](PLAN.md)

## 최종 결과

| 항목 | 결과 |
|------|------|
| **harness-meta 점수** | **92 → 93** (+1, 정확 회복) — grade=S 유지 |
| **code_structure 점수** | **12 → 13** ("파일 크기 적정 (≤500줄)" 2/3 → 3/3 만점) |
| **모듈 size** | score_codebase 178 / utils 290 / categories_quality 388 / categories_ops 285 / html_renderer 291 — **모두 ≤500줄** |
| **JSON schema** | 변경 0 (동등성 검증 — pre/post total_score 92→93만 차이) |
| **invocation API** | 변경 0 (`python score_codebase.py <repo>` 그대로) |
| **smoke 9건** | 9/9 PASS |
| **verify.ps1** | 38/38 PASS (WARN 0) |
| 변경 파일 | 1 수정 (score_codebase.py 슬림화) + 4 신규 (utils/categories_quality/categories_ops/html_renderer) + PLAN/REPORT |

## 구현 요약

### Stage A — PLAN.md + harness-plan-verify SKILL 호출

PLAN 4 § 의무 + 디테일 분석 10 dimensions (D1 circular import 위험 / D2 acyclic DAG / D3 generate_html dict-only / D8 invocation 불변 / D10 .gitignore 확인). **drift=N/A** — Python 내부 재구조화는 v1.28 매트릭스 4 source 매칭 0 + §4-2 비등재 조건 충족 (단발 인용 + 재인용 가능성 0~1회).

### Stage B — `utils.py` 신규 (290줄)

추출:

- 3 dataclasses (Check / CategoryResult / AuditReport) — **D1 circular import 회피 위해 main → utils로 이관**
- GRADE_MAP 상수
- grade / pct (등급 함수)
- 13 helper 함수 (git_tracked_files / detect_language / file_exists_any / count_lines / file_content / git_branch / is_env_committed / python_type_hint_ratio / count_docstrings_python /_pyproject_runtime_deps_empty / is_shell_markdown_only_repo / has_secret_pattern + 3 module-level constants `_BUILD_LANGS` / `_BUILD_MANIFESTS` / `_BUILD_SOURCE_EXTS`)

stdlib only (ast / re / subprocess / dataclasses / datetime / pathlib / typing).

### Stage C — `categories_quality.py` 신규 (388줄)

4 정적 품질 카테고리 score_* 함수 이관:

- `score_documentation` (73 → 96줄, README/CLAUDE.md/ADR/Docstring/Changelog 5 체크)
- `score_code_structure` (91줄, 디렉토리 분리/파일 크기/Config/매니페스트/평탄화 5 체크 + N/A 분기)
- `score_type_safety` (84줄, Python 4 체크 + TypeScript 3 체크 + 다른 lang fallback)
- `score_test_quality` (119줄, 7 체크 — tests dir / 테스트 수 / 프레임워크 / coverage / 통합 / 비율 / CI)

Imports: `from utils import Check, file_exists_any, count_lines, count_docstrings_python, python_type_hint_ratio, file_content, is_shell_markdown_only_repo` (6 helper).

### Stage D — `categories_ops.py` 신규 (285줄)

3 운영 카테고리 + ROI:

- `score_context_layer` (60줄, CLAUDE.md 품질 + GUARDRAILS + ADR)
- `score_automation` (113줄, CI/Pre-commit/Lint/Make/Docker/Lock 6 체크 + N/A 2건)
- `score_agentic_safety` (69줄, .gitignore/.env/.env.example/secret/Claude perm/guardrail 6 체크)
- `compute_roi_actions` + `EFFORT_HOURS` 상수

Imports: `from utils import Check, CategoryResult, file_content, file_exists_any, has_secret_pattern, is_env_committed, is_shell_markdown_only_repo` (5 helper + 2 dataclass).

### Stage E — `html_renderer.py` 신규 (291줄)

`generate_html` 단일 함수 (278 → 291줄, docstring 추가). dict 기반 렌더링 — Chart.js radar + 카테고리 카드 + ROI 표 + 공통 CSS.

Imports: `from utils import pct` (1 helper, dataclass 미참조). + stdlib (json, pathlib).

### Stage F — `score_codebase.py` 슬림화 (1335 → 178줄, -87%)

남은 책임:

- module docstring (v1.18g 분할 이력 명시)
- imports (3 신규 모듈 + utils + stdlib)
- `CATEGORY_META` 상수 (run_audit iter 순서, 다른 모듈에서 미사용)
- `run_audit()` (53줄, 7 카테고리 iter + ROI + AuditReport 빌드)
- `main()` (58줄, argparse + 출력 + gate 체크)

### Stage G — Self-test (scorer 재실행)

```
Total: 93.0/100 grade=S    ← 이전 92 → 93 (+1)
code_structure: 13/15      ← 이전 12 → 13 (+1)
  ✓ 소스/테스트 디렉토리 분리: 3/3
  ✓ 파일 크기 적정 (≤500줄): 3/3   ← 이전 2/3 → 3/3 (만점 회복)
  ✓ 설정 분리: 3/3
  ✓ 패키지 매니페스트: 3/3
  ✓ 루트 평탄화 방지: 1/1
```

→ **목표 달성 (정량 evidence)**.

### Stage H — 회귀 9 smoke + verify.ps1

| smoke | 결과 |
|-------|------|
| smoke-spec-verification | PASS=43 FAIL=0 SKIP=4 |
| smoke-scope-contract | PASS=58 FAIL=0 (v1.18g +2 self-test) |
| smoke-bash-permission-pattern | 6/6 PASS |
| smoke-thinking-effort | 5/5 PASS |
| smoke-language-overlay | PASS=11 FAIL=0 |
| smoke-legacy-cleanup-overlay | PASS=9 FAIL=0 |
| smoke-skills-install | PASS=9 FAIL=0 |
| smoke-sync-agents | PASS=5 FAIL=0 |
| smoke-verify-sh-parity | 5/5 PASS |
| verify.ps1 | 38/38 PASS (WARN 0) |

### Stage I — 본 REPORT.md 작성

본 § 포함. 메타 v1.27 이전 (v1.18g)이므로 REPORT § 의무 면제 (smoke `LEGACY_REPORTS_META_BEFORE=27`) — 그러나 forward-discipline 차원에서 § 작성.

## 판정

- [x] 세션 디렉토리 생성
- [x] PLAN.md + 4 § 의무 + 10 dimensions 디테일 분석 + Spec verification (drift=N/A)
- [x] Stage B — utils.py 신규 (dataclasses + GRADE_MAP + 15 함수)
- [x] Stage C — categories_quality.py 신규 (4 score_*)
- [x] Stage D — categories_ops.py 신규 (3 score_* + compute_roi)
- [x] Stage E — html_renderer.py 신규 (generate_html)
- [x] Stage F — score_codebase.py 슬림화 (1335 → 178)
- [x] Stage G — Self-test: 92 → 93 정확 회복
- [x] Stage H — 회귀 smoke 9/9 + verify.ps1 38/38
- [x] Stage I — REPORT.md
- [ ] 사용자 커밋 확인 (다음 단계)

### 성공 기준 결과

- [x] 5 파일 모두 ≤500줄 (178/290/388/285/291)
- [x] `python score_codebase.py <repo>` 정상 실행
- [x] JSON 출력 schema 변경 0
- [x] argv / exit code 동등
- [x] **harness-meta 92 → 93** ✓
- [x] **code_structure 12 → 13** ✓
- [x] "파일 크기 적정 (≤500줄)" 2/3 → 3/3 ✓
- [x] grade S 유지 ✓
- [x] 회귀 9 smoke PASS
- [x] verify.ps1 38/38 PASS

## Spec verification (context7)

본 세션은 메타 v1.27 이전 (v1.18g) → REPORT § 의무 면제 (`LEGACY_REPORTS_META_BEFORE=27` per SPEC_VERIFICATION.md §7-4). 그러나 PLAN § (drift=N/A)와의 cross-file 일관성 차원에서 본 § 동일 작성:

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 구현 후도 외부 spec 의존 무 (PLAN § 동등). Python 표준 import semantics만 활용 — 실제 분할 후 모든 import 정상 작동 + scorer 동등성 검증 (92→93 외 schema 변화 0) |
| **re-verify** | N/A |

## Lessons Learned

### L1 — 자기 룰 회복 (dogfood evidence)

scorer가 자신의 룰("≤500줄")을 자가 위반 → 분할로 해소 → 점수 +1 정량 회복. AI-Ready 점수 시스템의 self-bootstrap evidence — 룰 자체의 정합성 검증.

향후 scorer 룰 추가/변경 시 동일 패턴 적용 가능: 룰 추가 → harness-meta self-eval → 위반 발견 시 즉시 fix → 정량 evidence 누적.

### L2 — Circular import 위험은 dataclass 위치로 차단

dataclass(Check/CategoryResult/AuditReport)를 main에 두면 categories_*가 main을 import → main이 categories_*를 import → CIRCULAR. **dataclasses는 shared module(utils.py)로 이관**이 필수 디자인 결정.

대안 (별도 `models.py` 6번째 파일)은 over-engineering — utils.py가 290줄로 ≤500 충족 + 책임 단위 명확 (types + helpers) → 5 파일이 적정.

### L3 — generate_html은 dict-only로 의존성 최소화

`generate_html(report: dict, ...)` — dataclass 미참조 → html_renderer.py가 utils만 의존 (pct 함수). 만약 dataclass 의존 시 추가 import + 결합도 ↑. dict 기반 렌더링이 더 유연.

L4 (forward) — 향후 HTML 템플릿 분리 (v1.18h?) 시에도 dict-based로 유지하면 templating engine 도입 (Jinja2 등) 자연.

### L4 — 책임 그룹화 (4+3) vs 1 함수당 1 파일

7 카테고리 → 7 파일은 over-engineering. 정적/운영 2 그룹 (4+3)으로 ≤500줄 확보 + 의미 있는 분류 (정적 분석 vs 운영 자동화). 미래 카테고리 추가 시 그룹 매트릭스 재고 (현 7 카테고리 안정).

### L5 — invocation API 불변 = sub-version 안전 분할 패턴

`python score_codebase.py <repo>` argv / stdout / exit code / JSON schema 모두 불변 → 외부 사용자 영향 0. install-skills의 디렉토리 symlink가 신규 .py 파일 자동 노출 → 재배포 불필요. 내부 재구조화 정석 패턴.

## 다음 후보 (보류)

| 세션 | 조건 |
|------|------|
| `v1.18h-html-template-extract` | generate_html 291줄 → Jinja2 템플릿 분리. evidence-driven (HTML 변경 빈도 누적 시) |
| `v1.18i-package-promotion` | `__init__.py` + `python -m ai_ready_scorer`. evidence-driven (외부 사용자 등장 시) |
| `v1.18j-rule-add-`<rule>`` | scorer 신규 룰 추가 시 harness-meta self-eval 패턴 재적용 |
| `v1.22-skills-categories` | bootstrap/skills/`<cat>`/`<name>` 2단계. 5+ skill 누적 후 |

## 선행 세션 (cross-link)

- [`sessions/meta/v1.18c-scorer-package-manifest-na/`](../v1.18c-scorer-package-manifest-na/REPORT.md) — L6 verbatim에서 본 세션 trigger (1300+ 줄 -1 evidence)
- [`sessions/meta/v1.19-scorer-skill-distribution/`](../v1.19-scorer-skill-distribution/REPORT.md) — `bootstrap/skills/ai-ready-scorer/` source-of-truth 이관. 본 세션은 그 안의 분할
