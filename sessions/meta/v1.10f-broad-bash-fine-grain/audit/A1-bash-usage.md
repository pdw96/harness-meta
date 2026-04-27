# A1 — 본문 Bash 호출 inventory

본 audit는 v1.10f scope 4 파일의 **frontmatter declare ↔ 본문 실 호출** 일치성을 검증한다. 각 호출은 `파일:줄번호 [분류]` 형식으로 evidence 보존.

분류 체계 (PERMISSION_PATTERN.md §5 자동 허용 set 인용):
- **AUTO** — 자동 허용 set (`ls`/`cat`/`head`/`tail`/`grep`/`find`/`wc`/`diff`/`stat`/`du`/`cd` + `git` read-only forms). 자동 prompt 회피
- **WRITE** — git write forms (`add`/`commit`/`push`/`checkout`/`pull`/`merge`/`branch -d`) 등. prompt 또는 사용자 settings.json
- **DYN** — 매니페스트 동적 변수 (`{executor}` / `{test_cmd}` / `{type_check_cmd}` / `{lint_cmd}`). 프로젝트별 가변
- **DOC** — 코드블록이나 설명에만 등장 (실 호출 아님). frontmatter declare 무관

## 1. `bootstrap/templates/_base/.claude/skills/harness/SKILL.md`

**Frontmatter (현재)**: `allowed-tools: Read, Glob, Grep, Bash, Edit` (line 6)

**본문 Bash 호출 inventory**:

| 줄 | 인용 | 분류 |
|---|---|---|
| 69 | `git add -A 금지` | DOC (anti-pattern 설명. 호출 아님) |

**합계**: 호출 0건. DOC 1건.

**판정**:
- 본문 Bash 사용 사례 = **0** (Read·Grep·Glob 호출만, 디스패처 라우팅)
- L29: "아래를 **Read**하여 다음 단계를 결정" — 명시적 Read tool 한정
- frontmatter `Bash` declare = **redundant**. PERMISSION_PATTERN.md §5 "declare 제거 = 차단 아님 = baseline 폴백 (자동 허용 또는 prompt)" — 디스패처가 우연히 Bash 호출하면 prompt 발생 (안전 default)

**결정 근거 (R2)**: declare 제거 가능. 자동 허용 set으로 디스패처 동작 충분 (`ls phases/`, `cat phases/index.json` 등 read-only는 자동).

---

## 2. `bootstrap/templates/_base/.claude/skills/harness-run/SKILL.md`

**Frontmatter (현재)**: `allowed-tools: Read, Glob, Grep, Bash, Edit` (line 5)

**본문 Bash 호출 inventory**:

| 줄 | 인용 | 분류 |
|---|---|---|
| 11 | "**오케스트레이터**: 직접 Bash 실행" | DOC (정책 선언) |
| 24-25 | ` ```bash ` + `{executor} {version}/{phase-name} --dry-run` | **DYN** (8단계 UAT 본 호출) |
| 28 | `# Python: python3 scripts/execute.py` | DOC (예시 주석) |
| 29 | `# Node: pnpm tsx scripts/execute.ts` | DOC (예시 주석) |
| 30 | `# Go: go run ./cmd/execute` | DOC (예시 주석) |
| 31 | `# Rust: ./target/release/execute` | DOC (예시 주석) |
| 47-48 | ` ```bash ` + `{executor} {version}/{phase-name} --push-per-step` | **DYN** (9단계 실 실행) |
| 56 | `--status` | DYN (subcommand option) |
| 57 | `--reset-step N` | DYN (subcommand option) |
| 58 | `--from-step N` | DYN (subcommand option) |
| 71 | `--reset-step N` (재실행) | DYN |

**합계**: 실 호출 5건 (모두 DYN). DOC 6건.

**판정**:
- **모든 실 호출이 `{executor}` 동적**. 프로젝트별 `.harness.toml [harness].executor` 값에 의존
- 매니페스트 가변 매트릭스 (예시 4건):
  - Python: `python3 scripts/execute.py`
  - Node: `pnpm tsx scripts/execute.ts`
  - Go: `go run ./cmd/execute`
  - Rust: `./target/release/execute`
- 추가 PM 변형: `uv run scripts/execute.py` (Python+uv) / `bun scripts/execute.ts` (Node+bun) / `mvn exec:java` (Java) 등 — A3 매트릭스 참조
- `Bash(python3 scripts/execute.py *)` fine-grain 시도 시: TS/Go/Rust 프로젝트 매니페스트는 매치 실패 → 모든 step 실행 prompt → 실용 0
- → broad `Bash` declare가 유일한 일반화 가능 패턴 (PERMISSION_PATTERN.md §6 R3' Conservative 정합)

**결정 근거 (R3)**: broad `Bash` 유지. 형식만 콤마 → YAML list로 정정.

---

## 3. `bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md`

**Frontmatter (현재)**: `allowed-tools: Read, Glob, Grep, Bash, Edit(phases/**), Write(phases/**)` (line 5)

**본문 Bash 호출 inventory**:

| 줄 | 인용 | 분류 |
|---|---|---|
| 19 | "현재 git 브랜치 확인" | AUTO (`git branch --show-current` 또는 `git rev-parse --abbrev-ref HEAD` 추정 → read-only) |
| 53 | "`{test_cmd}` 실행" (Step 4 Functional) | DYN |
| 72 | "프로젝트 테스트 커맨드 실행 ... `[testing].test_cmd`" | DYN (10-2 항목 3) |
| 75-78 | ` ```bash ` + `{test_cmd}` / `{type_check_cmd}` / `{lint_cmd}` | **DYN** (10-2 항목 5 빌드 검증 — 3 변수) |
| 81 | `# TS/pnpm: pnpm test; pnpm tsc --noEmit; pnpm biome check` | DOC |
| 83 | `# Rust: cargo test; cargo clippy -- -D warnings` | DOC |
| 108 | `git status로 working tree clean 확인` | AUTO (git read-only) |
| 111-114 | `git add phases/{...} REPORT.md ...` + `git commit -m "..."` | **WRITE** (git add + commit) |
| 117 | `git status --porcelain | head -1` | AUTO (git read-only + head 자동) |
| 119 | `git checkout main` | **WRITE** (branch switch) |
| 120 | `git pull origin main --ff-only` | **WRITE** (network + index 변경) |
| 121 | `git merge feat-{phase-name} --no-edit` | **WRITE** (commit) |
| 122 | `git push origin main` | **WRITE** (remote 변경 — destructive 아니지만 published) |
| 123 | `git branch -d feat-{phase-name}` | **WRITE** (branch 삭제) |

**합계**: 실 호출 13건 — AUTO 3 + WRITE 6 + DYN 4. DOC 2.

**판정**:
- DYN 호출 4건 (10-1 Functional + 10-2 항목 3/5 빌드 검증) — 모두 `.harness.toml [testing]` 동적. 프로젝트별 매트릭스:
  - Python+uv: `uv run pytest` / `uv run mypy src` / `uv run ruff check`
  - Python+poetry: `poetry run pytest` / `poetry run mypy src` / `poetry run ruff check`
  - TS+pnpm: `pnpm test` / `pnpm tsc --noEmit` / `pnpm biome check`
  - TS+bun: `bun test` / `bun tsc --noEmit`
  - Go: `go test ./...` / `go vet ./...` / `golangci-lint run`
  - Rust: `cargo test` / `cargo clippy -- -D warnings`
  - JVM+Gradle: `./gradlew test` / `./gradlew check`
- WRITE 호출 6건 (git add/commit/checkout/pull/merge/push/branch -d) — 자동 허용 set 외. broad `Bash` declare 시 prompt에 의존 (사용자 settings.json `permissions.allow`로 별도 제어 가능)
- AUTO 3건 (git read-only) — 자동 허용. declare 효과 0
- DYN 4건 (test/type_check/lint) — broad 유지가 유일한 매니페스트 가변 대응

**Edit/Write fine-grain 분석**:
- L91: "`phases/{version}/{phase-name}/REPORT.md`에 Write" — `Write(phases/**)` fine-grain 매치 ✓
- L91: "`.claude/skills/harness-ship/report-template.md` Read" — Read는 무제한 ✓
- 10-4: "`phases/ROADMAP.md` 갱신" — `Edit(phases/**)` 매치 ✓
- 10-4: "`phases/index.json` 갱신", "`phases/{version}/milestone.json` 갱신" — `Edit(phases/**)` 매치 ✓
- → `Edit(phases/**)` / `Write(phases/**)` fine-grain 정합. **유지** (R5 보존)

**결정 근거 (R3)**: broad `Bash` 유지. `Edit(phases/**)` / `Write(phases/**)` 보존. 형식만 콤마 → YAML list로 정정.

---

## 4. `bootstrap/templates/_base/.claude/agents/harness-verifier.md`

**Frontmatter (현재)**: `tools: Read, Glob, Grep, Bash` (line 4)

⚠️ 필드명 차이 — agent는 `tools:` (PERMISSION_PATTERN.md §2 매트릭스 + A2 인용). slash command/skill의 `allowed-tools:`와 별도 schema.

**본문 Bash 호출 inventory**:

| 줄 | 인용 | 분류 |
|---|---|---|
| 33 | "**1. Exists** | `Glob` 또는 파일 존재 확인" | DOC (Glob tool 호출, Bash 아님) |
| 34 | "**2. Substantive** | `Grep: TODO|FIXME|...`" | DOC (Grep tool 호출) |
| 35 | "**3. Wired** | `Grep: import.*{module}` + 사용처 존재" | DOC (Grep tool 호출) |
| 37 | "**4. Functional** | 관련 테스트 경로 탐지 + (제안만) 프로젝트 테스트 커맨드로 해당 경로 실행 ... 실제 실행은 호출자 결정" | DOC (실 호출 위임 — verifier는 제안만) |
| 75 | "테스트 실제 실행 (호출자 결정)" | DOC (금지 명시) |

**합계**: 실 호출 0건. DOC 5건.

**판정**:
- 본문 Bash 직접 호출 = **0**. verifier는 read-only analytical (L8 "no implementation, no file writes")
- L37 4-Functional 단계는 **호출자(harness-ship) 위임** — verifier는 "제안만" + "실제 실행은 호출자 결정"
- 그러나 `tools: ... Bash` declare 유지 정당화 가능:
  - **미래 확장**: 4-Functional 단계가 verifier 직접 실행으로 진화할 가능성 (harness-ship의 위임 부담 분산)
  - **호출자가 verifier에게 추가 위임 시**: harness-ship이 `Agent(subagent_type="harness-verifier")` 호출 + 추가 Bash 위임 시나리오
  - **declare 제거 위험**: 현 시점 미사용이지만 미래 코드 변경 시 silent fail (declare 없으면 baseline 폴백)
- 단순 일관성: 4 파일 중 3개 broad Bash 유지 + 1개만 제거 = 분기 증가. 동상 유지가 verbose 0 증가

**결정 근거 (R4)**: broad `Bash` 유지 + `tools:` 필드 + YAML list 정정.

---

## 5. 종합 매트릭스

| 파일 | 본문 Bash 실 호출 | DYN 비율 | WRITE 비율 | declare 결정 | 형식 정정 |
|------|:---:|:---:|:---:|:---:|:---:|
| `harness/SKILL.md` | 0 | — | — | **제거 (R2)** | YAML list (4 entries) |
| `harness-run/SKILL.md` | 5 | 100% | 0% | **유지 (R3)** | YAML list (5 entries) |
| `harness-ship/SKILL.md` | 13 | 31% (4/13) | 46% (6/13) | **유지 (R3)** | YAML list (6 entries) |
| `harness-verifier.md` | 0 | — | — | **유지 (R4)** | YAML list (4 entries, `tools:` 필드) |

**핵심 발견**:
1. `harness/SKILL.md` — 디스패처 본질상 Bash 미사용 → declare 제거가 spec 정합 (PERMISSION_PATTERN.md §5 "declare = pre-approval, 차단 아님")
2. `harness-run/SKILL.md` — 100% DYN. fine-grain 불가능 (executor 매니페스트별 가변) → broad 정당
3. `harness-ship/SKILL.md` — DYN 4 + WRITE 6. fine-grain 시도 시 fragile (PERMISSION_PATTERN.md §6 R3' Conservative)
4. `harness-verifier.md` — 본문 0이지만 미래 확장 + 일관성 위해 broad 유지

**Cross-file evidence**: 4 파일 모두 v1.8b commands → skills 마이그레이션 시 frontmatter 무변경 보존 (`git mv` 이력). 본 v1.10f가 5축 spec (PERMISSION_PATTERN.md) 사후 정합.

## 6. 관련 문서

- 본 세션 PLAN: [`../PLAN.md`](../PLAN.md)
- 5축 spec: [`../../../../bootstrap/docs/PERMISSION_PATTERN.md`](../../../../bootstrap/docs/PERMISSION_PATTERN.md)
- 선행 audit: [`../../v1.10d-bash-permission-pattern-audit/audit/A2-pattern-inventory.md`](../../v1.10d-bash-permission-pattern-audit/audit/A2-pattern-inventory.md) — 발견 6 + harness-verifier 동상 식별
- A2 인용 매트릭스: [`A2-anthropic-docs.md`](A2-anthropic-docs.md)
- A3 동적 변수 매트릭스: [`A3-dynamic-vars.md`](A3-dynamic-vars.md)
