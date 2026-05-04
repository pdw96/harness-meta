# A4 — Policy 결정 (R1-R10 + Grey 5 + scope 매트릭스)

본 audit의 policy 결정. v1.10e Option C 후속 — T2 boilerplate 매칭 채택 + scope creep 차단.

## R1 — T2 boilerplate 12 패턴 채택

**결정**: T1 (v1.10e SPDX 헤더) 보존 + T2 (12 boilerplate 패턴) 추가 + T3 (fallback).

**근거** (audit/A1-A2 종합):

- v1.10e A2 sample 추출률 0% (T1 only) → v1.10e2 70% (T1+T2) — audit/A2 §3
- v1.10e REPORT promise 정확 일치: "T2 boilerplate 9 패턴 + GPL or-later + multi-file dual-license"
- 본 audit 12 패턴은 promise "9" 약간 초과 — LGPL-2.1 + AGPL-3.0 + LGPL-3.0 추가 (audit/A1 매트릭스). 이유: GPL family 4종(GPL-2/3, AGPL-3, LGPL-2.1/3 = 5)이 promise "9"의 자연스러운 확장. promise 약속한 7 license family (MIT, Apache, GPL, BSD, ISC, MPL, Unlicense) 전부 커버
- v1.10c observation 본질 유지: 사용자 LICENSE 콘텐츠 read만, default stamp 강제 없음

**대안 평가**:

- (A) Conservative T1 only — v1.10e (현 상태). 한계 검증 완료
- (B) Full T1+T2 — 본 결정. recovery rate 70%
- (C) T1+T2+메타데이터 — promise 초과. v1.10e3 분리

## R2 — boilerplate 12 패턴 (G1 결정)

**결정**: **(a) 12 패턴** — MIT / Apache-2.0 / GPL-2.0 / GPL-3.0 / AGPL-3.0 / LGPL-2.1 / LGPL-3.0 / BSD-2-Clause / BSD-3-Clause / ISC / MPL-2.0 / Unlicense

**근거** (audit/A1):

- v1.10e REPORT promise 7 family 전부 커버 (MIT/Apache/GPL/BSD/ISC/MPL/Unlicense)
- GPL family 5 변형 (GPL-2, GPL-3, AGPL-3, LGPL-2.1, LGPL-3) — 실 사용 분포 모두 처리
- BSD 2 변형 (2-Clause, 3-Clause) — 식별 disambiguation

**제외 대안**:

- (b) 9 패턴 (LGPL-2.1 + AGPL-3 제외) — GitHub 통계 상 AGPL-3 전체 OSS의 ~3% 비중. LGPL-2.1 도 legacy 비중 보유. 제외 시 false negative 증가
- (c) 7 패턴 (BSD-2 + LGPL-2.1 + AGPL + Unlicense 제외) — 보수적이나 실용 손실 큼

## R3 — head 라인 수 30 (G2 결정)

**결정**: **(a) head -30**

**근거** (audit/A1 §4 + audit/A2 §1):

- PortableGit GPL-2 boilerplate @ L22 → head -10/-15 부족
- ms-python.python MIT @ L13 (preamble 후) → head -10 경계
- BSD-3-Clause `3. Neither` 마커 본문 중반 → head -30 필요
- head -50은 false positive risk 추가 (license 본문 외 텍스트 capture)

**제외 대안**:

- (b) head -50 — 보수적, false positive 추가 위험
- (c) head -10 — sample 5건 (PortableGit, ms-python python, BSD-3) 누락

## R4 — GPL or-later/only 처리 (G3 결정)

**결정**: **(a) 본문 `any later version` grep → `-or-later` / 없으면 `-only`**

**근거** (audit/A1 §2-4):

- SPDX-License-Identifier 표준에 `-or-later` / `-only` suffix 정의
- GPL boilerplate 본문에 canonical 구문 `(at your option) any later version` 명시 — 정확한 grep 가능
- PortableGit edge case (or-later 의미 conflict) 1건은 한계 명시 — 사용자 SPDX 헤더 추가로 회복

**제외 대안**:

- (b) 통일 `-only` — 보수적이나 OSS 다수 (or-later 채택자) 부정확
- (c) 통일 `-or-later` — 낙관적이나 strict GPL-X.0-only 의도자 부정확

