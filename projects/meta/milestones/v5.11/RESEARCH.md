# RESEARCH — v5.11 audit-chain-fact-verification-discipline

```json
{
  "id": "v5.11_audit-chain-fact-verification-discipline",
  "external": [
    {
      "source": "memory feedback_subagent_fact_hallucination_correction",
      "topic": "Agent 호출 후 산출 안 외부 1차 source fact 인용 시 synthesizer 직접 매핑 검증 의무",
      "findings": "v5.10 L1 origin (component-proposer 12 항목 표 hallucination django/ai-ready-scorer 등 upbit 무관 → synthesizer overwrite 정정). memory 작성 시점 = v5.10 종료 직후 2026-05-18. 본 v5.11 = 누적 2 cycle direct evidence (proposer + scanner) 도달.",
      "drift": "v5.10 PROPOSE 작성 시점 검증 운용 부재 — scanner-output.md `claude_md_in_repo: false` fact 검증 누락 → analyzer/mapper/proposal-draft 3 산출물 cascade 흡수 → ROADMAP entry summary 5 차 위치 fact 인용 stale = 단일 hallucination 5 위치 누적 흡수. 본 milestone 정정 의무 = direct evidence cycle 2 도달 narrative 정전화."
    },
    {
      "source": "v3.21_narrative-canonicalization-3step-pattern (Lightweight 모드 § 6.2 폐지 후 narrative)",
      "topic": "narrative 정전화 3 단계 패턴 — (a) DESIGN 정확 문구 1차 source (markdown code block) / (b) phase-1 EXECUTE 안 Edit tool 정확 문구 그대로 삽입 / (c) VERIFY 안 grep 검증 키워드",
      "findings": "v3.18 + v3.20 + v3.21 + v4.1 + v4.2 + v4.3 + v5.0 + v5.7 + v5.8 + v5.9 + v5.10 + 본 v5.11 = 12 누적 후 13 번째 cycle 도그푸드 의도",
      "drift": "drift 부재 — 본 milestone 정확 정합 (Stage D D2 정확 문구 markdown code block 안 단일 source)"
    },
    {
      "source": "git log --oneline -- C:/Users/qkreh/upbit/CLAUDE.md",
      "topic": "upbit/CLAUDE.md 거주 시점 정확 정량",
      "findings": "최신 commit = a856ddc (v1.17 phase-3, 2026-05-14 'feat(upbit): v1.17 phase-3 — cleanup backup 2건 삭제 + CLAUDE.md cascade narrative + quality.yml security step 2건 (G8)'). 이전 commits = f0e1eb6 (v1.4 phase-1) + 21376e8 (refactor: migrate to global harness-meta repo) — 즉 v1.17 이전부터 거주 (cascade narrative 변경 = 기존 파일 단락 수정이지 신규 생성 아님). 현재 9430 bytes 실 존재.",
      "drift": "v5.10 audit-2026-05-18 (2026-05-18 진행) 시점 = upbit/CLAUDE.md 실 존재 4일+ 경과 → scanner `claude_md_in_repo: false` 출력 = hallucination 확정"
    },
    {
      "source": "v1.17_upbit-harness-plugin-pivot-and-audit-componentry/RESEARCH.md L75",
      "topic": "v1.17 audit chain 동일 hallucination 검증 (사용자 sc_5 명시 결정 포함)",
      "findings": "v1.17 RESEARCH.md L75 정확 문구 = 'current_state: .claude/ 직접 배포 (v4.x 시대) — ... CLAUDE.md:54 SymbolicLink/install.ps1 narrative.' — 즉 v1.17 audit chain 결과는 CLAUDE.md 가 line 54 narrative 거주 사실 정확 capture, hallucination 부재. v1.17 시점 audit chain 정상 작동 검증.",
      "drift": "v5.10 단독 발생 hallucination — 본 milestone 정정 scope 안 v1.17 cascade 정정 불요 (사용자 sc_5 명시 결정 → '부재 확인' = 사실 진술로 흡수)"
    }
  ],
  "codebase": {
    "affected_files": [
      "C:/Users/qkreh/harness-meta/projects/upbit/audit-2026-05-18/scanner-output.md (line 77 + line 150 + line 177 = 3 위치 fact 정정)",
      "C:/Users/qkreh/harness-meta/projects/upbit/audit-2026-05-18/analyzer-output.md (line 68~71 A4 entry + line 122 anomaly_entry + line 137 summary_narrative + line 149 anomaly_register = 4 위치 fact 정정)",
      "C:/Users/qkreh/harness-meta/projects/upbit/audit-2026-05-18/mapper-output.md (line 65~77 A4 entry block + line 171 status confirmed + line 192 A4 medium summary = 3 위치 fact 정정)",
      "C:/Users/qkreh/harness-meta/projects/upbit/audit-2026-05-18/proposal-draft.md (line 34 row 3 PARTIAL + line 81 row A4 medium + line 140 next_milestone#4 + line 172 row 7 = 4 위치 fact 정정)",
      "C:/Users/qkreh/harness-meta/projects/meta/ROADMAP.md (v5.10 entry summary 안 'audit-2026-05-18 A4 gap MEDIUM' 인용 + PROPOSE.next_candidates#4 origin narrative — Stage D 정확 위치 결정)",
      "C:/Users/qkreh/harness-meta/projects/meta/milestones/v5.10/PROPOSE.md (line 22~28 next_candidates[3] entry id `upbit-claude-md-repo-root-creation` + origin 'audit-2026-05-18 A4 gap MEDIUM' + rationale 안 'CLAUDE.md 자체 부재 (scanner: claude_md_in_repo: false)' = 무효 표지 후 정정 narrative)",
      "C:/Users/qkreh/harness-meta/projects/meta/ARCHITECTURE.md (line 135 cascade drift paragraph 직후 신 paragraph 'Audit chain fact 인용 검증 의무 (synthesizer 의무)' 정전화 — Stage D D1 host 결정)",
      "C:/Users/qkreh/harness-meta/projects/meta/milestones/v5.11/execute/phase-1.md (신규)",
      "C:/Users/qkreh/harness-meta/projects/meta/milestones/v5.11/{INTENT,RESEARCH,DESIGN,APPROVE,VERIFY,REPORT,PROPOSE,milestones}.md (산출물 통합 chore commit)"
    ],
    "untouched_files_explicit": [
      "C:/Users/qkreh/upbit/CLAUDE.md (이미 v1.17 phase-3 cascade narrative 변경 완료, 9430 bytes 거주, 본 milestone scope 외 — 사실 진술)",
      "C:/Users/qkreh/upbit/milestones/v1.17/* (RESEARCH.md L75 fact 정합 검증 결과 hallucination 부재, 본 milestone scope 외 — 사실 진술 sc_5 정합)",
      "C:/Users/qkreh/harness-meta/agents/project-harness-audit-team/CLAUDE.md (단일 source 전략 정합, ARCHITECTURE 한 곳만 정전화 — 사실 진술)",
      "C:/Users/qkreh/harness-meta/bootstrap/agents/CLAUDE.md (단일 source 전략 정합 — 사실 진술)",
      "C:/Users/qkreh/harness-meta/agents/{project-scanner,harness-gap-analyzer,claude-docs-mapper,component-proposer,component-installer}.md (agent 정의 자체 변경 부재 — 사실 진술, INTENT.out_of_scope#1 정합)"
    ],
    "current_state": "v5.10 audit chain 4 산출물 안 14 위치 fact 인용 (scanner 3 + analyzer 4 + mapper 3 + proposal 4) 가 hallucination 흡수 상태. ROADMAP v5.10 entry summary + v5.10 PROPOSE.md next_candidates#4 안 인용 = 본 hallucination 5 차 위치 인용. ARCHITECTURE.md § 4 끝 cascade drift paragraph (v5.10 정전화) 직후 = audit chain fact 인용 검증 의무 narrative 부재.",
    "target_state": "v5.10 audit chain 4 산출물 안 14 위치 fact 인용 모두 정정 (각 위치 inline 정정 narrative 또는 stale 표지 cross-ref + 실 상태) + ROADMAP + PROPOSE 2 위치 정정 + ARCHITECTURE § 4 끝 L135 paragraph 직후 'Audit chain fact 인용 검증 의무' bold lead paragraph 1건 정전화 (~12~18 line, v3.21 3 단계 패턴 정합). 단일 source 전략 (다른 host 변경 0)."
  },
  "options": [
    {
      "id": "O1_archive_with_correction_narrative",
      "approach": "v5.10 audit-2026-05-18/ 4 산출물 안 14 위치 inline 정정 + 정정 cross-ref narrative 추가 (audit chain 산출 = 산출 시점 그대로 보존 + 정정 추가). ROADMAP + PROPOSE 도 동일 패턴.",
      "pros": "산출 시점 hallucination evidence 그대로 보존 = audit trail (memory 정합) + 정정 narrative 안 1:1 매핑 추적성. v5.10 ROADMAP entry summary 안 'L1 component-proposer hallucination' 정합 패턴 (overwrite 후 사실 진술 lesson).",
      "cons": "각 위치 인라인 정정 narrative 길어짐 (~14 위치 × 2 line ≈ 28 line 증가). 산출물 file size 증가."
    },
    {
      "id": "O2_overwrite_full",
      "approach": "v5.10 audit-2026-05-18/ 4 산출물 안 hallucination 위치 전체 overwrite (false → true / A4 gap MEDIUM → 적용 부재로 인한 무효 표지). audit trail 완전 손실.",
      "pros": "산출물 size 변동 최소.",
      "cons": "v5.10 산출 시점 hallucination evidence 손실 = 본 milestone evidence cycle 추적성 손실. memory feedback_subagent_fact_hallucination_correction 'evidence 보존' 원칙 위배. component-proposer hallucination 정정 패턴 (v5.10 L1) 과 비대칭 (그쪽은 overwrite 했으나 산출 결과 = synthesizer 산출 12 항목 표지 부재였음. scanner-output.md 는 agent 직접 산출 = 더 신중한 보존 필요)."
    },
    {
      "id": "O3_meta_correction_md_separate",
      "approach": "v5.10 audit-2026-05-18/scanner-output-correction.md 별도 파일 신규 — hallucination 정정 narrative 통합 1건. 4 산출물 본체 무변경.",
      "pros": "원본 audit chain 산출 무손실. 정정 narrative 단일 source.",
      "cons": "신규 파일 보유 의무. cascade fact 인용 grep 시 본체와 분리됨 = 검색 효율 저하. ROADMAP / PROPOSE 안 인용 정정 = 별도 위치 정정 의무 (본 옵션 단일성 약화)."
    }
  ],
  "options_recommendation": "O1_archive_with_correction_narrative — audit trail 보존 + 1:1 매핑 추적성 + memory 'evidence 보존' 원칙 정합. v5.10 L1 component-proposer hallucination overwrite 패턴 (synthesizer 산출 표지 부재) 과 scanner-output.md (agent 직접 산출 표지 존재) 비대칭 정합. cons (~28 line 증가) 는 lightweight 모드 LOC cap ~1500 안 충분 흡수.",
  "risks_identified": [
    "R1: ARCHITECTURE § 4 끝 paragraph 정전화 위치 안 v5.10 paragraph 와 충돌 시 narrative drift 재발 risk — Stage D D1 정확 위치 (L135 직후 / § 4.1 직전) 결정 + 본 paragraph 안 v5.10 paragraph cross-ref 의무. mitigation = grep 'Narrative cascade drift' 단일 위치 확인.",
    "R2: v5.10 audit-2026-05-18/ 4 산출물 안 14 위치 inline 정정 시 markdown table 안 fact (e.g., scanner L150 표) 정렬 깨짐 risk — Stage F EXECUTE 안 Edit 직후 markdown 시각 검증 (또는 markdownlint pre-commit hook 의존).",
    "R3: ROADMAP v5.10 entry summary 안 'audit-2026-05-18 A4 gap MEDIUM' 정정 시 entry summary 길이 추가 risk — 사실 진술 (A4 → 정정 narrative) 단일 추가, 다른 fact 보존.",
    "R4: 자기참조 cycle 재진입 risk (workflow self-improvement 의 다른 형태) — 본 milestone = audit chain fact 검증 narrative 정전화 = workflow narrative 강화 본질. mitigation = lightweight 모드 적용 + § 6.2 폐지 narrative 정합 + v5.10 cascade drift paragraph 와 패턴 정합 (둘 다 narrative 정전화 만, 절차 변경 부재).",
    "R5: v1.17 audit chain hallucination 부재 사실 진술 검증 (sc_5) 시 v1.17 RESEARCH.md L75 1차 source 외 다른 위치 (DESIGN/REPORT etc.) 안 동일 fact 인용 누락 risk — RESEARCH 단계 v1.17 milestone 산출물 전체 grep 검증 의무. **검증 완료** (위 grep 결과 = v1.17 RESEARCH.md L75 + REPORT.md L56 안 단일 host 1:1 매핑, hallucination 부재 정합)."
  ]
}
```

