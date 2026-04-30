# Bootstrap Interview Flow — `/harness-meta <new-name>` 8-stage 책임 분리

`/harness-meta <new-name>` Bootstrap 모드의 **end-to-end 흐름**을 단일 소스로 정의. v1.10에서 확정, v1.14에서 8-stage로 간결화 (`sessions/meta/v1.14-bootstrap-simplify/`).

각 stage는 단일 책임. 실패 단위 격리 + 재실행 단위 명확.

## 1. Bootstrap 모드 진입 조건

다음 두 조건 동시 충족:

- 대상 프로젝트 루트에 `.harness.toml` 부재
- `~/harness-meta/projects/<name>/` 부재

하나라도 위배 시 Bootstrap 진입 거부 (Idempotency §5 참조).

## 2. 8-stage 표

| Stage | 주체 | 산출 |
|------|------|------|
| **S0 모드 진입** | 슬래시 명령 (`harness-meta.md`) | Bootstrap 의사 확인 |
| **S1 감지** | `detect-project.sh` (v1.9) | TOML snippet (lang/pm/test_cmd) |
| **S2 인터뷰** | `interview.md` | 사용자 답변 7Q (Q1-Q6 + Q10) + Q13 optional. HM_* env export. Q7/Q8/Q9 Claude 자동 설정 |
| **S3 manifest 작성+미리보기+검증** | `render-manifest.sh` + Claude (Write + Bash grep + literal template) | `.harness.toml` 렌더링 → 인라인 미리보기 + AGENTS.md 콘텐츠 defaults 표 → 사용자 확정 → 파일 작성 → round-trip 통과 (3 필드: name/code_dir/phases_dir) |
| **S4 프로젝트 부수 자산** (v1.10b sub-step a-e) | Claude (skeletons/ 기반 Write) | a) `<proj>/AGENTS.md` baseline / b) `<proj>/CLAUDE.md` (3 import: `@AGENTS.md` + `@ARCHITECTURE.md` + 조건부 `@CLAUDE.override.md`) / c) `<proj>/CLAUDE.override.md` (Q13 응답 시만) / d) `<proj>/{HM_GUARDRAILS}` placeholder / e) `<proj>/{HM_PHASES_DIR}/.gitkeep` |
| **S5 .claude/ 배포** | Claude (uname OS 분기 → install-project-claude.{ps1,sh}) | `<proj>/.claude/` 14 파일 |
| **S6 아키텍처+세션 기록** | Claude (skeletons/projects/ + skeletons/sessions/ 기반 Write) | `~/harness-meta/projects/<name>/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK,ROADMAP}.md` (v1.36+ 5종) + `sessions/<name>/v0.1-bootstrap/{PLAN,REPORT}.md` |
| **S7 후속 안내** | Claude (텍스트 출력) | 사용자 행동 항목: output style / GUARDRAILS 작성 / code_dir 골격 / **ARCHITECTURE.md의 observability·CI 항목 후속 작성** |

### 2.1. Stage S3 preview literal template (v1.10c — Claude 출력 deterministic)

S3에서 Claude(Bootstrap)는 `render-manifest.sh` stdout 다음에 **본 literal template를 그대로 복사 출력**한다. helper script 없이 deterministic 보장.

```
============= .harness.toml preview =============
(render-manifest.sh stdout 그대로)

============= AGENTS.md content defaults =========
| 변수 | 값 | 출처 |
|------|------|------|
| {{bootstrap_version}} | 1.10e3 | (자동 stamp — 본 세션 버전) |
| {{install_cmd}}       | <PM 매핑 결과> | interview.md `## install_cmd 매핑` (Q3 = <PM>) |
| {{license}}           | **v1.10h 3-way**: Case 1 (T1/T2/T2-Multi/T2.5) → `MIT (see [{HM_LICENSE_FILE}]({HM_LICENSE_FILE}))` (actual filename — `LICENSE`/`LICENSE.md`/`COPYING`/`LICENSES/CUSTOM` 등) / Case 2 (T3 only) → `MIT` (link 생략) / Case 3 (fallback or MAX_LENGTH > 80) → `see LICENSE.` | detect-project.sh 4-tier + license_file relative path. MAX_LENGTH=80 (Anthropic EULA abuse 차단) |

