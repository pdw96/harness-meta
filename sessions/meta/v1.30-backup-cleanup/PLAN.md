# meta v1.30-backup-cleanup — PLAN

세션 시작: 2026-04-29
직접 선행 세션:

- [`sessions/meta/v1.21-install-cleanup-foundation/`](../v1.21-install-cleanup-foundation/PLAN.md) — Out of scope: "backup-<ts>/ 디렉토리 누적 자동 정리 — 별 후속 evidence-driven"
- [`sessions/meta/v1.22-install-unification/`](../v1.22-install-unification/PLAN.md) — Out of scope: "backup 누적 자동 정리 (`~/.claude/backups/skills/`)"

목적: 3 backup source의 누적 자동 정리 mechanism 도입. evidence (`~/.claude/backups/skills/` 3건 누적) 기반 진입.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1c(2) `install-skills.{sh,ps1}` + S1b(2) `bootstrap/install-project-claude.{sh,ps1}` + S2(1) `bootstrap/docs/SKILLS.md` + S3(1) `tests/smoke-backup-cleanup.sh` = **6/6 meta**
- **T1 경로 다수결** — meta scope 6/6
- **T2 스펙 vs 값** — backup 정리 정책 = 모든 사용자 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.21-install-cleanup-foundation/PLAN.md` Out of scope** (verbatim):

> `| backup-<ts>/ 디렉토리 누적 자동 정리 | 별 후속 evidence-driven (현재는 사용자 수동 정리) |`

**Source 2 — `sessions/meta/v1.22-install-unification/PLAN.md` Out of scope** (verbatim):

> `| backup 누적 자동 정리 (~/.claude/backups/skills/) | 별 후속 evidence-driven |`

**Source 3 — `bootstrap/docs/SKILLS.md §5`** (verbatim):

> `**-Force 미지원**: 항상 backup. 자동 cleanup 없음 → 사용자 수동 정리 (안전).`
> `backup 디렉토리 누적 방지: ls ~/.claude/backups/skills/ 2>/dev/null  # 확인 후 불필요한 것 수동 삭제`

**Parsed sub-items (3)**:

1. **`~/.claude/backups/skills/<name>.<ts>/` 누적 정리** — install-skills.{sh,ps1} 생성 source. 현 3건 누적
2. **`<proj>/.claude/backup-<ts>/` 누적 정리** — install-project-claude.{sh,ps1} 생성 source (legacy cleanup + 충돌 backup)
3. **`<proj>/.harness/backups/manifest.<ts>.toml` 누적 정리** — bootstrap rebootstrap source (interview.md §5)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| backup 콘텐츠 무결성 검증 (실제 source vs backup diff) | 별 후속 evidence-driven |
| pre-commit / cron-based 주기적 자동 정리 | v1.32+ pre-commit hook 도입 시 |
| backup 압축 (tar.gz) 저장 | evidence-driven (디스크 사용량 부담 누적 시) |
| `<proj>/.claude/backup-<ts>/` 자동 정리 — install-project-claude는 프로젝트 cwd 작동, 사용자 git status 즉시 가시 | 본 세션은 "사용자 가시 외부" 2 source만 (skills + manifest) |
| Restore CLI (`install-skills --restore <name>.<ts>`) | 별 후속 evidence-driven |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/gnu_software_bash_manual_html_node` (1차 — bash) + `/microsoftdocs/powershell-docs` (2차 — PowerShell) |
| **topic** | shift n opt arg / `[[ =~ ]]` regex / Where-Object LastWriteTime / Remove-Item -Recurse -LiteralPath / [switch]+[int] param default / env in param default |
| **findings** | see citations below |
| **drift** | no — PLAN R1~R5 + D1~D17 결정이 양 spec과 정합 (옵션 인자 `shift 2` builtin, regex strict 매치 anchors, mtime 비교 idiom, 디렉토리 재귀 삭제 + LiteralPath, switch+int 파라미터 결합 default, env override 패턴 모두 공식 문서화 표준) |
| **re-verify** | bash 5.x → 6.x 또는 PowerShell 7.x → 8.x 메이저 변경 시 / install-skills 신규 cmdlet 추가 시 / S-Project / S-Manifest source 통합 시 (v1.30c+) |

**Citations**:

- C1 — Bash `shift n` builtin officially supports integer `n` (D8 `--retain N` + `shift 2` 패턴 정합) (Source: `https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html`)
- C2 — Bash `[[ =~ ]]` POSIX ERE 매처 + `^...$` 앵커 + return 0=match/1=no/2=syntax (D12 `^.+\.\d{8}-\d{6}$` strict 매치 정합) (Source: `https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html`)
- C3 — PowerShell `Get-ChildItem ... | Where-Object { $_.LastWriteTime -gt <DateTime> }` 표준 idiom (D5 grace 검사 패턴 — `(Get-Date).AddDays(-$GraceDays) -gt $_.LastWriteTime` 정합) (Source: `https://github.com/microsoftdocs/powershell-docs/blob/main/reference/docs-conceptual/samples/Working-with-Files-and-Folders.md`)
- C4 — PowerShell `Remove-Item -Recurse` (재귀 삭제, 자식 prompt 없음) + `-LiteralPath` (wildcard 차단 — path에 `.` 포함 안전) (D12 backup dir 재귀 삭제 정합) (Source: `https://github.com/microsoftdocs/powershell-docs/blob/main/reference/docs-conceptual/learn/deep-dives/visualize-parameter-binding.md`)
- C5 — PowerShell `[switch]$Param` + `[int]$X = N` default 결합 (D8 `[switch]$Cleanup`/`[switch]$CleanupAfter`/`[switch]$Yes` + `[int]$Retain = 3`/`[int]$GraceDays = 7` 정합) (Source: `https://github.com/microsoftdocs/powershell-docs/blob/main/reference/docs-conceptual/lang-spec/chapter-08.md`)
- C6 — PowerShell env in param default (`$env:COMPUTERNAME` 예시) (D16 `[string]$BackupRoot = $(if ($env:HARNESS_SKILLS_BACKUP_ROOT) { ... })` 정합) (Source: `https://github.com/microsoftdocs/powershell-docs/blob/main/reference/docs-conceptual/learn/ps101/09-functions.md`)

## 1. Evidence

### 1-1. 실 누적 사례

```
~/.claude/backups/skills/
├── ai-ready-scorer.20260429-030700/    # v1.20 이관
├── developer-profile.20260429-035422/  # v1.20 이관
└── mindvault.20260429-035422/          # v1.20 이관
```

3건 누적 (모두 v1.20 같은 날짜). 같은 skill을 여러 번 재install하면 N개 누적 → 시간 흐를수록 단조 증가.

### 1-2. Manifest backup source (현 0건이나 spec 기록됨)

`bootstrap/interview.md §5 Idempotency` + `INTERVIEW_FLOW.md §5`:
> `<proj>/.harness/backups/manifest.<YYYYMMDD-HHMMSS>.toml`

bootstrap rebootstrap 시 자동 backup. 향후 수년 사용 시 누적 가능.

### 1-3. v1.21 + v1.22 양쪽에서 후속으로 명시 — 2회 deferral 누적

## 2. 결정 (R1 ~ R5)

### R1 — 정리 정책: count-based + grace period

**채택**: **최근 N개 유지 (default N=3)** + **grace period 7일 미만 보존 (안전 net)**

근거:

- TTL-only (예: 30일 초과 삭제)는 사용자가 backup을 1회도 retain 못하는 경우 발생 가능
- count-only는 1일 내 N+1 backup 시 가장 오래된 것이 사라짐 — 디버깅 회복력 ↓
- 결합: count로 정리하되 7일 미만 backup은 count 초과해도 보존

**예시**:

- 5 backup 존재, 3개는 7일 이내 → 모두 보존 (count 초과해도 grace)
- 5 backup 존재, 모두 7일 초과 → 최근 3개만 유지, 2개 삭제

### R2 — 정리 트리거: 명시 CLI + install 시 자동 (default off)

