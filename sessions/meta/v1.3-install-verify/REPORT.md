# meta v1.3-install-verify — REPORT

세션 기간: 2026-04-24 (단일 세션)
세션 범위: `install.ps1` 동반 자가 검증 스크립트 도입 (v1.1 smoke 절차의 스크립트화 가능 부분)
판정: **PASS** (성공 기준 12/12 + 실측 30/30 PASS + 실패 주입 3/3 감지)

**세션 소속 (self-apply)**: `sessions/meta/`
**근거**: 변경 파일 8건 모두 **S3** (`install.ps1`, `verify.ps1`, `verify-lib.ps1`, `tests/fixtures/**` 6, `README.md`, `CLAUDE.md`). **T1 경로 다수결** 전부 S3 → meta 소유 확정. 세션 기록 2건(`PLAN.md`, `REPORT.md`) + evidence 4건.

## 최종 결과

- **신규 파일 9**: `verify.ps1` (349L), `verify-lib.ps1` (65L), fixtures 5 (F1: `.harness.toml`·`.gitkeep` / F2: `.harness.toml`·`.gitkeep`·`phases/index.json`), evidence 4
- **리팩터 1**: `install.ps1` — `Test-SymlinkIntegrity` 공유 함수 도입, lines 167·303 ReparsePoint-only 체크를 LinkType='SymbolicLink' + Target 실존 + MetaRoot 하위 엄격 체크로 교체
- **문서 2**: `README.md` 트러블슈팅·설치 섹션 / `CLAUDE.md` 명령어 섹션
- **세션 기록 2**: `PLAN.md` (본 세션 상세 분석 + 42 grey area 중 28 결정) / 본 REPORT
- **자동 검증**: 30/30 PASS (exit 0)
- **실패 주입**: 3/3 감지 (B3, C0, D2+E2)

## 구현 요약 (PLAN 목표 대조)

| # | 목표 | 결과 | 구현 파일 |
|---|------|------|----------|
| 1 | `verify.ps1` 신규 + `#Requires 7.3` + `$IsWindows` 가드 + `Resolve-Path` | ✅ | `verify.ps1:1,72-82,99-103` |
| 2 | `Test-SymlinkIntegrity` 공유 함수 추출 | ✅ | `verify-lib.ps1:1-65` |
| 3 | `install.ps1` 함수 호출로 교체 (ReparsePoint → SymbolicLink) | ✅ | `install.ps1:46-47,164-170,302-314` |
| 4 | F1 fixture (`sample-project/`) | ✅ | `tests/fixtures/sample-project/.harness.toml`, `scripts/harness/.gitkeep` |
| 5 | F2 fixture (`empty-phases/` + `phases/index.json`) | ✅ | `tests/fixtures/empty-phases/{.harness.toml, phases/index.json, scripts/harness/.gitkeep}` |
| 6 | settings.json 검증 (`statusLine` + `hooks.SessionStart`만) | ✅ | `verify.ps1` C 섹션 (C0–C9, foreign hooks 무시) |
| 7 | Hook 스모크 3 케이스 + stdout/stderr 격리 | ✅ | `verify.ps1` D 섹션 + `Invoke-Bash` 함수 |
| 8 | Statusline 스모크 3 케이스 | ✅ | `verify.ps1` E 섹션 |
| 9 | Bash fixture path forward-slash 정규화 | ✅ | `verify.ps1:208-215` (`-replace '\\','/'`) |
| 10 | Runtime-only 6항 체크리스트 출력 | ✅ | `verify.ps1` G 섹션 |
| 11 | Leftover backup [INFO] 안내 | ✅ | `verify.ps1` F 섹션 |
| 12 | Partial install 감지 (B3 1:1 enumeration) | ✅ | `verify.ps1:139-154`, failure-injection-1 실측 |
| 13 | README + CLAUDE.md 갱신 | ✅ | `README.md:78-84,241-244` / `CLAUDE.md:38-46` |
| 14 | REPORT에 실측 + 실패 주입 evidence | ✅ | `evidence/verify-output.txt` + `failure-injection-{1,2,3}*.txt` |

**완수율**: 14/14 (100%).

## 자동 검증 실측 (30/30)

