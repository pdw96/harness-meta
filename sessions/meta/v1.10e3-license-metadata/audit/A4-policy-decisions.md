# A4 — Policy decisions (R1-R10) + Grey 5건 + Scope 매트릭스

본 audit는 v1.10e3 채택 정당성과 Grey area 결정 + scope 명시. PLAN 5 Grey + R1-R10 통합.

## §1. R1 — v1.10e3 채택 (T3 메타데이터 4-tier)

**결정**: T3 메타데이터 4-tier 추가 (T1 SPDX → T2-Multi/boilerplate → **T3 메타** → T4 silent).

**근거** (audit/A1 spec + A2 evidence):

- A2 sample 30: LICENSE 부재 + 메타 only 시나리오 4건 (#21-24). v1.10e2 모두 silent (recovery 0/4). v1.10e3 → 3 OSS 매칭 + 1 정확 silent
- A1 spec 정합: 4 source (npm + PEP 621/639 + Poetry + Cargo) 모두 SPDX expression 표준 채택. observation 본질 유지
- v1.10c 거부 (injection) vs v1.10e3 (observation) 정합 — 사용자 메타 read만, default stamp 강제 없음 (audit/A5 별도)

**대안 거부**:

- (a) **현상 유지 (T1+T2 only)**: LICENSE 부재 + 메타 only 시나리오 (4 sample) 회복 불가. 거부
- (b) **메타데이터 우선 (LICENSE 무시)**: G1 §LICENSE 콘텐츠 strong signal 위배. #27 Oracle `"Apache 2.0"` (공백 비표준) → SPDX 비정확. 거부
- (c) **메타 + LICENSE 둘 다 표시 (merge)**: AGENTS.md L5 라인 복잡. SPDX expression 표준 위배. 거부

→ R1 채택.

## §2. R2 — 4 source 우선순위 (M2 → M2-legacy → M3 → M1 → M4)

**결정**: pyproject (PEP 639 modern → PEP 621 legacy → Poetry) → npm → Cargo.

**근거** (A3 §2):

- PEP 639 Final 2024-05 — Python packaging 공식 표준
- Poetry 자체 deprecated `[tool.poetry].license` → PEP 621 권장
- 단일 프로젝트 multi-language 메타 동시 보유는 비현실 (monorepo 외)

**Grey** — Multi-language conflict edge: 만약 pyproject MIT + package.json Apache 동시 존재 → pyproject 우선. 사용자 책임.

## §3. R3 — LICENSE 콘텐츠 우선 (G1)

**결정**: LICENSE 파일 T1/T2 매칭 시 T3 skip. LICENSE 부재 시만 T3 진입.

**근거** (audit/A5 — 별도 정밀):

- 사용자 의도: LICENSE 콘텐츠 직접 작성 = 가장 strong declaration
- GitHub Linguist 동일 전략: LICENSE 파일 우선 read
- 의미 정확도: A2 #27 Oracle `"Apache 2.0"` (공백) vs LICENSE.txt `Apache License Version 2.0` boilerplate → T2 우선이 SPDX 정확

**대안 거부**:

- (a) 메타 우선: 위 #27 거부
- (b) merge: AGENTS.md L5 라인 복잡

## §4. R4 — UNLICENSED → LicenseRef-UNLICENSED (G3)

**결정**: npm `"license": "UNLICENSED"` → SPDX 표준 `LicenseRef-UNLICENSED` 정규화.

**근거** (A3 §4):

- npm 자체 컨벤션 (SPDX 비표준)
- SPDX 표준 `LicenseRef-<id>` 형식 사용자 정의 license 표기
- downstream 도구 (Linguist 등) 호환

**대안 거부**:

- (a) `UNLICENSED` 그대로: 비표준
- (c) `proprietary`: semantic 비표준

## §5. R5 — SEE LICENSE IN 1회 재귀 (G4)

**결정**: `"license": "SEE LICENSE IN <file>"` → file 1회 read (T1/T2 재시도). 추가 재귀 없음.

**근거** (A3 §5):

- 무제한 재귀 risk: A → B → A 무한 루프, depth bomb
- npm 컨벤션은 단일 파일 가정
- depth counter 불필요 — 코드 단순

**Path traversal**: `_sanitize_path` — `..` / 절대경로 / null byte / 1KB 초과 거부.

## §6. R6 — non-SPDX 메타 보존 (G6 신규)

**결정**: 메타 값이 SPDX 표준 위배 (`"Apache 2.0"` 공백, `"© Anthropic..."` long EULA-style)이어도 **그대로 보존**. detect 단계에서 검증/거부 안 함.

**근거** (A2 #21 #27 + A1 §7):

- v1.10e3 = observation (사용자 명시 값 read). 검증은 v1.10h scope
- 권위 도구 동일 전략 (Linguist + npm registry — read만)
- bash로 SPDX 600+ ID 검증 비현실

**완화책**:

- AGENTS.md L5 출력 시 long string 라인 가독성 저하 → v1.10h에서 처리
- render-manifest.sh 5종 (`"`, `'`, `\n`, `$`, `\`) 메타 char 검증으로 명령 주입 차단

## §7. R7 — observation 본질 (T3 = LICENSE 콘텐츠 read와 동일)

**결정**: T3 메타 read = T1 SPDX 헤더 read = T2 boilerplate read와 동일 본질. 모두 사용자 명시 값.

**근거** (A5 별도 정밀):

- v1.10c 거부 3 이유 (spec 위반 / 의도 위배 / 권위 도구 불일치) 모두 무력화
- 메타데이터 spec (PEP 621/639 + npm + Cargo) 모두 정식 표준 — 사용자 명시 declaration
- T1/T2와 동등 신뢰성

## §8. R8 — license-file 보강 (T2.5)

**결정**: Cargo `license-file = "LICENSE.txt"` 사용자 정의 경로 → T1/T2 진입 전 `license_path` 보강. T3 본체 아닌 보강 단계.

**근거** (A1 §5.4 + A3 §1):

- 표준 4 파일 (LICENSE/LICENSE.md/LICENSE.txt/COPYING) 외 사용자 정의 경로 (`LICENSE.custom`, `LEGAL.txt`) 처리
- T2 (boilerplate)가 이미 콘텐츠 처리하므로 신규 분기 아님 — license_path만 보강

**대안 거부**:

- T3 본체로 분류: T3는 메타데이터 string 추출 source. license-file은 file-pointer (T1/T2와 동일 단계). 분류 부정확

## §9. R9 — POSIX awk 호환 (BSD/macOS/GNU/MINGW)

**결정**: helper 함수는 POSIX awk만 사용. GNU awk extension (`match($0, /regex/, arr)` 3-arg form 등) 회피.

**근거** (A3 §6):

- macOS 기본 awk = BSD awk (GNU 미지원)
- Windows MINGW awk 호환성 보장 위해
- v1.10e2 helper 동일 정책

**구현**: section flag + sed 후처리 (A3 §3.5 §3.7).

## §10. R10 — bootstrap_version stamp 1.10e2 → 1.10e3

**결정**: AGENTS.md.tmpl `{{bootstrap_version}}` 값을 `1.10e3`으로 갱신. interview.md 헤더 + INTERVIEW_FLOW.md §2 literal + skeletons/projects/INTERVIEW.md.tmpl 정합 갱신.

**근거**: v1.10b/c/e/e2 동일 패턴. 자동 적용 카운트 7 유지 (T3는 콘텐츠 변수 신규 추가 0 — 기존 `{{license}}` 변수에 흡수).

## §11. Grey 5건 결정 표

| ID | 질문 | 후보 | **결정** | R# |
|----|------|------|---------|----|
| **G1** | LICENSE vs 메타 우선순위 | (a) 메타 / **(b) LICENSE** / (c) merge | **LICENSE 우선** | R3 |
| **G2** | pyproject 3 source 우선순위 | **(a) modern→PEP 639→poetry** / (b) 역순 | **modern → 621-legacy → poetry** | R2 |
| **G3** | UNLICENSED 출력 형식 | (a) `UNLICENSED` / **(b) LicenseRef-UNLICENSED** / (c) proprietary | **`LicenseRef-UNLICENSED`** | R4 |
| **G4** | SEE LICENSE IN 재귀 깊이 | **(a) 1회** / (b) 무제한 | **1회** | R5 |
| **G5** | nested package.json `{type, url}` legacy | (a) 무시 / **(b) 부분 (`type`)** / (c) 완전 | **부분 — `type` 필드만 추출** | A1 §2.3 |
| **G6** (신규) | non-SPDX 메타 검증 | (a) 거부 / **(b) 그대로 보존** / (c) heuristic 의심 | **그대로 보존** (observation only) | R6 |
| **G7** (신규) | T2.5 license-file 분류 | **(a) 보강 단계** / (b) T3 본체 | **보강 단계** (T1/T2 재시도) | R8 |

## §12. Scope 매트릭스 (포함 12 + 제외 6)

### §12.1. ✅ 포함 12

| # | 항목 | scope | 근거 audit |
|---|------|------|----------|
| 1 | T3 메타데이터 4-tier | S2 detect-project.sh | R1 + A2 |
| 2 | M1 npm `package.json.license` | S2 | A1 §2 |
| 3 | M2 PEP 639 string | S2 | A1 §3 |
| 4 | M2-legacy PEP 621 inline `{text}` `{file}` | S2 | A1 §3.4 |
| 5 | M3 Poetry `[tool.poetry].license` | S2 | A1 §4 |
| 6 | M4 Cargo `[package].license` | S2 | A1 §5 |
| 7 | UNLICENSED → LicenseRef-UNLICENSED 정규화 | S2 | R4 |
| 8 | SEE LICENSE IN 1회 재귀 | S2 | R5 |
| 9 | T2.5 Cargo license-file 보강 | S2 | R8 |
| 10 | _sanitize_path 보안 함수 | S2 | A3 §3.8 |
| 11 | INTERVIEW_FLOW.md Stage S3 4-tier | S2 | A1 §10 |
| 12 | bootstrap_version `1.10e3` stamp | S2 | R10 |

### §12.2. ❌ 제외 6 → 후속

| # | 항목 | 이유 | 후속 |
|---|------|------|------|
| 1 | AGENTS.md L5 license 라인 정책 (truncate / 형식) | 라인 가독성 + non-SPDX 처리 별개 책임 | **v1.10h** |
| 2 | 복잡 SPDX expression 검증 (`(MIT OR Apache-2.0) AND CC-BY-4.0`) | bash 검증 비현실, 메타가 명시한 expression은 보존 | (별도 후속, evidence 부족 시 재평가) |
| 3 | modified license 감지 (`"MIT License (modified)"`) | regex 매칭 어려움, false positive risk | 사용자 SPDX 헤더 권장 (T1) |
| 4 | monorepo recursive (pnpm-workspace.packages.*) | scope 폭증, performance 우려 | (별도 후속) |
| 5 | npm `"licenses"` array (legacy v6 이전) | 마이그레이션 안내 충분 | (사용자 마이그레이션) |
| 6 | dynamic license (PEP 621 `dynamic = ["license"]`) | 빌드 후 메타 read 필요 | (사용자가 LICENSE 파일 명시) |

## §13. 검증 명령 (v1.10e3 적용 후)

```bash
# 1) detect-project.sh T3 출력 확인 (LICENSE 부재 + package.json MIT)
mkdir -p /tmp/v110e3-test && cd /tmp/v110e3-test
echo '{"license": "MIT"}' > package.json
bash ~/harness-meta/bootstrap/detect-project.sh "$PWD" | grep license

# 기대 출력:
# license = "MIT"

# 2) UNLICENSED 정규화 확인
echo '{"license": "UNLICENSED"}' > package.json
bash ~/harness-meta/bootstrap/detect-project.sh "$PWD" | grep license

# 기대 출력:
# license = "LicenseRef-UNLICENSED"

# 3) SEE LICENSE IN 1회 재귀 확인
echo '{"license": "SEE LICENSE IN custom.txt"}' > package.json
echo 'SPDX-License-Identifier: BSD-3-Clause' > custom.txt
bash ~/harness-meta/bootstrap/detect-project.sh "$PWD" | grep license

# 기대 출력:
# license = "BSD-3-Clause"

# 4) Path traversal 방어
echo '{"license": "SEE LICENSE IN ../../etc/passwd"}' > package.json
bash ~/harness-meta/bootstrap/detect-project.sh "$PWD" | grep license

# 기대 출력: (license 라인 없음 — silent)

# 5) LICENSE 콘텐츠 우선 (T2 우선 over T3)
echo "MIT License" > LICENSE
echo "" >> LICENSE
echo "Permission is hereby granted, free of charge," >> LICENSE
echo '{"license": "Apache-2.0"}' > package.json
bash ~/harness-meta/bootstrap/detect-project.sh "$PWD" | grep license

# 기대 출력:
# license = "MIT"   ← LICENSE 우선 (T2), 메타 무시
```

## §14. 채택 정당화 통합

- **R1 (T3 채택)**: A2 evidence — LICENSE 부재 + 메타 only 시나리오 100% 회복 (3 OSS sample)
- **R2 (4 source 우선순위)**: PEP 639 Final 권위 + Poetry 자체 deprecated 알림
- **R3 (LICENSE 우선)**: GitHub Linguist 동일 전략 + 의미 정확도
- **R4 (UNLICENSED → LicenseRef-UNLICENSED)**: SPDX 표준 정합
- **R5 (1회 재귀)**: depth bomb 차단 + npm 컨벤션 단일 파일 가정
- **R6 (non-SPDX 보존)**: observation 본질
- **R7 (observation 정합성)**: v1.10c 거부 3 이유 무력화 (A5에서 정밀)
- **R8 (license-file 보강)**: T1/T2 단계 재시도 (분류 정확)
- **R9 (POSIX awk)**: cross-platform 호환 (macOS BSD awk)
- **R10 (stamp 1.10e3)**: 일관 패턴

→ **v1.10e3 채택 정당**. v1.10c/e/e2 정합성 + 4 신규 시나리오 회복 evidence.
