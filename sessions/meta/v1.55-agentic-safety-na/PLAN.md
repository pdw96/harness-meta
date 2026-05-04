# meta v1.55-agentic-safety-na — PLAN

세션 시작: 2026-05-04
직접 선행 세션: [`sessions/meta/v1.54-hook-debug-log/`](../v1.54-hook-debug-log/PLAN.md) — PostToolUse hook R1/R2 디버그 로그 강화

목적: `score_agentic_safety()` 3 sub-check(`.env.example` / `Claude Code 권한 설정` / `가드레일 파일`)에 **Helper 1** (`is_shell_markdown_only_repo`) 기반 N/A 분기 추가. shell/markdown-only repo가 에이전틱 안전 체크에서 false negative 감점을 받지 않도록 한다. v1.43~v1.51 N/A 확장 시리즈 연속.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1c(1) `bootstrap/skills/audit/ai-ready-scorer/scripts/categories_ops.py` + S1c(1) `references/rubric.md` + S3(1) `tests/` smoke = **3/3 meta** (S1c 글로벌 user-skill source)
- **T1 경로 다수결** — meta scope 3/3

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/ROADMAP.md` §"다음 후보 (활성)" 0건 → 사용자 발의 (verbatim)**:

> "scorer 개선" → "에이전틱 안전 N/A" (2026-05-04 선택)

**Parsed sub-items (3)**:

1. **`.env.example` N/A** — shell/markdown-only repo → env 파일 불필요 → N/A 자동 만점
2. **`Claude Code 권한 설정` N/A** — shell/markdown-only repo → `.claude/settings.json` 불필요 → N/A 자동 만점
3. **`가드레일 파일` N/A** — shell/markdown-only repo → GUARDRAILS.md 불필요 → N/A 자동 만점

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `.gitignore 존재` N/A | 모든 repo에 적용 가능 — N/A 부적합 |
| `.env 미커밋` N/A | 보안 필수 체크 — N/A 없음 |
| `하드코딩 비밀 없음` N/A | 보안 필수 체크 — N/A 없음 |
| CATEGORY_META 불일치 해소 (v1.18h) | 후속 evidence-driven (별 세션) |
| `categories_quality.py` 분할 | 리팩토링 — 후속 별 세션 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 내부 scoring logic 변경만 (외부 spec 의존 무) |
| **re-verify** | N/A |

## 1. 문제

### 현재 상태

`score_agentic_safety()` 6 sub-check 중 N/A 분기가 0건. 다른 카테고리들(v1.35~v1.48)이 N/A를 적용한 것과 달리 에이전틱 안전 카테고리만 예외.

**false negative 사례**:

- GitHub Actions workflow collection (shell/yaml only) → `.env.example` 2pts, `.claude/settings.json` 2pts, `GUARDRAILS.md` 1pt 감점
- 순수 shell 유틸리티 repo → 동상

harness-meta는 모두 PASS하므로 점수 변화 없음. 다른 shell/markdown repo 감사 시 false negative 방지 효과.

### N/A 조건 선택

**Helper 1** (`is_shell_markdown_only_repo`) — 기존 pattern 동일 (v1.35~v1.48 precedent). 4 조건 AND:

1. lang ∉ {Python, TypeScript, JavaScript, Go, Rust, Java, Kotlin, C#, Ruby, Swift}
2. 빌드 매니페스트 부재
3. pyproject.toml 부재 OR runtime deps 비어있음
4. 빌드 소스 파일 count < 10 OR 비율 < 10%

**check별 N/A 적용 논리**:

| check | N/A 근거 |
|-------|---------|
| `.env.example` | shell repo는 런타임 env var 설정 템플릿 불필요 |
| `Claude Code 권한 설정` | shell repo가 Claude Code `.claude/settings.json` 없이 운영됨 (설정 없으면 N/A) |
| `가드레일 파일` | 컨텍스트 레이어 GUARDRAILS.md (v1.35 N/A precedent) 동등 처리 |

**harness-meta 영향 없음 근거**: 3 check 모두 PASS → N/A 분기 진입 불가 → 93/100 유지.

## 2. 결정 (R1 ~ R3)

### R1 — `.env.example` N/A (Helper 1)

```python
# before (현행)
env_example, fname = file_exists_any(repo, [".env.example", ".env.sample", "env.example"])
checks.append(Check(
    ".env.example",
    env_example, 2 if env_example else 0, 2,
    ...
))

# after
env_example, fname = file_exists_any(repo, [".env.example", ".env.sample", "env.example"])
if not env_example and na_repo:                      # ← 추가
    checks.append(Check(                             # N/A 분기
        ".env.example",
        passed=True, score=2, max_score=2,
        detail="N/A — shell/markdown-only repo (env 파일 불필요, 자동 만점)",
        action=None, roi_effort="즉시", roi_impact=0.0, na=True,
    ))
