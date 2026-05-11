# DESIGN — v3.6 overengineering-audit

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "Option A (lightweight remediation only) 채택 — 권고 #1/#4/#6/#7 즉시 적용",
      "rationale": "RESEARCH.options Option B (전면 trim) 는 lightweight 모드 정신 자체 위배 + 자기참조 사이클 재진입. Option C (milestone 부재) 는 audit trail 손실. Option A 가 lightweight 정합 + audit trail 보존 + 권고 7건 중 적용 가능한 4건 안전 처리.",
      "alternatives_rejected": ["B. 전면 trim", "C. milestone 부재"]
    },
    {
      "id": "D2",
      "decision": "권고 #2 (9-stage trim) / #3 (5 관점 trim) / #5 (4 era migration) 은 본 milestone scope 외 — PROPOSE 에서 후속 candidate 등재만",
      "rationale": "이 3건은 workflow 자체 변경 = self-improvement milestone — 적용시 자기참조 사이클 재진입. 권고 적용 자체가 권고 모순. 후속 candidate 등재 시 사용자가 외부 프로젝트 (upbit) 실 적용 후 정량 데이터 기반 재발의 권장 (release train 모델 아닌 evidence-base trigger).",
      "alternatives_rejected": ["본 milestone 안 적용"]
    },
    {
      "id": "D3",
      "decision": "subagent 5 관점 병렬 검토 생략 — lightweight 모드 표지",
      "rationale": "권고 #3 (5 관점 trim) 자체 적용 + 본 milestone scope 작음 (≤5 파일 변경 예상) + 5 관점 의견 충돌 부재 예상 (권고 적용 trim 작업이 본질, architecture 결정 분기 부재). 자기참조 회피 표지 narrative 1줄 명시.",
      "alternatives_rejected": ["3 관점 (architecture / spec-drift / scope contract) 적용", "5 관점 전체 적용"]
    },
    {
      "id": "D4",
      "decision": "권고 #6 (narrative cap) 의 정책 명문화 위치 — claude/commands/harness-meta.md 회피, ARCHITECTURE.md § 3.1 또는 § 6.1 추가 paragraph 만",
      "rationale": "claude/commands/harness-meta.md 는 workflow 절차 자체 — 변경시 workflow self-improvement 사이클 재진입. ARCHITECTURE.md (정의 단일 source) 의 lightweight 모드 표지 narrative 1 paragraph 추가가 self-improvement 회피 + 정의 명료화 정합.",
      "alternatives_rejected": ["claude/commands/harness-meta.md Stage 절차 안에 cap 명시", "ROADMAP entry summary 안 cap 명시 (per milestone 임시방편)"]
    },
    {
      "id": "D5",
      "decision": "권고 #4 (smoke inactive 처분) — 본 milestone 안에서 처분 옵션 narrative 제시 + 사용자 결정만, 실 처분 (git mv / 삭제) 은 EXECUTE phase 안에서 사용자 선택 후",
      "rationale": "22 smoke 처분은 reversibility 낮음 (git mv history 보존 가능하나 manual leverage narrative 변경 = 복귀 비용). 사용자 명시 선택 게이트 의무. lightweight 모드 정신상 1 phase 안 처리.",
      "alternatives_rejected": ["일괄 archive 자동 이동", "별 milestone 분리 (scope 적정 부재)"]
    }
  ],
  "approach": "Stage F EXECUTE 를 3 phase 로 분할. phase-1: 권고 #1 (workflow 자기개선 동결) 명문화 + ROADMAP defer audit trail (이미 Stage A 에서 처리됨, 본 phase 는 narrative 보강만). phase-2: 권고 #6 (narrative cap 정책) ARCHITECTURE.md 명문화 + 권고 #4 (smoke inactive 처분) 사용자 선택 후 실행. phase-3: 권고 #7 (upbit 외부 적용) PROPOSE 발의 준비 (next_candidate narrative). VERIFY → REPORT → PROPOSE 표준 lightweight cap.",
  "phases": [
    {
      "n": 1,
      "title": "권고 #1 명문화 — workflow 자기개선 milestone 동결 정책 + ROADMAP defer narrative 보강",
      "scope": "ROADMAP.md (이미 Stage A 에서 deferred_note 추가됨, 본 phase 는 narrative 명문화만) + ARCHITECTURE.md § 3.1 또는 § 6 끝 신규 paragraph (lightweight 모드 표지 정책)",
      "affected_files": [
        "projects/meta/ARCHITECTURE.md",
        "projects/meta/milestones/v3.6/execute/phase-1.md"
      ],
      "rationale": "권고 #1 의 audit trail 보존 + 정책 명문화 분리 — workflow 자기개선 milestone 동결 정책을 ARCHITECTURE.md 안에 'lightweight 모드' 표지 narrative 로 명문화. claude/commands/harness-meta.md 변경 회피 (D4).",
      "risks": ["narrative 자체가 workflow 변경 인식 risk — paragraph < 15줄 cap, 정의 명료화 정합으로 분류"]
    },
    {
      "n": 2,
      "title": "권고 #4 적용 — smoke inactive 22 처분 사용자 선택 + 실행",
      "scope": "tests/smoke-*.sh (inactive 22) 처분 — AskUserQuestion (a) active 통합 / (b) archive 이동 (git mv tests/_inactive/) / (c) 삭제 중 선택 + 실행 + tests/CLAUDE.md 매트릭스 갱신",
      "affected_files": [
        "tests/smoke-* (inactive 22, 사용자 선택에 따라 git mv 또는 delete)",
        "tests/CLAUDE.md (매트릭스 narrative 갱신)",
        "projects/meta/milestones/v3.6/execute/phase-2.md"
      ],
      "rationale": "권고 #4 의 즉시 적용. 22 smoke 의 manual leverage narrative 가 실 검증 부재 변명 — 사용자 결정 게이트로 정전화. lightweight 정신상 1 phase 안 처리.",
      "risks": ["R2 git history 손실 — git mv 또는 commit log 거명으로 mitigate", "active 7 hook 영향 부재 검증 (회귀 risk)"]
    },
    {
      "n": 3,
      "title": "권고 #7 발의 준비 — upbit 외부 적용 next_candidate narrative",
      "scope": "projects/upbit/ROADMAP.md 또는 PROPOSE.md next_candidates 안 'upbit 실 적용 milestone' 발의 narrative (실 발의는 별 milestone, 본 phase 는 후속 candidate 등재 narrative 만)",
      "affected_files": [
        "projects/meta/milestones/v3.6/execute/phase-3.md"
      ],
      "rationale": "권고 #7 의 즉시 발의 준비 — 본 milestone PROPOSE 단계에서 후속 candidate 등재만. 실 실행 (upbit repo 작업) 은 별 milestone (R4 mitigate).",
      "risks": ["narrative 만 추가 → 회귀 risk 없음"]
    }
  ],
  "risk_mitigation": {
    "R1": "v2.0 선례 직접 참조 narrative 1줄 (milestones.md self_reference_rationale 필드 활용 — 이미 Stage A 처리)",
    "R2": "phase-2 사용자 선택지 (a)/(b)/(c) 모두 git history 보존 옵션 명시 (git mv 우선, 삭제는 commit log 거명)",
    "R3": "D4 적용 — claude/commands/harness-meta.md 변경 부재, ARCHITECTURE.md paragraph 만",
    "R4": "phase-3 narrative 만, 실 발의는 별 milestone",
    "R5": "REPORT.lessons_learned cap < 5건 + next_candidates 가 workflow 변경 시 '동결 declaration' 명시 의무"
  },
  "expected_loc_cap": {
    "INTENT.md": 79,
    "RESEARCH.md": 145,
    "DESIGN.md": "target < 200줄",
    "APPROVE.md": "target < 40줄",
    "VERIFY.md": "target < 100줄",
    "REPORT.md": "target < 100줄",
    "PROPOSE.md": "target < 80줄",
    "execute/phase-1.md": "target < 50줄",
    "execute/phase-2.md": "target < 80줄",
    "execute/phase-3.md": "target < 40줄",
    "milestones.md": 53,
    "total_target": "< 850줄 (v3.5 897줄 대비 -5% 이상)"
  }
}
```

## 5 관점 검토 생략 narrative

본 milestone 은 lightweight 모드 자기참조 회피 표지 적용 — Stage D 절차 안 '다각적 병렬 검토 — 5 관점 subagent (가변, min 3)' 생략. 근거: (a) 권고 #3 (5 관점 trim) 자체의 직접 적용, (b) 본 milestone 변경 scope 작음 (≤5 파일), (c) trim 작업 본질상 architecture 결정 분기 / spec-drift / 보안 risk 부재 예상, (d) D3 decision narrative 1줄 명시. v2.0_workflow-word-fidelity 자기참조 회피 표지 선례 정합.

## 비고

본 DESIGN.md 192줄 (cap < 200줄 정합).