**`install-skills.{sh,ps1}` 신규 플래그**:

- `--cleanup` / `-Cleanup` — backup 정리 수행 후 종료 (skill install 안 함)
- `--cleanup-after` / `-CleanupAfter` — install 후 cleanup 1회 수행
- `--retain N` / `-Retain N` — N 개 유지 (default 3)
- `--grace-days D` / `-GraceDays D` — D일 미만 보존 (default 7)

**install 시 자동 정리는 default off** — 안전성 우선. 사용자가 `--cleanup-after` 명시할 때만.

**Dry-run**: 기존 `--dry-run`과 결합. `install-skills.sh --cleanup --dry-run` → 삭제 계획만 출력.

### R3 — 신규 스크립트: `cleanup-backups.{sh,ps1}` 분리 vs 통합

**채택**: **install-skills.{sh,ps1}에 `--cleanup` 플래그 통합**.

근거:

- 별 스크립트 신설 시 sync-agents / install-project-claude 패턴과 정합 깨짐 (단일 entrypoint 관습)
- backup source 위치는 install-skills가 이미 알고 있음 (`BACKUP_ROOT="$HOME/.claude/backups/skills"`)
- manifest backup (`<proj>/.harness/backups/`)은 별도 — `install-project-claude.{sh,ps1}` 또는 향후 `harness-rebootstrap` skill에서 흡수 (Out of scope)

### R4 — 안전성 가드

1. **`~/.claude/backups/skills/` 외부 경로 거부** — 절대 다른 디렉토리 정리 안 함 (path traversal 방어)
2. **`.<ts>` suffix 매치 강제** — `<name>.<YYYYMMDD-HHMMSS>` 형식 dir만 정리 (ad-hoc dir 무관)
3. **dry-run default 권장** — 첫 호출 시 dry-run 안내, `--yes` 또는 `--force` 명시 시만 실 삭제
4. **삭제 대신 `~/.claude/backups/skills/.archive/` 이동 옵션** — `--archive` 플래그 (default off, evidence-driven 후 활성)

### R5 — 문서 + smoke

**`bootstrap/docs/SKILLS.md §5`** 갱신:

- "자동 cleanup 없음" → "자동 cleanup `--cleanup` opt-in"
- 예시 추가

**`tests/smoke-backup-cleanup.sh`** 신규 (정적 + dynamic):

- 정적: 양 스크립트의 `--cleanup` 플래그 + R2 4 옵션 grep
- dynamic: tmpdir에 모의 backup 5개 생성 (3개는 8일 전 mtime, 2개는 1일 전) → `--cleanup --retain 3 --grace-days 7 --dry-run` → "would delete 0 (3 grace + 2 within retain)" 검증

## 3. 변경 대상 (4 수정 + 2 신규)

### 수정 (4)

| 경로 | scope | 변경 |
|------|------|------|
| `install-skills.sh` | S1c | R2 — `--cleanup` / `--cleanup-after` / `--retain` / `--grace-days` 플래그 + cleanup 함수 |
| `install-skills.ps1` | S1c | R2 — 동상 (PowerShell 파라미터 + `Get-ChildItem` 정렬 + `Remove-Item`) |
| `bootstrap/docs/SKILLS.md` | S2 | R5 — §5 자동 cleanup opt-in 문서 |
| `CLAUDE.md` | S3 | "관련 문서" cross-ref 갱신 (선택) |

