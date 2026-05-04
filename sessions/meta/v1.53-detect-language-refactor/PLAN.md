# meta v1.53-detect-language-refactor — PLAN

세션 시작: 2026-05-04
직접 선행 세션:

- [`sessions/meta/v1.35-scorer-other-na-categories/`](../v1.35-scorer-other-na-categories/PLAN.md) — L8 "detect_language dict ordering 의존 부정확성" 부수 발견 (v1.36d 후속 트리거 원점)
- [`sessions/meta/v1.18-ai-ready-scorer-shell-fix/`](../v1.18-ai-ready-scorer-shell-fix/PLAN.md) — L3 "타입 안전성 역설 구조" 최초 명시

목적: `detect_language()`의 dict ordering 의존 제거 — 동일 확장자 개수 tie 발생 시 file traversal 순서에 따라 언어가 달라지는 비결정적 동작을 우선순위 기반 tie-breaking으로 수정. `is_shell_markdown_only_repo()` 조건 #1 재구조화로 tiny Python 레포 N/A 보호 유지. 타입 안전성 역설 구조 해소의 **prerequisite**.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1c(1) `bootstrap/skills/audit/ai-ready-scorer/scripts/utils.py` + S3(1) `tests/smoke-detect-language.sh` (신규)
- T1 경로 다수결 — 2/2 모두 meta scope (S1c 글로벌 user-skill + S3 repo 정책)
- T2 스펙 vs 값 — 언어 감지 알고리즘 변경 = 모든 scorer 사용에 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.35-scorer-other-na-categories/REPORT.md` L8 (verbatim)**:

> "detect_language의 dict ordering 의존 부정확성 (Stage E 시뮬레이션 부수 발견): "작은 Python script" fixture (.py 1 + .toml 1)에서 lang="Toml" 판정. PLAN R5 표 예측 (Python+helper=False)과 다름. 결과는 의도된 N/A 진입 정합 (작은 repo)이지만 lang detection 정확도 자체는 별 문제. 별 후속 evidence-driven (v1.36+ detect_language refactor)."

**Source 2 — `sessions/meta/ROADMAP.md` §3-D (verbatim)**:

> "`v1.36d-detect-language-refactor` | D | dict ordering 의존 제거 — "타입 안전성 역설 구조 해소" prerequisite | `v1.18 REPORT`, `v1.35 REPORT L8`"

**Source 3 — `sessions/meta/v1.18-ai-ready-scorer-shell-fix/REPORT.md` L3 (verbatim)**:

> "스코어러 언어 감지 역설: `.md` 156개 dominant → `lang="Md"` → 타입 안전성·테스트 프레임워크 체크가 전부 "skip (부분 점수)"로 만점 처리. 언어 감지를 정확히 "Shell"로 바꾸면 오히려 점수가 떨어질 수 있는 역설 구조. 현행 유지."

**Parsed sub-items (3)**:

1. **dict ordering 의존 제거** — `max(exts, key=...)` tie에서 file traversal 순서 의존 → priority 기반 결정론적 tie-breaking으로 수정
2. **tiny Python 레포 N/A 보호 유지** — 수정 전 lang="Toml"(misdetect) → `is_shell_markdown_only_repo` True였던 tiny 레포가, 수정 후 lang="Python" → False 회귀 방지
3. **타입 안전성 역설 구조 해소 prerequisite** — 본 세션은 준비 단계; 실제 역설 해소(harness-meta Shell 정확 감지)는 후속

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 타입 안전성 역설 구조 실제 해소 (harness-meta `.sh` > `.md` 우선 감지) | 후속 세션 (evidence-driven) |
| detect_language를 `bootstrap/detect-project.sh`와 동기화 | 별 도메인 (shell script vs Python 분리) |
| `_BUILD_LANGS` 집합 재정의 (Shell 추가 등) | 별 후속 (scope 확장 위험) |
| `is_small_typed_lang_repo` 임계 재조정 | v1.36d ROADMAP 연관 없음 |
| categories_quality/ops.py 변경 | utils.py API 변경 없음 → 불필요 |
| CATEGORY_META max mismatch (v1.18h) | §3-B 별 세션 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 Python scorer 알고리즘 수정만) |
| **re-verify** | N/A |

## 1. 문제

### 1-1. dict ordering 의존 (비결정성)

`utils.py` line 112:

```python
dominant = max(exts, key=lambda k: exts[k])
```

`max()` tie 발생 시 Python dict insertion order (= file traversal order)에 따라 결과 달라짐. 파일시스템 탐색 순서는 OS/환경 의존 → **동일 레포, 다른 OS에서 다른 결과 가능**.

**실증 케이스 (v1.35 REPORT L8)**: `.py` 1 + `pyproject.toml` 1 → 동수 → lang="Toml" (파이썬이 아닌 toml 확장자가 먼저 삽입되어 max에서 선택됨).

### 1-2. `is_shell_markdown_only_repo` 조건 #1의 문제

현재 조건 #1: `if lang in _BUILD_LANGS: return False` — Python이 감지되면 즉시 False.

수정 후 lang="Python" (정확) → `is_shell_markdown_only_repo` → False → test/doc/context N/A 차단 → 점수 하락.

수정 전 lang="Toml" (오감지) → `is_shell_markdown_only_repo` → True (Toml ∉ _BUILD_LANGS) → N/A 적용.

이 동작은 v1.35에서 "의도된 N/A 진입 정합"으로 확인됨. dict ordering 수정 시 보호가 필요.

### 1-3. Shell이 lang_map 미등재

`.sh`/`.ps1` 등 shell 확장자는 `lang_map`에 없어서 `dominant.lstrip(".").capitalize()` fallback 경유 → `"Sh"`, `"Ps1"` 등 비일관적 출력. `lang_map`에 명시적 "Shell" 추가가 타당.

## 2. 결정 (R1 ~ R3)

### R1 — `detect_language()` priority 기반 tie-breaking

**신규 상수** (utils.py, `_BUILD_LANGS` 근처):

```python
_LANG_PRIORITY: dict[str, int] = {
    ".py": 100, ".ts": 100, ".tsx": 100,
    ".js": 90, ".jsx": 90,
    ".go": 100, ".rs": 100, ".java": 100, ".kt": 100,
    ".cs": 100, ".rb": 100, ".swift": 100,
    ".sh": 70, ".bash": 70, ".ps1": 70, ".zsh": 70,
}
```

**`detect_language()` 변경** (line 112):

```python
# Before
dominant = max(exts, key=lambda k: exts[k])

