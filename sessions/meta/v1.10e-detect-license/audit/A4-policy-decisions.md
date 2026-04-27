# A4 — Policy 결정 (Option C 채택, G1-G5 + scope 매트릭스)

본 audit의 policy 결정. v1.10c REPORT promise 정확 일치 + scope creep 차단.

## R1 — Option C (Hybrid) 채택

**결정**: T1 (SPDX 헤더 추출) + T3 (fallback)만 본 v1.10e. T2 (boilerplate 매칭 9 패턴), 메타데이터 license 필드, dual-license는 별도 후속.

**근거** (audit/A1-A2 종합):
- v1.10c REPORT promise 정확 일치: "SPDX 헤더 추출" — T1 명시, T2 미명시
- v1.10b/c 패턴 정합: 각 v1.10x가 단일 책임 (~10 변경 파일)
- scope creep 차단: PLAN 초안의 9 boilerplate + dual-license + 메타데이터는 promise 초과
- v1.10e2 후속 자연 분기: 본 audit이 evidence base 제공 (sample T1 추출률 0%) → 사용자가 추출률 한계 인지 후 v1.10e2 채택 결정

**대안 평가**:
- (A) Conservative T1 only — 본 결정. promise 정확
- (B) Full T1+T2 — 9 보일러플레이트 fuzzy 매칭. promise 초과
- (C) Hybrid T1 in v1.10e + T2 in v1.10e2 후속 — **본 결정** (Option C)

## R2 — LICENSE 파일명 우선순위 + case-insensitive

**결정**: `LICENSE` → `LICENSE.md` → `LICENSE.txt` → `COPYING` 순서. case-insensitive (`find -iname`).

**근거**:
- `LICENSE`: GitHub 표준
- `LICENSE.md`: markdown extension (GitHub render)
- `LICENSE.txt`: VSCode extensions 등 텍스트 명시
- `COPYING`: GPL/GNU 컨벤션
- case 변형: `License`, `license` 모두 흔함 (case-insensitive 필수)

**제외**:
- `LICENSE-MIT` / `LICENSE-APACHE` (dual-license multi-file) → **v1.10e2 후속**
- `NOTICE` (Apache-2.0 동반 파일) → boilerplate 매칭 시 신뢰도 보조 — v1.10e2 후속

## R3 — T3 fallback (output 없음 + S3 WARN)

**결정**: LICENSE 부재 또는 SPDX 헤더 미식별 시 detect-project.sh output 없음. AGENTS.md.tmpl L5 fallback `see LICENSE`. S3 preview에 WARN.

**근거**:
- v1.10c promise: "S3 preview WARN" 명시
- v1.10c 거부 정합 (audit/A5): observation 본질 — 사용자 의도 없으면 stamp 안 함
- proprietary 의도 보존 (sample 50% proprietary EULA)

## R4 — AGENTS.md.tmpl L5 변수화 (placeholder 자동화)

**결정**: L5 `License: see LICENSE.` → `License: {{license}}` 변수. fallback 텍스트 `see LICENSE`.

**근거**:
- v1.10c promise: "license 미터치한 placeholder를 정식 자동화"
- v1.10c의 `{{install_cmd}}` 패턴 정합 (env-driven 콘텐츠 변수)

**구체 형식** (Claude Bootstrap 치환):
- T1 매칭: `License: MIT (see [LICENSE](LICENSE))`
- T1 dual: `License: MIT OR Apache-2.0 (see [LICENSE](LICENSE))`
- T3 fallback: `License: see LICENSE.` (v1.10b 텍스트 그대로)

## R5 — 자동 적용 카운트 6 → 7

**결정**: 자동 적용 manifest 4 + 콘텐츠 3 (bootstrap_version + install_cmd + **license T1**) = 7건.

**근거**: v1.10b/c 패턴 정합. AGENTS.md 콘텐츠 default 자동 적용 카테고리에 license 추가.

