# milestones — v3.5

```json
{
  "version": "v3.5",
  "title": "OPEN/DESIGN stage milestones.md 동시 생성 절차 강화 — cascade 검증 smoke + Stage D narrative 동기 (bundle)",
  "status": "completed",
  "sub_milestones": [
    {
      "phase": 1,
      "title": "cascade 검증 smoke 도입 — `tests/smoke-open-stage-discipline.sh` 신규 + pre-commit hook 등록 + tests/CLAUDE.md 매트릭스 갱신",
      "status": "complete",
      "commit": "35c621c"
    },
    {
      "phase": 2,
      "title": "Stage D 절차 narrative 동기 — `claude/commands/harness-meta.md` Stage D 신규 step + Stage A step 7 backward cross-ref",
      "status": "complete",
      "commit": "a4aa8c7"
    }
  ]
}
```

## 의도

v3.4_open-stage-milestones-md-protocol lessons L1 + L3 의 의미 grouping bundle. 같은 모듈 (`claude/commands/harness-meta.md` + `tests/`) + 같은 주제 (OPEN/DESIGN 절차 강제) → v3.5 bundle 단일 entry 운용. sub-milestone 2건의 최종 의미 grouping 및 phase 분할은 Stage D DESIGN 단계에서 확정 — 본 skeleton 의 phase-1/2 title 은 placeholder (v3.4 Stage A step 7 narrative 의 첫 자기참조 적용).

## 자기참조 부합 (도그푸드)

본 milestone 의 OPEN 단계 자체가 v3.4 Stage A step 7 ('milestones.md 스켈레톤 즉시 작성') 첫 자기참조 적용 사례 — v3.4 직후속 bundle 답게 v3.4 신규 절차로 진입. OPEN 단계 종료 시점에 3 조건 동시 충족:

1. ROADMAP entry status: `in_progress` (위 entry 갱신)
2. ROADMAP entry `milestones_path` 보유 (`milestones/v3.5/milestones.md`)
3. 실 파일 보유 (본 파일)

→ `tests/_era_detect.py` v3.0+ 9-stage-bundled era 표지 충족 + `tests/smoke-bundle-trigger.sh` 검증 분기 모두 통과 (status: in_progress → milestones_path + 실 파일 둘 다 검증).

## 후속 stage 산출물

| Stage | 파일 | 책임 |
|:-:|------|------|
| B INTENT | `INTENT.md` | 의도 — goal / motivation / success_criteria / out_of_scope / dependencies |
| C RESEARCH | `RESEARCH.md` | 조사 — external / codebase / options / risks_identified |
| D DESIGN | `DESIGN.md` | 설계 — decisions / approach / phases / risk_mitigation + 5 관점 검토 + 본 `milestones.md` sub_milestones 1:1 동기 갱신 |
| E APPROVE | `APPROVE.md` | 사용자 명시 승인 게이트 |
| F EXECUTE | `execute/phase-{n}.md` | per-phase 구현 (sub-milestone 1:1 매핑, 각 phase = 1 commit) |
| G VERIFY | `VERIFY.md` | 검증 — smoke / criteria_check / verdict |
| H REPORT | `REPORT.md` | 종합 backward — summary / delta / lessons_learned |
| I PROPOSE | `PROPOSE.md` | 후속 forward — next_candidates ROADMAP 등록 |

## 관련

- 직속 부모 milestone (lessons 발원): [`../v3.4/REPORT.md`](../v3.4/REPORT.md) (L1 cascade smoke + L3 Stage D narrative 동기)
- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) (v3.5)
- 워크플로우 진입점: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md) — 본 milestone 의 phase-2 갱신 대상
- ARCHITECTURE: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1 (bundling 정책)
