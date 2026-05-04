# meta v1.18c-scorer-package-manifest-na — PLAN

세션 시작: 2026-04-29
직접 선행 세션:

- [`sessions/meta/v1.18b-scorer-skip-na/`](../v1.18b-scorer-skip-na/PLAN.md) — Docker/Lock N/A 분기 + `is_shell_markdown_only_repo` 헬퍼 도입. 본 세션이 동일 헬퍼를 코드 구조 카테고리로 재사용
- [`sessions/meta/v1.19-scorer-skill-distribution/`](../v1.19-scorer-skill-distribution/PLAN.md) — score_codebase.py가 `bootstrap/skills/` 내 git 추적 위치로 이관됨. 본 세션 변경분은 영구 보존

목적: ai-ready-scorer가 **shell/markdown-only repo** (Python/Node 의존성 부재 + 매니페스트 부적합)에서 코드 구조 카테고리의 **"패키지 매니페스트" 체크를 N/A로 처리**하여 false negative 감점을 제거. v1.18b 자동화 카테고리 N/A 패턴을 코드 구조로 일관성 있게 확장.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: `bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py` (S1c 글로벌 user-skill — v1.19 이관 후) + S2(2) 본 세션 PLAN/REPORT
- **T1 경로 다수결** — score_codebase.py는 v1.19에서 S1c로 이관됨. 모든 사용자/모든 repo의 AI-readiness 진단에 영향 → meta
- **T2 스펙 vs 값** — 스코어러 루브릭 = 스펙 (한 번 바꾸면 모든 repo 진단 결과 영향) → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.18b-scorer-skip-na/PLAN.md` Out of scope §** (verbatim):

> | 코드 구조 카테고리 "패키지 매니페스트" 체크 N/A 분기 (shell-only repo 대상) | **v1.18c-scorer-package-manifest-na** 별 후속 — harness-meta 영향 0 (pyproject.toml 있음) + multi-repo 회귀 sample 필요 |

**Source 2 — `sessions/meta/v1.18b-scorer-skip-na/REPORT.md` "다음 후보 (보류)" §** (verbatim):

> | `v1.18c-scorer-package-manifest-na` | 코드 구조 카테고리의 "패키지 매니페스트" 체크 N/A 분기 (shell-only repo 대상). harness-meta 영향 0 (pyproject.toml 있음) — multi-repo evidence 1+ 시 |

**Parsed sub-items (1)**:

1. **코드 구조 카테고리 "패키지 매니페스트" 체크 N/A 분기** — repo가 shell/markdown-only일 때 자동 만점 (3/3) + na flag. v1.18b의 `is_shell_markdown_only_repo` 헬퍼 재사용

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 코드 구조 카테고리 다른 체크 N/A 분기 (소스/테스트 디렉토리, 파일 크기, 설정 분리, 루트 평탄화) | 본 세션 scope 외 — "패키지 매니페스트" 단일 체크만. evidence-driven 후속 |
| 다른 카테고리 N/A 규칙 (Documentation·Test·Context layer·Type safety) | 본 세션 scope 외 — 자동화(v1.18b) + 코드 구조(v1.18c) 두 카테고리만 |
| `is_shell_markdown_only_repo` 헬퍼 4 조건 변경 | 별 후속 — 현 4 조건 AND가 v1.18b에서 8 유형 정성 검증 통과. 본 세션은 재사용만 |
| stdout encoding cp949 fix | **v1.18d-scorer-stdout-encoding** 별 후속 |
| HTML 대시보드 N/A 카드 정밀 시각화 | **v1.18e-scorer-html-na-ui** 별 후속 |
| Multi-repo 실 스코어링 회귀 검증 | **v1.18e** 흡수 — 본 세션은 8 유형 case table 정성 + harness-meta 단일 dynamic 검증 |
| 언어 감지 정확도 개선 (Md → Shell 인식) | 별 후속 (v1.18 L3 lesson 역설 구조) |
| `verify.ps1` 530줄 리팩토링 | 별 도메인 (v1.18 L1 명시) |
| SKILL.md description 갱신 | 불요 — context7 검증 (code.claude.com/docs/en/skills + plugin-dev): description은 trigger phrase 용도. 스크립트 로직 변경은 frontmatter 무관 |

## 1. 문제 (false negative 감점)

### 현재 상태

`score_code_structure` 함수 (line 440~451)는 패키지 매니페스트 부재 시 무조건 0점 부여:

```python
manifest, fname = file_exists_any(repo, [
    "pyproject.toml", "package.json", "go.mod", "Cargo.toml",
    "pom.xml", "build.gradle", "setup.py", "setup.cfg"
])
checks.append(Check(
    "패키지 매니페스트",
    manifest, 3 if manifest else 0, 3,
    f"발견: {fname}" if manifest else "의존성 관리 파일 없음",
    None if manifest else "pyproject.toml / package.json 등 의존성 매니페스트 추가",
    "즉시", 1.5
))
```

### Root cause

스코어러가 **모든 repo에 패키지 매니페스트가 적합하다고 가정**. shell/markdown-only repo (dotfiles, 글로벌 통합 레이어, 문서 전용 repo)에서는 매니페스트 자체가 부적합 — 진정한 신호 없이 -3점 감점.

### Harness-meta 영향

- harness-meta는 `pyproject.toml` 보유 → 패키지 매니페스트 체크 통과 (3/3)
- **본 세션의 harness-meta 직접 영향: 0** (이미 v1.18b에서 명시)
- 본 세션 효과는 **shell-only repo (dotfiles, hugo blog 등)** 에서만 발현
- 회귀 검증은 harness-meta dynamic 0 변동 + 8 유형 case table 정성 검증으로 진행

## 2. 결정 (R1 ~ R4)

### R1 — `is_shell_markdown_only_repo` 재사용 (v1.18b 헬퍼)

새 헬퍼 신설 안 함. v1.18b가 이미 4 조건 AND로 false positive 차단:

1. lang ∉ build-language 화이트리스트 (10 lang)
2. 빌드 매니페스트(package.json/Cargo.toml/go.mod/build.gradle*/pom.xml) 부재
3. pyproject.toml 부재 OR runtime deps empty
4. 빌드 소스 파일 < 5

**조건 2 정합성 분석**: v1.18b 헬퍼의 `_BUILD_MANIFESTS`는 `pyproject.toml`을 **포함하지 않음**. 즉 pyproject만 보유 + runtime deps 0인 repo (harness-meta)는 헬퍼가 True 반환 가능.

→ harness-meta는 lang="Md" + build manifest 부재(조건 2) + pyproject runtime deps empty(조건 3) + 빌드 소스 0(조건 4) → **헬퍼 True**

→ score_code_structure에서 N/A 분기 진입 가능 — but **harness-meta는 pyproject.toml 보유로 매니페스트 체크 자체가 이미 통과**. N/A 분기 진입 전 `manifest=True` 분기 우선 → **score 변동 0**.

→ 의도된 변경: pyproject.toml도 부재 + 헬퍼 True인 repo에서만 +3 효과 발현.

### R2 — score_code_structure 패키지 매니페스트 분기

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
    checks.append(Check(
        "패키지 매니페스트",
        manifest, 3 if manifest else 0, 3,
        f"발견: {fname}" if manifest else "의존성 관리 파일 없음",
        None if manifest else "pyproject.toml / package.json 등 의존성 매니페스트 추가",
        "즉시", 1.5
    ))
```

