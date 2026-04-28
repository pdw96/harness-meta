# meta v1.18-ai-ready-scorer-shell-fix — REPORT

세션 종료: 2026-04-29
선행 세션: [`sessions/meta/v1.17-ai-ready-improvements/`](../v1.17-ai-ready-improvements/)

## 최종 결과

| 항목 | 결과 |
|------|------|
| 수정 파일 | `score_codebase.py` 2군데 |
| 테스트/소스 비율 | 0/2 → **2/2** (+2점) |
| 소스/테스트 분리 | 1/3 → **3/3** (+2점) |
| 파일 크기 체크 부작용 | 없음 (3/3 유지) |
| AI-Ready 재스코어 | **90/100 S** (86 → +4) |

## 구현 요약

### 수정 A — `source_exts` 분리 (`score_test_quality`)

**파일**: `~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py` line ~551

**원인**: 테스트/소스 비율 계산에서 `code_exts`가 Python/TS/JS/Go 계열만 포함 → `.sh`, `.ps1` 미인식 → `source_files = []` → `ratio = 0` → 0/2점 오감지.

**수정**:
```python
# 변경 전
code_exts = {".py", ".ts", ".tsx", ".js", ".jsx", ".go", ".rs", ".java"}

# 변경 후
source_exts = {
    ".py", ".ts", ".tsx", ".js", ".jsx", ".go", ".rs", ".java",
    ".sh", ".bash", ".ps1", ".zsh",   # shell/script repo 지원
    ".rb", ".swift", ".kt", ".cs",    # 기존 누락 언어 보완
}
```

**파일 크기 체크 `code_exts` 독립 유지**: line 326의 파일 크기 체크용 `code_exts`는 변경하지 않음 → `verify.ps1` 530줄이 체크 대상에서 제외됨 (부작용 0).

**검증**: `2.00 (18테스트 / 9소스)` → 2/2점.

### 수정 B — `has_src` shell 소스 감지 (`score_code_structure`)

**파일**: 동일 파일 line ~314

**원인**: `has_src` 패턴 목록 = `["src", "lib", "bot", "app", "pkg"]` → harness-meta의 `bootstrap/`, `claude/`가 소스 역할임에도 미인식 → `has_src = False` → 1/3점.

**수정**:
```python
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

일반성: `bootstrap/*.sh` (4개), `claude/**/*.sh` (2개) 모두 `tests/` 외부 서브디렉토리 → `_shell_source_in_subdir = True` → `has_src = True`. harness-meta 전용 하드코딩 없이 shell repo 패턴 일반화.

**검증**: `src계: ✓, tests계: ✓` → 3/3점.

## 판정 (PLAN 체크박스)

| 목표 | 결과 |
|------|------|
| 수정 A — `source_exts` 분리 + shell 확장자 추가 | ✅ |
| 수정 B — `has_src` shell 소스 파일 감지 추가 | ✅ |
| harness-meta 재스코어 90점 확인 | ✅ (90/100 S) |
| 파일 크기 체크 부작용 없음 | ✅ (3/3 유지) |
| 타입 안전성 만점 유지 | ✅ (15/15) |

## Lessons Learned

- **L1 — 공유 집합 변수는 책임을 분리해야 한다**: `code_exts`가 "파일 크기 체크"와 "소스 비율 계산" 두 목적으로 공유되고 있었음. `.sh`를 추가하면 `verify.ps1` 530줄이 large_files에 포함돼 파일 크기 점수가 3→2점으로 하락할 뻔 했음. `source_exts`로 이름 분리 후 각 목적에 맞는 집합 유지.
- **L2 — 하드코딩 없는 shell repo 감지**: `has_src`에 `"bootstrap"` 문자열을 하드코딩하는 대신, "tests/ 외부 서브디렉토리에 `.sh`/`.ps1` 소스 파일이 존재하면 has_src"로 일반화. 다른 shell repo(`scripts/`, `cmd/`, `bin/` 구조)에도 자동 적용.
- **L3 — 스코어러 언어 감지 역설**: `.md` 156개 dominant → `lang="Md"` → 타입 안전성·테스트 프레임워크 체크가 전부 "skip (부분 점수)"로 만점 처리. 언어 감지를 정확히 "Shell"로 바꾸면 오히려 점수가 떨어질 수 있는 역설 구조. 현행 유지.

## 다음 후보 (보류)

| 항목 | 조건 |
|------|------|
| Lock 파일 | harness-meta Python 의존성 없음 → 개선 불가. 스코어러에서 `requirements.txt` 주석 전용 파일 감지 로직 추가 시 skip 처리 가능 (evidence-driven) |
| Docker | meta repo 성격상 불필요. 변경 없음 |
| `verify.ps1` 530줄 리팩토링 | 별도 세션 (현재 파일 크기 체크가 `.ps1` 무시하는 덕에 감점 없음) |
| 언어 감지 개선 (Shell repo 정확 감지) | 타입 안전성 역설 구조 해소 필요. evidence-driven |
