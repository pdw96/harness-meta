# RESEARCH — v5.1 plugin-component-discovery-fix

```json
{
  "external": [
    {
      "source": "context7 /websites/code_claude — plugins-reference",
      "topic": "Plugin manifest paths schema (agents / skills / commands / hooks / mcpServers / outputStyles / lspServers)",
      "findings": [
        "agents field = array of paths. spec 예시 = 모두 .md 파일 직접 명시 (e.g., './agents/security-reviewer.md'). directory entry 형식 예시 부재.",
        "skills field = STRING path to directory (single path, NOT array). spec 예시 = './custom/skills/'.",
        "commands field = array of paths. spec 예시 = .md 파일 + 디렉토리 (trailing /) 두 형식 모두 허용 (e.g., './commands/core/', './commands/preview.md').",
        "Plugin manifest 안 paths 명시 시 — agents/commands 는 default 위치 (standard structure plugin_root/{agents,commands}/) 를 REPLACE, skills 는 ADD-TO-DEFAULT (default 추가).",
        "Plugin manifest 부재 시 — Claude Code 자동 발견 (plugin root 안 standard structure 표준 위치) + plugin name = 디렉토리 명에서 derive.",
        "Skill directory structure 표준 = '{skills_path}/{skill-name}/SKILL.md' (1단계 sub-dir). 2단계 sub-dir nested ('{skills_path}/{category}/{skill-name}/SKILL.md') 안 인식 spec 미명시 = 부분 drift.",
        "Standard Plugin Directory Structure: plugin_root 안 agents/ commands/ skills/ hooks/ 표준 위치 (NOT nested in .claude-plugin/).",
        "${CLAUDE_PLUGIN_ROOT} 변수 활용 = hooks command path 안 사용 가능. paths field 안 사용 spec 미명시."
      ],
      "drift": "skills 안 2단계 nested sub-dir 안 SKILL.md 거주 시 discovery 미부합 (1단계만 인식). agents paths 명시 .md 파일 7건 모두 cache 안 정확 거주 — but claude plugin details 결과 Agents (0) 인식 부재. 본 drift root cause = paths 명시 표준 위치 (plugin_root/agents/) 미부합 추정 (alternative — paths 명시 자체 동작 부재 + standard structure 의무)."
    },
    {
      "source": "context7 /websites/code_claude — skills nested directory discovery",
      "topic": "Skills 의 nested directory discovery 동작",
      "findings": [
        ".claude/skills/ 안 nested 자동 발견 = monorepo 패턴 (예: packages/frontend/.claude/skills/) — user skill 안 nested 인식.",
        "Plugin skills 안 nested discovery spec 직접 명시 부재 — 즉 plugin skills 인식 표준 = 1단계 sub-dir 안 SKILL.md (예: skills/code-reviewer/SKILL.md)."
      ],
      "drift": "plugin skills field STRING path 안 거주 디렉토리 구조 = 표준 '{path}/{skill}/SKILL.md' 의무. 2단계 sub-dir (category 안 skill) 안 거주 시 인식 미부합."
    },
    {
      "source": "v5.0_plugin-pivot Stage G VERIFY 결과 (직접 source, [`../v5.0/VERIFY.md`](../v5.0/VERIFY.md))",
      "topic": "claude plugin details harness-meta 실 결과",
      "findings": [
        "v5.0 Stage G 안 결과 = Hooks (2 PostToolUse + SessionStart) PASS, Skills (1 of 5) PARTIAL, Agents (0) FAIL, Commands cache 거주 PASS (runtime 검증 부재).",
        "현 시점 재검증 (v5.1 Stage C, 2026-05-14) = Skills (1) — `harness-meta` 1건만 / Agents (0) / Hooks (2) PostToolUse, SessionStart / MCP servers (0). Token cost ~83 always-on + 9.4k on-invoke."
      ],
      "drift": "v5.0 Stage G 결과 = v5.1 Stage C 재검증 정확 동치 (5건 unchanged). v5.0 결과 = 본 RESEARCH 의 ground truth."
    },
    {
      "source": "v4.3_subagent-discovery-path-research RESEARCH 결과 ([`../v4.3/RESEARCH.md`](../v4.3/RESEARCH.md))",
      "topic": "Plugin manifest paths 명시 — install (~/.claude/agents/) 외 경로 발견 narrative",
      "findings": [
        "v4.3 RESEARCH 결과 = Claude Code Plugin spec 안 marketplace local source + plugin agents/ 자동 인식 + paths 명시 = install 회피 경로 단일 발견.",
        "v4.3 안 paths 명시 형식 + 실 install 후 인식 검증 수행 부재 — v5.0 phase-1 안 처음 시도, Stage G 안 드러난 부분 drift carry-over."
      ],
      "drift": "v4.3 안 'paths 명시 안 인식 자동' 추정 = 실 운용 안 부분 drift (skills 1 of 5 + agents 0). 본 milestone 안 정정 의무."
    }
  ],
  "codebase": {
    "affected_files": [
      ".claude-plugin/plugin.json (paths 형식 fix)",
      "bootstrap/agents/audit/ (디렉토리 재배치 가능, Option 별)",
      "bootstrap/skills/ (디렉토리 재배치 가능, Option 별)",
      "README.md (cascade narrative — 재배치 후 위치 명시)",
      "AGENTS.md (영문 cascade narrative)",
      "CLAUDE.md (root — cascade narrative)",
      "claude/CLAUDE.md (cascade narrative)",
      "bootstrap/agents/CLAUDE.md (디렉토리 안 위치 narrative)",
      "bootstrap/skills/CLAUDE.md (디렉토리 안 위치 narrative)",
      "bootstrap/claude-code-catalog/README.md (catalog narrative)",
      "projects/meta/ARCHITECTURE.md (정전 single source — § 3.1 plugin manifest narrative)",
      "CHANGELOG.md ([v5.1] entry 추가)"
    ],
    "untouched_files_explicit": [
      "claude/hooks/hooks.json (v5.0 Stage G 안 인식 PASS, 본 milestone 변경 부재)",
      "claude/commands/harness-meta.md (commands 인식 검증 후순위, 본 milestone scope 안 부재)",
      "claude/statusline/statusline.sh (Plugin manifest 안 statusline 표준 필드 부재, 본 milestone scope 부재)",
      "projects/meta/ROADMAP.md (Stage A entry 등재 외 추가 변경 부재)",
      "tests/ smoke (산출물 인식 검증 smoke 신규 부재 — 본 milestone 안 실 install 검증으로 verify)"
    ],
    "current_state": "Plugin manifest paths 안 agents = 7 .md 파일 개별 명시 (5 team + 2 standalone), skills = './bootstrap/skills/' STRING. Install 후 cache 거주 정확 (7 agents + 5 SKILL.md 모두 거주 확인). claude plugin details 결과 = Skills (1) `harness-meta`, Agents (0), Hooks (2), MCP servers (0).",
    "target_state": "claude plugin details 결과 = Skills (5) 5 SKILL.md 모두 인식 + Agents (7) 7 멤버 모두 인식 + Hooks (2) 보존 + MCP servers (0) 변경 부재. paths 형식 spec 정합 + cascade narrative drift 부재."
  },
  "options": [
    {
      "id": "A",
      "name": "표준 구조 재배치 — plugin_root/agents/ + plugin_root/skills/ flat 안 재배치 (paths 부재 default 활용)",
      "pros": [
        "Spec 표준 구조 (plugin_root 안 standard locations) 정합 — Claude Code default discovery 활용",
        "paths 명시 부재 = 표준 위치 자동 인식, 형식 spec drift 위험 부재",
        "skills 인식 spec '{path}/{skill}/SKILL.md' 1단계 sub-dir 정합"
      ],
      "cons": [
        "디렉토리 재배치 = bootstrap/agents/ + bootstrap/skills/ 삭제 + agents/ + skills/ plugin_root 안 생성 — narrative 11+ host update 의무 (큼 scope)",
        "bootstrap/ 정체성 narrative 변경 (현재 'bootstrap subagent + skill 컨테이너' = 폐지)",
        "category 차원 (audit / dev-tools) 손실 — skill 5건 flat 안 거주, category narrative cascade 안 별도 정전화 의무",
        "git mv 8+ 파일 + tests/CLAUDE.md 경로 규약 변경 검증"
      ]
    },
    {
      "id": "B",
      "name": "현 구조 유지 + plugin_root 안 agents/ + skills/ Symlink 추가 (dual-active narrative)",
      "pros": [
        "bootstrap/ 거주 narrative 보존 (cascade narrative 변경 최소)",
        "plugin_root 안 standard locations 동시 거주 → Claude Code default discovery PASS",
        "bootstrap/agents/* → agents/*.md symlink + bootstrap/skills/<cat>/<skill>/SKILL.md → skills/<skill>/SKILL.md symlink"
      ],
      "cons": [
        "dual-active narrative 복잡 (현재 구조 + symlink 추가 = 두 위치 동시 거주)",
        "Windows symlink 권한 의무 (Developer Mode 또는 Junction — v4.1 narrative 정합)",
        "skill 'category' 폐지 (symlink target 1단계 평탄화) — 또는 symlink directory 안 SKILL.md 보존 어려움",
        "git diff 안 symlink 표지 + 운용 안 symlink 정합성 검증 의무 (R 추가)"
      ]
    },
    {
      "id": "C",
      "name": "paths 명시 형식 alternative 시도 — agents 디렉토리 entry + ${CLAUDE_PLUGIN_ROOT} 변수 + skills array",
      "pros": [
        "디렉토리 재배치 부재 — 현 구조 + plugin.json 만 변경",
        "context7 spec 안 alternative 형식 시도 (e.g., agents array 안 directory trailing /, skills array 변경)",
        "minor change scope"
      ],
      "cons": [
        "v5.0 안 agents 디렉토리 entry 시도 → install FAIL (`agents: Invalid input`) 검증 결과 — context7 spec 정합 부재 (commands 만 directory entry 허용)",
        "skills array 변경 = spec 안 STRING 명시 (array 미명시) → install validation FAIL 예상",
        "${CLAUDE_PLUGIN_ROOT} = hooks command path 안 사용 (spec 정합), paths field 안 사용 spec 부재",
        "alternative 시도 모두 spec 정합 부재 → 부분 fix 또는 FAIL 위험"
      ]
    },
    {
      "id": "D",
      "name": "Hybrid — skills 만 표준 구조 재배치 + agents 는 현 구조 유지 (paths 명시 보존)",
      "pros": [
        "skills 1 of 5 root cause (2단계 sub-dir nested) 명확 해소 — bootstrap/skills/{audit,dev-tools}/<skill>/SKILL.md → bootstrap/skills/<skill>/SKILL.md 평탄화",
        "agents 0 = 별 root cause (paths 명시 인식 부재) — 추가 진단 의무, 본 milestone 안 scope 분리",
        "scope 작음 (skills 5 디렉토리 평탄화 + plugin.json skills 명시 보존 + cascade 일부 host)",
        "Skills 인식 정합 PASS → Agents 부분 drift carry-over (별 milestone 또는 본 milestone phase-2)"
      ],
      "cons": [
        "Agents 0 fix 부재 = success_criteria sc_1 PASS 부재 (부분 PASS 만)",
        "category 차원 (audit / dev-tools) 손실 — skill 5건 flat 안 평탄화",
        "agents 부분 drift 보존 — 후속 cycle 추가"
      ]
    },
    {
      "id": "E",
      "name": "Hybrid 두 단계 — skills 평탄화 (Option D) + agents 표준 구조 재배치 (plugin_root/agents/ 안 7 .md 거주, paths 부재 default 인식 활용)",
      "pros": [
        "Skills 인식 1 of 5 → 5 of 5 PASS (skills 평탄화 default)",
        "Agents 인식 0 → 7 PASS (plugin_root/agents/ standard location 안 거주, paths 부재 default 인식 활용)",
        "Spec 표준 구조 정합 (default 인식 활용) — paths 형식 spec drift 부재",
        "scope 중간 (5 skill 평탄화 + 7 agents 재배치 + plugin.json paths 부재 + cascade narrative)"
      ],
      "cons": [
        "디렉토리 재배치 큼 (bootstrap/agents/audit/<7 .md> → agents/<7 .md> flat / bootstrap/skills/<cat>/<skill>/ → skills/<skill>/ flat = 12 파일 git mv + bootstrap/ 정체성 narrative 변경)",
        "category 차원 (audit / dev-tools / team / standalone) 손실 — narrative cascade 안 별도 정전화 의무",
        "agents team CLAUDE.md (project-harness-audit-team/CLAUDE.md) + bootstrap/agents/CLAUDE.md 위치 의문 (디렉토리 폐지 시 cascade narrative 어디?)"
      ]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "risk": "디렉토리 재배치 (Option A/E) — git mv 안 .md 파일 이동 시 모든 cross-ref 깨짐 (CLAUDE.md / README.md / ROADMAP.md 안 path narrative 11+ host 동시 갱신 의무)",
      "potential_impact": "smoke-cross-ref FAIL + pre-commit 14 hook FAIL + 사용자 onboarding flow narrative drift"
    },
    {
      "id": "R2",
      "risk": "category (audit / dev-tools / team) 차원 손실 — skill/agent flat 평탄화 시 분류 narrative 디렉토리 위치 부재 → bootstrap/CLAUDE.md / claude-code-catalog/README.md 안 category 명시 narrative 의무",
      "potential_impact": "narrative cascade drift 잠재 — sub-section 안 category 명시 + 매트릭스 갱신 의무"
    },
    {
      "id": "R3",
      "risk": "Symlink 옵션 (Option B) — Windows Developer Mode 의무 (v4.1 narrative 정합) + symlink 정합성 검증 dual-active 운용",
      "potential_impact": "사용자 환경 의존 onboarding 마찰, dual-active drift 검증 smoke 신규 의무"
    },
    {
      "id": "R4",
      "risk": "Alternative 형식 (Option C) — install FAIL 위험 (v5.0 phase-1 안 검증 결과 agents 디렉토리 entry FAIL 사례 + skills array 형식 spec 미명시)",
      "potential_impact": "본 milestone Stage F EXECUTE 안 fix 시도 시점 install FAIL → 추가 cycle 진입"
    },
    {
      "id": "R5",
      "risk": "team CLAUDE.md (project-harness-audit-team/CLAUDE.md) 위치 의문 — team 디렉토리 폐지 시 team orchestration narrative 거주 위치 결정 의무 (e.g., bootstrap/agents/CLAUDE.md 흡수 / 신규 docs/agents/team-orchestration.md)",
      "potential_impact": "team orchestration narrative 거주 host 결정 미확정 시 사용자-facing host 안 narrative drift"
    },
    {
      "id": "R6",
      "risk": "v5.0 Stage G 안 R1 mitigation 패턴 정합 — fix 후 본 milestone Stage G 안 실 install 검증 mandatory (spec drift 잠재 재발 위험 → 'context7 spec 정합' 만 의존 부재)",
      "potential_impact": "Stage G 안 실 install + claude plugin details 결과 첨부 의무 누락 시 R1 mitigation 패턴 회귀"
    },
    {
      "id": "R7",
      "risk": "Hybrid 두 단계 (Option E) phase 분할 안 phase-1 (skills 평탄화) commit 후 phase-2 (agents 재배치) 진행 시 — 중간 시점 산출물 인식 부분 PASS 만 (skills 5 / agents 0) → CI 안 verify 만족 부재 위험",
      "potential_impact": "phase-1 commit 후 사용자 실 install 시 중간 상태 노출 (skills 5 / agents 0 부분 PASS) — Stage F EXECUTE 안 phase 분할 narrative 정확 명시 의무"
    },
    {
      "id": "R8",
      "risk": "bootstrap/ 정체성 narrative 변경 — 현재 'bootstrap subagent + skill 컨테이너' 명시 narrative 가 plugin_root/agents/ + /skills/ 표준 위치 재배치 시 폐지 → bootstrap 자체 폐지 또는 다른 책임 명시 의무",
      "potential_impact": "사용자-facing host (CLAUDE.md root + bootstrap/CLAUDE.md) 안 narrative 큼 변경 + v4.0 ~ v5.0 narrative cascade context7 정전화 정합 보존 의무"
    }
  ]
}
```

