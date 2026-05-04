# meta v1.10h-agents-md-license-line-policy — PLAN

세션 시작: 2026-04-28
직접 선행 세션:

- [`sessions/meta/v1.10e3-license-metadata/`](../v1.10e3-license-metadata/REPORT.md) — T3 메타 4-tier 도입 + ⚠️ "T3 메타 매칭 시 LICENSE 파일 부재 가능 — `(see [LICENSE](LICENSE))` 라인 부정확. v1.10h scope에서 처리"
- [`sessions/meta/v1.10g-skill-thinking-effort/`](../v1.10g-skill-thinking-effort/REPORT.md) — §6 후속 세션 후보 표 v1.10h 명시

목적: AGENTS.md L5 license 라인 — LICENSE 파일 부재 시 link 조건부 제거 + non-SPDX 메타 MAX_LENGTH=80 truncate + Smoke 검증.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S2(3) `bootstrap/{detect-project.sh, interview.md, docs/INTERVIEW_FLOW.md}` + S3(1) `tests/smoke-license-line-policy.sh` = **4/4 meta**
- **T1 경로 다수결** — S2+S3 전부 meta. project-specific 변경 없음
- **T4 후행 없음** — bootstrap 1-shot 정책 유지 (forward-only, 기존 `<proj>/AGENTS.md` 무영향)

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.10g-skill-thinking-effort/REPORT.md` §6 후속 세션 후보 표** (verbatim):

> | `v1.10h` — AGENTS.md L5 license 라인 정책 | S2 | v1.10e3 미해결 — LICENSE 부재 시 `(see [LICENSE](LICENSE))` 부정확, non-SPDX 메타 truncate, 검증 |

**Source 2 — `bootstrap/interview.md` License 처리 § ⚠️ 노트** (verbatim):

> ⚠️ T3 메타 매칭 시 LICENSE 파일 부재 가능 — `(see [LICENSE](LICENSE))` 라인 부정확. v1.10h scope (L5 라인 자체 정책)에서 처리.

**Parsed sub-items (3 — 변형 금지)**:

1. **LICENSE 부재 시 라인 형식** — T3 메타 매칭 시 깨진 링크 제거
2. **non-SPDX 메타 truncate** — 비표준 값 (긴 EULA 등) 처리 정책
3. **검증** — Smoke 자동화

## Out of scope (explicit rejection)

본 세션 PLAN.md 본문 진입 금지. 인접 발견 issue는 본 섹션에 명시 → 별도 세션으로 분리.

| ❌ Item | 이유 | 분리 대상 |
|--------|------|---------|
| **L5 `See [README.md](README.md) for project overview (human-readable).` 제거** (Issue D / R3 in v2 PLAN) | "라인 자체 정책" umbrella 해석 외 — sub-items 3개 어디에도 명시 없음 | **`sessions/meta/v1.10h2-l5-readme-link-cleanup/`** (사용자 결정 — 별도 분리) |
| **Case 3 enhancement** (license empty + file exists → actual filename link) | 인접 발견. sub-item 1은 "LICENSE 부재" — Case 3는 LICENSE 존재 | **v1.10i+** (evidence-driven 시) |
| **Issue B discrepancy** (T1/T2 fail + T3 hit + LICENSE 존재) | 인접 edge case. sub-item 1은 LICENSE 부재 only | **v1.10i+** |
| **non-SPDX 정규화 map** (`Apache 2.0` → `Apache-2.0`) | sub-item 2는 truncate only — 정규화는 별 작업 | **v1.10i+** |
| **Scope contract mechanism 정식화 (OWNERSHIP.md 갱신)** | meta-policy — 본 세션 sub-items 외 | **`sessions/meta/v1.10j-scope-contract-discipline/`** (사용자 결정) |

## 1. 문제 분석 (sub-item 1 + 2)

### Issue A — sub-item 1: T3 메타 매칭 시 LICENSE 파일 부재 → 깨진 링크

T3 메타 4 source 매칭은 `license_path` 부재 시 가능 (audit/A5 §1 LICENSE 콘텐츠 우선 정책의 부산물). 케이스:

- `pyproject.toml [project].license = "MIT"` + LICENSE 파일 부재
- `package.json "license": "MIT"` + LICENSE 파일 부재
- `Cargo.toml [package].license = "MIT OR Apache-2.0"` + LICENSE 파일 부재 (multi-file dual 미사용 시)

현재 `interview.md` Bootstrap 로직:

```bash
if HM_LICENSE non-empty:
    L5 = "License: $HM_LICENSE (see [LICENSE](LICENSE))"   # ← 깨진 링크
