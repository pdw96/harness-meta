# Evidence-driven Roadmap — 후속 세션 분류 단일 소스

`sessions/meta/v1.31-evidence-driven-roadmap/`에서 확정 (2026-04-29 audit 기준). 본 repo의 v1.10 ~ v1.30 세션이 누적해온 **evidence-driven 후속 세션 23건**의 통합 view.

각 도메인 docs (`OVERLAY.md`, `SKILLS.md`, `SPEC_VERIFICATION.md`, `OWNERSHIP.md`)는 자기 도메인 후속만 명시한다. 본 docs는 **횡단 통합 view** — "지금 진행 가능한 것?", "어떤 trigger 대기 중?" 답을 단일 grep으로 제공.

## 1. 개요 — Evidence-driven 패턴

### 1-1. 정의

evidence-driven 후속이란 **외부 trigger (사용자 등장 / 회귀 / 환경 변화 등) 발생 시점부터 진행 가능**한 세션을 의미한다. v1.10e REPORT L3에서 패턴 정착:

> "evidence가 후속 동기 자연 유도 — sample T1 추출률 0% 명시 → 사용자가 한계 인지 → v1.10e2 채택 결정 자연 유도. evidence-driven 후속 분기"

### 1-2. 분류 방법론 (Trigger 종류 5분류)

| 종류 | trigger 발생 메커니즘 | schedule 등록 가능? |
|------|----------------------|:-:|
| **A** 외부 사용자 등장 | 사용자가 명시적으로 도입/사용 요청 | ❌ (자동 감지 불가) |
| **B** 회귀/장애 evidence | verify.ps1/sh 실패, install fail 등 | ⚠️ (CI hook 등록 가능) |
| **C** 외부 환경 변화 | PyPI unpublish, upstream archived 등 | ✅ (정기 점검 가능) |
| **D** 설계 결정 선행 | 타입 안전성 redesign 등 prerequisite | ❌ (시간 trigger 아님) |
| **E** 정규화 우선순위 미달 | 사용자 사례 누적 (3+) | ❌ (사용자 입력 시점만) |

### 1-3. 임계 도달 인식

evidence 누적 임계는 각 후속 세션 정의 시점에 명시되며 (예: `evidence 3+ 사례`), 임계 도달 시 "진행 가능"으로 promote.

## 2. 진행 가능 1건 (임계 도달 또는 self-evidence 충족)

| # | 후속 세션 | 카테고리 | 진행 근거 | 출처 |
|:-:|---------|---------|---------|------|
| 1 | ~~REPORT § cross-file 일관성 검증~~ → **`v1.32` 완료 (2026-04-29)** | spec-verification | Archive §9 참조 | `v1.32 REPORT` |
| 2 | ~~`v1.10j2-legacy-plan-migration`~~ → **`v1.34-legacy-plan-migration` 완료 (2026-04-30)** (도구 인프라만 — `--include-legacy` opt-in flag; 실 legacy § 삽입은 별 후속 evidence-driven) | scope-contract | Archive §9 참조 | `v1.34 REPORT` |
| 3 | ~~`v1.29b-fix-other-smokes`~~ → **`v1.33-fix-scope-contract` 완료 (2026-04-29)** (smoke-scope-contract만; smoke-bash-permission `v1.33b` 후속) | smoke `--fix` | Archive §9 참조 | `v1.33 REPORT` |
| 4 | ~~`v1.18f-scorer-other-na-categories`~~ → **`v1.35-scorer-other-na-categories` 완료 (2026-04-30)** | ai-ready-scorer | Archive §9 참조 | `v1.35 REPORT` |
| 5 | **`v1.22-skills-categories`** | skills-distribution | 현 4 skill (ai-ready-scorer/mindvault/developer-profile/harness-plan-verify). 5번째 skill 추가와 동시 진행 시 자연 evidence | `SKILLS.md`, `v1.19 REPORT` |

