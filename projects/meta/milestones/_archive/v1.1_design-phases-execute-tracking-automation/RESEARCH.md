# RESEARCH — v1.1_design-phases-execute-tracking-automation

```json
{
  "id": "v1.1_design-phases-execute-tracking-automation",
  "external": [],
  "codebase": {
    "affected_files": [
      "claude/commands/harness-meta.md"
    ],
    "untouched_files": [
      "CLAUDE.md",
      "projects/meta/CLAUDE.md",
      "tests/",
      "claude/hooks/"
    ],
    "current_state": {
      "stage_E_phases_field": "phases (n / title / scope / affected_files / rationale / risks) — line 130. execute/phase-{n}.md 포함 의무 미명시.",
      "stage_F_step1": "execute/phase-{n}.md 작성 (status: in_progress) — line 158. DESIGN.phases[n].affected_files 갱신 지침 없음.",
      "stage_F_step2": "변경 파일 수정 (Edit/Write) — DESIGN.phases[n].affected_files 정합 — line 159. execute 파일 자체는 affected_files에 없으므로 loop에서 누락됨.",
      "stage_F_step5": "execute/phase-{n}.md status complete + execution_notes 갱신 — line 162. 갱신 지침 존재 (별도 변경 불필요).",
      "evidence": "v1.1_post-report-write-hook-update DESIGN.phases[1].affected_files=[claude/hooks/post-report-write.sh], phases[2].affected_files=[tests/smoke-posttooluse-hook.sh] — execute/ 파일 미등재."
    },
    "target_state": {
      "stage_E_phases_field": "phases[n].affected_files에 execute/phase-{n}.md 포함 의무 명시 추가.",
      "stage_F_step1": "execute/phase-{n}.md 작성 시 DESIGN.phases[n].affected_files에 해당 경로 추가 절차 명시."
    }
  },
  "options": [
    {
      "id": "A",
      "title": "harness-meta.md 지침 텍스트 갱신만",
      "approach": "Stage E phases 설명 + Stage F step 1 설명에 execute/phase-{n}.md 등재 의무 추가. 코드/hook 없음.",
      "pros": ["최소 변경 — 1 파일, 2 지점", "즉시 적용 가능", "기존 smoke 영향 없음"],
      "cons": ["Claude 세션마다 지침 준수 여부는 실행 주체 의존 (강제 불가)"]
    },
    {
      "id": "B",
      "title": "DESIGN 단계에서 phases 템플릿에 execute/phase-{n}.md placeholder 의무화",
      "approach": "Stage E 지침에 phases 예시 JSON을 추가하여 affected_files에 execute/phase-{n}.md 명시.",
      "pros": ["템플릿 레벨 가이드 — 작성 시점에서 누락 방지"],
      "cons": ["DESIGN 작성 지침이 비대해짐"]
    },
    {
      "id": "C",
      "title": "smoke-spec-verification.sh 확장으로 DESIGN.phases[n].affected_files 검증 추가",
      "approach": "smoke에 execute/phase-{n}.md 존재 여부 검증 추가.",
      "pros": ["강제 검증 — pre-commit 차단"],
      "cons": ["out_of_scope 명시 ('smoke 신규 추가 금지'). scope 위반."]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "desc": "harness-meta.md는 CLAUDE.md와 drift 감지 대상 (smoke-claude-md-drift). 지침 갱신 후 drift 체크 필요.",
      "mitigation": "pre-commit smoke-claude-md-drift가 자동 검증"
    },
    {
      "id": "R2",
      "desc": "Stage F step 1 지침 변경이 step 2 순서와 충돌 가능 (affected_files 먼저 갱신 후 수정 vs 수정 후 갱신).",
      "mitigation": "step 1에서 DESIGN 갱신 + step 2에서 실제 파일 수정 순서 명확히 유지"
    }
  ]
}
```
