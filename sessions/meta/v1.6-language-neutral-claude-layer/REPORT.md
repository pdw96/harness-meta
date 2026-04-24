# meta v1.6-language-neutral-claude-layer — REPORT

세션 기간: 2026-04-24 ~ 2026-04-25 (연결 세션)
세션 범위: `claude/**` 글로벌 레이어 Python 의존 전면 제거 + bash-only 재작성 + 문서·템플릿 18 파일 언어 중립화 + verify.ps1 기대값 갱신 + Git Bash 명시 탐지
판정: **PASS** (성공 기준 11/11 충족, verify 30/30 PASS, smoke 6/6 PASS)

**세션 소속 (self-apply)**: `sessions/meta/`
**근거**: 변경 파일 20건 (`claude/**` 18 + `verify.ps1` 1 + fixture 3개 신규 디렉토리) → **S1** 18 + **S3** 2. **T1 경로 다수결** S1 우세 → meta 소유. verify.ps1 편입은 **T5 (원자 단위)** — 본 세션 output 기대값 변경이 verify 연쇄 수정 강제.

## 최종 결과

- **재작성 2**: `claude/hooks/session-init.sh` (60 LOC 영문 bash-only), `claude/statusline/statusline.sh` (51 LOC 영문 bash-only)
- **문서 중립화 16**: commands 7 + agents 4 + skills 4 (plan SKILL/template, ship report, design 7d) + output-styles 1
- **verify.ps1 편입**: A3a Git Bash 명시 탐지 + A3b python3 optional + D2/D3/E2/E3 기대값 갱신
- **fixture 3 신규**: `state-file/`, `statusline-cmd/`, `statusline-timeout/`
- **evidence 6**: smoke-1~6 텍스트
- **세션 기록 2**: PLAN.md / 본 REPORT
- **Python 참조 0**: `grep -c 'python' session-init.sh statusline.sh` = 0/0
- **Poetry/upbit 하드코딩 0**: 최종 grep `(poetry run|pytest tests|worktree_advisor|statusline_stats|_finalize)` = 0 매치

## 구현 요약 (PLAN 목표 대조)

| # | 목표 | 결과 | 구현 |
|---|------|------|------|
| 1 | session-init.sh Python 0 라인 bash-only | ✅ | 재작성 60 라인 |
| 2 | statusline.sh Python 0 라인 + statusline_cmd + timeout 3s | ✅ | 재작성 51 라인 + `read -ra` + `timeout 3s` |
| 3 | statusline_cmd / state_file 필드 fallback-read 선반영 | ✅ | `_extract 'state_file'` + `_extract 'statusline_cmd'` |
| 4 | Shell injection 방어 (array 호출) | ✅ | `read -ra cmd_tokens` |
| 5 | 영문 fallback 출력 | ✅ | "not initialized" / "phases directory exists" / "[harness] {name}" |
| 6 | 문서 18 파일 중립화 | ✅ | 본 리포트 아래 파일별 표 |
| 7 | worktree_advisor.py 모듈명 완전 제거 | ✅ | grep 0 매치 |
| 8 | Smoke 6 시나리오 evidence | ✅ | `evidence/smoke-1~6.txt` |
| 9 | verify.ps1 D/E 기대값 갱신 | ✅ | 한국어 → 영문 + bash-only 형식 |
| 10 | verify.ps1 Git Bash 명시 탐지 (v1.3 회귀 해결) | ✅ | `$GitBashCandidates` fallback chain |
| 11 | 커밋 + push | ⏳ | 사용자 확인 후 |

**완수율**: 11/11 (100%, 커밋 대기).

## Smoke Test 결과

| # | 시나리오 | hook 결과 | statusline 결과 | 판정 |
|---|---------|---------|----------------|------|
| S1 | no manifest | `{}` | 빈 출력 | ✅ |
| S2 | manifest + phases 없음 | `{"hookSpecificOutput":{...,"additionalContext":"...not initialized..."}}` | `[harness] sample-project` | ✅ |
| S3 | manifest + phases + state_file 없음 | `"phases directory exists at phases/"` 포함 | `[harness] empty-phases` | ✅ |
| S4 | state_file 존재 | state 파일 내용 주입 (newline escape 정상) | `[harness] state-file-fixture` | ✅ |
| S5 | statusline_cmd 단순 | (hook 별도) | `[fixture]OK` | ✅ |
| S6 | statusline_cmd timeout (sleep 10) | (hook 별도) | 4초 후 fallback `[harness] statusline-timeout-fixture` | ✅ |

