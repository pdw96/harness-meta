# v6.0 — sub-milestone listing

## Spec

```json
{
  "version": "v6.0",
  "title": "AI Native 운영 reframe + entry title 가이드 정전화 (self-dogfood)",
  "status": "in_progress",
  "trigger": "A_user",
  "sub_milestones": [
    {
      "id": "phase-1-architecture-section-7-and-retitle-and-cascade",
      "title": "ARCHITECTURE § 7 신규 + 7 retitle + cascade 6 host + § 3.1 backward + § 8 shift",
      "status": "in_progress",
      "phase": 1,
      "commit": null
    }
  ]
}
```

## sub-milestone listing

### phase-1: ARCHITECTURE § 7 신규 + 7 retitle + cascade 6 host + § 3.1 backward + § 8 shift

- **scope**: lightweight 모드 1 phase 통합 — (a) `projects/meta/ARCHITECTURE.md` § 7 'AI Native 운영' 신규 (§§ 7.1 정의 + 3 면 매트릭스 + v4.0 cross-ref + §§ 7.2 Entry title 가이드 4 원칙) + 기존 § 7 (관련 문서) → § 8 shift, (b) § 3.1 끝 paragraph 안 신규 § 7 backward cross-ref (D9), (c) `projects/meta/ROADMAP.md` 안 milestones[] 4 entry retitle (v5.20 / v5.19 / v5.21 + v6.0 self-dogfood, D10) + schema_note 안 cross-ref, (d) 본 milestone artifact 4건 title field 동기 갱신 (INTENT/RESEARCH/DESIGN/milestones.md, D10 self-dogfood 통합), (e) `CHANGELOG.md` 안 [v5.20] / [v5.19] / [v5.21] bullet header 동기 retitle + [v6.0] entry 신규, (f) ROADMAP archival (v5.19 entry 제거, CHANGELOG entry 보존 D12), (g) cascade host 6 위치 narrative (root CLAUDE.md / projects/meta/CLAUDE.md + AGENTS.md + README.md + ROADMAP schema_note + CHANGELOG cross-ref, D11)
- **affected_files**: `projects/meta/ARCHITECTURE.md`, `projects/meta/ROADMAP.md`, `CHANGELOG.md`, `CLAUDE.md`, `projects/meta/CLAUDE.md`, `AGENTS.md`, `README.md`, `projects/meta/milestones/v6.0/INTENT.md`, `projects/meta/milestones/v6.0/RESEARCH.md`, `projects/meta/milestones/v6.0/DESIGN.md`, `projects/meta/milestones/v6.0/milestones.md`, `projects/meta/milestones/v6.0/execute/phase-1.md`
- **phase_allowed_tools**: `Write, Edit, Read, Grep`
- **commit**: `feat(meta): v6.0 phase-1 — AI Native 운영 § 7 신규 + entry title 가이드 4 원칙 + ROADMAP/CHANGELOG 7 retitle + cascade 6 host + § 7→§8 shift + § 3.1 backward + v5.19 archival`

## Notes

- **사용자 명시 trigger**: A_user, 2026-05-19 round 안 스무고개 7 round 후 합의. 직접 인용 5건 (INTENT.motivation 안)
- **v6.0 첫 원안 폐기 narrative**: 9-stage 자동 전환 + PoLP — Stage E 직전 사용자 결정 게이트 안 취소. 본 milestone trace = git log 부재 (commit 부재) + INTENT.dep_5 narrative
- **5요소 매핑**: Trace (1차) + Context (2차) — § 3.3 5요소 매트릭스 안 Trace + Context 행 sub-mechanism cross-ref 갱신 (phase 1 안 흡수)
- **버전 bump**: v6.0 major (정체성 차원 신규 — 'AI Native 운영' 신규 § 정전화 + entry title 가이드. v6.x 시리즈 시작)
- **3 관점 검토 (D8, 작은 scope + 비개발자)**: architecture / scope contract / 회귀 risk. spec-drift (RESEARCH ext_1~ext_3 안 검증) + 보안 (side effect 부재) skip
- **시리즈 outline (next_candidates 예약)**: v6.1 (JSON 필드 감축) / v6.2 (cascade 자동 동기) / v6.3 (자율 발의) / v6.4 (hallucination 자동 정정) / v7.0 (3 면 통합)
- **v3.21 narrative 정전화 3 단계 패턴**: cycle 25 도그푸드
