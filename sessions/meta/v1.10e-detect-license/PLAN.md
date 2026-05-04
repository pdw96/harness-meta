# meta v1.10e-detect-license — PLAN (Option C — T1 only)

세션 시작: 2026-04-27 (v1.10c 폐기 결정 후속)
직접 선행 세션:

- [`sessions/meta/v1.10c-bootstrap-content-defaults/`](../v1.10c-bootstrap-content-defaults/REPORT.md) — License 자동 default 폐기 + 본 v1.10e 약속 ("detect-project.sh가 LICENSE 파일 SPDX 헤더 추출 + S3 preview WARN. 본 세션이 license 미터치한 placeholder를 정식 자동화")
- [`sessions/meta/v1.10b-bootstrap-agents-md/`](../v1.10b-bootstrap-agents-md/REPORT.md) — AGENTS.md.tmpl L5 placeholder 도입

목적: v1.10c가 placeholder 형태로 남긴 AGENTS.md.tmpl L5 `License: see LICENSE.`를 **T1 SPDX-License-Identifier 헤더 자동 감지**로 전환. observation only — 사용자 LICENSE 작성 시만 추출 (v1.10c 거부 결정 정합).

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S2(7) — `bootstrap/{detect-project.sh, skeletons/AGENTS.md.tmpl, interview.md, docs/INTERVIEW_FLOW.md, manifest-schema.md, skeletons/projects/INTERVIEW.md}` + smoke. S1a(1) — `claude/commands/harness-meta.md`. 합 **8/8 meta**.
- **T1 경로 다수결** — meta scope 8/8.
- **T2 스펙 vs 값** — 자동 적용 카운트 (6→7) + T1 SPDX detection 알고리즘 정의는 "흐름 스펙". 신규 프로젝트의 LICENSE 파일 실 콘텐츠는 별도 `sessions/<name>/v0.1-bootstrap/` (T4).

## v1.10e scope 명시 분리 (Option C — Hybrid)

audit/A4 결정에 따라 본 v1.10e는 **v1.10c REPORT promise 정확 일치** 범위로 한정:

### ✅ 포함 (8 항목)

1. T1 — SPDX-License-Identifier 헤더 grep 추출
2. T3 — fallback (output 없음)
3. S3 preview WARN (LICENSE 부재 또는 SPDX 미식별 시)
4. AGENTS.md.tmpl L5 변수화 (`{{license}}`, fallback `see LICENSE`)
5. LICENSE 파일명 4 우선순위 (`LICENSE` → `.md` → `.txt` → `COPYING`, case-insensitive)
6. INTERVIEW_FLOW.md round-trip 한계 1줄 안내
7. v1.10c observation vs injection 정합성 audit/A5
8. 자동 적용 카운트 6 → 7

### ❌ 제외 (5 항목 → 후속)

- **T2 boilerplate 매칭 9 패턴** (MIT/Apache/GPL/BSD/ISC/MPL/Unlicense) → **v1.10e2** (sample 추출률 50%+ 잠재)
- **dual-license multi-file** (LICENSE-APACHE + LICENSE-MIT) → **v1.10e2**
- **메타데이터 license 필드** (npm/pyproject/Cargo) → **v1.10e3**
- **agents.md L5 license 라인 자체 정책** (라인 제거/유지 결정) → **v1.10h**
- **NOTICE 파일 보조 검증 (Apache-2.0)** → **v1.10e2**

## v1.10c 정합성 (audit/A5 — observation vs injection)

| 측면 | v1.10c 거부 | v1.10e 채택 |
|------|:----------:|:-----------:|
| 행위 유형 | injection (default MIT 강제) | **observation** (사용자 LICENSE read) |
| 트리거 | LICENSE 부재여도 stamp | **LICENSE + SPDX 헤더 존재 시만** stamp |
| 의도 위배 risk | 있음 (Apache 의도자) | **0** |
| 결정 정당성 | ✅ 거부 정당 | ✅ 채택 정당 |

→ v1.10c 거부 3 이유 모두 무력화. 본질 다름. 정합.

