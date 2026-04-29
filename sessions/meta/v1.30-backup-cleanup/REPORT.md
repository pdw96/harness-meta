# meta v1.30-backup-cleanup — REPORT

세션 종료: 2026-04-29

## 최종 결과

| 항목 | 수치 |
|------|:---:|
| 변경 파일 (수정) | 3 (`install-skills.sh` + `install-skills.ps1` + `bootstrap/docs/SKILLS.md`) |
| 신규 파일 | 3 (`tests/smoke-backup-cleanup.sh` + PLAN.md + REPORT.md) |
| 신규 CLI 플래그 | 5 (`--cleanup`, `--cleanup-after`, `--retain N`, `--grace-days D`, `--yes`) |
| 신규 env 변수 | 1 (`HARNESS_SKILLS_BACKUP_ROOT`) |
| Smoke 추가 | 18 checks (정적 10 + dynamic 8) |
| Smoke 회귀 | **19/19 PASS** (전체) |
| context7 query | 2회 (bash + PS) — drift=no 확인 |

## 구현 요약

### Stage A — install-skills.sh

| 변경 | 위치 | 내용 |
|------|------|------|
| Header usage | L17~32 | v1.30 5 플래그 + env override 문서화 |
| `BACKUP_ROOT` | L29 | `HARNESS_SKILLS_BACKUP_ROOT` env override |
| 위임 매핑 | L46~71 | bash → ps1 5 플래그 변환 + value 인자 처리 |
| 인자 파싱 | L96~127 | 5 신규 플래그 + 정수 검증 (`[[ =~ ^[0-9]+$ ]]`) |
| `distinct_skills()` | L196~206 | regex strict `^.+\.[0-9]{8}-[0-9]{6}$` (R4-2) |
| `cleanup_one()` | L208~273 | count + grace 결합. find -mtime +D. purge guard. path traversal guard |
| `cleanup_all()` | L275~290 | 단일 skill OR 모든 distinct prefix 분기 (D17) |
| 실행 분기 | L294~ | `--cleanup` 단독 (early exit) + `--cleanup-after` (install 후) |

### Stage B — install-skills.ps1

| 변경 | 위치 | 내용 |
|------|------|------|
| `.PARAMETER` doc | L40~55 | 5 신규 파라미터 + EXAMPLE 4건 |
| param block | L67~77 | `[switch]$Cleanup`/`$CleanupAfter`/`$Yes` + `[int]$Retain=3`/`$GraceDays=7` + 검증 |
| `$BackupRoot` | L78~83 | env override (`$env:HARNESS_SKILLS_BACKUP_ROOT`) |
| `Get-DistinctSkills` | L196~204 | regex `'^.+\.\d{8}-\d{6}$'` + `Sort-Object -Unique` |
| `Invoke-CleanupOne` | L206~273 | LastWriteTime AddDays 비교. Resolve-Path StartsWith guard |
| `Invoke-CleanupAll` | L275~290 | bash와 의미 동등 |
| 실행 분기 | L293~ | bash와 의미 동등 |

### Stage C — bootstrap/docs/SKILLS.md

- §4 환경변수 표에 `HARNESS_SKILLS_BACKUP_ROOT` 추가
- §4 신규 sub-§ "Backup 자동 정리 (v1.30+)" — 사용 예시 + 정책 + 알고리즘 + path traversal 방어
- §5 충돌 정책 "자동 cleanup 없음" → "opt-in 플래그 (`--cleanup`, v1.30+)" 갱신
- §5 backup 누적 방지 § — 자동 정리 명령 추가 (legacy 수동 명령 보존)

### Stage D — tests/smoke-backup-cleanup.sh

- **정적 10 checks**: bash + ps1 양쪽 5 flag / 3 함수 / env override / regex strict / path guard 검증 + SKILLS.md keyword
- **Dynamic 8 tests**: 8 모의 backup fixture (5 ai-ready-scorer + 2 mindvault + 1 ad-hoc) + 7 시나리오 + 회귀 1
  - Test 1: plan only (no --yes) — 변경 0 검증
  - Test 2: purge guard (--retain 0 --grace-days 0) — ERR
  - Test 3: grace 우선 (--grace-days 30) — 0 deletion
  - Test 4: --dry-run override --yes
  - Test 5: 단일 skill (positional)
  - Test 6: 실 삭제 + 정확히 3개 잔존
  - Test 7: ad-hoc dir manual-snapshot 보존 (regex strict)
  - Test 8: 회귀 (`--list` 정상 동작)

### Cross-platform 정합

| 항목 | bash | PowerShell | 정합 |
|------|------|-----------|:---:|
| Flag 인식 | `--cleanup` | `-Cleanup` | ✓ |
| Value 인자 (`--retain N`) | `shift 2` | `[int]$Retain` 자동 | ✓ |
| Regex strict | `[[ =~ ^.+\.[0-9]{8}-[0-9]{6}$ ]]` | `-match '^.+\.\d{8}-\d{6}$'` | ✓ |
| mtime 비교 | `find -mtime +D` | `LastWriteTime -lt (AddDays(-D))` | ✓ |
| 재귀 삭제 | `rm -rf` | `Remove-Item -Recurse -Force` | ✓ |
| Path guard | `case "$b" in "$BACKUP_ROOT"/*) ;;` | `Resolve-Path StartsWith` | ✓ |
| Env override | `${HARNESS_SKILLS_BACKUP_ROOT:-...}` | `if ($env:HARNESS_SKILLS_BACKUP_ROOT)` | ✓ |

