---
milestone: M2-drift-detection-infra
milestone-id: M2
phase: 2
---

<!-- milestone wrap: v1.83 retro classify (ADR-006) -->

# PLAN — v1.79b claude-md-drift pre-commit hook

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: `.pre-commit-config.yaml` (S3 — repo 정책) + `tests/CLAUDE.md` (S3 — 모듈 가이드)
- T1 (경로 다수결): S3×2 → meta 소유 명확

## Scope inheritance (verbatim from v1.79)

**Source — `sessions/meta/v1.79-claude-md-drift-smoke/PLAN.md` Out of scope 표** (verbatim):

> | pre-commit hook 등록 | smoke-cross-ref 패턴 답습 여부 evidence-driven — 별도 `v1.79b` |

**Parsed sub-items (1)**:

1. **H1 — `.pre-commit-config.yaml`에 smoke-claude-md-drift hook entry 추가** — 기존 wrapper (`precommit-autofix-or-fail.sh`) 경유 v1.78b cross-ref precommit 패턴 1:1 답습. root ↔ 모듈 CLAUDE.md drift 자동 차단 인프라.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `smoke-claude-md-drift.sh` 자체 수정 | v1.79에서 신설 — 본 세션 변경 0 (hook 등록만) |
| 다른 smoke (smoke-bash-permission-pattern 등) pre-commit 등록 일괄 검토 | 후속 미정 — 자주 실패 evidence 누적 시 |
| `.github/workflows/ci.yml`에 smoke-claude-md-drift 추가 | CI workflow 부재 — `v1.15c-ci-windows-runner` 후속 trigger 시 |
| `smoke-claude-md-drift.sh`에 `--fix` mode 추가 | v1.79 Out of scope — content drift는 사람 판단 필요 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/pre-commit/pre-commit.com` (official pre-commit framework docs) |
| **topic** | local hook field 정합 (`id` / `name` / `language: system` / `entry` / `pass_filenames: false` / `always_run: true`) |
| **findings** | local repo hook 6 field 패턴: `language: system`은 system-installed 명령 직접 실행. `pass_filenames: false` + `always_run: true` 조합은 entry가 파일 인자 없이 항상 실행 — wrapper(`bash precommit-autofix-or-fail.sh tests/smoke-claude-md-drift.sh`) 의도와 정합. 기존 hook 3건(smoke-spec-verification + smoke-scope-contract + smoke-cross-ref) 동일 6 field 패턴 1:1 답습 |
| **drift** | no — 6 field 모두 official spec 정합. 기존 hook 답습이므로 회귀 risk 0 |
| **re-verify** | 2026-11 (6개월) — pre-commit framework v5.x stable, local hook spec breaking change 가능성 낮음 |

**Citations**:

- `/pre-commit/pre-commit.com` — `id`/`name`/`entry`/`language` required + `pass_filenames`/`always_run` optional default 명시
- `/pre-commit/pre-commit.com` — `repo: local` 섹션 `language: system` 사용 예시

## 배경

- 선행: [`v1.79-claude-md-drift-smoke/`](../v1.79-claude-md-drift-smoke/) (2026-05-05) — `tests/smoke-claude-md-drift.sh` 신설 + harness-meta 16/16 PASS 보장
- v1.79 Out of scope row 1건 → 본 세션 Scope inheritance source
- v1.78b (cross-ref precommit) 패턴을 1:1 답습 — trivial scope
- ROADMAP §3-B `v1.79b-claude-md-drift-precommit` trigger 이행

## 목표

- [ ] **H1**: `.pre-commit-config.yaml` `repos.local.hooks` 배열에 smoke-claude-md-drift hook entry 추가
  - **id**: `smoke-claude-md-drift`
  - **name**: `Smoke — root ↔ 모듈 CLAUDE.md drift 검사`
  - **language**: `system`
  - **entry**: `bash tests/smoke-claude-md-drift.sh`
  - **pass_filenames**: `false`
  - **always_run**: `true`
- [ ] **H2**: `pre-commit run smoke-claude-md-drift --all-files` PASS 확인 (현 16/16 PASS)
- [ ] **H3**: `tests/CLAUDE.md` §"Pre-commit 통합" 코드 블록에 `pre-commit run smoke-claude-md-drift` 1 line 추가
- [ ] **H4**: 기존 smoke 회귀 0 — `smoke-spec-verification` + `smoke-scope-contract` + `smoke-cross-ref` + `smoke-claude-md-drift` PASS

## 변경 대상

- `.pre-commit-config.yaml` — `repos.local.hooks` 배열에 entry 1개 추가 (~6 lines)
- `tests/CLAUDE.md` §"Pre-commit 통합" — 1 line 추가 (예시 명령어)
- `sessions/meta/v1.79b-claude-md-drift-precommit/{PLAN.md, REPORT.md}`

## 성공 기준

- [ ] `pre-commit run smoke-claude-md-drift --all-files` → PASS (harness-meta 16/16 PASS)
- [ ] 회귀 0 — spec-verification + scope-contract + cross-ref + claude-md-drift PASS
- [ ] PLAN `Scope inheritance` 1 sub-item (H1) ↔ REPORT 구현 1건 1:1 매핑
- [ ] `Spec verification (context7)` § drift=no 결정 후 sub-field 5종 정합

## 커밋 전략

단일 커밋:

```text
feat(meta): sessions/meta/v1.79b-claude-md-drift-precommit — .pre-commit-config.yaml smoke-claude-md-drift hook 등록
```

## 후속 세션 연결

- **선행**: [`v1.79-claude-md-drift-smoke/`](../v1.79-claude-md-drift-smoke/)
- **후속 (잠재)**: 다른 도메인 smoke의 pre-commit 등록 일괄 검토 (자주 실패 smoke evidence 누적 시 §3-B 등록 후 trigger)