⚠️ LICENSE 부재 / boilerplate 미매칭 / 메타 부재 시 Case 3 fallback. boilerplate 또는 메타 stamp 의도와 다르면 SPDX 헤더 (`SPDX-License-Identifier: <id>`) 추가 권장 (T1 우선 매칭). **v1.10h 해소**: T3 메타 매칭 시 LICENSE 파일 부재 → Case 2 link 생략. round-trip 1회성 — LICENSE/메타 변경 후 AGENTS.md L5 수동 갱신.

확정 (yes / no / 수정) ?
```

`<PM 매핑 결과>` / `<PM>`은 사용자 Q3 답변 + interview.md 매트릭스 lookup 결과로 치환. `<T1 ... T3 메타 ... fallback>`는 detect-project.sh 4-tier (audit `sessions/meta/v1.10e3-license-metadata/audit/A1-A5`):
1. T1 — SPDX-License-Identifier 헤더 (head -10) — v1.10e
2. T2-Multi — multi-file dual (LICENSE-MIT + LICENSE-APACHE 등) — v1.10e2
3. T2 — boilerplate 12 패턴 (head -30, MIT/Apache/GPL family/BSD/ISC/MPL/Unlicense) — v1.10e2
4. T2.5 — Cargo `[package].license-file = "<path>"` 사용자 정의 LICENSE 경로 → license_path 보강 후 T1/T2 재시도 — v1.10e3
5. T3 — 메타데이터 4 source (LICENSE 콘텐츠 미매칭 시만 진입 — audit/A5) — v1.10e3
   - M2 PEP 639 modern (`pyproject.toml [project].license = "..."`)
   - M2-legacy PEP 621 inline (`license = {text = "..."}`, single-line)
   - M2-file PEP 621 inline (`license = {file = "<path>"}` → 1회 재귀)
   - M3 Poetry (`[tool.poetry].license = "..."` deprecated)
   - M1 npm (`package.json "license": "..."` + legacy `{type, url}` object 부분 지원 + UNLICENSED → LicenseRef-UNLICENSED + SEE LICENSE IN <file> 1회 재귀)
   - M4 Cargo (`Cargo.toml [package].license = "..."` SPDX 2.3 expression 보존)
6. fallback — output 없음, AGENTS.md L5 `see LICENSE.`

## 3. 데이터 전달 명세

### 3.1. detect output 파싱 절차 (S1 → S2)

```bash
# (a) Claude는 Bash tool로 detect-project.sh 실행, stdout 캡처:
DETECT_OUT=$(bash $HARNESS_META_ROOT/bootstrap/detect-project.sh "$PROJECT_ROOT")

# (b) Claude는 출력에서 line별 grep으로 default 추출:
detected_lang=$(echo "$DETECT_OUT" | grep -E '^language = "' | sed -E 's/.*"([^"]+)".*/\1/')
detected_pm=$(echo   "$DETECT_OUT" | grep -E '^package_manager = "' | sed -E 's/.*"([^"]+)".*/\1/')
detected_test_cmd=$(echo "$DETECT_OUT" | grep -E '^test_cmd = "' | sed -E 's/.*"([^"]+)".*/\1/')
detected_lint_cmd=$(echo "$DETECT_OUT" | grep -E '^lint_cmd = "' | sed -E 's/.*"([^"]+)".*/\1/')
detected_format_cmd=$(echo "$DETECT_OUT" | grep -E '^format_cmd = "' | sed -E 's/.*"([^"]+)".*/\1/')
detected_license=$(echo "$DETECT_OUT" | grep -E '^license = "' | sed -E 's/.*"([^"]+)".*/\1/')
detected_license_file=$(echo "$DETECT_OUT" | grep -E '^license_file = "' | sed -E 's/.*"([^"]+)".*/\1/')   # v1.10h R1 — relative path

