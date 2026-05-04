# meta v1.10c-bootstrap-content-defaults — PLAN

세션 시작: 2026-04-27 (검증 4개 agent 종합 후 옵션 1 재설계 — License 자동 default 폐기)
직접 선행 세션:

- [`sessions/meta/v1.10b-bootstrap-agents-md/`](../v1.10b-bootstrap-agents-md/REPORT.md) — AGENTS.md baseline 통합 (옵션 B strict, license/install_cmd placeholder 형태로 이연)

목적: v1.10b가 placeholder 형태로 남긴 AGENTS.md.tmpl `Install deps:` 라인을 **17 PM 매핑 자동 변수 치환**으로 전환. License는 agents.md 공식 spec 일관성 + 법적 리스크 회피를 위해 placeholder 유지 (별도 후속 v1.10e로 이연).

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S2(7) — AGENTS.md.tmpl + interview.md + INTERVIEW_FLOW.md + manifest-schema.md + projects/INTERVIEW.md + smoke + 본 세션 PLAN/REPORT. S1a(1) — slash command. S3(2) — CLAUDE.md / README.md. 합 **11/11 meta**.
- **T1 경로 다수결** — meta scope 11/11.
- **T2 스펙 vs 값** — 자동 적용 카운트(5→6) + 17 PM 매핑 매트릭스 정의는 "흐름 스펙". 신규 프로젝트의 AGENTS.md 실 콘텐츠는 별도 `sessions/<name>/v0.1-bootstrap/` (T4).

## 검증 결과 종합 (4 agent — License 자동 default 폐기 결정)

### Critical 발견

1. **License 자동 default 폐기** (Agent 2 + Agent 4-B 중복 신호):
   - agents.md 공식 spec — License는 권장 § 아님. 60,000+ 채택 사례에서 LICENSE 파일 reference가 표준
   - 법적 오인 리스크 — GitHub repo 34%가 license 미선언 (proprietary 의도). MIT 자동 stamp는 Apache/GPL/Proprietary 의도자에게 git log 영구 박힘
   - 권위 도구 — cargo new 의도적 미stamp / npm init ISC RFC 논쟁 中 / poetry init default 없음
   - **결정**: v1.10b placeholder `License: see LICENSE.` 유지. v1.10e-detect-license 후속 분리

2. **PM 매핑 정정 3건** (Agent 1):
   - maven: `mvn dependency:resolve` → `mvn dependency:go-offline` (Apache 공식 canonical, plugin/reports 포함)
   - gradle: `./gradlew dependencies` (진단 task) → `./gradlew dependencies --write-locks` + 비고 (Gradle 철학상 별도 install 부재)
   - pip: `pip install -r requirements.txt` (부재 시 fail) → `pip install -e .` (PEP 517 modern)

3. **manifest-schema.md:437 stale** (Agent 3): 자동 적용 4건 → 6건. 변경 대상 9번째 파일로 추가

### Important 발견

- unknown PM fallback (Agent 4-E2) — 빈 백틱 → placeholder 텍스트
- monorepo / verify.ps1 영향 (Agent 4-A3/E1) — §제외에 명시
- Stage S3 preview deterministic (Agent 4-D1) — INTERVIEW_FLOW.md §2에 literal 표 template 박음 (Claude 출력 확정성)

## 배경

### v1.10b가 남긴 placeholder

```
# AGENTS.md.tmpl L5 (License) — v1.10c는 미터치 (v1.10e+ 이연)
License: see LICENSE. See [README.md](README.md) for project overview (human-readable).

# AGENTS.md.tmpl L12 (Install deps) — v1.10c가 변수화
- Install deps: <see project README, PM-specific> <!-- v1.10c 후속에서 자동 추론 변수로 치환 -->
```

### v1.10b REPORT가 명시한 v1.10c 작업 범위 vs 본 세션 적용

