# DESIGN — v4.3 subagent-discovery-path-research (scope rewritten, lightweight 모드)

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "RESEARCH option P4 (RESEARCH 결과 정전화만 + 후속 milestone 설계 carry-over) 채택. 본 v4.3 = '진단 + 경로 발견' milestone.",
      "rationale": "사용자 결정 round 3 안 (I) 'v4.3 안 RESEARCH 완결 + v4.4/v5.0 후속 적용' 명시. P1 (전면) / P2 (점진) / P3 (현 유지) 는 후속 milestone 안 결정.",
      "alternatives_rejected": ["P1 (전면) — 본 v4.3 안 진행 시 breaking change 의무 + scope 거대화, 사용자 결정 미정합", "P2 (점진) — 본 v4.3 안 plugin.json 추가만 진행 가능하나 사용자 결정 (a) 안 v5.0_plugin-pivot 명시", "P3 (현 유지) — Plugin spec 미활용, ecosystem integrator 정체성 약화"]
    },
    {
      "id": "D2",
      "decision": "후속 milestone = v5.0_plugin-pivot pending entry ROADMAP 등재 (전면 P1 채택, breaking major bump). harness-meta 자체를 Plugin 으로 변환 + .claude-plugin/plugin.json + marketplace.json + install 메커니즘 전면 재설계.",
      "rationale": "사용자 결정 round 4 안 (a) 'v5.0_plugin-pivot pending entry 등재 (전면 P1 채택) (Recommended)' 명시. 점진 도입 (P2) 의 이중 구조 cons 회피 + 전면 채택의 narrative 단순화. v4.0 (정체성 pivot) 직접 후속 (두 번째 major bump).",
      "alternatives_rejected": ["(b) v4.4 점진 P2 — 이중 구조 narrative 부담 + 최종 단순화까지 추가 cycle 필요", "(c) narrative 거명만 — 사용자 명시 결정 (a) 와 모순", "(d) v4.4 + v5.0 동시 — 표지적 디렉션 over-engineering"]
    },
    {
      "id": "D3",
      "decision": "본 v4.3 phase 분할 = 1-phase Lightweight (narrative 정전화 + ROADMAP v5.0 등재 통합). commit timing (b) — Stage G commit 안 INTENT/RESEARCH/DESIGN/APPROVE 4건 + VERIFY/REPORT/PROPOSE + milestones.md + ROADMAP 갱신 모두 일괄 (v4.1/v4.2 패턴 정합).",
      "rationale": "v3.x lightweight 패턴 누적 (9/21 = 42.9% v3.21 까지). scope 작음 ≤5 파일 (narrative 정전화 2 host + ROADMAP entry) → 1-phase 자연 default. v3.18 L2 도그푸드 패턴 + v3.21 narrative 정전화 3 단계 패턴 6 cycle 누적 정합.",
      "alternatives_rejected": ["2-phase (narrative + ROADMAP 분리) — 분리 필요성 부재", "3-phase (v3.21 narrative 정전화 3 단계) — scope 본 milestone 산출물 = ARCHITECTURE.md + bootstrap/agents/CLAUDE.md narrative 정전화 + ROADMAP 등재만, 3 단계 분리 over-engineering"]
    },
    {
      "id": "D4",
      "decision": "narrative 정전화 위치 = (1) ARCHITECTURE.md § 3.1 끝 'mechanical 본질 vs Claude Code spec 의무 컴포넌트 분리' paragraph 직후 신규 paragraph 1건 ('Install 정책 본질 + Claude Code Plugin spec 대안 + trade-off') + (2) bootstrap/agents/CLAUDE.md § Install/Update/Cleanup 책임 § Component-installer mechanical sequence (D7) 끝 sub-paragraph 1건 ('.md 파일 영역 SymbolicLink default + Junction directory only spec drift + copy fallback 동작 narrative').",
      "rationale": "v3.21 narrative 정전화 3 단계 패턴 6 cycle 누적 (v3.18 + v3.20 + v3.21 + v4.1 + v4.2 + 본 v4.3 = 7 번째). 단일 source 전략 — ARCHITECTURE.md = install 정책 본질 narrative (정전 single source), bootstrap/agents/CLAUDE.md = D7 sequence narrative (mechanical 책임 위치). 다른 host (root CLAUDE.md / claude/CLAUDE.md / README.md / AGENTS.md / GUARDRAILS.md) cross-ref 추가 zero (v3.20 단일 source 패턴 정합).",
      "alternatives_rejected": ["root CLAUDE.md 안 직접 narrative — 정전 single source 분산 risk", "다중 host cascade — cross-ref drift risk + scope 확장"]
    },
    {
      "id": "D5",
      "decision": "lightweight 모드 채택 — 3 관점 subagent 병렬 검토 skip. v4.0 § 6.2 폐지 후 lightweight 자유 default + scope 작음 ≤5 파일 + scope rewrite narrative 자기 검토 충분.",
      "rationale": "v3.x lightweight 패턴 누적 10/22 = 45.5% (v3.6/v3.10/v3.13/v3.14/v3.17/v3.18/v3.19/v3.20/v3.21 + 본 v4.3). 사용자 의문 round 3회 + scope rewrite 결정 = scope 자기 검토 충분. RESEARCH context7 4 source 검증 = spec-drift 자체 검증 완료.",
      "alternatives_rejected": ["3 관점 subagent 호출 (architecture / spec-drift / scope contract) — context7 검증 안 spec-drift 이미 흡수, architecture/scope contract 검토 비용 대비 효익 낮음"]
    },
    {
      "id": "D6",
      "decision": "본 v4.3 산출물 안 forward propose 명령형 회피 — INTENT/RESEARCH/DESIGN 안 '후속 milestone v4.4/v5.0' 거명 모두 사실 진술 형식 + PROPOSE 단계 안 단일 source 통합 흡수 (v3.10 부산물 정책 정합).",
      "rationale": "v3.10 부산물 정책 (B/C/D 부산물 통합 흡수 책임 = Stage I PROPOSE 단일 source). 본 milestone 안 산출물 안 'forward propose 명령형' (예: '~을 별 milestone 으로 진행하자') 사용 부재 grep 검증 의무.",
      "alternatives_rejected": []
    },
    {
      "id": "D7",
      "decision": "VERIFY 안 narrative 정전화 검증 = grep 키워드 3건 — (1) 'Plugin spec' (ARCHITECTURE.md 안 install 정책 paragraph) + (2) 'plugin marketplace local source' (ARCHITECTURE.md 동) + (3) '.md 파일 영역 SymbolicLink default' (bootstrap/agents/CLAUDE.md 안 D7 sequence sub-paragraph). v3.21 3 단계 패턴 (c) VERIFY grep 검증 패턴 정합.",
      "rationale": "v3.21 narrative 정전화 3 단계 패턴 6 cycle 누적 — (a) DESIGN 안 정확 문구 1차 source + (b) phase-1 EXECUTE 안 Edit tool 정확 문구 그대로 삽입 + (c) VERIFY 안 grep 검증 키워드 직접 추출. 본 v4.3 = 7 번째 cycle.",
      "alternatives_rejected": []
    }
  ],
  "approach": "본 v4.3 = lightweight 1-phase (narrative 정전화 + ROADMAP v5.0_plugin-pivot pending entry 등재) milestone. EXECUTE 산출물 = (1) ARCHITECTURE.md § 3.1 끝 'Install 정책 본질 + Claude Code Plugin spec 대안' paragraph 1건 신규 + (2) bootstrap/agents/CLAUDE.md § Install/Update/Cleanup 안 D7 sequence sub-paragraph 1건 신규 + (3) ROADMAP v5.0_plugin-pivot pending entry 등재. v3.21 narrative 정전화 3 단계 패턴 7 번째 cycle 누적.",
  "phases": [
    {
      "n": 1,
      "title": "narrative 정전화 (ARCHITECTURE.md + bootstrap/agents/CLAUDE.md) + ROADMAP v5.0_plugin-pivot pending entry 등재 (Lightweight 1-phase)",
      "scope": "본 phase 의 정확 범위 (사실 진술, forward propose 명령형 부재): (a) ARCHITECTURE.md § 3.1 끝 paragraph 신규 1건 정전화 — 'Install 정책 본질 (~/.claude/agents/ 단일 discovery spec 강제) + Claude Code Plugin spec 대안 (plugin marketplace local source + plugin 안 agents/ 자동 인식) + trade-off (현 install symlink/copy 매핑 vs Plugin install lifecycle)'. (b) bootstrap/agents/CLAUDE.md § Install/Update/Cleanup 책임 § Component-installer mechanical sequence (D7) 끝 sub-paragraph 신규 1건 정전화 — '.md 파일 영역 SymbolicLink default (Junction = directory only Microsoft NTFS spec) + copy fallback 동작 narrative + Developer Mode 의존성 narrative'. (c) ROADMAP milestones[] 안 v5.0_plugin-pivot pending entry 등재 (status: pending, trigger: A_user, summary: install 정책 전면 재설계 narrative).",
      "affected_files": [
        "projects/meta/milestones/v4.3/execute/phase-1.md",
        "projects/meta/ARCHITECTURE.md (§ 3.1 끝 paragraph 신규)",
        "bootstrap/agents/CLAUDE.md (§ D7 sequence 끝 sub-paragraph 신규)",
        "projects/meta/ROADMAP.md (milestones[] 안 v5.0_plugin-pivot pending entry 등재)"
      ],
      "rationale": "narrative 정전화 + ROADMAP 등재 통합 1-phase Lightweight 모드. commit timing (b) — Stage G commit 안 INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE/milestones.md/ROADMAP 모두 일괄 (v4.1/v4.2 패턴 정합).",
      "risks": [
        "narrative 정전화 시 정확 문구 drift — Edit tool 안 정확 문구 그대로 삽입 (v3.21 3 단계 패턴 (b))",
        "ROADMAP v5.0 entry 안 status: pending — v5.0_plugin-pivot 명세 narrative 정합 의무",
        "smoke-cross-ref FAIL — 미작성 산출물 cross-ref 회피 (v4.2 L1 lesson 정합)"
      ]
    }
  ],
  "risk_mitigation": [
    {
      "risk_id": "R1",
      "description": "Plugin spec 안 paths 명시 시 glob 또는 multiple paths 지원 여부 미확정 (RESEARCH 1차 검증 안 명시 부족)",
      "mitigation": "본 v4.3 안 narrative 정전화만 + 실 적용 (paths 명시) carry-over → v5.0_plugin-pivot 안 깊은 검증 의무 narrative ROADMAP entry 안 명시"
    },
    {
      "risk_id": "R2",
      "description": "Plugin install 시 ~/.claude/plugins/ 안 거주 추정 — 현 ~/.claude/agents/ 5 멤버 SymbolicLink 와 공존 가능성 미확정",
      "mitigation": "v5.0_plugin-pivot 안 5 멤버 migration 책임 narrative + 현 SymbolicLink → Plugin install 으로 전환 plan"
    },
    {
      "risk_id": "R3",
      "description": "v4.0 정체성 narrative ('static install script 부재, agent 흡수') 와 Plugin install CLI 명령 책임 분리 narrative 정합 필요",
      "mitigation": "본 v4.3 안 ARCHITECTURE.md narrative 정전화 시 책임 분리 명시 — 'component-installer = harness-meta 안 component lifecycle 관리 (custom)' + 'Plugin install = Claude Code 표준 lifecycle (CLI 명령)' 책임 경계 narrative"
    },
    {
      "risk_id": "R4",
      "description": "본 milestone 자체 산출물 안 forward propose 명령형 risk (v3.10 부산물 정책 위반)",
      "mitigation": "사실 진술만 사용 + grep 검증 ('별 milestone 으로' / '후속 milestone 안 처리' 등 명령형 패턴 0). VERIFY 단계 안 검증 의무"
    },
    {
      "risk_id": "R5",
      "description": "scope rewrite 두 번째 사례 (v4.1 첫 사례) — workflow 흐름 안 scope rewrite 패턴 누적, narrative 정전화 잠재 후속",
      "mitigation": "본 v4.3 PROPOSE 안 'scope rewrite 패턴 정전화' candidate narrative 거명만 (ROADMAP 미등재, § 6.2 폐지 후 사용자 명시 결정 후 등재)"
    },
    {
      "risk_id": "R6",
      "description": "smoke-cross-ref FAIL risk (v4.2 L1 lesson) — 미작성 산출물 (e.g., VERIFY.md / REPORT.md / PROPOSE.md) cross-ref 거명 시 broken ref",
      "mitigation": "phase-1.md + INTENT/RESEARCH/DESIGN 안 미작성 산출물 cross-ref 회피. 직접 거명 시 즉시 작성 (또는 Stage G commit 안 일괄 작성). v4.2 L1 패턴 정확 정합"
    }
  ]
}
```

## 5 관점 검토 결과 (lightweight 모드, 3 관점 skip — 자기 검토 narrative)

본 milestone scope 작음 (≤5 파일) + scope rewrite narrative 자기 검토 round 4 + RESEARCH context7 4 source 검증 = lightweight 모드 자연 default (v4.0 § 6.2 폐지 후 자유). 3 관점 subagent (architecture / spec-drift / scope contract) 호출 비용 대비 효익 낮음.

**자기 검토 narrative**:

- **architecture**: 산출물 = ARCHITECTURE.md (단일 source, 정전 narrative) + bootstrap/agents/CLAUDE.md (D7 sequence narrative 위치) + ROADMAP (pending entry 등재). 단일 source 패턴 정합 — 다른 host cross-ref 추가 zero. v3.20 단일 source 패턴 정확 정합. **PASS**.
- **spec-drift**: context7 4 source 검증 완료 (sub-agents docs / plugins-reference / plugin-marketplaces / settings) — RESEARCH external #1~#5 안 명시. Plugin spec 발견 narrative + plugin marketplace local source 지원 + plugin 안 agents/ 자동 인식 = spec 정합. **PASS**.
- **scope contract**: INTENT.success_criteria 7건 ↔ DESIGN.phases[1].scope 매핑 검증 — (1) RESEARCH 결과 narrative ✓ + (2) trade-off 분석 ✓ (RESEARCH.options 안) + (3) 후속 milestone 설계 narrative ✓ (D2 v5.0_plugin-pivot 결정) + (4) ROADMAP 등재 ✓ (phase-1.scope (c)) + (5) v4.1 narrative drift 정전화 ✓ (phase-1.scope (b)) + (6) forward propose 명령형 부재 ✓ (D6 grep 검증) + (7) 회귀 0 ✓ (pre-commit 14 hook 의무). **PASS**.

→ 3 관점 검토 결과 = pass-with-comments 0 (의견 충돌 0). 사용자 결정 (a) + RESEARCH 검증 완료 후 직접 진행 정합.

## narrative

본 DESIGN 의 핵심 narrative — 본 v4.3 = **'진단 + 경로 발견' milestone** (사용자 결정 (I) 정합). 실 적용 (Plugin 으로 변환, install 정책 전면 재설계) 은 **v5.0_plugin-pivot 후속 milestone** (사용자 결정 (a) 정합). v3.x lightweight 패턴 누적 + v3.21 narrative 정전화 3 단계 패턴 7 번째 cycle.

## Stage D 완료 직전 의무 step (v3.5 도입)

`phases[]` 확정 직후 (3 관점 자기 검토 narrative 흡수 후) → `milestones/v4.3/milestones.md` `sub_milestones[]` 를 `phases[]` 와 1:1 동기 갱신 (placeholder title 교체). 본 step 다음 작업 안 진행.

## 관련

- INTENT (scope rewrite 후): [`INTENT.md`](INTENT.md)
- RESEARCH (context7 4 source 검증): [`RESEARCH.md`](RESEARCH.md)
- 후속 milestone 등재: ROADMAP milestones[] 안 v5.0_plugin-pivot pending entry (phase-1.scope (c))
- v3.21 narrative 정전화 3 단계 패턴 원전: [`../_archive/v3.21/DESIGN.md`](../_archive/v3.21/DESIGN.md)
- v4.0 정체성: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.1 끝
