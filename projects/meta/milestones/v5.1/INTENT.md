# INTENT — v5.1 plugin-component-discovery-fix

```json
{
  "id": "v5.1_plugin-component-discovery-fix",
  "title": "Plugin paths nested 인식 spec drift fix — Agents (0) + Skills (1 of 5) 인식 부족 해소 (v5.0 R1 mitigation 직접 후속)",
  "goal": "harness-meta Plugin 의 산출물 runtime 인식 부분 drift (claude plugin details 결과 Agents 0 / Skills 1 of 5) 를 spec-fidelity 회복 — paths 명시 array entry 형식 + sub-dir nested 인식 spec drift 해소 = 7 agents (2 standalone + 5 team) + 5 skills (3 audit + 2 dev-tools) 모두 인식.",
  "motivation": "v5.0_plugin-pivot Stage G VERIFY 단계 실 install (claude plugin marketplace add + install + details) 검증 시점 안 발견된 부분 drift = R1 mitigation ('Stage G VERIFY 실 검증 mandatory') 정합 사례. v5.0 핵심 본질 (Plugin 채택 + install lifecycle 표준 + cascade narrative 정전화 14 host) 자체 PASS, 산출물 인식 카운트만 부분 drift (Agents 0 / 7 expected, Skills 1 / 5 expected). v5.0 VERIFY.md manual_checks D9 step 3 — 'sub-dir nested 인식 부분 spec drift, R1 mitigation 미해소' carry-over 명시. v5.0 PROPOSE next_candidates#1 (rationale_for_no_roadmap_entry — '구체 책임 narrative + 추가 context7 검증 필요 + paths 형식 alternative 옵션 결정' 게이트) 본 milestone 안 흡수.",
  "success_criteria": [
    {
      "id": "sc_1",
      "criterion": "claude plugin details harness-meta 결과 Agents 카운트 ≥ 7 (7 멤버 = 2 standalone [environment-auditor + agents-md-sync] + 5 team [project-harness-audit-team 안 project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer / component-installer])",
      "verification_source": "Stage G VERIFY 안 실 install 후 claude plugin details 결과 첨부"
    },
    {
      "id": "sc_2",
      "criterion": "claude plugin details harness-meta 결과 Skills 카운트 ≥ 5 (5 skill = 3 audit [ai-ready-scorer + harness-plan-verify + harness-roadmap-update] + 2 dev-tools [developer-profile + mindvault])",
      "verification_source": "Stage G VERIFY 안 실 install 후 claude plugin details 결과 첨부"
    },
    {
      "id": "sc_3",
      "criterion": "기존 install path 보존 — claude plugin marketplace add ~/harness-meta + claude plugin install harness-meta@harness-meta 표준 명령 회귀 0",
      "verification_source": "Stage G VERIFY 안 실 install 후 status enabled 확인 + plugin source ~/.claude/plugins/cache/harness-meta/ 거주 확인"
    },
    {
      "id": "sc_4",
      "criterion": "pre-commit 14 hook 모두 PASS (회귀 0)",
      "verification_source": "Stage F EXECUTE 안 phase별 commit 시 pre-commit hook 결과"
    },
    {
      "id": "sc_5",
      "criterion": "cascade narrative drift 부재 — .claude-plugin/plugin.json paths 변경 시 README/AGENTS/root CLAUDE.md/component-installer.md 안 narrative 정합 유지 (paths 형식 + 인식 결과 명시 일관성)",
      "verification_source": "Stage G VERIFY 안 grep 키워드 검증 (변경 후 host 안 narrative 누락 부재)"
    },
    {
      "id": "sc_6",
      "criterion": "Hooks (2 PostToolUse + SessionStart) 인식 보존 — v5.0 PASS 결과 회귀 0",
      "verification_source": "Stage G VERIFY 안 claude plugin details Hooks 카운트 확인"
    },
    {
      "id": "sc_7",
      "criterion": "CHANGELOG [v5.1] entry 추가 — Fixed (Plugin component discovery spec drift) + Changed (paths 형식, 필요 시) section 명시",
      "verification_source": "Stage F EXECUTE 안 CHANGELOG.md 갱신 확인"
    },
    {
      "id": "sc_8",
      "criterion": "ROADMAP entry status: in_progress → completed (Stage I) + next_candidates 흡수",
      "verification_source": "Stage I PROPOSE 안 ROADMAP milestones[] entry 갱신"
    },
    {
      "id": "sc_9",
      "criterion": "사용자 환경 dual-active (v4.x SymbolicLink 잔존 ~/.claude/agents/ 5 멤버 + v5.0 Plugin install) 회귀 0 — Plugin 측 변경이 SymbolicLink 작동에 영향 없음",
      "verification_source": "Stage G VERIFY 안 manual_check — 본 milestone 안 cleanup 부재 narrative 유지"
    }
  ],
  "out_of_scope": [
    "v4.x SymbolicLink narrative 자연 제거 (~/.claude/agents/ 안 5 멤버 SymbolicLink cleanup 권고는 README/AGENTS 안 기존 narrative 유지, 본 milestone 안 추가 변경 없음 — v5.0 D2 deprecation 표지 narrative cleanup 책임 부재)",
    "외부 marketplace 등록 (GitHub source claude plugin marketplace add pdw96/harness-meta 표준 명령 추가 부재 — 본 milestone 안 local marketplace 만 검증)",
    "spec-drift 검증 패턴 narrative 정전화 (context7 검증 + 실 install/runtime 검증 2 단계 의무 명문화는 본 milestone 안 적용 사례로 기여하나 패턴 자체 정전화 narrative 신규 부재)",
    "narrative 정전화 3 단계 패턴 9 번째 cycle 의무 발현 (본 milestone scope 작음 예상, cycle 자체 추구 부재 — 자연 발현만)",
    "워크플로우 9-stage 본문 변경 (Lightweight 모드 / smoke / Stage 정의 신규 부재 — 본 milestone 은 산출물 fix scope 만)",
    "smoke 테스트 신규 (paths 형식 검증 smoke 신규 부재 — 본 milestone 안 실 install 검증으로 verify)"
  ],
  "dependencies": {
    "predecessors": [
      "v5.0_plugin-pivot (Stage G VERIFY 안 R1 drift 발견 + PROPOSE next_candidates#1 origin)",
      "v4.3_subagent-discovery-path-research (Plugin spec 안 paths 명시 RESEARCH source — 본 milestone RESEARCH 안 추가 검증 의무)"
    ],
    "successors_potential": [
      "v5.2+ external-marketplace-registration (v5.0 PROPOSE#5 carry-over)",
      "v5.x_v4x-deprecation-narrative-cleanup (v5.0 PROPOSE#4 carry-over, 사용자 명시 발의 시점 미확정)",
      "v5.x_spec-drift-verification-pattern-canonicalization (v5.0 PROPOSE#3 carry-over)"
    ]
  }
}
```

