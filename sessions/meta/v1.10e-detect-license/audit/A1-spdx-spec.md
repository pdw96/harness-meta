# A1 — SPDX spec + License detection reference (verbatim)

본 문서는 v1.10e audit의 reference base. T1 (SPDX-License-Identifier 헤더 추출) 본 세션 scope 정확 일치 + T2/T3/메타데이터 처리 후속 분기 명시.

**출처**:
- 공식 (SPDX): `https://spdx.org/licenses/` — SPDX License List
- 공식 (npm): `https://docs.npmjs.com/cli/v10/configuring-npm/package-json#license`
- 공식 (agents.md): `https://agents.md/`
- 보조 (SPDX matcher): `https://github.com/spdx/spdx-license-matcher` — Sorensen dice + cosine similarity 알고리즘

조회일자: 2026-04-27.

---

## 인용 1 — SPDX-License-Identifier 표준 (T1의 근거)

SPDX 표준 verbatim (spdx.dev):
> "License detection typically uses multiple algorithms: **first looking for SPDX-License-Identifier tags**, then template matching from built-in repositories, and finally using term frequency inverse document frequency algorithms with Cosine similarity to find the best matching license."

→ **3-tier detection**의 1단계 = SPDX-License-Identifier 헤더 grep. 100% 신뢰도. 본 v1.10e가 채택한 T1.

### SPDX-License-Identifier 헤더 형식

```
SPDX-License-Identifier: MIT
```

또는 dual-license:
```
SPDX-License-Identifier: MIT OR Apache-2.0
```

- 위치: 파일 첫 5-10 라인 (관례)
- LICENSE 파일에 직접 추가 가능 — modern OSS 권장 패턴
- 그러나 대부분의 LICENSE 파일은 boilerplate만 (SPDX 헤더 미포함) — 실용 한계

## 인용 2 — agents.md spec (license 필드 미정의)

agents.md verbatim:
> "Are there required fields? No. AGENTS.md is just standard Markdown. Use any headings you like; the agent simply parses the text you provide."

→ AGENTS.md spec에 **license 필드 자체 미정의**. 본 repo의 `License: see LICENSE.` placeholder는 v1.10b가 도입한 관례. spec 외 자유 영역 — 정책 결정 자유도 ↑.

**시사**:
- v1.10c가 인용한 "agents.md 공식 spec 일관 (LICENSE 파일 reference)"는 부정확
- 본 v1.10e의 placeholder 자동화는 spec 외 관례 유지 (위반 정도 동일)
- 라인 자체 제거/유지 정책은 별도 결정 (v1.10h 분리)

## 인용 3 — npm package.json license 필드 (메타데이터, scope 외)

npm 공식 verbatim:
> SPDX expression: `"license": "BSD-3-Clause"` / `"license": "(ISC OR GPL-3.0)"` / `"license": "SEE LICENSE IN <filename>"` / `"UNLICENSED"`

→ Node 프로젝트는 `package.json`에서 license 필드 추출 가능.

**v1.10e scope 외**: 본 세션은 LICENSE 파일 SPDX 헤더만. package.json/pyproject.toml/Cargo.toml 메타데이터 license 필드는 **v1.10e3 후속**.

## 인용 4 — SPDX 12 canonical License ID

| ID | 풀네임 |
|----|-------|
| `MIT` | MIT License |
| `Apache-2.0` | Apache License 2.0 |
| `GPL-3.0-or-later` | GNU GPL v3.0 or later |
| `GPL-2.0-or-later` | GNU GPL v2.0 or later |
| `BSD-3-Clause` | BSD 3-Clause "New" or "Revised" License |
| `BSD-2-Clause` | BSD 2-Clause "Simplified" License |
| `ISC` | ISC License |
| `MPL-2.0` | Mozilla Public License 2.0 |
| `LGPL-3.0-or-later` | GNU Lesser GPL v3.0 or later |
| `AGPL-3.0-or-later` | GNU Affero GPL v3.0 or later |
| `Unlicense` | The Unlicense |
| `CC0-1.0` | Creative Commons Zero v1.0 Universal |

→ **case-sensitive** (정확히 위 표기 사용). T1 grep 결과는 그대로 stamp (ID 검증은 SPDX matcher 등 별도 도구 영역).