**핵심 효과**:

- harness-meta: manifest=True → else 분기 → **변동 0**
- pure dotfiles repo: manifest=False + 헬퍼 True → N/A 분기 → +3
- Astro blog (package.json 보유): manifest=True → 기존 만점 → 변동 0
- Python script (lang="Python"): 헬퍼 False (조건 1 차단) → 기존 0점 유지 → 변동 0
- backward compat: na 필드 default False → 기존 외부 파서 영향 0

### R3 — rubric.md N/A 정책 명시 (v1.18b 누락 보강 포함)

**Drift 발견**: v1.18b가 자동화 카테고리 Docker/Lock을 N/A로 변경했지만 `references/rubric.md` line 134-135은 갱신되지 않음 → spec과 동작 drift 상태.

본 v1.18c는 동일 위배를 만들지 않기 위해 **v1.18b 누락분 + v1.18c 신규를 한 번에 정합화**.

**갱신 위치 3건**:

1. **카테고리 2 (코드 구조) 표** (rubric.md line 47):

   ```
   | 패키지 매니페스트 존재 | 3 | pyproject.toml / package.json 등 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
   ```

2. **카테고리 6 (자동화) 표** (rubric.md line 134-135) — v1.18b 누락 보강:

   ```
   | Docker / 컨테이너화 | 2 | Dockerfile 등 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
   | 의존성 Lock 파일 | 1 | poetry.lock / package-lock.json 등 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
   ```

