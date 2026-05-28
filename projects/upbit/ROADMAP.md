# ROADMAP — upbit

```json
{
  "project": "upbit",
  "updated": "2026-05-18",
  "v1_19_note": "v1.19 (2026-05-18 completed) — harness-meta v5.14 audit cycle 3 사용자 Accept 4건 mechanical apply. G1(.claude/settings.local.json stale cp 4건 제거, gitignored 실 적용) + G2(CLAUDE.md L114~L127 v4.x symlink narrative → v5.0+ deprecated blockquote 교체) + G3(.claude-plugin/plugin.json SessionStart hook 등록 + hooks/session-start.sh 신규) + S2(.claude-plugin/agents/spike-investigator.md 신규, read-only scope-bounded). DESIGN 단계에서 audit chain 추가 hallucination 2건 정정 — D2(SessionStart hook 형식 = harness-meta hooks.json 정합, proposal draft 평면 형식 정정) + D3(spike-investigator tools = Read/Glob/Grep/WebFetch/WebSearch, context7 미가용 정정). v5.13 절차 cycle 4 검증 evidence(synthesizer 5건 + apply 2건 = 7건 누적). 3 관점 review pass (architecture single phase 권고 + scope contract SC#7 명확화 흡수 + spec-drift hallucination 정정). 단일 phase 1 commit (b86ad81, 5 files +79/-8: plugin.json + CLAUDE.md modified + spike-investigator.md/session-start.sh/phase-1.md new). 회귀 0 (ruff PASS + pytest 638 baseline 정합 + harness-meta smoke 3종 PASS 168/40/PASS). v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 열다섯 번째 실 적용. v5.0+ Plugin spec 외부 적용 세 번째 (v1.17 첫 + v1.18 두 번째). 7 lessons (L1 audit chain hallucination cycle 4 누적 / L2 apply 단계 정정 추가 패턴 / L3 settings.local.json gitignored audit trail / L4 vector 카운트 모호성 / L5 propose vs apply 분리 / L6 low-risk 단일 phase 누적 / L7 Stage G commit 통합 b 패턴). 5 candidates_named_only (L2/L4 신규 origin 2 + L6 carry-over 3). 2026-05-18.",
  "v1_18_note": "v1.18 (2026-05-18 completed) — harness-meta v5.12 PROPOSE next_candidates#6 (upbit-plugin-json-hooks-mcpservers-extension, A_user trigger 대기) 사용자 명시 발의. v1.17 G1 phase-1 축소 적용 (.claude-plugin/plugin.json 안 agents + skills 2 필드만, hooks + mcpServers 보류) = N4 gap 완전 해소. OPT-A Full migration 단일 phase 통합 — plugin.json hooks (PreToolUse Bash/Write + PostToolUse Edit|Write|MultiEdit ${CLAUDE_PLUGIN_ROOT}/hooks/) + mcpServers.harness (type:stdio + command:poetry + args + description) inline 신설 + .claude/hooks/ → .claude-plugin/hooks/ 이전 (git rename 100%) + .mcp.json 삭제 + .claude/settings.json hooks block + enabledMcpjsonServers + permissions.allow Edit(.claude/hooks/...) 3 위치 제거. v1.17 SPIKE S2 (MCP tool) + S3 (hook stdin) RESEARCH context7 multi-source 7건 통합 해소. v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta **열네 번째** 실 적용. 4 관점 review (architecture/spec-drift/회귀 risk/scope contract) pass-with-comments 3 + pass 1 + decisive 0 + P1 권고 2 즉시 흡수 + P2 권고 5 phase-1 narrative + D6 type:stdio 보존 신규 + P3 권고 8 PROPOSE 거명. SC 7건 중 6 PASS + 1 PENDING_USER (SC#6 실 install 의존). 회귀 0 (pytest 638 collected + ruff/format + harness-meta smoke 3종 PASS, pre-existing collection error 2건 git stash 검증 무관). 1 phase 1 commit (4bc7180, 5 files +124/-49). v5.0+ Plugin spec 외부 적용 두 번째 사례 (v1.17 첫). 7 lessons (L1 context7 multi-source 7건 cross-validation + L2 단일 phase 통합 + git rename + L3 CLAUDE_PLUGIN_ROOT vs CLAUDE_PROJECT_DIR 2 variable layer + L4 MCP cwd 미지정 plugin source 외부 거주 spec-correct + L5 N4 gap 완전 해소 + L6 OOS RESEARCH-DESIGN 순차 narrative + L7 git stash pre-existing 검증 cycle 2). 7 candidates_named_only 후속 (외부 vector 5 + harness-meta 안 2). 2026-05-18.",
  "v1_16_note": "v1.16 (2026-05-13 completed) — v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta **열두 번째** 실 적용 milestone. v1.15 PROPOSE next_candidates_named_only #5 (bot-core-assert-refactor-v1.16, A_user trigger 대기) 사용자 명시 발의. bot/core/{strategy,risk,position,regime}.py 14 assert → 11 raise (TypeError 2 + RuntimeError 9 + combined 2) refactor 첫 milestone — Python -O / -OO 자동 제거 silent invariant 결함 risk 해소 + # noqa: S101 14건 inline 자연 제거 (assert root cause refactor). 5 관점 review 전원 pass / pass-with-comments + decisive 0 + 의견 충돌 0 + P2 4건 흡수. 단일 phase 1 commit (d64bc36, 11 files +989 -14). 회귀 0 (pytest 638 baseline + ruff/mypy + PYTHONOPTIMIZE manual smoke). § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 12건 + (2) 동결 유지 narrative 6회 누적 (v1.7 + v1.12 + v1.13 + v1.14 + v1.15 + v1.16). 9 candidates_named_only 거명 (§ 6.2 동결 6 + A_user 대기 2 — scripts-harness-noqa-s101 / deserialize-state-file-robustness + cycle 3 trigger 거명 1).",
  "v1_15_note": "v1.15 (2026-05-13 completed) — v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta **열한 번째** 실 적용 milestone. v1.14 PROPOSE next_candidates_named_only #7 (A_user trigger 대기) 사용자 명시 발의. ruff S (flake8-bandit) rule 활성화 + per-file-ignores 도입 첫 milestone — Option B (좁은 per-file-ignores + individual # noqa intent narrative). 28 파일 # noqa + pyproject.toml 단일 phase 통합. § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 11건 + (2) 동결 유지 narrative 5회 누적 (v1.7 + v1.12 + v1.13 + v1.14 + v1.15). 9 candidates_named_only 거명 (§ 6.2 동결 6 + A_user 대기 3 — bot/core assert refactor / notifier scheme validation / statusline logging refactor).",
  "v1_14_note": "v1.14 (2026-05-13 completed) — v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta **열 번째** 실 적용 milestone. v1.13 PROPOSE next_candidates_named_only #3 (upbit-ruff-rules-expansion, A_user trigger 대기) 사용자 명시 발의. ruff 공식 popular canonical set [E, F, UP, B, SIM, I] 6 rule 활성화 (사용자 선택 = 외부 spec 정확 일치, drift 0). 4 디렉토리 471 위반 단일 phase 통합 처리. Stage F EXECUTE 결정 흡수 1건 (DESIGN 2-phase → 단일 phase, v1.12/v1.13 패턴 정합 누적 3건). § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 10건 도달 + (2) 동결 유지 narrative 4회 누적 (v1.7 + v1.12 + v1.13 + v1.14).",
  "v1_13_note": "v1.13 (2026-05-12 completed) — v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta **아홉 번째** 실 적용 milestone. § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 9건 도달 + (2) 검증 동결 유지 narrative 정합 (v1.7 + v1.12 + v1.13 누적 3회 패턴). 11 minor jump (v0.4.10 → v0.15.12) + 21파일 reformat + Stage F 사용자 결정 1건 흡수 (poetry --no-update 부재, v1.12 .git/hooks 부재 패턴 정합).",
  "v1_12_note": "v1.12 (2026-05-12 completed) — v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta **여덟 번째** 실 적용 milestone. § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 8건 도달 + (2) 검증 v3.13 결정 narrative 정합 동결 유지. 2-leg defense (local + remote) 도입 + Stage F 사용자 결정 1건 흡수 (.git/hooks/pre-commit 부재 → pre-commit install, out_of_scope #3 허용 범위).",
  "v1_9_note": "v1.9 (2026-05-13 completed) — v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta **다섯 번째** 실 적용 milestone. § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 5건 도달.",
  "v1_7_note": "v1.7 (2026-05-12 completed) — v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta **세 번째** 실 적용 milestone. § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 3건 도달 (v1.5 + v1.6 + v1.7), 조건 (2) evidence 부족으로 동결 유지 (memory project_deferred_3_freeze_decision_2026_05_12.md 정합).",
  "v1_17_note": "v1.17 (2026-05-14 completed) — v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta **열세 번째** 실 적용 milestone. harness-meta v4.0_harness-composer-pivot phase-6 도입 `/harness-meta upbit --audit` opt-in 분기 첫 실 적용 — project-harness-audit-team 5 멤버 sequence (project-scanner → harness-gap-analyzer → claude-docs-mapper → component-proposer → component-installer) 완전 실행 + e3 정책 ACCEPT ALL 결정 게이트 통과 + 9-stage 정식 workflow 진행. audit 결과 12 항목 완전 적용 (G1 plugin.json + 11 git mv + G5/F1 trading-safety-checker + G6 paper-trading-gate + G8 quality.yml security 2 step + G2/F5 backup 삭제 + G3 CLAUDE.md narrative + F2 harness-verifier scope + F6 harness-grey-area scope + C1 harness-review SKILL description + C2~C6 KEEP). 3 phase 3 commit (719c6ee + ff2875c + a856ddc). v5.0+ Plugin spec 외부 적용 첫 사례. § 6.2 폐지 narrative 자연 정합. cycle 3 trigger 조건 잔여 3건 추가 누적 필요 (v1.20 도달).",
  "schema_note": "v3.0+ 9-stage-bundled era entry: {version, id (group-slug), title, status, summary, trigger, milestones_path?}. v2.0~v2.1 / v1.0~v1.4 보존 entry: 기존 schema (id flat = v{X.Y}_{slug}) 유지 (forward-only).",
  "milestones": [
    {
      "version": "v1.20",
      "id": "upbit-audit-cycle4-apply",
      "title": "upbit audit cycle 4 proposal R1+R2 bundled 적용",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v1.20/milestones.md",
      "summary": "harness-meta v5.15 PROPOSE next_candidates#1 (A_user trigger 사용자 ACCEPT ALL R1+R2 bundled, R2 Option A) mechanical apply 완료. upbit CLAUDE.md 3 위치 (L37 v1.20 C3 → v1.12 + L124 .claude/hooks → .claude-plugin/hooks + L125 .mcp.json → plugin.json mcpServers.harness) 단일 phase 단일 commit (9d2862c) 동기 변경. v1.18 plugin.json hooks+mcpServers inline 통합 (commit 4bc7180) narrative cascade 누락 정정 + v1.20 self-referential forward reference 제거. v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 열여섯 번째 실 적용 milestone. v5.0+ Plugin spec 외부 적용 세 번째 (v1.17+v1.18+본 v1.20). lightweight 모드 외부 적용 5 번째 사례 (v1.15+v1.16+v1.19+본 v1.20). cycle audit + apply 분리 4 cycle 패턴 정합 (v5.10/v5.14/v5.15 cycle audit ↔ v1.19/v1.20 apply). RESEARCH cascade grep 단계 안 추가 host 4건 (.pre-commit-config.yaml L1 + .claude-plugin/agents/harness-dispatcher.md L58 + scripts/harness/mcp_server.py L5 + docs/HARNESS.md L300) 발견 → 사용자 명시 Option C 채택 (audit proposer scope 그대로, 추가 host PROPOSE 거명 + 별 milestone candidate, v3.10 부산물 통합 흡수 정책 정합). v3.21 narrative 정전화 3 단계 패턴 (DESIGN.D6.exact_text 1차 source + Stage F Edit + Stage G grep 검증) 18 번째 cycle 도그푸드 완성. pre-commit 14 hook 모두 PASS (3 Skipped Python 파일 부재 + 1 Detect secrets Passed) 회귀 0. INTENT.success_criteria 7건 모두 PASS (sc_1~sc_5 PASS + sc_6 PASS + sc_7 PASS). 7 lessons (L1 cascade grep 추가 host / L2 외부 cycle 3 도그푸드 / L3 lightweight 외부 5 cycle / L4 v3.10 부산물 흡수 / L5 self-referential forward ref 패턴 / L6 audit chain hallucination 재발 / L7 외부 적용 16건 누적). next_candidates 5건 거명만 (ROADMAP 등재 zero, lightweight default 동결 정합 11 cycle). 2026-05-18."
    },
    {
      "version": "v1.19",
      "id": "upbit-audit-cycle3-apply",
      "title": "upbit audit cycle 3 proposal 4건 적용",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v1.19/milestones.md",
      "summary": "harness-meta v5.14 audit cycle 3 사용자 Accept 4건(G1 stale cp + G2 CLAUDE.md narrative + G3 SessionStart hook + S2 spike-investigator) mechanical apply. DESIGN 단계 audit chain hallucination 2건 정정(D2 plugin.json hooks 형식 + D3 spike-investigator tools). 3 관점 review pass. 단일 phase 1 commit (b86ad81, 5 files). 회귀 0. v3.0+ 9-stage-bundled era 외부 15번째 + v5.0+ Plugin spec 외부 3번째 실 적용. 7 lessons + 5 candidates_named_only. 2026-05-18."
    },
    {
      "version": "v1.18",
      "id": "upbit-plugin-json-hooks-mcpservers-extension",
      "title": "upbit .claude-plugin/plugin.json hooks/mcpServers 필드 신규",
      "status": "completed",
      "milestones_path": "milestones/v1.18/milestones.md",
      "trigger": "A_user",
      "summary": "harness-meta v5.12 PROPOSE next_candidates#6 사용자 명시 발의. v1.17 G1 phase-1 축소 적용 N4 gap 완전 해소 — `.claude-plugin/plugin.json` 안 hooks (PreToolUse Bash/Write + PostToolUse Edit|Write|MultiEdit `${CLAUDE_PLUGIN_ROOT}/hooks/`) + mcpServers.harness (type:stdio + command:poetry + args + description) inline 신설 + `.claude/hooks/` → `.claude-plugin/hooks/` 이전 (git rename 100%) + `.mcp.json` 삭제 + `.claude/settings.json` hooks block + enabledMcpjsonServers + permissions.allow Edit(.claude/hooks/...) 3 위치 제거. v1.17 SPIKE S2 (MCP tool) + S3 (hook stdin) RESEARCH context7 multi-source 7건 통합 해소. OPT-A Full migration 단일 phase 1 commit (4bc7180, 5 files +124/-49). 4 관점 review pass-with-comments 3 + pass 1 + decisive 0 + 의견 충돌 0 + P1 권고 2 즉시 + P2 권고 5 phase-1 narrative + D6 신규 + P3 권고 8 PROPOSE 거명. SC 7건 중 6 PASS + 1 PENDING_USER. 회귀 0 (pytest 638 collected + ruff/format + harness-meta smoke 3종 PASS, pre-existing collection error 2건 git stash 검증 무관). v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 열네 번째 실 적용. v5.0+ Plugin spec 외부 적용 두 번째. 7 lessons + 7 candidates_named_only (외부 vector 5 + harness-meta 안 2). 2026-05-18."
    },
    {
      "version": "v1.17",
      "id": "upbit-harness-plugin-pivot-and-audit-componentry",
      "title": "upbit harness Plugin spec 전환 (audit componentry 포함)",
      "status": "completed",
      "milestones_path": "milestones/v1.17/milestones.md",
      "trigger": "A_user",
      "summary": "harness-meta v4.0_harness-composer-pivot phase-6 도입 `/harness-meta upbit --audit` opt-in 분기 첫 실 적용 milestone. project-harness-audit-team 5 멤버 sequence (project-scanner read-only scan 6 anomaly + harness-gap-analyzer 8 gap + 6 conflict + 6 fleet evolution detect + claude-docs-mapper context7 6 source 매핑 + component-proposer 12 항목 proposal-draft) 완전 실행 + e3 정책 ACCEPT ALL 결정 게이트 통과 + 9-stage 정식 workflow (Stage A~I) 진행. audit 결과 12 항목 완전 적용 — G1 plugin.json 신규 (D3 directory string `./agents`+`./skills`) + 11 component git mv 디렉토리 단위 2 operation 15 R rename (.claude/agents → .claude-plugin/agents 4종 + .claude/skills → .claude-plugin/skills 11 파일) + G5/F1 trading-safety-checker 신규 (sonnet, Read/Grep/Glob read-only, GUARDRAILS+ADR-021+ADR-027 위반 4 차원 audit) + G6 paper-trading-gate 신규 (haiku, Read/Grep, ADR-027 72h advisory) + G8 quality.yml ruff S + pip-audit step 2건 (D9 ruff job 안 append, v1.12 패턴 정합) + G2/F5 backup 2건 삭제 (.gitignore ignore 상태 git 영향 zero) + G3 CLAUDE.md:54 narrative 교체 (cascade grep D8 4 키워드 단일 host) + F2 harness-verifier 'CI Workflow Verification' append + F6 harness-grey-area 'Docker Memory Limit ADR-021 Violation' case append + C1 harness-review SKILL description 분리 + C2~C6 KEEP 변경 부재. SPIKE 보류 4건 (S1 mypy latency / S2 MCP tool / S3 hook stdin / S4 dispatcher) + F4 조건부 = 본 milestone 외 사실 진술 (OOS#1~OOS#4). 5 관점 review 통합 verdict pass-with-comments (architecture pass-with-comments + spec-drift fail→부분 해소 + 회귀 risk pass-with-comments + 보안 pass-with-comments + scope contract pass-with-comments) + decisive 2건 (D4 tools 필드 vs disallowedTools + D5/D6 풀 model ID vs alias) 해소 (harness-meta v5.0+ agents 7/7 표준 grep 검증 후 D5/D6 alias 변경 흡수 + D4 유지 narrative 보강) + P1 권고 12건 흡수 (5건 즉시 + 7건 Stage F). 3 phase 3 commit (phase-1 719c6ee skeleton 17 files + phase-2 ff2875c 신규/scope 6 files + phase-3 a856ddc cleanup 3 files). 회귀 0 (pytest 638 in 33.90s v1.16 baseline 정합 + ruff check/format/S 모두 PASS + mypy --strict 29 source files 0 issues + harness-meta smoke 3종 PASS 102/24/PASS + pre-commit 3 commit 모두 PASS). INTENT.success_criteria 12건 중 10 PASS + 1 PASS_WITH_PARTIAL (SC#1 plugin install 검증 PENDING_USER) + 1 PASS_PENDING_CI (SC#4 actionlint PENDING_USER) + 1 Stage I 흡수 (SC#12). 7 lessons (L1 `/harness-meta --audit` 첫 실 적용 + L2 5 관점 의견 충돌 자체 표준 grep 검증 + L3 git mv 디렉토리 단위 효율 + L4 .claude-plugin/ + .claude/ dual layout 분리 패턴 + L5 cascade grep 단일 host 결과 + L6 audit team result + 9-stage 산출물 통합 흡수 + L7 외부 적용 13번째 + § 6.2 폐지 자연 정합). 7 candidates_named_only 후속 (next_candidates 빈 배열, ROADMAP 미등재) — A_user trigger 대기 4건 + C_improvement 2건 + B_regression cycle 3 1건. v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 열세 번째 실 적용. v5.0+ Plugin spec 외부 적용 첫 사례. 2026-05-14."
    },
    {
      "version": "v1.16",
      "id": "upbit-bot-core-assert-refactor",
      "title": "upbit bot/core invariant assert 14건 refactor",
      "status": "completed",
      "milestones_path": "milestones/v1.16/milestones.md",
      "trigger": "A_user",
      "summary": "v1.15 PROPOSE next_candidates_named_only #5 (bot-core-assert-refactor-v1.16, A_user trigger 대기) 사용자 명시 발의 (2026-05-13). bot/core/{strategy.py L97 L229 + risk.py L35 L112 + position.py L112 L113 L287 + regime.py L193 L218-219 L228-230 L249} 안 14건 production invariant assert (S101 # noqa 14건 inline 억제) → 명시적 raise refactor: **TypeError 2건** (isinstance: risk.py L35 Settings DI + position.py L287 JSON deserialize) + **RuntimeError 9건** (single None violation) + **RuntimeError combined 2건** (regime.py L218-219 DM14 + L228-230 DI computation, D3 결정 14 assert → 11 raise). # noqa: S101 14건 inline 자연 제거 (assert root cause refactor). Python -O / -OO 모드 시 assert 자동 제거 silent invariant 결함 risk 해소 — upbit 실 거래소 API hot path (position close / regime ATR+DM14+ADX / risk ATR / strategy MACD+RSI) 보안 critical 본질. 5 관점 병렬 review (architecture pass / spec-drift pass / 회귀 risk pass-with-comments / 보안 pass / scope contract pass-with-comments) + decisive_issues 0 + 의견 충돌 0 + P2 권고 4건 흡수 (D4 msg 통일 / approach SC#2 / R5_new SC#5 / Stage E·F 재검증). Stage F EXECUTE 안 ruff E501 3 round 검증 (Round 1 refactor 직후 5 errors → Round 2 ruff format auto multi-line 분할 3 errors 잔존 → Round 3 implicit string concat 수동 분할 0 errors). 단일 phase 1 commit (d64bc36, 11 files +989 -14). 회귀 0 (pytest 638 passed in 40.52s v1.15 baseline 정합 + ruff check 0 + ruff format 0 mismatch + mypy strict 0 error + PYTHONOPTIMIZE=1 + python -O TypeError raise sample manual smoke PASS). INTENT.success_criteria 7건 모두 VERIFY.criteria_check PASS (SC#7 Stage I 흡수). v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta **열두 번째** 실 적용 — § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 12건 + (2) 동결 유지 narrative 6회 누적 (v1.7 + v1.12 + v1.13 + v1.14 + v1.15 + v1.16). 7 lessons (L1 multi-line raise msg implicit concat / L2 PYTHONOPTIMIZE manual smoke / L3 review-burden minimization 누적 4건 / L4 combined check 14→11 / L5 deferred cycle 3 trigger / L6 scripts/harness # noqa S101 6건 잔존 / L7 stage-f edit parallelism). 9 candidates_named_only 후속 (next_candidates 빈 배열, ROADMAP 미등재) — § 6.2 동결 6건 + A_user trigger 대기 2건 (scripts-harness-noqa-s101 / deserialize-state-file-robustness) + cycle 3 trigger 거명 1건. 2026-05-13."
    },
    {
      "version": "v1.15",
      "id": "upbit-ruff-bandit-S-rule-expansion",
      "title": "upbit ruff S (flake8-bandit) rule set 활성화",
      "status": "completed",
      "milestones_path": "milestones/v1.15/milestones.md",
      "trigger": "A_user",
      "summary": "v1.14 PROPOSE next_candidates_named_only #7 (upbit-ruff-bandit-S-rule-expansion, A_user trigger 대기) 사용자 명시 발의. v1.14 보안 review P2 거명 + INTENT.out_of_scope OOS#1 (S rule 미활성화 사실 진술) origin. pyproject.toml `[tool.ruff.lint].select` 6→7 entry ('S' 추가, popular canonical + flake8-bandit) + `[tool.ruff.lint.per-file-ignores]` section 신규 (tests/** + scripts/tests/** S101 광범위 + scripts/tests/** S108 광범위, ruff 공식 example 정합) + L48~L54 narrative 갱신 (v1.15 per-file-ignores 도입 첫 milestone, modal 모순 회피, D3 결정). Option B 채택 (좁은 per-file-ignores + individual `# noqa: S{nnn} — <intent>` inline 주석) — 사용자 명시 결정 + 외부 ruff 공식 spec 정합. 단일 phase 통합 처리 (v1.14 패턴 정합) — 28 파일 # noqa: bot/core 14 (production invariant assert, v1.16+ refactor candidate) + scripts/harness 18 (S603/S607/S310/S602/S311/S110 internal-trust + S101 internal/self-test invariant) + scripts/tests/harness 5 + scripts/validate 1 + tests 6 (S105/S106 test fixture mock credential + S603/S607 test subprocess). 5 관점 review (architecture + spec-drift + 회귀 risk + 보안 + scope contract) 전원 pass / pass-with-comments + decisive_issues 0 + 의견 충돌 0 + 권고 흡수 11건 (Stage D 4건 즉시 + Stage F 7건 execution_notes). Stage F EXECUTE 결정 흡수 1건 (RESEARCH 누락 12건 EXECUTE 보완 흡수, v1.14 lessons L1 ruff cascade multi-pass 패턴 누적 2건). INTENT.success_criteria 7건 모두 VERIFY.criteria_check PASS (SC#5 push 후 CI manual + SC#7 Stage I commit 흡수). 회귀 0 (ruff check 0 errors + ruff format 0 mismatch + pytest 638 passed in 33.10s baseline 정합 + pre-commit 4 hook + harness-meta smoke 3종 238/47/1 PASS). v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta **열한 번째** 실 적용 milestone — § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 11건 + (2) 동결 유지 narrative 5회 누적 (v1.7 + v1.12 + v1.13 + v1.14 + v1.15). 7 lessons (L1 RESEARCH vs EXECUTE drift / L2 Stage F 결정 흡수 누적 4건 / L3 multi-line # noqa 위치 spec / L4 review-burden 최소화 누적 3건 / L5 5 관점 review 보안 핵심 의도 evidence / L6 narrative cascade 갱신 / L7 외부 적용 11번째 + 동결 5회 누적). 9 candidates_named_only 후속 (next_candidates 빈 배열, ROADMAP 미등재) — § 6.2 동결 6건 + A_user trigger 대기 3건 (bot/core assert refactor / notifier scheme validation / statusline logging refactor). 2026-05-13."
    },
    {
      "version": "v1.14",
      "id": "upbit-ruff-rules-expansion",
      "title": "upbit ruff rule set 확장 (I/B/UP/SIM 4 rule 활성화)",
      "status": "completed",
      "milestones_path": "milestones/v1.14/milestones.md",
      "trigger": "A_user",
      "summary": "v1.13 PROPOSE next_candidates_named_only #3 (upbit-ruff-rules-expansion, A_user trigger 대기) 사용자 명시 발의. pyproject.toml `[tool.ruff.lint]` section 신규 + `select = [\"E\", \"F\", \"UP\", \"B\", \"SIM\", \"I\"]` 6 rule 활성화 (ruff 공식 popular canonical 정확 정합, drift 0) + `[tool.ruff] src = [\"bot\", \"config\", \"tests\", \"scripts\"]` 명시 추가 (D5 spec-drift review P1.1 흡수). 4 디렉토리 (bot/ + config/ + tests/ + scripts/) 471 위반 단일 phase 통합 처리 — safe-fix 364 (--fix) + unsafe-fix 53 (--unsafe-fixes) + manual fix 67 (SIM117 32 multiple-with-statements + E501 21 cascade + SIM102 5 + B904 4 + SIM105 2 + B017 1 + B018 1 + F401 1) + format cascade 10 파일. 단일 commit (d66ffdc, 97 files +830/-764, net +66). 5 관점 review (architecture / spec-drift / 회귀 risk / 보안 / scope contract) 전원 pass-with-comments + decisive issue 0 + 의견 충돌 0 + P1 권고 9건 흡수 (D7 신설 .harness.toml drift 사실 진술 / D1 표기 순서 / D5 src 명시 / phases narrative + risks 보강 / B904 보안 체크리스트 / milestones.md sub_milestones 동기 v3.5). Stage F EXECUTE 결정 흡수 1건 — DESIGN 2-phase 분리 (D2) → 단일 phase 통합 (사용자 명시 결정 2026-05-13, ruff cascade 387→471 actual 로 phase 분리 시 pre-commit 차단, INTENT.out_of_scope #2 허용 범위 + v1.12 / v1.13 패턴 정합 누적 3건). INTENT.success_criteria 7건 모두 VERIFY.criteria_check PASS (pytest 638 passed in 32.75s baseline 정합 + ruff check/format 0 + pre-commit 4 hook PASS + harness-meta smoke 3종 PASS 230/45/1). 6 lessons (L1 ruff cascade multi-pass + L2 Stage F 결정 흡수 누적 3건 + L3 SIM117 py312 parenthesized syntax + L4 외부 spec 사용자 의도 정확 일치 review burden 최소화 + L5 [tool.ruff] src 명시 패턴 + L6 review burden 최소화 누적 evidence 2건). v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 열 번째 실 적용 — § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 10건 + (2) 동결 유지 4회 누적 (v1.7 + v1.12 + v1.13 + v1.14). 후속 candidate 7건 모두 거명만 (§ 6.2 동결 4건 + 적용 대상 부재 자체 흡수 2건 + A_user trigger 대기 1건 = S bandit rule expansion). 2026-05-13."
    },
    {
      "version": "v1.13",
      "id": "upbit-ruff-version-upgrade-evaluation",
      "title": "upbit ruff v0.4.10→v0.15.12 업그레이드 평가 적용",
      "status": "completed",
      "milestones_path": "milestones/v1.13/milestones.md",
      "trigger": "A_user",
      "summary": "v1.12 PROPOSE next_candidates_named_only #4 (A_user trigger 대기) 사용자 명시 발의. ruff version pin v0.4.10 → v0.15.12 (최신 stable, 2026-04-24 release) 11 minor jump + 21 파일 reformat (2025/2026 style guide v0.9+v0.15). dry-run 결과 (lint 0 회귀 + format 21파일) 가 실 적용 결과 100% 정합 — ruff 결정적 특성 검증. v0.5~v0.15 11 minor 전수 breaking changes 식별 (default rule set F + E subset, target='py312' 명시로 default 변경 영향 부재). 단일 phase 1 commit (1c96c4a, 24 files +103/-117). 회귀 0 (pytest 638 passed in 32.77s + harness-meta smoke 3종 230/45/1 + pre-commit 4 hook PASS). Stage F EXECUTE 안 사용자 결정 1건 흡수 — poetry 2.3.4 `lock --no-update` 옵션 부재 → AskUserQuestion → `poetry update ruff` 채택 (D5 의도 정합, OOS #3 허용 범위, v1.12 동일 패턴 정합). 4 관점 (architecture / spec-drift / 회귀 risk / scope contract) 병렬 검토 모두 pass-with-comments + 의견 충돌 0 + 권고 3건 흡수 (5 hook narrative 정정 / RESEARCH F+E subset 정확성 / milestones.md 동기). v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 아홉 번째 실 적용 — § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 9건 + (2) 동결 유지 narrative 정합 (v1.7 + v1.12 + v1.13 = 3회 누적 패턴). 6 lessons (L1~L6) 후속 candidate 모두 거명만 (§ 6.2 동결 5건 + A_user trigger 대기 1건 = upbit-ruff-rules-expansion). 2026-05-12."
    },
    {
      "version": "v1.12",
      "id": "upbit-ruff-ci-gate",
      "title": "upbit ruff CI gate 도입 (2-leg defense)",
      "status": "completed",
      "milestones_path": "milestones/v1.12/milestones.md",
      "trigger": "A_user",
      "summary": "v1.11 PROPOSE next_candidates_named_only #1 (upbit-ruff-ci-gate, A_user trigger 대기) 사용자 명시 발의. v1.7~v1.11 ruff format/lint cleanup 5건 누적 완료 후 회귀 방지 자동화 부재 해소. 2-leg defense 구조 — phase-1 (.pre-commit-config.yaml ruff/ruff-format hook files 패턴 제거, types: [python] default 전체 .py 자동 커버, local gate, b5a2037) + phase-2 (.github/workflows/quality.yml ruff job 안 ruff check scope 확장 bot/ config/ tests/ scripts/ + 신규 ruff format --check step 동일 scope, remote gate, 8862c82). 3 관점 병렬 검토 (architecture / spec-drift / scope contract) 모두 pass-with-comments + decisive_issues 0건 + 의견 충돌 0건 + 필수 흡수 6건 (P1 2 + P2 4). Stage F EXECUTE 도중 사용자 결정 1건 흡수 (.git/hooks/pre-commit 부재 → pre-commit install 1회, INTENT.out_of_scope #3 허용 범위). INTENT.success_criteria 7건 모두 VERIFY.criteria_check PASS, 회귀 0 (pytest 638 passed in 37.36s, v1.10 baseline 정합), harness-meta smoke 3종 PASS (230 / 45 / 1). 5 lessons (L1~L5) 후속 candidate 5건 모두 거명만 (§ 6.2 동결 권고 3건 + A_user trigger 대기 2건). v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 여덟 번째 실 적용 milestone — § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 8건 도달 + (2) 검증 v3.13 결정 narrative 정합 동결 유지. 2026-05-12."
    },
    {
      "version": "v1.11",
      "id": "upbit-ruff-unsafe-fix-f841",
      "title": "upbit ruff unsafe-fix 7건 (F841 unused local var) 검증 후 정정",
      "status": "completed",
      "milestones_path": "milestones/v1.11/milestones.md",
      "trigger": "C_improvement",
      "summary": "v1.10 Option A 보류 F841 7건 수동 fix 완료. C1~C3 test_live_smoke.py (unused init / context manager binding 2건) / C4 test_market_feed_reconnect.py (unused capture) / C5 test_live_executor.py (unused calc) / C6 test_market_feed.py (unused computed + stale comment 2줄 사용자 결정 제거) / C7 test_paper_executor.py (LHS-only 제거, await side-effect 보존). 5파일 -9+3 LOC. 단일 phase 1 commit (433b8c7). SC#1~SC#7 전원 PASS, 회귀 0. ruff check (전체 codebase) 0 errors 달성. scope-contract FAIL→사용자 결정(SC#6 모순 해소) 패턴 적용. 3 lessons (L1~L3) § 6.2 동결 + ruff CI gate A_user trigger 거명. v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 일곱 번째 실 적용. 2026-05-12."
    },
    {
      "version": "v1.10",
      "id": "upbit-ruff-lint-cleanup",
      "title": "upbit codebase ruff check 56 위반 일괄 정정",
      "status": "completed",
      "milestones_path": "milestones/v1.10/milestones.md",
      "trigger": "A_user",
      "summary": "v1.9 PROPOSE next_candidates_named_only 직접 발의. ruff check 56 위반 중 49건 (F401 43 + F541 1 + E741 5) 일괄 정정. Option A (safe-fix만) 채택 — unsafe-fix 7건 (F841 unused local var, ruff 공식 spec에서 unsafe 분류) v1.11 scope defer. 단일 phase 1 commit (8f75d3f), tests/ 21 파일 net +267 LOC. 638 passed / 회귀 0 (E741 rename 시 keyword arg 호출자 누락 회귀 1건 즉시 검출/해소 — REPORT.lessons L2). 5 관점 검토 모두 통과, 사용자 결정 2건 (Option A + tests/ scope), P1/P2/P3 권고 6건 흡수. v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 여섯 번째 실 적용. 5 lessons (L1~L5). v1.11_upbit-ruff-unsafe-fix-f841 후속 등재. 2026-05-13."
    },
    {
      "version": "v1.9",
      "id": "upbit-pytest-failure-fix",
      "title": "upbit pre-existing pytest failure 2건 수정",
      "status": "completed",
      "milestones_path": "milestones/v1.9/milestones.md",
      "trigger": "A_user",
      "summary": "v1.8 pre-existing failure 2건 수정. (1) test_alerts_yaml_contact_point_discord_prefix — bot-health.yaml 5 rule 최상위에 contact_point: discord-infra 추가 (contact-points.yaml name 정합). (2) test_local_compose_merges_with_base — Python 3.14 subprocess._readerthread Windows race 유발 PytestUnhandledThreadExceptionWarning을 conftest.py _BOT_ORIGIN_FILTERS 격리 패턴 적용. 단일 phase 1 commit (feb723d), 638 passed / 0 failed. harness-meta smoke 3종 PASS, 회귀 0. v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 다섯 번째 실 적용. 3 lessons. 2026-05-13."
    },
    {
      "version": "v1.8",
      "id": "upbit-codebase-tests-scripts-ruff-format-cleanup",
      "title": "upbit tests/scripts ruff format 90파일 일괄 정정",
      "status": "completed",
      "milestones_path": "milestones/v1.8/milestones.md",
      "trigger": "C_improvement",
      "summary": "v1.6 VERIFY out_of_scope_findings #1 직접 후속. tests/ 37파일 + scripts/ 53파일 = 90파일 ruff format mismatch 일괄 정정. 단일 phase 1 commit (f54e9ee), +3194 -1735 LOC (net +1459, 풀기 우세 — v1.7 합치기 우세와 반대). ruff format --check 전체 scope (182파일) 0 mismatch. pytest 2 failed (pre-existing) / 636 passed, 회귀 0. harness-meta smoke 3종 PASS. v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 네 번째 실 적용. 3 lessons (L1~L3). 후속 2건 거명만 (pytest failure fix / ruff lint cleanup). 2026-05-12."
    },
    {
      "version": "v1.4",
      "id": "upbit-cross-ref-cleanup",
      "title": "upbit repo 측 stale cross-ref 정리",
      "status": "completed",
      "summary": "upbit repo 내 폐기된 sessions/meta·upbit 경로 / DECISIONS.md 참조 정리 완료. CLAUDE.md(3) + harness-engineer.md(1) + harness-ship/SKILL.md(1) + docs/HARNESS.md(1) = 7위치 제거·갱신. smoke-bundle-trigger non-meta asymmetry 근본 해소 (is_meta guard + gitignore, harness-meta a7e499b). pre-existing CI 실패(test_statusline_sh_smoke) 해소 (upbit f4554f2). 2026-05-11.",
      "trigger": "A_user",
      "milestones_path": "milestones/v1.4/milestones.md"
    },
    {
      "version": "v1.5",
      "id": "statusline-cmd-migration",
      "title": "statusline 풍부한 출력 복원 (v1.6/v1.7 spec 후속)",
      "status": "completed",
      "milestones_path": "milestones/v1.5/milestones.md",
      "summary": "v1.6 statusline.sh dispatcher design + v1.7 contract formalization 도입 후 누락 wiring 복원. Option B 채택 (python summary action + toml one-liner, spawn 1회 663ms 측정 — v2.1_smoke-spawn-batching batched python 패턴 정합). 2 phase: phase-1 (e677038, statusline_stats.py +27 lines: summary() + module docstring + _main elif + test 5건) / phase-2 (b385d0a, .harness.toml +1 line statusline_cmd). 3 관점 병렬 검토 (architecture / spec-drift / scope contract) 모두 pass-with-comments + 결정적 issue 0건 + 의견 충돌 0건. P1 즉시 흡수 3건 (D4 token count 4→5 / INTENT.successor v3.10 정정 / 자기참조 narrative 정정) + P2 Stage D 안 흡수 3건 (Claude Code stdin contract / lightweight 거부 / module docstring summary entry) + P3 후속 흡수 3건 (latency 663ms 측정 / refresh 시점 narrative / composite docstring). INTENT.success_criteria 7건 모두 VERIFY.criteria_check PASS, 회귀 0건. wiring 검증 3 step (T1 minimal fallback / T2 latency 22% 사용 / T3 manual sequence 임시 in_progress → Format A `[harness] v1.5/7-dashboard-provisioning · 4/4 · $3.84` → revert 복원). 사전 정리 chore commit 3건 분리 (087b894 frontmatter / 003c89c harness-python backfill / 4f4e437 ruff format existing test indentation) — scope contract 정합. v3.0+ 9-stage-bundled era 의 외부 projects/<name>, name ≠ meta 첫 실 적용 milestone 사실 진술 (meta § 6.2 deferred 3건 재발의 trigger 조건 (1) 충족 narrative cascade 표지). 7 lessons (L1~L7) 중 4 후속 candidate 모두 § 6.2 동결 거명만 (ROADMAP 미등재). 2026-05-12.",
      "trigger": "B_regression"
    },
    {
      "version": "v1.6",
      "id": "manifest-upgrade-1-1",
      "title": ".harness.toml schema_version 1.0→1.1 bump 신규 필드 활성화",
      "status": "completed",
      "milestones_path": "milestones/v1.6/milestones.md",
      "summary": "upbit `.harness.toml` schema_version 1.0 → 1.1 bump + v1.1 additive 5 항목 활성화 (runtime_version=\"3.12\" + locale=\"ko\" + [agents].primary=\"claude-code\" + [testing].format_cmd) + python_version 즉시 교체 (runtime_version migration, D2). Option B 채택 (state_file / statusline_timeout_ms / [build] 제외 — 의미 부재 risk 회피). 단일 phase 1 commit (da5db9d), 변경 LOC +5/-1. 3 관점 병렬 검토 (architecture / spec-drift / scope contract) 모두 pass-with-comments + 결정적 issue 2건 (D5 --check 의미 + D1~D5 rationale audit trail 거명) P1 즉시 흡수 완료 + 의견 충돌 0. INTENT.success_criteria 7건 모두 PASS (SC#6 vacuously, SC#7 Stage I). harness-meta integration test 10/10 PASS + upbit pre-commit 0 block + 회귀 0. VERIFY out_of_scope_findings 1건 (upbit codebase 18 파일 ruff format mismatch, PROPOSE 거명 source). v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 두 번째 실 적용 milestone — § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 카운트 2건. § 6.2 동결 정책 적용 대상 부재 (manifest schema upgrade 본질 = upbit 자체 기능 개선). 5 lessons (L1~L5) 중 4 후속 candidate 모두 거명만 (ROADMAP 미등재, § 6.2 + 사용자 명시 발의 부재). 2026-05-12.",
      "trigger": "E_priority",
      "renumbered_from": "v1.6_manifest-upgrade-1-1 (flat schema → v3.0+ bundled schema forward-only, OPERATIONS.md § 2.1)"
    },
    {
      "version": "v1.7",
      "id": "upbit-codebase-ruff-format-batch-cleanup",
      "title": "upbit codebase ruff format 18 파일 일괄 정정",
      "status": "completed",
      "milestones_path": "milestones/v1.7/milestones.md",
      "summary": "v1.6 PROPOSE next_candidates_named_only #1 직접 발의 (사용자 명시 발의, A_user 재분류 candidate origin). v1.6 manifest schema 1.0→1.1 bump 후 format_cmd 활성화로 발견된 upbit codebase 18 파일 ruff format mismatch 일괄 정정. 단일 phase 1 commit (d4b5366), `poetry run ruff format bot/ config/` 안 bot/ 18 파일 정정 + config/ 0 vacuous. +366 -450 LOC / net -84 (멀티라인 합치기 우세, line-length 100 기준). 4 관점 병렬 검토 (architecture / spec-drift / 회귀 risk / scope contract) 모두 pass-with-comments + 결정적 issue 0건 + 의견 충돌 0건 + P1 권고 6건 + P2 권고 1건 흡수 (Stage D 안). 5 smoke (upbit ruff format --check + pytest tests/ pre-existing 검증 + harness-meta spec-verification 230 PASS / scope-contract 45 PASS / bundle-trigger PASS) 모두 PASS + 회귀 0 (pre-existing 2 pytest failure `git stash push -- bot/` 검증으로 v1.7 정정 무관 확정). INTENT.success_criteria 7건 중 5 PASS + 2 (SC#5/SC#7) Stage I 완성. v3.0+ 9-stage-bundled era 외부 projects/<name>, name ≠ meta 세 번째 실 적용 milestone — § 6.2 deferred 3건 재발의 trigger 조건 (1) 누적 카운트 3건 도달. 5 lessons (L1~L5) 중 5 후속 candidate 모두 거명만 (§ 6.2 동결 정책 정합 분류: 적용 대상 부재 2건 + 직접 적용 3건). § 6.2 동결 정책 적용 대상 부재 (upbit 자체 codebase 정정 본질). 2026-05-12.",
      "trigger": "C_improvement"
    },
    {
      "id": "v1.3_roadmap-backfill",
      "title": "Bootstrap S6 5종 파일 체계 소급 보완",
      "status": "completed",
      "summary": "projects/upbit/ROADMAP.md 신규 작성 (v1.0~v1.2 이력 기반). pending 2건 trigger 대기 이관. 2026-04-30.",
      "trigger": null
    },
    {
      "id": "v1.2_python-overlay-apply",
      "title": "Python overlay T4 후행 (meta v1.11b)",
      "status": "completed",
      "summary": "harness-python/SKILL.md + python-quality.md upbit 배포. install-project-claude.sh --force exit 0. 6 skill + 4 agent + output-style 회귀 0. 2026-04-28.",
      "trigger": null
    },
    {
      "id": "v1.1_skills-migration",
      "title": "commands→skills 마이그레이션 (meta v1.8b)",
      "status": "completed",
      "summary": ".claude/commands/ 6 파일 삭제 + skills 6 정리. .claude/backup-*/ gitignore 추가. rename 3 + delete 3 + modified 3. 2026-04-25.",
      "trigger": null
    },
    {
      "id": "v1.0_project-claude-install",
      "title": "초기 .claude/ 배포 (meta v1.8 BREAKING 후속)",
      "status": "completed",
      "summary": "install-project-claude.ps1 실행 → upbit .claude/ 17 파일 복구 (commands 6 + agents 4 + skills 6 + output-styles 1). upbit commit 703a21e. 2026-04-25.",
      "trigger": null
    }
  ]
}
```

## 관련 문서

- 프로젝트 아키텍처: [`ARCHITECTURE.md`](ARCHITECTURE.md)
- 프로젝트 thin index (root): [`../../ROADMAP.md`](../../ROADMAP.md)
- 메타 ROADMAP (참조): [`../meta/ROADMAP.md`](../../development/ROADMAP.md)
- 워크플로우 진입점: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md)
- upbit `.harness.toml` 매니페스트: (upbit repo 루트)

## 마이그레이션 노트 (2026-05-08, milestone v1.0_workflow-redesign phase-4)

기존 §2 (pending) + §6 (완료) 표 형식 → 단일 `milestones[]` JSON 배열로 통합.
완료 항목들은 4-tier 워크플로우 시대 (sessions/upbit/v{X}-{slug}/) 산출. 신규 작업은 v3.0+ 9-stage-bundled 흐름 의무 (OPERATIONS.md § 2.1).
DECISIONS / INTERVIEW / STACK 폐기 — 필요 시 ARCHITECTURE.md에 흡수 또는 milestone RESEARCH.md에 기록.
