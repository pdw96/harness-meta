# meta v1.31-evidence-driven-roadmap — PLAN

세션 시작: 2026-04-29
직접 선행 세션:

- (선행 없음 — 본 세션은 audit/roadmap. 분류 대상 후속 세션은 v1.10 ~ v1.30 전체)

목적: 23건 evidence-driven 후속 세션을 **진행 가능 5건 vs 진행 불가 18건**으로 분류하고 단일 소스 docs (`bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md`)로 영구 기록. 진행 가능 5건은 별 후속 세션(v1.32+)에서 차례 처리.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S2(1) `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` 신설 + meta(2) 본 세션 PLAN/REPORT = **3/3 meta**
- **T1 경로 다수결** — 100% S2/meta scope
- **T2 스펙 vs 값** — evidence-driven 후속 분류 = 모든 도메인 횡단 정책 → meta

## Scope inheritance (verbatim from 사용자 발의)

**Source — 사용자 발의 (2026-04-29) verbatim**:

> "Evidence 의존 후속 세션 — 진행 가능 vs 불가 분류 의 항목들을 작성해놔. 그리고 진행 가능한거는 진행"

**Parsed sub-items (2)**:

1. **23건 evidence-driven 후속 세션 분류 영구 기록** — "작성해놔" = 단일 소스 docs 또는 세션 본문에 기록
2. **진행 가능 5건 진행** — 본 세션 또는 별 후속 세션에서 implementation

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 진행 가능 5건의 실 implementation (REPORT cross-file consistency / v1.10j2-legacy / v1.29b-fix-other-smokes / v1.18f-scorer-NA / v1.22-skills-categories) | **각각 별 후속 세션** v1.32+ — sub-item 2 충족은 본 세션이 roadmap 작성 + 후속 세션 enqueue로 해석 (한 세션에 5건 대형 작업은 scope 폭주) |
| 진행 불가 18건 implementation | 외부 trigger 대기 (사용자 등장 / 회귀 발생 / unpublish 등) |
| Schedule 등록 (mindvault-pypi-check / alternative-survey / project-claude-backup-audit) | 사용자 명시 권한 필요 — 별 작업 |
| EVIDENCE_DRIVEN_ROADMAP.md를 모든 도메인 docs와 cross-link | docs 통합 view만 신설 — 각 도메인 docs(OVERLAY/SKILLS/SPEC_VERIFICATION)는 자기 후속만 그대로 유지 (drift 위험 회피) |
| 23건 누락 검증 (다른 후속 세션 후보 추가 식별) | 본 세션은 grep evidence + 사용자 검토만 — 추가 식별은 evidence 발생 시 별 세션 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 evidence-driven 정책 분류 + roadmap docs 신설만) |
| **re-verify** | N/A |

## 1. 문제 (분류 부재)

### 현재 상태

23건 evidence-driven 후속 세션이 **분산 기록**:

- `bootstrap/docs/{OVERLAY, SKILLS, SPEC_VERIFICATION, OWNERSHIP}.md` — 각 도메인 후속만
- `sessions/meta/v1.10*/REPORT.md` ~ `v1.30/REPORT.md` — 각 세션의 "다음 후보" 섹션
- `CLAUDE.md` — 일부 후속 언급

→ **통합 view 부재** — "지금 진행 가능한 것?", "어떤 trigger 대기 중?" 답을 매번 grep 수동 조사 필요. 본 세션에서 1회 발견 시 영구 기록 가치.

### Root cause

evidence-driven 패턴이 v1.10e부터 정착했으나 (`evidence가 후속 동기 자연 유도`, v1.10e REPORT L3), **분류·우선순위 단일 소스 부재**.

### 본 세션 해결 범위

- 23건 분류 결과 영구 기록 (5 진행 가능 + 18 진행 불가, 각각 trigger 명시)
- 진행 가능 5건 우선순위 제시
- 진행 불가 18건 trigger 종류별 분류 (외부 사용자 / 회귀 / 환경 변화 / 설계 / 정규화)
- Schedule 등록 후보 3건 cadence 근거 부록

## 2. 결정 (R1)

### R1 — `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` 신설

**위치**: `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` (~180 lines)

**구성** (8 §):

1. **개요** — evidence-driven 패턴 정의 + 분류 방법론 (trigger 종류 5분류)
2. **진행 가능 5건** — 임계 도달 또는 self-evidence 충족
3. **진행 불가 18건** — 카테고리 A~E + 각 trigger 조건 + 출처
4. **Schedule 등록 후보 3건** — cadence 근거 (월/분기)
5. **권장 진행 순서** — 진행 가능 5건 우선순위 + 후속 세션 v1.32+ 매핑
6. **갱신 정책** — 본 docs 갱신 주기 + 신규 후속 추가 절차
7. **관련 문서** — 도메인별 docs cross-ref (OVERLAY/SKILLS/SPEC_VERIFICATION/OWNERSHIP)
8. **확정 세션** — v1.31 본 세션 링크

**갱신 정책**:

- evidence 충족(trigger 발생)으로 진행 가능 항목이 진행 시: 해당 row를 "✅ 완료 (vX.Y 세션)" 표기 후 **archive 섹션**으로 이동
- 신규 evidence-driven 후속 추가 시: meta 세션 REPORT의 "다음 후보" 섹션에 명시 + 본 docs에 row 추가 (drift 회피)
- 진행 불가 항목의 trigger 발생 감지: 사용자 또는 정기 schedule이 발견 시 row를 진행 가능으로 promote

