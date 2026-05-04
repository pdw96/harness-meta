# meta v1.10c-bootstrap-content-defaults — REPORT

세션 기간: 2026-04-27 (단일 세션, 4-agent 검증 후 옵션 1 재설계)
세션 범위: v1.10b가 placeholder로 남긴 `Install deps:` 라인을 17 PM 매핑 자동 변수 치환으로 전환. License는 agents.md spec 위배 + 법적 리스크로 폐기 (v1.10e-detect-license 후속).
판정: **PASS** (성공 기준 11/11, smoke 6/6 PASS)

**세션 소속 (self-apply)**: `sessions/meta/`. S2(7) + S1a(1) + S3(2) = **11/11 meta**. T1 다수결 + T2 스펙 정의.

## 4-agent 검증 후 옵션 1 재설계 (License 자동 default 폐기)

PLAN 1차 작성 후 사용자 요청에 따라 **context7 + web search + adversarial review** 4 agent 병렬 검증 수행:

1. **Agent 1 (17 PM 정확성)** — gradle/maven/pip 매핑 정정 권장. uv/poetry/pdm/rye/cargo 등 14개 검증 통과
2. **Agent 2 (AGENTS.md spec)** — License는 agents.md 공식 § 권장 아님 (60,000+ 채택 사례). LICENSE 파일 reference가 표준
3. **Agent 3 (회귀 점검)** — manifest-schema.md:437 stale 발견. 변경 대상 9번째 파일로 추가 필수
4. **Agent 4 (적대적 검토)** — License 자동 stamp의 법적 리스크 (proprietary/Apache/GPL 충돌). Stage S3 preview deterministic 부족

**Critical 결정**: License 자동 MIT default **폐기**. v1.10b placeholder `License: see LICENSE.` 유지. v1.10e-detect-license 후속 분리.

→ PLAN 책임 좁아짐. sed 13→**14** (license 안 추가), 자동 적용 5→**6**, Grey Area 10→**8**.

## 최종 결과

- **수정 9 파일** + **신규 세션 기록 3 파일**:
  - `bootstrap/skeletons/AGENTS.md.tmpl` (L12 install_cmd 변수화. L5 License 무변경)
  - `bootstrap/interview.md` (자동 적용 4→6 + `## install_cmd 매핑 (자동 적용, 17 PM)` § 신규)
  - `bootstrap/docs/INTERVIEW_FLOW.md` (§3.3 v1.10c 변수 표 + 파일별 카운트 13→14 + §2.1 Stage S3 literal template)
  - `bootstrap/manifest-schema.md` (L437 자동 적용 4→6 + 인터뷰 12→13 + omit 7→9)
  - `bootstrap/skeletons/projects/INTERVIEW.md` (자동 적용 5→6 + install_cmd 항목)
  - `claude/commands/harness-meta.md` (S2 자동 5→6)
  - `tests/smoke-bootstrap-agents-md.sh` (Stage 2 변수 13→14 + Stage 4 mock install_cmd=uv sync)
  - `CLAUDE.md` / `README.md` (최신 meta 세션 v1.10c + 자동 적용 6 명시)
  - `sessions/meta/v1.10c-bootstrap-content-defaults/{PLAN,REPORT,evidence/smoke-bootstrap-content-defaults.txt}`

## smoke 6 stage 결과 (`evidence/smoke-bootstrap-content-defaults.txt`)

```
[Stage 1] AGENTS.md.tmpl 8 sections PASS (공식 agents.md sample 4 § 일치 + PLAN 고유 4 §)
[Stage 2] AGENTS.md.tmpl 14 sed vars + description + license placeholder (v1.10b 유지) + README relation + footer link PASS
[Stage 3] CLAUDE.md.tmpl 3 imports PASS
[Stage 4] sed 14-var + bootstrap_version stamp v1.10c + install_cmd=uv sync + license placeholder 잔존 PASS — {{ 잔존 0
[Stage 5] absolute path 0 + Do/Don't 5 + Boundaries 3 backups PASS
[Stage 6] CLAUDE.override.md.tmpl marker + header + Q13 § PASS

PASS — bootstrap agents-md smoke (6 stages, v1.10c — install_cmd 변수화)
```

