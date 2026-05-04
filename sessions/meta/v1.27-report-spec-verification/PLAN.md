# meta v1.27-report-spec-verification — PLAN

세션 시작: 2026-04-29
직접 선행 세션:

- [`sessions/meta/v1.26-project-plan-verify/`](../v1.26-project-plan-verify/REPORT.md) — Spec verification § 프로젝트 세션 확장 + v1.24 Out of scope chain 연결
- [`sessions/meta/v1.24-plan-spec-verification/`](../v1.24-plan-spec-verification/REPORT.md) — PLAN § 의무화 (v1.27 Out of scope 약속 원본)

목적: REPORT.md에 `## Spec verification (context7)` § 의무 확장 — post-hoc citation drift 검증 단일화.
v1.24 Out of scope `REPORT.md § 의무 — 별 후속`의 이행 세션.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S2(1) `bootstrap/docs/SPEC_VERIFICATION.md` + S1a(1) `claude/commands/harness-meta.md` + S3(1) `tests/smoke-spec-verification.sh` = **3/3 meta** (PLAN/REPORT 별도)
- **T1 경로 다수결** — meta scope 3/3
- **T2 스펙 vs 값** — REPORT.md 작성 규약 = 모든 세션 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.24-plan-spec-verification/PLAN.md` Out of scope 표 (verbatim)**:

> | ❌ Item | 분리 대상 |
> |--------|---------|
> | REPORT.md `## Spec verification` § 의무 | 별 후속 — REPORT는 post-hoc, PLAN이 forward 검증의 1차 게이트. REPORT § 의무는 evidence 누적 후 |

**Source 2 — `bootstrap/docs/SPEC_VERIFICATION.md` §1.3 Out of scope (verbatim)**:

> `REPORT.md (v1.27)`

**Source 3 — `sessions/meta/v1.26-project-plan-verify/REPORT.md` 다음 후보 (verbatim)**:

> `v1.27-report-spec-verification` | REPORT.md에 § 의무 확장 (v1.24 Out of scope 약속 이행)

**Parsed sub-items (3)**:

1. **REPORT.md `## Spec verification (context7)` § 의무** — v1.27+ 모든 meta REPORT에 의무 배치. 5 sub-fields + `drift` 의미 재정의 (post-hoc)
2. **`tests/smoke-spec-verification.sh` Stage 6 추가** — REPORT glob + 레거시 skip + `make_label` REPORT 확장
3. **문서 갱신** — `SPEC_VERIFICATION.md` (§1.3 / §2 / §7 / §8.1) + `harness-meta.md` (REPORT 필수 섹션)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| REPORT § drift 값과 PLAN § drift 값 cross-file 일관성 검증 | 별 후속 — smoke 복잡도 급증 + 실용 가치 불명확 (evidence-driven) |
| pre-commit hook으로 REPORT smoke 강제 | v1.30-precommit-hook (기존 보류) |
| `--fix` 모드 (§ skeleton 자동 삽입) | v1.29-verify-fix-mode (기존 보류) |
| 기존 REPORT.md (v1.26 이하) 소급 적용 | forward-only (레거시 정책 동결) |
| source matrix 확장 (Anthropic SDK / agents.md 등) | v1.28-source-matrix-expand (기존 보류) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 규약·문서 정의만. Claude Code API/SDK/hook 신규 기능 없음) |
| **re-verify** | N/A |

## 1. 문제 (chain 미완성)

### 현재 상태

- PLAN.md: `## Spec verification (context7)` § 의무 (v1.24+)
- 프로젝트 세션 PLAN: 동일 의무 (v1.26 확장)
- **REPORT.md: § 없음** — 구현 중 발견된 spec drift 기록 체계 없음

### 결과 비용

- 구현 중 spec 발견("context7 query 결과가 PLAN 가정과 다름")이 REPORT Lessons Learned에 자유 형식으로 묻히거나 누락
- PLAN § citations이 REPORT에서 재검증됐는지 감사 불가
- v1.24 Out of scope 약속이 dangling reference로 남음

### 본 세션 해결 범위

REPORT.md에 동일 § 의무 + 의미 재정의 (post-hoc) + smoke Stage 6 + 문서 갱신.

## 2. 결정 (R1 ~ R4)

### R1 — REPORT § format (5 sub-fields 동일, `drift` 의미 재정의)

PLAN §와 동일한 5 sub-fields를 사용하되 `drift` 값 semantics를 post-hoc으로 재정의:

| sub-field | PLAN 의미 | REPORT 의미 |
|-----------|-----------|-------------|
| `library` | 검증에 사용한 context7 library ID | 동일 (PLAN 대비 변경 없으면 "same as PLAN") |
| `topic` | 본 세션 의존 spec sub-area 키워드 | 동일 |
| `findings` | `see citations below` 또는 `N/A` | `no new findings` / `see citations below` / `N/A` |
| `drift` | context7 pre-check 결과 | **구현 중 발견된 신규 spec drift** |
| `re-verify` | 재검증 trigger 조건 | 동일 |

**REPORT `drift` 값 매트릭스 (3 값)**:

| 값 | 의미 |
|----|------|
| `no` | 구현 중 신규 spec drift 없음 (PLAN § 결론 유지) |
| `yes` | 구현 중 신규 spec drift 발견. citations에 새 발견 기록 |
| `N/A` | PLAN § drift=N/A 동일 (외부 spec 의존 무) |

**부분 N/A 금지**: PLAN § 동일. drift=N/A 시 다른 4 sub-field도 정확히 N/A.

**`findings` 값 허용 집합**:

- `N/A`
- `no new findings` (구현 중 새 발견 없음)
- `see citations below` (신규 발견 있음, 본문 Citations list)

