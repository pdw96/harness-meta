# meta v1.31c-archive-sync-automation — PLAN

세션 시작: 2026-04-30
직접 선행 세션:

- [`sessions/meta/v1.31-evidence-driven-roadmap/`](../v1.31-evidence-driven-roadmap/) — EVIDENCE_DRIVEN_ROADMAP.md 신설 + §6 갱신 정책
- [`sessions/meta/v1.31b-roadmap-archive-arrears/`](../v1.31b-roadmap-archive-arrears/) — 다음 후보 §에 본 세션 명시 (`v1.31c-archive-validation-smoke`)
- [`sessions/meta/v1.29-verify-fix-mode/`](../v1.29-verify-fix-mode/) — smoke `--fix` 패턴 답습
- [`sessions/meta/v1.33-fix-scope-contract/`](../v1.33-fix-scope-contract/) — smoke + enumerate 자동 흡수 패턴 답습
- [`sessions/meta/v1.18g2-helper-threshold-revisit/`](../v1.18g2-helper-threshold-revisit/) + [`v1.35-scorer-other-na-categories/`](../v1.35-scorer-other-na-categories/) + [`v1.18d-scorer-stdout-encoding/`](../v1.18d-scorer-stdout-encoding/) — 다음 후보 § evidence 출처

목적: EVIDENCE_DRIVEN_ROADMAP.md drift 자동 감지 워크플로우 도입. (1) 즉시 누락 정정 — §5 stale + §3 7건 신규 후속 추가, (2) `tests/smoke-archive-sync.sh` 신설 — §8 entry 누락 자동 검증 + `--fix` skeleton 삽입, (3) §6 갱신 정책에 smoke 호출 의무 명시. T3 pre-commit hook은 별 후속 (v1.31d).

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S2(1) `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` + S3(1) `tests/smoke-archive-sync.sh` (신규) = **2/2 meta**
- **T1 경로 다수결** — meta scope 2/2
- **T2 스펙 vs 값** — roadmap drift 검증 mechanism = 모든 미래 메타 세션 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.31b-roadmap-archive-arrears/REPORT.md` 다음 후보 § (verbatim)**:

> | `v1.31c-archive-validation-smoke` | archive 누락 자동 검증 smoke (REPORT 작성 시 §2 row 자동 archive 이관 강제). evidence 누적 (재발 1+) 후 |

> | §5 권장 진행 순서 갱신 | 본 세션에서 ranks 1-3 archive 이관됐으나 §5는 그대로. 별 후속 또는 §5 제거 |

**Source 2 — 사용자 발의 (2026-04-30) verbatim**:

> "후속 권장 세션 및 최신 report를 해당 md에 입력하고, 자동으로 갱신되는 워크플로우로 만들어"

**Source 3 — `sessions/meta/v1.31-evidence-driven-roadmap/REPORT.md` §6-1 (verbatim, indirect — 갱신 정책)**:

> 해당 row를 `✅ 완료 (vX.Y 세션, YYYY-MM-DD)` 표기 후 archive 섹션 (§9 신설 예정)으로 이동.

**Parsed sub-items (3)**:

1. **즉시 누락 정정** — §5 v1.35 strikethrough + §3 신규 후속 7건 추가 (v1.18g3 / v1.36 / v1.36b / v1.36c / v1.18h / v1.18e / v1.18d2)
2. **smoke-archive-sync.sh** — §8 entry 자동 검증 + `--fix` skeleton 삽입 (post-v1.31 메타 세션 대상)
3. **§6 갱신 정책 강화** — smoke 호출 의무 명시 + LEGACY_SESSIONS skip 정책 명시

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| **T3 pre-commit hook 설치** (smoke 자동 실행) | `v1.31d-precommit-archive-sync` 별 후속. 본 세션은 T1+T2만. evidence 누적(망각 1건+) 후 또는 사용자 명시 요청 |
| **PostToolUse hook** (REPORT.md write 시 자동 --fix) | 별 후속 (T3 후속). Markdown 자동 편집 위험 — 사용자 검토 거치는 manual --fix가 안전 |
| **§9 archive content 자동 생성** | content varies — skeleton만 가능. user-fill 의존 |
| **§5 권장 진행 순서 자동 재정렬** | Claude/사용자 판단 의존 — stale 감지만 |
| **§3 신규 후속 자동 등재** | "다음 후보" §에서 의미 추출 어려움 — 본 세션에서 manual 등재 (1회 batch) |
| **pre-v1.31 메타 53건 §8 등재** | LEGACY_SESSIONS skip 영구 (forward-only, v1.27 LEGACY_REPORTS 패턴 정합) |
| **smoke-spec-verification / smoke-scope-contract와 통합** | 별 smoke 유지 (단일 책임 원칙) — 통합은 별 후속 evidence 시 |
| **§5 § 자체 제거** | 본 세션은 stale 정정만 — 제거는 §5 본질 (Claude 권장) 가치 별도 평가 후 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 docs drift 검증 mechanism + bash 표준 도구만; PowerShell 변경 0) |
| **re-verify** | N/A |

## 1. 문제

### Drift 누적 패턴 (3 layer)

**Layer 1 — §5 stale**: ranks 1-3 archive 이관 후에도 §5 그대로. v1.35 (rank 4)도 archive됐으나 §5 strikethrough 누락. v1.31b REPORT에서 명시 발견.

**Layer 2 — §3 outdated**: 최근 세션 (v1.18g2 / v1.35 / v1.18d / v1.31b) "다음 후보" §에 신규 후속 7건 listing되었으나 §3 (진행 불가 18건) 매트릭스에 미등재. "통합 view" 단일 소스 신뢰성 ↓.

**Layer 3 — §8 누락 위험**: v1.31b가 v1.35/v1.18g2 누락 정정했지만 mechanism 부재 → 미래 재발 가능. v1.31 §6-1 정책 정합성 강제 mechanism 없음.

### Root cause

세션 종료 시 EVIDENCE_DRIVEN_ROADMAP 갱신은 **사용자 의지 기반**. 망각 시 자동 감지 0. v1.31b에서 v1.35/v1.18g2 누락이 manual audit으로만 발견 — pattern 재발 가능.

### 본 세션 해결 범위

3-tier 워크플로우 중 T1 (smoke validate) + T2 (--fix skeleton) + 즉시 batch 정정. T3 (pre-commit/PostToolUse hook)는 별 후속.

## 2. 결정 (R1 ~ R5)

### R1 — §5 stale 정정 (즉시)

```diff
- | 4 | `v1.35-scorer-other-na-categories` (= v1.18f 별칭) | §2 #4 | harness-meta self-eval 활용 |
+ | 4 | ~~`v1.35-scorer-other-na-categories` (= v1.18f 별칭)~~ → 완료 (§9) | §2 #4 | harness-meta self-eval 활용 |
```

§5 헤더 "(진행 가능 5건 → v1.32+ 매핑)"도 갱신: archive 4건 후 1건 활성. 또는 § 자체 제거 검토 — 본 세션에서는 strikethrough만 + § 헤더 카운트 동기화 (`5건` → `1건`). § 본질 (rank 권장) 제거는 별 평가.

### R2 — §3 신규 후속 7건 등재

각 row의 분류 (§3-A/B/D/E):

| 신규 후속 | §3 분류 | 출처 REPORT |
|---------|:---:|------|
| `v1.18g3-helper-redesign` | **B-2 회귀/장애** (scorer 10+ 파일 도달 또는 false positive evidence) | v1.18g2 |
| `v1.36-scorer-typesafety-na` | **D 설계 결정 선행** (새 helper 필요 — `is_small_python_script`) | v1.35 |
| `v1.36b-scorer-test-pytest-na` | **D 설계 결정 선행** (sub-3.3 dead code 해소 새 helper) | v1.35 |
| `v1.36c-scorer-test-borderline-na` | **E 정규화 우선순위 미달** (테스트/소스 비율 + CI evidence 3+) | v1.35 |
| `v1.18h-category-max-recalibration` | **B-2 회귀** (CATEGORY_META mismatch — Doc 13 vs max 15 / Code 13 vs max 15) | v1.35 / v1.18g2 |
| `v1.18e-scorer-html-na-ui` | **E 정규화 우선순위 미달** (multi-repo sample 또는 사용자 요청) | v1.35 |
| `v1.18d2-multi-script-encoding` | **B-2 회귀** (다른 scripts/*.py에서 cp949 evidence 발생 시) | v1.18d |

추가로 §3-D에 1건 명시 (이미 존재하는 lang detection refactor를 이름 정형화):

| 기존 row | 갱신 |
|---------|------|
| (lang detection redesign) | `v1.36d-detect-language-refactor` (dict ordering 의존 제거) |

### R3 — `tests/smoke-archive-sync.sh` 신설

**Stage 매트릭스**:

```bash
Stage 1 — §8 entry 검증
  for each session_dir in sessions/meta/v*/REPORT.md:
    name = basename(dirname(report))
    if is_legacy(name):              # LEGACY_SESSIONS skip (v1.0~v1.30 53건)
      SKIP
      continue
    if grep -q "^- \*\*${name}\*\*" §8:
      PASS
    else:
      FAIL — "§8 entry 누락: ${name}"

