# EXECUTE phase-3 — Cross-ref sweep + optional sweeps + smoke 활성화

```json
{
  "phase": 3,
  "title": "Cross-ref sweep + optional sweeps + scope-discipline smoke 활성화",
  "status": "complete",
  "started_at": "2026-05-08",
  "completed_at": "2026-05-08",
  "commit_sha": "e2f59de",
  "scope": "Stage A core 의존 없는 모든 갱신. Tier 2 cross-ref (모듈 CLAUDE.md / AGENTS.md / README.md / projects/upbit) + Tier 3 텍스트 메시지 (verify / hooks) + 4 optional sweeps (settings.local.json prune / docs/ARCHITECTURE.md grep+갱신 / harness-roadmap-update SKILL deprecation / .pre-commit-config.yaml 주석) + .pre-commit-config.yaml 신규 active local hook block (scope-discipline smoke 단독 활성화). anchor fragment grep ('ROADMAP.md#') 전수 + Windows long path 사전 확인.",
  "changes": [
    {"file": "CLAUDE.md (root)", "action": "modify", "description": "모듈 매트릭스 milestones/ 행 (라인 20) → projects/meta/milestones/ + 구조 규칙 (라인 32-33, 52, 55) + 관련 문서 cross-ref (라인 114-115). @ROADMAP.md (라인 9) 유지 (thin index 로드)."},
    {"file": "AGENTS.md (root, 영문)", "action": "modify", "description": "라인 26/29-30/43/68/76 영문 동등 갱신."},
    {"file": "README.md", "action": "modify", "description": "디렉토리 트리 (라인 158/162) + legacy 표기 (라인 244-245) 갱신."},
    {"file": "claude/CLAUDE.md", "action": "modify", "description": "Hook 정책 § 'sessions/.*/REPORT.(md|ipynb)$' 패턴 설명 갱신."},
    {"file": "tests/CLAUDE.md", "action": "modify", "description": "smoke 매트릭스 § milestones/.*\\.md$ 패턴 → projects/<name>/milestones/.*\\.md$ + scope-discipline smoke 신규 row."},
    {"file": "bootstrap/skills/CLAUDE.md", "action": "modify", "description": "라인 110 milestones/v{X.Y}_/ → projects/meta/milestones/v{X.Y}_/."},
    {"file": "verify.sh + verify.ps1", "action": "modify", "description": "메시지 텍스트 갱신 (선택)."},
    {"file": "claude/hooks/post-report-write.sh", "action": "modify", "description": "라인 153 메시지 텍스트 (선택)."},
    {"file": "projects/upbit/ROADMAP.md", "action": "modify", "description": "관련 문서 § meta link 보강 (../../projects/meta/ROADMAP.md)."},
    {"file": "projects/upbit/ARCHITECTURE.md", "action": "modify", "description": "디렉토리 트리 (라인 59) — projects/meta/ + projects/upbit/ 동형 표시."},
    {"file": ".claude/settings.local.json", "action": "modify (sweep 1)", "description": "sessions/meta/ROADMAP.md hardcoded Bash allow entry 5건 제거 (라인 26-30)."},
    {"file": "docs/ARCHITECTURE.md", "action": "modify (sweep 2)", "description": "grep 검증 + milestones/ path 참조 발견 시 projects/meta/milestones/ 갱신."},
    {"file": "bootstrap/skills/audit/harness-roadmap-update/SKILL.md", "action": "modify (sweep 3)", "description": "상단 deprecated 주석 추가 (broken since v1.0, sessions/meta/ 참조 dead)."},
    {"file": ".pre-commit-config.yaml (sweep 4 + smoke 활성화)", "action": "modify", "description": "라인 40/51/57 주석 milestones/.*\\.md$ → projects/<name>/milestones/.*\\.md$ + 신규 - repo: local 블록 (smoke-projects-scope-discipline 활성화)."}
  ],
  "execution_notes": [
    "15 files changed, +128 / -49 (commit e2f59de). 14 modified + 1 new (phase-3.md).",
    "Tier 2 cross-ref 8건 (CLAUDE.md / AGENTS.md / README.md / claude/CLAUDE.md / tests/CLAUDE.md / bootstrap/skills/CLAUDE.md / projects/upbit/ROADMAP.md / projects/upbit/ARCHITECTURE.md) 적용.",
    "Tier 3 텍스트 3건 (verify.sh / verify.ps1 / claude/hooks/post-report-write.sh) 적용.",
    "4 optional sweeps 적용 — settings.local.json prune (gitignored, local 정리), docs/ARCHITECTURE.md grep 결과 0 hits (변경 불필요), harness-roadmap-update SKILL.md DEPRECATED 주석 추가, .pre-commit-config.yaml 주석 path 갱신.",
    "smoke 활성화: .pre-commit-config.yaml 신규 active local hook block (smoke-projects-scope-discipline). pre-commit run 시 자동 실행 + PASS 확인 (commit log 마지막 줄: 'Smoke — projects/<name>/ROADMAP scope discipline...Passed').",
    "anchor fragment grep 'ROADMAP\\.md#' 전수 결과: 활성 파일 0 hits (DESIGN.md self-reference 제외) — 모든 milestone 내 cross-ref가 anchor 없는 단순 link이므로 thin index 변환에 의한 broken anchor 0.",
    "phase-2.md status: in_progress → complete + execution_notes 갱신 (commit 0fa3d32 retro) 본 commit 에 포함.",
    "Stage F (phase 1/2/3) 모두 완료 — 다음 Stage G (VERIFY/REPORT)."
  ],
  "commit_message": "feat(meta): v1.1 phase-3 — cross-ref sweep + optional sweeps + scope-discipline smoke 활성화"
}
```
