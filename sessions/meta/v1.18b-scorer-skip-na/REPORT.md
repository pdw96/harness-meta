# meta v1.18b-scorer-skip-na — REPORT

세션 종료: 2026-04-29
선행 세션: [`sessions/meta/v1.18-ai-ready-scorer-shell-fix/`](../v1.18-ai-ready-scorer-shell-fix/) — "다음 후보 (보류)" 표의 Lock/Docker 항목을 본 세션이 해소

## 최종 결과

| 항목 | 결과 |
|------|------|
| 수정 파일 | `~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py` 4군데 |
| 자동화 카테고리 | 10/15 (B) → **13/15 (A)** |
| 전체 AI-Ready 점수 | 90/100 (S) → **93/100 (S)** |
| 다른 6 카테고리 변동 | **0** (회귀 0) |
| ROI 액션 수 | 2건 → **0건** ("개선할 게 없음" 신호) |
| Docker 체크 | passed=True, score=2/2, na=true, detail에 "N/A" 명시 |
| Lock 체크 | passed=True, score=1/1, na=true, detail에 "N/A" 명시 |

## 구현 요약

### 수정 A — `Check.na` 필드 추가 (line 60)

```python
@dataclass
class Check:
    ...
    na: bool = False    # N/A (체크 부적합 — 자동 만점). HTML icon ℹ️
```

backward compat: default False → 기존 외부 파서 영향 0.

### 수정 B — `is_shell_markdown_only_repo` 헬퍼 신설 (line ~217~289)

4 조건 AND:

1. `lang ∉ {Python, TypeScript, JavaScript, Go, Rust, Java, Kotlin, C#, Ruby, Swift}`
2. 빌드 매니페스트(package.json/Cargo.toml/go.mod/build.gradle*/pom.xml) **부재**
3. pyproject.toml 부재 OR runtime deps 비어있음 (tomllib 우선 + regex fallback)
4. 빌드 소스 파일 (.py/.ts/.go/.rs/.java/.kt/.cs/.rb/.swift) 개수 **< 5**

**`_pyproject_runtime_deps_empty` 헬퍼**: tomllib(3.11+) 시 `[project].dependencies` + `[tool.poetry.dependencies]`(python 키 제외) 검사. tomllib 부재 시 regex fallback (`\[project\][\s\S]*?dependencies\s*=\s*\[\s*[^\s\]]` + poetry 본문 라인 검사).

### 수정 C — score_automation Docker/Lock 분기 (line ~795~840)

```python
na_repo = is_shell_markdown_only_repo(repo, tracked, lang)

if not docker and na_repo:
    checks.append(Check(
        "Docker / 컨테이너화",
        passed=True, score=2, max_score=2,
        detail="N/A — shell/markdown-only repo (컨테이너화 부적합, 자동 만점)",
        action=None, roi_effort="중기", roi_impact=0.0,
        na=True,
    ))
else:
    # 기존 로직 (docker 발견 시 만점, 부재 + non-N/A repo면 0점 + 액션 권고)
    ...

# Lock 파일 — 동일 패턴
```

### 수정 D — generate_html icon ℹ️ (line ~929)

```python
icon = "ℹ️" if ch.get("na") else ("✅" if ch["passed"] else "❌")
```

N/A 체크는 ℹ️로 시각 구분. 사용자 "Docker 없는데 ✅?" 혼란 차단.

## 검증

### Stage E 결과 (UTF-8 stdout 캡처)

```
category: 자동화  score=13/15  grade=A
  - CI/CD 파이프라인  score=3/3  detail=발견: .github/workflows/
  - Pre-commit 훅  score=3/3  detail=발견: .pre-commit-config.yaml
  - 린터 설정  score=2/2  detail=Md — 부분 점수
  - Makefile / 태스크 러너  score=2/2  detail=발견: Makefile
  - Docker / 컨테이너화 [N/A]  score=2/2  detail=N/A — shell/markdown-only repo (컨테이너화 부적합, 자동 만점)
  - 의존성 Lock 파일 [N/A]  score=1/1  detail=N/A — runtime 의존성 부재 (자동 만점)

ROI count = 0
```

### 회귀 0 검증 (다른 카테고리)

| 카테고리 | 이전 | 이후 | 변동 |
|---------|:---:|:---:|:---:|
| 문서화 | 12/15 | 12/15 | 0 |
| 코드 구조 | 13/15 | 13/15 | 0 |
| 타입 안전성 | 15/15 | 15/15 | 0 |
| 테스트 품질 | 15/15 | 15/15 | 0 |
| 컨텍스트 레이어 | 15/15 | 15/15 | 0 |
| **자동화** | **10/15 (B)** | **13/15 (A)** | **+3** |
| 에이전틱 안전 | 10/10 | 10/10 | 0 |
| **합계** | **90/100 (S)** | **93/100 (S)** | **+3** |

