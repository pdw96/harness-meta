# DESIGN — v4.0

```json
{
  "version": "v4.0",
  "id": "harness-composer-pivot",
  "approach": "B2 (전면 재설계, 8 phase) + B3 (install script 3개 폐기 + agent 흡수) + 옵션 3 team 단독 5 멤버. 8 phase = 1 commit each (도그푸드 정합, 큰 phase 안 2 commit 허용 — phase-3 책임 분할 시). Stage F EXECUTE 진입 전 APPROVE 게이트 + 5 관점 self-review (lightweight 거부 — § 6.2 폐지 milestone 본질). 도그푸드 자연 — 본 milestone 자체가 'agent 가 mechanical 흡수' 첫 적용 (phase-3 안 install script 폐기 시 메인 Claude 가 Bash 직접 진행).",
  "decisions": [
    {
      "id": "D1",
      "topic": "5 멤버 team 의 정확한 prompt + tools allowlist",
      "decision": "각 멤버 = frontmatter (name + description + tools + model) + 짧은 system prompt (≤ 50 line each). tools 정확 할당: project-scanner [Read, Glob, Grep], harness-gap-analyzer [Read, Grep, Bash], claude-docs-mapper [mcp__plugin_context7_context7__resolve-library-id, mcp__plugin_context7_context7__query-docs, WebFetch], component-proposer [Write], component-installer [Bash, Edit, Read]. model default = sonnet (component-installer 만 opus — write 위험 책임)",
      "rationale": "code.claude.com/docs/en/sub-agents 권장 (yaml frontmatter + 짧은 prompt). e3 정책 정합 — proposer (write proposal-only) ≠ installer (write apply). 메인 Claude orchestrator 가 멤버 호출 sequence 결정"
    },
    {
      "id": "D2",
      "topic": "bootstrap/agents/ 카테고리 (audit/+dev-tools/ skills 패턴 정합 vs 차별)",
      "decision": "audit/ + dev-tools/ 카테고리 — bootstrap/skills/ 패턴 정확 정합. project-harness-audit-team/ 은 audit/ 하위 (sub-team 디렉토리, 멤버 5 markdown). 신규 sub-category 도입 검토 시 5+ team 누적 후",
      "rationale": "기존 글로벌 skill 패턴 정확 mirror — 학습 비용 0. project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer / component-installer = audit team 본질"
    },
    {
      "id": "D3",
      "topic": "Claude Code 도구 카탈로그 매뉴얼 host",
      "decision": "`bootstrap/claude-code-catalog/README.md` 단일 host — bootstrap/ 하위 신규 디렉토리. plugin/MCP 인벤토리 + built-in slash command 인벤토리 + context7 사용 예 + query 카탈로그 모두 통합",
      "rationale": "단일 source 정합 (v1.4_cross-ref-propagation 패턴). bootstrap/plugins/ vs bootstrap/built-in-slash/ 같이 분산하면 cross-ref drift risk. claude-docs-mapper subagent 가 본 host 1차 source 로 인지"
    },
    {
      "id": "D4",
      "topic": "벤치마크 cycle routine 산출물 host",
      "decision": "projects/meta/ROADMAP.md 안 candidate_draft[] 신규 필드 (또는 별도 `projects/meta/candidates.md` 파일). schedule routine 결과는 ROADMAP candidate draft 자동 append → 사용자 명시 결정 후 milestones[] 정식 등재",
      "rationale": "본 repo 자체에 issue tracker 없음 (GitHub issues 미사용 또는 별도 host 부재). ROADMAP candidate_draft[] 가 자연 host — 9-stage workflow 의 ROADMAP 입력 source 본질 정합. 사용자 검토 cycle = candidate_draft → milestones[] (사용자 결정 시점)"
    },
    {
      "id": "D5",
      "topic": "/harness-meta <name> --audit 분기 정확 위치",
      "decision": "claude/commands/harness-meta.md Stage A OPEN entry 안 conditional 분기 — `if (--audit flag present) then call project-harness-audit-team; else freeform default`. Stage A 단일 진입점 (Stage B INTENT 진입 전 audit team 호출 + proposal 산출 + 사용자 결정 → INTENT 안 흡수)",
      "rationale": "Stage A 가 milestone 컨테이너 마운트 + ROADMAP entry 위치 — audit team 호출 결과가 INTENT motivation 자연 입력. Stage B 안 호출하면 INTENT 작성 후 audit 결과 cascade 부담"
    },
    {
      "id": "D6",
      "topic": "도그푸드 audit run 형태 (phase-8)",
      "decision": "Manual — 메인 Claude 가 phase-8 안 직접 audit team 호출 (Agent tool, subagent_type='project-harness-audit-team' 또는 멤버별 sequence). 결과 = VERIFY.md 안 도그푸드 섹션 (proposal draft 보존, v4.1+ 후속 candidate 만 거명). scripted (CI 자동) 회피 — in-loop 처리 risk 표지",
      "rationale": "도그푸드 결과는 v4.0 자체 도구 동작 evidence — manual 진행이 결과 합리성 검증 자연. scripted 시 audit-team 이 audit-team 자신 추가 멤버 제안하는 모순 무한 가능"
    },
    {
      "id": "D7",
      "topic": "component-installer mechanical 작업 sequence",
      "decision": "(1) backup 우선 — 기존 ~/.claude/<category>/<name>/ 존재 시 ~/.claude/backups/<category>/<name>.<YYYYMMDD-HHMMSS>/ git mv (또는 Move-Item) (2) symlink 시도 — Bash `New-Item -ItemType SymbolicLink -Path ~/.claude/<category>/<name> -Target <repo>/bootstrap/<category>/<name>` (3) symlink 실패 (권한 또는 OS) 시 copy fallback — `Copy-Item -Recurse -Force` (4) cleanup retention — default retain 3 backup + grace 7 days, --yes flag 으로 실 삭제 (default dry-run)",
      "rationale": "기존 install-skills.{ps1,sh} 6 element 패턴 정확 재현 (B3 폐기 후 agent 가 동등 책임). symlink 우선 = 디스크 절약 + git 즉시 반영, copy fallback = Windows 권한 부재 안전망. backup retention = 사용자 환경 보호"
    },
    {
      "id": "D8",
      "topic": "5 멤버 team orchestration sequence",
      "decision": "순차 (scanner → analyzer → mapper → proposer → 사용자 명시 결정 → installer). 메인 Claude orchestrator 가 단계별 결과 다음 멤버 prompt 입력 + 사용자 결정 게이트 between proposer 와 installer. 병렬 X (각 단계 결과 다음 단계 입력 의존)",
      "rationale": "audit 본질 = pipeline (scan → analyze → map → propose → apply). 병렬 = 결과 cascade drift risk. 사용자 게이트 between proposer/installer = e3 정책 핵심 (propose ≠ apply)"
    },
    {
      "id": "D9",
      "topic": "첫 진입 (~/.claude/ 비어있을 때) onboarding entry wording",
      "decision": "README.md + root CLAUDE.md 안 1줄 instruction — '본 repo clone 후 Claude Code 안에서 `harness-meta 설치해줘` 자연어 호출 → 메인 Claude 가 Bash (PowerShell New-Item -ItemType SymbolicLink) 로 자동 진행'. install script 폐기 narrative 직후 + 'Claude Code (https://code.claude.com/docs) 설치 필수' 1줄",
      "rationale": "신규 사용자 진입 장벽 최소화 — install command 1줄 < script 폐기 후 사용자 자율 추론 부담. Claude Code 안 자연어 = 본 repo 정체성 정합"
    }
  ],
  "phases": [
    {
      "phase": 1,
      "title": "Identity 5 host 재작성 + § 6.2 폐지 + 3 host 안 install narrative cleanup 통합 (옵션 B)",
      "affected_files": [
        "projects/meta/ARCHITECTURE.md (§ 3.1 끝에 'harness-meta repo 정체성' paragraph 추가 + § 6.2 line 182~205 완전 제거 + § 6.1 끝 폐지 표지 1줄)",
        "root CLAUDE.md (line 3~4 정체성 paragraph + line 56 install.ps1 narrative cleanup + line 75~96 설치 섹션 cleanup — D9 onboarding entry 1줄)",
        "AGENTS.md (line 3 영문 tagline + line 7~15 Commands 섹션 install reference cleanup — D9 onboarding entry 1줄)",
        "README.md (line 3 영문 tagline + line 28~63 Installation 섹션 cleanup + line 113~117 Directory layout install reference cleanup — D9 onboarding entry 1줄)",
        "projects/meta/CLAUDE.md (정체성 cross-ref 갱신 — 5요소 매트릭스 cross-ref 확장)"
      ],
      "narrative": "옵션 B 책임 재분담 (사용자 round 9) — phase-1 + phase-3 가 같은 host (root CLAUDE.md / AGENTS / README) 두 번 Edit 회피. phase-1 = identity layer 정전화 (paragraph + 관련 install narrative cleanup 통합). 단일 source = ARCHITECTURE § 3.1 끝 'harness-meta repo 정체성' paragraph. 다른 4 host = cross-ref + 짧은 sketch (v1.4_cross-ref-propagation 패턴 정합). § 6.2 폐지 후 cross-ref (v3.6/v3.10/v3.11/v3.13~v3.21 entry) 들은 phase-2 _archive 이전으로 자동 무력화"
    },
    {
      "phase": 2,
      "title": "메타 v1.0~v3.21 → _archive/ git mv + ROADMAP era 표지 + smoke sentinel 검증",
      "affected_files": [
        "projects/meta/milestones/v1.0_*/ ~ v3.21/ (27 디렉토리 전체 git mv)",
        "projects/meta/milestones/_archive/ (신규 디렉토리)",
        "projects/meta/milestones/_archive/v{X.Y}_*/ 또는 v{X.Y}/ (이전 후 위치)",
        "projects/meta/ROADMAP.md (milestones[] 안 entry 별도 archive 섹션 분리 또는 archived_at_v4 필드)",
        "tests/smoke-projects-scope-discipline.sh 또는 동치 (smoke 안 _archive/ skip 검증, 신규 추가 또는 기존 sentinel 정합)"
      ],
      "narrative": "git mv 일괄 (per-directory) + `git log --follow` per-file 검증 (history 보존 ≥ 95%). v4.0/ 자체는 archive 외 위치 (`projects/meta/milestones/v4.0/`). ROADMAP entry 들 status 'completed' 유지하되 archive 섹션 분리 표지"
    },
    {
      "phase": 3,
      "title": "bootstrap layer 재구성 — bootstrap/agents/ scaffold + CLAUDE.md 정책 narrative + install script 3개 폐기 + bootstrap/skills/CLAUDE.md cleanup (옵션 B 후속)",
      "affected_files": [
        "bootstrap/agents/ (신규 디렉토리)",
        "bootstrap/agents/audit/ (신규 placeholder)",
        "bootstrap/agents/dev-tools/ (신규 placeholder)",
        "bootstrap/agents/CLAUDE.md (신규 — 두 층 + conflict 4 case + fleet 5 case + install/update/cleanup 책임 narrative, D7 sequence 명시)",
        "install.ps1 (삭제 — B3)",
        "install-skills.ps1 (삭제 — B3)",
        "install-skills.sh (삭제 — B3)",
        "bootstrap/skills/CLAUDE.md (배포 섹션 narrative cleanup — install-skills 폐기 + agent 책임 이전)"
      ],
      "narrative": "옵션 B 후속 — phase-3 책임 = bootstrap layer 재구성 본질만 (root CLAUDE.md / AGENTS / README 안 install narrative cleanup 은 phase-1 안 통합). 의미 단위 = bootstrap 신규 + install layer 폐기 + skills CLAUDE.md cleanup. 2 commit 허용 (1: bootstrap/agents/ scaffold + CLAUDE.md / 2: install script 3개 삭제 + bootstrap/skills/CLAUDE.md cleanup)"
    },
    {
      "phase": 4,
      "title": "Claude Code 도구 카탈로그 매뉴얼",
      "affected_files": [
        "bootstrap/claude-code-catalog/README.md (신규 — D3 host)"
      ],
      "narrative": "통합 인벤토리 = code.claude.com/docs 페이지 목록 + built-in slash command (예: /init, /loop, /schedule, /security-review 등) + plugin/MCP (현 활성: context7, github, playwright, Google Drive) + 자주 묻는 query 카탈로그 ≥ 3건 (subagents / hooks / agent-teams) + context7 사용 예 코드 snippet"
    },
    {
      "phase": 5,
      "title": "첫 agent team `project-harness-audit-team` 5 멤버 + orchestration narrative",
      "affected_files": [
        "bootstrap/agents/audit/project-harness-audit-team/ (신규 디렉토리)",
        "bootstrap/agents/audit/project-harness-audit-team/project-scanner.md (D1 frontmatter + prompt)",
        "bootstrap/agents/audit/project-harness-audit-team/harness-gap-analyzer.md",
        "bootstrap/agents/audit/project-harness-audit-team/claude-docs-mapper.md",
        "bootstrap/agents/audit/project-harness-audit-team/component-proposer.md",
        "bootstrap/agents/audit/project-harness-audit-team/component-installer.md (D1 + Bash + Edit tools)",
        "bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md (D8 orchestration sequence + e3 게이트 narrative)"
      ],
      "narrative": "5 멤버 markdown 각 ≤ 50 line (frontmatter 10 + system prompt 40). CLAUDE.md = orchestration sequence + 사용자 게이트 between proposer 와 installer 명시. ~/.claude/agents/audit/project-harness-audit-team/ 으로 component-installer 가 1회 install (도그푸드 first apply)"
    },
    {
      "phase": 6,
      "title": "/harness-meta <name> --audit opt-in 동작 변경",
      "affected_files": [
        "claude/commands/harness-meta.md (D5 Stage A 안 --audit conditional 분기 추가)"
      ],
      "narrative": "기존 freeform 동작 보존 (회귀 0). --audit flag 명시 시 Stage A OPEN entry 직후 audit team 호출 → proposal draft → 사용자 결정 → INTENT motivation 자연 흡수 → 나머지 9-stage 정상 진행"
    },
    {
      "phase": 7,
      "title": "벤치마크 cycle routine — schedule skill 주 1회",
      "affected_files": [
        "bootstrap/agents/CLAUDE.md (벤치마크 routine narrative 추가 — schedule skill 활용 + 산출물 ROADMAP candidate_draft[] append)",
        "projects/meta/ROADMAP.md (candidate_draft[] 신규 필드 + D4 host narrative)"
      ],
      "narrative": "사용자 환경 안 schedule skill 호출 = `~/.claude/scheduled_tasks` 안 cron entry — 본 repo 외부. 매뉴얼 narrative 만 본 repo 에 보존. 산출물 = candidate_draft[] append → 사용자 결정 후 milestones[] 정식 등재 (e3 정책)"
    },
    {
      "phase": 8,
      "title": "CHANGELOG breaking + 도그푸드 검증",
      "affected_files": [
        "CHANGELOG.md (신규 [v4.0] entry — breaking `!` 마커 + 8 결정 narrative)",
        "README.md (semver major bump narrative)",
        ".harness.toml schema (필요 시 1.1 → 2.0 — 본 repo 의 .harness.toml 부재 시 skip)",
        "projects/meta/milestones/v4.0/VERIFY.md (도그푸드 audit run 결과 보존)"
      ],
      "narrative": "도그푸드 manual (D6) — 메인 Claude 가 audit team 호출 (Agent tool subagent_type 또는 멤버 순차) + 결과 합리성 확인 (모순 case 회피, v4.1+ 후속 candidate 만 거명). CHANGELOG entry breaking `!` 마커 + 8 결정 cascade"
    }
  ],
  "risk_mitigation": {
    "(1) 5 host identity cascade drift": "단일 source = ARCHITECTURE § 3 + 4 host cross-ref 1줄 (v1.4_cross-ref-propagation 선례). phase-1 안 wording 자기 검토 — 5 host grep cross-ref 통일",
    "(2) § 6.2 폐지 후 자기참조 재발": "새 정체성이 자연 가드레일 — 자기참조 milestone 자체가 새 정체성에 부합 안 함. B2 scope 자체가 본질 직접 구현 + 도그푸드 정합",
    "(3) git mv history 보존 ≥ 95%": "phase-2 안 `git log --follow <file>` per-file 검증 step + `git config diff.renames=true` 활용. directory 단위 mv 후 5 sample 파일 history trace 검증",
    "(4) smoke 회귀 (_archive/ sentinel)": "tests/_inactive/ 선례 grep + phase-2 안 smoke 직접 실행 확인 step (smoke-projects-scope-discipline.sh 등 active 6 + inactive 22 + _archive 신규 sentinel)",
    "(5) install-agents ↔ install-skills 충돌": "B3 채택으로 자체 소멸 — 둘 다 폐기 (decision 7). component-installer agent 가 단일 책임",
    "(6) phase-5 LOC 비대화": "5 멤버 markdown 각 ≤ 50 line (frontmatter 10 + system prompt 40). bootstrap/agents/CLAUDE.md = 단일 source narrative (매트릭스 + orchestration). 총 phase-5 LOC ~500 cap",
    "(7) /harness-meta --audit 동작 회귀": "phase-6 안 conditional 분기 (`if --audit then call team else freeform`). freeform default 유지 — 기존 호출자 회귀 0",
    "(8) 벤치마크 cycle 산출물 host 미정": "D4 결정 — ROADMAP candidate_draft[] 신규 필드 (또는 projects/meta/candidates.md 분리 host)",
    "(9) 도그푸드 audit run 결과 모순": "D6 결정 — manual run + 모순 case 는 v4.1+ 후속 candidate 만 거명, in-loop 처리 금지. phase-8 narrative 명시",
    "(10) CHANGELOG breaking `!` 마커 cascade": "phase-8 안 root README + CHANGELOG + .harness.toml schema 영향 grep 검증. breaking 마커 단일 source = CHANGELOG.md",
    "(11) 첫 진입 onboarding 자연성": "D9 결정 — README + root CLAUDE.md 안 1줄 instruction (Claude Code 안 자연어 호출). 추가 검증 = 새 clone 시뮬레이션 (선택)",
    "(12) 기존 ~/.claude/skills/ 5 symlink 보존": "phase-3 narrative 안 migration step 명시 — 기존 symlink 보존 (현 동작 유효), 신규 component / cleanup 필요 시 component-installer 또는 메인 Claude 호출. 단순 deletion 금지"
  },
  "review_perspectives": {
    "architecture": {
      "verdict": "pass-with-comments",
      "comments": [
        "5 멤버 team orchestration sequence (D8) 순차 vs 병렬 — proposer 단계까지 read-only 이므로 scanner/analyzer/mapper 병렬 가능. 그러나 단순성 우선 순차 유지",
        "bootstrap/claude-code-catalog/ (D3) 신규 디렉토리 vs bootstrap/agents/CLAUDE.md 안 흡수 — 별도 디렉토리가 단일 source 정합 (cross-ref drift risk 회피)",
        "D7 component-installer sequence = install-skills.{ps1,sh} 패턴 정확 재현 = 동등성 100% — agent 흡수 후에도 사용자 환경 회귀 0"
      ],
      "absorbed": ["D8 narrative 안 병렬 가능성 표지 추가 (실제 sequence 는 순차 default)"]
    },
    "spec-drift": {
      "verdict": "pass-with-comments",
      "comments": [
        "5 host identity paragraph 단일 source (ARCHITECTURE § 3) + 4 host cross-ref 1줄 = v1.4_cross-ref-propagation 패턴 정확 정합",
        "§ 6.2 폐지 후 cross-ref (v3.6/v3.10/v3.11/v3.13~v3.21) 자동 무력화 — 추가 cleanup 불필요 (phase-2 _archive 이전 효과)",
        "ROADMAP candidate_draft[] 신규 필드 (D4) = ROADMAP schema 확장 — schema_note 필드 갱신 필요 (phase-7 안 흡수)"
      ],
      "absorbed": ["phase-7 narrative 안 ROADMAP schema_note 갱신 명시 (candidate_draft[] 필드 정의 추가)"]
    },
    "regression_risk": {
      "verdict": "pass-with-comments",
      "comments": [
        "smoke 회귀 (risk 4) = _archive/ sentinel 미작동 시 active 6 + inactive 22 분류 깨짐. mitigation 명확 (tests/_inactive/ 선례)",
        "기존 ~/.claude/skills/ 5 symlink 보존 (risk 12) = 사용자 환경 회귀 0. install-skills.ps1 폐기 후 reinstall 필요 시 component-installer 호출",
        "/harness-meta <name> --audit 분기 (D5) conditional 분기 — freeform default 유지 = 기존 호출자 회귀 0"
      ],
      "absorbed": []
    },
    "security": {
      "verdict": "pass-with-comments",
      "comments": [
        "component-installer write 권한 (Bash New-Item SymbolicLink / Copy-Item / Remove-Item) = 사용자 환경 ~/.claude/ 직접 수정 — 위험 책임 비대. mitigation: e3 게이트 (사용자 명시 결정 직후만 호출) + backup 우선 (D7 sequence step 1) + model='opus' 할당 (D1) — 위험 책임 격상",
        "install script 폐기 후 새 보안 표면 = component-installer subagent prompt injection. mitigation: subagent prompt = read-only 입력 (proposer 결과만), Bash 명령 화이트리스트 (New-Item / Copy-Item / Remove-Item / Move-Item 만)",
        "schedule skill cron entry 권한 = 사용자 환경 ~/.claude/scheduled_tasks. 본 repo 외부 — 위험 표면 분리됨"
      ],
      "absorbed": ["D1 narrative 안 component-installer Bash 명령 화이트리스트 명시 (system prompt 안 'allowed commands: New-Item, Copy-Item, Remove-Item, Move-Item only')"]
    },
    "scope_contract": {
      "verdict": "pass",
      "comments": [
        "INTENT.success_criteria 16건 ↔ DESIGN.phases 8건 매핑 검증:",
        "  - (1) ↔ phase-1 (identity 5 host)",
        "  - (2) ↔ phase-1 (§ 6.2 폐지)",
        "  - (3) ↔ phase-2 (_archive git mv)",
        "  - (4) ↔ phase-2 (upbit 보존)",
        "  - (5)(11)(12) ↔ phase-3 (bootstrap/agents/CLAUDE.md narrative)",
        "  - (6) ↔ phase-3 (install script 3개 폐기)",
        "  - (7) ↔ phase-4 (Claude Code 도구 카탈로그)",
        "  - (8) ↔ phase-5 (5 멤버 team)",
        "  - (9) ↔ phase-6 (/harness-meta --audit)",
        "  - (10) ↔ phase-7 (벤치마크 routine)",
        "  - (13) ↔ phase-1~8 (pre-commit 14 hook PASS)",
        "  - (14) ↔ phase-8 (semver major bump)",
        "  - (15) ↔ phase-8 (도그푸드 검증)",
        "  - (16) ↔ phase-2 + phase-8 (ROADMAP era 표지)",
        "16 ↔ 8 매핑 완전, 누락 0, 영역 침범 0 (Stage I PROPOSE 안 흡수 책임 § 6.2 폐지 후에도 narrative 유지 — Stage B/C/D 부산물 정책)"
      ],
      "absorbed": []
    }
  },
  "review_summary": "5 관점 self-review 모두 pass / pass-with-comments. 의견 충돌 0. 흡수 권고 3건 (architecture D8 병렬 가능성 표지 / spec-drift phase-7 schema_note 갱신 / security D1 Bash 화이트리스트 명시) — 본 DESIGN.md 안 직접 반영 완료. lightweight 모드 거부 (§ 6.2 폐지 milestone 본질) — full 5 관점 검토 진행 (subagent 호출 X, self-review narrative 보존)"
}
```

