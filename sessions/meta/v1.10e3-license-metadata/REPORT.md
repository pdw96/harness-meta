# meta v1.10e3-license-metadata — REPORT (T1+T2+T3 4-tier)

세션 종료: 2026-04-28 (단일 세션 내 완료)
선행: [`v1.10e2`](../v1.10e2-license-boilerplate/REPORT.md) (T1+T2 boilerplate, sample 20 70%) → 본 세션 (T3 메타, sample 30 OSS 100%)
PLAN: [`PLAN.md`](PLAN.md)

## 최종 결과

- **변경 파일**: 14 (수정 9 + 신규 5 audit + 1 smoke + 3 evidence + PLAN/REPORT) = 18 (정정 — 자세히 §변경 파일 §)
- **자동 적용 카운트**: 7 유지 (manifest 4 + 콘텐츠 3 — bootstrap_version + install_cmd + license; T3는 기존 `{{license}}` 변수에 흡수, 신규 변수 0)
- **bootstrap_version stamp**: `1.10e2` → `1.10e3`
- **smoke**: 14/14 PASS — `evidence/smoke-bootstrap-license-metadata.txt`
- **회귀 (v1.10e2)**: 18/18 PASS — `evidence/regression-smoke-license-boilerplate.txt`
- **회귀 (v1.10e)**: 5/5 PASS — `evidence/regression-smoke-license-detect.txt`

## 구현 요약 — Option C 후속의 후속 (T3 메타 4 source)

### Stage A — Audit evidence (5 파일, audit/A1-A5)

