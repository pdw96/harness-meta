# A5 — Regression risk 종합 (β scope, 5축 통합)

본 audit β 정정 (5 파일 frontmatter 5축 통합 재작성)이 기존 동작에 미치는 영향 분석.

## Risk matrix (5축)

| 축 | 정정 | 의미 변화 | Risk | 비고 |
|----|------|----------|:----:|------|
| A1 필드명 | `tools:` → `allowed-tools:` (1 파일) | declare가 처음 정상 작동할 수 있음 → pre-approval 시작 | 🟢 0 (긍정 변화) | 일부 명령 prompt 안 발생 |
| A2 separator | 콤마 → YAML list (5 파일) | 현재 무효였다면 → 정상 작동 | 🟢 0 (긍정 변화) | 동상 |
| A3 pattern | `cmd*` → `cmd *` (9 패턴) | 의도 외 매치 차단 (`lsof`, `gitk` 등) | 🟢 0 | 본 repo 호출 명령 모두 정확한 명령명, 부작용 0 |
| A4 redundant | 자동 허용 set declare 제거 (-6건) | 행위 무변화 | 🟢 0 | declare 효과 0 |
| A5 argument | 미시도 (Conservative 유지) | 변화 없음 | 🟢 0 | — |

총 risk = 🟢 0. 모든 정정이 spec 정합 또는 redundant 제거.

## A1 + A2 정정의 함의 — declare가 처음 작동

현재 가설:

- harness-meta.md `tools: Read, Glob, ..., Bash(...)` — A1 위반 + A2 위반 → silent ignore 또는 단일 문자열 파싱
- 4 SKILL `allowed-tools: Read, ..., Bash(...)` — A2 위반 → 콤마 형식 spec 보장 없음

정정 후:

- `allowed-tools: \n  - Read\n  - ...\n  - Bash(... *)` — A1 정합 + A2 정합 → **declare 처음 정상 작동**

**가능 시나리오**:

- (a) 현재 declare 무효 → 모든 Bash 명령 baseline 폴백 → settings.json 또는 자동 허용 set 의존
- (b) 현재 declare lenient 작동 → 행위 동일 (콤마 lenient 해석)
- (c) 두 가능성의 mix

(a) 시나리오에서:

- `mkdir`, `git add`, `bash`, `pwsh`, `sed -i`, `mv`, `cp`, `rm` 등 declare된 명령 호출 시 **현재 prompt 발생** → 정정 후 **prompt 안 발생** (pre-approval 작동)
- 사용자 입장: 정정 후 prompt 빈도 감소 (긍정 변화)

(b) 시나리오에서:

- 현재 prompt 발생 빈도 = 정정 후 빈도 = 0 (모두 자동 허용 또는 settings.json 덮음)
- 사용자 변화 인지 못함

**판별 방법**: 사용자 사이드 dynamic 검증 (V3) — 정정 후 첫 `/harness-meta` 호출 시 `mkdir` 등 명령 prompt 발생 여부.

## Compound command 검증 (V6)

A1 인용 6: `&&`, `||`, `;`, `|`, `|&`, `&`, newlines = separator. 각 subcommand 독립 매치.

`harness-meta.md` body grep 결과:

- `^!|^\s*!|^\s*\\\$\\\(` → 0 (inline bash injection 없음)
- `&&|\|\|` → 0 (compound 없음)

→ markdown body에 실 동작 명령 0건. 모든 Bash 호출은 Claude tool call (런타임). frontmatter `allowed-tools:`가 유일한 pre-approval 메커니즘.

**결론**: compound 영향 없음.

## Process wrapper 검증 (V5의 일부)

A1 인용 5: `timeout`, `time`, `nice`, `nohup`, `stdbuf`, bare-`xargs` 자동 strip.

본 repo wrapper 사용: `harness-meta.md` body 검색 결과 0건.

**결론**: 정정 후 `Bash(bash *)`, `Bash(pwsh *)` 등이 직접 호출에 정확 매치.

## Word-boundary 차이 fine-grain (A3)

