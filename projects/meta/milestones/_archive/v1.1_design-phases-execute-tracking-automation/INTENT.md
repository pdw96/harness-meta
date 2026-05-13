# PLAN — v1.1_design-phases-execute-tracking-automation

```json
{
  "id": "v1.1_design-phases-execute-tracking-automation",
  "title": "DESIGN.phases[n] execute/phase-{n}.md 자동 트래킹",
  "goal": "harness-meta.md Stage E/F 지침을 갱신하여 DESIGN.phases[n].affected_files에 execute/phase-{n}.md를 항상 포함시키고, phase 시작·완료 시 status 갱신을 명시적 의무로 만든다.",
  "motivation": "현재 Stage F 지침에서 execute/phase-{n}.md를 DESIGN.phases[n].affected_files에 등재하는 규칙이 없어, 실제 milestone 산출물(e.g. v1.1_post-report-write-hook-update)에서 누락이 반복됐다. execute 파일은 phase 구현의 tracking artifact이므로 DESIGN.phases와 1:1 정합이 되어야 한다.",
  "success_criteria": [
    "harness-meta.md Stage E(DESIGN 작성) 지침에 phases[n].affected_files에 execute/phase-{n}.md 포함 의무 명시",
    "harness-meta.md Stage F(EXECUTE) step 1에 execute/phase-{n}.md를 DESIGN.phases[n].affected_files에 추가하는 절차 명시",
    "harness-meta.md Stage F step 5에 execute/phase-{n}.md status complete 갱신 절차 이미 존재 — 별도 변경 불필요 확인",
    "pre-commit hook full-pass (회귀 0)"
  ],
  "out_of_scope": [
    "execute/phase-{n}.md 자동 생성 스크립트 또는 hook 작성",
    "기존 완료 milestone DESIGN.md 소급 수정",
    "DESIGN.md JSON 스키마 자동 검증 smoke 신규 추가",
    "harness-meta.md 이외 파일 변경"
  ],
  "dependencies": {
    "predecessors": ["v1.1_post-report-write-hook-update"],
    "successors": []
  }
}
```
