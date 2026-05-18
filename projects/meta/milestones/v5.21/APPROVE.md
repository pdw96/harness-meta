# APPROVE — v5.21

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-19",
    "approval_summary": "v5.21 milestone (ROADMAP forward-looking 재정의 + CHANGELOG v5.7~v5.20 backfill + completed 41건 archival + cascade 7 host) EXECUTE Stage 진입 승인. INTENT 9 success_criteria + 6 out_of_scope + 5 dependencies 정합 확인. RESEARCH 50 entry baseline + 7 cascade host inventory + 8 risks_identified + 3 options 정합 확인. DESIGN 16 decisions (D1 v5.21 minor / D2 Schema A2 + validation regex / D3 Meta only / D4 3-phase / D5 5 관점 / D6 recent 3건 v5.20+v5.19+v5.18 / D7 deferred 3건 보존 / D8 v6.0 거명 / D9 Keep a Changelog 분류 가이드 / D10 § 4 끝 #3 drift 해소 / D11 Stage I archival cycle + register 책임 분리 아님 / D12 hook 메시지 갱신 + smoke-posttooluse _inactive 인지 / D13 narrative 3 단계 패턴 + markdownlint self-check / D14 milestones.md / D15 ROADMAP convention spec 부재 hardcode / D16 § 4 끝 #2 cross-ref + 매트릭스 row replace) 정합 확인. 5 관점 검토 5/5 pass-with-comments + decisive 0 + P1 6건 + P2 4건 모두 흡수. 사용자 명시 발의 (A_user, 2026-05-19 round 안 'ROADMAP 사전적 의미 = 이정표 미래지향' 명시) + AskUserQuestion 4 round 결정 종합 (archival CHANGELOG / recent 3건 / bump v5.21 minor / 3-phase + 5 관점 / Schema A2 / Meta only / 모두 흡수). v6.0_workflow-automation-and-least-privilege (자동 전환 + PoLP 별 stage) 별 milestone 분리 결정 정합. 매 phase commit 직전 사용자 확인 의무 (CLAUDE.md 룰 정합)."
  }
}
```

## 사용자 결정 round 종합

| Round | 결정 항목 | 사용자 결정 |
|---|---|---|
| Round 1 (방향) | "ROADMAP 사전적 의미 = 이정표 미래지향, 최근 완료 + PROPOSE 제안만 보존" | 사용자 자연어 발의 (A_user) |
| Round 2 (archival) | archival 흡수 위치 | CHANGELOG.md 흡수 |
| Round 2 (recent) | recent 보존 범위 | 최근 3건 |
| Round 2 (bump) | bump 수준 | RESEARCH 안 일임 → D1 v5.21 minor |
| Round 3 (backfill scope) | CHANGELOG v5.7~v5.20 누락 14 entry scope | 합쳐서 한 번에 backfill + ROADMAP 재정의 |
| Round 4 (자동 전환) | MD+JSON 자동 전환 메커니즘 | 자동 전환 + PoLP 별 stage — v6.0 별 milestone 분리 |
| Round 5 (Scope 통합 vs 분리) | v5.21 vs v6.0 | (A) v5.21 = ROADMAP만 + v6.0 = 자동 전환 + PoLP 별 milestone (Recommended) |
| Round 6 (Schema option) | A1/A2/A3 | A2 — milestones[] + next_candidates[] 별도 필드 (Recommended) |
| Round 6 (upbit cascade) | Meta only vs 동기 | Meta only (Recommended) |
| Round 6 (phase + review) | 3-phase + 5 관점 / 2-phase + 3 관점 / 1-phase lightweight | 3-phase + 5 관점 subagent (Recommended) |
| Round 7 (권고 흡수) | P1 6건 + P2 4건 흡수 | 모두 흡수 후 APPROVE 진입 (Recommended) |
| Round 8 (APPROVE 게이트) | EXECUTE 진입 승인? | Approve — EXECUTE phase-1 진행 (Recommended) |

## EXECUTE 진입 전 게이트 확인

- INTENT/RESEARCH/DESIGN/milestones.md 4 산출물 정합 (smoke-spec-verification 가능)
- 5 관점 검토 5/5 pass-with-comments, decisive 0
- P1 6건 + P2 4건 모두 DESIGN 안 흡수 완료
- 사용자 명시 승인 받음 (2026-05-19)

EXECUTE phase-1 (CHANGELOG.md v5.7~v5.20 14 entry backfill) 진행. 매 phase commit 직전 사용자 확인 의무 유지.

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- milestones.md: [`milestones.md`](milestones.md)
