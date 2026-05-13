# execute/phase-1.md — v3.20_drift-narrative-canonicalization

```json
{
  "milestone": "v3.20_drift-narrative-canonicalization",
  "phase": 1,
  "title": "ARCHITECTURE.md drift 수용 paragraph 추가 — § 4 끝 (line 117 직후) + commit",
  "status": "in_progress",
  "design_ref": "DESIGN.md phases[0] (D1~D6 채택)",
  "scope": "ARCHITECTURE.md § 4 line 117 (B/C/D 부산물 흡수 paragraph) 직후 + § 4.1 Bundling 헤더 (line 119) 직전에 'Word-fidelity drift 수용' bold lead paragraph 1건 추가. 정량 cross-ref 3건 (평균 86.1% + APPROVE 100% + PROPOSE 70%) + 9 stage 점수 9건 + drift 의도성 (pragmatic 절충) + § 6.2 동결 정책 cross-ref + v3.19 RESEARCH 1차 source link 포함.",
  "affected_files": [
    "projects/meta/ARCHITECTURE.md (drift narrative paragraph 추가, line 117 직후)",
    "projects/meta/milestones/v3.20/execute/phase-1.md (본 파일)",
    "projects/meta/milestones/v3.20/milestones.md (sub_milestones[0] status complete + commit hash 갱신, commit 직후)"
  ],
  "execution_notes": [
    "DESIGN D2 정확 narrative 문구 그대로 삽입 (DESIGN.md 'Phase 1 정확 narrative 정문구' 섹션 1차 source)",
    "Edit tool 사용 (Write 부재) — line 117 직후 ${B/C/D 부산물 흡수 paragraph} + 빈 줄 + drift paragraph + 빈 줄 + line 119 (§ 4.1 헤더)",
    "markdownlint MD031 (fenced code blocks blank lines) + MD049 (emphasis style) trigger 회피 — paragraph 앞뒤 빈 줄 + asterisk emphasis 정합",
    "commit message: feat(meta): v3.20 phase-1 — ARCHITECTURE.md § 4 drift narrative paragraph 추가 (word-fidelity 86.1%/APPROVE 100%/PROPOSE 70% 정전화)",
    "commit timing 실 운용 (a) 채택 — v3.19 실 운용 패턴 정확 정합 (v3.19 phase-1 commit 514b385 안 INTENT/RESEARCH/DESIGN/APPROVE 4건 + milestones.md + execute/phase-1.md + ROADMAP entry 통합). DESIGN D6 (b) default narrative 와 차이 있으나 v3.19 PROPOSE.next_candidates#4 L4 narrative ('lightweight 1-phase 일 때 commit timing (a) 자연 default') 정합. phase-1 commit = ARCHITECTURE.md + execute/phase-1.md + milestones.md (phase-1 in_progress) + INTENT/RESEARCH/DESIGN/APPROVE / Stage G chore commit 안 VERIFY/REPORT/PROPOSE + milestones.md (status complete + commit hash) + ROADMAP entry status completed + summary 갱신 + execute/phase-1.md status complete 갱신"
  ]
}
```

## 실행 결과 (commit 직후 갱신)

- commit hash: `<commit 직후 채움>`
- pre-commit 14 hook: `<commit 직후 채움>`
- ARCHITECTURE.md LOC delta: `<commit 직후 채움>`
- status: `complete` (commit 후)

## 관련

- DESIGN: [`../DESIGN.md`](../DESIGN.md) (D2 정확 narrative 문구 1차 source)
- INTENT: [`../INTENT.md`](../INTENT.md)
- milestones.md: [`../milestones.md`](../milestones.md)
- ARCHITECTURE insertion target: [`../../../ARCHITECTURE.md`](../../../ARCHITECTURE.md) § 4 끝
