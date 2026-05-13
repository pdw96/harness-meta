# DESIGN — v1.0_workflow-redesign

```json
{
  "milestone": "v1.0_workflow-redesign",
  "decisions": [
    {
      "decision": "버전 v1.0 리셋",
      "rationale": "기존 4-tier와 새 7-stage 본질 차이. 같은 번호 공간 이어가면 history 의미 흐려짐. milestones/v1.84~v1.88/은 historical로 격리.",
      "alternatives_rejected": ["v1.89 연속", "v2.0 major bump"]
    },
    {
      "decision": "MD + JSON 코드블록 포맷",
      "rationale": "Claude 컨텍스트 자연 로드 + GitHub 가독성. 자동화 파이프라인은 코드블록 추출로 대응.",
      "alternatives_rejected": ["순수 JSON", "YAML frontmatter"]
    },
    {
      "decision": "projects/{name}/ARCHITECTURE.md + ROADMAP.md 유지",
      "rationale": "ARCHITECTURE는 long-lived 참조. RESEARCH는 milestone 범위 스냅샷. 흡수 시 컨텍스트 비대.",
      "alternatives_rejected": ["전부 폐기", "DECISIONS/INTERVIEW/STACK 유지"]
    },
    {
      "decision": "bootstrap/skills/ 유지, 나머지 bootstrap/ 폐기",
      "rationale": "skills/는 글로벌 user skill 소스. 본 워크플로우와 무관. interview/render-manifest는 첫 milestone EXECUTE가 대체.",
      "alternatives_rejected": ["bootstrap 전체 폐기", "bootstrap 전체 유지"]
    },
    {
      "decision": "milestones/v1.84~v1.88/ historical 보존 (마이그레이션 안 함)",
      "rationale": "이미 git 커밋된 작업. 마이그레이션 ROI 낮음.",
      "alternatives_rejected": ["전체 마이그레이션", "전체 삭제"]
    },
    {
      "decision": "tests/ smoke + tests/CLAUDE.md + claude/hooks/ 후속 milestone 분리",
      "rationale": "smoke 다수가 sessions/ 검증 대상. 본 milestone에 포함 시 scope 비대 + 회귀 risk. 본 milestone에서는 .pre-commit-config.yaml hook 4종 disable로 즉시 fail만 차단.",
      "alternatives_rejected": ["본 milestone 포함 (scope 비대)"]
    },
    {
      "decision": "ROADMAP 단일 milestones 배열 (status 필드로 구분)",
      "rationale": "completed/active/pending 별도 섹션은 비대화 원인. 사용자 설계 의도.",
      "alternatives_rejected": ["섹션 분리 (기존 §2/§3/§8 패턴)"]
    },
    {
      "decision": "DESIGN.md 단계 신설 (RESEARCH→EXECUTE 사이)",
      "rationale": "RESEARCH는 raw findings 전담, DESIGN이 decisions + phase 분할 전담. 단일 책임.",
      "alternatives_rejected": ["RESEARCH에 decisions 포함"]
    },
    {
      "decision": "REPORT.md 단계 신설 (VERIFY 후)",
      "rationale": "VERIFY는 기술 검증, REPORT는 narrative 종합 + ROADMAP stamp용 변환.",
      "alternatives_rejected": ["VERIFY에 lessons/next 포함"]
    },
    {
      "decision": ".pre-commit-config.yaml hook 4종 주석 disable (Option B)",
      "rationale": "smoke-spec-verification / scope-contract / cross-ref / claude-md-drift은 sessions/.*\\.md$|milestones/.*\\.md$ 패턴 매칭 → 새 JSON 포맷 fail. 후속 milestone에서 갱신 후 재활성화. 삭제 대신 주석 처리로 이력 보존.",
      "alternatives_rejected": ["삭제 (Option A)", "--no-verify 명시 승인 (CLAUDE.md 정책 위반 risk)"]
    },
    {
      "decision": "phase-1에서 .pre-commit-config.yaml + 본 milestone 파일들(PLAN/RESEARCH/DESIGN) 동시 commit",
      "rationale": "milestone 파일들은 milestones/v1.0_/*.md → 4 hook 패턴에 매칭. .pre-commit-config.yaml 갱신을 같은 commit에 포함 → pre-commit이 staged 설정 적용 → disable된 hook 무시.",
      "alternatives_rejected": [".pre-commit-config.yaml 단독 phase (milestone 파일 commit 미루기 — 작업 흐름 끊김)"]
    },
    {
      "decision": "module CLAUDE.md 일부 light update (claude/CLAUDE.md, bootstrap/skills/CLAUDE.md)",
      "rationale": "bootstrap/{docs,templates,_base} 삭제로 cross-ref 깨짐 방지. 단 tests/CLAUDE.md는 smoke 후속 milestone과 동반 갱신.",
      "alternatives_rejected": ["전부 갱신 (scope 비대)", "전부 미갱신 (cross-ref 깨짐)"]
    },
    {
      "decision": "phase 분할 6단계 (1: precommit+milestone files, 2: docs, 3: slash, 4: upbit, 5: deletions, 6: tooling)",
      "rationale": "phase-1 우선 — milestone 파일 commit 가능하게 disable 먼저. phase-2~3 docs/slash가 새 흐름 정의. phase-4 dogfood. phase-5 mass deletion (단일 commit, 대규모 diff). phase-6 tooling 정리는 deletions 결과 반영.",
      "alternatives_rejected": ["5단계 (deletion + tooling 합치기 — diff 너무 비대)", "7단계 (slash + docs 분리 — 과한 분할)"]
    }
  ],
  "approach": "6-phase 분할. phase-1이 critical path — milestone 파일 commit 가능 환경 구축 (.pre-commit-config.yaml hook 4종 disable + 본 milestone PLAN/RESEARCH/DESIGN commit). phase-2~3 docs/slash 재작성. phase-4 dogfood (upbit). phase-5 mass deletion. phase-6 tooling. --no-verify 사용 안 함 (정책 준수). 각 phase = 1 commit.",
  "phases": [
    {
      "n": 1,
      "title": ".pre-commit-config.yaml hook 4종 disable + milestone 파일 commit",
      "scope": "smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift 4 local hook 주석 처리. 동일 commit에 milestones/v1.0_workflow-redesign/{PLAN,RESEARCH,DESIGN}.md + execute/phase-1.md 포함.",
      "affected_files": [
        ".pre-commit-config.yaml",
        "milestones/v1.0_workflow-redesign/INTENT.md",
        "milestones/v1.0_workflow-redesign/RESEARCH.md",
        "milestones/v1.0_workflow-redesign/DESIGN.md",
        "milestones/v1.0_workflow-redesign/execute/phase-1.md"
      ],
      "rationale": "critical path — milestone 파일 commit 가능 환경 구축. disable 먼저 안 하면 즉시 smoke fail.",
      "risks": ["markdownlint이 INTENT.md JSON 코드블록 둘러싼 영역 검사 — fence language 명시(```json) + blank line으로 회피"]
    },
    {
      "n": 2,
      "title": "root ROADMAP.md 신설 + CLAUDE.md/AGENTS.md/claude/CLAUDE.md/bootstrap/skills/CLAUDE.md 갱신",
      "scope": "ROADMAP.md 새 JSON 스키마로 root에 신설. CLAUDE.md/AGENTS.md 새 7-stage 흐름 반영. claude/CLAUDE.md + bootstrap/skills/CLAUDE.md cross-ref 정리.",
      "affected_files": [
        "ROADMAP.md (create)",
        "CLAUDE.md (rewrite)",
        "AGENTS.md (rewrite)",
        "claude/CLAUDE.md (light — bootstrap/templates/_base ref 제거)",
        "bootstrap/skills/CLAUDE.md (light — 부모 ref 정리)"
      ],
      "rationale": "새 워크플로우 정의 자체 — 후속 phase가 이를 기준.",
      "risks": ["AGENTS.md 다른 AI 도구 호환 — 영문 baseline + 한국어는 CLAUDE.md로 분리"]
    },
    {
      "n": 3,
      "title": "claude/commands/harness-meta.md 7-stage 흐름으로 재작성",
      "scope": "/harness-meta 명령 본문 — Stage A(ROADMAP)~Stage G(REPORT) 흐름 반영. frontmatter (allowed-tools 등) 유지.",
      "affected_files": ["claude/commands/harness-meta.md"],
      "rationale": "phase-2 docs와 정합. 명령 호출 시 새 흐름 실행 진입점.",
      "risks": ["기존 명령 사용자에 갑작스런 변경 — CLAUDE.md docs로 완화"]
    },
    {
      "n": 4,
      "title": "projects/upbit/ 정리 + ROADMAP JSON 마이그레이션",
      "scope": "DECISIONS/INTERVIEW/STACK 삭제. ROADMAP을 새 JSON 스키마(milestones 배열)로 마이그레이션. ARCHITECTURE는 유지.",
      "affected_files": [
        "projects/upbit/DECISIONS.md (delete)",
        "projects/upbit/INTERVIEW.md (delete)",
        "projects/upbit/STACK.md (delete)",
        "projects/upbit/ROADMAP.md (migrate to JSON)"
      ],
      "rationale": "유일한 활성 프로젝트 — 새 스키마 dogfood.",
      "risks": ["upbit repo 측 cross-ref 영향 (out-of-scope, 별도 후속)"]
    },
    {
      "n": 5,
      "title": "sessions/ + bootstrap/ 폐기 + 미커밋 milestone 삭제 (mass deletion)",
      "scope": "sessions/ 116 dirs 삭제. bootstrap/{CLAUDE.md, docs, interview.md, manifest-schema.md, render-manifest.sh, detect-project.sh, install-project-claude.{ps1,sh}, skeletons, templates} 삭제. milestones/v1.85_project-workflow-extension/ 삭제(untracked).",
      "affected_files": [
        "sessions/ (git rm -r)",
        "bootstrap/CLAUDE.md (delete)",
        "bootstrap/docs/ (git rm -r — 8 docs)",
        "bootstrap/interview.md, manifest-schema.md, render-manifest.sh, detect-project.sh (delete, 4개)",
        "bootstrap/install-project-claude.{ps1,sh} (delete, 2개)",
        "bootstrap/skeletons/ (git rm -r — 4 .tmpl + projects/ + sessions/)",
        "bootstrap/templates/ (git rm -r — _base/, python/)",
        "milestones/v1.85_project-workflow-extension/ (rm, untracked)"
      ],
      "rationale": "핵심 정리 — 가장 큰 diff. 후행 phase가 이를 가정.",
      "risks": ["git diff 거대 (~120 dirs 삭제, 단순 삭제라 검토 부담은 낮음)", "smoke 일부 obsolete (out-of-scope, 후속 milestone에서 정리)"]
    },
    {
      "n": 6,
      "title": "install.ps1 + verify.ps1/sh 간소화",
      "scope": "install.ps1 line 134-135 bootstrap/templates/_base + install-project-claude refs 제거. verify.ps1/sh 의 sessions/ 검증 stage 제거. install-skills/sync-agents/verify-lib는 유지.",
      "affected_files": [
        "install.ps1 (bootstrap/templates + project-claude refs 제거)",
        "verify.ps1 (sessions/ 검증 stage 제거)",
        "verify.sh (sessions/ 검증 stage 제거)"
      ],
      "rationale": "툴링 정리 — phase-5 삭제 결과 반영. 마지막.",
      "risks": ["설치 흐름 회귀 — verify 직접 실행으로 검증"]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "phase-1 markdownlint fail",
      "mitigation": "JSON 코드블록 fence에 'json' language 명시 + 블록 전후 blank line 보장 + .markdownlintignore에 milestones/v1.0_/ 추가 (필요 시)"
    },
    {
      "risk": "phase-5 git diff 거대 (~120 dirs 삭제)",
      "mitigation": "단순 삭제라 검토 부담 낮음. 커밋 메시지에 'sessions/ ~116 dirs deleted (historical preserved in git history)' 명시"
    },
    {
      "risk": "AGENTS.md 다른 AI 도구 호환",
      "mitigation": "영문 baseline 유지. 새 워크플로우 상세는 한국어 CLAUDE.md, AGENTS.md는 요약만."
    },
    {
      "risk": "upbit cross-ref 영향",
      "mitigation": "out-of-scope 명시. upbit repo 측 별도 후속 milestone."
    },
    {
      "risk": "버전 v1.0 리셋 → milestones/ 디렉토리 내 v1.0 신규와 v1.84~v1.88 historical 혼재",
      "mitigation": "ROADMAP.md에 v1.0이 새 포맷 시작점임 명시. milestones/v1.84~v1.88은 historical 표기."
    },
    {
      "risk": "phase-4 후속 milestones에서 .pre-commit hook 재활성화 누락",
      "mitigation": "REPORT.md next_candidates에 'tests/ smoke 갱신 + .pre-commit hook 재활성화' 명시 등록"
    },
    {
      "risk": "claude/hooks/post-report-write.sh의 sessions/.*/REPORT 패턴 — sessions/ 삭제 후 hook이 패턴 미스 (silent NOOP)",
      "mitigation": "out-of-scope. 본 milestone 후 hook NOOP 상태 명확. 후속 milestone에서 milestones/v.*/(PLAN|RESEARCH|DESIGN|VERIFY|REPORT|execute/.*)\\.md$ 패턴으로 갱신."
    }
  ],
  "approval": {
    "approved_by": "user",
    "date": "2026-05-08"
  }
}
```
