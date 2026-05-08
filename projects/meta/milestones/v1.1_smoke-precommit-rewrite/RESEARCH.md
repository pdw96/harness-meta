# RESEARCH — v1.1_smoke-precommit-rewrite

```json
{
  "external": [
    {
      "source": "4 smoke 스크립트 직접 분석",
      "topic": "현황 vs 7-stage 포맷 gap",
      "findings": "smoke-spec-verification: sessions/meta/v1.X*/PLAN.md glob + '## Spec verification (context7)' 마크다운 섹션 검사 — 완전 무관. smoke-scope-contract: sessions/meta/ glob + '## Scope inheritance'/'## Out of scope' 마크다운 섹션 + OWNERSHIP.md/harness-meta.md 텍스트 검사 — 완전 무관. smoke-cross-ref: 제외 패턴 '^milestones/v\\d+' (root milestones/) 가정 — 새 경로 projects/*/milestones/v* 로 갱신 필요. smoke-claude-md-drift: MODULE_PATHS에 sessions/CLAUDE.md 포함(부재) + bootstrap/CLAUDE.md 포함(부재) + projects/meta/CLAUDE.md 누락. S4가 root CLAUDE.md에서 'smoke N 매트릭스' 패턴 탐색하는데 실제 패턴은 tests/CLAUDE.md에만 존재.",
      "drift": "yes — 4 smoke 모두 7-stage 포맷 부적합"
    }
  ],
  "codebase": {
    "affected_files": [
      "tests/smoke-spec-verification.sh",
      "tests/smoke-scope-contract.sh",
      "tests/smoke-cross-ref.sh",
      "tests/smoke-claude-md-drift.sh",
      "tests/CLAUDE.md",
      ".pre-commit-config.yaml"
    ],
    "untouched_files": [
      "tests/precommit-autofix-or-fail.sh",
      "tests/smoke-projects-scope-discipline.sh",
      "기타 smoke 22종",
      ".github/workflows/ci.yml"
    ],
    "current_state": {
      "smoke_spec_verification": "sessions/meta/v1.X*/PLAN.md 열거 + '## Spec verification (context7)' 마크다운 섹션 5 sub-field 검사. 7-stage 산출물과 무관.",
      "smoke_scope_contract": "sessions/meta/ 열거 + '## Scope inheritance'/'## Out of scope' 마크다운 섹션 존재 + OWNERSHIP.md/harness-meta.md 텍스트 존재. 7-stage와 무관.",
      "smoke_cross_ref": "제외 패턴: _VER_MILE='^milestones/v\\d+' (root milestones/ 가정). projects/meta/milestones/ 내 산출물 제외 안 됨.",
      "smoke_claude_md_drift": "MODULE_PATHS 5건: bootstrap/CLAUDE.md(부재), bootstrap/skills/CLAUDE.md(존재), claude/CLAUDE.md(존재), tests/CLAUDE.md(존재), sessions/CLAUDE.md(부재). S4: root CLAUDE.md에서 'smoke N 매트릭스' 탐색 → 패턴 없음 → FAIL.",
      "precommit": "4 hook 모두 disabled 주석 처리. scope-discipline 1건만 active.",
      "tests_claude_md": "smoke 매트릭스 (현 28 파일) — 실제 파일 수 29 (smoke-projects-scope-discipline.sh 추가로 +1)"
    },
    "target_state": {
      "smoke_spec_verification": "projects/*/milestones/v*_*/ 열거. 각 artifact(PLAN/RESEARCH/DESIGN/VERIFY/REPORT/execute/phase-{n}) JSON block 필수 필드 검증. JSON block 없는 legacy 4-tier 자동 skip.",
      "smoke_scope_contract": "Stage1: PLAN.out_of_scope 비어있지 않음. Stage2: execute/ 파일 존재 시 DESIGN.approval.approved_by='user'. Stage3: harness-meta.md에 DESIGN.approval 안내 존재.",
      "smoke_cross_ref": "_VER_MILE을 '^projects/[^/]+/milestones/v\\d+' 로 갱신.",
      "smoke_claude_md_drift": "MODULE_PATHS: bootstrap/skills/CLAUDE.md, claude/CLAUDE.md, tests/CLAUDE.md, projects/meta/CLAUDE.md (4건). S4: tests/CLAUDE.md에서 '현 (\\d+) 파일' 패턴으로 갱신.",
      "precommit": "4 hook 재활성화. scope-discipline과 통합 local hook 블록.",
      "tests_claude_md": "smoke count 29로 갱신 + hook table 현행화"
    }
  },
  "options": [
    {
      "id": "A",
      "description": "spec-verification + scope-contract 전면 재작성. cross-ref + claude-md-drift 최소 패치.",
      "pros": ["7-stage 검증 완전 달성", "각 smoke 단일 책임 명확", "cross-ref는 로직 건실 — 제외 패턴만 수정으로 충분"],
      "cons": ["spec-verification 재작성 규모 상당 (Python JSON 추출 로직 필요)"]
    },
    {
      "id": "B",
      "description": "4종 모두 최소 패치 (glob 경로만 수정, JSON 검증은 다음 milestone)",
      "pros": ["빠름"],
      "cons": ["7-stage JSON schema 검증 효과 없음 — ROADMAP 취지 불충족"]
    }
  ],
  "risks_identified": [
    "smoke-spec-verification 재작성 시 Python JSON 추출 로직 복잡도 — shell 안에서 json 파싱은 jq/python3 위임 필요",
    "legacy 4-tier milestones(v1.84~v1.88) JSON block 없어 새 smoke에서 오탐 가능 — JSON block 부재 시 SKIP으로 처리하면 해결",
    "smoke-claude-md-drift S4 count: tests/CLAUDE.md 업데이트와 smoke 활성화 타이밍 — 같은 commit에서 처리해야 무결"
  ]
}
```
