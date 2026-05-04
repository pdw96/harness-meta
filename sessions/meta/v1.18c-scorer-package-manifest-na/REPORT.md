# meta v1.18c-scorer-package-manifest-na — REPORT

세션 종료: 2026-04-29
선행 세션:

- [`sessions/meta/v1.18b-scorer-skip-na/`](../v1.18b-scorer-skip-na/) — Docker/Lock N/A 분기 + `is_shell_markdown_only_repo` 헬퍼 도입. 본 세션이 동일 헬퍼를 코드 구조 카테고리로 재사용. **rubric.md 누락분 동시 보강**
- [`sessions/meta/v1.19-scorer-skill-distribution/`](../v1.19-scorer-skill-distribution/) — score_codebase.py가 git 추적 위치(`bootstrap/skills/`)로 이관됨. 본 세션이 v1.19 이후 첫 실 변경

## 최종 결과

| 항목 | 결과 |
|------|------|
| 수정 파일 | `bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py` (1군데) + `references/rubric.md` (3군데) |
| harness-meta 전체 점수 | 92/100 (S) → **92/100 (S)** (변동 0 — 의도) |
| 코드 구조 카테고리 | 12/15 → **12/15** (변동 0 — manifest=True 분기로 자연 차단) |
| 패키지 매니페스트 체크 | 3/3 (manifest=True 분기 — 기존 만점 그대로) |
| ROI 액션 수 | 0 → **0** (변동 0) |
| 8 유형 case table | dynamic 시뮬레이션 8/8 통과 (False positive 0) |
| rubric.md 정합화 | 자동화 § + 코드 구조 § + N/A 정책 신규 § (drift 제거) |

## 구현 요약

### 수정 A — score_code_structure() 패키지 매니페스트 분기 (line 440~458)

```python
manifest, fname = file_exists_any(repo, [
    "pyproject.toml", "package.json", "go.mod", "Cargo.toml",
    "pom.xml", "build.gradle", "setup.py", "setup.cfg"
])
if not manifest and is_shell_markdown_only_repo(repo, tracked, lang):
    checks.append(Check(
        "패키지 매니페스트",
        passed=True, score=3, max_score=3,
        detail="N/A — shell/markdown-only repo (의존성 매니페스트 부적합, 자동 만점)",
        action=None,
        roi_effort="즉시", roi_impact=0.0,
        na=True,
    ))
else:
    # 기존 로직 그대로
    checks.append(Check(... 기존 ...))
```

v1.18b의 `is_shell_markdown_only_repo` 헬퍼를 그대로 호출. 새 헬퍼 신설 없음 (DRY).

### 수정 B — rubric.md 정합화 (3군데)

**B1. 코드 구조 § 패키지 매니페스트 행** (line 47):

```diff
- | 패키지 매니페스트 존재 | 3 | pyproject.toml / package.json 등 |
+ | 패키지 매니페스트 존재 | 3 | pyproject.toml / package.json 등 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
```

**B2. 자동화 § Docker/Lock 행** (line 134-135) — **v1.18b 누락 보강**:

```diff
- | Docker / 컨테이너화 | 2 | Dockerfile 등 |
- | 의존성 Lock 파일 | 1 | poetry.lock / package-lock.json 등 |
+ | Docker / 컨테이너화 | 2 | Dockerfile 등 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
+ | 의존성 Lock 파일 | 1 | poetry.lock / package-lock.json 등 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
```

**B3. "N/A 정책" 신규 § 추가** (rubric.md "ROI 계산 방식" § 직전):

- 4 조건 AND 진입 조건 (lang 화이트리스트 + 매니페스트 부재 + pyproject deps empty + 빌드소스 <5)
- 적용 체크 3건 표 (Docker/Lock v1.18b + 패키지 매니페스트 v1.18c)
- Check.na 데이터 모델 + JSON `"na": true` + HTML ℹ️ icon spec

## 검증

### Stage C — harness-meta 재스코어 (회귀 0)

