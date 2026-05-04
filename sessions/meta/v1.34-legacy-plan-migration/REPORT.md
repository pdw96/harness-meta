# meta v1.34-legacy-plan-migration — REPORT

세션 종료: 2026-04-30
PLAN: [`PLAN.md`](PLAN.md)

## 최종 결과

- **수정 파일**: 3 (`tests/smoke-scope-contract.sh` ~80 lines 추가 + `bootstrap/docs/OWNERSHIP.md` 레거시 § 6줄→24줄 expand + `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` §2 #2 archive 이관 + §5/§9 갱신)
- **신규 기능**: `--include-legacy` opt-in flag (default 호출 영향 0) + `is_anchor_missing()` G1 명시 SKIP + R-WARP 4종 경고 단일 소스화
- **세션 기록**: 2 (PLAN.md + 본 REPORT.md)
- **smoke 결과**:
  - default: PASS=68 / FAIL=0 (회귀 0, v1.34 PLAN 추가로 +2)
  - `--include-legacy`: PASS=68 / FAIL=42 (G2 legacy 21건 두 § 부재 가시화) / SKIP=2 (G1 anchor 부재)
  - `--fix --dry-run`: PASS=64 / FAIL=0 (모두 no-op)
  - `--include-legacy --fix --dry-run`: PASS=85 / FAIL=0 / SKIP=2 (G2 21건 plan + G1 2건 SKIP)
- **회귀**: 0 (smoke-spec-verification 86 / smoke-bash-permission 6/6 / smoke-thinking-effort 5/5 / smoke-language-overlay 11)
- **실 legacy § 삽입**: 0 (Out of scope 정합 — 사용자 자율 영역)

## 구현 요약

### Stage A — `tests/smoke-scope-contract.sh` 신규 코드 ✅

신규 코드 ~80 lines 추가:

- argv parsing: `--include-legacy` 분기 추가 (case 안)
- `ANCHOR_MISSING_LEGACY` 정적 list (2건: v1.0/v1.1) + `is_anchor_missing()` 함수
- `fix_file()` 진입 시 G1 명시 SKIP 분기 (사용자 수동 의무 안내)
- `enumerate_plans()` `INCLUDE_LEGACY` 분기: legacy 23건 glob 7개 추가 (v1.0/v1.1/v1.2-9/v1.[2-9][a-z]/v1.10/v1.10[a-g]/v1.10[a-g][0-9]+)
- `check_plan()` G1 명시 SKIP (Stage 1 검증에서도 가시화)
- Stage 1 헤더 INCLUDE_LEGACY 분기 표기
- Help 텍스트 `--include-legacy` § + R-WARP 경고 추가

### Stage B — `bootstrap/docs/OWNERSHIP.md` 갱신 ✅

§Scope contract `### 레거시 세션` § 6줄 → 24줄 expand:

- v1.10h vs v1.10j inconsistency cosmetic clarification (1차 demo로 자연 PASS 명시)
- `--include-legacy` opt-in pathway § 신설 (사용 예시 2건)
- G1 (2건) / G2 (21건) 분류 명시
- ⚠️ R-WARP 4종 경고 표 (의미 단절 / TODO 영구 잔존 / chain head anchor 부재 / 역사 왜곡)
- 도입 세션 cross-ref + v1.27 LEGACY_REPORTS / v1.33 `--fix` 인프라 답습 명시

### Stage C — `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` archive 이관 ✅

- §2 #2 row를 archive 표기 (~~strikethrough~~ → `v1.34` 완료) + 도구 인프라만 / 실 § 삽입은 별 후속 evidence-driven 명시
- §5 권장 진행 순서 #1/#2/#3 strikethrough (모두 완료, archive 매핑)
- §8 확정 세션 v1.34 row 추가
- §9 archive table v1.34 row 추가 (산출 요약)

### Stage D — Self-test ✅

```
default smoke (no flag):
=== 결과: PASS=68 FAIL=0 SKIP=0 ===     (v1.10h+ 34 PLAN × 2 § = 68. v1.34 +2)

--include-legacy:
=== 결과: PASS=68 FAIL=42 SKIP=2 ===
  - PASS=68: v1.10h+ 34건 × 2 § (그대로)
  - FAIL=42: G2 legacy 21건 × 2 § (Scope inheritance + Out of scope 모두 부재)
  - SKIP=2: G1 v1.0/v1.1 anchor 부재 명시

--fix --dry-run (default):
=== 결과 (--fix): PASS=64 FAIL=0 SKIP=0 ===     (검증 stage 2/3 진입 안 함, fix only)

--include-legacy --fix --dry-run:
=== 결과 (--fix): PASS=85 FAIL=0 SKIP=2 ===
  - PASS=85: G2 21건 fix plan + v1.10h+ 32건 × 2 § no-op = 21 + 64 = 85
  - SKIP=2: G1 v1.0/v1.1 SKIP

--help:
Usage 정상 + --include-legacy § + R-WARP 경고 출력 ✓

회귀 4 smoke (모두 PASS 유지):
- smoke-spec-verification: PASS=86 (그대로)
- smoke-bash-permission-pattern: 6/6 ✓
- smoke-thinking-effort: 5/5 ✓
- smoke-language-overlay: 11/0 ✓
```

### Stage E — REPORT.md 작성 ✅

본 파일.

## 판정

PLAN 8 성공 기준:

- [x] `tests/smoke-scope-contract.sh --help` `--include-legacy` 안내 추가
- [x] default smoke (no flag): PASS=68 + FAIL=0 (회귀 0, v1.34 PLAN +2)
- [x] `--include-legacy` 단독: enumerate 56 + Stage 1 FAIL 다수 (legacy 두 § 부재 명시)
- [x] `--include-legacy --fix --dry-run`: G2 21건 plan 출력 + G1 2건 SKIP (anchor 부재 사유)
- [x] OWNERSHIP.md §Scope contract `### 레거시 세션` 갱신 (cosmetic clarification + opt-in pathway + R-WARP 경고 + G1 명시 + 사용자 자율 영역)
- [x] EVIDENCE_DRIVEN_ROADMAP.md §2 #2 archive 이관 + §5 권장 순서 갱신 + §9 archive row 추가
- [x] 회귀 0 — 4 smoke 모두 PASS 유지
- [x] 실제 legacy 23건 § 삽입 0 (Out of scope 정합)

**전체 PASS**.

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | /websites/gnu_software_bash_manual_html_node |
| **topic** | argv parsing / case-esac / arithmetic conditional `[ -lt ]` / arrays / shopt nullglob |
| **findings** | no new findings |
| **drift** | no — Stage A 구현 시 PLAN R1/R2 코드와 동일. v1.33 spec C1~C5 + v1.27 LEGACY_REPORTS 패턴 답습. SKILL `harness-plan-verify` 직접 query 1회 (max 3 budget 1/3 사용) 결과 정합 검증 완료. case alternation `pattern \| pattern`, `declare -A` associative array 모두 GNU Bash spec 정합 |
| **re-verify** | smoke argv 분기 추가 / is_anchor_missing 알고리즘 변경 / OWNERSHIP.md §Scope contract 갱신 시 |

**Citations** (no new findings — PLAN C1~C5 + 본 SKILL 직접 검증 1건):

- C1 — `shift` builtin (PLAN 참조)
- C2 — `case` alternation: `case word in [pattern | pattern]...` (PLAN 직접 검증, Source: gnu.org/.../Conditional-Constructs.html)
- C3 — errexit-conditional `[ -lt ]` (PLAN 참조)
- C4 — Indirect parameter expansion `${!parameter}` (v1.33 그대로)
- C5 — `declare -A` associative array (PLAN 직접 검증, Source: gnu.org/.../Arrays.html)

## Lessons Learned

### L1 — v1.10j "점진 마이그레이션" 분리 결정 정합성 입증

v1.10j PLAN Out of scope에서 "기존 모든 sessions PLAN.md 소급 갱신 (legacy 25+ 세션) | 후속 세션 — 점진 마이그레이션"으로 분리한 결정이 6개월 경과 후 본 v1.34에서 자연스럽게 후속 진행. **"점진"** = "한 번에 모두 하지 않는다" 의 핵심 의미가 v1.34에서 도구 인프라만 도입 + 실 적용은 사용자 자율로 분리하는 패턴으로 구체화. evidence-driven 분리 원칙의 valid case study.

### L2 — v1.27/v1.33 패턴 답습 — "도구 차원 인프라" 메커니즘 입증

v1.27 (`smoke-spec-verification.sh` LEGACY_REPORTS) → v1.33 (`smoke-scope-contract.sh --fix`) → v1.34 (`smoke-scope-contract.sh --include-legacy`) 3 세션이 모두:

- argv parsing 동일 패턴 (case 분기)
- 정적 list + 동적 함수 (is_legacy_*, is_anchor_missing)
- glob enumerate + dedup (declare -A)

→ smoke 인프라가 **재사용 mechanism**으로 정착. 향후 smoke 추가 시 동일 답습 가능. v1.31 ROADMAP "trigger 종류 5분류" 외 **도구 차원 인프라 가치**가 v1.33 L1 가설 → v1.34에서 cross-validated.

### L3 — R-WARP 4종 명시화의 보호 가치

R-WARP1 (의미 단절) / R-WARP2 (TODO 영구 잔존) / R-WARP3 (chain head anchor 부재) / R-WARP4 (역사 왜곡). PLAN 사전 분석에서 도출된 4종이 OWNERSHIP.md `### 레거시 세션` § 표로 단일 소스화 → 향후 사용자 또는 Claude가 "legacy retroactive 적용" 시점에 자동 참조 가능. **"왜 도구만 만들고 적용은 안 하는가?"** 질문에 대한 즉시 답변 가능.

### L4 — chain head edge case 패턴화

v1.0-bootstrap (선행 세션 부재 — 첫 세션) + v1.1-global-smoke-test (선행 v1.0이 § 부재 chain) = 모든 마이그레이션 도구의 본질적 chain head 문제. `is_anchor_missing()` 정적 list 명시화로 silent fail 회피 + 사용자 의무 명시. 향후 다른 chain head 도구 (예: project 세션 v1.0-project-claude-install legacy migration)도 동일 패턴 답습 가능.

### L5 — Default 회귀 0 보장 메커니즘

`INCLUDE_LEGACY=0` default + opt-in flag만 raw[]에 legacy glob 추가하는 구조 → default 호출 (검증 + `--fix`) 영향 0. v1.31 ROADMAP "soft migration risk 0" 주장이 본 구현에서 실증. **flag 추가 = 기능 추가 ≠ 기존 동작 변경** 원칙 정합.

## 다음 후보 (보류)

### 본 v1.34 직접 후속 (evidence-driven)

| 후속 세션 | 조건 |
|---------|------|
| `v1.34b-anchor-fallback` | G1 2건 anchor 자동 추가 메커니즘. evidence: 사용자가 G1도 § 적용 요청 |
| `v1.34c-project-plan-legacy` | `sessions/upbit/v1.0~v1.2` 등 project 세션 PLAN legacy migration. evidence: 프로젝트 측 사용자 요구 |
| `v1.34d-actual-legacy-fix` | legacy 23건 실 § 삽입 (Source — 사용자 발의 retroactive 형식). evidence: 사용자 명시 trigger + 22 PLAN 분석 자원 확보 |

### v1.31 ROADMAP §2 진행 가능 잔여 2건 (v1.35~v1.36)

| 우선순위 | 후속 세션 | 진행 근거 |
|:-:|---------|---------|
| 4 | `v1.35-scorer-other-na-categories` (= v1.18f) | harness-meta self-eval 활용 |
| 5 | `v1.36-skills-categories` (= v1.22) | 5번째 skill 추가 동시 진행 |

### v1.33 후속 (smoke-bash-permission `--fix`)

| 후속 세션 | 조건 |
|---------|------|
| `v1.33b-fix-bash-permission` | smoke-bash-permission-pattern.sh `--fix` mode. v1.33 L1에서 evidence 누적 (SKILL/agent 신설 빈도) 후 별 진행 |
| `v1.33c-skeleton-sentinel` | smoke skeleton ↔ OWNERSHIP.md verbatim drift 자동 감지 |
