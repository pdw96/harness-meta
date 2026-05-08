# DESIGN — v1.1_smoke-precommit-rewrite

```json
{
  "decisions": [
    {
      "decision": "smoke-spec-verification.sh 전면 재작성: 7-stage JSON schema 정합 검증",
      "rationale": "sessions/ 경로 + 마크다운 섹션 기반 로직이 7-stage 포맷과 완전 무관. Python3 heredoc으로 JSON 추출 후 필수 필드 존재 확인. JSON block 없는 legacy milestone은 SKIP (자동 구분).",
      "alternatives_rejected": [
        "최소 패치 (glob만 수정) — JSON schema 검증 효과 없어 ROADMAP 취지 불충족 (Option B)"
      ]
    },
    {
      "decision": "smoke-scope-contract.sh 전면 재작성: 3 stages (out_of_scope 의무 + approve gate + 안내 존재)",
      "rationale": "Stage2(execute/ 존재 시 DESIGN.approval.approved_by='user')는 workflow gate이고 spec-verification(schema 형식 검증)과 책임 분리 명확. Architecture 검토 결과 혼합 우려는 주석으로 문서화하여 해소. --fix 미구현 (JSON auto-fix 복잡도 과다 — PLAN.out_of_scope).",
      "alternatives_rejected": [
        "Stage2를 spec-verification으로 이전 — schema 검증과 workflow gate 혼합, 더 나쁜 분리"
      ]
    },
    {
      "decision": "smoke-cross-ref.sh 최소 패치: _VER_MILE regex만 갱신",
      "rationale": "나머지 로직(Python cross-ref 추출, --fix 삭제)은 건실. root milestones/ 더 이상 없음 — projects/*/milestones/v* 패턴으로만 교체하면 충분.",
      "alternatives_rejected": []
    },
    {
      "decision": "smoke-claude-md-drift.sh 최소 패치: MODULE_PATHS 4건 갱신 + S4 tests/CLAUDE.md 기준으로 수정",
      "rationale": "bootstrap/CLAUDE.md·sessions/CLAUDE.md 파일 모두 실제 부재 → FAIL 원인. projects/meta/CLAUDE.md 추가. S4: root CLAUDE.md에 'smoke N 매트릭스' 패턴 없음 — tests/CLAUDE.md의 '현 (N) 파일' 패턴으로 교정.",
      "alternatives_rejected": []
    },
    {
      "decision": "scope-discipline hook은 기존 분리 블록 유지, 4 hook 재활성화 시 신규 local 블록 추가",
      "rationale": "Regression 검토: 분리 유지가 혼동 감소. scope-discipline은 다른 4 hook과 trigger 패턴 달라 별도 블록이 명확."
    },
    {
      "decision": "--fix 미구현 (spec-verification, scope-contract) — direct call 방식",
      "rationale": "JSON auto-fix는 PLAN.out_of_scope. cross-ref는 --fix 기존 유지(autofix-or-fail wrapper 경유).",
      "alternatives_rejected": []
    }
  ],
  "approach": "4 phase. Phase1: minimal patch 2종(cross-ref + claude-md-drift). Phase2: spec-verification 전면 재작성. Phase3: scope-contract 전면 재작성. Phase4: .pre-commit-config.yaml 재활성화 + tests/CLAUDE.md 갱신. Python3 JSON heredoc 패턴은 기존 smoke-cross-ref.sh/smoke-claude-md-drift.sh 관용구 일관 적용.",
  "phases": [
    {
      "n": 1,
      "title": "smoke-cross-ref + smoke-claude-md-drift 최소 패치",
      "scope": "cross-ref: _VER_MILE regex 1줄 수정. claude-md-drift: MODULE_PATHS 배열 + S4 패턴 수정.",
      "affected_files": [
        "tests/smoke-cross-ref.sh",
        "tests/smoke-claude-md-drift.sh",
        "execute/phase-1.md"
      ],
      "rationale": "회귀 낮은 최소 변경 먼저. 두 smoke를 직접 실행해 PASS 확인 후 진행.",
      "risks": "smoke-claude-md-drift S4: tests/CLAUDE.md smoke count 29로 맞춰야 PASS — Phase4와 타이밍 주의 (S4는 현재 파일 수 동적 계산이므로 Phase1에서 tests/CLAUDE.md를 갱신하지 않아도 smoke 실행 시 실제 count로 비교)"
    },
    {
      "n": 2,
      "title": "smoke-spec-verification.sh 전면 재작성",
      "scope": "sessions/ 열거 제거. projects/*/milestones/v*_*/ 열거. 5 artifact type x JSON schema 검증. Python3 JSON 추출 heredoc.",
      "affected_files": [
        "tests/smoke-spec-verification.sh",
        "execute/phase-2.md"
      ],
      "rationale": "가장 복잡한 재작성 — 단독 phase로 분리해 집중 검증.",
      "risks": "legacy milestone(v1.84~v1.88) JSON block 없음 → SKIP 처리로 해결. execute/phase-{n}.md 명명 검증은 파일명 regex로 구현."
    },
    {
      "n": 3,
      "title": "smoke-scope-contract.sh 전면 재작성",
      "scope": "sessions/ 열거 제거. 3 Stage 신규 구현(out_of_scope 의무 + approve gate + harness-meta.md 안내).",
      "affected_files": [
        "tests/smoke-scope-contract.sh",
        "execute/phase-3.md"
      ],
      "rationale": "Phase2 후 spec-verification PASS 확인 후 진행.",
      "risks": "Python3 JSON 추출 공통 패턴 — Phase2와 동일 heredoc 구조 재사용."
    },
    {
      "n": 4,
      "title": ".pre-commit-config.yaml 재활성화 + tests/CLAUDE.md 갱신",
      "scope": "4 hook 재활성화 (files: 패턴 포함). scope-discipline 블록 주석 갱신. tests/CLAUDE.md smoke count 29 + hook table 현행화.",
      "affected_files": [
        ".pre-commit-config.yaml",
        "tests/CLAUDE.md",
        "execute/phase-4.md"
      ],
      "rationale": "smoke PASS 확인 후 pre-commit 통합. pre-commit run --all-files full-pass가 최종 VERIFY.",
      "risks": "4 hook files: 패턴이 기존 milestone 파일 변경 없이도 매칭되는지 smoke run --all-files로 검증 필요"
    }
  ],
  "precommit_files_patterns": {
    "smoke-spec-verification": "projects/[^/]+/milestones/v[^/]+/.*\\.md$",
    "smoke-scope-contract": "projects/[^/]+/milestones/v[^/]+/.*\\.md$|claude/commands/harness-meta\\.md$",
    "smoke-cross-ref": "\\.(md|sh|ps1|toml|json|yaml|yml|py|txt)$",
    "smoke-claude-md-drift": "CLAUDE\\.md$|tests/smoke-.*\\.sh$"
  },
  "risk_mitigation": [
    {
      "risk": "legacy milestone SKIP 오탐",
      "mitigation": "JSON block 부재 → SKIP (count 기록). FAIL 아님."
    },
    {
      "risk": "smoke-claude-md-drift S4 count 불일치",
      "mitigation": "S4는 실제 tests/smoke-*.sh 파일 수를 동적 계산. tests/CLAUDE.md 갱신과 같은 Phase4 commit에서 처리."
    },
    {
      "risk": "MSYS2 path translation (Windows Git Bash)",
      "mitigation": "Python3 heredoc에서 Path(sys.argv[N]).resolve() 정규화 적용 (기존 cross-ref 패턴 동일)."
    }
  ],
  "approval": {
    "approved_by": "user",
    "date": "2026-05-08"
  }
}
```
