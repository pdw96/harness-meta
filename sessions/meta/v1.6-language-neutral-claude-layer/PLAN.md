# meta v1.6-language-neutral-claude-layer — PLAN

세션 시작: 2026-04-24
선행 세션: [`sessions/meta/v1.5b-apply-agents-md/`](../v1.5b-apply-agents-md/REPORT.md)
목적: `claude/**` 글로벌 레이어에서 **Python 의존을 전면 제거**하여 진짜 언어 중립(bash-only) 상태로 전환한다. 프로젝트가 자기 언어로 상태 helper를 구현하도록 경계를 재설정 (`statusline_cmd` / `state_file` 매니페스트 필드 선반영). 문서·템플릿의 Python/Poetry 예시 제거.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: `~/harness-meta/claude/**` 17개 + 세션 기록 → 전부 **S1** (글로벌 UX).
- **T1 경로 다수결** — 17/17 S1 → meta 소유 확정.

## 배경

### 이전 PLAN의 근본 결함 (사용자 지적 2026-04-24)

초안 방향: "Python 있으면 full, 없으면 minimal" (graceful degradation).
**모순**: harness-meta는 **범용 다국어 메타 툴**을 표방하는데 Go/Rust/TS 프로젝트 사용자에게 **Python 설치를 사실상 강제**하는 결과. "언어 중립"이 아니라 "Python + 퇴화 fallback".

### 방향 재정립 — 전면 제거 (옵션 A)

글로벌 레이어의 **유일 책임**은 다음으로 축소:
1. 매니페스트 존재 확인 (`test -f .harness.toml`)
2. 프로젝트 이름 1개 추출 (`grep + sed`)
3. 프로젝트가 선언한 `statusline_cmd` / `state_file`을 **그대로 실행/읽기**
4. 정보 부족은 **프로젝트 책임** — 메타 툴은 깊은 파싱 안 함

프로젝트별 상태 helper(milestone 진행률, phase stats 등)는 **각 프로젝트가 자기 언어로 구현**:
- Python: `python3 scripts/harness/statusline_stats.py`
- Go: `go run ./cmd/statusline`
- TS/Node: `pnpm tsx scripts/statusline.ts`
- Rust: `./target/release/statusline`

### 트레이드오프

**잃는 것**:
- Claude Code SessionStart에 주입되던 milestone/phase 진행률 상세 (Python 60 라인 heredoc)
- statusline의 5단계 호출 (`current-version / current-phase / phase-stats / milestone-cost / cache-hit`)

**얻는 것**:
- **진짜 범용성** — 설치 자체에 Python 불필요
- 글로벌 레이어 "최소 책임" 원칙 확립
- 프로젝트 자율성 (언어별 helper)
- 차기 adapter/template 세션의 전제 단순화

### upbit에 미치는 영향 (T4 크로스 커팅 분할)

upbit 현 매니페스트는 `statusline_cmd` / `state_file` 필드 없음. 본 세션 변경 후:
- upbit `~/.claude` 연결은 그대로 작동 (bash-only 레이어는 무해)
- upbit statusline이 **기본 fallback**(`[harness] {project_name}`)으로 전환 — 기존 풍부한 stats 표시 상실
- 복원: 별도 세션 `sessions/upbit/vX-statusline-cmd-migration/`에서 upbit 매니페스트에 `statusline_cmd = "python3 scripts/harness/statusline_stats.py"` 추가. 본 meta 세션 범위 외.

## 목표

- [ ] **session-init.sh 전면 재작성** — Python heredoc 완전 제거. bash-only. 프로젝트명 + phases 디렉토리 존재 여부 + 선택적 `state_file` cat
- [ ] **statusline.sh 전면 재작성** — Python 호출 제거. `statusline_cmd` 필드 있으면 실행 (array + timeout 3s), 없으면 `[harness] {project_name}` minimal
- [ ] **새 매니페스트 필드 fallback-read** 선반영:
  - `[harness].statusline_cmd` — 문자열 명령
  - `[harness].state_file` — session-init이 cat할 상태 텍스트 파일 경로