# After
dominant = max(exts, key=lambda k: (exts[k], _LANG_PRIORITY.get(k, 0)))
```

**lang_map 확장** (shell 추가):

```python
lang_map = {
    ".py": "Python", ".ts": "TypeScript", ".tsx": "TypeScript",
    ".js": "JavaScript", ".jsx": "JavaScript", ".go": "Go",
    ".rs": "Rust", ".java": "Java", ".kt": "Kotlin",
    ".cs": "C#", ".rb": "Ruby", ".swift": "Swift",
    ".sh": "Shell", ".bash": "Shell", ".ps1": "Shell", ".zsh": "Shell",  # NEW
}
```

**효과**:

| 입력 | 수정 전 | 수정 후 |
|------|--------|--------|
| `.py` 1 + `.toml` 1 (tie) | "Toml" (dict order) | **"Python"** (priority 100 > 0) |
| `.sh` 5 + `.md` 5 (tie) | "Md" (dict order) | **"Shell"** (priority 70 > 0) |
| `.sh` 10 + `.md` 156 (no tie) | "Md" (dominant) | "Md" (**변화 없음**) |
| `.ts` 1 + `.js` 1 (tie) | 어느쪽이든 | **"TypeScript"** (100 > 90) |

harness-meta: `.md` 156개 >> `.sh`/`.py` → 비tie → **결과 변화 없음**.

### R2 — `is_shell_markdown_only_repo()` 조건 #1 재구조화

build_sources를 함수 상단에서 1회 계산하여 조건 #1과 #4 재사용. 조건 #1은 "significant build-lang repo"만 early-return:

```python
def is_shell_markdown_only_repo(repo: Path, tracked: list[Path], lang: str) -> bool:
    """... (기존 docstring + v1.53 조건 #1 재구조화 1줄 추가) ..."""
    # 빌드 소스 수 사전 계산 (조건 #1 + #4 재사용)
    build_sources = sum(
        1 for f in tracked
        if f.suffix in _BUILD_SOURCE_EXTS and f.is_file()
    )
    # 조건 #1 (v1.53 재구조화): build 언어 + 소스 ≥ 5 → 실 프로젝트, 즉시 False
    # tiny build-lang (< 5 소스) 은 조건 #2~#4 검사로 fall through
    if lang in _BUILD_LANGS and build_sources >= 5:
        return False
    # 조건 #2: 빌드 매니페스트
    has_build_manifest, _ = file_exists_any(repo, _BUILD_MANIFESTS)
    if has_build_manifest:
        return False
    # 조건 #3: runtime 의존성
    if not _pyproject_runtime_deps_empty(repo / "pyproject.toml"):
        return False
    # 조건 #4: 빌드 소스 count / ratio
    if not tracked:
        return True
    return build_sources < 10 or build_sources / len(tracked) < _BUILD_SOURCE_RATIO_THRESHOLD