```
Z 3/3 (IsWindows, PS 7.5.5, MetaRoot 정규화)
A 4/4 (Dev Mode ON, MetaRoot 구조, bash, python3)
B 7/7 (6 카테고리 / 17 기대 / 1:1 대응 / LinkType / Target / MetaRoot 하위 / SKILL.md)
C 10/10 (no BOM / JSON parse / statusLine 2 / hooks.SessionStart 6 field)
D 3/3 (no-manifest="{}"" / F1 "미존재" / F2 "전체 milestone 완료")
E 3/3 (no-manifest 빈 출력 / F1 "phases 미초기화" / F2 "stats 모듈 없음")
F   info (backup 0건)
G   수동 체크리스트 6항 출력
```

evidence: `evidence/verify-output.txt`

## 실패 주입 3종 (PLAN 성공 기준 검증)

### Injection 1 — Symlink 삭제 (partial install 시뮬레이션)

- **조작**: `~/.claude/commands/harness-review.md` 삭제 (17→16)
- **결과**: B3 FAIL `"누락 1건: commands/harness-review.md"` · 29/30 PASS · exit 1
- **복구**: `New-Item -ItemType SymbolicLink` 재생성 후 `LinkType=SymbolicLink` 확인
- evidence: `evidence/failure-injection-1-symlink-missing.txt`

### Injection 2 — settings.json BOM 주입

- **조작**: `~/.claude/settings.json` 앞에 `EF BB BF` 3바이트 prepend (backup 선저장)
- **결과**: C0 FAIL `"UTF-8 BOM 검출 (Claude Code JSON 파서 호환성 ↓)"` · C1 이후도 정상 파싱(PS ConvertFrom-Json은 BOM tolerant) 되었으나 C0 판정만 FAIL · 29/30 PASS · exit 1
- **복구**: backup 파일로 Move-Item 복원, size 2477 확인
- evidence: `evidence/failure-injection-2-bom.txt`

### Injection 3 — Fixture `.harness.toml` 일시 제거

- **조작**: `tests/fixtures/sample-project/.harness.toml` → `/tmp/` 이동 (F1이 no-manifest 상태)
- **결과**: D2 FAIL `"hookEventName != 'SessionStart'"` (hook이 `{}` 반환) + E2 FAIL `"stdout='' 기대='[harness] phases 미초기화'"` · 28/30 PASS · exit 1
- **복구**: 원위치 복원
- **의미**: verify가 "F1에 매니페스트 있음"을 전제로 엄격 검증함을 확증 — fixture 파손 / 누락 즉시 감지
- evidence: `evidence/failure-injection-3-fixture-manifest-missing.txt`

### Post-restore baseline

- 3회 주입+복구 후 `pwsh verify.ps1` 재실행 → **30/30 PASS · exit 0** (부작용 없음)

## 판정 (PLAN 성공 기준)

| 기준 | 결과 | 증거 |
|------|------|------|
| `verify.ps1` + `#Requires 7.3` + `$IsWindows` + `Resolve-Path` | ✅ | `verify.ps1:1,72-103` |
| `Test-SymlinkIntegrity` 공유 함수 (LinkType + Target + MetaRoot) | ✅ | `verify-lib.ps1` |
| `install.ps1` 함수 호출로 교체 | ✅ | `install.ps1` 167·303 라인 |
| F1/F2 fixture 전체 | ✅ | `tests/fixtures/**` 5 파일 |
| `{"milestones": []}` JSON parse | ✅ | F2 `phases/index.json` |
| `verify.ps1` 30/30 PASS (exit 0) | ✅ | `evidence/verify-output.txt` |
| 실패 주입 1 (symlink 삭제 → B3) | ✅ | `failure-injection-1-*.txt` |
| 실패 주입 2 (BOM → C0) | ✅ | `failure-injection-2-bom.txt` |
| 실패 주입 3 (fixture manifest 삭제 → D2/E2) | ✅ | `failure-injection-3-*.txt` |
| Foreign hooks 공존 테스트 | ✅ | 실제 사용자 settings.json에 `UserPromptSubmit` 존재, C 단계 WARN 없음, 30/30 PASS |
| Bash path 변환 | ✅ | `Invoke-Bash` native 경로 `-replace '\\','/'` 후 설정, 양 fixture 동작 |
| README/CLAUDE.md 갱신 | ✅ | 2 파일 |
| REPORT evidence 첨부 | ✅ | evidence/ 4 파일 |