**검증 4 포인트**:

1. AGENTS.md.tmpl 8 sections (v1.10b 그대로)
2. CLAUDE.md.tmpl 3 import (v1.10b 그대로)
3. **sed 14 변수 치환 + bootstrap_version stamp `v1.10c` + install_cmd=`uv sync` 치환 + License placeholder 잔존** (v1.10c 변경)
4. 절대경로 0 + Do/Don't 5 + Boundaries 3 backups

## 17 PM 매핑 매트릭스 (단일 소스 = `interview.md`)

| Family | PM | install_cmd | 검증 출처 |
|--------|-----|-------------|-----------|
| Python | uv | `uv sync` | uv 공식 docs |
| Python | poetry | `poetry install` | python-poetry.org |
| Python | pdm | `pdm install` | pdm-project.org |
| Python | rye | `rye sync` | rye 공식 docs |
| Python | hatch | `hatch env create` | pypa/hatch |
| Python | pip | `pip install -e .` | **PEP 517 modern** (Agent 1 권장) |
| Node | pnpm | `pnpm install` | pnpm 표준 |
| Node | bun | `bun install` | bun 표준 |
| Node | yarn | `yarn install` | yarn 표준 |
| Node | npm | `npm install` | npm 표준 (CI deterministic은 `npm ci`) |
| Go | go-mod | `go mod download` | go 공식 (CI canonical) |
| Rust | cargo | `cargo fetch` | cargo-fetch(1) man page (build_cmd와 분리) |
| JVM | gradle | `./gradlew dependencies --write-locks` | **Agent 1 권장** (Gradle 철학상 별도 install 부재) |
| JVM | maven | `mvn dependency:go-offline` | **Apache 공식 canonical** (Agent 1 권장, plugin/reports 포함) |
| .NET | dotnet | `dotnet restore` | .NET 공식 |
| Ruby | bundler | `bundle install` | bundler 표준 |
| Elixir | mix | `mix deps.get` | mix 공식 |

**Fallback (unknown PM)**: `(PM 미감지 — 부트스트랩 후 수동 입력)` placeholder 텍스트 (빈 백틱 회피, Agent 4-E2 발견).

**install_cmd vs build_cmd 분리** (cargo / gradle): 매트릭스 비고에 명시.

## 자동 적용 카운트 변화

| 카테고리 | v1.10b (5건) | v1.10c (6건) |
|---------|:----------:|:----------:|
| manifest 4건 (schema_version + mcp_server + agents.primary + [build]) | ✓ | ✓ |
| AGENTS.md `{{bootstrap_version}}` stamp | ✓ | ✓ (값 갱신: 1.10b → 1.10c) |
| AGENTS.md `{{install_cmd}}` (PM 매핑 17건) | — | **✓ (v1.10c 신규)** |

License는 자동 적용 안 함 — v1.10b placeholder `License: see LICENSE.` 그대로 유지.

## 구현 요약 — PLAN 11/11

| # | 목표 | 결과 |
|---|------|------|
| 1 | AGENTS.md.tmpl L12 install_cmd 변수화 (sed 13→14) | ✅ |
| 2 | interview.md 자동 적용 4→6 + 17 PM 매핑 § 신규 | ✅ |
| 3 | INTERVIEW_FLOW.md §3.3 v1.10c 변수 표 + §2.1 Stage S3 literal template | ✅ |
| 4 | manifest-schema.md L437 자동 적용 4→6 (Agent 3 발견 stale) | ✅ |
| 5 | projects/INTERVIEW.md 자동 적용 5→6 + install_cmd 항목 | ✅ |
| 6 | slash command S2 자동 5→6 | ✅ |
| 7 | smoke Stage 2 변수 13→14 + Stage 4 mock install_cmd=uv sync | ✅ |
| 8 | CLAUDE.md / README.md 최신 meta 세션 v1.10c | ✅ |
| 9 | smoke 6/6 PASS + evidence 저장 | ✅ |
| 10 | REPORT 본 파일 | ✅ |
| 11 | 사용자 확인 후 단일 커밋 + push | (대기) |

