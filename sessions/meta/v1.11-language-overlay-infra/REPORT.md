# meta v1.11-language-overlay-infra — REPORT

세션 종료: 2026-04-28
직접 선행: [`v1.10j-scope-contract-discipline`](../v1.10j-scope-contract-discipline/) (본 세션이 첫 정식 적용) · [`v1.8-core-adapter-split`](../v1.8-core-adapter-split/) (`_base/` 신설)

## 0. 최종 결과

- **수정 6**: `bootstrap/install-project-claude.sh` + `bootstrap/install-project-claude.ps1` + `bootstrap/manifest-schema.md` + `CLAUDE.md` + `README.md` + `tests/smoke-scope-contract.sh`
- **신규 5**: `bootstrap/templates/python/.claude/.gitkeep` + `bootstrap/docs/OVERLAY.md` + `tests/smoke-language-overlay.sh` + `sessions/meta/v1.11-.../{PLAN,REPORT}.md`
- **Smoke**: `smoke-language-overlay.sh` 8/8 PASS + `smoke-scope-contract.sh` 14/14 PASS
- **회귀**: 모든 smoke 13/13 PASS (기존 12 + 신규 1)
- **Dynamic stress test**: A1~A8 8 시나리오 모두 정합

## 1. 구현 요약

### Stage A — placeholder

- `bootstrap/templates/python/.claude/.gitkeep` 신규 (빈 파일, git tracking 용)
- 디렉토리 규약 첫 인스턴스. v1.11b+ 실 콘텐츠 진입점

### Stage B — `bootstrap/docs/OVERLAY.md` 신설 (14 §)

§1 개요 / §2 디렉토리 규약 / §3 Language 매트릭스 10건 / §4 정규화 / §5 Reserved prefix / §6 Naming convention `harness-*` / §7 Merge 알고리즘 / §8 충돌 시나리오 C1/C2/C3 / §9 `.gitkeep` skip / §10 Recursion / §11 Legacy cleanup 한계 / §12 빈 overlay 동작 / §13 v1.11 vs 향후 / §14 관련 문서

단일 소스. install-project-claude의 의사코드 + 충돌 정책 + naming convention의 reference.

### Stage C — `install-project-claude.sh` Phase 2 신설

- 헤더 코멘트 1줄 추가: `v1.11+: [project].language 기반 <language>/.claude/ overlay merge`
- Phase 2 logic: language grep+sed 추출 → `tr 'A-Z' 'a-z'` lowercase → reserved `_*` 검사 → overlay dir 존재 검사 → 4 카테고리 iter → top-level `.gitkeep` skip → `cp -r` recursion + `overlay overwrite` log
- bash syntax check PASS

### Stage D — `install-project-claude.ps1` 동상

- Header `.DESCRIPTION` v1.11+ 1줄 추가
- PowerShell idiom: `Select-String` regex로 language 추출 → `.ToLower()` → `Where-Object { $_.Name -ne '.gitkeep' }` 명시 → `Copy-Item -Recurse -Force`
- PS parser syntax check PASS

### Stage E — Cross-reference 3 파일

- `manifest-schema.md` §6.2 `language` 행 1줄 갱신: "v1.11+ install-project-claude가 lowercase 매치하여 overlay dir name으로도 사용. 상세: docs/OVERLAY.md"
- `README.md` 디렉토리 구조 `<language>/` 1줄: "v1.11+ 인프라 active — 실 콘텐츠 v1.11b+ — see bootstrap/docs/OVERLAY.md"
- `CLAUDE.md` "관련 문서" § 1줄: "Language overlay 규약 (v1.11+ 인프라): @bootstrap/docs/OVERLAY.md"

### Stage F — Smoke 2건

**`tests/smoke-language-overlay.sh` 신규** (정적 4 + dynamic 4 = 8 checks):

- S1.1 placeholder 존재 / S1.2 sh 키워드 / S1.3 ps1 키워드 / S1.4 OVERLAY.md 14 § keyword
- S2.1 install exit 0 / S2.2 카테고리 디렉토리 / S2.3 SKILL.md sub-dir 복사 / S2.4 .gitkeep skip 정합

**`tests/smoke-scope-contract.sh` 갱신** (D11 — 자동 enumerate):

- hard-coded 3건 → glob `v1.10h* / v1.10j* / v1.11*` 자동 enumerate
- v1.10h3 + v1.11 자동 흡수 (smoke 갱신 없이 향후 세션 자동 검사)

### Stage G — 본 REPORT.md

## 2. 검증 결과 매트릭스

### 2.1. Static + Dynamic Smoke

| Smoke | 결과 |
|-------|------|
| smoke-language-overlay.sh (정적 4 + dynamic 4) | **8/8 PASS** |
| smoke-scope-contract.sh (자동 enumerate, v1.10h × 3 + v1.10j + v1.11 = 5 PLAN × 2 + Stage 2/3 4) | **14/14 PASS** |

