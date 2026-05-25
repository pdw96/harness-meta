---
id: v5.16
title: RESEARCH v5.16
version: v5.16
stage: RESEARCH
status: completed
---

# RESEARCH — v5.16 audit-output-markdown-lint-precheck

## Spec

```json
{
  "external": [
    {
      "source": "v5.14 REPORT.md L58-L59 (lesson L7) + v5.14 PROPOSE.md L24-L25 (next_candidates#3)",
      "topic": "v5.14 cycle 3 audit 안 markdownlint 회귀 첫 발현",
      "findings": "Phase 1 commit 안 markdownlint MD022 (blanks-around-headings) + MD032 (blanks-around-lists) + MD028 (no-blanks-blockquote) 3 rule 위반 3건 발생. agent (project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer) 산출 markdown 을 repo 저장 시 markdownlint 위반 자동 발생 패턴 첫 관찰.",
      "drift": "v5.14 PROPOSE#3 origin (`audit-output-markdown-lint-precheck`) — 향후 cycle 5+ 추가 누적 시 발의."
    },
    {
      "source": "v5.15 REPORT.md L44-L45 (lesson L5) + v5.15 VERIFY.md L10-L11 + L55 + L69",
      "topic": "v5.15 cycle 4 audit 안 markdownlint 회귀 재현",
      "findings": "Phase 1 commit 1차 시도 markdownlint MD031 (fenced code blocks blank lines) + MD032 (lists blank lines) 2 rule 위반 8건 FAIL. 수동 inline blank line 정정 → 2차 PASS. v5.14 L7 lesson origin 재현 — 누적 2 사례 trigger 충족 = v5.15 PROPOSE.next_candidates#2 `audit-output-markdown-lint-precheck` 발의 가능 조건 충족.",
      "drift": "v5.14 L7 (3건) → v5.15 L5 (8건) 증가 추세 — cycle 5+ 추가 누적 시 회귀 cost 비례 증가 예상."
    },
    {
      "source": "v5.15 PROPOSE.md L21-L27 (next_candidates#2 본 milestone direct origin)",
      "topic": "본 milestone 직접 origin entry",
      "findings": "trigger_condition: '사용자 명시 발의 (A_user) ∧ 이미 2 사례 trigger 충족 (즉시 발의 가능)' = 본 세션 사용자 명시 발의 = trigger 조건 PASS. rationale: 'agent 산출 markdown을 repo 저장 시 MD022/MD031/MD032 lint 위반 자동 발생 — agent 산출 직후 lint 자동 검증 절차 정전화 (pre-write check 또는 inline blank line 패턴 명시) 필요.'",
      "drift": "v5.15 PROPOSE.md L24 rule 명명 = MD022/MD031/MD032 — 사용자 결정 Q3 hardcode 정합."
    },
    {
      "source": "v5.14 PROPOSE.md L24-L25 (next_candidates#3 origin) — MD028 vs 본 milestone MD031 분기 검토",
      "topic": "rule 누적 정량 정합 검토 (Q3 결정 평가)",
      "findings": "v5.14 cycle 3 rule 분포 = MD022(1) + MD032(1) + MD028(1) = 3 rule. v5.15 cycle 4 rule 분포 = MD031(다) + MD032(다) = 2 rule. 2 사례 누적 시 rule 별 발생 count: MD022 (1 cycle, 1건) / MD031 (1 cycle, 다) / MD032 (2 cycle, 다) / MD028 (1 cycle, 1건). MD028 = 1 cycle 단일 발현 (재발 부재).",
      "drift": "Q3 hardcode (MD022 + MD031 + MD032) 정합 — MD028 미포함 = 1 cycle 단일 발현 evidence-base 미흡 (재발 시 별 milestone 재발의 candidate). 본 milestone 안 정전화 위치 (RESEARCH external#4) 안 명시."
    }
  ],
  "codebase": {
    "affected_files_explicit": [
      "projects/meta/ARCHITECTURE.md § 4 끝 (L137 직후, ### 4.1 Bundling L139 직전 — v5.11 'Audit chain fact 인용 검증 의무' paragraph 직후 위치) — Layer A WHAT 정전화",
      "agents/project-harness-audit-team/CLAUDE.md ## Orchestration sequence (D8) 섹션 안 (L68 v5.13 Note 직후, L70 '병렬 가능성' 직전 — Note (v5.16) 추가) — Layer B WHERE 절차",
      "claude/commands/harness-meta.md `--audit` opt-in 분기 안 (L80 synthesizer fact 검증 step 직후, L81 사용자 명시 결정 게이트 직전 — lint precheck step 추가) — Layer C HOW 절차",
      "projects/meta/milestones/v5.16/execute/phase-1.md (본 milestone 의 EXECUTE 산출, 위 3 host 동시 변경)"
    ],
    "untouched_files_explicit": [
      ".markdownlint.json (rule set 자체 무변경, out_of_scope#3 정합)",
      ".pre-commit-config.yaml (hook 자체 무변경, out_of_scope#3 정합)",
      "agents/project-scanner.md, agents/harness-gap-analyzer.md, agents/claude-docs-mapper.md, agents/component-proposer.md (agent 정의 본문 무변경, out_of_scope#1 정합 = v5.15 PROPOSE#5 별 milestone scope)",
      "projects/upbit/audit-2026-05-18-cycle4/ (v5.15 archive 보존, 무변경)"
    ],
    "current_state": "3 host 안 lint precheck 절차 narrative 부재. v5.14 + v5.15 = 2 cycle 연속 회귀 evidence 있으나 절차 정전화 부재 = cycle 5+ 추가 누적 시 동일 회귀 재발 risk. v5.13 절차 정전화 3-layer cross-ref 구조는 fact 검증 1 layer 완성 — lint precheck = 2nd layer 추가 의무.",
    "target_state": "3 host 안 lint precheck 절차 narrative 정전화 — Layer A (WHAT, ARCHITECTURE § 4 끝) + Layer B (WHERE, agents D8 Note) + Layer C (HOW, claude/commands `--audit` 분기 step). MD022/MD031/MD032 3 rule hardcode. v3.21 narrative 정전화 3 단계 패턴 16 번째 cycle 도그푸드 완성."
  },
  "options": [
    {
      "option": "O1: 3-layer 정전화 (사용자 결정 Q1 Recommended)",
      "pros": "v5.13 정전화 3-layer cross-ref 구조 패턴 정합 — WHAT (ARCHITECTURE § 4 끝) + WHERE (agents D8 Note) + HOW (claude/commands `--audit` step). 자동화 도구 도입 없음 = 도구 dependency 부재 = scope 작음 (3 파일). v3.21 narrative 정전화 3 단계 16 cycle 도그푸드 completion.",
      "cons": "narrative 절차 = synthesizer (메인 Claude) 가 수동 실행 — 자동 검증 enforcement 부재. 후속 cycle 5+ 안 회귀 재발 가능 risk (실 효과 검증은 cycle 5 호출 시점)."
    },
    {
      "option": "O2: 자동 fix 도구 도입 (사용자 결정 Q1 미선택)",
      "pros": "markdownlint --fix 또는 mdformat 등 자동 fix 도구 호출 = 회귀 자동 방지. enforcement 강.",
      "cons": "도구 dependency 추가 = 환경 설정 cost. pre-commit hook 또는 별 script 도입 = scope 확대. evidence 부족 (2 사례 누적 = narrative 정전화 우선 정합)."
    },
    {
      "option": "O3: 하이브리드 (narrative + helper script)",
      "pros": "narrative 정전화 + pre-write check helper script 단일 도입 = 양면 강화.",
      "cons": "scope 2 파트 증가 = lightweight 모드 위배. 5 관점 검토 필요. evidence 부족 (2 사례 = O1 우선 정합)."
    },
    {
      "option": "O4: defer (cycle 5+ 추가 누적 후)",
      "pros": "evidence 누적 더 (3+ 사례) 후 정전화 = 정량 정합 강.",
      "cons": "v5.15 PROPOSE#2 trigger_condition '이미 2 사례 trigger 충족' 정합 안 함 — defer 정당화 약함. 사용자 명시 발의 (A_user) 거부."
    }
  ],
  "risks_identified": [
    "R1: ARCHITECTURE § 4 끝 위치 부적합 — v5.11 'Audit chain fact 인용 검증 의무' paragraph 직후가 자연 위치이나, lint precheck = fact 검증과 별 책임. § 6 으로 분리 검토 필요 (DESIGN 단계 결정).",
    "R2: agents D8 Note 추가 시 v5.13 Note (synthesizer fact 검증) 와 책임 중복 risk — Note (v5.16) 안 fact 검증과의 분리 명시 의무.",
    "R3: claude/commands/harness-meta.md `--audit` 분기 step 추가 시 sequence 순서 — synthesizer fact 검증 직후 lint precheck 가 자연 (산출물 안 fact 검증 후 markdown lint = 두 검증 단계).",
    "R4: MD022/MD031/MD032 hardcode = 3 rule 외 lint 위반 자동 무시 → 향후 새 rule (예: MD028 재발, 또는 신 rule 발현) 시 본 절차 outdated 가능. cycle 5+ 발생률 정량 evidence 누적 시 재발의 candidate (RESEARCH#4 본문 명시 정합).",
    "R5: 3-layer 정전화 narrative 동기화 누락 — Layer A 정전화 후 Layer B/C 빠짐 시 (Stage F 부분 commit) cross-ref drift. v3.21 narrative 정전화 3 단계 패턴 (DESIGN.D2.exact_text + EXECUTE 정확 삽입 + VERIFY grep 3 키워드) 적용 = 회피."
  ]
}
```

