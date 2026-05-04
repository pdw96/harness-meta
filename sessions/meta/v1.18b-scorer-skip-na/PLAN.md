# meta v1.18b-scorer-skip-na — PLAN (v2 개정)

세션 시작: 2026-04-29
직접 선행 세션: [`sessions/meta/v1.18-ai-ready-scorer-shell-fix/`](../v1.18-ai-ready-scorer-shell-fix/PLAN.md) — shell/ps1 소스 인식 수정 (86 → 90점), "다음 후보" 표에 본 세션 항목 명시 (Lock 파일 / Docker)

목적: ai-ready-scorer가 **shell/markdown-only repo**(Python/Node 의존성 부재 + 컨테이너화 부적합)에서 Docker·Lock 체크를 **N/A로 처리**하여 false negative 감점을 제거. harness-meta 같은 글로벌 하네스 레이어 repo의 자동화 카테고리 점수를 정확화.

**v2 개정 사유**: v1 PLAN의 R2 모델 (`max_score=0` 차감)이 `CATEGORY_META["max"]` 하드코딩 + line 1132 clamp 식과 충돌하여 작동 불가. Option C (자동 만점 + na 필드 + HTML icon ℹ️)로 재설계.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: ~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py 1건 (skill 본체) + S2(2) 본 세션 PLAN/REPORT
- **T1 경로 다수결** — score_codebase.py는 `~/.claude/skills/` 위치이지만 v1.18 선행 세션이 동일 파일을 meta scope로 처리한 전례. 모든 프로젝트의 AI-readiness 진단에 영향 → meta 소유
- **T2 스펙 vs 값** — 스코어러 루브릭 = 스펙 (한 번 바꾸면 모든 repo 진단 결과 영향) → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.18-ai-ready-scorer-shell-fix/REPORT.md` "다음 후보 (보류)" §** (verbatim):

> | Lock 파일 | harness-meta Python 의존성 없음 → 개선 불가. 스코어러에서 `requirements.txt` 주석 전용 파일 감지 로직 추가 시 skip 처리 가능 (evidence-driven) |
> | Docker | meta repo 성격상 불필요. 변경 없음 |

**Source 2 — 사용자 발의 (2026-04-29) verbatim**:

> "이거는 오픈소스용 하네스 개선인데 docker는 왜 쓰는거야?"

→ 합의: false negative 제거 = 스코어러 skip 로직 도입

**Parsed sub-items (2)**:

1. **Docker 체크 N/A 분기** — repo가 컨테이너화 부적합 (shell/markdown-only) 시 자동 만점 부여 + na flag
2. **Lock 파일 체크 N/A 분기** — repo가 의존성 매니페스트 부재 또는 runtime deps 0일 때 자동 만점 + na flag

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 언어 감지 정확도 개선 (Md → Shell 인식) | 별 후속 — v1.18 L3 lesson 역설 구조 (타입 안전성 점수 하락 위험) |
| 타입 안전성 카테고리에 Shell 별 트랙 도입 | evidence-driven 후속 (현재 Md skip이 만점 부여 중) |
| Docstring 커버리지 Shell 자동 측정 | evidence-driven 후속 |
| `verify.ps1` 530줄 리팩토링 | 별 도메인 (v1.18 L1 명시) |
| 코드 구조 카테고리 "패키지 매니페스트" 체크 N/A 분기 (shell-only repo 대상) | **v1.18c-scorer-package-manifest-na** 별 후속 — harness-meta 영향 0 (pyproject.toml 있음) + multi-repo 회귀 sample 필요 |
| stdout encoding cp949 fix (Windows console emoji UnicodeEncodeError) | **v1.18d-scorer-stdout-encoding** 별 후속 — 본 세션 동작 영향 0 (stderr/file 정상) |
| HTML 대시보드 N/A 카드 정밀 시각화 (별도 색상·레이블·툴팁) | **v1.18e-scorer-html-na-ui** 별 후속 — 본 세션 minimal patch (ℹ️ icon 1줄)만 |
| 다른 카테고리 N/A 규칙 (Documentation·Test·Context layer) | 본 세션 scope 외 — 자동화만 (코드 구조는 v1.18c) |
| 스코어러를 harness-meta repo 내로 이관 (`bootstrap/skills/` 등) | **v1.19-scorer-skill-distribution** 별 후속 |
| Multi-repo 회귀 sample 실행 검증 | **v1.18e** 또는 v1.18c 흡수 — 본 세션은 8 유형 case table 정성 검증만 |
| 기존 Python/Node repo 영향 검증 (실 스코어링) | 본 세션은 harness-meta 단일 fixture + 8 유형 정성 |

## 1. 문제 (false negative 감점)

### 현재 상태

`score_automation` 함수 (line 654~742)는 다음 두 체크를 무조건 실행:

- **Docker 체크** (max 2점): `Dockerfile`/`docker-compose.yml` 부재 시 0점 + 액션 권고
- **Lock 파일 체크** (max 1점): 8개 매니페스트 lock 부재 시 0점

### Root cause

스코어러가 **모든 repo가 application 또는 library**라고 가정. shell/markdown 기반 글로벌 통합 레이어 (harness-meta) 또는 문서 전용 repo는 두 체크가 본질적으로 부적합.

→ 진정한 신호 없이 -3점 감점 (자동화 13/15 → 10/15, 전체 93점 → 90점).

## 2. 결정 (R1 ~ R5 — v2)

### R1 — N/A 판정 헬퍼 함수 신설 (정밀화)

`is_shell_markdown_only_repo(repo, tracked, lang) -> bool`:

```python
def is_shell_markdown_only_repo(repo: Path, tracked: list[Path], lang: str) -> bool:
    """
    repo가 컨테이너화/lock 파일 모두 부적합한 패턴인가?

    조건 모두 충족:
    1. lang ∉ build-language 화이트리스트
       {"Python", "TypeScript", "JavaScript", "Go", "Rust",
        "Java", "Kotlin", "C#", "Ruby", "Swift"}
       → Md/Sh/Bash/Ps1/Yaml/Unknown 등 모두 통과

    2. 빌드 매니페스트(다음 중 하나) 부재:
       package.json, Cargo.toml, go.mod, build.gradle, build.gradle.kts,
       pom.xml
       → harness-meta는 pyproject.toml만 있고 위 6개 부재 → 통과

    3. pyproject.toml 부재 OR runtime deps empty
       (a) tomllib 사용 가능 (Python 3.11+):
           - [project].dependencies가 빈 리스트/부재
           - [tool.poetry.dependencies]가 부재 또는 'python' 키만
       (b) tomllib 부재 시 regex fallback:
           - re.search(r'\[project\][\s\S]*?dependencies\s*=\s*\[[^\]]+\]', content) 미매치
           - re.search(r'\[tool\.poetry\.dependencies\]\s*\n([^\[]+)', content) 본문에 python 외 라인 0

    4. 빌드 소스 파일(.py/.ts/.tsx/.js/.jsx/.go/.rs/.java/.kt/.cs/.rb/.swift) 개수 < 5
       → 절대 수치 사용 (small repo 비율 왜곡 회피)
    """
