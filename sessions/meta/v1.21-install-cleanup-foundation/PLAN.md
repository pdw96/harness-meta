# meta v1.21-install-cleanup-foundation — PLAN

세션 시작: 2026-04-29
직접 선행 세션:
- [`sessions/meta/v1.11-language-overlay-infra/`](../v1.11-language-overlay-infra/PLAN.md) — Phase 2 overlay merge 도입 + §11 한계 명시 + v1.21 해소 약속
- [`sessions/meta/v1.10j-scope-contract-discipline/`](../v1.10j-scope-contract-discipline/PLAN.md) — Scope contract 의무화

목적: `install-project-claude.{sh,ps1}` Section 2.5 legacy cleanup이 `_base`만 검사하는 v1.9b 한계를 해소. **`_base` + `<language>/.claude/` overlay 양쪽 검사**로 확장하여 v1.11b 도입 후 발생한 **활성 버그**(`language="python"` + `--force` 재install 시 `harness-python/`이 매번 spurious backup 생성) 차단.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S2(4) `bootstrap/{install-project-claude.sh, install-project-claude.ps1, docs/OVERLAY.md}` + S3(2) `tests/{smoke-legacy-cleanup-overlay.sh(신규), smoke-scope-contract.sh}` = **6/6 meta** (PLAN/REPORT 별도)
- **T1 경로 다수결** — meta scope 6/6
- **T2 스펙 vs 값** — install 알고리즘 + overlay 규약 정합 = 모든 프로젝트 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `bootstrap/docs/OVERLAY.md` §11 (verbatim)**:

> **해소 (후속)**: `v1.21-cross-platform-install`에서 legacy cleanup overlay-aware 확장 (`_base` + `<language>/` 양쪽 검사).

**Source 2 — `bootstrap/docs/OVERLAY.md` §13 v1.21 entry (verbatim)**:

> **v1.21 (별 도메인)**:
> - verify.ps1에 overlay 무결성 체크 + legacy cleanup overlay-aware

**Source 3 — `sessions/meta/v1.11-language-overlay-infra/PLAN.md` Out of scope 표 (verbatim)**:

> | Legacy cleanup overlay-aware 확장 (v1.9b 로직이 `<language>/` 도 검사) | 별 후속 (`-Force` 재실행으로 해결 — OVERLAY.md 한계 명시) |
> | verify.ps1 overlay 무결성 체크 | v1.21-cross-platform-install (verify 통합 시점) |

**Source 4 — 사용자 발의 (2026-04-29) verbatim**:

> "권고 채택" → 4 세션 분할 권고 중 첫 단계: **v1.21 = G만** (legacy cleanup overlay-aware foundation). E/C/F/A/B/D는 v1.22+ 분리.

**Parsed sub-items (1)**:

1. **Legacy cleanup overlay-aware** — `install-project-claude.{sh,ps1}` Section 2.5가 `_base/<cat>/<name>` 부재만 검사하던 것을 `_base/<cat>/<name>` + `<language>/.claude/<cat>/<name>` 양쪽 검사로 확장. 양쪽 모두 부재일 때만 backup 이동

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| verify.ps1 overlay 무결성 체크 + frontmatter 6축 통합 | **v1.23-verify-unification** (F+A+B 묶음) |
| `verify.sh` 신설 (현재 verify.ps1 Windows-only) | v1.23-verify-unification |
| install-skills + sync-agents 통합 | **v1.22-install-unification** (E+C 묶음) |
| copy mode fallback (Windows symlink 권한 부재 시) | v1.22-install-unification |
| macOS/Linux dynamic 검증 (CI 또는 제3 기기) | **v1.24-multi-os-validation** |
| Section 3 conflict cleanup도 overlay-aware로 — 사용자 custom vs overlay 검사 | 별 후속 (`harness-*` prefix convention으로 충돌 0 보장이 OVERLAY.md §6 결정. 본 세션 scope 외) |
| backup-<ts>/ 디렉토리 누적 자동 정리 | 별 후속 evidence-driven (현재는 사용자 수동 정리) |
| backup-<ts>/ 동일 초 collision 처리 | 별 후속 (현실 시나리오 0 — 1초 내 두 번 install 불가) |
| 동시 install 락 / race condition | 별 도메인 (concurrent install 미지원 명시) |
| Phase 2.5 algorithm rename | 유지 — "legacy" = "어떤 source에도 더 이상 없음" 의미로 정확 |
| `<lang>` 매트릭스 외 언어 (haskell 등) overlay 추가 | v1.11c+ (언어별 별 세션) |
| `[project].language` array 또는 multi-overlay | 별 도메인 (현재 single language 가정) |

