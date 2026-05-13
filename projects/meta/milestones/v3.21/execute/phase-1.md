# Phase 1 — ARCHITECTURE.md § 6.2 Narrative 정전화 3단계 패턴 paragraph 추가

```json
{
  "id": "v3.21_narrative-canonicalization-3step-pattern_phase-1",
  "phase": 1,
  "title": "ARCHITECTURE.md § 6.2 Narrative 정전화 3단계 패턴 paragraph 추가 — 'Workflow self-improvement 동결 정책' 직후 (선례 직전) + commit",
  "status": "in_progress",
  "scope": "ARCHITECTURE.md § 6.2 안 1 paragraph (3단계 패턴 narrative 정전화). 다른 host 변경 zero. 워크플로우 본문 (Stage A~I 9-stage 절차) 변경 zero. smoke 추가 zero.",
  "affected_files": [
    "projects/meta/ARCHITECTURE.md (§ 6.2 narrative 1 paragraph 추가 — 'Workflow self-improvement 동결 정책' 직후 + '선례' 직전)",
    "projects/meta/milestones/v3.21/execute/phase-1.md (본 파일)",
    "projects/meta/milestones/v3.21/milestones.md (sub_milestones[0] placeholder 교체됨, Stage G commit 시 status complete + commit hash)"
  ],
  "changes": [
    "ARCHITECTURE.md § 6.2 line 198 'Workflow self-improvement milestone 동결 정책 (v3.6 권고 #1)' paragraph 직후 + '선례' subsection 직전 'Narrative 정전화 3단계 패턴' bold lead paragraph 1건 삽입 (D2 정확 문구)"
  ],
  "execution_notes": "Stage F EXECUTE 진입 — DESIGN.md ## Phase 1 정확 narrative 정문구 섹션 안 markdown code block 정확 문구 (b) Edit tool 그대로 삽입. 3단계 패턴 자기 적용 도그푸드 — (a) DESIGN 1차 source → (b) phase-1 EXECUTE Edit 그대로 → (c) Stage G VERIFY grep 검증 키워드. self_reference_policy: avoid 표지 정합.",
  "commit_message_target": "feat(meta): v3.21 phase-1 — ARCHITECTURE.md § 6.2 Narrative 정전화 3단계 패턴 paragraph 추가 (v3.18+v3.20 발현 + v3.21 정전화)"
}
```

## narrative

본 phase = **3단계 패턴 (b) 단계 자기 적용** — DESIGN.md 안 정확 문구 1차 source 를 Edit tool 로 ARCHITECTURE.md § 6.2 'Workflow self-improvement 동결 정책' paragraph 직후 + '선례' subsection 직전 정확 그대로 삽입.

Edit pre-condition — DESIGN.md ## Phase 1 정확 narrative 정문구 섹션 안 markdown code block (line 158~) 정확 문구 1차 source 참조. 변형 차단.

## 관련

- DESIGN (정확 문구 1차 source): [`../DESIGN.md`](../DESIGN.md) (## Phase 1 정확 narrative 정문구 섹션)
- INTENT (success_criteria 8건): [`../INTENT.md`](../INTENT.md)
- ARCHITECTURE.md insertion target: [`../../../ARCHITECTURE.md`](../../../ARCHITECTURE.md) § 6.2
- milestones.md (sub_milestones[0] placeholder 교체됨): [`../milestones.md`](../milestones.md)