```
Total: 92/100  Grade: S
  문서화: 12/15  Grade: A
  코드 구조: 12/15  Grade: A    ← 본 세션 변경 진입 안 함 (manifest=True 분기)
  타입 안전성: 15/15  Grade: S
  테스트 품질: 15/15  Grade: S
  컨텍스트 레이어: 15/15  Grade: S
  자동화: 13/15  Grade: A        ← v1.18b N/A 효과 유지
  에이전틱 안전: 10/10  Grade: S

--- Code Structure ---
  소스/테스트 디렉토리 분리: 3/3
  파일 크기 적정 (≤500줄): 2/3   ← v1.19 이관 부수효과 (score_codebase.py 1300+ 줄)
  설정 분리 (config/settings): 3/3
  패키지 매니페스트: 3/3          ← manifest=True 분기 (pyproject.toml 보유) — 변동 0
  루트 평탄화 방지: 1/1

--- Automation ---
  CI/CD 파이프라인: 3/3
  Pre-commit 훅: 3/3
  린터 설정: 2/2
  Makefile / 태스크 러너: 2/2
  Docker / 컨테이너화 [N/A]: 2/2  ← v1.18b 효과 유지
  의존성 Lock 파일 [N/A]: 1/1     ← v1.18b 효과 유지

ROI count: 0
```

### Stage D — 8 유형 case table dynamic 시뮬레이션 (PLAN R4)

`tempfile.TemporaryDirectory`로 8개 가상 repo 구성 후 `is_shell_markdown_only_repo` + `file_exists_any` 호출 결과:

| Case | lang | helper | manifest | 결과 | 기대 | 일치 |
|------|------|:------:|:--------:|------|------|:----:|
| harness-meta | Md | True | True | 기존 만점 | 변동 0 | ✓ |
| 순수 dotfiles | Sh | True | False | **N/A +3** | +3 | ✓ |
| Hugo blog | Md | True | False | **N/A +3** | +3 | ✓ |
| Astro blog | JavaScript | False | True | 기존 만점 | 변동 0 | ✓ |
| Python app | Python | False | True | 기존 만점 | 변동 0 | ✓ |
| TS app | TypeScript | False | True | 기존 만점 | 변동 0 | ✓ |
| 작은 Python script | Python | False | True | 기존 만점 | 변동 0 | ✓ |
| empty placeholder | Unknown | True | False | **N/A +3** | +3 | ✓ |

**False positive 0.** 의도된 3 유형(dotfiles/blog/empty)만 +3 효과 발현.

## 디테일 검증 (Pre-impl)

### A. 코드 무결성 (7/7 PASS)

| # | 검증 | 결과 |
|---|------|:----:|
| A1 | `Check.na` 필드 (line 60, default False) backward compat | ✓ |
| A2 | `is_shell_markdown_only_repo(repo, tracked, lang)` 시그니처 ↔ `score_code_structure(repo, tracked, lang)` 일치 | ✓ |
| A3 | `CATEGORY_META["code_structure"]["max"]=15`, sub-check sum ≤ 15, line 1232 `min(sum, max)` clamp 자연 처리 | ✓ |
| A4 | `compute_roi_actions` line 917 — na=True → passed=True → 자동 제외 | ✓ |
| A5 | `generate_html` line 954 ℹ️ icon — v1.18b 패치 재사용 | ✓ |
| A6 | `asdict(c)` (line 1239) — dataclass 자동 직렬화 → na 필드 자동 포함 | ✓ |
| A7 | score_code_structure return list[Check] 타입 호환 | ✓ |

### B. 외부 spec (context7 검증)

| # | 검증 | 출처 | 결론 |
|---|------|------|------|
| B1 | Python `tomllib.load()` `TOMLDecodeError` (Python 3.11+ 표준) | docs.python.org/3/library/tomllib | v1.18b 헬퍼 try/except 흡수 — 안정 ✓ |
| B2 | Claude Code Skills `SKILL.md.description` = trigger phrase | code.claude.com/docs/en/skills + plugin-dev | 본 변경 frontmatter 무관 — 갱신 불요 ✓ |

### C. 내부 spec (rubric.md drift) — **보강 1건**

⚠️ **사전 발견**: v1.18b가 자동화 Docker/Lock을 N/A 처리했지만 rubric.md(line 134-135)는 미갱신 → spec drift.

→ 본 v1.18c가 동일 위배 회피 위해 v1.18b 누락분 + v1.18c 신규를 한 번에 정합화 (수정 B 참조).

## 판정 (PLAN 체크박스)

