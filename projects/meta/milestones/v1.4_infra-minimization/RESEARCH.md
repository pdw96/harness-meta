# RESEARCH — v1.4_infra-minimization

PLAN.success_criteria #1~#3 의 raw 감사. 결정은 DESIGN.md 로 미룸 — 본 파일은 findings only.

```json
{
  "id": "v1.4_infra-minimization",
  "external": [
    {
      "source": "projects/meta/ARCHITECTURE.md § 3.3 매트릭스",
      "topic": "Verification 행 (c) 분류",
      "findings": "현재 표기 = '혼재 — VERIFY.md narrative = 정전. smoke shell 인프라 = 임시방편 (후속 v1.4_infra-minimization 평가 대상)'. 본 milestone 을 직접 거명. § 3.6 step 2 의 세 가지 작업 유형 중 '혼재 의 임시방편 부분 narrative 대체' 매핑.",
      "drift": "없음 — 정의 거명 강함, 본 milestone scope 와 1:1"
    },
    {
      "source": "projects/meta/ARCHITECTURE.md § 3.1 명료화 단락",
      "topic": "'인프라 자동화 의존 최소화' 정신",
      "findings": "'SKILL 자동 invoke / hook hard-code / smoke 키워드 강제 / settings.json permission gate 같은 자동화 메커니즘에 작업의 정합성·의사결정·trace 를 맡기지 않는다. 자동화는 보조이며, PLAN/RESEARCH/DESIGN/EXECUTE/VERIFY/REPORT 의 narrative + 사용자 명시 approval gate 가 1차 source.' — 본 milestone 의 직접 motivation. 인용 'smoke 키워드 강제' 가 임시방편 사례로 거명.",
      "drift": "없음"
    },
    {
      "source": "v1.2_post-report-write-message-rewrite REPORT lessons",
      "topic": "메시지 1건 변경 → smoke 6건 연쇄",
      "findings": "자동화 (smoke 키워드 강제) 가 narrative 1차 source 가 되면 narrative 변경 시 smoke 다중 cascade 강제 — drift 위험. 본 milestone 의 narrative 우위 정전화 동기.",
      "drift": "없음 — 사례 보존 가치 확인"
    },
    {
      "source": "외부 컨벤션 (Anthropic Claude Code)",
      "topic": "settings.json hook / pre-commit / shellcheck 등",
      "findings": "settings.json hook + pre-commit framework + shellcheck = 표준 자동화 메커니즘. 외부 컨벤션은 smoke 인프라가 1차 source 인지 narrative 보조인지 명시 부재 — 본 milestone 은 외부 컨벤션 추수 부재, 자체 정의 정전화 (정의 § 3.4 와 일치).",
      "drift": "없음"
    },
    {
      "source": "tests/CLAUDE.md L7 'smoke 매트릭스 (현 29 파일)'",
      "topic": "smoke 카운트 + 카테고리 narrative",
      "findings": "smoke 29건 (실제 tests/*.sh = 30건 중 wrapper 1건 precommit-autofix-or-fail.sh 제외 = smoke 29건 ✓ 정합). 카테고리 3분류 (핵심 정책 검증 5 / 인프라 검증 7+ / 도메인 별 회귀 7+). '현행 hook 현황' 섹션이 active 5 건 명시. 매트릭스 자체가 narrative 1차 source 위치 — 책임 명시된 smoke 들의 'narrative 보조 인프라' 정전화 가능.",
      "drift": "사소 drift 1건 — smoke-projects-scope-discipline.sh 가 매트릭스 카테고리 표 (핵심 정책 검증 등) 에 누락. '현행 hook 현황' 섹션에는 등재."
    }
  ],
  "codebase": {
    "affected_files_explicit": [
      "projects/meta/ARCHITECTURE.md (§ 3.3 매트릭스 'Verification' 행 (c) 갱신 — 본 milestone 핵심 산출)",
      "tests/CLAUDE.md (smoke 매트릭스 narrative 1차 source 위치 명시 강화 + active vs inactive 표기 + drift 1건 정정)",
      "tests/smoke-l5-readme-link-cleanup.sh (legacy '4-tier L5' 시대 잔존, 매트릭스 미거명, narrative 책임 부재)",
      "tests/smoke-v1.1.sh (legacy 'v1.1 sessions/' 시대 잔존, 매트릭스 미거명, narrative 책임 부재)"
    ],
    "affected_files_candidate": [
      "tests/integration/test-install-guards.sh (narrative 거명 부재 — 단순 제거 후보)",
      "tests/integration/test-session-init-branches.sh (narrative 거명 부재)",
      "tests/integration/test-statusline-timeout.sh (narrative 거명 부재)",
      "verify.ps1 (Z/A/B/C/D/E/F/I/J/G 10 stage — D/E hook smoke 가 smoke-posttooluse-hook 와 책임 중복 — 슬림화 후보)",
      "verify.sh (verify.ps1 동등 — 동일 슬림화 후보)"
    ],
    "untouched_files_explicit": [
      "install.ps1 (정전 보조 — Windows symlink + Developer Mode + settings.json idempotent merge + legacy cleanup, narrative 대체 비현실)",
      "verify-lib.ps1 / verify-lib.sh (Test-SymlinkIntegrity 공유 함수 — install/verify 양쪽이 의존, 슬림화 미해당)",
      ".pre-commit-config.yaml (5 active hook = 회귀 차단 책임 명시된 정전 보조, 단 inactive 24건 제거 시 cascade 영향 없음 — config 미연결)",
      "tests/smoke-projects-scope-discipline.sh (active, 회귀 차단 책임 — root ROADMAP thin index 강제)",
      "tests/smoke-spec-verification.sh (active, 7-stage JSON schema 강제)",
      "tests/smoke-scope-contract.sh (active, out_of_scope + DESIGN.approval 게이트 강제)",
      "tests/smoke-cross-ref.sh (active, autofix wrapper 경유 — cascade 정합)",
      "tests/smoke-claude-md-drift.sh (active, CLAUDE.md drift 검출)",
      "tests/precommit-autofix-or-fail.sh (wrapper, --fix 패턴 보조)"
    ],
    "untouched_files_inactive_named": [
      "tests/smoke-bootstrap-render.sh (인프라 검증 카테고리 — render-manifest.sh 책임)",
      "tests/smoke-bootstrap-license-detect.sh (license 3종 — bootstrap/install_cmd/license)",
      "tests/smoke-bootstrap-license-boilerplate.sh (license 3종)",
      "tests/smoke-bootstrap-license-metadata.sh (license 3종)",
      "tests/smoke-bootstrap-agents-md.sh (인프라 검증 — AGENTS.md 콘텐츠 자동 적용)",
      "tests/smoke-backup-cleanup.sh (도메인 회귀 — install-skills cleanup)",
      "tests/smoke-roi-regression.sh (도메인 회귀 — ai-ready-scorer ROI)",
      "tests/smoke-detect-language.sh (도메인 회귀 — detect_language)",
      "tests/smoke-agentic-safety-na.sh (도메인 회귀 — score_agentic_safety N/A)",
      "tests/smoke-broad-bash-fine-grain.sh (핵심 정책 — broad Bash + 필드 rename)",
      "tests/smoke-bash-permission-pattern.sh (핵심 정책 — frontmatter 6축 V1/V5/V7/V8/V10)",
      "tests/smoke-language-overlay.sh (인프라 검증 — overlay)",
      "tests/smoke-legacy-cleanup-overlay.sh (인프라 검증 — install-project-claude legacy)",
      "tests/smoke-license-line-policy.sh (license 정책)",
      "tests/smoke-roadmap-sync.sh (도메인 회귀 — ROADMAP §최근 완료 동기화)",
      "tests/smoke-sync-agents.sh (인프라 검증 — sync-agents)",
      "tests/smoke-verify-sh-parity.sh (인프라 검증 — verify.ps1/sh 동등성)",
      "tests/smoke-scorer-output-newline.sh (도메인 회귀 — CRLF)",
      "tests/smoke-thinking-effort.sh (핵심 정책 — model+effort 6축)",
      "tests/smoke-skills-install.sh (인프라 검증 — install-skills 5 skill)",
      "tests/smoke-python-entry-boilerplate.sh (도메인 회귀 — Python entry-point)",
      "tests/smoke-posttooluse-hook.sh (도메인 회귀 — post-report-write 17 test)"
    ],
    "current_state": {
      "tests_smoke_count": 29,
      "tests_wrapper_count": 1,
      "tests_integration_count": 3,
      "active_hook_count": 5,
      "inactive_smoke_count": 24,
      "inactive_named_in_matrix": 22,
      "inactive_unnamed_in_matrix": 2,
      "verify_ps1_lines": 625,
      "verify_sh_lines": 593,
      "install_ps1_lines": 463,
      "matrix_verification_classification": "혼재",
      "narrative_primary_sources": [
        "README.md (사용자 진입, install/verify 안내)",
        "AGENTS.md (영문 요약, install/verify 거명)",
        "CLAUDE.md (root, 운영 가이드)",
        "claude/CLAUDE.md (글로벌 layer 가이드)",
        "tests/CLAUDE.md (smoke 매트릭스 + active hook 표)",
        "GUARDRAILS.md (H5 install + smoke 차단 게이트 거명)",
        "projects/meta/ARCHITECTURE.md (정의 § 3.3 매트릭스)",
        "projects/meta/CLAUDE.md (subdirectory 가이드)"
      ],
      "narrative_cross_ref_pattern": "install.ps1 / verify.ps1/sh / smoke-* / pre-commit hook 들은 narrative 문서 8 host 에서 'narrative 1차 source 의 보조 cross-ref' 로 거명된다. 매트릭스 § 3.3 에서 (c) = 혼재 표기되어 있으나 cross-ref 패턴 자체는 narrative 우위 — 즉 매트릭스 표기만 정전 갱신 + drift 항목 (legacy 2건) 제거 + tests/CLAUDE.md 명시 강화 가 narrative 우위 명문화의 자연 결과."
    },
    "target_state": {
      "matrix_verification_classification": "정전 (narrative 우위 명시 + 잔존 인프라가 narrative 보조임 강조)",
      "tests_smoke_count_after": "27 (기본 후보 — legacy 2건 단순 제거) 또는 24 (확장 후보 — legacy 2 + integration 3건 추가 제거)",
      "tests_claude_md_matrix_revisions": "active 5 vs inactive 24 명시 + drift 1건 정정 (smoke-projects-scope-discipline 매트릭스 등재)",
      "verify_ps1_sh_target": "현행 보존 (정전 보조 — onboarding + 자가 검증, narrative 대체 비현실) 또는 슬림화 (D/E hook smoke 책임 중복 제거)",
      "install_ps1_target": "보존 (정전 보조 — Windows symlink + settings.json merge 자동화 필수, narrative 대체 비현실)"
    }
  },
  "options": [
    {
      "id": "A",
      "label": "보수적 슬림화 + 매트릭스 정전화",
      "scope": [
        "ARCHITECTURE.md § 3.3 'Verification' (c) 갱신 = 정전",
        "drift 2건 제거 (smoke-l5-readme-link-cleanup.sh, smoke-v1.1.sh) — narrative 책임 부재 + 매트릭스 미거명 → 단순 제거",
        "tests/CLAUDE.md 매트릭스 갱신 (active vs inactive 표기 + drift 1건 정정 = smoke-projects-scope-discipline 카테고리 등재)",
        "install.ps1 / verify.ps1/sh / inactive 22 (매트릭스 거명) / integration 3 / active 5 / wrapper 1 모두 보존"
      ],
      "pros": [
        "단일 책임 명료 — 'narrative 우위' 명문화 + drift 정리 (legacy 잔존 2건) 만 다룸",
        "회귀 risk 최소 — pre-commit-config 미수정 + active 5 보존",
        "토큰·작업량 효율 — 3 phase 내 완결 가능",
        "사용자 메모리 가이드 (단일 source 정합 + 토큰 효율) 와 정합"
      ],
      "cons": [
        "inactive 22 의 'narrative 책임 명시 + 인프라 잔존' 상태가 '신규 milestone 발의 시 비활성 smoke 의 manual run leverage 가능' 정신과 자연 일치하지만 매트릭스 명시 미강화 시 후속 drift 가능성"
      ]
    },
    {
      "id": "B",
      "label": "적극적 슬림화 + 매트릭스 정전화",
      "scope": [
        "Option A 전체",
        "+ tests/integration/ 3건 제거 (narrative 거명 부재, install/verify 양쪽이 책임 중복)",
        "+ verify.ps1 / verify.sh 의 D/E (hook smoke) stage 슬림화 — smoke-posttooluse-hook 가 책임 중복",
        "+ tests/CLAUDE.md '인프라 검증' 카테고리 일부 inactive smoke 명시적 deprecation 표기"
      ],
      "pros": [
        "narrative 우위 명문화 강도 ↑ — 책임 중복 제거 + 명시 deprecation",
        "verify.ps1/sh slim line count (← 800 줄대) — 유지보수 ↓"
      ],
      "cons": [
        "회귀 risk ↑ — verify.ps1/sh slim 시 onboarding 자가 검증 부분 약화 가능",
        "integration tests 3건의 책임 (install guards / session-init / statusline-timeout) 이 install.ps1 / verify.ps1/sh 의 ad-hoc check 와 동등하다고 보기 모호 — RESEARCH 추가 감사 필요",
        "phase 수 ↑ (5+) — 작업량 ↑ + 사용자 검토 부담 ↑"
      ]
    },
    {
      "id": "C",
      "label": "최소 — 매트릭스 분류 갱신 only",
      "scope": [
        "ARCHITECTURE.md § 3.3 'Verification' (c) 갱신만"
      ],
      "pros": [
        "1 phase 즉결 — 토큰 최소"
      ],
      "cons": [
        "사용자 PLAN 분기에서 거부한 옵션과 일치 (success_criteria #1~#5 미충족 — install/verify/smoke 감사 + 분류 + 제거·슬림화 결정 부재)",
        "매트릭스 (c) = 정전 표기만 갱신은 self-evident 한 narrative 만 박는 형태 — drift 정정 부재"
      ]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "topic": "drift smoke 2건 제거 시 manual run leverage 손실",
      "detail": "smoke-l5-readme-link-cleanup.sh / smoke-v1.1.sh 가 manual run 으로 검출 가능한 회귀 case 가 있는지 RESEARCH 단계에서 추가 확인 필요. 매트릭스 미거명 = narrative 책임 부재 = manual run 가치 의문이지만 코드 자체는 회귀 검출 능력 보유 가능."
    },
    {
      "id": "R2",
      "topic": "tests/CLAUDE.md 매트릭스 갱신 cascade",
      "detail": "smoke 매트릭스 표 갱신 시 행 추가/삭제 → smoke-claude-md-drift 의 'smoke count 정합' 검증 cascade. tests/CLAUDE.md L7 카운트 표기 (현 29) 동기 갱신 의무."
    },
    {
      "id": "R3",
      "topic": "active 5 hook 우발적 영향",
      "detail": "smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift 가 본 milestone 산출물 (PLAN/RESEARCH/DESIGN/VERIFY/REPORT + execute/phase-N.md) 자체를 검증. 산출물 작성 중 schema 위반 시 차단."
    },
    {
      "id": "R4",
      "topic": "단일 source 정합 cascade — § 3.5",
      "detail": "ARCHITECTURE.md § 3.3 갱신 시 cross-ref host 5곳 (root CLAUDE.md / AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md) 은 cross-ref 만 보유 (정의 § 3.5 단일 source 정합). 매트릭스 본문 중복 부재 = cascade 영향 zero — 다만 grep 으로 본문 중복 부재 직접 확인 의무."
    },
    {
      "id": "R5",
      "topic": "Option B 의 verify.ps1/sh 슬림화 회귀",
      "detail": "verify.ps1 D/E stage 가 hook + statusline 동작을 fixture 기반 dynamic 검증. smoke-posttooluse-hook 는 post-report-write.sh 17 test 만 다룸 — 책임 비대칭. 책임 중복이 아닌 보완 관계 가능 — DESIGN 에서 정밀 비교 필요."
    },
    {
      "id": "R6",
      "topic": "Option B integration 제거 회귀",
      "detail": "test-install-guards (install.ps1 conflict 정책 검증) / test-session-init-branches (hook 분기) / test-statusline-timeout (statusline 타임아웃) — 각 install/verify 의 ad-hoc check 와 책임 중복인지 RESEARCH 추가 감사 필요."
    },
    {
      "id": "R7",
      "topic": "narrative 1차 source 8 host 정합",
      "detail": "README.md / AGENTS.md / CLAUDE.md (root) / claude/CLAUDE.md / tests/CLAUDE.md / GUARDRAILS.md / ARCHITECTURE.md / projects/meta/CLAUDE.md 8 host 의 install/verify/smoke 거명 패턴 cascade 점검 결과 모두 'narrative 1차 source + 인프라 보조' 정상 cross-ref. drift 부재. 본 milestone EXECUTE 영향 zero."
    }
  ]
}
```