### R2 — REPORT § 위치

**"판정" § 직후 / "Lessons Learned" § 직전** 의무 배치.

PLAN과 동일하게 "Out of scope" 직후가 아닌 이유: REPORT는 Out of scope가 없고 "판정"이 구현 완성 확인의 anchor.

```markdown
## 판정
(체크박스)

## Spec verification (context7)   ← 여기
(5 sub-fields 표)

## Lessons Learned
```

### R3 — smoke Stage 6 추가

`tests/smoke-spec-verification.sh`에 **Stage 6** 신설:

- glob: `sessions/meta/v1.2[7-9]*/REPORT.md sessions/meta/v1.[3-9][0-9]*/REPORT.md sessions/meta/v[2-9].*/REPORT.md`
  - 프로젝트 세션 REPORT: `sessions/*/v*/REPORT.md` (meta 제외)
- `LEGACY_REPORTS` 배열: 모든 v1.27 이전 REPORT (meta 전체 v1.0~v1.26 + upbit v1.0~v1.2)
- `make_label` 갱신: `PLAN\.md` 대신 `[^/]+\.md` 로 REPORT.md도 지원
- drift 값 검증: Stage 3 동일 (`yes/no/N/A`)
- N/A 분기 정합: Stage 4 동일
- Stage 5 (SKILL.md) 는 그대로 유지 — REPORT 전용 SKILL 없음

**Stage 6 체크 항목 (4)**:

1. REPORT § 헤더 존재
2. sub-field 5종 존재
3. drift 값 (`yes/no/N/A`) 정합
4. N/A 분기 정합

### R4 — 문서 갱신 (3 파일)

**`bootstrap/docs/SPEC_VERIFICATION.md`**:

- §1.3 In scope: REPORT.md (v1.27+) 항목 추가
- §1.3 Out of scope: `REPORT.md (v1.27)` 마커 제거 (이행)
- §2: "§ 규격" — REPORT § 별도 subsection (R1 + R2 반영)
- §3 위반 정책: REPORT § 누락 시 smoke FAIL 추가
- §7: "§7-4 REPORT 레거시 정책" 신설 (forward-only, v1.27 미만 skip)
- §8.1: Stage 6 언급
- §9.2 후속 분기: `v1.27` 완료 표기, 다음 분기 갱신

**`claude/commands/harness-meta.md`**:

- "5. REPORT.md 작성 (세션 종료 시)" 필수 섹션 목록에 `Spec verification (context7)` 추가 (판정 § 이후)

## 3. 변경 대상 (3 수정 + 세션 파일 2)

| 경로 | scope | 변경 |
|------|------|------|
| `tests/smoke-spec-verification.sh` | S3 | R3 — Stage 6 신설 + make_label REPORT 확장 + LEGACY_REPORTS |
| `bootstrap/docs/SPEC_VERIFICATION.md` | S2 | R4 — §1.3 / §2 / §3 / §7 / §8.1 / §9.2 갱신 |
| `claude/commands/harness-meta.md` | S1a | R4 — REPORT 필수 섹션 1줄 추가 |
| `sessions/meta/v1.27-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.27-.../REPORT.md` | meta | Stage D |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [ ] **사용자 진입 확인**
- [ ] Stage A — `SPEC_VERIFICATION.md` 갱신 (§1.3 / §2 / §3 / §7 / §8.1 / §9.2)
- [ ] Stage B — `smoke-spec-verification.sh` Stage 6 + make_label 갱신 + LEGACY_REPORTS
- [ ] Stage C — `harness-meta.md` REPORT 필수 섹션 갱신
- [ ] Stage D — REPORT.md 작성 (본 세션 self-validate 포함)
- [ ] smoke 전체 실행 확인
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `SPEC_VERIFICATION.md` §1.3 In scope에 REPORT.md (v1.27+) 명시
- [ ] `SPEC_VERIFICATION.md` §2에 REPORT § subsection (5 sub-fields + `drift` post-hoc 의미 + 위치 R2)
- [ ] `SPEC_VERIFICATION.md` §7-4 신설 (REPORT 레거시 정책)
- [ ] `smoke-spec-verification.sh` Stage 6 신설 (REPORT 4 체크)
- [ ] `harness-meta.md` REPORT 필수 섹션 갱신
- [ ] v1.27 REPORT.md § 채워짐 (self-validate)
- [ ] smoke-spec-verification.sh PASS (v1.27 REPORT self-test 포함)
- [ ] 회귀 0 — 기존 smoke 9/9 PASS 유지

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.27-report-spec-verification — REPORT Spec verification § 의무화

- update: bootstrap/docs/SPEC_VERIFICATION.md (§1.3/§2/§3/§7/§8.1/§9.2)
- update: tests/smoke-spec-verification.sh (Stage 6 — REPORT § 4체크 + make_label 확장 + LEGACY_REPORTS)
- update: claude/commands/harness-meta.md (REPORT 필수 섹션 1줄)
- add: sessions/meta/v1.27-.../{PLAN,REPORT}.md

PLAN § : drift=N/A (내부 규약 정의, 외부 spec 의존 무).
smoke-spec-verification.sh: v1.27 REPORT self-test PASS 포함.
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|---------|------|
| `v1.28-source-matrix-expand` | context7 source 매트릭스 확장 — evidence-driven |
| `v1.29-verify-fix-mode` | smoke `--fix` § skeleton 자동 삽입 |
| `v1.30-precommit-hook` | pre-commit hook으로 smoke 강제 |
| REPORT § cross-file 일관성 검증 | evidence 3+ 사례 누적 후 |