- [ ] **Shell injection 방어** — `eval` 대신 `read -ra` array 호출
- [ ] **Timeout** — `timeout 3s` (GNU coreutils, Git Bash 포함)
- [ ] **영문 fallback 출력** — AGENTS.md §8 locale 규약 일관성
- [ ] **문서·템플릿 18 파일** Python/Poetry 예시 중립화 (worktree_advisor.py 모듈명 완전 제거 포함)
- [ ] **Smoke test 6 시나리오** — evidence 저장
- [ ] **verify.ps1 영향 분석** — 기존 30/30 PASS가 변동 가능. D 섹션(hook smoke) / E 섹션(statusline smoke) 기대값 재정의 필요 여부 판단

## 범위

**포함**:
- `claude/hooks/session-init.sh` bash-only 재작성
- `claude/statusline/statusline.sh` bash-only 재작성
- `statusline_cmd` / `state_file` 필드 **fallback-read 선반영** (스키마 정식 스펙화는 v1.7)
- 문서·템플릿 18 파일 언어 중립화
- Smoke test 6 시나리오
- `verify.ps1` 기대값 갱신 (필요한 경우, 최소 변경)

**제외** (T4 / 후행 세션):
- 매니페스트 schema 1.1 정식 스펙화 → **v1.7-manifest-schema-v1.1**
- bootstrap/manifest-schema.md 예시 다언어화 → v1.7
- upbit `statusline_cmd` 필드 추가 → **sessions/upbit/vX-statusline-cmd-migration/** (T4 분할, upbit 소유)
- 각 언어별 statusline helper 샘플 공급 → v1.11~v1.13 bootstrap-templates
- 기존 Python 경로의 한국어 출력 영문 전환 → 본 세션 해당 없음 (Python 경로 자체 제거)
- `install.ps1` / `verify.ps1` PowerShell 코드 변경 (언어 중립화 대상 아님)

## 변경 대상

### 수정 파일 (18 + verify.ps1 기대값)

| # | 경로 | scope | 변경 요지 |
|---|------|-------|----------|
| 1 | `claude/hooks/session-init.sh` | S1 | **전면 재작성 bash-only** |
| 2 | `claude/statusline/statusline.sh` | S1 | **전면 재작성 bash-only + statusline_cmd** |
| 3 | `claude/commands/harness.md` | S1 | frontmatter 권한 완화 + 본문 예시 |
| 4 | `claude/commands/harness-plan.md` | S1 | `execute.py --status` + worktree_advisor.py 모듈명 **제거** |
| 5 | `claude/commands/harness-design.md` | S1 | 예시 + Agent prompt |
| 6 | `claude/commands/harness-run.md` | S1 | frontmatter + 본문 executor 중립화 |
| 7 | `claude/commands/harness-ship.md` | S1 | frontmatter + 본문 + `_finalize` 중립화 |
| 8 | `claude/commands/harness-review.md` | S1 | 빌드 검증 예시 |
| 9 | `claude/commands/harness-meta.md` | S1 | 17라인만 중립화 (78/117은 meta repo 관점 유지) |
| 10 | `claude/agents/harness-dispatcher.md` | S1 | dry-run 예시 |
| 11 | `claude/agents/harness-verifier.md` | S1 | 테스트 예시 |
| 12 | `claude/agents/harness-explore.md` | S1 | `.py` 예시 다언어 주석 + `__init__.py` 일반화 |
| 13 | `claude/agents/harness-grey-area.md` | S1 | 동일 패턴 |
| 14 | `claude/skills/harness-plan/SKILL.md` | S1 | AC 예시 placeholder |
| 15 | `claude/skills/harness-plan/plan-template.md` | S1 | AC 예시 placeholder |
| 16 | `claude/skills/harness-ship/report-template.md` | S1 | 테스트 존재 예시 |
| 17 | `claude/skills/harness-design/7d-checklist.md` | S1 | D1, D5 예시 다언어 주석 |
| 18 | `claude/output-styles/harness-engineer.md` | S1 | `execute.py` 2곳 중립화 |
| (19) | `verify.ps1` D/E 기대값 | S3 | (**본 세션 외 가능성** — 아래 verify 영향 분석 참조) |

### 세션 기록 (3)

`PLAN.md` (본), `REPORT.md` (후), `evidence/smoke-{1..6}.txt`

## session-init.sh 재작성 설계 (bash-only, Python 0 줄)

### 핵심 원칙

- TOML 파싱은 `grep + sed` 1줄짜리만 수행 — 핵심 필드(`name`, `phases_dir`, `state_file`)만
- JSON 파싱 안 함 — `phases/index.json`의 milestone 상태는 프로젝트 helper 또는 state_file 책임
- 깊은 context가 필요한 프로젝트는 **`state_file` 경로에 상태 텍스트를 써두고** hook이 cat — 프로젝트가 자기 언어로 생성
- 출력은 모든 경우 **exit 0 + 유효 JSON** (`{}` 또는 `hookSpecificOutput`) — SessionStart UI 에러 회피

### 새 구조 (의사 코드)

```bash
#!/usr/bin/env bash
# bash-only. Python 의존 없음.

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
MANIFEST="$PROJECT_DIR/.harness.toml"

# 1. 매니페스트 부재 → {}
if [ ! -f "$MANIFEST" ]; then
    printf '{}'
    exit 0
fi

# 2. 최소 필드 추출 (grep)
project_name=$(grep -E '^name[[:space:]]*=[[:space:]]*"' "$MANIFEST" | head -1 | sed -E 's/^name[[:space:]]*=[[:space:]]*"([^"]+)"/\1/')
phases_dir=$(grep -E '^phases_dir[[:space:]]*=[[:space:]]*"' "$MANIFEST" | head -1 | sed -E 's/^phases_dir[[:space:]]*=[[:space:]]*"([^"]+)"/\1/')
state_file=$(grep -E '^state_file[[:space:]]*=[[:space:]]*"' "$MANIFEST" | head -1 | sed -E 's/^state_file[[:space:]]*=[[:space:]]*"([^"]+)"/\1/')

phases_dir="${phases_dir:-phases}"

# 3. context 구성
context=""

if [ -n "$state_file" ] && [ -f "$PROJECT_DIR/$state_file" ]; then
    # 프로젝트가 생성한 상태 텍스트 그대로 사용
    context=$(cat "$PROJECT_DIR/$state_file")
elif [ -d "$PROJECT_DIR/$phases_dir" ]; then
    context="## Harness (project: ${project_name:-?})"$'\n'"- phases directory exists at \`$phases_dir/\`"$'\n'"- For detailed state, configure \`[harness].state_file\` in .harness.toml"
else
    context="## Harness (project: ${project_name:-?})"$'\n'"- \`$phases_dir/\` not initialized — run \`/harness-plan\` or similar"
fi

# 4. 빈 context면 {} 반환
if [ -z "$context" ]; then
    printf '{}'
    exit 0
fi

# 5. JSON 출력 (bash escape — newline/double-quote)
#    printf + sed로 backslash/quote escape
escaped=$(printf '%s' "$context" | sed 's/\\/\\\\/g; s/"/\\"/g' | awk 'BEGIN{ORS=""} NR>1{print "\\n"} {print}')
printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}' "$escaped"
exit 0
```

### 출력 언어

`context` 문자열은 **영문**. AGENTS.md §8 locale 규약 일관성. 프로젝트가 `state_file`로 override하면 프로젝트 자유.

### JSON escape 주의

- Python `json.dumps(ensure_ascii=False)`가 하던 escape 작업을 bash sed+awk로 대체
- 복잡한 유니코드 escape는 bash만으로 완벽하지 않음 — `state_file` 내용에 제어 문자 포함 시 깨짐 가능
- 단순 ASCII + UTF-8 일반 문자는 OK. 사용자가 이상한 문자 쓸 위험은 낮음
- **한계 인정**: bash escape의 robust성 < Python `json.dumps` — 허용 범위

## statusline.sh 재작성 설계 (bash-only + statusline_cmd)

### 핵심 원칙

- 매니페스트 없으면 exit 0 (no-op, 현재 유지)
- `statusline_cmd` 있음 → `read -ra` 로 array 파싱 → `timeout 3s "${cmd[@]}"` 호출
- `statusline_cmd` 없음 → minimal `[harness] {project_name}` 출력

### 새 구조

```bash
#!/usr/bin/env bash
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
MANIFEST="$PROJECT_DIR/.harness.toml"

if [ ! -f "$MANIFEST" ]; then
    exit 0  # 매니페스트 없음 = no-op
fi

project_name=$(grep -E '^name[[:space:]]*=[[:space:]]*"' "$MANIFEST" | head -1 | sed -E 's/^name[[:space:]]*=[[:space:]]*"([^"]+)"/\1/')
statusline_cmd=$(grep -E '^statusline_cmd[[:space:]]*=[[:space:]]*"' "$MANIFEST" | head -1 | sed -E 's/^statusline_cmd[[:space:]]*=[[:space:]]*"([^"]+)"/\1/')

if [ -n "$statusline_cmd" ]; then
    # Array 파싱 + timeout — shell injection 방어
    read -ra cmd_tokens <<< "$statusline_cmd"
    output=$(cd "$PROJECT_DIR" && timeout 3s "${cmd_tokens[@]}" 2>/dev/null)
    if [ -n "$output" ]; then
        printf '%s' "$output"
        exit 0
    fi
    # statusline_cmd 실패 시 fallback
fi

# Fallback minimal
printf '[harness] %s' "${project_name:-?}"
```

### Timeout 3s

`timeout` 명령이 PATH에 없으면 실패 — Git Bash / macOS / Linux 기본 포함. Windows PowerShell에서 bash shell로 호출하므로 OK.

### statusline_cmd 계약 (v1.7에서 정식 스펙화)

- 매니페스트 값은 **완전한 명령 문자열** (예: `"python3 scripts/harness/statusline_stats.py"`)
- hook이 프로젝트 루트를 CWD로 실행
- stdout 첫 줄(또는 전체)이 statusline 표시 텍스트
- stderr는 무시
- 3초 초과 시 cancel + fallback

## 문서 언어 중립화 패턴 (18 파일)

### frontmatter tools

**Before**: `tools: Read, Glob, Grep, Bash(python3 scripts/execute.py*), Bash(python scripts/execute.py*), ...`
**After**: `tools: Read, Glob, Grep, Bash, Edit(phases/**)`

**근거**: wildcard 권한 완화. 사용자가 `.claude/settings.json`에서 세부 deny 가능.

### 본문 명령 예시

**Before**: `예: poetry run pytest tests/ -q`
**After**: `예: {test_cmd from .harness.toml [testing].test_cmd}` (프로젝트별)

### agent 파일 (harness-explore.md / harness-grey-area.md / 7d-checklist.md)

**원칙**: LLM prompt engineering상 **1 Python + 1 타 언어** diversity로 추상화와 구체성 균형.

**Before**:
```markdown
- 변경 대상 모듈 목록 (예: `src/module_a.py`, `src/module_b.py`)
```

**After**:
```markdown
- 변경 대상 모듈 목록 (예: `src/module_a.py` Python / `src/module_a.ts` TypeScript / `cmd/service/main.go` Go — 프로젝트 언어에 따라)
```

**Before**:
```markdown
- **public API**: `__init__.py` export 변경 영향
```

**After**:
```markdown
- **public API**: 언어별 export 변경 영향 (Python `__init__.py`, TS `index.ts` named exports, Go 대문자 identifier, Rust `pub mod` 등)
```

### worktree_advisor.py 완전 제거

**Before** (`harness-plan.md:52`):
```markdown
4. `scripts/harness/worktree_advisor.py`가 자동 판정:
```

**After**:
```markdown
4. 프로젝트 하네스가 worktree 권고 helper 제공 시:
```

모듈명 삭제. upbit-specific 참조 잔존 제거.

### output-style `execute.py` 중립화

**Before**:
```markdown
- `phases/{version}/{phase}/index.json`이 단일 진실 원천. `execute.py`만 원자적 갱신
4. **/harness-run** — 8~9: UAT dry-run → execute.py (sonnet)
```

**After**:
```markdown
- `phases/{version}/{phase}/index.json`이 단일 진실 원천. 프로젝트 executor (`.harness.toml [harness].executor`)만 원자적 갱신
4. **/harness-run** — 8~9: UAT dry-run → 프로젝트 executor (sonnet)
```

## verify.ps1 영향 분석

현 30/30 check 중 D / E 섹션이 하드코딩된 기대 출력을 가짐 (v1.3 실측):

| Check | 기대 출력 (현재) | v1.6 재작성 후 기대 |
|-------|---------------|-------------------|
| D0 no-manifest | `{}` | `{}` (동일) |
| D1 F1 (sample-project) | `"미존재"` 포함 | **영문**으로 변경: `"not initialized"` 포함 |
| D2 F2 (empty-phases) | `"전체 milestone 완료"` | **재정의 필요** — bash-only 재작성 후 이 출력은 사라짐. 대신 `"phases directory exists"` 또는 유사 |
| E0 no-manifest | 빈 출력 | 동일 |
| E1 F1 | `"phases 미초기화"` | **영문**으로 변경: `"phases not initialized"` 또는 삭제 |
| E2 F2 | `"stats 모듈 없음"` | **삭제** — statusline.sh가 Python 호출 안 함 |

**결론**: verify.ps1 D/E 기대값이 **변경 필요**. 이는 **본 세션 범위** (글로벌 레이어 변경과 동일 원자 단위) — S3 `verify.ps1`을 예외적으로 본 세션에서 함께 수정. PLAN 범위에 추가.

→ 변경 대상 19번 `verify.ps1` 포함.

## Smoke Test 6 시나리오

| # | 시나리오 | hook 기대 | statusline 기대 | Evidence |
|---|---------|----------|---------------|---------|
| S1 | 매니페스트 없음 | `{}` exit 0 | 빈 출력 exit 0 | `smoke-1-no-manifest.txt` |
| S2 | 매니페스트 있음 + phases 디렉토리 없음 | `"not initialized"` 포함 JSON | `[harness] {name}` | `smoke-2-phases-missing.txt` |
| S3 | 매니페스트 있음 + phases 있음 + state_file 없음 | `"phases directory exists"` 포함 JSON | `[harness] {name}` | `smoke-3-phases-no-state.txt` |
| S4 | 매니페스트 있음 + `state_file = "phases/.state.txt"` 존재 | state 파일 내용 주입 JSON | `[harness] {name}` (statusline_cmd 별도 테스트) | `smoke-4-state-file.txt` |
| S5 | `statusline_cmd = "printf \"[test] OK\""` | (hook 무관) | `[test] OK` | `smoke-5-statusline-cmd.txt` |
| S6 | `statusline_cmd = "sleep 10"` (timeout 트리거) | (hook 무관) | 3초 후 fallback `[harness] {name}` | `smoke-6-timeout.txt` |

### Fixture 추가

`tests/fixtures/sample-project/` 기존 (F1) — 매니페스트만
`tests/fixtures/empty-phases/` 기존 (F2) — phases 디렉토리 포함

**추가 필요**:
- `tests/fixtures/state-file/` — `.harness.toml` + `phases/` + `phases/.state.txt`
- `tests/fixtures/statusline-cmd/` — `.harness.toml`에 `statusline_cmd = "printf \"[test] OK\""`
- `tests/fixtures/statusline-timeout/` — `statusline_cmd = "sleep 10"`

## Grey Areas — 결정 (22건)

| ID | 질문 | 결정 |
|----|------|------|
| G1 | Python 전면 제거 | **Yes (옵션 A)** — 사용자 지적대로 범용성 우선 |
| G2 | bash escape 완벽성 | **한계 인정** — 단순 UTF-8 OK, 제어 문자 / 특수 escape는 `state_file` 책임 |
| G3 | state_file 경로 기준 | **프로젝트 루트 상대** — 매니페스트의 여타 경로 필드와 일관 |
| G4 | state_file 포맷 | **plain text** (preformatted) — 프로젝트가 Markdown 작성 책임. JSON/YAML 파싱 안 함 |
| G5 | state_file 사이즈 제한 | **soft 8KB 권장** (SessionStart context 크기 현실적 상한). hard 강제 안 함 |
| G6 | statusline_cmd shell injection | **read -ra array** 방어 |
| G7 | statusline timeout | **3s** (`timeout 3s`) |
| G8 | statusline_cmd cwd | **프로젝트 루트** (cd $PROJECT_DIR) |
| G9 | statusline_cmd stderr | **무시** (2>/dev/null) |
| G10 | statusline_cmd 반환값 첫 줄만 vs 전체 | **전체** — 첫 줄만 필요하면 프로젝트가 `head -1` |
| G11 | fallback 영문 | **Yes** (AGENTS.md §8 locale 규약) |
| G12 | worktree_advisor.py 모듈명 | **제거** — upbit-specific 참조 불허 |
| G13 | agent 파일 예시 | **Python 1 + 타 언어 1 diversity** |
| G14 | output-styles harness-engineer execute.py | **"프로젝트 executor" 추상화** |
| G15 | harness-meta.md 78/117 execute.py | **유지** — meta repo 자체 관점 문맥 |
| G16 | verify.ps1 D/E 기대값 변경 | **본 세션 포함** (원자 단위). S3 예외 편입 |
| G17 | 기존 fixture 재활용 가능성 | **F1/F2 재사용 + 신규 3개 추가** (state-file / statusline-cmd / statusline-timeout) |
| G18 | bash grep TOML 파싱 한계 | **최소 필드만**: name / phases_dir / state_file / statusline_cmd. 나머지는 프로젝트 도구가 처리 |
| G19 | matrix schema 1.1 선반영 범위 | **필드 2개만** (`state_file`, `statusline_cmd`). 정식 스펙화는 v1.7 |
| G20 | upbit 영향 완화 | **별도 세션 T4 분할** — `sessions/upbit/vX-statusline-cmd-migration/` |
| G21 | Claude Code SessionStart UI 버그 (#12671) 대응 | bash이 non-zero exit 절대 안 하게 방어적 코딩. 모든 분기 exit 0 |
| G22 | `PYTHONIOENCODING=utf-8` 방어 | **해당 없음** — Python 호출 자체 제거로 불필요 |

## 성공 기준

- [ ] `session-init.sh` Python 0 라인 (`grep -c 'python' claude/hooks/session-init.sh` = 0)
- [ ] `statusline.sh` Python 0 라인 (동일 grep 0)
- [ ] 두 스크립트 모두 모든 분기에서 exit 0
- [ ] `statusline_cmd` / `state_file` 필드 fallback-read 동작 (스펙 정식화는 v1.7)
- [ ] 문서·템플릿 18 파일 Python/Poetry 하드코딩 0건 (placeholder 또는 다언어 주석으로 대체)
- [ ] `worktree_advisor.py` 모듈명 언급 0건 (grep 0)
- [ ] `verify.ps1` D/E 기대값 갱신 + 30/30 PASS 유지
- [ ] Smoke test 6/6 시나리오 evidence 저장
- [ ] fallback 출력 영문 (한국어 0건 in 2 scripts)
- [ ] Grey Area 22건 결정 기록
- [ ] 커밋 + push

## 커밋 전략

단일 커밋 (글로벌 레이어 원자적 재정립):

```
feat(meta)!: sessions/meta/v1.6-language-neutral-claude-layer — Python 의존 전면 제거

