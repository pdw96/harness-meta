# REPORT — v3.21_narrative-canonicalization-3step-pattern

```json
{
  "id": "v3.21_narrative-canonicalization-3step-pattern",
  "summary": "v3.20_drift-narrative-canonicalization L4 lesson + PROPOSE.next_candidates#2 직접 후속 (A_user trigger, /harness-meta meta 자유 발의 round 안 'narrative 정전화 3단계 패턴 명문화' 옵션 명시 선택). v3.18 + v3.20 두 narrative 정전화 milestone 안 자연 발현한 3 단계 정합 패턴 — (a) DESIGN 안 정확 문구 1차 source / (b) phase-1 EXECUTE Edit 그대로 삽입 / (c) VERIFY grep 검증 키워드 — 을 ARCHITECTURE.md § 6.2 Lightweight 모드 안 'Workflow self-improvement 동결 정책' paragraph 직후 + '선례' subsection 직전 'Narrative 정전화 3단계 패턴' bold lead paragraph 1건 정전화. lightweight 모드 (§ 6.2 자기참조 회피 표지, 누적 9/21 = 42.9%) — 5 관점 subagent 생략 + 1-phase 1+1 commit 도그푸드 (v3.18/v3.19/v3.20 패턴 정확 정합). 본 milestone 자체가 3단계 패턴 자기 적용 도그푸드 = 자기참조 cycle 3번째 (v3.18 + v3.20 + v3.21) 완성. INTENT.success_criteria 8건 모두 PASS, pre-commit 14 hook 모두 PASS, 회귀 0.",
  "delta": {
    "files_changed": 8,
    "files_added": [
      "projects/meta/milestones/v3.21/INTENT.md",
      "projects/meta/milestones/v3.21/RESEARCH.md",
      "projects/meta/milestones/v3.21/DESIGN.md",
      "projects/meta/milestones/v3.21/APPROVE.md",
      "projects/meta/milestones/v3.21/milestones.md",
      "projects/meta/milestones/v3.21/execute/phase-1.md"
    ],
    "files_modified": [
      "projects/meta/ARCHITECTURE.md (+2 line — § 6.2 'Narrative 정전화 3단계 패턴' bold lead paragraph 1건)",
      "projects/meta/ROADMAP.md (v3.21 entry in_progress 추가 + updated 2026-05-14)"
    ],
    "files_deleted": [],
    "loc_delta_phase_1_commit": "+521 lines (8 files, -1 deletion = ROADMAP.md updated date 갱신). v3.20 baseline 503 line 대비 +18 line. v3.17 ~495 / v3.18 ~400 / v3.19 ~575 / v3.20 ~503 / v3.21 ~521 = 5 cycle 누적 평균 ~499 line (cap 1500 권고 ~33.3% 활용, lightweight cap 정합)",
    "modules_affected": [
      "projects/meta/ARCHITECTURE.md (§ 6.2 Lightweight 모드 영역 narrative 추가)",
      "projects/meta/milestones/v3.21/ (신규 milestone container)",
      "projects/meta/ROADMAP.md (v3.21 entry 추가, Stage I 시점 status completed 갱신 예정)"
    ],
    "commits": [
      "03c1830 — feat(meta): v3.21 phase-1 — ARCHITECTURE.md § 6.2 Narrative 정전화 3단계 패턴 paragraph 추가 (v3.18+v3.20 발현 + v3.21 정전화)",
      "<Stage G chore commit pending — VERIFY/REPORT/PROPOSE + milestones.md status complete + ROADMAP completed 갱신>"
    ]
  },
  "lessons_learned": [
    {
      "id": "L1",
      "lesson": "3단계 패턴 자기 적용 도그푸드 = 자기참조 cycle 3번째 완성 — v3.18 (1차 발현) + v3.20 (2차 발현) + v3.21 (3차 정전화 자기 적용). 3 cycle 누적 = 정전화 권장 trigger 자연 충족. 도그푸드 cycle 3번째 = 패턴 자체로 패턴 명문화 + 명문화 자체가 패턴 적용 = 자기참조 모순 의도성 표지 정합. § 6.2 self_reference_policy: avoid 표지 + lightweight 모드 default 정합.",
      "implication": "후속 narrative 정전화 milestone (예: v3.X_lightweight-1phase-commit-timing-a-canonicalization, v3.X_diagnose-then-canonicalize-pattern) 도 동일 3단계 패턴 적용 가능 — § 6.2 신 paragraph 직접 cross-ref 가능"
    },
    {
      "id": "L2",
      "lesson": "phase-1.md JSON schema 안 'phase' 필드 누락 발견 (smoke-spec-verification FAIL → 첫 commit 시도 차단) — phase-1.md JSON 필드 구조 = `id` + `phase` (정수) + `status` + 기타. v3.21 phase-1.md 초기 작성 시 `phase` 필드 누락 → 첫 commit 시도 시 smoke FAIL → Edit 보완 후 재시도 PASS. 본 phase 추적 의무 schema 의 일관성 확인.",
      "implication": "phase-1.md 작성 시 'phase' (정수) 필드 의무 명시 — v3.18/v3.19/v3.20 phase-1.md 모두 'phase' 필드 보유, 누락 시 smoke-spec-verification 'Stage 5 — execute/phase-{n}.md JSON schema' FAIL 차단. 본 lesson 자체가 schema 의무 narrative 1차 source 후보 (단 § 6.2 default 동결 정합 — ROADMAP 미등재 거명만)"
    },
    {
      "id": "L3",
      "lesson": "lightweight 모드 누적 9/21 = 42.9% (v3.20 8/20 = 40% 첫 돌파 후 추가 cycle 갱신). v3.6_overengineering-audit § 6.2 도입 이후 12 milestone 누적 (v3.7~v3.21) 중 8건 lightweight 모드 (v3.10/v3.13/v3.14/v3.17/v3.18/v3.19/v3.20/v3.21). § 6.2 정책 정상 작동 정량 evidence + lightweight 모드 자연 default 패턴 정전화 누적.",
      "implication": "lightweight 모드 누적 동치화 narrative (v3.17 L3 + v3.18 L6 + v3.19 L3 + v3.20 L3) 4 cycle 누적 — § 6.2 default 동결 정상 작동 + lightweight 모드 자연 default 패턴 정확"
    },
    {
      "id": "L4",
      "lesson": "ARCHITECTURE.md narrative 정전화 milestone 안 정확 문구 1차 source 위치 = DESIGN.md 안 sub-header '## Phase 1 정확 narrative 정문구' + markdown code block 패턴 = v3.18 D3 + v3.20 D2 + v3.21 D2 = 3 cycle 누적 = 정전화 완료. 본 milestone § 6.2 신 paragraph 자체가 본 패턴 명문화 narrative.",
      "implication": "후속 narrative 정전화 milestone 시 동일 패턴 의무 적용 — DESIGN ## Phase 1 정확 narrative 정문구 섹션 + markdown code block + 정확 문구 1차 source. § 6.2 신 paragraph 직접 cross-ref 가능"
    },
    {
      "id": "L5",
      "lesson": "commit timing 실 운용 (a) 패턴 5 cycle 누적 (v3.17/v3.18/v3.19/v3.20/v3.21) — phase-1 commit 안 INTENT/RESEARCH/DESIGN/APPROVE 4건 + milestones.md + execute/phase-1.md + ROADMAP entry 통합. DESIGN D6 narrative (b) default vs 실 운용 (a) 차이 = lightweight 1-phase 시 (a)/(b) 실 동치 패턴 5 cycle 누적 strong evidence (v3.20 L1 narrative + 본 milestone 정확 정합).",
      "implication": "v3.20 PROPOSE.next_candidates#1 (v3.X_lightweight-1phase-commit-timing-a-canonicalization) trigger 조건 (사용자 명시 발의 AND) — 5 cycle 누적 = 정전화 권장 trigger 자연 충족. PROPOSE 단계 거명 (§ 6.2 default 동결 정합, ROADMAP 미등재)"
    },
    {
      "id": "L6",
      "lesson": "AskUserQuestion preview field 사용 패턴 누적 — v3.20 첫 사용 (narrative 위치 옵션 3건 preview ASCII layout) + v3.21 (host 위치 옵션 4건 preview ASCII layout). 2 cycle 누적 = lightweight 모드 narrative 위치 결정 분기점 default 도구. preview ASCII layout 으로 § 구조 시각 비교 가능.",
      "implication": "후속 narrative 정전화 milestone 시 host 위치 선택 분기점 = AskUserQuestion preview field 활용 default. 위치 후보 4건+ 시 preview ASCII layout 권장 — 사용자 인지 부담 균형"
    }
  ],
  "regressions": [],
  "byproduct_check": "REPORT.summary + delta + lessons_learned 모두 사실 진술 + backward 종합 책임만 — forward propose 책임 부재 (lessons_learned L1/L5 implication 안 후속 candidate 거명만, PROPOSE 단계 통합 흡수 책임 v3.10 정합)"
}
```