3. **신규 섹션 — "## N/A (Not Applicable) 정책"** (rubric.md "ROI 계산 방식" § 직전):

   ```markdown
   ## N/A (Not Applicable) 정책

   일부 체크는 repo 성격상 본질적으로 부적합하다 (예: dotfiles repo의 Dockerfile,
   shell/markdown-only repo의 패키지 매니페스트). 이 경우 false negative 감점을 막기
   위해 자동 만점 + N/A flag 부여 후 HTML 대시보드 ℹ️ icon으로 시각 구분한다.

   ### N/A 진입 조건 (4 조건 AND — `is_shell_markdown_only_repo`)

   1. lang ∉ {Python, TypeScript, JavaScript, Go, Rust, Java, Kotlin, C#, Ruby, Swift}
   2. 빌드 매니페스트 (package.json/Cargo.toml/go.mod/build.gradle*/pom.xml) **부재**
   3. pyproject.toml 부재 OR runtime deps 비어있음 (tomllib 우선 + regex fallback)
   4. 빌드 소스 파일 (.py/.ts/.go/.rs/.java/.kt/.cs/.rb/.swift) 개수 **< 5**

   ### 적용 체크 (3건)

   | 카테고리 | 체크 | 적용 세션 |
   |---------|-----|---------|
   | 자동화 | Docker / 컨테이너화 | v1.18b |
   | 자동화 | 의존성 Lock 파일 | v1.18b |
   | 코드 구조 | 패키지 매니페스트 | v1.18c |

   다른 체크에 N/A 확장은 evidence-driven 후속 (v1.18f+ 예정).
   ```

**효과**:

- rubric spec ↔ score_codebase.py 동작 정합화 (drift 제거)
- 향후 N/A 진입 조건/적용 체크 추가 시 단일 소스
- 사용자가 "Docker 없는데 만점?" 의문 시 rubric.md 참조 가능

### R4 — 8 유형 회귀 case table 정성 검증

| Repo 유형 | lang | 매니페스트 | runtime deps | 빌드소스 | 헬퍼 | manifest 체크 | 변동 |
|---------|------|----------|------------|--------|:----:|:------------:|:----:|
| harness-meta | Md | pyproject.toml | 0 | 0 | True | manifest=True → 기존 만점 | 0 |
| 순수 dotfiles | Sh | 부재 | — | 0 | True | manifest=False + 헬퍼 True → **N/A +3** | **+3** |
| Hugo blog | Md/Yaml | 부재 | — | 0 | True | manifest=False + 헬퍼 True → **N/A +3** | **+3** |
| Astro blog | Md | package.json | 있음 | 일부 | False (조건 2) | manifest=True → 기존 만점 | 0 |
| Python app | Python | pyproject.toml | 있음 | >5 | False (조건 1) | manifest=True → 기존 만점 | 0 |
| TS app | TypeScript | package.json | 있음 | >5 | False (조건 1) | manifest=True → 기존 만점 | 0 |
| 작은 Python script | Python | pyproject.toml | 0 | 1-4 | False (조건 1) | manifest=True → 기존 만점 | 0 |
| empty placeholder | Unknown | 부재 | — | 0 | True | manifest=False + 헬퍼 True → **N/A +3** | **+3** |

