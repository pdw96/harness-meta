# A3 — 동적 변수 가변성 매트릭스

본 audit는 `harness-run`/`harness-ship` SKILL의 **fine-grain 시도 시 fragile 위반**을 evidence-driven으로 입증한다. 4 동적 변수 × 5+ 언어 × 다중 PM 변형 매트릭스로 broad `Bash` 유지의 정당성 확보.

## 1. 4 동적 변수 inventory

| 변수 | 출처 | 사용 SKILL | 사용 위치 |
|------|------|-----------|---------|
| `{executor}` | `.harness.toml [harness].executor` | harness-run | 8단계 UAT (line 25) + 9단계 실행 (line 48) |
| `{test_cmd}` | `.harness.toml [testing].test_cmd` | harness-ship | 10-1 Functional (line 53) + 10-2 항목 3 (line 72) + 10-2 항목 5 (line 76) |
| `{type_check_cmd}` | `.harness.toml [testing].type_check_cmd` | harness-ship | 10-2 항목 5 (line 77) |
| `{lint_cmd}` | `.harness.toml [testing].lint_cmd` | harness-ship | 10-2 항목 5 (line 78) |

추가 미사용 (manifest schema v1.1에 정의되었으나 본 SKILL 미참조):
- `[testing].format_cmd` (v1.1 신규, harness-review 확장 v1.8+ 예정)
- `[testing].harness_test_cmd` (v1.0)
- `[harness].statusline_cmd` (v1.1)

## 2. 5 언어 × {executor} 매트릭스 (harness-run)

`.harness.toml [harness].executor` 권장값 (manifest-schema.md §10 다언어 예시 + interview.md install_cmd 매트릭스 17 PM):

| 언어 | PM | `executor` 값 (제안) | 첫 token | broad fine-grain 가능성 |
|------|------|----------------------|---------|:---:|
| Python | uv | `uv run scripts/execute.py` | `uv` | `Bash(uv *)` 가능 |
| Python | poetry | `poetry run scripts/execute.py` | `poetry` | `Bash(poetry *)` 가능 |
| Python | pip | `python3 scripts/execute.py` | `python3` | `Bash(python3 *)` 가능 |
| Python | pdm | `pdm run scripts/execute.py` | `pdm` | `Bash(pdm *)` 가능 |
| Python | rye | `rye run scripts/execute.py` | `rye` | `Bash(rye *)` 가능 |
| Python | hatch | `hatch run scripts/execute.py` | `hatch` | `Bash(hatch *)` 가능 |
| Node | pnpm | `pnpm tsx scripts/execute.ts` | `pnpm` | `Bash(pnpm *)` 가능 |
| Node | bun | `bun scripts/execute.ts` | `bun` | `Bash(bun *)` 가능 |
| Node | yarn | `yarn tsx scripts/execute.ts` | `yarn` | `Bash(yarn *)` 가능 |
| Node | npm | `npx tsx scripts/execute.ts` | `npx` | `Bash(npx *)` 가능 (단 wrapper 미strip — A3 §5 참조) |
| Go | go-mod | `go run ./cmd/execute` | `go` | `Bash(go *)` 가능 |
| Rust | cargo | `./target/release/execute` | `./target/release/execute` | exact match 필요 |
| JVM | gradle | `./gradlew run --args="..."` | `./gradlew` | exact match 필요 |
| JVM | maven | `mvn exec:java -Dexec.args="..."` | `mvn` | `Bash(mvn *)` 가능 |
| .NET | dotnet | `dotnet run --project src/...` | `dotnet` | `Bash(dotnet *)` 가능 |
| Ruby | bundler | `bundle exec ruby scripts/execute.rb` | `bundle` | `Bash(bundle *)` 가능 |
| Elixir | mix | `mix run scripts/execute.exs` | `mix` | `Bash(mix *)` 가능 |

