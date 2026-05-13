# INTENT — v4.1

```json
{
  "id": "install-strategy-reaudit",
  "version": "v4.1",
  "title": "Install 전략 자체 재검토 — Windows Developer Mode 강제 chain 분석 + symlink vs copy vs 대안 양상 + onboarding 마찰 정전화",
  "goal": "harness-meta 의 install 전략 (현 default = symlink 기반 배포, bootstrap/agents/CLAUDE.md D7 mechanical sequence 정전) 자체 재검토 — Windows Developer Mode 강제 chain 분석 + 대안 양상 (copy default / sparse checkout / hardlink / WSL / 기타) 검증 + 권장 default 결정 + 실 메커니즘 변경 (D7 sequence rewrite + 모듈 narrative cascade 정전화).",
  "motivation": "사용자 의문 raise (2026-05-13, v4.1 OPEN 직후 APPROVE 게이트 안 본질 의문 — '컴퓨터 설정에서 개발자 모드를 켜야하는거잖아. 왜 이 모드를 켜야하는거야'). v4.0 phase-3 안 bootstrap/agents/CLAUDE.md D7 mechanical sequence 가 'Symlink 시도 → Windows Developer Mode 의무 → macOS/Linux 기본 동작' chain 정전했지만 — 그 chain 의 첫 step 'Symlink 채택' 자체가 진정한 ROI 보유한가, onboarding 마찰 (Developer Mode 강제) 대비 정량 trade-off 정전 narrative 부재. v4.0 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 의 'ecosystem integrator' 책임 안 install 전략 자체가 onboarding 게이트 — 본 게이트 narrative 정전화는 onboarding 자체의 정합성. 본 milestone 은 분석 + 결정 + 실 메커니즘 변경 통합 (사용자 명시 선택, 'option 2 분석 + 결정 + 실 메커니즘 변경 통합').",
  "success_criteria": [
    "RESEARCH 안 install 전략 양상 분석 완료 — 최소 4 후보 (symlink default 현 유지 / copy default 전환 / sparse checkout / WSL 활용) 의 (a) onboarding 마찰 / (b) drift 회피 / (c) cross-platform 호환성 / (d) Claude Code spec 정합 4 축 raw 분석",
    "DESIGN 안 권장 default mechanism 결정 — 4 후보 중 사용자 명시 선택 + 결정 narrative + alternatives_rejected",
    "EXECUTE 안 D7 mechanical sequence rewrite — bootstrap/agents/CLAUDE.md § 'Install / Update / Cleanup 책임' 갱신 (default mechanism + fallback 결정 narrative cascade)",
    "필요 시 ARCHITECTURE.md § 3.1 끝 install 전략 narrative 추가 (단일 source 정합) — '정전화 narrative 3 단계 패턴' (v3.21) 적용",
    "필요 시 bootstrap/skills/CLAUDE.md + claude/CLAUDE.md install 정책 narrative cascade (bootstrap/agents/ 와 동일 전략 적용 의무 — 두 도메인 동일 install 전략 통합)",
    "실 install 검증 — 사용자 환경 (Windows + macOS + Linux 별 D7 sequence) 호환성 narrative 명시 (실 cross-platform 검증은 사용자 환경 의존 — 본 milestone 안 narrative 검증만)",
    "도그푸드 — 본 milestone 자체 install 부재 환경 (메인 Claude 가 Bash 으로 직접 처리 패턴 + ~/.claude/agents/ subagent install 부재 시 Agent tool 호출 패턴) narrative 정합 정전화",
    "pre-commit 전체 PASS + 회귀 0건"
  ],
  "out_of_scope": [
    "Claude Code 자체 onboarding 변경 — 외부 spec (code.claude.com/docs) 영향 외, 본 repo 변경만",
    "v4.0 PROPOSE #5 (dogfood-install-precondition) — 사용자 환경 의존 작업 (사용자 ~/.claude/ 안 실 install), 본 repo ROADMAP 등재 외",
    "이전 v4.1 scope (dev-tools-first-member-add + smoke-bootstrap-agents-add) — 사용자 명시 폐기 결정 (2026-05-13 'v4.1 scope rewrite' 선택), 본 milestone 외. 후속 case 발견 후 재발의 가능.",
    "Windows OS 자체 권한 / 보안 정책 변경 — 외부 환경, 본 repo 영향 외",
    "git submodule / git subtree 활용 — install 전략 후보 4건 외 광범위 검토 회피 (RESEARCH 안 깊이 분석은 사용자 명시 발의 시만)",
    "venv / poetry / npm 패키지 매니저 활용 — harness-meta 정체성 (shell scripts + markdown + json) 정합 외 도구 도입 거부"
  ],
  "dependencies": {
    "predecessors": [
      "v4.0_harness-composer-pivot (D7 mechanical sequence host + bootstrap/{skills,agents}/CLAUDE.md install 정전화 + Static install script 폐기 narrative)"
    ],
    "successors_named_only": [
      "환경별 onboarding 가이드 매트릭스 (Windows / macOS / Linux 별 D7 sequence) — narrative 정전화 후",
      "pre-commit hook install 시 환경 detect 자동화 — 결정된 default mechanism 따라 자동 분기",
      "도그푸드 install precondition narrative (v4.0 PROPOSE #5 carry-over, 사용자 환경 의존 — 본 milestone 외)"
    ],
    "blockers": []
  }
}
```

