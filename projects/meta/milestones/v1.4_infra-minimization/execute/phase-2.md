# EXECUTE phase-2 — v1.4_infra-minimization

```json
{
  "phase": 2,
  "title": "tests/CLAUDE.md 매트릭스 narrative 강화 (active vs inactive + 회귀 차단 책임 + smoke-projects-scope-discipline drift 정정)",
  "status": "in_progress",
  "commit": null,
  "scope_from_design": "DESIGN.phases[1] — narrative 1차 source 위치 명시 강화. 매트릭스 표 narrative '회귀 차단 책임' enum (active = pre-commit 강제 / inactive = manual run leverage 가능) 명시 + 핵심 정책 검증 카테고리에 smoke-projects-scope-discipline row 추가 (drift 1건 정정) + 매트릭스 헤더 직후 narrative 1차 source 명시 paragraph 추가. L7 count 동기는 Phase 1 cover 완료, Phase 2 는 narrative 강화 단일 책임.",
  "affected_files": [
    "tests/CLAUDE.md (3 부분 갱신: L7 직후 narrative paragraph 추가 / 핵심 정책 검증 표 smoke-projects-scope-discipline row 추가 / 현행 hook 현황 § 직후 inactive 22 회귀 차단 책임 paragraph 추가)",
    "projects/meta/milestones/v1.4_infra-minimization/execute/phase-2.md"
  ],
  "changes": [
    {
      "file": "tests/CLAUDE.md",
      "edits": [
        {
          "anchor": "L7 '## smoke 매트릭스 (현 27 파일)' 직후 (L8 빈 줄 + L9 '### 핵심 정책 검증' 사이)",
          "action": "insert standalone block (1 paragraph quoted)",
          "new_content": "> **narrative 1차 source**: 본 매트릭스는 회귀 차단 책임의 narrative 1차 source. ARCHITECTURE.md § 3.3 'Verification' 행 정전 분류 (narrative 우위) 가 본 매트릭스에 매핑 — pre-commit hook 5 active = narrative 보조 (자동화 강제), inactive 22 = manual run leverage (사용자 명시 게이트). 신규 smoke 등재 시 회귀 차단 책임 명시 의무."
        },
        {
          "anchor": "핵심 정책 검증 표 (L11~L17) 마지막 row '`smoke-broad-bash-fine-grain.sh`' 직후 (L18 빈 줄 직전)",
          "action": "append row to table",
          "new_content": "| `smoke-projects-scope-discipline.sh` | root ROADMAP thin index 강제 — milestones[] 키가 root 에 직접 등재되지 않고 `projects/<name>/ROADMAP.md` 에만 (v1.1_meta-as-project) | ❌ |"
        },
        {
          "anchor": "§ '현행 hook 현황' 표 (L229~L239) 직후",
          "action": "append paragraph",
          "new_content": "**inactive 22 의 회귀 차단 책임**: 위 5 active 외 22 smoke 는 `.pre-commit-config.yaml` 미연결 — pre-commit 강제 회귀 차단 의무 부재. narrative 1차 source 위치 = 본 매트릭스 § 'smoke 매트릭스' 의 카테고리 표 거명 → 사용자 manual run leverage (`bash tests/<smoke>.sh` 또는 `pre-commit run <smoke>`) 가능. 회귀 차단 의무는 사용자 명시 게이트 (DESIGN.decisions / 운영 문서) 가 1차, smoke 인프라 는 2차 보조 — ARCHITECTURE.md § 3.3 'Verification' 정전화 정신 직접 적용."
        }
      ],
      "rationale": "narrative 1차 source 위치를 매트릭스 표 자체에서 명시 강화. 카테고리 표 drift 1건 정정 (smoke-projects-scope-discipline). active vs inactive 회귀 차단 책임 enum 명문화 — Phase 3 ARCHITECTURE § 3.3 (c) 정전 갱신 시 'tests/CLAUDE.md 매트릭스에 회귀 차단 책임 명시' cross-ref 의 사실 근거."
    }
  ],
  "expected_commit_message": "feat(meta): v1.4 phase-2 — tests/CLAUDE.md 매트릭스 narrative 강화 (active vs inactive 회귀 차단 책임 + smoke-projects-scope-discipline drift 정정)",
  "verification_post_commit": [
    "grep '> \\*\\*narrative 1차 source\\*\\*' tests/CLAUDE.md → 1 hit (L8 직후 quoted block 추가 확인)",
    "grep 'smoke-projects-scope-discipline' tests/CLAUDE.md → 2+ hit (핵심 정책 검증 표 + 현행 hook 현황 표)",
    "grep 'inactive 22 의 회귀 차단 책임' tests/CLAUDE.md → 1 hit (§ 현행 hook 현황 직후 paragraph)",
    "pre-commit run --all-files → 5 hook PASS (특히 smoke-claude-md-drift smoke count 정합 검증)"
  ],
  "execution_notes": null
}
```

## 진행

phase-2 = tests/CLAUDE.md 3 부분 갱신. (1) 매트릭스 헤더 직후 narrative 1차 source paragraph + (2) 핵심 정책 검증 표 smoke-projects-scope-discipline row 추가 (drift 1건 정정) + (3) 현행 hook 현황 § 직후 inactive 22 회귀 차단 책임 paragraph. Phase 3 ARCHITECTURE § 3.3 'Verification' (c) 정전 갱신 시 'tests/CLAUDE.md 매트릭스에 회귀 차단 책임 명시' cross-ref 의 사실 근거 확보.
