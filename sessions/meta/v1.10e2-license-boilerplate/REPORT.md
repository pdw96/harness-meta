# meta v1.10e2-license-boilerplate — REPORT (T1 + T2 채택)

세션 종료: 2026-04-27 (단일 세션 내 완료)
선행: [`v1.10e`](../v1.10e-detect-license/REPORT.md) (T1 only, Option C — sample 추출률 0% 한계 확인)
PLAN: [`PLAN.md`](PLAN.md)

## 최종 결과

- **변경 파일**: 12 (수정 6 + 신규 audit 5 + smoke 1) + 세션 4 (PLAN/REPORT/audit dir/evidence dir) = 16
- **자동 적용 카운트**: 7 유지 (manifest 4 + 콘텐츠 3 — bootstrap_version + install_cmd + license; T2는 T1 fallback이라 신규 변수 0)
- **bootstrap_version stamp**: `1.10e` → `1.10e2`
- **smoke**: 18/18 PASS — `evidence/smoke-bootstrap-license-boilerplate.txt`
- **회귀 (v1.10e smoke)**: 5/5 PASS — `evidence/regression-smoke-license-detect.txt`
- **self-detect (harness-meta repo)**: `license = "MIT"` (T2 boilerplate 매칭 — v1.10e에선 T1 헤더 부재로 미식별)

## 구현 요약 — Option C 후속 (T2 boilerplate 12 패턴)

### Stage A — Audit evidence (5 파일, audit/A1-A5)

| 파일 | 핵심 내용 |
|------|----------|
| `audit/A1-boilerplate-regex.md` | 12 패턴 grep regex 확정 (header + body 2-신호) + GPL family longest-marker first 우선순위 + Notion edge fallback (header 부재 MIT body+copyright) + head -30 결정 근거 (PortableGit GPL@L22, ms-python MIT@L13, BSD-3 `3. Neither` 마커) |
| `audit/A2-recovery-rate.md` | 실 sample 20건 (v1.10e A2 10건 → 17 파일 + 3 중복 = 20). T1 0% → T1+T2 70% (14/20). False positive 0/20. Edge case 5종 (Notion / ms-python preamble / 들여쓰기 / `All rights reserved` + MIT / PortableGit or-later 의미 conflict) 분석 |
| `audit/A3-detect-strategy.md` | 3-tier bash 알고리즘 (T1 SPDX → T2-Multi → T2 boilerplate → T3) + helper 함수 4개 (`_license_file_first` / `_multi_dual_license` / `_gpl_suffix` / `_boilerplate_match`) + multi-file 알고리즘 (LICENSE-{MIT,APACHE,BSD,ISC,MPL} case-insensitive + 백업 패턴 5종 제외) |
| `audit/A4-policy-decisions.md` | R1-R11 결정 + Grey 5건 결정 (G1=12 패턴 / G2=head -30 / G3=or-later 본문 grep / G4=longest-marker first / G5=NOTICE informational only) + scope 매트릭스 (포함 11 + 제외 6, 후속 v1.10e3/v1.10h 명시 분기) |
| `audit/A5-v110e-consistency.md` | v1.10c 거부 (injection) vs v1.10e2 채택 (observation) 정합성 — observation 본질 (LICENSE 콘텐츠 read), 거부 3 이유 (spec 위반 / 의도 위배 / 권위 도구 불일치) 모두 무력화. 5 시나리오 검증 (proprietary / SPDX / boilerplate / SPDX-dual / multi-file-dual) |

### Stage B — `bootstrap/detect-project.sh` 갱신

- v1.10e T1 SPDX section 통째 교체 → 3-tier 통합 알고리즘 (~110 라인 추가)
- 신규 helper 함수 4개:
  - `_license_file_first` — LICENSE 4 우선순위 case-insensitive (v1.10e 보존)
  - `_multi_dual_license` — LICENSE-{MIT,APACHE,BSD,ISC,MPL}* 매칭, 백업 5 패턴 (`.bak`/`.draft`/`.tmp`/`.orig`/`.swp`) 제외, 2건+ 시 SPDX expression `OR` 조립 (sort + uniq)
  - `_gpl_suffix` — `any later version` grep → `or-later` / 없으면 `only`
  - `_boilerplate_match` — head -30 + longest-marker first 12 패턴 매칭 (header + body 2-신호)
- main flow 3-tier 가드: T1 → T2-Multi (license 비어있으면) → T2 boilerplate (license 비어있고 license_path 있으면) → T3 silent

