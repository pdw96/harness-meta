# A3 — Detection 전략 + bash 알고리즘 (Option C — T1 only)

본 v1.10e의 detect-project.sh `detect_license` 함수 알고리즘 명세. T1 (SPDX 헤더) + T3 (fallback)만.

## 1. 알고리즘 의사코드

```
detect_license(ROOT):
    LICENSE_FILES = ["LICENSE", "LICENSE.md", "LICENSE.txt", "COPYING"]

    for fname in LICENSE_FILES (case-insensitive):
        path = ROOT/<found case-insensitive match>
        if not exist: continue

        # T1: SPDX-License-Identifier 헤더 grep (첫 10 라인)
        spdx_id = grep -E "^SPDX-License-Identifier:" path | head -1 | sed extract
        if spdx_id non-empty:
            output: license = "<spdx_id>"
            return SUCCESS

    # T3: 미식별 → output 없음 (fallback)
    return NOT_FOUND  # silent
```

## 2. bash 구현 (detect-project.sh `detect_license` 함수 추가)

`bootstrap/detect-project.sh`에 새 함수 + main flow에서 호출:

```bash
# --- License detection (v1.10e — T1 SPDX-License-Identifier 헤더만) ---
license=""
for f in LICENSE LICENSE.md LICENSE.txt COPYING; do
    # case-insensitive 매칭 (find -iname)
    actual=$(find "$ROOT" -maxdepth 1 -iname "$f" -type f 2>/dev/null | head -1)
    [ -z "$actual" ] && continue

    # T1: SPDX-License-Identifier 헤더 grep (첫 10 라인 제한)
    spdx_id=$(head -10 "$actual" 2>/dev/null \
        | grep -E "^SPDX-License-Identifier:" \
        | head -1 \
        | sed -E 's/^SPDX-License-Identifier:[[:space:]]*(.+)[[:space:]]*$/\1/' \
        | tr -d '[:space:]')

    if [ -n "$spdx_id" ]; then
        license="$spdx_id"
        break
    fi
done

# T3: 미식별 → output 없음 (fallback)
[ -n "$license" ] && echo "license = \"$license\""
```

위치: detect-project.sh 끝부분 — `[testing]` 출력 다음, monorepo 출력 전.

## 3. LICENSE 파일명 우선순위

`LICENSE` → `LICENSE.md` → `LICENSE.txt` → `COPYING` (GPL 컨벤션).

**case-insensitive**: `License`, `license`, `LICENSE` 모두 매치 — `find -iname` 사용.

**제한**: `LICENSE-APACHE` / `LICENSE-MIT` 패턴 (dual-license)은 본 audit 미커버 — **v1.10e2 후속**.

## 4. SPDX-License-Identifier 형식 처리

### 표준 형식

```
SPDX-License-Identifier: MIT
```

### dual-license 형식 (희소)

```
SPDX-License-Identifier: MIT OR Apache-2.0
```

→ 그대로 stamp (`license = "MIT OR Apache-2.0"`). manifest schema가 SPDX expression 허용 (npm 표준 정합).

### sed 추출 결과 예시

| 입력 | 출력 |
|------|------|
| `SPDX-License-Identifier: MIT` | `MIT` |
| `SPDX-License-Identifier:    Apache-2.0` | `Apache-2.0` (trailing whitespace 제거) |
| `SPDX-License-Identifier: MIT OR Apache-2.0` | `MIT OR Apache-2.0` (보존 — `tr -d` 안 함, sed가 trailing만) |

⚠️ **수정 — 위 알고리즘의 `tr -d '[:space:]'` 제거 필요** (dual-license expression의 공백 보존):

```bash
# 정정 — 공백 보존 (dual-license 지원)
spdx_id=$(head -10 "$actual" 2>/dev/null \
    | grep -E "^SPDX-License-Identifier:" \
    | head -1 \
    | sed -E 's/^SPDX-License-Identifier:[[:space:]]*//' \
    | sed -E 's/[[:space:]]+$//')
```