## Phase 1 정확 narrative 정문구 (1차 source)

본 subsection 은 phase-1 EXECUTE 안 Edit tool 정확 삽입 대상 narrative. 문구 수정 시 본 source 직접 수정 → phase-1 cascade.

### projects/meta/ARCHITECTURE.md § 3.1 끝 추가 paragraph

```markdown
**harness-meta repo 정체성** (v4.0_harness-composer-pivot, 2026-05-13): 본 repo 는 위 working definition 을 적용하는 구체 instance — **project harness composer + Claude Code ecosystem integrator + agent fleet maintainer**. 대상 프로젝트를 분석하고 [code.claude.com/docs](https://code.claude.com/docs/) 의 Claude Code 도구 카탈로그 (docs + built-in slash command + plugin/MCP) 를 활용하여 적재적소 harness 구성요소 (subagent / agent team / hook / skill / slash command / statusline / MCP server / plugin) 를 만들어 배치한다. mechanical install/update/cleanup 도 agent (`component-installer`) 가 직접 담당 — static install script 부재. GitHub 인기 저장소 + Claude Code release notes 를 정기 벤치마크하여 업그레이드 검토 + agent fleet 자체 lifecycle (scope 확장 / 분할 / 신규 / 통합 / 삭제) 도 관리. 글로벌 자산은 `bootstrap/` 하위, 프로젝트 특화 자산은 `projects/<name>/.claude/` 하위 **두 층 구조**. Custom 과 built-in 충돌 / fleet evolution 모두 `audit → propose → 사용자 명시 결정 → apply` (e3) 적용. 자세히: [`milestones/v4.0/INTENT.md`](milestones/v4.0/INTENT.md).
```

