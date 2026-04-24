# meta v1.9c-docs-ps-home-path-fix — PLAN

세션 시작: 2026-04-25
선행 세션: [`sessions/meta/v1.9b-install-legacy-cleanup/`](../v1.9b-install-legacy-cleanup/REPORT.md)
목적: 활성 문서의 PowerShell 실행 예시에서 `pwsh ~/harness-meta/...` → `pwsh $HOME/harness-meta/...` 치환. PowerShell은 `~` 미지원 (bash/CLI와 차이) → Windows 사용자 UX 문제 해결.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**: 변경 파일 4 (README.md, CLAUDE.md, AGENTS.md(해당 없음), `_base/README.md`, `AGENTS_MD_STRATEGY.md`) → **S2/S3**. T1 meta scope 다수결.

## 배경

### 실측 이슈 (사용자 보고 2026-04-25)

```
PS C:\Users\qkreh\upbit> pwsh ~/harness-meta/bootstrap/install-project-claude.ps1 -Force
The argument '~/harness-meta/bootstrap/install-project-claude.ps1' is not recognized as the name of a script file.
```

PowerShell 7+는 `~`를 **외부 명령 인자 내부**에서 자동 확장하지 않음. bash/zsh와 다름.

해결책: `$HOME` 환경변수 — 모든 shell에서 동작 + 문자 그대로 bash/PS에서 수행 가능.

### 수정 대상 — 활성 문서만

**수정**:
- `README.md` — 4 hits
- `CLAUDE.md` — 3 hits
- `bootstrap/templates/_base/README.md` — 1 hit
- `bootstrap/docs/AGENTS_MD_STRATEGY.md` — 1 hit

**수정 안 함 (이력 보존)**:
- `sessions/**/PLAN.md`, `REPORT.md` — 과거 이력 그대로
- bash 명령(`bash ~/harness-meta/...`) — bash는 `~` 확장 OK

## 목표

- [ ] 활성 문서 4개에서 `pwsh ~/harness-meta/` → `pwsh $HOME/harness-meta/` 치환 (9 occurrences)
- [ ] bash 명령은 그대로 (`bash ~/harness-meta/...` 유지)
- [ ] 세션 기록은 **수정 안 함** (이력 보존)
- [ ] 커밋 + push

## 범위

**포함**:
- README.md, CLAUDE.md, `_base/README.md`, `AGENTS_MD_STRATEGY.md` 문서 치환
- 세션 기록

**제외**:
- `sessions/**` 과거 문서 (이력 보존)
- bash 명령 예시
- 설명 목적의 `~` 참조 (예: "`~/.claude/hooks/...`")

## Grey Areas — 결정

| ID | 질문 | 결정 |
|----|------|------|
| G1 | 과거 세션 기록 치환 여부 | **No** — 이력 보존 원칙 |
| G2 | bash 예시 치환 여부 | **No** — bash는 `~` 확장 OK |
| G3 | 일반 경로 설명(`~/.claude/hooks/...`) 치환 | **No** — 실행 명령 아님 |
| G4 | 치환 문구 `$HOME` vs `"$HOME"` | **`$HOME`** (PS 관례, double quote 불필요) |
| G5 | Windows-only vs 범용 | `$HOME`은 bash + PS 둘 다 작동 → 범용 |

## 성공 기준

- [ ] 활성 문서에 `pwsh ~/harness-meta/` 0건
- [ ] `pwsh $HOME/harness-meta/` 치환 확인
- [ ] 세션 기록 변경 0건
- [ ] 커밋 + push