## 5. T3 Fallback 동작

LICENSE 부재 또는 SPDX 헤더 미식별:

- detect-project.sh: **output 없음** (`license =` 라인 emit 안 함)
- Claude(Bootstrap)이 stdout grep 시 미발견 → `HM_LICENSE` env 미설정
- AGENTS.md.tmpl L5 치환 시 `{{license}}` → fallback 텍스트 `see LICENSE`

**Stage S3 preview WARN** (`bootstrap/docs/INTERVIEW_FLOW.md` §2 literal template):

```
⚠️ LICENSE 파일 부재 또는 SPDX 헤더 미식별 — proprietary 가정. AGENTS.md L5 fallback "see LICENSE" 유지.
   향후 LICENSE에 `SPDX-License-Identifier: <id>` 추가 시 자동 감지.
```

## 6. AGENTS.md.tmpl L5 변수화

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
HM_LICENSE = (detect-project.sh stdout에서 license = "..." grep 추출, 없으면 빈 값)

if HM_LICENSE non-empty:
    L5 = "License: $HM_LICENSE (see [LICENSE](LICENSE))"
else:
    L5 = "License: see LICENSE."  # fallback (v1.10b text 그대로)
```

**참고 — 치환 결과 예시**:

- T1 SPDX 매칭: `License: MIT (see [LICENSE](LICENSE))`
- T1 dual-license: `License: MIT OR Apache-2.0 (see [LICENSE](LICENSE))`
- T3 fallback: `License: see LICENSE.`

## 7. 환경변수 + render-manifest.sh 무관

본 v1.10e의 `{{license}}` 변수는 **AGENTS.md.tmpl 전용** — `.harness.toml` manifest와 무관.

- `render-manifest.sh` 변경 없음 (manifest에는 license 필드 없음)
- `HM_LICENSE` env는 Claude(Bootstrap)이 AGENTS.md 치환 시점에만 사용
- v1.10c의 `{{install_cmd}}` 패턴과 동일 (env-driven, manifest 외 콘텐츠 변수)

## 8. round-trip 한계 안내 (INTERVIEW_FLOW.md 1줄)

bootstrap 1회성 detection — LICENSE 변경 후 AGENTS.md 자동 갱신 안 됨.

**INTERVIEW_FLOW.md** §3.3 변수 표 끝에 추가:
> ⚠️ `{{license}}`는 bootstrap 1회성 — 사용자가 LICENSE 변경 시 AGENTS.md L5 수동 갱신 필요.

## 9. 검증 (smoke 3 case)

| Stage | mock LICENSE | 기대 |
|-------|-------------|------|
| Stage 1 (T1 — SPDX MIT) | `SPDX-License-Identifier: MIT` 첫 라인 | `license = "MIT"` |
| Stage 2 (T1 — SPDX Apache-2.0) | `SPDX-License-Identifier: Apache-2.0` | `license = "Apache-2.0"` |
| Stage 3 (T3 — 부재) | LICENSE 파일 없음 | output 없음 (silent) |

추가 stage:

- Stage 4 (T3 — boilerplate만, SPDX 헤더 없음): `MIT License` 첫 라인 → output 없음 (T1 미매칭, fallback)

→ smoke `tests/smoke-bootstrap-license-detect.sh` 4 stage.

## 10. v1.10e2 후속 분기점

본 v1.10e (T1 only)의 명시적 한계:

- sample 100% T3 fallback (SPDX 헤더 보유 0/10)
- 실용 추출률 거의 0%

→ 사용자가 본 v1.10e 적용 후 두 옵션:

1. **LICENSE에 SPDX 헤더 추가** (사용자 행동, INTERVIEW_FLOW.md 안내 따름)
2. **v1.10e2 채택** (T2 boilerplate 매칭 9 패턴 추가, 실용 추출률 50%+)

본 v1.10e의 evidence base가 v1.10e2 채택 결정을 자연 유도.
