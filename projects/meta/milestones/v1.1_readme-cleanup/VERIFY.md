# VERIFY — v1.1_readme-cleanup

```json
{
  "id": "v1.1_readme-cleanup",
  "smoke_tests": [
    {
      "name": "markdownlint",
      "command": "pre-commit run markdownlint --files README.md",
      "result": "pass",
      "output": "markdownlint...Passed"
    },
    {
      "name": "smoke-projects-scope-discipline",
      "command": "pre-commit run --all-files",
      "result": "pass",
      "output": "Smoke — projects/<name>/ROADMAP scope discipline...Passed (README.md는 smoke 대상 외 — 정상)"
    },
    {
      "name": "pre-commit full run",
      "command": "pre-commit run --all-files",
      "result": "pass",
      "output": "fix end of files / trim trailing whitespace / check yaml / shellcheck / markdownlint / scope-discipline — all Passed"
    }
  ],
  "manual_checks": [
    {
      "check": "README.md에 '10-stage' 문자열 잔존 여부",
      "result": "pass",
      "notes": "grep 결과 0건. line 6에 '7-stage workflow' 표현으로 교체됨"
    },
    {
      "check": "Bootstrap mode 문단 잔존 여부",
      "result": "pass",
      "notes": "'Bootstrap mode' 문자열 README.md에 없음. Onboard a new project 섹션으로 교체됨"
    },
    {
      "check": "/harness-plan·design·run·ship 명령 잔존 여부",
      "result": "pass",
      "notes": "Usage 테이블이 /harness-meta 2행으로 축소됨"
    },
    {
      "check": "sessions/ 경로 잔존 여부",
      "result": "pass",
      "notes": "milestones/v{X.Y}_{slug}/ 로 교체됨"
    },
    {
      "check": "미존재 파일 링크 (bootstrap/docs, bootstrap/templates, bootstrap/manifest-schema.md) 잔존 여부",
      "result": "pass",
      "notes": "Key docs 테이블에서 4행 제거됨. Language overlay 섹션 전체 제거됨"
    },
    {
      "check": "DECISIONS/INTERVIEW/STACK 5-doc 표기 잔존 여부",
      "result": "pass",
      "notes": "README.md에 해당 표기 원래 없었음 — 다른 문서에서 폐기된 참조"
    }
  ],
  "criteria_check": [
    {
      "criterion": "README.md 내 '10-stage workflow' 표현이 사라지고 현 7-stage workflow로 교체된다",
      "result": "pass",
      "evidence": "line 6: 'Harness wraps Claude Code sessions into a **7-stage workflow**: ROADMAP → MILESTONE → PLAN → RESEARCH → DESIGN → EXECUTE → VERIFY → REPORT'"
    },
    {
      "criterion": "Bootstrap mode 안내 문단이 제거 또는 현 신규 프로젝트 도입 절차로 교체된다",
      "result": "pass",
      "evidence": "'Onboard a new project' 섹션으로 교체. /harness-meta <new-project-name> + .harness.toml 부재 시 동작 설명"
    },
    {
      "criterion": "구 slash command 표(/harness-plan·design·run·ship)가 제거 또는 /harness-meta 단일 명령으로 교체된다",
      "result": "pass",
      "evidence": "Usage 테이블: /harness-meta 2행만 존재"
    },
    {
      "criterion": "sessions/ 경로 참조가 projects/meta/milestones/ 또는 현 milestone 경로로 교체된다",
      "result": "pass",
      "evidence": "Usage 섹션: 'projects/{meta or <name>}/milestones/v{X.Y}_{slug}/'"
    },
    {
      "criterion": "DECISIONS/INTERVIEW/STACK 5-doc 표기가 README.md에 잔존하지 않는다",
      "result": "pass",
      "evidence": "원래 README.md에 해당 표기 없었음 — criteria 충족"
    },
    {
      "criterion": "pre-commit run으로 markdownlint + scope-discipline smoke가 통과한다",
      "result": "pass",
      "evidence": "pre-commit run --all-files: all Passed (2 commits: 07c13d8, f694b16)"
    },
    {
      "criterion": "README.md가 현재 설치·사용 흐름을 독자 혼동 없이 기술한다",
      "result": "pass",
      "evidence": "Installation: Stage 1(global) + Stage 2(optional skills). Usage: /harness-meta 7-stage. Activating: .harness.toml + /harness-meta <name> 온보딩. Key docs: 실존 파일 7개만"
    }
  ],
  "verdict": "pass",
  "regressions": []
}
```
