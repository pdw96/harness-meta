# DESIGN — v5.20 audit-cycle-7-and-section-4-matrix-and-namespace-prefix-cascade

```json
{
  "id": "v5.20",
  "decisions": [
    {
      "id": "D1",
      "decision": "옵션 O2 (2-phase 분리) 선택 — phase-1 audit chain 호출 + 4 산출물 + phase-2 ARCHITECTURE § 4 끝 stability cycle pattern paragraph 정전화 + diff-vs-cycle6 + vector count 갱신",
      "rationale": "v5.19 cycle 6 패턴 정합 (2-phase 2 commit). phase-1 결과 안정 확인 후 phase-2 정전화 = narrative 본문 정확화. stability 본질 = baseline 동일 검증을 phase-1 결과로 확인 후 phase-2에서 정전화. cycle 7 hallucination 재발 또는 untracked 추가 발견 시 narrative 본문 수정 여지 보존.",
      "alternatives_rejected": ["O1 1-phase 통합 (phase-1 결과가 narrative 본문에 영향 시 commit 재작성 risk)", "O3 3-phase (lightweight 정책 이탈 누적)"]
    },
    {
      "id": "D2",
      "decision": "v5.13 3-layer fact 검증 절차 다섯 번째 실전 적용 + v5.18 Input Verification H2 + 검증 method 분리 narrative 두 번째 실전 적용 — hallucination 발견 시 inline 정정 + audit trail 보존",
      "rationale": "cycle 6 hallucination 0건 (v5.18 첫 실전 효과) baseline. cycle 7 = 동일 baseline = 0건 예상. 재발 시 evidence isolation 가능 (narrative 효과 단일 검증). 4 멤버 agent .md `## Input Verification` H2 sub-section 안 Read tool 보유/부재 분기 narrative 두 번째 실전.",
      "alternatives_rejected": ["검증 절차 생략 (cycle 6 실전 흐름 break, 절차 안정성 evidence 누락)"]
    },
    {
      "id": "D3",
      "decision": "v5.16 lint precheck 절차 세 번째 실전 적용 — MD022/MD031/MD032 hardcode 3 rule + 추가 발현 (MD028/MD034/MD038) inline 정정",
      "rationale": "cycle 5 = MD038 1건 / cycle 6 = MD034 11건 발현 누적. hardcode 외 rule 발현 추세 evidence cycle 7+에서 추가 확보. v5.19 PROPOSE#3 (`audit-output-markdown-lint-rule-expansion-md028-md034-md038`) carry-over trigger 누적 (cycle 7 발현 시 4 rule 확장 candidate evidence).",
      "alternatives_rejected": ["lint precheck 생략 (v5.16 도그푸드 break)"]
    },
    {
      "id": "D4",
      "decision": "ARCHITECTURE § 4 끝 'audit-apply-audit stability cycle pattern' paragraph 정전화 (v3.21 narrative 정전화 3 단계 패턴 — (a) DESIGN 1차 source + (b) EXECUTE Edit + (c) VERIFY grep)",
      "rationale": "v5.19 PROPOSE#4 trigger 조건 'cycle 7+ 3 cycle 연속 stability 누적' 자연 충족. paragraph 본문 = stability cycle 정의 + evidence (cycle 5+6+7 baseline 동일 + R1+R2 3 cycle 연속 APPLIED + 신규 gap 0건) + 1차 source cross-ref (cycle 6/7 diff). 본 paragraph 신규 → § 4 끝 paragraph 누적 6 → 7 → v5.19 PROPOSE#8 매트릭스화 trigger 조건 자연 충족 (out_of_scope #4 정합, v5.21+ candidate).",
      "alternatives_rejected": ["paragraph 정전화 생략 = trigger 충족 path 회피 (사용자 결정 cycle 7 강행 + 정전화 scope 축소와 모순)", "§ 3.1 끝 anchor (R6 self-loop baseline 위치, scope 외 v5.18 PROPOSE#5 carry-over)"]
    },
    {
      "id": "D5",
      "decision": "vector count 6→7 갱신 (ARCHITECTURE.md L135 narrative cascade drift 검증 의무 paragraph 안 + 산출물 cross-ref 안 본 v5.20 seventh 추가)",
      "rationale": "audit-team 외부 호출 누적 정확 정량 = v1.17 (first) + v5.10 (second) + v5.14 (third) + v5.15 (fourth) + v5.17 (fifth) + v5.19 (sixth) + 본 v5.20 (seventh) = 7건. v5.10 정전화 패턴 정합 (v5.14·v5.15·v5.17·v5.19 모두 동일 갱신).",
      "alternatives_rejected": ["vector count 갱신 생략 (cascade drift 의무 위배)"]
    },
    {
      "id": "D6",
      "decision": "self-loop counting = 20/26 ≈ 76.9% (외부 vector 1건 추가 + self-loop 1건 추가) — v5.19 baseline 19/25 = 76% 기준",
      "rationale": "본 v5.20 = 외부 audit-team 호출 (vector 1건 추가) + self-loop 운용 (stability paragraph 정전화 도그푸드 = self-loop 1건 추가). 분자 +1 + 분모 +2 = 20/26. monotonic 감소 추세 break 없이 ~77% 자연 유지 (numerator self-loop 비중 회복). 단 분류 기준 narrative 부재 = v5.18 PROPOSE#7 carry-over (out_of_scope, v5.21+ candidate).",
      "alternatives_rejected": ["19+1/25+1 (단순 추가만, 분자 self-loop 매핑 불명확)"]
    },
    {
      "id": "D7",
      "decision": "lightweight 모드 누적 15/33 = 45.5% (43.75% → 45.5%, 45% 첫 돌파) 갱신 — REPORT lessons 안 capture",
      "rationale": "본 v5.20 = 2-phase 2 commit lightweight 정합 (v5.19 cycle 6 패턴 정합). 누적 lightweight cycle counter v5.7~v5.19 = 14 cycle → 본 v5.20 = 15 cycle. 분모 = 본 milestone 완료 후 누적 milestone 수 (v4.0~v5.20 = 33 milestone).",
      "alternatives_rejected": ["lightweight 카운팅 생략 (v5.19 PROPOSE summary 패턴 break)"]
    },
    {
      "id": "D8",
      "decision": "§ 4 끝 매트릭스화 = in_scope phase-3 (scenario B 채택, 의문 round 2 사용자 결정) — paragraph 7건 (v3.10 + v3.20 + v5.9 + v5.10 + v5.11/v5.18 + v5.16 + 본 v5.20 stability) 표 변환 + cross-ref 매핑 통합 처리",
      "rationale": "v5.19 PROPOSE#8 trigger 조건 '§ 4 끝 6건+ 누적' 자연 충족 + scenario B 사용자 결정 = bundling 정합 (같은 의미 단위 = audit-team 운용 evidence + § 4 끝 narrative). lightweight 이탈 (3-phase) 정당화 = v3.0+ bundling 키워드. 1차 발의 (cycle 7 단일) → 2 issue 통합 흡수 (paragraph 정전화 + 매트릭스화 + namespace cascade) = 3 milestone 분리 회피 + 의미 단위 통합.",
      "alternatives_rejected": ["매트릭스화 v5.21+ deferred (1차 의문 round 1 결정, 의문 round 2 사용자 scenario B 결정으로 폐기)", "scope 축소 cycle 7 + stability paragraph만 (의문 round 2 scenario A, 사용자 scenario B 채택)"]
    },
    {
      "id": "D9",
      "decision": "audit chain 산출물 위치 = `projects/upbit/audit-2026-05-19-cycle7/` (디렉토리명에 cycle 7 명시)",
      "rationale": "v5.19 cycle 6 디렉토리 = `audit-2026-05-19-cycle6/` 동일 날짜 (2026-05-19) 사용 정합. cycle 분리 위해 -cycle7 suffix. 5 산출물 = scanner-output / analyzer-output / mapper-output / proposal-draft + diff-vs-cycle6. **동일 날짜 cycle 누적 첫 사례** (cycle 6+7 모두 2026-05-19) — 선례 정합 = v5.14/v5.15/v5.17 = 2026-05-18 안 cycle 3/4/5 3 cycle 누적 (분리 valid 검증).",
      "alternatives_rejected": ["날짜 변경 (현재 2026-05-19 자연 일치, 인위적 날짜 변경 회피)"]
    },
    {
      "id": "D10",
      "decision": "INTENT/RESEARCH/DESIGN/APPROVE.md 4건 commit 시점 = Stage G (VERIFY) commit 안 포함 (기본값 b, v3.1 L6 정합)",
      "rationale": "VERIFY 전 산출물 영구 보존 보장. 별도 chore commit 회피 (lightweight 정합). phase-1 (audit chain 호출 + 5 산출물) + phase-2 (ARCHITECTURE 갱신) + Stage G chore (산출물 + milestones.md 갱신) = 2+1 commit 패턴 (v5.19 정합).",
      "alternatives_rejected": ["(a) phase-1 commit 포함 (phase-1 scope 비대화)", "(c) 별도 chore 분리 (3 commit 누적, lightweight 이탈)"]
    },
    {
      "id": "D11",
      "decision": "Agent subagent_type = `harness-meta:<member-name>` Plugin namespace prefix 표기 유지 (v5.19 phase-1 실 실행 evidence 정합)",
      "rationale": "spec-drift 검토 round 안 D1 (decisive) — subagent_type prefix 정합성 의문 → v5.19 phase-1.md L17~L20 (commit 8b905b5) 실 실행 + cycle 6 stability 첫 완성 + hallucination 0건 evidence = 실 작동 확인. 본 사용자 환경 agent list 안 `harness-meta:project-scanner` 등 prefix 포함 = Plugin spec v5.0+ namespace prefix 정상 표기 (Claude Code Plugin 배포 spec). `agents/*.md` 안 prefix 부재 narrative (`subagent_type=\"environment-auditor\"`) 는 v4.x SymbolicLink 시대 잔재 — Plugin 도입 후 prefix 자동 결합. v5.20 cycle 7 = prefix 유지 + spec-drift round 결과 narrative 표지.",
      "alternatives_rejected": ["prefix 제거 (v5.19 실 실행 evidence 무시 + 자기참조 회귀)", "agents/*.md narrative 일괄 갱신 (out_of_scope — v5.21+ candidate)"]
    },
    {
      "id": "D12",
      "decision": "Stage G VERIFY 안 `grep -c '\"audit-apply-audit stability cycle pattern\"' projects/meta/ARCHITECTURE.md` = 1건 검증 의무 (v3.21 c step 적용)",
      "rationale": "회귀 risk 검토 round 안 R4 (decisive) — § 4 끝 paragraph 6→7 매트릭스화 trigger 충족 조건부 — grep -c 검증 통과 시 매트릭스화 trigger out_of_scope 정합 + 회귀 0건 확인. 단 D8 scope 확장 후 매트릭스화 phase-3 in-scope = paragraph 안 → 표 안 cell 변환. grep keyword exact string 유지 (표 cell 안에서도 검출 가능). v5.19 cycle 6 c step 패턴 정합. verify_grep_keyword = exact string `\"audit-apply-audit stability cycle pattern\"` (architecture P2 권고 흡수).",
      "alternatives_rejected": ["grep 생략 (v3.21 c step 패턴 break + R4 회귀 risk 미해소)"]
    },
    {
      "id": "D13",
      "decision": "phase-3 = § 4 끝 7 paragraph 매트릭스화 — 6 paragraph (v3.10/v3.20/v5.9/v5.10/v5.11+v5.18/v5.16) + 1 신규 paragraph (v5.20 stability) 표 안 통합 + cross-ref 매핑 narrative 유지",
      "rationale": "scenario B 채택 (의문 round 2). v5.19 PROPOSE#8 trigger 조건 자연 충족 + scope 확장 결정. 표 형식 — | # | 정전화 milestone | 본질 (drift/cascade/fact/lint/stability) | 1차 source | 검증 method | (5 열 7 행). paragraph 본문 narrative는 표 cell 안 요약 (full narrative는 cross-ref 1차 source 파일로 위임). § 4 끝 raw paragraph 6+1 → table 1건으로 정전화 — 정의 가독성 + 누적 흐름 명시.",
      "alternatives_rejected": ["paragraph 추가만 (D4 scope, scenario A) — scope 축소", "paragraph 전체 inline 통합 (full text 표 안) = scope 비대화 + 본문 가독성 break"]
    },
    {
      "id": "D14",
      "decision": "phase-3 = agent namespace prefix cascade 7 위치 정합 — claude/commands/harness-meta.md 5 (L75~L78 + L83) + agents/agents-md-sync.md L122 + agents/environment-auditor.md L155 narrative 안 `subagent_type=\"<name>\"` → `subagent_type=\"harness-meta:<name>\"` 교체",
      "rationale": "spec-drift D1 (decisive) 해소 cascade. 본 사용자 환경 agent list 안 `harness-meta:<name>` prefix 포함 = Plugin spec v5.0+ namespace 정상 표기 확인. v5.0+ Plugin 도입 후 agent .md narrative 갱신 누락 (v4.x SymbolicLink era 잔재). D11 = call-site cycle 7 호출 prefix 유지 결정 (실 evidence) + D14 = narrative 안 prefix 부재 7 위치 cascade. agent .md `## Input Verification` H2 sub-section 본문 prefix 부재 narrative 갱신은 out_of_scope (v5.18 narrative 정전화 후 변경 부재, 본 phase-3 = call-site cascade 단일 책임).",
      "alternatives_rejected": ["prefix 부재 narrative 유지 (spec-drift D1 미해소, 자기참조 cascade 누적)", "agents/<멤버>.md `## Input Verification` 안 prefix 추가 (out_of_scope, v5.18 narrative 변경 회피)"]
    },
    {
      "id": "D15",
      "decision": "scenario B 채택 narrative — lightweight 이탈 (3-phase 3 commit + chore) 정당화 = v3.0+ bundling 키워드. REPORT.lessons 안 정전화 (sc_12)",
      "rationale": "1차 발의 (cycle 7 stability paragraph 정전화 단일) → 의문 round 1 (upbit commit 부재) → 의문 round 2 (3 이슈 통합 시나리오 B 사용자 결정) = scope 확장 자연 발현. v3.0+ bundling 키워드 = 같은 의미 단위 통합 (audit-team 운용 evidence + § 4 끝 narrative 정전화/매트릭스화 + Plugin spec namespace). 3 milestone 분리 회피 (v5.20 + v5.21 + v5.22) = 메타 milestone 비대화 회피.",
      "alternatives_rejected": ["3 milestone 분리 (lightweight 정합 강), 그러나 메타 milestone 누적 비대화", "1 milestone (scenario A) — paragraph 정전화 + cycle 7만 (의문 round 2 사용자 폐기)"]
    }
  ],
  "approach": "본 milestone 은 v5.19 cycle 6 패턴을 정확 정합한 2-phase 2 commit + chore 구조로 진행. phase-1 = audit-team 4 멤버 read-only 호출 (Task tool 또는 Agent tool subagent_type 인자 활용) + 4 산출물 생성 + v5.13 fact 검증 + v5.16 lint precheck + v5.18 Input Verification 두 번째 실전. phase-2 = diff-vs-cycle6 생성 + ARCHITECTURE § 4 끝 'audit-apply-audit stability cycle pattern' paragraph 정전화 + L135 vector count 6→7 갱신. Stage G commit = INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE 7 산출물 + milestones.md 1:1 갱신 + ROADMAP completed 갱신.",
  "phases": [
    {
      "n": 1,
      "title": "audit chain 4 멤버 호출 + 4 산출물 + fact 검증 + lint precheck",
      "scope": [
        "Agent(subagent_type='harness-meta:project-scanner') 호출 — upbit 대상 read-only scan",
        "Agent(subagent_type='harness-meta:harness-gap-analyzer') 호출 — scanner-output.md 결과 입력",
        "Agent(subagent_type='harness-meta:claude-docs-mapper') 호출 — analyzer-output.md 입력 (D10 우회 패턴: orchestrator inline 첨부 본문 인용)",
        "Agent(subagent_type='harness-meta:component-proposer') 호출 — mapper-output.md 입력 (D10 우회 패턴)",
        "4 산출물 fact 검증 (v5.13 3-layer 다섯 번째 실전) — boolean/표/수치 별 매핑 method (v5.18 두 번째 실전)",
        "4 산출물 lint precheck (v5.16 세 번째 실전) — MD022/MD031/MD032 hardcode + 추가 발현 inline 정정",
        "산출물 commit = `feat(meta): v5.20 phase-1 — audit cycle 7 호출 + 4 산출물 + fact 검증 다섯 번째 + lint precheck 세 번째 실전`"
      ],
      "affected_files": [
        "projects/upbit/audit-2026-05-19-cycle7/scanner-output.md (신규)",
        "projects/upbit/audit-2026-05-19-cycle7/analyzer-output.md (신규)",
        "projects/upbit/audit-2026-05-19-cycle7/mapper-output.md (신규)",
        "projects/upbit/audit-2026-05-19-cycle7/proposal-draft.md (신규)",
        "projects/meta/milestones/v5.20/execute/phase-1.md (신규)"
      ],
      "rationale": "audit chain 호출 결과 안정 확인 후 phase-2 정전화 narrative 본문 정확화. cycle 7 결과 stability 본질 (cycle 5+6+7 동일 baseline = 동일 결과) evidence 확보.",
      "risks": ["R1 (hallucination 재발)", "R3 (MD028/MD034/MD038 lint 위반 재발)"]
    },
    {
      "n": 2,
      "title": "diff-vs-cycle6 + ARCHITECTURE § 4 끝 stability cycle pattern paragraph 정전화 + L135 vector count 6→7 갱신",
      "scope": [
        "projects/upbit/audit-2026-05-19-cycle7/diff-vs-cycle6.md 생성 — cycle 6 → cycle 7 stability cycle delta (3 cycle 연속 evidence) [sc_2 + sc_6]",
        "projects/meta/ARCHITECTURE.md § 4 끝 'audit-apply-audit stability cycle pattern' paragraph 신규 추가 (L139 다음) [sc_7]",
        "projects/meta/ARCHITECTURE.md L135 vector count 6건 → 7건 갱신 + 본 v5.20 seventh 추가 [sc_8]",
        "산출물 commit = `feat(meta): v5.20 phase-2 — diff-vs-cycle6 + ARCHITECTURE § 4 끝 stability cycle pattern paragraph 정전화 + vector count 6→7`"
      ],
      "affected_files": [
        "projects/upbit/audit-2026-05-19-cycle7/diff-vs-cycle6.md (신규)",
        "projects/meta/ARCHITECTURE.md (수정 — § 4 끝 paragraph 신규 + L135 갱신)",
        "projects/meta/milestones/v5.20/execute/phase-2.md (신규)"
      ],
      "rationale": "phase-1 audit chain 결과 안정 확인 후 stability cycle pattern paragraph 정전화. v3.21 narrative 정전화 3 단계 패턴 적용 — (a) DESIGN 1차 source (본 D4) + (b) phase-2 Edit + (c) VERIFY grep. Edit 순서 = paragraph 신규 추가 먼저 / L135 vector count 갱신 두 번째 (architecture P3 권고).",
      "risks": ["R2 (stability 본질 evidence 실패)", "R5 (vector count cascade drift)"]
    },
    {
      "n": 3,
      "title": "§ 4 끝 7 paragraph 매트릭스화 (표 변환 + cross-ref) + agent namespace prefix cascade 7 위치 (claude/commands/harness-meta.md 5 + agents-md-sync.md 1 + environment-auditor.md 1)",
      "scope": [
        "projects/meta/ARCHITECTURE.md § 4 끝 7 paragraph (v3.10 / v3.20 / v5.9 / v5.10 / v5.11+v5.18 / v5.16 / 본 v5.20 stability) 표 변환 — 5열 7행 매트릭스 (# / 정전화 milestone / 본질 / 1차 source / 검증 method) + cross-ref 매핑 [sc_14]",
        "claude/commands/harness-meta.md L75~L78 + L83 안 5건 `subagent_type=\"<name>\"` → `subagent_type=\"harness-meta:<name>\"` 교체 [sc_15 cascade 1/3]",
        "agents/agents-md-sync.md L122 안 `subagent_type=\"agents-md-sync\"` → `subagent_type=\"harness-meta:agents-md-sync\"` [sc_15 cascade 2/3]",
        "agents/environment-auditor.md L155 안 `subagent_type=\"environment-auditor\"` → `subagent_type=\"harness-meta:environment-auditor\"` [sc_15 cascade 3/3]",
        "산출물 commit = `feat(meta): v5.20 phase-3 — § 4 끝 7 paragraph 매트릭스화 + agent namespace prefix cascade 7 위치 (Plugin spec v5.0+)`"
      ],
      "affected_files": [
        "projects/meta/ARCHITECTURE.md (수정 — § 4 끝 6+1 paragraph → 표 변환)",
        "claude/commands/harness-meta.md (수정 — 5건 prefix 추가)",
        "agents/agents-md-sync.md (수정 — L122 prefix)",
        "agents/environment-auditor.md (수정 — L155 prefix)",
        "projects/meta/milestones/v5.20/execute/phase-3.md (신규)"
      ],
      "rationale": "v5.19 PROPOSE#8 매트릭스화 trigger 충족 + spec-drift D1 cascade. v3.21 narrative 정전화 3 단계 22번째 cycle 도그푸드 (paragraph 21번째 + 매트릭스화 22번째 동시). bundling 정합.",
      "risks": ["R4 (매트릭스화 표 변환 narrative drift)", "R5 (vector count cascade drift, phase-2 갱신 후 표 안 cell)", "신규 R8 (agent namespace prefix cascade drift — 7 위치 누락 시 mismatch 잔존)"]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "R1 cycle 7 hallucination 재발",
      "mitigation": "v5.13 3-layer 검증 + v5.18 Input Verification 두 번째 실전. 재발 시 inline 정정 + audit trail 보존 + cycle 8+ evidence isolation candidate (PROPOSE 흡수)."
    },
    {
      "risk": "R2 stability 본질 evidence 실패 (예측 외 변동)",
      "mitigation": "2-phase 분리 (D1) — phase-1 결과 확인 후 phase-2 narrative 본문 작성. 변동 발견 시 narrative 본문 수정 + 변동 origin 분리 (audit chain vs harness apply)."
    },
    {
      "risk": "R3 MD028/MD034/MD038 추가 lint 위반",
      "mitigation": "v5.16 lint precheck 세 번째 실전 + 발현 시 inline 정정. v5.19 PROPOSE#3 carry-over candidate (rule 확장 trigger 누적)."
    },
    {
      "risk": "R4 § 4 끝 paragraph 6→7 매트릭스화 trigger 충족",
      "mitigation": "out_of_scope #4 (PROPOSE candidate carry-over). 본 milestone scope = stability paragraph 정전화 단일 책임."
    },
    {
      "risk": "R5 vector count cascade drift",
      "mitigation": "Edit 후 grep -c verify (v3.21 c step). L135 narrative 본문 안 vector 7건 명시 (v1.17 + v5.10 + v5.14 + v5.15 + v5.17 + v5.19 + v5.20)."
    },
    {
      "risk": "R6 self-loop counting 모호",
      "mitigation": "D6 결정 (20/26 = 76.9%). 분류 기준 narrative 정전화는 v5.18 PROPOSE#7 carry-over (out_of_scope)."
    },
    {
      "risk": "R7 lightweight 모드 누적 비대화 → scope 확장 후 lightweight 이탈 본질",
      "mitigation": "D15 결정 = lightweight 이탈 정당화 (v3.0+ bundling 키워드). 3-phase + chore = 4 commit. REPORT.lessons 안 정전화 (sc_12)."
    },
    {
      "risk": "R8 (scope 확장 후 신규) — agent namespace prefix cascade drift (7 위치 누락 시 mismatch 잔존)",
      "mitigation": "D14 결정 + phase-3 affected_files 명시 (claude/commands/harness-meta.md L75~L78+L83 + agents/agents-md-sync.md L122 + agents/environment-auditor.md L155). Stage G VERIFY 안 `grep -c 'subagent_type=\"harness-meta:' claude/commands/harness-meta.md agents/{agents-md-sync,environment-auditor}.md` = 7 (5+1+1) 검증."
    }
  ]
}
```

## narrative

### 4 관점 병렬 검토 결과 (Stage D 안 흡수, 2026-05-19)

본 milestone scope = affected_files 17건 (audit chain 5건 + meta milestone 산출물 9건 + ARCHITECTURE + CHANGELOG + ROADMAP) = 큼 (16+) 범주. 그러나 v5.19 cycle 6 패턴 정합 (4 관점 = architecture / spec-drift / 회귀 risk / scope contract) 적용. 보안 관점 제외 — audit chain read-only + ARCHITECTURE narrative 변경만 = path traversal/권한 risk 부재.

**검토 verdict 요약**:

| # | 관점 | verdict | decisive | P1/P2/P3 | 흡수 위치 |
|:-:|---|:-:|:-:|:-:|---|
| 1 | architecture | pass_with_comments | 0 | P1 2 + P2 2 + P3 1 | D9 rationale 강화 (동일 날짜 cycle 첫 사례) + sc 매핑 표 (아래) + verify_grep_keyword (D12) |
| 2 | spec-drift | pass_with_comments | **1** | P1 1 | D11 (prefix 유지 + v5.19 실 evidence 표지) — silent-ignore 가설 폐기 (사용자 환경 agent list 안 `harness-meta:` prefix 포함 = Plugin namespace 정상 표기) |
| 3 | 회귀 risk | pass_with_comments | **1 (조건부)** | P1 1 + P2 1 + P3 1 | D12 (grep -c 의무 + verify_grep_keyword exact string) — R4 매트릭스화 trigger out_of_scope 정합 + grep -c = 1건 검증 |
| 4 | scope contract | pass_with_comments | **1** | P2 1 + P3 3 | sc 매핑 표 (아래) — sc_1/sc_5/sc_7/sc_11/sc_13 매핑 명시 흡수 |

**decisive 3건 모두 DESIGN narrative 보강으로 해소** (D11 + D12 신규 + sc 매핑 표 흡수). 흡수 후 blocking decisive = 0건.

### sc ↔ phase 매핑 표 (scope contract P1 흡수, scenario B 갱신)

| sc # | INTENT.success_criteria 요약 | phase 매핑 | 매핑 위치 |
|:-:|---|:-:|---|
| sc_1 | audit-team 4 멤버 호출 + 4 산출물 | phase-1 | phase-1.scope step 1~4 (Agent 호출 4건) |
| sc_2 | diff-vs-cycle6.md 생성 | phase-2 | phase-2.scope step 1 |
| sc_3 | v5.13 fact 검증 다섯 번째 실전 | phase-1 | phase-1.scope step 5 (fact 검증) |
| sc_4 | v5.16 lint precheck 세 번째 실전 | phase-1 | phase-1.scope step 6 (lint precheck) |
| sc_5 | v5.18 Input Verification + 검증 method 분리 두 번째 실전 | phase-1 | phase-1.scope step 5 (검증 method 분리 = v5.18 두 번째) + D2 |
| sc_6 | stability 3 cycle 연속 evidence 정량 정전화 | phase-2 | phase-2.scope step 1 (diff-vs-cycle6 stability delta) |
| sc_7 | ARCHITECTURE § 4 끝 stability paragraph 정전화 | phase-2 | phase-2.scope step 2 (paragraph 신규 추가) + D4 |
| sc_8 | vector count 6→7 갱신 | phase-2 | phase-2.scope step 3 (L135 갱신) + D5 |
| sc_9 | self-loop counting 갱신 (21/27 ≈ 77.8%) | Stage H REPORT | D6 결정 + REPORT.delta (scope 확장 후 self-loop +2: stability paragraph + 매트릭스화 = 21/27) |
| sc_10 | pre-commit 14 hook PASS + 회귀 0건 | Stage G VERIFY | VERIFY.smoke_tests + VERIFY.regressions |
| sc_11 | milestones.md sub_milestones 3 phase 1:1 동기 갱신 | Stage D 직후 (완료, scenario B 갱신) + Stage G | milestones.md sub_milestones phase 3건 완료 |
| sc_12 | lightweight 이탈 (scope 확장) — bundling 정당화 | Stage H REPORT | D15 결정 + REPORT.lessons |
| sc_13 | v3.21 narrative 정전화 3 단계 패턴 21~22+ cycle | phase-2 + phase-3 + Stage G | D4 + D13 anchor + D12 c step + REPORT.lessons (paragraph 21 + 매트릭스화 22) |
| sc_14 | § 4 끝 7 paragraph 매트릭스화 (표 변환) | phase-3 | phase-3.scope step 1 (표 변환) + D13 |
| sc_15 | agent namespace prefix narrative cascade 7 위치 | phase-3 | phase-3.scope step 2~4 (5+1+1 위치 cascade) + D14 |

매핑 완전성 = 15/15 = 100%. 신규 sc_14/sc_15 = scenario B scope 확장 흡수.

### v3.10 부산물 정책 정합

`decisions[].rationale` 12건 + `phases[].scope` 2건 = (a) 본 milestone 의 결정 / 단계 범위 사실 진술만. (b) 'PROPOSE.next_candidates 발의 narrative' 직접 거명 부재 — 후속 발의는 Stage I PROPOSE 단일 책임.

### v3.21 narrative 정전화 3 단계 패턴 (D4 anchor + D12 c step)

(a) **DESIGN 1차 source** — 본 D4 결정 + paragraph 본문 초안 (DESIGN.md 안 정의)
(b) **EXECUTE Edit** — phase-2 안 ARCHITECTURE.md § 4 끝 paragraph 신규 추가 (paragraph **먼저** Edit / L135 vector count 두 번째 Edit 순서 의무, architecture P3 권고 흡수)
(c) **VERIFY grep** — D12 `grep -c '"audit-apply-audit stability cycle pattern"' projects/meta/ARCHITECTURE.md` = 1건 검증

### Stage D 완료 직전 의무 step (v3.5 정합)

phases[] 확정 직후 → milestones.md sub_milestones[] 1:1 동기 갱신 (placeholder title 교체) **완료** (scenario B 후 milestones.md L11~L29 갱신 = 3 phase 명시).

## 관련

- INTENT: [INTENT.md](INTENT.md)
- RESEARCH: [RESEARCH.md](RESEARCH.md)
- milestones.md: [milestones.md](milestones.md) (Stage D 갱신 대상)
- v3.21 narrative 정전화 3 단계 패턴 정전화: `../../ARCHITECTURE.md` § 6.2 (1차 source)
- v5.19 cycle 6 패턴: `../v5.19/DESIGN.md`