- refactor: claude/hooks/session-init.sh — bash-only 재작성
    Python heredoc 완전 제거. TOML 파싱은 grep+sed 최소 필드만.
    state_file 필드 fallback-read로 프로젝트 상태 주입 위임.
    영문 fallback 출력.
- refactor: claude/statusline/statusline.sh — bash-only 재작성
    Python 5회 호출 완전 제거. statusline_cmd 필드 실행만.
    read -ra array 호출 (shell injection 방어). timeout 3s.
    minimal fallback: [harness] {project_name}.
- update: verify.ps1 — D/E 섹션 기대값 갱신 (영문 + bash-only 출력 반영)
- update: claude/commands/*.md (7개) — frontmatter tools 완화, 예시 언어 중립화,
    worktree_advisor.py 모듈명 제거, output-styles execute.py 추상화
- update: claude/agents/*.md (4개) — 예시 Python+타언어 diversity, __init__.py 일반화
- update: claude/skills/*/* (4개) — AC 예시 placeholder
- add: tests/fixtures/{state-file, statusline-cmd, statusline-timeout}/
- add: sessions/meta/v1.6-language-neutral-claude-layer/{PLAN,REPORT,evidence/×6}

BREAKING CHANGE: 기존 upbit statusline은 풍부한 stats 출력 상실.
복원: sessions/upbit/vX-statusline-cmd-migration/에서 매니페스트에
statusline_cmd / state_file 필드 추가 (T4 분할, upbit 소유).

