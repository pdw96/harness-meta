# RESEARCH — v5.10 external-audit-team-second-call-with-diff

```json
{
  "id": "v5.10_external-audit-team-second-call-with-diff",
  "external": [
    {
      "source": "harness-meta repo projects/upbit/audit-2026-05-14/proposal-draft.md (commit 16722fd, 511 LOC)",
      "topic": "v1.17 audit chain 5 멤버 sequence 1차 호출 산출물",
      "findings": "Step 1~4 (scanner → analyzer → mapper → proposer) 완전 호출 + Step 5 (installer) ACCEPT ALL apply. 12 항목 결정 확정 = G1 plugin.json / G2/F5 backup 2건 삭제 / G3 CLAUDE.md narrative / G5/F1 trading-safety-checker / G6 paper-trading-gate / G8 quality.yml security 2 step / F2 harness-verifier scope / F6 harness-grey-area scope / C1 harness-review SKILL description / 11 git mv. SPIKE 보류 4건 (S1 mypy / S2 MCP tool / S3 hook stdin / S4 dispatcher).",
      "drift": "본 milestone scope contract = audit-2026-05-14 = first call evidence (사실). 본 v5.10 = second call."
    },
    {
      "source": "harness-meta repo projects/meta/milestones/v5.8/RESEARCH.md L20 + L81 + L172",
      "topic": "v5.8 RESEARCH 안 'audit-team 호출 0건' drift 정정 evidence",
      "findings": "v5.8 RESEARCH 첫 round 진단 '외부 audit-team 호출 0건' 부정확 → 본 RESEARCH 안 R2 정정 (upbit v1.17 evidence 1건). 정정 후 부합도 60% → 65%, vector 정확 = 12/13 = 92.3% self-loop / 1/13 = 7.7% 외부. v5.8 자체가 drift 1차 catch + 정정 완료 narrative.",
      "drift": "v5.8 origin 정정 사실 = 정확 (정정 narrative 신뢰)."
    },
    {
      "source": "harness-meta repo projects/meta/milestones/v5.9/PROPOSE.md L39 + L63",
      "topic": "v5.9 PROPOSE.next_candidates#5 cascade drift",
      "findings": "v5.9 PROPOSE.next_candidates#5 (`external-audit-team-first-call`) rationale 안 'v4.0 도입 후 호출 0건' 진술. v1.17 (2026-05-14) audit chain 완전 실행 사실과 모순 + v5.8 RESEARCH 가 이미 정정한 fact 의 cascade 누락. v5.9 INTENT.out_of_scope L28 ('first 시도 — v5.8 out_of_scope 누적 carry-over') 도 동일 cascade drift.",
      "drift": "**confirmed cascade drift** — v5.8 정정 fact → v5.9 carry-over 시 cascade 누락 → 'first / 0건' 재발. 본 v5.10 정정 대상."
    },
    {
      "source": "harness-meta repo agents/project-harness-audit-team/CLAUDE.md (D8 sequence orchestration)",
      "topic": "audit-team 5 멤버 chain orchestration spec",
      "findings": "Step 1 project-scanner (read-only) → Step 2 harness-gap-analyzer (8 gap + 6 conflict + 6 fleet evolution) → Step 3 claude-docs-mapper (context7 매핑) → Step 4 component-proposer (proposal-draft) → 사용자 결정 게이트 (e3 정책) → Step 5 component-installer (mechanical apply). 본 v5.10 read-only scope = Step 1~4 만 호출, Step 5 미호출.",
      "drift": "spec 일치, drift 부재."
    },
    {
      "source": "claude/commands/harness-meta.md Stage A `--audit` opt-in 분기 narrative",
      "topic": "/harness-meta upbit --audit 분기 명령",
      "findings": "Stage A entry 직후 conditional 분기. `--audit` flag 명시 시 audit chain 호출 → proposal-draft 산출 → 사용자 결정 게이트 → ACCEPT 시 installer 호출. 본 v5.10 = read-only 강제 (proposer 까지) + 사용자 결정 게이트에서 REJECT (installer 호출 부재).",
      "drift": "본 milestone INTENT.sc_8 (installer 미호출 + upbit 실 파일 변경 0건) 강제 게이트 적용."
    },
    {
      "source": "upbit repo milestones/v1.17/REPORT.md (7 lessons L1~L7)",
      "topic": "v1.17 7 lessons 안 audit-team 호출 narrative 정전",
      "findings": "L1 = audit team 5 멤버 sequence narrative 정전 / L2 = 5 관점 review 의견 충돌 해소 = 자체 표준 grep 검증 / L3 = git mv 디렉토리 단위 / L4 = `.claude-plugin/` + `.claude/` dual layout 분리 / L5 = cascade grep 단일 host / L6 = audit team result + 9-stage workflow 산출물 통합 흡수 / L7 = 외부 적용 13번째 + § 6.2 폐지 fleet 정합. 본 v5.10 안 diff 비교 시 L1~L7 fact 와 재실행 결과 1:1 cross-check 가능.",
      "drift": "v1.17 lessons evidence 풍부 = 본 v5.10 diff scope 정합."
    }
  ],
  "codebase": {
    "affected_files_explicit": [
      "projects/meta/milestones/v5.10/INTENT.md (작성됨)",
      "projects/meta/milestones/v5.10/RESEARCH.md (본 파일)",
      "projects/meta/milestones/v5.10/DESIGN.md (Stage D)",
      "projects/meta/milestones/v5.10/APPROVE.md (Stage E)",
      "projects/meta/milestones/v5.10/execute/phase-{n}.md (Stage F)",
      "projects/meta/milestones/v5.10/VERIFY.md (Stage G)",
      "projects/meta/milestones/v5.10/REPORT.md (Stage H)",
      "projects/meta/milestones/v5.10/PROPOSE.md (Stage I)",
      "projects/meta/milestones/v5.10/milestones.md (작성됨, phase 확정 후 갱신)",
      "projects/meta/ROADMAP.md (v5.10 entry 추가됨, Stage I 시점 status: completed 갱신)",
      "projects/meta/milestones/v5.10/audit-output/ (audit chain 재실행 산출물 예상 위치 — proposal-draft.md + scanner/analyzer/mapper intermediate snapshot)",
      "projects/meta/ARCHITECTURE.md (narrative 정전화 위치 후보, Stage D 결정)"
    ],
    "untouched_files_explicit": [
      "upbit repo 일체 (read-only 강제, INTENT.sc_8) — milestones/v1.17/ + .claude-plugin/ + .claude/ + src/ 등",
      "agents/project-harness-audit-team/* (agent definition 변경 부재, INTENT.OOS#3)",
      "v1.17 audit-2026-05-14/proposal-draft.md (historical fact 보존, INTENT.OOS#2)",
      "agents/{project-scanner,harness-gap-analyzer,claude-docs-mapper,component-proposer,component-installer}.md (호출만, 정의 변경 부재)"
    ],
    "current_state": "v5.9 완료 시점 (2026-05-17). v5.9 PROPOSE.next_candidates#5 사용자 선택 → v5.10 OPEN 진입. v1.17 사실 발견 → scope rewrite (Option B).",
    "target_state": "v5.10 완료 시점 — (1) audit chain 4 멤버 재호출 산출물 produced / (2) v1.17 audit-2026-05-14/proposal-draft.md 와 본 milestone 산출 proposal-draft diff 비교 결과 documented / (3) v5.9 PROPOSE.next_candidates#5 cascade drift narrative 정전화 (ARCHITECTURE.md 안 1 paragraph)."
  },
  "options": [
    {
      "id": "O1",
      "title": "audit chain 4 멤버 실제 호출 (Recommended, INTENT 정합)",
      "pros": "ecosystem integrator vector 운용 evidence 강력 (호출 2건 누적) / v1.17 diff 실 evidence / narrative drift 정정 + 실 검증 통합",
      "cons": "LOC + 시간 cost (Agent 4 회 호출) / 산출물 disposal 책임 (audit-output/ 디렉토리)",
      "verdict": "채택 (INTENT.success_criteria sc_1~sc_2 강제)"
    },
    {
      "id": "O2",
      "title": "audit chain 호출 부재, v1.17 산출물만 재사용 + drift 정정",
      "pros": "cost 최소 / lightweight 정합",
      "cons": "second call evidence 부재 → INTENT.sc_1 미충족 / ecosystem integrator vector 운용 evidence 부재 / 시간 경과 diff 부재",
      "verdict": "기각 (sc_1 위배)"
    },
    {
      "id": "O3",
      "title": "audit chain 5 멤버 (installer 포함) 호출 + 사용자 게이트 REJECT",
      "pros": "5 멤버 chain 완전 호출 evidence",
      "cons": "installer 호출 자체가 read-only 위배 risk (사용자 게이트가 REJECT 보장 못 함, agent 자체 동작) / INTENT.OOS#1 모순",
      "verdict": "기각 (OOS#1 위배)"
    }
  ],
  "risks_identified": [
    "R1: audit chain 재호출 시 v1.17 결과와 큰 diff 발생 (Claude Code docs / upbit repo state 변화) → diff 분석 LOC 증가, lightweight 모드 trade-off 압박. mitigation: diff 결과 narrative 만 (정량 항목 1:1 매핑 표) + 정정 권고는 PROPOSE next_candidates 거명만.",
    "R2: v5.8/v5.9 narrative drift 정정 위치 결정 분기 (ARCHITECTURE.md 안 § 3.1 끝 / § 4 끝 / 신규 § 위치) → DESIGN.decisions 안 D1 결정. mitigation: AskUserQuestion 으로 위치 옵션 제시.",
    "R3: audit chain 호출 후 audit-output/ 디렉토리 신규 (실 commit 시점) — pre-commit smoke 가 audit-output/ 영역 검사 안 되도록 .markdownlintignore 등재 필요. mitigation: phase 첫 commit 안 .markdownlintignore 갱신 (v1.17 패턴 정합).",
    "R4: ecosystem integrator vector evidence 강조 narrative 가 도그푸드 위배 가능 (v4.0 § 6.2 폐지 정신 부합 — workflow self-improvement 본질 부재). mitigation: 본 v5.10 = audit-team 외부 호출 본질 + narrative drift 정정 본질 = ecosystem integrator 정체성 vector 운용 + evidence-base 진단 reliability 회복 = 부합 자연.",
    "R5: lightweight 모드 vs 정식 5 관점 검토 결정 분기. mitigation: DESIGN.decisions 안 사용자 결정 (lightweight 누적 13/26 = 50% 정합 검토)."
  ]
}
```