### projects/meta/ARCHITECTURE.md § 6.1 끝 추가 § 6.2 폐지 표지

```markdown
**§ 6.2 폐지 narrative** (v4.0_harness-composer-pivot, 2026-05-13): 구 § 6.2 "Lightweight 모드 정책 (v3.6_overengineering-audit 도입)" + "Workflow self-improvement milestone 동결 정책" + "Narrative 정전화 3단계 패턴" + 선례 2건 모두 v4.0 정체성 재정의로 폐지. 새 정체성 (§ 3.1 끝 paragraph) 이 자연 가드레일 — 자기참조 workflow self-improvement milestone 자체가 새 정체성에 부합 안 함. 본 § 6.2 cross-ref (v3.6 / v3.10 / v3.11 / v3.13 ~ v3.21 entry) 들은 v4.0 phase-2 안 `projects/meta/milestones/_archive/` 이전으로 자동 무력화. 자세히: [`milestones/v4.0/INTENT.md`](milestones/v4.0/INTENT.md) + [`milestones/v4.0/DESIGN.md`](milestones/v4.0/DESIGN.md).
```

### root CLAUDE.md line 3~4 갱신 (정체성 sketch + cross-ref)

```markdown
Claude Code 하네스의 **project harness composer + Claude Code ecosystem integrator + agent fleet maintainer**. 대상 프로젝트를 분석하고 [code.claude.com/docs](https://code.claude.com/docs/) 의 Claude Code 도구 카탈로그 (docs + built-in slash command + plugin/MCP) 를 활용하여 적재적소 harness 구성요소 (subagent / agent team / hook / skill / slash command / statusline / MCP server / plugin) 를 만들어 배치한다. mechanical install/update/cleanup 도 agent (`component-installer`) 가 흡수 — static install script 부재. 정전 정의: [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 3.1 끝.
```