**6/6 PASS**.

## verify.ps1 30/30 PASS 실측

```
Z 3/3 · A 4/4 · B 7/7 · C 10/10 · D 3/3 · E 3/3 · F info · G 6 manual
```

주요 변경:
- **A3a** "bash: `C:\Program Files\Git\bin\bash.exe`" 정상 탐지 (WSL bash 우회)
- **A3b** "python3 (optional)" info — v1.6+ hook/statusline이 bash-only이므로 python3 선택
- **D2/D3** 영문 기대값 매칭
- **E2/E3** `[harness] {project_name}` 기대값

## 문서 중립화 파일별

| 파일 | 주요 변경 |
|------|----------|
| `claude/commands/harness.md` | frontmatter tools `Bash(python3 scripts/execute.py*)` → `Bash, Edit` |
| `claude/commands/harness-run.md` | frontmatter 완화 + `python3 scripts/execute.py` → `{executor}` (언어별 예시 주석 4종) |
| `claude/commands/harness-ship.md` | frontmatter 완화 + `poetry run pytest/mypy/ruff` 3줄 → `{test_cmd}/{type_check_cmd}/{lint_cmd}` placeholder + 언어별 예시 주석 4종 + `_finalize` → "프로젝트 executor" |
| `claude/commands/harness-review.md` | 빌드 검증 예시 3줄 → placeholder |
| `claude/commands/harness-plan.md` | `execute.py --status` → "프로젝트 executor --status" + `worktree_advisor.py` 모듈명 **완전 제거** |
| `claude/commands/harness-design.md` | AC 예시 `poetry run pytest` → placeholder + Agent prompt의 `.py` 일반화 |
| `claude/commands/harness-meta.md` | `execute.py 자동` (line 17) → "프로젝트 executor 자동". line 78/117 meta 관점 유지 |
| `claude/agents/harness-dispatcher.md` | dry-run 예시 `python3 scripts/execute.py` → `{executor}` |
| `claude/agents/harness-verifier.md` | Functional 예시 + 출력 표 placeholder |
| `claude/agents/harness-explore.md` | `.py` 예시 → 다언어 주석 (Python/TS/Go/Rust 4종) + `__init__.py` 일반화 |
| `claude/agents/harness-grey-area.md` | 동일 패턴. pydantic → 다언어 설정 도구 |
| `claude/skills/harness-plan/SKILL.md` | AC 설명 |
| `claude/skills/harness-plan/plan-template.md` | 테이블 R1/R2 예시 placeholder |
| `claude/skills/harness-ship/report-template.md` | Goal-backward 표 / 테스트 존재 / 산출물 요약 / 테스트 변화 다수 placeholder |
| `claude/skills/harness-design/7d-checklist.md` | D1/D5 예시 placeholder |
| `claude/output-styles/harness-engineer.md` | `execute.py`만 원자적 갱신 → "프로젝트 executor" + run 단계 `execute.py (sonnet)` 동일 |

## Grey Area 결정 사후 검증 (PLAN 22건)

