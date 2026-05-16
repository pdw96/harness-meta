# RESEARCH — v5.7 spec-drift-spike-pattern-canonicalization

```json
{
  "external": [
    {
      "source": "projects/meta/milestones/v4.2/DESIGN.md L196 (spec-drift agent verdict)",
      "topic": "context7 standard pattern 정정 사례",
      "findings": "v4.2 RESEARCH 단계 = 'audit/AGENT.md 디렉토리 컴포넌트' 추정 (sub-agents docs context7 검증 부족) → v4.2 DESIGN 5 관점 spec-drift agent verdict 안 정정 권고 ('거주 위치 standalone .md 파일 권장 (context7 standard pattern) → D2 정정 흡수') → DESIGN.decisions D2 hardcode = 'standalone .md 파일 단일 형식' (v4.2 DESIGN.md L134).",
      "drift": "본 milestone 정전화 대상 패턴의 첫 origin 사례 — RESEARCH 추정 → DESIGN spec-drift 검토 안 정정 → DESIGN.decisions hardcode (Stage F EXECUTE 전 정정 cycle)."
    },
    {
      "source": "projects/meta/milestones/v5.6/RESEARCH.md L122 + L134 (R7 risk) + DESIGN.md L84 (D10 decision)",
      "topic": "settings.json plugin enabled key spike 사례",
      "findings": "v5.6 RESEARCH R7 = 'JSON schema 안 enabled/isEnabled/status 등 추정, Stage F EXECUTE 시 실 호출 결과 spike 필요. 추정 = enabled (boolean) but Stage D 안 spike 검증 + DESIGN.decisions 안 명시' → v5.6 DESIGN.D10 = 'JSON key 이름 추정 = enabled (boolean), Stage F EXECUTE 시 실 spike 검증 의무. R7 mitigation.' → v5.6 phase-1 안 spike 검증 + hardcode 완료.",
      "drift": "본 milestone 정전화 대상 패턴의 두 번째 origin 사례 — RESEARCH 추정 → DESIGN 안 spike 의무 화 → Stage F EXECUTE 안 실 spike + hardcode (Stage F EXECUTE 안 정정 cycle, v4.2 와 정정 시점 분리)."
    },
    {
      "source": "projects/meta/milestones/_archive/v3.21/DESIGN.md (3 단계 패턴 정전화 source)",
      "topic": "narrative 정전화 3 단계 패턴 (DESIGN 1차 source + EXECUTE Edit + VERIFY grep)",
      "findings": "v3.21 안 narrative 정전화 3 단계 = (a) DESIGN 안 정확 문구 1차 source (markdown code block) / (b) phase-1 EXECUTE 안 Edit tool 정확 문구 그대로 삽입 / (c) VERIFY 안 grep 검증 키워드. 본 milestone 도그푸드 적용.",
      "drift": "spec 명시 — 본 milestone 패턴 정전화 도구 (도그푸드)."
    },
    {
      "source": "projects/meta/milestones/v4.0/REPORT.md (§ 6.2 폐지 narrative source)",
      "topic": "§ 6.2 폐지 (v4.0) + 새 정체성 (project harness composer + ecosystem integrator)",
      "findings": "v4.0 phase-1 안 § 6.2 (workflow self-improvement 동결 정책) 폐지 — 새 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 안 spec 정합 = ecosystem integrator 정체성 직접 부합. spec-drift 가드레일 narrative 정전화 = ecosystem integrator 정체성 정합 (context7 spec 정합 = ecosystem 정합).",
      "drift": "§ 6.2 폐지 정합 검증 — 본 milestone narrative 안 § 6.2 거론 부재 의무 (sc_6, INTENT.success_criteria)."
    }
  ],
  "codebase": {
    "affected_files_estimated": [
      "projects/meta/ARCHITECTURE.md — 정전화 host 후보 1 (Option A/D)",
      "claude/commands/harness-meta.md — 정전화 host 후보 2 (Option B/C/D, Stage C 또는 D 안 narrative 추가)",
      "projects/meta/milestones/v5.7/milestones.md — sub_milestones 1:1 동기 갱신 (Stage D 후 의무)",
      "projects/meta/milestones/v5.7/execute/phase-{n}.md — Stage F 산출"
    ],
    "untouched_files_explicit": [
      "CLAUDE.md (root) — 본 milestone scope 외 (단일 source 정합)",
      "tests/ — smoke 추가 부재 (narrative 정전화 milestone, smoke 의무 부재)",
      "agents/ — agent 변경 부재",
      "skills/ — skill 변경 부재",
      "bootstrap/ — 변경 부재",
      "claude/hooks/ — hook 변경 부재"
    ],
    "current_state": "v4.2 DESIGN.spec-drift verdict + v5.6 DESIGN.D10 안 spec-drift spike 패턴 자연 발현 누적 2건 — narrative 정전화 부재. 향후 milestone 안 자연 도구화 부재 (각 milestone 별 spec-drift 검토 의존).",
    "target_state": "정전화 narrative 1건 (host 1곳, DESIGN 단계 결정) 안 3 단계 명시 — (a) context7 source 추정 (RESEARCH) → (b) Stage F EXECUTE 안 실 spike + DESIGN.decisions hardcode → (c) VERIFY grep 또는 5 관점 spec-drift 검토 시 자연 적용. v4.2 + v5.6 두 origin 사례 정량 cross-ref 포함."
  },
  "options": [
    {
      "option": "Option A — ARCHITECTURE.md § 6.X 신규 sub-section",
      "pros": [
        "단일 source 강제 (v3.18 + v3.20 + v3.21 narrative 정전화 패턴 정합)",
        "ARCHITECTURE.md = 정전 single source 약속 — 패턴 narrative 정전화 의 자연 host",
        "cross-ref host 추가 zero (v3.20 D1 단일 source 패턴 정합)"
      ],
      "cons": [
        "harness-meta.md Stage C/D 안 운영 narrative cross-ref 부재 시 운영자 자연 도구화 부족 (단일 source 패턴은 자연성 약함)"
      ]
    },
    {
      "option": "Option B — harness-meta.md Stage C (RESEARCH) 안 spec-drift spike 의무 step 추가",
      "pros": [
        "Stage C RESEARCH 단계 자연 적용 (운영자 자연 도구화)",
        "v3.10 부산물 정책 정합 (Stage C 안 spec 검증 단계화)"
      ],
      "cons": [
        "Stage C 안 본문 절차 변경 = INTENT.out_of_scope #5 (절차 자체 무변경) 위배 risk",
        "ARCHITECTURE.md 정전 single source 분산 — drift 위험"
      ]
    },
    {
      "option": "Option C — harness-meta.md Stage D (DESIGN) 안 5 관점 spec-drift agent 검토 결과 hardcode 의무 step 추가",
      "pros": [
        "Stage D 5 관점 검토 단계 자연 적용 (이미 spec-drift agent 존재)",
        "v4.2 + v5.6 두 origin 사례 모두 Stage D 안 spec-drift agent 권고 안 정정 cycle"
      ],
      "cons": [
        "Stage D 안 본문 절차 변경 = INTENT.out_of_scope #5 위배 risk",
        "ARCHITECTURE.md 정전 single source 분산 — drift 위험"
      ]
    },
    {
      "option": "Option D — Option A (ARCHITECTURE 정전화) + harness-meta.md Stage C/D 안 cross-ref 1줄",
      "pros": [
        "ARCHITECTURE = 정전 single source 강제 (Option A 장점 보존)",
        "harness-meta.md 안 cross-ref 1줄 = 운영자 자연 도구화 보강 (Option B/C 장점 부분 흡수)",
        "v3.18 + v3.20 + v3.21 narrative 정전화 패턴 일부 변형 (단일 source + cross-ref 1줄, v1.4_cross-ref-propagation 패턴 정합)"
      ],
      "cons": [
        "cross-ref 1줄 추가 = host 2곳 — drift 위험 (cross-ref 위치 stale)",
        "lightweight LOC ~500 line 권고 cap 안 cross-ref 추가 분 흡수"
      ]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "risk": "§ 6.2 폐지 정합 — workflow self-improvement 본질 검증 필요 (v4.0 도입 새 정체성 부합 검증)",
      "severity": "low",
      "mitigation_hint": "DESIGN 안 § 6.2 폐지 narrative + 새 정체성 (ecosystem integrator = context7 spec 정합) 부합 검증 paragraph. sc_6 검증 (본 milestone narrative 안 § 6.2 거론 부재)."
    },
    {
      "id": "R2",
      "risk": "도그푸드 모순 — 본 milestone 은 narrative 정전화 milestone 으로 외부 spec 추정 자체 부재, 정전화 대상 패턴 적용 사례 부재 표지",
      "severity": "low",
      "mitigation_hint": "REPORT lessons 안 도그푸드 모순 표지 narrative. 본 milestone 자체 = v3.21 narrative 정전화 3 단계 패턴 적용 도그푸드 (다른 종류 도그푸드)."
    },
    {
      "id": "R3",
      "risk": "정전화 host 위치 — ARCHITECTURE vs harness-meta.md 단일 source 충돌",
      "severity": "medium",
      "mitigation_hint": "DESIGN 단계 4 관점 검토 + 사용자 명시 결정 게이트 (Option A/B/C/D 중 선택)."
    },
    {
      "id": "R4",
      "risk": "정전화 narrative LOC — lightweight 모드 default LOC ~500 line 정합 추정",
      "severity": "low",
      "mitigation_hint": "DESIGN 안 정확 문구 LOC ~300~500 line 추정 (정전화 paragraph + 2 origin cross-ref + 3 단계 narrative)."
    },
    {
      "id": "R5",
      "risk": "VERIFY grep 키워드 — 정전화 narrative 안 3 단계 (RESEARCH 추정 + Stage F spike + DESIGN hardcode) 정확 키워드 추출 필요",
      "severity": "low",
      "mitigation_hint": "DESIGN 안 narrative 안 3 단계 명시 어휘 (e.g., 'spec-drift spike', 'RESEARCH 추정', 'Stage F spike', 'DESIGN hardcode') 자연 grep 키워드."
    },
    {
      "id": "R6",
      "risk": "spec-drift 위험 항목 정의 미모호 — '외부 spec 추정 진행' 판단 기준 미명시 시 자연 도구화 약화",
      "severity": "low",
      "mitigation_hint": "DESIGN 안 정전화 narrative 끝 'spec-drift 위험 항목 = context7 source 안 정확 spec 명시 부재 / narrative 표현 추정' 정의 1줄 (4.2 + 5.6 두 사례 정량 evidence)."
    }
  ]
}
```

