# Bootstrap Interview — `/harness-meta <new-name>` 흐름의 Stage S2

본 파일은 **Claude가 따라가는 인터뷰 질문지**. `/harness-meta <new-name>` Bootstrap 모드 진입 시 Claude는 본 파일의 Q1~Q13 + 자동 적용 7건(manifest 4 + AGENTS.md 콘텐츠 3: bootstrap_version + install_cmd + license — v1.10e3 4-tier)을 사용해 신규 프로젝트의 `.harness.toml` v1.1 + 부수 자산을 생성한다.

흐름 전체(10-stage)는 [`docs/INTERVIEW_FLOW.md`](docs/INTERVIEW_FLOW.md) 참조.

## 사전 조건 (Stage S0~S1)

1. **Bootstrap 모드 진입 조건**: 대상 프로젝트 루트에 `.harness.toml` 부재 + `~/harness-meta/projects/<name>/` 부재
2. **detect-project.sh 실행** (Stage S1):
   ```bash
   DETECT_OUT=$(bash $HARNESS_META_ROOT/bootstrap/detect-project.sh "$PROJECT_ROOT")
   ```
   stdout 캡처 후 line별 grep으로 default 추출:
   ```bash
   detected_lang=$(echo "$DETECT_OUT" | grep -E '^language = "' | sed -E 's/.*"([^"]+)".*/\1/')
   detected_pm=$(echo   "$DETECT_OUT" | grep -E '^package_manager = "' | sed -E 's/.*"([^"]+)".*/\1/')
   detected_test_cmd=$(echo   "$DETECT_OUT" | grep -E '^test_cmd = "' | sed -E 's/.*"([^"]+)".*/\1/')
   detected_lint_cmd=$(echo   "$DETECT_OUT" | grep -E '^lint_cmd = "' | sed -E 's/.*"([^"]+)".*/\1/')
   detected_format_cmd=$(echo "$DETECT_OUT" | grep -E '^format_cmd = "' | sed -E 's/.*"([^"]+)".*/\1/')
   ```

## 코어 질문 (7) — 모두 필수, manifest 핵심 필드

| # | 키 | 질문 | Default |
|---|----|----|---------|
| Q1 | `[project].name` | 프로젝트 이름? (식별자, 디렉토리명 권장) | CWD basename |
| Q2 | `[project].language` | 주 언어? | `$detected_lang` (unknown 시 manual) |
| Q3 | `[project].package_manager` | 패키지매니저? | `$detected_pm` (unknown 시 manual) |
| Q4 | `[project].runtime_version` | 런타임 버전? (예: Python "3.12", Node "20.x", Go "1.22"). 모르면 `python --version` / `node --version` 출력값 사용. 정말 모르면 `unknown` (manifest에 그대로 기록, 사용자 후속 갱신) | (감지 안 함, 사용자 입력) |
| Q5 | `[harness].code_dir` | 하네스 코드 디렉토리? | `scripts/harness` |
| Q6 | `[harness].phases_dir` | phases 디렉토리? | `phases` |
| Q7 | `[architecture].meta_ref` | harness-meta 내부 경로? | `projects/{Q1}/ARCHITECTURE.md` |

## 옵션 manifest-매핑 질문 (3) — skip 시 default 적용 또는 omit

| # | 키 | 질문 | Default | Skip 시 |
|---|----|----|---------|--------|
| Q8 | `[harness].guardrails` | GUARDRAILS.md 경로? | `docs/GUARDRAILS.md` (placeholder 자동 생성) | omit |
| Q9 | `[project].locale` | 작업 언어? (en/ko/ja/zh/...) | `en` (schema §6.2 default) — 한국어 사용자는 명시 입력 | "en" 채택 |
| Q10 | `[testing]` 4건 | 테스트 명령? (test/lint/format은 detect default. type_check_cmd는 사용자 입력) | test=`$detected_test_cmd` / lint=`$detected_lint_cmd` / format=`$detected_format_cmd` / type_check=사용자 (예: `uv run mypy src`, `pnpm tsc --noEmit`) | type_check_cmd 빈 응답 시 omit. 그 외 default 채택 |

## 자유 응답 질문 (3) — manifest 매핑 없음, INTERVIEW.md/STACK.md/ARCHITECTURE.md 영구 기록 (v1.10b — Q13 신규 추가)

