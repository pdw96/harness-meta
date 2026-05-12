# ROADMAP — upbit

```json
{
  "project": "upbit",
  "updated": "2026-05-12",
  "schema_note": "v3.0+ 9-stage-bundled era entry: {version, id (group-slug), title, status, summary, trigger, milestones_path?}. v2.0~v2.1 / v1.0~v1.4 보존 entry: 기존 schema (id flat = v{X.Y}_{slug}) 유지 (forward-only).",
  "milestones": [
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