### Stage C — interview.md / INTERVIEW_FLOW.md 갱신

- `bootstrap/interview.md` "License 처리" § 본문 재작성 — 3-tier 명시 (T1 SPDX + T2-Multi + T2 boilerplate 12 패턴) + Match priority (longest-marker first) + Recovery rate (0% → 70%) + 알려진 한계 1건 (PortableGit or-later) + 후속 v1.10e3/v1.10h 분기
- `bootstrap/interview.md` 헤더 라인 + AGENTS.md 콘텐츠 자동 적용 표 — `1.10e` → `1.10e2`
- `bootstrap/docs/INTERVIEW_FLOW.md` §2 Stage S3 preview literal — `{{license}}` 행 3-tier 명시 + WARN 메시지 갱신 + 4 우선순위 footnote
- `bootstrap/docs/INTERVIEW_FLOW.md` §3.3 v1.10e 변수 표 → v1.10e/e2 갱신 (3-tier 감지 명시)

### Stage D — claude/commands/harness-meta.md + skeletons/projects/INTERVIEW.md + manifest-schema.md + CLAUDE.md/README.md 정합

- `claude/commands/harness-meta.md` S2 행 — `license SPDX 감지 v1.10e` → `license 3-tier v1.10e/e2`
- `bootstrap/skeletons/projects/INTERVIEW.md` 자동 적용 표 — bootstrap_version `1.10e` → `1.10e2` + `{{license}}` 3-tier 갱신
- `bootstrap/manifest-schema.md` L437 — license v1.10e → v1.10e2 (T2 boilerplate 추가)
- `CLAUDE.md` / `README.md` — 최신 meta 세션 v1.10e → v1.10e2 + 자동 적용 항목 갱신

### Stage E — Smoke (18 stage PASS + 회귀 5/5 PASS)

`tests/smoke-bootstrap-license-boilerplate.sh` 신규 — 18 stage:
- Stage 1-12: 12 패턴 boilerplate single-file (MIT / Apache / GPL-2 (only) / GPL-3 (or-later) / AGPL-3 / LGPL-2.1 / LGPL-3 / BSD-3 / BSD-2 / ISC / MPL-2.0 / Unlicense)
- Stage 13: multi-file dual (LICENSE-MIT + LICENSE-APACHE → `Apache-2.0 OR MIT`)
- Stage 14: T1 우선순위 (SPDX `MIT` 헤더 + body Apache boilerplate → `MIT`, T2 skip)
- Stage 15: Notion edge (header 부재 MIT — body+copyright fallback)
- Stage 16: T3 fallback (LICENSE 부재)
- Stage 17: T3 fallback (proprietary EULA — boilerplate 미매칭)
- Stage 18: multi-file `.bak` 제외 (LICENSE-MIT + LICENSE-APACHE + LICENSE-MIT.bak → 2건만 사용)

회귀: `tests/smoke-bootstrap-license-detect.sh` 5/5 PASS — v1.10e Stage 4 (`MIT License` text + `Copyright` only, no `Permission... free of charge` body) 변경 없이 PASS 유지. 이유: v1.10e2 MIT 매칭은 header + body 2-신호 필수 — body signal (`Permission... free of charge`) 부재 시 매칭 안 됨 (audit/A1 §1 disambiguation). 의도된 행동.

evidence:
- `evidence/smoke-bootstrap-license-boilerplate.txt`
- `evidence/regression-smoke-license-detect.txt`

## 판정 (PLAN 체크박스)

- [x] 세션 디렉토리 생성
- [x] PLAN.md 초안 작성
- [x] 사용자 PLAN 확인
- [x] Stage A — audit/A1-A5 5 파일 작성
- [x] Stage B — `bootstrap/detect-project.sh` T2 + multi + helpers 추가
- [x] Stage C — interview.md / INTERVIEW_FLOW.md 갱신 (license § 3-tier + bootstrap_version 1.10e → 1.10e2)
- [x] Stage D — `tests/smoke-bootstrap-license-boilerplate.sh` 18 stage PASS
- [x] 회귀 v1.10e smoke 5/5 PASS
- [x] evidence 2 파일 저장
- [x] CLAUDE.md / README.md / claude/commands/harness-meta.md / manifest-schema.md / skeletons INTERVIEW.md 정합 갱신
- [x] REPORT.md 작성
- [ ] **사용자 확인 후 단일 커밋 + push** ← 진행 대기