### AGENTS.md line 3 갱신 (영문 tagline + cross-ref)

```markdown
**Project harness composer + Claude Code ecosystem integrator + agent fleet maintainer.** Analyzes target projects and composes appropriate harness components (subagent / agent team / hook / skill / slash command / statusline / MCP server / plugin) using the Claude Code tool catalog from [code.claude.com/docs](https://code.claude.com/docs/) (docs + built-in slash commands + plugin/MCP). Agent (`component-installer`) absorbs mechanical install/update/cleanup — no static install scripts. Canonical definition: [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 3.1 end.
```

### README.md line 3 갱신 (영문 tagline)

```markdown
> **Project harness composer + Claude Code ecosystem integrator + agent fleet maintainer** for Claude Code.
> Analyzes projects and composes appropriate harness components (subagent / agent team / hook / skill / slash command / MCP) using the Claude Code tool catalog. Agent absorbs mechanical install — no static install scripts.
> Operational manual (Korean): [`CLAUDE.md`](CLAUDE.md) · Agent context: [`AGENTS.md`](AGENTS.md) · Canonical definition: [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 3.1 end.
```

### projects/meta/CLAUDE.md 갱신 (정체성 cross-ref 확장)

```markdown
**하네스 엔지니어링 정의** (정전 single source): [`ARCHITECTURE.md`](ARCHITECTURE.md) § 3 — working definition + 5요소 매트릭스 (Context / Workflow / Constraint / Verification / Trace) + § 3.1 끝 `harness-meta repo 정체성` paragraph (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer, v4.0 도입). 신규 milestone 발의는 본 정의 5요소 중 하나에 매핑.
```

