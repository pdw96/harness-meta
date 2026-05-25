# DESIGN — v1.1_meta-as-project

```json
{
  "id": "v1.1_meta-as-project",
  "decisions": [
    {
      "decision": "approach_overall = A — 단일 milestone 다중 phase",
      "rationale": "사용자 명시 선호 + atomic transition + scope-discipline 즉시 효과. 점진적 다단계 milestone (B) 은 중간 상태 일관성 깨지고 사용자 의도 반함. Big-bang 단일 commit (C) 은 conventional commit 정책 위배 + bisect 불가.",
      "alternatives_rejected": ["B. 다단계 milestone", "C. Big-bang 단일 commit"]
    },
    {
      "decision": "thin_index_schema = S1 — { projects: [{ name, roadmap_path }] }",
      "rationale": "단순 / 토큰 효율 / 추가 메타데이터 (architecture_path) 는 컨벤션이 이미 fixed (projects/<name>/ARCHITECTURE.md) 이라 잉여. status / last_updated 는 drift bait. JSON schema 검증도 단순. 미래 확장 시 키 추가는 backward-compatible.",
      "alternatives_rejected": ["S2. + architecture_path", "S3. + status/last_updated"]
    },
    {
      "decision": "architecture_md_depth = D3 — homomorphic skeleton + 위임",
      "rationale": "projects/upbit/ARCHITECTURE.md 와 형식 일관 → '메타도 일반 project' 메시지 정합. 깊은 내용은 root CLAUDE.md / docs/ARCHITECTURE.md 위임 → drift 차단. D1 (thin reference) 은 형식 비대칭 신호. D2 (deep self-contained) 는 root 문서와 중복 risk.",
      "alternatives_rejected": ["D1. thin reference", "D2. deep self-contained"]
    },
    {
      "decision": "claude_md_at_import = single + lazy subdir",
      "rationale": "사용자 선택. root CLAUDE.md @ROADMAP.md (thin index) 만 — 토큰 효율 (memory: feedback_token_efficiency_priority 정합). projects/meta/CLAUDE.md 신설 + @ROADMAP.md 디렉티브 (=projects/meta/ROADMAP.md) — Claude Code subdirectory CLAUDE.md on-demand 로드 메커니즘 활용. meta 작업 시에만 로드 → 발견성 + 효율 둘 다 확보.",
      "alternatives_rejected": ["dual immediate (architecture C3 — root에 @projects/meta/ROADMAP.md 추가, 6x 토큰 비용)", "single only (PLAN 원안 — meta milestone 발견성 저하)"]
    },
    {
      "decision": "smoke_validation_algorithm = V1 + 보안 강화",
      "rationale": "python3 + json.load (stdlib only, jsonschema 의존 없이 dict-key assertions). 기존 smoke 다수가 동일 패턴. 보안: glob 'projects/*/ROADMAP.md' (single-segment, 재귀 traversal 금지) + roadmap_path 필드 regex '^projects/[a-z0-9_-]+/ROADMAP\\.md$' validation (path traversal defense-in-depth). DoS 방지: file size guard (>100KB skip).",
      "alternatives_rejected": ["V2. jq (Windows Git Bash 의존성 risk)", "V3. grep literal (JSON 의미론 무지, false positive)"]
    },
    {
      "decision": "smoke_activation = AC1 — 단독 active block 즉시 활성화",
      "rationale": "본 milestone이 fix 하려는 misclassification 재발을 smoke 가 차단 — 활성화 deferral 시 milestone 의도 무효화. .pre-commit-config.yaml 에 active local repo 1 block 추가 (markdownlint 다음, disabled 4종 주석 블록 직전 위치). active block 주석에 '단독 활성, v1.1_smoke-precommit-rewrite 에서 통합 예정' 명시.",
      "alternatives_rejected": ["AC2. disabled 주석 블록 안에 추가 — 활성화 지연 시 scope-discipline 검증 무효"]
    },
    {
      "decision": "phase_ordering = revised 3-phase atomic minimal",
      "rationale": "Architecture C2 broken-window 분석 채택. Phase 2 atomic 최소 set (git mv + thin index + harness-meta.md path resolution) 단일 commit → /harness-meta Stage A read 깨지는 중간 상태 0. Phase 1 (additive) 는 100% 추가만 — duplication 짧게 허용. Phase 3 (cross-ref + sweeps + smoke 활성화) 는 문서 / 운영 / 활성화 — Stage A core 영향 없음, bisect 단위 분리.",
      "alternatives_rejected": ["RESEARCH P1 (4-phase, phase 2/3 broken window)", "P2 atomic single phase (대규모 단일 commit, conventional commit 정책 위배)", "P3 cross-ref 먼저 (mv 전 cross-ref가 깨진 상태)"]
    },
    {
      "decision": "optional sweeps 4건 모두 phase 3 포함",
      "rationale": "사용자 명시 선택. (1) .claude/settings.local.json dead Bash entry 5개 prune (보안 + architecture 공통 추천), (2) docs/ARCHITECTURE.md grep 검증 + 갱신 (RESEARCH 누락 가능성 해소), (3) bootstrap/skills/audit/harness-roadmap-update/SKILL.md 상단 deprecation 주석 추가 (broken since v1.0 명시), (4) .pre-commit-config.yaml 라인 40/51/57 주석 milestones/ → projects/<name>/milestones/ 갱신.",
      "alternatives_rejected": ["선택적 sweep defer (현재 broken state 지속)"]
    }
  ],
  "approach": "ADDITIVE → ATOMIC FLIP → POLISH. 3 phase 구조. Phase 1은 100% 추가 (projects/meta/ skeleton + smoke 파일 + upbit ROADMAP 항목 추가) — 회귀 0. Phase 2는 atomic minimal flip (git mv + thin index + Stage A path resolution) 단일 commit — broken window 0. Phase 3은 documentation/operations/optional sweep + smoke 활성화 — Stage A core 의존 없음, bisect 분리. 각 phase commit 후 파일 시스템 무결성 즉시 확인 가능.",
  "phases": [
    {
      "n": 1,
      "title": "Additive scaffolding — projects/meta/ skeleton + scope-discipline smoke + upbit ROADMAP 항목 추가",
      "scope": "projects/meta/ 디렉토리 신설 + 3 신규 파일 (ROADMAP.md / ARCHITECTURE.md / CLAUDE.md) + tests/smoke-projects-scope-discipline.sh 신규 + projects/upbit/ROADMAP.md milestones[] 에 v1.1_upbit-cross-ref-cleanup 추가 (additive). 기존 root ROADMAP.md / milestones/ 무수정 유지 — 100% 추가만, 0 breakage.",
      "affected_files": [
        "projects/meta/ROADMAP.md (신규) — meta milestones 5건 cloning (v1.1_meta-as-project / v1.1_smoke-precommit-rewrite / v1.1_post-report-write-hook-update / v1.1_design-phases-execute-tracking-automation / v1.0_workflow-redesign), v1.1_upbit-cross-ref-cleanup 제외",
        "projects/meta/ARCHITECTURE.md (신규) — D3 homomorphic 형식, ~50라인 (디렉토리 매트릭스 + 모듈 책임 요약 + root 문서 위임 cross-ref)",
        "projects/meta/CLAUDE.md (신규) — subdirectory guide, @ROADMAP.md (=projects/meta/ROADMAP.md) lazy import + meta scope 작업 안내",
        "tests/smoke-projects-scope-discipline.sh (신규) — V1 algorithm (python3 + json.load + glob projects/*/ROADMAP.md + roadmap_path regex + size guard). 활성화는 phase 3.",
        "projects/upbit/ROADMAP.md (수정) — milestones[] 배열 6번째 항목으로 v1.1_upbit-cross-ref-cleanup 추가 (status/trigger/summary 보존, root에서 cloning)"
      ],
      "rationale": "additive 단계로 schema / 신규 파일 / smoke 코드를 사전 검증. 기존 system 무영향 → bisect 단순. duplication 임시 (root ROADMAP + projects/meta/ROADMAP.md 둘 다 5 meta milestones, root + upbit ROADMAP 둘 다 v1.1_upbit-cross-ref-cleanup) 는 phase 2에서 root 측 thin 변환으로 자연 해소.",
      "risks": ["R3 thin index 발견성 — phase 1 단계에서는 thin 변환 미실행이므로 영향 없음 (phase 2/3 적용)"],
      "commit_message": "feat(meta): v1.1 phase-1 — projects/meta/ skeleton + scope-discipline smoke (additive)"
    },
    {
      "n": 2,
      "title": "Atomic flip — git mv milestones/ + root ROADMAP thin index + harness-meta.md Stage A path resolution",
      "scope": "최소 원자 set. git mv milestones/* → projects/meta/milestones/* (7 dir history 보존) + 기존 root ROADMAP.md 를 thin index 로 rewrite (milestones[] 제거, projects[] 만) + claude/commands/harness-meta.md Stage A/B/C/D/E/G 모든 path resolution 갱신. 단일 commit. /harness-meta meta 모드 Stage A 가 thin index 만난 직후 즉시 새 path 인식 → broken window 0.",
      "affected_files": [
        "milestones/v1.0_workflow-redesign/ → projects/meta/milestones/v1.0_workflow-redesign/ (git mv)",
        "milestones/v1.1_meta-as-project/ → projects/meta/milestones/v1.1_meta-as-project/ (git mv, 본 milestone 자체 이동)",
        "milestones/v1.84_workflow-revamp/ → projects/meta/milestones/v1.84_workflow-revamp/ (git mv)",
        "milestones/v1.85_roadmap-housekeeping/ → projects/meta/milestones/v1.85_roadmap-housekeeping/ (git mv)",
        "milestones/v1.86_cross-ref-false-positive-fix/ → projects/meta/milestones/v1.86_cross-ref-false-positive-fix/ (git mv)",
        "milestones/v1.87_python-entry-boilerplate-smoke/ → projects/meta/milestones/v1.87_python-entry-boilerplate-smoke/ (git mv)",
        "milestones/v1.88_precommit-performance/ → projects/meta/milestones/v1.88_precommit-performance/ (git mv)",
        "ROADMAP.md (root) — rewrite to thin index { projects: [{ name: 'meta', roadmap_path: 'projects/meta/ROADMAP.md' }, { name: 'upbit', roadmap_path: 'projects/upbit/ROADMAP.md' }] } + 관련 문서 § thin index 안내 (간략)",
        "claude/commands/harness-meta.md — Stage A path (라인 67), Stage B mkdir (라인 79/82), Stage C/D/E (라인 90/105/120), Stage G (라인 169/175/181), 모듈 매트릭스 (라인 35-36), 대상 구분 표 (라인 48), milestones[] 배열 read (라인 70/85), 금지 list (라인 228-229), 관련 cross-ref (라인 236) 일괄 갱신"
      ],
      "rationale": "Stage A 가 root ROADMAP 의 milestones[] 만 의존하던 의미론을 thin index로 옮기는 즉시, harness-meta.md 도 새 location 으로 read 하도록 단일 commit 으로 완성. 두 변경이 분리되면 path mismatch state (R10 high) — 단일 commit 으로 차단.",
      "risks": ["R2 path resolution 누락 (high → mitigation: phase 2 commit 후 새 세션에서 /harness-meta meta 실행, Stage A read path 정상 확인)", "R10 phase 순서 의존성 (low — atomic single commit 으로 차단)", "R5 git mv line ending (very low — 검증 단순)"],
      "commit_message": "feat(meta): v1.1 phase-2 — atomic flip (git mv milestones + thin index + harness-meta.md path resolution)"
    },
    {
      "n": 3,
      "title": "Cross-ref sweep + optional sweeps + scope-discipline smoke 활성화",
      "scope": "Stage A core 의존 없는 모든 갱신 — 모듈 CLAUDE.md / AGENTS.md / README.md / verify / hooks 메시지 / projects/upbit/ARCHITECTURE.md 디렉토리 트리 / projects/upbit/ROADMAP.md 관련 문서 보강. 4 optional sweep (settings.local.json prune / docs/ARCHITECTURE.md grep + 갱신 / harness-roadmap-update SKILL deprecation / .pre-commit-config.yaml 주석). 마지막에 .pre-commit-config.yaml 신규 active local hook block 추가 (smoke 활성화).",
      "affected_files": [
        "CLAUDE.md (root) — 모듈 매트릭스 milestones/ 행 (라인 20) → projects/meta/milestones/, 구조 규칙 (라인 32-33, 52, 55), 관련 문서 (라인 114-115). @ROADMAP.md (라인 9) 유지.",
        "AGENTS.md (root, 영문) — 라인 26 (root ROADMAP 표기), 29-30 (per-project + milestones/), 43 (legacy 4-tier 표기), 68 (legacy 형식 금지), 76 (Active milestones link)",
        "README.md — 라인 158, 162 (디렉토리 트리), 244-245 (legacy sessions/meta/ROADMAP.md 표기 정리)",
        "claude/CLAUDE.md — Hook 정책 § 'sessions/.*/REPORT.(md|ipynb)$' 패턴 설명 (path 변경 반영, 단 hook 자체 갱신은 별도 milestone)",
        "tests/CLAUDE.md — smoke 매트릭스 § milestones/.*\\.md$ → projects/<name>/milestones/.*\\.md$ (라인 235-236) + scope-discipline smoke 신규 row 추가",
        "bootstrap/skills/CLAUDE.md — 라인 110 milestones/v{X.Y}_/ → projects/meta/milestones/v{X.Y}_/",
        "verify.sh / verify.ps1 — 라인 577/608 메시지 텍스트 (선택)",
        "claude/hooks/post-report-write.sh — 라인 153 메시지 텍스트 (선택)",
        "projects/upbit/ROADMAP.md — 관련 문서 § meta link 보강 (../../projects/meta/ROADMAP.md 추가)",
        "projects/upbit/ARCHITECTURE.md — 디렉토리 트리 (라인 59) — projects/meta/ + projects/upbit/ 동형 표시",
        ".claude/settings.local.json (sweep 1) — sessions/meta/ROADMAP.md hardcoded Bash allow entry 5건 prune (라인 26-30)",
        "docs/ARCHITECTURE.md (sweep 2) — grep 검증, milestones/ path 참조 발견 시 projects/meta/milestones/ 로 갱신",
        "bootstrap/skills/audit/harness-roadmap-update/SKILL.md (sweep 3) — 상단 deprecated 주석 추가 (broken since v1.0, sessions/meta/ 참조 dead)",
        ".pre-commit-config.yaml (sweep 4) — 라인 40/51/57 주석 milestones/.*\\.md$ → projects/<name>/milestones/.*\\.md$ 갱신",
        ".pre-commit-config.yaml (smoke 활성화) — 신규 - repo: local 블록 추가 (smoke-projects-scope-discipline, language: system, entry: bash tests/smoke-projects-scope-discipline.sh, pass_filenames: false, files: 'ROADMAP\\.md$|projects/.*/ROADMAP\\.md$')"
      ],
      "rationale": "Stage A 동작에 영향 없는 documentation/operation polish + 신규 smoke 활성화. atomic flip 직후 cross-ref 누락은 markdownlint 가 syntax-only 라 즉시 fail 안 하지만 사용자 가독성 저하 — phase 3에서 일괄 정리. 4 optional sweep 묶음으로 별도 cleanup milestone 회피 (사용자 선호: 한 번에 정리).",
      "risks": ["R8 cross-ref 누락 (medium → mitigation: phase 3 commit 전 grep -r 'ROADMAP\\.md|milestones/' 결과 전수 + ROADMAP.md# anchor fragment grep)", "R4 smoke false positive (medium → mitigation: 신규 smoke 에 fixture 정상/비정상 케이스 + 단독 활성화 후 며칠 모니터링)", "R6 active block 형식 (low → 주석 명시)", "R7 trigger 보존 (low → grep 검증)"],
      "commit_message": "feat(meta): v1.1 phase-3 — cross-ref sweep + optional sweeps + scope-discipline smoke 활성화"
    }
  ],
  "risk_mitigation": [
    {"risk": "R1 milestone 내부 ../../ROADMAP.md self-heal", "mitigation": "phase 2 commit 후 sample 5 REPORT.md 의 cross-ref grep + click test"},
    {"risk": "R2 harness-meta.md path resolution 누락 → Stage A 실패", "mitigation": "phase 2 atomic flip 단일 commit (broken window 0). commit 후 새 세션에서 /harness-meta meta 실행 → Stage A read 정상 resolve 확인 (수동)"},
    {"risk": "R3 thin index 발견성 저하", "mitigation": "projects/meta/CLAUDE.md 신설 + @ROADMAP.md (=projects/meta/ROADMAP.md) lazy import → meta 작업 시 자동 컨텍스트 주입"},
    {"risk": "R4 scope-discipline smoke false positive", "mitigation": "smoke 작성 시 fixture (정상 thin index + 정상 project ROADMAP + 비정상 misclassification) 포함, AC1 단독 활성화 후 며칠 모니터링"},
    {"risk": "R5 git mv line ending — very_low", "mitigation": "phase 2 commit 직후 git diff --stat 로 0 content change 확인 (path만 변경 검증)"},
    {"risk": "R6 신규 active block 형식", "mitigation": "active block 주석에 '단독 활성, v1.1_smoke-precommit-rewrite 에서 통합 예정' 명시"},
    {"risk": "R7 v1.1_upbit-cross-ref-cleanup 이관 trigger 보존", "mitigation": "phase 1 추가 시 status/trigger/summary 정확히 cloning, phase 3 verify"},
    {"risk": "R8 cross-ref 누락 → external 방문자 broken link", "mitigation": "phase 3 commit 전 grep -r 'ROADMAP\\.md|milestones/' (worktree 제외) + ROADMAP.md# anchor 포함 전수, commit log 에 갱신 list"},
    {"risk": "R9 ARCHITECTURE.md 중복", "mitigation": "D3 homomorphic + delegate 채택, root CLAUDE.md / docs/ARCHITECTURE.md 위임 명시"},
    {"risk": "R10 phase 순서 의존성 — low", "mitigation": "phase 2 atomic single commit 으로 broken window 0"},
    {"risk": "R11 projects/upbit/milestones/ 비대칭 미래 우려", "mitigation": "phase 3 CLAUDE.md 구조 규칙 + projects/meta/ARCHITECTURE.md 에 비대칭 의도 명문화"},
    {"risk": "spec-drift 신규 ROADMAP.md# anchor fragment", "mitigation": "phase 3 grep 'ROADMAP\\.md#' 전수 (thin index rewrite로 prior heading 사라짐 — 발견 시 anchor 제거 또는 thin index 측 heading 추가)"},
    {"risk": "Windows long path (>260)", "mitigation": "phase 2 시작 전 git ls-files milestones/ | awk '{print length}' | sort -rn | head 검증 (현 max < 240, 실 risk 0 추정)"},
    {"risk": "보안 — smoke 파일 경로 traversal defense-in-depth", "mitigation": "smoke 작성 시 glob 'projects/*/ROADMAP.md' (single-segment 한정) + roadmap_path regex '^projects/[a-z0-9_-]+/ROADMAP\\.md$' validation + size guard >100KB skip"}
  ],
  "approval": {
    "approved_by": "user",
    "date": "2026-05-08"
  }
}
```

