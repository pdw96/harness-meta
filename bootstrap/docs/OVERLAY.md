# Language Overlay — `bootstrap/templates/<language>/.claude/` 규약

`sessions/meta/v1.11-language-overlay-infra/`에서 확정. install-project-claude.{sh,ps1}이 `_base` baseline 위에 언어별 overlay를 merge하는 단일 소스.

## 1. 개요

`bootstrap/templates/_base/.claude/`는 **언어 불문 baseline** (commands/agents/skills/output-styles 17 파일). v1.11에서 **언어별 overlay** 인프라 도입:

- **Source of truth**: `bootstrap/templates/<language>/.claude/` (e.g., `templates/python/.claude/`)
- **Merge 동작**: `_base` 복사 후 overlay 추가 복사 (overlay 승)
- **현 시점**: v1.11 = **인프라만**. 실 overlay 콘텐츠 0 (placeholder `python/.claude/.gitkeep` 1건)
- **실 콘텐츠 도입**: v1.11b+ evidence-driven (Python 사용자 등장 → harness-python skill 등)

## 2. 디렉토리 규약

```
bootstrap/templates/
├── _base/                    # 언어 불문 baseline (sentinel _* prefix)
│   └── .claude/
│       ├── commands/
│       ├── agents/
│       ├── skills/
│       └── output-styles/
└── <language>/               # 언어별 overlay
    └── .claude/
        ├── commands/         # (선택) overlay만의 카테고리도 가능
        ├── agents/
        ├── skills/
        └── output-styles/
```

**우선순위**:

1. `_base/.claude/<cat>/<name>` — 항상 먼저 복사
2. `<language>/.claude/<cat>/<name>` — overlay 후행 복사. 동일 이름 시 **base 위에 덮어쓰기 = overlay 승**

## 3. Language 매트릭스 (10건)

`detect-project.sh` v1.10e3 출력과 1:1 정합:

| `[project].language` (lowercase) | overlay dir | 현 시점 실재 |
|---|---|:-:|
| `python` | `templates/python/` | ✓ (harness-python/ 2파일) |
| `typescript` | `templates/typescript/` | — |
| `javascript` | `templates/javascript/` | — |
| `go` | `templates/go/` | — |
| `rust` | `templates/rust/` | — |
| `java` | `templates/java/` | — |
| `kotlin` | `templates/kotlin/` | — |
| `csharp` | `templates/csharp/` | — |
| `ruby` | `templates/ruby/` | — |
| `elixir` | `templates/elixir/` | — |
| (그 외 또는 빈 값) | overlay 없음 → _base only | — |

v1.11 = `python/` placeholder → v1.11b에서 `harness-python/` 실 콘텐츠 도입. 나머지 9건은 v1.11c+에서 evidence-driven 도입.

## 4. Language 정규화

- `.harness.toml` `[project].language` 값을 **lowercase**로 변환 후 매치
- `Python` / `PYTHON` / `python` 모두 `python` overlay와 매치
- alias (`py` → `python` / `c#` → `csharp` 등)는 **불지원** — 사용자가 정확한 표준명 입력 의무
- 빈 값 / 매트릭스 외 값 → overlay 단계 silent skip (info log만)

## 5. Reserved prefix

- `_*` (예: `_base`, `_shared`)는 sentinel directory
- language overlay name으로 사용 **금지**
- install-project-claude는 `_*` prefix language 값을 받으면 overlay skip + info

## 6. Naming convention — `harness-*` prefix 의무

overlay item (commands/agents/skills/output-styles의 file 또는 sub-dir) 이름은 **`harness-*` prefix 의무**:

```
templates/python/.claude/skills/
├── harness-python/         ✓ (overlay)
├── harness-pytest/         ✓ (overlay)
└── my-skill/               ✗ (사용자 custom 영역 침범 — 금지)
```

**효과**:

- 사용자 custom 파일 (예: `<proj>/.claude/skills/my-skill/`)은 overlay와 자연 분리
- C2 충돌 시나리오 (overlay가 사용자 custom 무경고 덮어쓰기) 사실상 0
- legacy cleanup (v1.9b)의 `harness*` prefix 가정과 자연 정합

**Enforce**: v1.11 인프라는 자동 검증 안 함 (regex 없음). v1.11b+ overlay 작성 세션이 컨벤션 준수 의무. 위반 시 PR review 또는 후속 smoke 추가.

## 7. Merge 알고리즘 (Phase 1 + Phase 2)

install-project-claude.{sh,ps1} 의사코드:

```
Phase 1 — _base 복사 (현행 유지)
  pre-flight: _base 카테고리 4종 conflicts 스캔 → C1
  if C1 conflicts:
    if not -Force: abort
    if -Force: backup-<ts>/ 이동 후 덮어쓰기
  copy _base/<cat>/* → <proj>/.claude/<cat>/* (cp -r / Copy-Item -Recurse)

Phase 2 — overlay 추가 복사 (신규 v1.11)
  language = grep+sed `.harness.toml` [project].language → lowercase
  if language empty or language matches _<reserved>:
    info; return
  overlay_dir = templates/<language>/.claude/
  if not exists(overlay_dir):
    info "no language overlay dir for '<language>'"; return
  for cat in commands/agents/skills/output-styles:
    overlay_cat=overlay_dir/<cat>
    [ -d "$overlay_cat" ] || continue
    mkdir -p <proj>/.claude/<cat>
    for item in overlay_cat/*:
      [ "$(basename "$item")" = ".gitkeep" ] && continue   # top-level skip
      [ -e "$dst" ] && info "overlay overwrite: <cat>/<name>"
      cp -r "$item" <proj>/.claude/<cat>/
```

PowerShell 측 의미 동등:

- `Get-ChildItem ... | Where-Object { $_.Name -ne '.gitkeep' }`
- `Copy-Item -Path $item -Destination $dst -Recurse -Force`

## 8. 충돌 시나리오 (C1 / C2 / C3)

| # | 시나리오 | 정책 |
|---|---|---|
| **C1** | 사용자 custom vs `_base` (Phase 1) | 현행 유지 — abort 또는 `-Force` backup |
| **C2** | `_base` 또는 사용자 vs overlay (Phase 2) | overlay 자동 덮어쓰기 + log "overlay overwrite". backup 무. **`harness-*` prefix convention으로 사용자 custom 충돌 0 보장** |
| **C3** | 첫 install 후 overlay 추가/삭제 + 재install | 사용자가 `-Force` 재실행 (C1 정책 흡수). 자동 cleanup 안 함 |

## 9. `.gitkeep` skip 규약

- **Top-level overlay** `.gitkeep` (예: `python/.claude/.gitkeep`): explicit skip
  - 디렉토리 git tracking 용도. dest로 복사 불필요
- **Sub-dir 내** `.gitkeep` (예: `python/.claude/skills/harness-python/.gitkeep`): cp -r에 자연 포함 (의도)
  - sub-dir이 의도적으로 비어있을 수 있음 (실 콘텐츠 v1.11b+에서 채움)
- bash: `for item in $src/*` 글롭이 dotfile 자연 제외 + 명시 검사
- PowerShell: `Where-Object { $_.Name -ne '.gitkeep' }` 명시 필수

## 10. Recursion 동작 (file vs directory)

overlay item이 file이면 file 복사, directory면 디렉토리 통째 복사:

| Item type | bash | PowerShell |
|---|---|---|
| File (e.g., `harness-python.md`) | `cp -r file dst/` | `Copy-Item file dst/ -Recurse -Force` |
| Directory (e.g., `harness-python/`) | `cp -r dir dst/` | `Copy-Item dir dst/ -Recurse -Force` |

`cp -r`은 양쪽 모두 처리. PowerShell `Copy-Item -Recurse`도 양쪽 모두 처리. 단일 알고리즘으로 일관 처리.

## 11. Legacy cleanup overlay-aware (v1.21+)