| 명령 | `Bash(cmd*)` (현) | `Bash(cmd *)` (정정) | 의도 외 차단 |
|------|------------------|---------------------|-------------|
| `ls` | `ls`, `lsof`, `lsblk`, `lspci`, `lsattr` | `ls`만 | (declare 제거 — A4) |
| `git` | `git`, `gitk`, `git-lfs` | `git`만 | gitk (GUI) 차단 |
| `mv` | `mv`, `mvdir` | `mv`만 | mvdir 차단 |
| `cp` | `cp`, `cpio`, `cpan`, `cpufreq-info` | `cp`만 | cpio/cpan 차단 |
| `rm` | `rm`, `rmdir`, `rmuser` | `rm`만 | rmdir/rmuser 차단 |
| `mkdir` | `mkdir`, `mkdirhier` | `mkdir`만 | mkdirhier 차단 |
| `bash` | `bash`, `bashbug` | `bash`만 | bashbug 차단 |
| `pwsh` | `pwsh`, `pwshc` (가상) | `pwsh`만 | — |
| `sed` | `sed`, `sedbench` | `sed`만 | — |
| `uname` | `uname` | `uname`만 | — |

**부작용 평가**: 본 repo가 실제 호출하는 명령은 모두 정확한 명령명. word-boundary 정정 부작용 0.

## 사용자 환경 retroactive 영향

본 v1.10d β 정정 후:

- **harness-meta repo**: 5 파일 정정. install.ps1 재실행 없이 즉시 적용 (`harness-meta.md`는 symlink로 글로벌 즉시 반영)
- **신규 프로젝트**: install-project-claude.{ps1,sh} 호출 시 정정된 템플릿 자동 배포
- **upbit (기존)**: 미영향 — install 재실행 시까지 옛 형식 유지. T4 후행 세션
- **사용자 글로벌 settings**: 미영향 — 이미 콜론 형식 (= 공백 등가)

**전반 risk**: 🟢 minimal. 모든 정정이 spec 정합 또는 redundant 제거. (a) 시나리오 시 사용자 prompt 빈도 감소.

## 검증 단계 (smoke + dynamic)

| Test | 방식 | 기대 |
|------|------|------|
| V1 Static (A3) | grep 콜론 없는 `Bash\(\w+\*\)` 잔존 0건 | 5 파일 모두 0 |
| V2 Reference verbatim | A1 11 quotes 인용 | `audit/A1-anthropic-docs.md` |
| V3 Dynamic (REPORT) | 사용자 사이드 — 정정 후 `/harness-meta` 진입 시 `mkdir` 등 prompt 빈도 변화 | (a)/(b) 시나리오 판별 |
| V5 Redundancy (A4) | grep 자동 허용 set declare 잔존 0 (`Bash\((ls\|grep\|wc\|cat\|find)[ :]?\*?\)`) | 5 파일 모두 0 |
| V6 Compound | grep `&&\|\|\|` in `harness-meta.md` body | 0 또는 markdown 코드 블록만 |
| **V7 (NEW) Field name (A1)** | grep `^tools:` in `claude/commands/*.md` | 0 (`allowed-tools:`로 변경) |
| **V8 (NEW) Separator (A2)** | grep 콤마 (`allowed-tools:.*,`) in 5 파일 single-line | 0 (YAML list로 전환) |
| **V9 (NEW) YAML list 형식** | grep `^allowed-tools:\s*$` followed by `^  -` 라인 | 5 파일 모두 매치 |

smoke `tests/smoke-bash-permission-pattern.sh` 신규 작성 (4 stage → 5 stage 확장).

## 사용자 사이드 dynamic 검증 (REPORT 단계)

본 audit 정정 commit 후 사용자가 다음을 확인:

1. `/harness-meta` slash command 정상 진입 (정정된 `allowed-tools:` 파싱 성공)
2. 진입 후 다음 명령 prompt 발생 여부 (V3):
   - `git status` — prompt 없음 기대 (자동 허용)
   - `mkdir foo` — pre-approval 작동 시 prompt 없음 / 무효 시 prompt 발생
   - `bash script.sh` — 동상
   - `pwsh script.ps1` — 동상
3. 신규 SKILL 호출 (`/harness-design`, `/harness-plan`, `/harness-review`) 정상 작동
4. (b) 시나리오 — 변화 인지 못함이 정상

dynamic 검증 결과는 REPORT.md "사용자 사이드 검증 (V3)" 섹션에 보고.

## β scope 확장의 잠재 risk

α scope (16 → 10) → β scope (5축 통합) 확장으로:

- diff 크기 증가 (frontmatter 재작성)
- 단 단일 commit 단위 — 부분 적용 risk 0
- 사용자 사이드 dynamic 변화 가능성 (긍정 — prompt 빈도 감소)

**Decision**: β scope 채택 (사용자 D1 결정). risk 분석 통과.