## 5 관점 검토 요약

### Architecture (Plan agent)

- **Verdict**: sound-with-concerns
- **Critical**: phase 2/3 broken window — atomic 통합 필요 (channelled into 본 DESIGN phase 2)
- **결정 영향**: D3 / phase split revised / dual import 우려 (대안: lazy subdir CLAUDE.md 채택)

### Spec-drift (general-purpose + context7)

- **Verdict**: 대체로 정합. 5-hop @import recursion 안전 / git mv 보존 / pre-commit local hook 정확 / json.load 안전
- **충돌**: dual @import (architecture C3) vs single (PLAN intent) — 사용자 결정 (single + lazy subdir 채택)
- **추가 발견**: anchor fragment grep 필요 / Windows long path 사전 확인

### 회귀 risk (Explore agent)

- **Verdict**: 회귀 in scope 0건 (smoke-roadmap-sync.sh:31 hardcoded path 는 이미 disabled — 영향 0)
- **확인됨**: install / verify / sync-agents 무영향. 새 hook 추가 시 ordering 영향 없음. disabled smoke 우발 활성화 없음.

### 보안 (general-purpose + security-review SKILL)

- **Verdict**: low-risk (CRITICAL/HIGH 0건)
- **권장**: smoke V1에 glob 'projects/*/ROADMAP.md' 단일 세그먼트 제한 + roadmap_path regex + size guard. settings.local.json dead Bash entry prune (defense-in-depth).
- **검증됨**: symlink 무영향, git mv 모드/blob 보존, @import = 단순 concat (코드 실행 없음)

### Scope contract (Explore agent)

- **Verdict**: tight + coherent. 10/10 success_criteria 매핑, orphan/violation 0
- **lock-down**: 5 implicit assumption 확정 — thin schema (S1) / path self-heal verification / ARCHITECTURE depth (D3) / phase atomic / smoke fixture

## 관련

- PLAN: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- 활성 ROADMAP (이관 전): [`../../ROADMAP.md`](../../ROADMAP.md)
- 5 관점 subagent 결과 요약: 본 파일 §5-관점-검토-요약
