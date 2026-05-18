# RESEARCH — v5.17 external-audit-team-cycle-5-call

```json
{
  "id": "v5.17",
  "external": [
    {
      "source": "v5.16 PROPOSE.next_candidates#3 (origin: v5.15 PROPOSE.next_candidates#3, 'cycle 5+ 추가 누적 시 정량 evidence 강화 + 본 v5.16 정전화 효과 검증')",
      "topic": "cycle 5 trigger 조건 충족 검증",
      "findings": "trigger 명시 = 'upbit v1.20 완료 후' = 충족 (upbit v1.20_upbit-audit-cycle4-apply 2026-05-18 completed, commit 9d2862c phase-1 + 5aeed93 chore). 사용자 명시 발의 (본 세션 A_user). 둘 다 충족 — trigger AND 조건 부재, 단일 OR 충족만으로 trigger 진입 가능.",
      "drift": "없음 — v5.16 PROPOSE 명시 정확 carry-over"
    },
    {
      "source": "v5.15 audit-2026-05-18-cycle4/ (5 산출물 — scanner/analyzer/mapper/proposal-draft + diff-vs-cycle3)",
      "topic": "cycle 4 audit 결과 — diff 기준선",
      "findings": "v5.15 5 산출물 위치 = projects/upbit/audit-2026-05-18-cycle4/. 4 audit chain 산출물 + diff-vs-cycle3.md. cycle 4 proposal 2 항목 사용자 Accept = R1 (CLAUDE.md L124~L125 stale 경로 narrative) + R2 (L37 v1.20 forward reference → v1.12 대체). v1.20 mechanical apply (2026-05-18 completed) 결과 = upbit repo CLAUDE.md L37 + L122~L125 안 2 항목 적용 완료 확인 (직접 verify — L37 = 'pre-commit hooks (v1.12)' / L122 = `.claude-plugin/hooks/post-edit-syntax-check.sh` / L123 = `plugin.json mcpServers.harness`).",
      "drift": "현 upbit 상태 v5.15 cycle 4 기준선 대비 예상 delta = v1.20 apply 2 항목 (verified). 부수 변경 부재 가설 (v1.20 = cycle 4 2 항목 mechanical apply 단일 책임)."
    },
    {
      "source": "v5.15 REPORT.md + ARCHITECTURE.md § 4 (vector count 4건)",
      "topic": "self-loop 정량 baseline",
      "findings": "v5.15 카운팅 정전화 = 17 self-loop + 4 외부 vector = 17/21 = 81% self-loop. v5.8 baseline (L77) = 12+1 = 92.3%. v5.10 = 13+2 = 86.7%. v5.14 카운팅 = 14+3 = 82.4%. v5.15 정전화 = 17+4 = 81%. 본 v5.17 = 외부 vector 5건 (v1.17 + v5.10 + v5.14 + v5.15 + 본 v5.17). self-loop 카운팅 = v5.15 정전화 17 + v5.16 (lint precheck = workflow narrative 자체 강화 = self-loop) = 18 → 18/23 = 78.3%.",
      "drift": "v5.15 정전화 카운팅 정책 (v5.11~v5.13 포함) 그대로 적용. v5.16 = self-loop 분류 (v5.16 audit narrative 자체 강화). 옵션 정합 — 본 milestone DESIGN.D3 에서 18/23 = 78.3% 최종 결정 확인."
    },
    {
      "source": "v5.13 3-layer fact 검증 절차 (ARCHITECTURE § 4 끝 + agents/project-harness-audit-team/CLAUDE.md D8 Note + claude/commands/harness-meta.md --audit step)",
      "topic": "fact 검증 절차 세 번째 실전 적용 준비",
      "findings": "3-layer 완성 (v5.13). v5.14 cycle 3 = 첫 실전 적용 (5 hallucination 정정). v5.15 cycle 4 = 두 번째 (2 hallucination 정정 — scanner claude_md_bytes 추정 + proposer apply path .claude/ prefix). 본 v5.17 cycle 5 = 세 번째 사례 누적 = N=3 통계 시작 + 절차 stability 검증.",
      "drift": "없음 — v5.13 절차 본문 변경 부재 (의무 흡수만)"
    },
    {
      "source": "v5.16 lint precheck 절차 (ARCHITECTURE § 4 끝 + agents/project-harness-audit-team/CLAUDE.md D8 Note v5.16 + claude/commands/harness-meta.md --audit lint precheck step)",
      "topic": "lint precheck 절차 첫 실전 적용 준비",
      "findings": "3-layer 완성 (v5.16). MD022 (blanks-around-headings) + MD031 (blanks-around-fences) + MD032 (blanks-around-lists) hardcode. v5.16 자체 phase-1 1차 MD028 회귀 도그푸드 사례 (transition paragraph 삽입으로 해소). 본 v5.17 cycle 5 = 첫 실전 적용 = audit chain 4 산출물 markdown 위반 사전 방지 효과 검증 evidence 첫 사례.",
      "drift": "없음 — v5.16 절차 본문 변경 부재. 단 lint precheck 절차에 MD028 누락 (v5.16 out_of_scope) — 본 milestone 안 MD028 자체 발견 시 evidence 추가 누적 가능 (v5.16 PROPOSE#2 진급 trigger 후보)"
    },
    {
      "source": "v1.20 upbit milestone (upbit-audit-cycle4-apply, 2026-05-18 completed, commit 9d2862c + 5aeed93)",
      "topic": "cycle 4 apply 결과 = cycle 5 input baseline",
      "findings": "v1.20 mechanical apply 2 항목 (R1 + R2). meta v5.15 PROPOSE.next_candidates#1 직접 trigger. 본 v5.17의 cycle 5 audit = v1.20 apply 후 upbit 상태 read-only scan = cycle 4 1차 audit 결과 대비 delta 측정 가능.",
      "drift": "없음 — v1.20 완료 narrative 그대로 cycle 5 input baseline"
    },
    {
      "source": "upbit repo 현 상태 직접 verify (RESEARCH 시점)",
      "topic": "v1.20 apply 효과 사전 확인",
      "findings": "C:/Users/qkreh/upbit/CLAUDE.md 직접 Read = L37 = 'pre-commit hooks (v1.12)' / L122 = '`.claude-plugin/hooks/post-edit-syntax-check.sh`' / L123 = '`plugin.json mcpServers.harness`'. v1.20 R1 + R2 모두 mechanical apply 정확. git log -10 = v1.20 phase-1 (9d2862c) + chore (5aeed93) 확인. 부수 commit 부재 (cycle 4 → cycle 5 baseline = v1.20 단일 변경).",
      "drift": "없음 — v1.20 apply 완료 + 부수 변경 0건 확인. cycle 5 audit input baseline 명확."
    }
  ],
  "codebase": {
    "affected_files": [
      "projects/upbit/audit-2026-05-18-cycle5/{scanner,analyzer,mapper,proposal-draft}-output.md (신규 4 산출물 — 디렉토리 명명 DESIGN.decisions 결정)",
      "projects/upbit/audit-2026-05-18-cycle5/diff-vs-cycle4.md (신규 — v5.15 cycle 4 산출물 대비 delta + v1.20 apply 효과 검증 sub-section)",
      "projects/meta/milestones/v5.17/{INTENT,RESEARCH,DESIGN,APPROVE,VERIFY,REPORT,PROPOSE}.md + milestones.md + execute/phase-{n}.md",
      "projects/meta/ARCHITECTURE.md (§ 4 vector count 4 → 5 + self-loop 정량 갱신, narrative 본문 무변경)",
      "projects/meta/ROADMAP.md (v5.17 entry status in_progress → completed)"
    ],
    "untouched_files_explicit": [
      "agents/project-harness-audit-team/CLAUDE.md (절차 변경 부재, v5.13+v5.16 정전화 narrative 그대로 의무 적용만)",
      "agents/project-scanner.md / harness-gap-analyzer.md / claude-docs-mapper.md / component-proposer.md / component-installer.md (agent 정의 변경 부재 — read-only 호출만)",
      "claude/commands/harness-meta.md (워크플로우 절차 변경 부재 — `--audit` 분기는 명시 호출, 본 milestone은 9-stage freeform default 안에서 audit chain 호출)",
      "upbit repo 소스 파일 (read-only scan 대상 — audit-team scan, 본 milestone scope 안 수정 부재)",
      "projects/meta/ARCHITECTURE.md § 3.1 끝 정체성 paragraph 본문 (v5.16 PROPOSE#5 candidate — 별 milestone scope)",
      "projects/meta/milestones/_archive/ (historical 보존)"
    ],
    "current_state": {
      "upbit_plugin_version": "1.1.0",
      "upbit_plugin_hooks_declared": true,
      "upbit_plugin_mcp_servers_declared": true,
      "upbit_claude_md_in_repo": true,
      "upbit_agents_count_v5_15_baseline": 7,
      "upbit_skills_count_v5_15_baseline": 7,
      "upbit_hooks_count_v5_15_baseline": 2,
      "v1_20_apply_items": ["R1: CLAUDE.md L122~L123 .claude/hooks → .claude-plugin/hooks + plugin.json mcpServers.harness", "R2: CLAUDE.md L37 v1.20 forward reference → v1.12 대체 (Option A)"],
      "v1_20_apply_verified_via_read": true,
      "last_audit_date": "2026-05-18 (v5.15 / cycle 4)",
      "last_commit_since_v5_15": "v1.20 mechanical apply commits (9d2862c + 5aeed93)"
    },
    "target_state": {
      "cycle_5_audit_complete": true,
      "fact_verification_procedure_third_applied": true,
      "lint_precheck_procedure_first_applied": true,
      "ecosystem_integrator_vector_count": 5,
      "self_loop_ratio_recalculated_with_v5_16_inclusion": true,
      "v5_15_diff_produced": true,
      "v1_20_apply_validation_result": "regression: 0 expected, change: 2 항목 apply 적용 확인 (RESEARCH 시점 사전 verify 완료)"
    }
  },
  "options": [
    {
      "id": "A",
      "title": "4 멤버 전체 audit chain (v5.15 cycle 4 동일 scope)",
      "description": "project-scanner → harness-gap-analyzer → claude-docs-mapper → component-proposer 순차 호출. v5.13 fact 검증 절차 세 번째 실전 적용 + v5.16 lint precheck 절차 첫 실전 적용. installer 제외 (v5.14/v5.15 패턴 정합 — accept 결정 후 별 milestone v1.21).",
      "pros": ["v5.15와 1:1 diff 가능", "ecosystem integrator vector 완전 evidence 5건 누적", "fact 검증 절차 세 번째 + lint precheck 절차 첫 실전 = 절차 양 측면 evidence 동시 누적", "v1.20 apply 효과 검증 가능"],
      "cons": ["4 멤버 순차 시간 소요", "proposer hallucination cycle 7+ risk 가능 (v5.13 절차 mitigation)", "delta 작을 가능성 (v1.20 mechanical apply 단일 책임, 부수 변경 0건 확인)"]
    },
    {
      "id": "B",
      "title": "scanner + analyzer 2 멤버 경량 (v1.20 apply 결과 확인 중심)",
      "description": "scanner + analyzer 만 호출 — v5.15 cycle 4 대비 upbit 상태 delta 빠른 파악. docs-mapper + proposer 제외.",
      "pros": ["빠른 delta 확인", "hallucination risk 감소", "산출물 5건 → 2건 축소"],
      "cons": ["proposer 산출물 없음 → 새 gap 발견 시 사용자 결정 게이트 입력 미생성", "ecosystem integrator vector 운용 evidence 부분만 (4 멤버 vs 2 멤버 비대칭)", "v5.15 1:1 diff scope 축소 (4→2 파일)", "lint precheck 절차 첫 실전 evidence 부분만 (4 산출물 중 2 산출물만)"]
    },
    {
      "id": "C",
      "title": "4 멤버 + diff 명시 분석 강화 (Option A + diff narrative 보강)",
      "description": "Option A + diff-vs-cycle4.md 안 (a) unchanged / (b) changed / (c) new / (d) removed 4 카테고리 분류 + v1.20 apply 2 항목 일대일 검증 표 + self-loop 정량 계산 sub-section + lint precheck 결과 sub-section (4 산출물별 MD022/MD031/MD032 위반 검사 결과 표) 추가.",
      "pros": ["v1.20 apply effect 정확 검증", "self-loop 정량 모호성 해소", "lint precheck 첫 실전 evidence 명시 표 형태", "Option A 모든 장점 + diff narrative 강화"],
      "cons": ["diff-vs-cycle4.md LOC 증가 (~200~300 line)", "phase 분할 검토 의무 (1 phase vs 2 phase)"]
    }
  ],
  "risks_identified": [
    {
      "risk": "R1: self-loop 카운팅 baseline v5.15 정전화 (17/21) → v5.17 갱신 시 v5.16 분류 (self-loop vs 외부) 결정 필요",
      "likelihood": "medium",
      "mitigation": "DESIGN.decisions 안 카운팅 정책 명시 결정 (옵션 A: v5.16 = self-loop 분류 = 18/23 / 옵션 B: v5.16 = 외부 분류 = 17/22). 본 milestone DESIGN.D3 에서 옵션 A 채택 예정 (v5.16 audit narrative 자체 강화 본질 = self-loop 정합)."
    },
    {
      "risk": "R2: diff 결과 = v1.20 apply 2 항목 외 변화 부재 예측 → 새 발견 0건 가능 (가치 의문)",
      "likelihood": "high",
      "mitigation": "cycle 5의 주 가치 재정의 — (a) stability 검증 (regression 0), (b) integrator vector 5건 evidence, (c) v5.13 절차 세 번째 + v5.16 절차 첫 실전 적용 사례. 새 발견은 부수 가치. RESEARCH 시점 직접 verify = v1.20 apply 정확 + 부수 변경 0건 확인 = R2 likelihood high 명시."
    },
    {
      "risk": "R3: audit chain hallucination 재발 — proposer/scanner/mapper cycle 1~6 누적 (v5.10/v5.11/v5.12/v5.14/v5.15)",
      "likelihood": "medium",
      "mitigation": "v5.13 3-layer 절차 적용 = synthesizer 직접 fact 매핑 검증 (boolean / 수치 / 표 / 파일 존재) + 발견 시 inline 정정 (overwrite 회피, audit trail 보존). cycle 5+ 추가 hallucination 발생 시 N=7 통계 강화."
    },
    {
      "risk": "R4: pre-commit smoke 회귀 — 산출물 9개 + ARCHITECTURE 변경 + upbit 산출물 cascade",
      "likelihood": "low",
      "mitigation": "pre-commit hook 자동 실행 + 산출물 schema 검증 (INTENT/APPROVE 필드 누락 사전 인지 — memory feedback_intent_md_schema_required + feedback_approve_md_schema_wrap). markdownlint MD022/MD031/MD032 사전 적용 (v5.16 lint precheck 절차 자체 적용)."
    },
    {
      "risk": "R5: ecosystem integrator vector 운용 evidence 78~81% 정체 가능 — 카운팅 baseline 변경 시 비율 변화 작음",
      "likelihood": "medium",
      "mitigation": "정확 카운팅 재산정 + narrative 안 baseline 변경 사실 명시 (v5.15 정전화 그대로 + v5.16 분류 추가). 비율 변화 작음도 정량 evidence로 narrative 정전화 (monotonic 감소 추세 지속 확인)."
    },
    {
      "risk": "R6: cycle 4 디렉토리 = audit-2026-05-18-cycle4/, cycle 5 디렉토리 명명 충돌 회피 의무",
      "likelihood": "low",
      "mitigation": "DESIGN.D2 결정 = audit-2026-05-18-cycle5/ (v5.14/v5.15 patterns 정합 suffix flat). cycle4/cycle5 baseline 분리 보존."
    },
    {
      "risk": "R7: v5.16 lint precheck 절차 첫 실전 적용 안 MD028 (no-blanks-blockquote) 등 hardcode 외 rule 위반 발견 시 → procedure 한계 evidence 누적 (v5.16 L2 도그푸드 재발 패턴)",
      "likelihood": "medium",
      "mitigation": "MD028 또는 기타 rule 발견 시 inline 정정 + evidence 기록 → v5.16 PROPOSE#2 (audit-output-markdown-lint-rule-expansion-md028) trigger 조건 가속. 본 milestone scope = 발견 사실 진술만 (절차 확장 별 milestone)."
    }
  ]
}
```

