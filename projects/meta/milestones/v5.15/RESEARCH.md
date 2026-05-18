# RESEARCH — v5.15 external-audit-team-cycle-4-call

```json
{
  "id": "v5.15",
  "external": [
    {
      "source": "v5.14 PROPOSE.next_candidates#2 (origin: 'v5.14 L3 lesson — 82.4% self-loop 개선 추세 지속')",
      "topic": "cycle 4 trigger 조건 충족 검증",
      "findings": "trigger 명시 = 'v1.19 완료 후 또는 사용자 명시 발의'. v1.19 (upbit-audit-cycle3-apply, 2026-05-18 completed). 사용자 명시 발의 (본 세션 A_user). 둘 다 충족 — trigger AND 조건 부재 (OR 조건 명시), 단일 OR 충족만으로 trigger 진입 가능.",
      "drift": "없음 — v5.14 PROPOSE 명시 정확 carry-over"
    },
    {
      "source": "v5.14 audit-2026-05-18-cycle3/ (4 산출물 — scanner / analyzer / mapper / proposal-draft)",
      "topic": "cycle 3 audit 결과 — diff 기준선",
      "findings": "v5.14 4 산출물 위치 = projects/upbit/audit-2026-05-18-cycle3/ (v5.14 phase-1 commit 0335d01). 4 산출물 = scanner-output.md / analyzer-output.md / mapper-output.md / proposal-draft.md. cycle 3 proposal 4 항목 사용자 Accept = G1 stale cp / G2 symlink narrative / G3 SessionStart hook / S2 spike-investigator. v1.19 mechanical apply (2026-05-18 completed) 결과 = upbit repo 안 4 항목 적용 완료.",
      "drift": "현 upbit 상태 v5.14 cycle 3 기준선 대비 예상 delta = v1.19 apply 4 항목 (예상 가설). 부수 변경 부재 가설 (v1.19 = cycle 3 4 항목 mechanical apply 단일 책임)."
    },
    {
      "source": "v5.14 REPORT.md L38-39 + ARCHITECTURE.md § 4 L135 (vector count 3건)",
      "topic": "self-loop 정량 baseline",
      "findings": "v5.14 REPORT 카운팅 = meta self-loop 14 + 외부 vector 3 = total 17, self-loop = 14/17 = 82.4%. v5.8 baseline (L77) = 12 self-loop + 1 외부 (v1.17) = 12/13 = 92.3%. v5.10 추정 = 13 self-loop (v5.8/v5.9 추가, 단 v5.10 자체는 외부) + 2 외부 = 13/15 ≈ 86.7%. v5.14 카운팅 명시 = 14 self-loop + 3 외부.",
      "drift": "카운팅 모호 — v5.14 REPORT의 '14 self-loop'에서 v5.11/v5.12/v5.13 (audit chain fact narrative cleanup milestone) 포함 여부 불명확. 가능 해석: (A) v5.11~v5.13은 'audit narrative cleanup' 별 분류로 self-loop 제외 → 12+v5.8/v5.9=14 / (B) PROPOSE 작성 시점 카운팅 단순화 (실 누적 17 = 12+v5.8/v5.9/v5.11/v5.12/v5.13). 본 milestone DESIGN.D3 결정 = 옵션 B 채택 (17 self-loop + 4 외부 = 21 total, self-loop = 17/21 = 81%)."
    },
    {
      "source": "v5.13 3-layer fact 검증 절차 (ARCHITECTURE § 4 끝 L137 + agents/project-harness-audit-team/CLAUDE.md D8 Note + claude/commands/harness-meta.md --audit step)",
      "topic": "fact 검증 절차 두 번째 실전 적용 준비",
      "findings": "3-layer 완성 (v5.13 commit 5d673ba+8da5cf1). v5.14 cycle 3 = 첫 실전 적용 (5건 hallucination inline 정정). 본 v5.15 cycle 4 = 두 번째 사례 누적 = 적용 빈도 evidence 축적 + 절차 stability 검증.",
      "drift": "없음 — v5.13 절차 본문 변경 부재 (의무 흡수만)"
    },
    {
      "source": "v1.19 upbit milestone (audit-cycle3-apply, 2026-05-18 completed)",
      "topic": "cycle 3 apply 결과 = cycle 4 input baseline",
      "findings": "v1.19 mechanical apply 4 항목 (G1/G2/G3/S2). meta v5.14 PROPOSE.next_candidates#1 직접 trigger. 본 v5.15의 cycle 4 audit = v1.19 apply 후 upbit 상태 read-only scan = cycle 3 1차 audit 결과 대비 delta 측정 가능.",
      "drift": "없음 — v1.19 완료 narrative 그대로 cycle 4 input baseline"
    }
  ],
  "codebase": {
    "affected_files": [
      "projects/upbit/audit-2026-05-18-cycle4/{scanner,analyzer,mapper,proposal-draft}-output.md (신규 4 산출물 — 디렉토리 명명 DESIGN.decisions 결정)",
      "projects/upbit/audit-2026-05-18-cycle4/diff-vs-cycle3.md (신규 — v5.14 cycle 3 산출물 대비 delta)",
      "projects/meta/milestones/v5.15/{INTENT,RESEARCH,DESIGN,APPROVE,VERIFY,REPORT,PROPOSE}.md + milestones.md + execute/phase-{n}.md",
      "projects/meta/ARCHITECTURE.md (§ 4 L135 vector count 3 → 4 + self-loop 정량 갱신 / § 3.1 끝 L77 v5.8 baseline narrative 보강 시 결정 의무)",
      "projects/meta/ROADMAP.md (v5.15 entry status in_progress → completed)"
    ],
    "untouched_files_explicit": [
      "agents/project-harness-audit-team/CLAUDE.md (절차 변경 부재, v5.13 정전화 narrative 그대로 의무 적용만)",
      "agents/project-scanner.md / harness-gap-analyzer.md / claude-docs-mapper.md / component-proposer.md / component-installer.md (agent 정의 변경 부재 — read-only 호출만)",
      "claude/commands/harness-meta.md (워크플로우 절차 변경 부재 — `--audit` 분기는 명시 호출, 본 milestone은 9-stage freeform default 안에서 audit chain 호출)",
      "upbit repo 소스 파일 (read-only scan 대상 — audit-team scan, 본 milestone scope 안 수정 부재)",
      "projects/meta/milestones/_archive/ (historical 보존)"
    ],
    "current_state": {
      "upbit_plugin_version": "1.1.0",
      "upbit_plugin_hooks_declared": true,
      "upbit_plugin_mcp_servers_declared": true,
      "upbit_claude_md_in_repo": true,
      "upbit_agents_count_v5_14_baseline": 6,
      "upbit_skills_count_v5_14_baseline": 7,
      "v1_19_apply_items": ["G1: stale cp narrative 정정", "G2: symlink narrative 신규", "G3: SessionStart hook 신규", "S2: spike-investigator 재활성"],
      "last_audit_date": "2026-05-18 (v5.14 / cycle 3)",
      "last_commit_since_v5_14": "v1.19 mechanical apply commits + 본 v5.15 시점까지"
    },
    "target_state": {
      "cycle_4_audit_complete": true,
      "fact_verification_procedure_second_applied": true,
      "ecosystem_integrator_vector_count": 4,
      "self_loop_ratio_recalculated_with_explicit_counting_policy": true,
      "v5_14_diff_produced": true,
      "v1_19_apply_validation_result": "regression: 0 expected, change: 4 항목 apply 적용 확인"
    }
  },
  "options": [
    {
      "id": "A",
      "title": "4 멤버 전체 audit chain (v5.14 cycle 3 동일 scope)",
      "description": "project-scanner → harness-gap-analyzer → claude-docs-mapper → component-proposer 순차 호출. v5.13 fact 검증 절차 두 번째 실전 적용. installer 제외 (v5.14 패턴 정합 — accept 결정 후 별 milestone v1.20).",
      "pros": ["v5.14와 1:1 diff 가능", "ecosystem integrator vector 완전 evidence 4건 누적", "fact 검증 절차 두 번째 실전 = 절차 stability evidence", "v1.19 apply 효과 검증 가능"],
      "cons": ["4 멤버 순차 시간 소요", "proposer hallucination cycle 4 risk 가능 (v5.13 절차 mitigation)", "delta 작을 가능성 (v1.19 mechanical apply 단일 책임)"]
    },
    {
      "id": "B",
      "title": "scanner + analyzer 2 멤버 경량 (v1.19 apply 결과 확인 중심)",
      "description": "scanner + analyzer 만 호출 — v5.14 cycle 3 대비 upbit 상태 delta 빠른 파악. docs-mapper + proposer 제외. cycle 4 → cycle 5+ 안 본격 proposer 호출 분리.",
      "pros": ["빠른 delta 확인", "hallucination risk 감소", "산출물 5건 → 2건 축소"],
      "cons": ["proposer 산출물 없음 → 새 gap 발견 시 사용자 결정 게이트 입력 미생성", "ecosystem integrator vector 운용 evidence 부분만 (4 멤버 vs 2 멤버 비대칭)", "v5.14 1:1 diff scope 축소 (4→2 파일)"]
    },
    {
      "id": "C",
      "title": "4 멤버 + diff 명시 분석 강화 (Option A + diff narrative 보강)",
      "description": "Option A + diff-vs-cycle3.md 안 (a) unchanged / (b) changed / (c) new / (d) removed 4 카테고리 분류 + v1.19 apply 4 항목 일대일 검증 표 + self-loop 정량 계산 sub-section 추가.",
      "pros": ["v1.19 apply effect 정확 검증", "self-loop 정량 모호성 해소", "Option A 모든 장점 + diff narrative 강화"],
      "cons": ["diff-vs-cycle3.md LOC 증가 (~200~300 line)", "phase 분할 검토 의무 (1 phase vs 2 phase)"]
    }
  ],
  "risks_identified": [
    {
      "risk": "R1: self-loop 정량 모호 — v5.14 REPORT '14 self-loop' 안 v5.11/v5.12/v5.13 포함 여부 불명확",
      "likelihood": "high",
      "mitigation": "DESIGN.decisions 안 카운팅 정책 명시 결정 (옵션 A: v5.8 baseline 12 + v5.8/v5.9 추가만 = 14 / 옵션 B: v5.11~v5.13 추가 = 17). 본 milestone RESEARCH 안 정량 raw 카운팅 우선."
    },
    {
      "risk": "R2: diff 결과 = v1.19 apply 4 항목 외 변화 부재 예측 → 새 발견 0건 가능 (가치 의문)",
      "likelihood": "medium",
      "mitigation": "cycle 4의 주 가치 재정의 — (a) stability 검증 (regression 0), (b) integrator vector 4건 evidence, (c) 3-layer 절차 두 번째 적용 사례. 새 발견은 부수 가치."
    },
    {
      "risk": "R3: audit chain hallucination 재발 — proposer/scanner cycle 1/2 (v5.10/v5.11) origin, cycle 3 (v5.12 mapper origin)",
      "likelihood": "medium",
      "mitigation": "v5.13 3-layer 절차 적용 = synthesizer 직접 fact 매핑 검증 (boolean / 수치 / 표 / 파일 존재) + 발견 시 inline 정정 (overwrite 회피, audit trail 보존)"
    },
    {
      "risk": "R4: pre-commit smoke 회귀 — 산출물 9개 + ARCHITECTURE 변경 + upbit 산출물 cascade",
      "likelihood": "low",
      "mitigation": "pre-commit hook 자동 실행 + 산출물 schema 검증 (INTENT/APPROVE 필드 누락 사전 인지 — memory feedback_intent_md_schema_required + feedback_approve_md_schema_wrap)"
    },
    {
      "risk": "R5: ecosystem integrator vector 가설 (78% 개선 추세) 검증 실패 — 카운팅 baseline 변경 시 비율 정체 가능",
      "likelihood": "medium",
      "mitigation": "정확 카운팅 재산정 + narrative 안 baseline 변경 사실 명시 (v5.14 카운팅 모호 → v5.15 정전화). 비율 정체도 정량 evidence로 narrative 정전화."
    },
    {
      "risk": "R6: v5.10 audit 디렉토리 = projects/upbit/audit-2026-05-18/, v5.14 cycle 3 산출물 = projects/upbit/audit-2026-05-18-cycle3/ (suffix flat). cycle 4 디렉토리 명명 충돌 회피 의무",
      "likelihood": "medium",
      "mitigation": "DESIGN.D2 결정 = audit-2026-05-18-cycle4/ (v5.14 patterns 정합 suffix flat). cycle3/cycle4 baseline 분리 보존."
    }
  ]
}
```

