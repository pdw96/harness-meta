# meta v1.25-multi-os-validation — PLAN

세션 시작: 2026-04-29
직접 선행 세션:
- [`sessions/meta/v1.23-verify-unification/`](../v1.23-verify-unification/PLAN.md) — verify.sh 신설 + Stage H/I 통합 (dynamic 3건 Windows SKIP 남김)
- [`sessions/meta/v1.24-plan-spec-verification/`](../v1.24-plan-spec-verification/PLAN.md) — PLAN spec verification § 의무화 (v1.25 분기 명시)

목적: WSL(Ubuntu 24.04 / bash 5.2.21) 환경에서 `smoke-verify-sh-parity.sh` dynamic 3건(S2.1~S2.3)을 실 실행하여 PASS 확인. 버그 발견 시 verify.sh 수정.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S2 `verify.sh` (버그 발견 시 수정) + S3 `sessions/meta/v1.25-.../PLAN+REPORT.md`
- **T3 검증 대상 기준** — 검증 대상이 글로벌 레이어(`verify.sh`) → CWD 무관 meta 소유
- **T5 애매 기본값** — 수정 없이 검증만으로 끝나도 meta 소속 (T3)

## Scope inheritance (verbatim from v1.24-plan-spec-verification)

**Source — `sessions/meta/v1.24-plan-spec-verification/REPORT.md` 다음 후보 표** (verbatim):

> `| \`v1.25-multi-os-validation\` | (v1.23 REPORT 다음 후보, 본 세션과 별 도메인이라 v1.24 → v1.25 prefix 변경) verify.sh dynamic 3건 Linux/macOS/WSL 실 검증 |`

**후속 세션 (예정) verbatim**:

> `- **v1.25-multi-os-validation** — verify.sh dynamic 3건을 Linux/macOS 또는 WSL bash 환경에서 실 검증`

**Parsed sub-items (1)**:

1. **WSL에서 smoke-verify-sh-parity.sh dynamic 3건(S2.1/S2.2/S2.3) 실 실행 + 결과 기록** — 버그 발견 시 verify.sh 수정 포함

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| v1.24b-project-plan-verify (프로젝트 PLAN spec 의무화) | evidence-driven 후속 |
| v1.24c-source-matrix-expand (context7 source 매트릭스 확장) | evidence-driven 후속 |
| v1.B-verify-fix-mode (verify --fix 자동 정정) | evidence-driven 후속 |
| v1.C-precommit-hook (pre-commit hook) | evidence-driven 후속 |
| v1.D-postoolse-hook (PostToolUse deterministic trigger) | evidence-driven 후속 |
| macOS 실 기기 검증 (macOS 환경 부재) | 환경 확보 후 후속 미정 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (WSL runtime 검증 + 버그픽스만) |
| **re-verify** | N/A |

## 배경

`v1.23-verify-unification`에서 `verify.sh` + `verify.ps1` Stage H/I를 통합했고, `smoke-verify-sh-parity.sh`는 정적 5건(S1.1~S1.5)을 Windows에서 검증했다. 그러나 dynamic 3건(S2.1~S2.3)은 `smoke-verify-sh-parity.sh` 자체의 precondition (`Linux/Darwin + bash 4+ + python3`)에 의해 Windows에서 **자동 SKIP**됐다.

본 세션은 **WSL Ubuntu 24.04**(bash 5.2.21 확인)에서 dynamic 3건을 실 실행하여 `verify.sh`가 Linux 환경에서도 정상 동작함을 확인한다.

### Dynamic 3건 정의

| 항목 | 내용 | 통과 조건 |
|------|------|----------|
| **S2.1** | `verify.sh` 종료 코드 | 0 또는 1 (segfault/syntax error 없음) |
| **S2.2** | Stage H1 출력에 `python` 문자열 | overlay enumerate가 `python` 감지 |
| **S2.3** | Stage I 출력에 I1~I5 라인 5건 이상 | frontmatter 6축 검증 전체 실행 |

### WSL 환경 (확인 완료)

| 항목 | 값 |
|------|---|
| OS | WSL Ubuntu 24.04 |
| bash | 5.2.21(1)-release (x86_64-pc-linux-gnu) |
| HARNESS_META_ROOT (WSL path) | `/mnt/c/Users/qkreh/harness-meta` |
| python3 | 확인 예정 (동적 precondition) |

## 목표

- [ ] **Stage A** — WSL에서 precondition 확인 (python3 가용 여부)
- [ ] **Stage B** — WSL에서 `smoke-verify-sh-parity.sh` 실행
- [ ] **Stage C** — S2.1 PASS (exit 0 or 1)
- [ ] **Stage D** — S2.2 PASS (H1 python 감지)
- [ ] **Stage E** — S2.3 PASS (I1~I5 5건)
- [ ] **Stage F** — 버그 발견 시 `verify.sh` 수정 (없으면 skip)
- [ ] **Stage G** — REPORT.md 작성

## 변경 대상

| 경로 | scope | 변경 |
|------|------|------|
| `verify.sh` | S3 | 버그 발견 시 수정 (없으면 변경 없음) |
| `sessions/meta/v1.25-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.25-.../REPORT.md` | meta | Stage G |

## 성공 기준

- [ ] `smoke-verify-sh-parity.sh` S2.1~S2.3 PASS (WSL 실행)
- [ ] smoke 전체 출력 REPORT에 인라인 기록
- [ ] 회귀 0 — 기존 정적 5건 PASS 유지
- [ ] verify.sh 수정 시: Windows `verify.ps1` 동등 변경 + 재검증

## 커밋 전략

버그 없음:
```
feat(meta): sessions/meta/v1.25-multi-os-validation — WSL dynamic 3건 검증 PASS
```

버그 있음:
```
fix(meta): sessions/meta/v1.25-multi-os-validation — verify.sh WSL 버그픽스 + dynamic 3건 PASS
```