# (c) 각 default를 Q2/Q3/Q10에 표시 → 사용자 확정 → HM_* env export
# (d) Q11/Q12/Q13 자유 응답은 env 미매핑 — Claude 메모리에만 보유 후 INTERVIEW.md/STACK.md/ARCHITECTURE.md/CLAUDE.override.md 기록 (Q13 — v1.10b 신규)
```

### 3.2. interview → render env 매핑 (S2 → S3)

| Q | env (HM_*) | render-manifest.sh 처리 | v1.14 변경 |
|---|---|---|---|
| Q1 name | `HM_NAME` | required | — |
| Q2 language | `HM_LANGUAGE` | required | — |
| Q3 package_manager | `HM_PACKAGE_MANAGER` | required | — |
| Q4 runtime_version | `HM_RUNTIME_VERSION` | required | — |
| Q5 code_dir | `HM_CODE_DIR` | required | — |
| Q6 phases_dir | `HM_PHASES_DIR` | required | — |
| ~~Q7 meta_ref~~ | `HM_META_REF` | required | **자동 설정**: `projects/${HM_NAME}/ARCHITECTURE.md` |
| ~~Q8 guardrails~~ | `HM_GUARDRAILS` | optional | **자동 설정**: `docs/GUARDRAILS.md` |
| ~~Q9 locale~~ | (미export) | optional, default "en" | **미설정**: render default 사용 |
| Q10 test/lint/format/type_check | `HM_TEST_CMD`/`HM_LINT_CMD`/`HM_FORMAT_CMD`/`HM_TYPE_CHECK_CMD` | optional | — |
| (자동) build (컴파일 언어) | `HM_BUILD_TOOL`/`HM_BUILD_CMD`/`HM_ARTIFACT_DIR` | optional | — |
| ~~Q11/Q12 자유 응답~~ | (env 미매핑) | render 무관 | **이연**: S7 후속 안내에서 "ARCHITECTURE.md 항목 채우기" 언급 |
| Q13 자유 응답 | (env 미매핑) | render 무관 — INTERVIEW.md + CLAUDE.override.md 흡수. 빈 응답 시 override.md 미생성 | — |

### 3.3. tmpl 변수 매핑 — 파일별 분리 (S5/S7/S8, v1.10b)

#### v1.10 정의 (변수 16)

| Tmpl marker | env source | Fallback |
|---|---|---|
| `{{name}}` | `HM_NAME` | (코어, 필수) |
| `{{language}}` | `HM_LANGUAGE` | (코어, 필수) |
| `{{runtime_version}}` | `HM_RUNTIME_VERSION` | (코어, 필수) |
| `{{package_manager}}` | `HM_PACKAGE_MANAGER` | (코어, 필수) |
| `{{code_dir}}` | `HM_CODE_DIR` | `scripts/harness` |
| `{{phases_dir}}` | `HM_PHASES_DIR` | `phases` |
| `{{meta_ref}}` | `HM_META_REF` | `projects/{{name}}/ARCHITECTURE.md` |
| `{{guardrails_path}}` | `HM_GUARDRAILS` | `docs/GUARDRAILS.md` |
| `{{locale}}` | `HM_LOCALE` | `en` |
| `{{test_cmd}}` | `HM_TEST_CMD` | `(미설정)` |
| `{{lint_cmd}}` | `HM_LINT_CMD` | `(미설정)` |
| `{{format_cmd}}` | `HM_FORMAT_CMD` | `(미설정)` |
| `{{type_check_cmd}}` | `HM_TYPE_CHECK_CMD` | `(미설정)` |
| `{{q11_observability}}` | (Q11 자유 응답) | `(미설정)` |
| `{{q12_ci}}` | (Q12 자유 응답) | `(미설정)` |
| `{{date}}` | `$(date +%Y-%m-%d)` | (자동) |

#### v1.10b 신규 (변수 3)

| Tmpl marker | env source | Fallback |
|---|---|---|
| `{{bootstrap_version}}` | (Bootstrap 시점 자동 stamp) | `1.10e3` (v1.10e3에서 stamp 갱신) |
| `{{q13_claude_specific}}` | (Q13 자유 응답, sanity wrap 후) | `(미설정)` — 빈 응답 시 CLAUDE.override.md 미생성 |
| `{{description}}` | (env 미정의) | placeholder 주석 + fallback 1줄 (sed 변수 아님) |

#### v1.10c 신규 (변수 1)

| Tmpl marker | env source | Fallback |
|---|---|---|
| `{{install_cmd}}` | (Q3 PM 매핑 — interview.md `## install_cmd 매핑` 17 PM 매트릭스 lookup) | `(PM 미감지 — 부트스트랩 후 수동 입력)` placeholder 텍스트 — unknown PM 시 빈 백틱 회피 |