### 2.2. Stress test 8 시나리오 (A1~A8)

| # | 시나리오 | 기대 | 결과 |
|---|---------|------|------|
| A1 | `language='JAVA'` (대문자) | lowercase → templates/java/ skip | ✓ |
| A2 | `language` 필드 부재 | Phase 2 skip — `[project].language` 부재 | ✓ |
| A3 | `language='_base'` (reserved) | reserved prefix `_*` skip | ✓ |
| A4 | `language='haskell'` (matrix 외) | overlay dir 부재 skip | ✓ |
| A5 | `language='python'` (현 placeholder) | 진입 → sub-cat 부재 → no-op | ✓ |
| A6 | PowerShell .ps1 dynamic (Windows) | Phase 1 11항목 + Phase 2 no-op | ✓ |
| A7 | overlay sub-dir + nested 파일 (mock) | `cp -r` recursion 정합 | ✓ |
| A8 | overlay overwrite `_base` 동명 파일 | overlay 승 + log + 콘텐츠 정합 | ✓ |

### 2.3. 기존 smoke 회귀 13/13 PASS

```
✓ smoke-bash-permission-pattern.sh
✓ smoke-bootstrap-agents-md.sh
✓ smoke-bootstrap-license-boilerplate.sh
✓ smoke-bootstrap-license-detect.sh
✓ smoke-bootstrap-license-metadata.sh
✓ smoke-bootstrap-render.sh
✓ smoke-broad-bash-fine-grain.sh
✓ smoke-l5-readme-link-cleanup.sh
✓ smoke-language-overlay.sh        ← 신규
✓ smoke-license-line-policy.sh
✓ smoke-scope-contract.sh           ← 갱신 (자동 enumerate)
✓ smoke-thinking-effort.sh
✓ smoke-v1.1.sh
```

### 2.4. 정합성 매트릭스

| 검증 | 결과 |
|------|------|
| PLAN 변경 매트릭스 (6 수정 + 5 신규) ↔ git status | ✓ M=6, ??=5 정확 일치 |
| Language matrix (OVERLAY.md 10) ↔ detect-project.sh (10) | ✓ 1:1 정합 |
| `.gitattributes` LF 적용 (신규 .sh) | ✓ `eol: lf` |
| Bash syntax check | ✓ PASS |
| PowerShell parser check | ✓ PASS |
| upbit 영향 (재install 시 dest 변동) | ✓ 0 (Phase 2 no-op) |

## 3. 판정 (PLAN 성공 기준)

- [x] `bootstrap/templates/python/.claude/.gitkeep` 존재
- [x] `bootstrap/docs/OVERLAY.md` 존재 + 14 § 모두 작성
- [x] install-project-claude.sh: 헤더 + Phase 2 + lowercase + .gitkeep skip + C2 + cp -r
- [x] install-project-claude.ps1: 동상 + Where-Object skip + Copy-Item -Recurse
- [x] manifest-schema.md: cross-ref 1줄
- [x] README.md: 디렉토리 구조 1줄
- [x] CLAUDE.md: 관련 문서 1줄
- [x] smoke-language-overlay.sh 8/8 PASS
- [x] smoke-scope-contract.sh D11 갱신 PASS
- [x] 회귀 0 (sample-project fixture 검증)
- [x] upbit 영향 0 (Phase 2 no-op)

**전 항목 PASS**.

## 4. 분석 결과 누적 (D1~D17)

본 세션은 PLAN을 **3차 재작성** — 분석 단계마다 신규 결함/grey area 발견.

### 1차 분석 (D1~D10) — 사용자 "디테일하게 분석"

| # | 발견 | PLAN 영향 |
|---|------|----------|
| D1 | Fixture 부재 가정 오류 + Language matrix 누락 2건 | Smoke dynamic 강화 + ruby/elixir 추가 |
| D2 | 충돌 정책 grey area (C1/C2/C3 미정) | Phase 1/2 + 정책 명시 |
| D3 | `.gitkeep` skip cross-platform 정합 (PS1 누락) | Where-Object 명시 |
| D4 | Language 식별자 정규화 미정 | lowercase 채택 |
| D5 | 문서 위치 약함 (manifest-schema 1줄) | OVERLAY.md 신설 |
| D6 | `categories` v1.8b 잔존 검토 | 유지 |
| D7 | AGENTS.md 표준 영향 (`.agents/`) | scope 외 명시 |
| D8 | Smoke 정적 4 → 정적 4 + dynamic 4 | 강화 |
| D9 | v1.10j Scope contract 자기 검증 | Source 4 verbatim 보강 |
| D10 | 5 grey area (빈 overlay / alias / legacy / manifest / README) | Out of scope 명시 + OVERLAY.md 흡수 |