### Onboarding entry (root CLAUDE.md + README + AGENTS 안 install 섹션 대체)

```markdown
**설치** (clone 후 1회): 본 repo 를 `$HOME/harness-meta/` 에 clone 후 Claude Code 안에서 자연어로 `harness-meta 설치해줘` 호출 → 메인 Claude 가 Bash (PowerShell `New-Item -ItemType SymbolicLink`) 로 `~/.claude/{commands,hooks,statusline,skills,agents}/` 자동 구성. static install script 부재 — agent (`component-installer`) 가 mechanical 작업 흡수 (v4.0 B3).
```

## approach

**B2 + B3 + 옵션 3 + 5 멤버** 통합 접근. 8 phase = 도그푸드 정합 1 commit each (phase-3 큰 책임 시 2 commit 허용 — bootstrap scaffold + install 폐기 분리). 각 phase 안 success_criteria 1~3건 매핑. APPROVE 게이트 후 EXECUTE 진입. VERIFY 시 도그푸드 audit run (D6 manual) 결과 보존.

## 9 decisions

위 JSON `decisions[]` 명시. 핵심:

| ID | Topic | 채택 |
|---|---|---|
| D1 | 5 멤버 tools allowlist | scanner/analyzer/mapper [read-only] + proposer [Write proposal] + installer [Bash+Edit, opus model] |
| D2 | bootstrap/agents/ 카테고리 | audit/ + dev-tools/ (skills 패턴 정합) |
| D3 | 도구 카탈로그 host | `bootstrap/claude-code-catalog/README.md` 단일 |
| D4 | 벤치마크 산출물 host | `projects/meta/ROADMAP.md` candidate_draft[] 신규 필드 |
| D5 | `--audit` 분기 위치 | Stage A OPEN entry 안 conditional |
| D6 | 도그푸드 형태 | Manual (phase-8) — scripted 회피 |
| D7 | installer mechanical sequence | backup → symlink 시도 → copy fallback → cleanup (retain 3 / grace 7d / --yes 게이트) |
| D8 | team orchestration | 순차 (scanner → analyzer → mapper → proposer → 사용자 게이트 → installer), 병렬 가능 narrative 표지 |
| D9 | 첫 진입 onboarding | README + root CLAUDE.md 안 'harness-meta 설치해줘' 1줄 instruction |