## narrative

본 RESEARCH 의 핵심 결과 = **root cause 분리 명확**:

1. **Skills 1 of 5** = sub-dir nested 2단계 (`{path}/{category}/{skill}/SKILL.md`) 안 거주 → spec '{path}/{skill}/SKILL.md' 1단계 표준 미부합 (확실).
2. **Agents 0** = paths array entry 안 7 .md 명시 형식 정합 + cache 거주 정확. 그러나 인식 0 — paths 명시 자체 동작 부재 추정 OR 표준 위치 (plugin_root/agents/) 의무 추정.
3. **Hooks (2) 인식 PASS** = 본 milestone scope 외 (보존).
4. **MCP servers (0)** = manifest 안 명시 부재 (정합 expected).

## Options 비교 핵심

| ID | scope | spec 정합 | category 보존 | Agents fix | Skills fix |
|:-:|:-----:|:--:|:--:|:--:|:--:|
| A | 큼 | PASS | 손실 | PASS | PASS |
| B | 중간 | PASS | 부분 | PASS | PASS |
| C | 작음 | FAIL | 보존 | FAIL? | FAIL |
| D | 작음 | PASS | 손실 (skills) | FAIL | PASS |
| E | 중간 | PASS | 손실 | PASS | PASS |

핵심 trade-off = 'category 차원 보존' vs 'spec 표준 구조 정합'. Option C 는 spec drift 위험 → 회피. Option B 는 dual-active 복잡 → 회피. **Option A / D / E 가 유력 후보**, DESIGN 단계 결정.

