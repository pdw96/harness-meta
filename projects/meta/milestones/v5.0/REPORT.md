# REPORT — v5.0 plugin-pivot

```json
{
  "summary": "v5.0_plugin-pivot 완료 — harness-meta repo 자체를 Claude Code Plugin 으로 변환 (breaking major bump v4→v5). `.claude-plugin/plugin.json` (manifest, paths 명시) + `.claude-plugin/marketplace.json` (local marketplace) + `claude/hooks/hooks.json` (Plugin schema PostToolUse + SessionStart matcher) 3건 신규 + 14 host cascade narrative 정전화 ('deprecated since v5.0, v5.0+ 환경에서는 비활성' 표지 + claude plugin install 표준 명령 narrative) + component-installer agent 책임 분리 (custom component lifecycle 보존 + Plugin install lifecycle Claude Code CLI 위임) + CHANGELOG [v5.0]! breaking entry + bootstrap/claude-code-catalog/README.md.bak cleanup. v4.3_subagent-discovery-path-research RESEARCH 결과 (Plugin spec local source + paths 자동 인식) 직접 후속 + v4.0_harness-composer-pivot 정체성 (ecosystem integrator 책임 강화) 정합. 3 phase 4 commits (phase-1 5505010 + phase-2 e7ec60f + phase-3 1차 markdownlint MD032 FAIL + phase-3 251063e 재 commit PASS). 5 관점 검토 (architecture / spec-drift / 회귀 risk / 보안 / scope contract) 전체 PASS 또는 PASS_WITH_COMMENTS + 7 권고 모두 흡수. VERIFY verdict = PASS_WITH_PARTIAL_DRIFT (8 PASS + 2 PASS_WITH_PARTIAL_DRIFT + 1 PENDING_AT_PROPOSE). 핵심 fix 3건 (marketplace.json source='./' + plugin.json agents 개별 명시 + hooks.json wrapper 객체) 모두 검증 과정 안 즉시 보정. Agents (0) + Skills (1 of 5) 인식 부족 = paths 명시 sub-dir nested 인식 spec drift = 후속 v5.1 cleanup carry-over.\n\n본 v5.0 = v4.3 narrative 정전화 3 단계 패턴 8 번째 cycle + 두 번째 major bump (v4.0 정체성 pivot 직접 후속). lightweight 모드 11/23 = 47.8% (본 milestone 은 lightweight 아님 — 18 affected_files scope 큼). 도그푸드 narrative — 본 milestone 자체가 Plugin install lifecycle 채택 후 첫 milestone, plugin 안 거주 narrative 자기참조 cycle. 14 host cascade 정합 = v3.21 패턴 누적 8 cycle 완성.\n\n사용자 결정 1 round 4 question 모두 Recommended 채택 (D1 O1 + D2 deprecation 표지 + D3 manual cleanup 권고 + D4 3 phase 분할) — v4.x 패턴 (round 1 명시 + Recommended 채택) 누적 5 번째 (v4.0~v4.3 + v5.0).",
  "delta": {
    "files_changed": 14,
    "files_added": 6,
    "files_deleted": 1,
    "lines_added_approx": 280,
    "lines_deleted_approx": 90,
    "net_loc_approx": 190,
    "commits": 4,
    "phase_breakdown": [
      {
        "phase": 1,
        "commit": "5505010",
        "title": "Plugin manifest + onboarding cascade 3 host + hooks.json 신규",
        "files_added": [".claude-plugin/plugin.json", ".claude-plugin/marketplace.json", "claude/hooks/hooks.json", "projects/meta/milestones/v5.0/execute/phase-1.md"],
        "files_modified": ["README.md", "AGENTS.md", "CLAUDE.md"],
        "lines_changed": "174 insertions / 19 deletions"
      },
      {
        "phase": 2,
        "commit": "e7ec60f",
        "title": "내부 narrative cascade 10 host",
        "files_added": ["projects/meta/milestones/v5.0/execute/phase-2.md"],
        "files_modified": ["claude/CLAUDE.md", "bootstrap/agents/CLAUDE.md", "bootstrap/skills/CLAUDE.md", "projects/meta/ARCHITECTURE.md", "tests/CLAUDE.md", "Makefile", ".env.example", "claude/commands/harness-meta.md", "GUARDRAILS.md", "bootstrap/claude-code-catalog/README.md"],
        "lines_changed": "144 insertions / 52 deletions"
      },
      {
        "phase": 3,
        "commit": "251063e (1차 commit markdownlint MD032 FAIL → fix 후 재 commit PASS)",
        "title": "D7 책임 분리 + CHANGELOG [v5.0]! breaking entry + README.md.bak cleanup",
        "files_added": ["projects/meta/milestones/v5.0/execute/phase-3.md"],
        "files_modified": ["bootstrap/agents/audit/project-harness-audit-team/component-installer.md", "bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md", "CHANGELOG.md"],
        "files_deleted": ["bootstrap/claude-code-catalog/README.md.bak"],
        "lines_changed": "102 insertions / 55 deletions"
      }
    ],
    "modules_affected": [
      "`.claude-plugin/` (신규 디렉토리, manifest 2건)",
      "`claude/hooks/` (hooks.json 신규)",
      "사용자-facing onboarding (README + AGENTS + root CLAUDE.md)",
      "내부 narrative (bootstrap/agents + skills CLAUDE.md, claude/CLAUDE.md, ARCHITECTURE.md, GUARDRAILS.md, Makefile, .env.example, tests/CLAUDE.md, claude/commands/harness-meta.md, bootstrap/claude-code-catalog/README.md)",
      "audit-team source-of-truth (component-installer.md + team CLAUDE.md)",
      "CHANGELOG"
    ]
  },
  "lessons_learned": [
    {
      "id": "L1",
      "lesson": "R1 mitigation 'Stage G VERIFY 실 검증 mandatory' = 핵심 정합 검증 패턴 — Plugin manifest spec drift (agents array entry 디렉토리 invalid + hooks.json wrapper 객체 부재 + marketplace.json source '.' invalid) 3건 모두 Stage G 안 실 `claude plugin marketplace add` + `claude plugin install` 실행 시점에 발견 + 즉시 보정. DESIGN.D6 narrative 'Stage G VERIFY 실 검증 mandatory (optional 확인 아님)' 정합 — 본 검증 패턴이 다른 spec-drift milestone (Plugin / MCP / 표준 spec 의존) 안 표준 패턴 정전화 잠재.",
      "scope": "spec-drift 검증 패턴 (외부 표준 spec 의존 milestone 안 일반 적용)",
      "actionable_follow_up": "narrative 거명만 — v5.0 도그푸드 평가 후 사용자 명시 결정"
    },
    {
      "id": "L2",
      "lesson": "claude plugin validate 결과 = 1 발견 = 깊은 stack drift, 마이너 fix 3건 모두 narrative 변경 부재 + 코드 (JSON) 만 변경 = scope-creep 위반 부재. context7 검증 결과 부분 spec drift (sub-dir nested 인식 + agents 디렉토리 entry + marketplace single plugin source 형식) 모두 검증 시점 fix 가능 = RESEARCH (R1/R3) mitigation narrative 정확 정합. context7 검증 결과 absolute 100% 정합 부재 = 자연 — 실 plugin install 시점 mandatory verification 의무 narrative 강화.",
      "scope": "Plugin spec drift 본질 (context7 검증 + 실 install 두 단계)"
    },
    {
      "id": "L3",
      "lesson": "5 관점 검토 7 권고 모두 narrative 1~3 줄 보정 수준 + DESIGN 안 흡수 완료 후 EXECUTE 진입 = 5 관점 검토 패턴 효과 + 5 관점 의견 충돌 0 + FAIL 0 발견 = scope 18+ 파일 안 5 관점 자연 효과. v5.0 = scope 큼 (18 파일) 5 관점 전체 검토 첫 적용 milestone (v4.x 는 4 관점 + 3 관점 lightweight).",
      "scope": "5 관점 검토 trigger 조건 narrative (scope 16+ 의무)"
    },
    {
      "id": "L4",
      "lesson": "v3.21 narrative 정전화 3 단계 패턴 8 번째 cycle 완성 — DESIGN cascade 표준 narrative 정확 문구 1차 source (`cascade 표준 narrative` section 안 deprecation 표지 + cleanup 권고 + onboarding 표준 + 핵심 키워드 3건) + EXECUTE Edit tool 안 정확 문구 그대로 삽입 (14 host) + VERIFY grep 키워드 검증 (51 occurrence 분포). v3.18 + v3.20 + v3.21 + v4.1 + v4.2 + v4.3 + v4.4 v5.0 = 8 cycle 누적. 패턴 본질 = scope 큼 cascade narrative 정전화 시 drift 회피 표준.",
      "scope": "narrative 정전화 3 단계 패턴 (cascade 큰 host 안 default 적용)"
    },
    {
      "id": "L5",
      "lesson": "v4.0 정체성 pivot (첫 major bump) → v4.1~v4.3 (1.5 cycle 안 직접 후속) → v5.0 plugin-pivot (두 번째 major bump) = 3 단계 cycle 완성. v4.0 = 정체성 정전화 + agent fleet 신규 + install script 폐기. v4.1 = install 전략 재검토. v4.2 = verify/sync agent 흡수. v4.3 = Plugin spec 발견 RESEARCH. v5.0 = Plugin 전면 채택 + 14 host cascade. v5.0 자체 narrative = v4.0 ecosystem integrator 정체성 강화 + v4.3 RESEARCH 직접 적용. ecosystem integrator 정체성의 본질 = Claude Code 표준 메커니즘 (Plugin spec) 채택 = 본 cycle 완성.",
      "scope": "정체성 pivot cycle (v4.0~v5.0 narrative 정합)"
    },
    {
      "id": "L6",
      "lesson": "사용자 결정 round 1 안 4 question Recommended 모두 채택 패턴 누적 5 번째 (v4.0~v4.3 + v5.0). Round 1 명시 + Recommended 채택 = 사용자 결정 진영 가독성 + decision overhead 낮음 + DESIGN 권고 직접 흡수 = v3.x 패턴 (round 다회 + 옵션 비교) 와 다른 v4.0+ 패턴. AskUserQuestion preview field 사용 부재 (본 milestone 안) = simple 옵션 비교 1~5 줄 description 충분.",
      "scope": "AskUserQuestion 운영 원칙 narrative (v4.0+ round 1 패턴)"
    },
    {
      "id": "L7",
      "lesson": "Agents (0) + Skills (1 of 5) 인식 부족 = paths 명시 sub-dir nested 인식 spec drift = R1 mitigation 안 'Stage G VERIFY 실 검증 mandatory' 정합 발견. 본 drift 의 본질 = Plugin spec 안 `agents` 필드 = array of .md path 만 valid + array entry 안 디렉토리 entry invalid (commands 와 다름) + sub-dir nested SKILL.md 인식 부분 (top-level 1건만 인식). 후속 v5.1 cleanup carry-over narrative = paths 형식 추가 검증 (context7 또는 실 plugin 예시 codebase scan) + alternative 옵션 (agents/ root flat symlink 또는 ${CLAUDE_PLUGIN_ROOT} 변수 활용). 사용자 명시 결정 후 ROADMAP 등재 (e3 정책 정합).",
      "scope": "Plugin paths nested 인식 spec drift (R1 후속 carry-over)"
    },
    {
      "id": "L8",
      "lesson": "phase-3 markdownlint MD032 FAIL → 재 commit PASS 패턴 = pre-commit hook 안 markdownlint 의 list blank line 강제 = v3.x 패턴 정합 (v3.21 phase-1.md JSON 'phase' 필드 누락 → smoke FAIL 비슷한 fix 후 재 commit). 본 milestone 안 1차 commit 직후 markdownlint FAIL = scope 큼 cascade narrative 안 자연 발생 risk = pre-commit hook 의 자연 검증 효과 + 즉시 fix 가능 (Edit + 재 commit).",
      "scope": "pre-commit markdownlint 강제 패턴 (cascade narrative 안 자연 발생 risk)"
    }
  ]
}
```