`install-project-claude --force`의 legacy cleanup. v1.9b 도입 시 `_base`만 검사 → v1.21에서 **`_base` + `<language>/.claude/` overlay 양쪽 검사**로 확장.

### v1.21 알고리즘

```bash
# bash (의미 동등 PowerShell mirror)
in_base=0
[ -e "$_base/$cat/$name" ] && in_base=1   # if-else 형식 채택 (errexit 안전)
in_overlay=0
if [ -n "$overlay_path" ] && [ -e "$overlay_path/$cat/$name" ]; then
    in_overlay=1
fi
# 양쪽 부재 시만 진정한 legacy → backup
if [ "$in_base" -eq 0 ] && [ "$in_overlay" -eq 0 ]; then
    mv "$d" "$backup_root/$cat/$name"
fi
```

`overlay_path`는 Section 2.4 (v1.21 신설)에서 통합 추출 — Section 2.5 + Phase 2 재사용 (drift 방지).

### v1.9b 한계 + v1.11b 활성 버그

v1.9b 로직 (legacy cleanup이 `_base`만 검사)은 v1.11에서 Phase 2 overlay 도입 후에도 유지 → **v1.11b (`harness-python/` 실 콘텐츠 도입) 시점부터 활성 버그**:

| 단계 | 동작 (pre-v1.21) | 결과 |
|------|------------------|------|
| T1 첫 install | `_base` 복사 + Phase 2 (`harness-python/` 복사) | dest 정상 |
| T2 `--force` 재install | Section 2.5: `_base/skills/harness-python` 부재 → backup | spurious `backup-<ts>/skills/harness-python/` |
| T2 Section 4 | `_base/skills/` 복사 (harness/ 등) | harness-python dest 부재 |
| T2 Phase 2 | overlay 복사 → harness-python 다시 등장 | dest 정상 (데이터 보존) |

**Net 결과 (pre-v1.21)**: 매 `--force` 실행마다 backup 디렉토리 누적 + WARN 로그 + 사용자 혼란. 데이터는 보존되지만 churn.

### v1.21 시나리오 매트릭스

| 시나리오 | v1.21+ 동작 | v1.20 동작 (회귀 검사) |
|---------|------------|---------------------|
| `language` 미설정 + `--force` 재install | `overlay_path` 빈 값 → in_overlay 항상 false → 기존 v1.9b 동등 | 동일 |
| `language="python"` 첫 install (no -f) | Section 2.5 skip (-f 없음) | 동일 |
| **`language="python"` + `--force` 재install (overlay 정합)** | **harness-python in_overlay=true → backup 생략** | **spurious backup (BUG)** |
| `language="python"` → `language="rust"` 변경 + `--force` | python overlay 부재 → harness-python in_overlay=false → backup 정당 | 동일 (legitimate) |
| `_base` 항목 삭제 (미래 v1.8b commands 같은 변경) + `--force` | `_base` + overlay 양쪽 부재 → backup 정당 | 동일 |
| `language="haskell"` (overlay 없음) + `--force` | overlay_path 빈 값 → 기존 동등 | 동일 |

→ **단 1 시나리오만 변경** (활성 버그 차단). 나머지 회귀 0.

### bash + ps1 의미 동등성

bash:

```bash
in_overlay=0
if [ -n "$overlay_path" ] && [ -e "$overlay_path/$cat/$name" ]; then
    in_overlay=1
fi
```

PowerShell:

```powershell
$inOverlay = $false
if ($overlayPath) {
    $overlayItem = "$overlayPath/$cat/$($d.Name)"
    if (Test-Path $overlayItem) { $inOverlay = $true }
}
```

PS는 `/` slash를 자동 정규화 (Windows API 받아들임). `Join-Path` multi-arg cross-version 호환성 우려 회피 (literal interpolation 채택).

### Latent bug 자연 해소 (v1.11 incidental fix)

기존 v1.11 ps1:

