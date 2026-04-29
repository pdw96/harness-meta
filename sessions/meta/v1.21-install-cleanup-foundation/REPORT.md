# meta v1.21-install-cleanup-foundation — REPORT

세션 종료: 2026-04-29
선행 세션:
- [`sessions/meta/v1.11-language-overlay-infra/`](../v1.11-language-overlay-infra/PLAN.md) — Phase 2 overlay merge 도입 + §11 한계 명시 + v1.21 해소 약속
- [`sessions/meta/v1.10j-scope-contract-discipline/`](../v1.10j-scope-contract-discipline/PLAN.md) — Scope contract 의무화

## 1. 최종 결과

- **신규 파일**: 3 (`smoke-legacy-cleanup-overlay.sh`, `audit/A1-context7-validation.md`, REPORT.md 자체)
- **수정 파일**: 4 (`install-project-claude.{sh,ps1}`, `OVERLAY.md`, `smoke-scope-contract.sh`)
- **신규 § 또는 큰 단락**: 1 (OVERLAY.md §11 전면 재작성 — 한계 → 해소 알고리즘)
- **신규 R 결정**: 8 (R1~R8) — 1차 R1~R5 + context7 검증 후 R6~R8
- **신규 D 분석**: 10 (D31~D40) — 1차 D1~D30 + audit A1
- **Smoke 합계**: 60/60 PASS (9 신규 + 11 기존 overlay + 40 scope contract)

## 2. 구현 요약

### Stage A — `bootstrap/install-project-claude.sh` (R1+R2+R7)

- **Section 2.4 신설** (line 76-89): language + overlay_path 통합 추출. 단일 source-of-truth.
- **Section 2.5 갱신** (line 91-126): legacy cleanup이 `_base` + overlay 양쪽 검사. R7 `if-else` 형식 채택 (단일 `&&` 회피, errexit 모호성 0).
- **Phase 2 단순화** (line 152-181): Section 2.4 변수 재사용. 중복 grep 제거.
- **헤더 1줄 추가**: `v1.21+: legacy cleanup이 _base + <language>/ overlay 양쪽 검사`

### Stage B — `bootstrap/install-project-claude.ps1` (R1+R2+R6+R8)

- **Section 2.4 신설**: PS null-safe Select-String pattern (R6) — `$matchResult` if-else로 `$null.Groups[1]` indexing crash 회피.
- **Section 2.5 갱신**: `$inOverlay` 변수 + literal interpolation `"$overlayPath/$cat/$($d.Name)"` (R8) — `Join-Path` multi-arg 회피.
- **Phase 2 단순화**: `$overlayPath` 재사용. 중복 Select-String 제거.
- **`.DESCRIPTION` 1줄 추가**: 동일 v1.21 메시지

**Incidental fix**: v1.11 latent crash (`(Select-String).Matches.Groups[1].Value` chain — language 필드 부재 manifest install 시 RuntimeException) 자연 해소. context7 인용 #1 (PS docs `everything-about-null`) 근거.

### Stage C — `bootstrap/docs/OVERLAY.md` (R4)

- **§11 전면 재작성** (49 lines → 73 lines): "Legacy cleanup 한계 (v1.9b)" → "Legacy cleanup overlay-aware (v1.21+)"
  - v1.21 알고리즘 명시 (bash + ps1 의미 동등)
  - v1.9b 한계 + v1.11b 활성 버그 4단계 trace 표
  - v1.21 시나리오 매트릭스 6건 (1 변경 + 5 회귀 0)
  - bash + ps1 mirror 코드 예시
  - Latent bug 자연 해소 (incidental fix) 명시
- **§13 갱신**: v1.21 (완료) + v1.22~v1.24 (예정 후속 분기)

### Stage D — `tests/smoke-legacy-cleanup-overlay.sh` 신설 (R5)

정적 3 + dynamic 6 = **9 checks**:

| Stage | Check | 검증 |
|-------|-------|------|
| S1.1 | install-project-claude.sh: Section 2.4 + in_overlay 키워드 | 정적 |
| S1.2 | install-project-claude.ps1: overlayPath + inOverlay + matchResult | 정적 |
| S1.3 | OVERLAY.md §11: v1.21 + 양쪽 검사 + 활성 버그 키워드 | 정적 |
| T1 | 첫 install + harness-python 정상 복사 | dynamic |
| T2.a (CRITICAL) | --force 재install log에 'legacy cleanup' 부재 | dynamic |
| T2.b (CRITICAL) | --force 재install backup-*/skills/harness-python 부재 | dynamic |
| T3 | language → "haskell" 후 --force → harness-python backup 이동 (legitimate) | dynamic |
| T4 | language 복원 → --force → harness-python overlay 재복사 | dynamic |
| T5 | _base/skills/harness/SKILL.md 정상 잔존 (회귀 0) | dynamic |

T2 split (D34) — fix 부재 시 두 assertion 모두 명백히 fail하는 구조. critical regression test 첫 정형화.

### Stage E — `tests/smoke-scope-contract.sh` (R5)

기존 v1.10h~v1.14 enumerate에 **v1.15~v1.21** 7개 glob 추가. v1.15-v1.20 모두 이미 두 섹션 의무 준수 확인됨 (사전 audit). v1.21 self-test 자연 흡수.

### Stage F — Smoke 실행 결과

| Smoke | 결과 |
|-------|------|
| `smoke-legacy-cleanup-overlay.sh` (신규) | **9/9 PASS** |
| `smoke-language-overlay.sh` (기존) | 11/11 PASS (회귀 0) |
| `smoke-scope-contract.sh` (갱신) | **40/40 PASS** (v1.21 self-test 흡수 + v1.15-v1.20 누적) |
| **합계** | **60/60 PASS** |

## 3. 판정 (PLAN 체크박스)

PLAN의 **목표 + 성공 기준** 모두 충족:

### 목표
- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 + D1~D40 정밀 분석 반영 + R1~R8 결정
- [x] 사용자 진입 확인
- [x] **context7 검증 + audit/A1 작성 + R6/R7/R8 도출**
- [x] Stage A — install-project-claude.sh Section 2.4 신설 + 2.5 overlay-aware (R7) + Phase 2 재사용 + 헤더
- [x] Stage B — install-project-claude.ps1 동등 mirror (R6 null-safe + R8 literal interpolation)
- [x] Stage C — OVERLAY.md §11 + §13 갱신
- [x] Stage D — smoke-legacy-cleanup-overlay.sh 신설 (9 checks)
- [x] Stage E — smoke-scope-contract.sh v1.15~v1.21 glob 추가
- [x] Stage F — smoke 3종 실행 (PASS) + 회귀 0
- [x] Stage G — REPORT.md
- [ ] 사용자 확인 후 커밋 (다음 단계)

### 성공 기준
- [x] install-project-claude.sh: Section 2.4 신설 + 2.5 in_overlay (R7 if-else) + Phase 2 재사용
- [x] install-project-claude.ps1: 동등 mirror (R6 + R8) — v1.11 latent crash 자연 해소
- [x] OVERLAY.md §11: "v1.9b 한계" → "v1.21+ 해소" 재작성 + 알고리즘 명시
- [x] OVERLAY.md §13: v1.21 entry 갱신 (완료) + v1.22-v1.24 후속 분기
- [x] smoke-legacy-cleanup-overlay.sh 9/9 PASS
- [x] smoke-scope-contract.sh v1.15-v1.21 모두 PASS (40/40)
- [x] 회귀 0 — smoke-language-overlay.sh 11/11 PASS 유지
- [x] **upbit 영향 0** — `language="python"` 재install spurious backup 0건 (T2.a + T2.b 검증)

## 4. Lessons Learned

### L1 — "현실 시나리오 0" 명시 한계도 활성 버그가 될 수 있음

OVERLAY.md §11 (v1.11) 작성 시 "java overlay에 (가상으로) `harness-python/`이 있을 경우" 가상 시나리오로 한계 명시. 실은 **v1.11b (`harness-python/` 실 콘텐츠 도입) 시점부터 같은 시나리오가 활성**:
- `language="python"` + `--force` 재install → 매 실행마다 spurious backup 생성
- 데이터 보존되므로 사용자가 "버그"로 인식 안 했을 가능성 — silent drift

**결론**: 한계 기술 시 **현 시점 source 매트릭스 cross-check 의무**. v1.11에서 "python overlay에 `harness-python` 있음" 명시 후 시나리오 재검토 단계 누락이 root cause.

