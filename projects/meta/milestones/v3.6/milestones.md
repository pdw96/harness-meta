# milestones — v3.6

```json
{
  "version": "v3.6",
  "title": "Overengineering audit — workflow 자기참조 사이클 진단 + lightweight remediation (자기참조 회피 표지)",
  "status": "in_progress",
  "self_reference_policy": "avoid",
  "self_reference_rationale": "v2.0_workflow-word-fidelity 선례 — 본 milestone 이 9-stage rigid + 5 관점 검토 + 산출물 narrative 5~9x overhead 를 권고로 trim 하는 작업이므로, 본 milestone 자체에 9-stage rigid 적용 시 진단 자체가 오버엔지니어링 재연. 따라서 자기참조 부합 (도그푸드) 거부 + 회피 표지 채택. ARCHITECTURE.md § 6.1 'chicken-and-egg 회피 시 예외' 정합.",
  "sub_milestones": [
    {
      "phase": 1,
      "title": "권고 #1 명문화 — ARCHITECTURE.md § 6.2 'Lightweight 모드 정책' 신설 + workflow self-improvement 동결",
      "status": "complete",
      "commit": "4ef8a74"
    },
    {
      "phase": 2,
      "title": "권고 #4 적용 — smoke inactive 22 archive 이동 (tests/_inactive/) + tests/CLAUDE.md 매트릭스 narrative 갱신",
      "status": "complete",
      "commit": "9ba1eb1"
    },
    {
      "phase": 3,
      "title": "권고 #7 발의 준비 — upbit 외부 적용 next_candidate narrative (실 발의는 사용자 명시 trigger 대기)",
      "status": "complete",
      "commit": null,
      "commit_note": "Stage G+H+I 통합 commit 안 포함 (narrative-only phase, git log + REPORT.delta.commits 거명, lightweight 정합)"
    }
  ]
}
```

## 의도 (lightweight skeleton)

사용자 발의 — 외부 best practice (Martin Fowler / OpenAI / Anthropic / Pi) 대비 + 내부 정량 진단 결과 명확한 오버엔지니어링 확인. 자기참조 사이클 (workflow self-improvement) 탈출 + 진단 권고 7건 의 lightweight remediation 실행.

상세 의도·success_criteria·out_of_scope·dependencies 는 Stage B `INTENT.md` 작성 시 확정 (lightweight cap < 100줄 권고).

## Lightweight 모드 적용 (v2.0 선례)

- Stage D 5 관점 병렬 subagent 검토 **생략** (권고 #3 자체 적용)
- 산출물 narrative cap (각 산출물 < 150줄 권고, v3.5 산출 897줄 대비 < 600줄 cap)
- INTENT/DESIGN 통합 가능 (실 trim 작업이 본 milestone 본질, 5 관점 의견 충돌 부재 예상)
- APPROVE.md 사용자 명시 승인 게이트 **유지** (lightweight 모드에서도 EXECUTE 진입 게이트 의무)
- 자기참조 부합 (도그푸드) 거부 — chicken-and-egg 회피 표지

## 후속 stage 산출물 (lightweight)

| Stage | 파일 | 책임 (lightweight cap) |
|:-:|------|------|
| B INTENT | `INTENT.md` | 의도 + 권고 7건 success_criteria 매핑 (< 100줄) |
| C RESEARCH | `RESEARCH.md` | 외부 best practice 정리 + 내부 정량 source (< 150줄) |
| D DESIGN | `DESIGN.md` | 권고 7건 → phase 분할 + risk_mitigation (< 200줄, **5 관점 검토 생략**) |
| E APPROVE | `APPROVE.md` | 사용자 명시 승인 (lightweight 모드에서도 게이트 유지) |
| F EXECUTE | `execute/phase-{n}.md` | per-phase trim 작업 (각 1 commit) |
| G VERIFY | `VERIFY.md` | smoke 회귀 검증 + criteria_check (< 100줄) |
| H REPORT | `REPORT.md` | backward + lessons (< 100줄) |
| I PROPOSE | `PROPOSE.md` | 기존 v3.6/v3.7 defer entry 재발의 여부 + 후속 forward (< 80줄) |

## Defer 처리 entry (audit trail)

본 milestone 발의로 ROADMAP 에서 제거된 pending entry 2건 (`projects/meta/ROADMAP.md` deferred_note 참조):

1. **v3.6_milestones-md-validation-extension** (구 v3.6, pending) — milestones.md 검증 확장. 자기참조 사이클 강화 신호 (smoke 인프라 자체 강화). 본 milestone PROPOSE 에서 재발의 여부 검토.
2. **v3.7_workflow-narrative-strengthening-v2** (구 v3.7, pending) — workflow narrative 강화 v2. 자기참조 사이클 가장 직접 신호. 본 milestone PROPOSE 에서 재발의 여부 검토 (권고 #1 동결과 정면 대비).

git history 가 audit trail (HEAD 이전 ROADMAP entry source).

## 관련

- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) (v3.6, `status: in_progress`)
- ARCHITECTURE: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1 (자기참조 회피 표지 정책)
- 자기참조 회피 선례: [`../v2.0_workflow-word-fidelity/`](../v2.0_workflow-word-fidelity/) (chicken-and-egg 회피)
- 부모 진단 source: 본 세션 transcript (외부 source 8건 + 내부 정량 8건)
