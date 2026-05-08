# RESEARCH — v1.0_workflow-redesign

```json
{
  "milestone": "v1.0_workflow-redesign",
  "external": [
    {
      "source": "user_design_intent",
      "topic": "7-stage workflow",
      "findings": "ROADMAP→MILESTONE→PLAN→RESEARCH→DESIGN→EXECUTE→VERIFY→REPORT. 단일 책임 분리. md+JSON 코드블록. v1.0 리셋. ROADMAP은 milestones 단일 배열(id/title/status/summary/trigger 5필드).",
      "drift": "none"
    },
    {
      "source": "Anthropic Claude Code spec",
      "topic": "CLAUDE.md @import + subdirectory on-demand load",
      "findings": "@path 형식의 import는 root CLAUDE.md에서 파일 path를 컨텍스트에 자동 로드. subdirectory CLAUDE.md는 해당 dir 작업 시 on-demand 로드. 새 root CLAUDE.md 작성 시 이 동작 가정 — @sessions/meta/ROADMAP.md 같은 import 제거 + ROADMAP.md(root)로 대체.",
      "drift": "none (Claude Code 4.x 공식 동작)"
    },
    {
      "source": "Anthropic Claude Code slash command spec",
      "topic": "frontmatter allowed-tools + description",
      "findings": "/harness-meta 슬래시 명령 frontmatter (allowed-tools / description / argument-hint) 유지 — 새 흐름은 본문 변경만. 6축 frontmatter 정책은 명령 하나라 영향 적음.",
      "drift": "none"
    },
    {
      "source": "pre-commit local hook spec",
      "topic": "files: 패턴 + always_run + pass_filenames 의미",
      "findings": "현재 4 local hook (smoke-spec-verification / scope-contract / cross-ref / claude-md-drift) 모두 sessions/ 또는 sessions/.*/...md 패턴에 매칭. sessions/ 삭제 후 trigger 안 되지만 hook 정의 자체에 sessions/ 잔존 → 의미 없는 hook. 삭제 또는 disable로 정리.",
      "drift": "none"
    }
  ],
  "codebase": {
    "affected_files": [
      "ROADMAP.md (create at root)",
      "CLAUDE.md (rewrite, root)",
      "AGENTS.md (rewrite)",
      "claude/CLAUDE.md (light update — bootstrap/templates ref 제거)",
      "claude/commands/harness-meta.md (rewrite)",
      "bootstrap/skills/CLAUDE.md (light update — 부모 ref 정리)",
      "projects/upbit/{DECISIONS,INTERVIEW,STACK}.md (delete, 3개)",
      "projects/upbit/ROADMAP.md (migrate to JSON)",
      "sessions/ (delete entire ~116 dirs, including sessions/CLAUDE.md)",
      "bootstrap/CLAUDE.md (delete)",
      "bootstrap/docs/ (delete entire 8 docs)",
      "bootstrap/interview.md, manifest-schema.md, render-manifest.sh, detect-project.sh (delete, 4개)",
      "bootstrap/install-project-claude.{ps1,sh} (delete, 2개)",
      "bootstrap/skeletons/ (delete entire — AGENTS/CLAUDE/CLAUDE.override/GUARDRAILS .tmpl + projects/ + sessions/)",
      "bootstrap/templates/ (delete entire — _base/, python/)",
      "milestones/v1.85_project-workflow-extension/ (delete, untracked)",
      "install.ps1 (line 134-135 — bootstrap/templates/_base + install-project-claude refs 제거)",
      "verify.ps1, verify.sh (sessions/ 검증 stage 제거)",
      ".pre-commit-config.yaml (sessions/-의존 4 local hook disable)"
    ],
    "untouched_files": [
      "bootstrap/skills/ (글로벌 user skills 5종 — ai-ready-scorer, developer-profile, harness-plan-verify, harness-roadmap-update, mindvault)",
      "claude/hooks/, claude/statusline/, claude/agents/, claude/output-styles/",
      "install-skills.{ps1,sh}, sync-agents.{ps1,sh}, verify-lib.{ps1,sh}",
      "tests/ (smoke 28종 + tests/CLAUDE.md — 본 milestone 후 별도 milestone)",
      "milestones/v1.84~v1.88/ (historical 4-tier 포맷 보존)",
      ".markdownlint.json, .markdownlintignore, .gitattributes, .gitignore"
    ],
    "current_state": "4-tier sessions/meta/{ROADMAP,116 vX.Y dirs} + sessions/upbit/ + milestones/v{1.84~1.88}_/ (4-tier 포맷) + projects/{upbit}/ 5종 + bootstrap/ 16개 docs/scripts + skeletons + templates. 총 200+ active 파일.",
    "target_state": "ROADMAP.md(root,JSON) + projects/{name}/{ARCHITECTURE,ROADMAP}.md + milestones/v{X.Y}_/{PLAN,RESEARCH,DESIGN,VERIFY,REPORT}.md + execute/phase-{n}.md. bootstrap/skills/ 유지. tests/ + claude/hooks 후속 milestone에서 갱신. ~30 active 파일."
  },
  "options": [
    {
      "option": "버전 v1.0 리셋",
      "pros": ["새 흐름 명확", "history 의미 분리"],
      "cons": ["과거 v1.x과 번호 중복 (milestones/ 내 historical로만 식별)"]
    },
    {
      "option": "v1.89 연속",
      "pros": ["history 단조 증가"],
      "cons": ["완전 다른 흐름인데 같은 번호 → 혼란"]
    },
    {
      "option": "MD + JSON 코드블록",
      "pros": ["Claude 컨텍스트 자연 로드", "GitHub 가독성", "prose 병기"],
      "cons": ["JSON 추출 단계 (자동화 시)"]
    },
    {
      "option": "순수 JSON 파일",
      "pros": ["파싱 명확", "스키마 lint"],
      "cons": ["Claude 컨텍스트 자동 로드 안 됨"]
    },
    {
      "option": "projects/{name}/ARCHITECTURE.md 유지",
      "pros": ["하네스 구조 long-lived 참조 보존"],
      "cons": ["RESEARCH와 일부 중복 가능"]
    },
    {
      "option": "ROADMAP 단일 milestones 배열",
      "pros": ["스키마 단순", "히스토리 비대화 없음"],
      "cons": ["완료 항목 누적 시 배열 길이"]
    },
    {
      "option": "tests/ 본 milestone에 포함",
      "pros": ["완전한 정합 1 milestone"],
      "cons": ["scope 비대 (smoke 28종 갱신)", "회귀 risk 증가"]
    },
    {
      "option": "tests/ 후속 milestone (선택)",
      "pros": ["scope 한정", "회귀 격리"],
      "cons": ["일시 hook disable 필요", "후속 milestone 의무 발생"]
    },
    {
      "option": ".pre-commit-config.yaml hook 삭제 (Option A)",
      "pros": ["clean state"],
      "cons": ["후속 milestone에서 재추가 부담"]
    },
    {
      "option": ".pre-commit-config.yaml hook 주석 disable (Option B, 선택)",
      "pros": ["후속 milestone에서 재활성화 쉬움", "이력 보존"],
      "cons": ["주석 코드 잔존"]
    }
  ],
  "risks_identified": [
    "phase-1 commit 시 새 JSON 포맷 milestone 파일 (PLAN/RESEARCH/DESIGN) → smoke-spec-verification + smoke-scope-contract files 패턴 (milestones/.*\\.md$) 매칭 → 즉시 smoke fail. 동일 commit에서 .pre-commit-config.yaml disable 우선 처리 필수.",
    "phase-5 sessions/ 116 dirs 삭제 → git working tree 대규모 삭제 (커밋 diff 거대, 단순 삭제라 검토 부담은 낮음)",
    "phase-5 후 markdownlint hook이 milestones/v1.0_/*.md 검사 → JSON 코드블록 둘러싼 markdown lint rule (MD040 fence language, MD031 blank line) 위반 가능",
    "claude/CLAUDE.md, bootstrap/skills/CLAUDE.md cross-ref → bootstrap/{docs,templates,_base} 삭제 후 broken link",
    "AGENTS.md 다른 AI 도구 호환 (Cursor/Copilot/Gemini) — 영문 baseline 유지로 완화",
    "upbit repo 측 cross-ref 영향 (out-of-scope, 별도 후속)",
    "milestones/v1.84~v1.88/ 4-tier 포맷 잔존 → 새 v1.0+ 7-stage와 혼재 (historical 라벨로 표시)"
  ]
}
```