## narrative

**조사 요약**: v5.16 PROPOSE.next_candidates#3 명시 trigger 조건 (upbit v1.20 완료 후) 충족. v5.15 cycle 4 산출물 (projects/upbit/audit-2026-05-18-cycle4/ 5 파일) baseline + v1.20 apply 2 항목 (R1 + R2) 후 upbit 상태 = cycle 5 audit input. RESEARCH 시점 직접 verify = v1.20 apply 정확 + 부수 변경 0건 확인.

**외부 검증 (external)**: 7건 — v5.16 PROPOSE / v5.15 audit 산출물 / v5.15 REPORT self-loop 카운팅 / v5.13 절차 / v5.16 절차 / v1.20 apply 결과 / upbit 직접 verify.

**codebase**: affected 5건 (audit 산출물 4 + diff 1 + meta 산출물 9 + ARCHITECTURE 1 + ROADMAP 1) + untouched 6건 (agent 정의 / 절차 narrative / upbit 소스 / § 3.1 paragraph / archive). current_state = v5.15 cycle 4 baseline + v1.20 apply 후. target_state = cycle 5 4 산출물 + diff + vector 5건 + self-loop 정량 재계산 + lint precheck 첫 실전 evidence.

**옵션 (options)**: 3건 raw 분석 — A(4 멤버 full) / B(2 멤버 경량) / C(A + diff narrative 강화). 결정은 DESIGN.

**리스크 (risks_identified)**: 7건 (R1~R7). R1 self-loop 카운팅 v5.16 분류 / R2 새 발견 0건 가능 (high) / R3 hallucination 재발 / R4 smoke 회귀 / R5 비율 정체 가능 / R6 디렉토리 명명 충돌 / R7 lint precheck rule 한계 evidence.