Stage 2 — §9 archive entry 검증 (§2 strikethrough → §9 일치)
  for each row in §2 with ~strikethrough~:
    extract session ref
    if grep -q "${session_ref}" §9:
      PASS
    else:
      FAIL — "§9 archive 누락"

Stage 3 — §5 stale 감지
  for each row in §5:
    if has ~strikethrough~ but session not in §9:
      WARN — "stale rank entry"

Stage 4 — § 카운트 동기화
  active = count of non-strikethrough rows in §2
  if header "진행 가능 N건" matches active:
    PASS
  else:
    FAIL — "§2 header count drift"
```

**LEGACY_SESSIONS array** (forward-only, v1.27 LEGACY_REPORTS 패턴):

```bash
LEGACY_SESSIONS=(
  v1.0-bootstrap v1.1-global-smoke-test v1.2-ownership-rules
  ... (v1.0~v1.30 53건 enumerate)
)
```

**`--fix` mode** (Stage 1 only):

```bash
if [ "$FIX_MODE" = "1" ]; then
  for each missing §8 entry:
    extract date from REPORT.md (`^세션 종료: ` line)
    append to §8: "- **${name}** (${date}) — TODO: 1 line summary."
fi
```

Stage 2/3/4는 fix 안 함 (content/judgment 의존).

**CLI**:

```bash
bash tests/smoke-archive-sync.sh                        # validate (default)
bash tests/smoke-archive-sync.sh --fix                  # auto-append missing §8 entries
bash tests/smoke-archive-sync.sh --fix --dry-run        # preview only
bash tests/smoke-archive-sync.sh --help                 # usage
```

### R4 — §6 갱신 정책 강화

```diff
+ ### 6-0. 자동 검증 (smoke-archive-sync)
+
+ 본 docs drift 자동 감지: `bash tests/smoke-archive-sync.sh`
+
+ - 매 메타 세션 종료 시 또는 commit 전 호출 권장
+ - FAIL 시 `--fix` 호출 → §8 skeleton 자동 삽입 → 사용자 TODO 채움
+ - LEGACY_SESSIONS array (v1.0~v1.30 53건) skip 정책 영구 유지
+
+ Pre-commit hook 자동화는 `v1.31d-precommit-archive-sync` 별 후속 (evidence-driven).
```

### R5 — Self-test

`tests/smoke-archive-sync.sh` 자체가 본 세션 PLAN/REPORT를 검증 대상에 포함 → 본 세션 완료 후 즉시 PASS 보장 (§8에 v1.31c entry 추가 의무).

또한 R1+R2 정정 후 §5 stale 감지 0 + §3 신규 row 7건 등재 + §2 header 카운트 동기화 검증.

## 3. 변경 대상

### 수정 (1)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` | S2 | R1 + R2 + R4 — §5 정정 + §3 신규 row 7+ + §6-0 신설 + §2 header 동기화 + §8에 v1.31c entry |