## audit 5 파일 (Stage A 완료)

| 파일 | 내용 |
|------|------|
| [`audit/A1-spdx-spec.md`](audit/A1-spdx-spec.md) | SPDX 12 ID + SPDX-License-Identifier 헤더 spec + npm/agents.md/Linguist reference + v1.10c promise verbatim |
| [`audit/A2-license-distribution.md`](audit/A2-license-distribution.md) | 10 sample 분포 (SPDX 헤더 보유율 0%) + 4 프로젝트 분포 + T1 추출률 한계 |
| [`audit/A3-detect-strategy.md`](audit/A3-detect-strategy.md) | T1+T3 bash 알고리즘 + LICENSE 파일명 우선순위 + SPDX expression dual-license 보존 + AGENTS.md 치환 로직 |
| [`audit/A4-policy-decisions.md`](audit/A4-policy-decisions.md) | R1-R7 결정 + scope 매트릭스 14항목 + Grey Areas 5건 (G1 결정 후 종속 해소) |
| [`audit/A5-v110c-consistency.md`](audit/A5-v110c-consistency.md) | observation vs injection 정합성 + 5 시나리오 검증 + v1.10e2 재검증 필요 명시 |

## bash 알고리즘 (audit/A3)

```bash
# detect-project.sh 끝부분 (testing 출력 다음, monorepo 출력 전)

# --- License detection (v1.10e — T1 SPDX-License-Identifier 헤더만) ---
license=""
for f in LICENSE LICENSE.md LICENSE.txt COPYING; do
    actual=$(find "$ROOT" -maxdepth 1 -iname "$f" -type f 2>/dev/null | head -1)
    [ -z "$actual" ] && continue

    spdx_id=$(head -10 "$actual" 2>/dev/null \
        | grep -E "^SPDX-License-Identifier:" \
        | head -1 \
        | sed -E 's/^SPDX-License-Identifier:[[:space:]]*//' \
        | sed -E 's/[[:space:]]+$//')

    if [ -n "$spdx_id" ]; then
        license="$spdx_id"
        break
    fi
done

[ -n "$license" ] && echo "license = \"$license\""
```

## AGENTS.md.tmpl 변수화 (Stage D)

### Before (v1.10b)

```
License: see LICENSE. See [README.md](README.md) for project overview (human-readable).
```

### After (v1.10e)

```
License: {{license}}
```

### 치환 로직 (Claude Bootstrap)

```
HM_LICENSE = (detect-project.sh stdout에서 "license = \"...\"" grep 추출)

if HM_LICENSE non-empty:
    L5 = "License: $HM_LICENSE (see [LICENSE](LICENSE))"
else:
    L5 = "License: see LICENSE."  # fallback (v1.10b 텍스트)
```

## 목표

- [x] **audit/ 5 파일 작성** (Stage A 완료)

- [ ] **Stage B — `bootstrap/detect-project.sh` 갱신**
  - License detection 함수 추가 (T1 SPDX 헤더 + T3 fallback)
  - LICENSE 파일명 4 우선순위 + case-insensitive (`find -iname`)
  - 위치: `[testing]` 출력 다음, monorepo 출력 전

- [ ] **Stage C — `bootstrap/skeletons/AGENTS.md.tmpl` 변경**
  - L5 `License: see LICENSE.` → `License: {{license}}`
  - sed 변수 14 → **15** (L5의 `{{license}}` 추가)

- [ ] **Stage D — `bootstrap/interview.md` 갱신**
  - "License 처리 (자동 적용 안 함)" → "License 처리 (자동 적용 — v1.10e SPDX 헤더 감지)"
  - 자동 적용 카운트 6 → 7 (manifest 4 + 콘텐츠 3: bootstrap_version + install_cmd + license)
  - 본문에 T1 SPDX 헤더 매핑 명시 + T2/메타데이터/dual은 v1.10e2/e3 후속 명시

- [ ] **Stage E — `bootstrap/docs/INTERVIEW_FLOW.md` 갱신**
  - §3.3 변수 표 `{{license}}` 추가 + Round-trip 한계 1줄 안내
  - §2 Stage S3 preview literal에 license default 표 추가 + LICENSE 부재 WARN
  - 파일별 변수 카운트 14 → 15

