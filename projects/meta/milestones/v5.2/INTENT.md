# INTENT — v5.2 agent-functional-path-cleanup

```json
{
  "id": "v5.2_agent-functional-path-cleanup",
  "title": "agents/environment-auditor.md + agents/harness-gap-analyzer.md 내부 functional audit path 갱신 — v5.1 Phase 1+2 (agent + skills move) 결과 stale path 해소",
  "goal": "v5.1 component 이동 (Phase 1 bootstrap/agents/audit/ → agents/ + Phase 2 bootstrap/skills/{audit,dev-tools}/ → skills/) 결과 stale 상태로 잔존한 2 agent .md 파일 안 functional audit path 를 신 위치에 정합하도록 갱신하여, environment-auditor + harness-gap-analyzer 두 agent 의 실 audit/scan 동작이 신 디렉토리 구조에서 정확히 resolve 되도록 한다.",
  "motivation": "B_regression origin — v5.1_plugin-component-discovery-fix VERIFY 단계에서 cascade 9 host narrative 갱신이 완료된 후에도 2 agent .md 파일 안 functional audit path (실제 audit 시 glob 대상 경로) 가 stale 상태로 잔존함을 발견 (regressions 2건). v5.1 PROPOSE#1 에 등재된 B_regression candidate (등재 시점 id = `agent-audit-path-cleanup`). 사용자 명시 발의 (A_user, Stage A AskUserQuestion 안 선택) 후 v5.2 진입 — Stage A AskUserQuestion 후속 결정으로 id `agent-audit-path-cleanup` → `agent-functional-path-cleanup` 변경 ('audit' 단어 모호성 해소, functional path 의미 명시화). v5.1 cascade scope 는 narrative 중심이었고 functional path (hardcoded glob) 는 누락 → 본 milestone 이 그 누락 fix. scope 사전 식별 2건 (environment-auditor.md:74 + harness-gap-analyzer.md:59), Stage C RESEARCH 에서 추가 잔존 codebase 전체 grep 검증.",
  "success_criteria": [
    {
      "id": "sc_1",
      "criterion": "agents/environment-auditor.md:74 안 functional path 3건 (bootstrap/skills/audit/*/SKILL.md + bootstrap/skills/dev-tools/*/SKILL.md + bootstrap/agents/audit/*.md) → skills/*/SKILL.md + agents/*.md (2 path) 통합/갱신 완료",
      "verification_source": "Stage G VERIFY 안 environment-auditor.md L74 grep + diff 검증"
    },
    {
      "id": "sc_2",
      "criterion": "agents/harness-gap-analyzer.md:59 안 functional path 2건 (bootstrap/agents/audit/ + bootstrap/agents/dev-tools/) → agents/ 통합 1건 갱신 완료",
      "verification_source": "Stage G VERIFY 안 harness-gap-analyzer.md L59 grep + diff 검증"
    },
    {
      "id": "sc_3",
      "criterion": "2 agent .md (environment-auditor + harness-gap-analyzer) 안 'bootstrap/agents/' 또는 'bootstrap/skills/' 거명 잔존 0건 (functional path 범위 한정 — historical narrative 안 거명은 sc_4 참조)",
      "verification_source": "Stage G VERIFY 안 `grep -E 'bootstrap/(agents|skills)/' agents/{environment-auditor,harness-gap-analyzer}.md` 결과 0 line"
    },
    {
      "id": "sc_4",
      "criterion": "다른 host (CLAUDE.md / README.md / AGENTS.md / 다른 agent .md / skill SKILL.md / claude/commands/*.md / ARCHITECTURE.md / 산출물 milestone files) 안 'bootstrap/agents/' 또는 'bootstrap/skills/' 거명 검증 — historical narrative (milestone 산출물 안 v4.x 거명 등) 는 보존, functional path 잔존 시에만 추가 fix",
      "verification_source": "Stage C RESEARCH grep 전수 검증 결과 의존 + Stage G VERIFY 안 case-by-case 분기 결과 첨부"
    },
    {
      "id": "sc_5",
      "criterion": "pre-commit 14 hook 모두 PASS (smoke 회귀 0)",
      "verification_source": "Stage F EXECUTE 안 phase별 commit 시 pre-commit hook 결과"
    },
    {
      "id": "sc_6",
      "criterion": "environment-auditor + harness-gap-analyzer 두 agent 의 functional 작동 — 갱신된 path 가 신 위치에 실제 resolve 되는지 검증 (ad-hoc Glob 검증 또는 실 agent 호출 1회)",
      "verification_source": "Stage G VERIFY 안 두 agent 별 차등 가능 — environment-auditor → Glob 검증 또는 실 invoke / harness-gap-analyzer → Glob 검증 우선 (orchestration 의존 invoke 부담)"
    },
    {
      "id": "sc_7",
      "criterion": "CHANGELOG [v5.2] entry 추가 — Fixed (agent functional path stale drift) section 명시",
      "verification_source": "Stage F EXECUTE 안 CHANGELOG.md 갱신 확인"
    }
  ],
  "out_of_scope": [
    "v5.1 cascade scope 외 historical narrative (milestone 산출물 v4.x ~ v5.1 안 bootstrap/agents 거명) — 본 milestone 은 functional path 갱신만, historical 보존.",
    "agent 책임 변경 / skill 추가 / Plugin spec 변경 — 본 milestone 은 path string 갱신만.",
    "v5.x_external-marketplace-registration (pending 별 milestone) 처리 — 별도 trigger 대기.",
    "Stage D 시점 lightweight 모드 채택 여부 결정 미확정 — 본 INTENT 는 표준 9-stage 가정으로 작성, Stage D 에서 결정 후 후속 stage scope 조정."
  ],
  "dependencies": {
    "predecessors": [
      "v5.1_plugin-component-discovery-fix (completed, B_regression origin — VERIFY regressions 2건 명시)"
    ],
    "successors": []
  }
}
```
