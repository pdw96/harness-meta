# REPORT — v3.10 stage-byproduct-clarification

```json
{
  "id": "stage-byproduct-clarification",
  "summary": "v2.0_workflow-word-fidelity '단어 = 단일 책임 1:1 매핑' 원칙 운영 안 영역 침범 3건 (v3.6 INTENT.out_of_scope L19~21 '별 milestone 분리' / v3.6 DESIGN.phase-3 scope 'PROPOSE.md next_candidates 발의 narrative' / v1.4 RESEARCH.untouched_files_explicit 6건 묶음 → v1.5_legacy-narrative-cleanup 직접 발의) 을 자연 부산물로 재해석 (옵션 A). claude/commands/harness-meta.md Stage B/C/D 정의에 (a) 사실 진술 vs (b) 후속 발의 의미 분리 narrative 추가 + Stage I PROPOSE 안 B/C/D 부산물 통합 흡수 책임 + A_user dual origin 명시 + projects/meta/ARCHITECTURE.md § 4 9-stage 표 직후 cross-ref 1줄. lightweight 모드 (5 관점 subagent 생략, v3.6 선례) + 1 phase 1 commit (4e1981f) + 도그푸드 (본 milestone 산출물 안 forward propose 명령형 부재). § 6.2 A_user trigger 예외 경로 첫 사용 사례 — 외부 적용 정량 데이터 부재이나 현 세션 내부 정량 진단 3건 기반 사용자 명시 발의. INTENT.success_criteria 7건 모두 VERIFY PASS, pre-commit 14 hook 모두 PASS, 회귀 0.",
  "delta": {
    "files_changed": 3,
    "files_added": 8,
    "files_deleted": 0,
    "modules_affected": ["claude/commands/", "projects/meta/", "projects/meta/milestones/v3.10/"],
    "lines_added": 95,
    "narrative_lines_in_workflow_definition": 16,
    "narrative_lines_in_architecture": 2,
    "commits": ["4e1981f (phase-1)"]
  },
  "lessons_learned": [
    {
      "id": "L1",
      "lesson": "도그푸드 (본 milestone 산출물 안 새 narrative 첫 적용) 가 narrative 명료화 milestone 의 self-consistency 검증 핵심 메커니즘. INTENT.out_of_scope / DESIGN.phases[0].scope / decisions[i].rationale 모두 사실 진술 + alternative 거명 + alternatives_rejected — forward propose 명령형 부재 grep 검증 통과. v3.10 narrative 자체가 본 milestone 안에서도 self-consistent 입증."
    },
    {
      "id": "L2",
      "lesson": "smoke-spec-verification Stage 7 (execute/phase-{n}.md JSON schema) 가 'phase' 필드를 의무화. phase-1.md skeleton 첫 작성 시 'id' 필드만 두고 'phase' 누락 → 1st commit FAIL. skeleton template 명문화 권고 — v3.10 후속 candidate (v3.11 phase-skeleton-template-strengthening)."
    },
    {
      "id": "L3",
      "lesson": "lightweight 모드 + 1 phase 1 commit + narrative-only 변경 의 조합이 workflow self-improvement 카테고리의 효율적 패턴. v3.6 선례 + v3.10 적용 — 산출물 LOC 합 < 600줄 cap 정합 (INTENT 51 + RESEARCH 70 + DESIGN 92 + APPROVE 28 + VERIFY 36 + REPORT 작성 중 + PROPOSE 예정 + milestones 60 + phase-1 25 ≈ 480줄 추정). 5 관점 subagent 생략이 자기참조 사이클 재진입 risk 회피 + 산출물 단순화."
    },
    {
      "id": "L4",
      "lesson": "§ 6.2 A_user trigger 예외 경로 첫 사용 사례 — INTENT.dependencies.section_6_2_exception 안 narrative 명시 의무 충족. evidence-base trigger (외부 적용 정량 데이터) 부재이나 내부 정량 진단 (현 세션 영역 침범 3건 grep 확정) + 사용자 명시 결정 기반. § 6.2 의 '사용자 명시 trigger' 가 'evidence-base trigger' 와 병렬 예외 경로임을 명확히 — v3.6 § 6.2 narrative 자체 보강 후보 (v3.10 후속 candidate)."
    }
  ]
}
```

## 비고

본 REPORT.md 32줄 (cap < 100줄 정합). lessons_learned 4건 (cap < 5건 정합). next_candidates (forward) 는 PROPOSE.md 분리 — REPORT 는 backward 종합만 (Stage H/I 분리 원칙 정합).
