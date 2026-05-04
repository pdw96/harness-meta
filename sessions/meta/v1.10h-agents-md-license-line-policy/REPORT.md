# meta v1.10h-agents-md-license-line-policy — REPORT

세션 종료: 2026-04-28
선행 세션:

- [`sessions/meta/v1.10e3-license-metadata/`](../v1.10e3-license-metadata/REPORT.md) — T3 메타 4-tier 도입 + ⚠️ "T3 메타 매칭 시 LICENSE 파일 부재 가능 — `(see [LICENSE](LICENSE))` 라인 부정확. v1.10h scope에서 처리"
- [`sessions/meta/v1.10g-skill-thinking-effort/`](../v1.10g-skill-thinking-effort/REPORT.md) — §6 후속 세션 후보 표 v1.10h 명시

## 1. 최종 결과

| 지표 | 수치 |
|------|:---:|
| 변경 파일 (R1 detect + R2+R3 interview + R4 INTERVIEW_FLOW) | **3** |
| 신규 파일 (smoke 1 + PLAN/REPORT 2 + evidence 1 + 분리 PLAN 2) | **6** |
| smoke stage (v1.10h + 회귀 v1.10d + v1.10f + v1.10g) | **4 + 6 + 6 + 5 = 21** |
| smoke 11/11 — Stage 4 fixture 4 checks (Stage 1: 2 + Stage 2: 3 + Stage 3: 2 + Stage 4: 4) | **11** (PLAN 9 → actual 11) |
| sub-item 해소 (LICENSE 부재 link + non-SPDX truncate + 검증) | **3 / 3** |
| Out of scope 명시 분리 | **5 항목** |

## 2. 구현 요약

### R1 — `bootstrap/detect-project.sh` (S2)

```diff
+# v1.10h R1 — license_file: actual LICENSE file relative path (T1/T2/T2-Multi/T2.5 매칭 시 set).
+# T3 only (메타 매칭 + LICENSE 파일 부재) 시 empty → Claude(Bootstrap) L5 link 생략 분기.
+# Cargo subdirectory license-file (e.g., "LICENSES/CUSTOM") edge case 자연 처리.
+license_file=""
+if [ -n "$license_path" ]; then
+    license_file="${license_path#$ROOT/}"
+fi
```

출력 추가:

```diff
+# v1.10h R1: license_file relative path (T1/T2/T2.5 매칭 시) — Claude(Bootstrap) L5 link 분기용
+[ -n "$license_file" ] && echo "license_file = \"$license_file\""
```

근거: sub-item 1 — LICENSE 부재 시 link 깨짐 회피 위한 신호. relative path 채택으로 Cargo subdirectory edge case 자연 처리 + actual filename 활용.

### R2 + R3 — `bootstrap/interview.md` (S2)

**Bootstrap 치환 로직** — 단순 if/else → **3-way 분기 + MAX_LENGTH=80**:

```python
HM_LICENSE      = grep license = ...
HM_LICENSE_FILE = grep license_file = ...   # v1.10h 신규

# sub-item 2 — MAX_LENGTH=80 (Anthropic EULA abuse 차단)
if len(HM_LICENSE) > 80: HM_LICENSE = ""

# 3-way
if HM_LICENSE and HM_LICENSE_FILE: {{license}} = f"{HM_LICENSE} (see [{HM_LICENSE_FILE}]({HM_LICENSE_FILE}))"
elif HM_LICENSE:                    {{license}} = HM_LICENSE
else:                               {{license}} = "see LICENSE."
```

**3 케이스 표** + **MAX_LENGTH 정당화** (47/45/50자 SPDX upper) + **HM_LICENSE_FILE relative path semantics** (LICENSE/LICENSE.md/COPYING/LICENSES/CUSTOM) + **알려진 한계** (Issue B / Case 3 enhancement v1.10i+ 이연) 추가.

`## License 처리` 섹션 후속 분기 갱신: v1.10h 해소 + v1.10h2 분리 + v1.10i+ 이연 명시.

### R4 — `bootstrap/docs/INTERVIEW_FLOW.md` (S2)

3 부위 갱신:

1. §2.1 S3 preview 표 `{{license}}` 행 — 3-way 케이스 명시 + MAX_LENGTH 언급
2. §3.1 detect output 파싱 — `detected_license_file` extraction 추가
3. §3.3 v1.10e/e2/e3 → **v1.10h (3-way 분기)** 헤더 변경 + `HM_LICENSE_FILE` env 각주 + MAX_LENGTH=80 § + 파일별 변수 카운트 표 갱신 (L5 정리 v1.10h2 분리 명시)

### Smoke (sub-item 3) — `tests/smoke-license-line-policy.sh`

4 stage 11 checks:

- Stage 1: detect-project.sh source (2)
- Stage 2: interview.md 3-way + MAX_LENGTH (3)
- Stage 3: INTERVIEW_FLOW.md (2)
- Stage 4: end-to-end fixture (4) — Fixture A (LICENSE + MIT) + Fixture B (pyproject + 부재)

LF eol + set -euo pipefail + mktemp 자동 cleanup.

## 3. Smoke 결과

### v1.10h — `tests/smoke-license-line-policy.sh` 11/11 PASS

```
Stage 1 — detect-project.sh license_file (R1)        ✓ ✓
Stage 2 — interview.md R2+R3 (3-way + MAX_LENGTH=80) ✓ ✓ ✓
Stage 3 — INTERVIEW_FLOW.md R4                       ✓ ✓
Stage 4 — end-to-end fixture
  Fixture A (LICENSE + MIT):
    license = "MIT" (T2 boilerplate)                 ✓
    license_file = "LICENSE" (R1 출력)               ✓
  Fixture B (pyproject + LICENSE 부재):
    license = "MIT" (T3 메타)                        ✓
    license_file 출력 부재 (T3 only)                 ✓

결과: 11 PASS / 0 FAIL
```

evidence: [`evidence/smoke-license-line-policy.txt`](evidence/smoke-license-line-policy.txt)

### 회귀 — v1.10d 6/6 + v1.10f 6/6 + v1.10g 5/5 PASS

| Smoke | 결과 |
|------|:---:|
| `tests/smoke-bash-permission-pattern.sh` (v1.10d) | 6/6 ✓ |
| `tests/smoke-broad-bash-fine-grain.sh` (v1.10f) | 6/6 ✓ |
| `tests/smoke-thinking-effort.sh` (v1.10g) | 5/5 ✓ |

R1~R4 모두 license-only 영역 — frontmatter / Bash permission 무영향. 회귀 0건.

## 4. 판정

| PLAN 체크박스 | 상태 |
|------|:---:|
| 세션 디렉토리 생성 | ✓ |
| PLAN.md 작성 (Scope contract 섹션 포함) | ✓ |
| Stage A — detect-project.sh R1 | ✓ |
| Stage B — interview.md R2 + R3 | ✓ |
| Stage C — INTERVIEW_FLOW.md R4 | ✓ |
| Stage D — Smoke 11/11 PASS (PLAN 9 → 실 11) | ✓ |
| Stage E — REPORT.md 작성 | ✓ (본 파일) |
| 사용자 확인 후 단일 커밋 | (대기) |

→ **모든 PLAN 목표 달성 + Smoke 초과 (9 → 11)**. 사용자 확인 후 커밋.

## 5. Out of scope 분리 재확인 (5건)

| ❌ Item | 분리 대상 | 진행 상태 |
|--------|---------|:---:|
| L5 `See [README.md](README.md) for project overview...` 제거 | `v1.10h2-l5-readme-link-cleanup` | placeholder PLAN 작성 ✓ |
| Case 3 enhancement (license empty + file → actual filename link) | `v1.10i+` | 이연 |
| Issue B (T1/T2 fail + T3 hit + LICENSE 존재 discrepancy) | `v1.10i+` | 이연 |
| non-SPDX 정규화 map (`Apache 2.0` → `Apache-2.0`) | `v1.10i+` | 이연 |
| Scope contract mechanism 정식화 (OWNERSHIP.md 갱신) | `v1.10j-scope-contract-discipline` | placeholder PLAN 작성 ✓ |