**갱신 대상**:
- `bootstrap/interview.md` "자동 적용 (질문 없음, 6건)" → 7건
- `bootstrap/docs/INTERVIEW_FLOW.md` §3.3 v1.10e 변수 표 + Stage S3 literal
- `bootstrap/manifest-schema.md` L437
- `bootstrap/skeletons/projects/INTERVIEW.md`
- `claude/commands/harness-meta.md` S2 자동 6 → 7

## R6 — INTERVIEW_FLOW.md round-trip 한계 1줄 안내

**결정**: §3.3 변수 표 끝에 1줄: bootstrap 1회성, LICENSE 변경 후 AGENTS.md 수동 갱신 필요.

**근거**: 사용자 혼란 방지. 별도 doc 없이 가벼운 안내.

## Scope 매트릭스 — Option C 명시 분리

| 항목 | v1.10 (parent) | **v1.10e (본)** | 후속 |
|------|:-------------:|:--------------:|:----:|
| T1 — SPDX 헤더 추출 | ✓ | ✅ | — |
| T3 — fallback (output 없음) | ✓ | ✅ | — |
| S3 preview WARN | ✓ | ✅ | — |
| AGENTS.md.tmpl L5 변수화 | ✓ | ✅ | — |
| LICENSE 파일명 4 우선순위 | ✓ | ✅ | — |
| Round-trip 한계 안내 | ✓ | ✅ (1줄) | — |
| v1.10c observation 정합성 audit | ✓ | ✅ (audit/A5) | — |
| 자동 적용 6 → 7 | ✓ | ✅ | — |
| **T2 — boilerplate 매칭 (9 패턴)** | ✓ | ❌ | **v1.10e2** |
| **dual-license / multi-file** | ✓ | ❌ | **v1.10e2** |
| **메타데이터 license (npm/PEP/Cargo)** | ✓ | ❌ | **v1.10e3** |
| **agents.md L5 line 자체 정책** | ✓ | ❌ | **v1.10h** |
| **NOTICE 파일 보조 (Apache-2.0)** | ✓ | ❌ | v1.10e2 |
| **harness-meta self-detect** | ✗ | ❌ (smoke fixture만) | — |

**v1.10 series 종료 시점**: 알려진 v1.10x 후속 (v1.10e2/e3/f/g/h) 처리 후 v1.11 (language overlay)로 이행.

## Grey Areas — 5건 (G1 결정 후 G2-G9 종속 해소)

| ID | 질문 | 결정 |
|----|------|------|
| **G1** | T2 boilerplate 포함 여부 | **Option C — T1 only in v1.10e, T2 in v1.10e2 후속** (R1) |
| **G2** | LICENSE 파일명 우선순위 | `LICENSE` → `.md` → `.txt` → `COPYING`, case-insensitive (R2) |
| **G3** | 자동 적용 6 → 7 | 7건 채택 (R5) |
| **G4** | LICENSE 부재 처리 | T3 fallback (R3) |
| **G5** | agents.md L5 license 라인 자체 정책 | **별도 v1.10h** — 본 v1.10e는 placeholder 자동화 본질 (라인 제거 결정과 별건) |

(G6-G9 — dual-license / 메타데이터 / GPL or-later / Unlicense — 모두 G1 종속, T2 채택 시점에 결정. 본 v1.10e 외)

## R7 — 후속 세션 명시 분기 (3건)

| 세션 | scope | 내용 |
|------|------|------|
| `v1.10e2-license-boilerplate` | S2 | T2 boilerplate 매칭 9 패턴 (MIT/Apache/GPL/BSD/ISC/MPL/Unlicense) + GPL or-later + dual-license multi-file |
| `v1.10e3-license-metadata` | S2 | package.json/pyproject.toml/Cargo.toml `license` 필드 추출 + SEE LICENSE IN file 처리 + UNLICENSED 처리 |
| `v1.10h-agents-md-license-line-policy` | S2 | agents.md spec L5 license 라인 유지/제거/표기 형식 결정 (raison d'être 검토) |

본 v1.10e는 v1.10e2/e3 evidence base 제공 — sample T1 추출률 0% → v1.10e2 채택 결정 자연 유도.
