# APPROVE — v3.13 pending-milestone-renumber-policy

사용자 명시 승인 게이트 (Stage E — 9-stage workflow v2.0+). EXECUTE 진입 전 의무.

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-12",
    "approval_summary": "v1.x pending 3건의 9-stage workflow 적용 정책 결정 milestone (v2.0_workflow-word-fidelity lessons next_candidates#1 origin) — § 6.2 동결 정책 직접 적용 = 옵션 A (defer + 외부 upbit 적용 데이터 대기) 채택. 8 decisions: D1 옵션 A 채택 / D2 Lightweight 모드 (5 관점 subagent 생략) / D3 status 'pending' → 'deferred' + deferred_reason 신 필드 / D4 deferred_note 갱신 (v3.6 + v3.13 누적) / D5 v3.13 entry PROPOSE 책임 (EXECUTE 변경 부재) / D6 단일 phase / D7 historical 산출물 forward-only 보존 / D8 A_user trigger 재분류 narrative cascade. 6 risks 모두 low (smoke unknown 필드 통과 검증 + v3.5 placeholder 교체 의무 step 포함). 5 관점 자기 검토 모두 pass (architecture / spec-drift / 회귀 risk / 보안 / scope contract — lightweight 모드 trigger 3건 충족 + 충돌 부재 예상). EXECUTE phase-1 진행 승인."
  }
}
```

## 5 관점 검토 결과 (lightweight 자기 검토)

| 관점 | 결과 | 비고 |
|------|:----:|------|
| architecture | ✅ pass | ROADMAP.md 단일 파일 + unknown 필드 자유 추가 |
| spec-drift | ✅ pass | § 6.2 정책 source 직접 cross-ref + v3.6 narrative cascade |
| 회귀 risk | ✅ pass | pre-commit 14 hook 검증 부재 확인 (status 'deferred' / deferred_reason 신 필드) |
| 보안 | ✅ pass | 분기 부재 (ROADMAP narrative 갱신만) |
| scope contract | ✅ pass | INTENT.success_criteria 7건 → DESIGN.phases[0] 1:1 매핑 |

## 의견 충돌

없음 (lightweight 모드 자기 검토, § 6.2 trigger 3건 충족).

## EXECUTE 진입 조건 확인

- ✅ milestones.md 보유 (Stage A step 7 작성 + Stage D phases 동기 갱신 완료)
- ✅ INTENT/RESEARCH/DESIGN/APPROVE 4건 작성 완료
- ✅ 사용자 명시 승인 (approved_by: "user" + date: "2026-05-12")
- ✅ INTENT~APPROVE commit 시점 — 패턴 (b) 채택 (Stage G VERIFY commit 안 포함, 산출물 영구 보존 보장)

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- milestones.md (sub_milestones 1:1 동기): [`milestones.md`](milestones.md)
