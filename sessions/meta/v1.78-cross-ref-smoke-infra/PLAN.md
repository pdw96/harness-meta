# PLAN — v1.78 Cross-ref smoke infra

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: `tests/smoke-cross-ref.sh` (S3 meta repo 검증 자산) + `tests/CLAUDE.md` (S3)
- T1 (경로 다수결): S3×2 → meta 소유 명확
- T3: 검증 대상 = harness-meta living docs (전역) → meta 소유

## Scope inheritance (verbatim from v1.77)

**Source — `sessions/meta/v1.77-cross-ref-broken-link-fix/PLAN.md` Out of scope 표** (verbatim):

> | `tests/smoke-cross-ref.sh` 인프라 신설 (audit 자동화) | 후속 미정 (v1.78 또는 evidence 누적 후) |
> | backtick 내부 false positive filter 정밀화 | 위 smoke 인프라 신설 시 동반 |

**Parsed sub-items (2)**:

1. **C1 — `tests/smoke-cross-ref.sh` 신설** — living docs cross-ref 자동 감지 smoke (`@`-import + markdown link, 코드 블록/backtick 제외)
2. **C2 — backtick false positive filter** — 코드 블록 내부 + inline backtick 내부 링크 제외 (v1.77 L1 Lesson 기반)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `sessions/**/*.md` 전수 cross-ref 검증 | 불변 이력 — 영구 제외 (v1.77 Out of scope 계승) |
| `bootstrap/templates/**`, `bootstrap/skeletons/**` placeholder ref | placeholder 의도 — 영구 제외 |
| `.pre-commit-config.yaml`에 smoke-cross-ref hook 추가 | `v1.78b` (broken ref 재발 evidence 시) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 순수 bash/python3 내부 스크립트, 외부 spec 의존 없음 |
| **re-verify** | N/A |

**Citations**: N/A

## 배경

- 선행: [`v1.77-cross-ref-broken-link-fix/`](../v1.77-cross-ref-broken-link-fix/) (2026-05-05)
  - 수동 audit: living docs 26 파일 196 refs → 16 후보 → false positive 12건 (75%) 분리 → 실 broken 4건 fix
  - L1 Lesson: "backtick 코드 블록 외부 link만 검출하는 정밀 필터 필수" — 본 세션 핵심 요구
  - Out of scope 2행 → 본 세션 Scope inheritance로 진화
- 사용자 AskUserQuestion 응답: "v1.78 cross-ref smoke (Recommended)" 선택

## 목표

- [ ] C1: `tests/smoke-cross-ref.sh` 신설
  - **검사 대상**: repo 내 `.md` 파일 — `sessions/**/v*-*/*.md` + `bootstrap/templates/**` + `bootstrap/skeletons/**` 제외 (`sessions/CLAUDE.md` + `sessions/meta/ROADMAP.md`는 living docs이므로 포함)
  - **추출 패턴**: `@path/to/file.md` (Claude Code @import) + `[text](path.md)` (markdown link)
  - **False positive 제외** (C2): 코드 블록 (` ``` `...` ``` `) 내부 + inline backtick 내부
  - **resolve 양방향**: `@path`는 repo root 기준 절대 경로, `[text](path)` markdown link는 파일 위치 기준 상대 경로 — 별도 로직
  - **출력**: broken ref 파일명 + 행 번호 + ref 문자열
  - **exit code**: broken=0 → 0, broken>0 → 1
- [ ] C2: `--fix` mode — broken ref 행 자동 삭제 (python3 heredoc 위임, `.bak` 백업)
- [ ] C3: default 실행 → harness-meta PASS 확인 (현재 broken=0 기대)
- [ ] C4: E2E violation 주입 → FAIL → --fix → PASS 시나리오 검증
- [ ] C5: 기존 smoke 회귀 0 (smoke-spec-verification + smoke-scope-contract PASS)

## 변경 대상

- `tests/smoke-cross-ref.sh` (신규)
- `tests/CLAUDE.md` §smoke 매트릭스 표에 1 row 추가
- `sessions/meta/v1.78-cross-ref-smoke-infra/{PLAN.md, REPORT.md}` (세션 기록)

## 성공 기준

- [ ] `bash tests/smoke-cross-ref.sh` → harness-meta PASS (broken=0)
- [ ] `bash tests/smoke-cross-ref.sh --fix` (fixture) → E2E broken 행 삭제 검증
- [ ] 기존 smoke 2종 PASS — 회귀 0 (smoke-spec-verification, smoke-scope-contract)
- [ ] PLAN sub-items C1/C2 ↔ REPORT 구현 2건 1:1 매핑

## 커밋 전략

단일 커밋:

```text
feat(meta): sessions/meta/v1.78-cross-ref-smoke-infra — smoke-cross-ref.sh 신설 (backtick filter + --fix mode)
```

## 후속 세션 연결

- **선행**: [`v1.77-cross-ref-broken-link-fix/`](../v1.77-cross-ref-broken-link-fix/)
- **후속 (잠재)**: `v1.78b` — `.pre-commit-config.yaml`에 smoke-cross-ref hook 추가 (broken ref 재발 evidence 시)