### R1.1 — 본 docs는 통합 view, 도메인 docs는 자기 후속만 유지

각 도메인 docs (`OVERLAY.md`, `SKILLS.md`, `SPEC_VERIFICATION.md`, `OWNERSHIP.md`)는 자기 도메인 후속만 명시하는 현 정책 유지. 본 ROADMAP.md는 **횡단 통합 view**.

**Drift 회피**: 도메인 docs와 본 docs 동시 갱신 의무는 부담. 대신 본 docs를 "최신 audit 결과" 시점 표기 (v1.31 audit 기준)로 stamp + 6개월 마다 또는 후속 세션 진행 시 갱신.

## 3. 변경 대상 (1 신규 + 2 수정)

### 신규 (1)

| 경로 | scope | 역할 |
|------|------|------|
| `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` | S2 | R1 — 통합 view (8 §, ~180 lines) |

### 수정 (2 — minimal cross-ref)

| 경로 | scope | 변경 |
|------|------|------|
| `CLAUDE.md` | S3 | "관련 문서" § 1줄 추가 — `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` cross-ref |
| `README.md` | S3 | "관련 문서" 또는 디렉토리 구조 § 1줄 추가 |

### 세션 기록 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.31-evidence-driven-roadmap/PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.31-evidence-driven-roadmap/REPORT.md` | meta | 결과 + 후속 v1.32+ 매핑 |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 + Scope contract + Spec verification §
- [ ] **사용자 진입 확인**
- [ ] Stage A — `EVIDENCE_DRIVEN_ROADMAP.md` 신설 (8 §)
- [ ] Stage B — `CLAUDE.md` cross-ref 1줄
- [ ] Stage C — `README.md` cross-ref 1줄
- [ ] Stage D — REPORT.md 작성 (v1.32+ 후속 매핑 포함)
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` 존재 + 8 § 모두 작성
- [ ] 진행 가능 5건 + 진행 불가 18건 = **23건 모두** docs에 매핑
- [ ] 각 진행 불가 항목 trigger 조건 1줄 이상 명시
- [ ] 출처 (`v1.X REPORT` 또는 `<도메인>.md`) 1:1 매핑
- [ ] CLAUDE.md + README.md cross-ref 1줄씩 추가
- [ ] 회귀 0 (smoke 변경 0 — 본 세션은 docs only)
- [ ] 후속 5건 (v1.32~v1.36 매핑) REPORT에 명시

## 6. 커밋 전략

```
docs(meta): sessions/meta/v1.31-evidence-driven-roadmap — evidence-driven 후속 세션 분류 단일 소스

- add: bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md (R1 — 8 § 통합 view, 23건 분류)
- update: CLAUDE.md (관련 문서 cross-ref 1줄)
- update: README.md (관련 문서 cross-ref 1줄)
- add: sessions/meta/v1.31-.../{PLAN,REPORT}.md

Scope: 분류 + roadmap 영구 기록만. 진행 가능 5건 implementation은 v1.32+ 별 세션.

23건 분류:
- 진행 가능 5건 (REPORT cross-file / v1.10j2-legacy / v1.29b-fix-other-smokes / v1.18f-scorer-NA / v1.22-skills-categories)
- 진행 불가 18건 (외부 사용자 9 + 회귀 4 + 환경 변화 2 + 설계 1 + 정규화 2)
- Schedule 등록 후보 3건 (mindvault-pypi-check 월 / alternative-survey 분기 / project-claude-backup 월)

회귀 0 — docs only.
```

## 7. 후속 분기 (v1.32+ 매핑 — 진행 가능 5건)

| 후속 세션 | 우선순위 | 진행 근거 |
|---------|:------:|---------|
| `v1.32-report-cross-file-consistency` | **1순위** | v1.27/v1.28/v1.29 3건 누적 → "evidence 3+ 사례" 임계 도달 (v1.27/v1.29 REPORT 명시) |
| `v1.33-fix-other-smokes` (v1.29b 별칭) | 2순위 | `--fix` 패턴 v1.29 검증 완료 → 즉시 재사용 가능 |
| `v1.34-legacy-plan-migration` (v1.10j2 별칭) | 3순위 | 25+ legacy PLAN 사례 충분, soft migration risk 0 |
| `v1.35-scorer-other-na-categories` (v1.18f 별칭) | 4순위 | harness-meta self-eval로 evidence 자체 확보 가능 |
| `v1.36-skills-categories` (v1.22 별칭) | 5순위 | 5번째 skill 추가와 동시 진행 시 자연 evidence (현 4 → 5) |

## 8. Lessons Forward (예상)

- **L1 — evidence-driven 패턴은 분산 기록만으로는 운영 효율 낮다** — v1.10e 도입 후 23건 누적까지 통합 view 부재로 매번 grep 수동 조사. 본 v1.31이 통합 view 단일 소스 도입 첫 사례
- **L2 — trigger 분류가 "진행 가능 vs 불가" 판정에 결정적** — 외부 사용자 등장 의존(9건)은 정기 schedule로도 검출 불가하나, 회귀 의존(4건)은 verify 실패 등 자동 trigger 가능. 분류 자체가 schedule 등록 후보 식별로 직결
- **L3 — 임계 도달 자동 인식 필요** — REPORT cross-file consistency가 v1.27/v1.28/v1.29 3건 누적으로 "evidence 3+" 임계 도달했으나 명시 trigger 없어 사용자 발의 시점까지 대기. 향후 evidence 누적 카운터 + 임계 도달 alert 자동화 검토 (v1.31 후속 evidence-driven)
