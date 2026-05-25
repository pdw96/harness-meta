---
id: milestone-v5.5-report
title: REPORT v5.5
version: v5.5
stage: REPORT
status: completed
---

# REPORT — v5.5 v4x-deprecation-narrative-cleanup

## Spec

```json
{
  "summary": "v5.0 Plugin install 전환 이후에도 environment-auditor 가 v4.x SymbolicLink/Junction 방식 검증 로직 (Stage B B1~B6) 과 Developer Mode 체크 (A1) 를 그대로 보유하고 있었다. v5.0+ 환경에서 audit 시 Stage B 전체가 false-negative 로 보고되는 실질적 문제였으며, 사용자가 Plugin 기반으로 전환한 이유 자체가 Developer Mode 의존 제거인데 여전히 체크하고 있는 것은 의도와 충돌이었다. v5.5 에서 Stage B 를 Plugin cache 기반 검증 (B0/BP1/BP2) 으로 완전 교체하고 A1 을 삭제하여 auditor 가 현행 설치 방식을 정확히 반영하도록 했다. 동시에 skills/harness-roadmap-update/SKILL.md 보안 표에서 폐기된 install-skills 참조도 제거했다."
}
```

## Delta

- **files_changed**: 2
- **files_added**: 8
- **files_deleted**: 0
- **modules_affected**: agents/, skills/harness-roadmap-update/, CHANGELOG.md, projects/meta/milestones/v5.5/

## Lessons learned

- L1: auditor 자체가 stale 할 수 있음 — auditor 가 검증하는 환경이 바뀌면 auditor 도 동시에 갱신해야 한다. v5.0 에서 install 방식이 바뀌었는데 auditor Stage B 는 v4.2 시점 그대로였다.
- L2: 버전 태그보다 현행 교체 — 'deprecated since vX.Y' 표지를 추가하는 것보다 단순히 현행 상태로 교체하는 것이 더 깔끔하다. 버전 추적 정보는 milestone 산출물과 CHANGELOG 에만 있으면 충분.
- L3: APPROVE 게이트 scope 조정 패턴 — 이번 milestone 에서 scope 가 2 차례 조정됐다 (표지 추가 → 전면 교체 → v4.x 완전 제거). APPROVE 게이트가 의도한 대로 작동했다.
- L4: 1-phase 적절 — narrative 정리 + 로직 교체가 동시에 포함되어도 2 파일 범위면 1-phase 가 적절하다.
- L5: § 6.2 stale reference drift — § 6.2 (및 Lightweight 모드 / Workflow self-improvement 동결 정책 / Narrative 정전화 3단계 패턴) 는 v4.0_harness-composer-pivot 에서 폐지됨. ARCHITECTURE.md L192 가 정전 narrative. 본 milestone Stage D~H 작성 중 옛 패턴 답습으로 'Lightweight 모드' 거명 3 파일 (DESIGN/APPROVE/REPORT) 잔존 → 사용자 지적 후 별도 fix commit. v5.4 의 § 6.2 cross-ref drift cleanup 패턴 동종 — workflow 산출물 작성 시 폐지된 옛 정책 거명 사전 검토 필요.
