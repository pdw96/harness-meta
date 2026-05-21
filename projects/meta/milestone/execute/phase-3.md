---
phase: phase-3
milestone: v7.0
status: completed
---

# v7.0 phase-3 — milestone 산출물 git tag 위임 migration (mandate #8 도그푸드)

## Spec

```json
{
  "phase": "phase-3",
  "status": "completed",
  "scope": "milestone 산출물 git tag 위임 migration — (a) projects/meta/milestone/ (단수) 디렉토리 신설 + git mv v7.0 산출물 (MILESTONE.md + execute/phase-1.md + execute/phase-2.md) + projects/meta/milestones/v7.0/ rmdir + (b) ROADMAP v7.0 entry milestones_path 갱신 (milestone/MILESTONE.md#sub-milestones 단수) + (c) tests/smoke-bundle-trigger.sh regex 단수 path 분기 추가 + (d) tests/_era_detect.py 안 'external-vector-pivot' era 신규 분기 추가 (mandate #5 약위반 1건 — v7.0 = 마지막 self-loop forward-only mandate 정합)",
  "changes": [
    {
      "type": "create",
      "path": "projects/meta/milestone/",
      "description": "단수 디렉토리 신설 — v7.0+ external-vector-pivot era 현재 milestone only 거주 위치"
    },
    {
      "type": "rename",
      "path": "projects/meta/milestones/v7.0/MILESTONE.md → projects/meta/milestone/MILESTONE.md",
      "description": "git mv (history 보존)"
    },
    {
      "type": "rename",
      "path": "projects/meta/milestones/v7.0/execute/phase-1.md → projects/meta/milestone/execute/phase-1.md",
      "description": "git mv"
    },
    {
      "type": "rename",
      "path": "projects/meta/milestones/v7.0/execute/phase-2.md → projects/meta/milestone/execute/phase-2.md",
      "description": "git mv"
    },
    {
      "type": "rename",
      "path": "projects/meta/milestones/v7.0/execute/phase-3.md → projects/meta/milestone/execute/phase-3.md",
      "description": "git mv (본 phase 자체, 도그푸드 마지막)"
    },
    {
      "type": "delete",
      "path": "projects/meta/milestones/v7.0/",
      "description": "rmdir (empty 후) — 단수 디렉토리 migration 도그푸드 완료"
    },
    {
      "type": "edit",
      "path": "projects/meta/ROADMAP.md",
      "description": "v7.0 entry milestones_path 갱신 — `milestones/v7.0/MILESTONE.md#sub-milestones` → `milestone/MILESTONE.md#sub-milestones`"
    },
    {
      "type": "edit",
      "path": "tests/smoke-bundle-trigger.sh",
      "description": "milestones_path regex 단수 path 분기 추가 (`^milestone/MILESTONE\\.md(#sub-milestones)?$` allowed)"
    },
    {
      "type": "edit",
      "path": "tests/_era_detect.py",
      "description": "단수 디렉토리 name=='milestone' 검사 + 'external-vector-pivot' era 신규 분기 추가 (1줄)"
    }
  ],
  "verification": [
    {
      "method": "smoke",
      "result": "PASS",
      "detail": "smoke-spec-verification PASS 426/0 (v7.0 자연 미포함, forward-only mandate 정합) + smoke-scope-contract PASS 96/0 + smoke-bundle-trigger PASS (regex 단수 path 분기 정합) + smoke-open-stage-discipline PASS (51 checked) + smoke-cascade-drift PASS"
    },
    {
      "method": "manual",
      "result": "PASS",
      "detail": "mv 4건 (MILESTONE.md + execute/phase-1.md + phase-2.md + phase-3.md) + rmdir 2건 (v7.0/execute + v7.0/) + ROADMAP milestones_path 갱신 (milestones/v7.0/... → milestone/...) + _era_detect.py 'external-vector-pivot' era 분기 추가 + smoke-bundle-trigger regex 단수 path 허용. 디렉토리 위치 = projects/meta/milestone/ (단수, 도그푸드)."
    }
  ],
  "commit": {
    "sha": "pending",
    "message": "feat(meta): v7.0 phase-3 — milestone 산출물 git tag 위임 migration (도그푸드 v7.0 단수 디렉토리)"
  }
}
```

## Narrative

phase-3 = mandate #8 (milestone 산출물 단일 파일 + git tag 위임) 도그푸드 직접 실현. v7.0 = 자기 정정 mechanism 마지막 cycle 본질 + 본 phase 안 단수 디렉토리 도그푸드 = 본질 직접 evidence. era 분기 신규 1건 추가 (`_era_detect.py` "external-vector-pivot") = mandate #5 약위반 1건 — 단 v7.0 마지막 self-loop forward-only mandate 정합 (후속 self-host milestone 부재 → era 분기 추가 forward-only 자연).

22 디렉토리 archive (v6.2~v6.23) = phase scope 외 (cross-ref 손실 R10 자연 인정 + 디렉토리 보존). 본 phase = projects/meta/milestone/ 단수 디렉토리 신설 + v7.0 자체 거주 본질.