## narrative

본 REPORT 는 **backward 종합 책임** (report 단어-책임 정합 90% 정합 적용) — summary + delta + lessons_learned + regressions 4 책임. forward 책임 (next_candidates) 은 PROPOSE 단계 분리 (v2.0_workflow-word-fidelity 정정 정합).

`lessons_learned` 6건 (L1~L6) 모두 사실 진술 + implication narrative — 후속 candidate '거명만' 표현 (v3.10 부산물 정책 정합, PROPOSE 단계 통합 흡수). lightweight 모드 자기참조 회피 표지 = self_reference_policy: avoid 정합.

## delta summary

| 항목 | 값 |
|---|---|
| files changed | 8 (6 added + 2 modified + 0 deleted) |
| LOC delta (phase-1 commit) | +521 line (-1 deletion = ROADMAP.md updated date 갱신) |
| commit count | 1 (03c1830) + 1 (Stage G pending) = 2 |
| 워크플로우 본문 변경 | 0 |
| smoke 추가/변경 | 0 |
| 다른 host cross-ref 추가 | 0 (단일 source 전략 정합) |
| pre-commit hook | 14/14 PASS |
| 회귀 | 0 |
| AskUserQuestion 사용 | 3건 (옵션 선택 + host 위치 + APPROVE) |

