# RESEARCH — v5.3 external-marketplace-registration

```json
{
  "external": [
    {
      "source": "context7 /websites/code_claude — plugin-marketplaces",
      "topic": "GitHub shorthand marketplace registration",
      "findings": [
        "claude plugin marketplace add owner/repo (GitHub shorthand) — 전체 repo 를 clone. relative path source ('./') 가 clone 된 로컬 경로로 해석 가능",
        "URL-based marketplace (https://example.com/marketplace.json) 는 JSON 파일만 download — relative path 실패. GitHub shorthand 와 근본적 차이",
        "Git repository marketplace 는 전체 repo clone → './' 정상 작동. spec 인용: 'host your marketplace in a Git repository to enable cloning of the entire repository'",
        "외부 source plugin entry: { 'source': 'github', 'repo': 'owner/repo' } — URL-based marketplace 전용 권장 (GitHub shorthand 에는 불필요)"
      ],
      "drift": "marketplace.json 'source': './' 는 GitHub shorthand 에서도 정상 작동 — 변경 불필요 (기존 SC1 가정 수정)"
    }
  ],
  "codebase": {
    "affected_files": [
      "README.md — Installation section (lines 34-43): git clone + local marketplace only → GitHub shorthand 추가",
      "AGENTS.md — Installation section (lines 13-19): 동일 업데이트",
      "CLAUDE.md — line 3 (첫 단락 install 명령) + lines 80-83 (설치 섹션): 동일 업데이트",
      "agents/component-installer.md — line 66: marketplace add 명령 업데이트",
      "bootstrap/agents/CLAUDE.md — lines 55, 64-67, 130: install narrative 업데이트",
      "projects/meta/ARCHITECTURE.md — line 73: Install 정책 서술 업데이트",
      "Makefile — lines 15-16: help target 명령 업데이트"
    ],
    "untouched_files": [
      ".claude-plugin/marketplace.json — 'source': './' 는 GitHub shorthand + local 양쪽 정상 작동. 변경 불필요",
      ".claude-plugin/plugin.json — 변경 불필요",
      "claude/ hooks/skills/commands — 변경 불필요",
      "tests/ — smoke 추가 불필요 (문서 cascade 범위)"
    ],
    "current_state": "onboarding 3 step: git clone → marketplace add ~/harness-meta → plugin install. 외부 방문자 clone 필수",
    "target_state": "외부 방문자: 2 step (marketplace add pdw96/harness-meta → plugin install, clone 불요). 로컬 dev: 기존 3 step 유지 (병렬 표기)"
  },
  "options": [
    {
      "id": "A",
      "label": "Documentation cascade only",
      "description": "7 파일 install narrative 에 GitHub shorthand 추가. marketplace.json 무변경. 1 phase.",
      "pros": ["marketplace.json 작동 확인 — 변경 0 risk", "로컬 dev 흐름 보존", "단순 문서 cascade"],
      "cons": ["실 CLI 검증 불가 (harness-meta GitHub repo public 가정 필요)"]
    },
    {
      "id": "B",
      "label": "Documentation cascade + marketplace.json GitHub source 추가",
      "description": "Option A + marketplace.json plugin entry source 를 GitHub source 객체로 교체",
      "pros": ["external source 명시적 선언"],
      "cons": ["로컬 dev 시 plugin 이 GitHub 에서 pull (상대경로 해소 불요화 risk)", "불필요 변경 (spec 상 './' 이미 OK)"]
    }
  ],
  "risks_identified": [
    "R1: GitHub repo pdw96/harness-meta 가 public 이어야 외부 방문자 clone 없이 marketplace add 가능 — private 이면 인증 필요. 사전 확인 필요",
    "R2: marketplace.json 의 marketplace 파일 탐색 경로 — Claude Code 가 .claude-plugin/marketplace.json 을 인식하는지 확인 필요 (v5.0 local 에서 이미 작동하므로 동일 메커니즘 적용 가정)"
  ]
}
```
