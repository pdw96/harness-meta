# meta v1.28-source-matrix-expand — REPORT

세션 완료: 2026-04-29
선행 세션:

- [`sessions/meta/v1.27-report-spec-verification/`](../v1.27-report-spec-verification/REPORT.md) — REPORT § 의무 도입 (다음 후보 §9-2의 첫 행)
- [`sessions/meta/v1.24-plan-spec-verification/`](../v1.24-plan-spec-verification/REPORT.md) — Spec verification § 도입. 본 세션이 §4-2 매트릭스 확장 정책 첫 invocation
- [`sessions/meta/v1.21-install-cleanup-foundation/`](../v1.21-install-cleanup-foundation/audit/A1-context7-validation.md) — evidence: 매트릭스 외 PowerShell + Bash 2 source 인용 (R6/R7 결정 근거)

## 최종 결과

| 항목 | 결과 |
|------|------|
| smoke-spec-verification.sh | **PASS=31 FAIL=0 SKIP=4** (v1.28 PLAN 4 check + v1.28 REPORT 4 check 자동 흡수) |
| smoke-scope-contract.sh | **PASS=54 FAIL=0** (v1.28 +2 PLAN self-test) |
| 회귀 smoke 7건 (bash-permission/thinking-effort/language-overlay/legacy-cleanup-overlay/skills-install/sync-agents/verify-sh-parity) | **7/7 PASS** |
| verify.ps1 | **38/38 PASS** (WARN: 0, frontmatter 6축 변경 0) |
| 변경 파일 | 3건 (SPEC_VERIFICATION.md + harness-plan-verify/SKILL.md + smoke-scope-contract.sh) + PLAN/REPORT |

## 구현 요약

### Stage A — PLAN.md 작성 (사용자 확인)

4 § 의무 (세션 소속 근거 / Scope inheritance 4 sub-items / Out of scope 8 row / Spec verification drift=N/A) 포함 PLAN. **harness-plan-verify SKILL 명시 호출**로 § 검증 — drift=N/A 정당 confirm (변경 영역이 markdown table + bash array로 spec-dependent 아님). 사용자 "오케이" + "진행" 확인.

### Stage B — `bootstrap/docs/SPEC_VERIFICATION.md` 갱신 (R1 + R2)

**R1 — §4 매트릭스 2 row → 4 row**:

| 추가 Library ID | 적용 영역 | 등재 근거 |
|-----------------|---------|---------|
| `/microsoftdocs/powershell-docs` | PS 7+ shell spec — `$null` chain / `?.` `?[]` operators / `Select-String` no-match / `New-Item` SymbolicLink | v1.21 audit/A1 인용 1, 2 |
| `/websites/gnu_software_bash_manual_html_node` | GNU Bash manual — errexit + `&&`/`\|\|` lists / glob `nullglob`/`failglob` / Bourne-Shell-Builtins | v1.21 audit/A1 인용 3, 4 |

**R2 — §4-2 정책 명문화**:

- "재발 임계 = 1회" 명문화 (v1.28 명시)
- 등재 3 조건: 권위 source / context7 resolve 가능 / 재발 가능성
- 비등재 2 조건: 단발 인용 + 재발 0 / 권위 약함 (v1.19 L6 `/zebbern/claude-code-guide` 정합)
- v1.24c → v1.X 일반화 (v1.28까지 누적)
- §4-3 신설 — v1.28 적용 사례 (등재 source × 등재 3 조건 매트릭스 + `/zebbern/...` 비등재 사례 표기)

**§4-1 매트릭스 사용 갱신**: Step 2 keyword 분기 명시 — Claude Code spec / Cross-platform shell spec 두 도메인 매핑.

### Stage C — `bootstrap/skills/harness-plan-verify/SKILL.md` Step 2 갱신 (R3)

기존 2 source 단순 list → **4 source 매트릭스 도메인 분기**:

- Claude Code spec → `/websites/code_claude` (1차) + `/anthropics/claude-code` (보조)
- Cross-platform shell spec → `/microsoftdocs/powershell-docs` (PS) + `/websites/gnu_software_bash_manual_html_node` (Bash). 활성 keyword: `install` / `verify` / `PowerShell` / `Bash` / `null` / `errexit`

frontmatter (name/allowed-tools/model/effort/description) 변경 0 → V10/V1/V5/V7/V8/V9 6축 회귀 0.

### Stage D — `tests/smoke-scope-contract.sh` v1.28 glob (R4)

`plans` 배열에 `sessions/meta/v1.28*/PLAN.md` 1줄 추가. 자동 enumerate 매핑으로 본 세션 PLAN.md 2 stage 흡수 → PASS 52 → **54**.

`smoke-spec-verification.sh`는 **변경 0** — 기존 `meta_plans=(sessions/meta/v1.2[4-9]*/PLAN.md ...)` + `meta_reports=(sessions/meta/v1.2[7-9]*/REPORT.md ...)` glob이 v1.28 자동 흡수 (PLAN의 변경 안 하는 파일 표 1번째 행 정합).