### 신규 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `tests/smoke-archive-sync.sh` | S3 | R3 — Stage 1~4 정적 검증 + Stage 1 `--fix` |
| `sessions/meta/v1.31c-.../{PLAN,REPORT}.md` | meta | 본 세션 기록 |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 (R1~R5)
- [ ] **사용자 진입 확인**
- [ ] Stage A — EVIDENCE_DRIVEN_ROADMAP.md 즉시 정정 (§5 + §3 + §6-0 + §2 header)
- [ ] Stage B — `tests/smoke-archive-sync.sh` 작성 (Stage 1~4 + --fix Stage 1)
- [ ] Stage C — Self-test 실행 (PASS 보장 + §8에 v1.31c 추가)
- [ ] Stage D — 다른 smoke 회귀 검증 (PASS 유지)
- [ ] Stage E — REPORT.md + §9 archive에 v1.31c entry 추가
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] §5 v1.35 strikethrough + §5 헤더 카운트 동기화 (`5건` → `1건`)
- [ ] §3 신규 후속 7건 (또는 8건 — lang detection 정형화) 등재
- [ ] §6-0 smoke 호출 의무 명시
- [ ] `tests/smoke-archive-sync.sh` Stage 1~4 정적 검증 통과
- [ ] `--fix` mode (Stage 1) 동작 — skeleton 삽입 후 재호출 PASS
- [ ] Self-test: 본 세션 v1.31c entry §8/§9 등재 후 smoke PASS
- [ ] 회귀 0: 기존 19 smoke (PASS=118 + 80) 유지

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.31c-archive-sync-automation — EVIDENCE_DRIVEN_ROADMAP drift 자동 감지 + 즉시 정정

