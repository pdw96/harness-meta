# INTENT — v5.3 external-marketplace-registration

```json
{
  "id": "v5.3",
  "title": "외부 marketplace 등록 — claude plugin marketplace add pdw96/harness-meta 표준 명령 추가 (GitHub source onboarding)",
  "goal": "현재 local marketplace (~/harness-meta clone 필수) 만 지원하는 harness-meta onboarding 흐름을 GitHub source marketplace 등록으로 확장하여 오픈소스 방문자가 clone 없이 단일 CLI 명령으로 install 할 수 있도록 한다.",
  "motivation": "v5.0 PROPOSE#5 + v5.1 PROPOSE#2 carry-over. 현 onboarding 은 git clone → marketplace add ~/harness-meta → plugin install 3 step 으로 clone 이 진입 게이트. GitHub source 지원 시 marketplace add pdw96/harness-meta → plugin install 2 step 으로 단축 — 오픈소스 방문자 첫 접촉 마찰 해소.",
  "success_criteria": [
    "SC1: .claude-plugin/marketplace.json 에 GitHub source entry (source='pdw96/harness-meta') 가 추가되거나 외부 marketplace 등록 메커니즘이 확인된다",
    "SC2: README.md onboarding 섹션에 GitHub source 경로 명령 (clone 불요 형태) 이 반영된다",
    "SC3: CLAUDE.md 설치 섹션에 동일 명령이 반영된다",
    "SC4: AGENTS.md (영문 요약) 에 동일 명령이 반영된다",
    "SC5: cascade narrative 갱신이 완료되어 기존 local-only narrative 와 일관성을 유지한다",
    "SC6: 기존 smoke / pre-commit 14 hook 회귀 0"
  ],
  "out_of_scope": [
    "Claude Code 공식 plugin marketplace 서버 등록 (외부 서비스 — Claude Code 팀 관할, 본 milestone 범위 외)",
    "실 GitHub Actions CI/CD 파이프라인 추가",
    "harness-meta repo 자체의 GitHub 설정 변경 (branch protection, Actions 등)"
  ],
  "dependencies": {
    "predecessor": ["v5.2 (agent-functional-path-cleanup) — 완료"],
    "successor": []
  }
}
```
