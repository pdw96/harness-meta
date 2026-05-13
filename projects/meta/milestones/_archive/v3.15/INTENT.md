# INTENT — v3.15 changelog-v3-backfill

```json
{
  "id": "v3.15_changelog-v3-backfill",
  "title": "CHANGELOG.md v3.0~v3.14 backfill — v3.0 breaking major bump + v3.1~v3.14 13 entry 외부 visible artifact 정전화",
  "goal": "CHANGELOG.md 에 누락된 v3.0 breaking change (major bump) + v3.1~v3.14 13 entry 를 Keep a Changelog v1.1.0 포맷으로 backfill 하여 외부 visible artifact 단일 source 정전화.",
  "motivation": "CHANGELOG.md 는 외부 사용자/공헌자 시점의 단일 visible source. 현재 v2.1 (2026-05-10) 까지만 기록되어 있고, v3.0 (2026-05-10, breaking change `!` major bump = milestone hierarchy 재구성 v2 → v3) + v3.1~v3.14 (2026-05-10 ~ 2026-05-13, 13 entry) 총 14 milestone 이 누락 상태. 외부 시점에서 본 repo 가 'v2.1 era 정지' 로 stale 비춰지는 narrative drift. 정량 — 누적 14 milestone × ~3일 간 갱신 부재. 사용자 발의 (A_user) — 자유 발의 round 에서 'CHANGELOG 갱신 (Recommended)' 옵션 명시 선택.",
  "success_criteria": [
    "CHANGELOG.md 에 v3.0~v3.14 13 entry 추가 (v3.0 단독 + v3.1~v3.14 12 entry, v3.2/v3.5 sub-bundle 포함, v3.6 lightweight 모드 포함)",
    "v3.0 entry 에 breaking change 마커 `!` 표시 (기존 v2.0 `!` 동치 표기) — major bump 정전",
    "각 entry 는 해당 milestone ROADMAP entry `summary` 필드 1차 source 부합 (REPORT.md 참조 권유는 별도 보조 source)",
    "Keep a Changelog v1.1.0 카테고리 (Added / Changed / Removed / Fixed / Performance / Security / Deprecated) 정합",
    "SemVer 정합 narrative 유지 (`.harness.toml` schema 레벨, repo 자체 버전 아닌 표기)",
    "[Unreleased] 섹션 처리 — v2.1 직후 등록되었던 항목들이 v3.x 안으로 이동했는지 확인 후 정합화 (현행 보존 또는 v3 안 흡수)",
    "기존 v2.1 / v2.0 / v1.x entry narrative 보존 (재작성 금지 — 본 milestone scope 외)",
    "pre-commit 14 hook + smoke 회귀 0",
    "lightweight 모드 산출물 LOC cap 정합 (§ 6.2 narrative cap 정책)"
  ],
  "out_of_scope": [
    "workflow 자체 변경 (§ 6.2 workflow self-improvement 동결 정책 회피 — narrative cleanup 본질)",
    "ROADMAP.md 의 v3.0~v3.14 entry summary 재작성 (현행 보존, 본 milestone 은 CHANGELOG 단방향 backfill)",
    "ARCHITECTURE.md narrative 변경 (era 정책 § 6.1 / 동결 § 6.2 현행 보존)",
    "milestone REPORT.md 재작성 또는 보충 (각 milestone 자기 완결)",
    "v1.x / v2.x CHANGELOG entry 재작성 (현행 보존)",
    "5 관점 subagent 검토 (lightweight 모드 — § 6.2 trigger 3건 충족: narrative cleanup + workflow 미영향 + 충돌 부재 예상)",
    "deferred 3건 재발의 (cycle 3) — v3.14 결정 정합, 외부 5건+ ∧ 사용자 명시 발의 AND 조건 미충족"
  ],
  "dependencies": {
    "precedes": [
      "v3.14_deferred-revaluation-cycle-2 (cycle 2 완료, 2026-05-13)",
      "v3.6_overengineering-audit (§ 6.2 lightweight 모드 정책 source)",
      "v3.11_legacy-narrative-cleanup (narrative cleanup 패턴 선례)",
      "v3.12_deprecated-skill-narrative-cleanup (narrative cleanup 패턴 선례)"
    ],
    "follows": []
  },
  "trigger_origin": "사용자 발의 (A_user) — /harness-meta meta 자유 발의 round 의 'CHANGELOG v3.0~v3.14 갱신 (Recommended)' 옵션 명시 선택. CHANGELOG.md head 50 line 직접 확인 결과 v2.1 (2026-05-10) 헤더 직후 [Unreleased] + v1.14 직접 이어짐, v3.0 부재 정량 확인."
}
```

## 부가 narrative

- **lightweight 모드 적용 근거** (§ 6.2 trigger):
  1. narrative cleanup 본질 (실 코드 변경 부재) — v3.11/v3.12 선례 패턴 정합
  2. workflow 자체 미영향 (CHANGELOG.md 단일 파일 한정)
  3. 5 관점 의견 충돌 부재 예상 (사실 진술 정리)

- **out_of_scope 부산물 정책** (v3.10): 위 entry 들은 (a) 본 milestone 의 negative scope 사실 진술만 — '별 milestone 으로' 같은 forward propose 명령형 표현 부재. 후속 candidates 발의는 Stage I (PROPOSE) 단일 책임으로 위임.

## 관련

- 상위 컨테이너: [`milestones.md`](milestones.md)
- 선행 milestone: [`../v3.14/REPORT.md`](../v3.14/REPORT.md), [`../v3.11/REPORT.md`](../v3.11/REPORT.md), [`../v3.12/REPORT.md`](../v3.12/REPORT.md)
- 단일 source: [`../../../../CHANGELOG.md`](../../../../CHANGELOG.md)
- ROADMAP: [`../../ROADMAP.md`](../../ROADMAP.md)