## 1. 문제 (활성 버그 — v1.11b 도입 후 발생)

### 현재 상태 (v1.11b 이후)

`install-project-claude.{sh,ps1}` Section 2.5 (Legacy cleanup, v1.9b 도입):

```bash
# 의사코드
for d in dst/<cat>/harness*; do
    if [ ! -e "_base/<cat>/$name" ]; then
        mv "$d" "backup-<ts>/<cat>/$name"
    fi
done
```

→ `_base`에 없으면 무조건 legacy로 판정. **overlay에 있는 항목도 legacy로 오판**.

### 활성 시나리오

`upbit` 또는 다른 Python 프로젝트가 `language = "python"` + 재install (`--force`) 수행:

| Step | 내부 동작 | 결과 |
|------|---------|------|
| T1 — 첫 install | _base 복사 + Phase 2 (`harness-python/` 복사) | dest에 `harness-python/` 정상 |
| T2 — `--force` 재install Section 2.5 | `dst/skills/harness-python` 발견 → `_base/skills/harness-python` 검사 → **부재** → backup으로 이동 | spurious `backup-<ts>/skills/harness-python/` 생성 |
| T2 — Section 4 (_base 복사) | `_base/skills/` 복사 (harness/ 등) | `harness-python/`은 dest에 없음 (방금 backup) |
| T2 — Phase 2 (overlay 복사) | `python/.claude/skills/harness-python/` 복사 | dest에 `harness-python/` 다시 등장 |

**Net 결과**: `harness-python/` 데이터는 보존되지만 매 `--force` 실행마다:
1. 불필요한 backup 디렉토리 누적
2. WARN 로그 출력 ("legacy cleanup — 1건 backup")
3. 사용자 혼란 (실제로 legacy 아님)

### Root cause

`v1.11`에서 Phase 2 overlay 인프라 도입 시 Section 2.5 legacy cleanup의 source-of-truth를 `_base` only로 유지. 양쪽 검사로 확장 누락. v1.11 PLAN의 명시적 한계 (`Out of scope` 표 + OVERLAY.md §11)로 공인했으나 실제로는 **활성 버그**.

### 본 세션 해결 범위

**G — Legacy cleanup overlay-aware (1 sub-item)**.
- `_base` + `<language>/.claude/` 양쪽 검사 → 양쪽 부재 시만 backup 이동
- 진정한 legacy 시나리오 (language 변경, _base에서 항목 삭제 등)는 정상 작동 유지
- 정적 + dynamic smoke 신설로 회귀 검증

## 2. 결정 (R1 ~ R8)

> R1~R5는 1차 분석. R6~R8은 context7 검증 (`audit/A1-context7-validation.md`) 후 D31~D40 보강에서 도출. 모든 R 동시 적용.

### R1 — 알고리즘: 양쪽 source 검사

**Pseudocode (bash + ps1 의미 동등 — R7 if-else 형식 적용)**:

```
Section 2.4 — language + overlay path 통합 추출 (신규)
  language = grep+sed manifest [project].language → tr 'A-Z' 'a-z'
  overlay_path = ""
  if language not empty AND not _<reserved>:
      candidate = META_ROOT/bootstrap/templates/<language>/.claude
      if [ -d candidate ]:
          overlay_path = candidate

Section 2.5 — Legacy cleanup (overlay-aware, 갱신)
  for cat in categories:
      src_base = BASE/<cat>
      dst = DEST/<cat>
      [ -d "$dst" ] || continue
      for d in dst/harness*:
          [ -e "$d" ] || continue
          name = basename(d)
          in_base = 0
          if [ -e "$src_base/$name" ]: in_base=1
          in_overlay = 0
          if [ -n "$overlay_path" ] && [ -e "$overlay_path/$cat/$name" ]: in_overlay=1
          if [ in_base = 0 ] && [ in_overlay = 0 ]:
              # 양쪽 부재 → 진정한 legacy → backup
              ensure backup_root
              mv d → backup_root/<cat>/<name>
              legacy_moved += "<cat>/<name>"
          # else: 한쪽이라도 있으면 legitimate → 그대로 유지

Section 5 — Phase 2 (재사용 — Section 2.4 변수 활용)
  if overlay_path empty: skip
  else: 기존 로직 (language + overlay 재산출 제거)
```

