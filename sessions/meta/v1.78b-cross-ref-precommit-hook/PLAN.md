# PLAN — v1.78b Cross-ref pre-commit hook

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: `.pre-commit-config.yaml` (S3 — repo 정책) + `tests/CLAUDE.md` (S3 — 모듈 가이드)
- T1 (경로 다수결): S3×2 → meta 소유 명확

## Scope inheritance (verbatim from v1.78)

**Source — `sessions/meta/v1.78-cross-ref-smoke-infra/PLAN.md` Out of scope 표** (verbatim):

> | `.pre-commit-config.yaml`에 smoke-cross-ref hook 추가 | `v1.78b` (broken ref 재발 evidence 시) |

**Parsed sub-items (1)**:

1. **H1 — `.pre-commit-config.yaml`에 smoke-cross-ref hook entry 추가** — 기존 wrapper (`precommit-autofix-or-fail.sh`) 경유 v1.39/v1.64 패턴 답습. broken ref 자동 차단 인프라.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `tests/smoke-cross-ref.sh` 자체 수정 | v1.78에서 신설 — 본 세션 변경 0 (인프라 등록만) |
| 다른 smoke (`smoke-bash-permission-pattern` 등) pre-commit 등록 일괄 검토 | 후속 미정 — 자주 실패 evidence 누적 시 |
| `.github/workflows/ci.yml`에 smoke-cross-ref 추가 | CI workflow 부재 — `v1.15c-ci-windows-runner` 후속 trigger 시 |
| `precommit-autofix-or-fail.sh` wrapper 자체 수정 | 범용 wrapper 변경 0 — 인자만 다른 smoke path 전달 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/pre-commit/pre-commit.com` (official pre-commit framework docs) |
| **topic** | local hook field 정합 (`id` / `name` / `language: system` / `entry` / `pass_filenames: false` / `always_run: true`) |
| **findings** | local repo hook은 4 required (id/name/entry/language) + 2 optional (pass_filenames default `true`, always_run default `false`) 조합 사용. `language: system`은 system-installed 명령 직접 실행. `pass_filenames: false` + `always_run: true` 조합은 entry가 파일 인자 없이 항상 실행 — wrapper(`bash precommit-autofix-or-fail.sh tests/smoke-cross-ref.sh`) 의도와 정합. 기존 hook 2건(smoke-spec-verification + smoke-scope-contract) 동일 6 field 패턴 1:1 답습 |
| **drift** | no — 6 field 모두 official spec 정합. 기존 hook 답습이므로 회귀 risk 0 |
| **re-verify** | 2026-11 (6개월) — pre-commit framework v5.x stable, local hook spec breaking change 가능성 낮음 |

**Citations**:

- [pre-commit Hook Definition Fields](https://context7.com/pre-commit/pre-commit.com/llms.txt) — `id`/`name`/`entry`/`language` required + `pass_filenames`/`always_run` optional default 명시
- [Define Local Repository Hooks](https://context7.com/pre-commit/pre-commit.com/llms.txt) — `repo: local` 섹션 `language: system` 사용 예시

## 배경

- 선행: [`v1.78-cross-ref-smoke-infra/`](../v1.78-cross-ref-smoke-infra/) (2026-05-05) — `tests/smoke-cross-ref.sh` 신설 + harness-meta broken=0 보장
- v1.78 Out of scope row 1건 → 본 세션 Scope inheritance source
- 사용자 AskUserQuestion 응답 (2026-05-05): "v1.78b: cross-ref pre-commit (Recommended)" 선택
- broken ref 재발 evidence 0건이지만 **proactive 등록**으로 차단 인프라 확보 (v1.39 도입 / v1.64 wrapper 답습)
- ROADMAP §3-B `v1.78b-cross-ref-precommit-hook` trigger 이행

## 목표

- [ ] **H1**: `.pre-commit-config.yaml` `repos.local.hooks` 배열에 smoke-cross-ref hook entry 추가
  - **id**: `smoke-cross-ref`
  - **name**: `Smoke — Cross-ref 정합 § 검사 (실패 시 --fix 자동)`
  - **language**: `system`
  - **entry**: `bash tests/precommit-autofix-or-fail.sh tests/smoke-cross-ref.sh`
  - **pass_filenames**: `false`
  - **always_run**: `true`
- [ ] **H2**: `pre-commit run smoke-cross-ref --all-files` PASS 확인 (현 broken=0)
- [ ] **H3**: E2E violation 주입 → `pre-commit run smoke-cross-ref --all-files` FAIL → wrapper `--fix` 자동 시도 → 안내 + exit 1 시나리오 검증 (.bak 생성 확인 후 수동 정리)
- [ ] **H4**: 기존 smoke 회귀 0 — `smoke-spec-verification` + `smoke-scope-contract` + `smoke-cross-ref` 3종 PASS
- [ ] **H5**: `tests/CLAUDE.md` §"Pre-commit 통합" 코드 블록에 `pre-commit run smoke-cross-ref` 1 line 추가

## 변경 대상

- `.pre-commit-config.yaml` — `repos.local.hooks` 배열에 entry 1개 추가 (~7 lines)
- `tests/CLAUDE.md` §"Pre-commit 통합" — 1 line 추가 (예시 명령어)
- `sessions/meta/v1.78b-cross-ref-precommit-hook/{PLAN.md, REPORT.md}`

## 성공 기준

- [ ] `pre-commit run smoke-cross-ref --all-files` → PASS (harness-meta broken=0)
- [ ] E2E violation 주입 시나리오 → wrapper FAIL + abort + 안내 (`git diff` / `git add -u` / `git commit` 안내)
- [ ] 회귀 0 — `smoke-spec-verification` + `smoke-scope-contract` + `smoke-cross-ref` PASS
- [ ] PLAN `Scope inheritance` 1 sub-item (H1) ↔ REPORT 구현 1건 1:1 매핑
- [ ] `Spec verification (context7)` § drift=no/N/A 결정 후 sub-field 5종 정합

## 커밋 전략

단일 커밋:

```text
feat(meta): sessions/meta/v1.78b-cross-ref-precommit-hook — .pre-commit-config.yaml smoke-cross-ref hook 등록 (wrapper 경유)
```

## 후속 세션 연결

- **선행**: [`v1.78-cross-ref-smoke-infra/`](../v1.78-cross-ref-smoke-infra/)
- **후속 (잠재)**: 다른 도메인 smoke의 pre-commit 등록 일괄 검토 (자주 실패 smoke evidence 누적 시 §3-B 등록 후 trigger)
