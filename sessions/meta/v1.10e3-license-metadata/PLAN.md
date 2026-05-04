# meta v1.10e3-license-metadata — PLAN

세션 시작: 2026-04-27 (v1.10e2 직후, 동일 세션 분기 — Option C 후속의 후속)
직접 선행 세션:

- [`sessions/meta/v1.10e2-license-boilerplate/`](../v1.10e2-license-boilerplate/REPORT.md) — T1+T2 3-tier (SPDX 헤더 + multi-file dual + boilerplate 12 패턴). recovery rate 0% → 70% (sample 20). False positive 0. 알려진 한계 1건 (PortableGit or-later) + modified license / 신규-희귀 license / **메타데이터-only** 미커버
- [`sessions/meta/v1.10e-detect-license/`](../v1.10e-detect-license/REPORT.md) — T1 only Option C
- [`sessions/meta/v1.10c-bootstrap-content-defaults/`](../v1.10c-bootstrap-content-defaults/REPORT.md) — License default 폐기 + observation only 원칙

목적: v1.10e2의 70% recovery rate 잔여 30% 보완. **메타데이터 license 필드 추출** — `package.json.license` (npm/pnpm/yarn/bun) / `pyproject.toml [project].license` (PEP 621) + `[tool.poetry].license` (poetry) / `Cargo.toml [package].license` + `license-file` (cargo) 4-tier 추가. T1 (SPDX 헤더) + T2 (multi-file/boilerplate) + **T3 메타데이터** + T4 fallback (silent).

LICENSE 파일 부재 + 메타데이터만 명시한 프로젝트 (e.g. npm 패키지 다수 — `"license": "ISC"` only) 회복.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S2(7) — `bootstrap/{detect-project.sh, interview.md, docs/INTERVIEW_FLOW.md}` + smoke + audit 5. S1a(0). S3(2) — `CLAUDE.md` + `README.md` 갱신. 합 **9/9 meta**.
- **T1 경로 다수결** — meta scope 9/9.
- **T2 스펙 vs 값** — 4 메타데이터 source + 매칭 알고리즘 = "흐름 스펙". 신규 프로젝트의 실 메타데이터 추출 결과는 `sessions/<name>/v0.1-bootstrap/` (T4).

## 배경 — v1.10e2 잔여 30% 분석 (audit/A2 인용)

v1.10e2 sample 20건 중 **미회복 6건** (false negative + edge):

| # | 프로젝트 | LICENSE 상태 | v1.10e2 결과 | 메타데이터 가능성 |
|---|---------|------|------|------|
| 1 | (npm 패키지 LICENSE 부재) | LICENSE 파일 부재 | T4 silent | `package.json.license = "ISC"` 가능 |
| 2 | (PyPI 패키지 LICENSE 부재) | LICENSE 파일 부재 | T4 silent | `pyproject.toml [project].license = {text = "MIT"}` 가능 |
| 3 | (Cargo crate LICENSE 부재) | LICENSE 파일 부재 | T4 silent | `Cargo.toml [package].license = "Apache-2.0"` 가능 |
| 4 | modified license | "MIT License (modified)" | T4 silent | 메타데이터 fallback (정확하진 않음) |
| 5 | 신규/희귀 license | Boost / zlib / NCSA | T4 silent | 메타데이터 SPDX ID 직접 명시 가능 |
| 6 | PortableGit edge | LICENSE 헤더 부재 + body GPL-2 | T2 매칭 (`GPL-2.0-only`) | 의도가 or-later면 메타데이터로 정정 가능 |

**가설**: v1.10e3 메타데이터 4-tier 도입 시 **OSS 메타데이터 보유 프로젝트 ~80% recovery rate** 달성 가능 (v1.10e2 70% + 메타데이터 회복 ~10%p).

## v1.10c observation 정합성 재확인

v1.10e3 = **observation** (사용자 메타데이터 read) — v1.10c 거부 3 이유 (spec 위반 / 의도 위배 / 권위 도구 불일치) 모두 무력화:

- **spec 정합**: PEP 621 + npm package.json schema + Cargo manifest spec — 3 표준 모두 `license` 필드 정식 spec
- **의도 일치**: 사용자가 메타데이터에 명시한 SPDX ID는 **명시적 declaration** (LICENSE 파일 헤더보다 더 strong signal — 빌드 도구가 직접 read)
- **권위 도구 일치**: GitHub Linguist + licensee + npm registry + crates.io + PyPI 모두 메타데이터 license 필드 우선 read

## scope — Option C 후속의 후속

### ✅ 포함 (12 항목)

1. **T3 메타데이터 4-tier 추가** (T1 SPDX 헤더 → T2-Multi → T2 boilerplate → **T3 메타데이터** → T4 silent)
2. **package.json `license` 필드** — npm/pnpm/yarn/bun 공통. SPDX expression 직접 + `"UNLICENSED"` + `"SEE LICENSE IN <file>"` 처리
3. **pyproject.toml** 2 source:
   - PEP 621 `[project].license = {text = "MIT"}` (modern, PEP 639 simplification)
   - PEP 621 `[project].license = "MIT"` (PEP 639 string 형식)
   - poetry `[tool.poetry].license = "MIT"` (legacy)
4. **Cargo.toml** 2 source:
   - `[package].license = "MIT"` (SPDX expression 직접)
   - `[package].license-file = "LICENSE"` (간접 — 이미 v1.10e/e2가 처리)
5. **Match priority**: T1 SPDX > T2-Multi > T2 boilerplate > **T3 메타데이터 (LICENSE 파일 부재 시만)** > T4 silent. 즉 T3는 **LICENSE 파일 자체가 없을 때 fallback**. LICENSE 존재 + boilerplate 매칭 시 메타데이터 무시 (LICENSE 콘텐츠 우선)
6. **메타데이터 source 우선순위** (LICENSE 부재 시): pyproject (PEP 621 modern) → pyproject (PEP 621 legacy string) → pyproject (poetry) → package.json → Cargo.toml. 첫 매칭 + early return
7. **UNLICENSED 처리**: `"license": "UNLICENSED"` (npm proprietary 컨벤션) → 메타데이터 매칭 + AGENTS.md L5 출력 (`License: UNLICENSED (proprietary)` 또는 SPDX standard `LicenseRef-UNLICENSED`)
8. **SEE LICENSE IN 처리**: `"license": "SEE LICENSE IN <file>"` (npm 비표준 license 컨벤션) → 메타데이터에서 file 경로 추출 + LICENSE 파일 read 위임 (T1/T2 재시도)
9. **TOML 안전성** — pyproject/Cargo `license = "..."` 파싱은 grep + sed (tomllib 없이). 멀티라인 / nested 미지원 (limitation 명시)
10. **JSON 안전성** — package.json `license` 파싱은 grep + sed (jq 없이). nested object (`{ type: "MIT", url: "..." }`, deprecated npm 형식) 부분 지원
11. **bootstrap_version stamp** `1.10e2` → `1.10e3`
12. **INTERVIEW_FLOW.md Stage S3 preview literal** 갱신 (4-tier 표기)

### ❌ 제외 (6 항목 → 후속)