## 3. 진행 불가 26건 — Trigger 종류별

### 3-A. 외부 사용자 등장 의존 (9건)

| 후속 세션 | Trigger 조건 | 출처 |
|---------|------------|------|
| `v1.11b-overlay-python-skill` | Python 사용자 1+ 등장 | `OVERLAY.md` |
| `v1.11c-overlay-typescript` | TS 사용자 등장 | `OVERLAY.md` |
| `v1.11c+`-overlay-go | Go 사용자 등장 | `OVERLAY.md` |
| `v1.11c+`-overlay-rust | Rust 사용자 등장 | `OVERLAY.md` |
| `v1.11c+`-overlay-java | Java 사용자 등장 | `OVERLAY.md` |
| `v1.11c+`-overlay-kotlin | Kotlin 사용자 등장 | `OVERLAY.md` |
| `v1.11c+`-overlay-csharp | C# 사용자 등장 | `OVERLAY.md` |
| `v1.18i-package-promotion` (`__init__.py` + `python -m`) | 외부 scorer 사용자 등장 | `v1.18g REPORT` |
| `v1.28b-anthropic-sdk-source` | claude-api skill 활용 evidence 누적 (Anthropic SDK 매트릭스 등재) | `v1.28 REPORT` |

⚠️ Schedule 등록 불가 — 사용자 등장은 외부 명시 요청만 trigger. 본 docs grep 또는 README "Language overlay" § 안내로 사용자 onboarding 시점 인지.

### 3-B. 회귀/장애 evidence 의존 (7건)

| 후속 세션 | Trigger 조건 | 출처 |
|---------|------------|------|
| `v1.15c-ci-windows-runner` | install-project-claude.ps1 회귀 의심 evidence (verify.ps1 실패) | `v1.15 REPORT` |
| `v1.29c-sentinel-check` (SPEC_SKELETON ↔ §2 drift) | drift 실 발생 (양쪽 hardcode 동시 갱신 누락) | `v1.29 REPORT` |
| `v1.30d-project-claude-backup-cleanup` | `<proj>/.claude/backup-<ts>/` 누적 + git status 부담 | `v1.30 REPORT` |
| `v1.30e-backup-restore-cli` | 사용자 backup 복원 요구 | `v1.30 REPORT` |
| `v1.18g3-helper-redesign` (_TOOL_DIRS 또는 비율) | scorer 10+ 파일 도달 또는 false positive evidence 누적 | `v1.18g2 REPORT` |
| `v1.18h-category-max-recalibration` | CATEGORY_META mismatch (Documentation 13 vs max 15 / Code structure 13 vs max 15) | `v1.35 REPORT`, `v1.18g2 REPORT` |
| `v1.18d2-multi-script-encoding` | 다른 글로벌 user-skill `scripts/*.py`에서 cp949 UnicodeEncodeError 재발 | `v1.18d REPORT` |

⚠️ CI hook 등록 가능 — verify 실패 시 자동 trigger. `v1.30d`는 정기 schedule 후보 (§4-3).

### 3-C. 외부 환경 변화 trigger (2건 — Schedule 후보)

| 후속 세션 | Trigger 조건 | 출처 |
|---------|------------|------|
| `vX-mindvault-self-fork` | PyPI mindvault-ai unpublish 발생 | `v1.20 REPORT` |
| `v1.20b-mindvault-alternative` | upstream archived 후 graphify 등 active alternative 사용 패턴 변화 | `SKILLS.md` |

→ 정기 schedule 등록으로 자동 감지 가능 (§4-1, §4-2).

### 3-D. 설계 결정 선행 (3건)