| v1.10b 이연 항목 | v1.10c 처리 |
|---|---|
| license sed `MIT` default | **폐기** — agents.md spec + 법적 리스크. v1.10e-detect-license로 이연 |
| install_cmd 17 PM 매핑 | **본 세션 essential** |
| AGENTS.md.tmpl sed 13 → 15 | **13 → 14** (install_cmd만) |
| 자동 적용 manifest 4 + 콘텐츠 1 → 3 | **manifest 4 + 콘텐츠 2** (bootstrap_version + install_cmd) |
| Stage S3 preview 콘텐츠 default 표 | **INTERVIEW_FLOW.md §2에 literal template** (deterministic 보장) |
| install_cmd vs build_cmd 분리 (cargo) | **본 세션 essential** — 매트릭스에 명시 |

## 목표

- [ ] **`bootstrap/skeletons/AGENTS.md.tmpl` install_cmd 변수화** — L12 `Install deps: <see project README, PM-specific>` → `` Install deps: `{{install_cmd}}` `` (sed 13 → 14). License L5 **무변경** (v1.10b 그대로)
- [ ] **`bootstrap/interview.md` 갱신** — `## 자동 적용` 4건 (manifest) + bootstrap_version (v1.10b 추가) 표기 → **6건** (manifest 4 + 콘텐츠 2: bootstrap_version + install_cmd) + 신규 § `## install_cmd 매핑 (자동 적용, 17 PM)` 표 추가
- [ ] **`bootstrap/docs/INTERVIEW_FLOW.md` 갱신** — §3.3 v1.10c 신규 변수 표 추가 (install_cmd만) + 파일별 변수 카운트 13 → 14 + §2 Stage S3 description에 **literal 표 template 박아넣기** (Claude가 그대로 복사 출력) + 17 PM cross-link
- [ ] **`bootstrap/manifest-schema.md` 갱신** — L437 자동 적용 4건 → 6건 (Agent 3 발견 stale)
- [ ] **`bootstrap/skeletons/projects/INTERVIEW.md` 갱신** — `## 자동 적용 (질문 없음, 5건)` → `6건` + install_cmd 항목 추가
- [ ] **`claude/commands/harness-meta.md` 갱신** — S2 행 `자동 5` → `자동 6 (manifest 4 + 콘텐츠 2: bootstrap_version + install_cmd PM 매핑, v1.10c)`
- [ ] **`tests/smoke-bootstrap-agents-md.sh` 갱신** — Stage 2 변수 13 → 14 (`{{install_cmd}}` 추가) / Stage 4 mock에 install_cmd=`uv sync` 추가 + 검증 / Stage 2 install_cmd placeholder grep 제거. License 검증은 그대로 유지 (v1.10b placeholder)
- [ ] **`CLAUDE.md` / `README.md` 갱신** — 최신 meta 세션 v1.10b → v1.10c + 자동 적용 카운트 6 명시
- [ ] **smoke 6 stage PASS** + `evidence/smoke-bootstrap-content-defaults.txt`
- [ ] **REPORT.md** 작성
- [ ] **사용자 확인 후 단일 커밋** + push

## 범위

**포함** (v1.10c essential):

- AGENTS.md.tmpl L12 placeholder → `{{install_cmd}}` sed 변수 (sed 13 → 14)
- 17 PM → install_cmd 매핑 매트릭스 (interview.md 단일 소스)
- 자동 적용 5 → 6 (콘텐츠 1 → 2 — bootstrap_version + install_cmd)
- install_cmd vs build_cmd 분리 (cargo: install=`cargo fetch` / build=`cargo build --release`)
- 매핑 정확도 향상 (maven `dependency:go-offline` / gradle `--write-locks` / pip `-e .`)
- INTERVIEW_FLOW.md §2 Stage S3 description에 literal 표 template (deterministic)
- v1.10 자산 일관 갱신 (interview.md / INTERVIEW_FLOW.md / manifest-schema.md / projects skeleton / slash command)

**제외** (이연):