**PLAN 11/12 완수**.

## v1.10c 거부 결정과의 정합성 (audit/A5 검증)

| 측면 | v1.10c 거부 (injection) | v1.10e (T1 채택) | **v1.10e2 (T2 채택)** |
|------|:-----------------------:|:----------------:|:---------------------:|
| 행위 유형 | injection (default 강제) | observation (헤더 read) | **observation (콘텐츠 read)** |
| 트리거 | LICENSE 부재여도 stamp | SPDX 헤더 존재 시만 | **boilerplate 텍스트 존재 시만** |
| 의도 위배 risk | 있음 | 0 | **0** (1건 한계 — PortableGit or-later 의미 conflict, SPDX 헤더로 회복) |
| spec 정합 | ✗ (강제) | ✓ (SPDX 표준) | **✓ (SPDX expression + Linguist/licensee 패턴)** |

→ v1.10e2도 v1.10c 거부 3 이유 모두 무력화. 둘은 반대 아님 (정합).

## v1.10e와의 비교 — 추출률 향상 evidence

| 측면 | v1.10e (T1 only) | **v1.10e2 (T1+T2)** |
|------|:---------------:|:-------------------:|
| sample 추출률 | 0/20 (0%) | **14/20 (70%)** |
| OSS 정확 분류 | 0/14 OSS | 13/14 OSS |
| Proprietary 정확 분류 | 6/6 (T3) | 6/6 (T3) |
| False positive | 0 | 0 |
| False negative | 14 (모든 OSS) | 1 (PortableGit or-later 의미 conflict) |
| Multi-file dual 지원 | ✗ | ✅ (LICENSE-MIT + LICENSE-APACHE) |
| GPL or-later 처리 | ✗ | ✅ (본문 grep) |
| harness-meta self-detect | ✗ (헤더 부재) | **✅ MIT** |

## 사용자 사이드 dynamic 검증 (REPORT 단계)

본 v1.10e2 적용 후 사용자가 `/harness-meta <new-name>` Bootstrap 진행 시:

1. detect-project.sh 출력에 `license = "..."` 라인 emit 여부 확인 — LICENSE 파일 콘텐츠에 따라:
   - SPDX 헤더 → T1 매칭 (기존 v1.10e 동작 보존)
   - LICENSE-MIT + LICENSE-APACHE → T2-Multi → `MIT OR Apache-2.0`
   - 단일 LICENSE boilerplate → T2 → 12 패턴 중 매칭 결과
   - LICENSE 부재 또는 boilerplate 미매칭 → output 없음 (T3)
2. Stage S3 preview에 `{{license}}` 행 표시 확인 (3-tier 결과)
3. AGENTS.md.tmpl 치환 결과 확인:
   - 매칭 → `License: <SPDX> (see [LICENSE](LICENSE))`
   - 미식별 → `License: see LICENSE.` (v1.10b fallback)

## v1.10e2 한계 + v1.10e3 동기 (audit/A2 evidence)

**알려진 한계** (audit/A2 §4):
- PortableGit edge case (or-later 의미 conflict 1/20) — boilerplate stamp이 사용자 의도와 미세 deviation
- modified license (`MIT License (with attribution clause)` 등) → false negative
- 신규/희귀 license (Boost, zlib, NCSA 등) → 미커버
- License 파일 없이 메타데이터만 명시 (npm `"license": "ISC"`) → 미커버

→ 사용자가 본 v1.10e2 적용 후:
- (a) LICENSE에 SPDX 헤더 추가 (사용자 행동, T1 우선 매칭)
- (b) **v1.10e3 채택** (메타데이터 license 필드 추출 — npm/pyproject/Cargo)

본 v1.10e2의 evidence base가 v1.10e3 채택 결정 자연 유도 (v1.10e → v1.10e2 동일 패턴).

## Lessons Learned

