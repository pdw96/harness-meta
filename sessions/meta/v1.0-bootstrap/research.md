# Step 0 — Claude Code 공식 문서 조사 결과

본 세션 설계 결정 확정용. 모든 답은 2026-04-24 기준 <https://code.claude.com/docs/en/> 공식 문서 출처.

---

## Q1. `@` import 구문 지원 범위 (G11 해소)

**결과**:
- **절대경로 O**, **상대경로 O** (import된 파일 기준, CWD 아님)
- **`@~/...` 홈 확장 O** — 공식 문서 예시 명시:
  ```text
  # Individual Preferences
  - @~/.claude/my-project-instructions.md
  ```
- 최대 depth 5 hops 재귀 import
- 환경변수 확장(`@$VAR/...`)은 문서에 명시 없음 → 불확실, 피하는 게 안전
- symlink는 `.claude/rules/`에서 명시 지원 (memory 문서: "Symlinks are resolved and loaded normally")

**결정**:
- **upbit/CLAUDE.md에 `@~/harness-meta/projects/upbit/ARCHITECTURE.md` 형태 사용** (홈 확장, 이식성 확보)
- 사용자 홈이 `C:/Users/qkreh`이므로 결과적으로 `C:/Users/qkreh/harness-meta/...`
- 다른 기기로 이전 시 clone 위치만 `~/harness-meta`로 맞추면 CLAUDE.md 그대로 동작 → G21 재현 절차와 정합

---

## Q2. `~/.claude/settings.json` ↔ `.claude/settings.json` merge (G7 해소)

**결과**:
- **스칼라 필드**: 프로젝트가 user override (프로젝트 승리)
- **배열 필드**: 양쪽 concat + dedup (replace 아님) — `permissions.allow/deny/ask`, `additionalDirectories`, `sandbox.*`, `enabledPlugins` 등
- **precedence**: managed > CLI args > local(`.claude/settings.local.json`) > project(`.claude/settings.json`) > user(`~/.claude/settings.json`)

**결정**:
- `~/.claude/settings.json`에 harness 관련 필드(hooks, statusLine) 박아도 **upbit가 project 설정에서 원하면 override 가능** (안전)
- permissions는 배열 concat이므로 글로벌에 harness 공통 permissions 추가해도 upbit project 것과 누적됨 (충돌 위험 낮음)
- upbit `.claude/settings.json`에서 hooks/statusLine 필드만 제거하면 글로벌 것이 적용됨

---

## Q3. Hook 설정 + OS 선택 (G15 해소)

**결과**:
- hook은 **settings.json에 명시적 등록**, 파일시스템 자동 탐지 없음
- OS 자동 선택 **안 함**. `shell` 필드로 명시:
  - `"shell": "bash"` (기본, 모든 플랫폼)
  - `"shell": "powershell"` (Windows 전용, 다른 OS에선 무시)
- user-level `~/.claude/settings.json`에 hook 정의 가능
- 환경변수 지원: `$CLAUDE_PROJECT_DIR`, `$HOME`, `${CLAUDE_PLUGIN_ROOT}` 등
- symlink 명시 지원은 아니나 실행만 되면 OK (쉘 기본 동작)

**결정**:
- 글로벌 hook은 **단일 `.sh` 파일**(`session-init.sh`)로 통일. Windows에선 Git Bash로 실행 가능
- `~/.claude/settings.json`에 다음 등록:
  ```json
  {
    "hooks": {
      "SessionStart": [
        {
          "matcher": "startup",
          "hooks": [
            {
              "type": "command",
              "command": "$HOME/.claude/hooks/session-init.sh",
              "shell": "bash",
              "timeout": 10
            }
          ]
        }
      ]
    }
  }
  ```
- `.ps1` 버전은 **만들지 않음** (PLAN 수정 필요: 목표·변경대상에서 `.ps1` 제거)
- 재언급: bash는 Windows에서 Git Bash로 작동 (ruff/poetry/pytest도 이 환경에서 호출됨 → 검증됨)

---

## Q4. Output style 활성화 조건 (G10 해소)

