# RESEARCH — v3.11 legacy-narrative-cleanup

```json
{
  "id": "v3.11_legacy-narrative-cleanup",
  "external": [
    {
      "source": "v3.6_overengineering-audit ARCHITECTURE.md § 6.2",
      "topic": "Lightweight 모드 trigger 조건",
      "findings": "본 milestone 3 trigger 조건 모두 충족 — (1) 메타 인프라 narrative 변경 (외부 프로젝트 적용 부재), (2) ≤5 파일 (3건 cleanup), (3) 5 관점 의견 충돌 부재 예상 (architecture/보안 분기 부재).",
      "drift": "없음 — § 6.2 trigger 정의 직접 적용"
    },
    {
      "source": "v3.10_stage-byproduct-clarification claude/commands/harness-meta.md Stage B/C/D 부산물 정의",
      "topic": "INTENT.out_of_scope / RESEARCH.untouched_files_explicit / risks_identified 부산물 정책",
      "findings": "본 milestone 안 out_of_scope entry / untouched_files_explicit 모두 negative scope 사실 진술 — forward propose 명령형 표현 부재. PROPOSE 단계 next_candidates 통합 흡수 책임 적용.",
      "drift": "없음"
    },
    {
      "source": "v3.0_milestones-restructure ARCHITECTURE.md § 6.1",
      "topic": "9-stage-bundled era forward-only 정책",
      "findings": "v1.5_legacy-narrative-cleanup (v1.x era pending entry) 의 v3.11 renumber 처리 정합. ROADMAP entry id schema 변경 (`v1.5_legacy-narrative-cleanup` flat → `{version: v3.11, id: legacy-narrative-cleanup}` 신 schema).",
      "drift": "없음 — renumbered_from 필드로 origin 이력 보존"
    }
  ],
  "codebase": {
    "affected_files": [
      "claude/CLAUDE.md (L39 PostToolUse 섹션 narrative)",
      "projects/upbit/ARCHITECTURE.md (L106 현행 안내 stale path)",
      "CHANGELOG.md (L3 era 카테고리 narrative)"
    ],
    "untouched_files_explicit": [
      "claude/hooks/post-report-write.sh (L2 이미 fix 완료 — '9-stage milestone 산출물 Write/Edit 감지' 갱신됨, 거명 자체 stale)",
      "projects/upbit/ROADMAP.md L11/L13 (v1.4_upbit-cross-ref-cleanup completion entry summary, historical 보존)",
      "projects/upbit/ROADMAP.md L74 (historical completion narrative, 보존)",
      "projects/upbit/ARCHITECTURE.md L100~L105 (upbit 고유 slash command 안내 /harness-plan / harness-design / harness-run / harness-ship / harness-review, upbit repo 본인 책임 scope)",
      "projects/upbit/ARCHITECTURE.md L133 ('레거시 이력: harness-meta/sessions/upbit/v1.1-legacy/ ~ v1.4-legacy/' historical 이력, 보존)"
    ],
    "current_state": {
      "claude_claude_md_l39": "기존 패턴은 `sessions/.*/REPORT\\.(md|ipynb)$` + `PLAN\\.md$` 기반 (4-tier era 잔존 narrative — v1.5_legacy-narrative-cleanup 후속 milestone 에서 정리 예정). 신규 9-stage (v2.0+) `projects/meta/milestones/v{X.Y}_/` 패턴 갱신은 v1.1_post-report-write-hook-update 에서 7-stage 패턴 적용 후 v2.0_workflow-word-fidelity 에서 9-stage 패턴 갱신.",
      "upbit_arch_l106": "/harness-meta         → 하네스 자체 개선 세션 (harness-meta/sessions/upbit/vX.Y-{name}/)",
      "changelog_l3": "User-facing highlights for the harness-meta repo. For detailed change records, see `projects/meta/milestones/v{X.Y}_{slug}/REPORT.md` (v2.0+ 9-stage era) 또는 `projects/meta/milestones/v{X.Y}_{slug}/REPORT.md` (v1.0~v1.4 7-stage era)."
    },
    "target_state": {
      "claude_claude_md_l39": "현행 패턴 = v3.0+ 9-stage-bundled era `projects/meta/milestones/v{X.Y}/{INTENT,RESEARCH,DESIGN,APPROVE,VERIFY,REPORT,PROPOSE}.md` + `execute/phase-{n}.md` + v2.0~v2.1 보존 era `v{X.Y}_{slug}/` 동일 산출 + v1.0~v1.4 7-stage era `v{X.Y}_{slug}/PLAN.md` ... 형태로 갱신. 정리 예정 narrative 제거.",
      "upbit_arch_l106": "/harness-meta         → 하네스 자체 개선 세션 (harness-meta repo: projects/meta/milestones/v{X.Y}/ 또는 v{X.Y}_{slug}/)",
      "changelog_l3": "v3.0+ 9-stage-bundled era 카테고리 추가 — `projects/meta/milestones/v{X.Y}/REPORT.md` (v3.0+ 9-stage-bundled) + `v{X.Y}_{slug}/REPORT.md` (v2.0~v2.1 9-stage / v1.0~v1.4 7-stage)."
    }
  },
  "options": [
    {
      "name": "A. 3위치 일괄 갱신 (Recommended)",
      "scope": "claude/CLAUDE.md L39 + upbit/ARCHITECTURE.md L106 + CHANGELOG.md L3",
      "pros": "단일 phase 1 commit 적합 (Lightweight 모드 LOC cap 정합). 3위치 narrative 모두 v3.0+ era 정합화 동시 처리. 회귀 risk 0 (narrative 단순 갱신, 패턴/코드 변경 부재)",
      "cons": "phase 작아도 3 파일 동시 변경 = atomic 보장 (실패 risk 0)"
    },
    {
      "name": "B. 위치별 phase 분리 (3 phase)",
      "scope": "phase-1 claude/CLAUDE.md / phase-2 upbit/ARCHITECTURE.md / phase-3 CHANGELOG.md",
      "pros": "각 phase commit granular, rollback 단순",
      "cons": "narrative 정리 단순 작업에 3 commit 과잉. Lightweight 모드 LOC cap 위배 risk (산출물 분할 oh). v3.10 1 phase 선례와 drift"
    },
    {
      "name": "C. 추가 scope 확장 (upbit L100~105 7-stage 안내 정리)",
      "scope": "A + projects/upbit/ARCHITECTURE.md L100~L105 7-stage slash command 안내 정리",
      "pros": "upbit ARCHITECTURE.md 안 stale narrative 일괄 처리",
      "cons": "L100~L105 는 upbit 고유 slash command (upbit repo 본인 책임), 본 milestone scope 침범. 사용자 historical 보존 결정 정합 위배"
    }
  ],
  "risks_identified": [
    "claude/CLAUDE.md L39 narrative 갱신 후 회귀 risk — post-report-write.sh 실 패턴 (이미 9-stage) 과 narrative 정합 검증 필요 (smoke 자동 검증 부재, 수동 grep)",
    "upbit/ARCHITECTURE.md L106 갱신 시 v3.0+ era 패턴 거명 안 v{X.Y}/ vs v{X.Y}_{slug}/ 동시 표기 필요 — 한 쪽만 거명 시 era 분기 잔존 narrative drift",
    "CHANGELOG.md L3 v3.0+ era 카테고리 추가 시 markdown 가독성 (3 era 거명 = 줄 길이 증가) — markdownlint rule 미위반 검증 필요 (line length cap)"
  ]
}
```

## Lightweight 모드 적용 narrative

§ 6.2 trigger 3건 모두 충족 — 5 관점 subagent 병렬 검토 **생략**. self_reference_policy: "avoid" 표지 (milestones.md 이미 명시). 본 milestone 본질은 4-tier era 잔존 narrative 정리 — workflow self-improvement 부재 → § 6.2 동결 정책 무관.
