# meta v1.28-source-matrix-expand — PLAN

세션 시작: 2026-04-29
직접 선행 세션:
- [`sessions/meta/v1.27-report-spec-verification/`](../v1.27-report-spec-verification/REPORT.md) — REPORT § 의무 도입 (다음 후보 §9-2의 첫 행)
- [`sessions/meta/v1.24-plan-spec-verification/`](../v1.24-plan-spec-verification/REPORT.md) — Spec verification § 도입. 본 세션은 §4-2 매트릭스 확장 정책 첫 invocation
- [`sessions/meta/v1.21-install-cleanup-foundation/`](../v1.21-install-cleanup-foundation/audit/A1-context7-validation.md) — evidence: 매트릭스 외 PowerShell + Bash 2 source 인용 (R6/R7 결정 근거)

목적: `bootstrap/docs/SPEC_VERIFICATION.md §4` Context7 source matrix 2 row → **4 row** 확장. v1.21 audit가 이미 인용한 cross-platform shell spec 2종(PowerShell + GNU Bash)을 매트릭스에 등재해 향후 install/verify 스크립트 재변경 시 lookup cost 0 보장. §4-2 "재발 임계 = 1회" 정책 명문화.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S2(2) `bootstrap/docs/SPEC_VERIFICATION.md` + `bootstrap/skills/harness-plan-verify/SKILL.md` + S3(1) `tests/smoke-scope-contract.sh` (v1.28 glob 추가) = **3/3 meta**
- **T1 경로 다수결** — meta scope 3/3
- **T2 스펙 vs 값** — 매트릭스 = 모든 메타 PLAN의 외부 spec lookup 단일 소스 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `bootstrap/docs/SPEC_VERIFICATION.md §4-2` (verbatim)**:

> 신규 외부 spec(Anthropic SDK / agents.md / 외부 라이브러리) 의존 세션 발생 시:
> 1. `sessions/meta/v1.24c-source-matrix-expand/` 별 세션 진행
> 2. 해당 라이브러리 ID context7 resolve → benchmark 확인
> 3. 본 §4 표에 행 추가
>
> 매트릭스 부재 라이브러리는 PLAN의 § findings에 임시 인용 가능하나 **재발 시 매트릭스 등재 의무**.

**Source 2 — `sessions/meta/v1.27-report-spec-verification/REPORT.md` 다음 후보 (verbatim)**:

> | `v1.28-source-matrix-expand` | context7 source 매트릭스 확장 — evidence-driven |

**Source 3 — `sessions/meta/v1.21-install-cleanup-foundation/audit/A1-context7-validation.md` 인용 (verbatim)**:

> ## 인용 1 — PowerShell 7+ null property access
> Source: `/microsoftdocs/powershell-docs` — `everything-about-null.md`
> ## 인용 3 — Bash errexit + && || lists
> Source: `/websites/gnu_software_bash_manual_html_node` — `Bourne-Shell-Builtins.html`

**Parsed sub-items (4)**:

1. **§4 매트릭스 확장 — 2 row 추가** — `/microsoftdocs/powershell-docs` + `/websites/gnu_software_bash_manual_html_node`
2. **§4-2 정책 갱신** — "재발 임계 = 1회" 명문화 + v1.24c → v1.28 self-reference
3. **SKILL `harness-plan-verify` Step 2 갱신** — 매트릭스 lookup 4 source 표기
4. **smoke-scope-contract.sh v1.28 glob 추가** — Scope contract self-test 흡수

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| Anthropic SDK (`anthropic` PyPI / `@anthropic-ai/sdk` NPM) 매트릭스 등재 | v1.28b 후속 — claude-api skill 활용 evidence 누적 후 (현재 harness-meta 자체 SDK 사용 0) |
| agents.md (https://agents.md/) 매트릭스 등재 | v1.28c 후속 — context7 resolve 가능성 미확인 + AGENTS_MD_STRATEGY.md 외부 인용 1건 only (재발 임계 미충족) |
| SPDX / PEP 621 / PEP 639 / npm package.json schema 매트릭스 등재 | v1.10e/e2/e3 detect-project.sh 직접 URL 인용만 (context7 사용 흔적 0). 별 후속 evidence-driven |
| `/zebbern/claude-code-guide` 매트릭스 등재 | v1.19 1건 인용 + L6 "권위 약함" 명시. 권위 source 부재 시 보조 — 매트릭스 부적합 |
| smoke-spec-verification.sh `meta_plans` glob 갱신 | 기존 `v1.2[4-9]*/PLAN.md` 패턴이 v1.28 자동 흡수 — 변경 불필요 |
| smoke-spec-verification.sh `meta_reports` glob 갱신 | 기존 `v1.2[7-9]*/REPORT.md` 패턴이 v1.28 자동 흡수 — 변경 불필요 |
| 매트릭스 행 추가 시 context7 query로 benchmark 재확인 | 본 세션 scope 외 (§4-2 절차 단계 2) — Anthropic 공식 benchmark 메타 부재이므로 `—` 표기 (v1.21 인용 정합 자체가 benchmark 대용) |
| dynamic 검증 (실제 PowerShell/Bash query 재실행) | sessions/meta/v1.25 같은 multi-OS validation 세션의 책임. 본 세션 scope 외 |
| PERMISSION_PATTERN.md 외부 reference § 갱신 | 동상 (cross-ref만, 본 세션은 SPEC_VERIFICATION.md 단일 소스 우선) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (SPEC_VERIFICATION.md §4 매트릭스 자체 확장은 내부 규약 변경. 매트릭스에 추가될 2 source의 v1.21 인용 정합은 v1.21 audit 시점에 이미 검증됨 — 본 세션이 재query하지 않음) |
| **re-verify** | N/A |

## 1. 문제 (매트릭스 외 lookup 비용)

### 현재 상태

`SPEC_VERIFICATION.md §4` 매트릭스 = **2 row**:
- `/websites/code_claude` (Claude Code 공식, benchmark 83.6)
- `/anthropics/claude-code` (plugin-dev 보조)

→ Claude Code spec 영역만 cover.

### v1.21 audit 시 발생한 우회

`v1.21-install-cleanup-foundation` 세션은 install-project-claude.{ps1,sh} v1.11 latent crash (PS `Select-String` null chain) 해소를 위해 **매트릭스 외 2 source** 인용:

| Library ID | v1.21 인용 | 결정 영향 |
|------------|-----------|---------|
| `/microsoftdocs/powershell-docs` | 인용 1 (`$null` property access), 인용 2 (`?.` operators) | R6 Section 2.0 null-safe pattern |
| `/websites/gnu_software_bash_manual_html_node` | 인용 3 (errexit + `&&`/`\|\|`), 인용 4 (`nullglob`/`failglob`) | R7 if-else 형식 + R8 literal interpolation |

§4-2 "재발 시 매트릭스 등재 의무" 정책 — v1.21에서 **첫 인용** 발생. 향후 install/verify 변경 세션에서 재인용 시 **매트릭스 부재 비용** (lookup 절차 즉흥 판단 + library ID resolve 반복).

### 예측 가능한 재발 시나리오

| 시나리오 | 재인용 source |
|---------|------------|
| `v1.29-verify-fix-mode` (smoke `--fix`) | bash sed/awk + glob 동작 |
| `v1.30-precommit-hook` | bash hook + errexit |
| 향후 install-skills.{ps1,sh} / sync-agents.{ps1,sh} 변경 | PS `Select-String` / bash compound list |
| Cross-platform symlink 처리 변경 | PS `New-Item -ItemType SymbolicLink` / bash `ln -s` MSYS edge |

### Root cause

**매트릭스 등재 임계 모호** — v1.21에서 1회 인용 발생했으나 "재발"의 정확한 임계가 §4-2에 미명시. "재발 임계 = 1회"로 명문화하면 본 세션이 임계 충족 → 매트릭스 등재.

## 2. 결정 (R1 ~ R3)

### R1 — 매트릭스 §4 표 2 row → 4 row 확장

```markdown
| Library ID | 용도 | 적용 영역 | benchmark |
|------------|------|---------|-----------|
| `/websites/code_claude` | Claude Code 공식 docs (1차) | SKILL/hook/permission/frontmatter/agent/slash command/MCP | 83.6 |
| `/anthropics/claude-code` | plugin-dev (2차, conflict 검증) | frontmatter-reference / agent-development / mcp-integration | — |
| `/microsoftdocs/powershell-docs` | PowerShell 7+ shell spec (cross-platform install/verify) | `$null` property access / `?.` `?[]` operators / `Select-String` no-match / `New-Item` SymbolicLink | — |
| `/websites/gnu_software_bash_manual_html_node` | GNU Bash manual (cross-platform install/verify) | errexit + `&&`/`\|\|` lists / glob `nullglob`/`failglob` / Bourne-Shell-Builtins | — |
```

**근거**:
- 두 source 모두 v1.21 audit/A1에서 인용 (문서 cross-ref로 검증됨)
- Anthropic 공식 benchmark 부재 (Microsoft / GNU 외부 권위 source) → `—` 표기 (Anthropic plugin-dev `/anthropics/claude-code`도 동일 표기)
- 적용 영역은 v1.21 audit 인용 1~4의 sub-area를 정확히 인용

### R2 — §4-2 매트릭스 확장 정책 명문화

```markdown
### 4-2. 매트릭스 확장 정책

신규 외부 spec(Anthropic SDK / agents.md / 외부 라이브러리) 의존 세션 발생 시:

1. `sessions/meta/v1.X-source-matrix-expand/` 별 세션 진행 (현재 v1.28까지 발생)
2. 해당 라이브러리 ID context7 resolve → benchmark 확인 (Anthropic 외부 source는 `—` 표기 허용)
3. 본 §4 표에 행 추가

**재발 임계 = 1회** (v1.28에서 명문화). 매트릭스 부재 라이브러리가 1개 세션에서 인용된 시점부터 등재 후보. 단, 다음 조건 모두 충족 시:

- 권위 source (공식 docs / 표준 단체 / 주요 벤더) — 커뮤니티 가이드는 보조 인용만 허용 (매트릭스 부적합, v1.19 L6 정합)
- context7 resolve 가능 (library ID 형식 `/<owner>/<repo>` 또는 `/websites/<host>`)
- 향후 재인용 가능성 (cross-platform 도구 / 표준 spec / 본 repo 핵심 의존)

**비등재 조건**:
- 단발 인용 + 재발 가능성 0 (특정 비즈니스 코드 / 일회성 마이그레이션)
- 권위 약함 (커뮤니티 가이드 / 개인 블로그)

매트릭스 부재 라이브러리는 PLAN의 § findings에 임시 인용 가능하나 **재발 시 본 §4-2 절차 진입 의무**.
```

**변경**:
- "재발 시" → "재발 임계 = 1회 (v1.28에서 명문화)"
- 등재 조건 3건 명시 (권위 / context7 resolve / 재발 가능성)
- 비등재 조건 2건 명시 (단발 + 권위 약함)
- v1.24c → v1.X 일반화 (현재 v1.28까지 발생)

### R3 — SKILL `harness-plan-verify` Step 2 표기 갱신

기존 Step 2:
```markdown
2. 매칭된 spec area에 해당하는 library ID 선택:
   - 기본: `/websites/code_claude` (Claude Code 공식 docs)
   - 보조 (conflict 검증): `/anthropics/claude-code` (plugin-dev)
```

신규 Step 2:
```markdown
2. 매칭된 spec area에 해당하는 library ID 선택 (4 source matrix):
   - **Claude Code spec** (SKILL/hook/permission/frontmatter/agent/slash command/MCP)
     - 기본: `/websites/code_claude` (공식 docs, benchmark 83.6)
     - 보조: `/anthropics/claude-code` (plugin-dev, conflict 검증)
   - **Cross-platform shell spec** (install/verify 스크립트 변경 세션)
     - PowerShell 7+: `/microsoftdocs/powershell-docs`
     - GNU Bash: `/websites/gnu_software_bash_manual_html_node`
```

**근거**: Step 1 keyword grep에서 `install` / `verify` / `PowerShell` / `Bash` / `null` / `errexit` 매칭 시 cross-platform shell source 선택이 명확해야 향후 세션 lookup 효율 ↑.

## 3. 변경 대상 (3 수정 + 2 신규)

### 수정 (3)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/docs/SPEC_VERIFICATION.md` | S2 | R1 §4 표 2 row → 4 row + R2 §4-2 정책 명문화 |
| `bootstrap/skills/harness-plan-verify/SKILL.md` | S2 | R3 Step 2 — 4 source 매트릭스 표기 + cross-platform shell sub-area |
| `tests/smoke-scope-contract.sh` | S3 | v1.28 glob 1줄 추가 (Scope contract self-test 흡수) |

### 신규 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.28-source-matrix-expand/PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.28-source-matrix-expand/REPORT.md` | meta | Stage E |

### 변경 안 하는 파일 (회귀 0 보장)

| 경로 | 이유 |
|------|------|
| `tests/smoke-spec-verification.sh` | `meta_plans=(sessions/meta/v1.2[4-9]*/PLAN.md ...)` glob이 v1.28 자동 흡수. `meta_reports=(sessions/meta/v1.2[7-9]*/REPORT.md ...)` 동상 |
| `verify.{ps1,sh}` | `$frontmatterFiles` / `FRONTMATTER_FILES` 배열 변경 0 (SKILL 파일 자체 추가 없음, harness-plan-verify SKILL은 이미 v1.24에서 등재) |
| `tests/smoke-bash-permission-pattern.sh` | FILES 배열 변경 0 (동상) |
| `claude/commands/harness-meta.md` | PLAN 필수 § list는 v1.24/v1.27에서 이미 갱신 (SPEC_VERIFICATION.md 단일 소스 cross-ref 유지) |
| `bootstrap/docs/PERMISSION_PATTERN.md` | 외부 reference § 변경 0 (PowerShell/Bash spec은 SPEC_VERIFICATION.md §4 단일 소스로 분리) |
| `bootstrap/docs/SKILLS.md` | §1 매트릭스 변경 0 (SKILL 4건 동일) |
| `CLAUDE.md` | 관련 문서 § 변경 0 (SPEC_VERIFICATION.md 이미 등재) |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 + 4 § 의무 (세션 소속 근거 / Scope inheritance / Out of scope / Spec verification)
- [ ] **사용자 PLAN 확인**
- [ ] Stage B — `bootstrap/docs/SPEC_VERIFICATION.md` (R1 §4 + R2 §4-2)
- [ ] Stage C — `bootstrap/skills/harness-plan-verify/SKILL.md` (R3 Step 2)
- [ ] Stage D — `tests/smoke-scope-contract.sh` (v1.28 glob)
- [ ] Stage E — Smoke 9건 + verify 회귀 검증 (PASS=53 예상)
- [ ] Stage F — REPORT.md (v1.27+ § 의무 포함)
- [ ] **사용자 커밋 확인**

## 5. 성공 기준

- [ ] `SPEC_VERIFICATION.md §4` 표 4 row (`/microsoftdocs/powershell-docs` + `/websites/gnu_software_bash_manual_html_node` 추가)
- [ ] `SPEC_VERIFICATION.md §4-2` "재발 임계 = 1회" 명문화 + 등재 3 조건 + 비등재 2 조건
- [ ] `harness-plan-verify/SKILL.md` Step 2 — 4 source 매트릭스 + cross-platform shell sub-area
- [ ] `tests/smoke-scope-contract.sh` plans 배열에 `sessions/meta/v1.28*/PLAN.md` 추가
- [ ] `tests/smoke-scope-contract.sh` PASS=54 (52 + v1.28 PLAN 2 stage 흡수 = +2)
- [ ] `tests/smoke-spec-verification.sh` PASS=29 (27 + v1.28 PLAN 2 check 자동 흡수 = +2)
- [ ] 회귀 0 — 기존 smoke 9건 전체 + verify.ps1 38/38 유지
- [ ] v1.28 PLAN/REPORT 본 SKILL 검증 통과 (drift=N/A 부분 N/A 금지)

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.28-source-matrix-expand — Context7 source matrix 4 row 확장

- update: bootstrap/docs/SPEC_VERIFICATION.md (R1 §4 표 2 → 4 row + R2 §4-2 재발 임계 1회 명문화)
- update: bootstrap/skills/harness-plan-verify/SKILL.md (R3 Step 2 — 4 source 매트릭스 + cross-platform shell sub-area)
- update: tests/smoke-scope-contract.sh (v1.28 glob 1줄 추가)
- add: sessions/meta/v1.28-source-matrix-expand/{PLAN,REPORT}.md

Scope: §4 매트릭스 evidence-driven 확장 (v1.21 audit 인용 발생 후 첫 invocation).
- /microsoftdocs/powershell-docs (PS 7+ null/operator/Select-String spec — v1.21 R6)
- /websites/gnu_software_bash_manual_html_node (errexit + glob — v1.21 R7/R8)
- §4-2 재발 임계 1회 명문화 + 등재 3 조건 (권위 / context7 resolve / 재발 가능성) + 비등재 2 조건

Smoke: smoke-spec-verification 29/29 (자동 흡수) + smoke-scope-contract 54/54 + 회귀 7건 PASS.
verify.ps1 38/38 유지 (frontmatter 6축 변경 0).
```

## 7. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.28b-anthropic-sdk-source` | claude-api skill (user-skill) 활용 evidence 누적 시. Anthropic SDK (`anthropic` PyPI / `@anthropic-ai/sdk`) 매트릭스 등재 |
| `v1.28c-agents-md-source` | agents.md (https://agents.md/) 표준 인용 재발 시. AGENTS_MD_STRATEGY.md 변경 세션이 외부 spec 검증 필요할 때 |
| `v1.28d-spdx-pep-source` | detect-project.sh 4-tier license 감지 변경 또는 PEP 621/639 spec 재인용 시. 현재 v1.10e/e2/e3 직접 URL 인용만 |
| `v1.29-verify-fix-mode` | smoke `--fix` mode (§ skeleton 자동 삽입). 본 세션 매트릭스 활용 첫 사례 가능성 |
| `v1.30-precommit-hook` | pre-commit hook으로 smoke-spec-verification 강제 |

## 8. Lessons Forward (예상)

- **L1 — §4-2 첫 invocation으로 "재발 임계" 명문화** — v1.24에서 정의된 정책이 v1.28에서 처음 작동. 임계 모호성을 후속 세션이 발견하기 전에 본 세션에서 명문화 (preemptive clarification ROI).
- **L2 — Cross-platform shell source는 install/verify 도구 dual mainted 정합 자연 결과** — harness-meta가 PowerShell+Bash 양쪽 maintain → 두 source 재발 자연. 매트릭스 등재가 자연스러운 도메인 분리.
- **L3 — Anthropic 외부 source는 benchmark `—` 표기 허용** — `/anthropics/claude-code` 도 동일 표기. Microsoft / GNU 같은 외부 권위 source는 Anthropic 공식 benchmark 메타 부재이나 v1.21 인용 정합이 benchmark 대용.
- **L4 — Out of scope 표가 8건으로 over-scope 차단 의식 동작** — Anthropic SDK / agents.md / SPDX / PEP / smoke glob / verify / dynamic 검증 / cross-ref 8건 explicit reject로 본 세션 scope 3 row 변경에 집중.