```

링크가 LICENSE 파일을 가리키지만 **파일이 존재하지 않음** → Markdown render 시 broken anchor.

### Issue C — sub-item 2: non-SPDX 메타값 정책 미정

T3 메타에서 비표준 값 가능:

- Anthropic-style long EULA (1000+ 자)
- `"Apache 2.0"` (공백 — npm 비표준)
- `"MIT License"`, `"Proprietary"` 등 custom string

**현재**: 그대로 stamp (observation only, audit/A5 R4 결정).

**v1.10h 정책 — MAX_LENGTH=80 truncate**:

- SPDX longest single ID: `LicenseRef-scancode-polyform-noncommercial-1.0.0` ~47자
- Compound: `MIT AND Apache-2.0 WITH Bootloader-exception` ~45자
- Triple: `(MIT AND Apache-2.0) OR (BSD-3-Clause AND ISC)` ~50자
- Practical SPDX upper: ~70자 → **80자 = safe margin** (false positive 0)
- 80자 초과: 사실상 EULA 본문 → fallback `see LICENSE.`

정규화 (e.g., `Apache 2.0` → `Apache-2.0`)는 본 세션 out of scope (위 표 참조).

## 2. 결정 (R1 ~ R4 + Smoke)

### R1 — `detect-project.sh`: `license_file` 출력 (relative path)

T2.5 보강 후 `license_path` 변수가 actual LICENSE file path를 가짐 (T1/T2/T2-Multi/T2.5 매칭 시) 또는 empty (T3 only).

**relative path 채택 근거**:

- `LICENSE` (표준) — 대부분
- `LICENSE.md`, `LICENSE.txt`, `COPYING` — 가능
- `LICENSES/CUSTOM-LICENSE` (Cargo subdirectory license-file) — fringe but supported

basename 대신 relative path → Cargo subdirectory edge case 자연 처리 + 실제 파일명으로 link.

**Implementation** (line 425 직후):

```bash
# license_file: actual LICENSE file relative path (T1/T2/T2-Multi/T2.5 매칭 시 set)
license_file=""
if [ -n "$license_path" ]; then
    license_file="${license_path#$ROOT/}"
fi
```

**Output** (line 454 직후):

```bash
[ -n "$license_file" ] && echo "license_file = \"$license_file\""
```

### R2 — `interview.md` Bootstrap 치환 로직: **3-way 분기** + MAX_LENGTH

```python
HM_LICENSE      = grep 'license = "..."' detect-output
HM_LICENSE_FILE = grep 'license_file = "..."' detect-output

# sub-item 2 — MAX_LENGTH=80
if len(HM_LICENSE) > 80:
    HM_LICENSE = ""    # → fallback 분기

# 3-way construction (Case 3 enhancement는 out of scope)
if HM_LICENSE and HM_LICENSE_FILE:        # Case 1: T1/T2/T2.5 — license + file
    {{license}} = f"{HM_LICENSE} (see [{HM_LICENSE_FILE}]({HM_LICENSE_FILE}))"
elif HM_LICENSE:                          # Case 2: T3 only — license, no file (sub-item 1 해소)
    {{license}} = HM_LICENSE
else:                                     # Case 3: 완전 fallback (legacy v1.10b 텍스트 유지)
    {{license}} = "see LICENSE."