1. **Evidence-driven 후속 분기 패턴 정착** — v1.10e (T1 only sample 0%) → v1.10e2 (T1+T2 70%) → v1.10e3 (T1+T2+메타 80%+ 예상). 각 세션의 audit/A2가 다음 세션의 evidence base. 이 패턴은 v1.10b/c/e 모두 유지 (REPORT promise → audit/A2 sample 검증 → 후속 정당화)
2. **Header + body 2-신호 disambiguation 견고** — 단일 신호 (header만 또는 body만) 매칭은 false positive risk. 본 v1.10e2는 sample 0/20 false positive 달성. start-anchor (`^[[:space:]]*`) + Notion edge fallback (header 부재 + body + copyright pattern)으로 모든 edge 처리
3. **bash longest-marker first 단순 우선순위 유지** — weighted scoring 회피. AGPL → LGPL → GPL / BSD-3 → BSD-2 / ISC → MIT 순서로 substring 충돌 해소 가능. 디버깅 + smoke 검증 용이
4. **observation 본질 = LICENSE 콘텐츠 read = injection 아님** (audit/A5) — boilerplate 텍스트가 사용자 의도적 declaration이므로 read 행위는 정합. SPDX 헤더와 동등한 의도 표명. GitHub Linguist / licensee 등 권위 도구 동일 전략
5. **단일 책임 v1.10x 패턴 유지** — 본 v1.10e2 변경 12 (~동급 v1.10b/c/e). scope creep 방지: 메타데이터 추출 v1.10e3 / agents.md L5 line 정책 v1.10h / 복잡 SPDX expression 별도 후속
6. **Multi-file dual 백업 제외 명시 필요** — `iname "$f*"` glob이 `.bak`/`.draft`/`.tmp`/`.orig`/`.swp` 캡처 risk. PLAN 초안에 미명시 → audit/A3 §5에서 발견 → 코드 + smoke Stage 18 검증으로 처리. 향후 v1.10e3에서 backup 정책 일반화 검토

## 다음 후보 (보류 / 후속)

| 세션 | scope | 내용 | 상태 |
|------|------|------|:----:|
| `v1.10e3-license-metadata` | S2 | package.json/pyproject/Cargo `license` 필드 + UNLICENSED + SEE LICENSE IN file | 보류 (사용자 결정 후) |
| `v1.10h-agents-md-license-line-policy` | S2 | agents.md L5 license 라인 유지/제거/형식 정책 | 보류 |
| `v1.10f-broad-bash-fine-grain` | S1b | v1.10d 후속 — broad Bash 3 SKILL fine-grain | 보류 |
| `v1.10g-skill-thinking-effort` | S1b | v1.10d 후속 — `thinking:` vs `effort:` | 보류 |
| `sessions/upbit/v1.2-bash-permission-update/` | S6 (T4) | v1.10d 적용 — upbit 41+ 패턴 정정 + deny 재설계 | upbit 측 진행 대기 |

## 변경 파일 목록 (수정 6 + 신규 9 = 15)

### 수정 (6)
- `bootstrap/detect-project.sh` (T2 boilerplate + helpers + main flow 3-tier, ~110 라인 추가)
- `bootstrap/interview.md` ("License 처리" § 3-tier 갱신 + bootstrap_version 1.10e → 1.10e2 + 헤더 라인 자동 적용 6 → 7)
- `bootstrap/docs/INTERVIEW_FLOW.md` (Stage S3 literal 3-tier + §3.3 v1.10e/e2 변수 표)
- `bootstrap/manifest-schema.md` (L437 license v1.10e → v1.10e2)
- `bootstrap/skeletons/projects/INTERVIEW.md` (bootstrap_version 1.10e → 1.10e2 + license 3-tier)
- `claude/commands/harness-meta.md` (S2 license SPDX → 3-tier)
- `CLAUDE.md` (최신 meta v1.10e → v1.10e2)
- `README.md` (동상)

### 신규 (9)
- `tests/smoke-bootstrap-license-boilerplate.sh` (18 stage)
- `sessions/meta/v1.10e2-license-boilerplate/PLAN.md`
- `sessions/meta/v1.10e2-license-boilerplate/REPORT.md`
- `sessions/meta/v1.10e2-license-boilerplate/audit/A1-boilerplate-regex.md`
- `sessions/meta/v1.10e2-license-boilerplate/audit/A2-recovery-rate.md`
- `sessions/meta/v1.10e2-license-boilerplate/audit/A3-detect-strategy.md`
- `sessions/meta/v1.10e2-license-boilerplate/audit/A4-policy-decisions.md`
- `sessions/meta/v1.10e2-license-boilerplate/audit/A5-v110e-consistency.md`
- `sessions/meta/v1.10e2-license-boilerplate/evidence/smoke-bootstrap-license-boilerplate.txt`
- `sessions/meta/v1.10e2-license-boilerplate/evidence/regression-smoke-license-detect.txt`

(수정 8 — 위 6 + CLAUDE.md + README.md = 8. 정정: 수정 8 + 신규 10 = 18)