## narrative

본 milestone 의 핵심 질문 — **'Plugin paths 안 명시한 7 agents + 5 skills 가 왜 claude plugin details 결과 0 + 1 로만 인식되는가'**. v5.0 Stage G 안 R1 mitigation 'Stage G VERIFY 실 검증 mandatory' 패턴 정합으로 발견된 부분 drift, 본 milestone scope = 해당 drift 의 root cause 파악 (RESEARCH 단계 context7 추가 검증) + fix 적용 (DESIGN 단계 결정 후) + 실 install 검증 (VERIFY 단계 실 install 후 details 결과 첨부) 완결.

## 핵심 motivation 정합 narrative

1. **R1 mitigation 정합 발견** — v5.0 DESIGN 안 5 관점 검토 결과 'paths 명시 array entry 형식 spec drift 가능' R1 으로 예고 + 'Stage G VERIFY 실 검증 mandatory' mitigation 명시. v5.0 Stage G 안 실 install 시점 = drift 가 실제 발현 + 검증 패턴 정합.
2. **carry-over scope 명확** — v5.0 핵심 본질 (manifest 3건 + install lifecycle + cascade 14 host narrative) 자체 PASS, 산출물 runtime 인식 카운트만 부분 drift. 본 milestone = scope 작음 + fix 본질 (workflow self-improvement 부재).
3. **R1 mitigation 안 safer 옵션 안 alternative 옵션 미실행** — v5.0 안 fix 3건 (source / agents 개별 명시 / hooks wrapper) 모두 minor adjustment 수준이었으나, paths array entry 형식 fix 는 spec 안 alternative 옵션 (agents/ root flat 재배치 / `${CLAUDE_PLUGIN_ROOT}` 변수 / paths 부재 default 활용) 결정 부재 — 본 milestone 안 RESEARCH 단계 context7 추가 검증 후 결정.

## scope 정합 narrative (v3.10 out_of_scope 부산물 정책 정합)

`out_of_scope` 6건 모두 (a) 사실 진술 형식 — '본 milestone 안 무엇이 **아닌가**' 만 명시. (b) forward propose 명령형 ('별 milestone 으로 / 후속 milestone 안 처리') 회피. 후속 candidate origin 은 본 milestone 안 흡수 부재 = Stage I PROPOSE 단계 단일 source.

## 관련

- 컨테이너: [`milestones.md`](milestones.md)
- v5.0 R1 drift 발견 source: [`../v5.0/VERIFY.md`](../v5.0/VERIFY.md) § "manual_checks D9 step 3"
- v5.0 R1 mitigation narrative: [`../v5.0/DESIGN.md`](../v5.0/DESIGN.md) § "risk_mitigation"
- v5.0 PROPOSE next_candidates#1 origin: [`../v5.0/PROPOSE.md`](../v5.0/PROPOSE.md)
- v4.3 Plugin spec RESEARCH source: [`../v4.3/RESEARCH.md`](../v4.3/RESEARCH.md)
- Plugin manifest: [`../../../../.claude-plugin/plugin.json`](../../../../.claude-plugin/plugin.json)
