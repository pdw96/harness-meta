---
phase: phase-2
milestone: v7.1
status: completed
---

# v7.1 phase-2 — carry-over + `/clear` 권고 (행동 지침 반쪽)

## Spec

```json
{
  "phase": "phase-2",
  "status": "completed",
  "scope": "carry-over + 권고 — root CLAUDE.md 안 carry-over 블록 schema (in-flight 4 항목, d_6) + stage 완료 시 제시 행동 규약 + /clear 권고 narrative (always-loaded 단일 source, d_5) + ARCHITECTURE § 7.1 1줄 등재 pointer. sc_2/sc_3 커버.",
  "changes": [
    {"type": "edit", "path": "CLAUDE.md", "description": "(d_5/d_6) ## 개발 프로세스 안 ### Stage carry-over + /clear 권고 (v7.1) 신규 — stage 완료 결정적 trigger 설명 + carry-over 블록 schema (in-flight 4 항목: 진행 중 결정 / 대기 중 질문 / 다음 행동 / [ctx N%] 높으면 /clear 고려) + 디스크 미기록 상태만 담는 범위 + 1차 source = CLAUDE.md(always-loaded) 명시. always-loaded 부담 최소 위해 짧게 유지."},
    {"type": "edit", "path": "projects/meta/ARCHITECTURE.md", "description": "(d_5) § 7.1 안 '컨텍스트 효율 면 mechanism (v7.1)' 1단락 등재 — (a) 게이지 (b) carry-over 두 반쪽 + '게이지 보고→안전 리셋' loop 요약 + 1차 source = CLAUDE.md pointer only (정의 중복 회피, cascade marker 부재 = § 7.3 단방향 pointer 선례 동형)."}
  ],
  "verification": [
    {"method": "grep carry-over CLAUDE.md", "result": "PASS", "detail": "carry-over 4 회 출현 — 블록 schema + narrative 존재 확인 (d_6 schema 존재 검증)."},
    {"method": "python scripts/cascade_sync.py --check", "result": "PASS", "detail": "all 1 host(s) in sync — 신규 cascade marker 부재 (§ 7.1 = narrative pointer only), 기존 1 host 무변경 (DESIGN cascade 정합)."},
    {"method": "smoke 회귀", "result": "PASS", "detail": "smoke-claude-md-drift 13/13 + smoke-cross-ref 1/0 + smoke-cascade-drift in sync."},
    {"method": "always-loaded 토큰 폭 1회 측정 (d_7, cascade-narrative comment 흡수)", "result": "기록", "detail": "CLAUDE.md before 155 lines / 2080 words / 17522 bytes → after 171 / 2240 / 18641 = delta +16 lines / +160 words / +1119 bytes (≈ +6.4% bytes). d_5 token-efficiency trade-off 정직 노출 — d_6 schema 최소화로 완화한 결과."}
  ],
  "verification_asymmetry": "계기판 (phase-1) 은 stdin JSON fixture smoke 로 PASS 검증. carry-over (phase-2) 는 행동 지침이라 '실제 stage 완료 시 carry-over 가 제시됐는지' 자기회고 검증 불가 (risk_3, memory: skill body observer limit 동류) → schema 존재 (grep) + 수동 1회 확인까지만. 과잉 검증 주장 금지 (d_7).",
  "commit": null
}
```

## Narrative

phase-2 = INTENT 2 반쪽 중 **carry-over + 권고** (행동 지침, 검증 비대칭 절반). DESIGN d_5/d_6 를 2 파일 편집으로 구현했다.

**단일 source 거주** (d_5) — carry-over narrative 를 root CLAUDE.md (always-loaded) 에 둔 이유는 stage skill (invoke-시-로드) 이 '복도(모든 stage 경계)' 를 못 덮기 때문이다. carry-over 권고는 skill 명시 호출 없는 stage 완료에서도 작동해야 하므로 always-loaded 가 신뢰성 높다 (opt_3 재평가). ARCHITECTURE § 7.1 은 정의 중복을 피해 pointer 1단락만 — 신규 cascade marker 부재는 § 7.3 stage skill 단방향 pointer 선례와 동형 (양방향 hash-tracked marker 는 정의 중복 drift 차단용이라 여기선 불요).

**범위 좁힘** (d_6) — carry-over 블록은 in-flight 상태 (진행 중 결정 / 대기 질문 / 다음 행동) 만 담는다. milestone 진행 상태는 이미 MILESTONE.md / ROADMAP 디스크에 남으므로, 디스크 미기록 상태만 담는 것이 carry-over 의 유일 가치다.

**검증 비대칭 솔직 명시** (d_7, risk_3) — 계기판은 smoke PASS 였으나 carry-over 는 행동 지침이라 자기회고 검증 불가. schema 존재 (grep 4회) + 수동 1회 확인 (본 milestone REPORT 작성 시 carry-over 블록 실제 제시 여부 관찰) 까지만. always-loaded 토큰 폭은 1회 측정 기록 (+16 lines / +1119 bytes ≈ +6.4%) — d_5 token-efficiency trade-off 를 숨기지 않고 노출, d_6 schema 최소화로 완화한 결과 (design-review cascade-narrative comment 흡수).