**핵심 변화**: Section 2.5 판정 조건 `not in_base` → `not in_base AND not in_overlay`. 단일 `&&` 패턴 회피 (R7).

### R2 — Code organization (refactor 우선)

**선택**: Section 2.0 신설하여 language detection + overlay path 계산을 **단일 위치에서 1회만** 수행. Section 2.5와 Phase 2가 동일 변수 참조.

**대안 reject**: 2.5와 Phase 2에 각각 grep+sed 중복 (drift 위험 ↑).

**효과**:
- 향후 language detection 로직 변경 시 단일 지점만 갱신
- Phase 2 코드도 약간 단순화 (language 재산출 제거)

### R3 — Backward compat / 회귀 0 보장

| 시나리오 | v1.21 후 동작 | v1.20 동작 (회귀 검사 기준) |
|---------|--------------|--------------------------|
| `language` 미설정 → `--force` 재install | overlay_path 빈 값 → in_overlay 항상 false → 기존 v1.9b 동등 동작 | 동일 |
| `language="python"` + 첫 install (no -f) | Section 2.5 skip (-f 없음) | 동일 |
| `language="python"` + `--force` 재install (overlay 항목 정합) | **NEW**: harness-python in_overlay=true → backup 생략 | spurious backup 생성 (BUG) |
| `language="python"` → `language="rust"` 변경 + `--force` install | python overlay 부재 (이제 rust 검사) → harness-python in_overlay=false → backup 정당 | 동일 (legitimate cleanup) |
| `_base` 항목 삭제 (v1.8b commands 제거 같은 미래 변경) + `--force` | _base 부재 + overlay 부재 → backup 정당 | 동일 |
| `language="haskell"` (overlay 없음) + `--force` | overlay_path 빈 값 → in_overlay false → 기존과 동일 | 동일 |

→ **단 하나의 시나리오만 변경**: `language="<overlay 존재>"` + `--force` 재install → spurious backup 0. 다른 모든 케이스 회귀 0.

### R6 — PowerShell null-safe Section 2.4 (D31 적용 — context7 인용 1)

기존 v1.11 ps1 line 166-167:
```powershell
$languageRaw = (Select-String ... -List).Matches.Groups[1].Value   # null-chain crash 위험
```

PS docs 인용: "Attempting to index a `$null` variable results in a `RuntimeException`". `Select-String` no-match → `$null` → `.Matches.Groups[1]` 시 indexing crash. `$ErrorActionPreference='Stop'` 환경에서 즉시 종료.

**v1.21 채택 패턴** — 명시 if-else (null-safe):

```powershell
$matchResult = Select-String -Path $Manifest -Pattern '^language\s*=\s*"([^"]+)"' -List -ErrorAction SilentlyContinue
if ($matchResult) {
    $language = $matchResult.Matches.Groups[1].Value.ToLower()
} else {
    $language = ''
}
```

**부가 효과**: v1.11 latent crash (language 필드 부재 manifest install 시) 자연 해소. Out of scope 아님 — Section 2.4 통합이 동일 grep 로직 흡수하므로 incidental fix.

### R7 — Bash if-else 형식 채택 (D32 적용 — context7 인용 3)

bash docs 인용: errexit는 `&&`/`||` list 내 첫 command에서 ignored. 그러나 compound 자체 exit status는 마지막 실행 command 결과 → bash 버전/shopt 조합에 따라 errexit propagation 모호.

**v1.21 채택 패턴** — 단일 `&&` 회피:

```bash
in_base=0
if [ -e "$src/$name" ]; then
    in_base=1
fi

in_overlay=0
if [ -n "$overlay_path" ] && [ -e "$overlay_path/$cat/$name" ]; then
    in_overlay=1
fi
```

→ 가독성 + errexit 모호성 0. 두 번째 `if`의 `&&`는 두 conditional test를 묶는 것 (`[[]]` 내부)이지만 본 형식은 두 개의 `[ ]` 결합 — bash 표준 idiom (errexit 안전).

### R8 — PowerShell literal interpolation join (D36 적용)

multi-arg `Join-Path` cross-version 호환성 우려:

```powershell
# 회피 (PS 7.3+ 의존)
$overlayItem = Join-Path $overlayPath $cat $d.Name

# 채택 (PS 모든 버전 + Windows/Unix path 자동 정규화)
$overlayItem = "$overlayPath/$cat/$($d.Name)"
```

PS는 `/`를 native path로 자동 처리 (Windows에서도 OS API가 받아들임). 가독성 + 호환성.

### R4 — Documentation: OVERLAY.md §11 + §13 갱신

**§11 재작성** (현재: "Legacy cleanup 한계 (v1.9b)" → 신규: "Legacy cleanup overlay-aware (v1.21+)"):

- v1.9b 한계 + v1.21 해소 알고리즘 명시 (`_base` + `<language>/` 양쪽 검사)
- 시나리오 표 갱신 (활성 버그 명시 + 해소 후 동작)
- bash + ps1 의미 동등 명시

**§13 갱신** (v1.21 entry):

- 기존: `verify.ps1에 overlay 무결성 체크 + legacy cleanup overlay-aware`
- 신규: `legacy cleanup overlay-aware 완료 (v1.21). verify 통합 + frontmatter 6축은 v1.23 분리`

### R5 — Smoke 설계: 정적 3 + dynamic 6 = 9 checks (D34 적용 — T2 split)

**`tests/smoke-legacy-cleanup-overlay.sh` 신설**:

```
Stage 1 — 정적 (3 checks)
  S1.1 install-project-claude.sh: Section 2.4 (language+overlay_path 통합) + in_overlay 검사 grep
  S1.2 install-project-claude.ps1: 동등 mirror grep (overlayPath / inOverlay)
  S1.3 OVERLAY.md §11 재작성 + "v1.21" + "양쪽 검사" keyword

Stage 2 — Dynamic (6 checks, sample-project fixture)
  Setup:
    tmpdir=$(mktemp -d)
    cp -r tests/fixtures/sample-project/. tmpdir/
    # sample-project: language="python", overlay 정합

  T1 — 첫 install (no -f) → exit 0 + harness-python/ 존재
  T2 — --force 재install (overlay 정합 유지)
       T2.a (critical) install.log에 'legacy cleanup' 키워드 부재 (G fix 검증)
       T2.b (critical) backup-*/skills/ 내 harness-python 부재 (G fix 검증)
       ⚠️ Section 3 (conflicts backup)으로 backup-* 자체는 항상 1건 생성 — 정상
  T3 — manifest language 변경 (python → "haskell" overlay 부재) → --force install
       harness-python을 backup으로 이동 (legitimate cleanup 정합)
  T4 — manifest language 복원 (python) → --force install
       harness-python overlay에서 재복사 (영구 손실 없음 검증)
  T5 — _base 항목 (skills/harness/SKILL.md) 정상 잔존 (회귀 0 검증)
```

**T2가 critical regression test** (D34):
- ❌ 잘못된 assertion: "T2 후 0 backup-*" (Section 3가 항상 backup-* 생성)
- ✅ 정확한 assertion: T2.a (log) + T2.b (path) 양쪽 검사

**T3 manifest 수정 — `awk` 채택 (D39)**:
```bash
awk '/^language/{print "language = \"haskell\""; next}{print}' \
    "$TMPDIR/.harness.toml" > "$TMPDIR/.tmp" \
    && mv "$TMPDIR/.tmp" "$TMPDIR/.harness.toml"
```
BSD/GNU awk 양쪽 호환. `sed -i` 회피 (cross-platform 차이).

**Cross-platform**: bash dynamic만 검증. ps1 dynamic은 v1.24-multi-os-validation으로 이연 (정적 grep으로 알고리즘 mirror 확인).