```powershell
$languageRaw = (Select-String ... -List).Matches.Groups[1].Value   # null-chain crash
```

`Select-String` no-match → `$null.Groups[1]` indexing → RuntimeException → `$ErrorActionPreference='Stop'` 종료. `language` 필드 부재 manifest install 시 즉시 crash.

v1.21 Section 2.4가 동일 grep 로직 통합하면서 null-safe pattern 채택 (`if ($matchResult) { ... } else { '' }`) → latent crash 자연 해소.

## 12. 빈 overlay / unknown language 동작

| 입력 | 동작 |
|---|---|
| `language` 부재 (manifest에 필드 없음) | overlay 단계 silent skip + info log |
| `language = ""` | 동상 |
| `language = "haskell"` (매트릭스 외) | `templates/haskell/` 존재 검사 → 부재 → info log |
| `language = "python"` + `python/` 부재 | info log |
| `language = "python"` + `python/.claude/` 빈 디렉토리 (sub-cat 없음) | overlay loop 진입 → 모든 sub-cat skip → no-op |
| `language = "python"` + `python/.claude/.gitkeep` 만 (현 v1.11 상태) | top-level .gitkeep skip → sub-cat 부재 → no-op |
| `language = "_base"` (reserved prefix) | reject + info log |

**회귀 0 보장**: overlay 부재 / 빈 상태 / unknown — 모두 `_base` 복사 정상 진행 + Phase 2 no-op.

## 13. v1.11 scope vs 향후

**v1.11 (본 세션)**: 인프라만

- 디렉토리 규약 + Phase 2 merge logic + naming convention + placeholder + smoke

**v1.11b+ (후속)**:

- `python/.claude/skills/harness-python/SKILL.md` 등 실 overlay 콘텐츠 (`harness-*` prefix 준수)
- evidence-driven — Python 사용자 등장 시점

**v1.11c+ (다언어)**:

- TypeScript / Go / Rust / 등 9 언어 overlay (각자 별 세션)

**v1.11d (별 도메인)**:

- `<proj>/{HM_CODE_DIR}/` 골격 자동 생성

**v1.14~v1.20 (별 도메인)**:

- `.agents/skills/` adapter overlay (Cursor / Codex CLI / Gemini CLI 등)
- 본 v1.11는 `.claude/` only — adapter overlay와 충돌 없음

**v1.21 (완료, 2026-04-29)**:

- legacy cleanup overlay-aware (Section 2.4 + 2.5 — `_base` + `<language>/` 양쪽 검사). 본 §11 참조

**v1.22 (완료, 2026-04-29)**:

- install-skills + sync-agents 통합 + copy mode fallback (Windows symlink 권한 부재 시)

**v1.23 (완료, 2026-04-29)**:

- verify.sh 신설 + verify.ps1/sh Stage H (overlay 무결성: 매트릭스 enumerate + `harness-*` prefix + SKILL.md frontmatter) + Stage I (frontmatter 6축 V1/V5/V7/V8/V10) 통합. context7 (`/websites/code_claude` C1~C10) spec 정합 검증

**v1.24 (예정, 후속)**:

- macOS/Linux dynamic 검증 (cross-platform CI 또는 사용자 제3 기기)

## 14. 관련 문서

- 상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md) · [`../../README.md`](../../README.md)
- 매니페스트 스펙: [`../manifest-schema.md`](../manifest-schema.md) — `[project].language` 필드
- 감지: [`DETECTION.md`](DETECTION.md) — `detect-project.sh` 출력 매트릭스
- 세션 소속: [`OWNERSHIP.md`](OWNERSHIP.md) — S1b (메타 소유 프로젝트 템플릿)
- AGENTS.md 표준: [`AGENTS_MD_STRATEGY.md`](AGENTS_MD_STRATEGY.md) — `.agents/skills/` 미래 표준 (v1.14+)
- 본 규약 확정 세션: [`../../sessions/meta/v1.11-language-overlay-infra/`](../../sessions/meta/v1.11-language-overlay-infra/)
