# phase-3 — bootstrap layer 재구성 (옵션 B 후속) — bootstrap/agents/ scaffold + install script 3개 폐기 (B3)

```json
{
  "phase": 3,
  "version": "v4.0",
  "id": "harness-composer-pivot",
  "title": "bootstrap layer 재구성 — bootstrap/agents/ scaffold + CLAUDE.md (정책 narrative) + install script 3개 폐기 + bootstrap/skills/CLAUDE.md cleanup",
  "status": "in_progress",
  "commit": ["e6bacc2", "a2c967c"],
  "split_2_commits": "DESIGN.D7 + 의미 단위 분리 — (1/2) bootstrap 신설 forward / (2/2) install 폐기 backward",
  "changes": [
    "[commit 1/2 = e6bacc2] bootstrap/agents/CLAUDE.md 신규 (121 LOC) — 두 층 구조 (글로벌 bootstrap/agents/ + 프로젝트 특화 projects/<name>/.claude/agents/) + conflict resolution 4 case 매트릭스 + agent fleet lifecycle 5 case 매트릭스 + install/update/cleanup 책임 narrative (component-installer D7 sequence) + 신규 subagent/team 추가 절차 + 벤치마크 cycle narrative (phase-7 placeholder)",
    "[commit 2/2 = a2c967c] install.ps1 + install-skills.ps1 + install-skills.sh 3 파일 삭제 (B3) — 총 1484 line 제거. mechanical 작업은 agent (component-installer) 또는 메인 Claude 가 Bash 직접 진행",
    "[commit 2/2] bootstrap/skills/CLAUDE.md 배포 섹션 cleanup — install-skills 명령 reference 모두 제거 + bootstrap/agents/CLAUDE.md 단일 source cross-ref + 평탄화 책임 narrative (component-installer 흡수)",
    "[commit 2/2] bootstrap/skills/CLAUDE.md 신규 user-skill 추가 절차 4단계 안 install-skills.ps1 reference → Claude Code 자연어 호출 갱신"
  ],
  "affected_files": [
    "bootstrap/agents/CLAUDE.md (신규)",
    "install.ps1 (삭제 -534 line)",
    "install-skills.ps1 (삭제 -610 line)",
    "install-skills.sh (삭제 -340 line)",
    "bootstrap/skills/CLAUDE.md (배포 섹션 + 추가 절차 cleanup, net +6/-15)"
  ],
  "criteria_met": {
    "INTENT_sc_5": "bootstrap/agents/ 디렉토리 신규 (bootstrap/agents/CLAUDE.md 위치 자동 생성) + CLAUDE.md (두 층 + conflict 4 case + fleet 5 case + install 책임 narrative). audit/ + dev-tools/ placeholder narrative 만 (실 멤버 추가는 phase-5)",
    "INTENT_sc_6": "install script 3 파일 폐기 + 4 host narrative cleanup 통합 — phase-1 안 3 host (root CLAUDE.md + AGENTS + README) 완료 + 본 phase-3 안 bootstrap/skills/CLAUDE.md 완료",
    "INTENT_sc_10": "conflict resolution 4 case 매트릭스 narrative 정전화 — bootstrap/agents/CLAUDE.md 단일 host",
    "INTENT_sc_11": "agent fleet lifecycle 5 case 매트릭스 narrative 정전화 — bootstrap/agents/CLAUDE.md 단일 host"
  },
  "smoke_verification": {
    "phase_3_1_commit_e6bacc2": "14 hook 모두 PASS (markdownlint + cross-ref + claude-md-drift PASS, smoke 일부 skipped — no files to check 정합)",
    "phase_3_2_commit_a2c967c": "14 hook 모두 PASS (markdownlint + cross-ref + claude-md-drift PASS, smoke 일부 skipped)"
  },
  "deviations_from_design": [
    "DESIGN phase-3 안 'audit/ + dev-tools/ 카테고리 placeholder' = 빈 디렉토리 가정이었으나, 실제는 bootstrap/agents/CLAUDE.md narrative 안 거명만 + 빈 디렉토리 미생성 (실 멤버 추가는 phase-5). 디렉토리 자동 생성은 component-installer 또는 메인 Claude 가 phase-5 안 첫 멤버 추가 시점에 진행."
  ]
}
```

## narrative

### 2 commit 분할 의미 단위

| Commit | 의미 단위 | LOC 영향 |
|---|---|---|
| 1/2 (e6bacc2) | bootstrap 신설 (forward) — bootstrap/agents/CLAUDE.md 정책 narrative | +121 |
| 2/2 (a2c967c) | install 폐기 (backward) — 3 파일 삭제 + bootstrap/skills/CLAUDE.md cleanup | -1484 / +6 |

순방향 (신설) + 역방향 (폐기) 분리 = audit trail 명확 + 의미 단위 review 자연.

### B3 결정 정합

`install.ps1` (534 line) + `install-skills.ps1` (610 line) + `install-skills.sh` (340 line) = **총 1484 line 제거**. 동일 mechanical 책임은 `component-installer` subagent (phase-5 신규 멤버, D7 sequence 정합) 또는 메인 Claude Bash 호출로 흡수.

기존 사용자 환경 영향:

- `~/.claude/skills/<5 symlink>` 보존 (현 작동 유지) — phase-3 안 변경 0
- 신규 install / reinstall / cleanup 필요 시 = Claude Code 안 자연어 호출 (`harness-meta 설치해줘`)

### 4 host install narrative cleanup 추적

| Host | Phase | 상태 |
|---|---|---|
| `root CLAUDE.md` | phase-1 | ✅ (commit `af8b884`) |
| `AGENTS.md` | phase-1 | ✅ |
| `README.md` | phase-1 | ✅ |
| `bootstrap/skills/CLAUDE.md` | phase-3 (2/2) | ✅ (commit `a2c967c`) |

옵션 B 통합 정합 — 같은 host 두 번 Edit 회피 완전 충족.

## commit (완료)

- **1/2**: `e6bacc2` — `feat(meta): v4.0 phase-3 (1/2) — bootstrap/agents/ scaffold + CLAUDE.md (정책 narrative)`
- **2/2**: `a2c967c` — `chore(meta)!: v4.0 phase-3 (2/2) — install script 3개 폐기 + bootstrap/skills/CLAUDE.md cleanup (B3)`

## 관련

- INTENT: [`../INTENT.md`](../INTENT.md) — success_criteria (5), (6), (10), (11)
- DESIGN: [`../DESIGN.md`](../DESIGN.md) phase-3 + D7 (mechanical sequence)
- bootstrap/agents/CLAUDE.md (단일 source): [`../../../../bootstrap/agents/CLAUDE.md`](../../../../bootstrap/agents/CLAUDE.md)
- bootstrap/skills/CLAUDE.md (cleanup 후): [`../../../../bootstrap/skills/CLAUDE.md`](../../../../bootstrap/skills/CLAUDE.md)