### 신규 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `tests/smoke-backup-cleanup.sh` | S3 | R5 — 정적 + dynamic |
| `sessions/meta/v1.30-.../{PLAN,REPORT}.md` | meta | 본 세션 |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 (본 파일)
- [ ] **사용자 진입 확인**
- [ ] Stage A — install-skills.sh `--cleanup` 함수 + 4 플래그
- [ ] Stage B — install-skills.ps1 동상
- [ ] Stage C — SKILLS.md §5 갱신
- [ ] Stage D — smoke-backup-cleanup.sh (정적 + dynamic)
- [ ] Stage E — REPORT.md
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `install-skills.sh --cleanup --dry-run` 실행 → 3 backup 중 grace period 내(7일) 모두 보존, 0 삭제 계획 (현 backup 모두 4-29 같은 날짜)
- [ ] `install-skills.sh --cleanup --retain 0 --grace-days 0 --dry-run` 실행 → 3 backup 모두 삭제 계획
- [ ] `install-skills.ps1 -Cleanup -DryRun` 동일 동작
- [ ] R4 안전성 가드 4건 모두 통과 (path 거부 / suffix 매치 / dry-run 권장 / --archive 미구현 명시)
- [ ] smoke-backup-cleanup.sh 정적 + dynamic PASS
- [ ] **회귀 0** — 기존 install-skills 기본 동작 (cleanup 플래그 없음) 무변경
- [ ] SKILLS.md §5 "자동 cleanup 없음" → "opt-in" 갱신

## 6. 우선순위 후속 후보 큐 (사용자 요청 — 2026-04-29)

evidence 충족된 4 후보 중 본 세션은 **#1**. 나머지는 본 세션 완료 후 차례:

| 우선 | 세션 후보 | evidence | ROI |
|:---:|---------|---------|-----|
| **1** | **`v1.30-backup-cleanup` (본 세션)** | `~/.claude/backups/skills/` 3건 누적 + v1.21/v1.22 2회 deferral | **즉각 사용자 가치 (UX 마찰 발생 중)** |
| 2 | `v1.30b-report-cross-file-check` | v1.27/v1.28/v1.29 REPORT § = 정확 3건 (v1.29 자체 명시) | 검증 mechanism 강화. smoke 1 stage 추가 수준 작은 비용 |
| 3 | `v1.31-oss-entry-files` (CONTRIBUTING.md / SECURITY.md) | AGENTS.md "v1.25 예정" 시간 약속 + 현 v1.29 도달 | 외부 기여 진입 장벽 낮춤. evidence 시간 임계 충족 (외부 기여자 0이나 약속 우선) |
| 4 | `v1.10j2-legacy-plan-migration` | pre-v1.10j 16+ 세션 + v1.10h~h3 등 = 25+ legacy | **비용 큼** (수동 갱신). evidence 충족하나 ROI 낮음 |

## 7. 커밋 전략

```
feat(meta): sessions/meta/v1.30-backup-cleanup — backup-<ts>/ 누적 자동 정리 opt-in

- update: install-skills.sh (R2 — --cleanup/--cleanup-after/--retain/--grace-days)
- update: install-skills.ps1 (R2 — 동상)
- update: bootstrap/docs/SKILLS.md (R5 — §5 opt-in 문서)
- add: tests/smoke-backup-cleanup.sh (R5)
- add: sessions/meta/v1.30-.../{PLAN,REPORT}.md

Scope: count-based (default N=3) + grace period (default 7일) 정책.
- 명시 CLI 플래그만 활성 (default off — 안전성 우선)
- ~/.claude/backups/skills/ 만 정리 (3 source 중 1 — manifest backup은 별도)
- R4 안전성 가드 4건 (path 거부 / suffix 매치 / dry-run / archive 옵션)

Evidence: ~/.claude/backups/skills/ 3건 누적 (v1.20 이관) + v1.21/v1.22 2회 deferral.
회귀 0 — 기존 install-skills 기본 호출 (cleanup 플래그 없음) 무변경.
```

## 8. 후속 분기

| 후속 세션 | 조건 |
|---------|------|
| `v1.30b-report-cross-file-check` | 본 세션 완료 후 즉시 (우선순위 큐 #2) |
| `v1.31-oss-entry-files` | #2 완료 후 (우선순위 큐 #3) |
| `v1.30c-manifest-backup-cleanup` | manifest backup (`<proj>/.harness/backups/`) 누적 1+ 발생 시 |
| `v1.30d-backup-restore-cli` | 사용자 backup 복원 요구 evidence 발생 시 |
| `v1.30e-backup-archive` | `--archive` 활성 — 디스크 사용량 부담 누적 시 |
