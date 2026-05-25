# phase-1 — ARCHITECTURE.md § 6 spec-drift spike 패턴 정전화

```json
{
  "phase": 1,
  "title": "ARCHITECTURE.md § 6 안 spec-drift spike 패턴 paragraph 1건 정전화 + milestones.md sub_milestones[] 동기 갱신",
  "status": "complete",
  "affected_files": [
    "projects/meta/ARCHITECTURE.md (§ 6.2 폐지 narrative 직후 + § 7 직전 bold lead paragraph 1건 추가, +2 line)",
    "projects/meta/milestones/v5.7/milestones.md (sub_milestones[0] title placeholder 교체)",
    "projects/meta/milestones/v5.7/execute/phase-1.md (본 파일 산출)"
  ],
  "execution_notes": [
    "DESIGN D2 exact_text 그대로 Edit 삽입 (v3.21 narrative 정전화 3 단계 패턴 (b) EXECUTE Edit 도그푸드 9 번째 cycle 적용)",
    "삽입 위치 = ARCHITECTURE.md line 192 (§ 6.2 폐지 narrative paragraph) 직후, § 7 직전. bold lead paragraph 형식 (§ 6.2 폐지 narrative 와 일관 형식).",
    "milestones.md sub_milestones[0] phase-1 title placeholder 'Stage D DESIGN 단계에서 정확한 phase 분할 후 갱신' → 'ARCHITECTURE.md § 6 안 spec-drift spike 패턴 paragraph 1건 정전화 + milestones.md sub_milestones[] 동기 갱신' 교체 (Stage D 완료 직전 의무 step, v3.5 phase-2 도입 정합).",
    "cross-ref host 추가 zero — D3 단일 source 결정 정합. CLAUDE.md (root) / 모듈 CLAUDE.md / harness-meta.md / AGENTS.md / README / GUARDRAILS 변경 부재.",
    "§ 6.2 직접 거명 부재 검증 (D6 정합) — 본 milestone narrative 안 § 6.2 어떻게 거명 부재. 다만 ARCHITECTURE.md line 192 자체가 § 6.2 폐지 narrative paragraph 로 그 직후 paragraph 추가 = '폐지 narrative 직후' 위치 정합 (D1)."
  ],
  "commit": "phase-1 commit 예정 — conventional commits: feat(meta): v5.7 phase-1 — spec-drift spike 패턴 ARCHITECTURE.md § 6 정전화"
}
```

## execution narrative

DESIGN.D2 `exact_text` (markdown code block 1차 source) 를 Edit tool 안 `new_string` 안 그대로 삽입 — v3.21 narrative 정전화 3 단계 패턴 9 번째 cycle 도그푸드 적용. 삽입 후 ARCHITECTURE.md `~/harness-meta/projects/meta/ARCHITECTURE.md` line 192 직후 + line 194 (§ 7) 직전 위치 paragraph 1건 추가 (+2 line, 빈 line 1 + paragraph 1 line).

milestones.md sub_milestones[0] title 동기 갱신 — Stage D 완료 직전 의무 step (v3.5 phase-2 도입) 안 'phases[] 확정 후 milestones.md sub_milestones 1:1 동기 갱신 (placeholder title 교체)' narrative 정합. 본 commit 안 통합.
