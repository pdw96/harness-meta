# A5 — 회귀 위험 + smoke 정당화

본 audit는 v1.10f 변경 적용 후 (a) 신규 프로젝트 bootstrap → templates copy 후 frontmatter 효과 / (b) 기존 deployed projects 영향 / (c) v1.10d β scope 회귀 영향 / (d) cross-platform (자동 허용 set OS 차이) / (e) smoke 6 stage 설계 정당화를 분석한다.

## 1. 회귀 영향 매트릭스 (3 시나리오)

### 시나리오 1 — 신규 프로젝트 bootstrap 후 templates copy

`/harness-meta <new-name>` Bootstrap 모드 → S6 stage `install-project-claude.{ps1,sh}` → templates 4 파일이 `<proj>/.claude/{skills,agents}/`로 복사.

| 변경 | 신규 프로젝트 영향 | 회귀 시그널 |
|------|-------------------|-----------|
| `harness/SKILL.md` Bash 제거 | 디스패처 호출 시 우연한 Bash 실행 → prompt | 기존 워크플로우 prompt 발생 시 → 디스패처 본문 코드 변경 필요 (드물 것 — A1 §1 evidence: 본문 Bash 0) |
| `harness-run` broad 유지 | 동일 (broad Bash 의미 변화 0) | 0 |
| `harness-ship` broad 유지 | 동일 | 0 |
| `harness-verifier` broad 유지 | 동일 (`tools:` 필드 정합) | 0 |
| 4 파일 콤마 → YAML list | 파싱 정합 (A2 인용 14: skills docs verbatim "space OR YAML list") | colon-separated 패턴 (`Bash(git:*)`) 사용 시 콤마 separator 충돌 가능성 — YAML list 채택으로 해결 |

**예상 시그널 빈도**:
- (a) 디스패처 prompt 발생: **확률 < 5%** (본문 Bash 0이지만 미래 코드 변경 시)
- (b) 파싱 오류: **확률 0** (YAML list는 spec verbatim)
- (c) 의도된 broad Bash 작동: **확률 100%** (broad Bash 의미 변화 0)

### 시나리오 2 — 기존 deployed projects 영향

본 v1.10f는 templates baseline만 정정. 기존 deployed `<proj>/.claude/`는 **자동 동기화 안 됨** (copy 모드).

| 프로젝트 상태 | 본 v1.10f 영향 | 후속 |
|------|---|------|
| upbit (현재 유일 deployed) | **0** — `<proj>/.claude/`는 S6 (project owned) | T4 후행 — `sessions/upbit/v1.2-bash-permission-update/` (별도 프로젝트 세션) |
| 미래 deployed | **0** (이미 deploy됨) | 각자 자기 세션에서 흡수 |

**T4 분리 패턴**:
- 선행 (본 v1.10f, meta): templates baseline 정정 → 미래 새 프로젝트 baseline 확보
- 후행 (각 프로젝트, T4): deployed `.claude/`의 동일 정정 (자기 세션 책임)

deployed projects 영향 0 — 본 v1.10f는 미래 새 프로젝트만 영향.

### 시나리오 3 — v1.10d β scope 회귀 영향

v1.10d β scope 4 파일 (`harness-meta.md` + `harness-design`/`harness-plan`/`harness-review` SKILL):

| 파일 | 본 v1.10f 변경 | 회귀 영향 |
|------|---|---|
| `claude/commands/harness-meta.md` | 무변경 | 0 |
| `bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md` | 무변경 | 0 |
| `bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md` | 무변경 | 0 |
| `bootstrap/templates/_base/.claude/skills/harness-review/SKILL.md` | 무변경 | 0 |

→ v1.10d β scope 회귀 영향 **0**. 기존 `tests/smoke-bash-permission-pattern.sh` 6/6 PASS 유지 보장.

## 2. Cross-platform 영향 (자동 허용 set OS 차이)

### 자동 허용 set 12 명령 OS 가용성

PERMISSION_PATTERN.md §5 인용 3 (Anthropic permissions docs): "`ls`, `cat`, `head`, `tail`, `grep`, `find`, `wc`, `diff`, `stat`, `du`, `cd`, and read-only forms of `git`. The set is not configurable."

| 명령 | macOS/Linux | Windows (Git Bash / WSL) | Windows (PowerShell native) |
|------|:---:|:---:|:---:|
| `ls` | ✓ POSIX | ✓ Git Bash POSIX | ✗ (`Get-ChildItem` 또는 alias `ls`) |
| `cat` | ✓ POSIX | ✓ Git Bash | ✗ (`Get-Content` 또는 alias `cat`) |
| `head` | ✓ POSIX | ✓ Git Bash | ✗ (`Select-Object -First`) |
| `tail` | ✓ POSIX | ✓ Git Bash | ✗ (`Select-Object -Last`) |
| `grep` | ✓ POSIX | ✓ Git Bash | ✗ (`Select-String`) |
| `find` | ✓ POSIX | ✓ Git Bash | ✗ (`Get-ChildItem -Recurse`) |
| `wc` | ✓ POSIX | ✓ Git Bash | ✗ (`Measure-Object`) |
| `diff` | ✓ POSIX | ✓ Git Bash | ✗ (`Compare-Object`) |
| `stat` | ✓ POSIX | ✓ Git Bash | ✗ (`Get-Item`) |
| `du` | ✓ POSIX | ✓ Git Bash | ✗ |
| `cd` | ✓ shell builtin | ✓ shell builtin | ✓ (`Set-Location` alias) |
| `git` (read-only) | ✓ Git CLI | ✓ Git for Windows | ✓ (Git for Windows installed) |

