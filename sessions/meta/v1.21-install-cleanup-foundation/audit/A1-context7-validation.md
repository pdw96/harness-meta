# A1 — context7 검증 + 추가 D 분석 (D31~D40)

PLAN의 R1~R5 결정을 정밀화하기 위해 context7 (Microsoft PowerShell docs + GNU Bash manual) 검증 + 5건 신규 D 분석.

## 인용 1 — PowerShell 7+ null property access

Source: `/microsoftdocs/powershell-docs` — `everything-about-null.md`

> Accessing most properties on a `$null` value results in `$null`. However, the `Count` property is an exception; accessing `$null.Count` returns `0`. This behavior is a special addition by PowerShell.

> Invoking a method on a `$null` object throws a 'RuntimeException'.

> Attempting to index a `$null` variable results in a `RuntimeException` with the message 'Cannot index into a null array'.

## 인용 2 — Null-conditional operators (PS 7+)

> The `?.` and `?[]` operators access members or elements only if the operand is non-null. Requires curly brace syntax for variables: `${a}?.PropName` / `${a}?[0]`.

## 인용 3 — Bash errexit + && || lists

Source: `/websites/gnu_software_bash_manual_html_node` — `Bourne-Shell-Builtins.html`

> The `ERR` trap [errexit] is not executed under specific conditions, such as when the command is part of an `until` or `while` loop's command list, within an `if` or `elif` test, in a `&&` or `||` list (except for the command following the final operator), or if the command's return status is inverted with `!`.

## 인용 4 — Bash glob no-match behavior

Source: `Filename-Expansion.html`

> If `nullglob` is set, the word is removed; if `failglob` is set, an error message is printed and the command is not executed. If neither is set, the word remains unchanged.

## D31 — PowerShell Select-String null chain risk (latent bug)

기존 `install-project-claude.ps1` line 166-167 (v1.11 도입):

```powershell
$languageRaw = (Select-String -Path $Manifest -Pattern '^language\s*=\s*"([^"]+)"' -List).Matches.Groups[1].Value
$language = if ($languageRaw) { $languageRaw.ToLower() } else { '' }
```

**인용 1 적용**: `Select-String` no-match → `$null` 반환.

- `($null).Matches` → `$null` (property access OK)
- `$null.Groups[1]` → `Cannot index into a null array` **RuntimeException**
- 스크립트 line 45 `$ErrorActionPreference = 'Stop'` → 스크립트 즉시 종료

**증거**: 현재 sample-project / upbit 모두 `language` 필드 보유 → 실 트리거 0. 하지만 `language` 필드 누락 manifest를 install 시 즉시 crash.

**해소 (v1.21 R6 신설)**: Section 2.0 (PS) null-safe pattern:

```powershell
# Section 2.0 — language + overlay path 통합 추출 (v1.21+, null-safe)
$matchResult = Select-String -Path $Manifest -Pattern '^language\s*=\s*"([^"]+)"' -List -ErrorAction SilentlyContinue
if ($matchResult) {
    $language = $matchResult.Matches.Groups[1].Value.ToLower()
} else {
    $language = ''
}

$overlayPath = ''
if ($language -and -not $language.StartsWith('_')) {
    $candidate = Join-Path $MetaRoot "bootstrap/templates/$language/.claude"
    if (Test-Path $candidate) {
        $overlayPath = $candidate
    }
}
```

**부가 효과**: Section 2.0 신설로 v1.11 latent crash 해소 (incidental fix). Out of scope 아님 — Section 2.0이 동일 grep 로직 통합하므로 자연 흡수.

## D32 — Bash errexit + `&&` 패턴 안전성 검증

R1 알고리즘 후보 패턴:

```bash
in_base=0
[ -e "$src/$name" ] && in_base=1
```

**인용 3 적용**: `[ -e ]`는 `&&` list의 첫 번째 command → errexit 무시. `in_base=1`은 final operator 후 command이지만 항상 exit 0 → 안전.

**but** compound 자체의 exit status는 마지막 실행 command 결과. `[ -e ]` false면 compound returns 1. 일부 bash 버전 / shopt 설정에서 errexit propagation 가능성 존재.

**선택 (R7 신설 — 안전 패턴 채택)**: 명시적 `if-else`로 모호성 0:

```bash
if [ -e "$src/$name" ]; then
    in_base=1
else
    in_base=0
fi
```

또는 단일 라인:

```bash
in_base=0; [ -e "$src/$name" ] && in_base=1 || true
```

→ **`if-else` 형식 채택**. 가독성 + errexit 무관. Smoke로 algorithm 동등성만 검증.

## D33 — Glob iteration `harness*` 안전성

```bash
for d in "$dst"/harness*; do
    [ -e "$d" ] || continue
    ...
done
```

**인용 4 적용**: nullglob/failglob 미설정 → no-match 시 `harness*` literal 반환. `[ -e "$d" ] || continue` 패턴이 literal 매치 차단 (literal 경로는 file system에 존재하지 않음).

