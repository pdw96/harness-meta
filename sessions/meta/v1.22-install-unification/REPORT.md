# meta v1.22-install-unification — REPORT

세션 종료: 2026-04-29
선행 세션: [`sessions/meta/v1.21-install-cleanup-foundation/`](../v1.21-install-cleanup-foundation/REPORT.md)

## 최종 결과

| 항목 | 수치 |
|------|------|
| Smoke PASS | smoke-skills-install 9/9 + smoke-sync-agents 5/5 + smoke-scope-contract 42/42 |
| 회귀 | 0 (smoke-language-overlay 11/11, smoke-legacy-cleanup-overlay 9/9) |
| 신규 파일 | 4 (`sync-agents.sh`, `sync-agents.ps1`, `tests/smoke-sync-agents.sh`, PLAN+REPORT) |
| 수정 파일 | 6 (`install-skills.ps1`, `install-skills.sh`, `SKILLS.md`, `AGENTS_MD_STRATEGY.md`, `smoke-skills-install.sh`, `smoke-scope-contract.sh`) |

## 구현 요약

### E: install-skills copy mode fallback

**`install-skills.ps1`** (Stage A):

- `[switch]$CopyMode` 파라미터 추가
- `$ModeFile = Join-Path $SkillsDest '.harness-install-mode'` 변수 추가
- `Install-OneSkill` 함수: `New-Item -ItemType SymbolicLink` → try/catch 감쌈
  - `CopyMode` 명시 → `Copy-Item -Path $src -Destination $dest -Recurse -Force` 직접 실행
  - symlink 시도 catch → copy fallback (잔여물 제거 → copy → rollback if copy도 실패)
  - 성공 시 `"symlink"/"copy" | Set-Content $ModeFile`
- `.DESCRIPTION`, `.PARAMETER CopyMode`, `.EXAMPLE` 갱신

**`install-skills.sh`** (Stage B):

- `COPY_MODE=0` + `--copy-mode` 인자 파싱 추가
- `MODE_FILE="$SKILLS_DEST/.harness-install-mode"` 변수 추가
- `install_one()` 함수: copy mode 분기 + symlink 실패 시 copy fallback
- **Git Bash 위임 플래그 변환 맵 (D6 버그 해소)**: `exec pwsh "$@"` → `_ps_args` 배열로 전체 변환 (`--all` → `-All`, `--dry-run` → `-DryRun`, `--list` → `-List`, `--copy-mode` → `-CopyMode`)

### C: sync-agents 통합

**`sync-agents.sh`** (Stage C):

- 7개 `AGENT_MAPPINGS` (CLAUDE.md, GEMINI.md, .github/copilot-instructions.md, .cursor/rules/main.mdc, CONVENTIONS.md, .clinerules/main.md, .roo/rules/main.md)
- SHA-256 3단 fallback: `sha256sum` → `shasum -a 256` → `python3 hashlib`. `awk '{print $1}'` 안전 파싱
- symlink 파일 자동 skip (`[ -L "$target" ]`)
- 플래그: `--check` / `--source-wins` / `--dry-run` / `--list-targets`
- 비대화형 감지: `[ ! -t 0 ] || [ -n "${CI:-}" ]` → warn + exit 1
- `/dev/tty` 기반 warn-and-prompt
- Windows Git Bash → `sync-agents.ps1` 위임 (플래그 변환 맵 포함)

**`sync-agents.ps1`** (Stage D):

- `Get-FileHash -Algorithm SHA256` + `.Hash.ToLower()`
- `$item.LinkType -in @('SymbolicLink', 'Junction')` skip (D18 Junction 처리)
- 비대화형: `[Console]::IsInputRedirected -or ($null -ne $env:CI)`
- `Copy-Item -Path $Canonical -Destination $target -Force` (바이너리 복사)
- 플래그: `-SourceWins` / `-Check` / `-DryRun` / `-ListTargets`

### 문서 갱신 (Stage E)

**`bootstrap/docs/SKILLS.md`**:

- §4: copy mode 사용법 섹션 추가 (`-CopyMode` / `--copy-mode` / 모드 파일)
- §5: 충돌 정책 표에 copy mode 열 추가 + 모드 파일 설명
- §6: OS 분기 표에 copy mode fallback 행 추가 (v1.22+ 자동 fallback)

**`bootstrap/docs/AGENTS_MD_STRATEGY.md`**:

- §4.2: "실제 구현: v1.21" → "v1.22" 갱신 + AGENT_MAPPINGS 표 + 인터페이스 플래그 표 + exit code 정책

### Smoke 갱신 (Stage F-H)

- `smoke-skills-install.sh`: 정적 2건 추가 (CopyMode/try/harness-install-mode 검증) + dynamic 3건 추가 (copy mode 설치 검증) = 9 정적 + 3 dynamic → PASS 9/9 (Linux/macOS는 12/12)
- `smoke-sync-agents.sh`: 신규 9 checks (정적 5 + dynamic 4) → PASS 5/5 (Linux/macOS는 9/9)
- `smoke-scope-contract.sh`: `v1.22*/PLAN.md` glob 추가 → PASS 42/42

## 판정

| 성공 기준 | 결과 |
|-----------|------|
| install-skills.ps1: `-CopyMode` + try/catch + copy fallback + `.harness-install-mode` | ✅ |
| install-skills.sh: `--copy-mode` + `_ps_args` 플래그 변환 + `.harness-install-mode` | ✅ |
| sync-agents.sh: sha256/shasum/python3 + awk + AGENT_MAPPINGS 7건 | ✅ |
| sync-agents.ps1: Get-FileHash + Junction skip + source-wins | ✅ |
| AGENTS_MD_STRATEGY.md §4.2: "실제 구현: v1.22" + 인터페이스 스펙 | ✅ |
| SKILLS.md §5+6: copy mode 행 추가 | ✅ |
| smoke-skills-install.sh: +5건 PASS | ✅ |
| smoke-sync-agents.sh 5/5 PASS (정적) | ✅ |
| smoke-scope-contract.sh v1.22 self-test PASS | ✅ |
| 회귀 0 (smoke-language-overlay, smoke-legacy-cleanup-overlay) | ✅ |

**모든 PLAN 체크박스 완수.**

## Lessons Learned

- **L1 — D6 잠재 버그 해소 기회**: `exec pwsh "$@"` 위임 버그는 `--copy-mode` 추가 기회에 전체 변환 맵으로 해소. 신규 플래그 추가 시 위임 경로 동시 점검 원칙 확인
- **L2 — try/catch와 rollback 순서**: `$ErrorActionPreference='Stop'` 환경에서는 예외가 함수 전체를 탈출하므로 rollback 로직을 catch 블록 안에 배치해야 함. 코드 순서 의존 패턴 위험
- **L3 — sync-agents는 HARNESS_META_ROOT 불필요**: CWD의 AGENTS.md를 canonical로 하는 per-project 도구이므로 repo 루트 개념이 필요 없음 (D4 분석). 도구 설계 전 실행 컨텍스트 명확화의 중요성
- **L4 — awk vs cut**: sha256sum 이진 모드 출력(`<hash> *<file>`)에서 `cut -d' ' -f1`은 이론상 실패 가능. `awk '{print $1}'`은 공백 구분자 모두 처리 → SHA-256 파싱의 표준 패턴으로 채택

## 다음 후보 (보류)

| 세션 | 내용 | 조건 |
|------|------|------|
| `v1.23-verify-unification` | verify.sh 신설 + verify.ps1 overlay/frontmatter 6축 통합 | v1.22 안정 후 |
| `v1.24-multi-os-validation` | macOS/Linux dynamic CI 검증 | 제3 기기 또는 CI 환경 확보 후 |
| `v1.22b-sync-agents-target-wins` | `target-wins` 정책 전체 구현 | sync-agents 실 사용 사례 발생 시 |
