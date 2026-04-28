---
name: harness-python
description: Python 프로젝트 통합 점검 — 환경 확인 + mypy → ruff → pytest 품질 게이트. .harness.toml PM 자동 감지.
disable-model-invocation: true
argument-hint: "[env|check|fix|all]"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
model: sonnet
---

Python 프로젝트 전체 점검. `.harness.toml` 기반 PM 감지 + `[testing]` 필드 통합.

| argument | 동작 |
|----------|------|
| 없음 / `all` | §2 환경 확인 → §3 품질 게이트 전체 |
| `env` | §2 환경 확인만 |
| `check` | §3 품질 게이트만 |
| `fix` | §4 자동 수정 (ruff format + ruff --fix) |

---

## §0. 전제 읽기

**1. `.harness.toml` 필드 추출** (Bash grep+sed):

```bash
PM=$(grep -E '^package_manager\s*=\s*"' .harness.toml 2>/dev/null \
     | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
TYPE_CHECK=$(grep -E '^type_check_cmd\s*=\s*"' .harness.toml 2>/dev/null \
     | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
LINT=$(grep -E '^lint_cmd\s*=\s*"' .harness.toml 2>/dev/null \
     | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
FORMAT=$(grep -E '^format_cmd\s*=\s*"' .harness.toml 2>/dev/null \
     | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
TEST=$(grep -E '^test_cmd\s*=\s*"' .harness.toml 2>/dev/null \
     | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
```

**2. PM → prefix 매핑** (`python-quality.md §1` 참조):

- `uv` → `uv run`
- `poetry` → `poetry run`
- `pdm` → `pdm run`
- `hatch` → `hatch run`
- `pip` / 기타 / 미감지 → 직접 호출 (prefix 없음)

**3. 명령 fallback** — 필드 빈값 시 PM default 사용 (`python-quality.md §2` 참조).

**.harness.toml 부재 시**: "`.harness.toml` 미발견. PM을 입력하세요 (uv/poetry/pip):" 사용자 질의.

---

## §1. Argument dispatch

argument를 소문자로 정규화 후 위 표에 따라 섹션 진입.

---

## §2. 환경 확인 (env)

순서대로 실행하고 ✓/✗ 출력:

| # | 항목 | 확인 명령 / 조건 |
|---|------|----------------|
| 1 | Python 버전 | `python --version` (uv: `uv python list --only-installed \| head -1`) |
| 2 | 가상환경 | `.venv/` 디렉토리 존재 (`[ -d .venv ]`) |
| 3 | Lock file | `uv.lock` 또는 `poetry.lock` 파일 존재 |
| 4 | Lock sync 상태 | uv → `uv sync --dry-run 2>&1 \| tail -5` / poetry → `poetry check --quiet` |

상세 확인 명령 및 수정 명령은 `python-quality.md §3` 참조.

**출력 형식:**
```
─── Python 환경 ───────────────────────────
  ✓ Python 3.12.x
  ✓ .venv 존재
  ✓ uv.lock 존재
  ✗ sync 불일치 — uv sync 실행 필요
─────────────────────────────────────────
```

✗ 항목 발생 시 → 원인 1줄 + 수정 명령 안내.  
`check` 진행 여부 사용자 확인 (✗가 있는 경우).

---

## §3. 품질 게이트 (check)

**실행 순서**: type_check → lint → format_check → test

각 단계:
1. `▶ <command>` 출력
2. Bash 실행
3. exit 0 → PASS / exit ≠ 0 → FAIL
4. FAIL 시 → 핵심 오류 최대 10줄 표시 + `python-quality.md §4` 진단 패턴 매칭
5. FAIL 후 → "계속할까요? (y/n)" 확인. `n` → 중단. `y` → 다음 단계.

**최종 결과 표 형식:**
```
─── 품질 게이트 결과 ──────────────────────
  type_check  ✓  (0 errors)
  lint        ✗  (3 issues)
  format      —  (skipped: 사용자 중단)
  test        —  (skipped)
─────────────────────────────────────────
  종합: 1 PASS / 1 FAIL / 2 SKIPPED
```

전체 PASS 시:
```
─── 품질 게이트 결과 ──────────────────────
  type_check  ✓  (0 errors)
  lint        ✓  (0 issues)
  format      ✓  (clean)
  test        ✓  (42 passed, 0 failed)
─────────────────────────────────────────
  종합: 4/4 PASS ✓
```

---

## §4. 자동 수정 (fix)

**format 수정** (먼저):
```bash
<prefix> ruff format .
```

**lint 자동 수정** (이후):
```bash
<prefix> ruff check --fix .
```

수정된 파일 수 출력. `ruff check --fix` 이후 잔존 오류는 수동 해결 필요.  
fix 완료 후 → "check를 실행할까요? (y/n)" 확인.

---

## §5. 진단 힌트

FAIL 오류 메시지를 `python-quality.md §4` 패턴 표와 grep 매칭 → 원인 + 해결 명령 제안.  
미식별 패턴은 원문 그대로 표시.