**검증**: 인용 3에 따르면 `[ -e ]` false 시 errexit 무시 (`||` list 첫 command). 안전.

→ 기존 v1.9b 패턴 유지. 변경 0.

## D34 — Section 2 conflict scan vs Section 2.5 / 3 / Phase 2 ordering 재검증

기존 코드 흐름:

```
Section 2  conflict scan: _base/<cat>/* 순회. dst/<cat>/<name> 존재 시 conflicts list 추가
Section 2.5 legacy cleanup (-f): dst/<cat>/harness* 순회. _base 부재 시 backup
Section 3  conflict handling (-f): conflicts list backup
Section 4  _base 복사: _base/<cat>/* → dst
Section 5  Phase 2 overlay: <language>/.claude/<cat>/* → dst
```

**핵심 분석 (수정 후)**:

- harness-python은 `_base/skills/`에 부재 → Section 2 conflicts list에 **포함 안 됨**
- Section 2.5 (G fix 후): in_base=false + in_overlay=true → **backup 안 함** (수정 핵심)
- Section 3: conflicts list (모두 _base 항목) backup. harness-python 무관 → 그대로 dst 잔존
- Section 4: _base 항목 재복사 (Section 3에서 backup된 항목 복원)
- Phase 2: overlay 항목 (harness-python 포함) 복사 → 기존 dst harness-python overwrite (정상)

**T2 시나리오 (--force 재install, same lang)**:

- Pre-fix: backup-T2/skills/harness-python 생성 (BUG)
- Post-fix: backup-T2/skills/harness-python 부재. backup-T2 자체는 _base 항목 conflicts로 생성 (Section 3 정상 동작 — G와 무관)

**T2 critical assertion 재정의 (D34 결과)**:

- ❌ "T2 후 0 backup-*" (PLAN 초안) — 부정확 (Section 3 항상 backup-* 생성)
- ✅ **"T2 후 backup-*/skills/harness-python 부재"** (정확)
- ✅ **"T2 install log에 'legacy cleanup' 키워드 부재"** (보강)

→ **R5 Smoke T2 재설계** (PLAN의 R5 갱신 의무).

## D35 — Section 2.0 placement + naming

선택지:

- (a) Section 2.0 (Section 2 직후, Section 2.5 직전)
- (b) Section 2.4 (Section 2와 2.5 사이 더 명확한 numeric)
- (c) 최상단 (Section 1 검증 직후, Section 2 conflict scan 전)

**(b) Section 2.4 채택**:

- 기존 numbering (1 → 2 → 2.5 → 3 → 4 → 5) 보존
- `2.4` = 2.5 직전 명시적 의미
- (c) 최상단은 Section 2 conflict scan과 무관 (overlay_path는 conflict scan에 사용 안 됨) → 위치 부적절

## D36 — `Join-Path` PowerShell semantics (3-arg form)

PS code:

```powershell
$overlayItem = Join-Path $overlayPath $cat $d.Name
```

**검증 필요**: PS 7+ `Join-Path`의 multi-segment 지원 여부.

context7 인용 누락 — fallback 실험적 명시:

```powershell
# 안전 패턴 — 2-arg 중첩
$overlayItem = Join-Path (Join-Path $overlayPath $cat) $d.Name
```

또는:

```powershell
$overlayItem = "$overlayPath/$cat/$($d.Name)"
```

PS 7+ `Join-Path -AdditionalChildPath` 또는 multi-position arg 지원하지만 cross-version 안전 형식 채택 권장.

→ **R8 신설**: PS code에서 multi-segment join은 **2-arg 중첩** 또는 **literal slash interpolation** 패턴. PS 7.3+ 요구하므로 `Join-Path -AdditionalChildPath`도 가능하지만 가독성 trade-off.

선택: literal interpolation `"$overlayPath/$cat/$($d.Name)"` — PS는 `/`를 자동 정규화 (Windows에서도 작동).

## D37 — Phase 2 dotglob iteration 영향 0 검증

기존 Phase 2 (line 167):

```bash
for item in "$overlay_cat"/* "$overlay_cat"/.[!.]* "$overlay_cat"/..?*; do
```

본 G fix는 Section 2.5만 변경. Phase 2 dotglob 무변경. 회귀 0.

`harness-python/.gitkeep` (가상) — 본 G fix는 dst에 이미 있는 harness-python을 backup할지만 결정. dotglob과 무관.

## D38 — backup-<ts>/ collision (Section 2.5 vs Section 3)

기존 코드:

- Section 2.5가 backup_root 설정 후 ts 사용
- Section 3가 ts + backup_root 재산출 + `mkdir -p` (idempotent)
- 동일 초 시 backup_root 동일 path → mkdir -p OK
- 다른 초 시 backup_root 다른 path → 두 디렉토리 생성

**G fix 후 영향**:

- T2: Section 2.5 0 legacy → backup_root 미설정. Section 3가 새로 설정. **collision 0 보장** ✓
- T3: Section 2.5 1 legacy → backup_root 설정. Section 3 동시 backup → 동일 ts일 가능성 높음 → backup_root 같음. mkdir -p OK ✓
- T4: 동상

→ G fix가 collision 시나리오 단순화 (T2에서 1 backup-* 디렉토리만, Section 3 source). 회귀 0.

## D39 — Smoke fixture에 manifest 수정 안전성 (T3)

T3 가공:

```bash
awk '/^language/{print "language = \"haskell\""; next}{print}' \
    "$TMPDIR/.harness.toml" > "$TMPDIR/.tmp" \
    && mv "$TMPDIR/.tmp" "$TMPDIR/.harness.toml"
```

**검증**:

- `awk` BSD/GNU 양쪽 동작 (인용 — POSIX awk semantics)
- `> "$TMPDIR/.tmp"` redirect 후 `mv`로 atomic replace
- `&&` 체인은 인용 3에 따라 errexit 안전 (final operator command만 errexit 적용. mv는 일반적으로 성공)

→ **OK**. 별도 sed -i 회피 (BSD/GNU 차이).

## D40 — `harness*` glob — Phase 2 dotfile 미포함 영향

Section 2.5 (legacy cleanup) glob `harness*`는 dotfile (`.harness*` 등) 매치 안 함. 의도. dst에 `.harness*` 명명 사용자 custom 파일 가정 0.

또한 `harness*` glob은 `harness` 자체도 매치 (dir 또는 file) — `_base/skills/harness/`가 정확히 이 케이스. 기존 동작 유지.

→ 변경 0.

## D 분석 추가 5건 종합

| # | Finding | 영향 |
|---|---------|------|
| **D31** | PS `Select-String` null chain crash (v1.11 latent) | R6 신설 — Section 2.0 (PS) null-safe pattern |
| **D32** | bash `&&` 패턴 errexit 모호성 | R7 신설 — `if-else` 형식 채택 |
| **D33** | bash `harness*` glob 안전성 | 변경 0 (검증 완료) |
| **D34** | T2 critical assertion 재정의 | R5 Smoke 재설계 — log + path 양쪽 검사 |
| **D35** | Section 2.4 placement | R2 (refactor) 보강 |
| **D36** | PS Join-Path multi-arg cross-version | R8 신설 — literal interpolation |
| **D37** | Phase 2 dotglob 영향 0 | 변경 0 |
| **D38** | backup collision 영향 0 | 변경 0 |
| **D39** | T3 manifest awk 수정 안전 | smoke 구현 detail |
| **D40** | `harness*` glob dotfile 제외 | 변경 0 |

## 신규 R 결정 (R6, R7, R8)

PLAN의 R1~R5 보강:

### R6 — PowerShell null-safe Section 2.0 (D31 적용)

```powershell
$matchResult = Select-String -Path $Manifest -Pattern '...' -List -ErrorAction SilentlyContinue
if ($matchResult) { $language = $matchResult.Matches.Groups[1].Value.ToLower() } else { $language = '' }
```

- `-ErrorAction SilentlyContinue`로 추가 안전성
- 명시 if-else로 null-safe (인용 1)

### R7 — Bash if-else 형식 채택 (D32 적용)

```bash
in_base=0
if [ -e "$src/$name" ]; then in_base=1; fi
in_overlay=0
if [ -n "$overlay_path" ] && [ -e "$overlay_path/$cat/$name" ]; then
    in_overlay=1
fi
```

- 단일 `&&` 패턴 회피
- errexit 모호성 0

### R8 — PowerShell literal interpolation join (D36 적용)

```powershell
$inOverlay = $false
if ($overlayPath) {
    $overlayItem = "$overlayPath/$cat/$($d.Name)"
    if (Test-Path $overlayItem) { $inOverlay = $true }
}
```

- multi-arg `Join-Path` 회피
- PS는 `/` 자동 정규화 (Windows에서도 작동)

## R5 Smoke T2 재정의 (D34 결과)

**구 T2 (PLAN 초안)**: "0 backup-*" → 부정확 거부

**신 T2 (D34 적용)**:

- T2.a: `grep -q 'legacy cleanup' install.log` → 부재 (G fix 검증)
- T2.b: `find dst/.claude/backup-* -path '*/skills/harness-python' -type d` → 부재 (G fix 검증)

→ Smoke 8 → 9 checks (T2 split 2건).

## 최종 D 합계

원본 PLAN: D1~D30 (사실 PLAN에 명시 안 함, 구두로 사용)
보강: D31~D40 (10건)
신규 R: R6, R7, R8 (3건)

→ **PLAN 갱신 의무**:

- R1 의사코드 → R7 if-else 형식 반영
- R2 → R8 literal interpolation 반영
- R5 Smoke → T2 9 checks 재정의 (T2.a + T2.b)
- 신규 § "context7 검증 결과 (R6, R7, R8)" 추가