- **License `{{license}}` 변수화** — agents.md spec 위배 + 법적 리스크. v1.10e-detect-license 별도 후속 (LICENSE 파일 SPDX 추출 + S3 preview WARN)
- **detect-project.sh 수정** — Claude(Bootstrap)가 interview.md 매핑 매트릭스 lookup. detect.sh 무수정
- **render-manifest.sh 수정** — manifest는 install_cmd 안 다룸. 무수정
- **Stage S3 preview helper script** — Claude 직접 출력 + literal template로 deterministic. 별도 helper 없음 (옵션 B 학습)
- **upbit retroactive** — `sessions/upbit/vX-content-default-update/` 별도 (T4)
- **monorepo install_cmd 분기** — pnpm-workspace / cargo workspace 등 root install_cmd 가정. nested는 v1.23-monorepo-polyglot
- **verify.ps1 A1/A4 drift 적용** — install_cmd 변수 빈 값 시 stale 라인 발생 가능. 본격 적용은 v1.21-cross-platform-install
- **install_cmd 사용자 override Q14** — PM 매핑 자동만. 사용자 override는 부트스트랩 후 AGENTS.md 직접 편집

## 변경 대상

### 신규 (1 세션 디렉토리)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.10c-bootstrap-content-defaults/{PLAN,REPORT,evidence/smoke-bootstrap-content-defaults.txt}.md` | meta | 본 세션 기록 |

### 수정 (9 파일)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/skeletons/AGENTS.md.tmpl` | S2 | **L12만 변경** — `Install deps: <see project README, PM-specific> <!-- 주석 -->` → `` Install deps: `{{install_cmd}}` `` (주석 제거). **L5 License 무변경** (v1.10b 그대로) |
| `bootstrap/interview.md` | S2 | `## 자동 적용` 본문 명시 (현 4 항목, v1.10b 후 5 암묵) → **6 항목** + 신규 § `## install_cmd 매핑 (자동 적용, 17 PM)` 표 추가 |
| `bootstrap/docs/INTERVIEW_FLOW.md` | S2 | §3.3 "v1.10c 신규 변수 표" 추가 (install_cmd) + 파일별 변수 카운트 13 → **14** + §2 Stage S3 description에 **literal 표 template** 박음 (Claude 출력 deterministic 보장) + §3.3 끝 cross-link "17 PM 매핑은 `interview.md` 참조" |
| `bootstrap/manifest-schema.md` | S2 | L437 `자동 적용 4건` → `자동 적용 6건` (Agent 3 발견 stale) |
| `bootstrap/skeletons/projects/INTERVIEW.md` | S2 | `## 자동 적용 (질문 없음, 5건 — manifest 4 + 콘텐츠 1)` → `6건 — manifest 4 + 콘텐츠 2` + install_cmd 항목 1개 append |
| `claude/commands/harness-meta.md` | S1a | S2 행 `자동 5 (manifest 4 + AGENTS.md bootstrap_version stamp 1, v1.10b)` → `자동 6 (manifest 4 + 콘텐츠 2: bootstrap_version + install_cmd PM 매핑, v1.10c)` |
| `tests/smoke-bootstrap-agents-md.sh` | S2 | Stage 2 변수 13 → **14** (`{{install_cmd}}` 추가) / Stage 2 `Install deps: <see project README` placeholder grep 제거 / Stage 4 mock sed에 `install_cmd=uv sync` 추가 + 검증 (`` Install deps: `uv sync` ``) / Stage 4 install_cmd placeholder 잔존 검증 제거. **License placeholder grep + 검증은 유지** (v1.10b 그대로) |
| `CLAUDE.md` | S3 | "최신 meta 세션" 라인 v1.10b → v1.10c + 자동 적용 6 명시 |
| `README.md` | S3 | 동일 |

## 17 PM → install_cmd 매핑 매트릭스 (단일 소스)

`bootstrap/interview.md`의 `## install_cmd 매핑 (자동 적용, 17 PM)` § 본문. Claude(Bootstrap)가 Q3(package_manager) 확정 후 본 표를 lookup해 `HM_INSTALL_CMD` env 도출.