## 판정

| 성공 기준 | 결과 |
|----------|:---:|
| `--cleanup --dry-run` (3 backup, grace 7d 모두 보존) | ✓ (Test 1, plan only) |
| `--retain 0 --grace-days 0 --dry-run` 모두 삭제 계획 | ✓ (Test 4) |
| `-Cleanup -DryRun` 동일 동작 | ✓ (PS bash → ps1 위임 통과) |
| R4 안전성 가드 4건 | ✓ (path / suffix / dry-run / archive 명시 보류) |
| smoke-backup-cleanup PASS | ✓ (18/18) |
| 회귀 0 (기존 호출 무변경) | ✓ (19/19 smoke PASS) |
| SKILLS.md §4/§5 갱신 | ✓ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/gnu_software_bash_manual_html_node` (1차 — bash) + `/microsoftdocs/powershell-docs` (2차 — PowerShell) |
| **topic** | shift n opt arg / `[[ =~ ]]` regex / Where-Object LastWriteTime / Remove-Item -Recurse -LiteralPath / [switch]+[int] param default / env in param default |
| **findings** | no new findings |
| **drift** | no — 구현 중 PLAN R1~R5 + D1~D17 결정 모두 spec 정합 유지 (PLAN § citations C1~C6 변경 없음) |
| **re-verify** | bash 5.x → 6.x 또는 PowerShell 7.x → 8.x 메이저 변경 시 / install-skills 신규 cmdlet 추가 시 / S-Project / S-Manifest source 통합 시 (v1.30c+) |

## Lessons Learned

- **L1 — Cross-platform parity는 의미 동등성 매트릭스로 검증** — bash `find -mtime +D` vs PowerShell `LastWriteTime -lt AddDays(-D)`는 syntax 차이 크나 의미 정확 동일. PLAN D5에서 사전 매핑 → 구현 시 confusion 0
- **L2 — context7 query는 drift 추정에 fresh evidence 제공** — PLAN 초안 drift=N/A는 부정확이었음. 실제 install-skills 변경 = 양 spec 의존. v1.10d/v1.10g 후속 정합 ("install/verify 변경 = cross-platform shell spec 의존")
- **L3 — opt-in 플래그 5건 + default off = 회귀 0 보장** — `--cleanup` / `--cleanup-after` / `--retain` / `--grace-days` / `--yes` 모두 신설이므로 기존 `bash install-skills.sh` 무변경 호출은 동일 동작. smoke 19/19 통과로 검증
- **L4 — `--yes` 강제 + dry-run-equivalent default = 비가역 작업의 안전성 패턴** — backup 삭제는 비가역. 첫 호출 `--cleanup` = plan only + WARN. 사용자가 "삭제 의지" 명시(`--yes`)할 때만 실 동작. 직접적 타이핑 비용 = 안전성과 trade-off 가치 충분
- **L5 — regex strict 매치는 ad-hoc dir 보존의 핵심 mechanism** — 사용자가 `~/.claude/backups/skills/manual-snapshot/` 같은 임의 dir 두면 cleanup 무관 (regex 미일치). v1.11 language overlay의 `harness-*` prefix와 동일 철학 (사용자 영역 자연 분리)

## 후속 분기

| 후속 세션 | 조건 |
|-----------|------|
| `v1.30b-report-cross-file-check` | 우선순위 큐 #2 — 본 세션 완료 후 즉시 (REPORT § cross-file 일관성 검증) |
| `v1.31-oss-entry-files` | 우선순위 큐 #3 (CONTRIBUTING.md / SECURITY.md, 시간 임계 충족) |
| `v1.30c-manifest-backup-cleanup` | `<proj>/.harness/backups/manifest.<ts>.toml` 누적 1+ 발생 시 |
| `v1.30d-project-claude-backup-cleanup` | `<proj>/.claude/backup-<ts>/` 누적 + 사용자 git status 부담 evidence 발생 시 |
| `v1.30e-backup-restore-cli` | 사용자 backup 복원 요구 evidence 발생 시 |
| `v1.30f-backup-archive` | `--archive` 활성 — 디스크 사용량 부담 누적 시 (현재 default off) |

## 변경 파일 요약

```
M  bootstrap/docs/SKILLS.md      (+50 lines)
M  install-skills.ps1            (+156 lines, 0 deletions)
M  install-skills.sh             (+199 lines, 23 deletions in delegation block)
A  tests/smoke-backup-cleanup.sh (+150 lines)
A  sessions/meta/v1.30-backup-cleanup/PLAN.md
A  sessions/meta/v1.30-backup-cleanup/REPORT.md
```

## 선행 세션

- [`sessions/meta/v1.21-install-cleanup-foundation/`](../v1.21-install-cleanup-foundation/PLAN.md) — Out of scope verbatim
- [`sessions/meta/v1.22-install-unification/`](../v1.22-install-unification/PLAN.md) — Out of scope verbatim
- [`sessions/meta/v1.20-other-global-skills-migration/`](../v1.20-other-global-skills-migration/REPORT.md) — 3 backup 누적 발생 source