## 판정

| PLAN 성공 기준 | 결과 |
|----------------|------|
| `SPEC_VERIFICATION.md §4` 표 4 row | ✅ |
| `SPEC_VERIFICATION.md §4-2` 재발 임계 1회 명문화 + 등재 3 조건 + 비등재 2 조건 | ✅ |
| `SPEC_VERIFICATION.md §4-3` v1.28 적용 사례 (etalon) | ✅ (PLAN scope 외 추가 — Stage B 자연 확장) |
| `harness-plan-verify/SKILL.md` Step 2 4 source 매트릭스 + cross-platform shell sub-area | ✅ |
| `tests/smoke-scope-contract.sh` v1.28 glob 추가 | ✅ |
| smoke-scope-contract PASS=54 (52 + v1.28 +2) | ✅ |
| smoke-spec-verification PASS=29 (예상) | ✅ (실제 31 — Stage 1~4 + Stage 5/6 분포 — v1.28 4 check 자동 흡수) |
| 회귀 0 — 기존 smoke 9건 + verify.ps1 38/38 | ✅ |
| v1.28 PLAN/REPORT 본 SKILL 검증 통과 (drift=N/A 부분 N/A 금지) | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (매트릭스 자체 확장은 내부 규약 변경. PLAN § 동일 — Stage B/C/D 구현 중 신규 spec drift 발견 없음) |
| **re-verify** | N/A |

## Lessons Learned

### L1 — §4-2 첫 invocation으로 "재발 임계" 명문화 (preemptive ROI)

v1.24에서 정의된 §4-2 정책이 v1.28에서 처음 작동. PLAN Stage B 작성 중 "재발 시"의 정확한 임계가 모호함을 인지 → 1회 명문화 + 등재 3 조건 / 비등재 2 조건 분리. 후속 세션이 모호성을 발견하기 전에 본 세션에서 해소 (preemptive clarification ROI). v1.10j Scope contract 패턴과 동일 — mechanism 첫 사용 시 mechanism 자체 정밀화.

### L2 — Cross-platform shell source 등재가 자연 도메인 분리

harness-meta가 PowerShell + Bash 양쪽 install/verify dual maintain → 2 source 재발 자연. §4-1 사용 절차에 keyword 분기 (Claude Code spec / Cross-platform shell spec) 명시로 향후 SKILL Step 2 lookup 비용 ↓. v1.21 1회 인용 → v1.28 등재로 cross-platform 도구 작성 세션 (v1.29-verify-fix-mode 등) 매트릭스 즉시 활용 가능.

### L3 — Anthropic 외부 source benchmark `—` 표기 정착

`/anthropics/claude-code` (plugin-dev)이 이미 `—` 표기. Microsoft / GNU 같은 외부 권위 source는 Anthropic 공식 benchmark 메타 자체가 부재 — `—` 표기 일반화 + "인용 정합 자체가 benchmark 대용" 정책 §4-2 명시. 향후 Microsoft Docs / GitHub Docs / 표준 단체 등 추가 source도 동일 처리.

### L4 — Stage B 자연 확장으로 §4-3 etalon 신설

PLAN scope에 §4-3 항목 미명시였으나 Stage B 갱신 중 "정책만 명문화하면 추후 적용 사례가 흩어진다" 인지 → §4-3 v1.28 적용 사례 표 신설. 등재 source × 등재 3 조건 매트릭스 + 비등재 사례 명시로 §4-2 정책의 etalon 역할. 향후 §4-2 진입 시 §4-3 표 형식으로 추가 (mechanism 자기-문서화).

### L5 — smoke 변경 안 하는 파일 표가 회귀 확인 시간 단축

PLAN "변경 안 하는 파일 (회귀 0 보장)" 표 7건 명시 → Stage D에서 smoke-spec-verification.sh / verify.ps1 등 검증 시 "기대값 = 무변경" 사전 정의. 실제 PASS=31 결과가 27+4 (자동 흡수 4 check)로 정합 — 표가 검증 hypothesis 역할.

## 다음 후보 (보류)

| 세션 | 조건 |
|------|------|
| `v1.28b-anthropic-sdk-source` | claude-api skill (user-skill) 활용 evidence 누적 시. Anthropic SDK 매트릭스 등재 |
| `v1.28c-agents-md-source` | agents.md 표준 인용 재발 시. AGENTS_MD_STRATEGY.md 변경 세션이 외부 spec 검증 필요할 때 |
| `v1.28d-spdx-pep-source` | detect-project.sh 4-tier license 감지 변경 또는 PEP 621/639 재인용 시 |
| `v1.29-verify-fix-mode` | smoke `--fix` mode (§ skeleton 자동 삽입). 본 세션 매트릭스 활용 첫 사례 가능성 |
| `v1.30-precommit-hook` | pre-commit hook으로 smoke-spec-verification 강제 |