- [ ] **Stage F — `bootstrap/manifest-schema.md` 갱신**
  - L437 자동 적용 6 → 7

- [ ] **Stage G — `bootstrap/skeletons/projects/INTERVIEW.md` 갱신**
  - 자동 적용 6 → 7 + license 항목 추가

- [ ] **Stage H — `claude/commands/harness-meta.md` 갱신**
  - S2 자동 6 → 7 + license SPDX 감지 명시

- [ ] **Stage I — Smoke**
  - `tests/smoke-bootstrap-license-detect.sh` 신규 (4 stage):
    - Stage 1 (T1 — SPDX MIT)
    - Stage 2 (T1 — SPDX Apache-2.0)
    - Stage 3 (T1 — SPDX dual-license `MIT OR Apache-2.0`)
    - Stage 4 (T3 — boilerplate만, SPDX 미포함 → output 없음)
  - `evidence/smoke-bootstrap-license-detect.txt`

- [ ] **REPORT.md** 작성

- [ ] **사용자 확인 후 단일 커밋** + push

## 변경 대상 (8 파일 + audit 5 + smoke evidence 1 = 14)

### 신규 (1 + 5 + 1 + 1 + 1 = 9 파일)

| 경로 | scope | 역할 |
|------|------|------|
| `tests/smoke-bootstrap-license-detect.sh` | S2 | 4 stage T1 SPDX 감지 + T3 fallback 검증 |
| `sessions/meta/v1.10e-detect-license/audit/A1-A5.md` | meta | evidence 5 파일 (작성 완료) |
| `sessions/meta/v1.10e-detect-license/PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.10e-detect-license/REPORT.md` | meta | (Stage I 후 작성) |
| `sessions/meta/v1.10e-detect-license/evidence/smoke-bootstrap-license-detect.txt` | meta | smoke 결과 |

### 수정 (7 파일)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/detect-project.sh` | S2 | License detection 함수 (T1 SPDX 헤더 + T3 fallback) — 4 LICENSE 파일명 우선순위 + case-insensitive |
| `bootstrap/skeletons/AGENTS.md.tmpl` | S2 | L5 `License: see LICENSE.` → `License: {{license}}` (sed 변수 14 → 15) |
| `bootstrap/interview.md` | S2 | "License 처리" § v1.10e 갱신 + 자동 적용 6 → 7 + § "T1 SPDX 헤더 감지 매핑" |
| `bootstrap/docs/INTERVIEW_FLOW.md` | S2 | §3.3 `{{license}}` 변수 + Stage S3 literal license default + Round-trip 1줄 + 파일별 카운트 14 → 15 |
| `bootstrap/manifest-schema.md` | S2 | L437 자동 적용 6 → 7 |
| `bootstrap/skeletons/projects/INTERVIEW.md` | S2 | 자동 적용 6 → 7 (license 항목 1 추가) |
| `claude/commands/harness-meta.md` | S1a | S2 자동 6 → 7 + license SPDX 감지 명시 |

## smoke 4 stage (Stage I 신규 `tests/smoke-bootstrap-license-detect.sh`)