## 인용 5 — SPDX matcher 알고리즘 (T2/T3 정밀도 한계)

SPDX matcher verbatim:
> "tokenize → bigrams → Sorensen dice algorithm → cosine similarity"

→ 정교한 license 매칭 (T2 boilerplate fuzzy matching)은 cosine similarity 등 ML 알고리즘 필요. **bash detect-project.sh로 불가** — 단순 grep만 가능.

**v1.10e 결정**:
- T1 (SPDX 헤더 grep) — bash 가능, 100% 신뢰
- T2 (boilerplate fuzzy) — bash 한계 → **v1.10e2 후속** (또는 단순 첫 라인 매칭으로 우회)
- T3 (fallback) — 미식별 시 output 없음 + S3 WARN

본 v1.10e는 T1 + T3만. T2는 단순 grep으로 첫 라인 매칭 가능하지만 false positive risk (boilerplate 변형 다양) — Conservative 채택.

## 인용 6 — v1.10c 폐기 결정 verbatim

`sessions/meta/v1.10c-bootstrap-content-defaults/PLAN.md`:
> **License 자동 default 폐기** (Agent 2 + Agent 4-B 중복 신호):
> - agents.md 공식 spec — License는 권장 § 아님. 60,000+ 채택 사례에서 LICENSE 파일 reference가 표준
> - 법적 오인 리스크 — GitHub repo 34%가 license 미선언 (proprietary 의도). MIT 자동 stamp는 Apache/GPL/Proprietary 의도자에게 git log 영구 박힘
> - 권위 도구 — cargo new 의도적 미stamp / npm init ISC RFC 논쟁 中 / poetry init default 없음
> - **결정**: v1.10b placeholder `License: see LICENSE.` 유지. v1.10e-detect-license 후속 분리

**시사**:
- v1.10c 거부 = injection (사용자 입력 없이 stamp)
- v1.10e 채택 = observation (사용자가 LICENSE 작성 시만 추출)
- 본질 다름 — v1.10c 거부 이유 무력화 (audit/A5에서 상세)

## 인용 7 — v1.10c REPORT v1.10e promise verbatim

`sessions/meta/v1.10c-bootstrap-content-defaults/REPORT.md` 또는 PLAN의 후속 세션 link:
> **v1.10e-detect-license** (S2, 본 세션 폐기 결정 후속) — License 안전 처리. detect-project.sh가 LICENSE 파일 SPDX 헤더 추출 + S3 preview WARN. **본 세션이 license 미터치한 placeholder를 정식 자동화**

→ promise **3건 명시**:
1. **detect-project.sh — SPDX 헤더 추출** (T1만 명시)
2. **S3 preview — WARN** (LICENSE 부재 시)
3. **AGENTS.md.tmpl placeholder — 자동화** (변수 치환)

본 v1.10e PLAN은 promise 정확 일치 (Option C — Hybrid: T1 only in v1.10e, T2/T3 boilerplate는 v1.10e2 후속).

## 인용 8 — Linguist 알고리즘 reference (확인 불가, 보조)

GitHub Linguist의 license detection은 SPDX matcher와 유사한 fuzzy matching. 본 audit는 단순 grep 기반 — Linguist 깊이 미달성. 사용자 LICENSE 파일에 SPDX 헤더 추가 권장 안내 가능 (별도 doc 또는 INTERVIEW_FLOW.md 1줄).

## 통합 결론 — v1.10e scope (Option C)

| Tier | 본 v1.10e 처리 | 후속 |
|------|:--------------:|:----:|
| **T1 — SPDX-License-Identifier 헤더** | ✅ 채택 | — |
| **T2 — boilerplate 매칭 (fuzzy)** | ❌ 별도 후속 | **v1.10e2** |
| **T3 — fallback (output 없음 + WARN)** | ✅ 채택 | — |
| **메타데이터 license 필드 (npm/PEP/Cargo)** | ❌ 별도 후속 | **v1.10e3** |
| **dual-license / multi-file** | ❌ 별도 후속 | **v1.10e2** |

**v1.10e scope 정확 일치**: v1.10c promise 3건 + Hybrid Option C (T1만, T2/T3 후속 분리).
