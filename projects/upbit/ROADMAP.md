# ROADMAP — upbit

```json
{
  "project": "upbit",
  "updated": "2026-05-13",
  "v1_14_note": "v1.14 (2026-05-13 completed) — v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta **열 번째** 실 적용 milestone. v1.13 PROPOSE next_candidates_named_only #3 (upbit-ruff-rules-expansion, A_user trigger 대기) 사용자 명시 발의. ruff 공식 popular canonical set [E, F, UP, B, SIM, I] 6 rule 활성화 (사용자 선택 = 외부 spec 정확 일치, drift 0). 4 디렉토리 471 위반 단일 phase 통합 처리. Stage F EXECUTE 결정 흡수 1건 (DESIGN 2-phase → 단일 phase, v1.12/v1.13 패턴 정합 누적 3건). § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 10건 도달 + (2) 동결 유지 narrative 4회 누적 (v1.7 + v1.12 + v1.13 + v1.14).",
  "v1_13_note": "v1.13 (2026-05-12 completed) — v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta **아홉 번째** 실 적용 milestone. § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 9건 도달 + (2) 검증 동결 유지 narrative 정합 (v1.7 + v1.12 + v1.13 누적 3회 패턴). 11 minor jump (v0.4.10 → v0.15.12) + 21파일 reformat + Stage F 사용자 결정 1건 흡수 (poetry --no-update 부재, v1.12 .git/hooks 부재 패턴 정합).",
  "v1_12_note": "v1.12 (2026-05-12 completed) — v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta **여덟 번째** 실 적용 milestone. § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 8건 도달 + (2) 검증 v3.13 결정 narrative 정합 동결 유지. 2-leg defense (local + remote) 도입 + Stage F 사용자 결정 1건 흡수 (.git/hooks/pre-commit 부재 → pre-commit install, out_of_scope #3 허용 범위).",
  "v1_9_note": "v1.9 (2026-05-13 completed) — v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta **다섯 번째** 실 적용 milestone. § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 5건 도달.",
  "v1_7_note": "v1.7 (2026-05-12 completed) — v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta **세 번째** 실 적용 milestone. § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 3건 도달 (v1.5 + v1.6 + v1.7), 조건 (2) evidence 부족으로 동결 유지 (memory project_deferred_3_freeze_decision_2026_05_12.md 정합).",
  "schema_note": "v3.0+ 9-stage-bundled era entry: {version, id (group-slug), title, status, summary, trigger, milestones_path?}. v2.0~v2.1 / v1.0~v1.4 보존 entry: 기존 schema (id flat = v{X.Y}_{slug}) 유지 (forward-only).",
  "milestones": [
    {
      "version": "v1.14",
      "id": "upbit-ruff-rules-expansion",
      "title": "upbit ruff rule set 확장 — default (F + E subset) 외 I + B + UP + SIM 4 rule 활성화",
      "status": "completed",
      "milestones_path": "milestones/v1.14/milestones.md",
      "trigger": "A_user",
      "summary": "v1.13 PROPOSE next_candidates_named_only #3 (upbit-ruff-rules-expansion, A_user trigger 대기) 사용자 명시 발의. pyproject.toml `[tool.ruff.lint]` section 신규 + `select = [\"E\", \"F\", \"UP\", \"B\", \"SIM\", \"I\"]` 6 rule 활성화 (ruff 공식 popular canonical 정확 정합, drift 0) + `[tool.ruff] src = [\"bot\", \"config\", \"tests\", \"scripts\"]` 명시 추가 (D5 spec-drift review P1.1 흡수). 4 디렉토리 (bot/ + config/ + tests/ + scripts/) 471 위반 단일 phase 통합 처리 — safe-fix 364 (--fix) + unsafe-fix 53 (--unsafe-fixes) + manual fix 67 (SIM117 32 multiple-with-statements + E501 21 cascade + SIM102 5 + B904 4 + SIM105 2 + B017 1 + B018 1 + F401 1) + format cascade 10 파일. 단일 commit (d66ffdc, 97 files +830/-764, net +66). 5 관점 review (architecture / spec-drift / 회귀 risk / 보안 / scope contract) 전원 pass-with-comments + decisive issue 0 + 의견 충돌 0 + P1 권고 9건 흡수 (D7 신설 .harness.toml drift 사실 진술 / D1 표기 순서 / D5 src 명시 / phases narrative + risks 보강 / B904 보안 체크리스트 / milestones.md sub_milestones 동기 v3.5). Stage F EXECUTE 결정 흡수 1건 — DESIGN 2-phase 분리 (D2) → 단일 phase 통합 (사용자 명시 결정 2026-05-13, ruff cascade 387→471 actual 로 phase 분리 시 pre-commit 차단, INTENT.out_of_scope #2 허용 범위 + v1.12 / v1.13 패턴 정합 누적 3건). INTENT.success_criteria 7건 모두 VERIFY.criteria_check PASS (pytest 638 passed in 32.75s baseline 정합 + ruff check/format 0 + pre-commit 4 hook PASS + harness-meta smoke 3종 PASS 230/45/1). 6 lessons (L1 ruff cascade multi-pass + L2 Stage F 결정 흡수 누적 3건 + L3 SIM117 py312 parenthesized syntax + L4 외부 spec 사용자 의도 정확 일치 review burden 최소화 + L5 [tool.ruff] src 명시 패턴 + L6 review burden 최소화 누적 evidence 2건). v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 열 번째 실 적용 — § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 10건 + (2) 동결 유지 4회 누적 (v1.7 + v1.12 + v1.13 + v1.14). 후속 candidate 7건 모두 거명만 (§ 6.2 동결 4건 + 적용 대상 부재 자체 흡수 2건 + A_user trigger 대기 1건 = S bandit rule expansion). 2026-05-13."
    },
    {
      "version": "v1.13",
      "id": "upbit-ruff-version-upgrade-evaluation",
      "title": "upbit ruff version v0.4.10 → v0.15.12 업그레이드 평가 + 실 적용 — breaking changes / 21파일 reformat / baseline 정합 검증",
      "status": "completed",
      "milestones_path": "milestones/v1.13/milestones.md",
      "trigger": "A_user",
      "summary": "v1.12 PROPOSE next_candidates_named_only #4 (A_user trigger 대기) 사용자 명시 발의. ruff version pin v0.4.10 → v0.15.12 (최신 stable, 2026-04-24 release) 11 minor jump + 21 파일 reformat (2025/2026 style guide v0.9+v0.15). dry-run 결과 (lint 0 회귀 + format 21파일) 가 실 적용 결과 100% 정합 — ruff 결정적 특성 검증. v0.5~v0.15 11 minor 전수 breaking changes 식별 (default rule set F + E subset, target='py312' 명시로 default 변경 영향 부재). 단일 phase 1 commit (1c96c4a, 24 files +103/-117). 회귀 0 (pytest 638 passed in 32.77s + harness-meta smoke 3종 230/45/1 + pre-commit 4 hook PASS). Stage F EXECUTE 안 사용자 결정 1건 흡수 — poetry 2.3.4 `lock --no-update` 옵션 부재 → AskUserQuestion → `poetry update ruff` 채택 (D5 의도 정합, OOS #3 허용 범위, v1.12 동일 패턴 정합). 4 관점 (architecture / spec-drift / 회귀 risk / scope contract) 병렬 검토 모두 pass-with-comments + 의견 충돌 0 + 권고 3건 흡수 (5 hook narrative 정정 / RESEARCH F+E subset 정확성 / milestones.md 동기). v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 아홉 번째 실 적용 — § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 9건 + (2) 동결 유지 narrative 정합 (v1.7 + v1.12 + v1.13 = 3회 누적 패턴). 6 lessons (L1~L6) 후속 candidate 모두 거명만 (§ 6.2 동결 5건 + A_user trigger 대기 1건 = upbit-ruff-rules-expansion). 2026-05-12."
    },
    {
      "version": "v1.12",
      "id": "upbit-ruff-ci-gate",
      "title": "upbit ruff CI gate 도입 — pre-commit + GitHub Actions ruff check 자동 회귀 방지",
      "status": "completed",
      "milestones_path": "milestones/v1.12/milestones.md",
      "trigger": "A_user",
      "summary": "v1.11 PROPOSE next_candidates_named_only #1 (upbit-ruff-ci-gate, A_user trigger 대기) 사용자 명시 발의. v1.7~v1.11 ruff format/lint cleanup 5건 누적 완료 후 회귀 방지 자동화 부재 해소. 2-leg defense 구조 — phase-1 (.pre-commit-config.yaml ruff/ruff-format hook files 패턴 제거, types: [python] default 전체 .py 자동 커버, local gate, b5a2037) + phase-2 (.github/workflows/quality.yml ruff job 안 ruff check scope 확장 bot/ config/ tests/ scripts/ + 신규 ruff format --check step 동일 scope, remote gate, 8862c82). 3 관점 병렬 검토 (architecture / spec-drift / scope contract) 모두 pass-with-comments + decisive_issues 0건 + 의견 충돌 0건 + 필수 흡수 6건 (P1 2 + P2 4). Stage F EXECUTE 도중 사용자 결정 1건 흡수 (.git/hooks/pre-commit 부재 → pre-commit install 1회, INTENT.out_of_scope #3 허용 범위). INTENT.success_criteria 7건 모두 VERIFY.criteria_check PASS, 회귀 0 (pytest 638 passed in 37.36s, v1.10 baseline 정합), harness-meta smoke 3종 PASS (230 / 45 / 1). 5 lessons (L1~L5) 후속 candidate 5건 모두 거명만 (§ 6.2 동결 권고 3건 + A_user trigger 대기 2건). v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 여덟 번째 실 적용 milestone — § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 8건 도달 + (2) 검증 v3.13 결정 narrative 정합 동결 유지. 2026-05-12."
    },
    {
      "version": "v1.11",
      "id": "upbit-ruff-unsafe-fix-f841",
      "title": "upbit ruff unsafe-fix 7건 (F841 unused local var) 검증 후 정정",
      "status": "completed",
      "milestones_path": "milestones/v1.11/milestones.md",
      "trigger": "C_improvement",
      "summary": "v1.10 Option A 보류 F841 7건 수동 fix 완료. C1~C3 test_live_smoke.py (unused init / context manager binding 2건) / C4 test_market_feed_reconnect.py (unused capture) / C5 test_live_executor.py (unused calc) / C6 test_market_feed.py (unused computed + stale comment 2줄 사용자 결정 제거) / C7 test_paper_executor.py (LHS-only 제거, await side-effect 보존). 5파일 -9+3 LOC. 단일 phase 1 commit (433b8c7). SC#1~SC#7 전원 PASS, 회귀 0. ruff check (전체 codebase) 0 errors 달성. scope-contract FAIL→사용자 결정(SC#6 모순 해소) 패턴 적용. 3 lessons (L1~L3) § 6.2 동결 + ruff CI gate A_user trigger 거명. v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 일곱 번째 실 적용. 2026-05-12."
    },
    {
      "version": "v1.10",
      "id": "upbit-ruff-lint-cleanup",
      "title": "upbit codebase ruff check (lint) 56 위반 일괄 정정 — F401/F841/F541 auto-fix + E741 수동 rename",
      "status": "completed",
      "milestones_path": "milestones/v1.10/milestones.md",
      "trigger": "A_user",
      "summary": "v1.9 PROPOSE next_candidates_named_only 직접 발의. ruff check 56 위반 중 49건 (F401 43 + F541 1 + E741 5) 일괄 정정. Option A (safe-fix만) 채택 — unsafe-fix 7건 (F841 unused local var, ruff 공식 spec에서 unsafe 분류) v1.11 scope defer. 단일 phase 1 commit (8f75d3f), tests/ 21 파일 net +267 LOC. 638 passed / 회귀 0 (E741 rename 시 keyword arg 호출자 누락 회귀 1건 즉시 검출/해소 — REPORT.lessons L2). 5 관점 검토 모두 통과, 사용자 결정 2건 (Option A + tests/ scope), P1/P2/P3 권고 6건 흡수. v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 여섯 번째 실 적용. 5 lessons (L1~L5). v1.11_upbit-ruff-unsafe-fix-f841 후속 등재. 2026-05-13."
    },
    {
      "version": "v1.9",
      "id": "upbit-pytest-failure-fix",
      "title": "upbit pre-existing pytest failure 2건 수정 (test_alerts_yaml + test_compose_local)",
      "status": "completed",
      "milestones_path": "milestones/v1.9/milestones.md",
      "trigger": "A_user",
      "summary": "v1.8 pre-existing failure 2건 수정. (1) test_alerts_yaml_contact_point_discord_prefix — bot-health.yaml 5 rule 최상위에 contact_point: discord-infra 추가 (contact-points.yaml name 정합). (2) test_local_compose_merges_with_base — Python 3.14 subprocess._readerthread Windows race 유발 PytestUnhandledThreadExceptionWarning을 conftest.py _BOT_ORIGIN_FILTERS 격리 패턴 적용. 단일 phase 1 commit (feb723d), 638 passed / 0 failed. harness-meta smoke 3종 PASS, 회귀 0. v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 다섯 번째 실 적용. 3 lessons. 2026-05-13."
    },
    {
      "version": "v1.8",
      "id": "upbit-codebase-tests-scripts-ruff-format-cleanup",
      "title": "upbit codebase tests/ + scripts/ ruff format 90파일 일괄 정정 — v1.7 bot/ 후속",
      "status": "completed",
      "milestones_path": "milestones/v1.8/milestones.md",
      "trigger": "C_improvement",
      "summary": "v1.6 VERIFY out_of_scope_findings #1 직접 후속. tests/ 37파일 + scripts/ 53파일 = 90파일 ruff format mismatch 일괄 정정. 단일 phase 1 commit (f54e9ee), +3194 -1735 LOC (net +1459, 풀기 우세 — v1.7 합치기 우세와 반대). ruff format --check 전체 scope (182파일) 0 mismatch. pytest 2 failed (pre-existing) / 636 passed, 회귀 0. harness-meta smoke 3종 PASS. v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 네 번째 실 적용. 3 lessons (L1~L3). 후속 2건 거명만 (pytest failure fix / ruff lint cleanup). 2026-05-12."
    },
    {
      "version": "v1.4",
      "id": "upbit-cross-ref-cleanup",
      "title": "upbit repo 측 stale cross-ref 정리 — sessions/ / DECISIONS.md 참조 제거",
      "status": "completed",
      "summary": "upbit repo 내 폐기된 sessions/meta·upbit 경로 / DECISIONS.md 참조 정리 완료. CLAUDE.md(3) + harness-engineer.md(1) + harness-ship/SKILL.md(1) + docs/HARNESS.md(1) = 7위치 제거·갱신. smoke-bundle-trigger non-meta asymmetry 근본 해소 (is_meta guard + gitignore, harness-meta a7e499b). pre-existing CI 실패(test_statusline_sh_smoke) 해소 (upbit f4554f2). 2026-05-11.",
      "trigger": "A_user",
      "milestones_path": "milestones/v1.4/milestones.md"
    },
    {
      "version": "v1.5",
      "id": "statusline-cmd-migration",
      "title": "statusline 풍부한 출력 복원 (v1.6/v1.7 spec 후속)",
      "status": "completed",
      "milestones_path": "milestones/v1.5/milestones.md",
      "summary": "v1.6 statusline.sh dispatcher design + v1.7 contract formalization 도입 후 누락 wiring 복원. Option B 채택 (python summary action + toml one-liner, spawn 1회 663ms 측정 — v2.1_smoke-spawn-batching batched python 패턴 정합). 2 phase: phase-1 (e677038, statusline_stats.py +27 lines: summary() + module docstring + _main elif + test 5건) / phase-2 (b385d0a, .harness.toml +1 line statusline_cmd). 3 관점 병렬 검토 (architecture / spec-drift / scope contract) 모두 pass-with-comments + 결정적 issue 0건 + 의견 충돌 0건. P1 즉시 흡수 3건 (D4 token count 4→5 / INTENT.successor v3.10 정정 / 자기참조 narrative 정정) + P2 Stage D 안 흡수 3건 (Claude Code stdin contract / lightweight 거부 / module docstring summary entry) + P3 후속 흡수 3건 (latency 663ms 측정 / refresh 시점 narrative / composite docstring). INTENT.success_criteria 7건 모두 VERIFY.criteria_check PASS, 회귀 0건. wiring 검증 3 step (T1 minimal fallback / T2 latency 22% 사용 / T3 manual sequence 임시 in_progress → Format A `[harness] v1.5/7-dashboard-provisioning · 4/4 · $3.84` → revert 복원). 사전 정리 chore commit 3건 분리 (087b894 frontmatter / 003c89c harness-python backfill / 4f4e437 ruff format existing test indentation) — scope contract 정합. v3.0+ 9-stage-bundled era 의 외부 projects/<name>, name ≠ meta 첫 실 적용 milestone 사실 진술 (meta § 6.2 deferred 3건 재발의 trigger 조건 (1) 충족 narrative cascade 표지). 7 lessons (L1~L7) 중 4 후속 candidate 모두 § 6.2 동결 거명만 (ROADMAP 미등재). 2026-05-12.",
      "trigger": "B_regression"
    },
    {
      "version": "v1.6",
      "id": "manifest-upgrade-1-1",
      "title": ".harness.toml schema_version 1.0 → 1.1 bump + 신규 필드 활성화",
      "status": "completed",
      "milestones_path": "milestones/v1.6/milestones.md",
      "summary": "upbit `.harness.toml` schema_version 1.0 → 1.1 bump + v1.1 additive 5 항목 활성화 (runtime_version=\"3.12\" + locale=\"ko\" + [agents].primary=\"claude-code\" + [testing].format_cmd) + python_version 즉시 교체 (runtime_version migration, D2). Option B 채택 (state_file / statusline_timeout_ms / [build] 제외 — 의미 부재 risk 회피). 단일 phase 1 commit (da5db9d), 변경 LOC +5/-1. 3 관점 병렬 검토 (architecture / spec-drift / scope contract) 모두 pass-with-comments + 결정적 issue 2건 (D5 --check 의미 + D1~D5 rationale audit trail 거명) P1 즉시 흡수 완료 + 의견 충돌 0. INTENT.success_criteria 7건 모두 PASS (SC#6 vacuously, SC#7 Stage I). harness-meta integration test 10/10 PASS + upbit pre-commit 0 block + 회귀 0. VERIFY out_of_scope_findings 1건 (upbit codebase 18 파일 ruff format mismatch, PROPOSE 거명 source). v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 두 번째 실 적용 milestone — § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 카운트 2건. § 6.2 동결 정책 적용 대상 부재 (manifest schema upgrade 본질 = upbit 자체 기능 개선). 5 lessons (L1~L5) 중 4 후속 candidate 모두 거명만 (ROADMAP 미등재, § 6.2 + 사용자 명시 발의 부재). 2026-05-12.",
      "trigger": "E_priority",
      "renumbered_from": "v1.6_manifest-upgrade-1-1 (flat schema → v3.0+ bundled schema forward-only, ARCHITECTURE.md § 6.1)"
    },
    {
      "version": "v1.7",
      "id": "upbit-codebase-ruff-format-batch-cleanup",
      "title": "upbit codebase ruff format 18 파일 mismatch 일괄 정정 — v1.6 format_cmd 활성화 직접 후속",
      "status": "completed",
      "milestones_path": "milestones/v1.7/milestones.md",
      "summary": "v1.6 PROPOSE next_candidates_named_only #1 직접 발의 (사용자 명시 발의, A_user 재분류 candidate origin). v1.6 manifest schema 1.0→1.1 bump 후 format_cmd 활성화로 발견된 upbit codebase 18 파일 ruff format mismatch 일괄 정정. 단일 phase 1 commit (d4b5366), `poetry run ruff format bot/ config/` 안 bot/ 18 파일 정정 + config/ 0 vacuous. +366 -450 LOC / net -84 (멀티라인 합치기 우세, line-length 100 기준). 4 관점 병렬 검토 (architecture / spec-drift / 회귀 risk / scope contract) 모두 pass-with-comments + 결정적 issue 0건 + 의견 충돌 0건 + P1 권고 6건 + P2 권고 1건 흡수 (Stage D 안). 5 smoke (upbit ruff format --check + pytest tests/ pre-existing 검증 + harness-meta spec-verification 230 PASS / scope-contract 45 PASS / bundle-trigger PASS) 모두 PASS + 회귀 0 (pre-existing 2 pytest failure `git stash push -- bot/` 검증으로 v1.7 정정 무관 확정). INTENT.success_criteria 7건 중 5 PASS + 2 (SC#5/SC#7) Stage I 완성. v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 세 번째 실 적용 milestone — § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 카운트 3건 도달. 5 lessons (L1~L5) 중 5 후속 candidate 모두 거명만 (§ 6.2 동결 정책 정합 분류: 적용 대상 부재 2건 + 직접 적용 3건). § 6.2 동결 정책 적용 대상 부재 (upbit 자체 codebase 정정 본질). 2026-05-12.",
      "trigger": "C_improvement"
    },
    {
      "id": "v1.3_roadmap-backfill",
      "title": "Bootstrap S6 5종 파일 체계 소급 보완",
      "status": "completed",
      "summary": "projects/upbit/ROADMAP.md 신규 작성 (v1.0~v1.2 이력 기반). pending 2건 trigger 대기 이관. 2026-04-30.",
      "trigger": null
    },
    {
      "id": "v1.2_python-overlay-apply",
      "title": "Python overlay T4 후행 (meta v1.11b)",
      "status": "completed",
      "summary": "harness-python/SKILL.md + python-quality.md upbit 배포. install-project-claude.sh --force exit 0. 6 skill + 4 agent + output-style 회귀 0. 2026-04-28.",
      "trigger": null
    },
    {
      "id": "v1.1_skills-migration",
      "title": "commands→skills 마이그레이션 (meta v1.8b)",
      "status": "completed",
      "summary": ".claude/commands/ 6 파일 삭제 + skills 6 정리. .claude/backup-*/ gitignore 추가. rename 3 + delete 3 + modified 3. 2026-04-25.",
      "trigger": null
    },
    {
      "id": "v1.0_project-claude-install",
      "title": "초기 .claude/ 배포 (meta v1.8 BREAKING 후속)",
      "status": "completed",
      "summary": "install-project-claude.ps1 실행 → upbit .claude/ 17 파일 복구 (commands 6 + agents 4 + skills 6 + output-styles 1). upbit commit 703a21e. 2026-04-25.",
      "trigger": null
    }
  ]
}
```

## 관련 문서

- 프로젝트 아키텍처: [`ARCHITECTURE.md`](ARCHITECTURE.md)
- 프로젝트 thin index (root): [`../../ROADMAP.md`](../../ROADMAP.md)
- 메타 ROADMAP (참조): [`../meta/ROADMAP.md`](../meta/ROADMAP.md)
- 워크플로우 진입점: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md)
- upbit `.harness.toml` 매니페스트: (upbit repo 루트)

## 마이그레이션 노트 (2026-05-08, milestone v1.0_workflow-redesign phase-4)

기존 §2 (pending) + §6 (완료) 표 형식 → 단일 `milestones[]` JSON 배열로 통합.
완료 항목들은 4-tier 워크플로우 시대 (sessions/upbit/v{X}-{slug}/) 산출. 신규 작업은 v3.0+ 9-stage-bundled 흐름 의무 (ARCHITECTURE.md § 6.1).
DECISIONS / INTERVIEW / STACK 폐기 — 필요 시 ARCHITECTURE.md에 흡수 또는 milestone RESEARCH.md에 기록.
