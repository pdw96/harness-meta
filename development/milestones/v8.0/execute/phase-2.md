---
id: reclassify-meta-as-development
title: phase-2 — cross-ref 보정 + thin-index + 활성 narrative sweep
version: v8.0
phase: 2
status: complete
---

# v8.0 phase-2 — cross-ref 보정 + thin-index + 활성 narrative sweep

## Scope (DESIGN d_1/d_2/d_4, approach (f)~(g))

내부 cross-ref 보정 + root ROADMAP thin-index 재구성 + 활성 instruction projects/meta → development sweep.

## Changes

```json
{
  "phase": 2,
  "status": "complete",
  "commit": "(phase-1+2 통합 1 commit)",
  "changes": [
    {"file": "tests/smoke-cross-ref.sh", "what": "_VER_MILE 제외 패턴에 development/milestones 추가 — (?:projects/[^/]+|development)/milestones/(_archive/)?v...  (immutable history 제외 scope 확장, 판정 로직 불변). **이것이 _archive 134건을 안 건드리고 보존하는 핵심** (d_4 + settings.json hard_deny 정합)"},
    {"file": "development/{ARCHITECTURE,CLAUDE}.md + 비이동 active narrative ~40파일", "what": "projects/meta → development 문자열 sweep (skills 11 + agents 6 + claude/commands 3 + bootstrap 3 + docs/adr + .claude/rules 2 + AGENTS/README/GUARDRAILS/CLAUDE + tests/CLAUDE/_era_detect 등). cascade marker 경로 + 링크 text/target 정합 동반 (186 occurrences / 41 files)"},
    {"file": "ROADMAP.md (root)", "what": "thin-index 재작성 — projects[] 에서 meta 제거 (upbit 만) + development_roadmap 별도 필드 신설 (d_2: projects[] regex 불변 + smoke-projects-scope-discipline 무수정). 활성 ROADMAP 표 + 의도 narrative 갱신"},
    {"file": "이동 파일 active cross-ref (development/{ARCHITECTURE,ROADMAP,CLAUDE}.md + upbit/ROADMAP.md)", "what": "상대경로 정밀 재계산 (옛 위치 기준 의도 대상 역산 → 새 위치 상대경로). root-level (../ 1개 감소) / sibling projects/upbit (../projects/upbit/) 구분 처리"},
    {"file": "tests/fixtures/audit-fact-verify/table-{normal,mismatch}/mapper-output.md", "what": "fixture 안 live-경로 검증 인용 projects/meta → development (table-normal=ARCHITECTURE.md 실존 복원 exit0 / table-mismatch=nonexistent-fact.md 부재 유지 exit1)"},
    {"file": "development/milestones/_archive/** (134 broken ref)", "what": "**미변경 — immutable history 보존** (cross-ref 제외 패턴 확장으로 검사 대상 외, hard_deny 정합). DESIGN d_4 + 사용자 옵션 재해석 후 더 깨끗한 해법"},
    {"file": "development/ROADMAP.md v8.0 entry summary", "what": "미변경 — v8.0 이동 narrative ('git mv projects/meta→development') 보존 (move 서술이라 의도적 유지)"}
  ],
  "verification": [
    "smoke-cross-ref PASS (broken ref 0건)",
    "smoke-projects-scope-discipline PASS (projects[]=upbit only)",
    "smoke-claude-md-drift 13/13 PASS",
    "smoke-cascade-drift all 1 host in sync",
    "smoke-audit-fact-verify PASS=9 (table-normal exit0 복원)",
    "pre-commit run --all-files = 18 hook 전부 PASS"
  ]
}
```

## phase 통합 commit 사유

DESIGN d_6 은 phase-1/phase-2 별 2 commit 계획. 그러나 EXECUTE 중 발견 — `git mv` 가 `development/ROADMAP.md` 등 ROADMAP/cross-ref 트리거 파일을 건드려 pre-commit (smoke-cross-ref + projects-scope-discipline) 이 phase-1 단독 커밋 시 FAIL. 즉 디렉토리 이동과 narrative cross-ref 보정이 pre-commit 레벨에서 불가분 → **phase-1+2 통합 1 commit** 으로 진행 (논리 분리는 본 execute/ 별책 2건으로 보존).