### L2 — Section 2.4 신설 = 단일 source-of-truth refactor 패턴

language detection을 Section 2.5 + Phase 2 두 곳에서 grep+sed 중복 산출 시 drift 위험. 통합 추출 + 재사용이 표준. 

향후 frontmatter detection (v1.23 verify 통합) 등에도 동일 패턴 적용:
- 한 번 grep + 한 번 sed → 변수 export → 다중 위치 재사용

비용: refactor 1단계 추가. 이득: drift 0 + 가독성 + 단순화 (Phase 2 코드 5 줄 감소).

### L3 — Critical regression test (T2 split) 첫 정형화

기존 smoke는 정합 검증만 — fix 부재 시도 PASS 가능 (false positive 위험). T2 split (T2.a log + T2.b path)은 **fix 부재 시 명백히 fail하는 두 assertion**:
- T2.a: legacy cleanup 트리거 시 log 'legacy cleanup' 키워드 출력 → grep 매치
- T2.b: spurious backup harness-python 생성 → find 매치

이 패턴은 후속 smoke (v1.22 install unification, v1.23 verify, etc.)의 reference. "정합 검증 + critical regression test" 두 트랙 분리 권장.

### L4 — context7 검증이 latent bug 1건 자연 발견

D31 (PS Select-String null chain crash)은 PLAN 1차 분석 (D1~D30)에서 발견 못 함. context7 인용 #1 (PS docs `everything-about-null` "Cannot index into a null array") 검증 후 즉시 도출.

**결론**: context7 검증을 PLAN 1차 분석 후 의무 단계로 추가. 1차 분석은 사용자 멘탈 모델 + 코드 직접 읽기. context7은 **공식 docs cross-check** — 의도 외 동작 발견.

향후 R 결정에 PS / bash / Python /...等 외부 라이브러리 의미가 핵심이면 context7 검증 1단계 추가.

### L5 — 4 세션 분할 권고의 첫 단계 안전성

v1.21 (G만) → v1.22 (E+C) → v1.23 (F+A+B) → v1.24 (D)의 의존성 chain 첫 단계 결과:
- 변경 5 파일 (작음)
- 회귀 0
- 새 인프라 (Section 2.4) 후속 세션에서 재사용 가능
- audit/A1로 외부 검증 trace 보존

→ 4 세션 분할 채택 정합 검증 완료. v1.22+ 동일 패턴 적용.

## 5. 다음 후보 (보류)

본 세션은 G만 처리. 후속 분기 권고 순서:

| 후속 세션 | 포함 sub-items | 의존성 |
|-----------|---------------|------|
| **v1.22-install-unification** | E (copy mode fallback) + C (install-skills + sync-agents 통합) | v1.21 Section 2.4 패턴 재사용 가능 |
| **v1.23-verify-unification** | F (verify.sh 신설) + A (frontmatter 6축) + B (overlay 무결성) | v1.22 install 흐름 안정 후 verify 통합 |
| **v1.24-multi-os-validation** | D (macOS/Linux dynamic) | v1.21~v1.23 누적 후 실 환경 검증 |

각 세션 시작 시 새 PLAN 작성 + D 분석 + context7 검증 + scope contract self-test.

## 6. 관련 문서

- 본 세션 PLAN: [`PLAN.md`](PLAN.md)
- context7 + D31~D40 audit: [`audit/A1-context7-validation.md`](audit/A1-context7-validation.md)
- 단일 소스 §11 갱신: [`../../../bootstrap/docs/OVERLAY.md`](../../../bootstrap/docs/OVERLAY.md) §11 + §13
- 알고리즘 구현: [`../../../bootstrap/install-project-claude.sh`](../../../bootstrap/install-project-claude.sh) Section 2.4-2.5 + 5
- PowerShell mirror: [`../../../bootstrap/install-project-claude.ps1`](../../../bootstrap/install-project-claude.ps1)
- 검증: [`../../../tests/smoke-legacy-cleanup-overlay.sh`](../../../tests/smoke-legacy-cleanup-overlay.sh)
- scope contract enumerate: [`../../../tests/smoke-scope-contract.sh`](../../../tests/smoke-scope-contract.sh)
- 후속 세션 (예정): `v1.22-install-unification` / `v1.23-verify-unification` / `v1.24-multi-os-validation`
