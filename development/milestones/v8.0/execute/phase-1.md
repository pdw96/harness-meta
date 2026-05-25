---
id: reclassify-meta-as-development
title: phase-1 — 디렉토리 이동 + behavior-critical 배선
version: v8.0
phase: 1
status: complete
---

# v8.0 phase-1 — 디렉토리 이동 + behavior-critical 배선

## Scope (DESIGN d_3/d_6, approach (a)~(e))

`git mv projects/meta development` + 경로-로직 보유 배선(스크립트/스모크/설정) 갱신.

## Changes

```json
{
  "phase": 1,
  "status": "complete",
  "commit": "(phase-1+2 통합 1 commit — pre-commit cross-ref 결합, REPORT delta 참조)",
  "changes": [
    {"file": "projects/meta → development", "what": "git mv 디렉토리 통째 이동 (681 rename, history 보존). projects/ 에는 upbit 만 잔존."},
    {"file": "scripts/propose_next.py", "what": "milestones_dir + roadmap 경로 projects/meta → development (line 113/165) + docstring 2곳"},
    {"file": "claude/statusline/statusline.sh", "what": "MARKER = development/claude-code-version-log.md (line 30 + 주석 2곳)"},
    {"file": "claude/hooks/session-start-version-track.sh", "what": "LOG_FILE + context 메시지 development/ (line 20/36 + 주석)"},
    {"file": "claude/hooks/post-report-write.sh", "what": "8 milestone 패턴 regex projects/[^/]+/milestones → (projects/[^/]+|development)/milestones (DESIGN 미열거 — EXECUTE 발견, generic 패턴이라 literal grep 미포착)"},
    {"file": "tests/smoke-spec-verification.sh + smoke-scope-contract.sh", "what": "milestone_dirs glob 에 development/milestones enumerate 추가"},
    {"file": "tests/smoke-bundle-trigger.sh", "what": "development/ROADMAP.md 순회 추가 + is_self_dev (parent.name=='development') 실파일 검증"},
    {"file": "tests/smoke-open-stage-discipline.sh", "what": "milestones_dirs 에 development/milestones 추가 (loop 재구성)"},
    {"file": "tests/smoke-entry-title-guideline.sh + smoke-candidate-draft-schema.sh", "what": "development/ROADMAP.md enumerate + schema_note hardcode 경로 development/"},
    {"file": ".pre-commit-config.yaml", "what": "spec-verification/scope-contract/open-stage-discipline files: 패턴에 development/milestones alternative 추가 (ROADMAP 트리거 hook 은 ROADMAP\\.md$ 가 이미 매칭)"},
    {"file": ".claude/settings.json", "what": "autoMode 경로 규칙 5곳 projects/meta → development (milestones/v*/** + claude-code-version-log.md + _archive/**)"},
    {"file": ".github/workflows/release-publish.yml", "what": "MILESTONE_PATH 등 development/milestones (release body 추출 경로)"}
  ],
  "verification": [
    "smoke-spec-verification PASS=452 FAIL=0 + development/v8.0 enumerate 확인",
    "smoke-open-stage-discipline PASS (checked=54)",
    "propose_next --scan directory_names = [v8.0,v7.1,v7.0,v6.23,v6.22] (development enumerate)",
    "grep projects/meta scripts/ claude/statusline claude/hooks = 잔존 0"
  ]
}
```
