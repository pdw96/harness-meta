# meta v1.48-scorer-linter-na — PLAN

세션 시작: 2026-05-03
선행 세션: [`sessions/meta/v1.47-scorer-config-na/`](../v1.47-scorer-config-na/PLAN.md) — Code Structure "설정 분리" N/A 분기

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1c(1) `bootstrap/skills/audit/ai-ready-scorer/scripts/categories_ops.py` + S1c(1) `references/rubric.md` = **2/2 meta** (PLAN/REPORT 별도)
- **T1 경로 다수결** — S1c 2/2
- **T2 스펙 vs 값** — 글로벌 user-skill 로직 변경 = 모든 사용자 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/ROADMAP.md` §3-E (verbatim)**:

> `v1.46c-scorer-linter-na` | Automation 린터 설정 N/A 분기 신설 (Python/TS 양쪽 — Helper 2 답습 가능)

**Parsed sub-items (3)**:

1. **Python 린터 설정 N/A** — `is_small_typed_lang_repo` (Helper 2) 적용. Python 소스 < 5 → N/A 자동 만점
2. **TypeScript 린터 설정 N/A** — `is_small_typed_lang_repo` (Helper 2) 적용. TS 소스 < 5 → N/A 자동 만점
3. **기타 언어 (else) 린터 설정 N/A** — `na_repo` (Helper 1) 적용. shell/markdown-only repo → N/A; Go/Rust/Java → 기존 "부분 점수" 유지

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| Go/Rust/Java 린터 감지 실제 구현 (golangci-lint / clippy / checkstyle) | 후속 미정 (evidence-driven) |
| CI/CD / Pre-commit / Makefile N/A 분기 | 후속 미정 |
| `v1.18e-scorer-html-na-ui` HTML 대시보드 N/A 카드 시각화 | 별 도메인 (§3-E) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 내부 scorer 로직 변경 (외부 spec 의존 무) |
| **re-verify** | N/A |

## 배경

`score_automation()` 린터 설정 체크 현황:

- `lang == "Python"` → ruff/flake8/pylint 파일 탐색. 설정 없으면 0점 (실패)
- `lang == "TypeScript"` → ESLint/Biome 탐색. 설정 없으면 0점 (실패)
- `else` → `True, 2, 2, f"{lang} — 부분 점수"` (na=False로 항상 통과하되 N/A 미표시)

harness-meta (`lang="Md"`) 현재: `린터 설정 score=2/2 na=False detail="Md — 부분 점수"` → 점수는 옳지만 N/A 플래그 없어 시각적 구분 불가.

`na_repo = is_shell_markdown_only_repo(...)` 계산이 현재 Makefile 체크 *이후* (line 170)에 있어 린터 체크에서 활용 불가 → 상단으로 이동 필요 (v1.47 패턴 답습).

rubric.md §N/A 정책 적용 체크 표 line 211: "예: Automation 린터 설정" — 본 세션이 이 evidence를 이행.

## 목표

- [ ] `categories_ops.py` import에 `is_small_typed_lang_repo` 추가
- [ ] `score_automation()` 상단에 `na_repo` 계산 이동
- [ ] Python 린터 분기: `is_small_typed_lang_repo` → N/A
- [ ] TypeScript 린터 분기: `is_small_typed_lang_repo` → N/A
- [ ] else 린터 분기: `na_repo` → N/A; 아니면 "부분 점수" 유지
- [ ] `rubric.md` §적용 체크 22→25건 + §린터 설정 N/A 주석 갱신
- [ ] 4 case 동적 시뮬레이션 PASS
- [ ] harness-meta 93/100 변동 0 (회귀 0)

## 변경 대상

| 파일 | 변경 |
|------|------|
| `bootstrap/skills/audit/ai-ready-scorer/scripts/categories_ops.py` | import 추가 + na_repo 상단 이동 + 린터 N/A 분기 3건 |
| `bootstrap/skills/audit/ai-ready-scorer/references/rubric.md` | §적용 체크 22→25건 + 린터 설정 행 N/A 주석 |

## 성공 기준

- [ ] Python 소스 < 5 → 린터 N/A 만점 (Python branch)
- [ ] TS 소스 < 5 → 린터 N/A 만점 (TypeScript branch)
- [ ] shell/markdown-only (`na_repo=True`) → 린터 N/A 만점 (else branch)
- [ ] Go 등 build lang → "부분 점수" 유지 (else branch, `na_repo=False`)
- [ ] rubric.md §N/A 적용 체크 25건
- [ ] harness-meta 93/100 S 변동 0 (회귀 0)

## 커밋 전략

```
feat(meta): v1.48-scorer-linter-na — Automation 린터 설정 N/A 분기 신설 (Helper 1+2)
```