## 8 phases (affected_files)

위 JSON `phases[]` 명시. 핵심 affected_files 추적:

- **phase-1**: 5 host (root CLAUDE.md + ARCHITECTURE.md + AGENTS + README + projects/meta/CLAUDE.md)
- **phase-2**: 27 메타 디렉토리 git mv + ROADMAP + smoke
- **phase-3**: bootstrap/agents/ 신규 + 3 install script 삭제 + 4 host narrative cleanup (= 2 commit 허용)
- **phase-4**: bootstrap/claude-code-catalog/README.md 신규 1 파일
- **phase-5**: 5 멤버 markdown + CLAUDE.md orchestration (6 파일)
- **phase-6**: claude/commands/harness-meta.md 1 파일
- **phase-7**: bootstrap/agents/CLAUDE.md + ROADMAP schema_note 갱신
- **phase-8**: CHANGELOG + README + (.harness.toml) + VERIFY.md

총 변경 파일 ~50 (git mv 27 + 신규 ~15 + 수정 ~10 + 삭제 3).

## 12 risk_mitigation

위 JSON `risk_mitigation` 명시. RESEARCH 10 risks + 본 DESIGN 추가 2 risks (11 첫 진입 + 12 기존 symlink) 모두 phase 별 mitigation 분배.

## 5 관점 self-review