**관찰**: 첫 token이 **17가지 가능** — 매니페스트별 fine-grain pattern은 templates baseline에서 **불가능**.

### 시도 시 발생 시나리오

```yaml
# 가설 — 모든 PM 패턴 declare 시도 (실용 불가)
allowed-tools:
  - Bash(uv *)
  - Bash(poetry *)
  - Bash(python3 *)
  - Bash(pdm *)
  - Bash(rye *)
  - Bash(hatch *)
  - Bash(pnpm *)
  - Bash(bun *)
  - Bash(yarn *)
  - Bash(npx *)
  - Bash(go *)
  - Bash(./target/release/execute)
  - Bash(./gradlew *)
  - Bash(mvn *)
  - Bash(dotnet *)
  - Bash(bundle *)
  - Bash(mix *)
```

**문제 4건**:
1. **17 entries 매트릭스 폭발** — 새 PM 추가 시 매번 templates 갱신 필요
2. **사용자 정의 executor** (예: `python -m foo.bar`, `./scripts/custom-runner.sh`) 매치 실패 — manifest-schema.md §6.3 `executor`는 자유 형식 string
3. **Rust `./target/release/execute`** 같은 exact match는 사용자가 binary 이름 변경 시 fail
4. **wrapper 변경** (`devbox run`, `mise exec`, `direnv exec` 등 미strip wrapper) 시 매치 실패 — PERMISSION_PATTERN.md §7

→ broad `Bash` 유지가 유일한 일반화 가능 패턴.

## 3. 5 언어 × {test_cmd} / {type_check_cmd} / {lint_cmd} 매트릭스 (harness-ship)

`.harness.toml [testing].*` 권장값 (manifest-schema.md §10 4 언어 예시 + 추가 변형):

### Python

| PM | `test_cmd` | `type_check_cmd` | `lint_cmd` | first tokens |
|------|----------|----------|----------|:---:|
| uv | `uv run pytest` | `uv run mypy src` | `uv run ruff check` | `uv` (3종 모두) |
| poetry | `poetry run pytest` | `poetry run mypy src` | `poetry run ruff check` | `poetry` |
| pdm | `pdm run pytest` | `pdm run mypy src` | `pdm run ruff check` | `pdm` |
| pip | `pytest` | `mypy src` | `ruff check` | `pytest`/`mypy`/`ruff` (분기) |

### TypeScript / JavaScript

| PM | `test_cmd` | `type_check_cmd` | `lint_cmd` | first tokens |
|------|----------|----------|----------|:---:|
| pnpm | `pnpm test` | `pnpm tsc --noEmit` | `pnpm biome check` | `pnpm` |
| bun | `bun test` | `bun tsc --noEmit` | `bun lint` | `bun` |
| yarn | `yarn test` | `yarn tsc --noEmit` | `yarn lint` | `yarn` |
| npm | `npm test` | `npm run tsc -- --noEmit` | `npm run lint` | `npm` |

### Go / Rust / JVM

| 언어 | `test_cmd` | `type_check_cmd` | `lint_cmd` | first tokens |
|------|----------|----------|----------|:---:|
| Go | `go test ./...` | `go vet ./...` | `golangci-lint run` | `go`/`golangci-lint` (분기) |
| Rust | `cargo test` | (none, compile checks types) | `cargo clippy -- -D warnings` | `cargo` |
| Gradle | `./gradlew test` | (none) | `./gradlew check` | `./gradlew` |
| Maven | `mvn test` | (none) | `mvn checkstyle:check` | `mvn` |
| .NET | `dotnet test` | (none) | `dotnet format --verify-no-changes` | `dotnet` |

**관찰**:
- 단순 첫 token만 13가지 (PM × 도구 분리 시 더 많음)
- Python pip은 `pytest` / `mypy` / `ruff` 3 분기 — 단일 prefix 추출 불가
- Go는 `go` + `golangci-lint` 2 분기

### 시도 시 fragile 사례