- **`license-file` indirect fallback** (Cargo `license-file = "LICENSE.custom"`) → v1.10e/e2가 이미 LICENSE 파일 read하므로 이미 처리됨. 신규 분기 불필요
- **agents.md L5 license 라인 자체 정책** (라인 제거/유지/형식 결정) → **v1.10h** (별도 세션)
- **복잡 SPDX expression** (`(MIT OR Apache-2.0) AND CC-BY-4.0` 본 v1.10e2 multi-file dual은 단순 OR만) → 메타데이터에서 직접 명시된 expression은 그대로 보존하되 검증 안 함. 별도 후속
- **modified license 감지** (`"MIT License (modified)"`) → 메타데이터로 정확 매칭 안 됨. 사용자에게 SPDX 헤더 추가 권장 (T1 우선)
- **자식 packages monorepo recursive** (pnpm-workspace 하위 packages/*/package.json) → workspace root만. recursive 별도 후속
- **deprecated npm `licenses` array** (npm v6 이전 `"licenses": [{type, url}, ...]` 구식) → 검출 안 함. 사용자 마이그레이션 안내

## 4 메타데이터 source spec (audit/A1에서 정밀화)

| # | 파일 | 키 | TOML/JSON | 추출 형식 | spec |
|---|------|------|-----------|----------|------|
| 1 | `package.json` | `"license"` | JSON top-level string | `"MIT"` / `"UNLICENSED"` / `"SEE LICENSE IN file"` / `{type, url}` (legacy) | npm package.json schema |
| 2 | `pyproject.toml` | `[project].license` (PEP 621 modern) | TOML inline table | `license = {text = "MIT"}` 또는 `license = {file = "LICENSE"}` | PEP 621 |
| 2b | `pyproject.toml` | `[project].license` (PEP 639) | TOML string | `license = "MIT"` (SPDX expression) | PEP 639 (Python 3.12+) |
| 2c | `pyproject.toml` | `[tool.poetry].license` | TOML string | `license = "MIT"` | Poetry |
| 3 | `Cargo.toml` | `[package].license` | TOML string | `license = "MIT OR Apache-2.0"` | Cargo manifest |

**Match priority** (audit/A3 결정 예정):

- LICENSE 파일 존재 + T1/T2 매칭 → 메타데이터 무시 (LICENSE 콘텐츠 우선)
- LICENSE 파일 부재 → T3 메타데이터 진입
- T3 source 우선순위: pyproject (modern PEP 621) → pyproject (PEP 639 string) → pyproject (poetry) → package.json → Cargo.toml

## bash 파싱 알고리즘 (audit/A3에서 확정)

**package.json `license` 필드 grep+sed 패턴**:

```bash
# top-level "license": "..." (간단 케이스)
license=$(grep -E '^[[:space:]]*"license"[[:space:]]*:[[:space:]]*"' package.json \
    | head -1 \
    | sed -E 's/^[[:space:]]*"license"[[:space:]]*:[[:space:]]*"([^"]+)".*/\1/')
```

**pyproject.toml** — PEP 621 modern + PEP 639 + poetry 3 source 순차:

```bash
# (a) PEP 621 modern: license = {text = "..."}
license=$(grep -E '^license[[:space:]]*=[[:space:]]*\{[[:space:]]*text' pyproject.toml \
    | head -1 \
    | sed -E 's/.*text[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')

# (b) PEP 639 string (license = "..." top-level [project])
[ -z "$license" ] && license=$(awk '/^\[project\]/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*"/' pyproject.toml \
    | head -1 \
    | sed -E 's/^license[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')

# (c) poetry: [tool.poetry] license = "..."
[ -z "$license" ] && license=$(awk '/^\[tool\.poetry\]/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*"/' pyproject.toml \
    | head -1 \
    | sed -E 's/^license[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')
```

**Cargo.toml** — `[package]` section license:

```bash
license=$(awk '/^\[package\]/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*"/' Cargo.toml \
    | head -1 \
    | sed -E 's/^license[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')
```

**SEE LICENSE IN <file> 처리** (npm):

```bash
# license = "SEE LICENSE IN custom.txt" → custom.txt를 read해서 T1/T2 재시도
if echo "$license" | grep -q -E '^SEE LICENSE IN '; then
    file=$(echo "$license" | sed -E 's/^SEE LICENSE IN //')
    # T1/T2를 file에 재적용 (재귀 호출 회피 — 1회만)
    license=$(_t1_t2_match "$ROOT/$file")
fi
```

## 변경 대상 (3 수정 + 11 신규 = 14 파일)

### 수정 (3)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/detect-project.sh` | S2 | T3 메타데이터 4-tier 추가 (T2 다음, T4 이전). package.json + pyproject 3 source + Cargo.toml. UNLICENSED + SEE LICENSE IN 처리. ~50-70 라인 추가 |
| `bootstrap/interview.md` | S2 | "License 처리" § 본문 갱신 — T1+T2+T3+T4 4-tier 명시. 4 메타데이터 source 표. bootstrap_version stamp `1.10e2` → `1.10e3` |
| `bootstrap/docs/INTERVIEW_FLOW.md` | S2 | §2 Stage S3 preview literal에 4-tier 표기 갱신. §3.3 v1.10e2 변수 표 footnote에 T3 추가 |

### 신규 (11)

| 경로 | scope | 역할 |
|------|------|------|
| `tests/smoke-bootstrap-license-metadata.sh` | S2 | 12 stage smoke (4 source 매칭 + UNLICENSED + SEE LICENSE IN + LICENSE 우선순위 + 회귀) |
| `sessions/meta/v1.10e3-license-metadata/PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.10e3-license-metadata/REPORT.md` | meta | (Stage E 후 작성) |
| `sessions/meta/v1.10e3-license-metadata/audit/A1-metadata-sources.md` | meta | 4 source 정밀 spec — package.json schema 변형 (legacy `{type, url}` 등) + PEP 621 modern vs PEP 639 변천 + Poetry vs PEP 621 충돌 + Cargo dual-license expression |
| `sessions/meta/v1.10e3-license-metadata/audit/A2-recovery-rate.md` | meta | v1.10e2 sample 20건 + 메타데이터-only OSS sample 10건 추가 = 총 30. T3 메타데이터로 회복 가능한 6/6 false negative 확인 + recovery rate 70% → ~80% 추정 |
| `sessions/meta/v1.10e3-license-metadata/audit/A3-detect-strategy.md` | meta | 4-tier bash 알고리즘 + grep+sed vs awk section parse 트레이드오프 + tomllib/jq 회피 정당화 + SEE LICENSE IN 재귀 회피 |
| `sessions/meta/v1.10e3-license-metadata/audit/A4-policy-decisions.md` | meta | R1-R10 결정 + Grey 5건 + scope 매트릭스 (포함 12 + 제외 6) |
| `sessions/meta/v1.10e3-license-metadata/audit/A5-priority-rationale.md` | meta | LICENSE 파일 vs 메타데이터 우선순위 결정 — LICENSE 콘텐츠 우선 정당화 (사용자 의도 + GitHub Linguist 동일 전략 + 콘텐츠가 더 strong signal) |
| `sessions/meta/v1.10e3-license-metadata/evidence/smoke-bootstrap-license-metadata.txt` | meta | smoke 실행 결과 |
| `sessions/meta/v1.10e3-license-metadata/evidence/regression-smoke-license-boilerplate.txt` | meta | v1.10e2 18-stage 회귀 결과 |
| `sessions/meta/v1.10e3-license-metadata/evidence/regression-smoke-license-detect.txt` | meta | v1.10e 5-stage 회귀 결과 |

## 목표

- [x] 세션 디렉토리 생성 (`sessions/meta/v1.10e3-license-metadata/{audit,evidence}/`)
- [x] **PLAN.md 초안 작성** (본 파일 — 사용자 확인 대상)
- [ ] **사용자 PLAN 확인** ← 진행 대기
- [ ] **Stage A — audit 5 파일 작성**
  - A1 — 4 메타데이터 source 정밀 spec (package.json + pyproject 3 + Cargo)
  - A2 — recovery rate 70% → ~80% 추정 (v1.10e2 sample 20건 + 메타데이터-only sample 10건 추가)
  - A3 — 4-tier bash 알고리즘 + grep+awk 전략 + SEE LICENSE IN 재귀 회피
  - A4 — R1-R10 정책 결정 + Grey 5건 + scope 매트릭스
  - A5 — LICENSE 파일 vs 메타데이터 우선순위 정당화
- [ ] **Stage B — `bootstrap/detect-project.sh` 갱신**
  - T3 메타데이터 4-tier 추가 (helper 함수 4-5개)
  - UNLICENSED + SEE LICENSE IN 처리
  - LICENSE 파일 부재 시만 T3 진입 (가드)
- [ ] **Stage C — interview.md / INTERVIEW_FLOW.md 갱신**
  - "License 처리" § 4-tier 명시 + 4 메타데이터 source 표
  - bootstrap_version stamp `1.10e2` → `1.10e3`
  - INTERVIEW_FLOW.md §2 Stage S3 preview literal — 4-tier
- [ ] **Stage D — Smoke**
  - `tests/smoke-bootstrap-license-metadata.sh` 12 stage:
    - Stage 1-4: 4 source 단순 매칭 (package.json MIT / pyproject PEP 621 modern MIT / pyproject poetry MIT / Cargo MIT)
    - Stage 5: pyproject PEP 639 string 형식
    - Stage 6: UNLICENSED (npm proprietary)
    - Stage 7: SEE LICENSE IN <file> + 해당 파일 T1/T2 매칭
    - Stage 8: LICENSE 파일 + 메타데이터 동시 존재 → LICENSE 우선 (T1 SPDX MIT vs 메타데이터 Apache → MIT 출력)
    - Stage 9: LICENSE 부재 + 메타데이터만 존재 → 메타데이터 출력
    - Stage 10: 메타데이터도 부재 → T4 silent
    - Stage 11: pyproject 우선순위 (PEP 621 modern + poetry 동시 → modern 우선)
    - Stage 12: source 충돌 (package.json + Cargo 동시 존재) → audit/A4 우선순위 적용
  - 회귀 v1.10e2 18-stage + v1.10e 5-stage PASS 유지
- [ ] **REPORT.md 작성**
- [ ] **사용자 확인 후 단일 커밋 + push**

## Grey Areas — audit/A4에서 확정 예정

| ID | 질문 | 후보 |
|----|------|----------|
| **G1** | LICENSE vs 메타데이터 우선순위 | (a) **LICENSE 우선 (콘텐츠가 strong signal)** ✓ / (b) 메타데이터 우선 (declaration이 strong) / (c) merge (둘 다 표시) |
| **G2** | pyproject 3 source 우선순위 | (a) **PEP 621 modern → PEP 639 → poetry** ✓ / (b) poetry → PEP 621 (legacy 우선) |
| **G3** | UNLICENSED 출력 형식 | (a) `UNLICENSED` 그대로 (npm 컨벤션 보존) / (b) **`LicenseRef-UNLICENSED`** (SPDX 표준) / (c) `proprietary` (semantic) |
| **G4** | SEE LICENSE IN 재귀 깊이 | (a) **1회만 (재귀 회피, performance)** ✓ / (b) 무제한 |
| **G5** | nested package.json 형식 (legacy `{type, url}`) | (a) 검출 안 함 (사용자 마이그레이션) / (b) **부분 지원 (`type` 필드만 추출)** ✓ / (c) 완전 지원 |

## 성공 기준

- [ ] audit/A1-A5 5 파일 작성 (Stage A)
- [ ] `bootstrap/detect-project.sh` T3 메타데이터 4-tier 함수 + UNLICENSED + SEE LICENSE IN (~50-70 라인 추가)
- [ ] `bootstrap/interview.md` "License 처리" § 4-tier 갱신 + 4 메타데이터 source 표 + bootstrap_version `1.10e3`
- [ ] `bootstrap/docs/INTERVIEW_FLOW.md` Stage S3 literal + §3.3 footnote
- [ ] `tests/smoke-bootstrap-license-metadata.sh` 12 stage PASS
- [ ] 기존 `tests/smoke-bootstrap-license-boilerplate.sh` 18/18 회귀 PASS
- [ ] 기존 `tests/smoke-bootstrap-license-detect.sh` 5/5 회귀 PASS
- [ ] `evidence/` 3 파일 저장
- [ ] `CLAUDE.md` / `README.md` / `claude/commands/harness-meta.md` / `manifest-schema.md` / `skeletons/projects/INTERVIEW.md` 정합 갱신 (S3 + S2)
- [ ] REPORT.md 작성
- [ ] 사용자 확인 후 단일 커밋 + push

## 커밋 전략

단일 커밋. 부분 적용 시 4 source 매핑 / 12 smoke / 4-tier 문서 불일치 → 자산 정합성 깨짐.

```
feat(meta): sessions/meta/v1.10e3-license-metadata — LICENSE 메타데이터 4 source 추출 (T3 4-tier)

- update: bootstrap/detect-project.sh (T3 메타데이터 4-tier + 4 source: package.json/pyproject 3/Cargo + UNLICENSED + SEE LICENSE IN)
- update: bootstrap/interview.md ("License 처리" § T1+T2+T3+T4 4-tier + 4 메타데이터 source 표 + bootstrap_version 1.10e2 → 1.10e3)
- update: bootstrap/docs/INTERVIEW_FLOW.md (Stage S3 literal 4-tier + §3.3 footnote)
- add: tests/smoke-bootstrap-license-metadata.sh (12 stage)
- add: sessions/meta/v1.10e3-license-metadata/{PLAN,REPORT,audit/A1-A5,evidence/3 파일}

v1.10e2 후속. 70% recovery rate 잔여 30% 보완:
- T3 메타데이터 4 source: package.json + pyproject (PEP 621 modern + PEP 639 + poetry) + Cargo.toml
- UNLICENSED 처리 (npm proprietary 컨벤션 → LicenseRef-UNLICENSED SPDX)
- SEE LICENSE IN <file> 1회 재귀 (T1/T2 위임)
- LICENSE 파일 우선 (T1/T2 매칭 시 T3 skip)
- T4 fallback 유지

v1.10c/v1.10e/v1.10e2 정합성 (audit/A5):
- T3 = observation (사용자 메타데이터 read), injection 아님
- spec 정합 (PEP 621 + npm schema + Cargo manifest)
- 권위 도구 일치 (Linguist + licensee + npm/PyPI/crates 메타데이터 우선)

v1.10e2 70% → ~80% (audit/A2 검증).

Smoke 12/12 PASS. 회귀 v1.10e2 18/18 + v1.10e 5/5 PASS.
```

## 후속 세션 연결

### 직접 연계

- **v1.10h-agents-md-license-line-policy** (S2) — agents.md spec L5 license 라인 자체 정책 (유지/제거/형식)

### Lessons Forward (예상)

1. **Evidence-driven 후속 분기 4단계 정착** — v1.10e (T1 0%) → v1.10e2 (T1+T2 70%) → v1.10e3 (T1+T2+T3 ~80%) → v1.10h (라인 정책). 각 세션이 다음 세션의 evidence base 제공
2. **메타데이터 vs LICENSE 콘텐츠 우선순위 — LICENSE 우선** — 사용자 의도가 콘텐츠에 표현됨 + GitHub Linguist 동일 전략 + 콘텐츠가 strong signal. 메타데이터는 LICENSE 부재 시만 fallback
3. **bash awk section parse 패턴** — TOML `[section]` 단위 grep은 awk + flag 사용 (pyproject 3 source / Cargo `[package]` 등). tomllib 회피 + 단순 + 검증 용이
4. **SEE LICENSE IN 1회 재귀 한계** — 무제한 재귀는 path traversal risk + performance. 1회 충분 (npm 컨벤션 자체가 단일 파일 참조)
5. **단일 책임 v1.10x 패턴 유지** — 본 v1.10e3 변경 14 (~동급). scope creep 방지: agents.md L5 line 정책 v1.10h / 복잡 SPDX expression 별도 후속 / monorepo recursive 별도 후속