```

**조건 1 영향**: Python/TS app은 lang으로 차단. shell/md repo만 통과.

**조건 2 영향**: pyproject.toml만 있는 repo (harness-meta) 통과. Cargo/Node/Go/Java/Maven 매니페스트 보유 시 차단.

**조건 3 영향**: pyproject.toml runtime deps 0인 경우만 통과. dev-only deps (e.g., coverage)는 [project.dependencies] 본문에 안 들어가므로 통과.

**조건 4 영향**: 5개 미만 build 소스 = "fluent script repo 가능성 매우 높음".

### R2 — Check dataclass에 `na` 필드 추가

```python
@dataclass
class Check:
    name: str
    passed: bool
    score: float
    max_score: float
    detail: str
    action: Optional[str] = None
    roi_effort: str = "즉시"
    roi_impact: float = 1.0
    na: bool = False    # ← 신규: True 시 N/A 자동 만점 분기
```

backward compat: default False → 기존 외부 파서 영향 0.

### R3 — Docker / Lock 체크 N/A 분기 (Option C 자동 만점)

```python
# Docker (line 718~726)
docker, fname = file_exists_any(repo, ["Dockerfile", "docker-compose.yml", "docker-compose.yaml", ".dockerignore"])
na_repo = is_shell_markdown_only_repo(repo, tracked, lang)
if not docker and na_repo:
    checks.append(Check(
        "Docker / 컨테이너화",
        passed=True, score=2, max_score=2,
        detail="N/A — shell/markdown-only repo (컨테이너화 부적합, 자동 만점)",
        action=None,
        roi_effort="중기", roi_impact=0.0,
        na=True,
    ))
