# meta v1.33-fix-scope-contract — REPORT

세션 종료: 2026-04-29
PLAN: [`PLAN.md`](PLAN.md)

## 최종 결과

- **수정 파일**: 2 (`tests/smoke-scope-contract.sh` 전면 재작성 + `bootstrap/docs/OWNERSHIP.md` cross-ref 1줄)
- **신규 기능**: `--fix` mode (idempotent + dry-run + path positional + help) + enumerate 자동 흡수 (glob 패턴)
- **세션 기록**: 2 (PLAN.md + 본 REPORT.md)
- **smoke 결과**: PASS=66 / FAIL=0 (default), PASS=62 / FAIL=0 (--fix --dry-run no-op all)
- **회귀**: 0 (smoke-spec-verification 77 / bash-permission 6/6 / thinking-effort 5/5 / language-overlay 11)

## 구현 요약

### Stage A — `tests/smoke-scope-contract.sh` 전면 재작성 ✅

신규 코드 ~150 lines (기존 ~100 → 신 ~250):
- argv parsing (`--fix` / `--dry-run` / `--help` / positional path) — v1.29 패턴 답습
- `read -r -d '' SCOPE_INHERITANCE_SKELETON / OUT_OF_SCOPE_SKELETON <<'SKELETON_EOF'` — 2 heredoc skeleton (OWNERSHIP.md §Scope contract verbatim 정합)
- `fix_section()` 함수 — idempotent + anchor lookup + dry-run + indirect variable expansion `${!skeleton_var}` (C4)
- `fix_file()` 함수 — 두 § 순차 처리 + dry-run 두 § 모두 부재 통합 메시지 (D1)
- `enumerate_plans()` 함수 — glob 자동 흡수 + associative array dedup (C5, D3 안전장치)

### Stage B — Enumerate 자동 흡수 ✅

기존 hardcode list (v1.10h~v1.29 21 row) → glob 패턴 5건:
- `v1.10h*` (v1.10h, v1.10h2, v1.10h3)
- `v1.10j*` (v1.10j)
- `v1.1[1-9]*` (v1.11~v1.19 + suffix)
- `v1.[2-9][0-9]*` (v1.20~v1.99)
- `v[2-9].*` (향후 v2+)

→ v1.30/v1.31/v1.32/v1.33 자동 흡수 + 향후 PLAN 자연 흡수. v1.10b~v1.10g 면제 정합 (Scope contract 도입 이전).

### Stage C — `OWNERSHIP.md` cross-ref ✅

§Scope contract 끝 (`### Spec verification (context7) §` 직후)에 `### Smoke --fix mode (v1.33+)` 1줄 추가. v1.29 패턴 답습 명시.

### Stage D — Self-test ✅

```
default smoke:
=== 결과: PASS=66 FAIL=0 SKIP=0 ===
v1.30/v1.31/v1.32/v1.33 모두 검사됨 (각 2 § = 8건 추가)

--fix --dry-run:
=== 결과 (--fix): PASS=62 FAIL=0 SKIP=0 ===
모든 PLAN '이미 존재 (no-op)' (idempotent ✓)

--help:
Usage: ... 정상 출력

실 fix (fixture):
✓ 'Scope inheritance' skeleton 삽입 (line 7)
✓ 'Out of scope' skeleton 삽입 (line 16)
삽입된 skeleton에 TODO placeholder 6건 (사용자 채움 대기)
```

### Stage E — REPORT.md 작성 ✅

본 파일.

## 판정

PLAN 7 성공 기준:
- [x] `tests/smoke-scope-contract.sh --help` usage 출력 정상
- [x] `--fix --dry-run` 모든 PLAN no-op (idempotent 정합)
- [x] default smoke enumerate 확장 v1.30/v1.31/v1.32/v1.33 흡수 + PASS=66
- [x] enumerate dedup associative array — 중복 매치 0건 (D3 검증)
- [x] `OWNERSHIP.md` cross-ref 1줄 추가
- [x] 회귀 0 (4 smoke 모두 PASS 유지)
- [x] self-test: 본 v1.33 PLAN enumerate 흡수 + PASS

**전체 PASS**.

### 한계 (cosmetic, 별 후속 가능)

- 두 § 사이 빈 줄 1개 부재 (heredoc `read -r -d ''` 동작 — leading newline trim). markdown parser 정상 인식하나 가독성 minor. 별 후속 evidence-driven (사용자 불만 누적 후)

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | /websites/gnu_software_bash_manual_html_node |
| **topic** | shift / case-esac / argv positional / heredoc / errexit-conditional / indirect-expansion / associative-array |
| **findings** | no new findings |
| **drift** | no — Stage A 구현 시 PLAN R1 코드와 동일. v1.29 spec C1~C3 + 신규 C4 (`${!skeleton_var}`) + C5 (`declare -A seen`) 모두 GNU Bash 정합. 실 fix 동작 검증 완료 |
| **re-verify** | smoke argv 분기, skeleton 본문, fix_section 함수, dedup 알고리즘 변경 시 |

