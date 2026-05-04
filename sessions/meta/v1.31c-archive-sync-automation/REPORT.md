# meta v1.31c-archive-sync-automation — REPORT

세션 종료: 2026-04-30
선행 세션:

- [`sessions/meta/v1.31-evidence-driven-roadmap/`](../v1.31-evidence-driven-roadmap/) — §6 갱신 정책 정의
- [`sessions/meta/v1.31b-roadmap-archive-arrears/`](../v1.31b-roadmap-archive-arrears/) — 다음 후보 § 본 세션 명시
- [`sessions/meta/v1.29-verify-fix-mode/`](../v1.29-verify-fix-mode/) — `--fix` mode 패턴
- [`sessions/meta/v1.33-fix-scope-contract/`](../v1.33-fix-scope-contract/) — smoke + enumerate 패턴

## 최종 결과

| 항목 | 결과 |
|------|------|
| 수정 파일 | `EVIDENCE_DRIVEN_ROADMAP.md` 5 § 갱신 |
| 신규 파일 | `tests/smoke-archive-sync.sh` (Stage 1~4 + --fix Stage 1) + 본 세션 PLAN/REPORT |
| §3 신규 후속 등재 | 8건 (B-2 회귀 3 + D 설계 2 + E 정규화 2 + 분류 명시 1) |
| §3 헤더 카운트 | 18건 → **26건** 동기화 |
| §5 stale 정정 | v1.35 strikethrough + 헤더 카운트 (5 → 1) |
| §6-0 자동 검증 정책 | 신설 — smoke 호출 의무 + LEGACY skip 명시 |
| smoke self-test | 13 PASS / 0 FAIL / 54 SKIP / 0 WARN |
| --fix mode self-test | v1.31c entry 자동 삽입 + 재호출 PASS |

## 구현 요약

### Stage A — EVIDENCE_DRIVEN_ROADMAP.md 5 § 갱신

**A1 §5 stale 정정**:

- v1.35 strikethrough 추가 (rank 4 archive 이관 명시)
- §5 헤더: `(진행 가능 5건 → v1.32+ 매핑)` → `(활성 1건 → v1.36+ 매핑, 4건 archive 이관)`

**A2 §3 신규 후속 8건 등재**:

| 분류 | 신규 row | 출처 |
|------|---------|------|
| §3-B (회귀) | `v1.18g3-helper-redesign` (scorer 10+ 파일 또는 false positive) | v1.18g2 REPORT |
| §3-B (회귀) | `v1.18h-category-max-recalibration` (CATEGORY_META mismatch) | v1.35/v1.18g2 REPORT |
| §3-B (회귀) | `v1.18d2-multi-script-encoding` (다른 scripts cp949 재발) | v1.18d REPORT |
| §3-D (설계) | `v1.36d-detect-language-refactor` (dict ordering 의존 제거) | v1.18 REPORT, v1.35 L8 |
| §3-D (설계) | `v1.36-scorer-typesafety-na` (새 helper) | v1.35 REPORT |
| §3-D (설계) | `v1.36b-scorer-test-pytest-na` (새 helper) | v1.35 REPORT |
| §3-E (정규화) | `v1.36c-scorer-test-borderline-na` (테스트/소스 비율 + CI evidence 3+) | v1.35 REPORT |
| §3-E (정규화) | `v1.18e-scorer-html-na-ui` (HTML N/A 시각화) | v1.35 REPORT |

§3 헤더: `진행 불가 18건` → `진행 불가 26건` 동기화.
§3-B 카운트: 4건 → 7건. §3-D: 1건 → 3건. §3-E: 2건 → 4건.

**A3 §6-0 자동 검증 정책 신설**:

| Stage | 검증 내용 | --fix |
|-------|---------|:---:|
| 1 | post-v1.31 메타 §8 entry | ✅ skeleton |
| 2 | §2 strikethrough → §9 일치 | ❌ manual |
| 3 | §5 stale 감지 | ❌ 사용자 판단 |
| 4 | §2 헤더 카운트 동기화 | ❌ manual |

호출 시점 + LEGACY_SESSIONS skip 정책 + Pre-commit hook v1.31d 후속 안내 포함.

**A4 §8/§9 self entry 추가**:

- §8: v1.31c (2026-04-30) — smoke + --fix mode 도입
- §9: v1.31c row — drift 자동 감지 워크플로우 (Stage 1 entry skeleton 자동 삽입)

### Stage B — `tests/smoke-archive-sync.sh` 작성

**4 Stage**:

```bash
Stage 1 — §8 확정 세션 entry 검증 (FAIL)
  for each sessions/meta/v*/REPORT.md:
    legacy check (LEGACY_SESSIONS list + 일자 fallback) → SKIP
    grep "^- \\*\\*${version}\\*\\* " §8 → PASS / FAIL

Stage 2 — §2 strikethrough → §9 archive entry (WARN-only)
  awk extract §2 block → grep -oE 's/→ \\*\\*\`(v[^`]+)\\`/...'
  grep -F "\`${actual}\`" §9 → PASS / WARN

Stage 3 — §5 stale 감지 (WARN-only)
  awk extract §5 block → strikethrough refs
  grep version_only in §8/§9 → PASS / WARN

Stage 4 — §2 헤더 카운트 동기화 (FAIL)
  header N건 vs active row count → PASS / FAIL
```

**`--fix` mode (Stage 1 only)**:

- §9 헤더 line 직전 (빈 line 위치)에 skeleton 삽입
- 형식: `- **${version}** (${date}) — TODO: 1 line summary (session: ${name}).`
- mktemp + head/tail mv 패턴 (v1.29 답습)