## narrative

본 v5.0_plugin-pivot 의 핵심 성과 — **harness-meta repo 가 Claude Code Plugin 으로 변환 완료** (두 번째 major bump). v4.3 RESEARCH 안 'Plugin spec local source 발견' narrative 가 v5.0 안 실 적용 + 14 host cascade 정전화 + 사용자 onboarding flow 표준 CLI 채택. 핵심 fix 3건 모두 검증 시점 즉시 보정 = R1 mitigation 정합 + scope-creep 위반 0.

## v3.21 narrative 정전화 3 단계 패턴 8 번째 cycle 완성

- (a) DESIGN `cascade 표준 narrative` section 안 정확 문구 1차 source (deprecation 표지 + cleanup 권고 + onboarding 표준 + 핵심 키워드 3건)
- (b) phase-1/phase-2/phase-3 EXECUTE Edit tool 안 정확 문구 그대로 삽입 (14 host)
- (c) Stage G VERIFY grep 키워드 검증 (51 occurrence 분포 across 14 host)

누적: v3.18 (단일 source) + v3.20 (drift narrative) + v3.21 (패턴 정전화) + v4.1 (install 전략) + v4.2 (verify/sync 흡수) + v4.3 (Plugin spec 발견) + v5.0 (Plugin 전면 채택) = 7 cycle 누적 (count 보정: 본 v5.0 안 narrative 안 'v3.21 8 번째 cycle 완성' 명시 — v3.18~v5.0 7 milestone + v3.21 본질 = 패턴 자체 정전화 시점). 사실 진술 = narrative 정전화 패턴 효과 검증 누적 cycle.