**관찰**:
- Claude Code의 Bash tool은 **Windows에서도 bash (Git Bash 또는 WSL) 호출** → POSIX 명령 자동 허용 set 작동
- PowerShell tool은 별도 — 본 frontmatter `Bash` declare 영역 외 (PowerShell tool은 `Bash()` 패턴 매치 안 함)
- → **본 v1.10f의 R2 (`harness/` Bash 제거) 결정은 Windows 환경에서도 안전** — 자동 허용 set이 POSIX bash에서 작동

### 본 v1.10f cross-platform 회귀 시그널

| 환경 | R2 영향 (harness/ Bash 제거) | R3/R4 영향 (broad 유지) |
|------|---|---|
| macOS | 0 (POSIX 자동 허용) | 0 |
| Linux | 0 (POSIX 자동 허용) | 0 |
| Windows + Git Bash | 0 (Git Bash POSIX) | 0 |
| Windows + WSL | 0 (WSL POSIX) | 0 |
| Windows + PowerShell native | 별도 tool — frontmatter 영역 외 | 별도 tool — 영역 외 |

→ 본 v1.10f cross-platform 회귀 영향 0.

### CRLF/EOL 영향

본 v1.10f 변경 4 파일 모두 markdown — `.gitattributes`에 `*.md text=auto` (또는 `eol=lf`) 적용 시 normalized. frontmatter YAML 파싱은 `\r\n` 문제 없음 (yaml parser가 양쪽 처리).

## 3. Smoke 6 stage 설계 정당화

`tests/smoke-broad-bash-fine-grain.sh` 6 stage:

### Stage 1 — V8 (A2): single-line 콤마 separator 잔존 0

```bash
grep -E '^(allowed-tools|tools):.+,' <4 파일>
```

**검증 대상**: 4 파일 모두 single-line 콤마 separator 부재 (YAML list 변환 완료)

**기대값**: 0건

**실패 시 의미**: YAML list 변환 누락 → A2 인용 14 spec 위반

**v1.10d 회귀 보장**: PERMISSION_PATTERN.md V8 검증 명령 동일

### Stage 2 — V9 (A2): YAML list `^  - ` 라인 ≥ entries 수

```bash
# 4 파일 각각:
# harness/SKILL.md: 4 entries (Read/Glob/Grep/Edit)
# harness-run/SKILL.md: 5 entries (Read/Glob/Grep/Bash/Edit)
# harness-ship/SKILL.md: 6 entries (Read/Glob/Grep/Bash/Edit(phases/**)/Write(phases/**))
# harness-verifier.md: 4 entries (Read/Glob/Grep/Bash)
```

**검증 대상**: YAML list 형식 정합 (각 파일별 entries 수 일치)

**기대값**: harness/=4, harness-run=5, harness-ship=6, harness-verifier=4

**실패 시 의미**: YAML list 변환 시 entry 누락 또는 추가 — A1 inventory 매칭 실패

### Stage 3 — R2 검증: `harness/SKILL.md` Bash declare 부재

```bash
grep -E '^\s*-\s*Bash(\s*\(.*\))?$' bootstrap/templates/_base/.claude/skills/harness/SKILL.md
```

**검증 대상**: R2 적용 — Bash declare 제거 완료

**기대값**: 0건

**실패 시 의미**: R2 미적용 — Bash declare 잔존

### Stage 4 — R3/R4 검증: `harness-run`/`harness-ship`/`harness-verifier` broad Bash (parens 없음) 존재

```bash
# 3 파일 각각 broad Bash entry 1건 존재
grep -E '^\s*-\s*Bash$' <3 파일>
```

**검증 대상**: R3/R4 적용 — broad Bash 유지 (parens 없음 = `Bash(*)` equivalent)

**기대값**: 각 파일 1건

**실패 시 의미**: R3/R4 미적용 또는 fine-grain 시도 — A3 fragile 위반

### Stage 5 — V5 (A4): 자동 허용 set declare 잔존 0

```bash
auto_set='Bash\((ls|cat|head|tail|grep|find|wc|diff|stat|du|cd)([: ]\*?)?\)'
grep -cE "$auto_set" <4 파일>
```

**검증 대상**: 자동 허용 set declare 잔존 0 (PERMISSION_PATTERN.md §5 인용 3)

**기대값**: 0건

**실패 시 의미**: 자동 허용 set declare 위반 — declare 효과 0인 redundant 패턴

### Stage 6 — Field name (A1): 3 SKILL `allowed-tools:` + 1 agent `tools:` 정합

