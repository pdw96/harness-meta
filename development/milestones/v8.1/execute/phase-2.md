---
phase: phase-2
milestone: v8.1
status: completed
---

# v8.1 phase-2 — 반창고 은퇴 (동결 정책) + v8.2 가벼운 흐름 도그푸드

## Spec

```json
{
  "phase": "phase-2",
  "status": "completed",
  "scope": "두 반창고 은퇴 — (1) lightweight 1-phase 관행 = 가벼운 흐름 정식 대체 (§ 7.4 phase-1 명시 완료) + (2) 동결 정책 = ROADMAP deferred_note 은퇴 + deferred 3건 처리 (v1.5 도그푸드 실처리 / v1.4×2 next_candidates 전환) + 도그푸드 development/milestones/v8.2/LIGHTWEIGHT.md 작성 (deferred v1.5 RESEARCH cascade grep 규율 해소, sc_5 입증)",
  "changes": [
    {"type": "create", "path": "development/milestones/v8.2/LIGHTWEIGHT.md", "description": "harness-meta 첫 가벼운 흐름 산출물 (4-section-lightweight era) — deferred v1.5 도그푸드 해소. 4 섹션 (## 문제/## 결정/## 적용/## 기록) + frontmatter 4 필드 (status: completed). era 식별 4-section-lightweight 확인"},
    {"type": "edit", "path": "skills/stage-research/SKILL.md", "description": "## 입력 안 'cascade host 조사 grep 규율' 블록 추가 (3 형식 = relative/절대·repo-root/symlink·anchor + v1.4 lessons #1 origin + cascade_sync marker 자동화 보완 관계) — deferred v1.5 실 해소 변경"},
    {"type": "edit", "path": "development/ROADMAP.md", "description": "deferred_note 은퇴 narrative (동결 정책 retire, '§ 6.2 부활' 아닌 drift 해소 framing, memory feedback_section_6_2_abolished 정합) + deferred 3건 milestones[] 제거 + v8.2 completed entry 추가 + next_candidates[] 2건 추가 (hook-narrative-separation / design-review-trace, v1.4×2 schema 변환 A2: version→id slug + target_version + title ≤60) + verification-philosophy-redefine target v8.2→v8.3 (도그푸드 v8.2 충돌 회피)"}
  ],
  "verification": [
    {"method": "smoke", "result": "PASS", "detail": "smoke-spec-verification — v8.2 LIGHTWEIGHT.md frontmatter 4 필드 + 4 섹션 OK (sc_5 직접 입증). FAIL=0"},
    {"method": "manual", "result": "PASS", "detail": "_era_detect — development/milestones/v8.2/ → 4-section-lightweight 식별 확인"},
    {"method": "smoke", "result": "PASS", "detail": "smoke-bundle-trigger — v8.2 milestones_path 'milestones/v8.2/LIGHTWEIGHT.md' regex PASS + 실 파일 존재 검증 PASS + version uniqueness PASS"},
    {"method": "smoke", "result": "PASS", "detail": "smoke-open-stage-discipline — v8.2 디렉토리 ↔ LIGHTWEIGHT.md 페어링 PASS (checked 증가)"},
    {"method": "smoke", "result": "PASS", "detail": "smoke-candidate-draft-schema — next_candidates[].id regex + entry-title (title ≤60 + ' + ' 부재) PASS"},
    {"method": "pre-commit", "result": "PASS", "detail": "pre-commit run --all-files 18 hook 전체 PASS"},
    {"method": "manual", "result": "PASS", "detail": "grep 동결 정책 — 활성 정책 statement 0 (development/ROADMAP deferred_note = 은퇴 기록 / ARCHITECTURE = v4.0 폐지 historical record / upbit notes + 완료 milestone REPORT = historical trace 보존, oos_1 upbit 미변경)"}
  ],
  "commit": {
    "sha": "pending",
    "message": "feat(meta): [v8.1] phase-2 — 반창고 은퇴 (동결 정책) + v8.2 가벼운 흐름 도그푸드"
  }
}
```

## Narrative

phase-2 = 반창고 은퇴 + 도그푸드 (가치 입증). DESIGN approach (f)~(i) 정합.

**lightweight 1-phase 관행 (d_5)** — § 7.4 안 'lightweight 1-phase 관행 대체' paragraph 로 phase-1 에서 이미 명시 (재폐지 아님, v4.0 § 6.2 폐지 정합). phase-2 추가 작업 부재.

**동결 정책 은퇴 (d_6, risk_1)** — ROADMAP deferred_note 를 '동결 정책 보존' → '동결 정책 은퇴 (drift 해소)' 로 재작성. memory `feedback_section_6_2_abolished` 정합하게 '§ 6.2 부활' 이 아니라 '컨설턴트 정체성 + 가벼운 흐름 창구 도입으로 동결 narrative 가 무의미해진 deferred_note drift 해소' framing. deferred 3건 처리 = v1.5 도그푸드 실처리 (v8.2) + v1.4×2 next_candidates 전환. d_10 A-2 schema 변환 의무 준수 — version (`v1.4_hook-narrative-separation`) → id slug (`hook-narrative-separation`, regex `^[a-z0-9-]+$`) + target_version (`v8.4`, regex `^v[0-9]+\.[0-9]+$`) + title ≤ 60자 ∧ ' + ' 부재 점검.

**도그푸드 (d_7, sc_5)** — deferred `v1.5_research-cascade-grep-discipline` 를 v8.2 가벼운 흐름으로 실처리. 실 변경 = stage-research SKILL.md 의 cascade host grep 3 형식 규율 1 블록 (작은 mechanical 보강 = 가벼운 흐름 적정 scope). v8.2 LIGHTWEIGHT.md 자체가 4-section-lightweight era smoke 통과 = 가벼운 흐름 mechanism 실작동 직접 입증 (sc_5).

**도중 결정 trace** — (1) 도그푸드 위치 = 사용자 결정 (별 디렉토리 v8.2, DESIGN d_7 '또는 별 디렉토리' 옵션 선택) — era 분기 + open-stage/bundle-trigger smoke 확장을 실작동 검증 (dead code 회피). (2) upbit ROADMAP 안 historical 완료 milestone notes (`v1_7_note` 등 § 6.2 trigger 조건 count 기록) 는 미변경 — 역사적 trace 보존 (oos_1 upbit 미변경 + v8.0 oos_5 외부 구조 불변 정합, memory `feedback_hard_reset` audit trail narrative 보존 정합). (3) verification-philosophy-redefine target v8.2 → v8.3 — v8.2 가 도그푸드에 사용되어 충돌 회피.

**도중 발견 issue** — phase-1.md ### Spec JSON 안 top-level `status` 필드 누락 → smoke-spec-verification check_execute_phase FAIL (extract_json 안 phase+status 강제) → `"status": "completed"` 추가 정정 (기존 v8.0 phase 파일 convention 정합).
