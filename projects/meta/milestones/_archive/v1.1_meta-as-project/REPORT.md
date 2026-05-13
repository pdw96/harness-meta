# REPORT — v1.1_meta-as-project

```json
{
  "id": "v1.1_meta-as-project",
  "completed_at": "2026-05-08",
  "verdict": "pass",
  "summary": [
    "v1.0_workflow-redesign 직후 발견된 ROADMAP scope misclassification (root ROADMAP에 v1.1_upbit-cross-ref-cleanup 잘못 등재) 을 계기로, 사용자 발의로 'meta 도 일반 project처럼 projects/<name>/ 하위로 이관' 구조 개혁 milestone 진행. 단순 항목 이관이 아니라 디렉토리 위치 자체가 scope 강제하는 동형 구조 + 재발 방지 smoke 까지 동반.",
    "5 관점 병렬 검토 (architecture / spec-drift / 회귀 risk / 보안 / scope contract) 에서 발견된 핵심 이슈: (1) phase 2/3 broken window — atomic 통합 필요 / (2) CLAUDE.md @import dual vs single 충돌 / (3) optional sweep 4건 추가. 모두 사용자 결정 후 DESIGN.decisions 8건으로 잠금. atomic minimal phase 2 (git mv + thin index + harness-meta.md path resolution 단일 commit) 채택으로 broken window 0 달성. @import 은 single + lazy subdir CLAUDE.md 신설 (토큰 효율 + 발견성 둘 다).",
    "3 phase commit (7bfa1a5 → 0fa3d32 → e2f59de). 총 ~69 files changed. 회귀 0 (3 pre-commit chain 모두 통과). smoke-projects-scope-discipline 단독 active 활성화 — 미래 misclassification 자동 차단. v1.0 후속 backlog 3건 (v1.1_smoke-precommit-rewrite / v1.1_post-report-write-hook-update / v1.1_design-phases-execute-tracking-automation) 은 본 milestone 결과물 위에서 진행 가능한 상태로 정합 잠금."
  ],
  "delta": {
    "files_changed": 69,
    "files_added": 11,
    "files_deleted": 0,
    "files_renamed": 42,
    "files_modified": 16,
    "lines_inserted_total": 919,
    "lines_deleted_total": 105,
    "modules_affected": [
      "projects/meta/ (신규) — ROADMAP.md / ARCHITECTURE.md / CLAUDE.md / milestones/ (git mv)",
      "ROADMAP.md (root) — 6 milestones[] → thin index ({projects: [...]})",
      "claude/commands/harness-meta.md — Stage A/B path resolution + 금지 list 보강",
      "tests/smoke-projects-scope-discipline.sh (신규) + .pre-commit-config.yaml (신규 active block + 주석 갱신)",
      "CLAUDE.md / AGENTS.md / README.md / claude/CLAUDE.md / tests/CLAUDE.md / bootstrap/skills/CLAUDE.md (cross-ref 갱신)",
      "verify.{sh,ps1} / claude/hooks/post-report-write.sh (텍스트 메시지)",
      "projects/upbit/ROADMAP.md / projects/upbit/ARCHITECTURE.md (cross-ref + 디렉토리 트리)",
      "bootstrap/skills/audit/harness-roadmap-update/SKILL.md (DEPRECATED 주석)",
      ".claude/settings.local.json (gitignored, dead Bash entry prune)"
    ],
    "commits": [
      {"sha": "7bfa1a5", "phase": 1, "title": "projects/meta/ skeleton + scope-discipline smoke (additive)", "files": 10, "insertions": 704, "deletions": 0},
      {"sha": "0fa3d32", "phase": 2, "title": "atomic flip (git mv milestones + thin index + harness-meta.md path resolution)", "files": 44, "insertions": 87, "deletions": 56},
      {"sha": "e2f59de", "phase": 3, "title": "cross-ref sweep + optional sweeps + scope-discipline smoke 활성화", "files": 15, "insertions": 128, "deletions": 49}
    ]
  },
  "lessons_learned": [
    {
      "lesson": "Pre-PLAN 사용자 검토 round가 RESEARCH 보강을 정확하게 유도",
      "context": "사용자 'detail 검토' 요청에 대응해 RESEARCH 11건 자체 결함 발견 (milestone count 오류 / 라인 번호 누락 / target_state 도식 / options 미명세 등). 이 보강이 5 관점 검토의 출발점 정합을 결정.",
      "applies_to": "큰 milestone (16+ 파일) 진입 전 RESEARCH 자체 review round 의무화 검토"
    },
    {
      "lesson": "5 관점 검토의 충돌이 사용자 결정 분기점 명시화에 결정적",
      "context": "architecture (dual @import) vs spec-drift (single @import per token efficiency). RESEARCH 단계에서는 옵션 미열거. 5 관점 검토 단계에서 비로소 충돌 가시화 → 사용자 결정 후 'single + lazy subdir CLAUDE.md' 새 옵션 도출.",
      "applies_to": "DESIGN 5 관점 출력의 단순 정렬보다 '관점 간 충돌' 명시 추출이 사용자 결정 효율 향상"
    },
    {
      "lesson": "atomic phase 분할 — broken window 분석은 architecture 관점이 핵심",
      "context": "RESEARCH P1 (additive → mv → cross-ref → smoke) 4 phase 가 architecture C2 분석에서 phase 2/3 사이 broken window 발견 → 3 phase atomic minimal 로 재설계. RESEARCH 단계에서 path resolution 동시성을 미고려.",
      "applies_to": "phase ordering 옵션은 RESEARCH 가 아닌 architecture 관점 검토 후 잠금"
    },
    {
      "lesson": "Markdownlint MD022/MD032 (heading/list blank line) 자주 반복",
      "context": "phase 1 commit 1차 fail. DESIGN.md '5 관점 검토 요약' 섹션 의 ### heading 직후 list 시작 시 blank line 부족.",
      "applies_to": "DESIGN.md template 또는 .markdownlint.json 에 자동 정정 또는 template 강제 검토"
    },
    {
      "lesson": "git mv (cross-directory bulk) 가 history 보존 + line ending / blob 무수정 — R5 risk 거의 0 확인",
      "context": "milestones/ → projects/meta/milestones/ 단일 git mv 명령 (42 renames, 41 at 100% similarity). path 만 변경, 내용/blob/line ending 무영향.",
      "applies_to": "R5-class risks (line ending) 향후 git mv 활용 시 사전 검증 단계 단순화 가능"
    },
    {
      "lesson": "subdirectory CLAUDE.md (lazy load) = root @import 보완 메커니즘",
      "context": "spec-drift agent 가 Claude Code @import 5-hop recursion limit + lazy subdir 메커니즘 제시. 본 migration 에서 root @ROADMAP.md (thin index) + projects/meta/CLAUDE.md (lazy load via @ROADMAP.md=projects/meta/ROADMAP.md) 패턴으로 토큰 효율 + 발견성 둘 다 확보.",
      "applies_to": "향후 추가 project 도입 시 동일 패턴 (projects/<name>/CLAUDE.md lazy load) 활용"
    },
    {
      "lesson": "scope-discipline smoke 가 컨벤션을 디렉토리 위치로 강제하는 효과",
      "context": "이전 컨벤션 (projects/<name>/ROADMAP 에만 milestone 등재) 은 명문화 되어 있었으나 자동 검증 부재로 silent misclassification 발생. 본 milestone 후 root ROADMAP에 milestones[] 키 추가 시도 = pre-commit fail.",
      "applies_to": "다른 컨벤션 (e.g., DESIGN.approval 게이트, milestone 번호 단조 증가) 도 smoke 자동 검증 도입 고려"
    }
  ],
  "next_candidates": [
    {
      "id": "v1.1_smoke-precommit-rewrite",
      "trigger": "B_regression",
      "trigger_type": "기존 pending milestone (정합 잠금)",
      "notes": "본 milestone 결과로 path 컨벤션 (projects/<name>/milestones/) 확정 + 기존 disabled smoke 4종 주석의 path 기준이 갱신 됨. 재작성 시 본 path 기반으로 진행."
    },
    {
      "id": "v1.1_post-report-write-hook-update",
      "trigger": "B_regression",
      "trigger_type": "기존 pending milestone (정합 잠금)",
      "notes": "post-report-write.sh 패턴 갱신 — 본 milestone에서 path가 sessions/.* → projects/meta/milestones/v.* 로 정합. 새 패턴 적용 후 hook silent NOOP 해소."
    },
    {
      "id": "v1.1_design-phases-execute-tracking-automation",
      "trigger": "D_design",
      "trigger_type": "기존 pending milestone (영향 없음)",
      "notes": "DESIGN.phases[n].affected_files 자동 트래킹 — 본 milestone 영향 없음, 독립 진행 가능."
    },
    {
      "id": "v1.1_readme-cleanup",
      "trigger": "A_user",
      "trigger_type": "신규 발의 (선택)",
      "notes": "README.md 의 legacy 참조 (Bootstrap mode 표기 / DECISIONS.md / INTERVIEW.md / STACK.md 5-doc projects/<name>/ 표기 / sessions/ 트리 일부) 본 milestone phase 3 에서 디렉토리 트리 + Key docs 갱신했으나 다른 섹션 (Activating a project / Bootstrap mode 안내) 잔존. 사용자 trigger 시 별도 cleanup milestone."
    }
  ]
}
```