→ False positive 0. 의도된 3 유형(dotfiles/blog/empty)만 +3. v1.18b와 정확히 동일한 4 유형 매트릭스 (meta는 manifest=True로 자연 차단).

## 3. 변경 대상 (2 수정 + 2 신규)

### 수정 (2)

| 경로 | scope | 변경 | 라인 수 |
|------|------|------|------|
| `bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py` | S1c | score_code_structure() line ~440~451 패키지 매니페스트 분기에 `is_shell_markdown_only_repo` 호출 + N/A 분기 추가 | ~15 lines |
| `bootstrap/skills/ai-ready-scorer/references/rubric.md` | S1c | (a) 코드 구조 § 패키지 매니페스트 행 N/A 표기 / (b) 자동화 § Docker/Lock 행 N/A 표기 (v1.18b 누락 보강) / (c) "N/A 정책" 신규 § (4 조건 AND + 적용 체크 3건 표) | ~30 lines |

### 신규 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.18c-scorer-package-manifest-na/PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.18c-scorer-package-manifest-na/REPORT.md` | meta | Stage F — 결과 + Lessons |

## 4. 목표 / 진행 체크박스

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 + Scope inheritance + Out of scope
- [x] **사용자 진입 확인** (디테일 검증 완료 — context7 외부 spec + 7 코드 무결성 + rubric drift 보강 1건)
- [ ] Stage A — score_code_structure 패키지 매니페스트 분기 적용
- [ ] Stage B — rubric.md 갱신 (코드 구조 § + 자동화 § + N/A 정책 신규 §)
- [ ] Stage C — harness-meta 재스코어 → 코드 구조 13/15 유지 (회귀 0) + 전체 93/100 유지
- [ ] Stage D — 8 유형 case table 정성 검증 (PLAN R4 표)
- [ ] Stage E — REPORT.md 작성
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] score_code_structure 패키지 매니페스트 분기에 `is_shell_markdown_only_repo` 호출 추가
- [ ] manifest 부재 + 헬퍼 True 시 `na=True`, score=3, max_score=3, detail에 "N/A" 명시
- [ ] **harness-meta 회귀 0**: 코드 구조 12/15 유지 (v1.19 이관 부수효과로 13→12 변동, 본 세션 무관), 전체 92/100 유지, 다른 6 카테고리 변동 0
- [ ] manifest=True 분기 (pyproject.toml 보유 시) 기존 동작 유지
- [ ] manifest=False + 헬퍼 False (Python app 매니페스트 누락 등) 시 기존 0점 유지 (감점 보존)
- [ ] JSON output: N/A 진입 시 `"na": true` 필드 존재
- [ ] HTML 대시보드: N/A 진입 시 ℹ️ icon (v1.18b D 패치 재사용 — 본 세션 추가 패치 불요)
- [ ] **rubric.md 정합화**: 코드 구조 § + 자동화 § + N/A 정책 § (v1.18b 누락분 + v1.18c 신규)

## 6. 위험 / 제약

| 위험 | 영향 | 완화 |
|------|------|------|
| 헬퍼 4 조건 변경으로 false positive | shell-only repo 외 repo 오분류 | R1 — v1.18b 헬퍼 재사용. 변경 없음 |
| harness-meta 실수 변동 | 코드 구조 점수 흔들림 | manifest=True 분기 우선 → 자연 차단 |
| Python script repo (manifest 누락 + 빌드소스<5) 오분류 | 정상 Python repo가 N/A로 진입 | 조건 1 lang 화이트리스트 차단 ✓ |
| Multi-repo 실 검증 부재 | 미발견 false positive 가능 | 8 유형 case table 정성 + v1.18e 후속 실행 검증 |

## 7. 커밋 전략