```bash
#!/usr/bin/env bash
# v1.10e smoke — T1 SPDX 헤더 감지 + T3 fallback 검증
set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

DETECT="$HARNESS_META_ROOT/bootstrap/detect-project.sh"

# Stage 1 — T1 MIT
mkdir -p "$TMPDIR/s1"
echo "SPDX-License-Identifier: MIT" > "$TMPDIR/s1/LICENSE"
echo "" >> "$TMPDIR/s1/LICENSE"
echo "MIT License" >> "$TMPDIR/s1/LICENSE"

OUT=$(bash "$DETECT" "$TMPDIR/s1" 2>/dev/null)
echo "$OUT" | grep -q 'license = "MIT"' || { echo "FAIL Stage 1: T1 MIT 미매칭"; echo "$OUT"; exit 1; }
echo "PASS Stage 1 — T1 SPDX MIT"

# Stage 2 — T1 Apache-2.0
mkdir -p "$TMPDIR/s2"
echo "SPDX-License-Identifier: Apache-2.0" > "$TMPDIR/s2/LICENSE"

OUT=$(bash "$DETECT" "$TMPDIR/s2" 2>/dev/null)
echo "$OUT" | grep -q 'license = "Apache-2.0"' || { echo "FAIL Stage 2: T1 Apache-2.0 미매칭"; exit 1; }
echo "PASS Stage 2 — T1 SPDX Apache-2.0"

# Stage 3 — T1 dual-license expression
mkdir -p "$TMPDIR/s3"
echo "SPDX-License-Identifier: MIT OR Apache-2.0" > "$TMPDIR/s3/LICENSE"

OUT=$(bash "$DETECT" "$TMPDIR/s3" 2>/dev/null)
echo "$OUT" | grep -q 'license = "MIT OR Apache-2.0"' || { echo "FAIL Stage 3: T1 dual-license expression 미매칭"; exit 1; }
echo "PASS Stage 3 — T1 SPDX dual-license"

# Stage 4 — T3 fallback (boilerplate만, SPDX 헤더 없음)
mkdir -p "$TMPDIR/s4"
echo "MIT License" > "$TMPDIR/s4/LICENSE"
echo "" >> "$TMPDIR/s4/LICENSE"
echo "Copyright (c) 2026 Test" >> "$TMPDIR/s4/LICENSE"

OUT=$(bash "$DETECT" "$TMPDIR/s4" 2>/dev/null)
echo "$OUT" | grep -q 'license = ' && { echo "FAIL Stage 4: T3 fallback 위반 (boilerplate 매칭됨, T2는 v1.10e2 후속)"; echo "$OUT"; exit 1; }
echo "PASS Stage 4 — T3 fallback (boilerplate-only LICENSE → output 없음)"

echo ""
echo "============================="
echo "smoke-bootstrap-license-detect PASS — 4/4"
echo "============================="
```

evidence: `evidence/smoke-bootstrap-license-detect.txt`.

## Grey Areas — 5건 (audit/A4 결정)

| ID | 질문 | 결정 |
|----|------|------|
| **G1** | T2 boilerplate 포함 여부 | **Option C — T1 only in v1.10e, T2 in v1.10e2 후속** (R1) |
| **G2** | LICENSE 파일명 우선순위 | `LICENSE` → `.md` → `.txt` → `COPYING`, case-insensitive (R2) |
| **G3** | 자동 적용 6 → 7 | 7건 채택 (R5) |
| **G4** | LICENSE 부재 처리 | T3 fallback (R3) |
| **G5** | agents.md L5 license 라인 자체 정책 | **별도 v1.10h** — 본 v1.10e는 placeholder 자동화 본질 |

## 성공 기준

- [x] audit/A1-A5 5 파일 작성 (Stage A 완료)
- [ ] `bootstrap/detect-project.sh` License 감지 함수 추가 (T1+T3)
- [ ] `bootstrap/skeletons/AGENTS.md.tmpl` L5 `{{license}}` 변수화 (sed 14 → 15)
- [ ] `bootstrap/interview.md` 자동 적용 6 → 7 + License § 갱신
- [ ] `bootstrap/docs/INTERVIEW_FLOW.md` `{{license}}` 변수 표 + Stage S3 literal + Round-trip 안내
- [ ] `bootstrap/manifest-schema.md` L437 자동 적용 6 → 7
- [ ] `bootstrap/skeletons/projects/INTERVIEW.md` 6 → 7
- [ ] `claude/commands/harness-meta.md` S2 자동 6 → 7
- [ ] `tests/smoke-bootstrap-license-detect.sh` 4 stage PASS
- [ ] `evidence/smoke-bootstrap-license-detect.txt`
- [ ] REPORT.md 작성
- [ ] 사용자 확인 후 단일 커밋 + push

## 커밋 전략

단일 커밋. 부분 적용 시 자동 적용 카운트 6/7 + sed 14/15 불일치 → 자산 정합성 깨짐.