## 판정 (PLAN 체크박스)

| 목표 | 결과 |
|------|:---:|
| `Check.na` 필드 추가, default False | ✅ |
| `is_shell_markdown_only_repo` 함수 추가, harness-meta에서 True 반환 | ✅ |
| Docker/Lock detail에 "N/A — ... (자동 만점)" 표기 | ✅ |
| 자동화 score=13/15, 등급 B → A | ✅ |
| 전체 점수 90 → 93 (S 유지) | ✅ |
| 다른 6 카테고리 변동 0 | ✅ |
| ROI 리스트 빈 배열 | ✅ (count=0) |
| HTML 대시보드 ℹ️ icon | ✅ (line ~929 패치) |
| JSON output에 `"na": true` 필드 존재 | ✅ |

## Lessons Learned

- **L1 — CATEGORY_META["max"] 하드코딩이 분모 차감 모델 폐기 근거**: PLAN v1의 `max_score=0` 차감 모델은 line 1132 `min(sum, meta["max"])` clamp + line 1142 `max_score=meta["max"]` + line 1148 `min(total, 100)` 3중 클램프로 무력화. Option C "자동 만점 + na flag + detail 명시 + ℹ️ icon" 4중 보강이 정직성과 단순성 양립.

- **L2 — N/A 분기는 4-조건 AND 헬퍼로 격리**: lang + manifest + deps + source count 4 조건 모두 만족할 때만 N/A. 어느 하나만 잘못돼도 false positive 차단. 미래 v1.18c (코드 구조 매니페스트 N/A) 추가 시 동일 헬퍼 재사용 가능.

- **L3 — Check 데이터 구조 확장은 default False로 backward compat**: na 필드 default False → 기존 외부 파서 영향 0. enhanced 파서가 새 정보 활용 가능. 데이터 모델 진화의 표준 패턴.

- **L4 — ROI 리스트 자연 필터의 부수 효과**: `compute_roi_actions` line 817 `if not ch["passed"] and ch.get("action")` 필터로 N/A는 자연 제외. ROI 리스트가 비어 → "개선할 게 없음" 긍정 신호. 별도 필터 로직 불요.

- **L5 — 8 유형 case table 정성 검증의 가치**: multi-repo 실 스코어링 없이 false positive 시나리오를 사전에 8개 매트릭스로 분석 (harness-meta/dotfiles/blog/Astro/Python/TS/script/empty). 4 유형(meta/dotfiles/blog/script-bin)만 N/A 진입, 4 유형 차단 — 의도된 동작 확인.

## 다음 후보 (보류 — 후속 분기)

| 항목 | 조건 |
|------|------|
| `v1.18c-scorer-package-manifest-na` | 코드 구조 카테고리의 "패키지 매니페스트" 체크 N/A 분기 (shell-only repo 대상). harness-meta 영향 0 (pyproject.toml 있음) — multi-repo evidence 1+ 시 |
| `v1.18d-scorer-stdout-encoding` | Windows cp949 stdout emoji UnicodeEncodeError fix (`sys.stdout.reconfigure(encoding='utf-8')` 1줄). 본 세션 동작 영향 0 (stderr/file 정상)이지만 Windows console UX 개선 |
| `v1.18e-scorer-html-na-ui` | HTML 대시보드 N/A 카드 정밀 시각화 (별도 색상·툴팁·필터) + multi-repo 회귀 sample 실제 실행 |
| `v1.19-scorer-skill-distribution` | 스코어러를 harness-meta repo 내 `bootstrap/skills/` 또는 별 repo로 이관 + symlink/install 배포 (글로벌 통합). 본 세션의 "score_codebase.py가 git 미추적" 이슈 영구 해소 |

## ⚠️ 중요 — score_codebase.py 변경분 보존

`score_codebase.py`는 `~/.claude/skills/ai-ready-scorer/scripts/`에 위치 — **harness-meta repo 외부**. 본 세션 git commit 대상은 PLAN.md + REPORT.md 2건만. score_codebase.py 변경분(57 lines diff)은 다음 중 하나로 보존 권장:

1. **dotfiles repo** — `~/.claude/`를 별도 dotfiles repo로 관리 중이면 자동 보존
2. **manual backup** — `cp ~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py <somewhere>/score_codebase.py.v1.18b`
3. **v1.19 후속 세션 진행** — 스코어러를 harness-meta 내로 이관하면 영구 보존
