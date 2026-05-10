# RESEARCH — v3.1_workflow-policy-fine-tuning

```json
{
  "external": [
    {
      "source": "markdownlint MD032 (blanks-around-lists)",
      "topic": "list 앞뒤 빈 줄 의무",
      "findings": "MD032 default true. list (ordered/unordered) 앞 또는 뒤 line 이 빈 줄이 아니면 fail. v3.0 phase-3 commit 시 APPROVE.md/DESIGN.md '필수 게이트:' 강조 직후 list 시작 → 빈 줄 부재로 fail. 회피: list 앞뒤 빈 줄 의무.",
      "drift": null
    },
    {
      "source": "markdownlint MD049 (emphasis-style)",
      "topic": "emphasis underscore vs asterisk 일관성",
      "findings": "MD049 default 'consistent' (mixed style 차단). v3.0 INTENT.md/DESIGN.md 안 `v{X.Y}_{slug}` underscore 가 emphasis 오인 (`{X.Y}` ~ `{slug}` 사이 underscore pair → italic 시도) → fail. 회피: identifier 백틱 escape (`v{X.Y}_{slug}`).",
      "drift": null
    },
    {
      "source": "harness-meta/.markdownlint.json",
      "topic": "현 markdownlint 설정",
      "findings": "default: true + MD013 (line-length) / MD033 (raw HTML) / MD041 (first-line-h1) / MD040 (fenced-code-language) disabled, MD024 siblings_only, MD026 punctuation customized, MD029 disabled, MD036 disabled. MD032/MD049 default 활성 — 본 milestone 의 함정 narrative 적용 대상.",
      "drift": null
    },
    {
      "source": "semver.org",
      "topic": "minor bump 정합 (v3.0 → v3.1)",
      "findings": "v3.0 (breaking change, major bump) 의 후속 fine-tuning 은 backward-compatible feature 추가/narrative 강화 → minor bump (v3.1). bundling 정책 단조 적용, 디렉토리/schema 변경 부재. semver 정합 (단조 증가, breaking 부재).",
      "drift": null
    },
    {
      "source": "v3.0_milestones-restructure REPORT.md L10",
      "topic": "v3.0 직접 lessons_learned",
      "findings": "L10 actionable: 'milestone 산출물 작성 시 (a) underscore 포함 단어 백틱 escape, (b) 강조 (**...**) 직후 list 시 빈 줄 의무. tests/CLAUDE.md § 흔한 함정 7번째 항목 후보 — 별 milestone 검토.' → 본 milestone 의 phase-1 직접 흡수.",
      "drift": null
    },
    {
      "source": "v3.0_milestones-restructure PROPOSE.md next_candidates",
      "topic": "v3.0 직접 후속 3건",
      "findings": "(1) v3.1_markdownlint-trap-narrative (B_regression) / (2) v3.1_milestones-md-spec-formalization (C_improvement, design_decision) / (3) v3.1_smoke-bundle-trigger-validation (B_regression, policy_enforcement). propose_summary: '같은 모듈 (tests/) + 같은 주제 (정책 fine-tuning) — bundling 가능. 또는 단독 milestone N건 분리. 사용자 결정.' → 본 milestone 통합 결정 (bundling 첫 적용 사례).",
      "drift": null
    }
  ],
  "codebase": {
    "affected_files": [
      "tests/CLAUDE.md (§ '흔한 함정' 표 7번째 row 추가 — phase-1)",
      "projects/meta/ARCHITECTURE.md (§ 6.1 또는 milestones.md spec 섹션 — historical era 적용 결정 narrative — phase-2)",
      "projects/meta/milestones/v3.0/milestones.md (forward-only 결정 narrative cross-ref — phase-2)",
      "tests/smoke-projects-scope-discipline.sh (확장 — v3.0+ entry version 단위 1 entry 검증) 또는 tests/smoke-bundle-trigger.sh (신규) — phase-3",
      "tests/CLAUDE.md (§ smoke 매트릭스 - 27 → 28 카운트, 신규 smoke 등재 시 — phase-3)",
      ".pre-commit-config.yaml (신규 smoke pre-commit 등록 검토 — phase-3)",
      "projects/meta/milestones/v3.1/INTENT.md (작성 완료, audit 시 참조 — Stage B)",
      "projects/meta/milestones/v3.1/RESEARCH.md (본 파일 — Stage C)",
      "projects/meta/milestones/v3.1/DESIGN.md (Stage D)",
      "projects/meta/milestones/v3.1/APPROVE.md (Stage E)",
      "projects/meta/milestones/v3.1/milestones.md (sub-milestone 3건 listing — Stage F phase 별 갱신)",
      "projects/meta/milestones/v3.1/execute/phase-{1,2,3}.md (Stage F per-phase)",
      "projects/meta/milestones/v3.1/VERIFY.md (Stage G)",
      "projects/meta/milestones/v3.1/REPORT.md (Stage H)",
      "projects/meta/milestones/v3.1/PROPOSE.md (Stage I)",
      "projects/meta/ROADMAP.md (v3.1 entry status: pending → in_progress → completed, milestones_path 필드)"
    ],
    "untouched_files": [
      "tests/_era_detect.py (era 분기 단일 source, 변경 부재)",
      "tests/smoke-spec-verification.sh (era 분기 검증 보존, 변경 부재)",
      "tests/smoke-scope-contract.sh (era 분기 보존, 변경 부재)",
      "claude/commands/harness-meta.md (9-stage workflow 보존, 변경 부재)",
      "CLAUDE.md (root) (모듈별 가이드 보존, 변경 부재)",
      "projects/meta/CLAUDE.md (subdirectory 가이드 보존, 변경 부재)",
      "claude/hooks/post-report-write.sh (milestones.md NOOP 보존, 변경 부재)",
      "projects/meta/milestones/v1.84~v1.88/ (4-tier era historical 보존)",
      "projects/meta/milestones/v1.0_workflow-redesign ~ v1.4_*/ (7-stage era historical 보존)",
      "projects/meta/milestones/v2.0_workflow-word-fidelity ~ v2.1_*/ (9-stage era historical 보존)",
      "projects/meta/milestones/v3.0/ (9-stage-bundled era 도그푸드 보존, 본 milestone 후속이지만 v3.0 디렉토리 자체 변경 부재 — milestones.md cross-ref 1건만 phase-2 시)"
    ],
    "current_state": "v3.0_milestones-restructure (2026-05-10 completed) 직후. ROADMAP.md 안 v3.1 entry status: in_progress (Stage A 갱신). v3.0 신 schema (version + id 분리) 확립, milestones.md spec picture-frame 도입 (v3.0 only), bundling 정책 narrative ARCHITECTURE.md § 6.1 명문화 (자동 강제 부재). tests/CLAUDE.md § '흔한 함정' 6 항목 (cp949 6번째). smoke 27 + helper 1 (`tests/_era_detect.py`). pre-commit 12 hook (built-in 5 + shellcheck + markdownlint + 5 active local: smoke-projects-scope-discipline + smoke-spec-verification + smoke-scope-contract + smoke-cross-ref + smoke-claude-md-drift). v3.0 lessons L10 markdownlint 함정 narrative-only.",
    "target_state": "tests/CLAUDE.md § '흔한 함정' 7 항목 (markdownlint trap 7번째). milestones.md spec historical era 적용 결정 명문화 (옵션 a/b/c 결정 + rationale). bundling trigger 자동 검증 smoke (신규 또는 기존 확장). v3.1 milestones/ 디렉토리 신 구조 (milestones/v3.1/ + milestones.md + sub-milestone 3건). pre-commit 12 → (smoke 신규 등록 시) 13 hook 또는 12 hook (확장 시). v3.0+ 9-stage-bundled era 첫 후속 사례 도그푸드."
  },
  "options": [
    {
      "topic": "phase-2 historical era 적용 결정",
      "alternatives": [
        {
          "option": "(a) forward-only 강제 — v3.0+ 만 milestones.md, v1.x~v2.1 부재 영구",
          "pros": [
            "v3.0 forward-only 정책 (ARCHITECTURE.md § 6.1) 직접 일관 — 정책 정합",
            "historical 디렉토리 unchanged (v3.0 정신 보존)",
            "구현 부담 0 (narrative 결정만)",
            "v2.x 가 9-stage flat 구조 (sub-milestone 부재) 이므로 milestones.md 필요성 본질 부재"
          ],
          "cons": [
            "v2.1 안 다중 milestone (smoke-spawn-batching + pending-milestone-renumber-policy + smoke-posttooluse-9stage-tests) 의 그룹 관계 표현 어려움 (단점)",
            "future query 시 'v2.1 안 어떤 milestone?' 답변에 ROADMAP.md grep 의존 (milestones.md 부재)"
          ]
        },
        {
          "option": "(b) v2.x retroactive 적용 — v2.1/ 디렉토리에 milestones.md 추가",
          "pros": [
            "v2.1 다중 milestone 그룹 표현 명료화",
            "milestones.md spec 의 일반화 (= 모든 v 단위)"
          ],
          "cons": [
            "v3.0 forward-only 정책 위반 — historical 변경",
            "v2.1 디렉토리 명 v{X.Y}_{slug} flat 구조 → milestones.md 의 sub_milestones[] phase 매핑 무의미 (각 milestone 이 자체 디렉토리 + 자체 INTENT~PROPOSE 보유)",
            "구현 부담 큼 (v2.0_workflow-word-fidelity, v2.1_smoke-spawn-batching 등 status:completed milestone 디렉토리 변경)",
            "git mv 필요 시 history 보존 위험",
            "미래 동등 정책 v2.x 의 9-stage era 보존 정신 훼손"
          ]
        },
        {
          "option": "(c) 신규 milestone 만 적용 — v3.0+ 신규 milestone 기본 도입, 기존 v3.0 도그푸드 보존",
          "pros": [
            "(a) 와 사실상 동치 (v3.0+ 9-stage-bundled era 의무 = milestones.md 의무)",
            "ARCHITECTURE.md § 6.1 표 의무 sign 과 일관"
          ],
          "cons": [
            "(a) 와 구분 모호 — '신규' 정의 = '향후 작성' = 'forward-only' 와 동치"
          ]
        }
      ]
    },
    {
      "topic": "phase-3 bundling trigger smoke — 신규 vs 기존 확장",
      "alternatives": [
        {
          "option": "(A) tests/smoke-projects-scope-discipline.sh 확장 — v3.0+ entry version 필드 단위 1 entry 검증 추가",
          "pros": [
            "기존 smoke 의 ROADMAP `milestones[]` 검증 인프라 재사용 (extract_json_block 등)",
            "구현 부담 작음 (한 함수 추가)",
            "smoke 카운트 27 보존 (인프라 변경 부재)",
            "pre-commit hook 등록 부담 부재 (기존 active hook 확장)"
          ],
          "cons": [
            "smoke 책임 확대 — 'projects scope discipline' (root thin index 강제) + bundling validation 두 책임 혼재 (단일 책임 원칙 위배)",
            "smoke 명 의미 부정합 (bundling validation 이 'projects-scope-discipline' 안에 위치)"
          ]
        },
        {
          "option": "(B) tests/smoke-bundle-trigger.sh 신규 — bundling validation 단일 책임",
          "pros": [
            "단일 책임 원칙 일관 (smoke = 단일 검증 책임 원칙, smoke 매트릭스 narrative 정신)",
            "smoke 명 의미 정합 ('bundle-trigger' = bundling 정책 강제)",
            "pre-commit hook 등록 시 별 entry (시각적 명료)"
          ],
          "cons": [
            "smoke 카운트 27 → 28 (인프라 추가)",
            "기존 smoke-projects-scope-discipline 와 중복 코드 (extract_json_block 등)",
            "pre-commit hook 등록 시 13 hook (12 → 13)"
          ]
        }
      ]
    },
    {
      "topic": "phase-3 신규 smoke 의 pre-commit 등록 여부",
      "alternatives": [
        {
          "option": "등록 (12 → 13 hook 또는 12 hook + 확장)",
          "pros": [
            "ROADMAP.md commit 시 자동 강제 (narrative-only 정책의 자동 강제 누적)",
            "v3.0 lessons L10 actionable 의 정신 (자동 차단 우선)"
          ],
          "cons": [
            "pre-commit 시간 증가 (smoke 1건 추가 ~0.6s)"
          ]
        },
        {
          "option": "미등록 (manual run leverage, narrative 1차)",
          "pros": [
            "tests/CLAUDE.md narrative 1차 source 정책 일관",
            "pre-commit 시간 보존"
          ],
          "cons": [
            "ROADMAP.md commit 시 강제 부재",
            "narrative-only 와 동치 (자동 강제 없음)"
          ]
        }
      ]
    },
    {
      "topic": "milestone scope — sub-milestone 3 vs 4 (markdownlint 자동 강제 추가 옵션)",
      "alternatives": [
        {
          "option": "3 sub-milestone (현 INTENT 안)",
          "pros": [
            "PROPOSE 3 후보 1:1 매핑",
            "scope 단순"
          ],
          "cons": [
            "markdownlint 함정 narrative 만 — 자동 강제 부재 (사용자 commit 시 markdownlint hook 이 자동 차단하지만 narrative 안내 부재)"
          ]
        },
        {
          "option": "4 sub-milestone (markdownlint MD032/MD049 위반 사전 차단 smoke 추가)",
          "pros": [
            "narrative-only → 자동 강제 누적 (5요소 매트릭스 'Constraint' 정전)",
            "사전 차단 (commit 전 사용자 안내)"
          ],
          "cons": [
            "scope 확대 — 본 milestone bundling 첫 적용 사례 정신 훼손",
            "markdownlint 자체가 이미 차단 (pre-commit hook 12 안 markdownlint) — 중복 검증",
            "out_of_scope (INTENT 명시: 'markdownlint MD032/MD049 외 다른 markdownlint 규칙 자동 강제' → 본 옵션은 MD032/MD049 자동 강제 추가, 명백한 scope creep)"
          ]
        }
      ]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "risk": "phase-2 결정 (a)/(b)/(c) 선택 시 의견 충돌 가능 — 5 관점 검토 시 spec-drift / scope contract 가 forward-only 강제 권고할 가능성, 사용자 별 의견 가능",
      "severity": "MEDIUM",
      "likely_phase": "phase-2 (DESIGN.decisions 단계)"
    },
    {
      "id": "R2",
      "risk": "phase-3 신규/확장 smoke 가 v3.0 도그푸드 milestones/v3.0/ 자체 entry (version + id 분리, 단일 entry) 검증 시 정상 PASS 인지 controlled 비교 필요",
      "severity": "LOW",
      "likely_phase": "phase-3 (Stage F 구현 + Stage G 검증)"
    },
    {
      "id": "R3",
      "risk": "phase-3 smoke 가 historical entry (id flat = v{X.Y}_{slug}, version 필드 부재) 를 v3.0+ 신 schema 위반으로 오인할 가능성",
      "severity": "MEDIUM",
      "likely_phase": "phase-3 (smoke logic 작성 시)"
    },
    {
      "id": "R4",
      "risk": "phase-1 markdownlint 함정 narrative 추가 시 본 milestone INTENT/RESEARCH/DESIGN/APPROVE.md 자체가 markdownlint 위반할 가능성 — 사전 self-check 필요",
      "severity": "LOW",
      "likely_phase": "phase-1 (commit 시 markdownlint 자동 차단)"
    },
    {
      "id": "R5",
      "risk": "phase-3 신규 smoke 시 pre-commit 등록 여부 의견 충돌 (옵션 등록 vs 미등록) — 사용자 결정",
      "severity": "LOW",
      "likely_phase": "phase-3 (DESIGN 검토 시)"
    },
    {
      "id": "R6",
      "risk": "milestones/v3.1/ 디렉토리 sub-id 부재 (9-stage-bundled era) 가 smoke-scope-contract / smoke-spec-verification 의 era 분기 자동 식별 PASS 보장 — controlled 비교 필요 (v3.0 phase-7 흡수 패턴 적용)",
      "severity": "LOW",
      "likely_phase": "Stage G VERIFY"
    },
    {
      "id": "R7",
      "risk": "phase-2 가 narrative-only (구현 부담 부재) 라면 phase 단위로 분할할 가치가 부족 — 통합 phase 검토 가능 (phase-1 + phase-2 합병)",
      "severity": "LOW",
      "likely_phase": "DESIGN.phases 단계 (5 관점 architecture 검토 권고 가능)"
    }
  ]
}
```