```
feat(meta): sessions/meta/v1.18c-scorer-package-manifest-na — 패키지 매니페스트 N/A 분기 + rubric drift 정합화

- update: bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py
  - score_code_structure() 패키지 매니페스트 분기에 is_shell_markdown_only_repo 호출 추가
  - manifest=False + 헬퍼 True 시 na=True, score=3, max_score=3 자동 만점
- update: bootstrap/skills/ai-ready-scorer/references/rubric.md
  - 코드 구조 § 패키지 매니페스트 행에 N/A 정책 cross-ref
  - 자동화 § Docker/Lock 행에 N/A 정책 cross-ref (v1.18b 누락 보강)
  - "N/A 정책" 신규 § (4 조건 AND + 적용 체크 3건 표)
- add: sessions/meta/v1.18c-scorer-package-manifest-na/{PLAN,REPORT}.md

Scope: 코드 구조 카테고리 "패키지 매니페스트" 단일 체크 + rubric.md spec 정합화.
- v1.18b is_shell_markdown_only_repo 헬퍼 재사용 (4 조건 AND)
- v1.18b 누락 (rubric drift) 보강
- harness-meta 회귀 0: pyproject.toml 보유 → manifest=True 분기 → 변동 0
- shell-only repo (dotfiles/hugo blog/empty)에서만 +3 효과

Context7 검증:
- Python tomllib stable + TOMLDecodeError → try/except 흡수 (v1.18b 패턴 재사용)
- Claude Code Skills SKILL.md.description은 trigger 용도 → frontmatter 갱신 불요

Lessons:
- L1 — N/A 헬퍼는 카테고리 간 재사용 (자동화 v1.18b → 코드 구조 v1.18c)
- L2 — manifest=True 분기 우선 → harness-meta 자연 회귀 0
- L3 — v1.19 이관 후 첫 변경 — git 추적 위치 (bootstrap/skills/) 영구 보존
- L4 — Spec drift 사전 감지 — rubric.md ↔ score_codebase.py 정합화 (v1.18b 누락분 동시 보강)

후속 분기:
- v1.18d: stdout cp949 encoding fix
- v1.18e: HTML 대시보드 N/A UI 정밀화 + multi-repo 회귀 sample 실 실행
- v1.18f+: 다른 카테고리 N/A 확장 (evidence-driven)
```

## 8. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.18d-scorer-stdout-encoding` | Windows cp949 stdout emoji UnicodeEncodeError fix (`sys.stdout.reconfigure(encoding='utf-8')` 1줄) |
| `v1.18e-scorer-html-na-ui` | HTML 대시보드 N/A 카드 정밀 시각화 (별도 색상·툴팁·필터) + multi-repo 회귀 sample 실 실행 |
| `v1.18f-scorer-other-na-categories` | Documentation·Test·Context layer·Type safety 카테고리 N/A 분기 (evidence-driven) |

## 9. Lessons Forward (예상)

- **L1 — N/A 헬퍼는 카테고리 간 재사용 패턴**: v1.18b의 `is_shell_markdown_only_repo` 4 조건 AND를 자동화 → 코드 구조로 재사용. 헬퍼 단일 소스 + 호출 사이트만 카테고리별 추가. 데이터 모델 (`Check.na`) + UI 패치(HTML icon) 모두 v1.18b가 이미 인프라 제공
- **L2 — manifest=True 분기 우선이 harness-meta 자연 회귀 0 보장**: pyproject.toml 보유 repo는 N/A 분기 진입 전에 기존 만점 분기로 흡수. shell-only repo만 N/A 효과 발현. 의도된 동작 + 회귀 위험 0
- **L3 — v1.19 이관 후 첫 실 변경**: score_codebase.py가 `bootstrap/skills/`(git 추적)에 있어 변경분 영구 보존. v1.18b의 "dotfiles 백업 안내" 우려 해소 — v1.19 이관의 직접 가치
- **L4 — Spec drift 사전 감지의 가치**: 디테일 분석 단계에서 v1.18b가 rubric.md를 갱신하지 않은 drift 발견 → 본 세션에 보강 흡수. 동작-spec 정합화 의무를 매 세션 PLAN review의 표준 항목화 권고. context7 검증 (외부 spec) + 내부 spec 검토 (rubric/SKILL/CLAUDE) 양쪽 의무