```
feat(meta): sessions/meta/v1.10e-detect-license — LICENSE SPDX 헤더 자동 감지 (T1 only, Option C)

- update: bootstrap/detect-project.sh (License section: T1 SPDX-License-Identifier + T3 fallback)
- update: bootstrap/skeletons/AGENTS.md.tmpl (L5 placeholder → {{license}} 변수, sed 14→15)
- update: bootstrap/interview.md (자동 적용 6→7 + License § v1.10e 갱신)
- update: bootstrap/docs/INTERVIEW_FLOW.md ({{license}} 변수 표 + Stage S3 license default + Round-trip 안내)
- update: bootstrap/manifest-schema.md (L437 자동 적용 6→7)
- update: bootstrap/skeletons/projects/INTERVIEW.md (6→7)
- update: claude/commands/harness-meta.md (S2 자동 6→7)
- add: tests/smoke-bootstrap-license-detect.sh (4 stage T1+T3)
- add: sessions/meta/v1.10e-detect-license/{PLAN,REPORT,audit/A1-A5,evidence/smoke}

v1.10c 폐기 결정 후속. License 안전 처리 — observation only (사용자 명시 SPDX 헤더만 추출).

핵심 결정 (audit/A4 R1 — Option C):
- T1 (SPDX-License-Identifier 헤더 grep) — 본 v1.10e
- T2 (boilerplate 9 패턴) — v1.10e2 후속 (sample 추출률 50%+ 잠재)
- T3 (fallback) — output 없음 + S3 WARN
- 메타데이터 license — v1.10e3 후속
- multi-file dual-license — v1.10e2 후속

v1.10c 거부 정합성 (audit/A5):
- v1.10c 거부 = injection (default MIT 강제). v1.10e 채택 = observation (사용자 LICENSE read).
- 거부 3 이유 모두 무력화 (agents.md spec 위반 동일 / 의도 위배 risk 0 / 권위 도구 패턴 정합).

Smoke 4/4 PASS — T1 MIT/Apache-2.0/dual-license + T3 boilerplate fallback.
```

## 후속 세션 연결

### 직접 연계 (v1.10e evidence 기반)

- **v1.10e2-license-boilerplate** (S2) — T2 boilerplate 매칭 9 패턴 (MIT/Apache/GPL/BSD/ISC/MPL/Unlicense) + GPL or-later 처리 + multi-file dual-license. **본 audit/A2가 동기 evidence** (SPDX 헤더 보유율 0%, OSS sample 50% boilerplate 매칭 가능)
- **v1.10e3-license-metadata** (S2) — package.json/pyproject.toml/Cargo.toml `license` 필드 추출 + UNLICENSED 처리
- **v1.10h-agents-md-license-line-policy** (S2) — agents.md L5 license 라인 유지/제거/형식 정책 결정

### Lessons Forward

1. **scope 매트릭스 의식적 분리** — v1.10c REPORT promise 정확 일치 (T1 only) vs 초과 (T2/T3 fuzzy/메타데이터)를 명시적으로 매트릭스화. PLAN 초안의 9 boilerplate + dual + 메타데이터는 scope creep — Option C로 정확화
2. **observation vs injection 본질 다름** — v1.10c 거부 (injection) vs v1.10e 채택 (observation). 둘 다 정당. audit/A5 단독 파일로 정합성 검증 보존
3. **evidence가 후속 동기 자연 유도** — sample T1 추출률 0% 명시 → 사용자가 한계 인지 → v1.10e2 채택 결정 자연 유도. evidence-driven 후속 분기
4. **단일 책임 v1.10x 패턴** — 각 v1.10x가 ~10 변경 파일. v1.10e도 동급. scope creep은 별도 후속 분기 (v1.10e2/e3/h)
5. **bash detect-project.sh 한계 인정** — Sorensen dice / cosine similarity 등 정교 매칭은 bash로 불가. T1 (정확) + T3 (안전 fallback)만. T2는 v1.10e2에서 단순 grep으로 우회 (false positive risk 명시)
