# DESIGN — v1.1_readme-cleanup

```json
{
  "id": "v1.1_readme-cleanup",
  "decisions": [
    {
      "decision": "Option B — 섹션 재작성 (최소 수정이 아닌 구조 교체)",
      "rationale": "3 관점 subagent 모두 Option B 권장. architecture 검토: '10-stage 시대에 설계된 섹션 배치를 그대로 두면 stale 참조 제거 후에도 섹션 간 논리 흐름이 어색하게 남는다'. scope contract: criteria 7(독자 혼동 없이 기술)은 Option A로 달성 불가. spec-drift: 3건 모두 교체 표현 확인됨.",
      "alternatives_rejected": [
        "Option A(최소 수정): stale 참조 제거 후 섹션 공백·논리 단절이 남아 criteria 7 미충족"
      ]
    },
    {
      "decision": "2-phase 분할: Phase 1 = 제거, Phase 2 = 교체·재작성",
      "rationale": "architecture 검토 권고. Phase 1은 확실한 삭제(미존재 파일 링크·구 명령·sessions/ 경로)이고 Phase 2는 새 섹션 작성으로 책임 분리. 각 phase 후 markdownlint 검증.",
      "alternatives_rejected": [
        "단일 phase: 제거+재작성 혼재 시 review 복잡도 증가"
      ]
    },
    {
      "decision": "Language overlay 섹션 전체 제거 (bootstrap/templates 미존재 확인)",
      "rationale": "bootstrap/templates/ 디렉토리가 실제 repo에 없음(Glob 확인). 기능 자체가 현 repo 구조에 없으므로 섹션 삭제가 맞음. 향후 재도입 시 별도 milestone.",
      "alternatives_rejected": [
        "경로만 수정: 지칭할 실제 디렉토리가 없어 불가"
      ]
    }
  ],
  "approach": "README.md 단일 파일을 2-phase로 편집. Phase 1: 미존재 파일 참조·구 slash command·sessions/ 경로·Bootstrap mode·Language overlay 섹션 제거. Phase 2: 헤더 tagline을 7-stage로 교체, Activating a project 섹션을 /harness-meta 기반 신규 프로젝트 도입으로 재작성, Usage 테이블을 /harness-meta 단일 행으로 교체, Key docs 테이블에서 미존재 파일 행 제거. 각 phase = 1 commit.",
  "phases": [
    {
      "n": 1,
      "title": "stale 참조 제거",
      "scope": "README.md에서 확실히 제거할 항목 삭제. 미존재 파일 링크·구 slash command 테이블·sessions/ 경로·Stage 2 bootstrap 설치 절차·Language overlay 섹션·Key docs 미존재 행.",
      "affected_files": ["README.md", "projects/meta/milestones/v1.1_readme-cleanup/execute/phase-1.md"],
      "target_lines": {
        "line6_workflow": "'10-stage workflow' 표현 제거 (Phase 2에서 7-stage로 교체)",
        "lines29-68_stage2_install": "Stage 2 — Per-project 섹션 전체 제거 (bootstrap/install-project-claude.{ps1,sh} 미존재)",
        "line81_skills_doc": "bootstrap/docs/SKILLS.md 링크 제거 (디렉토리 미존재)",
        "lines100-104_HI_checks": "H/I 단계 설명 중 미존재 파일 참조 문장 제거",
        "lines141-165_dir_layout": "bootstrap/install-project-claude·manifest-schema·docs·templates 항목 제거",
        "lines169-200_activating": "Bootstrap mode 문단 + bootstrap/manifest-schema.md 링크 제거",
        "lines204-215_usage_table": "/harness-plan·design·run·ship 3행 제거, sessions/ → milestones/ 교체",
        "lines220-228_language_overlay": "Language overlay 섹션 전체 제거",
        "key_docs_stale_rows": "bootstrap/manifest-schema·OWNERSHIP·OVERLAY·AGENTS_MD_STRATEGY 행 제거"
      },
      "rationale": "제거 대상이 명확(파일 미존재 확인됨)하여 판단 부담 없음. 재작성보다 제거를 먼저 분리해 diff를 명확하게 유지.",
      "risks": ["markdownlint: 제거 후 orphan heading 또는 table 행 수 불일치 가능 — commit 전 pre-commit 실행으로 확인"]
    },
    {
      "n": 2,
      "title": "7-stage 기반 재작성",
      "scope": "헤더 tagline 교체, Activating a project 섹션 재작성, Usage 테이블 /harness-meta 단일 행으로 교체.",
      "affected_files": ["README.md", "projects/meta/milestones/v1.1_readme-cleanup/execute/phase-2.md"],
      "target_content": {
        "line6_tagline": "Harness wraps Claude Code sessions into a **7-stage workflow**: ROADMAP → MILESTONE → PLAN → RESEARCH → DESIGN → EXECUTE → VERIFY → REPORT. A per-project `.harness.toml` manifest activates the workflow.",
        "activating_section": "toml 필드는 유지, Bootstrap mode 문단을 '/harness-meta <name> — .harness.toml 부재 시 신규 프로젝트 도입 흐름 진입' 설명으로 교체",
        "usage_table": "| Command | Purpose | — /harness-meta | meta 또는 per-project harness milestone 7-stage workflow 진입 | — 산출물 경로: projects/{meta or <name>}/milestones/v{X.Y}_{slug}/"
      },
      "rationale": "spec-drift agent가 제공한 교체 표현을 그대로 활용. CLAUDE.md 정합 보장.",
      "risks": ["표현 과도 확장 방지: PLAN.out_of_scope(기능 추가 없이 정확성 회복만) 엄수"]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "markdownlint: orphan heading 또는 table 오류",
      "mitigation": "각 phase commit 전 pre-commit run --all-files 실행. 오류 발견 시 즉시 수정 후 재커밋."
    },
    {
      "risk": "Phase 2 표현 scope creep",
      "mitigation": "PLAN.out_of_scope 준수 — 문서 정확성 회복만. 새 기능 설명·섹션 추가 금지."
    }
  ],
  "approval": {
    "approved_by": "user",
    "date": "2026-05-08"
  }
}
```