본 v1.10h PLAN.md `## Out of scope (explicit rejection)` 섹션이 위 5건을 명시적으로 부정 — 본문 진입 차단 demo 성공.

## 6. Lessons Learned

### L1 — Scope contract 두 섹션이 over-scope 1차 차단 demo

본 v1.10h가 `Scope inheritance (verbatim)` + `Out of scope (explicit rejection)` 두 섹션 도입의 **1차 demo**.

**효과**:

- v1 PLAN (initial): Issue A/B/C/D + G3 + R3 모두 본문 → over-scope
- v3 PLAN (rectified): Issue A/C만 본문 + 5건 Out of scope 표로 분리 → strict scope
- 본문 작업 = 인용 sub-item 3개 (LICENSE 부재 / non-SPDX truncate / 검증)에 100% 매핑

**평가 시점**: v1.10j 정식화 시 본 효과 정량화 + verify.ps1 자동 검사 도입.

### L2 — relative path > basename (Cargo subdirectory edge case)

`license_file = "${license_path#$ROOT/}"` (relative) 채택 → `LICENSES/CUSTOM-LICENSE` (Cargo `[package].license-file`) 자연 처리. basename 채택 시 link target 부정확 → broken anchor.

추상화 비용 0 (1행 변경) vs 안정성 +1 → Pareto improvement.

### L3 — MAX_LENGTH=80 = SPDX 50% margin

SPDX longest 47자 + 50% margin = 80. False positive 0 + Anthropic EULA abuse 차단.

향후 SPDX spec evolution 시 margin 부족하면 재평가 (현재 ~70자 upper bound 기준 50% safe).

### L4 — Smoke fixture는 mktemp + 실제 detect 실행 ≫ static grep

Stage 4 Fixture A/B (mktemp 디렉토리 + LICENSE 콘텐츠 작성 + 실제 `bash detect-project.sh` 실행) → end-to-end 검증.

대안 (static grep만)은 R1 logic 작동 검증 못 함 — 변수 정의/echo 라인만 확인. fixture 추가 비용 ~30 lines vs 결정적 검증 효익 무한대.

### L5 — round-trip 미보장 정책 일관성

bootstrap 1회성 + LICENSE/메타 변경 후 AGENTS.md L5 수동 갱신 — v1.10b ~ v1.10e3 일관성 유지. v1.10h가 새 정책 도입하지 않음 (forward-only 변경 — 기존 `<proj>/AGENTS.md` 무영향).

마이그레이션 비용 0 = 사용자 disrupt 0.

## 7. 후속 세션 (placeholder PLAN 작성 완료)

| 세션 | scope | 상태 |
|------|------|:---:|
| **`v1.10h2-l5-readme-link-cleanup`** | S2 | placeholder PLAN ✓ — AGENTS.md.tmpl L5 `See [README.md]...` 제거 |
| **`v1.10j-scope-contract-discipline`** | S2 | placeholder PLAN ✓ — OWNERSHIP.md 갱신 + 두 섹션 의무화 + verify rule |
| `v1.10i` (가설) | S2 | 미작성 — non-SPDX 정규화 + Issue B WARN + Case 3 enhancement (evidence-driven) |
| `sessions/upbit/v1.2-bash-permission-update` | S6 | T4 후행 (v1.10d + v1.10g) |

## 8. 관련 문서

- PLAN: [`PLAN.md`](PLAN.md)
- evidence: [`evidence/smoke-license-line-policy.txt`](evidence/smoke-license-line-policy.txt)
- 선행 세션 v1.10e3: [`../v1.10e3-license-metadata/`](../v1.10e3-license-metadata/)
- 선행 세션 v1.10g: [`../v1.10g-skill-thinking-effort/`](../v1.10g-skill-thinking-effort/)
- 후속 분리: [`../v1.10h2-l5-readme-link-cleanup/PLAN.md`](../v1.10h2-l5-readme-link-cleanup/PLAN.md) · [`../v1.10j-scope-contract-discipline/PLAN.md`](../v1.10j-scope-contract-discipline/PLAN.md)
- 본 정책 단일 소스: `bootstrap/interview.md` `## License 처리` § + `bootstrap/docs/INTERVIEW_FLOW.md` §3.3