else:
    # 기존 로직 그대로
    checks.append(Check(
        "Docker / 컨테이너화",
        docker, 2 if docker else 0, 2,
        f"발견: {fname}" if docker else "없음",
        None if docker else "Dockerfile 및 docker-compose.yml 추가 (환경 재현성 보장)",
        "중기", 1.5
    ))

# Lock 파일 — 동일 패턴
lock, fname = file_exists_any(repo, [...])
if not lock and na_repo:
    checks.append(Check(
        "의존성 Lock 파일",
        passed=True, score=1, max_score=1,
        detail="N/A — runtime 의존성 부재 (자동 만점)",
        action=None,
        roi_effort="즉시", roi_impact=0.0,
        na=True,
    ))
else:
    checks.append(Check(... 기존 로직 ...))
```

**핵심 효과**:

- 자동화 카테고리 점수: 10/15 (B) → **13/15 (87% A)**
- 전체 점수: 90/100 → **93/100 (S 유지)**
- ROI 리스트: passed=True + action=None → 자연 제거 → "개선할 게 없음" 신호
- backward compat: na 필드 default False, 기존 동작 100% 유지

### R4 — HTML 대시보드 icon ℹ️ (1줄 패치)

```python
# generate_html line 854 변경
# 기존: icon = "✅" if ch["passed"] else "❌"
# 변경:
icon = "ℹ️" if ch.get("na") else ("✅" if ch["passed"] else "❌")
```

→ N/A 체크는 ℹ️로 시각 구분. 사용자 "Docker 없는데 ✅?" 혼란 차단.

### R5 — 8 유형 회귀 case table 검증 (정성)

본 세션은 harness-meta 단일 dynamic 검증 + 8 유형 정성 case 검토. multi-repo 실 스코어링 회귀는 v1.18e 후속.

| Repo 유형 | lang | 매니페스트 | runtime deps | 빌드소스 | N/A 적용? | 기대 |
|---------|------|----------|------------|--------|---------|------|
| harness-meta | Md | pyproject.toml | 0 | 0 | ✓ | 자동화 +3 |
| 순수 dotfiles | Sh | 부재 | — | 0 | ✓ | +3 |
| Hugo blog | Md/Yaml | 부재 | — | 0 | ✓ | +3 |
| Astro blog | Md | package.json | 있음 | 일부 | ✗ | 변동 0 |
| Python app | Python | pyproject.toml | 있음 | >5 | ✗ (lang) | 변동 0 |
| TS app | TypeScript | package.json | 있음 | >5 | ✗ (lang) | 변동 0 |
| 작은 Python script | Python | pyproject.toml | 0 | 1-4 | ✗ (lang) | 변동 0 |
| empty placeholder | Unknown | pyproject.toml | 0 | 0 | ✗ (조건 2 만족 but 조건 4 통과 — pyproject 매니페스트 부재 조건 2에 포함 안 됨) | 변동 0 |

→ False positive 0. 의도된 4 유형(meta/dotfiles/blog/script-bin)만 +3.

## 3. 변경 대상 (1 수정 + 2 신규)

### 수정 (1)

| 경로 | scope | 변경 | 라인 수 |
|------|------|------|------|
| `~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py` | (skill body) | (a) Check dataclass `na` 필드 +1 / (b) `is_shell_markdown_only_repo` 헬퍼 신설 ~35 / (c) score_automation Docker/Lock 분기 ~20 / (d) generate_html icon 1줄 | ~57 lines |

### 신규 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.18b-scorer-skip-na/PLAN.md` | meta | 본 파일 (v2) |
| `sessions/meta/v1.18b-scorer-skip-na/REPORT.md` | meta | Stage G — 결과 + Lessons |