Grey Area 22건. Smoke 6/6. verify 30/30 PASS (기대값 갱신 후).
진짜 범용 — Python 없는 Go/Rust/TS 프로젝트도 설치 가능.
```

**주의**: `!` (exclamation) 사용 — **breaking change** 표시. upbit의 statusline 표시가 fallback으로 전환되므로 사용자 인지 필수.

## 후속 세션 연결

### 직접 연계

| 순위 | 세션 ID | Scope | 본 세션 활용 |
|-----|---------|-------|------------|
| 1 | **sessions/upbit/vX-statusline-cmd-migration** | S6 (upbit) | upbit 매니페스트에 `statusline_cmd`/`state_file` 추가 (T4 분할) |
| 2 | v1.7-manifest-schema-v1.1 | S2 | `statusline_cmd` + `state_file` + `[agents]` + `[build]` + `locale` 정식 스펙화 |
| 3 | v1.8-core-adapter-split | S1+S2 | `claude/**` → `adapters/claude-code/**` 이관. 본 세션의 중립화가 이관 깔끔 |
| 4 | v1.9-project-auto-detect | S2 | language/PM 감지 후 `.harness.toml` 자동 생성 |
| 5 | v1.11~v1.13 bootstrap-templates | S2 | 각 언어 템플릿이 자기 언어 statusline helper 공급 |

### 보류 후보

- `sessions/meta/vX-state-file-spec/` — state_file 포맷 권장 (프런트매터/섹션 구조 가이드)
- `sessions/meta/vX-statusline-protocol-v2/` — JSON 프로토콜 (단순 텍스트 → 구조화)

### 3개월 재평가 게이트

본 세션 "bash-only" 원칙은 글로벌 레이어의 최소 책임 원칙과 함께 영구. upbit 외 실증 프로젝트(Go/TS/Rust) 추가 시 state_file / statusline_cmd 계약 재검토.