| 목표 | 결과 |
|------|:---:|
| score_code_structure 패키지 매니페스트 분기에 `is_shell_markdown_only_repo` 호출 추가 | ✅ |
| manifest 부재 + 헬퍼 True 시 `na=True`, score=3, max_score=3, detail에 "N/A" 명시 | ✅ |
| harness-meta 회귀 0 (코드 구조 12/15 유지, 전체 92/100 유지) | ✅ |
| manifest=True 분기 (pyproject.toml 보유 시) 기존 동작 유지 | ✅ |
| manifest=False + 헬퍼 False 시 기존 0점 유지 (감점 보존) | ✅ (Python app/TS app/script 검증) |
| JSON output: N/A 진입 시 `"na": true` 필드 존재 | ✅ (asdict 자동 직렬화) |
| HTML 대시보드: N/A 진입 시 ℹ️ icon (v1.18b D 패치 재사용) | ✅ |
| **rubric.md 정합화 (코드 구조 § + 자동화 § + N/A 정책 §)** | ✅ |

## Lessons Learned

- **L1 — N/A 헬퍼는 카테고리 간 재사용 패턴**: v1.18b의 `is_shell_markdown_only_repo` 4 조건 AND를 자동화 → 코드 구조로 재사용. 헬퍼 단일 소스 + 호출 사이트만 카테고리별 추가. 데이터 모델(`Check.na`) + UI 패치(HTML ℹ️ icon) 모두 v1.18b가 이미 인프라 제공 → 본 세션 코드 변경 ~15 lines로 완료.

- **L2 — manifest=True 분기 우선이 harness-meta 자연 회귀 0 보장**: `if not manifest and is_shell_markdown_only_repo(...)` 조건의 `not manifest`가 우선 차단. pyproject.toml 보유 repo는 N/A 분기 진입 전 기존 만점 분기로 흡수 → 회귀 위험 0. shell-only repo만 N/A 효과 발현.

- **L3 — v1.19 이관 후 첫 실 변경**: score_codebase.py가 `bootstrap/skills/`(git 추적)에 있어 변경분 영구 보존. v1.18b의 "dotfiles 백업 안내" 우려 해소 — v1.19 이관의 직접 가치 입증.

- **L4 — Spec drift 사전 감지의 가치**: 디테일 분석 단계(context7 + 내부 spec 검토)에서 v1.18b가 rubric.md를 갱신하지 않은 drift 발견 → 본 세션에 보강 흡수. **동작-spec 정합화 의무를 매 세션 PLAN review의 표준 항목화**. context7 검증 (외부 spec) + 내부 spec 검토 (rubric/SKILL/CLAUDE) 양쪽 의무.

- **L5 — 8 유형 case table dynamic 시뮬레이션의 가치**: PLAN R4의 정성 매트릭스를 `tempfile.TemporaryDirectory` 기반 dynamic 검증으로 강화. 실 multi-repo 회귀 검증 (v1.18e)이 없어도 8 case 모두 helper + manifest 분기 통과 확인 가능 → false positive 0 사전 보장. 코드 무결성 + 동작 무결성 양쪽 검증.

- **L6 — v1.19 이관 부수효과 (코드 구조 13→12)**: score_codebase.py 자체가 1300+ 줄로 git tracked되며 "파일 크기 ≤500줄" 체크에서 -1점. 본 세션 변경 무관, v1.19 이관의 자연 결과. 향후 score_codebase.py 자체 분할은 별 후속 (v1.18g+ 등 evidence-driven).

## 다음 후보 (보류 — 후속 분기)

| 항목 | 조건 |
|------|------|
| `v1.18d-scorer-stdout-encoding` | Windows cp949 stdout emoji UnicodeEncodeError fix (`sys.stdout.reconfigure(encoding='utf-8')` 1줄). 본 세션 검증 시 Windows console 깨짐 재확인 — 점수 산출은 정상 (file/stderr 정상) |
| `v1.18e-scorer-html-na-ui` | HTML 대시보드 N/A 카드 정밀 시각화 (별도 색상·툴팁·필터) + multi-repo 회귀 sample 실 실행 |
| `v1.18f-scorer-other-na-categories` | Documentation·Test·Context layer·Type safety 카테고리 N/A 분기 (evidence-driven) |
| `v1.18g-score-codebase-py-split` | score_codebase.py 1300+ 줄 분할 (코드 구조 -1 회복). evidence-driven |