## category 차원 narrative cascade 흡수

bootstrap/agents/{category}/ + bootstrap/skills/{category}/ 디렉토리 안 거주 category 차원 손실 시 — 다음 host 안 sub-section 안 category 명시 narrative 흡수:

- `bootstrap/agents/CLAUDE.md` — 매트릭스 안 column 추가 (category: standalone / team)
- `bootstrap/skills/CLAUDE.md` — 매트릭스 안 column 추가 (category: audit / dev-tools)
- `bootstrap/claude-code-catalog/README.md` — catalog narrative 안 category 명시
- `projects/meta/ARCHITECTURE.md` § 3.1 — plugin manifest narrative + category 표지

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- v5.0 R1 발견 source: [`../v5.0/VERIFY.md`](../v5.0/VERIFY.md) § "manual_checks D9 step 3"
- v4.3 Plugin spec RESEARCH: [`../v4.3/RESEARCH.md`](../v4.3/RESEARCH.md)
- Plugin manifest 현 상태: [`../../../../.claude-plugin/plugin.json`](../../../../.claude-plugin/plugin.json)
- bootstrap 디렉토리 현 상태: `bootstrap/agents/audit/` (2 standalone + 1 team sub-dir 5 멤버) + `bootstrap/skills/` (audit 3 + dev-tools 2)