## R5 — Match priority — longest-marker first (G4 결정)

**결정**: **(a) 첫 매칭 + longest-marker first**

**근거** (audit/A1 §2-2 + audit/A3 §3):

- GPL family substring 충돌 (LGPL/AGPL이 GPL substring 포함) → longest-match 필수
- BSD-3 / BSD-2 disambiguation — 3-clause 마커 우선 검사
- ISC / MIT disambiguation — 다른 permission phrase로 자연 분리

**우선순위 명시 표** (audit/A3 §3):

```
T1 → T2-Multi → AGPL-3 → LGPL-3 → LGPL-2.1 → GPL-3 → GPL-2
   → Apache-2.0 → MPL-2.0 → Unlicense
   → BSD-3 → BSD-2
   → ISC → MIT → MIT-no-header (Notion)
   → T3 (output 없음)
```

**제외 대안**:

- (b) 단순 첫 매칭 — GPL-2가 GPL-3 본문도 매칭 risk
- (c) weighted score — bash 복잡도 ↑

## R6 — T1 우선순위 명시

**결정**: SPDX 헤더 매칭 시 T2 skip (early return).

**근거**:

- SPDX-License-Identifier는 사용자 명시 declaration — boilerplate보다 정확
- audit/A1 §2-4 PortableGit edge case 회복 경로 (사용자 SPDX 헤더 추가 시 의미 정확)
- bash flow: T1 변수 non-empty 시 T2 함수 호출 안 함

**구현 명시**: audit/A3 §2-4 main flow `if [ -z "$license" ]` 가드.

## R7 — Multi-file dual-license 처리

**결정**: `LICENSE-{MIT, APACHE, APACHE-2, BSD, ISC, MPL}` 패턴 case-insensitive 매칭. 2건 이상 시 SPDX expression `<id1> OR <id2>` (sort + uniq).

**근거** (audit/A3 §5):

- Rust 컨벤션 (LICENSE-MIT + LICENSE-APACHE — 대표)
- v1.10e REPORT promise 명시 ("multi-file dual-license")
- SPDX expression `OR` 연산자 표준 정합 (npm `license` 필드와 동일 syntax)

**커버 범위**:

- LICENSE-MIT, LICENSE-APACHE, LICENSE-APACHE-2 (suffix 변형), LICENSE-BSD, LICENSE-ISC, LICENSE-MPL
- Rust 외 컨벤션 (LICENSE.MIT, LICENSE_MIT 등 underscore/dot 변형) — **미커버**, v1.10e3 검토

## R8 — NOTICE 보조 informational only (G5 결정)

**결정**: **(a) informational only** — Apache-2.0 매칭 시 NOTICE 존재 log. output 동일.

**근거** (audit/A3 §4):

- NOTICE는 Apache-2.0 선택 사항 — 부재가 부정 신호 아님
- 매칭 정확도 향상 evidence 부족 (현 sample 17 중 Apache-2.0 3건 모두 NOTICE 부재인지 확인 필요 — 현재는 정보만)

**향후 확장**: v1.10e2 적용 후 evidence 추가 수집 시 strict mode 재고려.

## R9 — bootstrap_version stamp 갱신

**결정**: `1.10e` → `1.10e2`.

**위치**:

- `bootstrap/interview.md` "현 시점 `1.10e`" → `1.10e2`
- `bootstrap/docs/INTERVIEW_FLOW.md` §2 Stage S3 literal `{{bootstrap_version}}` 1.10e → 1.10e2 + §3.3 v1.10b table fallback 갱신

## R10 — 자동 적용 카운트 7 유지

**결정**: 자동 적용 7건 유지 (manifest 4 + 콘텐츠 3 — bootstrap_version + install_cmd + license).

**근거**:

- T2는 T1의 fallback — `{{license}}` 신규 변수 추가 0
- 본 v1.10e2는 license 추출 알고리즘 강화 (T1 only → T1+T2+T3) — 변수 카운트 동일

**제외**: 카운트 변동 (8건 등) — 변경 0 (변수 신규 없음).

