# meta v1.53-detect-language-refactor — REPORT

세션 종료: 2026-05-04
선행 세션:

- [`sessions/meta/v1.35-scorer-other-na-categories/`](../v1.35-scorer-other-na-categories/) — L8 dict ordering 의존 부수 발견 → 본 세션 트리거
- [`sessions/meta/v1.18-ai-ready-scorer-shell-fix/`](../v1.18-ai-ready-scorer-shell-fix/) — L3 타입 안전성 역설 구조 최초 명시

## 최종 결과

| 항목 | 결과 |
|------|------|
| 수정 파일 | `utils.py` (3 변경: 상수 추가 + 함수 2) |
| 신규 파일 | `tests/smoke-detect-language.sh` |
| harness-meta 점수 | **93/100 S 변동 0** |
| smoke-detect-language.sh | **6/6 PASS** (정적 3 + 동적 3) |
| smoke-roi-regression.sh | **6/6 PASS** (회귀 0) |

## 구현 요약

### Stage A — `detect_language()` R1 (utils.py)

**`_LANG_PRIORITY` 상수 신설** (`_TYPED_LANG_EXTS` 직후):

```python
_LANG_PRIORITY: dict[str, int] = {
    ".py": 100, ".ts": 100, ".tsx": 100,
    ".js": 90, ".jsx": 90,
    ".go": 100, ".rs": 100, ".java": 100, ".kt": 100,
    ".cs": 100, ".rb": 100, ".swift": 100,
    ".sh": 70, ".bash": 70, ".ps1": 70, ".zsh": 70,
}
```

**`detect_language()` 수정**:

- lang_map에 `.sh`/`.bash`/`.ps1`/`.zsh` → "Shell" 추가
- `dominant = max(exts, key=lambda k: (exts[k], _LANG_PRIORITY.get(k, 0)))` (tie-breaking 추가)

### Stage B — `is_shell_markdown_only_repo()` R2 (utils.py)

조건 #1 재구조화 + build_sources 사전 계산:

```python
# 기존
if lang in _BUILD_LANGS:
    return False
...
build_sources = sum(...)  # 함수 말미

# 수정 후
build_sources = sum(...)  # 함수 상단 (조건 #1/#4 재사용)
if lang in _BUILD_LANGS and build_sources >= 5:
    return False
# tiny build-lang repo (< 5 소스) → 조건 #2~#4 fall through
```

### Stage C — `tests/smoke-detect-language.sh` R3

정적 3 + 동적 3 = 6 checks:

- S1~S3: `_LANG_PRIORITY` 존재, priority 패턴, Shell lang_map
- D1: `.py`+`.toml` tie → "Python" ✓
- D2: `.sh`+`.md` tie → "Shell" ✓
- D3: tiny Python (1 .py, no deps) → `is_shell_markdown_only_repo` True ✓

### Stage D — 검증

```
smoke-detect-language.sh  6/6 PASS
smoke-roi-regression.sh   6/6 PASS
harness-meta score        93/100 S (변동 0)
```

## 판정 (PLAN 체크박스)

| 목표 | 결과 |
|------|:---:|
| `utils.py`: `_LANG_PRIORITY` 상수 존재 | ✅ |
| `utils.py`: `.py`+`.toml` tie → "Python" | ✅ |
| `utils.py`: `.sh`+`.md` tie → "Shell" | ✅ |
| `utils.py`: tiny Python (1 .py, no deps) → `is_shell_markdown_only_repo` True | ✅ |
| `utils.py`: Python 5+ .py → `is_shell_markdown_only_repo` False (회귀 0) | ✅ (build_sources≥5 → False) |
| `tests/smoke-detect-language.sh` 6/6 PASS | ✅ |
| harness-meta self-eval 93/100 S 변동 0 | ✅ |
| 기존 smoke-roi-regression.sh 6/6 PASS | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 Python scorer 알고리즘 수정만). 구현 중 신규 spec drift 없음 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — dict ordering 수정 + N/A 보호 동시 유지**: priority tie-breaking 추가 시 lang="Python"으로 정확 감지 → `is_shell_markdown_only_repo` 조건 #1이 즉시 차단 → N/A 보호 소실 위험. 조건 #1 재구조화(`build_sources >= 5`만 early-return)로 tiny Python 레포의 기존 N/A 보호를 보존하면서 dict ordering 의존을 동시 제거. **두 문제를 단일 함수 재구조화로 해결**.

- **L2 — build_sources 사전 계산으로 중복 제거**: 기존 코드는 `build_sources`를 조건 #4에서만 계산 (함수 말미). 조건 #1에서도 필요해지면서 함수 상단 이동 → 단일 계산 + 조건 #1/#4 재사용. 가독성과 효율성 동시 개선.

- **L3 — Shell이 lang_map 미등재였음**: 수정 전 `.sh` dominant 레포 → `"Sh".capitalize()` 경유 → 비일관적 출력. lang_map 등재는 side fix로 포함할 수 있었음 — tie-breaking 수정과 자연 결합. **연관 side fix를 같이 처리하면 smoke 한 번으로 검증 가능**.

- **L4 — Architecture 관점 검토가 "build_sources 사전 계산" 제안 발굴**: 3 관점 병렬 검토에서 architecture agent가 `_count_build_sources` 별도 helper 추출 제안. 실제 구현에서는 직접 계산으로 단순하게 해결했지만, 제안 덕분에 조건 #1/#4 공통 활용 가능성을 인식 → 함수 상단 이동 결정. **subagent 검토가 구현 개선에 직접 기여**.

## 다음 후보 (보류)

| 항목 | 조건 |
|------|------|
| `vX-type-safety-paradox-resolve` | 타입 안전성 역설 구조 실제 해소 — harness-meta `.sh` 파일이 `.md`보다 적어도 "Shell" 우선 감지 (본 v1.53 prerequisite 완료 후) |
| `v1.18h-category-max-recalibration` | CATEGORY_META max mismatch (§3-B 별 세션) |