## Grey Area 8건 결정 반영

- **G1** install_cmd 도출 = Claude(Bootstrap) [interview.md 단일 소스]
- **G2** License 자동 default = **폐기** (v1.10e-detect-license 후속, agents.md spec + 법적 리스크)
- **G3** install_cmd Q14 사용자 입력 = 본 세션 외 (자동만)
- **G4** install_cmd vs build_cmd 분리 (cargo / gradle) = 분리
- **G5** smoke 17 PM 전수 검증 = mock 1개(uv)만
- **G6** Stage S3 preview deterministic = INTERVIEW_FLOW.md §2.1 literal template
- **G7** unknown PM fallback = placeholder 텍스트 (빈 백틱 회피)
- **G8** smoke 신규 vs 기존 갱신 = 기존 갱신

## Lessons Learned

1. **검증 4 agent 종합이 redesign을 막은 모범** — License 자동 MIT default가 agents.md 공식 spec 위배 + 법적 리스크임을 발견. 단순 PLAN 진행 시 60,000+ 채택 사례에서 어긋날 뻔. **PLAN 작성 후 multi-perspective 검증 단계는 비용 대비 효용 큼**

2. **옵션 B 분할 후속의 모범 (v1.10b → v1.10c → v1.10e)** — v1.10b 본질(structure) + v1.10c 보강(install_cmd만) + v1.10e 안전(license SPDX detect)이 각 단일 책임. 본 세션은 license 폐기로 더 가벼워짐 — PLAN ~120 라인 (v1.10b 600 라인 대비 1/5)

3. **17 PM 매핑은 단일 소스 = interview.md** — Claude(Bootstrap) reference. detect.sh 무수정으로 단순성 유지. 향후 PM 추가 시 1곳만 갱신

4. **install_cmd vs build_cmd 분리 (cargo / gradle)** — 컴파일 언어는 의존성 동기화와 빌드 산출물 생성이 명확히 다른 명령. 매트릭스 비고에 분리 명시. cargo: install=`cargo fetch` / build=`cargo build --release`

5. **License 자동 default는 권위 도구 패턴 위배** — cargo new는 의도적 미stamp / npm init ISC RFC 논쟁 中 / poetry init default 없음. 기술적 default가 항상 안전한 default는 아님. **법적 의도 명시는 사용자 책임으로 두는 게 안전**

6. **Stage S3 preview literal template** — Claude 출력의 deterministic 보장은 자동화 미존재 시 단일 reference (INTERVIEW_FLOW.md §2.1)에 literal block 박음으로 해결. helper script 없이 (옵션 B 학습)

7. **PM 매핑 정확도는 공식 docs 검증 필수** — Agent 1 검증으로 maven/gradle/pip 3건 정정. PLAN 초안의 `mvn dependency:resolve` (plugin/reports 미포함) → `mvn dependency:go-offline` (Apache canonical). `./gradlew dependencies` (진단 task) → `--write-locks` 추가. `pip install -r requirements.txt` (부재 시 fail) → `pip install -e .` (PEP 517)

8. **manifest-schema.md:437 stale 발견** — Agent 3 회귀 점검으로 PLAN 변경 대상 8 → **9 파일**. 자동 적용 카운트는 schema 문서에도 명시되어 있음. **카운트 변경 시 grep 전수 검색 패턴 필수**

## 후속 세션 연결

### 직접 연계