## narrative

본 RESEARCH 는 v5.11 milestone 의 조사 단일 source. v5.10 audit chain 4 산출물 안 hallucination 위치 14건 정확 grep + v1.17 audit chain 동일 검증 (사용자 sc_5 명시 결정 부분) + narrative 정전화 host 후보 검증 + 4 options 비교 + 5 risks_identified.

### v1.17 audit chain hallucination 부재 검증 (sc_5)

`grep -n "claude_md_in_repo\|claude.md.*부재" upbit/milestones/v1.17/*.md` 결과 = v1.17 RESEARCH.md L75 안 정확 fact 'CLAUDE.md:54 SymbolicLink/install.ps1 narrative' (= 그 시점 line 54 narrative 거주 사실) + REPORT.md L56 안 D8 cascade grep 결과 'CLAUDE.md 단일 host' (= 동일 fact 1:1 매핑) — v1.17 audit chain 정상 작동, hallucination 부재 확정. sc_5 verdict = 사실 진술 (정정 작업 불요).

### v5.10 hallucination 5 차 위치 인용 누적 정확 정량

scanner-output.md (3 위치 = L77 + L150 + L177) → analyzer-output.md (4 위치 = L68~71 + L122 + L137 + L149) → mapper-output.md (3 위치 = L65~77 + L171 + L192) → proposal-draft.md (4 위치 = L34 + L81 + L140 + L172) → ROADMAP v5.10 entry summary (1 위치 'audit-2026-05-18 A4 gap MEDIUM 인용') + v5.10 PROPOSE.md next_candidates#4 (1 위치 origin + rationale 인용) = **총 16 위치 fact 인용 (산출물 안 14 + ROADMAP/PROPOSE 안 2)**.

### options 비교 결정 narrative

O1 (archive with correction narrative) 채택 권장 — audit trail 보존 (memory 정합) + 추적성. O2/O3 cons 흡수. 최종 결정은 Stage D 안.

### untouched_files 부산물 정책 정합 (v3.10)

`untouched_files_explicit` 5건 모두 (a) 사실 진술만 — 후속 milestone 명명 표현 부재. v3.10_stage-byproduct-clarification 정합. 후속 candidate origin 가능성은 Stage I PROPOSE 통합 흡수.

### risks_identified 부산물 정책 정합

`risks_identified` 5건 모두 (a) 사실 진술만 — 'untouched 묶음을 별 milestone 으로' 같이 후속 milestone 명명 표현 부재. v3.10 정합.
