# DESIGN — v5.6 environment-auditor-runtime-check-automation

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "Option O1 채택 — Stage B 확장 (10 stage 유지)",
      "rationale": "사용자 명시 결정 (D1 라운드). 현 stage_count 10 유지 + frontmatter description 최소 변경. B 의미 본질 = 'install 검증' 자연 확장 ('install + activation + runtime AUTO 부분'). cascade 범위 4 파일 안 narrative 변경 최소화.",
      "alternatives_rejected": [
        "O2 신규 Stage K (11 stage) — 단어-책임 1:1 매핑 더 명확하나 frontmatter+본문+Makefile+bootstrap/agents/CLAUDE.md cascade 범위 증가 (3+1 위치 narrative '10 stage' → '11 stage')",
        "O3 BP3 only (G 원형 유지) — 자동화 가능 G AUTO 부분 미이전 = INTENT goal '자동화 가능 항목 이전' 미충족"
      ]
    },
    {
      "id": "D2",
      "decision": "stage_count = 10 유지 (D1 자연 따름)",
      "rationale": "O1 채택 직접 결과. environment-auditor.md frontmatter description '10 stage 매트릭스' narrative 보존. bootstrap/agents/CLAUDE.md L23+L108+L112 + Makefile L29 narrative 동기 의무 부재.",
      "alternatives_rejected": ["11 stage (O2 채택 시 필요)"]
    },
    {
      "id": "D3",
      "decision": "Plugin activation 검증 = BP3 신규 sub-step (B 안 통합)",
      "rationale": "D1 O1 자연 따름. `claude plugin list --json` 출력 안 본 plugin entry 의 `enabled: true` 검증. spec source = context7 1차 검증 결과 (Plugin reference docs).",
      "alternatives_rejected": [
        "별 stage (K) 안 — O2 선택 시",
        "G 안 manual — INTENT goal 위반 (자동화 가능 항목 manual 잔존)"
      ]
    },
    {
      "id": "D4",
      "decision": "G AUTO 통합 검증 = BP4 신규 sub-step (단일 step, 5 path/grep enumerate)",
      "rationale": "사용자 의문 round 3 결과 — 10 sub-items 세분화 회피. 단일 sub-step 안 G1~G5 AUTO 부분 (file 존재 + grep) 통합 검증 + WARN partial. narrative 압축 + LOC 비대화 회피.",
      "alternatives_rejected": [
        "BP4~BP8 각 G 항목 1:1 매핑 (5 sub-step) — 세분화, 사용자 의견 위반",
        "BP3 안 통합 — Plugin activation 책임과 다름, 단어-책임 매핑 약화"
      ]
    },
    {
      "id": "D5",
      "decision": "G 5 항목 narrative 보존 + 'AUTO 부분 + MANUAL 부분' 책임 표기 추가",
      "rationale": "사용자 의문 round 1+2+3 결과. G 5 항목 narrative 유지 (5 항목 그대로) + 각 항목에 책임 표기 추가 ('AUTO 부분: ... / MANUAL 부분: ...'). 자동 stage 안 검증 (BP3+BP4) 은 별 책임으로 분리. G 본질 = '실 세션 안 효과 인식 (MANUAL)' 으로 정의 정확화.",
      "alternatives_rejected": [
        "G 5 항목 narrative 완전 분리 (10 sub-items) — 세분화 회피",
        "G 5 항목 그대로 (책임 표기 부재) — INTENT goal 위반"
      ]
    },
    {
      "id": "D6",
      "decision": "Bash 화이트리스트 추가 = `claude` (root CLI) + `claude plugin list` + `claude plugin list --json`",
      "rationale": "read-only side-effect-free 검증 (output 만 표시, write 일체 부재). D7 보안 정합. `claude plugin details` 채택 회피 (R3 mitigation, docs 미등재).",
      "alternatives_rejected": [
        "claude plugin details 포함 — docs 미등재 (R3), Plugin activation 검증은 list --json 충족",
        "claude root CLI 미명시 + 개별 subcommand 만 — 사전 검증 (`Get-Command claude`) 누락 위험"
      ]
    },
    {
      "id": "D7",
      "decision": "phases 분할 = 1-phase",
      "rationale": "scope 4 파일 (environment-auditor.md + bootstrap/agents/CLAUDE.md + Makefile + CHANGELOG.md) — atomic 변경 자연. 1-phase 정합 (ARCHITECTURE § 6.1 1-phase 정합 paragraph 정합, v3.18 narrative 흡수).",
      "alternatives_rejected": [
        "2-phase (phase-1 environment-auditor.md 본체 + phase-2 cascade) — 4 파일 atomic 자연 분할 부재"
      ]
    },
    {
      "id": "D8",
      "decision": "`claude` CLI 부재 환경 fallback = WARN + manual fallback narrative",
      "rationale": "R1/R12 mitigation. `Get-Command claude` (pwsh) / `command -v claude` (bash) 사전 check → 부재 시 BP3+BP4 SKIP + WARN 메시지 ('claude CLI 부재, G 5 항목 manual 검증 필요'). audit failure 회피.",
      "alternatives_rejected": [
        "FAIL 처리 — 사용자 환경 안 CLI 미설치 시 audit FAIL = false-positive risk",
        "SKIP silent — 사용자 인지 부재 risk"
      ]
    },
    {
      "id": "D9",
      "decision": "JSON parse = python3 / jq (Bash 화이트리스트 안 parse only 추가 활용), regex grep fallback",
      "rationale": "R2 mitigation. `claude plugin list --json` 출력 안 `enabled` 필드 parse — python3 -c (preferred) / jq -r (fallback) / regex grep (last resort). JSON schema 변동 시 regex 깨짐 회피.",
      "alternatives_rejected": [
        "regex grep only — JSON schema 변동 시 깨짐",
        "non-JSON `claude plugin list` parse — output format 정형 부재 risk"
      ]
    },
    {
      "id": "D10",
      "decision": "JSON key 이름 추정 = `enabled` (boolean), Stage F EXECUTE 시 실 spike 검증 의무",
      "rationale": "R7 mitigation. context7 spec 안 명시 부재 (`enabled status` narrative만, 정확 키 이름 명시 zero). Stage F 안 실 `claude plugin list --json` 호출 + JSON output spike → 키 이름 확정. 추정 = `enabled` (context7 narrative '`enabled status`' 정합 추론). spike 결과 다를 시 BP3 patch."
    },
    {
      "id": "D11",
      "decision": "disabled 상태 분기 narrative = audit 정상 (사용자 의도 disable 정합 메시지) + `/reload-plugins` cross-ref 흡수",
      "rationale": "R9 mitigation. `claude plugin disable harness-meta` 후 (install 유지하면서 비활성화) → B0 cache 존재 PASS + BP3 enabled false = WARN ('사용자 의도 disable 정합? `claude plugin enable harness-meta` 으로 재활성 후 `/reload-plugins` slash command 으로 세션 적용 권고'). spec-drift 4 관점 검토 권고 #2 흡수 — context7 안 `claude plugin enable/disable` 후 변경 적용에 `/reload-plugins` 사용 narrative 존재. audit FAIL 회피.",
      "scope_monitor": "architecture 4 관점 검토 권고 #1 흡수 — D11 가 audit 본질 (binary 검증) 안 '사용자 의도 분기' 첫 도입. 향후 분기 narrative 패턴 누적 시 책임 모호화 risk monitor 권고 (PROPOSE 안 narrative 흡수)."
    }
  ],
  "approach": "environment-auditor.md 안 Stage B 5 sub-step (B0/BP1/BP2/BP3/BP4) 으로 확장 + Stage G 5 항목 narrative 책임 표기 추가 + frontmatter description 본문 매트릭스 narrative 동기. cascade narrative 동기 (bootstrap/agents/CLAUDE.md L23+L108+L112 + Makefile L29) 'N stage' 변경 부재 (10 stage 유지). CHANGELOG [v5.6] entry 신규. 1-phase atomic commit.",
  "phases": [
    {
      "n": 1,
      "title": "environment-auditor Stage B 확장 (BP3+BP4) + G 책임 표기 + cascade narrative + CHANGELOG",
      "scope": "agents/environment-auditor.md 본문 매트릭스 § B 확장 (BP3 activation + BP4 G AUTO 통합) + § G 5 항목 책임 표기 + frontmatter description 갱신 (narrative 정합, '10 stage 매트릭스' 보존) + § Bash 화이트리스트 § 'claude plugin list' 추가 narrative. bootstrap/agents/CLAUDE.md L23+L108+L112 narrative 정합 검증 (10 stage 유지 → 변경 zero, drift 검증 grep 만). Makefile L29 narrative 정합 검증 (변경 zero, drift 검증 grep 만). CHANGELOG.md [v5.6] entry 신규 (Unreleased 안 또는 [v5.6] header 신규).",
      "affected_files": [
        "agents/environment-auditor.md (본문 매트릭스 + frontmatter + Bash 화이트리스트 § 갱신)",
        "CHANGELOG.md ([v5.6] entry 신규)",
        "projects/meta/milestones/v5.6/execute/phase-1.md (Stage F 산출물)",
        "(검증 only, 변경 zero) bootstrap/agents/CLAUDE.md L23+L108+L112",
        "(검증 only, 변경 zero) Makefile L29"
      ],
      "rationale": "atomic 4 파일 변경 (실 변경 2 + 검증 only 2 + execute/phase-1.md). 1-phase = scope contract 단일 책임. cascade narrative '10 stage' 보존 = D1 (O1) 자연 결과.",
      "risks": [
        "(D8) claude CLI 부재 환경 fallback narrative 누락 risk",
        "(D10) JSON key 이름 spike 검증 결과 추정 다를 시 BP3 patch 필요 — 보안 권고 #3 흡수: spike 시 정확 키 발견 후 string literal hardcode (동적 구성 회피)",
        "(R8) cross-platform encoding cp949 함정 (Windows pwsh stdout UTF-8 확보)",
        "(보안 권고 #4) stderr ANSI escape 무해화 — `2>&1` capture 후 ANSI escape sequence 무해화 narrative 필요 (낮은 risk, optional)"
      ],
      "commit_msg_draft": "feat(meta): v5.6 phase-1 — environment-auditor BP3+BP4 activation+runtime auto + G 책임 표기"
    }
  ],
  "risk_mitigation": [
    {"risk": "R1 (CLI 부재 fallback)", "mitigation": "D8 — Get-Command/command -v 사전 check + WARN + manual fallback narrative"},
    {"risk": "R2 (JSON format 변경)", "mitigation": "D9 — python3/jq parse 우선, regex fallback"},
    {"risk": "R3 (`plugin details` docs 미등재)", "mitigation": "D6 — 화이트리스트 추가 회피, `plugin list --json` 만 채택"},
    {"risk": "R4 (Bash 화이트리스트 확장 보안)", "mitigation": "D6 — read-only side-effect-free 검증 + 4 관점 보안 검토"},
    {"risk": "R5 (DESIGN 결정 cascade 범위)", "mitigation": "D1 (O1 채택) — cascade narrative 변경 zero (10 stage 보존)"},
    {"risk": "R6 (entry 부재 분기)", "mitigation": "BP3 안 entry 부재 시 WARN 메시지"},
    {"risk": "R7 (JSON schema 변동)", "mitigation": "D10 — Stage F spike 검증 의무"},
    {"risk": "R8 (cross-platform encoding)", "mitigation": "Stage F EXECUTE 시 pwsh + bash 둘 다 spike + UTF-8 명시"},
    {"risk": "R9 (disabled 상태 분기)", "mitigation": "D11 — WARN 메시지 narrative"},
    {"risk": "R10 (granularity)", "mitigation": "D4 — BP4 single sub-step 안 partial WARN 권고"},
    {"risk": "R11 (G narrative LOC)", "mitigation": "D5 — 책임 표기 추가만, 5 항목 narrative 보존, 추정 +10~15 LOC"},
    {"risk": "R12 (PATH 부재 sub-risk)", "mitigation": "D8 — R1 mitigation 통합"}
  ]
}
```

## approach narrative

Stage B 5 sub-step 확장 (B0/BP1/BP2 기존 + BP3 activation + BP4 G AUTO 통합) + Stage G 5 항목 책임 표기. cascade 4 host (environment-auditor.md 본체 + bootstrap/agents/CLAUDE.md 검증 only + Makefile 검증 only + CHANGELOG.md release note). 1-phase atomic.

D1 (O1 채택) 가 cascade narrative '10 stage' 보존 → 회귀 risk 최소화 직접 결과. environment-auditor.md 본문 매트릭스 narrative 갱신만 핵심 변경. Bash 화이트리스트 § 'claude plugin list' 추가는 D6 보안 정합 결정.

5 관점 검토 (다음 단계) — scope 4 파일 / 작음. 3 관점 (architecture / spec-drift / scope contract) 최소 + 보안 (Bash 화이트리스트 확장) 추가 → 4 관점 권고.

## 5 관점 검토 결과 (Stage D 안 다각적 병렬 검토, 4 관점 채택)

scope 4 파일 → 3 관점 (architecture / spec-drift / scope contract) 최소 + 보안 (Bash 화이트리스트 확장) 추가 = 4 관점 병렬 호출.

### 1. Architecture (Plan subagent) — pass_with_comments

- Stage B 확장 (D1) 정합: B 단어 의미 ('Plugin install 검증') 안 'activation' 자연 확장. BP4 (G AUTO file 존재) 도 install 산출물 영역 정합.
- BP3/BP4 granularity (D3+D4) 단일 책임 1:1 매핑 부합. D4 single sub-step 5 path enumerate 적정.
- Cascade 4 host narrative drift risk 최소 (10 stage 보존, narrative 변경 zero).
- 1-phase (D7) scope contract 자연 정합.
- Bash 화이트리스트 (D6) read-only 본질 위반 zero.
- **권고**: D11 disabled 상태 WARN 분기 narrative — audit 본질 (binary 검증) 안 첫 '사용자 의도 분기' 도입 → 향후 분기 narrative 패턴 누적 시 책임 모호화 risk monitor 권고.

### 2. Spec-drift (general-purpose + context7) — pass_with_comments

- D10 `enabled` boolean 추정 UNVERIFIED — context7 1차 source 안 정확 JSON key 명시 부재 (narrative `enabled status` / `enable status` 표현). Stage F spike 검증 의무 (D10) 적정 mitigation.
- D6 `claude plugin details` 회피 정합 — context7 query 결과 `details` 미등재 확인.
- **신규 발견**: `/reload-plugins` slash command 존재 (context7 안 `claude plugin enable/disable` 후 변경 적용에 사용 narrative). R9 disabled 상태 분기 narrative 안 cross-ref 권고 (선택 보강).
- R7 schema 변동 D10 spike 적정 mitigation.

### 3. Scope contract (Explore subagent) — PASS

- INTENT.success_criteria 7건 → 6건 PASS + 1건 PENDING_F (sc_5 회귀 0, Stage F 실행 시 검증).
- INTENT.out_of_scope 4건 → DESIGN.affected_files 4 파일 모두 정합 (cascade narrative 검증 only 2건 = OOS-3 정합).
- scope creep zero (DESIGN.phases scope narrative 안 INTENT 외 항목 거명 부재).
- **권고**: sc_5/sc_6 Stage F 실 검증 의무 — `claude plugin list --json` spike (D10) + Bash 화이트리스트 § 갱신 후 read-only side-effect-free 재검증.

### 4. 보안 (general-purpose + security-review) — PASS

- `claude plugin list [--json]` read-only side-effect-free PASS.
- Bash 화이트리스트 D6 추가 D7 정합 PASS.
- JSON parse command injection (D9) PASS — trusted source.
- fallback (D8) silent SKIP 회피 → 사용자 인지 보안 정합 PASS.
- R3 `details` 회피 supply-chain 안정성 우수 PASS.
- read-only 본질 유지 (BP3+BP4) PASS — write 명령 부재.
- **권고**: Stage F spike 시 JSON key hardcode (D10 `enabled` 등 동적 구성 회피) + stderr capture 시 ANSI escape 무해화 (낮은 risk).

### 종합 결과

- 4 관점 모두 PASS 또는 PASS_WITH_COMMENTS
- 의견 충돌 0건
- 권고 흡수 항목 4건:
  1. (architecture) D11 disabled 분기 narrative monitor — 향후 패턴 누적 시 책임 모호화 risk monitor (PROPOSE 안 narrative 흡수)
  2. (spec-drift) `/reload-plugins` cross-ref — R9 disabled 분기 narrative 안 cross-ref 권고 → D11 mitigation 추가
  3. (보안) D10 spike JSON key hardcode — Stage F EXECUTE 시 동적 구성 회피, 정확 키 발견 시 직접 string literal
  4. (보안) stderr ANSI escape 무해화 — Stage F EXECUTE 시 `2>&1` capture + escape 처리 narrative (낮은 risk)

권고 흡수 후 DESIGN 안정화 — Stage E APPROVE 게이트 진입.