- **v1.10d-bash-permission-pattern-audit** (S1a, T4 분할) — `Bash(cmd:*)` vs `Bash(cmd*)` 콜론 패턴 audit
- **v1.10e-detect-license** (S2, **본 세션 폐기 결정의 직접 후속**) — License 안전 처리:
  1. detect-project.sh가 LICENSE 파일 SPDX 헤더 추출 (BSD/MIT/Apache-2.0/GPL/proprietary 식별)
  2. AGENTS.md.tmpl L5 `License: {{license}}.` sed 변수화 — 자동 적용 6 → 7
  3. S3 preview에 LICENSE 파일 발견 시 SPDX 표시 + 사용자 confirm
  4. proprietary 의도 사용자에게 placeholder `License: see LICENSE` 옵션 제공 (Q14 신규?)
- **v1.11~v1.13 bootstrap-templates** (S2) — language overlay
- **v1.14~v1.20 adapter-{cursor,gemini,...}** (S2) — adapter 7종
- **v1.21-cross-platform-install** (S3) — symlink/copy 자동 분기 + verify.ps1 체크리스트 A1/A4 drift
- **v1.23-monorepo-polyglot** (S2) — nested AGENTS.md + monorepo install_cmd 분기

### 적용 사례

- 신규 프로젝트 추가 시점에 본 v1.10 + v1.10b + v1.10c 흐름 호출 → AGENTS.md.tmpl `{{install_cmd}}` 자동 PM 매핑
- upbit는 별도 `sessions/upbit/vX-content-default-update/` (T4 분할)

## 커밋 계획

```
feat(meta): sessions/meta/v1.10c-bootstrap-content-defaults — install_cmd 17 PM 매핑 자동 변수 치환

- update: bootstrap/skeletons/AGENTS.md.tmpl (Install deps placeholder → `{{install_cmd}}`. License L5 무변경 — v1.10b placeholder 유지)
- update: bootstrap/interview.md (자동 적용 4→6 + ## install_cmd 매핑 (17 PM) § 신규)
- update: bootstrap/docs/INTERVIEW_FLOW.md (§3.3 v1.10c 변수 표 + sed 13→14 + §2.1 Stage S3 literal template)
- update: bootstrap/manifest-schema.md (L437 자동 적용 4→6 + 인터뷰 12→13 + omit 7→9)
- update: bootstrap/skeletons/projects/INTERVIEW.md (자동 적용 5→6)
- update: claude/commands/harness-meta.md (S2 자동 5→6)
- update: tests/smoke-bootstrap-agents-md.sh (Stage 2 변수 13→14 + Stage 4 mock install_cmd=uv sync)
- update: CLAUDE.md / README.md (최신 meta 세션 v1.10c)
- add: sessions/meta/v1.10c-bootstrap-content-defaults/{PLAN,REPORT,evidence/smoke-bootstrap-content-defaults.txt}

v1.10b 옵션 B 분할의 후속 — install_cmd placeholder를 17 PM 매핑 자동 변수로 전환.
License 자동 default는 agents.md 공식 spec 위배 + 법적 리스크 (proprietary/Apache/GPL 충돌)로 폐기.
v1.10e-detect-license 후속 분리 (LICENSE 파일 SPDX 추출 + S3 preview WARN).

17 PM 매핑 (interview.md 단일 소스):
Python 6 (uv/poetry/pdm/rye/hatch/pip(-e .)) + Node 4 (pnpm/bun/yarn/npm) + Go 1 (mod download) +
Rust 1 (cargo fetch — build와 분리) + JVM 2 (gradle --write-locks / maven dependency:go-offline — Agent 1 권장) +
.NET 1 + Ruby 1 + Elixir 1 = 17.

Smoke 6/6 PASS — Stage 2 변수 14 + Stage 4 install_cmd=uv sync 치환 + bootstrap_version v1.10c stamp + License placeholder 잔존.
검증: 4-agent 종합 (context7 + web search + adversarial review) 후 옵션 1 재설계.
Grey Area 8건 결정 (10건 → license/SPDX 폐기로 8건).
```