```

**3 케이스 렌더링 (template `License: {{license}} See [README.md]...` 변경 없음)**:

| Case | 조건 | `{{license}}` 치환 결과 |
|------|------|----------------------|
| 1 | T1/T2 match (license + file) | `MIT (see [LICENSE](LICENSE))` |
| 2 | T3 only (license, no file) | `MIT` |
| 3 | nothing matched | `see LICENSE.` |

⚠️ Note: AGENTS.md.tmpl L5 `See [README.md](README.md)...` 는 **out of scope** (v1.10h2). 본 세션 후 L5 렌더 결과는 여전히 다음과 같이 출력됨:

- Case 1 → `License: MIT (see [LICENSE](LICENSE)) See [README.md](README.md) for project overview (human-readable).`
- 시각 awkwardness는 **v1.10h2에서 정리**

### R3 — `interview.md` `## License 처리` section update

추가 항목:

- `license_file` 출력 spec (relative path semantics)
- 3-way 분기 (Case 1~3 표)
- MAX_LENGTH=80 정책 (정당화 + safe margin 근거)

### R4 — `INTERVIEW_FLOW.md` 업데이트

- §2.1 S3 preview 표 `{{license}}` 행 — 3-way 결과 + license_file 언급
- §3.3 tmpl 변수 표 `{{license}}` description — 3-way + HM_LICENSE_FILE 각주
- §3.3 env 매핑 — `HM_LICENSE_FILE` 추가 (tmpl marker 아님 — env only 명시)

### Smoke (sub-item 3) — 4 stage 9 checks

```bash
Stage 1 — detect-project.sh source 검증 (2 checks)
  ✓ license_file 변수 정의 라인 (`license_file=""`)
  ✓ license_file 출력 echo 라인

Stage 2 — interview.md 3-way + MAX_LENGTH (3 checks)
  ✓ HM_LICENSE_FILE 변수 사용
  ✓ MAX_LENGTH=80 명시
  ✓ 3-way 분기 (Case 1~3) 명시

Stage 3 — INTERVIEW_FLOW.md (2 checks)
  ✓ {{license}} description에 license_file 언급
  ✓ HM_LICENSE_FILE env 각주

Stage 4 — end-to-end fixture (2 checks, mktemp)
  Fixture A: MIT LICENSE 파일 → license_file = "LICENSE"
  Fixture B: pyproject license + LICENSE 부재 → license = "MIT" + license_file 부재
```

(Stage 5 — AGENTS.md.tmpl L5 검증은 out of scope. v1.10h2 smoke로 분리)

## 3. 변경 대상 (3 수정 + 3 신규)

### 수정 (3 파일)

| 경로 | scope | 변경 내용 |
|------|------|---------|
| `bootstrap/detect-project.sh` | S2 | R1 — `license_file` computation + output (+9 lines) |
| `bootstrap/interview.md` | S2 | R2 + R3 — 3-way 분기 + MAX_LENGTH + License 처리 section |
| `bootstrap/docs/INTERVIEW_FLOW.md` | S2 | R4 — `{{license}}` 3-way + HM_LICENSE_FILE 각주 |

### 신규 (3 파일)

| 경로 | scope | 역할 |
|------|------|------|
| `tests/smoke-license-line-policy.sh` | S2 | 4 stage 9 checks (LF eol, set -e) |
| `sessions/meta/v1.10h-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.10h-.../REPORT.md` | meta | Stage F |

## 4. 목표 (Stage A ~ F)

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 (Scope contract 섹션 포함)
- [x] 사용자 Grey Area G1=(a) MAX_LENGTH=80 확정
- [ ] **Stage A — `detect-project.sh` R1** (license_file output)
- [ ] **Stage B — `interview.md` R2 + R3** (3-way + License 처리 section)
- [ ] **Stage C — `INTERVIEW_FLOW.md` R4** (§2.1 + §3.3)
- [ ] **Stage D — Smoke 4 stage 9/9 PASS**
- [ ] **Stage E — REPORT.md 작성**
- [ ] **사용자 확인 후 단일 커밋 (push 아님)**

## 5. 성공 기준

