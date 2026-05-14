# RESEARCH — v5.2 agent-functional-path-cleanup

```json
{
  "milestone": "v5.2_agent-functional-path-cleanup",
  "external": [
    {
      "source": "v5.1_plugin-component-discovery-fix REPORT.md + VERIFY.md",
      "topic": "v5.1 git mv 후 stale functional path 확인",
      "findings": "v5.1 Phase 1 (bootstrap/agents/audit/ → agents/ git mv) + Phase 2 (bootstrap/skills/{audit,dev-tools}/ → skills/ git mv) 완료. v5.1 cascade scope 9 host 갱신은 narrative 중심 (CLAUDE.md / AGENTS.md / README.md / claude/CLAUDE.md / bootstrap/agents/CLAUDE.md / bootstrap/skills/CLAUDE.md / ARCHITECTURE.md / tests/CLAUDE.md / component-installer.md cross-ref). agents/*.md 내부 functional audit path (실 audit/scan 시 glob 대상 경로) 는 cascade scope 외 → 본 milestone 의 fix 대상.",
      "drift": "v5.1 cascade scope 가 narrative 중심으로 좁게 정의됨 → functional path (hardcoded glob) 누락. 본 milestone 의 root cause 검증 결과 정합."
    },
    {
      "source": "Claude Code Plugin spec (.claude-plugin/plugin.json)",
      "topic": "현 plugin.json paths 명시 확인 (실 source-of-truth)",
      "findings": "plugin.json `\"agents\"` 필드 부재 (plugin_root `./agents/` default discovery), `\"skills\": \"./skills/\"` (add-to-default), `\"commands\": [\"./claude/commands/\"]`, `\"hooks\": \"./claude/hooks/hooks.json\"`. agents/*.md 내부 functional audit path 의 target = `agents/*.md` (7 멤버) + `skills/*/SKILL.md` (5 skill = 3 audit + 2 dev-tools 통합 1단계 flat).",
      "drift": "없음 — plugin.json 자체는 v5.1 phase-2 commit (2ea2c13) 후 정합."
    }
  ],
  "codebase": {
    "affected_files_pre_identified": [
      {
        "path": "agents/environment-auditor.md",
        "line": 74,
        "current_state": "대상 — `claude/commands/harness-meta.md` + `bootstrap/skills/audit/*/SKILL.md` + `bootstrap/skills/dev-tools/*/SKILL.md` + (v4.2 신규) `bootstrap/agents/audit/*.md`.",
        "target_state": "대상 — `claude/commands/harness-meta.md` + `skills/*/SKILL.md` + `agents/*.md`. (3 path → 2 path 통합)",
        "sc_ref": "sc_1"
      },
      {
        "path": "agents/harness-gap-analyzer.md",
        "line": 59,
        "current_state": "기존 fleet (`bootstrap/agents/audit/` + `bootstrap/agents/dev-tools/` + 프로젝트 특화 `projects/<name>/.claude/agents/`) 검토.",
        "target_state": "현 fleet (`agents/` + 프로젝트 특화 `projects/<name>/.claude/agents/`) 검토. (2 path → 1 path 통합)",
        "sc_ref": "sc_2"
      }
    ],
    "affected_files_research_discovered": [
      {
        "path": "agents/component-installer.md",
        "line": 31,
        "current_state": "신규 agent / skill / command 추가 시 `bootstrap/{agents,skills}/<category>/<name>/` 또는 `claude/{commands,hooks,statusline}/<name>` 안 .md / .sh 파일 신규 작성 ...",
        "target_state": "신규 agent / skill / command 추가 시 `agents/<name>.md` 또는 `skills/<name>/SKILL.md` 또는 `claude/{commands,hooks,statusline}/<name>` 안 .md / .sh 파일 신규 작성 ...",
        "sc_ref": "sc_4",
        "classification": "FUNCTIONAL_STALE — Step C1 narrative 안 신규 추가 위치 명시 stale"
      },
      {
        "path": "agents/component-installer.md",
        "line": 39,
        "current_state": "- `skills` 필드 = add-to-default + 디렉토리 명시 (`./bootstrap/skills/`) → 신규 sub-dir 자연 인식 (갱신 부재)",
        "target_state": "- `skills` 필드 = add-to-default + 디렉토리 명시 (`./skills/`) → 신규 sub-dir 자연 인식 (갱신 부재)",
        "sc_ref": "sc_4",
        "classification": "FUNCTIONAL_STALE — Step C2 narrative 안 plugin.json skills 필드 값 stale (실 plugin.json = `./skills/`)"
      },
      {
        "path": "bootstrap/claude-code-catalog/README.md",
        "line": 34,
        "current_state": "| `/docs/en/sub-agents` | subagent yaml frontmatter + `.claude/agents/` 구조 + tools allowlist | `bootstrap/agents/` 신규 멤버 작성 시 |",
        "target_state": "| `/docs/en/sub-agents` | subagent yaml frontmatter + `.claude/agents/` 구조 + tools allowlist | `agents/` 신규 멤버 작성 시 |",
        "sc_ref": "sc_4",
        "classification": "FUNCTIONAL_STALE (mild) — '신규 멤버 작성 위치' = agents/ flat (v5.1+), bootstrap/agents/ 아님"
      }
    ],
    "untouched_files_explicit": [
      "bootstrap/agents/CLAUDE.md (자기 디렉토리 meta 거명 4건 — narrative-only container 정책 narrative, HISTORICAL_NARRATIVE_OK)",
      "bootstrap/skills/CLAUDE.md (자기 디렉토리 meta 거명 4건 — narrative-only container 정책 narrative, HISTORICAL_NARRATIVE_OK)",
      "claude/CLAUDE.md L28, L86 (cross-ref bootstrap/{agents,skills}/CLAUDE.md, CROSS_REF_OK)",
      "agents/project-harness-audit-team/CLAUDE.md L5, L90, L93 (cross-ref bootstrap/agents/CLAUDE.md, CROSS_REF_OK)",
      "agents/agents-md-sync.md L145 (cross-ref bootstrap/agents/CLAUDE.md, CROSS_REF_OK)",
      "AGENTS.md L41, L52 (narrative + cross-ref, NARRATIVE_OK)",
      "CLAUDE.md (root) L17 (모듈 가이드 cross-ref, CROSS_REF_OK)",
      "projects/meta/ARCHITECTURE.md L46, L56 (트리 + cross-ref, NARRATIVE_OK)",
      "CHANGELOG.md (v5.0/v5.1 entry historical narrative, HISTORICAL_NARRATIVE_OK)",
      "tests/smoke-claude-md-drift.sh L22, L43 (smoke 검증 target = bootstrap/skills/CLAUDE.md 존재 = OK, FUNCTIONAL_LIVE)",
      "_archive/ 하위 모든 milestone 산출물 (historical, _archive/ 표지 = 정의적 historical, HISTORICAL_NARRATIVE_OK)"
    ],
    "empty_subdir_cosmetic": [
      "bootstrap/agents/audit/project-harness-audit-team/ (empty, git untracked)",
      "bootstrap/skills/audit/ (empty, git untracked)",
      "bootstrap/skills/dev-tools/ (empty, git untracked)"
    ]
  },
  "options": [
    {
      "id": "A",
      "label": "INTENT 사전 식별 2건만 fix (보수)",
      "pros": ["INTENT immutable 정합 strict", "scope 최소 1-phase 자연", "lightweight 모드 강 후보"],
      "cons": ["RESEARCH 발견 functional stale 3건 미해소 → 후속 B_regression 발의 필요", "sc_4 narrative ('functional path 잔존 시 추가 fix') 활용 부재"]
    },
    {
      "id": "B",
      "label": "INTENT 사전 식별 2건 + RESEARCH 발견 3건 fix (권장)",
      "pros": ["sc_4 narrative 정합 활용 — INTENT 안 'functional path 잔존 시 추가 fix' 사전 허용", "v5.1 cascade scope 누락 완전 해소", "후속 B_regression 발의 불요"],
      "cons": ["affected_files 2→5 확장, scope 1-phase 유지 가능하나 LOC 증가", "narrative drift fix 와 functional path fix 혼재"]
    },
    {
      "id": "C",
      "label": "Option B + empty subdir cleanup 흡수",
      "pros": ["file system 완전 정리", "사용자 cosmetic confusion 해소"],
      "cons": ["INTENT scope 외 (out_of_scope#2 'agent 책임 변경 / skill 추가 / Plugin spec 변경 — 본 milestone 은 path string 갱신만' narrative 와 약간 충돌 — empty dir 는 path 가 아님)", "git untracked 직접 rm 위험 (low)"]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "risk": "Stage F EXECUTE 시 affected file 내부 line 번호 변경 가능성",
      "rationale": "edit 결과 line 갯수 변경 → 다른 host 의 line ref 거명 영향. 단 RESEARCH 결과 다른 host 의 line ref 거명 0건 (모두 cross-ref by file path 또는 narrative)."
    },
    {
      "id": "R2",
      "risk": "smoke-claude-md-drift.sh 회귀 가능성",
      "rationale": "본 smoke 가 bootstrap/skills/CLAUDE.md 존재 검증 (L22, L43). 본 milestone 안 bootstrap/skills/CLAUDE.md 삭제 부재 → 회귀 0 예상."
    },
    {
      "id": "R3",
      "risk": "Option C empty subdir cleanup 시 git untracked 직접 rm 위험 (low)",
      "rationale": "bootstrap/{agents/audit, skills/audit, skills/dev-tools}/ 모두 empty + git untracked → rm 직접 안전. 단 Option C 채택 시만 적용."
    },
    {
      "id": "R4",
      "risk": "scope expansion (Option B/C) 시 phase 분할 결정 — Stage D",
      "rationale": "Option A → 1-phase 자연 / Option B → 1-phase (2+3 = 5 path) 또는 2-phase (사전+RESEARCH 분리) / Option C → 2-phase (path fix + empty dir cleanup 분리) — Stage D 결정 책임."
    },
    {
      "id": "R5",
      "risk": "agent component-installer.md fix 시 functional 동작 검증 어려움 (orchestration 의존)",
      "rationale": "component-installer agent 는 메인 Claude orchestration 의 일부. 단 본 milestone 의 fix 는 narrative path string 만 — agent 실 invoke 검증 sc_6 책임 아님 (sc_6 는 environment-auditor + harness-gap-analyzer 한정). Stage G 검증 시 component-installer.md 는 grep 만."
    }
  ]
}
```
