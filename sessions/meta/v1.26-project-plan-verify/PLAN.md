# meta v1.26-project-plan-verify — PLAN

세션 시작: 2026-04-29
선행 세션: [`sessions/meta/v1.24-plan-spec-verification/`](../v1.24-plan-spec-verification/PLAN.md) — Spec verification § meta 세션 의무화 + SKILL 신설

목적: `sessions/<project>/**/PLAN.md`에도 `## Spec verification (context7)` § 의무 확장. v1.24는 `sessions/meta/` only — 본 세션이 프로젝트 세션으로 범위 확대. 기존 세션(upbit v1.0~v1.2)은 레거시 처리.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S2(1) `bootstrap/docs/SPEC_VERIFICATION.md` + S1a(1) `claude/commands/harness-meta.md` + S3(2) `tests/{smoke-spec-verification.sh, smoke-scope-contract.sh}` = 4/4 meta
- **T1 경로 다수결** — meta scope 4/4
- **T2 스펙 vs 값** — 적용 범위 규약 변경 = 모든 프로젝트 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.24-plan-spec-verification/PLAN.md` Out of scope 표** (verbatim):

> `| 프로젝트별 PLAN (sessions/<project>/**/PLAN.md)에 적용 | 별 후속 evidence-driven — 프로젝트 PLAN은 외부 spec 의존 케이스가 메타 대비 적음 |`

**Parsed sub-items (1)**:

1. **`sessions/<project>/**/PLAN.md`에 Spec verification § 의무 확장** — smoke 갱신 + SPEC_VERIFICATION.md §1.3 업데이트 + harness-meta.md 안내 갱신. 기존 프로젝트 세션(upbit v1.0~v1.2)은 레거시로 소급 면제.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 기존 upbit v1.0~v1.2 PLAN.md에 § 소급 추가 | 레거시 정책 — v1.10j / v1.24와 동일 forward-only |
| REPORT.md에 § 의무 확장 | v1.27-report-spec-verification (다음 세션) |
| context7 source 매트릭스 확장 (Anthropic SDK 등) | v1.28-source-matrix-expand |
| 프로젝트별 harness-plan-verify SKILL 배포 (`_base/.claude/skills/`로 복사) | 명시 reject — 글로벌 user-skill(S1c) opt-in 유지. 프로젝트 .claude/는 별 도메인 |
| smoke --fix 모드 | v1.29-verify-fix-mode |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 smoke glob 확장 + 문서 갱신만. 외부 spec 의존 무 |
| **re-verify** | N/A |

## 1. 문제

### 현재 상태

`smoke-spec-verification.sh`는 `sessions/meta/v1.24+/**/PLAN.md`만 검사. `sessions/<project>/`는 대상 외.

`harness-meta.md` 슬래시 커맨드에서 Spec verification § 안내가 "meta 세션"에 한정돼 있어 프로젝트 세션 작성 시 § 누락이 자연스럽게 발생.

### 프로젝트 세션의 외부 spec 의존 현황

| 세션 | 외부 spec 의존 | § 예상 값 |
|------|--------------|---------|
| upbit v1.0-project-claude-install | 없음 (install 스크립트 실행) | N/A |
| upbit v1.1-skills-migration | Claude Code skills spec (frontmatter) | no 또는 N/A |
| upbit v1.2-python-overlay-apply | 없음 (overlay 복사) | N/A |
| 향후 upbit v1.3+ (API 기능 구현 등) | **잠재적 외부 spec** → 의식적 기록 필요 |

대부분 N/A지만 — § 자체가 "외부 spec 확인 안 함"을 명시하는 audit trail. meta 세션과 동등한 discipline.

**비용 명시**: 프로젝트 PLAN도 § + sub-field 5종 의무 (N/A 케이스 포함, 부분 N/A 금지 — smoke Stage 4 정합).

## 2. 결정

### R1 — smoke-spec-verification.sh 프로젝트 세션 glob 추가

현행 glob: `sessions/meta/v1.24*/PLAN.md`

추가 glob: `sessions/*/v*/PLAN.md` (meta 제외 + 레거시 제외)

**레거시 skip 목록** (소급 면제 — v1.26 도입 이전 존재 세션):

```bash
LEGACY_PROJECT_PLANS=(
    "sessions/upbit/v1.0-project-claude-install/PLAN.md"
    "sessions/upbit/v1.1-skills-migration/PLAN.md"
    "sessions/upbit/v1.2-python-overlay-apply/PLAN.md"
)
```

smoke에서 레거시 목록에 있는 파일은 SKIP (meta 세션의 v1.10j 이전 정책과 동등).

**신규 프로젝트 세션 자동 흡수**: 새 프로젝트 or 새 세션 추가 시 레거시 목록 외이므로 자동 검사 대상.

**Skip 정책 동결** (Q2 — fail-open 위험 명시): 레거시 list는 v1.26 도입 시점 동결. 향후 동일 경로 재작성도 SKIP 유지 (의도적 결정 — 재작성 시점에 § 추가 여부는 사용자 판단).

### R2 — SPEC_VERIFICATION.md §1.3 스코프 확장

현행 (L32-33):

```
- **In scope**: `sessions/meta/v1.24+/**/PLAN.md`
- **Out of scope** (별 후속 evidence-driven): `sessions/<project>/**/PLAN.md` (v1.24b), REPORT.md (v1.24d), 레거시 v1.24 미만 (forward-only)
```

변경:

```
- **In scope**: `sessions/meta/v1.24+/**/PLAN.md` + `sessions/<project>/v<N>.*/PLAN.md` (v1.26 이후 신규 — 레거시 skip 목록 §7-3 참조)
- **Out of scope** (별 후속 evidence-driven): REPORT.md (v1.27), 레거시 v1.24 미만 meta + 레거시 프로젝트 세션 (forward-only)
```

§7 레거시 정책에 §7-3 신설:

```markdown
### 7-3. 프로젝트 세션 레거시 (v1.26 도입)

