---
id: milestone-v5.1-design
title: DESIGN v5.1
version: v5.1
stage: DESIGN
status: completed
---

# DESIGN — v5.1 plugin-component-discovery-fix

## Spec

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "Option E 채택 — agents ./agents/ flat 재배치 + skills ./skills/{name}/ flat 재배치",
      "rationale": "RESEARCH options A/D/E 중 sc_1 (Agents ≥7) + sc_2 (Skills ≥5) 동시 PASS 가능 유일 옵션. Option D (skills만) 는 sc_1 PASS 불가. Option A와 Option E는 실질 동일 (full reorg) — 명칭 E 유지. Option B (symlink) = Windows Developer Mode 의존 + dual-active 복잡 = 회피. Option C (alternative format) = v5.0 agents directory entry FAIL 실증 + skills array spec 미명시 = 회피.",
      "alternatives_rejected": [
        "Option A (Option E와 실질 동일, 명칭만 다름)",
        "Option B (symlink, Windows 의존)",
        "Option C (alternative format, spec drift 위험)",
        "Option D (skills만, sc_1 FAIL)"
      ]
    },
    {
      "id": "D2",
      "decision": "plugin.json `agents` 필드 제거 — standard discovery (./agents/*.md) 활용",
      "rationale": "Standard Plugin Directory Structure 정합: plugin_root 안 agents/ 표준 위치 = Claude Code default discovery. paths 명시 형식 (bootstrap/agents/audit/*.md) 이 Agents (0) 인식 실패한 근본 원인 = 표준 위치 외 경로 명시. 제거 후 default discovery 활용 = spec 표준 구조 정합 + paths 형식 drift 위험 제거.",
      "alternatives_rejected": [
        "agents 필드 유지 + 경로만 ./agents/*.md 로 변경 (동일 효과이나 불필요 명시)"
      ]
    },
    {
      "id": "D3",
      "decision": "plugin.json `skills` `./bootstrap/skills/` → `./skills/` 변경",
      "rationale": "skills root cause = 2단계 nested sub-dir (bootstrap/skills/{cat}/{skill}/SKILL.md) → 1단계만 인식. ./skills/ 로 변경 + skills dir flat 재배치 (./skills/{name}/SKILL.md) = spec '{path}/{skill}/SKILL.md' 1단계 정합. skills 필드는 STRING 유지 (spec: STRING path to directory).",
      "alternatives_rejected": [
        "skills 필드 제거 + standard discovery (동일 효과이나 skills = ADD-TO-DEFAULT 정책 명시 보존 목적으로 유지)",
        "skills 재배치 없이 paths만 변경 (2단계 nested 해소 불가)"
      ]
    },
    {
      "id": "D4",
      "decision": "team CLAUDE.md → agents/project-harness-audit-team/CLAUDE.md 이동 (subdir within agents/)",
      "rationale": "bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md = 팀 오케스트레이션 narrative (5 멤버 + D8 sequence). agents/ 재배치 시 팀 컨텍스트 co-location 유지 = agents/project-harness-audit-team/CLAUDE.md. Claude Code 가 발견하지 않음 (CLAUDE.md = agent .md 아님) → 발견 대상 외. claude/commands/harness-meta.md cross-ref 갱신 의무.",
      "alternatives_rejected": [
        "bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md 원위치 유지 (agents/ 재배치 후 경로 분리 → narrative co-location 손실)"
      ]
    },
    {
      "id": "D5",
      "decision": "bootstrap/agents/CLAUDE.md + bootstrap/skills/CLAUDE.md 원위치 유지 (narrative-only 컨테이너), Phase 3 안 내부 구조 서술 갱신 포함",
      "rationale": "bootstrap/agents/CLAUDE.md = 에이전트 fleet 매트릭스 (4 case conflict + 5 case fleet evolution) 원천 narrative — harness-gap-analyzer.md 가 text reference (functional dependency). bootstrap/skills/CLAUDE.md = 스킬 구조 narrative. 두 파일 모두 executable agent/skill .md 아님 → 이동 의무 없음. agents 이동 후 bootstrap/agents/audit/ 디렉토리는 CLAUDE.md 만 잔존 (narrative container). **Phase 3 필수**: bootstrap/agents/CLAUDE.md 안 '신규 subagent 추가 절차 Step 2' + 디렉토리 구조 서술 (`bootstrap/agents/<category>/<name>/` → `agents/<name>/`) 갱신 — agents 재배치 후 구조 서술 drift 방지.",
      "alternatives_rejected": [
        "bootstrap/agents/CLAUDE.md → agents/CLAUDE.md (harness-gap-analyzer text reference 변경 의무 추가, 미이동으로 회귀 위험 최소화)"
      ]
    },
    {
      "id": "D6",
      "decision": "내부 상대경로 업데이트 — environment-auditor.md, agents-md-sync.md, component-installer.md, team CLAUDE.md 안 깨진 상대경로 수정",
      "rationale": "Phase 1 agent 재배치 후 markdown link 경로 깨짐 발생: (1) environment-auditor.md + agents-md-sync.md 안 `../CLAUDE.md` → `../bootstrap/agents/CLAUDE.md` (2) component-installer.md 안 `../../../../projects/meta/milestones/v4.1/REPORT.md` → `../projects/meta/milestones/v4.1/REPORT.md` (3) team CLAUDE.md 안 `../../CLAUDE.md` → `../../bootstrap/agents/CLAUDE.md`, `../../../claude-code-catalog/README.md` → `../../bootstrap/claude-code-catalog/README.md`, `../../../../projects/meta/milestones/v4.0/DESIGN.md` → `../../projects/meta/milestones/v4.0/DESIGN.md`. 기능적 영향 없음 (text reference 는 절대 경로 사용) — 그러나 markdown link 정합성 유지 의무.",
      "alternatives_rejected": [
        "상대경로 수정 생략 (smoke-cross-ref FAIL 잠재 위험)"
      ]
    }
  ],
  "phases": [
    {
      "n": 1,
      "title": "agents 재배치 — 7 agent .md git mv → ./agents/ flat + team CLAUDE.md → agents/project-harness-audit-team/ + 내부 경로 fix + plugin.json agents 필드 제거",
      "scope": "agent .md 7건 git mv (bootstrap/agents/audit/ → agents/ flat) + team CLAUDE.md git mv (bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md → agents/project-harness-audit-team/CLAUDE.md) + 내부 상대경로 fix 4건 + plugin.json agents 필드 제거",
      "affected_files": [
        "bootstrap/agents/audit/environment-auditor.md → agents/environment-auditor.md (+ ../CLAUDE.md 상대경로 fix)",
        "bootstrap/agents/audit/agents-md-sync.md → agents/agents-md-sync.md (+ ../CLAUDE.md 상대경로 fix)",
        "bootstrap/agents/audit/project-harness-audit-team/project-scanner.md → agents/project-scanner.md",
        "bootstrap/agents/audit/project-harness-audit-team/harness-gap-analyzer.md → agents/harness-gap-analyzer.md",
        "bootstrap/agents/audit/project-harness-audit-team/claude-docs-mapper.md → agents/claude-docs-mapper.md (+ bootstrap/agents/<cat>/<name>/ instruction text 갱신 → agents/<name>/)",
        "bootstrap/agents/audit/project-harness-audit-team/component-proposer.md → agents/component-proposer.md",
        "bootstrap/agents/audit/project-harness-audit-team/component-installer.md → agents/component-installer.md (+ ../../../../projects/ 상대경로 fix)",
        "bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md → agents/project-harness-audit-team/CLAUDE.md (+ 3건 상대경로 fix)",
        ".claude-plugin/plugin.json (agents 필드 제거)",
        "projects/meta/milestones/v5.1/execute/phase-1.md"
      ],
      "rationale": "agents 인식 (0) root cause 해소 — standard location (./agents/) 재배치 + plugin.json agents 필드 제거 (default discovery). phase-1 commit 후 Plugin 재install 시 Agents 카운트 개선 기대.",
      "risks": [
        "R1 cross-ref 깨짐 — 내부 상대경로 fix 4건 동시 처리로 mitigate",
        "bootstrap/agents/audit/ 디렉토리 empty 잔존 — phase-1 commit 후 rmdir (git rm 불필요)"
      ]
    },
    {
      "n": 2,
      "title": "skills 재배치 — 5 skill dirs git mv → ./skills/ flat + plugin.json skills 갱신",
      "scope": "5 skill 디렉토리 git mv (bootstrap/skills/{cat}/{name}/ → skills/{name}/) + plugin.json skills 필드 ./skills/ 갱신",
      "affected_files": [
        "bootstrap/skills/audit/ai-ready-scorer/ → skills/ai-ready-scorer/ (SKILL.md + references/rubric.md 포함)",
        "bootstrap/skills/audit/harness-plan-verify/ → skills/harness-plan-verify/",
        "bootstrap/skills/audit/harness-roadmap-update/ → skills/harness-roadmap-update/",
        "bootstrap/skills/dev-tools/mindvault/ → skills/mindvault/",
        "bootstrap/skills/dev-tools/developer-profile/ → skills/developer-profile/",
        ".claude-plugin/plugin.json (skills ./bootstrap/skills/ → ./skills/)",
        "projects/meta/milestones/v5.1/execute/phase-2.md"
      ],
      "rationale": "skills 인식 (1 of 5) root cause 해소 — 2단계 nested → 1단계 flat. {skills_path}/{skill}/SKILL.md 표준 정합.",
      "risks": [
        "R2 category 차원 손실 — bootstrap/skills/CLAUDE.md narrative 갱신으로 mitigate (phase-3)",
        "bootstrap/skills/ 안 cat dirs empty 잔존 — phase-2 commit 후 정리"
      ]
    },
    {
      "n": 3,
      "title": "cascade narrative + CHANGELOG — 활성 host 8건 갱신 + [v5.1] entry 추가",
      "scope": "bootstrap/agents/CLAUDE.md + bootstrap/skills/CLAUDE.md narrative 갱신 + claude/commands/harness-meta.md team CLAUDE.md 경로 갱신 + GUARDRAILS.md + claude/CLAUDE.md + CLAUDE.md (root) + AGENTS.md + projects/meta/ARCHITECTURE.md + CHANGELOG.md",
      "affected_files": [
        "bootstrap/agents/CLAUDE.md (agents 위치 narrative 갱신 — audit/ 서브디렉토리 → agents/ root)",
        "bootstrap/skills/CLAUDE.md (skills 위치 narrative 갱신 — {cat}/{skill}/ → skills/{skill}/)",
        "claude/commands/harness-meta.md (team CLAUDE.md 경로 갱신 → agents/project-harness-audit-team/CLAUDE.md)",
        "GUARDRAILS.md (bootstrap/skills/** → skills/**)",
        "claude/CLAUDE.md (bootstrap/agents/CLAUDE.md 참조 갱신 → ../bootstrap/agents/CLAUDE.md, 또는 위치 유지 시 불변)",
        "CLAUDE.md (root — bootstrap/agents/ + bootstrap/skills/ path narrative 갱신)",
        "AGENTS.md (영문 cascade)",
        "projects/meta/ARCHITECTURE.md (§ 3.1 plugin manifest paths narrative 갱신)",
        "bootstrap/claude-code-catalog/README.md (agent 경로 참조 갱신 — bootstrap/agents/audit/project-harness-audit-team/*.md → agents/*.md)",
        "CHANGELOG.md ([v5.1] entry: Fixed Plugin component discovery spec drift)",
        "projects/meta/milestones/v5.1/execute/phase-3.md"
      ],
      "rationale": "Phase 1+2 재배치 후 활성 host 안 경로 narrative drift 제거 (sc_5 정합). CHANGELOG sc_7 정합.",
      "risks": [
        "R1 cascade 누락 — grep 검증 (agents/|skills/ 신 경로 + bootstrap/agents/audit/ 구 경로 잔존) 으로 mitigate"
      ]
    }
  ]
}
```

## Milestone

v5.1_plugin-component-discovery-fix

## Approach

Option E 채택 — agents 표준 위치 (./agents/) 재배치 + skills 1-level flat 재배치 (./skills/{name}/) + plugin.json paths 정합 갱신 (agents 필드 제거 + skills ./skills/). 3 phase: agents 재배치 → skills 재배치 → cascade narrative.

## Risk mitigation

- risk: R1 — git mv 후 cross-ref 깨짐; mitigation: Phase 1 + 2 각 commit 전 smoke-cross-ref 통과 확인. 내부 상대경로 fix D6 목록 4건 Phase 1 안 동시 처리. Phase 3 안 grep 검증 (old path 잔존 부재 확인).
- risk: R2 — category 차원 손실; mitigation: bootstrap/agents/CLAUDE.md + bootstrap/skills/CLAUDE.md 안 category 명시 매트릭스 갱신 (Phase 3). agents/ 안 standalone (environment-auditor, agents-md-sync) + team (project-scanner 등 5건) 구분 narrative 보존.
- risk: R6 — Stage G 실 install 검증 mandatory; mitigation: Phase 1 commit 후 + Phase 2 commit 후 claude plugin marketplace add + install + details 실행 (중간 상태 + 최종 상태 모두 검증). Stage G VERIFY 안 claude plugin details 결과 첨부.
- risk: A2 assumption — local marketplace source (`claude plugin marketplace add ~/harness-meta`) 시 plugin_root 가 로컬 repo 그대로인지 vs cache 복사본인지 spec 비명시; mitigation: Stage G VERIFY 실 install 후 cache 내 파일 구조 확인 (`~/.claude/plugins/cache/harness-meta/agents/`, `~/.claude/plugins/cache/harness-meta/skills/`) — 복사본 정합 여부 검증.
- risk: R7 — Phase 1 후 중간 상태 (Agents N / Skills 1) 노출; mitigation: Phase 1 commit 후 Agents 카운트 개선 예상 (0 → 7). Phase 2 commit 후 Skills 카운트 개선 예상 (1 → 5). 중간 상태 Stage F execute/phase-1.md 안 명시.

## narrative

본 DESIGN 의 핵심 = **표준 위치 재배치 + default discovery 활용**. v5.0 안 paths 명시 형식 (bootstrap/agents/audit/*.md) 이 Agents (0) 인식 실패의 근본 원인 — spec 표준 위치 (./agents/) 외 경로 명시. skills 는 2단계 nested sub-dir (bootstrap/skills/{cat}/{skill}/SKILL.md) 이 1단계 표준 미부합 (./skills/{skill}/SKILL.md) 의 root cause.

**Option E = 표준 위치 재배치 3 phase**: Phase 1 (agents → ./agents/ flat) → Phase 2 (skills → ./skills/ flat) → Phase 3 (cascade narrative).

**cascade narrative 범위** — 활성 host 8건 (archived milestone 제외): bootstrap/agents/CLAUDE.md + bootstrap/skills/CLAUDE.md + claude/commands/harness-meta.md + GUARDRAILS.md + claude/CLAUDE.md + CLAUDE.md (root) + AGENTS.md + ARCHITECTURE.md. CHANGELOG.md [v5.1] 추가.

**bootstrap/ 역할 변화** — executable .md 파일 이동 후 bootstrap/agents/ = CLAUDE.md narrative-only 컨테이너 (audit/ 서브디렉토리 비활성). bootstrap/skills/ = CLAUDE.md narrative-only 컨테이너 (category 서브디렉토리 비활성). bootstrap/claude-code-catalog/ = 불변.

## 5 관점 검토 (scope 큰 = 16+ files → 5 관점 전체)

5 관점 subagent 병렬 검토 후 결과 흡수 — 아래 섹션에 기록.

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- Plugin manifest 현 상태: [`../../../../.claude-plugin/plugin.json`](../../../../.claude-plugin/plugin.json)
- bootstrap 현 구조: bootstrap/agents/audit/ (2 standalone + 1 team-subdir 5멤버) + bootstrap/skills/ (audit 3 + dev-tools 2)
