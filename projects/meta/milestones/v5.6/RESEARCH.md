# RESEARCH — v5.6 environment-auditor-runtime-check-automation

```json
{
  "external": [
    {
      "source": "context7 /websites/code_claude (resolve-library-id: Claude Code)",
      "topic": "claude plugin list / enable / disable spec",
      "findings": "claude plugin list — installed plugins, version, source marketplace, enabled status 표시. `--json` 옵션 = JSON 출력 (errors 필드 포함). `--available` 옵션 = marketplace plugin 포함 (--json 조합 시). claude plugin enable <name> — disabled plugin 재활성. claude plugin disable <name> — install 유지하면서 비활성. source: https://code.claude.com/docs/en/plugins-reference",
      "drift": "spec 명시 — context7 1차 source 검증 완료"
    },
    {
      "source": "context7 /websites/code_claude (query-docs 2회)",
      "topic": "claude plugin details spec",
      "findings": "context7 docs 안 explicit 명시 부재 (plugins-reference 안 list/enable/disable/install 명시, details 별도 docs 안 발견 zero).",
      "drift": "spec 안 explicit 명시 부재 — but v5.1_plugin-component-discovery-fix VERIFY 안 실 사용 검증됨 (`claude plugin details harness-meta` 결과 Agents 7 + Skills 6 + Hooks 2 narrative). 즉 functional 명령이나 docs 등재 안 됨. fallback 전략 필요 — DESIGN 결정."
    },
    {
      "source": "v5.1 INTENT.md + VERIFY.md (projects/meta/milestones/v5.1/)",
      "topic": "claude plugin details 실 사용 패턴",
      "findings": "v5.1 INTENT.md L12-13: 'criterion: claude plugin details harness-meta 결과 Agents 카운트 ≥ 7' + 'verification_source: Stage G VERIFY 안 실 install 후 claude plugin details 결과 첨부'. v5.1 REPORT L33: 'claude plugin details Skills 카운트에 slash command 포함 — Skills (6) = 5 skill + 1 command (harness-meta). Claude Code Plugin spec 안 commands 와 skills 가 Claude-facing 동일 category 로 표시'.",
      "drift": "v5.1 milestone 안 실 사용 검증 + Skills (6) = 5 skill + 1 command (harness-meta) 정합. details 명령은 docs 미등재이지만 functional + harness-meta repo 안 표준 사용 패턴."
    }
  ],
  "codebase": {
    "affected_files_verified": [
      "agents/environment-auditor.md (직접 대상 — Stage G 5 항목 책임 표기 갱신 + B 확장 or 신규 stage 신설 + frontmatter description 'N stage' 갱신, 본문 매트릭스 narrative 갱신)",
      "bootstrap/agents/CLAUDE.md L23 + L108 + L112 (매트릭스 narrative cascade — '10 stage 매트릭스' 거명 grep verify 결과 3 위치, Stage D 결정 후 N stage 로 동기)",
      "Makefile L29 (verify guidance message 안 '10 stage 매트릭스' 거명, grep verify 결과 1 위치, Stage D 결정 후 동기)",
      "CHANGELOG.md ([v5.6] entry 신규 — release note)"
    ],
    "untouched_files_explicit": [
      "agents/agents-md-sync.md L146 (environment-auditor 거명만, 책임 분리 narrative — cascade 의무 부재, out_of_scope #3 정합)",
      "agents/component-installer.md (out_of_scope #3 정합)",
      "agents/project-harness-audit-team/* (5 멤버 team, out_of_scope #3 정합)",
      "claude/hooks/* (out_of_scope #2 정합)",
      "claude/statusline/* (out_of_scope #2 정합)",
      "projects/meta/ARCHITECTURE.md (cascade 의무 부재 — environment-auditor stage 수 변경은 ARCHITECTURE § 3.1 정체성/§ 3 정의/§ 6.1 era 정책 영향 zero)",
      "tests/* smoke (out_of_scope #2 정합)",
      "_archive/* (historical milestone, _archive 안 'environment-auditor' 거명은 historical narrative 보존)"
    ],
    "current_state": {
      "stage_count": 10,
      "stage_labels": "Z / A / B / C / D / E / F / I / J / G",
      "stage_G_items": [
        "G1: /harness-meta slash command 인식",
        "G2: 글로벌 user-skill 호출 (예: /ai-ready-scorer) 인식",
        "G3: root CLAUDE.md @ROADMAP.md 자동 로드",
        "G4: projects/meta/CLAUDE.md lazy subdir on-demand 로드",
        "G5: subdirectory CLAUDE.md (claude/ / bootstrap/skills/ / bootstrap/agents/ / tests/ / projects/meta/) on-demand 로드"
      ],
      "stage_B_items": [
        "B0: Plugin cache 존재 (~/.claude/plugins/cache/harness-meta/)",
        "BP1: agents/ .md 파일 열거 (≥ 7)",
        "BP2: skills/ 디렉토리 열거 (≥ 5)"
      ],
      "bash_whitelist": "허용 = pwsh read-only cmdlet + bash POSIX read-only + python3/jq parse only. 금지 = write 일체 + 외부 호출 (curl/wget/git push/git commit/npm install/pip install). 'claude' CLI 명시 부재 — 추가 명시 필요."
    },
    "target_state": {
      "stage_count": "10 (B 확장) 또는 11 (신규 stage K 신설) — Stage D 결정",
      "automation_classification_criteria_revised": {
        "AUTO": "audit 책임 안 = binary 상태 검증 (file/content/spec/enabled 존재 또는 값) — Bash 환경 단독 결정 가능",
        "MANUAL": "audit 책임 안 = Claude Code 세션 컨텍스트 안 실 동작/효과 인식 — Bash 환경 검증 불가, 세션 내 직접 확인만",
        "책임_분리_원칙": "audit = binary 상태 검증만. '실 효과 검증' (예: slash command 호출 시 동작 / agent invoke / lazy 로드 실 동작) 은 audit 외 책임 (functional test / 세션 안 manual)."
      },
      "automation_matrix_G_5_items_consolidated": {
        "G1_slash_command": "AUTO 부분: `claude plugin list --json` enabled + `~/.claude/plugins/cache/harness-meta/commands/harness-meta.md` 파일 존재 / MANUAL 부분: 실 세션 안 `/harness-meta` 입력 트리거 인식",
        "G2_user_skill": "AUTO 부분: plugin cache 안 skills/*/SKILL.md 파일 존재 list / MANUAL 부분: 실 `/ai-ready-scorer` 호출 인식",
        "G3_at_roadmap": "AUTO 부분: `~/harness-meta/CLAUDE.md` 안 `@ROADMAP.md` 문자열 grep / MANUAL 부분: Claude Code parser 안 실 @import 자동 로드",
        "G4_projects_meta_lazy": "AUTO 부분: `~/harness-meta/projects/meta/CLAUDE.md` 파일 존재 / MANUAL 부분: 실 subdirectory 진입 시 lazy 로드",
        "G5_subdir_ondemand": "AUTO 부분: 5 subdirectory (claude/ / bootstrap/skills/ / bootstrap/agents/ / tests/ / projects/meta/) 안 CLAUDE.md 파일 존재 list / MANUAL 부분: 실 on-demand 로드"
      },
      "automation_consolidation": "G 5 항목 narrative 보존 (5 항목 유지), 각 항목에 'AUTO 부분 + MANUAL 부분' 책임 표기 추가. 자동 stage 안 sub-step 압축 — Plugin activation (별 sub-step) + G AUTO 부분 통합 (single sub-step 안 5 path/grep enumerate). 10 sub-items 세분화 회피 (사용자 의견 흡수).",
      "automation_count_correction_history": "초안: G1=AUTO / G3~G5=MANUAL (부정확). 사용자 의문 round 1: 모두 PARTIAL (file (a) + session (b)). 사용자 의문 round 2: 책임 분리 (binary 상태 검증 = AUTO / 실 효과 검증 = MANUAL). 사용자 의문 round 3: 10 sub-items 세분화 회피 → G 5 항목 narrative 유지 + AUTO/MANUAL 책임 표기 + 자동 stage sub-step 압축.",
      "plugin_activation_new_check_consolidated": "Plugin activation enabled 검증 = AUTO 완전 (binary 상태 검증). 자동 stage 안 sub-step 통합 — Stage B 확장 시 BP3 (activation, 신규) + BP4 (G 5 항목 AUTO 부분 통합 single step, 5 path/grep enumerate). 신규 Stage K 안 통합 시 K1 (activation) + K2 (G 5 항목 통합). Stage D 결정 의존. G 5 항목 narrative 본문 보존 = 책임 표기 추가만."
    }
  },
  "options": [
    {
      "id": "O1_extend_stage_B",
      "label": "Option A: Stage B 확장 (10 stage 유지)",
      "approach": "Stage B 안 BP3 (Plugin activation enabled 검증) + BP4 (commands/harness-meta.md 파일 존재) + BP5 (G2 자동화 부분 - skills file 존재 보강) 추가. Stage G 5 항목 → 3 항목 (G3/G4/G5) 잔존. stage_count 10 유지.",
      "pros": [
        "stage_count 10 유지 — frontmatter description 'N stage' 변경 최소",
        "B 의미 본질 = 'install 검증' 인데 'activation' 도 install 검증 자연 확장 — 의미 정합",
        "narrative 변경 작음, 회귀 risk 낮음"
      ],
      "cons": [
        "B 가 'install + activation + runtime check 부분' 의 3 책임 — 단일 책임 약간 모호화",
        "Plugin activation 은 install 후 별 단계 — '검증' 의미 안 묶을 수 있지만 단어 부합도 strict 아님"
      ]
    },
    {
      "id": "O2_new_stage_K",
      "label": "Option B: 신규 Stage K (Activation + Runtime Auto) 신설 (11 stage)",
      "approach": "Stage K 신규 = Plugin activation + commands/harness-meta.md 파일 존재 + skills/*/SKILL.md 파일 존재. Stage G 5 항목 → 3 항목 (G3/G4/G5) 잔존. stage_count 11.",
      "pros": [
        "단어 = 단일 책임 1:1 매핑 정합 (B = install / K = activation+runtime / G = 세션 의존 manual)",
        "B 책임 분리 명확, narrative 책임 분리 정합 (v3.10 부산물 정책 정합)"
      ],
      "cons": [
        "stage_count 10 → 11 변경, frontmatter description + 본문 매트릭스 cascade",
        "신규 stage 라벨 'K' (J 다음) — alphabet ordering 자연성 OK, but Z 플랫폼 전제와 ordering 혼란 risk"
      ]
    },
    {
      "id": "O3_hybrid_B_extend_minimal",
      "label": "Option C: Stage B 확장 (BP3 activation 만) + G 5 항목 유지 (수동 분류 narrative 정밀화)",
      "approach": "BP3 (activation) 만 추가. G 5 항목 그대로 유지하되 각 항목에 'AUTO/PARTIAL/MANUAL' 분류 label 추가 narrative — 자동화는 추가 안 하고 'classification 만 정밀화'. stage_count 10 유지.",
      "pros": [
        "회귀 risk 최소 — 기존 G 항목 변경 zero",
        "Plugin activation 신규 + 분류 narrative 만 = 최소 변경"
      ],
      "cons": [
        "자동화 가능한 G1/G2 file 존재 검증을 'manual' 로 잔존 = sc_3 위반 (자동화 가능 항목이 G 잔존)",
        "INTENT goal '자동화 가능 항목 이전' 미충족"
      ]
    }
  ],
  "five_perspective_preanalysis": {
    "1_architecture": "Stage B 확장 vs 신규 Stage K 결정 (Options O1/O2/O3) 이 본 milestone architecture 핵심. environment-auditor.md = single source — 본문 매트릭스 구조 갱신 + frontmatter description 'N stage' 갱신 + Bash 화이트리스트 § 갱신. 단일 책임 1:1 매핑 정합 (B = install + activation 책임 단일 vs B = install / K = activation+runtime 책임 분리) 가 결정자 키.",
    "2_spec_drift": "context7 1차 source 검증: `claude plugin list --json` spec 안 명시 (enabled status + errors 필드). but JSON schema (key 이름 'enabled' vs 'isEnabled') 명시 부재 — Stage F EXECUTE 시 실 spike 검증 + DESIGN.decisions 안 명시 가정 (R7 mitigation). `claude plugin details` 명령 docs 미등재 — v5.1 functional 검증만 (R3 mitigation, 채택 회피 권장).",
    "3_regression_risk": "1) environment-auditor.md 본문 매트릭스 변경 → bootstrap/agents/CLAUDE.md '10 stage' 3 위치 + Makefile 1 위치 narrative drift (Stage F 안 cascade 동기 의무). 2) Bash 화이트리스트 § 갱신 → 기존 명령 호환 보존 (additive only, 회귀 zero). 3) G 5 항목 narrative 책임 표기 추가 → narrative LOC 증가 (R11) 작음, 회귀 risk 낮음. 4) 신규 자동 stage 안 `claude` CLI 호출 → CLI 부재 환경 fallback narrative (R1/R12 mitigation).",
    "4_security": "Bash 화이트리스트 확장 (read-only `claude plugin list` / `--json` 추가) = side-effect-free 검증 — output 만 표시, write 일체 부재. `claude plugin details` 채택 회피 권장 (docs 미등재 + Plugin activation 검증은 list --json 으로 충족). path traversal / command injection risk zero (`claude` 표준 CLI subcommand, 사용자 입력 무관). D7 보안 정합.",
    "5_scope_contract": "INTENT.success_criteria 7건 (sc_1~sc_7) ↔ DESIGN.phases 매핑 의무. 매핑 예시 — phase-1 (또는 단일 phase Lightweight): sc_1 (matrix) + sc_2 (activation) + sc_3 (G 잔존 기준) + sc_4 (frontmatter+본문) + sc_5 (회귀 0 + 자연어 호출 trace) + sc_6 (Bash 화이트리스트) + sc_7 (pre-commit). out_of_scope 4건 (cascade narrative 허용 narrative 정합)."
  },
  "risks_identified": [
    "R1: `claude` CLI 부재 환경 (사용자가 Claude Code CLI 미설치 또는 PATH 미등록) — automation stage 안 fallback narrative 필요 (예: 'CLI 부재 시 WARN + manual fallback')",
    "R2: `claude plugin list --json` 출력 format 변경 시 grep 패턴 깨짐 — context7 1차 source 인용 + JSON parse (python3/jq) 권장 (regex grep 회피)",
    "R3: `claude plugin details` 명령 docs 미등재 — v5.1 사용 narrative 안 functional 확인이지만 spec-fidelity 약함. Plugin activation 검증은 `plugin list --json` 채택 (spec docs 안 명시) 으로 회피 가능",
    "R4: Bash 화이트리스트 확장 — `claude plugin list` / `claude plugin list --json` 추가 = read-only side-effect-free 검증 (output 만 표시, write zero). 보안 정합 — Stage D 5 관점 검토 안 보안 관점 명시",
    "R5: Stage B 확장 vs 신규 Stage K 결정 (Stage D) 가 frontmatter description + 본문 매트릭스 cascade 범위 결정 — DESIGN 5 관점 검토 의무",
    "R6: `claude plugin list --json` 결과 안 harness-meta entry 부재 시 (예: marketplace add 됐지만 install 안 됨, 또는 다른 marketplace 안 install) — 분류 분기 narrative 필요 (Stage B0 cache 존재 PASS + activation 검증 FAIL = '재 install 권고' 메시지)",
    "R7: Claude Code 버전 차이 안 `plugin list --json` schema 변동 — context7 spec 안 schema 명시 부재 (errors 필드만 명시), 키 이름 ('enabled' / 'isEnabled' / 'status' 등) 정확 검증을 Stage F EXECUTE 시 실 호출 결과 spike 필요. 추정 = `enabled` (boolean) but Stage D 안 spike 검증 + DESIGN.decisions 안 명시",
    "R8: cross-platform 정합 — PowerShell 7+ 환경 (Windows) vs bash 4+ 환경 (Linux/macOS) 안 `claude plugin list --json` stdout encoding 차이 (Windows cp949 환경 안 UTF-8 BOM 함정 v2.1 cp949 패턴 정합) — Stage F 안 `pwsh -Command` vs `bash -c` 둘 다 검증 + JSON parse encoding 명시",
    "R9: `claude plugin disable harness-meta` 후 (install 유지하면서 비활성화) Stage B B0 cache 존재 PASS / 신규 activation 검증 FAIL = 정상 분기. 본 분기 narrative 명시 필요 — disabled 상태가 audit FAIL 으로 인지되지 않도록 (사용자 의도 disable 정합 메시지)",
    "R10: 자동화 stage 의 sub-step (예: BP3 + BP4 + BP5) granularity — entire stage FAIL vs partial WARN 결정. v5.5 패턴 (B0/BP1/BP2 각각 PASS/FAIL 독립) 정합 채택 권고 — Stage D decisions 안 명시",
    "R11: G 잔존 항목 narrative LOC — 분류 label (AUTO/PARTIAL/MANUAL) 추가 시 environment-auditor.md 본문 (현 178 LOC) 약 5~10% 증가 추정. 비대화 risk 낮음, but Stage D 5 관점 검토 안 단순성 관점 (`simplicity`) 명시",
    "R12: PATH 부재 `claude` 명령 (e.g., `npx claude` 만 사용) — `Get-Command claude` 또는 `command -v claude` 사전 check 필요. R1 의 sub-risk 분리"
  ]
}
```

