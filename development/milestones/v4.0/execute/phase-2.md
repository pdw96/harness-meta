# phase-2 — 메타 v1.0~v3.21 → _archive/ git mv + smoke sentinel 검증 + ROADMAP era 표지

```json
{
  "phase": 2,
  "version": "v4.0",
  "id": "harness-composer-pivot",
  "title": "메타 v1.0~v3.21 → _archive/ git mv + smoke sentinel 검증 + ROADMAP era 표지",
  "status": "in_progress",
  "commit": null,
  "changes": [
    "(1) projects/meta/milestones/_archive/ 디렉토리 신설",
    "(2) v1.0~v3.21 모든 디렉토리 (40건, sub-directories 포함) → _archive/ 일괄 git mv (history 보존, v4.0/ 만 활성 위치 유지)",
    "(3) projects/meta/ROADMAP.md milestones_path sed 일괄 — v0~v3 prefix → milestones/_archive/v{X.Y}/ (v4.0 활성 유지, regex `\"milestones_path\": \"milestones/v[0123]`)",
    "(4) tests/smoke-bundle-trigger.sh MILESTONES_PATH_REGEX 안 `_archive/` optional 추가 (`^milestones/(_archive/)?v[0-9]+\\.[0-9]+/milestones\\.md$`) + 에러 메시지 narrative 갱신",
    "(5) tests/smoke-cross-ref.sh `_VER_MILE` regex 안 `_archive/` optional 추가 (`^projects/[^/]+/milestones/(_archive/)?v\\d+\\.\\d+[^/]*/.*\\.md$`) — archive 안 cross-ref 자동 skip (immutable history 정합)",
    "(6) 활성 cross-ref 2건 fix — docs/adr/ADR-006-workflow-revamp.md:115 (v1.84 archive prefix) + projects/meta/ARCHITECTURE.md:121 (v3.19 RESEARCH archive prefix)",
    "(7) projects/meta/ROADMAP.md § 관련 문서 안 활성 vs archive narrative 분리 (v4.0 활성 / _archive/ v1.0~v3.21 historical)"
  ],
  "affected_files": [
    "projects/meta/milestones/_archive/ (신규 디렉토리)",
    "projects/meta/milestones/_archive/v1.0_*/ ~ v3.21/ (40 디렉토리 git mv)",
    "projects/meta/ROADMAP.md (milestones_path sed + 관련 문서 narrative)",
    "tests/smoke-bundle-trigger.sh (MILESTONES_PATH_REGEX + 에러 narrative)",
    "tests/smoke-cross-ref.sh (_VER_MILE regex)",
    "docs/adr/ADR-006-workflow-revamp.md (line 115 archive prefix)",
    "projects/meta/ARCHITECTURE.md (line 121 archive prefix)"
  ],
  "criteria_met": {
    "INTENT_sc_3": "_archive/ 디렉토리 신설 + 메타 v1.0~v3.21 전체 git mv (40 디렉토리, history 보존 — git mv 가 자동 처리, 별도 verify 단계 후속 phase-8 안 흡수 가능)",
    "INTENT_sc_4": "upbit milestone (projects/upbit/) 현 위치 보존 — projects/upbit/ROADMAP.md 변경 0 (git status 확인)",
    "INTENT_sc_16": "ROADMAP entry archive 표지 — milestones_path sed 갱신 + 관련 문서 narrative 활성 vs archive 분리"
  },
  "smoke_verification": {
    "smoke-spec-verification": "PASS=5 FAIL=0 SKIP=12 (_archive/ 자동 skip)",
    "smoke-bundle-trigger": "PASS (regex `_archive/` optional 후)",
    "smoke-cross-ref": "PASS (broken ref 0건, archive 안 cross-ref 자동 skip + 활성 2건 fix 후)",
    "smoke-scope-contract": "PASS=4 FAIL=0",
    "smoke-projects-scope-discipline": "PASS",
    "smoke-open-stage-discipline": "PASS (9-stage-bundled checked=2 — v4.0/ + _archive/ skip)",
    "smoke-claude-md-drift": "PASS 13/13"
  },
  "deviations_from_design": [
    "phase-2 책임 확장 (DESIGN 비교) — smoke 2 파일 (bundle-trigger + cross-ref) regex 수정 + 활성 cross-ref 2건 fix 추가. DESIGN 안 'smoke sentinel skip 검증' narrative 가 자동 skip 가정이었으나 실제는 regex 수정 필요. workflow 본문 변경 아님 (smoke 자체는 자동화 보조, INTENT out_of_scope A 무관)"
  ]
}
```

## narrative

### 핵심 변경 (40 디렉토리 git mv)

```bash
# 단일 Bash loop — v4.0/ + _archive/ 제외 모든 디렉토리 archive 이전
mkdir -p projects/meta/milestones/_archive
for d in projects/meta/milestones/*/; do
  d_name="$(basename "$d")"
  if [ "$d_name" != "v4.0" ] && [ "$d_name" != "_archive" ]; then
    git mv "$d" "projects/meta/milestones/_archive/"
  fi
done
```

결과: `projects/meta/milestones/` 안 `_archive/` + `v4.0/` 만 활성. _archive/ 안 40 디렉토리 (v1.0~v3.21 era 별 historical).

### smoke 자동 skip 메커니즘 (tests/_inactive/ 선례 정합)

- **`_*` prefix sentinel** — `tests/_inactive/` (v3.6_overengineering-audit phase-2 도입) 패턴 정확 정합. `_archive/` 도 동일 sentinel.
- **smoke-spec-verification + smoke-scope-contract + smoke-open-stage-discipline** — `_*` 자동 skip (이미 구현, 추가 변경 0)
- **smoke-bundle-trigger** — MILESTONES_PATH_REGEX 안 `(_archive/)?` optional group 추가 (이번 phase-2 안 변경)
- **smoke-cross-ref** — `_VER_MILE` regex 안 `(_archive/)?` optional group 추가 (archive 안 cross-ref 자동 skip = immutable history 정합)

### Deviation from DESIGN

DESIGN phase-2 안 "smoke sentinel skip 검증" narrative 는 모든 smoke 가 `_*` 자동 skip 한다는 가정. 실제는 smoke-bundle-trigger + smoke-cross-ref 안 regex 수정 필요 (위 narrative). INTENT.out_of_scope (A) "9-stage 워크플로우 본문 변경" 무관 — smoke 는 자동화 보조 (ARCHITECTURE § 3.3 'Verification' 행 narrative).

## commit (pending 사용자 확인)

```
chore(meta): v4.0 phase-2 — 메타 v1.0~v3.21 → _archive/ git mv (40 디렉토리) + smoke regex + ROADMAP era 표지

projects/meta/milestones/v1.0~v3.21 → projects/meta/milestones/_archive/
일괄 git mv (40 디렉토리 + sub-directories, history 보존). v4.0/ 만 활성 위치 유지.

ROADMAP entry milestones_path 갱신 (v0~v3 prefix → _archive/v{X.Y}/, v4.0 활성).
smoke-bundle-trigger + smoke-cross-ref regex 안 _archive/ optional 추가.
활성 cross-ref 2건 fix (ADR-006 + ARCHITECTURE.md § 4 끝 v3.19 link).
projects/meta/ROADMAP.md § 관련 문서 안 활성 vs archive narrative 분리.

tests/_inactive/ 선례 정합 — _* prefix sentinel 자동 skip. upbit milestone 현 위치 유지 (A2).
```

## 관련

- INTENT: [`../INTENT.md`](../INTENT.md) — success_criteria (3), (4), (16)
- DESIGN: [`../DESIGN.md`](../DESIGN.md) phase-2
- tests/_inactive/ 선례: v3.6_overengineering-audit phase-2 (`_*` sentinel 도입)
