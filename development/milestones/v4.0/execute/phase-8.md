# phase-8 — CHANGELOG.md [v4.0]! breaking entry + 도그푸드 narrative (실 run = VERIFY 시점)

```json
{
  "phase": 8,
  "version": "v4.0",
  "id": "harness-composer-pivot",
  "title": "CHANGELOG.md [v4.0]! breaking entry + README semver narrative (phase-1 안 흡수 완료) + 도그푸드 검증 narrative",
  "status": "in_progress",
  "commit": null,
  "changes": [
    "CHANGELOG.md 안 [v4.0]! - 2026-05-13 entry 추가 — [Unreleased] 직후 + [v3.16] 직전. breaking `!` 마커 + Breaking changes 4건 (정체성 + § 6.2 폐지 + B3 + 메타 archive) + Added 6건 (bootstrap/agents/ + catalog + 5 멤버 team + --audit + 벤치마크 cycle) + Changed 3건 + Removed 4건 + Migration narrative (기존 5 symlink 보존)",
    "README semver narrative — phase-1 안 tagline 갱신으로 흡수 완료 (v4.0 B3 표지 포함). 추가 narrative 불필요",
    ".harness.toml schema bump 검토 — 본 repo 안 .harness.toml 부재. 외부 프로젝트 의 schema 는 사용자 환경 의존 — 본 repo 변경 영향 0",
    "도그푸드 narrative — phase-8 안 실 run 미실행 (Agent tool 안 본 repo 의 5 멤버 subagent_type 미등록, 실 호출 불가). 도그푸드 manual run 은 VERIFY (Stage G) 시점에 메인 Claude reasoning 으로 진행 — proposal draft 보존, v4.1+ 후속 candidate 만 거명, in-loop 처리 금지 (D6 narrative 정합)"
  ],
  "affected_files": [
    "CHANGELOG.md ([v4.0]! breaking entry +~50 line)",
    "projects/meta/milestones/v4.0/execute/phase-8.md (본 파일, 신규)"
  ],
  "criteria_met": {
    "INTENT_sc_13": "semver major bump (v3 → v4) — CHANGELOG.md [v4.0]! entry breaking `!` 마커 + 4 Breaking changes narrative. README tagline 안 v4.0 B3 표지 (phase-1 흡수). .harness.toml schema 부재 (본 repo) — bump 불필요",
    "INTENT_sc_14_partial": "도그푸드 검증 narrative — 본 phase-8 안 narrative 만, 실 run = VERIFY 시점 manual reasoning (D6 정합). audit-team 이 audit-team 자신 모순 회피 (in-loop 처리 금지)"
  },
  "deviations_from_design": [
    "도그푸드 실 run 시점 — DESIGN phase-8 안 'Manual run' narrative 였으나 실제 phase-8 시점에는 Agent tool 으로 본 repo 의 5 멤버 subagent_type 호출 불가능 (~/.claude/agents/ 안 install 미실행, 본 세션 안 등록 부재). 따라서 manual run = VERIFY (Stage G) 시점 메인 Claude reasoning. D6 narrative 정합 (Manual 강조, scripted 회피)"
  ]
}
```

## narrative

### Breaking change 명시 정합

CHANGELOG.md [v4.0]! entry 의 `!` 마커 = Keep a Changelog v1.1.0 본 repo 컨벤션 (line 7 narrative: "`!` after a version marker denotes a breaking change"). 4 Breaking changes:

1. 정체성 전면 재정의
2. § 6.2 동결 정책 폐지
3. install script 3개 폐기 (B3)
4. 메타 milestone 40 디렉토리 → `_archive/`

### 도그푸드 narrative (실 run 시점 = VERIFY)

본 phase-8 안 도그푸드 실 run 미실행 — Agent tool 으로 본 repo 의 5 멤버 (project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer / component-installer) `subagent_type` 호출 시점은 `~/.claude/agents/` 안 install 완료 후 (component-installer 실 호출 후) 가 자연. 본 세션 안에서는 사용자 자연어 호출 (`harness-meta 설치해줘`) 이 미실행 = `~/.claude/agents/` 안 5 멤버 부재.

따라서 **도그푸드 manual run = VERIFY (Stage G) 시점** 메인 Claude reasoning (5 멤버 markdown 안 system prompt 직접 읽고 manual 진행). 결과 = `VERIFY.md` 안 도그푸드 섹션 — proposal draft 보존, v4.1+ 후속 candidate 만 거명 (in-loop 처리 금지, D6 narrative 정합).

### 도그푸드 manual run 절차 (VERIFY 시점 예고)

1. 메인 Claude 가 `bootstrap/agents/audit/project-harness-audit-team/project-scanner.md` 안 system prompt 읽고 본 repo 메타데이터 추출 reasoning
2. 결과 → `harness-gap-analyzer.md` system prompt 입력 (3 축 gap detection reasoning)
3. → `claude-docs-mapper.md` system prompt 입력 (도구 카탈로그 매핑 reasoning)
4. → `component-proposer.md` system prompt 입력 (proposal draft markdown 생성)
5. → **사용자 게이트** (VERIFY 시점에 사용자 명시 결정 대기, 도그푸드 모순 회피)
6. → `component-installer.md` 호출 skip (도그푸드 첫 적용 후 본 repo 안 추가 변경 금지 — in-loop 처리 회피)

## commit (pending 사용자 확인)

```
feat(meta)!: v4.0 phase-8 — CHANGELOG.md [v4.0]! breaking entry + 도그푸드 narrative

CHANGELOG.md 안 [v4.0]! - 2026-05-13 entry 추가 — breaking `!` 마커 + 4 Breaking
changes (정체성 + § 6.2 폐지 + B3 install 폐기 + 메타 archive) + 6 Added + 3 Changed
+ 4 Removed + Migration narrative.

README tagline 안 v4.0 표지 = phase-1 흡수 완료. .harness.toml schema bump 불필요
(본 repo 안 .harness.toml 부재).

도그푸드 실 run = VERIFY (Stage G) 시점 manual reasoning (D6 정합). 5 멤버
subagent_type 본 세션 등록 부재 — ~/.claude/agents/ install 후 가능. in-loop
처리 회피.
```

## 관련

- INTENT: [`../INTENT.md`](../INTENT.md) — success_criteria (13), (14 부분)
- DESIGN: [`../DESIGN.md`](../DESIGN.md) D6 (도그푸드)
- CHANGELOG.md (variation host): [`../../../../CHANGELOG.md`](../../../../CHANGELOG.md)
- 도그푸드 실 run 시점: VERIFY.md (Stage G, 다음 stage)