**12/12 전부 충족**.

## Lessons Learned

1. **`PYTHONIOENCODING=utf-8` 필수**: 한국어 Windows locale(cp949)에서 session-init.sh의 Python heredoc이 em-dash(—) 등 non-cp949 문자를 만나면 `UnicodeEncodeError`. 또한 한글도 Python stdout cp949 인코딩 → PS Get-Content UTF-8 read 불일치로 mojibake. `Start-Process -Environment`에 `PYTHONIOENCODING=utf-8` 주입 + `Get-Content -Encoding utf8`로 해결. 본 버그는 Claude Code 실제 런타임에서는 드러나지 않음(다른 인코딩 환경) — **verify가 처음 드러낸 잠재 버그**.
2. **`LinkType` vs `ReparsePoint` 차이의 실측 가치**: install.ps1 line 167·303은 `Attributes -band ReparsePoint`만 체크 → Junction도 통과. Dev Mode OFF fallback 시 디렉토리 symlink가 Junction으로 떨어질 수 있음을 PLAN에서 이론적으로 지목했는데, `Test-SymlinkIntegrity`로 엄격화하면서 재설치 시 사용자 대응 필요성이 생김(`-Force`로 백업 후 재생성). 현재 환경은 모두 정상 SymbolicLink라 회귀 없음.
3. **Foreign hooks 공존의 실증**: 사용자 실제 `settings.json`에 `UserPromptSubmit` hook 공존. verify가 "우리 필드만(`statusLine` + `hooks.SessionStart`)" 검증 원칙을 고수 → 30/30 PASS. 만약 "hooks 전체가 우리 것" 가정으로 설계했다면 사용자 환경에서 즉시 false FAIL 발생. v1.3 설계 G30 결정(foreign-compatible)이 검증된 순간.
4. **Fixture F2의 코드 경로 선택**: `phases/index.json = {"milestones": []}` → session-init.sh가 `active = None` 분기 → "전체 milestone 완료" 출력. 이 특정 출력을 verify가 substring 매칭함으로써 **session-init.sh의 3분기 중 2개**(no-manifest + empty-milestones) 동시 커버. 세 번째(정상 milestone) 분기는 F3 fixture + mock `statusline_stats.py` 필요 → v1.3 범위 외.
5. **실패 주입 3종의 coverage**: (1) symlink 삭제 → B 단계, (2) BOM → C 단계, (3) fixture 삭제 → D+E 단계. 각각 verify의 한 섹션을 개별 검증. A·Z는 환경 전제라 주입 비용 높음(Dev Mode OFF 리부팅, python3 PATH 제거) — 필요 시 별도 세션 후보.
6. **공유 함수의 dot-source 패턴**: `verify-lib.ps1`을 `install.ps1`과 `verify.ps1`이 `. (Join-Path $PSScriptRoot 'verify-lib.ps1')`로 로드. PowerShell 모듈(.psm1) 대신 dot-source 선택 이유 — 모듈 import 경로/PSModulePath 설정 오버헤드 회피. 한 파일 + 두 소비자 패턴은 이 정도 규모에 최적.

## Grey Area 결정 사후 검증 (PLAN 42개 중 28 결정 / 14 자동 수렴)