**`tests/smoke-scope-contract.sh` 갱신**:

```bash
plans=(
    sessions/meta/v1.10h*/PLAN.md
    sessions/meta/v1.10j*/PLAN.md
    sessions/meta/v1.11*/PLAN.md
    sessions/meta/v1.12*/PLAN.md
    sessions/meta/v1.13*/PLAN.md
    sessions/meta/v1.14*/PLAN.md
    sessions/meta/v1.15*/PLAN.md   # 추가
    sessions/meta/v1.16*/PLAN.md   # 추가
    sessions/meta/v1.17*/PLAN.md   # 추가
    sessions/meta/v1.18*/PLAN.md   # 추가
    sessions/meta/v1.19*/PLAN.md   # 추가
    sessions/meta/v1.20*/PLAN.md   # 추가
    sessions/meta/v1.21*/PLAN.md   # 본 세션
)
```

→ v1.15-v1.20 모두 이미 의무 준수 확인됨. v1.21 본 세션 self-test도 자연 흡수.

## 3. 변경 대상 (3 수정 + 1 신규)

### 수정 (3)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/install-project-claude.sh` | S2 | R1+R2+R7 — Section 2.4 신설 (language + overlay_path 통합 추출) + Section 2.5 in_overlay 검사 (if-else 형식) + Phase 2 재사용 (중복 제거) + 헤더 1줄 |
| `bootstrap/install-project-claude.ps1` | S2 | R1+R2+R6+R8 — 동상 (PowerShell null-safe Select-String + literal interpolation join) + .DESCRIPTION 1줄. v1.11 latent null-chain crash 자연 해소 |
| `bootstrap/docs/OVERLAY.md` | S2 | R4 — §11 재작성 + §13 v1.21 entry 갱신 |

### 신규 (1) + smoke 갱신 (1)

| 경로 | scope | 역할 |
|------|------|------|
| `tests/smoke-legacy-cleanup-overlay.sh` | S3 | R5 — 정적 3 + dynamic 6 = 9 checks (D34 T2 split) |
| `tests/smoke-scope-contract.sh` | S3 | R5 — v1.15~v1.21 glob 추가 (self-test 흡수) |

### 세션 산출 (2)

| 경로 | 역할 |
|------|------|
| `sessions/meta/v1.21-install-cleanup-foundation/PLAN.md` | 본 파일 |
| `sessions/meta/v1.21-install-cleanup-foundation/REPORT.md` | Stage G |
| `sessions/meta/v1.21-install-cleanup-foundation/audit/A1-context7-validation.md` | 인용 1-4 (PS docs + Bash docs) + D31~D40 + R6/R7/R8 도출 근거 |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 + D1~D30 정밀 분석 반영
- [ ] **사용자 진입 확인**
- [x] **context7 검증 + D31~D40 audit 추가 + R6/R7/R8 도출**
- [ ] Stage A — `install-project-claude.sh` Section 2.4 신설 + 2.5 overlay-aware (R7 if-else) + Phase 2 재사용 + 헤더
- [ ] Stage B — `install-project-claude.ps1` 동등 mirror (R6 null-safe + R8 literal interpolation)
- [ ] Stage C — `OVERLAY.md` §11 + §13 갱신
- [ ] Stage D — `smoke-legacy-cleanup-overlay.sh` 신설 (9 checks — T2 split)
- [ ] Stage E — `smoke-scope-contract.sh` v1.15~v1.21 glob 추가
- [ ] Stage F — smoke 3종 실행 (PASS) + 기존 smoke-language-overlay.sh 회귀 0
- [ ] Stage G — REPORT.md
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `install-project-claude.sh`: Section 2.4 신설 + 2.5 in_overlay (R7 if-else) + Phase 2 재사용
- [ ] `install-project-claude.ps1`: 동등 mirror (R6 null-safe + R8 literal interpolation) — v1.11 latent crash 자연 해소
- [ ] `OVERLAY.md` §11: "v1.9b 한계" → "v1.21+ 해소" 재작성 + 알고리즘 명시
- [ ] `OVERLAY.md` §13: v1.21 entry 갱신
- [ ] `smoke-legacy-cleanup-overlay.sh` 9/9 PASS (정적 3 + dynamic 6)
  - **T2.a (critical, log)**: install.log에 'legacy cleanup' 키워드 부재 (G fix 검증)
  - **T2.b (critical, path)**: backup-*/skills/ 내 harness-python 부재 (G fix 검증)
  - **T3 (legitimate)**: language → "haskell" 후 --force → harness-python backup으로 이동
  - **T5 (회귀)**: _base/skills/harness/SKILL.md 정상 잔존