#### v1.10e/e2/e3 (변수 1, 4-tier 감지) + v1.10h (3-way 분기)

| Tmpl marker | env source | Fallback |
|---|---|---|
| `{{license}}` | **v1.10h 3-way** (Claude 치환): `HM_LICENSE` + `HM_LICENSE_FILE` (둘 다 detect-project.sh) → Case 1: license + file → `<id> (see [<file>](<file>))` / Case 2: license only (T3) → `<id>` / Case 3: empty 또는 MAX_LENGTH > 80 → `see LICENSE.` (v1.10b 텍스트 유지) | `see LICENSE.` |

**v1.10h 추가 env (tmpl marker 아님 — Claude 치환 logic only)**:
- `HM_LICENSE_FILE` — `detect-project.sh` `license_file = "..."` 출력. T1/T2/T2-Multi/T2.5 매칭 시 actual LICENSE file relative path (`LICENSE`/`LICENSE.md`/`COPYING`/`LICENSES/CUSTOM` 등). T3 only 또는 미매칭 시 empty. Case 1 link 구성용

**v1.10h MAX_LENGTH=80**:
- SPDX longest single ID ~47자 + compound expression ~50자 → 80자 = safe margin (false positive 0)
- 80자 초과 시 Case 3 fallback (Anthropic EULA abuse 차단)
- 정규화 (e.g., `Apache 2.0` → `Apache-2.0`)는 v1.10i+ scope (evidence-driven)

**v1.10e3 — T1 + T2 + T3 채택** (audit `sessions/meta/v1.10e3-license-metadata/audit/A1-A5`):
- T1 (v1.10e): SPDX-License-Identifier 헤더, head -10
- T2-Multi (v1.10e2): multi-file dual-license (LICENSE-MIT + LICENSE-APACHE → `MIT OR Apache-2.0`)
- T2 (v1.10e2): boilerplate 12 패턴 head -30 매칭. GPL family or-later/only suffix 본문 grep
- T2.5 (v1.10e3): Cargo `[package].license-file = "<path>"` 사용자 정의 LICENSE 경로 → license_path 보강 후 T1/T2 재시도
- T3 (v1.10e3): 메타데이터 4 source — pyproject (PEP 639 modern → PEP 621 inline `{text}` → `{file}` 1회 재귀 → poetry) → npm package.json (string + legacy object `type` 필드 부분 지원 + UNLICENSED → `LicenseRef-UNLICENSED` + SEE LICENSE IN 1회 재귀) → Cargo `[package].license`
- LICENSE 콘텐츠 우선 (T1/T2 매칭 시 T3 skip — audit/A5 §1)
- Recovery rate: 0% (T1) → 70% (T1+T2 sample 20) → **OSS 100% (T1+T2+T3 sample 30)**. False positive 0
- 매칭 우선순위: longest-marker first (AGPL → LGPL → GPL / BSD-3 → BSD-2 / ISC → MIT). T2.5 → T3는 LICENSE 콘텐츠 미매칭 후 진입
- 보안: `_sanitize_path` — `..` / 절대경로 / null byte / 1KB 초과 거부. 1회 재귀만 (depth bomb 차단)

⚠️ Round-trip 한계: bootstrap 1회성 — LICENSE 또는 메타 변경 후 AGENTS.md L5 수동 갱신 필요. boilerplate / 메타 stamp 의도와 다르면 SPDX 헤더 추가 권장 (T1 우선 매칭). **v1.10h 해소**: T3 매칭 시 LICENSE 파일 부재 → Case 2 link 생략으로 broken anchor 회피.