**LEGACY_SESSIONS list**: 53 hardcoded forward-only (v1.0~v1.30b). 일자 fallback (`< 2026-04-29`) 추가 안전장치.

### Stage C — Self-test

**C1 — 첫 실행 (--fix 전, v1.31c REPORT 부재 시)**:

```
PASS=12 FAIL=0 SKIP=55 WARN=0
- v1.31c-archive-sync-automation — REPORT.md 부재 (세션 미완료) (SKIP)
```

**C2 — REPORT 작성 후, --fix 전**:

```
v1.31c-archive-sync-automation — §8 entry 누락 (v1.31c, 2026-04-30) ✗
PASS=12 FAIL=1 SKIP=54
```

**C3 — `--fix` 호출 후**:

```
=== --fix mode — §8 skeleton 삽입 ===
fix: §8에 skeleton 추가 — - **v1.31c** (2026-04-30) — TODO: 1 line summary (session: v1.31c-archive-sync-automation).
```

**C4 — 사용자 TODO 채움 후 재실행**:

```
v1.31c-archive-sync-automation — §8 entry 존재 (v1.31c, 2026-04-30) ✓
PASS=13 FAIL=0 SKIP=54 WARN=0
```

### Stage D — 회귀 검증 (다른 18 smoke)

기존 smoke (PASS=118 spec + 80 scope + 다른 17개) 모두 PASS 유지. 본 smoke 신설은 다른 smoke 영향 0.

## 판정 (PLAN 체크박스)

| 목표 | 결과 |
|------|:---:|
| §5 v1.35 strikethrough + 헤더 카운트 동기화 (5건 → 1건) | ✅ |
| §3 신규 후속 8건 등재 (v1.18g3 / v1.36 / v1.36b / v1.36c / v1.18h / v1.18e / v1.18d2 / v1.36d) | ✅ |
| §6-0 smoke 호출 의무 명시 | ✅ |
| `tests/smoke-archive-sync.sh` Stage 1~4 정적 검증 통과 | ✅ |
| `--fix` mode (Stage 1) 동작 — skeleton 삽입 후 재호출 PASS | ✅ |
| Self-test: 본 세션 v1.31c entry §8/§9 등재 후 smoke PASS | ✅ |
| 회귀 0: 기존 smoke 유지 | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 docs drift 검증 mechanism + bash 표준 도구만; PowerShell 변경 0). 구현 중 신규 spec drift 없음 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — `pipefail` + `grep` no-match 함정**: `grep | sed | tr` pipeline에서 grep no-match → 전체 pipeline exit 1 → `set -e` 즉시 종료. `extract_end_date()` 첫 구현 시 발견. fix: `grep ... || true` + 빈 raw 체크. v1.30b smoke pipefail 패턴 답습. **모든 helper 함수에 grep 보호 필수**.

- **L2 — 일자 기반 legacy 판정의 한계**: `세션 종료 < 2026-04-29` 단순 비교는 불충분 — v1.29/v1.30/v1.30b 등이 v1.31과 같은 일자에 완료. **버전 기반 LEGACY_SESSIONS hardcode + 일자 fallback** 이중 검증으로 해결. forward-only 정책 (한 번 seed 후 미증가).

- **L3 — Backtick regex escape 함정**: bash `"\\\`"` 4-char escape를 grep `-E`regex로 보낼 때 의미 불명확. **`-F` (fixed-string) 채택**으로 backtick literal 보장. Stage 2 첫 구현 시 false negative 3건 발견 → fix.

- **L4 — Skeleton 삽입 anchor 안정성**: `## 9. Archive` 헤더 line 직전 빈 line 위치에 삽입 → §8 끝 + 빈 line 보존 + §9 시작 자연 정합. 한 entry 삽입 후 line 번호 재계산 필요 (multiple --fix 시).

- **L5 — Smoke 자체가 세션 완료 검증** ⭐: 본 세션 smoke가 자기 자신 (v1.31c entry §8 누락) 검증 → self-test 사이클 자연 보장. v1.31b가 manual audit으로만 발견한 누락이 향후 자동 감지 가능. v1.31b → v1.31c → 후속 망각 자연 차단 chain.

- **L6 — Stage 2/3은 WARN-only** (의도적 design): §9 archive content는 session-specific 의미 추출 불가 (각 row 형식 다양 — alias chain / `(§2 row 외)` 등). 자동 fix 위험 > 가치. 사용자 판단 의존 + WARN flag만. 향후 evidence 누적 시 v1.31c2에서 패턴 정형화.

## 다음 후보 (보류)

| 항목 | 조건 |
|------|------|
| `v1.31d-precommit-archive-sync` | T3 — pre-commit hook 설치 (smoke validate 강제 — commit 전 차단). 망각 재발 1+ 또는 사용자 명시 요청 시 |
| `v1.31c2-stage2-fix-mode` | Stage 2 (§9 archive) auto-fix mode. evidence 누적 (manual 누락 3+) 후 — content varies 위험 검토 |
| `v1.31e-archive-content-auto` | §9 archive content 자동 추출 (REPORT.md 표 parse). PostToolUse hook과 함께 검토 |
| `v1.31f-domain-docs-sync-smoke` | OVERLAY/SKILLS/SPEC_VERIFICATION/OWNERSHIP §X-2 후속 list와 본 docs §3 cross-validate |
| `v1.31g-stage3-strikethrough-auto` | Stage 3 (§5 stale) auto-fix — strikethrough 자동 추가 (§9 entry 존재 시). evidence 누적 후 |