**결과**:
- user-level `~/.claude/output-styles/` 또는 project `.claude/output-styles/` 배치
- 자동 활성화 **X**. `/config` 메뉴 또는 settings.json `outputStyle` 필드로 명시
- 선택은 `.claude/settings.local.json`에 저장됨 (세션 시작 시 로드)
- 변경은 **다음 세션부터 반영** (system prompt cache 유지 목적)

**결정**:
- user-level `~/.claude/output-styles/harness-engineer.md` symlink 배치
- 자동 활성화 안 함. upbit CLAUDE.md에 안내:
  > 하네스 세션 진입 전 `/config` → Output style → `harness-engineer` 선택 권장
- settings.json의 `outputStyle` 필드는 **건드리지 않음** (사용자 수동 결정 존중)

---

## Q5. Commands/Agents/Skills user-level + symlink 지원 (G19 연관)

**결과**:
- **Skills**: `~/.claude/skills/` (personal) / `.claude/skills/` (project) / plugin 3계층. 우선순위 **enterprise > personal > project**
- **Commands = Skills**: 공식 문서에서 "Custom commands have been merged into skills". `.claude/commands/<n>.md`와 `.claude/skills/<n>/SKILL.md` 동등. 둘 다 존재 시 skill 우선
- **Subagents**: `.claude/agents/` — additional-directories에는 안 로드되지만 **user-level `~/.claude/agents/`는 지원됨**
- **Symlink**: `.claude/rules/`에서 명시 지원. skills/agents/commands도 동일 원칙으로 동작할 가능성 높음 — **install.ps1 실행 후 실제 세션에서 검증 필수**
- **live change detection**: Claude Code가 skills 디렉토리를 watch. symlink 대상 파일 수정 시 세션 중 반영됨

**결정**:
- 5개 카테고리 전부 `~/.claude/`로 symlink (commands, agents, skills, output-styles, hooks)
- install.ps1 실행 후 **Claude Code 세션에서 `What skills are available?` 프롬프트로 harness-* 목록 확인**을 성공 기준에 추가
- 실패 시 R6 시나리오 (직접 복사 + 업데이트 스크립트 fallback) 발동

---

## 보너스 발견 — statusLine (G9 보강)

**결과** (settings 문서):
- `statusLine` 필드 = `{ "type": "command", "command": "<path>" }`
- `$CLAUDE_PROJECT_DIR` 환경변수 사용 가능 → **CWD 기반 프로젝트 자동 감지 가능**
- 주기적 실행. stdout 출력이 status line으로 표시
- 설치 위치 자유 (권장: `~/.claude/statusline.sh`)

**결정**:
- user-level `~/.claude/statusline/statusline.sh` symlink
- `~/.claude/settings.json`에 등록:
  ```json
  {
    "statusLine": {
      "type": "command",
      "command": "$HOME/.claude/statusline/statusline.sh"
    }
  }
  ```
- 스크립트 내부: `$CLAUDE_PROJECT_DIR/.harness.toml` 읽어 `[harness].code_dir`의 `execute.py` 호출
- `.harness.toml` 부재 시 빈 문자열 출력
- upbit `.claude/settings.json`에서 `statusLine` 필드 제거

---

## PLAN 영향 요약

| 항목 | PLAN 변경 |
|---|---|
| G11 import 경로 | `@~/harness-meta/...` 홈 확장 사용 확정 |
| G7 settings merge | user-level에 hooks/statusLine 박기 안전 (project override 가능, permissions는 concat) |
| G15 hook OS 선택 | `.sh` 단일, `shell: "bash"`. `.ps1` 제작 제거 |
| G10 output-style | 자동 활성화 없음. CLAUDE.md 가이드만. settings.json `outputStyle` 무변경 |
| G19 symlink 인식 | 이론상 OK. 설치 후 실제 세션으로 재확인 필수 (검증 스텝 성공 기준 추가) |
| G9 statusline | user-level settings.json의 `statusLine.command` + `$CLAUDE_PROJECT_DIR` 활용 |

## 후속 action

PLAN.md에 다음 반영:
- 목표/변경 대상/성공 기준에서 `session-init.ps1`, `statusline.ps1` 제거 → `.sh` 단일
- `~/.claude/settings.json` 신규 작성 (hooks + statusLine 필드만) 명시
- CLAUDE.md import 문법 `@~/...` 확정
- 검증 스텝에 "세션에서 harness-* skill/command 목록 노출 확인" 추가