| 후속 세션 | Trigger 조건 | 출처 |
|---------|------------|------|
| `v1.36d-detect-language-refactor` | dict ordering 의존 제거 — "타입 안전성 역설 구조 해소" prerequisite. 설계 redesign 결정 대기 | `v1.18 REPORT`, `v1.35 REPORT L8` |
| `v1.36-scorer-typesafety-na` | 새 helper (`is_small_python_script` 등) 설계 — Type safety 카테고리 N/A 분기 | `v1.35 REPORT` |
| `v1.36b-scorer-test-pytest-na` | 새 helper 설계 — sub-3.3 pytest dead code 해소 (`is_shell_markdown_only_repo` lang #1 위배) | `v1.35 REPORT` |

### 3-E. 정규화 우선순위 미달 (4건)

| 후속 세션 | Trigger 조건 | 출처 |
|---------|------------|------|
| `v1.10i-license-case3-enhancement` | LICENSE Case 3 (T1/T2/T2.5/T3 모두 fail) evidence 3+ 누적. 현재 0건 (T3 추가로 OSS 100% 회복) | `v1.10h REPORT`, `v1.11 REPORT` |
| `v1.10i` non-SPDX 정규화 (`Apache 2.0` → `Apache-2.0`) | non-SPDX form 메타 사례 3+ 누적. 현재 1건 (Oracle `"Apache 2.0"`) | `INTERVIEW_FLOW.md`, `v1.10h2 REPORT` |
| `v1.36c-scorer-test-borderline-na` | Test borderline 2 sub (테스트/소스 비율 + CI 테스트 자동화) evidence 누적 — shell repo도 측정 가능 | `v1.35 REPORT` |
| `v1.18e-scorer-html-na-ui` | HTML 대시보드 N/A 카드 정밀 시각화 — multi-repo 회귀 sample 또는 사용자 명시 요청 | `v1.35 REPORT` |

### 3-F. 기타 (잡): scorer/lock 사례 (Md/Shell repo 예외 처리, requirements.txt 주석 전용 lock — `v1.16/v1.18 REPORT`)는 본 분류 §3-A·E 범주에 포함. 별 row 무.

## 4. Schedule 등록 후보 3건 (cadence 근거)

evidence 발생을 **자동 감지 가능**한 항목만. 외부 사용자 등장(§3-A)은 자동 감지 불가하므로 schedule 후보 아님.

### 4-1. `mindvault-pypi-check` — **월 1회**

- **작업**: `pip index versions mindvault-ai` 또는 PyPI API → unpublish/yank 감지 시 `vX-mindvault-self-fork` trigger
- **cadence 근거**:
  - upstream archived: 2026-04-14 (확정, `SKILLS.md §7b`)
  - PyPI archived 패키지 통상 deprecation 경로: 6~24개월 내 maintainer unpublish 또는 yank
  - 주 1회 = 과잉 (PyPI 변경 일 단위 거의 없음)
  - 분기 1회 = 지연 (사용자가 `pip install` 실패 먼저 발견)
  - **월 1회** = trigger 발현 ≤ 30일 지연

### 4-2. `mindvault-alternative-survey` — **분기 1회 (3개월)**

- **작업**: graphify 등 active alternative GitHub stars/commits 활성도 모니터링 → 사용 패턴 변화 평가
- **cadence 근거**:
  - 활성 OSS 도구 통상 분기 단위 major release
  - 월 단위 변화는 noise
  - 반기 단위는 onboarding 지연 6개월
  - **분기 1회** = ecosystem shift 감지 + 작업 부담 균형

### 4-3. `project-claude-backup-audit` — **월 1회**

- **작업**: 활성 프로젝트 `.claude/backup-<ts>/` 누적 개수 측정. 임계 5+ 도달 시 `v1.30d-project-claude-backup-cleanup` trigger
- **cadence 근거**:
  - install-project-claude 재실행 빈도: 메타 세션 후 변경 시 (월 1~3회 추정, v1.21~v1.30 30일간 10 세션 = 3 install)
  - 임계 5+ 도달 = 약 5~15 install = 1~5개월
  - 주 1회 = install 시점에만 변화 → 비주 단위 점검 무의미
  - **월 1회** = 임계 도달 후 ≤ 30일 내 trigger

### 4-4. cadence 일반 원칙

1. **cadence ≤ trigger 발현 지연 허용 시간** — 사용자 영향 발생 후 1 cycle 내 검출
2. **cadence ≥ 변화 발생 주기** — 반복 동일 결과 (변화 0) noise 회피
3. **추정 기반 — 실 발생 빈도 관찰 후 조정** — 첫 cycle 결과 평가 후 cadence 단축/연장

⚠️ 위 cadence는 모두 **추정값** (Anthropic/PyPI/graphify 공식 통계 인용 0). 실 trigger 1~2회 관찰 후 사용자 판단으로 조정 권장.

## 5. 권장 진행 순서 (활성 1건 → v1.36+ 매핑, 4건 archive 이관)

| 순위 | 후속 세션 alias | 본 docs 매핑 | 진행 근거 |
|:-:|---------|------------|---------|
| 1 | ~~`v1.32-report-cross-file-consistency`~~ → 완료 (§9) | §2 #1 | "evidence 3+ 사례" 임계 도달 — spec-verification 흐름 직접 후속 |
| 2 | ~~`v1.33-fix-other-smokes` (= v1.29b 별칭)~~ → 완료 (§9) | §2 #3 | v1.29 `--fix` 패턴 즉시 재사용 |
| 3 | ~~`v1.34-legacy-plan-migration` (= v1.10j2 별칭)~~ → 완료 (§9) | §2 #2 | 25+ legacy PLAN soft migration, risk 0 |
| 4 | ~~`v1.35-scorer-other-na-categories` (= v1.18f 별칭)~~ → 완료 (§9) | §2 #4 | harness-meta self-eval 활용 |
| 5 | `v1.36-skills-categories` (= v1.22 별칭) | §2 #5 | 5번째 skill 추가와 동시 진행 시 자연 evidence |

각 세션 별 PLAN 작성 시 본 docs §2 row 내용을 PLAN의 "Scope inheritance" verbatim 인용 가능.

## 6. 갱신 정책

### 6-0. 자동 검증 (smoke-archive-sync, v1.31c+)

본 docs drift 자동 감지: `bash tests/smoke-archive-sync.sh` (v1.31c 도입).

| Stage | 검증 내용 | --fix |
|-------|---------|:---:|
| 1 | post-v1.31 메타 세션 §8 entry 존재 | ✅ skeleton 자동 삽입 |
| 2 | §2 strikethrough → §9 archive entry 일치 | ❌ content varies, manual |
| 3 | §5 stale ranks (strikethrough → §9 부재) | ❌ 사용자 판단 |
| 4 | §2 헤더 카운트 동기화 (`진행 가능 N건` ↔ 활성 row 수) | ❌ manual edit |

**호출 시점**:
- 매 메타 세션 종료 시 (REPORT.md 작성 후)
- commit 직전 (수동 또는 pre-commit hook v1.31d 후속)
- `--fix` 호출 → §8 skeleton 삽입 → 사용자 TODO 채움 → 재커밋

**LEGACY_SESSIONS skip 정책**: pre-v1.31 메타 53건은 forward-only (smoke 영구 skip). v1.27 LEGACY_REPORTS 패턴 정합.

Pre-commit hook 자동화는 [`v1.31d-precommit-archive-sync`](../../sessions/meta/v1.31d-precommit-archive-sync/) 별 후속 (evidence-driven — 망각 재발 1+ 또는 사용자 요청).

### 6-1. 진행 가능 항목 진행 시

해당 row를 `✅ 완료 (vX.Y 세션, YYYY-MM-DD)` 표기 후 **archive 섹션** (§9 신설 예정)으로 이동. §2 활성 목록 축소.

### 6-2. 신규 evidence-driven 후속 추가 시

각 메타 세션 REPORT의 "다음 후보" 섹션 작성 후 본 docs §3 또는 §4에 row 추가. **drift 회피**: 도메인 docs와 본 docs **동시 갱신 의무 부재**. 본 docs는 분류·통합 view 우선, 상세는 도메인 docs 단일 소스 유지.

### 6-3. 진행 불가 → 진행 가능 promote

trigger 발생 감지 (사용자 명시 또는 정기 schedule 결과) 시 §3 row를 §2로 이동 + 진행 근거 갱신. 임계 도달 명시 (예: "evidence 3+ 도달, sample N").

### 6-4. 갱신 stamp

본 docs는 **최신 audit 결과** 시점 명시 (현 v1.31 audit 기준). 6개월 또는 후속 세션 진행 시 갱신. 헤더 1줄 stamp 갱신.

## 7. 관련 문서

- 상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md) · [`../../README.md`](../../README.md)
- 세션 소속 (S1~S7): [`OWNERSHIP.md`](OWNERSHIP.md)
- Language overlay 후속: [`OVERLAY.md`](OVERLAY.md) §13
- 글로벌 user-skill 후속: [`SKILLS.md`](SKILLS.md) §9
- Spec verification 후속: [`SPEC_VERIFICATION.md`](SPEC_VERIFICATION.md) §10-2
- 본 docs 확정 세션: [`../../sessions/meta/v1.31-evidence-driven-roadmap/`](../../sessions/meta/v1.31-evidence-driven-roadmap/)