| 파일 | 핵심 내용 |
|------|----------|
| `audit/A1-metadata-sources.md` | 4 source 정밀 spec (1차 spec WebFetch 검증 4건: npm CLI v10 + PEP 639 Final 2024-05 + Poetry docs + Cargo manifest). package.json string + legacy `{type, url}` object 부분 지원 + UNLICENSED + SEE LICENSE IN. pyproject (PEP 639 modern + PEP 621 inline `{text}` `{file}` + Poetry deprecated). Cargo `[package].license` SPDX expression 보존 + license-file 보강. 한계 명시 (multi-line inline / dynamic license / monorepo recursive / npm `licenses` legacy array) |
| `audit/A2-recovery-rate.md` | sample 30건 (v1.10e2 20 + 메타 only 10). v1.10e3 신규 노출 4 시나리오 (#21-24): LICENSE 부재 + 메타 only. **OSS 추출률 16/16 (100%)**. False positive 0. Edge case 5종 (Anthropic non-SPDX EULA / SEE LICENSE IN proprietary / Oracle 공백 form / pyproject license 부재 / package.json license 부재) |
| `audit/A3-detect-strategy.md` | 4-tier bash 알고리즘 + helper 함수 6개 시그니처 + POSIX awk 호환 (BSD/macOS/MINGW). GNU awk extension `match()` 3-arg 회피 → section flag + sed 후처리. tomllib/jq 회피 정당화. 보안 매트릭스 (path traversal / DoS / 명령 주입 / symlink follow) + 실행시간 ~50ms 추가 |
| `audit/A4-policy-decisions.md` | R1-R10 + Grey 7건 (G1-G5 PLAN + G6 G7 신규: G6=non-SPDX 메타 보존 / G7=T2.5 license-file 분류) + scope 매트릭스 (포함 12 + 제외 6 → v1.10h/별도 후속) |
| `audit/A5-priority-rationale.md` | G1 (LICENSE 콘텐츠 우선) 정밀 정당화 — 4 정당화 축 (의도 hierarchy / 의미 정확도 4/4 vs 메타 우선 2/4 / 권위 도구 일치 (GitHub Linguist + licensee) / 계층 일관성). v1.10c 거부 3 이유 (spec 위반 / 의도 위배 / 권위 도구 불일치) 모두 무력화. 5 시나리오 검증 (proprietary / OSS+SPDX / OSS+boilerplate / LICENSE 부재+메타 / 메타 vs LICENSE conflict) |

### Stage B — `bootstrap/detect-project.sh` 갱신

- v1.10e2 main flow 보존 + T2.5 + T3 추가 (~80 라인 추가)
- 신규 helper 함수 7개:
  - `_t1_match` — T1 SPDX 헤더 매칭 (재사용 위해 함수화 — SEE LICENSE IN 재귀 + pyproject `{file}` 재귀에서 사용)
  - `_sanitize_path` — `..` / 절대경로 (Unix `/` + Windows `C:`) / null byte / 1KB 초과 거부
  - `_metadata_pyproject_pep639` — `[project] license = "..."` (PEP 639 modern, awk section flag)
  - `_metadata_pyproject_pep621_text` — `[project] license = {text = "..."}` (legacy)
  - `_metadata_pyproject_pep621_file` — `[project] license = {file = "..."}` → 1회 재귀 (T1/T2)
  - `_metadata_pyproject_poetry` — `[tool.poetry] license = "..."` (deprecated)
  - `_metadata_npm` — `package.json "license": "..."` 또는 legacy `{type, url}` object (`type` 필드 부분 지원, multi-line + minified 모두). **Anchor 완화** — `^[[:space:]]*"license"` 대신 `"license"[[:space:]]*:` (single-line minified JSON `{"license":"MIT"}` 처리)
  - `_metadata_cargo` — `Cargo.toml [package] license = "..."` (SPDX expression 보존)
  - `_metadata_cargo_license_file` — `Cargo.toml [package] license-file = "<path>"` → license_path 보강 (T2.5)
- main flow 4-tier 가드 chain: T1 → T2-Multi → T2 boilerplate → T2.5 (Cargo license-file) → T3 (M2 → M2-legacy → M2-file → M3 → M1 → M4) → SEE LICENSE IN 1회 재귀 → UNLICENSED 정규화 → T4 silent

### Stage C — interview.md / INTERVIEW_FLOW.md 갱신

- `bootstrap/interview.md` "License 처리" § 본문 재작성 — 4-tier 명시 (T1 SPDX + T2-Multi + T2 boilerplate + **T2.5 Cargo license-file 보강 + T3 메타 4 source**) + LICENSE 콘텐츠 우선 정책 (G1) + Recovery rate (0% → 70% → 100% sample 30) + 후속 v1.10h 분기 + Match priority + 보안 명시
- `bootstrap/interview.md` 헤더 + 자동 적용 표 — `1.10e2` → `1.10e3`
- `bootstrap/docs/INTERVIEW_FLOW.md` §2 Stage S3 preview literal — `{{license}}` 행 4-tier 명시 (T1/T2-Multi/T2/T2.5/T3 M2/M2-legacy/M2-file/M3/M1/M4) + WARN 메시지 갱신 (T3 메타 매칭 시 LICENSE 부재 가능 안내) + 6 우선순위 footnote
- `bootstrap/docs/INTERVIEW_FLOW.md` §3.3 v1.10e/e2 변수 표 → v1.10e/e2/e3 갱신 (4-tier 감지 + bootstrap_version fallback `1.10c` → `1.10e3`)

### Stage D — Smoke (14 stage PASS + 회귀 18/18 + 5/5 PASS)

`tests/smoke-bootstrap-license-metadata.sh` 신규 — 14 stage:

- Stage 1: M1 npm string MIT
- Stage 2: M2 PEP 639 modern Apache-2.0
- Stage 3: M2-legacy PEP 621 inline `{text}` MIT
- Stage 4: M3 Poetry GPL-3.0
- Stage 5: M4 Cargo dual `MIT OR Apache-2.0`
- Stage 6: UNLICENSED → `LicenseRef-UNLICENSED` 정규화
- Stage 7: SEE LICENSE IN custom.txt → T1 SPDX BSD-3-Clause
- Stage 8: LICENSE 우선 (T2 MIT over 메타 Apache-2.0)
- Stage 9: LICENSE 부재 + 메타 ISC (v1.10e3 신규 회복)
- Stage 10: T4 silent (메타 부재)
- Stage 11: pyproject 우선순위 (PEP 639 MIT over poetry GPL-3.0)
- Stage 12: Path traversal 차단 (`SEE LICENSE IN ../../etc/passwd` → silent)
- Stage 13: T2.5 Cargo license-file 보강 → ISC
- Stage 14: npm legacy `{type, url}` object 부분 지원 → MIT

회귀:

- `tests/smoke-bootstrap-license-boilerplate.sh` 18/18 PASS — v1.10e2 변경 없이 PASS
- `tests/smoke-bootstrap-license-detect.sh` 5/5 PASS — v1.10e 변경 없이 PASS

evidence:

- `evidence/smoke-bootstrap-license-metadata.txt`
- `evidence/regression-smoke-license-boilerplate.txt`
- `evidence/regression-smoke-license-detect.txt`

### Stage E — claude/commands/harness-meta.md + skeletons/projects/INTERVIEW.md + manifest-schema.md + CLAUDE.md/README.md 정합

- `claude/commands/harness-meta.md` S2 행 — `license 3-tier v1.10e/e2` → `license 4-tier v1.10e/e2/e3 — T1 SPDX + T2-Multi dual + T2 boilerplate 12 패턴 + T3 메타 4 source`
- `bootstrap/skeletons/projects/INTERVIEW.md` 자동 적용 표 — bootstrap_version `1.10e2` → `1.10e3` + `{{license}}` 4-tier 갱신 (LICENSE 콘텐츠 우선 정책 + UNLICENSED 정규화 + SEE LICENSE IN 재귀 명시)
- `bootstrap/manifest-schema.md` L437 — license `v1.10e2` → `v1.10e3` (T2.5 Cargo license-file 보강 + T3 메타 4 source 추가)
- `CLAUDE.md` / `README.md` — 최신 meta 세션 v1.10e2 → v1.10e3 + 자동 적용 항목 갱신 (4-tier)

## 판정 (PLAN 체크박스)

- [x] 세션 디렉토리 생성
- [x] PLAN.md 초안 작성
- [x] 사용자 PLAN 확인
- [x] Stage A — audit/A1-A5 5 파일 작성
- [x] Stage B — `bootstrap/detect-project.sh` T2.5 + T3 메타 4 source + helpers 7개 추가
- [x] Stage C — interview.md / INTERVIEW_FLOW.md 갱신 (license § 4-tier + bootstrap_version 1.10e2 → 1.10e3)
- [x] Stage D — `tests/smoke-bootstrap-license-metadata.sh` 14 stage PASS
- [x] 회귀 v1.10e2 18/18 + v1.10e 5/5 PASS
- [x] evidence 3 파일 저장
- [x] CLAUDE.md / README.md / claude/commands/harness-meta.md / manifest-schema.md / skeletons INTERVIEW.md 정합 갱신
- [x] REPORT.md 작성
- [ ] **사용자 확인 후 단일 커밋 + push** ← 진행 대기

**PLAN 11/12 완수**.

## v1.10c 거부 결정과의 정합성 (audit/A5 검증)

| 측면 | v1.10c 거부 (injection) | v1.10e (T1) | v1.10e2 (T2) | **v1.10e3 (T3)** |
|------|:-----------------------:|:-----------:|:------------:|:--------------:|
| 행위 유형 | injection (default 강제) | observation (헤더 read) | observation (콘텐츠 read) | **observation (메타 read)** |
| Trigger | LICENSE 부재여도 stamp | SPDX 헤더 존재 시만 | boilerplate 텍스트 존재 시만 | **메타데이터 명시 시만** |
| 사용자 declaration | 없음 | 있음 (SPDX 헤더) | 있음 (boilerplate 동의) | **있음 (4 spec 표준)** |
| 의도 위배 risk | 있음 | 0 | 0 (1건 한계) | **0** (1건 한계 — non-SPDX 메타 보존) |
| spec 정합 | ✗ (강제) | ✓ (SPDX 표준) | ✓ (Linguist/licensee) | **✓** (npm/PEP 639/Poetry/Cargo 4 표준) |
| 권위 도구 일치 | ✗ | ✓ | ✓ | **✓** (npm registry / crates.io / PyPI / Linguist) |

→ v1.10e3도 v1.10c 거부 3 이유 모두 무력화. 4-tier 모두 observation 본질 동일.

## v1.10e2와의 비교 — OSS 추출률 향상 evidence

| 측면 | v1.10e (T1 only sample 20) | v1.10e2 (T1+T2 sample 20) | **v1.10e3 (T1+T2+T3 sample 30)** |
|------|:-----------:|:-----------:|:---------------------:|
| 추출률 (any output) | 0/20 (0%) | 14/20 (70%) | 17/30 (57%) ¹ |
| OSS 정확 분류 | 0/14 OSS | 13/14 OSS (93%) | **16/16 OSS (100%)** |
| Proprietary 정확 분류 (T4) | 6/6 (100%) | 6/6 (100%) | 7/7 (100%) |
| False positive | 0 | 0 | **0** |
| False negative (OSS) | 14 | 1 (PortableGit or-later) | **0-1** (or-later 한계 유지) |
| LICENSE 부재 + 메타 only 회복 | — | 0/4 (시나리오 미커버) | **3/4 OSS** (#23 #24 + #21 보존) + 1 정확 silent (#22) |
| Multi-file dual 지원 | ✗ | ✅ | ✅ (보존) |
| GPL or-later 처리 | ✗ | ✅ | ✅ (보존) |
| pyproject 메타 (PEP 639/621/poetry) | ✗ | ✗ | **✅** |
| npm 메타 (UNLICENSED + SEE LICENSE IN) | ✗ | ✗ | **✅** |
| Cargo 메타 (license + license-file) | ✗ | ✗ | **✅** |

¹ sample 30 통합 비율 — 메타 부재 케이스 2건 (#29 + ruff-pre-commit) 포함. proprietary는 T4가 정확.

## 사용자 사이드 dynamic 검증 (REPORT 단계)

본 v1.10e3 적용 후 사용자가 `/harness-meta <new-name>` Bootstrap 진행 시:

1. detect-project.sh 출력 — LICENSE 콘텐츠와 메타데이터 모두 검사:
   - SPDX 헤더 → T1 매칭 (보존)
   - LICENSE-MIT + LICENSE-APACHE → T2-Multi → `MIT OR Apache-2.0` (보존)
   - 단일 LICENSE boilerplate → T2 → 12 패턴 매칭 (보존)
   - **Cargo `license-file = "..."` 사용자 정의 경로 → T2.5 license_path 보강** (신규)
   - **LICENSE 부재 + pyproject `[project].license = "..."` → T3 M2 매칭** (신규)
   - **LICENSE 부재 + package.json `"license": "..."` → T3 M1 매칭** (신규)
   - **`"license": "UNLICENSED"` → `LicenseRef-UNLICENSED`** (신규)
   - **`"license": "SEE LICENSE IN <file>"` → 1회 재귀 T1/T2** (신규)
   - LICENSE / 메타 모두 부재 → output 없음 (T4)
2. Stage S3 preview에 `{{license}}` 행 표시 확인 (4-tier 결과)
3. AGENTS.md.tmpl 치환 결과 확인:
   - 매칭 → `License: <SPDX> (see [LICENSE](LICENSE))`
   - 미식별 → `License: see LICENSE.` (v1.10b fallback)

## v1.10e3 한계 + v1.10h 동기 (audit/A2 evidence)

**알려진 한계** (audit/A2 §5):

1. **non-SPDX 메타 보존 (#21 #27)**: 사용자가 비표준 형식 (long EULA / 공백 형식) 명시 시 그대로 stamp. AGENTS.md L5 라인 가독성 저하 → **v1.10h** scope (L5 라인 정책)
2. **PortableGit or-later 의미 conflict (#19)**: T1/T2/T3 어느 단계에서도 의미 추출 불가 (보존). 사용자 SPDX 헤더 권장 (T1 우선)
3. **modified license 미커버**: `"MIT License (modified)"` 등 SPDX 변형. 메타가 명시 시 보존, 아니면 false negative
4. **multi-line TOML inline table 미커버**: PEP 621 multi-line `license = {\n  text = "MIT"\n}` 미처리. PEP 639 modern 권장
5. **dynamic license**: PEP 621 `dynamic = ["license"]` 빌드 후 결정. v1.10e3 미커버 — 사용자 LICENSE 파일 명시
6. **monorepo recursive**: pnpm-workspace 자식 packages 미처리. workspace root만

→ 사용자가 본 v1.10e3 적용 후:

- (a) LICENSE에 SPDX 헤더 추가 (T1 우선 매칭, 가장 정확)
- (b) **v1.10h 채택** (L5 line 형식 / non-SPDX 메타 truncate / LICENSE 부재 시 라인 분기)

본 v1.10e3 evidence base (non-SPDX 메타 보존 한계)가 v1.10h 채택 결정 자연 유도.

## Lessons Learned

1. **Evidence-driven 후속 분기 4단계 정착** — v1.10e (T1 0%) → v1.10e2 (T1+T2 70%) → **v1.10e3 (T1+T2+T3 OSS 100% sample 30)** → v1.10h (라인 정책). 각 세션의 audit/A2가 다음 세션의 evidence base. 본 패턴이 license 분기 시리즈에서 일관됨
2. **Anchor 완화 발견** — 초기 PLAN/A3 grep `^[[:space:]]*"license"` anchor가 minified JSON `{"license":"MIT"}` 한 줄 미커버. 빠른 smoke 검증 (Stage B `/tmp/v110e3-quick`)에서 발견 → `grep -o -E '"license"[[:space:]]*:[[:space:]]*"[^"]+"'` anchor-less 형식으로 수정. **단순 grep + sed가 multi-line 가정**한 것이 한계 — root-only `head -1` 가드로 nested risk 회피
3. **4 spec 동시 검증 가치** — npm CLI v10 + PEP 639 Final + Poetry + Cargo manifest 4 1차 spec WebFetch 수집이 audit/A1 정확도 보장. legacy 형식 (npm `{type, url}` / PEP 621 inline `{text}` `{file}`) 사용자 마이그레이션 안내 정합. spec 검증 없이는 우선순위 결정 (M2 over M3) 정당화 불가
4. **LICENSE 콘텐츠 우선 정책 (G1) 의미 정확도 보장** — sample evidence 4/4 vs 메타 우선 2/4. Oracle `"Apache 2.0"` (공백) 같은 비표준 메타 form을 LICENSE boilerplate가 SPDX 정확화. GitHub Linguist 동일 전략. v1.10e3가 본 정책을 명문화한 것이 향후 v1.10h L5 line 정책 분리 (non-SPDX 메타 처리는 라인 차원)의 evidence base
5. **POSIX awk section flag 패턴 정착** — `/^\[section\]/{f=1;next} /^\[/{f=0} f && ...`로 모든 awk 호환. GNU awk extension `match()` 3-arg 회피. v1.10e2 helper 동일 정책 + v1.10e3 6개 신규 helper 동일 적용 → cross-platform 호환성 일관 보장 (BSD/macOS/MINGW)
6. **단일 책임 v1.10x 패턴 유지** — 본 v1.10e3 변경 14 (~동급 v1.10b/c/e/e2). scope creep 방지: AGENTS.md L5 라인 정책 v1.10h / 복잡 SPDX expression / monorepo recursive / dynamic license / npm `licenses` legacy array → 각 별도 후속 세션 분기. PLAN 명시적 omit 6건 + audit A4 §12.2 명시
7. **observation 본질 = LICENSE/메타 콘텐츠 read = injection 아님 (audit/A5)** — 4 spec 표준 (npm CLI v10 + PEP 639 + Poetry + Cargo) 모두 사용자 명시 declaration. 권위 도구 (npm registry / crates.io / PyPI / GitHub Linguist) 동일 전략. v1.10c 거부 3 이유 (spec 위반 / 의도 위배 / 권위 도구 불일치) 모두 무력화. 4-tier 모두 동일 본질 (T1=헤더 read / T2=콘텐츠 read / T3=메타 read)

## 다음 후보 (보류 / 후속)

| 세션 | scope | 내용 | 상태 |
|------|------|------|:----:|
| `v1.10h-agents-md-license-line-policy` | S2 | agents.md L5 license 라인 자체 정책 (LICENSE 부재 시 라인 분기 / non-SPDX 메타 truncate / 형식 검증) | 보류 (v1.10e3 evidence base 제공) |
| `v1.10f-broad-bash-fine-grain` | S1b | v1.10d 후속 — broad Bash 3 SKILL fine-grain | 보류 |
| `v1.10g-skill-thinking-effort` | S1b | v1.10d 후속 — `thinking:` vs `effort:` | 보류 |
| (별도 후속) | S2 | 복잡 SPDX expression 검증 (`(MIT OR Apache-2.0) AND CC-BY-4.0`) | 보류 (evidence 부족) |
| (별도 후속) | S2 | monorepo recursive (pnpm-workspace 자식 packages) | 보류 |
| (별도 후속) | S2 | dynamic license (PEP 621 `dynamic = ["license"]`) | 보류 |
| `sessions/upbit/v1.2-bash-permission-update/` | S6 (T4) | v1.10d 적용 — upbit 41+ 패턴 정정 + deny 재설계 | upbit 측 진행 대기 |

## 변경 파일 목록 (수정 9 + 신규 9 = 18)

### 수정 (9)

- `bootstrap/detect-project.sh` (T2.5 + T3 메타 4-tier + helpers 7개, ~80 라인 추가)
- `bootstrap/interview.md` ("License 처리" § 4-tier 갱신 + bootstrap_version 1.10e2 → 1.10e3 + 헤더 라인 갱신)
- `bootstrap/docs/INTERVIEW_FLOW.md` (Stage S3 literal 4-tier + §3.3 v1.10e/e2/e3 변수 표 + bootstrap_version fallback 1.10c → 1.10e3)
- `bootstrap/manifest-schema.md` (L437 license v1.10e2 → v1.10e3 + T2.5 + T3 메타 4 source 추가)
- `bootstrap/skeletons/projects/INTERVIEW.md` (bootstrap_version 1.10e2 → 1.10e3 + license 4-tier + LICENSE 우선 정책 명시)
- `claude/commands/harness-meta.md` (S2 license 3-tier → 4-tier)
- `CLAUDE.md` (최신 meta v1.10e2 → v1.10e3 + 4-tier 갱신)
- `README.md` (동상)

### 신규 (9)

- `tests/smoke-bootstrap-license-metadata.sh` (14 stage)
- `sessions/meta/v1.10e3-license-metadata/PLAN.md`
- `sessions/meta/v1.10e3-license-metadata/REPORT.md`
- `sessions/meta/v1.10e3-license-metadata/audit/A1-metadata-sources.md`
- `sessions/meta/v1.10e3-license-metadata/audit/A2-recovery-rate.md`
- `sessions/meta/v1.10e3-license-metadata/audit/A3-detect-strategy.md`
- `sessions/meta/v1.10e3-license-metadata/audit/A4-policy-decisions.md`
- `sessions/meta/v1.10e3-license-metadata/audit/A5-priority-rationale.md`
- `sessions/meta/v1.10e3-license-metadata/evidence/smoke-bootstrap-license-metadata.txt`
- `sessions/meta/v1.10e3-license-metadata/evidence/regression-smoke-license-boilerplate.txt`
- `sessions/meta/v1.10e3-license-metadata/evidence/regression-smoke-license-detect.txt`

(수정 8 + 신규 11 = **19 파일**. evidence 3 + audit 5 + smoke 1 + PLAN/REPORT 2 = 신규 11 정확 카운트.)