## 4. 목표 / 진행 체크박스

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 + 심층 분석 → v2 개정
- [x] **사용자 진입 확인** — v2로 진행 승인 받음
- [ ] Stage A — Check dataclass `na` 필드 추가
- [ ] Stage B — `is_shell_markdown_only_repo` 헬퍼 함수 구현 (tomllib + regex fallback)
- [ ] Stage C — score_automation Docker/Lock 분기 적용
- [ ] Stage D — generate_html icon ℹ️ 1줄 패치
- [ ] Stage E — harness-meta 재스코어 → 자동화 13/15 (B→A) + 전체 93점 확인 + ROI 리스트 비어있음 확인
- [ ] Stage F — REPORT.md 작성
- [ ] 사용자 확인 후 커밋 (PLAN + REPORT만)

## 5. 성공 기준

- [ ] `Check.na` 필드 추가, default False
- [ ] `is_shell_markdown_only_repo` 함수 추가, harness-meta에서 True 반환
- [ ] 자동화 카테고리: Docker/Lock 두 체크 detail에 "N/A — ... (자동 만점)" 표기
- [ ] 자동화 카테고리 score = 13, max = 15, 등급: B → **A**
- [ ] 전체 점수: 90 → **93** (S 유지)
- [ ] **회귀 0**: 다른 6 카테고리 점수 변화 0
- [ ] ROI 액션 리스트: 빈 배열 또는 N/A 미포함
- [ ] HTML 대시보드: Docker/Lock 행에 ℹ️ icon
- [ ] JSON output: 두 N/A 체크에 `"na": true` 필드 존재

## 6. 위험 / 제약 (v2)

| 위험 | 영향 | 완화 |
|------|------|------|
| Python repo 오분류 (dev-only deps 보유) | 정상 Python repo의 lock 체크 부정확 | R1 조건 1 lang 화이트리스트 차단 |
| tomllib 부재 (Python 3.10 이하 환경) | pyproject deps 검사 부정확 | regex fallback 명시 |
| 작은 Python script repo가 빌드소스 <5 + lang fallback="Py" 미흡 | False positive 가능 | lang_map에 .py = "Python" 명시되어 있음 — 화이트리스트 차단 ✓ |
| HTML ℹ️ icon font 미지원 환경 | rendering 깨짐 | emoji 표준 (U+2139) — 모던 브라우저 100% 지원 |
| 외부 도구가 `na` 필드 읽지 못함 | backward compat | default False — 기존 파서 영향 0 |
| score_codebase.py git 미추적 | 변경 손실 위험 | REPORT.md에 dotfiles 백업 안내 명시 + v1.19 후속 |
| harness-meta 외 multi-repo 회귀 미검증 | 미발견 false positive | 8 유형 case table 정성 검증 + v1.18e 실행 검증 후속 |

## 7. 커밋 전략