```

**동작 매트릭스**:

| 케이스 | 수정 전 | 수정 후 |
|--------|--------|--------|
| Python, 1 .py 파일, pyproject 없음 | lang=Toml(mis) → True | lang=Python(정확), build_s=1<5 → fall-through → True (**보호 유지**) |
| Python, 1 .py + pyproject.toml (deps empty) | lang=Toml → True | lang=Python, build_s=1<5 → fall-through → cond#3 empty → True (**보호 유지**) |
| Python, 1 .py + pyproject.toml (has deps) | lang=Toml → True (단, is_shell misfire) | lang=Python, build_s=1<5 → fall-through → cond#3 non-empty → **False** (올바른 수정) |
| Python, 50 .py 파일 | 해당 없음 | lang=Python, build_s=50≥5 → **False** (회귀 0) |
| Shell/Md repo 156 .md | lang=Md, build_s=0<5 → fall-through → True | **동일** |
| harness-meta 현재 | lang=Md | **동일** (점수 변화 없음) |

### R3 — Smoke `tests/smoke-detect-language.sh` 신규

정적 3 + 동적 3 = 6 checks:

**Stage 1 (정적, 3)**:

- S1: `_LANG_PRIORITY` 상수 존재
- S2: `detect_language` 내 `_LANG_PRIORITY.get(k, 0)` 패턴 존재
- S3: lang_map에 `".sh": "Shell"` 존재

**Stage 2 (동적, 3)**:

- D1: `.py`+`.toml` tie → "Python" (priority 수정 확인)
- D2: `.sh`+`.md` tie → "Shell" (shell priority + lang_map 확인)
- D3: tiny Python N/A 보호 — `is_shell_markdown_only_repo("Python", [1 .py], ...)` → True (조건 #1 fall-through 확인)

## 3. 변경 대상 (2 파일)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/skills/audit/ai-ready-scorer/scripts/utils.py` | S1c | R1+R2 — `_LANG_PRIORITY` 상수 + `detect_language` 수정 + `is_shell_markdown_only_repo` 재구조화 |
| `tests/smoke-detect-language.sh` | S3 | R3 — 정적 3 + 동적 3 = 6 checks 신규 |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [ ] **사용자 진입 확인**
- [ ] Stage A — `utils.py` R1 (\_LANG\_PRIORITY + detect\_language 수정 + lang\_map 확장)
- [ ] Stage B — `utils.py` R2 (`is_shell_markdown_only_repo` 조건 #1 재구조화)
- [ ] Stage C — `tests/smoke-detect-language.sh` R3 (6 checks)
- [ ] Stage D — 검증 (harness-meta self-eval 변화 없음 확인 + smoke 6/6 PASS)
- [ ] Stage E — REPORT.md + ROADMAP 갱신
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `utils.py`: `_LANG_PRIORITY` 상수 존재
- [ ] `utils.py`: `detect_language()` — `.py`+`.toml` tie → "Python"
- [ ] `utils.py`: `detect_language()` — `.sh`+`.md` tie → "Shell"
- [ ] `utils.py`: `is_shell_markdown_only_repo()` — tiny Python (1 .py, no deps) → True
- [ ] `utils.py`: `is_shell_markdown_only_repo()` — Python 50 .py → False (회귀 0)
- [ ] `tests/smoke-detect-language.sh` 6/6 PASS
- [ ] harness-meta self-eval: **93/100 S 변동 0**
- [ ] 기존 smoke 회귀 0 (smoke-roi-regression.sh 6/6 PASS)

## 6. 커밋 전략

단일 커밋:

```
feat(meta): v1.53-detect-language-refactor — detect_language priority 기반 tie-breaking

- update: utils.py — _LANG_PRIORITY 상수 + detect_language priority tie-breaking + Shell lang_map 등재
- update: utils.py — is_shell_markdown_only_repo 조건 #1 재구조화 (tiny build-lang fall-through)
- add: tests/smoke-detect-language.sh — 정적 3 + 동적 3 = 6/6 PASS
- add: sessions/meta/v1.53-detect-language-refactor/{PLAN,REPORT}.md

ROADMAP §3-D v1.36d 이행. harness-meta 93/100 S 변동 0. 회귀 0.
```

## 7. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `vX-type-safety-paradox-resolve` | 타입 안전성 역설 구조 실제 해소 — harness-meta `.sh` 파일이 `.md`보다 적어도 "Shell" 감지 우선화 (본 v1.53 prerequisite 완료 후) |
| `v1.18h-category-max-recalibration` | §3-B CATEGORY_META max mismatch (별 세션) |