## narrative

`claude plugin list --json` 은 context7 docs 안 spec 명시 (1차 source 검증) — Plugin activation 자동 check 의 권장 source. `claude plugin details` 는 docs 미등재 (functional 검증 v5.1 milestone 안) — fallback 또는 미채택 결정 필요.

G 5 항목 자동/수동 매트릭스 — 사용자 의문 round 3회 거쳐 정정. 책임 분리 원칙: **audit = binary 상태 검증만. 실 효과 검증은 audit 외 책임**. 단순화 후: G 5 항목 narrative 유지 + 각 항목 'AUTO 부분 + MANUAL 부분' 책임 표기 추가. 자동 stage 안 sub-step 압축 — Plugin activation 별 sub-step + G AUTO 부분 통합 single sub-step. 본문 LOC 비대화 회피 + 책임 표기 명확화 동시 달성.

3 options (B 확장 / 신규 Stage K / 최소 변경 hybrid) 중 결정은 Stage D — 단어-책임 정합 (B = install 책임 vs K = activation+runtime 별 책임) 과 cascade 비용 (10/11) trade-off.

12 risks 식별 — R1~R5 base (CLI 부재 / JSON format / details 미등재 / Bash 화이트리스트 / DESIGN 결정) + R6~R12 추가 (entry 부재 분기 / Claude Code 버전 schema 변동 / cross-platform encoding / disabled 상태 분기 / granularity / 본문 LOC / PATH 부재 sub-risk).