## narrative

v4.2 + v5.6 두 origin 사례 정량 검증 결과 — spec-drift spike 패턴 자연 발현 누적 2건 확인. 본 milestone 정전화 대상 패턴 = (a) RESEARCH 단계 context7 source 안 정확 spec 명시 부재 / 추정 진행 → (b) Stage D DESIGN 5 관점 spec-drift agent 검토 안 추정 risk 식별 → (c) Stage F EXECUTE 안 실 spike (실 호출 / 실 spec 검증) 또는 DESIGN 안 즉시 정정 → (d) DESIGN.decisions 안 hardcode (string literal / 정확 spec 값 명시).

v4.2 사례 = (a) → (b) → DESIGN 안 즉시 정정 → (d) (Stage F 전 정정 cycle).
v5.6 사례 = (a) → (b) → (c) Stage F EXECUTE 안 spike → (d) (Stage F 안 정정 cycle).

두 정정 시점 (DESIGN 즉시 vs Stage F spike) 차이는 spec 명시 부재 정도에 따라 자연 분기 — 본 milestone narrative 정전화 시 양쪽 cycle 모두 포함.

decision (host 위치 / 정확 문구 / cross-ref 정책) 은 Stage D DESIGN 단계 4 관점 검토 + 사용자 명시 결정 후 확정.
