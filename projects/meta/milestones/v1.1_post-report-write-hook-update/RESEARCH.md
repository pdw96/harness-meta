# RESEARCH — v1.1_post-report-write-hook-update

```json
{
  "id": "v1.1_post-report-write-hook-update",
  "external": [],
  "codebase": {
    "affected_files": [
      "claude/hooks/post-report-write.sh",
      "tests/smoke-posttooluse-hook.sh"
    ],
    "untouched_files": [
      "install.ps1",
      ".pre-commit-config.yaml",
      "claude/CLAUDE.md"
    ],
    "current_state": {
      "hook_path_regex": {
        "REPORT_type": "sessions/[^/]+/[^/]+/REPORT\\.(md|ipynb)$ (line 128)",
        "PLAN_type": "sessions/[^/]+/[^/]+/PLAN\\.md$ (line 131)",
        "status": "silent NOOP for all new 7-stage milestone artifacts"
      },
      "smoke_base_path": "sessions/meta/v1.36b-test/REPORT.md (line 52)",
      "smoke_test_count": "17 dynamic tests (A~Q), 3 static — 20 total",
      "tests_using_sessions_path": ["A", "C", "D", "E", "F", "G", "H", "I", "J", "K"],
      "tests_using_sessions_ipynb": ["M", "O"],
      "tests_using_sessions_plan": ["P"],
      "test_Q_non_sessions_noop": "docs/PLAN.md → NOOP (경로 가드, will keep same logic)"
    },
    "target_state": {
      "hook_path_regex": {
        "REPORT_type": "projects/[^/]+/milestones/v[^/]+/(RESEARCH|DESIGN|VERIFY|REPORT|execute/[^/]+)\\.md$",
        "PLAN_type": "projects/[^/]+/milestones/v[^/]+/PLAN\\.md$",
        "sessions_pattern": "제거"
      },
      "smoke_base_path": "projects/meta/milestones/v1.1_test/REPORT.md",
      "notebooks_in_milestones": "없음 — NotebookEdit은 NOOP (milestones 파일은 .md only)"
    }
  },
  "options": [
    {
      "id": "A",
      "title": "two-clause regex (현행 구조 유지)",
      "approach": "REPORT_type regex + PLAN_type regex 두 줄 분리 유지, 패턴만 교체",
      "pros": ["현행 if/elif 구조 유지 — diff 최소화", "FILE_TYPE 분기 명확"],
      "cons": ["REPORT_type에서 PLAN 제외 명시 필요 (실수 여지)"]
    },
    {
      "id": "B",
      "title": "combined regex + sub-check",
      "approach": "단일 combinned 정규식으로 모든 artifact 매치 후, PLAN.md 여부 서브체크",
      "pros": ["milestone 패턴 단일 정의 — DRY"],
      "cons": ["두 줄 grep → 구조 변경 (불필요한 복잡화)"]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "desc": "smoke 17 tests 중 sessions/ 경로 사용 test (A~K, M, O, P) 10+ 건이 new 패턴에서 FAIL",
      "mitigation": "smoke 업데이트를 hook과 동일 phase에서 수행 (pre-commit 통과)"
    },
    {
      "id": "R2",
      "desc": "NotebookEdit + REPORT.ipynb tests (M, O)가 기존 trigger → new NOOP으로 동작 변경",
      "mitigation": "테스트 기대값 NOOP으로 업데이트 (out of scope: NotebookEdit 경로 지원 확장 명시)"
    },
    {
      "id": "R3",
      "desc": "execute/phase-{n}.md 경로에 대한 기존 테스트 부재 — 신규 추가 필요",
      "mitigation": "Test R 신규 추가 (execute/phase-1.md 경로 → additionalContext 포함)"
    },
    {
      "id": "R4",
      "desc": "구 sessions/ 경로가 NOOP임을 명시적으로 검증하는 테스트 부재",
      "mitigation": "Test S 신규 추가 (old sessions/ path → NOOP, 회귀 방지)"
    }
  ]
}
```