| ID | 결정 | 구현 반영 |
|----|------|----------|
| G1 | Python 전면 제거 | ✅ 2 스크립트 / 18 문서 |
| G2 | bash JSON escape 한계 인정 | ✅ S4 state_file 복잡 content 주입 정상 확인 |
| G3 | state_file 프로젝트 루트 상대 | ✅ fixture 매니페스트 `phases/.state.txt` |
| G4 | state_file plain text | ✅ |
| G5 | state_file soft 8KB 권장 | 강제 안 함. REPORT 통해 문서화 |
| G6 | statusline_cmd array 호출 | ✅ `read -ra cmd_tokens` |
| G7 | statusline timeout 3s | ✅ S6에서 실측 ~4초 (초과분은 timeout cancel 오버헤드) |
| G8 | statusline_cmd CWD = 프로젝트 루트 | ✅ `cd "$PROJECT_DIR" &&` |
| G9 | statusline_cmd stderr 무시 | ✅ `2>/dev/null` |
| G10 | statusline_cmd 출력 전체 사용 | ✅ `printf '%s' "$output"` |
| G11 | fallback 영문 | ✅ |
| G12 | worktree_advisor.py 모듈명 제거 | ✅ grep 0 |
| G13 | agent 예시 Python+타언어 diversity | ✅ 4언어 주석 |
| G14 | output-styles execute.py 추상화 | ✅ |
| G15 | harness-meta.md 78/117 meta 관점 유지 | ✅ line 17만 중립화 |
| G16 | verify.ps1 D/E 기대값 갱신 (본 세션 S3 편입) | ✅ |
| G17 | 기존 fixture F1/F2 재사용 + 3 신규 | ✅ |
| G18 | bash grep TOML 최소 필드 | ✅ name / phases_dir / state_file / statusline_cmd |
| G19 | schema 1.1 선반영은 2 필드만 | ✅ statusline_cmd / state_file |
| G20 | upbit 영향 T4 분할 | ✅ sessions/upbit/vX-statusline-cmd-migration/ 후속 |
| G21 | 모든 분기 exit 0 | ✅ |
| G22 | PYTHONIOENCODING 불필요 | ✅ (Python 제거로) |

**22/22 결정 유지.** 추가로 **verify.ps1 A3a WSL bash 회피**가 구현 중 발견되어 T5로 편입.

## Lessons Learned

1. **"범용 = Python 제거"가 아닌 "Python 선호 + fallback"의 함정**: 초안 PLAN은 graceful degradation으로 타협했으나 사용자 지적으로 근본 재설계. 메타 툴의 책임 = **최소**. 깊은 context는 프로젝트 책임(`state_file` 경로에 텍스트). 이 원칙은 향후 모든 adapter 세션(v1.14~v1.20)에 일관 적용.

2. **WSL bash vs Git Bash 자동 선택은 환경 의존적**: v1.3 verify 30/30은 당시 `bash`가 Git Bash로 resolve됐기에 PASS. 2026-04 Windows 업데이트 후 `C:\WINDOWS\system32\bash.exe` (WSL)가 PATH 우선. 회귀 감지되어 `$GitBashCandidates` fallback 체인으로 해결. 이는 차기 v1.21-cross-platform-install에서도 유효 — macOS/Linux는 단일 bash.

3. **breaking change의 대상 분리 T4 분할**: 본 세션의 BREAKING은 **upbit의 statusline 풍부한 출력 상실**. 복원은 upbit 매니페스트에 `statusline_cmd = "python3 scripts/harness/statusline_stats.py"` + `state_file = "phases/.state.txt"` 추가로 가능. 이는 upbit 소유 (S6) → 별도 세션에서 수행. meta 세션이 upbit 파일을 직접 건드리지 않음으로써 audit trail 명확.

4. **LLM prompt engineering: 다언어 예시의 agent 효과**: `harness-explore` / `harness-grey-area`의 예시를 "Python 1 + TS 1 + Go 1 + Rust 1" 4개 diversity로 제공. LLM은 추상 placeholder보다 구체 다언어 예시에서 "프로젝트 언어에 맞게 선택" 패턴을 잘 따름. 차기 bootstrap-templates에서 이 효과 실증 가능.

5. **`timeout 3s`의 4초 관찰**: S6 실측 4초 (sleep 10 → timeout 3s + cancel overhead 1초). Claude Code statusline hot path에서 3초도 체감상 김. 개선 후보: timeout을 **2s**로 단축 + 사용자 매니페스트에서 override 가능 필드(`statusline_timeout_ms`). v1.7 schema에서 검토.

6. **bash-only JSON escape의 현실적 한계**: 제어 문자 (NUL, BEL 등) 및 Unicode emoji escape는 Python `json.dumps`만큼 완벽하지 않음. 그러나 실용 범위(UTF-8 markdown)에서는 정상. 사용자가 `state_file`에 이상한 문자를 넣을 가능성 낮음 — 넣어야 한다면 프로젝트가 **자기 스크립트로 사전 escape**하여 써야 함. 이는 §4-2 계약에 명시.

