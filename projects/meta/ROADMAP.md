# ROADMAP — meta

```json
{
  "project": "meta",
  "updated": "2026-05-18",
  "deferred_note": "v3.6_milestones-md-validation-extension + v3.7_workflow-narrative-strengthening-v2 (구 pending) 는 v3.6_overengineering-audit (2026-05-11 진단 결과) 에 의해 defer. v1.4_hook-narrative-separation + v1.4_design-review-trace + v1.5_research-cascade-grep-discipline (v1.x era pending, v2.0_workflow-word-fidelity lessons next_candidates#1 origin) 도 v3.13_pending-milestone-renumber-policy (cycle 1, 2026-05-12) 결정으로 defer — 모두 workflow self-improvement 본질, § 6.2 재발의 trigger 조건 (외부 projects/<name>, name ≠ meta 실 적용 milestone 1건 완료 + 정량 데이터 기반 명시 발의) 충족 시 재발의. 자기참조 사이클 (workflow self-improvement) 동결 권고 적용. v3.14_deferred-revaluation-cycle-2 (cycle 2, 2026-05-13) 검토 결과 — 옵션 A (동결 유지) 채택. 외부 적용 5건 추가 누적 (v1.10~v1.14) 시점 evidence 검증 결과 direct_naming 0 + indirect_impact 0 + reverse_evidence 5 → 조건 (1) PASS (10건 누적) ∧ 조건 (2) FAIL (0건 정량 evidence) = AND FAIL → 재발의 trigger 미충족. 다음 cycle trigger 조건 — 외부 적용 5건 추가 누적 ∧ 사용자 명시 발의 AND.",
  "schema_note": "v3.0+ 9-stage-bundled era entry: {version, id (group-slug), title, status, summary, trigger, milestones_path?}. v2.0~v2.1 / v1.0~v1.4 보존 entry: 기존 schema (id flat = v{X.Y}_{slug}) 유지 (forward-only). 신 schema spec: ARCHITECTURE.md § 6.1. candidate_draft[] (v4.0 phase-7 신규, D4): 벤치마크 cycle routine (schedule skill 주 1회) 산출물 host — entry schema = {id, title, source, detected_at, rationale, category: 'github-pattern'|'claude-code-update'|'fleet-evolution', decision_pending: true}. 사용자 명시 결정 후 milestones[] 정식 등재 (e3 정책).",
  "candidate_draft": [],
  "milestones": [
    {
      "version": "v5.14",
      "id": "external-audit-team-cycle-3-call",
      "title": "audit-team 외부 호출 cycle 3 — upbit 대상 + v5.10 audit diff + fact 검증 절차 첫 실전 적용",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.14/milestones.md",
      "summary": "사용자 명시 발의 (A_user, 2026-05-18). v5.13 PROPOSE#6 carry-over (v5.10 PROPOSE#6 origin). project-harness-audit-team 4 멤버(scanner → gap-analyzer → docs-mapper → proposer) upbit 대상 세 번째 실 호출 + v5.13 3-layer fact 검증 절차 첫 실전 적용. 4 산출물 안 총 5건 hallucination inline 정정 (scanner 1 + mapper 1 + proposer 3). gap: G1(stale cp 지속) / G2(CLAUDE.md symlink narrative 신규) / G3(session-init hook 지속) / S2(spike-investigator 재활성). 사용자 4건 모두 Accept — v1.19 upbit milestone trigger. ARCHITECTURE.md L135 vector count 2건→3건. ecosystem integrator vector 3건(v1.17+v5.10+v5.14). 2-phase 2 commit (0335d01 phase-1 + chore G+H+I). 7 lessons. 2026-05-18."
    },
    {
      "version": "v5.13",
      "id": "audit-chain-fact-verification-protocol-procedure",
      "title": "audit chain 산출물 fact 검증 절차 정전화 — Stage A OPEN 안 직접 검증 step 신규 또는 agents/project-harness-audit-team/CLAUDE.md 검증 책임 명시 (v5.12 PROPOSE#1 carry-over, cycle 3 evidence 도달)",
      "status": "completed",
      "summary": "사용자 명시 발의 (A_user, 2026-05-18). v5.12 PROPOSE#1 carry-over (v5.11 PROPOSE#1 origin, cycle 3 evidence 도달). audit chain hallucination 3 cycle 누적 (v5.10/v5.11/v5.12) 후 ARCHITECTURE § 4 끝 'Audit chain fact 인용 검증 의무' paragraph (WHAT 정의, v5.11 정전화) 와 보완하는 WHERE/HOW 절차 step 을 두 workflow 문서 안에 추가 — 3-layer 구조 완성 (정의 → orchestration → workflow step). O3 채택: claude/commands/harness-meta.md --audit 분기 proposal-draft 직후 synthesizer fact 직접 검증 step + agents/project-harness-audit-team/CLAUDE.md D8 sequence 코드블록 직후 Note (v5.13) + ARCHITECTURE.md § 4 끝 cross-ref append. 1-phase Lightweight. v3.21 narrative 정전화 3 단계 패턴 15 번째 cycle 도그푸드 완성. 3 관점 검토 모두 pass_with_comments, blocking 없음. pre-commit 14 hook PASS, 회귀 0. commit 5d673ba (phase-1) + Stage G+H+I 통합 chore. 7 lessons (L1 WHAT/WHERE 분리 구조 정착 / L2 3-layer cross-ref 패턴 신규 / L3 v3.21 15 cycle / L4 append 위치 Read 선행 의무 / L5 O3 coverage 완전성 / L6 lightweight 46.7% 누적 / L7 exact_text diff 제시 → 사용자 판단 품질). next_candidates 6건 거명만 (ROADMAP 등재 zero). 2026-05-18.",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.13/milestones.md"
    },
    {
      "version": "v5.12",
      "id": "bundled-skill-narrative-cleanup",
      "title": "/review·/security-review·/init 'Skill tool 안 invoke 가능 built-in command' 분류 정확화 + v5.10 mapper hallucination cascade 정정 (audit chain hallucination cycle 3, scope 9 파일)",
      "status": "completed",
      "summary": "사용자 명시 발의 (A_user, 2026-05-18). v5.11 PROPOSE.next_candidates#4 carry-over. Stage E APPROVE 게이트 5 관점 (사용자 명시 요구) subagent 검토 안 spec-drift agent decisive issue 발견 ('bundled skill 별칭' = spec drift) → scope 재정의 + D2.exact_text 재작성 (7→9 파일 cascade). context7 5 source (glossary + skills + slash-commands + whats-new + changelog) 재검증 = Bundled skills (prompt-based playbook, /simplify·/batch·/debug·/loop·/claude-api) vs Built-in commands (fixed-logic). 일부 built-in (/init·/review·/security-review) = Skill tool 안 discover + execute 가능 (별 sub-classification, bundled skill 범주 아님). v5.10 mapper-output.md L100/L102/L105/L180/L198/L215 6 위치 + diff-vs-v1.17.md L87 = drift origin = audit chain hallucination cycle 3 도달 (cycle 1 v5.10 proposer / cycle 2 v5.11 scanner / cycle 3 본 v5.12 mapper). v5.11 PROPOSE#1 trigger 조건 충족 = Stage I PROPOSE.next_candidates#1 진급 (거명만, ROADMAP 등재 zero 사용자 결정). scope 9 파일 cascade hybrid 정정 (inline 4 + footnote 5). 4 관점 subagent 검토 verdict = architecture pass_with_comments / spec-drift fail with decisive issue 흡수 후 / 회귀 risk pass / scope contract pass. 1 phase 1+1 commit (phase-1 ed3ddbd + Stage G+H+I 통합 chore). v5.7 spec-drift spike 3 단계 + v3.21 narrative 정전화 3 단계 패턴 14 번째 cycle 도그푸드 완성. INTENT.success_criteria 11건 모두 PASS (9 PASS + 2 PASS_WITH_NOTE). pre-commit 14 hook 모두 PASS, 회귀 0. 7 lessons (L1 cycle 3 origin / L2 APPROVE 5 관점 검토 decisive issue 발견 / L3 informal 용어 ↔ spec 충돌 / L4 hybrid 정정 위치 패턴 / L5 [v5.12 정정] footnote audit trail 보존 / L6 drift origin vs cascade target 분기 / L7 context7 5 source 다중 인용). next_candidates 7건 거명만 (ROADMAP 등재 zero). 2026-05-18.",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.12/milestones.md"
    },
    {
      "version": "v5.11",
      "id": "audit-chain-fact-verification-discipline",
      "title": "audit chain 4 멤버 fact 인용 검증 의무 narrative 정전화 + v5.10/v1.17 audit 산출물 hallucination 정정 (memory feedback_subagent_fact_hallucination_correction 누적 2 cycle direct evidence)",
      "status": "completed",
      "summary": "사용자 명시 발의 (A_user, 2026-05-18). v5.10 PROPOSE.next_candidates#4 (`upbit-claude-md-repo-root-creation`) 사용자 명시 선택 후 Stage A OPEN 단계 결정적 이슈 round 안 upbit/CLAUDE.md 실존 발견 (v1.17 phase-3 commit a856ddc, 2026-05-14 cascade narrative 변경 시점부터 거주, 9430 bytes) → v5.10 audit-2026-05-18 chain (scanner → analyzer → mapper → proposer) 4 산출물 안 `claude_md_in_repo: false` (scanner L77) 시발 + 3 산출물 cascade 흡수 + v5.10 PROPOSE.md next_candidates#4 5 차 위치 인용 누적 stale 확인. memory feedback_subagent_fact_hallucination_correction 누적 2 cycle direct evidence 도달 (v5.10 L1 component-proposer 12 항목 hallucination origin + 본 v5.11 project-scanner hallucination 신규). 9 결정 (D1 ARCHITECTURE § 4 끝 단일 source / D2 exact_text + v3.21 3 단계 패턴 / D3 O1 archive with correction narrative / D4 1-phase Lightweight + 누적 11/28 / D5 (b) commit / D6 v1.17 부재 흡수 / D7 ROADMAP 정정 부재 / D8 PROPOSE#4 stale 표지 / D9 자기참조 도그푸드). 1 phase 1+1 commit (phase-1 a6fcf4e + Stage G+H+I 통합 chore). ARCHITECTURE.md § 4 끝 L137 'Audit chain fact 인용 검증 의무' paragraph 정전화 (v3.21 narrative 정전화 3 단계 패턴 13 번째 cycle 도그푸드 완성, v3.18 + v3.20 + v3.21 + v4.1 + v4.2 + v4.3 + v5.0 + v5.7 + v5.8 + v5.9 + v5.10 + 본 v5.11 = 12 누적 + 13 번째). audit-2026-05-18/ 4 산출물 안 14 위치 inline 정정 (O1 archive with correction narrative — audit trail 보존, v5.10 L1 proposer overwrite 와 비대칭 정합 = L6 lesson 신규 origin). v5.10 PROPOSE.md next_candidates#4 entry block _v5_11_correction 필드 추가 + stale 표지. v1.17 audit chain hallucination 부재 사실 진술 흡수 (D6, sc_5 PASS_WITH_NOTE — RESEARCH grep 결과 v1.17 RESEARCH.md L75 + REPORT.md L56 fact 정확 capture 검증). lightweight 모드 누적 11/28 = 39.3% 갱신. INTENT.success_criteria 8건 모두 VERIFY.criteria_check PASS (6 PASS + 2 PASS_WITH_NOTE). pre-commit 14 hook 모두 PASS, 회귀 0. 7 lessons (L1 5 차 위치 cascade 패턴 정량 / L2 feedback 작성 시점 ≠ 운용 시점 cycle 자연 발견 / L3 Stage A OPEN 안 fact 검증 scope rewrite 누적 2 cycle / L4 v3.21 3 단계 패턴 13 번째 cycle / L5 lightweight + 도그푸드 비대칭 정합 6 번째 / L6 agent 직접 산출 inline 정정 vs synthesizer 임시 산출 overwrite 비대칭 / L7 self-loop 비례 14 번째 사례). next_candidates 5건 거명만 (ROADMAP 등재 0건, lightweight default 동결 정합) — #1/#2 = v5.11 신규 origin (L1/L6) + #3/#4/#5 = v5.10 PROPOSE candidates carry-over. 2026-05-18.",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.11/milestones.md"
    },
    {
      "version": "v5.10",
      "id": "external-audit-team-second-call-with-diff",
      "title": "외부 audit-team 두 번째 실 호출 (upbit, proposer까지 read-only) + v1.17 산출물 diff 비교 + v5.8/v5.9 'audit-team 호출 0건' narrative drift 정정",
      "status": "completed",
      "summary": "사용자 명시 발의 (A_user, 2026-05-18). v5.9 PROPOSE.next_candidates#5 (`external-audit-team-first-call`) 사용자 선택 후 Stage A OPEN 단계 중 발견 = v1.17 upbit milestone (2026-05-14, commit 16722fd) 안 audit chain 5 멤버 sequence 완전 실행 + 12 항목 ACCEPT ALL apply 완료 사실 → 'first call' 전제 폐기 → 'second call + diff' 로 scope 재조정 (Option B 사용자 명시 결정). 9 결정 (D1 lightweight / D2 § 4 끝 / D3 2 phase / D4 projects/upbit/audit-2026-05-18/ v1.17 패턴 정합 / D5 2+1 commit / D6 D6 정확 문구 1차 source / D7 .markdownlintignore cascade / D8 4 멤버 순차 / D9 자기참조 자연) — Round 1 자체 의문 round 결정적 이슈 3건 식별 후 D3+D4+D5+D9 갱신. 2 phase 2 commit (phase-1 36d364b audit chain 4 멤버 호출 + 4 산출물 + .markdownlintignore cascade / phase-2 2bd6baa ARCHITECTURE § 4 끝 cascade drift paragraph 정전화 + diff-vs-v1.17.md + milestones.md). pre-commit 14 hook 모두 PASS, 회귀 0. INTENT.success_criteria 8건 모두 VERIFY.criteria_check PASS. ecosystem integrator 정체성 vector 운용 evidence 누적 정확 정량 = 2건 (v1.17 first + v5.10 second). cascade drift narrative 정전화 1 cycle 완료 — v5.8 origin (R2+L172 정정) → v5.9 cascade 누락 (PROPOSE#5 + INTENT.out_of_scope misclassification) → v5.10 second call 정정 (ARCHITECTURE § 4 끝 paragraph). v3.21 narrative 정전화 3 단계 12 번째 cycle 도그푸드 완성 (v5.7~v5.9 + 본 v5.10). proposer agent 1차 산출 hallucination 1건 (v1.17 12 항목 표 misnaming django/ai-ready-scorer 등 upbit 무관) → synthesizer overwrite 정정 (L1 lesson origin). lightweight 모드 누적 10/27 = 37%. 7 lessons (L1 proposer hallucination + synthesizer 정정 / L2 cascade drift 1 cycle 완성 / L3 v3.21 12 cycle / L4 audit 산출물 4 파일 분리 / L5 2 phase 분할 효과 / L6 lightweight 37% / L7 자체 의문 round 패턴). next_candidates 6건 거명만 (ROADMAP 등재 0건, e3 정책 정합 누적 9 번째 cycle). 2026-05-18.",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.10/milestones.md"
    },
    {
      "version": "v5.9",
      "id": "dictionary-semantics-integrated-audit",
      "title": "사전적 의미 vs 실 책임 3 축 (harness-meta name + 9-stage workflow + ROADMAP) 통합 부합도 audit + ARCHITECTURE § 4 끝 'ROADMAP 단어 drift 수용' paragraph 정전화 (lightweight 자기 검토 라운드 5 번째)",
      "status": "completed",
      "summary": "사용자 명시 발의 (A_user, 2026-05-17, /clear 후 '사전적 의미 vs 워크플로우 스테이지 부합 점검' 자유 질의 round 안 새 진단 milestone 명시 발의). 3 축 통합 audit — (A) harness-meta name (harness=마구/활용 + meta=상위/자기참조) vs v4.0 정체성 (composer/integrator/maintainer) = 선언 100% / 운용 77.5% (v5.8 baseline 유지) / (B) 9-stage 단어 vs 실 책임 = 86.1% baseline 유지 (v3.19 baseline, 단어 정의 + 책임 narrative 무변경) / (C) ROADMAP 단어 (Merriam-Webster '목표를 향한 진행을 안내하는 상세 계획' / Cambridge 'step-by-step visibility') vs 실 상태 (50 entry / completed 46 / deferred 3 / in_progress 1 / pending 0, completed-dominant 92% / forward-looking 0%) = ~30~40% 부합도. 진단 결과 = 축 A 정전화 완료 (v5.8 § 3.1 끝 paragraph) + 축 B 정전화 완료 (v3.20 § 4 끝 paragraph) + 축 C 정전화 부재 = 본 v5.9 신 발견. ARCHITECTURE.md § 4 끝 'ROADMAP 단어 drift 수용' paragraph 1건 정전화 (옵션 B, 사용자 명시 D1 Recommended). lightweight 모드 5 번째 cycle (v3.6/v3.17/v3.19/v5.8 누적) + 디테일 분석 round 4건 자체 흡수 (Round 1 cycle 카운트 5건 mechanical 수정 + Round 2 thin index 정확화 v1.1_meta-as-project + v2.0_workflow-word-fidelity cross-ref + Round 3+4 lessons 6건, lightweight 5 관점 subagent 생략 trade-off 보완) + v3.21 narrative 정전화 3 단계 패턴 11번째 cycle 도그푸드 (v3.18+v3.20+v3.21+v4.1+v4.2+v4.3+v5.0+v5.7+v5.8 = 10 누적 후 본 v5.9) + self-loop 13번째 사례 (92.86% = 13/14) + 1+1 commit 패턴 7번째 (v3.17+v3.18+v3.19+v3.20+v3.21+v5.8 누적). 2 commit (08b1719 phase-1 + Stage G+H+I 통합 chore). pre-commit 14 hook 2차 시도 PASS (1차 시도 schema 3 FAIL = RESEARCH.options+risks_identified / PROPOSE.next_candidates / phase-1.md status 필드 누락 → schema fix 후 PASS, L8 lesson 신규 origin). 회귀 0. INTENT.success_criteria 8건 모두 PASS. 7 lessons (L1 harness-meta 명명 어순 비자연 / L2 root cause v1.0 시점 단어 선택 / L3 pending status 대안 검토 부재 / L4 scope_rewrite 가능성 통합 frame 유지 / L5 drift 수용 narrative 행동 zero = 의도적 절충 / L6 디테일 분석 round = lightweight trade-off 보완 / L7 cycle 카운트 sequential 검증). next_candidates 5건 거명만 (ROADMAP 등재 0건, lightweight 모드 누적 9 cycle § 6.2 폐지 정신 정합).",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.9/milestones.md"
    },
    {
      "version": "v5.8",
      "id": "identity-application-vector-audit",
      "title": "v4.0 정체성 (composer/integrator/maintainer) ↔ 실 운용 vector drift 진단 + ARCHITECTURE narrative 정전화 (lightweight 자기 검토 라운드 4 번째)",
      "status": "completed",
      "summary": "사용자 발의 (A_user, 2026-05-17) — /clear 후 round 안 'harness-meta 존재 목적 ↔ meta repo 일치도' 자유 질의 진행 결과 부합도 진단 → 사용자 명시 '진단 milestone 발의' 결정. round 2 사용자 '디테일 분석' 요청 → RESEARCH 보강 § A1~A9 9 sub-section 추가 (~150 line) → 진단 5건 정정 (외부 vector 0 → 1 evidence 강력 / 부합도 60 → 77.5% sub-metric 가중 평균 / attractor 본질 v5.0 Plugin pivot 자기 강화 cascade 3축 / 가드레일 진화 trend strong → weak → medium / reverse evidence 6건 누적). round 4 사용자 'D2 전면 재작성' 결정 → cascade (D2/D7/ARCHITECTURE/APPROVE/phase-1) 동기 갱신. ARCHITECTURE.md § 3.1 끝 정체성 paragraph 직후 'vector drift 수용' bold lead paragraph 1건 (~15 line) 정전화 — 12 meta milestone sub-classification 정량 + audit-team chain 5 멤버 완전 작동 evidence (v1.17, 12 항목 mechanical apply) + composer 50%/integrator 60%/maintainer 70% sub-metric + Plugin pivot 자기 강화 cascade + 가드레일 진화 trend + cycle 4 trigger 조건 + reverse evidence + RESEARCH 보강 § A1~A9 cross-ref. 자기 검토 라운드 lightweight 모드 4 번째 (v3.6 / v3.17 / v3.19 선례) + v3.21 narrative 정전화 3 단계 패턴 10 번째 cycle 완성. 1-phase 1+1 commit (phase-1 f4fef24 + Stage G+H+I 통합 chore). 산출 LOC 517 (cap 1500 = 34.5% 활용). pre-commit 14 hook 3차 PASS (1차 INTENT id/title 누락 + 2차 markdownlint MD032 FAIL → 3차 PASS, L1+L2 lesson 흡수). INTENT.success_criteria 7건 모두 PASS (sc_6 PASS_WITH_NOTE). 회귀 0. 7 lessons (L1~L7). next_candidates 4건 거명만 (ROADMAP 등재 0건, e3 정책 8 번째 사례). self-loop 5중 mitigation 적용 후 9 → 10 번째 재현 인지 명시 (v4.0 § 6.2 폐지 후 가드레일 narrative 흡수 medium 정합). 2026-05-17.",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.8/milestones.md"
    },
    {
      "version": "v5.7",
      "id": "spec-drift-spike-pattern-canonicalization",
      "title": "spec-drift spike 패턴 정전화 — context7 spec 추정 + Stage F EXECUTE 실 spike + DESIGN.decisions hardcode 3 단계 narrative (v5.6 PROPOSE#4 carry-over, 조기 발의 A_user 재분류)",
      "status": "completed",
      "summary": "v5.6 PROPOSE.next_candidates#4 carry-over (origin 누적 2건 — v4.2 context7 standard pattern 정정 + v5.6 D10 enabled key spike). 사용자 명시 선택 = A_user trigger 재분류 (원래 trigger '세 번째 사례 누적 시 C_improvement' 조기 발의). v4.2 + v5.6 두 origin 사례 자연 발현 spec-drift spike 패턴 (RESEARCH 추정 → DESIGN spec-drift 식별 → Stage F EXECUTE 안 실 spike 또는 DESIGN 안 즉시 정정 → DESIGN.decisions hardcode 4 단계) 을 ARCHITECTURE.md § 6 본문 안 § 6.2 폐지 narrative paragraph 직후 + § 7 직전 위치에 bold lead paragraph 1건 정전화 (Option A 단일 source, 사용자 명시 결정 D1). 정정 시점 분기 narrative (DESIGN 즉시 vs Stage F spike) + ecosystem integrator 정체성 (§ 3.1 끝 paragraph) 직접 부합 cross-ref. v3.21 narrative 정전화 3 단계 패턴 (DESIGN.D2.exact_text 1차 source + Stage F EXECUTE Edit 정확 삽입 + VERIFY grep 3 키워드) 9 번째 cycle 도그푸드 완성 (v3.18 + v3.20 + v3.21 + v4.1 + v4.2 + v4.3 + v5.0 + 본 v5.7). Lightweight 모드 (5 관점 subagent 생략, 사용자 명시 결정 D5) + 1-phase 1+1 commit (phase-1 da94db7 + Stage G chore). 7 success_criteria 모두 PASS (sc_6 PASS_WITH_NOTE 포함). pre-commit 14 hook 모두 PASS (1차 시도 APPROVE.md approval 필드 누락 FAIL → schema 정정 후 PASS, L1 lesson). 회귀 0. 7 lessons (L1~L7). next_candidates 3건 carry-over 거명만 (ROADMAP 등재 0건, e3 정책 7 번째 사례) — v5.7 신규 origin (L1/L2/L6/L7) 모두 workflow narrative 자체 강화 본질로 ecosystem integrator 정체성 자연 부합 안 함, forward 거명 부재. 2026-05-16.",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.7/milestones.md"
    },
    {
      "version": "v5.6",
      "id": "environment-auditor-runtime-check-automation",
      "title": "environment-auditor G 섹션 (Runtime-only manual checklist) 자동화 확대 + Plugin activation 상태 포함 (v5.5 PROPOSE#2 carry-over, L1 origin)",
      "status": "completed",
      "summary": "v5.5 PROPOSE next_candidates#2 사용자 명시 선택 (A_user). environment-auditor Stage B 5 sub-step 확장 (B0/BP1/BP2 + BP3 activation + BP4 G AUTO 통합) + § G 5 항목 책임 표기 추가 (AUTO 부분 BP4 흡수 + MANUAL 부분 G 잔존) + § Bash 화이트리스트 § claude CLI 추가 (read-only side-effect-free). audit 책임 분리 원칙 정전화 (binary 상태 검증 = AUTO / 실 효과 검증 = audit 외, L1). D10 spike 검증 (enabled boolean key 정확) hardcode 채택 (L2). cascade drift 1건 (bootstrap/agents/CLAUDE.md L110 v5.5 누락) 본 milestone scope 안 흡수 (L3). 10 stage 매트릭스 보존 (D1 O1 채택). 4 관점 검토 (architecture/spec-drift/scope contract/보안) PASS_WITH_COMMENTS + PASS, 4 권고 흡수 (D11 /reload-plugins + JSON hardcode + ANSI 무해화 + architecture monitor). 1-phase 1+1 commit (phase-1 b87014a + Stage G chore). pre-commit 14 hook PASS, 회귀 0. 7 lessons. next_candidates 4건 거명만 (e3 정책 정합 6 번째). 2026-05-14.",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.6/milestones.md"
    },
    {
      "version": "v5.5",
      "id": "v4x-deprecation-narrative-cleanup",
      "title": "environment-auditor Stage B Plugin 전용 교체 + A1 (Developer Mode) 삭제 + SKILL.md install-skills 제거 (v5.0 PROPOSE#4 carry-over)",
      "status": "completed",
      "summary": "v5.0 Plugin install 전환 후 environment-auditor Stage B (Symlink/Junction 무결성 B1~B6) + A1 (Developer Mode 체크) 가 현행 환경과 불일치 — false-negative audit 문제. Stage B 를 Plugin cache 기반 검증 (B0/BP1/BP2) 으로 완전 교체, A1 삭제. skills/harness-roadmap-update/SKILL.md 보안 표 install-skills 행 삭제. CHANGELOG [v5.5]. 1-phase 3 commit (9056b0b phase-1 + 1d8056c Stage B-I + 0f51065 § 6.2 stale ref fix). 5 lessons (L5 § 6.2 polished drift v5.4 동종 패턴). 2026-05-14.",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.5/milestones.md"
    },
    {
      "version": "v5.2",
      "id": "agent-functional-path-cleanup",
      "title": "agents/environment-auditor.md + agents/harness-gap-analyzer.md 내부 functional audit path 갱신 — v5.1 Phase 1+2 (agent + skills move) 결과 stale path 해소",
      "status": "completed",
      "summary": "v5.1 PROPOSE#1 carry-over (B_regression). v5.1 Phase 1+2 git mv 후 잔존 functional audit path stale 5건 완전 해소. Option B (INTENT 사전 식별 2건 + RESEARCH 발견 3건 통합) + Lightweight 모드 + 1-phase 1 commit (c4edde7). 갱신 4 unique files: environment-auditor.md (path 3→2건) + harness-gap-analyzer.md (path 2→1건) + component-installer.md (신규 위치 + plugin.json skills 필드) + bootstrap/claude-code-catalog/README.md (agents/ 갱신) + CHANGELOG [v5.2]. sc_1~sc_7 모두 PASS, pre-commit 14 hook PASS, 회귀 0. 3 lessons. 2026-05-14.",
      "trigger": "B_regression",
      "milestones_path": "milestones/v5.2/milestones.md"
    },
    {
      "version": "v5.3",
      "id": "external-marketplace-registration",
      "title": "외부 marketplace 등록 — claude plugin marketplace add pdw96/harness-meta 표준 명령 추가 (GitHub source onboarding)",
      "status": "completed",
      "summary": "v5.0 PROPOSE#5 + v5.1 PROPOSE#2 carry-over. GitHub shorthand (`pdw96/harness-meta`) = full repo clone → `./'` relative path 정상 작동 (context7 spec 확인). marketplace.json 무변경. 7 파일 cascade (README/AGENTS/CLAUDE.md/component-installer/bootstrap/agents/CLAUDE.md/ARCHITECTURE.md/Makefile) + CHANGELOG [v5.3]. 1 phase 1 commit (3484319). pre-commit 14 hook PASS. 4 lessons. 2026-05-14.",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.3/milestones.md"
    },
    {
      "version": "v5.4",
      "id": "marketplace-json-github-source",
      "title": "marketplace.json source 필드 → GitHub source 객체 명시 전환 (optional 품질 개선)",
      "status": "completed",
      "summary": "v5.3 optional candidate #1 완료. context7 spec 재검증: Git repository marketplace(GitHub shorthand + local clone)에서 './' = spec-correct. GitHub source 객체는 URL-based marketplace 전용 — 전환 기각. 사용자 review 중 § 6.2 cross-ref 잔존 (v4.0 cleanup 누락 drift) 발견 → scope 확장 active 3 위치 (PROPOSE.md / ARCHITECTURE.md L129 / tests/CLAUDE.md L9+L294) 즉시 fix. CHANGELOG [v5.4] + milestone 산출물이 정전 근거. 1 phase 3 commit (962c064 + 9bd6065 + drift-fix). pre-commit 14 hook PASS. 5 lessons. 2026-05-14.",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.4/milestones.md"
    },
    {
      "version": "v5.1",
      "id": "plugin-component-discovery-fix",
      "title": "Plugin paths nested 인식 spec drift fix — Agents (0) + Skills (1 of 5) 인식 부족 해소 (v5.0 R1 mitigation 직접 후속)",
      "status": "completed",
      "milestones_path": "milestones/v5.1/milestones.md",
      "summary": "v5.0 VERIFY R1 drift (claude plugin details Agents 0 / Skills 1 of 5) 를 3 phase 로 완전 해소. Phase 1: 7 agents git mv (bootstrap/agents/audit/ → agents/ flat, plugin_root standard, plugin.json agents 필드 제거). Phase 2: 5 skills git mv (bootstrap/skills/{audit,dev-tools}/ → skills/ flat). Phase 3: cascade narrative 9 host 갱신 + CHANGELOG [v5.1]. 결과 = claude plugin details Agents (7) + Skills (6 = 5 skill + 1 command) + Hooks (2) 완전 인식. pre-commit 14 hook 3 commit 모두 PASS. VERIFY regressions 2건 발견 (agents/environment-auditor.md + agents/harness-gap-analyzer.md 내부 functional audit path stale) → v5.2 후보 등재. 사용자 명시 발의 (A_user, v5.0 PROPOSE next_candidates#1 선택, 2026-05-14).",
      "trigger": "A_user"
    },
    {
      "version": "v5.0",
      "id": "plugin-pivot",
      "title": "Install 정책 전면 재설계 — harness-meta 를 Claude Code Plugin 으로 변환 (breaking major bump, ecosystem integrator 정체성 강화)",
      "status": "completed",
      "milestones_path": "milestones/v5.0/milestones.md",
      "summary": "v4.3_subagent-discovery-path-research RESEARCH 결과 직접 후속. harness-meta repo 자체를 Claude Code Plugin 으로 변환 (두 번째 major bump v4→v5). `.claude-plugin/plugin.json` (manifest, paths 명시 = agents 7 멤버 개별 + commands 디렉토리 + hooks hooks.json + skills add-to-default) + `.claude-plugin/marketplace.json` (local marketplace, source='./'+description) + `claude/hooks/hooks.json` (Plugin schema PostToolUse Write|Edit + SessionStart matcher, wrapper 객체) 3건 신규. 사용자 onboarding flow 표준 CLI 채택 — `claude plugin marketplace add ~/harness-meta` + `claude plugin install harness-meta@harness-meta` (자연어 'harness-meta 설치해줘' + v4.1 D7 sequence deprecated since v5.0, v5.0+ 환경에서는 비활성). 14 host cascade narrative 정전화 (README/AGENTS/root CLAUDE.md + claude/CLAUDE.md + bootstrap/agents/CLAUDE.md + bootstrap/skills/CLAUDE.md + ARCHITECTURE.md + tests/CLAUDE.md + Makefile + .env.example + claude/commands/harness-meta.md + GUARDRAILS.md + bootstrap/claude-code-catalog/README.md + project-harness-audit-team CLAUDE.md + component-installer.md) — 51 occurrence 분포 (v3.21 narrative 정전화 3 단계 패턴 8 번째 cycle 완성). component-installer agent 책임 분리 (custom component lifecycle 보존 + Plugin install lifecycle Claude Code CLI 위임). CHANGELOG [v5.0]! breaking entry + bootstrap/claude-code-catalog/README.md.bak cleanup. 5 관점 검토 (architecture / spec-drift / 회귀 risk / 보안 / scope contract) 전체 PASS / PASS_WITH_COMMENTS + 7 권고 흡수 (D6 commands precedent + hooks.json minimum schema + D10 책임 분리 구체화 + D3 PowerShell 동치 + D9 dual-active 검출 step 5 + D2 'v5.0+ 환경에서는 비활성' 명시). 13 결정 (D1~D13) — 사용자 round 1 4 question Recommended 채택 (v4.0~v4.3 패턴 누적 5 번째). 3 phase 4 commits (phase-1 5505010 + phase-2 e7ec60f + phase-3 251063e). VERIFY verdict = PASS_WITH_PARTIAL_DRIFT (8 PASS + 2 PASS_WITH_PARTIAL_DRIFT Agents 0 + Skills 1 of 5 인식 부족 R1 drift + 1 PENDING_AT_PROPOSE). 핵심 fix 3건 (marketplace.json source='./'+description + plugin.json agents 7 .md 개별 명시 + hooks.json wrapper 객체) 모두 Stage G 실 검증 시점 즉시 보정 (R1 mitigation 'Stage G VERIFY 실 검증 mandatory' 정합). 8 lessons (L1 spec-drift 검증 패턴 / L2 context7 + 실 install 2 단계 / L3 5 관점 7 권고 / L4 v3.21 8 cycle / L5 v4.0~v5.0 3 단계 cycle / L6 round 1 Recommended 패턴 / L7 paths nested 인식 drift / L8 markdownlint MD032 재 commit). next_candidates 5건 narrative 거명만 (ROADMAP 등재 0건, e3 정책 정합 v4.0~v4.3 패턴 누적). 2026-05-14.",
      "trigger": "A_user"
    },
    {
      "version": "v4.3",
      "id": "subagent-discovery-path-research",
      "title": "Claude Code subagent discovery 메커니즘 RESEARCH — install (~/.claude/agents/ 매핑) 외 경로 (Plugin spec / settings path 등) 발견 + 후속 milestone 발의 narrative",
      "status": "completed",
      "milestones_path": "milestones/v4.3/milestones.md",
      "summary": "사용자 의문 round 3회 raise (Developer Mode 의존 / install 자체 의문 / install 외 경로 탐색) 안 scope rewrite (v4.1 패턴 두 번째 사례). 원래 scope (subagent-runtime-validation = v4.2 PROPOSE #2 + #4 bundle) 는 install 본질 의문 raise 후 보류. 새 scope = install (~/.claude/agents/ 매핑) 외 Claude Code subagent discovery 메커니즘 RESEARCH milestone. context7 4 source 검증 (sub-agents docs / plugins-reference / plugin-marketplaces / settings docs) 결과 = Claude Code Plugin spec 안 plugin marketplace local source 지원 (`claude plugin marketplace add ./harness-meta`) + plugin 안 agents/ 자동 인식 + paths 명시 (plugin.json) = install 회피 경로 단일 발견. DESIGN 7 결정 (D1~D7) — P4 채택 + v5.0_plugin-pivot pending 등재 + 1-phase Lightweight + narrative 2 host 정전화 (ARCHITECTURE.md § 3.1 끝 'Install 정책 본질 + Plugin spec 대안' paragraph + bootstrap/agents/CLAUDE.md § D7 끝 '.md 파일 영역 SymbolicLink default 정정' sub-paragraph) + 3 관점 자기 검토 (lightweight 모드 자유) + forward propose 명령형 회피 + VERIFY grep 키워드 3건. APPROVE 게이트 (Round 5 명시 승인) + Stage F EXECUTE 1-phase Lightweight 진행 — narrative 2 host 정전화 + ROADMAP v5.0_plugin-pivot pending entry 등재. VERIFY verdict = pass + 회귀 risk 0 + criteria_check 6건 PASS + 1건 PENDING_AT_COMMIT (pre-commit 14 hook Stage G+H+I 통합 commit). v3.21 narrative 정전화 3 단계 패턴 7 번째 cycle 누적 (v3.18 + v3.20 + v3.21 + v4.1 + v4.2 + v4.3). lightweight 모드 10/22 = 45.5% 누적. 7 lessons (L1 scope rewrite 패턴 두 번째 / L2 사용자 의문 round 3 depth-first 패턴 / L3 context7 4 source Plugin spec 발견 / L4 v4.1 narrative drift 진단 / L5 lightweight 모드 45.5% / L6 narrative 정전화 3 단계 7 cycle / L7 v4.0→v4.3→v5.0 3 단계 cycle). next_candidates 5건 narrative 거명만 (ROADMAP 등재 0건, 단 v5.0_plugin-pivot pending entry 1건 별도 등재). 2026-05-14.",
      "trigger": "A_user",
      "scope_rewritten_from": "v4.3_subagent-runtime-validation (v4.2 PROPOSE.next_candidates #2 + #4 bundle, Stage B INTENT 작성 완료 + Stage C RESEARCH 작성 완료 + Stage D DESIGN 진입 직후 사용자 의문 round 3회 raise → scope rewrite 결정. audit trail = 본 entry summary + INTENT.scope rewrite narrative + REPORT.lessons_learned L1)"
    },
    {
      "version": "v4.2",
      "id": "verify-infra-agent-absorption",
      "title": "verify/sync infrastructure agent 흡수 — 6 script (verify.{ps1,sh} + verify-lib.{ps1,sh} + sync-agents.{ps1,sh}) 폐기 + 2 신규 standalone subagent (environment-auditor + agents-md-sync) 흡수 + cascade 5 host narrative cleanup",
      "status": "completed",
      "milestones_path": "milestones/v4.2/milestones.md",
      "summary": "사용자 명시 발의 (A_user, 2026-05-13 v4.1 종료 후 round 안 'verify/sync 도 폐기 신규 milestone 발의' 명시 선택). v4.0 phase-3 안 폐기된 install script 3개 (install.ps1 + install-skills.{ps1,sh}) 외 잔존 — verify/sync 6 script (~1750 LOC) 도 'mechanical' 본질을 공유. v4.0 정체성 (project harness composer + agent fleet maintainer + 'mechanical install/update/cleanup agent 흡수') 정합 확장. 사용자 명시 결정 4건 (Stage D entry): P2 옵션 (verify → environment-auditor read-only audit / sync-agents → agents-md-sync write drift sync / verify-lib 자연 폐기) + standalone .md 파일 거주 (spec-drift context7 standard pattern 정합) + inactive smokes git rm + Makefile stub message. 4 관점 병렬 검토 (architecture / spec-drift+context7 / 회귀 risk / scope contract) 모두 pass-with-comments + 의견 충돌 0 + 13 권고 흡수 (spec-drift critical drift 정정 — RESEARCH 디렉토리+AGENT.md 추정 → 단일 .md 파일). 13 결정 (D1~D13) — P2 옵션 / standalone .md / 3 phase 분할 (agent 신규 → script 폐기 → cascade) / 14 host cascade scope / Bash 화이트리스트 (R2 mitigation) / agents-md-sync default -Check + write 게이트 (D9 e3 정책 정합) / ARCHITECTURE.md § 3.1 끝 narrative 정전화 (v3.21 3 단계 패턴 6 cycle 누적 완성). 3 phase 3 commits — phase-1 (0a9e6db, agent fleet 신규 +352 LOC) + phase-2 (f90c56b, 6 script + 2 inactive smokes git rm + Makefile stub net -1930 LOC) + phase-3 (41f94ad, cascade 5 host edit +81 LOC). net -1496 LOC. VERIFY verdict pass + 회귀 0 + criteria_check 7건 모두 PASS + pre-commit 14 hook 3 commit 모두 PASS (phase-1 첫 commit 시 smoke-cross-ref FAIL → --fix 자동 정리 + re-commit PASS, broken ref = 미작성 REPORT.md 사전 거명, L1 lesson). bootstrap/agents/CLAUDE.md 매트릭스 audit/ row 2 추가 + 헤더 'Team / Standalone Subagent' + 트리 standalone narrative + § Audit/Sync 책임 신규 sub-section (standalone vs team 책임 경계 narrative). ARCHITECTURE.md § 3.1 끝 신규 paragraph 'mechanical 본질 vs Claude Code spec 의무 컴포넌트 분리' 정전화 — spec 의무 컴포넌트 (claude/hooks/{session-init.sh, post-report-write.sh} + claude/statusline/statusline.sh) agent 흡수 불가능 narrative. 8 lessons (L1 broken ref / L2 spec-drift drift 정정 / L3 v3.21 6 cycle 완성 / L4 3 phase default / L5 Bash 화이트리스트 / L6 default -Check + 게이트 / L7 context7 standard pattern / L8 Makefile stub 패턴). next_candidates 6건 모두 narrative 거명만 (ROADMAP 등재 0건, e3 정책 정합 v4.0/v4.1 패턴 누적).",
      "trigger": "A_user"
    },
    {
      "version": "v4.1",
      "id": "install-strategy-reaudit",
      "title": "Install 전략 자체 재검토 — Option D 채택 (Junction Windows + Symlink Linux/macOS) + D7 5 step rewrite + cascade narrative 12 host + install.ps1 stale 9건 cleanup",
      "status": "completed",
      "milestones_path": "milestones/v4.1/milestones.md",
      "summary": "사용자 명시 발의 (A_user, /harness-meta 진입 round v4.1 scope rewrite 결정 후 'Install 전략 자체 재검토' 명시 선택, 본 v4.1 scope rewrite 첫 사례). 이전 v4.1_dev-tools-bootstrap (v4.0 PROPOSE #1+#2 bundle, OPEN~DESIGN 4 stage 완료) 가 APPROVE 게이트 직전 사용자 의문 ('dev-tools 를 써야하는 이유' + 본질 'Developer Mode 켜야 하는 이유') raise 후 폐기 결정 (commit 부재 상태 산출물 삭제). v4.1 scope rewrite — Windows Developer Mode 강제 chain 본질 = 'symlink 채택 자체가 정합한가' + onboarding 마찰 vs drift 회피 trade-off. Option D 사용자 명시 결정 (Junction Windows default + Symlink Linux/macOS) — PowerShell 7.6 docs `Junction` ItemType elevation note 부재 (standard user 권한 PASS, spec-drift context7 검증). D7 mechanical sequence 4 step → 5 step rewrite (Backup → OS detect 신규 → Primary attempt by OS [Windows junction / Linux/macOS symlink] → Copy fallback → Cleanup retention, NTFS same-volume 강제 narrative + ad-hoc 검증 권고). cascade narrative 12 host 정합 (README + AGENTS + root CLAUDE.md + claude/CLAUDE.md + claude/commands/harness-meta.md + GUARDRAILS + bootstrap/agents/CLAUDE.md [phase-1 단일 source] + bootstrap/skills/CLAUDE.md [cross-ref 보존] + ARCHITECTURE.md [D9 정합 보존] + Makefile + .env.example + verify-lib.ps1 + verify.ps1 + verify.sh). stale install.ps1 거명 9건 cleanup (RESEARCH 외 잠재 발견 — Makefile install target / .env.example Referenced by / verify-lib.ps1 header / verify.ps1 L283/L578/L587 narrative / verify.sh L289/L543/L550 narrative). verify A1 check info-level 격하 (Junction default 시 Developer Mode 불요, Check-Info 함수 신규). 4 관점 검토 (architecture / spec-drift / 회귀 risk / scope contract) 모두 pass-with-comments + 의견 충돌 0 + 10 decisions (D1~D10) + 7 risk mitigation (R1~R7). 2 phase / 2 commit (phase-1 320fac9 mechanical + phase-2 6f23506 cascade). INTENT.success_criteria 8건 모두 PASS (7 PASS + 1 PASS_WITH_NOTE 실 cross-platform 검증 사용자 환경 의존). pre-commit 14 hook 모두 PASS, 회귀 0. v3.21 narrative 정전화 3 단계 패턴 4번째 cycle 누적 (v3.18 + v3.20 + v3.21 + v4.1). 8 lessons (L1 APPROVE 게이트 안 scope rewrite 첫 사례 / L2 install 전략 의문 본질 = onboarding 게이트 / L3 4 관점 pass-with-comments 패턴 / L4 RESEARCH grep inventory 부족 → 추가 9건 발견 / L5 v3.21 3 단계 패턴 4번째 cycle / L6 markdownlint MD032 함정 정합 / L7 도그푸드 모순 narrative / L8 Option D trade-off 우위). PROPOSE 5 candidates 모두 narrative 거명만 (ROADMAP 등재 0건, § 6.2 + e3 정책 정합).",
      "trigger": "A_user",
      "scope_rewritten_from": "v4.1_dev-tools-bootstrap (v4.0 PROPOSE #1+#2 bundle, OPEN~DESIGN 4 stage 완료 후 APPROVE 게이트 사용자 의문 raise → 폐기 결정, commit 부재 상태 산출물 삭제. audit trail = 본 entry summary + REPORT.lessons_learned L1)"
    },
    {
      "version": "v4.0",
      "id": "harness-composer-pivot",
      "title": "정체성 전면 재설계 — project harness composer + Claude Code ecosystem integrator + agent fleet maintainer (B2 scope, 8 phase, breaking major bump v3→v4)",
      "status": "completed",
      "milestones_path": "milestones/v4.0/milestones.md",
      "summary": "사용자 명시 발의 (A_user, 2026-05-13 /clear 직후) — '의미 상실' 진단 + 새 정체성 명시 라운드 9회. v3.17~v3.21 자기참조 cycle + upbit v1.16 이후 정체 진단. 9 결정 (B2 / 옵션 3 team / b1 / c1 / d2 / e3 + 매트릭스 / B3 install 폐기 / 5 멤버 / 옵션 B 책임 재분담). 8 phase 10 commits net -1148 LOC: phase-1 (af8b884) identity 5 host + § 6.2 폐지 + 3 host install narrative cleanup (옵션 B 통합) / phase-2 (7107729) 메타 v1.0~v3.21 _archive/ git mv 40 디렉토리 + smoke regex (_archive/ optional) + ROADMAP era 표지 / phase-3 (e6bacc2 + a2c967c + 0e93bcc) bootstrap/agents/ scaffold + CLAUDE.md (두 층 + conflict 4 case + fleet 5 case + D7 sequence) + install script 3개 폐기 -1484 LOC / phase-4 (0c0d060) bootstrap/claude-code-catalog/README.md (docs + built-in + plugin/MCP 통합) / phase-5 (acb6f22) 첫 agent team project-harness-audit-team 5 멤버 (scanner/analyzer/mapper/proposer/installer) + orchestration / phase-6 (d4e034c) /harness-meta --audit opt-in (Stage A conditional) / phase-7 (abbbee0) 벤치마크 cycle routine + candidate_draft[] D4 / phase-8 (523c959) CHANGELOG [v4.0]! breaking + 도그푸드 narrative. VERIFY PASS_WITH_NOTE (14 PASS + 2 PASS_WITH_NOTE sc_14 .harness.toml N/A + sc_15 도그푸드 manual reasoning), FAIL 0, 회귀 0, pre-commit 14 hook 모두 PASS. 도그푸드 manual reasoning (D6) 결과 = proposal 3건 모두 v4.1+ 후속 candidate 만 거명 (in-loop 회피). 8 lessons (L1 옵션 B 책임 재분담 / L2 B3 agent 흡수 / L3 smoke archive regex / L4 pivot 표지 / L5 9 round 누적 / L6 도그푸드 manual / L7 2 commit 분할 / L8 model 차별). PROPOSE 5 candidates 모두 narrative 거명만 (ROADMAP 등재 0건, e3 정책 정합).",
      "trigger": "A_user"
    },
    {
      "version": "v3.21",
      "id": "narrative-canonicalization-3step-pattern",
      "title": "narrative 정전화 3단계 패턴 명문화 — DESIGN 정확 문구 1차 source + EXECUTE Edit 그대로 삽입 + VERIFY grep 검증 (v3.20 L4 후속)",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.21/milestones.md",
      "summary": "v3.20_drift-narrative-canonicalization L4 lesson + PROPOSE.next_candidates#2 직접 후속 (A_user trigger, /harness-meta meta 자유 발의 round 안 'narrative 정전화 3단계 패턴 명문화' 명시 선택). v3.18 + v3.20 두 narrative 정전화 milestone 안 자연 발현한 3 단계 정합 패턴 — (a) DESIGN 안 정확 문구 1차 source (markdown code block) / (b) phase-1 EXECUTE 안 Edit tool 정확 문구 그대로 삽입 / (c) VERIFY 안 grep 검증 키워드 (정확 문구 안 cohesive 키워드 직접 추출) — 을 ARCHITECTURE.md § 6.2 Lightweight 모드 안 'Workflow self-improvement 동결 정책' paragraph 직후 + '선례' subsection 직전 'Narrative 정전화 3단계 패턴' bold lead paragraph 1건 정전화 (+2 line). 사용자 명시 선택 host 위치 (AskUserQuestion D1 Option 3 § 6.2 Recommended). 단일 source 전략 (D3) — 다른 host (CLAUDE.md / 모듈 / harness-meta.md / CHANGELOG / AGENTS / README / GUARDRAILS) cross-ref 추가 zero. Lightweight 모드 (§ 6.2 trigger 3건 충족, 누적 9/21 = 42.9% — v3.20 40% 첫 돌파 후 추가 cycle 갱신) — 5 관점 subagent 생략 + 산출물 LOC 521 line (cap 1500 권고 약 34.7% 활용, v3.17~v3.21 5 cycle 평균 ~499 line). 1-phase 1+1 commit 도그푸드 (v3.18/v3.19/v3.20 패턴 정확 정합). 본 milestone 자체가 3단계 패턴 자기 적용 도그푸드 = 자기참조 cycle 3번째 (v3.18 + v3.20 + v3.21) 완성. INTENT.success_criteria 8건 모두 VERIFY.criteria_check PASS, pre-commit 14 hook 모두 PASS, 회귀 0. 6 lessons (L1~L6) — L1 자기참조 cycle 3번째 완성 / L2 phase-1.md JSON schema 'phase' 필드 누락 발견 (smoke FAIL → Edit 보완) / L3 lightweight 누적 9/21 갱신 / L4 DESIGN sub-header markdown code block 패턴 3 cycle 누적 정전화 / L5 commit timing (a) 5 cycle 누적 strong evidence / L6 AskUserQuestion preview field 2 cycle 누적. next_candidates 4건 거명만 (ROADMAP 등재 0건, § 6.2 default 동결 정합) — #1 lightweight-1phase-commit-timing-a-canonicalization (5 cycle 충족 + v3.20 #1 carry-over) + #2 diagnose-then-canonicalize-pattern (v3.20 #2 carry-over, v3.21 부분 흡수) + #3 propose-register-책임-separation (v3.20 #3 + v3.19 #2 carry-over) + #4 phase-1-md-schema-canonicalization (v3.21 L2 신규 origin). 2 commit (03c1830 phase-1 + Stage G chore). 2026-05-14.",
      "trigger": "A_user"
    },
    {
      "version": "v3.20",
      "id": "drift-narrative-canonicalization",
      "title": "word-fidelity drift 수용 narrative 정전화 — ARCHITECTURE.md 안 86.1% 부합도 + PROPOSE 70% drift 의도성 paragraph 추가",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.20/milestones.md",
      "summary": "v3.19_word-fidelity-audit-v2 PROPOSE.next_candidates#1 직접 후속 (A_user trigger, 사용자 명시 발의 'v3.19 L1 후속: drift-narrative-canonicalization'). v3.19 진단 결과 (9-stage 부합도 평균 86.1% / APPROVE 100% / VERIFY 95% / REPORT 90% / OPEN 90% / EXECUTE 85% / RESEARCH 85% / INTENT 80% / DESIGN 80% / PROPOSE 70%) 의 ARCHITECTURE.md 안 narrative 정전화 → 'Word-fidelity drift 수용' bold lead paragraph 1건 § 4 끝 (line 117 B/C/D 부산물 흡수 paragraph 직후, § 4.1 Bundling 헤더 직전) 신규. drift 의도성 (pragmatic 절충, 100% 부합 추구 시 workflow 비대화 risk) + 정량 cross-ref 3건 + § 6.2 동결 정책 cross-ref + v3.19 RESEARCH 1차 source link 포함. lightweight 모드 (§ 6.2 자기참조 회피 표지, 누적 8/20 = 40% 첫 돌파) — 5 관점 subagent 생략 + 산출물 LOC ~503 (cap 1500 권고 33.5% 활용, v3.17~v3.20 평균 ~493 정합). 1-phase 1+1 commit 도그푸드 (v3.18/v3.19 패턴 정확 정합). 워크플로우 본문 변경 zero / smoke 추가 zero / 다른 host cross-ref 추가 zero (v3.18 D1 단일 source 패턴 정확 정합). INTENT.success_criteria 7건 모두 VERIFY.criteria_check PASS (1 PASS_WITH_NOTE — commit timing DESIGN D6 (b) narrative vs 실 운용 (a) 차이 L1 흡수). pre-commit 14 hook 모두 PASS, 회귀 0. 6 lessons (L1~L6) — L1 commit timing (a) default 누적 4 cycle evidence / L2 진단→정전화 2 cycle 패턴 / L3 lightweight 누적 40% 첫 돌파 / L4 narrative 정전화 3 단계 패턴 (DESIGN 1차 source + EXECUTE 정확 삽입 + VERIFY grep) / L5 AskUserQuestion preview field 첫 사용 / L6 LOC ~500 line 자연 default. next_candidates 4건 거명만 (ROADMAP 등재 0건, § 6.2 default 동결 정합) — #1/#2 v3.20 lessons 신규 origin + #3/#4 v3.19 carry-over. v3.18 패턴 두 번째 적용 (v3.17 진단 → v3.18 정전화 cycle 의 v3.19 진단 → v3.20 정전화 cycle). 2 commit (b929cd8 phase-1 + Stage G chore). 2026-05-13.",
      "trigger": "A_user"
    },
    {
      "version": "v3.19",
      "id": "word-fidelity-audit-v2",
      "title": "9-stage 단어-책임 부합도 정량 audit v2 — v2.0 word-fidelity 후속 정량 진단 + ROADMAP/PROPOSE root cause 진단",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.19/milestones.md",
      "summary": "사용자 발의 (A_user) — /harness-meta meta 자유 발의 round 안 워크플로우 자기 검토 결과 milestone 발의. (1) ROADMAP 단어 사전적 정의 검토 (forward-looking plan / time-bound / goal-oriented / step-by-step visibility) vs 현 projects/meta/ROADMAP.md 실 상태 (pending 0 / in_progress 1 / completed 32 / deferred 3, total 36 entry, forward-looking 0%) 정량 미부합 확인. (2) 9-stage 각 단어 사전적 정의 vs 부합 검토 — 평균 부합도 86.1% (APPROVE 100% / VERIFY 95% / REPORT 90% / OPEN 90% / EXECUTE 85% / RESEARCH 85% / INTENT 80% / DESIGN 80% / PROPOSE 70% 가장 큰 drift). 두 진단 root cause 공유 진단 = '단일 책임 모호' (PROPOSE 의 register 책임 침범 ↔ ROADMAP 의 forward-looking 정의 미부합 = 같은 모호성의 양면). § 6.2 default 동결 정책이 부분 완화 (pending 미등재 default → register 호출 빈도 감소) 하지만 단어-책임 자체 drift 해소 아님. lightweight 모드 (§ 6.2 자기참조 회피 표지) — 5 관점 subagent 생략 + 산출물 ~700 LOC (cap 1500 47% 활용). 1 phase 1+1 commit (phase-1 514b385 + Stage G+H+I 통합 chore). 워크플로우 본문 변경 zero, smoke 추가 zero. lightweight 누적 7/19 = 36.8% 갱신 (v3.6/v3.10/v3.13/v3.14/v3.17/v3.18 + v3.19). 워크플로우 자기 검토 라운드 누적 3번째 (v3.6 / v3.17 / v3.19) — 자기참조 모순 표지 의도성 진화 패턴 정량 확인. INTENT.success_criteria 7건 모두 VERIFY.criteria_check PASS, pre-commit 14 hook 모두 PASS, 회귀 0. 6 lessons (L1~L6) — L1 root cause 공유 / L2 자기 검토 라운드 누적 3번째 / L3 lightweight 누적 동치화 / L4 commit timing (a) lightweight default / L5 사전적 정의 검토 sub-pattern / L6 LOC ~700 정량. next_candidates 4건 거명만 (ROADMAP 등재 0건, § 6.2 default 동결 정합). 2026-05-13.",
      "trigger": "A_user"
    },
    {
      "version": "v3.18",
      "id": "option-a-natural-adaptation-narrative",
      "title": "Option A — 1-phase milestone era 정합 narrative 정착 (ARCHITECTURE § 6.1 단일 source)",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.18/milestones.md",
      "summary": "v3.17_phase-distribution-audit PROPOSE.next_candidates Option A 직접 후속 (A_user trigger, 사용자 명시 발의 'Option A 진행해줘'). ARCHITECTURE § 6.1 'bundling 정책' 섹션 운용 paragraph 직후 1 paragraph 신규 추가 — '1-phase milestone 정합 (v3.17 진단 + v3.18 정전화): sub_milestones[] 1 entry 도 본 era 정합. v3.7~v3.16 = 100% 1-phase, v3.x 전체 12/17 = 70.6% (v3.17 RESEARCH 1차 source). bundling 의미 grouping 본질 = ≥2 건 자연 활용 도구, 단일 후속 시 1-phase 강제 분할 부재.' D1 Option 1 채택 (ARCHITECTURE § 6.1 단일 source narrative, CLAUDE.md root / 모듈 CLAUDE.md / harness-meta.md 본문 변경 zero — v1.4_cross-ref-propagation 정합). D2 위치 line 166 직후, D3 정확 문구 정량 cross-ref. lightweight 모드 5번째 적용 (v3.6/v3.10/v3.13/v3.14/v3.17 선례 정합) — 5 관점 subagent 생략 + 산출물 LOC ~400 (cap 1500 권고 27% 활용). 1-phase 1+1 commit 도그푸드 (v3.17 lesson L6 패턴 두 번째 적용). 워크플로우 절차 본문 변경 zero, smoke 추가 zero. INTENT.success_criteria 7건 모두 VERIFY.criteria_check PASS (1 PASS_WITH_NOTE — Option 1 단일 source 채택 결과 추가 cross-ref 0). pre-commit 14 hook 모두 PASS, 회귀 0. 6 lessons (L1~L6) — L1 narrative 정전화 단일 source 패턴 / L2 도그푸드 패턴 두 번째 적용 / L3 'INTENT 필요 시' 조건 flex / L4 narrative 위치 cascade 자연성 / L5 정량 cross-ref 패턴 / L6 lightweight 누적 6/18 = 33.3% 갱신. v3.17 Option A 본질 완전 흡수 + Option D 본질 대부분 흡수. 2 commit. 2026-05-13.",
      "trigger": "A_user"
    },
    {
      "version": "v3.17",
      "id": "phase-distribution-audit",
      "title": "v3.x 17건 phase 분포 진단 — 1-phase 70.6% 현상 정량화 + 원인 분석 + 해결책 후보 PROPOSE",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.17/milestones.md",
      "summary": "사용자 발의 (A_user) — /harness-meta meta 자유 발의 round 안 'milestone 하나에 phase가 1개로 진행되는게 이해가 안 간다' 명시 의문. v3.x 17건 phase 분포 통계 (1-phase 12/17 = 70.6%, RESEARCH 정확 측정 / lightweight 6/17 = 35.3% / v3.7~v3.16 100% 1-phase / v3.10~v3.16 7건 consecutive lightweight) 와 v3.0+ 9-stage-bundled era 도입 narrative 사이 정량 괴리 진단 milestone. 원인 추정 3축 (§ 6.2 default 동결 부작용 + milestone 입자 작음 + lightweight 누적 동치화) direct/counter evidence 표 documented → 3축 모두 부분 기여 단일 결정적 원인 부재. 해결책 4 options (A/B/C/D) PROPOSE.next_candidates 거명만 — ROADMAP 등재 0건 (§ 6.2 default 동결 정합). Lightweight 모드 (§ 6.2 자기참조 회피 표지) 적용 — 5 관점 subagent 생략 + 산출물 LOC ~495 (cap 1500 권고 33% 활용). 본 milestone 자체가 1-phase 1+1 commit (phase-1 commit 97b7394 + Stage G chore commit) lightweight 모드 = 진단 결과 도그푸드 (자기참조 모순 의도적 표지). 워크플로우 본문 변경 zero. INTENT.success_criteria 7건 모두 VERIFY.criteria_check PASS (1건 PASS_WITH_NOTE commit timing (b)/(c) 실 동치 lesson L4). pre-commit 14 hook 모두 PASS (실 실행 9 + skipped 5), 회귀 0. 7 lessons (L1~L7) — L1 1-phase era 정합 / L2 § 6.2 시점-효과 + 3축 단일 결정 어려움 / L3 lightweight 누적 동치화 narrative / L4 commit timing (b)/(c) 실 동치 / L5 OPEN→RESEARCH drift 정정 cascade 흡수 / L6 자기참조 모순 도그푸드 표지 패턴 / L7 § 6.2 default 동결 = 사용자 명시 발의 trigger. 2026-05-13.",
      "trigger": "A_user"
    },
    {
      "version": "v3.16",
      "id": "changelog-unreleased-position-cleanup",
      "title": "CHANGELOG.md [Unreleased] 섹션 Keep a Changelog 권장 위치(최상단) 정합화",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.16/milestones.md",
      "summary": "v3.15_changelog-v3-backfill DESIGN D2 out_of_scope 보존 결정의 직접 후속. CHANGELOG.md [Unreleased] 섹션이 [v2.0] 아래(L190) 위치하던 Keep a Changelog 권장 위반을 해소. Option B (사용자 명시 선택) — [Unreleased] 빈 섹션 최상단 이동(L9) + 5 항목(CI / pre-commit / GUARDRAILS / .env.example / CHANGELOG) v1.0~v1.4 entry Added 흡수 + [v3.15] entry 추가 + [v3.16] entry 자기참조. Lightweight 모드 누적 6건째 (v3.11~v3.16, § 6.2 trigger 3건 충족) 단일 phase 1 commit (`e9dffa1`). INTENT.success_criteria 5건 VERIFY.criteria_check PASS, pre-commit 14 hook PASS, 회귀 0. 3 lessons (L1 lightweight 누적 / L2 초기 infra 귀속 묶음 패턴 / L3 out_of_scope 보존 → 후속 귀착 1 cycle). next_candidates 0건 (§ 6.2 default 동결 정합). 2026-05-13.",
      "trigger": "C_improvement"
    },
    {
      "version": "v3.15",
      "id": "changelog-v3-backfill",
      "title": "CHANGELOG.md v3.0~v3.14 backfill — v3.0 breaking major bump + v3.1~v3.14 13 entry 외부 visible artifact 정전화",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.15/milestones.md",
      "summary": "사용자 발의 (A_user) — /harness-meta meta 자유 발의 round 안 'CHANGELOG v3.0~v3.14 갱신 (Recommended)' 명시 선택. CHANGELOG.md 가 v2.1 (2026-05-10) 까지만 기록되어 있고 v3.0 breaking change (`!` major bump = milestone hierarchy 재구성 v2 → v3) + v3.1~v3.14 13 entry 누락 상태였던 외부 visible artifact 단일 source 정전화. Lightweight 모드 (§ 6.2 trigger 3건 충족, 누적 5건째 — v3.11/v3.12/v3.13/v3.14/v3.15) 적용 — 5 관점 subagent 검토 생략 + 단일 phase 1 commit (`d3eddaa`). CHANGELOG.md 149 → 302 lines (+153 LOC, 14 entry 삽입). v3.0 `!` BREAKING 마커 + v3.1~v3.14 13 entry 모두 역순 (Keep a Changelog v1.1.0 권장) 삽입. [Unreleased] + v2.0/v2.1/v1.x entry 현행 보존 (DESIGN D2/D3 정합). Keep a Changelog v1.1.0 + SemVer (`.harness.toml` schema 레벨) 정합 유지. INTENT.success_criteria 9건 모두 VERIFY.criteria_check PASS, pre-commit 14 hook PASS (실 실행 9 + skipped 5), 회귀 0. INTENT~APPROVE commit 시점 (b) default 정합. 6 lessons (L1 lightweight 모드 누적 5건 / L2 [Unreleased] 위치 권장 위반 보존 / L3 ROADMAP summary 단일 1차 source / L4 commit timing (b) 정합 / L5 cross-ref 누적 효과 / L6 backfill 패턴 첫 적용). next_candidates 2건 거명만 (§ 6.2 default 동결 권고 정합) — v3.16_unreleased-section-position-cleanup + v3.X_changelog-backfill-pattern-formalization. 2026-05-13.",
      "trigger": "A_user"
    },
    {
      "version": "v3.14",
      "id": "deferred-revaluation-cycle-2",
      "title": "deferred 3건 재평가 cycle 2 — 외부 적용 5건 (v1.10~v1.14) 추가 evidence 누적 후 § 6.2 동결 정책 검증",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.14/milestones.md",
      "summary": "v3.13_pending-milestone-renumber-policy (cycle 1, 2026-05-12) defer 결정의 직접 후속 cycle 2 검토. v3.13 이후 외부 적용 milestone 5건 추가 누적 (v1.10 ruff-lint-cleanup + v1.11 ruff-unsafe-fix-f841 + v1.12 ruff-ci-gate + v1.13 ruff-version-upgrade-evaluation + v1.14 ruff-rules-expansion) 시점에서 § 6.2 재발의 trigger 조건 (2) 정량 evidence 검증 후 옵션 A (동결 유지) 채택 — direct_naming 0 + indirect_impact 0 + reverse_evidence 5 → 조건 (1) PASS (10건 누적) ∧ 조건 (2) FAIL (0건 정량 evidence) = AND FAIL → 재발의 trigger 미충족. lightweight 모드 (self_reference_policy: avoid + subagent_review_policy: skipped + 5 관점 subagent 생략) 단일 phase 1 commit (f50ad5d). v3.13 cycle 1 패턴 정합. 4 lessons (L1~L4): cycle 2 cycle 1 동일 패턴 누적 / § 6.2 동결 정상 작동 reverse_evidence 5건 / lightweight 단일 phase 패턴 정합 / RESEARCH evidence_collection 3 축 분리 (direct/indirect/reverse). next_candidates ROADMAP 등재 0건 (release train 회피, § 6.2 정책 정합) + cycle 3 trigger 조건 narrative 거명만 (외부 적용 5건+ 추가 누적 ∧ 사용자 명시 발의 AND). 2026-05-13.",
      "trigger": "A_user"
    },
    {
      "version": "v3.13",
      "id": "pending-milestone-renumber-policy",
      "title": "v1.x pending 3건의 9-stage workflow 적용 정책 결정 — § 6.2 동결 정책 적용 + defer narrative",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.13/milestones.md",
      "summary": "v2.0_workflow-word-fidelity lessons next_candidates#1 origin — 사용자 명시 선택 (v2.1_pending-milestone-renumber-policy pending entry 직접 선택, A_user trigger 재분류). v1.x pending 잔여 3건 (v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_research-cascade-grep-discipline) 모두 workflow self-improvement 본질 → v3.6 § 6.2 동결 정책 직접 적용. 옵션 A 채택 (defer + 외부 upbit 적용 데이터 대기) — ROADMAP 3 entry status 'pending' → 'deferred' + deferred_reason 신 필드 (§ 6.2 cross-ref + 재발의 trigger 조건) + deferred_note 갱신 (v3.6 narrative + v3.13 결정 누적). Lightweight 모드 (§ 6.2 trigger 3건 충족) 자연 적용 — 5 관점 subagent 검토 생략 + 자기 검토 narrative cascade 5 위치 + 산출물 LOC ~673 (baseline 850 미만). 1 phase 1 commit (a86334c, ROADMAP.md +20-14). pre-commit 14 hook + smoke 직접 3건 모두 PASS, 회귀 0. INTENT.success_criteria 7건 모두 VERIFY.criteria_check PASS. 4 lessons (L1~L4) 후속 candidate 4건 모두 거명만 (§ 6.2 default 동결 권고 — workflow self-improvement 본질 + 외부 적용 데이터 부재 = ROADMAP 미등재). v3.11_legacy-narrative-cleanup 후속 renumber 두 번째 사례 — v3.11 (실 실행) vs v3.13 (정책 결정) 두 유형 모두 lightweight 모드. § 6.2 정책 narrative 세 번째 적용 사례 (v3.6 도입 + v3.10 부산물 통합 + v3.13 default 동결 적용). 2026-05-12.",
      "trigger": "A_user",
      "renumbered_from": "v2.1_pending-milestone-renumber-policy (v1.x era pending → v3.0+ 9-stage-bundled forward-only § 6.1 의무)"
    },
    {
      "version": "v3.12",
      "id": "deprecated-skill-narrative-cleanup",
      "title": "bootstrap/skills/audit/harness-{plan-verify,roadmap-update}/SKILL.md sessions/ 거명 일괄 정리",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.12/milestones.md",
      "summary": "v3.11 VERIFY drift 검증 시 발견된 잔존 narrative — harness-plan-verify/SKILL.md 6건 (L4-5 description + L27-28 적용 대상 현행화 + L165-166 historical 세션 경로 제거) + harness-roadmap-update/SKILL.md 3건 (L4 description + L22/L24 allowed-tools sessions/ → projects/). DEPRECATED 블록 내 역사적 서술은 보존. Lightweight 모드 (§ 6.2 조건 3건 충족) 적용. 1 phase 1 commit (446485b), pre-commit 14 hook 모두 PASS, 회귀 0. 2 lessons (L1: DEPRECATED SKILL frontmatter 동시 정리 / L2: era-transition SKILL.md 경로 체크리스트). 2026-05-12.",
      "trigger": "C_improvement"
    },
    {
      "version": "v3.11",
      "id": "legacy-narrative-cleanup",
      "title": "stale sessions/ + 4-tier narrative 일괄 정리 — claude/CLAUDE.md + upbit ARCHITECTURE.md + CHANGELOG.md",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.11/milestones.md",
      "summary": "v1.5_legacy-narrative-cleanup (v1.x era pending) 의 v3.0+ 9-stage-bundled era renumber 완료 (forward-only § 6.1 의무). v1.4_cross-ref-propagation RESEARCH untouched_files_explicit 6건 묶음 origin — 실재 stale 3위치 cleanup: (a) claude/CLAUDE.md L39 PostToolUse 섹션 narrative ('현행 패턴 (v2.0+ 9-stage 이후) v3.0+ 9-stage-bundled v{X.Y}/ + v{X.Y}_{slug}/ 보존 era' + 진화 이력 4단계 명시), (b) projects/upbit/ARCHITECTURE.md L106 현행 안내 stale path ('harness-meta repo: projects/meta/milestones/v{X.Y}/ 또는 v{X.Y}_{slug}/'), (c) CHANGELOG.md L3 era 카테고리 정합화 (3 era). 거명 6건 중 1건 (post-report-write.sh L2) 이미 fix 확인 + 2건 (upbit ROADMAP L11~13 v1.4 entry / ARCHITECTURE L133 historical) historical 보존. Lightweight 모드 (§ 6.2 trigger 3건 충족: narrative 정리 중심 + ≤5 파일 + 충돌 부재 예상) — 5 관점 subagent 생략, self_reference_policy: avoid 표지. 1 phase 1 commit (40faa23), pre-commit 14 hook 모두 PASS, 회귀 0. INTENT.success_criteria 6건 모두 PASS. 4 lessons (L1~L4) 중 L1 후속 candidate (roadmap-entry-summary-drift-detection) § 6.2 동결 (PROPOSE narrative 거명만), L2 후속 candidate (deprecated-skill-narrative-cleanup) v3.12 등재. 2026-05-12.",
      "trigger": "C_improvement",
      "renumbered_from": "v1.5_legacy-narrative-cleanup (v1.x era pending → v3.0+ 9-stage-bundled forward-only 의무)"
    },
    {
      "version": "v3.10",
      "id": "stage-byproduct-clarification",
      "title": "9-stage stage 영역 침범 narrative 명료화 — INTENT/RESEARCH/DESIGN 부산물 정의 + PROPOSE 흡수 책임",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.10/milestones.md",
      "summary": "사용자 발의 — 9-stage workflow '단어 = 단일 책임 1:1 매핑' (v2.0_workflow-word-fidelity) 원칙 운영 안 영역 침범 3건 정량 확인 (v3.6 INTENT.out_of_scope L19~21 '별 milestone 분리' / v3.6 DESIGN.phase-3 scope 'PROPOSE.md next_candidates 발의 narrative' / v1.4 RESEARCH.untouched_files_explicit 6건 묶음 → v1.5_legacy-narrative-cleanup 직접 발의). 옵션 A 채택 = 자연 부산물로 재해석. claude/commands/harness-meta.md Stage B/C/D 정의에 (a) 사실 진술 vs (b) 후속 발의 의미 분리 narrative 추가 + Stage I PROPOSE 안 B/C/D 부산물 통합 흡수 책임 + A_user dual origin 명시 + projects/meta/ARCHITECTURE.md § 4 9-stage 표 직후 cross-ref 1줄. lightweight 모드 (5 관점 subagent 생략, v3.6 선례) + 1 phase 1 commit (4e1981f). 도그푸드 정합 (본 milestone 산출물 안 forward propose 명령형 부재 grep 검증). § 6.2 A_user trigger 예외 경로 첫 사용 사례 — INTENT.dependencies 명시 충족. pre-commit 14 hook 모두 PASS, 회귀 0. 4 lessons (L1~L4) 중 L2/L4 후속 candidate 2건 PROPOSE 거명 (ROADMAP 미등재, § 6.2 default 동결 권고 정합). 2026-05-11.",
      "trigger": "A_user"
    },
    {
      "version": "v3.9",
      "id": "inactive-smoke-git-mv-checklist",
      "title": "smoke git mv 시 dirname 경로 자동 갱신 절차 명문화",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.9/milestones.md",
      "summary": "v3.8 L1 직접 후속. tests/CLAUDE.md '회귀 검증 절차' 섹션 하단에 '### smoke 파일 이동(git mv) 시 체크리스트' subsection 추가 (4단계). 경로 규범은 기존 line 285 'inactive smoke 경로 규약 (v3.8)' cross-ref 처리 (재서술 금지). 1 phase 1 commit (9587f52), pre-commit 14 hook 모두 PASS, 회귀 0. 2 lessons (L1: 소규모 충돌도 사용자 결정 게이트 유효 / L2: canonical source cross-ref 패턴 실 사례). 2026-05-12.",
      "trigger": "C_improvement"
    },
    {
      "version": "v3.8",
      "id": "inactive-smoke-cd-path-fix",
      "title": "inactive smoke 21건 cd 경로 버그 일괄 수정 (../.. 경로)",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.8/milestones.md",
      "summary": "v3.7 L1 후속. tests/_inactive/ 이동 후 cd '$(dirname $0)/..' 가 tests/ 로 잘못 해석되는 버그 8개 파일 일괄 수정 (→ ../..): smoke-detect-language / smoke-roi-regression / smoke-backup-cleanup / smoke-bootstrap-agents-md / smoke-bootstrap-render / smoke-skills-install / smoke-sync-agents / smoke-python-entry-boilerplate. tests/CLAUDE.md inactive smoke 경로 규약 1줄 추가 (spec-drift 권고 흡수). 1 phase 1 commit (2e25eff), pre-commit 14 hook PASS, 대표 inactive smoke 2건 6/6 PASS. L1: git mv 시 dirname 경로 갱신 체크리스트 누락 → v3.9 pending. 2026-05-11.",
      "trigger": "C_improvement"
    },
    {
      "version": "v3.7",
      "id": "smoke-posttooluse-9stage-tests",
      "title": "smoke-posttooluse-hook.sh INTENT/APPROVE/PROPOSE 9-stage 테스트 추가",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.7/milestones.md",
      "summary": "v2.0_workflow-word-fidelity 의 INTENT/APPROVE/PROPOSE 분기 coverage gap 보완. Tests T/U/V 3건 추가 (25/25 PASS). 겸: _inactive/ cd 경로 버그 수정 (../..) + 헤더 카운트 19→22. tests/CLAUDE.md '17 test' → '25 checks'. 1 phase 1 commit (030e68e), pre-commit 14 hook PASS, 회귀 0. L1: inactive 나머지 21건 동일 cd 버그 잠재 → v3.8 pending. 2026-05-11.",
      "trigger": "B_regression",
      "absorbed_from": "v2.1_smoke-posttooluse-9stage-tests (pending → v3.7 실행)"
    },
    {
      "version": "v3.3",
      "id": "ci-inactive-smoke-cleanup",
      "title": "CI inactive smoke 16건 정리 — bootstrap 잔존 / install-verify 합리화 / session 잔존 narrative cleanup",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.3/milestones.md",
      "summary": ".github/workflows/ci.yml CI 정책 변경 — glob 28건 → active 6건 명시 배열 (ACTIVE_SMOKES). inactive smoke 16건 CI 제외로 즉시 green 복구. inactive smoke 파일 보존. pre-commit 13 hook PASS, 회귀 0. 1 phase 1 commit (14b36ff). L1: OPEN stage milestones.md 스켈레톤 동시 생성 gap 발견 → v3.4 후속 제안. 2026-05-11.",
      "trigger": "B_regression"
    },
    {
      "version": "v3.4",
      "id": "open-stage-milestones-md-protocol",
      "title": "OPEN stage 절차에 milestones.md 스켈레톤 동시 생성 명문화",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.4/milestones.md",
      "summary": "v3.3 L1 직접 후속. claude/commands/harness-meta.md Stage A OPEN 절차에 step 7 ('milestones.md 스켈레톤 즉시 작성') 신규 추가 + Stage F 선결 조건 게이트 블록 narrative 미세 갱신 (DRY 회피 + 보조 검증 step 명시). skeleton 최소 필드 narrative 1차 source 위치 Stage F 게이트 → Stage A step 7 로 이동. 자기참조 부합 (도그푸드) — v3.4 OPEN 단계 자체가 본 절차 첫 적용. 3 관점 (architecture / spec-drift / scope contract) 병렬 검토 모두 pass-with-comments, 의견 충돌 0, 권고 흡수 완료 (R4 즉시 / R1 D4 narrative 강화 / R2·R3·R5·D7 REPORT). 단일 phase 1 commit (c3c35a9), pre-commit 13 hook 모두 PASS, 회귀 0. INTENT.success_criteria 6건 모두 PASS. 7 lessons (L1~L7) 중 L1/L3 후속 candidate 2건 등재 (v3.5_*). 2026-05-11.",
      "trigger": "C_improvement"
    },
    {
      "version": "v3.5",
      "id": "open-stage-discipline-strengthening",
      "title": "OPEN/DESIGN stage milestones.md 동시 생성 절차 강화 — cascade 검증 smoke + Stage D narrative 동기 (bundle)",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.5/milestones.md",
      "summary": "v3.4 lessons L1 + L3 직접 후속 bundle. v3.0+ 9-stage-bundled era 두 번째 bundle 사례 (첫: v3.1). 2 phase 2 commit. phase-1 (35c621c) — tests/smoke-open-stage-discipline.sh 신규 + pre-commit hook 등록 (13→14 active) + tests/CLAUDE.md 매트릭스 5 영역 갱신 (헤더 28→29 / narrative 7 active / 핵심 정책 검증 표 row + 현행 hook 표 row + inactive 22 active 카운트). phase-2 (a4aa8c7) — claude/commands/harness-meta.md Stage D 끝 신규 sub-section ('Stage D 완료 직전 의무 step') 삽입 + Stage A step 7 placeholder narrative 끝 '(placeholder title 교체)' 미세 추가. 4 관점 병렬 검토 (architecture / spec-drift / 회귀 risk / scope contract) 모두 pass-with-comments + 의견 충돌 0 + 필수 흡수 4건 (D4 정규식 정정 / INTENT phrasing / DESIGN D3 trace / phases[0] affected_files) + 선택 흡수 2건. pre-commit 14 hook 모두 PASS (3회), 회귀 0. 자기참조 도그푸드 3 사례 (OPEN 단계 / Stage D / smoke). INTENT.success_criteria 6건 모두 VERIFY.criteria_check PASS. 7 lessons (L1~L7) 중 L3 + L5 후속 candidate 등재 (v3.6_workflow-narrative-strengthening-v2). out_of_scope 후속 candidate 등재 (v3.6_milestones-md-validation-extension). 2026-05-11.",
      "trigger": "B_regression"
    },
    {
      "version": "v3.6",
      "id": "overengineering-audit",
      "title": "Overengineering audit — workflow 자기참조 사이클 진단 + lightweight remediation (자기참조 회피 표지)",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.6/milestones.md",
      "summary": "사용자 발의 — 외부 best practice (Martin Fowler / OpenAI / Anthropic / Pi) 대비 + 내부 정량 진단 결과 명확한 오버엔지니어링 확인 (workflow self-improvement 9/24 milestone, narrative ÷ 코드 변경 5~9x, pending 4/6 워크플로우 강화, 18일간 workflow 3회 major bump). 자기참조 회피 표지 (v2.0_workflow-word-fidelity 선례 chicken-and-egg 회피) 적용 lightweight 모드 — 5 관점 subagent 검토 생략 + 산출물 LOC cap. 권고 7건 중 4건 적용: #1 (workflow self-improvement 동결 ARCHITECTURE § 6.2 신설) + #4 (smoke inactive 22 archive tests/_inactive/ git mv) + #6 (narrative cap 정책 명문화 § 6.2 동시) + #7 (upbit 외부 적용 next_candidate 거명, 실 발의는 사용자 명시 trigger 대기). 권고 #2/#3/#5 (9-stage trim / 5 관점 trim / 4 era migration) 은 evidence-base trigger candidate 만 PROPOSE 거명 (자기참조 사이클 재진입 risk, release train 거부). 3 phase / 3 commit (phase-1 4ef8a74 + phase-2 9ba1eb1 + phase-3 Stage G+H+I 통합). pre-commit 14 hook 모두 PASS, 회귀 0. 산출물 총 LOC cap 정합. 4 lessons (L1~L4). 기존 v3.6_milestones-md-validation-extension + v3.7_workflow-narrative-strengthening-v2 deferred entry 는 외부 적용 후 정량 데이터 기반 재발의 (default 동결 권고). 2026-05-11.",
      "trigger": "A_user"
    },
    {
      "version": "v3.2",
      "id": "workflow-narrative-strengthening",
      "title": "workflow narrative 강화 — Stage F 절차 / smoke skeleton 책임 분리 / controlled 비교 cp949 narrative",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.2/milestones.md",
      "summary": "v3.1 lessons L2/L3/L5/L6/L9 narrative 공백 4건 채움. phase-1: harness-meta.md Stage F 선결 조건 게이트 블록 신규 (milestones.md 선결 의무 CRITICAL + INTENT~APPROVE commit 시점 3 패턴). phase-2: tests/CLAUDE.md controlled 비교 cp949 mojibake 정상 작동 narrative. phase-3: Skeleton 매트릭스 2 row (era 분류 vs schema 책임 분리 + status 기반 분기). 3 phase 3 commit (1220a2d/6483d1b/de7f62a), 13 hook PASS, 회귀 0. 2026-05-11.",
      "trigger": "C_improvement"
    },
    {
      "version": "v3.1",
      "id": "workflow-policy-fine-tuning",
      "title": "v3.0 bundling 정책 첫 후속 적용 — markdownlint trap / milestones.md historical / bundling trigger smoke",
      "status": "completed",
      "milestones_path": "milestones/_archive/v3.1/milestones.md",
      "summary": "v3.0_milestones-restructure 직접 후속 (PROPOSE next_candidates 3건 + lessons L10) 통합 milestone. v3.0+ 9-stage-bundled era 첫 후속 통합 milestone 사례 (도그푸드 누적). 3 sub-milestone: phase-1 markdownlint trap narrative (tests/CLAUDE.md § '흔한 함정' 7번째 row + MD049 spec 직접 인용) + milestones.md 신규 (R1 CRITICAL mitigation) / phase-2 historical era 적용 결정 (forward-only 강제, v3.0 milestones.md unchanged D12 사용자 결정 P1) / phase-3 tests/smoke-bundle-trigger.sh 신규 + pre-commit 등록 (12→13 hook, 자동 강제 누적). 4 관점 검토 (architecture / spec-drift / 회귀 risk / scope contract) 모두 pass-with-comments + 의견 충돌 1건 사용자 결정 해소 + 19 권고 자동 흡수 (D13~D18 신규). 3 phase 3 commit (0a86598 / 4bd4ec6 / d136b2f), pre-commit 13 hook 모두 PASS, 회귀 0. INTENT.success_criteria 8건 모두 PASS. minor bump (semver 정합 backward-compatible). 8 lessons (L1~L8) 중 4 건 후속 candidate 등록 (v3.2_workflow-narrative-strengthening 통합). 2026-05-10.",
      "trigger": "B_regression",
      "absorbed_milestones": [
        "v3.1_markdownlint-trap-narrative (phase-1, v3.0 PROPOSE next_candidates)",
        "v3.1_milestones-md-spec-formalization (phase-2, v3.0 PROPOSE next_candidates)",
        "v3.1_smoke-bundle-trigger-validation (phase-3, v3.0 PROPOSE next_candidates)"
      ]
    },
    {
      "version": "v3.0",
      "id": "milestones-restructure",
      "title": "milestone hierarchy 재구성 — version > sub-milestone > phase + v2.2_* 4건 흡수",
      "status": "completed",
      "summary": "v2.2_* 4건 검토 round 중 사용자가 명명 구조 v{X.Y}_{slug} 자체가 grouping 한계의 root cause임을 통찰. 동일 X.Y 후속 candidates가 별도 milestone으로 분리 강제 → 토큰 비효율 + INTENT/DESIGN 중복 + merge conflict 위험. 해결: ROADMAP `milestones[]` schema에 version/id 분리 + 디렉토리 milestones/v{X.Y}/ 도입 + milestones.md (sub-milestone listing per version) 신규 + smoke era 분기 (forward-only, historical v1.x~v2.1 보존). 자기참조 부합 — v3.0 자체가 신 구조 첫 적용 사례 (도그푸드). 8 phase: phase-1 smoke era branching / phase-2 _era_detect.py 분리 (v2.2_era-detect-shared-module 흡수) / phase-3 정책 명문화 + INTENT~APPROVE commit / phase-4 ROADMAP schema 변경 + v2.2_* 4건 entry 제거 / phase-5 milestones.md 도입 / phase-6~8 v2.2_* 3건 잔여 흡수 (cp949 / controlled-comparison / historical-decision). breaking change → major bump (v2 → v3).",
      "trigger": "A_user",
      "milestones_path": "milestones/_archive/v3.0/milestones.md",
      "absorbed_milestones": [
        "v2.2_era-detect-shared-module (phase-2)",
        "v2.2_smoke-cp949-encoding-pattern (phase-6)",
        "v2.2_smoke-controlled-comparison-pattern (phase-7)",
        "v2.2_historical-7stage-stage1-decision (phase-8)"
      ]
    },
    {
      "id": "v2.1_smoke-spawn-batching",
      "title": "smoke-spec-verification + smoke-scope-contract python3 spawn batching (66s+12s → 0.6s+0.6s)",
      "status": "completed",
      "summary": "사용자 발의 — pre-commit 전체 1m33s 의 84% (smoke-spec-verification 66.4s + smoke-scope-contract 12.4s) 가 milestone N × stage M 마다 python3 새로 spawn 하는 비효율로 점유. Approach A 채택 (단일 batched python3 호출). spec-verification 66.4s → 0.63s (99.05% 감소) + scope-contract 12.4s → 0.65s (94.76% 감소) + 전체 pre-commit 93.3s → 15.4s (83.49% 감소). INTENT.success_criteria 7건 모두 임계 대비 2~16x 여유로 PASS, 회귀 0. 3 관점 검토 (architecture / 회귀 risk / scope contract — D11 spec-drift 자리 회귀 risk 대체) 모두 pass-with-comments + 의견 충돌 0. 검토 권고 11건 모두 흡수 (D5/D12~D17 + R11~R13). 신규 발견 1건 (Windows cp949 콘솔 em dash UnicodeEncodeError, smoke-python-entry-boilerplate § P2 v1.87 패턴 차용). 9-stage workflow (v2.0+) 두 번째 실 적용 — APPROVE 게이트 + PROPOSE 분리 정상. 2 phase commit (e4cffd6 + de1421e), pre-commit 5 hook 모두 PASS. 7 lessons (L1~L7) 중 4 건 후속 candidate 등록 (v2.2_*). 2026-05-10.",
      "trigger": "A_user"
    },
    {
      "id": "v2.0_workflow-word-fidelity",
      "title": "워크플로우 stage 단어 의미 부합 정정 — 7-stage → 9-stage (OPEN/INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE)",
      "status": "completed",
      "summary": "현 7-stage workflow 의 4건 단어 미스매치 (MILESTONE 단어-책임 부정합 / PLAN 'intent only' narrowing / DESIGN 3 책임 혼재 / REPORT backward+forward 혼재) 전면 정정. MILESTONE→OPEN, PLAN→INTENT, DESIGN(decisions+approach+phases) + APPROVE 분리, REPORT(lessons) + PROPOSE 분리. ROADMAP 은 입력 source 로 stage 카운트 제외 (OPEN~PROPOSE = 9 stage). 5 관점 병렬 검토 (architecture / spec-drift / 회귀 risk / 보안 / scope contract) — 회귀 risk 1 fail + 4 pass-with-comments → DESIGN 정정 8건 반영 후 5 관점 모두 pass. 사용자 의문 round 3회 (총 13 question 명시 결정). 6 phase + 1 hotfix = 7 commit (4846aa7 / 4435eb3 / a682f2a / e3d0478 / 84b0a49 / ab5b514 + 43472b7). ARCHITECTURE.md § 3.3 5요소 매트릭스 'Workflow' 행 9-stage + 'Constraint' 행 APPROVE.md.approved_by gate + 'Trace' 행 산출 7종 + § 4 9-stage 섹션 + § 6 era 정책 (4-tier / 7-stage / 9-stage 3 era) 명문화. claude/commands/harness-meta.md 9-stage 절차 전면 재작성. 단일 source 5곳 + 모듈 가이드 3곳 cascade. smoke (smoke-spec-verification / smoke-scope-contract) 에 era 자동 식별 메커니즘 + post-report-write hook 9-stage 패턴 + 분기 inject 메시지. Historical 7-stage era 11개 milestone PLAN.md → INTENT.md git mv (history 96~100% 보존) + 본문 cross-ref. 4-tier era 보존. 본 v2.0 milestone 자체 7-stage 포맷 자기참조 표지 (D12). pre-commit 5 hook 모두 PASS, 회귀 0. CHANGELOG v2.0 entry + 사용자 메모리 갱신. 2026-05-10.",
      "trigger": "D_design"
    },
    {
      "id": "v1.3_harness-engineering-definition",
      "title": "하네스 엔지니어링 정의 명시 — 메타 레이어의 working definition + 5요소 매트릭스 박기",
      "status": "completed",
      "summary": "projects/meta/ARCHITECTURE.md § 3 단일 source 에 working definition (1문장) + '인프라 자동화 의존 최소화' 명료화 단락 + working philosophy + 4컬럼 5 row 매트릭스 (Context / Workflow / Constraint / Verification / Trace) + 외부 컨벤션 관계 + 단일 source 정합 + 신규 milestone 평가 절차 6 sub-section 박음. root CLAUDE.md L8 cross-ref 1줄 추가 (보수 결정 — 다른 host 5곳 은 후속 v1.4_cross-ref-propagation 분리). 3 관점 병렬 검토 + 사용자 결정 2건 (4컬럼 / 보수 cross-ref) + 명료화 단락 추가 trigger. 2 phase + Stage G commit, pre-commit smoke 8건 PASS, 회귀 0. 2026-05-09.",
      "trigger": "C_improvement"
    },
    {
      "id": "v1.4_infra-minimization",
      "title": "인프라 최소화 — install/verify 제거 + smoke 합리화 (5요소 'Verification 혼재' 정전화)",
      "status": "completed",
      "summary": "v1.3 § 3.3 매트릭스 'Verification' 행 (c) = 혼재 → 정전 갱신 + drift 2건 (smoke-l5-readme-link-cleanup / smoke-v1.1, 4-tier era 잔존) 단순 제거 + tests/CLAUDE.md 매트릭스 narrative 강화 (L7 count 29→27 + 매트릭스 헤더 직후 narrative 1차 source standalone block + 핵심 정책 검증 표 smoke-projects-scope-discipline row 추가 + 현행 hook § 직후 inactive 22 회귀 차단 책임 paragraph). Option A 채택 (보수적 슬림화 — 사용자 PLAN/RESEARCH 분기). 4 관점 subagent 검토 (architecture / spec-drift / 회귀 risk / scope contract) 모두 pass-with-comments + 5 권고 반영. DESIGN.D9 narrative 대체 메커니즘 1:1 매핑 (a/b/c). § 3.5 cascade grep host 5곳 (root CLAUDE.md / AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md) 4 pattern 본문 중복 부재 직접 검증 → 단일 source 정합 보장. 3 phase commit (3f918d3 / bd398a1 / 7ba503f) + Stage G, pre-commit 5 hook 모두 PASS, 회귀 0. ARCHITECTURE.md (b) smoke 22종 → 27종 카운트 cascade. 2026-05-10.",
      "trigger": "D_design"
    },
    {
      "id": "v1.4_hook-narrative-separation",
      "title": "hook hard-code 메시지 narrative 분리 (post-report-write.sh)",
      "status": "deferred",
      "summary": "v1.3 § 3.1 명료화 단락 거명 자동화 #2 'hook hard-code'. post-report-write.sh inject 메시지를 shell 안에 박지 않고 MD 파일에 분리, hook 은 단순 reader.",
      "trigger": "D_design",
      "deferred_reason": "v3.6_overengineering-audit § 6.2 workflow self-improvement 동결 정책 직접 적용 — post-report-write.sh hook 구조 변경 = workflow 자체 (claude/hooks/) 영향. § 6.2 재발의 trigger 조건 (외부 projects/<name>, name ≠ meta 실 적용 milestone 1건 완료 후 정량 데이터에 근거한 명시 발의) 충족 시 재발의. v3.13 결정 (cycle 1, 2026-05-12) → v3.14_deferred-revaluation-cycle-2 결정 (cycle 2, 2026-05-13 동결 유지 verdict — AND FAIL)."
    },
    {
      "id": "v1.4_design-review-trace",
      "title": "Stage E 5 관점 검토 raw 출력 보존 (milestones/.../design-review/)",
      "status": "deferred",
      "summary": "v1.3 § 3.3 매트릭스 'Trace' = 정전 + 메타 고유 차별화이나 현재 Stage E subagent 5 관점 검토 결과는 DESIGN.md 통합 후 raw 출력 소실. milestones/v{X.Y}_*/design-review/{architecture,spec-drift,...}.md 로 보존.",
      "trigger": "D_design",
      "deferred_reason": "v3.6_overengineering-audit § 6.2 workflow self-improvement 동결 정책 직접 적용 — Stage E 5 관점 검토 raw 출력 보존 = workflow 절차 (claude/commands/harness-meta.md Stage E) 변경. § 6.2 재발의 trigger 조건 충족 시 재발의. v3.13 결정 (cycle 1, 2026-05-12) → v3.14_deferred-revaluation-cycle-2 결정 (cycle 2, 2026-05-13 동결 유지 verdict — AND FAIL)."
    },
    {
      "id": "v1.4_cross-ref-propagation",
      "title": "정의 cross-ref 전파 (AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md) + GUARDRAILS 재작성 + docs/ARCHITECTURE.md 폐기",
      "status": "completed",
      "summary": "v1.3 DESIGN.decisions[4] 보수 cross-ref 결정의 직접 후속. host 4곳 (AGENTS·README·projects/meta/CLAUDE·GUARDRAILS) 정의 § 3 cross-ref 1줄 standalone header/block 추가 (영문 host 'canonical single source' / 한국어 host '정전 single source' 표본 통일) + AGENTS Status 섹션 일반화 (Milestone history: see projects/meta/ROADMAP.md) + GUARDRAILS.md 전면 재작성 (sessions/→milestones/, bootstrap C2~C6 부재 제거, H 매트릭스 H1~H8 재할당 (구 H7/H9 제거 + 신규 H8 DESIGN.approval gate), C 매트릭스 C1~C4 재할당, § 4 7-stage Scope contract, § 6 References 정의 host 거명) + docs/ARCHITECTURE.md 폐기 (책임 중복) + cascade 7곳 정리 (RESEARCH 6곳 + smoke autofix 1곳 docs/adr/README.md L34) + § 3.5 단일 source list 갱신 (5곳: root CLAUDE.md/AGENTS.md/README.md/projects/meta/CLAUDE.md/GUARDRAILS.md). 4 관점 subagent 검토 (architecture / spec-drift / 회귀 risk / scope contract) + 사용자 결정 4건 (의문 round 1) + 모순 재확인 (round 2) + DESIGN 13 결정 + 13 risk_mitigation. 3 phase commit (df3ea89 / f1a2b6f / 7ac122f) + Stage G commit. pre-commit smoke 5건 모두 PASS, 회귀 0. 2026-05-09.",
      "trigger": "D_design"
    },
    {
      "id": "v1.5_research-cascade-grep-discipline",
      "title": "RESEARCH 단계 cascade grep 패턴 강화 (relative + 절대 + symlink)",
      "status": "deferred",
      "summary": "v1.4 lessons_learned #1 — RESEARCH 단계 cascade list grep 이 relative path (`../ARCHITECTURE.md`) 누락 (1건). phase-2 commit 시 smoke-cross-ref autofix 가 보완. claude/commands/harness-meta.md 또는 RESEARCH 템플릿 보강 — cascade RESEARCH 시 relative + 절대 + symlink 모두 grep 패턴 강화 의무 명시.",
      "trigger": "B_regression",
      "deferred_reason": "v3.6_overengineering-audit § 6.2 workflow self-improvement 동결 정책 직접 적용 — RESEARCH 단계 cascade grep 패턴 강화 = workflow 절차 (claude/commands/harness-meta.md RESEARCH 템플릿) 변경. § 6.2 재발의 trigger 조건 충족 시 재발의. v3.13 결정 (cycle 1, 2026-05-12) → v3.14_deferred-revaluation-cycle-2 결정 (cycle 2, 2026-05-13 동결 유지 verdict — AND FAIL)."
    },
    {
      "id": "v1.1_meta-as-project",
      "title": "meta repo를 projects/meta/로 이관 — 모든 project 동형 구조 강제",
      "status": "completed",
      "summary": "root ROADMAP/milestones를 projects/meta/ 하위로 이관 (git mv 7 dirs, history 보존) + ARCHITECTURE.md 신규 + root ROADMAP을 thin index 변환 + projects/meta/CLAUDE.md (lazy subdir) 신설 + /harness-meta 경로 resolution 갱신 + misclassified v1.1_upbit-cross-ref-cleanup 이관 (root → projects/upbit/) + scope-discipline smoke 신규 + 단독 active 활성화 + 4 optional sweeps (settings.local.json prune / docs grep / harness-roadmap-update SKILL deprecation / pre-commit-config 주석 갱신). 3 phase commit (7bfa1a5 / 0fa3d32 / e2f59de), 회귀 0. 2026-05-08.",
      "trigger": null
    },
    {
      "id": "v1.1_readme-cleanup",
      "title": "README.md legacy 참조 (Bootstrap mode / DECISIONS|INTERVIEW|STACK / sessions/) 정리",
      "status": "completed",
      "summary": "10-stage tagline·/harness-plan·design·run·ship·sessions/ 경로·Bootstrap mode·Stage 2 bootstrap 설치·Language overlay·bootstrap/docs 링크 제거 + 7-stage 재작성. 2-phase, pre-commit full-pass, 회귀 0. 2026-05-08.",
      "trigger": "A_user"
    },
    {
      "id": "v1.1_agents-md-cleanup",
      "title": "AGENTS.md legacy 참조 정리 (README.md cleanup 후속)",
      "status": "completed",
      "summary": "Status 섹션 stale 표기 1건(v1.1_meta-as-project 'in progress') 갱신 — v1.0·v1.1_meta-as-project·v1.1_readme-cleanup completed + v1.1_agents-md-cleanup in progress 표기. 예상 legacy 참조(10-stage·Bootstrap)는 실제 스캔 결과 없었음. 1 phase, pre-commit full-pass, 2026-05-08.",
      "trigger": "A_user"
    },
    {
      "id": "v1.1_smoke-precommit-rewrite",
      "title": "smoke + .pre-commit hook 4종 재작성 (새 7-stage 포맷 정합)",
      "status": "completed",
      "summary": "4 smoke 전면 재작성(spec-verification/scope-contract) + 최소 패치(cross-ref/claude-md-drift) + pre-commit 5 hook 활성화. JSON schema 검증 + DESIGN.approval 게이트 + 43건 broken ref 정리. 4 phase, pre-commit full-pass, 회귀 0건. 2026-05-08.",
      "trigger": "B_regression"
    },
    {
      "id": "v1.1_post-report-write-hook-update",
      "title": "claude/hooks/post-report-write.sh 패턴 갱신",
      "status": "completed",
      "summary": "sessions/.*/REPORT.(md|ipynb)$ 패턴 → projects/meta/milestones/v{X.Y}_*/(PLAN|RESEARCH|DESIGN|VERIFY|REPORT|execute/phase-N).md$ 패턴. 2 phase, pre-commit full-pass, smoke 22/22, 회귀 0. 2026-05-08.",
      "trigger": "B_regression"
    },
    {
      "id": "v1.1_design-phases-execute-tracking-automation",
      "title": "DESIGN.phases[n] execute/phase-{n}.md 자동 트래킹",
      "status": "completed",
      "summary": "harness-meta.md Stage E phases 필드 + Stage F step 1/2 지침 갱신 — execute/phase-{n}.md DESIGN.affected_files 포함 의무 명시. 1 phase, pre-commit full-pass, 회귀 0. 2026-05-08.",
      "trigger": "D_design"
    },
    {
      "id": "v1.2_post-report-write-message-rewrite",
      "title": "post-report-write.sh additionalContext 메시지 재작성 (7-stage 안내)",
      "status": "completed",
      "summary": "deprecated SKILL 참조(harness-roadmap-update/harness-plan-verify) 제거 + 7-stage 흐름 안내 메시지 교체. smoke 6건 키워드 갱신. 2 phase, smoke 22/22, pre-commit full-pass, 회귀 0. 2026-05-08.",
      "trigger": "C_improvement"
    },
    {
      "id": "v1.0_workflow-redesign",
      "title": "7-stage workflow redesign — single-responsibility pipeline",
      "status": "completed",
      "summary": "기존 4-tier sessions/milestones 구조를 새 7-stage JSON-schema 기반 흐름(ROADMAP→MILESTONE→PLAN→RESEARCH→DESIGN→EXECUTE→VERIFY→REPORT)으로 완전 교체. 6 phase 분할 commit. ~370 파일 정리 + 12 신규. 회귀 0. 2026-05-08.",
      "trigger": null
    }
  ]
}
```

## 관련 문서

- 운영 가이드 (root): [`../../CLAUDE.md`](../../CLAUDE.md)
- ARCHITECTURE: [`ARCHITECTURE.md`](ARCHITECTURE.md)
- subdirectory CLAUDE.md (lazy load): [`CLAUDE.md`](CLAUDE.md)
- 활성 milestone: [`milestones/v4.0/`](milestones/v4.0/) (in_progress, 2026-05-13 — v4.0_harness-composer-pivot, 정체성 재정의)
- Archive (v4.0 phase-2, 2026-05-13 이전): [`milestones/_archive/v1.1_meta-as-project/`](milestones/_archive/v1.1_meta-as-project/) (REPORT 참조, 2026-05-08) / [`milestones/_archive/v1.0_workflow-redesign/`](milestones/_archive/v1.0_workflow-redesign/) (2026-05-08) / `milestones/_archive/v1.84_*` ~ `v1.88_*` (4-tier historical) / `milestones/_archive/v2.0~v2.1_*` (9-stage) / `milestones/_archive/v3.0~v3.21/` (9-stage-bundled)

## 비고

이 ROADMAP은 v1.1_meta-as-project (2026-05-08 완료) 에서 신설됨. 이전에는 root `ROADMAP.md` 가 meta scope 의 단일 source 였으나, 본 milestone 후 root는 thin index, 본 파일이 meta milestones[] 의 단일 source 가 됨.
