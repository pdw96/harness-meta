# RESEARCH — v3.16 changelog-unreleased-position-cleanup

```json
{
  "external": [
    {
      "source": "Keep a Changelog v1.1.0 (https://keepachangelog.com/en/1.1.0/)",
      "topic": "[Unreleased] 섹션 권장 위치",
      "findings": "Keep a Changelog 권장: '[Unreleased] 섹션은 파일 상단에 위치하여 아직 릴리즈되지 않은 변경사항을 추적'. 현행 CHANGELOG.md는 [v2.0] (L174) 다음 [Unreleased] (L190) 위치 — 권장 위반.",
      "drift": "현 위치 L190, 권장 위치는 헤더(L1~L8) 바로 다음"
    }
  ],
  "codebase": {
    "affected_files": ["CHANGELOG.md"],
    "untouched_files_explicit": [
      "projects/meta/ROADMAP.md (OPEN step 6 신규 entry 외 변경 없음)",
      "projects/meta/milestones/v3.16/milestones.md (milestone 산출물 전용)",
      "claude/commands/harness-meta.md (workflow 미변경)",
      "tests/ (smoke / hook 미변경)"
    ],
    "current_state": {
      "unreleased_section_line": 190,
      "unreleased_section_after": "[v2.0] entry (L174)",
      "unreleased_items": [
        ".github/workflows/ci.yml — smoke tests (13 files) auto-run on push and pull_request",
        ".pre-commit-config.yaml + .markdownlint.json + .markdownlintignore — shellcheck + markdownlint enforcement",
        "GUARDRAILS.md — meta-repo session behavior guardrails",
        ".env.example — HARNESS_META_ROOT environment variable reference",
        "CHANGELOG.md — this file"
      ],
      "v3_15_entry_present": false,
      "total_lines": 302
    },
    "target_state": {
      "unreleased_section_line": "9 (헤더 L1~L8 직후, [v3.16] 또는 [v3.15] 바로 위)",
      "unreleased_items_disposition": "v1.0~v1.4 entry 흡수 또는 [Unreleased] 유지 (사용자 결정)",
      "v3_15_entry_added": true
    }
  },
  "options": [
    {
      "id": "A",
      "description": "[Unreleased] 섹션을 최상단으로 이동 (5 항목 내용 유지) + [v3.15] entry 추가",
      "pros": ["최소 변경", "5 항목 attribution 결정 생략", "1 pass 완결"],
      "cons": ["[Unreleased] 내 5 항목이 실제로는 v1.x era 완료 기능임에도 'unreleased' 레이블 유지 (의미 모호)", "독자 혼란 유지"]
    },
    {
      "id": "B",
      "description": "[Unreleased] 5 항목을 v1.0–v1.4 entry에 흡수 + [Unreleased] 빈 섹션 최상단 유지 + [v3.15] entry 추가",
      "pros": ["Keep a Changelog 정합 (위치 + 내용 모두)", "독자 혼란 완전 제거", "v1.0–v1.4 entry 기록 보완"],
      "cons": ["sub-decision (항목별 귀속 버전 결정) 필요", "약간 더 복잡"]
    },
    {
      "id": "C",
      "description": "[Unreleased] 섹션 완전 제거 + 5 항목 v1.x 적절한 entry 흡수 + [v3.15] entry 추가",
      "pros": ["가장 깔끔"],
      "cons": ["Keep a Changelog 권장 [Unreleased] 섹션 유지 원칙 위배 가능성 (빈 섹션이라도 유지 권장)"]
    }
  ],
  "risks_identified": [
    "option B sub-decision: [Unreleased] 5 항목의 정확한 귀속 버전 결정 필요. v1.0~v1.4 era에 해당하므로 v1.0–v1.4 entry에 Added 흡수가 가장 안전.",
    "v3.15 entry 내용 작성: v3.15_changelog-v3-backfill 완료 기록 — REPORT.md 참조 필요.",
    "markdownlint 회귀: 섹션 이동 중 blank line / heading level 위반 주의 (v3.1 L1 함정 선례)."
  ]
}
```