PERMISSION_PATTERN.md §6 인용 4 (Anthropic permissions docs):
> "Bash permission patterns that try to constrain command arguments are **fragile**."

**예시 — Python+uv 가정 fine-grain**:
```yaml
allowed-tools:
  - Bash(uv run pytest *)        # fail: 사용자가 `uv run pytest -k foo` 추가 OK / `uv run pytest --cov` 추가 OK / 그러나 `uv run --frozen pytest` 같은 옵션 변형 시 매치 실패
  - Bash(uv run mypy *)          # fail: `uv run --no-sync mypy src` 시 매치 실패 (uv 옵션이 run 앞에)
  - Bash(uv run ruff check *)    # fail: `uv run ruff format` (포맷) 시도 시 unrelated
```

→ argument constraint = fragile. broad `Bash(uv *)` 또는 단순 `Bash` 가 유일한 신뢰 가능 패턴.

## 4. git ops fine-grain 시도 분석

`harness-ship/SKILL.md` 본문 git WRITE 호출 6건 (A1 §3 매트릭스):

```bash
git add phases/{...} REPORT.md ...    # line 111-113
git commit -m "..."                    # line 114
git checkout main                       # line 119
git pull origin main --ff-only          # line 120
git merge feat-{phase-name} --no-edit   # line 121
git push origin main                    # line 122
git branch -d feat-{phase-name}         # line 123
```

### 시도 1 — sub-command별 declare

```yaml
allowed-tools:
  - Bash(git add *)
  - Bash(git commit *)
  - Bash(git checkout main)        # exact match
  - Bash(git pull origin main *)
  - Bash(git merge *)
  - Bash(git push origin main)     # exact match
  - Bash(git branch -d *)
```

**문제 5건**:
1. `git checkout main` exact — 다른 브랜치 (`develop`, `feat-*`)로 복귀 시 매치 실패
2. `git pull --ff-only` 옵션 위치 변경 시 매치 실패 — `git pull --ff-only origin main` (옵션 앞) vs `git pull origin main --ff-only` (옵션 뒤)
3. `git push origin main` exact — 다른 remote (`upstream`, `fork`) 또는 다른 브랜치 push 시 매치 실패
4. `git branch -d` vs `git branch -D` (force) — D 대문자는 fragile (인용 4)
5. **fail recovery 시나리오** (예: `git pull --ff-only` 실패 → 사용자가 `git rebase origin/main` 시도) — 명시적 declare 외 모든 git 명령 prompt → 매번 사용자 개입 = workflow 마찰

### 시도 2 — broad git

```yaml
allowed-tools:
  - Bash(git *)
```

**문제**: destructive 명령 (`git reset --hard`, `git push --force`, `git branch -D`) 모두 자동 허용 → 사용자 settings.json `permissions.deny`로 별도 제어 필요. 본 templates는 사용자 환경 가정 안 함 → 결정 미루기.

### 시도 3 — broad Bash (현 채택)

```yaml
allowed-tools:
  - Bash
```

**효과**:
- 모든 git 명령 자동 허용 (write forms 포함)
- 사용자 settings.json에서 deny rule로 destructive 제어 (PERMISSION_PATTERN.md §9 마이그레이션 가이드)
- workflow 마찰 0
- 신뢰 모델: harness-ship SKILL은 의도적 git workflow만 호출 (line 110-123 sequence) — broad Bash는 "이 SKILL의 의도된 명령은 prompt 없이 진행" 의미

→ R3' Conservative + workflow 보존 균형. broad 유지 정당.

## 5. Compound + Wrapper 분석 (PERMISSION_PATTERN.md §7 인용 5-6)

### Compound 명령 분해 (line 117)

```bash
git status --porcelain | head -1
```

separator: `|` (pipe). 각 subcommand 독립 매치:
- `git status --porcelain` → AUTO (git read-only)
- `head -1` → AUTO (자동 허용 set)