- update: bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md
  - §5 v1.35 strikethrough + 헤더 카운트 (5건 → 1건) (R1)
  - §3 신규 후속 8건 등재 (v1.18g3 / v1.36 / v1.36b / v1.36c / v1.18h / v1.18e / v1.18d2 / v1.36d) (R2)
  - §6-0 자동 검증 정책 신설 — smoke-archive-sync 호출 의무 (R4)
  - §8 + §9 v1.31c entry 추가 (self)
- add: tests/smoke-archive-sync.sh
  (Stage 1~4 정적 검증 + Stage 1 --fix mode
   LEGACY_SESSIONS pre-v1.31 53건 skip — forward-only, v1.27 패턴 답습)
- add: sessions/meta/v1.31c-archive-sync-automation/{PLAN,REPORT}.md

T1+T2 워크플로우 도입 (smoke validate + --fix skeleton).
T3 (pre-commit hook) 별 후속 v1.31d-precommit-archive-sync.
PostToolUse hook 위험 — Markdown 자동 편집은 manual --fix가 안전.

References: v1.31b 다음 후보 § + v1.18g2/v1.35/v1.18d 다음 후보 § + v1.29/v1.33 --fix 패턴.
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|-----------|---|
| `v1.31d-precommit-archive-sync` | T3 — pre-commit hook 설치 (smoke validate 강제). evidence 누적 (망각 재발 1+) 또는 사용자 명시 요청 시 |
| `v1.31e-archive-content-auto` | §9 archive content 자동 추출 (REPORT.md 표 parse). evidence 부재 — 별 후속 |
| `v1.31f-domain-docs-sync-smoke` | OVERLAY/SKILLS/SPEC_VERIFICATION/OWNERSHIP §X-2 후속 list와 EVIDENCE_DRIVEN_ROADMAP.md §3 cross-validate. drift 누적 시 |