**Citations** (no new findings — PLAN C1~C5 그대로 유지):
- C1 — `shift` builtin (PLAN 참조)
- C2 — `case` alternation (PLAN 참조)
- C3 — errexit-conditional (PLAN 참조)
- C4 — Indirect parameter expansion `${!parameter}` (PLAN 참조)
- C5 — `declare -A` associative array (PLAN 참조)

## Lessons Learned

### L1 — `--fix` mode 패턴 v1.29 → v1.33 즉시 재사용 검증

v1.29-verify-fix-mode에서 도입한 `--fix`/`--dry-run`/`--help`/argv parsing/Idempotent/heredoc skeleton 패턴이 본 v1.33에서 거의 그대로 답습 가능. 차이는:
- 두 § 처리 (Scope inheritance + Out of scope) — `fix_section` 함수 분리 + `fix_file` 통합
- Indirect variable expansion `${!skeleton_var}` — skeleton 변수 동적 선택 (2건 이상 일반화)

→ 향후 `v1.33b-fix-bash-permission` 도입 시도 동일 패턴 답습 가능. **재사용 mechanism = 도구 인프라**. v1.31 ROADMAP §1-2 "trigger 종류 5분류" 외 도구 차원 인프라 가치 입증.

### L2 — Enumerate hardcode → glob 자동 흡수 트레이드오프

기존 hardcode list (v1.10h~v1.29 21 row) 매 PLAN 추가 의무 → 사용자 부담 + drift risk (v1.30/v1.31/v1.32 검증 빠짐). glob 패턴 5건으로 자동 흡수 → 부담 0 + 자연 검증.

**트레이드오프**:
- glob 자동 흡수 = 향후 폐기/변경 PLAN 처리 시 동결 정책 evidence 필요 (현재 evidence 0)
- v1.10b~v1.10g 같은 면제 대상은 명시적 glob 외 (v1.10h*/v1.10j*만 매치) — 정합

### L3 — Skeleton 양쪽 hardcode (smoke + OWNERSHIP.md verbatim)

v1.29 SPEC_SKELETON 동일 우려. SCOPE_INHERITANCE_SKELETON / OUT_OF_SCOPE_SKELETON 본문 = OWNERSHIP.md §Scope contract 표 본문 hardcode. drift 가능성. sentinel 검증은 drift 발생 evidence 후 별 세션 (v1.33c-skeleton-sentinel).

### L4 — Heredoc `read -r -d ''` leading newline trim

skeleton 시작 빈 줄이 `read -r -d ''`에서 trim → 두 § 사이 빈 줄 1개 부재. markdown parser는 정상 인식하나 cosmetic 결함. printf '%s\n\n' 사용 또는 skeleton 끝 명시 빈 줄 추가로 해결 가능. 본 세션 scope 외 (별 후속).

## 다음 후보 (보류)

### 본 v1.33 후속 (evidence-driven)

| 후속 세션 | 조건 |
|---------|------|
| `v1.33b-fix-bash-permission` | smoke-bash-permission-pattern.sh `--fix` mode. evidence 누적 (SKILL/agent 신설 빈도 증가, 현 v1.10g 이후 1건만) |
| `v1.33c-skeleton-sentinel` | smoke skeleton ↔ OWNERSHIP.md verbatim drift 자동 감지. drift 발생 evidence 후 |
| `v1.33d-cosmetic-fix` | 두 § 사이 빈 줄 1개 보장 (printf '%s\n\n' 또는 skeleton 끝 명시 빈 줄). 사용자 불만 evidence 후 |
| `v1.33e-todo-detection` | smoke가 TODO placeholder 잔존 시 WARN. `--fix` 후 사용자 채움 누락 evidence 후 |

### v1.31 ROADMAP §2 진행 가능 3건 (v1.34~v1.36)

| 우선순위 | 후속 세션 | 진행 근거 |
|:-:|---------|---------|
| 3 | `v1.34-legacy-plan-migration` (= v1.10j2) | 25+ legacy PLAN soft migration |
| 4 | `v1.35-scorer-other-na-categories` (= v1.18f) | harness-meta self-eval 활용 |
| 5 | `v1.36-skills-categories` (= v1.22) | 5번째 skill 추가 동시 진행 |

### v1.31 ROADMAP archive 갱신 권장 (별 작업)

본 v1.33 완료로 §9 archive에 row 추가:
> `✅ v1.29b-fix-other-smokes (v1.33-fix-scope-contract, 2026-04-29) — smoke-scope-contract --fix mode + enumerate 자동 흡수`

§2 #3 row를 archive로 이관.
