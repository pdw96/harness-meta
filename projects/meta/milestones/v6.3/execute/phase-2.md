---
phase: 2
status: completed
---

# v6.3 EXECUTE phase-2 — corrective 41건 + .pre-commit-config.yaml 등재 + cascade + archival

## Spec

```json
{
  "phase": 2,
  "name": "corrective 41+3건 일괄 정정 + .pre-commit-config.yaml hook 등재 + ARCHITECTURE § 7.2 paragraph + CHANGELOG [v6.3] entry + ROADMAP archival cycle + MILESTONE.md VERIFY/REPORT/PROPOSE H2",
  "status": "completed",
  "changes": [
    {"file": "projects/meta/ROADMAP.md", "action": "updated", "loc": "4 retitle (v6.0 + v1.5 deferred + 2 next_candidates) + v6.0 archive (CHANGELOG 이전) + recent 3 = v6.3+v6.2+v6.1", "purpose": "corrective + archival cycle 4번째 사례 (v5.21+v6.0+v6.2+v6.3)"},
    {"file": "projects/upbit/ROADMAP.md", "action": "updated", "loc": "15 entry retitle (v1.20~v1.7)", "purpose": "corrective scope ROADMAP + CHANGELOG 모두 cover (사용자 결정 정합)"},
    {"file": "CHANGELOG.md", "action": "updated", "loc": "21 bullet retitle + 3 잔존 미세 정정 + [v6.3] entry 신규 (Added 3 + Changed 3 + Documented 5)", "purpose": "Keep a Changelog v1.1.0 정합 release note + corrective"},
    {"file": "projects/meta/ARCHITECTURE.md", "action": "updated", "loc": "§ 7.2 4 원칙 paragraph 안 'smoke 자동 강제 정전화 — (1)+(2) auto / (3)+(4) AI 판단 위임' 1 paragraph 추가", "purpose": "narrative 정전화 (v3.21 cycle 28 도그푸드 1차 source)"},
    {"file": ".pre-commit-config.yaml", "action": "updated", "loc": "smoke-entry-title-guideline hook 등재 (local 7→8, CHANGELOG-trigger 첫 도입)", "purpose": "pre-commit 자동 강제 활성화 — D11 정합"},
    {"file": "projects/meta/milestones/v6.3/MILESTONE.md", "action": "updated", "loc": "VERIFY + REPORT + PROPOSE 3 H2 작성 + status='in_progress'→'completed' (ROADMAP 안)", "purpose": "milestone 완료 표지"},
    {"file": "projects/meta/milestones/v6.3/execute/phase-2.md", "action": "created", "loc": "~70 line", "purpose": "phase-2 별책 narrative"}
  ],
  "verification": {
    "smoke-entry-title-guideline": "PASS (0 violations) — corrective 41+3건 정정 후",
    "smoke-claude-md-drift": "PASS 13/13 (smoke count 정합 8)",
    "pre-commit_run_all_files": "PASS (upstream 4 + local 8 = 12 hook)",
    "v6.3_self_title": "PASS (22자, ' + ' 부재)",
    "controlled_4_step": "phase-1 self-check 정합 PASS"
  }
}
```

## Phase-2 narrative

### Corrective 41+3건 정정 결과

| Source | 정정 entries (sample) |
|---|---|
| meta ROADMAP (4) | v6.0 'AI Native 운영 reframe 정전화' (22자) / v1.5 deferred 'RESEARCH cascade grep 패턴 강화 (relative/절대/symlink)' (52자) / next_candidates[0] 'post-report-write hook 자동 flattened era 분기' (46자) / next_candidates[2] 'spec-drift 검토 regex 와 실 사용 함께 검증 가이드라인' (35자) |
| upbit ROADMAP (15) | v1.20 'upbit audit cycle 4 proposal R1+R2 bundled 적용' (47자, R1+R2 false-positive guard 작동) / v1.19~v1.7 (14 retitle, 각 30~52자 단축) |
| CHANGELOG bullet (21+3) | L31~L241 (21 retitle, ' + ' → '/'/'—'/괄호 변환 + 80자 초과 단축) + 잔존 3 미세 정정 (61자 → 56자 이하: L72/L131/L143) |

### Cascade 5 host (D14 정합)

1. ARCHITECTURE.md § 7.2 paragraph 안 'smoke 자동 강제 정전화' 추가 ✓
2. tests/CLAUDE.md 통합 (L7 caption + 매트릭스 row + 현행 hook 표 row) — phase-1 안 ✓
3. .pre-commit-config.yaml hook 등재 ✓
4. CHANGELOG.md [v6.3] entry ✓
5. ROADMAP archival cycle (v6.0 entry 제거 + recent 3 = v6.3+v6.2+v6.1) ✓

### Commit 메시지 draft

```
feat(meta): v6.3 phase-2 — corrective 41+3건 + cascade + archival cycle

v6.3 entry-title-guideline-smoke-verification phase-2 — entry title 가이드
(1) ' + ' + (2) ≤ 60자 자동 강제 활성화 + corrective 일괄 정정.

Corrective (41+3 retitle):
- meta ROADMAP 4 (v6.0 + v1.5 deferred + 2 next_candidates)
- upbit ROADMAP 15 (v1.20~v1.7)
- CHANGELOG bullet 21 + 잔존 3 미세 정정 (61자→56자 이하)

Cascade 5 host:
- ARCHITECTURE § 7.2 paragraph 안 'smoke 자동 강제 정전화' 추가
- .pre-commit-config.yaml hook 등재 (local 7→8, CHANGELOG-trigger 첫 도입)
- CHANGELOG [v6.3] entry (Added 3 + Changed 3 + Documented 5)
- ROADMAP archival cycle 4번째 (v6.0 archive, recent 3 = v6.3+v6.2+v6.1)
- MILESTONE.md VERIFY + REPORT + PROPOSE 작성

smoke 검증: 0 violations (corrective 41+3 정정 후) + pre-commit 12 hook PASS
+ v6.3 자체 entry 22자 PASS + smoke-claude-md-drift 13/13.

v3.21 narrative 정전화 3 단계 패턴 cycle 28 도그푸드 완성.
AI Native § 7.1 Verification 면 첫 실 적용 milestone.

5 관점 P2 14건 PROPOSE Spec 안 거명만 (lightweight 정책 정합).

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
```

## Cross-ref

- 상위: [`../MILESTONE.md`](../MILESTONE.md) (INTENT + RESEARCH + DESIGN + APPROVE + VERIFY + REPORT + PROPOSE)
- 직전: [`phase-1.md`](phase-1.md) (smoke + cascade tests/CLAUDE.md + self-check)