## narrative

**조사 요약**: v5.14 PROPOSE.next_candidates#2 명시 trigger 조건 OR (v1.19 완료 OR 사용자 명시 발의) 둘 다 충족. v5.14 cycle 3 산출물 (projects/upbit/audit-2026-05-18-cycle3/ 4 파일) baseline + v1.19 apply 4 항목 후 upbit 상태 = cycle 4 audit input.

**외부 검증 (external)**: 5건 — v5.14 PROPOSE / v5.14 audit 산출물 / v5.14 REPORT self-loop 카운팅 / v5.13 절차 / v1.19 apply 결과.

**codebase**: affected 5건 (audit 산출물 4 + diff 1 + meta 산출물 9 + ARCHITECTURE 1 + ROADMAP 1) + untouched 5건 (agent 정의 / 절차 narrative / upbit 소스 / archive). current_state = v5.14 cycle 3 baseline. target_state = cycle 4 4 산출물 + diff + vector 4건 + self-loop 정량 재계산.

**옵션 (options)**: 3건 raw 분석 — A(4 멤버 full) / B(2 멤버 경량) / C(A + diff narrative 강화). 결정은 DESIGN.

**리스크 (risks_identified)**: 6건 (R1~R6). R1 self-loop 카운팅 모호 (DESIGN.decisions 의무) / R2 새 발견 0건 가능 / R3 hallucination 재발 / R4 smoke 회귀 / R5 비율 정체 가능 / R6 디렉토리 명명 충돌.