| Family | PM (Q3) | install_cmd | 비고 |
|--------|---------|-------------|------|
| Python | uv | `uv sync` | pyproject + uv.lock. lockfile 부재 시 첫 호출이 lockfile 생성 + install (정상) |
| Python | poetry | `poetry install` | pyproject + poetry.lock |
| Python | pdm | `pdm install` | pdm.lock |
| Python | rye | `rye sync` | rye.lock |
| Python | hatch | `hatch env create` | hatch.toml — 환경 생성 시 의존성 install 동시 수행 |
| Python | pip | `pip install -e .` | **PEP 517 modern** (Agent 1+4 권장). legacy `requirements.txt` 프로젝트는 부트스트랩 후 `pip install -r requirements.txt`로 수동 변경 |
| Node | pnpm | `pnpm install` | pnpm-lock.yaml |
| Node | bun | `bun install` | bun.lockb |
| Node | yarn | `yarn install` | yarn.lock |
| Node | npm | `npm install` | package-lock.json. CI에서 deterministic 원하면 부트스트랩 후 `npm ci`로 수동 변경 (lockfile 전제) |
| Go | go-mod | `go mod download` | go.mod — 명시적 module cache 다운로드 |
| Rust | cargo | `cargo fetch` | Cargo.toml — **build_cmd `cargo build --release`와 분리**. 사용자 dev에서 `cargo build`/`cargo run`이 자동 fetch + build 수행 (실용 분리는 약함, 의미 분리는 정확) |
| JVM | gradle | `./gradlew dependencies --write-locks` | build.gradle / .kts. **Gradle 철학상 별도 install 단계 부재** — 첫 `./gradlew <task>` 시 의존성 자동 fetch. `--write-locks`는 dependency lockfile 사용 시 의존성 해소 + lock 갱신 |
| JVM | maven | `mvn dependency:go-offline` | pom.xml — **Apache 공식 canonical** (plugin/reports 포함). `dependency:resolve`보다 표준 |
| .NET | dotnet | `dotnet restore` | *.csproj /*.sln |
| Ruby | bundler | `bundle install` | Gemfile + Gemfile.lock |
| Elixir | mix | `mix deps.get` | mix.exs + mix.lock |

**Fallback (unknown PM)**: Q3가 위 17 PM 외(예: `unknown` / detect 실패 + 사용자 manual 미입력)면 `HM_INSTALL_CMD="(PM 미감지 — 부트스트랩 후 수동 입력)"`. 빈 백틱 회피 (Agent 4-E2 발견). AGENTS.md.tmpl 치환 시 `Install deps: \`(PM 미감지 — 부트스트랩 후 수동 입력)\``.

**install_cmd vs build_cmd 책임 분리**:

- `install_cmd` = "**의존성 lockfile 동기화**" (lockfile → cache + venv/`node_modules`)
- `build_cmd` = "**컴파일 산출물 생성**" (인터프리터 언어는 보통 미정의; 컴파일 언어만 자동 적용)
- cargo: install=`cargo fetch` / build=`cargo build --release` (분리 의미)
- gradle: install=`./gradlew dependencies --write-locks` / build=`./gradlew build` (분리 의미)

**smoke 검증 범위**: mock 1개 PM(uv)만. 17 PM 전수 검증은 본 세션 범위 외 (사용자 부트스트랩 시점 자연 검증).

## 자동 적용 카운트 변화

| 카테고리 | v1.10b (5건) | v1.10c (6건) |
|---------|:----------:|:----------:|
| manifest `schema_version = "1.1"` | ✓ | ✓ |
| manifest `[harness].mcp_server = "harness"` | ✓ | ✓ |
| manifest `[agents].primary = "claude-code"` | ✓ | ✓ |
| manifest `[build]` (컴파일 언어) | ✓ | ✓ |
| AGENTS.md `{{bootstrap_version}}` stamp | ✓ | ✓ |
| AGENTS.md `{{install_cmd}}` (PM 매핑 17건) | — | **✓ (v1.10c 신규)** |

manifest 4 + 콘텐츠 1 (v1.10b) → manifest 4 + 콘텐츠 2 (v1.10c).

## tmpl 변수 변화 (AGENTS.md.tmpl)

v1.10b 13개 모두 유지 + `{{install_cmd}}` 1개 추가 = **총 14**.

| 변수 | v1.10b | v1.10c | env source |
|------|:----:|:----:|------------|
| `{{name}}` | ✓ | ✓ | HM_NAME |
| `{{language}}` | ✓ | ✓ | HM_LANGUAGE |
| `{{runtime_version}}` | ✓ | ✓ | HM_RUNTIME_VERSION |
| `{{package_manager}}` | ✓ | ✓ | HM_PACKAGE_MANAGER |
| `{{code_dir}}` | ✓ | ✓ | HM_CODE_DIR |
| `{{phases_dir}}` | ✓ | ✓ | HM_PHASES_DIR |
| `{{locale}}` | ✓ | ✓ | HM_LOCALE |
| `{{test_cmd}}` | ✓ | ✓ | HM_TEST_CMD |
| `{{lint_cmd}}` | ✓ | ✓ | HM_LINT_CMD |
| `{{format_cmd}}` | ✓ | ✓ | HM_FORMAT_CMD |
| `{{type_check_cmd}}` | ✓ | ✓ | HM_TYPE_CHECK_CMD |
| `{{build_cmd}}` | ✓ | ✓ | HM_BUILD_CMD |
| `{{bootstrap_version}}` | ✓ | ✓ | (자동 stamp = `1.10c`) |
| `{{install_cmd}}` | — | **✓** | (PM 매핑 17건 — interview.md `## install_cmd 매핑` lookup) |

description은 placeholder 주석 (sed 변수 아님) — v1.10b 그대로. **License는 v1.10b placeholder `License: see LICENSE.` 그대로 (sed 변수 아님)**.

## Stage S3 preview literal 표 template (deterministic 보장)

**v1.10b**: S3 preview = `render-manifest.sh` stdout (manifest TOML만)

**v1.10c**: S3 preview = manifest TOML + AGENTS.md 콘텐츠 default 표. 표 형식은 INTERVIEW_FLOW.md §2 Stage S3 description에 **literal template로 박음** (Claude가 그대로 복사 출력 — Agent 4-D1 발견 보강).

INTERVIEW_FLOW.md §2 Stage S3 description에 다음 literal block 추가:

```
S3 preview Claude 출력 형식 (사용자 확정 받기 전):

  ============= .harness.toml preview =============
  (render-manifest.sh stdout 그대로)

  ============= AGENTS.md content defaults =========
  | 변수 | 값 | 출처 |
  |------|------|------|
  | {{bootstrap_version}} | 1.10c | (자동 stamp — 본 세션 버전) |
  | {{install_cmd}}       | <PM 매핑 결과> | interview.md `## install_cmd 매핑` (Q3 = <PM>) |
  | License (placeholder) | see LICENSE | v1.10b — 사용자 LICENSE 파일 별도 작성 |

  확정 (yes / no / 수정) ?
```

`render-manifest.sh`는 manifest TOML만 렌더링 (변경 없음). AGENTS.md 콘텐츠 default 표는 **Claude(Bootstrap)이 위 literal template 그대로 복사 출력**. 별도 helper script 없음 (옵션 B 학습).

## smoke 갱신 (`tests/smoke-bootstrap-agents-md.sh`)

기존 6 stage 유지. 변경:

### Stage 2 (변수 13 → 14)

- 추가: `grep -q '{{install_cmd}}' "$TMPL"`
- 제거: `grep -q 'Install deps: <see project README' "$TMPL"` (placeholder 사라짐)
- **유지**: `grep -q 'License: see LICENSE' "$TMPL"` (v1.10b placeholder 그대로)

### Stage 4 (mock 치환 + 검증)

- sed 추가: `-e 's|{{install_cmd}}|uv sync|g'`
- 검증 추가: `` grep -q 'Install deps: `uv sync`' "$TMP" ``
- 제거: `grep -q 'Install deps: <see project README' "$TMP"`
- **유지**: `grep -q 'License: see LICENSE' "$TMP"` (v1.10b placeholder 치환 후도 그대로)

기존 `! grep -q '{{' "$TMP"` (변수 잔존 0) — 14 변수 모두 치환 후 `{{` 잔존 0.

### Stage 1 / 3 / 5 / 6

변경 없음.

### evidence

`sessions/meta/v1.10c-bootstrap-content-defaults/evidence/smoke-bootstrap-content-defaults.txt` — smoke 실행 결과.

## Grey Areas — 결정 (8건, 옵션 B 학습 적용 — 간결)

| ID | 질문 | 결정 |
|---|------|------|
| **G1** | install_cmd 도출 위치 — detect.sh vs Claude(Bootstrap) | **Claude(Bootstrap)** — interview.md `## install_cmd 매핑` 단일 소스. detect.sh 무수정 |
| **G2** | License 자동 default 처리 | **폐기 (v1.10e-detect-license 후속)** — agents.md spec 위배 + 법적 리스크 (Agent 2 + Agent 4-B). v1.10b placeholder `License: see LICENSE.` 유지 |
| **G3** | install_cmd 사용자 override Q14 | **본 세션 외** — PM 매핑 자동만. 사용자 override는 부트스트랩 후 AGENTS.md 직접 편집 |
| **G4** | install_cmd vs build_cmd 분리 (cargo) | **분리** — install=`cargo fetch` / build=`cargo build --release` (gradle도 분리 명시) |
| **G5** | smoke 17 PM 전수 검증 | **mock 1개(uv)만** — 17 매핑 정확성은 사용자 부트스트랩 시점 자연 검증 |
| **G6** | Stage S3 preview deterministic | **INTERVIEW_FLOW.md §2 literal template 박음** (Agent 4-D1) — Claude가 그대로 복사. helper script 없음 (옵션 B 학습) |
| **G7** | unknown PM fallback | **placeholder 텍스트** `(PM 미감지 — 부트스트랩 후 수동 입력)` (Agent 4-E2). 빈 백틱 회피 |
| **G8** | smoke 신규 파일 vs 기존 갱신 | **기존 `tests/smoke-bootstrap-agents-md.sh` 갱신** — v1.10c는 v1.10b 자산 보강 (분리 시 중복) |

## 성공 기준

- [ ] AGENTS.md.tmpl L12 `` Install deps: `{{install_cmd}}` `` 변수화 (sed 13 → 14). L5 License **무변경**
- [ ] interview.md `## install_cmd 매핑 (자동 적용, 17 PM)` § 신규 — 17행 표 + cargo install vs build 분리 명시 + maven `dependency:go-offline` + gradle `--write-locks` + pip `-e .` 정정
- [ ] interview.md `## 자동 적용 (질문 없음, 4건 → 6건)` 갱신 (manifest 4 + 콘텐츠 2)
- [ ] INTERVIEW_FLOW.md §3.3 v1.10c 신규 변수 표 (install_cmd) + 파일별 변수 카운트 13 → 14 + §2 Stage S3 literal template
- [ ] manifest-schema.md L437 `자동 적용 4건` → `6건`
- [ ] projects/INTERVIEW.md `## 자동 적용 (5건 → 6건)`
- [ ] slash command S2 행 `자동 5 → 6`
- [ ] smoke Stage 2 변수 13 → 14 (install_cmd 추가) + Stage 4 mock install_cmd=`uv sync` 치환·검증. License placeholder 검증 유지
- [ ] CLAUDE.md / README.md 최신 meta 세션 v1.10c + 자동 적용 6 명시
- [ ] smoke 6 stage PASS — `evidence/smoke-bootstrap-content-defaults.txt`
- [ ] REPORT.md 작성
- [ ] 사용자 확인 후 단일 커밋 + push

## 커밋 전략

단일 커밋. 부분 적용 시 자동 적용 카운트(5/6) + sed 변수(13/14) 불일치 → 자산 정합성 깨짐.

```
feat(meta): sessions/meta/v1.10c-bootstrap-content-defaults — install_cmd 17 PM 매핑 자동 변수 치환

- update: bootstrap/skeletons/AGENTS.md.tmpl (Install deps placeholder → `{{install_cmd}}`. License L5 무변경)
- update: bootstrap/interview.md (자동 적용 4→6 + ## install_cmd 매핑 (17 PM) § 신규)
- update: bootstrap/docs/INTERVIEW_FLOW.md (§3.3 v1.10c 변수 표 + sed 13→14 + §2 Stage S3 literal template)
- update: bootstrap/manifest-schema.md (L437 자동 적용 4→6)
- update: bootstrap/skeletons/projects/INTERVIEW.md (자동 적용 5→6)
- update: claude/commands/harness-meta.md (S2 자동 5→6)
- update: tests/smoke-bootstrap-agents-md.sh (Stage 2 변수 13→14 + Stage 4 mock install_cmd=uv sync)
- update: CLAUDE.md / README.md (최신 meta 세션 v1.10c)
- add: sessions/meta/v1.10c-bootstrap-content-defaults/{PLAN,REPORT,evidence/smoke-bootstrap-content-defaults.txt}

v1.10b 옵션 B 분할의 후속 — install_cmd placeholder를 17 PM 매핑 자동 변수로 전환.
License 자동 default는 agents.md spec 위배 + 법적 리스크로 폐기 (v1.10e-detect-license 후속).

17 PM 매핑 (interview.md 단일 소스):
Python 6 (uv/poetry/pdm/rye/hatch/pip(-e .)) + Node 4 (pnpm/bun/yarn/npm) + Go 1 (mod download) +
Rust 1 (cargo fetch — build와 분리) + JVM 2 (gradle --write-locks / maven dependency:go-offline) +
.NET 1 + Ruby 1 + Elixir 1 = 17.

Smoke 6/6 PASS — Stage 2 변수 14 + Stage 4 install_cmd=uv sync 치환 검증.
검증: 4 agent 종합 후 옵션 1 재설계. Grey Area 8건 결정.
```

## 후속 세션 연결

### 직접 연계

- **v1.10d-bash-permission-pattern-audit** (S1a, T4 분할) — `Bash(cmd:*)` vs `Bash(cmd*)` 콜론 패턴 audit (v1.10b에서 분리)
- **v1.10e-detect-license** (S2, 본 세션 폐기 결정 후속) — License 안전 처리. detect-project.sh가 LICENSE 파일 SPDX 헤더 추출 + S3 preview WARN. **본 세션이 license 미터치한 placeholder를 정식 자동화**
- **v1.11~v1.13 bootstrap-templates** (S2) — language overlay
- **v1.14~v1.20 adapter-{cursor,gemini,...}** (S2)
- **v1.21-cross-platform-install** (S3) — symlink/copy 자동 분기 + verify.ps1 체크리스트 A1/A4 drift
- **v1.23-monorepo-polyglot** (S2) — nested AGENTS.md + monorepo install_cmd 분기

### Lessons Forward

1. **검증 4 agent 종합이 redesign을 막은 모범** — context7 + web search + adversarial review로 license 자동 default가 agents.md spec 위배 + 법적 리스크임을 발견. 단순 진행 시 60,000+ 채택 사례에서 어긋날 뻔. **PLAN 작성 후 검증 단계는 비용 대비 효용 큼**
2. **옵션 B 분할 후속의 모범** — v1.10b 본질(structure) + v1.10c 보강(install_cmd만) + v1.10e 안전(license SPDX detect)이 각 단일 책임. 본 세션은 license 폐기로 더 가벼워짐 (~120 라인)
3. **17 PM 매핑은 단일 소스 = interview.md** — Claude(Bootstrap) reference. detect.sh 무수정으로 단순성 유지
4. **install_cmd vs build_cmd 분리 (cargo / gradle)** — 컴파일 언어는 의존성 동기화와 빌드 산출물 생성이 명확히 다른 명령. 매트릭스에 분리 명시
5. **License 자동 default는 권위 도구 패턴 위배** — cargo new는 의도적 미stamp / npm init ISC RFC 논쟁 中. 기술적 default가 항상 안전한 default는 아님. 법적 의도 명시는 사용자 책임
6. **Stage S3 preview literal template** — Claude 출력의 deterministic 보장은 자동화 미존재 시 INTERVIEW_FLOW.md 같은 단일 reference에 literal block 박음으로 해결 (helper script 없이)
