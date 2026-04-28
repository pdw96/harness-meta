# meta v1.18-ai-ready-scorer-shell-fix — PLAN

세션 시작: 2026-04-29
선행 세션: [`sessions/meta/v1.17-ai-ready-improvements/`](../v1.17-ai-ready-improvements/)

목적: `ai-ready-scorer` 스크립트가 shell/PowerShell 중심 repo를 잘못 평가하는 두 버그 수정.
harness-meta 재스코어 86 → 90점 달성.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: `~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py` (S1a — 글로벌 UX)
- T1 경로 다수결 — 1/1 파일 S1a → meta 소유

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.17-ai-ready-improvements/REPORT.md` 다음 후보 표 (verbatim)**:

> | test/source 비율 (스코어러 오감지) | 스코어러 자체 .sh 인식 개선 필요 (v1.18+ 스코어러 개선) |

**Parsed sub-items (1)**:

1. **스코어러 `.sh`·`.ps1` 소스 인식 개선** — `code_exts`에 shell 확장자 없어 source_files=0 → ratio=0 → 0점 오감지. `source_exts` 분리 + shell 파일 포함으로 수정.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| Lock 파일 추가 | harness-meta에 Python 런타임 의존성 없음 → 의미 없음 |
| Docker 추가 | meta repo 성격상 불필요 |
| `src/` 디렉토리 신설 | shell repo 구조 불일치 |
| 언어 감지 로직 전면 개선 | `.md` dominant → "Md" 반환 현상은 타입 안전성 만점에 유리하게 작용 중. 건드리면 역효과 위험 |
| `verify.ps1` 리팩토링 (530줄 초과) | 별도 세션 (현재 파일 크기 체크가 `.ps1` 무시하는 덕에 감점 없음) |

## 1. 문제 정확 기술

### 버그 A — 테스트/소스 비율 (`score_test_quality` line 550~565)

```python
code_exts = {".py", ".ts", ".tsx", ".js", ".jsx", ".go", ".rs", ".java"}
source_files = [f for f in tracked if f.suffix in code_exts ...]
ratio = len(test_files) / len(source_files) if source_files else 0
```

- `.sh`, `.ps1` 미포함 → `source_files = []` → `ratio = 0` → **0/2점**
- 실제: 소스 9개 / 테스트 16개 → ratio 1.78 → 만점이었어야 함
- **주의**: 이 `code_exts`를 `source_exts`로 이름 분리. 파일 크기 체크용 `code_exts` (line 326)는 **건드리지 않음** → `verify.ps1` 530줄 부작용 차단

### 버그 B — 소스/테스트 디렉토리 분리 (`score_code_structure` line 313~323)

```python
has_src = any((repo / d).is_dir() for d in ["src", "lib", "bot", "app", "pkg"])
```

- harness-meta에 `src/`, `lib/`, `bot/`, `app/`, `pkg/` 없음 → `has_src = False`
- `has_tests = True` → 1/3점
- 실제: `bootstrap/` 내 `.sh` 소스 4개, `claude/` 내 2개 → 소스 디렉토리 존재
- **수정**: shell 소스 파일이 tests/ 외부 서브디렉토리에 존재하면 `has_src = True`로 인정

## 2. 수정 설계

### 수정 A — `source_exts` 분리 (line 550 근방)

```python
# 변경 전
code_exts = {".py", ".ts", ".tsx", ".js", ".jsx", ".go", ".rs", ".java"}
source_files = [
    f for f in tracked
    if f.suffix in code_exts and f.is_file()
    and not any(seg in f.parts for seg in ("test", "tests", "__tests__", "spec"))
]

# 변경 후
source_exts = {
    ".py", ".ts", ".tsx", ".js", ".jsx", ".go", ".rs", ".java",
    ".sh", ".bash", ".ps1", ".zsh",           # shell/script repo 지원
    ".rb", ".swift", ".kt", ".cs",            # 기존 누락 언어 보완
}
source_files = [
    f for f in tracked
    if f.suffix in source_exts and f.is_file()
    and not any(seg in f.parts for seg in ("test", "tests", "__tests__", "spec"))
]
```

파일 크기 체크 `code_exts` (line 326)는 **독립 집합 유지** — 변경 없음.

### 수정 B — `has_src` 확장 (line 314)

```python
# 변경 전
has_src = any((repo / d).is_dir() for d in ["src", "lib", "bot", "app", "pkg"])

# 변경 후
_src_dirs = ["src", "lib", "bot", "app", "pkg", "scripts", "cmd", "internal"]
_shell_exts = {".sh", ".bash", ".ps1", ".zsh"}
_shell_source_in_subdir = any(
    f.parent != repo
    and not any(seg in f.parts for seg in ("test", "tests"))
    for f in tracked
    if f.suffix in _shell_exts and f.is_file()
)
has_src = any((repo / d).is_dir() for d in _src_dirs) or _shell_source_in_subdir
```

일반성 근거:
- `scripts/`, `cmd/`, `internal/` — Go/Node 오픈소스에서 흔한 소스 디렉토리 패턴
- `_shell_source_in_subdir` — shell repo (bootstrap/, claude/ 등) 패턴을 하드코딩 없이 감지

## 3. 변경 대상

| 파일 | 변경 |
|------|------|
| `~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py` | 수정 A (line ~551) + 수정 B (line ~314) |

## 4. 목표

- [ ] PLAN.md 작성
- [ ] 수정 A — `source_exts` 분리 + shell 확장자 추가
- [ ] 수정 B — `has_src` shell 소스 파일 감지 추가
- [ ] harness-meta 재스코어 → 90점 확인
- [ ] REPORT.md 작성
- [ ] 커밋

## 5. 성공 기준

- [ ] `score_codebase.py` 수정 후 harness-meta 재스코어: **90/100**
- [ ] 테스트/소스 비율: 0/2 → 2/2
- [ ] 소스/테스트 디렉토리 분리: 1/3 → 3/3
- [ ] 파일 크기 체크 (`verify.ps1` 530줄) 영향 없음: 3/3 유지
- [ ] 타입 안전성 만점 유지: 15/15

## 6. 커밋 전략

```
fix(meta): ai-ready-scorer shell/ps1 소스 파일 인식 버그 수정 — 86 → 90점

- score_test_quality: code_exts → source_exts 분리 + .sh/.ps1/.bash/.zsh 추가
- score_code_structure: has_src에 shell 소스 파일 subdirectory 감지 추가
- 부작용 차단: 파일 크기 체크 code_exts 독립 유지 (verify.ps1 530줄 영향 없음)
```