본 절차의 v1.24b 후속 약속을 v1.26-project-plan-verify에서 이행. 다음 세션은 § 의무 면제 (forward-only):

- `sessions/upbit/v1.0-project-claude-install/PLAN.md`
- `sessions/upbit/v1.1-skills-migration/PLAN.md`
- `sessions/upbit/v1.2-python-overlay-apply/PLAN.md`

**Skip 정책 동결**: 본 list는 v1.26 도입 시점 동결. 향후 동일 경로 재작성도 SKIP 유지 (재작성 시점에 § 추가 여부는 사용자 판단).
```

### R3 — harness-meta.md PLAN § 안내 갱신

현행 텍스트 (verbatim):
> `**Spec verification (context7)** — 외부 spec drift 검증 표 5 sub-fields (library/topic/findings/drift/re-verify) + Citations 본문 list. drift=N/A 분기 시 모든 sub-field N/A (**의무 v1.24+**, sessions/meta/ only). 상세: ~/harness-meta/bootstrap/docs/SPEC_VERIFICATION.md`

정확 교체:

- `(**의무 v1.24+**, sessions/meta/ only)` → `(**의무**: sessions/meta/v1.24+ 및 sessions/<project>/v1.26+)`

## 3. 변경 대상 (4 수정)

| 경로 | scope | 변경 |
|------|------|------|
| `tests/smoke-spec-verification.sh` | S3 | R1 — 프로젝트 세션 glob + 레거시 skip 목록 추가 (Stage 1 확장) |
| `bootstrap/docs/SPEC_VERIFICATION.md` | S2 | R2 — §1.3 In scope/Out of scope 양쪽 갱신 + §7-3 신설 (v1.24b 약속 v1.26 이행 cross-ref + 레거시 3건 + Skip 정책 동결) |
| `claude/commands/harness-meta.md` | S1a | R3 — `(의무 v1.24+, sessions/meta/ only)` → `(의무: sessions/meta/v1.24+ 및 sessions/<project>/v1.26+)` 정확 교체 |
| `tests/smoke-scope-contract.sh` | S3 | Stage E — `sessions/meta/v1.26*/PLAN.md` glob 추가 (본 세션 self-test) |

## 4. 목표

- [x] 세션 디렉토리 생성 + PLAN.md 작성
- [ ] **사용자 진입 확인**
- [ ] Stage A — `smoke-spec-verification.sh` 프로젝트 glob + 레거시 skip (R1)
- [ ] Stage B — `SPEC_VERIFICATION.md` §1.3 + §7 갱신 (R2)
- [ ] Stage C — `harness-meta.md` PLAN § 안내 일반화 (R3)
- [ ] Stage D — smoke 실행 검증 (기존 PASS 유지 + 레거시 skip 확인)
- [ ] Stage E — `smoke-scope-contract.sh` v1.26 glob 추가
- [ ] Stage F — REPORT.md 작성
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `smoke-spec-verification.sh`: 레거시 3건 SKIP + meta v1.24/v1.25 기존 PASS 유지
- [ ] `SPEC_VERIFICATION.md` §1.3 In scope에 프로젝트 세션 명시
- [ ] `harness-meta.md` meta-only 한정 문구 제거
- [ ] 회귀 0 — 기존 smoke 전체 PASS 유지
- [ ] smoke-scope-contract.sh v1.26 self-test PASS

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.26-project-plan-verify — Spec verification § 프로젝트 세션 확장
```

## 7. 후속 분기

| 후속 세션 | 내용 |
|---------|------|
| `v1.27-report-spec-verification` | REPORT.md에 § 의무 확장 |
| `v1.28-source-matrix-expand` | context7 source 매트릭스 확장 |
| `v1.29-verify-fix-mode` | verify/smoke --fix 모드 |
