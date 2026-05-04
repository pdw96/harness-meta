# meta v1.31-evidence-driven-roadmap — REPORT

세션 종료: 2026-04-29
PLAN: [`PLAN.md`](PLAN.md)

## 최종 결과

- **신규 docs**: 1 (`bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md`, 9 §, ~140 lines)
- **수정 docs**: 2 (`CLAUDE.md` 1줄 + `README.md` 1줄 cross-ref)
- **세션 기록**: 2 (PLAN.md + 본 REPORT.md)
- **23건 분류**: 진행 가능 5 + 진행 불가 18 + schedule 후보 3
- **회귀**: 0 (docs only — smoke/install/verify 영향 무)

## 구현 요약

### Stage A — `EVIDENCE_DRIVEN_ROADMAP.md` 신설 ✅

위치: `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md`

9 § 구성:

1. 개요 — Evidence-driven 패턴 정의 + 분류 방법론 (Trigger 종류 5분류 A~E)
2. 진행 가능 5건 — 임계 도달 또는 self-evidence 충족
3. 진행 불가 18건 — Trigger 종류별 (3-A 외부 사용자 9 + 3-B 회귀 4 + 3-C 환경 변화 2 + 3-D 설계 1 + 3-E 정규화 2)
4. Schedule 등록 후보 3건 — cadence 근거 + 일반 원칙 4
5. 권장 진행 순서 — v1.32 ~ v1.36 매핑
6. 갱신 정책 — promote/archive/drift 회피
7. 관련 문서 cross-ref
8. 확정 세션
9. Archive (현 0건)

### Stage B — `CLAUDE.md` cross-ref 1줄 ✅

위치: "관련 문서" §, `SPEC_VERIFICATION.md` 다음 줄
내용: `Evidence-driven 후속 세션 통합 view (v1.31+, 23건 분류): @bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md`

### Stage C — `README.md` cross-ref 1줄 ✅

위치: "Key docs" 표, `AGENTS_MD_STRATEGY.md` 다음 행
내용: `[bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md] | Evidence-driven follow-up sessions — unified view, 23 items classified (v1.31+)`

### Stage D — REPORT.md 작성 ✅

본 파일.

## 판정

PLAN 5 성공 기준:

- [x] `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` 존재 + 8 § 모두 작성 (실 9 § — Archive 추가)
- [x] 진행 가능 5건 + 진행 불가 18건 = 23건 모두 docs에 매핑
- [x] 각 진행 불가 항목 trigger 조건 1줄 이상 명시
- [x] 출처 (`v1.X REPORT` 또는 `<도메인>.md`) 1:1 매핑
- [x] CLAUDE.md + README.md cross-ref 1줄씩 추가
- [x] 회귀 0 (smoke 변경 0)
- [x] 후속 5건 (v1.32~v1.36 매핑) PLAN/REPORT/docs §5 명시

**전체 PASS**.

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션 외부 spec 의존 무 (내부 정책 분류 + roadmap docs 신설만) |
| **re-verify** | N/A |

## Lessons Learned

### L1 — Evidence-driven 패턴 분산 기록 → 통합 view 단일 소스 도입

v1.10e부터 23건 누적까지 evidence-driven 후속이 각 도메인 docs(OVERLAY/SKILLS/SPEC_VERIFICATION/OWNERSHIP) + 각 세션 REPORT "다음 후보" §에 분산 기록되어 매번 grep 수동 조사 필요했음. 본 v1.31이 통합 view 단일 소스 (`EVIDENCE_DRIVEN_ROADMAP.md`) 도입 첫 사례. 도메인 docs는 자기 후속만 유지 (drift 회피), 본 docs는 횡단 통합 view 우선 — 책임 분리가 drift 위험 차단의 핵심.

### L2 — Trigger 종류 5분류가 schedule 등록 후보 식별로 직결

`A 외부 사용자 등장 / B 회귀 / C 환경 변화 / D 설계 / E 정규화` 5분류 중 **C만 정기 schedule 등록 가능** (자동 감지 가능). A/D/E는 사용자 명시 trigger, B는 CI hook 후보. 분류 자체가 "어떤 방식으로 trigger 검출할 것인가" 답을 제공.

### L3 — 임계 도달 자동 인식 부재 (후속 evidence)

REPORT cross-file consistency가 v1.27/v1.28/v1.29 3건 누적으로 "evidence 3+" 임계 도달했으나 명시 trigger 없어 사용자 발의 시점까지 대기. 향후 evidence 누적 카운터 + 임계 도달 alert 자동화 검토 가치 — `v1.31b-evidence-counter` 또는 본 docs §6 "갱신 정책" 확장 (evidence-driven 후속).

### L4 — Roadmap docs는 "최신 audit 시점" stamp + 정기 갱신 필수

trigger 발생 + 사용자 환경 변화로 인해 본 docs 자체가 stale 가능. 6개월 또는 후속 세션 진행 시 갱신 stamp 명시 필수 (§6-4). 현 v1.31 audit 기준 정확하지만 Python 사용자 1명 등장 시 §3-A row 즉시 promote 필요.

## 다음 후보 (보류)

### 임계 도달 — 진행 가능 (v1.32 ~ v1.36)

| 우선순위 | 후속 세션 | docs 매핑 |
|:-:|---------|---------|
| 1 | `v1.32-report-cross-file-consistency` | EVIDENCE_DRIVEN_ROADMAP.md §2 #1 |
| 2 | `v1.33-fix-other-smokes` (= v1.29b) | §2 #3 |
| 3 | `v1.34-legacy-plan-migration` (= v1.10j2) | §2 #2 |
| 4 | `v1.35-scorer-other-na-categories` (= v1.18f) | §2 #4 |
| 5 | `v1.36-skills-categories` (= v1.22) | §2 #5 |

### 본 v1.31 후속 (보류)

| 후속 세션 | 조건 |
|---------|------|
| `v1.31b-evidence-counter` | 임계 도달 자동 인식 — evidence 누적 카운터 + alert. 현 수동 audit 부담 누적 후 (v1.32+ 진행 후 6개월) |
| `v1.31c-roadmap-stamp-refresh` | 본 docs 정기 갱신 자동화 — 6개월 cadence schedule 등록 (사용자 명시 권한) |

### Schedule 등록 (사용자 권한 요구)

| Schedule | cadence |
|---------|---------|
| `mindvault-pypi-check` | 월 1회 |
| `mindvault-alternative-survey` | 분기 1회 |
| `project-claude-backup-audit` | 월 1회 |