#### 파일별 변수 카운트 (v1.10b)

| 파일 | sed 변수 | 비고 |
|---|:---:|---|
| `AGENTS.md.tmpl` (v1.10b 신규, v1.10c install_cmd 추가, v1.10e license 추가) | **15** sed + 1 placeholder | name / language / runtime_version / package_manager / code_dir / phases_dir / locale / test_cmd / lint_cmd / format_cmd / type_check_cmd / build_cmd / bootstrap_version / install_cmd / **license (v1.10e 신규, v1.10h 3-way + MAX_LENGTH=80)** (description은 placeholder 주석). **L5 `See [README.md](README.md) for project overview` 제거는 v1.10h2 분리** |
| `CLAUDE.md.tmpl` (v1.10b 재작성) | **1** | name |
| `CLAUDE.override.md.tmpl` (v1.10b 신규) | **2** | name / q13_claude_specific |
| `skeletons/projects/*.md` (v1.10) | 15+ | (v1.10 정의) |
| `skeletons/sessions/v0.1-bootstrap/*.md` (v1.10) | 4 | name / phases_dir / code_dir / date |

**치환 방식**: Claude가 Read tmpl → 답변 기반 텍스트 치환 → Write 결과 파일. bash sed helper 별도 작성 안 함.

**Claude Code @import 제약 (context7 검증)**: max depth 5 hops. CLAUDE.md.tmpl 3 import (`@AGENTS.md` + `@ARCHITECTURE.md` + `@CLAUDE.override.md`) 모두 자체 import 미보유 → depth 1 (여유). 미래 skeleton 추가 시 이 제약 검증.

**install_cmd 17 PM 매핑 매트릭스**: `bootstrap/interview.md`의 `## install_cmd 매핑 (자동 적용, 17 PM)` § 단일 소스 참조. Claude(Bootstrap)가 Q3 답변 후 본 매트릭스를 lookup해 `HM_INSTALL_CMD` env 도출.

## 4. Stage 실패/abort 정책

| Stage | 실패 사례 | 정책 |
|------|-----------|------|
| S0 | 진입 조건 위배 (manifest 또는 projects/<name>/ 존재) | abort + Idempotency §5 분기로 |
| S1 | detect unknown 출력 | unknown으로 진행, Q2/Q3 사용자 manual 입력 강제 |
| S2 | 사용자 abort (코어 빈/skip 3회) | 0 영향 (아직 파일 미작성). manifest 미작성 |
| S3 | render 실패 (escaping 위반 exit 2 / bash 3 exit 3 / required missing exit 1) | 사용자 재입력 요구. 3회 시도 후 abort |
| S3 | round-trip 실패 (grep+sed가 name/code_dir/phases_dir 추출 못함) | 작성된 manifest를 backup (`.harness/backups/manifest.<ts>.toml`) 후 재시도 안내 |
| S4 | 부수 자산 작성 실패 (CLAUDE.md/GUARDRAILS/.gitkeep) | manifest 보존, 사용자 수동 작성 안내 |
| S5 | install-project-claude 실패 (충돌 backup, 권한 오류 등) | manifest+부수 자산 그대로, 사용자에게 `-Force` 또는 conflicts 수동 해결 후 재실행 안내 |
| S6 | 작성 실패 | 사용자 수동 작성 안내 (manifest+`.claude/`는 보존, 프로젝트는 작동 가능 상태) |
| S7 | (사용자 행동 항목 출력만) | 실패 분기 없음 |

## 5. Idempotency

재실행 시 `.harness.toml` 존재하면 **abort + Claude가 사용자에게 명시 확인**:

```
"기존 .harness.toml 발견. backup 후 재진행할까요? (yes/no)"
```