## 외부 spec 검증 요약

**markdownlint 규칙** (MD032/MD049):

- MD032 (blanks-around-lists): list 앞뒤 빈 줄 의무. v3.0 phase-3 commit 시 발견 — `**필수 게이트**:` 강조 직후 list 시작 시 빈 줄 부재로 fail. 회피: 강조 다음 빈 줄 1개 의무.
- MD049 (emphasis-style): emphasis underscore vs asterisk 일관성. v3.0 INTENT.md/DESIGN.md 안 `v{X.Y}_{slug}` 의 underscore 가 emphasis 오인 (`{X.Y}` ~ `{slug}` 사이 underscore pair → italic 시도). 회피: identifier 백틱 escape (`v{X.Y}_{slug}`).

**markdownlint 설정 (현재 .markdownlint.json)**:

- default: true (= MD032/MD049 활성)
- MD013/MD033/MD041/MD040 disabled
- 본 milestone 작성 시 sub-milestone 1 narrative 가 .markdownlint.json 변경 부재 — 함정 회피만 narrative 명문화.

**semver 정합 (v3.0 → v3.1)**:

- v3.0 (breaking change, major bump) 후속의 backward-compatible 추가 (narrative 강화 + smoke 1건 추가 또는 확장)
- minor bump 정합 — 단조 증가 정책 일관

