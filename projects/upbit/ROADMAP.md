# ROADMAP — upbit

```json
{
  "project": "upbit",
  "updated": "2026-05-11",
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
      "id": "v1.5_statusline-cmd-migration",
      "title": "statusline 풍부한 출력 복원 (v1.6/v1.7 spec 후속)",
      "status": "pending",
      "summary": "verify.ps1/sh statusline 출력 불완전 또는 사용자 요청 시 진행. v1.0 REPORT 후속 세션 연결에서 등록. (v1.4 cross-ref-cleanup 이후 v1.5+ 로 renumber. 작업 시 v3.0+ bundled 포맷 적용.)",
      "trigger": "B_regression"
    },
    {
      "id": "v1.6_manifest-upgrade-1-1",
      "title": ".harness.toml schema_version 1.0 → 1.1 bump",
      "status": "pending",
      "summary": "v1.1 신규 필드(runtime_version / state_file 등) 활성화 원할 때 진행. (v1.4 cross-ref-cleanup 이후 v1.6 로 renumber. 작업 시 v3.0+ bundled 포맷 적용.)",
      "trigger": "E_priority"
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