## Scope 매트릭스 — 본 v1.10e2 명시 분리

| 항목 | v1.10 (parent) | **v1.10e2 (본)** | 후속 |
|------|:-------------:|:--------------:|:----:|
| T1 — SPDX 헤더 | ✓ (v1.10e 채택) | ✅ (보존) | — |
| T2 — boilerplate 매칭 | ✓ (v1.10e2 약속) | ✅ | — |
| 12 패턴 (MIT/Apache/GPL family/BSD/ISC/MPL/Unlicense) | ✓ | ✅ | — |
| GPL or-later/only suffix | ✓ | ✅ | — |
| Multi-file dual-license (Rust) | ✓ | ✅ | — |
| NOTICE 보조 (Apache-2.0) | — | ✅ (informational) | — |
| T1 우선순위 (early return) | ✓ | ✅ | — |
| T3 fallback (output 없음) | ✓ | ✅ | — |
| head -30 buffer | ✓ | ✅ | — |
| Notion edge (header 부재 MIT) | — | ✅ | — |
| **메타데이터 license (npm/pyproject/Cargo)** | ✓ (v1.10e2 약속) | ❌ | **v1.10e3** |
| **agents.md L5 line 자체 정책** | ✓ | ❌ | **v1.10h** |
| **Complex SPDX expression (compound, AND)** | ✗ | ❌ | (필요 시 별도) |
| **Modified license 변형 (with attribution)** | ✗ | ❌ | (한계 명시) |
| **Underscore/dot multi-file (LICENSE.MIT)** | ✗ | ❌ | (v1.10e3 검토) |
| **harness-meta self-detect** | ✗ | ❌ (smoke fixture만) | — |

**핵심 분리**:

- **v1.10e2 = boilerplate 텍스트 매칭** (LICENSE 파일 콘텐츠 read)
- **v1.10e3 = 메타데이터 매칭** (package.json / pyproject.toml / Cargo.toml `license` 필드)
- 두 세션 모두 **observation 본질** 유지 (audit/A5)

## Grey Areas — 5건 결정

| ID | 질문 | 결정 |
|----|------|------|
| **G1** | boilerplate 패턴 카운트 | **12 패턴** (R2) — promise 7 family 전부 + GPL family 5 변형 |
| **G2** | head 라인 수 | **head -30** (R3) — sample 100% capture |
| **G3** | GPL or-later/only | **본문 grep + suffix** (R4) — SPDX 표준 정합 |
| **G4** | Match priority | **longest-marker first + early return** (R5) |
| **G5** | NOTICE 보조 | **informational only** (R8) — strict 미적용 |

## R11 — 알려진 한계 명시 (audit/A2 footnote)

**결정**: 본 v1.10e2의 false negative 1건 (PortableGit or-later 의미 conflict)을 INTERVIEW_FLOW.md round-trip 한계 안내에 통합.

**문구 (INTERVIEW_FLOW.md)**:
> ⚠️ `{{license}}` boilerplate 매칭은 본문 텍스트 grep에 의존 — 사용자 의도 (or-later vs only)와 파일 boilerplate가 의미 conflict 시 SPDX 헤더 (`SPDX-License-Identifier: <id>`) 추가 권장 (T1 우선 매칭).

## 후속 세션 명시 분기

| 세션 | scope | 내용 |
|------|------|------|
| `v1.10e3-license-metadata` | S2 | package.json/pyproject.toml/Cargo.toml `license` 필드 추출. SPDX expression 처리. SEE LICENSE IN file / UNLICENSED |
| `v1.10h-agents-md-license-line-policy` | S2 | agents.md spec L5 line 자체 정책 (유지/제거/형식 결정) |

본 v1.10e2 한계 → v1.10e3 evidence base 자연 유도 (audit/A2 §6).

## v1.10c/v1.10e 정합성 (audit/A5 별도 검증)

- v1.10c 거부 = injection (default MIT 강제 stamp)
- v1.10e 채택 = observation (사용자 SPDX 헤더 read)
- v1.10e2 채택 = observation (사용자 LICENSE 콘텐츠 read)

→ 모두 정합. 본 v1.10e2도 v1.10c 거부 3 이유 무력화 (audit/A5).