## 8. 확정 세션

- **v1.31** (2026-04-29) — 본 docs 신설. 23건 분류 (진행 가능 5 + 진행 불가 18 + schedule 후보 3).
- **v1.32** (2026-04-29) — §2 #1 (REPORT § cross-file 일관성 검증) 완료 → §9 archive 이관.
- **v1.33** (2026-04-29) — §2 #3 (`v1.29b-fix-other-smokes` 부분 — smoke-scope-contract `--fix` mode + enumerate 자동 흡수) 완료 → §9 archive 이관. smoke-bash-permission은 `v1.33b` 별 후속.
- **v1.34** (2026-04-30) — §2 #2 (`v1.10j2-legacy-plan-migration`) 완료 → §9 archive 이관. 도구 인프라만 (`--include-legacy` opt-in flag); 실 legacy § 삽입은 `v1.34d-actual-legacy-fix` 별 후속 evidence-driven.
- **v1.35** (2026-04-30) — §2 #4 (`v1.18f-scorer-other-na-categories` alias) 완료 → §9 archive 이관. 8 sub-checks N/A 확장 (Doc 2 + Context 2 + Test 4 — sub-3.3 dead code 제거). D1 부수 발견 → v1.18g2 분리.
- **v1.18g2** (2026-04-30) — v1.35 D1 부수 발견 후속 — helper `build_sources < 5` → `< 10` 임계 상향 (v1.18g 분할 부수 효과 보정). 6 옵션 매트릭스 비교 후 Option A2 채택. harness-meta 점수 90→93 (Docker+Lock N/A 복원). 회귀 0.
- **v1.31b** (2026-04-30) — 본 docs §2/§8/§9 archive arrears 갱신 (v1.35 + v1.18g2 누락 정정). §6-1 갱신 정책 정합.
- **v1.18d** (2026-04-30) — Windows cp949 default stdout encoding에서 emoji UnicodeEncodeError 차단. `score_codebase.py main()` 진입 직후 `sys.stdout/stderr.reconfigure(UTF-8, errors='replace')`. v1.18g2 Stage C에서 직접 evidence 관찰. 회귀 0.
- **v1.31c** (2026-04-30) — `tests/smoke-archive-sync.sh` 신설 (Stage 1~4 + Stage 1 `--fix` mode) + §3 신규 후속 8건 등재 + §5 stale 정정 + §6-0 자동 검증 정책. drift 자동 감지 워크플로우 도입.