## codebase 영향 분석

**phase-1 markdownlint 함정 narrative**: tests/CLAUDE.md § '흔한 함정' 표에 7번째 row 추가 (현 6 row → 7 row). MD032/MD049 두 규칙 narrative + 회피 권고 (백틱 escape + 빈 줄). 자동 강제 부재 (markdownlint hook 이 이미 차단, narrative 만 사용자 안내).

**phase-2 milestones.md historical 적용 결정**: ARCHITECTURE.md § 6.1 결정 narrative 추가 (1 단락) + milestones/v3.0/milestones.md spec 섹션 cross-ref 1줄 (선택). 옵션 (a) forward-only 강제 권장 — v3.0 정책 일관, 구현 부담 0.

**phase-3 bundling trigger smoke**: 옵션 (B) 신규 smoke (smoke-bundle-trigger.sh) — 단일 책임 원칙 일관, smoke 매트릭스 narrative 정신 일관. 신규 smoke 검증 책임:

- ROADMAP `milestones[]` 안 v3.0+ entry (`version` + `id` 분리 schema) 가 같은 `version` 값을 둘 이상 보유하지 않음 (= bundling 강제)
- v3.0+ entry 가 `milestones_path` 필드 보유 (`milestones/v{X.Y}/milestones.md` 형식)
- historical entry (id flat, version 필드 부재) 는 무시 (forward-only 정책 일관)