## narrative

### v4.1 scope rewrite 배경

본 v4.1 은 scope rewrite 결과 — 기존 v4.1_dev-tools-bootstrap (v4.0 PROPOSE #1+#2 bundle, OPEN~DESIGN 4 stage 완료) 가 사용자 의문 raise (APPROVE 게이트 직전 'dev-tools 를 써야하는 이유' + 본질 의문 'Developer Mode 켜야 하는 이유') 후 폐기 결정. commit 부재 상태에서 산출물 삭제 + v4.1 번호 재사용. 이전 v4.1 scope 의 dev-tools 멤버 추가는 ROI 약함 결론 (smoke 만 독립 발의도 가능했고, 본질 의문이 더 강력) — 본 milestone scope rewrite 가 진정한 fleet maintainer 책임 첫 행사 사례.

### Install 전략 = onboarding 게이트

v4.0 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 안 'ecosystem integrator' 책임 핵심 = 사용자 환경 안 ~/.claude/ 통합. 본 통합 메커니즘 (install 전략) 자체가 onboarding 게이트 — harness-meta 사용자가 처음 진입할 때 가장 큰 마찰 발생점. Windows Developer Mode 강제 narrative 가 그 마찰 첫 표지.

### Out-of-scope 부산물 정책 (v3.10)

본 INTENT.out_of_scope entry 6건 모두 negative scope **사실 진술** — '본 milestone 이 무엇이 **아닌가**'. forward propose 명령형 ('별 milestone 으로') 부재. 후속 발의 (예: 환경별 onboarding 가이드 / pre-commit hook 환경 detect 자동화) 는 Stage I PROPOSE 통합 흡수 (v3.10 단일 origin 강제).

## 관련

- 이전 v4.1 scope (폐기): 본 session conversation 안 직접 보존 (commit 부재, audit trail = REPORT lessons_learned 안 narrative)
- v4.0 D7 mechanical sequence host: [`../../../../bootstrap/agents/CLAUDE.md`](../../../../bootstrap/agents/CLAUDE.md) § 'Install / Update / Cleanup 책임'
- v4.0 DESIGN (D7 정전 source): [`../v4.0/DESIGN.md`](../v4.0/DESIGN.md)
- v4.0 PROPOSE #5 (dogfood-install-precondition, 본 의문 trigger): [`../v4.0/PROPOSE.md`](../v4.0/PROPOSE.md)
- bootstrap/skills/CLAUDE.md (두 층 패턴 정합 참조): [`../../../../bootstrap/skills/CLAUDE.md`](../../../../bootstrap/skills/CLAUDE.md)
- claude/CLAUDE.md (글로벌 레이어 install 정책): [`../../../../claude/CLAUDE.md`](../../../../claude/CLAUDE.md)
- 9-stage workflow: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md)
- ARCHITECTURE § 3.1 (정체성 정전 source): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)