| # | 매핑 | 질문 |
|---|----|----|
| Q11 | INTERVIEW.md + STACK.md 관측 표 + ARCHITECTURE.md §3 | 관측·트레이싱 스택? (메트릭/로그/트레이스 도구) |
| Q12 | INTERVIEW.md + STACK.md CI 절 + ARCHITECTURE.md §4 | CI/CD 인프라? (GitHub Actions/GitLab/Jenkins/없음) |
| **Q13** (v1.10b 신규) | INTERVIEW.md + CLAUDE.override.md (옵션, 응답 시만 생성) | Claude Code 전용 지시? (subagent / skill / thinking 등). skip 가능. 빈 응답 시 CLAUDE.override.md 미생성 + CLAUDE.md `@CLAUDE.override.md` import 라인 미추가 |

**Q13 sanity 검증** (v1.10b — markdown injection 방지): Claude(Bootstrap)가 응답을 trim → 메타 문자 (`@`, `{{`, `}}`, `<!--`, `<script`) 검출 → 발견 시 fenced code block (\`\`\`text...\`\`\`) 안에 강제 wrap → CLAUDE.override.md.tmpl `{{q13_claude_specific}}` 위치에 삽입.

**Q13 빈 응답 처리**: trim 후 빈 문자열 / "skip" / "-" / "(미설정)" 중 하나면 → CLAUDE.override.md 파일 + CLAUDE.md import 라인 둘 다 미생성 (안전 분기).

**총 13 질문 = 코어 7 (manifest 필수) + 옵션 manifest 3 (Q8/9/10) + 자유 응답 3 (Q11/Q12/Q13)** (v1.10b).

## Q&A UX 시퀀스

- **Claude는 한 번에 13 질문을 표시** (각 질문 옆에 default 명시) — 13 turn 회피
- 사용자는 한 번에 답변 (빈 항목 = default 채택). 부분 수정 원하면 follow-up
- 답변 수신 후 Claude가 **미리보기 manifest를 사용자에게 표시** (render-manifest.sh stdout) → 최종 확정

## 자동 적용 (질문 없음, 7건 — manifest 4 + 콘텐츠 3)

### Manifest 자동 적용 (4건, v1.0~)

- `schema_version = "1.1"`
- `[harness].mcp_server = "harness"` (단일 default)
- `[agents].primary = "claude-code"` (현재 단일 adapter — v1.5 규약 §6 시나리오 A)
- 컴파일 언어(rust/go/java/csharp)면 `[build]` 섹션 자동 포함:
  - rust → `tool="cargo"`, `build_cmd="cargo build --release"`, `artifact_dir="target/release"`
  - go → `tool="go"`, `build_cmd="go build ./..."`, `artifact_dir="bin"`
  - java/gradle → `tool="gradle"`, `build_cmd="./gradlew build"`, `artifact_dir="build/libs"`
  - csharp → `tool="dotnet"`, `build_cmd="dotnet build -c Release"`, `artifact_dir="bin/Release"`

### AGENTS.md 콘텐츠 자동 적용 (3건, v1.10b + v1.10c + v1.10e/e2/e3)

- `{{bootstrap_version}}` stamp (v1.10b — 현 시점 `1.10e3`)
- `{{install_cmd}}` PM 매핑 (v1.10c — 17 PM 매트릭스, 아래 § 참조)
- `{{license}}` 4-tier 감지 (v1.10e T1 SPDX + v1.10e2 T2-Multi + T2 boilerplate + **v1.10e3 T3 메타** 4 source, 아래 § 참조)

### License 처리 (자동 적용 — v1.10e3 4-tier 감지: T1 SPDX + T2-Multi + T2 boilerplate + T3 메타)

LICENSE 파일 + 메타데이터 검사 후 detect-project.sh가 자동 추출 → AGENTS.md.tmpl `{{license}}` 치환. 미식별 시 fallback `see LICENSE.` (v1.10b 텍스트 그대로).

**감지 알고리즘 — 4-tier 우선순위** (audit `sessions/meta/v1.10e3-license-metadata/audit/A1-A5`):

1. **T1 — SPDX-License-Identifier 헤더 (v1.10e)** — `LICENSE` → `LICENSE.md` → `LICENSE.txt` → `COPYING` (case-insensitive) 4 우선순위. 첫 10 라인 `^SPDX-License-Identifier:` grep. SPDX expression (`MIT OR Apache-2.0`) 보존. **매칭 시 T2/T3 skip**
2. **T2-Multi — Multi-file dual-license (v1.10e2)** — `LICENSE-MIT` + `LICENSE-APACHE` 등 2건 이상 detect 시 SPDX expression `<id1> OR <id2>` 자동 stamp (Rust 컨벤션). 매트릭스: MIT / Apache / BSD / ISC / MPL. backup suffix (`.bak`/`.draft`/`.tmp`/`.orig`/`.swp`) 제외
3. **T2 — Boilerplate 12 패턴 (v1.10e2)** — single LICENSE 파일 head -30 grep:
   - **MIT** / **Apache-2.0** / **GPL-2.0** / **GPL-3.0** / **AGPL-3.0** / **LGPL-2.1** / **LGPL-3.0** / **BSD-2-Clause** / **BSD-3-Clause** / **ISC** / **MPL-2.0** / **Unlicense**
   - GPL family는 본문 `any later version` grep → `-or-later` / 없으면 `-only` suffix
   - Header signal + body signal 2-신호 매칭 (false positive 0/20 sample)
   - Notion edge (header 부재 MIT) — body `Permission... free of charge` + `Copyright (c)` fallback
4. **T2.5 — Cargo license-file 보강 (v1.10e3)** — `Cargo.toml [package].license-file = "<path>"` 사용자 정의 LICENSE 경로 → license_path 보강 후 T1/T2 재시도. 표준 4 파일 (LICENSE/LICENSE.md/LICENSE.txt/COPYING) 외 위치 처리
5. **T3 — 메타데이터 4 source (v1.10e3)** — LICENSE 콘텐츠 미매칭 시만 진입 (audit/A5 LICENSE 우선 정책). 우선순위:
   - **M2** `pyproject.toml [project].license = "<SPDX>"` (PEP 639 modern, Final 2024-05)
   - **M2-legacy** `pyproject.toml [project].license = {text = "..."}` (PEP 621 deprecated, single-line only)
   - **M2-file** `pyproject.toml [project].license = {file = "<path>"}` → 1회 재귀 (T1/T2)
   - **M3** `pyproject.toml [tool.poetry].license = "..."` (Poetry deprecated)
   - **M1** `package.json "license": "..."` (string 또는 legacy `{type, url}` object — `type` 필드 부분 지원)
   - **M4** `Cargo.toml [package].license = "..."` (SPDX 2.3 expression — `MIT OR Apache-2.0` 보존)
   - **UNLICENSED 정규화**: npm `"UNLICENSED"` → SPDX 표준 `LicenseRef-UNLICENSED` (audit/A4 R4)
   - **SEE LICENSE IN <file>**: 1회 재귀 (T1 → T2). path traversal (`..` / 절대경로 / null byte) 거부 (audit/A4 R5)
6. **T4 — Fallback** — T1+T2+T2.5+T3 모두 미식별 → output 없음 + S3 preview WARN. AGENTS.md L5 fallback `see LICENSE.`

**Match priority** (longest-marker first — audit/A4 R5):
```
T1 (SPDX) → T2-Multi → AGPL-3 → LGPL-3 → LGPL-2.1 → GPL-3 → GPL-2
         → Apache-2.0 → MPL-2.0 → Unlicense → BSD-3 → BSD-2 → ISC → MIT → MIT-no-header
         → T2.5 (Cargo license-file) → T3 (M2 → M2-legacy → M2-file → M3 → M1 → M4)
         → T4 (silent)
```

**Bootstrap 치환 로직** (Claude — v1.10h 3-way + MAX_LENGTH=80):
```
HM_LICENSE      = (detect-project.sh stdout에서 license = "..." grep 추출)
HM_LICENSE_FILE = (detect-project.sh stdout에서 license_file = "..." grep 추출 — v1.10h 신규)

# non-SPDX MAX_LENGTH=80 (Anthropic EULA abuse 차단)
if len(HM_LICENSE) > 80:
    HM_LICENSE = ""   # → Case 3 fallback

# 3-way 분기
if HM_LICENSE and HM_LICENSE_FILE:        # Case 1: T1/T2/T2.5 — license + LICENSE 파일 존재
    {{license}} = f"{HM_LICENSE} (see [{HM_LICENSE_FILE}]({HM_LICENSE_FILE}))"
elif HM_LICENSE:                          # Case 2: T3 only — license, LICENSE 파일 부재 (link 생략)
    {{license}} = HM_LICENSE
else:                                     # Case 3: 완전 fallback (v1.10b 텍스트 유지)
    {{license}} = "see LICENSE."
```

**3 케이스 렌더링 표** (v1.10h):

| Case | 조건 | `{{license}}` 치환 | 비고 |
|------|------|------|------|
| 1 | `HM_LICENSE` + `HM_LICENSE_FILE` (T1/T2/T2-Multi/T2.5) | `MIT (see [LICENSE](LICENSE))` (또는 `LICENSE.md`/`COPYING`/`LICENSES/CUSTOM` 등 actual filename) | sub-item 1 정상 — link valid |
| 2 | `HM_LICENSE` only (T3 메타 only) | `MIT` | sub-item 1 해소 — link 생략 (LICENSE 부재) |
| 3 | empty (T4 fallback 또는 MAX_LENGTH 초과) | `see LICENSE.` | 기존 v1.10b 텍스트 유지 |

**MAX_LENGTH=80 정당화** (v1.10h sub-item 2):
- SPDX longest single ID: `LicenseRef-scancode-polyform-noncommercial-1.0.0` (~47자)
- Compound expression: `MIT AND Apache-2.0 WITH Bootloader-exception` (~45자)
- Triple compound: `(MIT AND Apache-2.0) OR (BSD-3-Clause AND ISC)` (~50자)
- Practical SPDX upper bound: ~70자 → **80자 = safe margin** (false positive 0)
- 80자 초과: 사실상 EULA 본문 abuse → fallback `see LICENSE.`

**HM_LICENSE_FILE relative path semantics** (v1.10h R1):
- `LICENSE` (표준) — 대부분
- `LICENSE.md`, `LICENSE.txt`, `COPYING` (변형) — case-insensitive 4 우선순위
- `LICENSES/CUSTOM-LICENSE` (Cargo subdirectory `[package].license-file`) — fringe but supported
- relative path 채택 → 실제 파일명으로 link → broken anchor 회피

⚠️ **알려진 한계 (v1.10h scope 외)**:
- **Issue B** — T1/T2 fail + T3 hit + LICENSE 파일 존재 시: link valid (file 존재) 하지만 메타 SPDX vs 파일 콘텐츠 mismatch 가능. discrepancy WARN은 v1.10i+ scope (현 evidence 0)
- **Case 3 enhancement** — license empty + file 존재 시 actual filename으로 link 가능하나 본 v1.10h scope 외 (v1.10i+ evidence-driven)

**v1.10c observation 정합성** (audit/A5): v1.10e3의 T3 메타 매칭도 observation 본질 — 사용자 메타데이터 read만 (default stamp 강제 없음). 4 source (npm + PEP 621/639 + Poetry + Cargo) 모두 정식 spec 표준. v1.10c 거부 3 이유 (spec 위반 / 의도 위배 / 권위 도구 불일치) 모두 무력화. 권위 도구 (npm registry / crates.io / PyPI / Linguist) 모두 메타데이터 license 필드 read.

**LICENSE 콘텐츠 vs 메타 우선순위** (audit/A5 §1 G1 결정): T1/T2 매칭 시 T3 skip. LICENSE 부재 시만 T3 진입. 근거: (1) LICENSE 파일 = strong declaration / (2) Linguist 동일 전략 / (3) sample evidence 의미 정확도 4/4 vs 2/4 (메타 비표준 form `"Apache 2.0"` 공백 등 false negative 회피).

**Recovery rate** (audit/A2):
- v1.10e (T1 only sample 20): 0/20 (0%)
- v1.10e2 (T1+T2 sample 20): 14/20 (70%) — false positive 0
- **v1.10e3 (T1+T2+T3 sample 30)**: **OSS 16/16 (100%)** — LICENSE 부재 + 메타 only 시나리오 100% 회복 (#21 #23 #24)
- 알려진 한계: PortableGit `or-later` 의미 conflict (T1/T2/T3 모두 추출 불가, 사용자 SPDX 헤더 권장) + non-SPDX 메타 보존 (Anthropic long EULA / Oracle `"Apache 2.0"` 공백 → 그대로 stamp, observation only)

**Round-trip 한계**: bootstrap 1회성 — LICENSE 또는 메타 변경 후 AGENTS.md L5 수동 갱신 필요. boilerplate stamp 또는 메타 stamp가 의도와 다르면 SPDX 헤더 (`SPDX-License-Identifier: <id>`) 추가 권장 (T1 우선 매칭).

**보안** (audit/A3 §9): SEE LICENSE IN / pyproject `{file}` 재귀 시 `_sanitize_path` 검증 — `..` / 절대경로 / null byte / 1KB 초과 거부. 1회 재귀만 (depth bomb 차단).

**후속 분기**:
- ~~agents.md L5 license 라인 자체 정책 (LICENSE 부재 시 라인 형식, non-SPDX 메타 truncate, 검증) → **v1.10h**~~ ← **v1.10h에서 sub-item 1 (LICENSE 부재 link) + sub-item 2 (MAX_LENGTH=80) + sub-item 3 (Smoke) 해소**. L5 `See [README.md]...` 정리는 **v1.10h2** 분리, Issue B/Case 3/정규화는 **v1.10i+** 이연
- 복잡 SPDX expression 검증 / monorepo recursive / dynamic license / npm `licenses` legacy array → 별도 후속 (evidence-driven)

## install_cmd 매핑 (자동 적용, 17 PM)

Q3(`[project].package_manager`) 확정 후 Claude(Bootstrap)가 본 표를 lookup해 `HM_INSTALL_CMD` env 도출. AGENTS.md.tmpl `{{install_cmd}}` 치환.

| Family | PM (Q3) | install_cmd | 비고 |
|--------|---------|-------------|------|
| Python | uv | `uv sync` | pyproject + uv.lock. lockfile 부재 시 첫 호출이 lockfile 생성 + install (정상) |
| Python | poetry | `poetry install` | pyproject + poetry.lock |
| Python | pdm | `pdm install` | pdm.lock |
| Python | rye | `rye sync` | rye.lock |
| Python | hatch | `hatch env create` | hatch.toml — 환경 생성 시 의존성 install 동시 수행 |
| Python | pip | `pip install -e .` | **PEP 517 modern**. legacy `requirements.txt` 프로젝트는 부트스트랩 후 `pip install -r requirements.txt`로 수동 변경 |
| Node | pnpm | `pnpm install` | pnpm-lock.yaml |
| Node | bun | `bun install` | bun.lockb |
| Node | yarn | `yarn install` | yarn.lock |
| Node | npm | `npm install` | package-lock.json. CI deterministic 원하면 부트스트랩 후 `npm ci`로 수동 변경 (lockfile 전제) |
| Go | go-mod | `go mod download` | go.mod — 명시적 module cache 다운로드 |
| Rust | cargo | `cargo fetch` | Cargo.toml — **build_cmd `cargo build --release`와 분리**. 사용자 dev에서 `cargo build`/`cargo run`이 자동 fetch + build 수행 (실용 분리는 약함, 의미 분리는 정확) |
| JVM | gradle | `./gradlew dependencies --write-locks` | build.gradle / .kts. **Gradle 철학상 별도 install 단계 부재** — 첫 `./gradlew <task>` 시 의존성 자동 fetch. `--write-locks`는 dependency lockfile 사용 시 의존성 해소 + lock 갱신 |
| JVM | maven | `mvn dependency:go-offline` | pom.xml — **Apache 공식 canonical** (plugin/reports 포함). `dependency:resolve`보다 표준 |
| .NET | dotnet | `dotnet restore` | *.csproj / *.sln |
| Ruby | bundler | `bundle install` | Gemfile + Gemfile.lock |
| Elixir | mix | `mix deps.get` | mix.exs + mix.lock |

**Fallback (unknown PM)**: Q3가 위 17 PM 외(예: `unknown` / detect 실패 + 사용자 manual 미입력)면 `HM_INSTALL_CMD="(PM 미감지 — 부트스트랩 후 수동 입력)"`. AGENTS.md.tmpl 치환 후 `` Install deps: `(PM 미감지 — 부트스트랩 후 수동 입력)` ``. 빈 백틱 회피.

**install_cmd vs build_cmd 책임 분리**:
- `install_cmd` = "**의존성 lockfile 동기화**" (lockfile → cache + venv/`node_modules`)
- `build_cmd` = "**컴파일 산출물 생성**" (인터프리터 언어는 보통 미정의; 컴파일 언어만 자동 적용)
- cargo: install=`cargo fetch` / build=`cargo build --release` (분리 의미)
- gradle: install=`./gradlew dependencies --write-locks` / build=`./gradlew build` (분리 의미)

## 명시적 omit (생성 안 함, 7건 — v1.11+ overlay 또는 사용자 후속)

- `[harness].executor`
- `[harness].statusline_cmd` + `statusline_timeout_ms` + `state_file`
- `[testing].harness_test_cmd`
- `[notifications]` 섹션 전체
- `[agents].secondary`
- `[project].python_version` (deprecated v1.0 — v1.1 신규는 `runtime_version`만)

## Q→A 처리 규칙

- **빈 응답(엔터) → default 채택**. detect 결과 또는 추천값 사용
- **"-" 또는 "skip" → 옵션 필드 omit**. 코어 필드는 재질의
- **detect unknown 코어 필드(Q2/Q3)** → **첫 시도부터 사용자 직접 입력** (재시도 카운트 시작점 — detect unknown 자체는 fail 아님)
- **코어 필드 빈 응답/skip 3회 누적** → **abort** (manifest 미작성 → 0 영향)
- **다중 값** → array 필드면 그대로, scalar면 첫 값 + WARN
- **TOML 안전성**: 응답에 `"`, `'`, `\n`, `$`, `\` 포함 시 **재입력 요구**. render-manifest.sh가 5종 거부 (`'` = bash `-c` 명령 주입 차단)

## Stage S3~S10 (인터뷰 종료 후 Claude 동작)

S2 인터뷰 완료 후 답변을 환경변수로 export:

```bash
export HM_NAME="..."
export HM_LANGUAGE="..."
export HM_PACKAGE_MANAGER="..."
export HM_RUNTIME_VERSION="..."
export HM_CODE_DIR="..."
export HM_PHASES_DIR="..."
export HM_META_REF="..."
export HM_GUARDRAILS="..."          # 옵션
export HM_LOCALE="..."              # 옵션, default "en"
export HM_TEST_CMD="..."            # 옵션
export HM_LINT_CMD="..."            # 옵션
export HM_FORMAT_CMD="..."          # 옵션
export HM_TYPE_CHECK_CMD="..."      # 옵션
# 컴파일 언어 시:
export HM_BUILD_TOOL="..."
export HM_BUILD_CMD="..."
export HM_ARTIFACT_DIR="..."
```

이후 stage:
- **S3 render**: `bash $HARNESS_META_ROOT/bootstrap/render-manifest.sh > /tmp/manifest-preview.toml`. 사용자에게 미리보기 표시 → 확정
- **S4 manifest 작성**: `cp /tmp/manifest-preview.toml <proj>/.harness.toml`. round-trip 검증 (`name`/`code_dir`/`phases_dir` 3 필드 grep+sed 추출 일치)
- **S5 부수 자산**: `<proj>/CLAUDE.md` (skeletons/CLAUDE.md.tmpl 치환), `<proj>/{HM_GUARDRAILS}` (skeletons/GUARDRAILS.md.tmpl 치환), `<proj>/{HM_PHASES_DIR}/.gitkeep`. `<proj>/{HM_CODE_DIR}/`는 v1.11+ overlay 또는 사용자 안내 (S10에서)
- **S6 install-project-claude**: OS 분기 후 `.ps1` 또는 `.sh` 호출. 14 파일 배포
- **S7 projects/{name}/**: skeletons/projects/ 4종 치환 후 작성
- **S8 sessions/{name}/v0.1-bootstrap/**: skeletons/sessions/v0.1-bootstrap/ 2종 치환 후 작성
- **S9 README 등록**: `~/harness-meta/README.md`의 프로젝트 섹션에 `<name>` 항목 1줄 Edit
- **S10 후속 안내**: 사용자에게 텍스트 출력 — `/config → Output style → "Harness Engineer"` 선택, GUARDRAILS 도메인 규칙 채움, `{HM_CODE_DIR}/` 하네스 실행기 작성 (v1.11+ overlay)

## 관련 문서

- 흐름 상세: [`docs/INTERVIEW_FLOW.md`](docs/INTERVIEW_FLOW.md)
- 매니페스트 스펙: [`manifest-schema.md`](manifest-schema.md)
- 감지 규칙: [`docs/DETECTION.md`](docs/DETECTION.md)
- 세션 소속: [`docs/OWNERSHIP.md`](docs/OWNERSHIP.md)
- 본 흐름 설계 세션: [`../sessions/meta/v1.10-bootstrap-interview/`](../sessions/meta/v1.10-bootstrap-interview/)