**pre-commit 등록**: 사용자 결정 — 옵션 등록 (12 → 13 hook) 권장 (자동 차단 누적 정신).

## 의존 관계 분석

선행 milestone:

- **v3.0_milestones-restructure** (2026-05-10 completed) — 9-stage-bundled era 도입 + milestones.md spec + bundling 정책 narrative + tests/_era_detect.py 단일 source. 본 milestone 의 lessons L10 + PROPOSE 3건 직접 후속.
- **v2.1_smoke-spawn-batching** (2026-05-10 completed) — smoke batched python3 spawn 패턴 + cp949 reconfigure errors='replace' (v3.0 phase-6 흡수). 신규 bundling smoke 작성 시 표준 절차.

후행 milestone (PROPOSE 시 검토):

- 본 milestone 의 lessons_learned 가 v3.x 또는 v4.0 후속 milestone trigger 가능 (예: bundling smoke 추가 휴리스틱 정교화)

## 관련

- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 정전 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1 bundling 정책
- INTENT: [`INTENT.md`](INTENT.md)
- v3.0 REPORT (lessons L10): [`../v3.0/REPORT.md`](../v3.0/REPORT.md)
- v3.0 PROPOSE (next_candidates 3건): [`../v3.0/PROPOSE.md`](../v3.0/PROPOSE.md)
- v3.0 milestones.md (spec picture-frame reference): [`../v3.0/milestones.md`](../v3.0/milestones.md)
- tests/ 모듈 가이드: [`../../../../tests/CLAUDE.md`](../../../../tests/CLAUDE.md)
- markdownlint 설정: [`../../../../.markdownlint.json`](../../../../.markdownlint.json)
- pre-commit 설정: [`../../../../.pre-commit-config.yaml`](../../../../.pre-commit-config.yaml)
- smoke-projects-scope-discipline (확장 후보 vs 신규 비교): [`../../../../tests/smoke-projects-scope-discipline.sh`](../../../../tests/smoke-projects-scope-discipline.sh)