## 자기참조 cycle 3번째 완성

본 milestone = **3단계 패턴 명문화 + 자기 적용 도그푸드 cycle 3번째**:

- v3.18 (1차 발현): D3 narrative 정확 문구 패턴 자연 도입
- v3.20 (2차 발현): D2 narrative 정확 문구 패턴 동일 재현 → L4 lesson 1차 source
- v3.21 (3차 정전화): § 6.2 신 paragraph 'Narrative 정전화 3단계 패턴' 명문화 + 자기 적용 도그푸드

3 cycle 누적 = 정전화 권장 trigger 자연 충족 (v3.20 PROPOSE.next_candidates#2 trigger_condition '3 cycle 누적 후 정전화 권장' 정확 충족).

## 관련

- INTENT (goal/success_criteria source): [`INTENT.md`](INTENT.md)
- RESEARCH (external/options/risks source): [`RESEARCH.md`](RESEARCH.md)
- DESIGN (D1~D6 decisions source): [`DESIGN.md`](DESIGN.md)
- APPROVE (사용자 명시 승인 게이트): [`APPROVE.md`](APPROVE.md)
- execute/phase-1.md (commit 03c1830): [`execute/phase-1.md`](execute/phase-1.md)
- VERIFY (criteria_check 8건 1:1 매핑): [`VERIFY.md`](VERIFY.md)
- phase-1 commit: `03c1830`
- v3.20 L4 lesson 1차 source: [`../v3.20/REPORT.md`](../v3.20/REPORT.md) (L4)
- v3.20 PROPOSE.next_candidates#2 origin: [`../v3.20/PROPOSE.md`](../v3.20/PROPOSE.md) (next_candidates#2)
- v3.18 패턴 1차 발현: [`../v3.18/DESIGN.md`](../v3.18/DESIGN.md) (## Phase 1 정확 narrative 정문구)
- ARCHITECTURE.md insertion result: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2
- workflow 자기참조 동결: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2
