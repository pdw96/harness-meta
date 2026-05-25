# REPORT — v3.9 inactive-smoke-git-mv-checklist

```json
{
  "summary": "v3.8 L1 직접 후속. v3.6_overengineering-audit #4 권고(inactive smoke 22건 tests/_inactive/ git mv) 적용 시 dirname 경로 깊이 갱신 단계가 누락되어 v3.7/v3.8 두 milestone에서 동일 버그 반복 발생. tests/CLAUDE.md '회귀 검증 절차' 섹션 하단에 '### smoke 파일 이동(git mv) 시 체크리스트' subsection 신규 추가 (4단계). 경로 규범은 기존 line 285 'inactive smoke 경로 규약 (v3.8)' cross-ref 처리 (재서술 금지). 1 phase 1 commit (9587f52), pre-commit 14 hook 모두 PASS, 회귀 0. INTENT.success_criteria 3건 모두 PASS.",
  "delta": {
    "files_changed": 2,
    "files_added": 6,
    "files_deleted": 0,
    "modules_affected": [
      "tests/CLAUDE.md (체크리스트 subsection 추가)",
      "projects/meta/milestones/v3.9/ (신규 산출물 7종)"
    ]
  },
  "lessons_learned": [
    "L1: 3 관점 검토에서 배치 위치 충돌(Option A vs B) 발생 — architecture + scope contract (2:1) 다수결 + 사용자 결정으로 해소. 소규모 milestone에서도 관점 충돌이 발생할 수 있으며, 사용자 결정 게이트가 유효함을 확인.",
    "L2: spec-drift 권고 R1 (규범 재서술 금지) 적용 패턴 — 기존 단락이 canonical source인 경우 체크리스트에서 동일 내용을 재서술하지 않고 cross-ref 처리. 단일 source 원칙과 체크리스트 절차 분리의 실 사례."
  ]
}
```
