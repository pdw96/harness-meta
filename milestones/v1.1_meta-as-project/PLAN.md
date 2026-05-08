# PLAN — v1.1_meta-as-project

```json
{
  "id": "v1.1_meta-as-project",
  "title": "meta repo를 projects/meta/로 이관 — 모든 project 동형 구조 강제",
  "goal": "harness-meta repo 자체 milestone trace를 projects/meta/ 하위로 이관하여 모든 project가 동일한 projects/<name>/{ROADMAP,ARCHITECTURE}.md + projects/<name>/milestones/ 구조를 갖도록 한다. ROADMAP scope misclassification을 디렉토리 위치로 물리적 차단하고, 재발 방지 smoke를 동반한다.",
  "motivation": "현재 ~/harness-meta/ROADMAP.md (meta scope) 안에 v1.1_upbit-cross-ref-cleanup (upbit project milestone)이 잘못 등록된 사례 확인 — summary 자체에 'upbit repo 자체 milestone으로 진행'이라고 적혀있음에도 root에 위치. CLAUDE.md 컨벤션 (`projects/<name>/ROADMAP.md`)이 명시되어 있으나 자동 검증 부재로 silent 누출. 'meta'를 일반 project처럼 projects/meta/ 하위로 강등하면 디렉토리 위치 자체가 scope를 강제 → 컨벤션 의존도 소거 + 향후 N개 프로젝트 동형 확장 가능.",
  "success_criteria": [
    "projects/meta/ROADMAP.md 존재. 현재 root ROADMAP.md의 meta-scope milestone 5건 (v1.1_meta-as-project + v1.1_smoke-precommit-rewrite + v1.1_post-report-write-hook-update + v1.1_design-phases-execute-tracking-automation + v1.0_workflow-redesign) 전부 이관 (v1.1_upbit-cross-ref-cleanup 제외 — projects/upbit/ROADMAP.md로 이관).",
    "projects/meta/ARCHITECTURE.md 신규 작성 (meta 자체 long-lived 구조 참조).",
    "projects/meta/milestones/ 존재. 기존 root milestones/ 전체 (v1.0 + v1.84~v1.88 historical + 본 v1.1 milestone 포함) git mv로 이관 — git history 보존.",
    "root ROADMAP.md는 thin index — { projects: [{ name, roadmap_path }] } 구조만 유지. milestone 항목 0건.",
    "root CLAUDE.md @ROADMAP.md 디렉티브 정상 resolve (auto-load 동작 유지).",
    "/harness-meta meta / /harness-meta <name> 두 모드 모두 신규 경로 기준으로 정상 path resolution.",
    "v1.1_upbit-cross-ref-cleanup 항목이 meta ROADMAP에서 제거되고 projects/upbit/ROADMAP.md milestones[] 배열에 등록됨.",
    "scope-discipline smoke 신규 추가 — root ROADMAP.md 가 thin index 형식이 아닐 때 / projects/<name>/ROADMAP.md 외 위치에 milestone-like 객체 발견 시 실패.",
    "기존 pre-commit hook 회귀 0 — install.ps1 / verify.{ps1,sh} 무수정으로 통과.",
    "모든 cross-reference 갱신 (broken link 0): commands / hooks / smoke / install / docs/adr / 모듈 CLAUDE.md / projects/upbit/ROADMAP.md 의 ../../ROADMAP.md 참조 등."
  ],
  "out_of_scope": [
    "기존 disabled smoke 4종 (smoke-spec-verification / scope-contract / cross-ref / claude-md-drift) 본격 재작성 — 별도 milestone v1.1_smoke-precommit-rewrite. 본 milestone은 scope-discipline smoke 1건만 신규 추가.",
    "post-report-write.sh 패턴 갱신 — 별도 milestone v1.1_post-report-write-hook-update. 단, 본 milestone에서 path가 milestones/ → projects/meta/milestones/ 로 바뀌므로 hook 의 fingerprint 갱신은 동반 처리될 수 있음 (DESIGN에서 결정).",
    "DESIGN.phases auto-tracking 자동화 — 별도 milestone v1.1_design-phases-execute-tracking-automation.",
    "upbit repo 측 cross-ref 실제 정리 작업 — 본 milestone은 ROADMAP 항목 이관까지만, 실제 upbit repo 코드 수정은 upbit repo 본인 milestone (이관 후 trigger).",
    "projects/<other>/ 신규 프로젝트 도입 — 기존 upbit + 신규 meta 두 종만 다룸. 향후 N개 확장은 자연 follow-on.",
    "milestone 번호 namespace 분리 (e.g., meta-vM1.1 / upbit-vU1.1) — vX.Y 그대로 유지, scope는 projects/<name>/ 디렉토리 위치로 분리."
  ],
  "dependencies": {
    "blocked_by": ["v1.0_workflow-redesign (completed) — 7-stage MD+JSON 포맷 정착 후에만 가능"],
    "blocks": [
      "v1.1_smoke-precommit-rewrite — 신규 4종 smoke가 본 milestone에서 정한 projects/<name>/ 컨벤션 위에서 동작",
      "v1.1_post-report-write-hook-update — post-write hook 패턴이 신규 경로 (projects/meta/milestones/v.*/) 인식 필요"
    ]
  }
}
```

## 관련

- 활성 ROADMAP (이관 전): [`../../ROADMAP.md`](../../ROADMAP.md)
- 운영 가이드: [`../../CLAUDE.md`](../../CLAUDE.md)
- 워크플로우 진입점: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md)
- 기존 upbit project ROADMAP: [`../../projects/upbit/ROADMAP.md`](../../projects/upbit/ROADMAP.md) (참조 — 동형 대칭의 모델)
