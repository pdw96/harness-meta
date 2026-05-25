# EXECUTE phase-2 — v1.4_cross-ref-propagation

```json
{
  "phase": 2,
  "title": "docs/ARCHITECTURE.md 폐기 + cascade 정리 (6곳) + § 3.5 단일 source list 갱신",
  "status": "complete",
  "commit": "f1a2b6f",
  "scope_from_design": "책임 중복 host 폐기 cleanup — docs/ARCHITECTURE.md git rm + ROADMAP.md L43 cross-ref 줄 제거 + projects/meta/ARCHITECTURE.md 5곳 (L5 / L46 / L76 / L102 / L112) docs/ARCH 거명 제거 + § 3.5 list 갱신 (docs/ARCH 제거 + projects/meta/CLAUDE.md 추가, 결과 5곳)",
  "affected_files": [
    "docs/ARCHITECTURE.md",
    "ROADMAP.md",
    "projects/meta/ARCHITECTURE.md",
    "docs/adr/README.md",
    "projects/meta/milestones/v1.4_cross-ref-propagation/execute/phase-2.md"
  ],
  "research_gap_finding": "RESEARCH cascade list 6곳 (docs/ARCHITECTURE.md + ROADMAP.md L43 + projects/meta/ARCHITECTURE.md L5/L46/L76/L102/L112) 외 docs/adr/README.md L34 'aux 아키텍처 개요: ../ARCHITECTURE.md' 1줄 누락 — phase-2 commit 시 smoke-cross-ref.sh 의 autofix wrapper 가 자동 검출 + --fix 1행 삭제. 회귀 risk agent 사전 예측 (smoke-cross-ref HIGH risk) 정확. cascade 7곳 으로 갱신.",
  "changes": [
    {
      "file": "docs/ARCHITECTURE.md",
      "action": "git rm — file deletion",
      "rationale": "projects/meta/ARCHITECTURE.md 와 책임 중복 (글로벌 시스템 도식 = projects/meta/ARCHITECTURE § 1 디렉토리 트리 흡수). 4-tier sessions/<target>/, bootstrap/templates/_base/, bootstrap/docs/, bootstrap/render-manifest.sh, bootstrap/detect-project.sh — 모두 부재 디렉토리/파일 거명. v1.1_meta-as-project 후 사실상 유령 문서."
    },
    {
      "file": "ROADMAP.md (root)",
      "edit": "L43 '글로벌 시스템 도식: docs/ARCHITECTURE.md' 줄 제거",
      "action": "delete 1 line"
    },
    {
      "file": "projects/meta/ARCHITECTURE.md",
      "edits": [
        {
          "anchor": "L5",
          "action": "remove 'docs/ARCHITECTURE.md' 거명 from 인용 줄",
          "rationale": "글로벌 시스템 도식 책임은 § 1 디렉토리 트리 흡수 (architecture R11 mitigation)"
        },
        {
          "anchor": "L46 (§ 2 모듈 책임 표 row)",
          "action": "delete 1 row (docs/ARCHITECTURE.md row)",
          "rationale": "table 6행 → 5행, markdownlint 점검 의무"
        },
        {
          "anchor": "L76 (§ 3.5 단일 source list)",
          "action": "remove 'docs/ARCHITECTURE.md' + add 'projects/meta/CLAUDE.md'",
          "new_state": "5 docs cross-ref host: root CLAUDE.md / AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md",
          "rationale": "DESIGN.decisions[3] — § 3.5 list = metadata, body 갱신 X. R8 mitigation."
        },
        {
          "anchor": "L102 (§ 6 변경 시 주의)",
          "action": "remove 'docs/ARCHITECTURE.md' from list",
          "rationale": "폐기 후 동기 검토 대상 부재"
        },
        {
          "anchor": "L112 (§ 7 관련 문서)",
          "action": "remove '글로벌 시스템 도식: docs/ARCHITECTURE.md' line",
          "rationale": "관련 문서 list 정리"
        }
      ]
    }
  ],
  "expected_commit_message": "feat(meta): v1.4 phase-2 — docs/ARCHITECTURE.md 폐기 + cascade 6곳 정리 + § 3.5 list 갱신",
  "verification_post_commit": [
    "test ! -f docs/ARCHITECTURE.md → 파일 부재 확인",
    "grep -r 'docs/ARCHITECTURE' --exclude-dir=projects/meta/milestones --exclude-dir=.git . → 0 hits (live deps)",
    "grep -c 'projects/meta/CLAUDE.md' projects/meta/ARCHITECTURE.md → § 3.5 list 안에 신규 거명 1+ 확인",
    "smoke pre-commit hook PASS"
  ],
  "execution_notes": "docs/ARCHITECTURE.md git rm + cascade 7곳 정리 (RESEARCH cascade list 6곳 + smoke-cross-ref autofix 자동 검출 1곳 = docs/adr/README.md L34). § 3.5 단일 source list 갱신 (5곳: root CLAUDE.md / AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md). 회귀 risk agent HIGH risk 사전 예측 정확 — smoke 가 RESEARCH 누락 자동 보정. .bak 백업 정리. pre-commit smoke 5건 모두 PASS, commit f1a2b6f, 6 files changed."
}
```

## 진행

phase-2 = docs/ARCHITECTURE.md 폐기 cascade. 변경 파일 3건 (deletion 1 + 2 host edits). § 3.5 list 갱신이 phase-3 GUARDRAILS rewrite 의 prerequisite (DESIGN.decisions[1] 정합).