else:
    checks.append(Check(".env.example", env_example, 2 if env_example else 0, 2, ...))
```

### R2 — `Claude Code 권한 설정` N/A (Helper 1)

```python
# before
perm, fname = file_exists_any(repo, [".claude/settings.json", ".claude/settings.local.json"])
checks.append(Check("Claude Code 권한 설정", perm, 2 if perm else 0, 2, ...))

# after
perm, fname = file_exists_any(repo, [".claude/settings.json", ".claude/settings.local.json"])
if not perm and na_repo:                             # ← 추가
    checks.append(Check(
        "Claude Code 권한 설정",
        passed=True, score=2, max_score=2,
        detail="N/A — shell/markdown-only repo (Claude Code 설정 불필요, 자동 만점)",
        action=None, roi_effort="즉시", roi_impact=0.0, na=True,
    ))
else:
    checks.append(Check("Claude Code 권한 설정", perm, 2 if perm else 0, 2, ...))
```

### R3 — `가드레일 파일` N/A (Helper 1)

```python
# before
guard, fname = file_exists_any(repo, ["docs/GUARDRAILS.md", "GUARDRAILS.md"])
checks.append(Check("가드레일 파일", guard, 1 if guard else 0, 1, ...))

# after
guard, fname = file_exists_any(repo, ["docs/GUARDRAILS.md", "GUARDRAILS.md"])
if not guard and na_repo:                            # ← 추가
    checks.append(Check(
        "가드레일 파일",
        passed=True, score=1, max_score=1,
        detail="N/A — shell/markdown-only repo (가드레일 불필요, 자동 만점)",
        action=None, roi_effort="즉시", roi_impact=0.0, na=True,
    ))
else:
    checks.append(Check("가드레일 파일", guard, 1 if guard else 0, 1, ...))
```

**`na_repo` 추출 위치**: `score_agentic_safety()` 함수 상단에 `na_repo = is_shell_markdown_only_repo(repo, tracked, lang)` 1줄 추가 (다른 category 함수들과 동일 패턴).

## 3. 변경 대상

### 수정 (2)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/skills/audit/ai-ready-scorer/scripts/categories_ops.py` | S1c | R1/R2/R3 — `score_agentic_safety()` 상단 `na_repo` 추출 + 3 sub-check N/A 분기 |
| `bootstrap/skills/audit/ai-ready-scorer/references/rubric.md` | S1c | 에이전틱 안전 표 3 항목에 N/A 주석 + §"적용 체크" 표 3행 추가 (25→28건) |

### 신규 (1)

| 경로 | scope | 역할 |
|------|------|------|
| `tests/smoke-agentic-safety-na.sh` | S3 | 정적 2 + dynamic 3 = 5 checks |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [ ] **사용자 진입 확인**
- [ ] Stage A — `categories_ops.py` N/A 분기 3건 구현
- [ ] Stage B — `rubric.md` 표 갱신 (3행 N/A 주석 + §"적용 체크" 3행)
- [ ] Stage C — `tests/smoke-agentic-safety-na.sh` (정적 2 + dynamic 3 = 5 checks)
- [ ] Stage D — `REPORT.md` + ROADMAP 갱신

## 5. 성공 기준

- [ ] `categories_ops.py` `score_agentic_safety()`: `na_repo` 추출 + 3 sub-check N/A 분기
- [ ] `rubric.md` §"적용 체크" 표: 25 → 28건
- [ ] `smoke-agentic-safety-na.sh` 5/5 PASS
- [ ] **harness-meta 93/100 변동 없음** (모두 PASS라 N/A 미진입)
- [ ] **회귀 0** — 기존 모든 smoke 통과

## 6. 동적 시뮬레이션 (5 case)

| Case | repo 특성 | `.env.example` | `Claude Code 권한 설정` | `가드레일 파일` | 기대 결과 |
|------|---------|:---:|:---:|:---:|------|
| 1 | shell-only, 3 파일 없음 | ❌ | ❌ | ❌ | 셋 모두 N/A=perfect |
| 2 | shell-only, 3 파일 있음 | ✅ | ✅ | ✅ | 셋 모두 PASS (N/A 미진입) |
| 3 | Python≥5, .env.example 없음 | ❌ | — | — | `.env.example` FAIL (N/A 아님) |
| 4 | harness-meta 동등 | ✅ | ✅ | ✅ | 93/100 변동 없음 |
| 5 | shell-only, .env.example만 있음 | ✅ | ❌ | ❌ | .env.example PASS + 나머지 N/A |

## 7. 후속 분기

| 후속 세션 | 조건 |
|---------|------|
| `v1.18h-category-max-recalibration` | CATEGORY_META mismatch evidence (§3-B 기존 등록) |
| `v1.56-quality-file-split` | `categories_quality.py` 545줄 분할 evidence (파일 크기 체크 2/3 → 3/3) |
