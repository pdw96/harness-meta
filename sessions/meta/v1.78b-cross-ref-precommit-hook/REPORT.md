# REPORT — v1.78b Cross-ref pre-commit hook

## 최종 결과

- **변경 파일**: 4건 — `.pre-commit-config.yaml` (수정 +7 lines) + `tests/CLAUDE.md` (수정 +1 line) + 본 세션 PLAN/REPORT
- **신규 hook**: 1건 — `smoke-cross-ref` (`.pre-commit-config.yaml` `repos.local.hooks` 배열)
- **post-run 검증**: `pre-commit run smoke-cross-ref --all-files` PASS (harness-meta broken=0)
- **E2E 검증**: fixture 1행 broken ref 주입 → wrapper FAIL detect → `--fix` 자동 시도 → 1행 삭제 + .bak 생성 → exit 1 + 안내 출력 → fixture/.bak 정리 PASS
- **smoke 회귀**: 0
  - `tests/smoke-spec-verification.sh`: PASS=558 FAIL=0 SKIP=4 (v1.78 drift entry 추가 반영)
  - `tests/smoke-scope-contract.sh`: PASS=178 FAIL=0 SKIP=0
  - `tests/smoke-cross-ref.sh`: PASS=1 FAIL=0 SKIP=0

## 구현 요약

| # | Goal (PLAN sub-item) | Implementation | 상태 |
|--:|---------------------|---------------|:----:|
| H1 | `.pre-commit-config.yaml`에 smoke-cross-ref hook entry 추가 | `repos.local.hooks` 배열 끝에 6 field entry 추가 (`id` / `name` / `language: system` / `entry: bash tests/precommit-autofix-or-fail.sh tests/smoke-cross-ref.sh` / `pass_filenames: false` / `always_run: true`). 기존 hook 2건(smoke-spec-verification + smoke-scope-contract) 1:1 패턴 답습 | ✅ |
| H2 | `pre-commit run smoke-cross-ref --all-files` PASS 확인 | "Smoke — Cross-ref 정합 § 검사 (실패 시 --fix 자동).......................Passed" 출력 | ✅ |
| H3 | E2E violation 주입 → wrapper `--fix` 자동 시도 → abort 시나리오 | `tests/_e2e_fixture_v1_78b.md`에 broken `@nonexistent_path/should_not_exist.md` 1행 주입 → smoke FAIL=1 detect → wrapper "attempting --fix" → 1행 삭제 + .bak 저장 → exit 1 + "Please review changes / git diff / git add -u / git commit" 안내 → fixture + .bak 정리 | ✅ |
| H4 | 기존 smoke 회귀 0 (3종 PASS) | spec-verification 558/0 + scope-contract 178/0 + cross-ref 1/0 — 회귀 0 | ✅ |
| H5 | `tests/CLAUDE.md` §"Pre-commit 통합" 코드 블록에 1 line 추가 | `pre-commit run smoke-cross-ref` line 추가 (v1.78b 주석) | ✅ |

PLAN `Scope inheritance` 1 sub-item (H1) ↔ REPORT 구현 1건 **1:1 매핑** 정합. H2~H5는 PLAN "성공 기준" 검증 항목.

## 판정

- [x] H1: `.pre-commit-config.yaml` smoke-cross-ref hook entry 추가 (6 field 1:1 패턴)
- [x] H2: `pre-commit run smoke-cross-ref --all-files` → PASS (broken=0)
- [x] H3: E2E violation 주입 → wrapper FAIL + `--fix` 자동 + abort + 안내 시나리오 검증
- [x] H4: 회귀 0 (smoke-spec-verification 558/0 + smoke-scope-contract 178/0 + smoke-cross-ref 1/0)
- [x] H5: `tests/CLAUDE.md` §"Pre-commit 통합" 1 line 추가
- [x] PLAN `Scope inheritance` 1 sub-item ↔ REPORT 구현 1건 1:1 매핑

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

PLAN drift=no → REPORT drift=no (자연 진화 — Stage 7 cross-file 일관성 OK case).

## Lessons Learned

- **L1 — Trivial scope에서 단계 5 skip 정당화**: PLAN 검토 깊이 결정 시 사용자 AskUserQuestion으로 "단계 6 (Plan-verify)만 (Recommended)" 선택. 변경 파일 ≤2 + 기존 hook 1:1 답습 + Spec verification 단독 정합성 충분 → 5 관점 검토 ROI 낮음. v1.76 패턴 답습 (단일 파일 cleanup, review skip 결정).
- **L2 — Wrapper 재사용 ROI**: v1.64 `precommit-autofix-or-fail.sh`가 범용 wrapper(인자 = smoke path)로 설계된 덕분에 본 세션 변경 0. 신규 hook 추가 시 entry 1 line만 작성. v1.39/v1.64 인프라 답습 모범 사례.
- **L3 — E2E fixture 정리 의무**: 임시 fixture (`tests/_e2e_fixture_v1_78b.md`)는 `--fix` 후 `.bak` 동반 생성. 검증 종료 시 둘 다 `rm` 의무 (.gitignore에 미등록 → 누락 시 git status 잔존). v1.78에서 fixture 패턴 정착 후 본 세션도 따름.

## 다음 후보 (보류)

- **다른 도메인 smoke의 pre-commit 등록 일괄 검토**: `smoke-bash-permission-pattern` / `smoke-thinking-effort` / `smoke-broad-bash-fine-grain` 등 frontmatter 검증 smoke를 pre-commit에 등록할지 검토. 현재 자주 실패 evidence 없음 → 후속 미정 (evidence 누적 시 §3-B 등록).
- **`.github/workflows/ci.yml` smoke-cross-ref 추가**: CI workflow 부재 (`v1.15c-ci-windows-runner` 후속 trigger 시).

## 선행 / 후속 세션

- **선행**: [`v1.78-cross-ref-smoke-infra/`](../v1.78-cross-ref-smoke-infra/) — `tests/smoke-cross-ref.sh` 신설 + harness-meta broken=0 보장 → 본 세션 Scope inheritance source
- **후속 (잠재)**: 다른 도메인 smoke pre-commit 등록 일괄 검토 (자주 실패 smoke evidence 누적 시)
