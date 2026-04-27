# Bootstrap Interview — `/harness-meta <new-name>` 흐름의 Stage S2

본 파일은 **Claude가 따라가는 인터뷰 질문지**. `/harness-meta <new-name>` Bootstrap 모드 진입 시 Claude는 본 파일의 Q1~Q13 + 자동 적용 6건(manifest 4 + AGENTS.md 콘텐츠 2: bootstrap_version + install_cmd)을 사용해 신규 프로젝트의 `.harness.toml` v1.1 + 부수 자산을 생성한다.

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

### AGENTS.md 콘텐츠 자동 적용 (3건, v1.10b + v1.10c + v1.10e)

- `{{bootstrap_version}}` stamp (v1.10b — 현 시점 `1.10e`)
- `{{install_cmd}}` PM 매핑 (v1.10c — 17 PM 매트릭스, 아래 § 참조)
- `{{license}}` SPDX 헤더 감지 (v1.10e — T1 only, 아래 § 참조)

### License 처리 (자동 적용 — v1.10e SPDX 헤더 감지, T1 only)

LICENSE 파일에 `SPDX-License-Identifier: <id>` 헤더 존재 시 detect-project.sh가 자동 추출 → AGENTS.md.tmpl `{{license}}` 치환. 미식별 시 fallback `see LICENSE.` (v1.10b 텍스트 그대로).

**감지 알고리즘 (T1, Option C)**:
- LICENSE 파일명 4 우선순위: `LICENSE` → `LICENSE.md` → `LICENSE.txt` → `COPYING` (case-insensitive)
- 첫 10 라인에서 `^SPDX-License-Identifier:` grep
- 매칭 시 stdout `license = "<id>"` emit. SPDX expression dual-license (`MIT OR Apache-2.0`) 보존
- 미식별 시 emit 안 함 (T3 fallback)

**Bootstrap 치환 로직** (Claude):
```
HM_LICENSE = (detect-project.sh stdout에서 license = "..." grep 추출)
if HM_LICENSE non-empty:
    L5 = "License: $HM_LICENSE (see [LICENSE](LICENSE))"
else:
    L5 = "License: see LICENSE."  # fallback (v1.10b 텍스트)
```

**v1.10c observation vs injection 정합성**: v1.10c가 거부한 default `MIT` 강제 stamp (injection)와 본 v1.10e의 SPDX 헤더 추출 (observation)은 본질이 다름. 사용자 명시 의도 (LICENSE + SPDX 헤더)만 반영. 거부 3 이유 모두 무력화 (audit/A5 참조).

**Round-trip 한계**: bootstrap 1회성 — LICENSE 변경 후 AGENTS.md 수동 갱신 필요.

**후속 분기**:
- T2 boilerplate 9 패턴 매칭 (MIT/Apache/GPL/BSD/ISC/MPL/Unlicense) → **v1.10e2** (sample 추출률 50%+ 잠재)
- 메타데이터 license 필드 (npm/pyproject/Cargo) → **v1.10e3**
- Multi-file dual-license (LICENSE-MIT + LICENSE-APACHE) → **v1.10e2**

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