- [ ] `detect-project.sh`: `license_file = "LICENSE"` 출력 (Fixture A) + 부재 (Fixture B)
- [ ] `interview.md`: 3-way 분기 (Case 1~3) + MAX_LENGTH=80 명시
- [ ] `INTERVIEW_FLOW.md`: `{{license}}` description + `HM_LICENSE_FILE` env 각주
- [ ] `tests/smoke-license-line-policy.sh` 9/9 PASS (LF eol)
- [ ] `evidence/smoke-license-line-policy.txt` 저장
- [ ] REPORT.md: 2 sub-item 해소 매핑 + Out of scope 5건 재확인 + Lessons Learned

## 6. 회귀 검증

기존 smoke 영향 zero 예상 (frontmatter / Bash permission 변경 없음):

- [ ] `tests/smoke-bash-permission-pattern.sh` 6/6 PASS (v1.10d 회귀)
- [ ] `tests/smoke-broad-bash-fine-grain.sh` 6/6 PASS (v1.10f 회귀)
- [ ] `tests/smoke-thinking-effort.sh` 5/5 PASS (v1.10g 회귀)

## 7. 커밋 전략

단일 커밋. 3 수정 + smoke + PLAN/REPORT 논리적 단위.

```
feat(meta): sessions/meta/v1.10h-agents-md-license-line-policy — L5 link 조건부 + MAX_LENGTH=80

- update: bootstrap/detect-project.sh (R1 — license_file relative path output)
- update: bootstrap/interview.md (R2+R3 — 3-way 분기 + MAX_LENGTH=80)
- update: bootstrap/docs/INTERVIEW_FLOW.md (R4 — {{license}} 3-way + HM_LICENSE_FILE)
- add: tests/smoke-license-line-policy.sh (4 stage 9 checks)
- add: sessions/meta/v1.10h-.../{PLAN,REPORT}.md + evidence

v1.10g 후속 sub-item 2건 해소:
(1) LICENSE 부재 시 (see [LICENSE](LICENSE)) 깨진 링크 → Case 2 link 생략
(2) non-SPDX MAX_LENGTH=80 → 초과 시 fallback (Anthropic EULA abuse 차단)

Out of scope (5건 별도 분리):
- L5 "See [README.md]..." 정리 → v1.10h2
- Case 3 enhancement / Issue B / 정규화 map → v1.10i+
- Scope contract mechanism → v1.10j

Smoke 9/9 PASS. 회귀 v1.10d 6/6 + v1.10f 6/6 + v1.10g 5/5.
```

## 8. 후속 세션 후보 (보류)

| 세션 | scope | 동기 |
|------|------|------|
| **`v1.10h2-l5-readme-link-cleanup`** | S2 | R3 (`See [README.md]...` 제거) — 본 세션 out of scope 분리 |
| **`v1.10j-scope-contract-discipline`** | S2 | OWNERSHIP.md 갱신 + Scope inheritance/Out of scope 의무화 + verify rule |
| `v1.10i` | S2 | non-SPDX 정규화 + Issue B discrepancy WARN + Case 3 enhancement (evidence-driven) |
| `sessions/upbit/v1.2-bash-permission-update` | S6 | v1.10d + v1.10g T4 후행 |
| `v1.11` — language overlay | S2 | bootstrap omit 9건 |

## 9. Lessons Forward (예상)

- **L1 — Scope contract 의무 섹션이 본 PLAN의 1차 demo** — `Scope inheritance` (verbatim) + `Out of scope` (explicit rejection) 두 섹션이 over-scope 차단 mechanism. 효과는 v1.10j에서 평가
- **L2 — relative path > basename** — Cargo `license-file` subdirectory edge case 자연 처리. 추상화 비용 0
- **L3 — MAX_LENGTH=80 = SPDX 50% margin** — false positive 0 + Anthropic EULA abuse 차단
- **L4 — round-trip 미보장 정책 유지** — bootstrap 1-shot. forward-only 변경 → 기존 프로젝트 무영향
