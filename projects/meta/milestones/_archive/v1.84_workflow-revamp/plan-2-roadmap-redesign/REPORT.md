# PLAN-2: roadmap-redesign — REPORT

**완료일**: 2026-05-06
**상태**: ✅ 완료 (single phase, 1 commit)

## 최종 결과

- **변경 파일 1개**: `sessions/meta/ROADMAP.md`
- **갱신 4 영역**:
  - §1 audit 일자: `2026-05-06 (v1.82-agents-md-drift-fix 기준)` → `2026-05-06 (v1.84_workflow-revamp milestone 기준 — v1.83 폐기 후 4-tier 도입)`
  - §3-A 16건 → 17건 (`project-workflow-extension` 추가)
  - §3-B: `smoke-cross-ref-false-positive-fix` 추가 (plan-1 발견)
  - §8: milestone-summary 정책 1줄 + v1.84_workflow-revamp row (1 milestone = 1 row, phase 상세는 milestone REPORT 위임)
- **§9 보존**: v1.0~v1.82 legacy stamp 그대로 유지 (forward-only)

## 구현 요약

§8 정책 도입 — v1.84+ milestone-summary 1 row만 stamp:

```markdown
⚠️ **v1.84+ milestone-summary 정책**: `milestones/v{X.Y}_{slug}/` 단위 1 row만 본 표에 stamp. phase 상세는 milestone REPORT.md로 위임 (ROADMAP 비대화 차단). v1.0~v1.82 legacy는 forward-only 그대로 유지.
```

이로써 ROADMAP 비대화는 forward로 단조 차단 — 매 milestone 추가 시 1 row만 누적, phase N개 상세는 milestone REPORT.md에 분리 보관.

§9 폐기는 후속 (사용자 확인 필요). 본 PLAN은 forward 정책 도입에 집중.

## 판정

| 성공 기준 | 결과 |
|---------|:----:|
| §1 audit 일자 v1.84 기준 | ✅ |
| §3-A 17건 | ✅ |
| §3-B false positive fix entry | ✅ |
| §8 milestone-summary 정책 + v1.84 row | ✅ |
| §9 legacy stamp 보존 | ✅ |

## Lessons Learned

- **L1 — §9 폐기 결정 보류**: §9 ~50 row 삭제는 큰 변경. 사용자 확인 필요. 본 PLAN은 forward 정책만 도입 (legacy preservation 안전).
- **L2 — milestone-summary 정책의 dual-track**: legacy v1.0~v1.82는 phase별 1 row 형식 유지, v1.84+는 milestone 1 row. ROADMAP §8이 두 형식 병존하는 것이 audit 가독성에 미치는 영향은 후속 평가.

## 후속 (이 plan 외)

- §3-A: ROADMAP §9 폐기 결정 (사용자 확인 후)
- §3-A: ROADMAP §8 legacy 압축 (cluster grouped retro)

## 관련

- 본 PLAN: [PLAN.md](PLAN.md)
- milestone PLAN: [../PLAN.md](../PLAN.md)
- ROADMAP: [../../../sessions/meta/ROADMAP.md](../../../sessions/meta/ROADMAP.md)