## v4.0~v5.0 정체성 pivot 3 단계 cycle 완성

- **v4.0** (2026-05-13) — 정체성 정전화 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) + agent fleet 신규 (project-harness-audit-team 5 멤버) + install script 3개 폐기
- **v4.1** (2026-05-13) — install 전략 재검토 (Option D Junction Windows + Symlink Linux/macOS + D7 5 step) + 12 host cascade
- **v4.2** (2026-05-14) — verify/sync 6 script 폐기 + 2 standalone subagent 신규 (environment-auditor + agents-md-sync)
- **v4.3** (2026-05-14) — Plugin spec 발견 RESEARCH (context7 4 source 검증) + v5.0 pending entry 등재
- **v5.0** (2026-05-14) — Plugin 전면 채택 + 14 host cascade + 2 major bump 완성

## 후속 forward 거명 (PROPOSE 단계 narrative 흡수 의무, 본 REPORT 안 거명만)

- **v5.1_plugin-component-discovery-fix** (잠재) — Agents (0) + Skills (1 of 5) 인식 부족 fix. context7 추가 검증 + paths 형식 fix (alternative 옵션 검토). 사용자 명시 결정 후 ROADMAP 등재.

(REPORT.md 안 forward propose 책임 부재, v3.10 부산물 정책 정합 — 후속 candidate 본질 narrative = Stage I PROPOSE 단일 source.)

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- APPROVE: [`APPROVE.md`](APPROVE.md)
- VERIFY: [`VERIFY.md`](VERIFY.md)
- PROPOSE: 다음 작성 — [`PROPOSE.md`](PROPOSE.md)
- ROADMAP entry (status: in_progress → completed 갱신 의무, Stage I): [`../../ROADMAP.md`](../../ROADMAP.md)
- v4.3 RESEARCH 직접 source: [`../v4.3/RESEARCH.md`](../v4.3/RESEARCH.md)
- v4.0 정체성: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.1
