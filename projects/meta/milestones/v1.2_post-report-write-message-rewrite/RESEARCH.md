# RESEARCH — v1.2_post-report-write-message-rewrite

```json
{
  "id": "v1.2_post-report-write-message-rewrite",
  "external": [],
  "codebase": {
    "affected_files": [
      "claude/hooks/post-report-write.sh",
      "tests/smoke-posttooluse-hook.sh"
    ],
    "untouched_files": [
      "claude/commands/harness-meta.md",
      "install.ps1",
      ".pre-commit-config.yaml"
    ],
    "current_state": {
      "PLAN_message": "INTENT.md write detected. Please invoke harness-plan-verify SKILL now: /harness-plan-verify — verify spec (context7) before proceeding.",
      "REPORT_with_sections": "${FILE_BASENAME} write detected (sections: ${SECTIONS}). Please invoke harness-roadmap-update SKILL now: /harness-roadmap-update",
      "REPORT_without_sections": "${FILE_BASENAME} write detected. Please invoke harness-roadmap-update SKILL now: /harness-roadmap-update — update projects/<name>/ROADMAP.md with this session completed entry and Out of scope trigger rows. (root ROADMAP.md is now thin index — milestone 등재 금지)",
      "deprecated_refs": ["harness-roadmap-update", "harness-plan-verify"],
      "smoke_tests_checking_deprecated": ["A (harness-roadmap-update)", "F (harness-roadmap-update)", "H (harness-roadmap-update)", "K (harness-roadmap-update)", "P (harness-plan-verify)", "R (harness-roadmap-update)"]
    },
    "target_state": {
      "PLAN_message": "INTENT.md 작성 감지. 7-stage 다음: RESEARCH.md 작성으로 진행하세요 (/harness-meta).",
      "REPORT_with_sections": "${FILE_BASENAME} 작성 감지 (sections: ${SECTIONS}). 7-stage 다음 단계로 진행하세요 (/harness-meta).",
      "REPORT_without_sections": "${FILE_BASENAME} 작성 감지. 7-stage 다음 단계로 진행하세요 (/harness-meta).",
      "smoke_keyword_PLAN": "RESEARCH (success criteria 정합)",
      "smoke_keyword_REPORT": "/harness-meta (success criteria 정합)"
    }
  },
  "options": [
    {
      "id": "A",
      "title": "단순 교체 — FILE_TYPE 2분기 유지",
      "approach": "PLAN/REPORT 2분기 메시지만 교체. FILE_BASENAME별 세분화 없음.",
      "pros": ["최소 변경", "out_of_scope 완전 준수", "smoke 6건만 수정"],
      "cons": ["RESEARCH/DESIGN/VERIFY/execute 모두 동일 REPORT 메시지"]
    },
    {
      "id": "B",
      "title": "FILE_BASENAME 기반 세분화",
      "approach": "RESEARCH.md→DESIGN, DESIGN.md→approval+EXECUTE, VERIFY.md→REPORT, REPORT.md→ROADMAP+push 등 단계별 메시지.",
      "pros": ["더 구체적인 안내"],
      "cons": ["out_of_scope 명시 위반 (FILE_BASENAME별 세분화 라우팅)", "hook 코드 복잡화", "smoke 케이스 폭발"]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "desc": "smoke 6건(A/F/H/K/P/R) 키워드 갱신 누락 시 pre-commit 아닌 별도 실행에서 FAIL",
      "mitigation": "phase-1 hook 갱신 직후 smoke 로컬 실행 확인, phase-2 smoke 갱신"
    }
  ]
}
```
