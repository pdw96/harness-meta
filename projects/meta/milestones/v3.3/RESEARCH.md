# RESEARCH — v3.3 ci-inactive-smoke-cleanup

```json
{
  "id": "v3.3",
  "external": [
    {
      "source": "GitHub Actions CI log (post-v3.1 push, 2026-05-10)",
      "topic": "CI fail 현황",
      "findings": "28 smoke 중 16건 FAIL. v3.0 push 시점부터 동일 state (v3.1 회귀 0). bootstrap/templates, sessions/, bootstrap/docs 인프라 부재가 root cause.",
      "drift": "ROADMAP summary 16건 vs 실측 17건 — smoke-bundle-trigger.sh 1건 OPEN Stage A 중 in_progress 전환 + milestones_path 누락으로 신규 fail. milestones_path 추가로 즉시 해소."
    }
  ],
  "codebase": {
    "affected_files": [
      ".github/workflows/ci.yml"
    ],
    "untouched_files": [
      "tests/smoke-*.sh (16건 inactive — 삭제 없이 보존)",
      ".pre-commit-config.yaml (변경 없음 — active hook 13건 현행 유지)"
    ],
    "current_state": {
      "ci_yml": "모든 tests/smoke-*.sh 28건 glob 실행 — inactive 16건 포함 fail 누적",
      "smoke_pass": "12건 PASS (active 6 + inactive 6: agentic-safety-na / detect-language / posttooluse-hook / python-entry-boilerplate / roi-regression / scorer-output-newline)",
      "smoke_fail_16": [
        "smoke-backup-cleanup.sh",
        "smoke-bash-permission-pattern.sh",
        "smoke-bootstrap-agents-md.sh",
        "smoke-bootstrap-license-boilerplate.sh",
        "smoke-bootstrap-license-detect.sh",
        "smoke-bootstrap-license-metadata.sh",
        "smoke-bootstrap-render.sh",
        "smoke-broad-bash-fine-grain.sh",
        "smoke-language-overlay.sh",
        "smoke-legacy-cleanup-overlay.sh",
        "smoke-license-line-policy.sh",
        "smoke-roadmap-sync.sh",
        "smoke-skills-install.sh",
        "smoke-sync-agents.sh",
        "smoke-thinking-effort.sh",
        "smoke-verify-sh-parity.sh"
      ],
      "active_smokes_6": [
        "smoke-projects-scope-discipline.sh",
        "smoke-spec-verification.sh",
        "smoke-scope-contract.sh",
        "smoke-cross-ref.sh",
        "smoke-claude-md-drift.sh",
        "smoke-bundle-trigger.sh"
      ]
    },
    "target_state": "CI가 active 6건만 실행 → green. inactive 28-6=22건은 CI 범위 외."
  },
  "options": [
    {
      "id": "A",
      "label": "CI glob → active 6 hardcode",
      "description": ".github/workflows/ci.yml의 `for f in tests/smoke-*.sh` glob을 active 6건 명시 배열로 교체. 1파일 1-phase.",
      "pros": ["변경 최소 (1파일만)", "즉시 green", "inactive smoke 보존", "pre-commit-config와 일치 정책 명시 가능"],
      "cons": ["active smoke 추가 시 CI + pre-commit 양쪽 수동 동기화 필요"],
      "selected": true
    },
    {
      "id": "B",
      "label": "ACTIVE_SMOKES 마커 + CI grep 디스커버리",
      "description": "각 smoke 헤더에 `# ACTIVE` 주석 마킹 → CI가 grep으로 동적 수집. 자동 동기화.",
      "pros": ["자동 동기화"],
      "cons": ["smoke 파일 16건 수정 필요 (scope 과대)", "grep 파싱 fragile"],
      "selected": false
    },
    {
      "id": "C",
      "label": "inactive smoke 파일 삭제",
      "description": "16건 smoke 파일 삭제 후 CI는 현행 glob 유지.",
      "pros": ["CI 변경 불필요"],
      "cons": ["historical 보존 정책 위반 (INTENT out_of_scope)", "사용자 결정 반함"],
      "selected": false
    }
  ],
  "risks_identified": [
    {
      "risk": "active smoke 추가 시 CI 갱신 누락",
      "severity": "low",
      "note": "pre-commit이 새 smoke 추가 시 ci.yml도 갱신해야 하나, 현 scope(6건 고정)에서는 즉각 risk 없음. PROPOSE에서 narrative 추가 제안."
    },
    {
      "risk": "inactive 6건 PASS smoke가 CI 제외되는 것에 대한 우려",
      "severity": "low",
      "note": "agentic-safety-na / detect-language / posttooluse-hook / python-entry-boilerplate / roi-regression / scorer-output-newline — 6건 passing inactive smoke도 CI에서 제외된다. pre-commit에 등록되어 있지 않아 active 정의 밖. 현재는 CI 제외 OK."
    }
  ]
}
```