## narrative

### v5.14 / v5.15 lint 회귀 정량 정합 (external#1 + #2 + #4)

| cycle | rule 분포 | 건수 |
|:-:|---|:-:|
| v5.14 cycle 3 | MD022 + MD032 + MD028 | 3건 |
| v5.15 cycle 4 | MD031 + MD032 | 8건 |

누적 2 사례 rule 별 발생 count:

| rule | cycle | 누적 발생 |
|:-:|:-:|:-:|
| MD022 (blanks-around-headings) | 1 cycle (v5.14) | 1건 |
| MD028 (no-blanks-blockquote) | 1 cycle (v5.14) | 1건 |
| MD031 (fenced code blocks blank lines) | 1 cycle (v5.15) | 다 |
| MD032 (blanks-around-lists) | 2 cycle (v5.14 + v5.15) | 다 |

Q3 hardcode (MD022 + MD031 + MD032) = v5.15 PROPOSE.md L24 명명 정합. MD028 미포함 = 1 cycle 단일 발현 evidence-base 미흡 (재발 시 별 milestone candidate).

### 3-layer 정전화 host 위치 (codebase.affected_files_explicit)

- **Layer A** = `projects/meta/ARCHITECTURE.md` § 4 끝 (L137 v5.11 paragraph 직후, L139 ### 4.1 직전) — WHAT 정의
- **Layer B** = `agents/project-harness-audit-team/CLAUDE.md` ## Orchestration sequence (D8) 섹션 안 (L68 v5.13 Note 직후, L70 '병렬 가능성' 직전) — WHERE 절차
- **Layer C** = `claude/commands/harness-meta.md` `--audit` opt-in 분기 안 (L80 synthesizer fact 검증 step 직후) — HOW 절차

v5.13 패턴 정합 — Layer A (WHAT) + Layer B (WHERE) + Layer C (HOW) 3-layer cross-ref 구조.

### risks_identified 사실 진술 (v3.10 정합)

5건 모두 본 milestone 의 식별 risk 사실 진술. 후속 milestone 발의 명령형 표현 부재 (R4 안 '재발의 candidate' = 거명만, 명령형 부재).

## 관련

- 메타 ROADMAP: [`../../ROADMAP.md`](../../ROADMAP.md)
- 직접 origin: v5.15 PROPOSE.next_candidates#2
- 정전화 패턴: v5.13 INTENT.md + v5.13 DESIGN.md
- 누적 evidence 1차 source: v5.14 REPORT.md L58-L59 + v5.15 VERIFY.md L10-L11