```bash
# 3 SKILL: allowed-tools: 존재 + tools: 부재
# 1 agent (verifier): tools: 존재 + allowed-tools: 부재
```

**검증 대상**: A1 매트릭스 (인용 7-8, 10, 11) — 필드명 정합

**기대값**: 3 SKILL=allowed-tools, 1 agent=tools

**실패 시 의미**: 필드명 혼용 — silent ignore 또는 파서 lenient 의존 (spec 미보장)

## 4. v1.10d 회귀 smoke

`tests/smoke-bash-permission-pattern.sh` 6 stage 회귀 보장 — 본 v1.10f가 v1.10d β scope 4 파일 무변경.

| Stage | 검증 | 본 v1.10f 영향 |
|------|------|:---:|
| 1 (V1 A3 pattern format) | 콜론 없음 패턴 잔존 0 | 0 (β scope 무변경) |
| 2 (V5 A4 redundancy) | 자동 허용 set declare 잔존 0 | 0 |
| 3 (V7 A1 field name) | `allowed-tools:` 정합 | 0 |
| 4 (V8 A2 separator) | 콤마 separator 잔존 0 | 0 |
| 5 (V4 R5' doc) | PERMISSION_PATTERN.md keyword 9/9 | 0 |
| 6 (V9 A2 YAML list) | YAML list 형식 정합 | 0 |

→ 6/6 PASS 유지 보장. Stage E에서 회귀 실행 후 evidence 저장.

## 5. 시그널 모니터링 (Stage E REPORT 기록)

본 v1.10f 적용 후 사용자 환경 dynamic 검증 (REPORT.md `## 후속 시그널 모니터링` 섹션):

### 시그널 1 — 신규 프로젝트 bootstrap 후 디스패처 prompt 빈도

- 측정: `/harness` 호출 시 prompt 발생 빈도
- 임계: 1 세션 내 1건 이상 → R2 재검토 (디스패처 본문에 Bash 사용 추가 여부)
- 기대: 0건 (A1 §1 evidence: 본문 Bash 0)

### 시그널 2 — `harness-run` `{executor}` 호출 후 prompt 발생

- 측정: 8/9단계 dry-run / push-per-step 호출 시 prompt 발생 빈도
- 임계: 매 호출마다 prompt → broad `Bash` 미적용 의심 (settings.json deny rule 충돌 가능)
- 기대: 0건 (broad `Bash` 의도)

### 시그널 3 — `harness-ship` git WRITE 호출 후 prompt 발생

- 측정: 10-5 git ops (add/commit/push 등) 호출 시 prompt 발생 빈도
- 임계: 매 호출마다 prompt → 사용자 settings.json deny rule 충돌 (예: `Bash(git push *)` deny)
- 기대: 사용자 환경 의존 — destructive 명령은 의도된 prompt 가능

### 시그널 4 — `harness-verifier` agent isolation 영향

- 측정: harness-verifier 호출 시 Bash 사용 여부 + prompt 발생
- 임계: Bash 사용 발생 → R4 재검토 (4-Functional 단계 evolution 검토)
- 기대: 0건 (현 시점 본문 Bash 0)

## 6. 종합 — 회귀 위험 등급

| 시나리오 | 위험 등급 | 모니터링 시그널 | 회귀 시 액션 |
|---------|:---:|--------|---------|
| 신규 프로젝트 bootstrap | **LOW** | 시그널 1 | R2 재검토 (Bash declare 복원) |
| 기존 deployed projects | **NONE** | 0 (영향 0) | — |
| v1.10d β scope | **NONE** | smoke 회귀 6/6 | — |
| Cross-platform | **NONE** | 0 | — |
| `harness-run` workflow | **LOW** | 시그널 2 | settings.json deny rule 충돌 진단 |
| `harness-ship` workflow | **MEDIUM** (사용자 환경 의존) | 시그널 3 | settings.json deny rule 가이드 (PERMISSION_PATTERN.md §9) |
| `harness-verifier` agent | **NONE** | 시그널 4 | (현 시점 0) |

**전체 회귀 위험**: **LOW** (시그널 1 + 시그널 3 사용자 환경 의존). smoke 6/6 + 회귀 v1.10d 6/6 PASS 시 적용 안전.

## 7. 관련 문서

- 본 세션 PLAN: [`../PLAN.md`](../PLAN.md)
- A1 본문 inventory: [`A1-bash-usage.md`](A1-bash-usage.md)
- A2 권위 인용: [`A2-anthropic-docs.md`](A2-anthropic-docs.md)
- A3 동적 변수: [`A3-dynamic-vars.md`](A3-dynamic-vars.md)
- A4 정책 결정: [`A4-policy-decisions.md`](A4-policy-decisions.md)
- 5축 spec: [`../../../../bootstrap/docs/PERMISSION_PATTERN.md`](../../../../bootstrap/docs/PERMISSION_PATTERN.md)
- 선행 smoke: [`../../../../tests/smoke-bash-permission-pattern.sh`](../../../../tests/smoke-bash-permission-pattern.sh)