## 핵심 발견 요약

1. **정의 거명 강함**: ARCHITECTURE.md § 3.3 'Verification' (c) 가 '후속 v1.4_infra-minimization 평가 대상' 으로 본 milestone 을 직접 거명. 1:1 매핑.
2. **narrative 우위는 cross-ref 패턴에 이미 내재**: 8 host 의 install/verify/smoke 거명 모두 'narrative 1차 source + 인프라 보조' 정상 cross-ref. 즉 매트릭스 (c) 표기만 '혼재' 로 lag 되어 있음 — 표기 갱신이 narrative 우위 명문화.
3. **drift 항목 2건**: smoke-l5-readme-link-cleanup.sh / smoke-v1.1.sh — 매트릭스 미거명 + active 미연결 = narrative 책임 부재 + 인프라 잔존. 정전화 정신 직접 적용 → 단순 제거.
4. **tests/CLAUDE.md 매트릭스 drift 1건**: smoke-projects-scope-discipline 가 카테고리 표 미등재 (현행 hook 표만 등재). 갱신 의무.
5. **Option A 가 단일 책임 + 회귀 최소**: drift 2건 제거 + 매트릭스 갱신 + tests/CLAUDE.md 강화 = 3 phase 내 완결.
6. **Option B 의 추가 작업 (integration / verify slim) 은 책임 중복 여부 정밀 감사 필요** — DESIGN 5 관점 검토에서 결론.

## 비고

- 본 RESEARCH 의 결정은 DESIGN.decisions 로 미룸. options A/B/C 의 raw 분석.
- risks_identified R5/R6 (Option B 책임 중복) 는 Option B 채택 시만 정밀 감사 의무 — Option A 채택 시 우회.

## 관련 문서

- PLAN: [`PLAN.md`](PLAN.md)
- 정의 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3
- tests/ 모듈 가이드: [`../../../../tests/CLAUDE.md`](../../../../tests/CLAUDE.md)
- 직전 완료 milestone: [`../v1.4_cross-ref-propagation/`](../v1.4_cross-ref-propagation/)