위 JSON `review_perspectives` 명시. 모두 pass / pass-with-comments. 흡수 권고 3건 본 DESIGN 안 직접 반영:

- architecture: D8 narrative 안 병렬 가능성 표지
- spec-drift: phase-7 안 ROADMAP schema_note 갱신
- security: D1 narrative 안 component-installer Bash 화이트리스트

의견 충돌 0. lightweight 모드 거부 (§ 6.2 폐지 milestone 본질) — full review 진행, subagent 호출 X (self-review narrative 보존).

## narrative

본 DESIGN 은 INTENT.success_criteria 16건 ↔ DESIGN.phases 8건 1:1 매핑 + 9 decisions + 12 risk_mitigation + 5 관점 self-review 통합. lightweight 모드 거부 — § 6.2 폐지 milestone 자체가 lightweight 정책 자체를 폐지하므로 full review 자연. 5 관점 self-review (subagent 호출 X) narrative 본 DESIGN.md 안 보존.

APPROVE.md 게이트 직후 EXECUTE 진입 — phase-1 부터 순차 + 각 phase 안 success_criteria 매핑 + 결과 phase-{n}.md 보존 + commit.

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- milestones: [`milestones.md`](milestones.md)
- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) `v4.0_harness-composer-pivot`
- 폐지 대상 paragraph: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2 (line 182~205)
- 정의 최종 host: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3
- context7 1차 source: `/websites/code_claude`
- agent teams docs: `https://code.claude.com/docs/en/agent-teams`
- subagents docs: `https://code.claude.com/docs/en/sub-agents`
- best practices: `https://code.claude.com/docs/en/best-practices`
- 폐기 대상 install script (B3): `../../../install.ps1` + `../../../install-skills.ps1` + `../../../install-skills.sh`
- 두 층 구조 reference: [`../../../bootstrap/skills/CLAUDE.md`](../../../bootstrap/skills/CLAUDE.md)