→ broad `Bash` 또는 declare 제거 모두 prompt 0 (자동 허용으로 충분).

### Wrapper 자동 strip (인용 5)

자동 strip: `timeout`, `time`, `nice`, `nohup`, `stdbuf`, bare `xargs` (no flags).

**본 v1.10f scope 영향**:
- `harness-run`/`harness-ship` 본문에 wrapper 사용 0건 — 영향 없음
- 그러나 사용자가 `timeout 60 {executor} ...` 으로 호출 시 자동 strip → broad `Bash`로 처리 OK

미strip wrapper (PERMISSION_PATTERN.md §7): `direnv exec`, `devbox run`, `mise exec`, `npx`, `docker exec`.

**npm `npx` edge** — A3 §2 매트릭스에 `npx tsx scripts/execute.ts` 등재. `npx`는 자동 strip **안 됨** → 사용자가 npx 사용 시 declare 별도 필요. 그러나 broad `Bash`로 통합 처리 가능.

## 6. fine-grain 가능성 매트릭스 (종합)

| SKILL | 호출 종류 | fine-grain 가능? | 근거 |
|-------|---------|:---:|------|
| harness-run 8/9단계 | `{executor}` | **불가** | 17 PM × 사용자 정의 executor (A3 §2) |
| harness-ship 10-1 Functional | `{test_cmd}` | **불가** | 13 PM × 분기 (A3 §3) |
| harness-ship 10-2 항목 3 | `{test_cmd}` | **불가** | 동일 |
| harness-ship 10-2 항목 5 | `{test_cmd}` / `{type_check_cmd}` / `{lint_cmd}` | **불가** | 3 변수 × 13 PM (A3 §3) |
| harness-ship 10-5 git WRITE | `git add/commit/checkout/pull/merge/push/branch -d` | **부분 가능 (fragile)** | 옵션 위치 / 다른 브랜치-remote 시나리오 fail (A3 §4) |

**결론**: harness-run / harness-ship 모든 본문 호출이 fine-grain 시도 시 fragile 또는 매니페스트 가변. broad `Bash` 유지가 유일한 spec 정합 + 신뢰 가능 패턴.

## 7. 후속 세션 가능성

본 v1.10f는 templates baseline의 broad 유지 결정. 향후 세션 후보:

| 후속 | scope | 검토 시점 |
|------|-------|---------|
| settings.json deny rule 가이드 | S2 (PERMISSION_PATTERN.md §9 확장) | 사용자 마이그레이션 가이드 — 본 v1.10f scope 외 |
| `[harness].executor_class` enum 도입 (제안: `python` / `node` / `go` / `rust` / `jvm` / `dotnet` / `custom`) | S2 (manifest schema v1.2) | broad declare 대신 class 기반 declare 가능 검토 (3개월 재평가 게이트) |
| 사용자 settings.json 자동 분석 + deny rule 자동 생성 | S2 (audit tool) | tomllib parser 도입 후 (v2.0+) |

본 v1.10f는 위 3 후속 모두 **scope 외**. evidence-driven 진화 패턴 유지.

## 8. 관련 문서

- 본 세션 PLAN: [`../PLAN.md`](../PLAN.md)
- A1 본문 inventory: [`A1-bash-usage.md`](A1-bash-usage.md)
- A2 권위 인용: [`A2-anthropic-docs.md`](A2-anthropic-docs.md)
- A4 정책 결정: [`A4-policy-decisions.md`](A4-policy-decisions.md)
- 5축 spec §6 R3' Conservative: [`../../../../bootstrap/docs/PERMISSION_PATTERN.md`](../../../../bootstrap/docs/PERMISSION_PATTERN.md)
- manifest 동적 변수 spec: [`../../../../bootstrap/manifest-schema.md`](../../../../bootstrap/manifest-schema.md)
- install_cmd 17 PM 매트릭스: [`../../../../bootstrap/interview.md`](../../../../bootstrap/interview.md)
