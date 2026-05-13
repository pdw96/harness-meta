# RESEARCH — v1.1_readme-cleanup

```json
{
  "id": "v1.1_readme-cleanup",
  "external": [
    {
      "source": "CLAUDE.md (root)",
      "topic": "현재 workflow",
      "findings": "7-stage workflow (ROADMAP → MILESTONE → PLAN → RESEARCH → DESIGN → EXECUTE → VERIFY → REPORT). /harness-meta 단일 slash command. 신규 프로젝트 도입 = 첫 milestone EXECUTE phase.",
      "drift": "README.md는 여전히 '10-stage workflow: plan → design → run → ship' 기술"
    },
    {
      "source": "projects/meta/ROADMAP.md",
      "topic": "ROADMAP summary",
      "findings": "v1.1_readme-cleanup summary에 'Activating a project / Bootstrap mode 안내 / 세션 산출물 phases/ 표기' + 'DECISIONS/INTERVIEW/STACK 5-doc 표기' 정리 대상으로 명시",
      "drift": "DECISIONS/INTERVIEW/STACK은 README 내 명시적 언급 없음 — Key docs 테이블과 Usage 섹션이 실질 stale 핵심"
    }
  ],
  "codebase": {
    "affected_files": ["README.md"],
    "untouched_files": [
      "CLAUDE.md", "AGENTS.md", "GUARDRAILS.md", "CHANGELOG.md",
      "projects/meta/ROADMAP.md", "projects/meta/ARCHITECTURE.md",
      "bootstrap/skills/**", "claude/**", "tests/**"
    ],
    "current_state": {
      "README_line6": "'10-stage workflow: plan → design → run → ship' — stale (현재 7-stage)",
      "README_lines29-68_install_stage2": "bootstrap/install-project-claude.ps1·sh 참조 — 파일 미존재",
      "README_line63_bootstrap_template": "bootstrap/templates/_base/.claude/ 14 files — bootstrap/templates/ 디렉토리 미존재",
      "README_line81_skills_doc": "bootstrap/docs/SKILLS.md 참조 — bootstrap/docs/ 디렉토리 미존재",
      "README_lines95-104_verify": "H/I checks: bootstrap/skeletons·templates·PERMISSION_PATTERN.md 참조 — 미존재",
      "README_lines141-165_dir_layout": "bootstrap/install-project-claude·manifest-schema·docs·templates 등 다수 미존재 항목",
      "README_lines169-200_activating": "Bootstrap mode 안내 + bootstrap/manifest-schema.md 참조 — 미존재",
      "README_lines204-215_usage": "/harness-plan·design·run·ship 명령 테이블 — 명령 파일 미존재 (claude/commands/harness-meta.md만 존재). sessions/ 경로 — milestones/ 로 교체됨",
      "README_lines220-228_language_overlay": "bootstrap/templates/·bootstrap/docs/OVERLAY.md 참조 — 미존재",
      "README_lines232-247_key_docs": "bootstrap/manifest-schema.md·docs/OWNERSHIP·OVERLAY·AGENTS_MD_STRATEGY 참조 — 미존재"
    },
    "target_state": {
      "README_line6": "7-stage workflow (ROADMAP→MILESTONE→PLAN→RESEARCH→DESIGN→EXECUTE→VERIFY→REPORT)",
      "install_section": "Global (Stage 1 install.ps1) + optional skills (install-skills.ps1) 만 유지. 미존재 Stage 2 bootstrap 절차 제거",
      "verify_section": "미존재 파일 참조 H/I 단계 설명 간소화 또는 제거",
      "dir_layout": "실제 존재하는 파일/디렉토리만 기재",
      "activating_section": "Bootstrap mode 제거 → /harness-meta <name> 신규 도입 절차로 교체",
      "usage_table": "/harness-meta 단일 행으로 축소, sessions/ → milestones/ 교체",
      "language_overlay_section": "bootstrap/templates 참조 제거. 현 구조에 맞게 축소 또는 제거",
      "key_docs_table": "미존재 파일 행 제거, 실존 파일만 유지"
    }
  },
  "options": [
    {
      "id": "A",
      "label": "최소 수정 — stale 참조만 제거·교체",
      "description": "명백히 stale인 참조(미존재 파일 링크, 구 명령 테이블, 구 workflow 표현)만 삭제·교체. 섹션 구조 유지.",
      "pros": ["범위 최소 — 리뷰 부담 낮음", "smoke 통과 확실"],
      "cons": ["README 섹션 구조가 구 시스템 기반이라 전체 가독성 여전히 낮음"]
    },
    {
      "id": "B",
      "label": "섹션 재작성 — 현 7-stage 기반 재구성",
      "description": "Installation·Usage·Key docs 섹션을 현 워크플로우 기준으로 재작성. 구 섹션(Bootstrap, Language overlay) 제거 또는 통합.",
      "pros": ["README가 현 워크플로우를 정확히 반영", "외부 방문자 혼동 최소화"],
      "cons": ["변경 범위 큼 — PLAN.out_of_scope(기능 추가 없이 정확성 회복)에 부합하나 review 부담"]
    }
  ],
  "risks_identified": [
    "markdownlint: 링크 제거 후 orphan heading 또는 마크다운 문법 오류 발생 가능",
    "smoke-projects-scope-discipline.sh: README 내 JSON 블록 편집 시 파싱 충돌 없는지 확인 필요 (README는 JSON 블록 없음 — 위험 낮음)",
    "GUARDRAILS.md·CHANGELOG.md는 실존하므로 Key docs 테이블에서 유지해야 함",
    ".github/workflows/ci.yml 참조는 실존 — 유지"
  ]
}
```