### 2차 분석 (D11~D17) — 사용자 "추가 분석"

| # | 발견 | PLAN 영향 |
|---|------|----------|
| **D11** | smoke-scope-contract.sh v1.11 자기 검증 누락 (강력) | 자동 enumerate 도입 |
| D12 | Sub-directory recursion 미정 | `cp -r` / `Copy-Item -Recurse` 명시 |
| D13 | C2 사용자 custom overwrite 위험 | `harness-*` prefix naming convention |
| D14 | install scripts 헤더 stale | 1줄 추가 |
| D15 | `.gitattributes` LF 강제 | 기존 설정 정합 ✓ |
| D16 | Legacy cleanup overlay 미인식 | OVERLAY.md §11 한계 명시 (Out of scope) |
| D17 | upbit 재install 회귀 0 | 성공 기준 1줄 |
| F2 | CLAUDE.md cross-ref | 1줄 추가 |

### 3차 검증 (Stress test A1~A8) — 사용자 "추가 검증"

전 시나리오 PASS. 추가 발견 0 → PLAN 안정.

## 5. Lessons Learned

- **L1 — 다단계 면밀 분석이 PLAN 결함 17건 사전 발견** — 단일 분석 대비 17건 추가 결함 발견. "디테일하게 분석" + "추가 분석" + "추가 검증" 3단계 시퀀스가 정형화 가치
- **L2 — overlay merge는 Phase 분리 + C1/C2/C3 + naming convention으로 안전 단순화** — `harness-*` prefix가 사용자 custom 보호의 결정적 mechanism (D13). C2 silent overwrite의 위험을 0으로 제거
- **L3 — detect-project.sh ↔ install-project-claude language 매트릭스 1:1 정합** — 양방향 책임 분리 (detect는 추측 / install은 정규화). 향후 언어 추가 시 양쪽 동시 갱신 의무
- **L4 — Scope contract 첫 정식 적용 시 self-test 의무 (D11)** — "scope contract mechanism이 자기 자신을 검증해야 mechanism 강화" 원칙. 향후 신규 mechanism 도입 세션은 자기 검증 smoke 의무 검토
- **L5 — Fixture 적극 활용** — 첫 PLAN의 "fixture 부재" 가정은 잘못. `tests/fixtures/sample-project/`를 `cp` + `mktemp`로 isolate하여 dynamic install 검증 가능. 향후 install/bootstrap 류 smoke 패턴
- **L6 — 한글 console mojibake는 v1.21 cross-platform-install 범위** — PowerShell + Korean Windows cp949 출력 깨짐 (verify.ps1 PYTHONIOENCODING 패턴). 본 v1.11 동작 영향 0이지만 별 도메인

## 6. 다음 후보 (보류)

| 후속 세션 | 조건 |
|----------|------|
| `v1.11b-overlay-python-skill` | Python 사용자 1+ 발생. `python/.claude/skills/harness-python/SKILL.md` (`harness-*` prefix) |
| `v1.11c-overlay-typescript` 등 | TS / Go / Rust 사용자 발생 (각자 별 세션) |
| `v1.11d-codedir-skeleton` | `<proj>/{HM_CODE_DIR}/` 골격 자동 생성 |
| `v1.10i-license-case3-enhancement` | LICENSE Case 3 evidence 3+ 누적 |
| `v1.21-cross-platform-install` | verify.ps1 overlay 무결성 + legacy cleanup overlay-aware + PowerShell encoding |
| `v1.14~v1.20-adapter-*` | `.agents/` adapter overlay (Cursor/Codex/Gemini) |

## 7. 후속 세션 (Cross-link)

본 세션 → 후속:

- `v1.11b+`: 본 OVERLAY.md §6 naming convention + §7 merge 알고리즘 활용
- `v1.21`: 본 §11 legacy cleanup 한계 해소 + verify.ps1 overlay 체크 도입

선행 세션:

- `v1.10j-scope-contract-discipline`: 본 세션이 첫 정식 적용 + D11 자기 검증 mechanism 강화
- `v1.8-core-adapter-split`: `_base/.claude/` 신설 (overlay 전제)

## 8. Stage 진행 로그

| Stage | 산출 | 결과 |
|-------|------|------|
| A | python/.claude/.gitkeep 신규 | ✓ |
| B | OVERLAY.md 14 § 신설 | ✓ |
| C | install-project-claude.sh Phase 2 | ✓ syntax PASS |
| D | install-project-claude.ps1 동상 | ✓ parser PASS |
| E | manifest-schema + README + CLAUDE 3 cross-ref | ✓ |
| F | smoke-language-overlay (8/8) + smoke-scope-contract 갱신 (14/14) | ✓ |
| G | 본 REPORT.md | ✓ |

**커밋 대기**.
