# RESEARCH — v3.8 inactive-smoke-cd-path-fix

```json
{
  "external": [
    {
      "source": "bash dirname best practice",
      "topic": "스크립트가 임의 CWD에서 실행될 때 repo root 해석",
      "findings": "`$(dirname \"$0\")/..` 는 스크립트 위치 기준 1 레벨 상위 → tests/_inactive/ 에서 실행 시 tests/ 가 됨. 정확한 repo root = `$(dirname \"$0\")/../..` (2 레벨). git rev-parse --show-toplevel 이 더 robust 하나 fallback path 도 올바른 깊이여야 함.",
      "drift": "없음"
    }
  ],
  "codebase": {
    "affected_files": [
      "tests/_inactive/smoke-detect-language.sh",
      "tests/_inactive/smoke-roi-regression.sh",
      "tests/_inactive/smoke-backup-cleanup.sh",
      "tests/_inactive/smoke-bootstrap-agents-md.sh",
      "tests/_inactive/smoke-bootstrap-render.sh",
      "tests/_inactive/smoke-skills-install.sh",
      "tests/_inactive/smoke-sync-agents.sh",
      "tests/_inactive/smoke-python-entry-boilerplate.sh"
    ],
    "untouched_files": [
      "tests/_inactive/smoke-agentic-safety-na.sh (HARNESS_META_ROOT $HOME fallback — dirname 버그 없음)",
      "tests/_inactive/smoke-bash-permission-pattern.sh (HARNESS_META_ROOT $HOME fallback)",
      "tests/_inactive/smoke-bootstrap-license-*.sh (HARNESS_META_ROOT $HOME fallback)",
      "tests/_inactive/smoke-broad-bash-fine-grain.sh (HARNESS_META_ROOT $HOME fallback)",
      "tests/_inactive/smoke-language-overlay.sh (HARNESS_META_ROOT $HOME fallback)",
      "tests/_inactive/smoke-legacy-cleanup-overlay.sh (HARNESS_META_ROOT $HOME fallback)",
      "tests/_inactive/smoke-license-line-policy.sh (HARNESS_META_ROOT $HOME fallback)",
      "tests/_inactive/smoke-roadmap-sync.sh (HARNESS_META_ROOT $HOME fallback)",
      "tests/_inactive/smoke-scorer-output-newline.sh (git rev-parse 1차, HARNESS_META_ROOT fallback)",
      "tests/_inactive/smoke-thinking-effort.sh (HARNESS_META_ROOT $HOME fallback)",
      "tests/_inactive/smoke-verify-sh-parity.sh (HARNESS_META_ROOT $HOME fallback)",
      "tests/_inactive/smoke-posttooluse-hook.sh (v3.7 에서 이미 수정 — ../.. 정상)",
      "모든 active smoke (tests/ 최상위, _inactive/ 이동 불필요)",
      ".github/workflows/ci.yml (active smoke 6건 배열 — 수정 불필요)"
    ],
    "current_state": "8개 파일이 `$(dirname \"$0\")/..` 를 사용 → tests/_inactive/에서 실행 시 tests/ 로 해석 (1 레벨 오류). 수동 실행 시 Stage 1 static check FAIL (cd 후 경로 불일치).",
    "target_state": "8개 파일 모두 `$(dirname \"$0\")/../..` 로 수정 → repo root(harness-meta/) 정상 해석. bash -n syntax check PASS + active pre-commit 회귀 0."
  },
  "options": [
    {
      "option": "A — dirname/../.. 직접 치환 (단순 sed-style 교체)",
      "pros": ["최소 변경 — 경로 1개 문자열만 수정", "파일 구조 무변경", "검토 범위 명확"],
      "cons": ["파일별 컨텍스트 확인 필요 (직접 cd vs 변수 할당 패턴 2종)"]
    },
    {
      "option": "B — git rev-parse --show-toplevel 로 일괄 교체",
      "pros": ["더 robust (symlink, 중첩 repo 등)"],
      "cons": ["git context 없는 환경에서 추가 fallback 필요", "변경량 과도 (out_of_scope 위배)"]
    }
  ],
  "risks_identified": [
    {
      "risk": "smoke-python-entry-boilerplate.sh 는 git rev-parse primary + dirname fallback 구조 — primary 가 정상이어도 fallback 수정 포함",
      "mitigation": "fallback 포함 수정, git repo 환경에서 primary 경로 사용이 검증됨"
    },
    {
      "risk": "sed-style 교체 시 다른 의도치 않은 /.. 패턴 치환 위험",
      "mitigation": "Edit 도구로 each file individually 수정 + bash -n syntax check 개별 검증"
    }
  ]
}
```
