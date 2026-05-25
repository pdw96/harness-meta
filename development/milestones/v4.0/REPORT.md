---
id: harness-composer-pivot
title: REPORT v4.0
version: v4.0
stage: REPORT
status: completed
---

# REPORT — v4.0

## Spec

```json
{
  "summary": "harness-meta repo 정체성 전면 재정의 (B2 scope, 8 phase, breaking major bump v3→v4). 'project harness composer + Claude Code ecosystem integrator + agent fleet maintainer' 으로 pivot. 사용자 명시 발의 라운드 9회 (2026-05-13, /clear 직후) — 결정적 이슈 9건 (B2 / 옵션 3 team / b1 / c1 / d2 / e3 + 매트릭스 / B3 install 폐기 / 5 멤버 / 옵션 B 책임 재분담). EXECUTE 10 commits, net -1148 LOC. INTENT.success_criteria 14 PASS + 2 PASS_WITH_NOTE, FAIL 0. pre-commit 14 hook 모두 PASS, smoke 회귀 0. 도그푸드 manual run (D6) 결과 = v4.1+ 후속 candidate 3건 거명만 (in-loop 처리 회피)."
}
```

## Delta

- **files_changed**: phase-1 5 + phase-2 348 (rename 280 + modified) + phase-3 (1/2 1 + 2/2 4) + phase-3 chore 1 + phase-4 2 + phase-5 7 + phase-6 2 + phase-7 3 + phase-8 2 = ~375 files
- **loc_delta**: net -1148 (phase-1 -30 + phase-2 0 + phase-3 -1357 + phase-4 +220 + phase-5 +599 + phase-6 +88 + phase-7 +106 + phase-8 +119 + execute summaries +200)
- **commits**: 10
- **commit_list**: 3991c51 docs(meta): OPEN~APPROVE 산출물 + ROADMAP entry (in_progress), af8b884 feat(meta)!: phase-1 identity 5 host + § 6.2 폐지 + install narrative cleanup (옵션 B), 7107729 chore(meta): phase-2 메타 v1~v3.21 → _archive/ git mv (40 디렉토리) + smoke regex + ROADMAP era 표지, e6bacc2 feat(meta): phase-3 (1/2) bootstrap/agents/ scaffold + CLAUDE.md (정책 narrative), a2c967c chore(meta)!: phase-3 (2/2) install script 3개 폐기 + bootstrap/skills/CLAUDE.md cleanup (B3), 0e93bcc chore(meta): phase-3 execute summary, 0c0d060 feat(meta): phase-4 Claude Code 도구 카탈로그 매뉴얼, acb6f22 feat(meta): phase-5 첫 agent team project-harness-audit-team (5 멤버 + orchestration), d4e034c feat(meta): phase-6 /harness-meta <name> --audit opt-in (D5), abbbee0 feat(meta): phase-7 벤치마크 cycle routine + ROADMAP candidate_draft[] (D4), 523c959 feat(meta)!: phase-8 CHANGELOG [v4.0]! breaking entry + 도그푸드 narrative

## Lessons learned