```
feat(meta): sessions/meta/v1.18b-scorer-skip-na — Docker/Lock N/A 분기

- update: ~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py
  - add: Check.na 필드 (default False, backward compat)
  - add: is_shell_markdown_only_repo() 헬퍼 (~35 lines, tomllib + regex fallback)
  - update: score_automation Docker/Lock N/A 분기 (~20 lines)
  - update: generate_html icon ℹ️ 1줄 (na 시각 구분)
- add: sessions/meta/v1.18b-scorer-skip-na/{PLAN,REPORT}.md

Scope: 자동화 카테고리만. 다른 6 카테고리 무변경.
- N/A 조건 (4 AND): lang ∉ build-language(10) + 매니페스트(6) 부재 + pyproject deps 0 + 빌드소스 <5
- Option C 모델: passed=True + score=max_score + na=True
- harness-meta 재스코어: 90 → 93 (자동화 B→A, 전체 S 유지)

Lessons:
- L1 — CATEGORY_META["max"] 하드코딩 + line 1132 clamp 분석으로 max_score=0 분모 차감 모델 폐기
- L2 — N/A는 4-조건 AND 헬퍼로 격리 + na 필드로 외부 도구 enhanced 파싱 지원
- L3 — Option C "자동 만점"은 detail "N/A" 명시 + ℹ️ icon으로 정직성 보강

후속 분기:
- v1.18c: 패키지 매니페스트 N/A (코드 구조 카테고리, shell-only repo)
- v1.18d: stdout cp949 encoding fix
- v1.18e: HTML 대시보드 N/A UI 정밀화 + multi-repo 회귀 sample
- v1.19: 스코어러를 harness-meta repo 내로 이관
```

⚠️ **score_codebase.py는 `~/.claude/skills/` 위치** — harness-meta repo 외부. git commit 대상은 PLAN.md + REPORT.md 2건만. REPORT.md에 dotfiles 백업 안내 명시.

## 8. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.18c-scorer-package-manifest-na` | 코드 구조 카테고리의 "패키지 매니페스트" 체크 shell-only repo N/A 분기. multi-repo evidence 1+ 시 |
| `v1.18d-scorer-stdout-encoding` | Windows cp949 stdout emoji UnicodeEncodeError fix (`sys.stdout.reconfigure`) |
| `v1.18e-scorer-html-na-ui` | HTML 대시보드 N/A 정밀 UI (별도 색상·툴팁·필터) + multi-repo 회귀 sample 실행 검증 |
| `v1.19-scorer-skill-distribution` | 스코어러를 harness-meta repo `bootstrap/skills/` 또는 별 repo로 이관 + symlink/install 배포 (글로벌 통합) |

## 9. Lessons Forward (예상)

- **L1 — 분모 차감 모델 폐기 근거**: `CATEGORY_META["max"]` 하드코딩 + `min(sum, meta["max"])` clamp 식으로 max_score=0은 의미 0. Option C "자동 만점 + na flag + detail 명시 + icon ℹ️" 4중 보강이 정직성 회복
- **L2 — N/A 분기는 4-조건 AND 헬퍼로 격리**: lang + manifest + deps + source count 4 조건 AND. 어느 하나만 잘못돼도 false positive 차단. 미래 다른 N/A 후보 (코드 구조 매니페스트 v1.18c) 추가 시 동일 헬퍼 재사용
- **L3 — Check 데이터 구조 확장은 default False로 backward compat**: na: bool = False 추가 → 기존 외부 파서 영향 0 + enhanced 파서가 새 정보 활용 가능. 데이터 모델 진화의 표준 패턴
- **L4 — meta 세션이 ~/.claude/ 외부 파일을 다룰 때**: 커밋 대상은 sessions/meta/* 만. skill body 변경은 사용자 dotfiles 책임 — REPORT 후속 안내 명시 + v1.19로 영구 해소 분기
- **L5 — 8 유형 case table 정성 검증의 가치**: multi-repo 실 스코어링 없이도 false positive 시나리오를 사전에 8개 매트릭스로 차단. Type 분석으로 회귀 위험 측정