- [ ] `smoke-scope-contract.sh` v1.15-v1.21 PLAN 모두 두 섹션 PASS
- [ ] **회귀 0** — `smoke-language-overlay.sh` 기존 PASS 유지
- [ ] **upbit 영향 0** — `language="python"` 재install 시 spurious backup 0건 (직접 영향)

## 6. 커밋 전략

```
fix(meta): sessions/meta/v1.21-install-cleanup-foundation — legacy cleanup overlay-aware

Section 2.5 legacy cleanup이 _base만 검사하던 v1.9b 한계 해소.
v1.11b 이후 활성화된 활성 버그 (language="python" + --force 재install
시 harness-python/ spurious backup 생성) 차단.

- update: bootstrap/install-project-claude.sh (Section 2.0 신설 +
  2.5 _base + <language>/ 양쪽 검사 + Phase 2 재사용)
- update: bootstrap/install-project-claude.ps1 (동등 mirror)
- update: bootstrap/docs/OVERLAY.md (§11 재작성 + §13 v1.21 entry 갱신)
- add: tests/smoke-legacy-cleanup-overlay.sh (정적 3 + dynamic 5 = 8 checks)
- update: tests/smoke-scope-contract.sh (v1.15-v1.21 glob 추가)
- add: sessions/meta/v1.21-.../{PLAN,REPORT}.md

Smoke: 8/8 PASS (T2 0 backup-* 활성 버그 차단 + T3 legitimate 1 backup-* 정합).
회귀 0 — smoke-language-overlay.sh 기존 PASS 유지.
upbit 직접 수혜 — language="python" 재install spurious backup 0.
```

## 7. 후속 분기 (4 세션 분할 권고 순서)

| 후속 세션 | 포함 sub-items | 비고 |
|-----------|---------------|------|
| `v1.22-install-unification` | E (copy mode fallback) + C (install-skills + sync-agents) | install write 흐름 단일화 |
| `v1.23-verify-unification` | F (verify.sh 신설) + A (frontmatter 6축) + B (overlay 무결성) | verify read-only 통합 |
| `v1.24-multi-os-validation` | D (macOS/Linux dynamic) | 1~3 후 실 환경 dynamic 검증 |

## 8. Lessons Forward (예상)

- **L1 — "현실 시나리오 0" 명시 한계도 활성 버그가 될 수 있음** — v1.11 PLAN/OVERLAY.md §11이 "java overlay에 (가상으로)..."로 한계를 가상 시나리오로 기술. 실은 v1.11b 도입 (`harness-python/` 실 콘텐츠) 시점부터 동일 시나리오가 활성. 한계 기술 시 **현 시점 source 매트릭스 cross-check** 의무
- **L2 — Section 2.0 신설 = 단일 source-of-truth refactor 패턴** — language detection을 Section 2.5/Phase 2 두 곳에서 중복 산출 시 drift 위험. 통합 추출 + 재사용이 표준. 향후 frontmatter detection (v1.23) 등에도 동일 패턴 적용
- **L3 — Critical regression test (T2) 첫 정형화** — fix 부재 시 명백히 fail하는 시나리오를 명시적 분리 → fix 검증 deterministic. 기존 smoke는 정합 검증만 + critical-fail-path 검증 부재. 후속 smoke의 reference pattern
- **L4 — 4 세션 분할이 1 mega-session보다 안전** — v1.21 (G) → v1.22 (E+C) → v1.23 (F+A+B) → v1.24 (D)의 의존성 chain이 각 세션 회귀 격리 + scope contract 단순화. 단일 세션 시 7 sub-item 동시 변경 → 회귀 추적 어려움
