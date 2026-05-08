# RESEARCH — v1.1_meta-as-project

```json
{
  "id": "v1.1_meta-as-project",
  "external": [
    {
      "source": "user (2026-05-08 session)",
      "topic": "scope misclassification 우려",
      "findings": "사용자가 root ROADMAP에 upbit project milestone(v1.1_upbit-cross-ref-cleanup)이 등록된 사실을 식별 + meta/upbit 작업 경계 충돌 우려 제기 → projects/meta/ROADMAP.md 동형 구조 직접 제안. 후속 3질문(이관 범위/root 처리/smoke 포함)에서 모두 Recommended 옵션 선택 (전체 이관 + thin index + smoke 본 milestone에 포함).",
      "drift": "없음 — 사용자 의도 직접 확인됨"
    },
    {
      "source": "git core",
      "topic": "git mv cross-directory 이동",
      "findings": "git mv <src> <dst>는 rename 감지 + history 보존. 디렉토리 단위 이동 가능. tree depth 변경에도 git log --follow로 기존 history 추적 가능. 이동 시 파일 내용/line ending 무수정 — path 변경만.",
      "drift": "없음"
    },
    {
      "source": "Claude Code @import 디렉티브",
      "topic": "CLAUDE.md 자동 import",
      "findings": "@<relative-path>.md 형식은 root CLAUDE.md에서 파일을 컨텍스트에 자동 로드. subdirectory CLAUDE.md는 해당 디렉토리 작업 시 on-demand 로드. 본 migration 후 @ROADMAP.md는 thin index를 로드 → 토큰 효율 우선 (memory: feedback_token_efficiency_priority 정합).",
      "drift": "없음 — relative path 그대로 유효"
    },
    {
      "source": "Markdown relative path semantics",
      "topic": "milestone 이동 시 ../../ROADMAP.md self-heal",
      "findings": "milestones/v1.0_*/REPORT.md (depth 2) 의 ../../ROADMAP.md는 root ROADMAP을 가리킴. git mv → projects/meta/milestones/v1.0_*/REPORT.md (depth 4) 에서 ../../ROADMAP.md는 projects/meta/ROADMAP.md를 가리킴. **개념적 referent (meta ROADMAP)는 보존**. execute/phase-*.md (depth 3 → 5) 의 ../../../ROADMAP.md도 동일 self-heal. 단 milestones/ 외 root path 참조 (../../../docs/, ../../../bootstrap/ 등)는 깊이 +2 mismatch 발생 가능 — 본 migration에서 신규 broken link 검증 필요.",
      "drift": "없음 (ROADMAP 한정), 중간 (다른 root 경로 참조 시)"
    },
    {
      "source": ".pre-commit-config.yaml (현행)",
      "topic": "active hook list",
      "findings": "active: end-of-file-fixer / trailing-whitespace / check-merge-conflict / check-yaml / check-added-large-files (500kb) / shellcheck (.sh) / markdownlint (.md). disabled (주석): smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift — v1.0 phase-1에서 disable, v1.1_smoke-precommit-rewrite 에서 재활성화 예정. **markdownlint는 syntax-only — broken cross-ref link는 fail 안 함**. 본 migration의 phase commit 동안 active hook 모두 통과 가능.",
      "drift": "없음 — 현 hook은 본 migration 통과"
    },
    {
      "source": "install.ps1 / install-skills.* / verify-lib.* / sync-agents.*",
      "topic": "deployment scripts의 path 의존성",
      "findings": "Glob 결과 (\"ROADMAP.md\" + \"milestones\") 에서 install.ps1 / install-skills.{ps1,sh} / verify-lib.{ps1,sh} / sync-agents.{ps1,sh} 모두 hits 0. 이들은 claude/{commands,hooks,statusline}/ + bootstrap/skills/ → ~/.claude/{commands,hooks,statusline,skills}/ symlink 배포. milestones/ 또는 ROADMAP.md path 직접 참조 없음 → 본 migration이 install/verify 영향 없음.",
      "drift": "없음"
    }
  ],
  "codebase": {
    "current_state": "harness-meta 최상위에 ROADMAP.md (meta scope, milestones[] 6건) + milestones/ (7 milestone 디렉토리: v1.0 + v1.1_meta-as-project + v1.84~v1.88) + projects/upbit/{ARCHITECTURE,ROADMAP}.md. v1.1_upbit-cross-ref-cleanup 항목이 root ROADMAP에 misclassified.",
    "target_state": "harness-meta 최상위에 thin index ROADMAP.md ({projects: [...]} 만, milestones[] 키 부재) + projects/meta/{ARCHITECTURE,ROADMAP,milestones/}.md 신설 + projects/upbit/ 그대로 (단 ROADMAP.md milestones[]에 v1.1_upbit-cross-ref-cleanup 추가). scope-discipline smoke 신규 추가.",
    "directory_diagram_before": "harness-meta/\n├── ROADMAP.md             # meta scope milestones[] 6건 (1건 misclassified)\n├── CLAUDE.md\n├── AGENTS.md\n├── README.md\n├── milestones/             # ★ 메타 milestones 7건\n│   ├── v1.0_workflow-redesign/\n│   ├── v1.1_meta-as-project/  (in_progress, 본 milestone)\n│   ├── v1.84_workflow-revamp/\n│   ├── v1.85_roadmap-housekeeping/\n│   ├── v1.86_cross-ref-false-positive-fix/\n│   ├── v1.87_python-entry-boilerplate-smoke/\n│   └── v1.88_precommit-performance/\n├── projects/\n│   └── upbit/\n│       ├── ARCHITECTURE.md\n│       └── ROADMAP.md      # upbit milestones[] 5건\n├── claude/{commands,hooks,statusline}/\n├── bootstrap/skills/\n├── tests/\n└── docs/{adr,ARCHITECTURE.md}",
    "directory_diagram_after": "harness-meta/\n├── ROADMAP.md             # ★ thin index — {projects: [{name, roadmap_path}]} 만\n├── CLAUDE.md              # @ROADMAP.md 그대로 (thin index 로드)\n├── AGENTS.md\n├── README.md\n├── projects/\n│   ├── meta/              # ★ 신설\n│   │   ├── ARCHITECTURE.md (신규)\n│   │   ├── ROADMAP.md      (이전 root ROADMAP의 meta milestone 5건)\n│   │   └── milestones/     # ★ 기존 root milestones/ 전체 git mv\n│   │       ├── v1.0_workflow-redesign/\n│   │       ├── v1.1_meta-as-project/\n│   │       ├── v1.84_workflow-revamp/\n│   │       ├── v1.85_roadmap-housekeeping/\n│   │       ├── v1.86_cross-ref-false-positive-fix/\n│   │       ├── v1.87_python-entry-boilerplate-smoke/\n│   │       └── v1.88_precommit-performance/\n│   └── upbit/\n│       ├── ARCHITECTURE.md\n│       └── ROADMAP.md      # milestones[]에 v1.1_upbit-cross-ref-cleanup 추가 (이관)\n├── claude/{commands,hooks,statusline}/  (path 갱신: harness-meta.md Stage A)\n├── bootstrap/skills/\n├── tests/\n│   └── smoke-projects-scope-discipline.sh  # ★ 신규 smoke\n└── docs/{adr,ARCHITECTURE.md}",
    "affected_files": [
      {"path": "ROADMAP.md (root)", "change": "rewrite — thin index ({projects: [{name, roadmap_path}]} 만)", "tier": "Tier 1 critical", "lines_estimate": "약 -50 +20"},
      {"path": "projects/meta/ROADMAP.md", "change": "신규 — root ROADMAP의 meta milestone 5건 이관 (v1.1_meta-as-project + v1.1_smoke-precommit-rewrite + v1.1_post-report-write-hook-update + v1.1_design-phases-execute-tracking-automation + v1.0_workflow-redesign), v1.1_upbit-cross-ref-cleanup 제외", "tier": "Tier 1 critical (new)", "lines_estimate": "약 +60"},
      {"path": "projects/meta/ARCHITECTURE.md", "change": "신규 — meta repo 자체 long-lived 구조 참조 (DESIGN 옵션 a/b/c 중 결정 필요, 현재 thin reference 권고)", "tier": "Tier 1 critical (new)", "lines_estimate": "약 +30~+150 (옵션 결정 후)"},
      {"path": "milestones/* → projects/meta/milestones/*", "change": "git mv — 7 milestone 디렉토리 일괄 이동, history 보존", "tier": "Tier 1 critical", "lines_estimate": "0 (rename only)"},
      {"path": "CLAUDE.md (root)", "change": "@ROADMAP.md 유지 + 모듈 매트릭스 milestones/ 행 path → projects/meta/milestones/ 갱신 + 구조 규칙 갱신 + 관련 문서 cross-ref 갱신 (라인 9, 20, 32-33, 52, 55, 114-115)", "tier": "Tier 1 critical", "lines_estimate": "약 ±15"},
      {"path": "claude/commands/harness-meta.md", "change": "Stage A/B 경로 resolution 갱신 — meta ROADMAP path: ~/harness-meta/ROADMAP.md → ~/harness-meta/projects/meta/ROADMAP.md, meta milestone path: milestones/ → projects/meta/milestones/. 영향 라인: 35-36 (모듈 매트릭스), 48 (대상 구분 표), 67 (Stage A read), 70 (milestones[] 배열), 79/82 (Stage B mkdir), 85 (ROADMAP milestones[] update), 90/105/120 (Stage C/D/E path), 169/175 (Stage G VERIFY/REPORT path), 181 (ROADMAP 갱신), 228-229 (금지 list), 236 (관련 cross-ref)", "tier": "Tier 1 critical", "lines_estimate": "약 ±25"},
      {"path": "AGENTS.md (root)", "change": "영문 동등 갱신 — 라인 26 (root ROADMAP), 29-30 (per-project + milestones/), 43 (legacy 4-tier 표기), 68 (legacy 형식 금지), 76 (Active milestones link)", "tier": "Tier 2", "lines_estimate": "약 ±10"},
      {"path": "README.md", "change": "디렉토리 트리 시각화 갱신 — 라인 158, 162 (트리 그림), 244-245 (legacy sessions/meta/ROADMAP.md 표기 정리)", "tier": "Tier 2", "lines_estimate": "약 ±15"},
      {"path": "projects/upbit/ROADMAP.md", "change": "milestones[] 배열에 v1.1_upbit-cross-ref-cleanup 항목 추가 (meta에서 이관, status/trigger 보존). cross-ref ../../ROADMAP.md (라인 57)는 thin index 가리킴 — 정상 유지. 관련 문서 § meta ROADMAP 표기를 'meta milestones: ../../projects/meta/ROADMAP.md' 로 보강.", "tier": "Tier 2", "lines_estimate": "약 +12"},
      {"path": "projects/upbit/ARCHITECTURE.md", "change": "디렉토리 트리 (라인 59) 갱신 — projects/meta/ + projects/upbit/ 동형 표시", "tier": "Tier 2", "lines_estimate": "약 ±5"},
      {"path": "claude/CLAUDE.md", "change": "Hook 정책 § 'sessions/.*/REPORT.(md|ipynb)$' 패턴 설명 갱신 (path 변경 반영, 단 hook 자체 갱신은 별도 milestone)", "tier": "Tier 2", "lines_estimate": "약 ±5"},
      {"path": "tests/CLAUDE.md", "change": "smoke 매트릭스 § milestones/.*\\.md$ 패턴 → projects/<name>/milestones/.*\\.md$ 갱신 (라인 235-236), scope-discipline smoke 신규 항목 row 추가", "tier": "Tier 2", "lines_estimate": "약 ±10"},
      {"path": "bootstrap/skills/CLAUDE.md", "change": "milestones/v{X.Y}_/ 패턴 (라인 110) → projects/meta/milestones/v{X.Y}_/ 갱신", "tier": "Tier 2", "lines_estimate": "약 ±3"},
      {"path": "verify.sh", "change": "라인 577 메시지 (텍스트만)", "tier": "Tier 3", "lines_estimate": "0~±2"},
      {"path": "verify.ps1", "change": "라인 608 메시지 (텍스트만)", "tier": "Tier 3", "lines_estimate": "0~±2"},
      {"path": "claude/hooks/post-report-write.sh", "change": "라인 153 메시지의 'ROADMAP.md' 텍스트 — 패턴 자체 갱신은 별도 milestone, 본 milestone에서는 메시지만 보강 (선택)", "tier": "Tier 3", "lines_estimate": "0~±2"},
      {"path": "tests/smoke-projects-scope-discipline.sh", "change": "신규 smoke — root ROADMAP.md thin index schema 검증 + projects/<name>/ROADMAP.md 외 위치 milestone-like 객체 미존재 검증. 단독 활성화 vs disabled 추가 (DESIGN 결정)", "tier": "Tier 1 critical (new)", "lines_estimate": "약 +80~+150"}
    ],
    "untouched_files": [
      "milestones/v1.0_workflow-redesign/{PLAN,RESEARCH,DESIGN,VERIFY,REPORT}.md + execute/phase-*.md — 내용 동결 (path만 git mv)",
      "milestones/v1.84_workflow-revamp/* ~ v1.88_precommit-performance/* — 4-tier historical 동결 (path만 git mv)",
      "docs/adr/ADR-006-workflow-revamp.md — 역사적 ADR, 내용 동결",
      "tests/smoke-cross-ref.sh / smoke-roadmap-sync.sh / smoke-spec-verification.sh / smoke-scope-contract.sh / smoke-claude-md-drift.sh — disabled 상태, v1.1_smoke-precommit-rewrite 에서 통합 갱신 (out of scope)",
      "bootstrap/skills/audit/harness-roadmap-update/SKILL.md — sessions/meta/ROADMAP.md 참조는 v1.0 이후 broken, 별도 cleanup tech debt (out of scope)",
      ".pre-commit-config.yaml — 주석 내 milestones/.*\\.md$ 언급은 disabled 상태 안내 (재활성화 시 갱신, 단 본 milestone에서 신규 smoke 1건 active block 추가는 가능)",
      ".claude/settings.local.json — sessions/meta/ROADMAP.md 참조는 v1.0 이후 broken (out of scope)",
      "install.ps1 / install-skills.{ps1,sh} / verify-lib.{ps1,sh} / sync-agents.{ps1,sh} — milestones/ path 직접 참조 없음 (Glob 검증 완료)",
      "projects/upbit/milestones/ — 부재 유지. 프로젝트별 하네스 milestone은 프로젝트 repo에 위치 (CLAUDE.md 컨벤션 정합). meta는 본 repo가 곧 'meta repo'이므로 projects/meta/milestones/ 내부 보유 — 비대칭 의도적."
    ]
  },
  "options": [
    {
      "id": "approach_overall",
      "topic": "전체 migration 접근",
      "alternatives": [
        {"option": "A. 단일 milestone 전체 이관 (Recommended, 사용자 선택)", "pros": ["atomic transition", "scope-discipline 즉시 효과", "사용자 명시 선호"], "cons": ["phase 4-6 다중 commit 필요"]},
        {"option": "B. 점진적 다단계 milestone", "pros": ["각 milestone 작은 단위, rollback 단순"], "cons": ["중간 상태 일관성 깨짐 — '왜 따로?' 혼란", "사용자 의도 반함"]},
        {"option": "C. Big-bang 단일 commit", "pros": ["최단 commit 수"], "cons": ["rollback/bisect 어려움", "phase별 회귀 격리 불가", "conventional commit 정책 위배"]}
      ]
    },
    {
      "id": "thin_index_schema",
      "topic": "root ROADMAP.md thin index schema",
      "alternatives": [
        {"option": "S1. 최소 — {projects: [{name, roadmap_path}]}", "pros": ["가장 간결, 토큰 효율", "유지보수 단순"], "cons": ["프로젝트별 ARCHITECTURE.md 위치 묵시적"]},
        {"option": "S2. 보강 — {projects: [{name, roadmap_path, architecture_path}]}", "pros": ["ARCHITECTURE 명시적"], "cons": ["projects/<name>/ARCHITECTURE.md 컨벤션이 이미 fixed이라 잉여"]},
        {"option": "S3. 운영 status — {projects: [{name, roadmap_path, status: active|archived, last_updated}]}", "pros": ["프로젝트 활성도 가시화"], "cons": ["last_updated 갱신 비용 + 운영 부담"]}
      ]
    },
    {
      "id": "architecture_md_depth",
      "topic": "projects/meta/ARCHITECTURE.md 작성 깊이",
      "alternatives": [
        {"option": "D1. Thin reference (Recommended)", "pros": ["root CLAUDE.md/docs/ARCHITECTURE.md 와 중복 회피", "단일 source 정합"], "cons": ["meta-only 정보 부재 — projects/upbit/ARCHITECTURE.md 와 형식 불일치"]},
        {"option": "D2. Deep self-contained", "pros": ["projects/upbit/ARCHITECTURE.md 와 동형 형식"], "cons": ["root CLAUDE.md/docs/ARCHITECTURE.md 와 중복", "drift risk"]},
        {"option": "D3. Middle — projects/upbit/ 와 동형 구조 + root cross-ref 위임 (긴 설명은 위임)", "pros": ["형식 일관성 + 중복 최소"], "cons": ["cross-ref가 많아짐"]}
      ]
    },
    {
      "id": "smoke_validation_algorithm",
      "topic": "scope-discipline smoke 검증 알고리즘",
      "alternatives": [
        {"option": "V1. python + json.load (Recommended)", "pros": ["json schema 정합 + key 존재 검증 robust", "기존 smoke 다수가 python 사용 패턴"], "cons": ["python3 의존 (이미 다른 smoke가 동일 의존)"]},
        {"option": "V2. jq", "pros": ["순수 shell, jq schema 명세"], "cons": ["jq Windows Git Bash 의존 — 부재 가능성, 테스트 fixture 필요"]},
        {"option": "V3. grep literal pattern", "pros": ["의존 zero, fastest"], "cons": ["JSON 의미론 무지 — false positive 多. 실용 부적합."]}
      ]
    },
    {
      "id": "smoke_activation",
      "topic": "신규 smoke의 pre-commit 활성화 방식",
      "alternatives": [
        {"option": "AC1. 단독 active block 추가 (Recommended)", "pros": ["disabled 4종과 분리, 즉각 활성", "회귀 isolation"], "cons": ["pre-commit-config.yaml 에 active local repo 1개 추가 — 형식 변화"]},
        {"option": "AC2. disabled 주석 블록 안에 추가, v1.1_smoke-precommit-rewrite 에서 통합 활성화", "pros": ["미래 통합 정합"], "cons": ["본 milestone scope에서 즉각 효과 없음 — scope-discipline 검증 지연"]}
      ]
    },
    {
      "id": "phase_ordering",
      "topic": "phase 실행 순서",
      "alternatives": [
        {"option": "P1. 신규 → mv → cross-ref → smoke (Recommended)", "pros": ["phase 1: projects/meta/{ROADMAP,ARCHITECTURE} 신규 (기존 root ROADMAP 미수정 — Stage A 안전 유지) → phase 2: thin index 변환 + git mv milestones/ → phase 3: cross-ref / harness-meta.md / 각 모듈 CLAUDE.md / AGENTS.md / README.md / verify.* 일괄 갱신 → phase 4: smoke 신규 + 단독 활성화 + misclassified 이관"], "cons": ["phase 2 commit 시 잠시 path mismatch (thin index 변환 직후, harness-meta.md 갱신 전 → 새 세션에서 /harness-meta 실행하면 옛 path 시도). 실 사용자는 phase 3 commit 후만 새 세션 진입 권장."]},
        {"option": "P2. atomic single phase", "pros": ["중간 broken state 부재"], "cons": ["대규모 단일 commit, bisect 불가, conventional commit 정책 위배"]},
        {"option": "P3. cross-ref 먼저 → mv 나중", "pros": ["cross-ref가 미래 path 가리킴 → mv 후 자동 정합"], "cons": ["mv 전 cross-ref가 깨진 상태 (projects/meta/ROADMAP.md 부재) — phase 1 commit 시 markdownlint warn 가능, 직관 반함"]}
      ]
    }
  ],
  "risks_identified": [
    {"id": "R1", "risk": "git mv 후 milestone 내부 ../../ROADMAP.md 가 의도된 projects/meta/ROADMAP.md 를 가리키는지 (그리고 다른 root path 참조가 새로운 +2 깊이에서 broken 되지 않는지) 검증 필요", "severity": "low", "verification": "phase commit 후 sample 5건 REPORT.md 의 cross-ref grep + click test"},
    {"id": "R2", "risk": "claude/commands/harness-meta.md 의 path resolution 갱신 누락 시 /harness-meta meta 모드 Stage A에서 ROADMAP read 실패", "severity": "high", "verification": "phase 3 commit 후 새 세션에서 /harness-meta meta 실행 → Stage A read 정상 resolve 확인"},
    {"id": "R3", "risk": "CLAUDE.md @ROADMAP.md 가 thin index 로 변경되어 meta milestone 정보가 컨텍스트에 즉각 가시화되지 않음 → 사용자 발견성 저하", "severity": "medium", "mitigation": "thin index에 'meta milestones: projects/meta/ROADMAP.md 참조' 명시 + harness-meta.md Stage A 에서 자동 read 보장"},
    {"id": "R4", "risk": "scope-discipline smoke false positive — 너무 엄격하면 정상 ROADMAP 도 fail", "severity": "medium", "mitigation": "신규 smoke 에 fixture (정상 thin index + 정상 project ROADMAP + 비정상 misclassification 케이스) 포함, 단독 활성화 후 며칠간 모니터링"},
    {"id": "R5", "risk": "git mv 시 .gitattributes 의 *.md 처리에 따른 line ending 변경 — 실은 git mv 는 path 만 변경하므로 거의 0", "severity": "very_low", "verification": "phase 2 commit 직후 git diff --stat 로 0 content change 확인"},
    {"id": "R6", "risk": "신규 smoke 단독 활성화 시 pre-commit-config.yaml 형식 (- repo: local active block 신설). 기존 disabled 주석 블록과 분리되어 미래 통합 시 추가 정리 필요", "severity": "low", "mitigation": "active block에 '단독 활성, v1.1_smoke-precommit-rewrite 에서 통합 예정' 주석 명시"},
    {"id": "R7", "risk": "v1.1_upbit-cross-ref-cleanup 이관 시 trigger 분류 변경 가능성 — 이관만 처리하므로 기존 trigger A_user 보존, status pending 유지", "severity": "low", "verification": "이관 후 projects/upbit/ROADMAP.md milestones[] 무결성 확인"},
    {"id": "R8", "risk": "README.md / AGENTS.md / 각 모듈 CLAUDE.md cross-ref 부분 누락 → 외부 방문자 broken link 경험", "severity": "medium", "mitigation": "phase 3 commit 전 grep -r 'ROADMAP.md\\|milestones/' (worktree 제외) 결과 전수 갱신 + commit log에 갱신 list"},
    {"id": "R9", "risk": "projects/meta/ARCHITECTURE.md 가 root CLAUDE.md / docs/ARCHITECTURE.md / AGENTS.md 와 중복 — drift risk", "severity": "medium", "mitigation": "DESIGN option D1 (thin reference) 채택 권고. root 문서 위임 + meta 디렉토리 매트릭스만 유지"},
    {"id": "R10", "risk": "phase 순서 의존성 — path resolution 갱신 (phase 3) 보다 git mv (phase 2) 먼저 진행 시 phase 2 직후 새 세션에서 /harness-meta meta 실행하면 옛 path 시도 → 잠시 broken state", "severity": "low", "mitigation": "phase 2 + 3 짧은 시간 내 연속 commit + push 분리. 사용자는 phase 3 후 새 세션 권장. (혹은 phase 2 + 3 단일 commit 통합 — phase 분할 의도 약화 trade-off)"},
    {"id": "R11", "risk": "projects/upbit/milestones/ 신설 여부 — 본 migration은 부재 유지하지만 사용자 추후 'projects/<name>/도 milestones/ 통일' 요구 가능", "severity": "low", "mitigation": "RESEARCH untouched_files 에 비대칭 의도 명시. CLAUDE.md 구조 규칙에 '프로젝트별 milestones는 프로젝트 repo, meta는 본 repo' 명문화 (phase 3 cross-ref 갱신 범위)"}
  ]
}
```

## 관련

- 활성 ROADMAP (이관 전): [`../../ROADMAP.md`](../../ROADMAP.md)
- PLAN: [`PLAN.md`](PLAN.md)
- 사용자 의도 확인 round (2026-05-08): "ROADMAP scope 분리" + "projects/meta/ROADMAP.md 동형 구조" + 3 Recommended 선택
