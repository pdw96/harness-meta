# REPORT — v3.12 deprecated-skill-narrative-cleanup

```json
{
  "summary": "v3.11 VERIFY drift 검증 시 발견된 잔존 sessions/ 거명을 harness-plan-verify/SKILL.md 6건 + harness-roadmap-update/SKILL.md 3건 = 9건 일괄 정리 완료. harness-plan-verify 는 현행 9-stage milestones/v{X.Y}/DESIGN.md 경로로 갱신, harness-roadmap-update 는 projects/meta/ROADMAP.md 현행 경로로 교체 + allowed-tools broken path 수정. DEPRECATED 블록 내 역사적 서술은 보존. Lightweight 모드 (§ 6.2 조건 3건 충족) 적용 — 5 관점 subagent 생략, 1 phase 1 commit.",
  "delta": {
    "files_changed": 2,
    "files_added": 7,
    "files_deleted": 0,
    "modules_affected": ["bootstrap/skills/audit/harness-plan-verify", "bootstrap/skills/audit/harness-roadmap-update"],
    "commit": "446485b"
  },
  "lessons_learned": [
    {
      "id": "L1",
      "lesson": "DEPRECATED SKILL 의 frontmatter allowed-tools broken path 는 기능에 영향 없어도 가독성 오해 위험 — DEPRECATED 선언과 동시에 frontmatter 정리가 바람직",
      "application": "향후 SKILL deprecation 시 본문 DEPRECATED 블록 + frontmatter allowed-tools 동시 정리를 milestone EXECUTE phase 체크리스트에 포함"
    },
    {
      "id": "L2",
      "lesson": "SKILL.md '관련 문서' 섹션의 historical 세션 경로는 sessions/ 제거 시점에 함께 정리되지 않으면 silent stale narrative로 잔존 — v1.0_workflow-redesign 이후 최초 명시적 청소",
      "application": "workflow era 전환 시 관련 SKILL.md 관련 문서 섹션 historical 경로 일괄 제거를 era-transition 체크리스트 항목으로 추가 고려"
    }
  ]
}
```