- **L1** — topic: 옵션 B 책임 재분담 (사용자 round 9 짚음); narrative: DESIGN 안 phase-1 (identity) + phase-3 (bootstrap) 가 같은 host (root CLAUDE.md / AGENTS / README) 두 번 Edit 비효율. 옵션 B 채택 — phase-1 안 install narrative cleanup 통합 (3 host) + phase-3 = bootstrap layer 본질 (+ bootstrap/skills/CLAUDE.md 1 host) 분리. 결과 = 같은 host 두 번 commit 회피, audit trail 명확. 향후 phase 분할 시 host 영향 사전 검토 의무 (DESIGN review_perspectives 안 추가 권고).
- **L2** — topic: B3 install script 폐기 (사용자 round 8 짚음); narrative: 초기 plan 안 install-agents.{ps1,sh} 생성 가정. 사용자 'ps1/sh 가 있는 이유 모름' + 'AI agent 가 mechanical 흡수 가능' 짚음 = 정체성 본질 정합 발현. B3 채택 — install.ps1 + install-skills.{ps1,sh} 3 파일 (-1484 LOC) 모두 폐기, component-installer subagent 흡수. script 미러 부담 자체 소멸 + 정체성 본질 직접 구현. 인프라 자동화 검토 시 agent 흡수 우선 고려 narrative 정전화.
- **L3** — topic: smoke regex archive 허용 (workflow self-improvement 무관); narrative: phase-2 안 smoke-bundle-trigger + smoke-cross-ref regex 안 _archive/ optional 추가 필요. § 6.2 폐지 정합 — 본 변경은 workflow 본문 변경 X (smoke 는 자동화 보조). 향후 archive 디렉토리 추가 시 smoke 자동 skip 의무 검토 패턴 정전화.
- **L4** — topic: self_reference_policy: pivot (§ 6.2 폐지 정합); narrative: v4.0 = § 6.2 동결 정책 자체를 폐지하는 정체성 재정의 milestone. 'avoid' 회피 표지 부적합 → 'pivot' (정체성 전환 표지) 신규 도입. B2 scope 자체가 정체성 본질 직접 구현 = self-reference 회피 자연 (도그푸드 정합). § 6.2 폐지 후 자기참조 가드레일은 새 정체성 그 자체 ('project harness composer' 본질이 자기참조 milestone 거부).
- **L5** — topic: Pre-PLAN 9 round 누적 (사용자 명시 redirect 패턴); narrative: INTENT 작성 직전 7 round + EXECUTE 도중 추가 2 round = 총 9 round. 사용자가 매 round 결정적 이슈 짚음 — '의미 상실 진단 → 정체성 명시 → 결정 6건 → ps1/sh 의문 → B3 + 5 멤버 → 옵션 B'. 사용자 메모리 (반복적 pre-PLAN 검토 선호) 정합. 9 round 모두 absorb 됐고 결과 = 본 INTENT.success_criteria 16건. 향후 큰 milestone 발의 시 라운드 누적 수용 (단축 시 의도 손상 risk).
- **L6** — topic: 도그푸드 Manual reasoning (D6, Agent tool 미등록 회피); narrative: phase-5 산출 5 멤버 subagent 는 ~/.claude/agents/ 안 install 미실행 상태 = Agent tool 의 subagent_type 호출 시 등록 부재. 도그푸드 manual reasoning (메인 Claude 가 system prompt 직접 read + reasoning) 으로 우회. 결과 = proposal draft 3건 모두 v4.1+ 후속 candidate 만 거명 (in-loop 처리 회피). 향후 도그푸드 시점에 ~/.claude/ install 사전 의무 검토.
- **L7** — topic: phase-3 2 commit 분할 (forward + backward); narrative: phase-3 (1/2 bootstrap 신설) + (2/2 install 폐기) 의미 단위 분리. forward (신설) vs backward (폐기) audit trail 효율 + review 자연. 향후 큰 phase (의미 단위 2+) 2 commit 분할 패턴 권장.
- **L8** — topic: model 차별 할당 (component-installer 만 opus); narrative: 5 멤버 중 component-installer (write apply, Bash 화이트리스트 mechanical) 만 model: opus, 나머지 4 멤버 (read-only / Write draft) sonnet. 위험 책임 격상 정합 (D1 security mitigation). 향후 신규 subagent 안 model 선택 = 책임 위험 기반 (write apply 격상 / read-only 표준).

## narrative

### 사용자 명시 발의 9 round 요약

1. 진단 — "harness-meta 의미 상실"
2. (b) 선택 — 정체성 재정의
3. 정체성 명시 — "project harness composer + ..."
4. 결정 6건 (B2 / 옵션 3 / b1 / c1 / d2 / e3 + 매트릭스)
5. B3 + 5 멤버
6. 옵션 B 책임 재분담 (phase-1 + phase-3 host 통합)
7. Pre-PLAN 검토 (DESIGN 진입 전)
8. 승인 + EXECUTE 진입
9. EXECUTE 도중 phase-별 진행 결정

### 8 lessons (L1~L8)

`L1 옵션 B 책임 재분담 / L2 B3 / L3 smoke archive / L4 pivot 표지 / L5 9 round 누적 / L6 도그푸드 manual / L7 2 commit 분할 / L8 model 차별`

### Verdict (VERIFY 흡수)

PASS_WITH_NOTE — 16 criteria 14 PASS + 2 PASS_WITH_NOTE (sc_14 .harness.toml 부재 N/A + sc_15 도그푸드 manual reasoning).

## 관련

- VERIFY: [`VERIFY.md`](VERIFY.md)
- INTENT: [`INTENT.md`](INTENT.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- phase 1~8 execute: [`execute/`](execute/)
- PROPOSE: [`PROPOSE.md`](PROPOSE.md)