- **yes**: `<proj>/.harness.toml` → `<proj>/.harness/backups/manifest.<YYYYMMDD-HHMMSS>.toml` 이동
  - `<proj>/.harness/backups/` 디렉토리 자동 생성 (`mkdir -p`)
  - `<proj>/.gitignore`에 `.harness/backups/` 자동 append (없으면 .gitignore 신규 작성). git 추적 오염 방지
  - 같은 Claude 대화 내 인터뷰 재진입 (S2부터). **슬래시 명령 재호출 아님**
- **no**: abort. 0 영향

**v1.10b 추가 — 다른 산출물 충돌 처리 (M4 backup 일원화)**:
- 기존 `<proj>/AGENTS.md` 존재 → `<proj>/.harness/backups/AGENTS.md.<YYYYMMDD-HHMMSS>` (manifest와 동일 디렉토리)
- 기존 `<proj>/CLAUDE.override.md` 존재 → `<proj>/.harness/backups/CLAUDE.override.md.<YYYYMMDD-HHMMSS>`
- 기존 `<proj>/CLAUDE.md` 충돌 → CLAUDE.md baseline 3분기 (G19): (i) 부재→tmpl 신규 / (ii) 존재+`@AGENTS.md` import 부재→append 사용자 확인 / (iii) 존재+import 있음→no-op (덮어쓰기 안 함, 사용자 직접 편집 보존)

`<proj>/projects/<name>/` 존재 (harness-meta repo 측)에 대해서는 별도 분기 — 사용자에게 "이미 부트스트랩됨. 재부트스트랩하려면 `v0.2-rebootstrap` 별도 세션" 안내.

`--force` 같은 flag는 없음 — 모두 대화 분기로 처리.

## 6. Cross-platform OS 분기 (S6 install-project-claude 호출)

```bash
case "$(uname -s 2>/dev/null || echo Windows)" in
    MINGW*|MSYS*|CYGWIN*|Windows)
        pwsh "$HARNESS_META_ROOT/bootstrap/install-project-claude.ps1" -ProjectRoot "$PWD"
        ;;
    Darwin|Linux|*)
        bash "$HARNESS_META_ROOT/bootstrap/install-project-claude.sh" "$PWD"
        ;;
esac
```

Claude는 Bash tool로 `uname -s` 실행 후 분기 명령 호출. Git Bash on Windows의 `uname -s`는 `MINGW*` 출력 → 첫 분기 매치.

`pwsh` 부재 시(Windows에 PowerShell 7 미설치) — 사용자에게 `pwsh` 설치 안내 또는 `powershell.exe` fallback 검토.

## 7. 로깅

- 인터뷰 진행 중 답변 (Q1~Q12 + 자유 응답) → Claude 메모리 (대화 컨텍스트)
- manifest 작성 후 → `~/harness-meta/projects/<name>/INTERVIEW.md`에 영구 기록 (12 Q + 자유 응답 그대로)
- 세션 진행 → `~/harness-meta/sessions/<name>/v0.1-bootstrap/{PLAN,REPORT}.md`

INTERVIEW.md는 audit trail. 향후 ARCHITECTURE/STACK 업데이트 시 근거 자료.

## 8. CRLF / 라인 종결 주의

`render-manifest.sh` / `tests/smoke-bootstrap-render.sh` / 추후 추가되는 모든 .sh는 **LF 라인 종결 필수**. CRLF로 commit되면 Git Bash / Linux / macOS에서 `$'\r': command not found` 오류.

`.gitattributes`에 `*.sh text eol=lf` 명시 (이미 있으면 확인). 신규 .sh 파일 작성 시 LF 저장 검증.

## 9. 관련 문서

- 인터뷰 질문지: [`../interview.md`](../interview.md)
- 매니페스트 스펙: [`../manifest-schema.md`](../manifest-schema.md)
- 감지 규칙: [`DETECTION.md`](DETECTION.md)
- 세션 소속: [`OWNERSHIP.md`](OWNERSHIP.md)
- AGENTS.md 표준: [`AGENTS_MD_STRATEGY.md`](AGENTS_MD_STRATEGY.md)
- 본 흐름 확정 세션: [`../../sessions/meta/v1.10-bootstrap-interview/`](../../sessions/meta/v1.10-bootstrap-interview/)
