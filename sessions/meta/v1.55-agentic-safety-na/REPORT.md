# meta v1.55-agentic-safety-na — REPORT

세션 종료: 2026-05-04
선행 세션: [`v1.54-hook-debug-log/`](../v1.54-hook-debug-log/PLAN.md)

## 최종 결과

| 항목 | 결과 |
|------|------|
| 변경 파일 | 2 수정 (`categories_ops.py` + `rubric.md`) + 1 신규 (`smoke-agentic-safety-na.sh`) |
| 신규 smoke | `tests/smoke-agentic-safety-na.sh` 5/5 PASS |
| 회귀 smoke | smoke-roi-regression 6/6 + smoke-detect-language 6/6 + smoke-scope-contract 130/130 + smoke-spec-verification 342/342 |
| harness-meta 점수 | 93/100 변동 없음 (3 check 모두 PASS → N/A 미진입) |

## 구현 요약

| 목표 | 구현 |
|------|------|
| `score_agentic_safety()` 상단 `na_repo` 추출 | `categories_ops.py:251` `na_repo = is_shell_markdown_only_repo(repo, tracked, lang)` |
| `.env.example` N/A 분기 | `categories_ops.py` `if not env_example and na_repo:` (Helper 1) |
| `Claude Code 권한 설정` N/A 분기 | `categories_ops.py` `if not perm and na_repo:` (Helper 1) |
| `가드레일 파일` N/A 분기 | `categories_ops.py` `if not guard and na_repo:` (Helper 1) |
| `rubric.md` §"적용 체크" 28건 | 25→28건 + 에이전틱 안전 3행 추가 + v1.55 stamp |
| smoke 신규 | 정적 2 (S1 awk 함수 본문 추출 + S2 28건/3행) + 동적 3 (D1/D2/D3 mock repo) |

### 주요 결정

- **Helper 1 단일 사용**: 3 sub-check 모두 `is_shell_markdown_only_repo` (v1.35~v1.48 패턴 답습). `Claude Code 권한 설정`은 추가 조건 (`.claude/` 디렉토리 부재) 검토했으나 단순화 채택 — N/A는 check FAIL 시에만 진입하므로 edge case 영향 미미.
- **`가드레일 파일` 이중 N/A 일관성**: `score_context_layer()` (v1.35)와 `score_agentic_safety()` (본 세션)에서 같은 파일을 다른 카테고리 관점으로 채점. 양쪽 N/A는 의도된 설계 (코드 comment "중복이지만 안전 관점에서 재채점").
- **smoke 인코딩 우회**: Korean check 이름 (`Claude Code 권한 설정` 등)이 Windows cp949 콘솔에서 mangled → Python script가 SLUG 매핑 (`env_example`/`claude_perm`/`guardrails`) ASCII 식별자 출력 + `sys.stdout.reconfigure(encoding='utf-8')` 양쪽.

### 동적 시뮬레이션 결과

| Case | repo 특성 | env_example | claude_perm | guardrails | 기대 vs 실제 |
|------|---------|:---:|:---:|:---:|------|
| D1 | shell-only, no 3 files | NA 2/2 | NA 2/2 | NA 1/1 | ✓ 3 N/A |
| D2 | shell-only, all 3 files | PASS 2/2 | PASS 2/2 | PASS 1/1 | ✓ 3 PASS |
| D3 | Python, no 3 files | FAIL 0/2 | FAIL 0/2 | FAIL 0/1 | ✓ 3 FAIL |
| C4 | harness-meta 자체 | PASS 2/2 | PASS 2/2 | PASS 1/1 | ✓ 93/100 유지 |
| C5 | shell-only + .env.example만 | PASS 2/2 | NA 2/2 | NA 1/1 | ✓ 1 PASS + 2 N/A |

## 판정

- [x] `categories_ops.py` `score_agentic_safety()`: `na_repo` 추출 + 3 sub-check N/A 분기 ✓
- [x] `rubric.md` §"적용 체크" 표: 25 → 28건 ✓
- [x] `smoke-agentic-safety-na.sh` 5/5 PASS ✓
- [x] **harness-meta 93/100 변동 없음** ✓
- [x] **회귀 0** ✓

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 내부 scoring logic 변경만 (외부 spec 의존 무) |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — Windows cp949 콘솔 ↔ UTF-8 Korean 충돌은 Python sys.stdout.reconfigure() + ASCII slug 양쪽으로 차단**. 단일 차단(reconfigure만)은 shell pipe (grep)에서 다시 cp949로 변환되며 원복. ASCII slug 매핑이 portable.
- **L2 — `score_agentic_safety()` 만 N/A 분기 부재였던 이유**: 보안 카테고리는 "모든 repo가 고려해야 할 baseline"이라는 직관 때문. 그러나 *check FAIL 시에만 N/A 진입*이라는 N/A 메커니즘 본질은 보안 카테고리에서도 유효 — shell/markdown-only repo는 `.env.example`/Claude Code 설정/`GUARDRAILS.md`가 본질적으로 부적합.
- **L3 — awk range pattern `/start/,/end/` 함정**: `/^def score_agentic_safety/,/^def [a-z_]/` 패턴에서 `^def [a-z_]`가 시작 라인도 매치 → 1줄만 추출. 해결: `awk '/^def score_agentic_safety/{f=1; next} f && /^def /{exit} f'` (flag 패턴).

## 다음 후보 (보류)

| 후속 세션 | Trigger 종류 | 조건 |
|---------|:----------:|------|
| `v1.18h-category-max-recalibration` | B (회귀) | CATEGORY_META cat_max(15) ≠ check_sum_max(13) for documentation/code_structure/automation. 본 세션에서 측정 evidence 명확화 |
| `v1.56-quality-file-split` | B (회귀) | `categories_quality.py` 545줄 > 500줄 → 파일 크기 체크 2/3 (1pt 손실). 분할 시 harness-meta 93→94 |
