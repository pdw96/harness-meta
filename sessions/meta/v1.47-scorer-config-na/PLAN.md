# meta v1.47-scorer-config-na — PLAN

세션 시작: 2026-05-01
직접 선행 세션: [`sessions/meta/v1.46-scorer-test-borderline-na/`](../v1.46-scorer-test-borderline-na/)

목적: `score_code_structure()` "설정 분리 (config/settings)" sub-check에 N/A 분기 신설 — shell/markdown-only repo에서 설정 파일 부재 시 false negative 감점 방지.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1c×2 (`bootstrap/skills/audit/ai-ready-scorer/scripts/categories_quality.py` + `references/rubric.md`) = 2/2 meta
- **T1 경로 다수결** — S1c 글로벌 user-skill 2/2
- **T2 스펙 vs 값** — N/A 분기 로직 = 루브릭 규칙 변경 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.46-scorer-test-borderline-na/PLAN.md` Out of scope 표** (verbatim):

> | `score_code_structure` 설정 분리 (config/settings) N/A | evidence-driven 후속 (v1.46b+) |

**Parsed sub-items (1)**:

1. **`설정 분리 (config/settings)` N/A 분기** — `score_code_structure()` 내 해당 sub-check에 N/A 분기 신설 (evidence-driven 후속 조건 충족)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| Automation 린터 설정 N/A 분기 (`v1.46c`) | v1.48 또는 후속 세션 |
| Code Structure 다른 sub-check (소스/테스트 분리, 파일 크기, 루트 평탄화) N/A | evidence-driven 후속 |
| rubric.md 45번 행 이외 구조 변경 | 본 세션 scope 외 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 내부 Python 로직 + rubric.md 문서 수정만. 외부 spec 의존 무 |
| **re-verify** | N/A |

## 배경

v1.43~v1.46에서 Type Safety / Test Quality / Documentation 카테고리에 N/A 분기를 체계적으로 도입했다. Code Structure 카테고리의 "설정 분리 (config/settings)" sub-check는 shell/markdown-only repo에서 여전히 false negative가 발생한다.

harness-meta 자체는 `.env.example`이 있어 이미 3/3을 받고 있지만, 다른 shell/markdown-only repo (예: 순수 bash 도구, markdown 문서 repo)는 설정 파일이 없어 0/3을 받는다. 이는 실제로 설정 중앙화가 필요 없는 repo에 대한 false negative다.

"패키지 매니페스트" sub-check (v1.18c)에서 이미 동일 패턴이 적용됐다 — `is_shell_markdown_only_repo` 조건 + N/A auto-pass.

## 변경 대상

| 파일 | 변경 내용 |
|------|---------|
| `bootstrap/skills/audit/ai-ready-scorer/scripts/categories_quality.py` | `score_code_structure()` 함수 상단에 `na_repo` 변수 추출 + "설정 분리 (config/settings)" 및 "패키지 매니페스트" 양쪽 `is_shell_markdown_only_repo` 직접 호출 → `na_repo` 참조로 통일. "설정 분리" if-else N/A 분기 신설 |
| `bootstrap/skills/audit/ai-ready-scorer/references/rubric.md` | 46번 행: "(shell-only repo는 N/A 자동 만점 — § N/A 정책 참조)" 추가 + N/A 적용 체크 표에 행 추가 (21→22건) |

## 목표

- [ ] `categories_quality.py` — N/A 분기 추가 (Helper 1 패턴 답습)
- [ ] `rubric.md` — 두 곳 갱신 (인라인 설명 + N/A 적용 체크 표 22건)
- [ ] 동적 시뮬레이션 3 case PASS
  - Case A: config 부재 + shell/markdown-only → N/A 자동 만점 (3/3, na=True)
  - Case B: config 부재 + 일반 Python repo → regular fail (0/3, na=False)
  - Case C: config 존재 → regular pass (3/3, na=False) — harness-meta 해당
- [ ] harness-meta 재채점: 93/100 S 변동 0 (회귀 0)

## 성공 기준

- [ ] `categories_quality.py` 168~179줄 N/A 분기 삽입 확인
- [ ] `rubric.md` N/A 적용 체크 표 22건 (21→22)
- [ ] 동적 시뮬레이션 3/3 PASS
- [ ] harness-meta `python3 ... score_codebase.py . --json-only` → 93/100 S 변동 0

## 커밋 전략

단일 커밋:

```
feat(meta): v1.47-scorer-config-na — Code Structure 설정 분리 N/A 분기 신설 (Helper 1)
```