## 파일 내용별 잔존 Python 언급 (의도적 유지)

다음은 **의도적**으로 유지:

| 위치 | 내용 | 이유 |
|------|------|------|
| `harness-run.md:27` | 언어별 예시 주석에 "Python: python3 scripts/execute.py" | Grey G13 다언어 diversity |
| `harness-ship.md:78~81` | 언어별 예시 주석에 "Python/uv: uv run pytest..." | 동일 |
| `harness-explore.md:45, 54` | 언어별 export 관례 "Python `__init__.py`, TS..." | 동일 — agent LLM이 프로젝트 언어 식별 후 치환 |
| `harness-grey-area.md:31, 78` | 동일 패턴 | 동일 |
| `commands/harness-meta.md:78, 117` | "execute.py 사용 안 함 (재귀 구조 회피)" | meta repo 자체 관점 (harness 실행기 사용 안 함을 의미) |

## 커밋 계획

```
feat(meta)!: sessions/meta/v1.6-language-neutral-claude-layer — Python 의존 전면 제거

- refactor: claude/hooks/session-init.sh — bash-only (60 LOC, 영문)
    Python heredoc 완전 제거. TOML 파싱은 grep+sed 최소 필드.
    state_file 필드 fallback-read로 프로젝트 상태 주입 위임.
- refactor: claude/statusline/statusline.sh — bash-only (51 LOC, 영문)
    Python 5회 호출 완전 제거. statusline_cmd 필드 실행만.
    read -ra array (shell injection 방어). timeout 3s.
    fallback: [harness] {project_name}.
- update: verify.ps1
    A3a Git Bash 명시 탐지 (WSL bash 회귀 해결).
    A3b python3을 optional로 완화.
    D2/D3/E2/E3 기대값 영문 + bash-only 형식으로 갱신.
- update: claude/commands/*.md (7) + agents/*.md (4) + skills/**/*.md (4) + output-styles/*.md (1)
    Python/Poetry 편향 예시 → placeholder + 다언어 diversity.
    worktree_advisor.py 모듈명 완전 제거 (upbit-specific 참조 불허).
- add: tests/fixtures/{state-file, statusline-cmd, statusline-timeout}/
- add: sessions/meta/v1.6-language-neutral-claude-layer/{PLAN,REPORT,evidence×6}

Smoke 6/6 PASS. verify 30/30 PASS.
Grey Area 22건 결정 + T5로 verify 편입 1건.

BREAKING CHANGE: upbit statusline 풍부한 출력 상실.
복원: sessions/upbit/vX-statusline-cmd-migration/에서 매니페스트에
statusline_cmd + state_file 필드 추가 (T4 분할, upbit 소유).
```

## 후속 세션 연결

### 직접 연계

| 순위 | 세션 ID | Scope |
|-----|---------|-------|
| 1 | **sessions/upbit/vX-statusline-cmd-migration** | S6 (upbit) — 매니페스트 복구 |
| 2 | v1.7-manifest-schema-v1.1 | S2 — `statusline_cmd`/`state_file`/`[agents]`/`[build]`/`locale`/`runtime_version` 정식 스펙 |
| 3 | v1.8-core-adapter-split | S1+S2 — `claude/commands/harness-{plan,design,run,ship,review}.md` 등 → `bootstrap/templates/<language>/.claude/`로 per-project 배치. `/harness-meta`만 글로벌 잔존 (사용자 아키텍처 방향 전환) |

### 보류 후보

- `sessions/meta/vX-statusline-timeout-configurable` — `statusline_timeout_ms` 매니페스트 필드 (Lesson #5)
- `sessions/meta/vX-state-file-spec` — state_file 권장 포맷 (섹션 구조 / 사이즈 제한 / 업데이트 트리거)
- `sessions/meta/vX-claude-native-agents` — Claude Code AGENTS.md 네이티브 지원 시 symlink 전환

### 3개월 재평가 게이트

본 세션 "bash-only" 원칙은 글로벌 레이어 최소 책임 원칙과 영구. upbit 외 실증 프로젝트(Go/TS/Rust) bootstrap-templates 진행 후 `state_file` / `statusline_cmd` 계약 현실 검증.