## 9. Archive (완료 세션)

| 완료 세션 | 진행 일자 | 매트릭스 §2 row | 산출 |
|---------|---------|---------------|------|
| **`v1.32-report-cross-file-consistency`** | 2026-04-29 | §2 #1 (REPORT § cross-file 일관성 검증) | smoke Stage 7 매트릭스 9 case (5 OK + 2 FAIL + 2 WARN). `SPEC_VERIFICATION.md §11` 단일 소스. Self-test 6/6 OK |
| **`v1.33-fix-scope-contract`** | 2026-04-29 | §2 #3 (`v1.29b-fix-other-smokes` 부분) | smoke-scope-contract.sh `--fix` mode + enumerate 자동 흡수 glob 5건 (v1.10h~v1.99 + v2+). `OWNERSHIP.md` cross-ref. PASS=66 + 회귀 0. smoke-bash-permission은 `v1.33b` 후속 |
| **`v1.34-legacy-plan-migration`** | 2026-04-30 | §2 #2 (`v1.10j2-legacy-plan-migration`) | smoke-scope-contract.sh `--include-legacy` opt-in flag + `is_anchor_missing()` G1 SKIP + `OWNERSHIP.md` §Scope contract 레거시 § 갱신 (R-WARP 4종 경고). 도구 인프라만 — 실 legacy § 삽입 0 (사용자 자율 영역). default smoke PASS=68 + 회귀 0. `--include-legacy --fix --dry-run`: G2 21건 plan + G1 2건 SKIP |
| **`v1.35-scorer-other-na-categories`** | 2026-04-30 | §2 #4 (`v1.18f` alias) | 8 sub-checks N/A 확장 (Documentation 2 + Context layer 2 + Test 4 — sub-3.3 dead code 제거). categories_quality.py + categories_ops.py + rubric.md 4군데 정합화. harness-meta 변동 0 (helper=False — D1 부수 발견 → v1.18g2 분리), 8 case dynamic 시뮬레이션 통과 |
| **`v1.18g2-helper-threshold-revisit`** | 2026-04-30 | (§2 row 외 — v1.35 D1 후속) | helper `build_sources < 5` → `< 10` 임계 상향 (v1.18g `score_codebase.py` 1335줄 → 5 모듈 분할 부수 효과 보정). 6 옵션 매트릭스 (A1~A3, B TOOL_DIRS, C 제거, D 비율) 비교 후 Option A2 채택 (YAGNI + 회귀 위험 0 + 1건 evidence). harness-meta 점수 90→93 (Docker 2 + Lock 1 N/A 복원). 회귀 0 (다른 6 카테고리 변동 0) |
| **`v1.18d-scorer-stdout-encoding`** | 2026-04-30 | (§2 row 외 — v1.18g2 Stage C evidence) | Windows cp949 default stdout encoding에서 emoji UnicodeEncodeError 차단. `score_codebase.py main()` 진입 직후 `sys.stdout/sys.stderr.reconfigure(UTF-8, errors='replace')` 3중 방어 layer. 회귀 0 (점수/등급 변동 0) |
| **`v1.31b-roadmap-archive-arrears`** | 2026-04-30 | (§2 row 외 — §6-1 정책 정정) | EVIDENCE_DRIVEN_ROADMAP §2/§8/§9 archive arrears 정정 (v1.35 + v1.18g2 누락 보충). routine bookkeeping 세션 가치 명시 |
| **`v1.31c-archive-sync-automation`** | 2026-04-30 | (§2 row 외 — §6-0 정책 신설) | drift 자동 감지 워크플로우 신설. `tests/smoke-archive-sync.sh` Stage 1~4 + Stage 1 `--fix` mode. §3 신규 후속 8건 등재 (v1.18g3/v1.36/v1.36b/v1.36c/v1.18h/v1.18e/v1.18d2/v1.36d). §5 v1.35 strikethrough 정정. §6-0 자동 검증 정책 신설 |