| ID | 결정 | 실측 검증 |
|----|------|----------|
| G1 | 별도 `verify.ps1` | ✅ 349L 독립, install.ps1 330L 유지 |
| G2 | `tests/fixtures/` | ✅ 루트 `tests/` 도입 |
| G3 | F1+F2 (F3 제외) | ✅ 30체크로 충분 |
| G4 | 설치 전제 | ✅ 설치 없으면 B/C 다수 FAIL |
| G5 | 표준 출력 PASS/FAIL | ✅ `-Json` 미구현 (v1.4 후보) |
| G6 | install.ps1 함수 추출 | ✅ `Test-SymlinkIntegrity` |
| G7 | Target resolve + MetaRoot 하위 | ✅ B5+B6 |
| G8 | settings.json 전체 값 | ✅ C0–C9 |
| G10 | Windows path `\` → `/` | ✅ Invoke-Bash 내부 처리 |
| G13 | 30s timeout | ✅ `-Timeout 30` 기본 |
| G14 | runtime-only 체크리스트 | ✅ G 섹션 6항 |
| G18 | Force/Verify 무관 (별 파일) | ✅ |
| G19 | 동적 enumerate | ✅ 17 하드코딩 없음 |
| G23 | exit 1만 | ✅ |
| G26 | `& bash` explicit + `Start-Process` | ✅ |
| G27 | SKILL.md만 | ✅ B7 |
| G29 | Partial install | ✅ Injection 1 |
| G30 | Foreign hooks 무시 | ✅ 사용자 UserPromptSubmit 공존에도 30/30 |
| G31 | LinkType=SymbolicLink | ✅ `Test-SymlinkIntegrity` |
| G32 | Target StartsWith MetaRoot | ✅ B6 |
| G33 | BOM 부재 | ✅ C0, Injection 2 |
| G34 | Backup info | ✅ F 섹션 |
| G35 | $IsWindows 가드 | ✅ Z1 |
| G36 | SKILL.md만 | ✅ B7 |
| G37 | Stderr 분리 | ✅ Invoke-Bash |
| G38 | Forward-slash 변환 | ✅ Invoke-Bash |
| G40 | Resolve-Path | ✅ Z3 |
| G42 | #Requires 7.3 | ✅ |

**신규 발견 (Lessons에 포함)**: `PYTHONIOENCODING=utf-8` 필요성 — PLAN에 없었던 숨겨진 요구사항.

## 후속 세션 연결

- **직접 연결**: 없음 (v1.3 단독 완결)
- **보류 후보 (우선순위)**:
  1. `sessions/meta/vX-verify-json-output/` (S3) — `-Json` 출력 모드 + CI 통합 (GitHub Actions workflow 템플릿 포함 가능)
  2. `sessions/meta/vX-verify-auto-on-install/` (S3) — `install.ps1` 끝에 `-SkipVerify` 없으면 verify 자동 호출
  3. `sessions/meta/vX-hook-utf8-declaration/` (S1) — `session-init.sh` Python heredoc 첫 줄에 `sys.stdout.reconfigure(encoding='utf-8')` 명시 (PYTHONIOENCODING 의존 제거, 근본 치료). 본 세션의 Lessons #1 영구화
  4. `sessions/meta/vX-fixture-f3/` (S3) — F3 fixture + mock `statusline_stats.py` + `phase-stats/milestone-cost/cache-hit` 분기 커버
  5. `sessions/meta/vX-verify-cross-platform/` (S3) — macOS/Linux 지원 (`$IsWindows` 가드 대신 OS별 분기, Developer Mode/symlink 의미 차이)
  6. `sessions/meta/vX-bootstrap-templates/` (S2) — v1.2 이래 대기 중

**백로그는 자동 후행 아님**. 사용자가 명시적으로 command 호출해야 진행.

## 커밋 계획

단일 커밋 제안 (원자적 논리 단위):

```
feat(meta): sessions/meta/v1.3-install-verify — verify.ps1 + fixtures + install.ps1 리팩터

- add: verify.ps1 (349L, Z/A/B/C/D/E/F/G 30 자동 체크 + runtime-only 6항)
- add: verify-lib.ps1 (Test-SymlinkIntegrity 공유 함수)
- refactor: install.ps1 — lines 167·303 ReparsePoint-only → Test-SymlinkIntegrity (LinkType + Target + MetaRoot 하위 엄격화)
- add: tests/fixtures/{sample-project, empty-phases}/ (F1, F2)
- docs: README.md 설치·트러블슈팅 + CLAUDE.md 명령어 섹션
- add: sessions/meta/v1.3-install-verify/{PLAN,REPORT,evidence×4}.md

실측: 30/30 PASS (Windows 11 / PS 7.5.5). 실패 주입 3종 (B3/C0/D2+E2) 감지.
신규 발견: PYTHONIOENCODING=utf-8 필요 (한국어 Windows locale에서 hook Python stdout 인코딩).
Foreign-compatible: 사용자 UserPromptSubmit hook 공존 환경에서도 우리 필드만 검증.
```

사용자 확인 후 `~/harness-meta` repo에 커밋.