## narrative

### External evidence 6건 흡수

1. v1.17 audit-2026-05-14/proposal-draft.md = first call 사실 + 12 항목 ACCEPT ALL apply
2. v5.8 RESEARCH 정정 narrative (audit-team 0건 → 1건, 부합도 65% upgrade)
3. v5.9 PROPOSE.next_candidates#5 cascade drift (v5.8 fact cascade 누락 → 'first/0건' 재발) ← **본 v5.10 정정 대상**
4. audit-team CLAUDE.md (D8 sequence orchestration spec)
5. claude/commands/harness-meta.md `--audit` opt-in 분기 narrative
6. v1.17 REPORT.md 7 lessons (diff 비교 1차 source)

### Cascade drift root cause 진단

v5.8 RESEARCH (R2/L172) = 정정 origin (외부 audit-team 호출 1건 = upbit v1.17). v5.9 carry-over 시 v5.8 PROPOSE.next_candidates#1 = 'audit-team 호출 2번째' 정확 표현 → v5.9 INTENT.out_of_scope + PROPOSE.next_candidates#5 cascade 시 '1번째 → 0건 / first 시도' 재 misclassification → cascade drift.

핵심 = **정전화 narrative cascade 시 fact 검증 부재** → 같은 fact 정정 다시 필요. drift 정정 1회 후 fragile.

### Read-only 강제 game plan

- audit-team 호출은 scanner → analyzer → mapper → proposer 4 멤버까지만
- installer 호출 부재 → upbit repo 실 파일 변경 0건 강제
- 결과 산출 = `projects/meta/milestones/v5.10/audit-output/proposal-draft.md` (harness-meta repo 안 본 milestone 디렉토리)

### Risks 5건 mitigation 요약

R1 diff LOC → narrative 만 + 정량 표 / R2 정정 위치 → DESIGN.D1 / R3 audit-output/ → .markdownlintignore / R4 도그푸드 위배 → ecosystem integrator vector 부합 자연 / R5 lightweight 결정 → DESIGN 안 사용자 결정.
