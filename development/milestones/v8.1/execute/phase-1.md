---
phase: phase-1
milestone: v8.1
status: completed
---

# v8.1 phase-1 — 정전화 (§ 7.4 + 매트릭스 #17) + mechanism 설치 + cascade host 동기

## Spec

```json
{
  "phase": "phase-1",
  "status": "completed",
  "scope": "가벼운 흐름 (4 섹션 트랙) 정전화 (ARCHITECTURE § 7.4 신설 + § 4 끝 매트릭스 #17 + § 6.1 era 표 row) + mechanism 설치 (skill skills/lightweight-flow/ + LIGHTWEIGHT.md template + smoke era 확장 _era_detect.py 4-section-lightweight 분기 + spec-verification/open-stage/bundle-trigger/scope-contract 확장) + cascade host 동기 (root CLAUDE.md + development/CLAUDE.md + tests/CLAUDE.md)",
  "changes": [
    {"type": "edit", "path": "development/ARCHITECTURE.md", "description": "§ 7.4 신설 (가벼운 흐름 4 섹션 정의 + 두 갈래 공존 + 승격 기준 표 + worked example 3건 (v8.1 큰 건 / v8.2 작은 건 / 반례) + LIGHTWEIGHT.md template + status enum draft|completed (SD-1) + ## 기록 trace 편입 (DX-3)) + § 4 끝 매트릭스 #17 row + paragraph 본문 + § 6.1 era 표 4-section-lightweight row (A-1 era 갱신 의무)"},
    {"type": "create", "path": "skills/lightweight-flow/SKILL.md", "description": "가벼운 흐름 derived checklist skill (9-stage stage skill 동형 4 H2: 입력(승격 판단 게이트 표)/작성할것(디렉토리+LIGHTWEIGHT.md template+ROADMAP entry+commit)/검증/관련). plugin.json skills 자동 인식 (ext_1)"},
    {"type": "edit", "path": "tests/_era_detect.py", "description": "4-section-lightweight 분기 추가 — 디렉토리 ^v\\d+\\.\\d+$ + LIGHTWEIGHT.md 존재 + MILESTONE.md 부재, flattened 검사 뒤 (flattened 우선 보존, risk_2)"},
    {"type": "edit", "path": "tests/smoke-spec-verification.sh", "description": "4-section-lightweight era LIGHTWEIGHT.md 검증 블록 추가 — frontmatter 4 필드 (id/title/version/status, status enum draft|completed) + H2 4 섹션 (## 문제/## 결정/## 적용/## 기록) 존재"},
    {"type": "edit", "path": "tests/smoke-open-stage-discipline.sh", "description": "페어링 검증에 LIGHTWEIGHT.md 추가 (milestones.md OR MILESTONE.md OR LIGHTWEIGHT.md)"},
    {"type": "edit", "path": "tests/smoke-bundle-trigger.sh", "description": "MILESTONES_PATH_REGEX 에 LIGHTWEIGHT.md 추가"},
    {"type": "edit", "path": "tests/smoke-scope-contract.sh", "description": "Stage 1 에 4-section-lightweight era 명시 skip 분기 (out_of_scope/approval gate 비적용 = 가벼운 흐름 본질)"},
    {"type": "edit", "path": "tests/CLAUDE.md", "description": "smoke 매트릭스 — spec-verification/scope-contract 6 era + open-stage/bundle-trigger LIGHTWEIGHT.md 페어링·regex 갱신"},
    {"type": "edit", "path": "CLAUDE.md", "description": "§ 워크플로우 안 '두 갈래 공존' 하위 섹션 추가 (cascade host — 큰 건 9-stage / 작은 건 가벼운 흐름 pointer)"},
    {"type": "edit", "path": "development/CLAUDE.md", "description": "모듈 가이드 milestone 산출물에 4-section-lightweight 트랙 row 추가 (cascade host)"}
  ],
  "verification": [
    {"method": "smoke", "result": "PASS", "detail": "smoke-spec-verification PASS=460 FAIL=0 SKIP=248 (기존 milestone 무손상)"},
    {"method": "smoke", "result": "PASS", "detail": "smoke-scope-contract PASS=103 FAIL=0 SKIP=9"},
    {"method": "smoke", "result": "PASS", "detail": "smoke-open-stage-discipline PASS (checked=55, historical skipped=1)"},
    {"method": "smoke", "result": "PASS", "detail": "smoke-bundle-trigger PASS"},
    {"method": "manual", "result": "PASS", "detail": "_era_detect 직접 검증 — pure LIGHTWEIGHT.md → 4-section-lightweight / MILESTONE+LIGHTWEIGHT 동시 → 9-stage-flattened (flattened 우선, risk_2 오분류 회피 확인)"},
    {"method": "pre-commit", "result": "PASS", "detail": "pre-commit run --all-files 18 hook 전체 PASS (markdownlint + cross-ref + claude-md-drift + cascade-drift 포함)"},
    {"method": "manual", "result": "PASS", "detail": "cascade_sync.py --check exit 0 (all 1 host in sync; ARCHITECTURE.md 106297 bytes > 100KB WARN skip — 본 milestone 신규 marker 부재, 기존 단일 host 정합)"}
  ],
  "commit": {
    "sha": "pending",
    "message": "feat(meta): [v8.1] phase-1 — 가벼운 흐름 (4 섹션 트랙) 정전화 + mechanism 설치"
  }
}
```

## Narrative

phase-1 = 정전화 + mechanism 설치 + cascade host 동기. DESIGN approach (a)~(e) 정합.

**결정 trace 흡수** — d_10 design-review decisive 4건 모두 반영: (A-1) § 6.1 era 표 row 추가 (era N+1 갱신 의무, ARCHITECTURE:253) 완료, (A-2) deferred→next_candidates schema 변환은 phase-2 처리, (SD-1) LIGHTWEIGHT.md status enum `draft|completed` § 7.4 + skill + smoke 3 곳 정의, (DX-3) `## 기록` trace 편입 § 7.4 명시 (release-publish.yml `## REPORT` 미인식 → git+ROADMAP+섹션 자체 3중 보존). DX-1 minor (승격 기준 반례 1건) = § 7.4 승격 기준 worked example 에 '반례 (가벼운 흐름 부적합)' 항목으로 흡수.

**도중 발견 issue + mitigation** — (1) smoke-cross-ref `--fix` 가 forward-reference 행 (phase-2 생성 예정 v8.2/LIGHTWEIGHT.md 링크 + 오타 `../../skills/` 2-up 경로) 을 파괴적 삭제 → `.bak` 복원 후 정정: skills 경로 `../skills/` (1-up) 교정 + v8.2 참조는 markdown 링크 대신 backtick text 로 강등 (cross-ref 는 backtick-only path 제외, phase-2 v8.2 생성 후 링크 승격 가능). (2) ARCHITECTURE.md 가 § 7.4 추가로 106297 bytes (> 100KB) → cascade-drift/cascade_sync 가 WARN skip — 본 milestone 신규 cascade marker 부재라 무영향, 단 향후 ARCHITECTURE.md 안 cascade marker 추가 시 size limit 재검토 필요 (## SCOPE_OUT_NOTES 후속 candidate 자연).

**era 분기 순서** (risk_2 mitigation) — `4-section-lightweight` 를 flattened (MILESTONE.md) 검사 뒤에 배치해 기존 30+ flattened milestone 오분류 0 확인 (직접 검증 PASS). 기존 55 milestone E2E 무손상 (smoke PASS).
