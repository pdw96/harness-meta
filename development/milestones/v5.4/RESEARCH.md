---
id: milestone-v5.4-research
title: RESEARCH v5.4
version: v5.4
stage: RESEARCH
status: completed
---

# RESEARCH — v5.4 marketplace-json-github-source

## Spec

```json
{
  "external": [
    {
      "source": "context7 /websites/code_claude — plugin-marketplaces",
      "topic": "marketplace.json source 필드 허용 형태 — Git repository vs URL-based 구분",
      "findings": [
        "Git repository marketplace (GitHub shorthand 또는 local path 클론): plugin entry source = relative path ('source': './') 가 spec-correct 형태. 'For local sources, specify the relative path in the source field.'",
        "URL-based marketplace (https://example.com/marketplace.json 다운로드 방식): plugin entry에 relative path 사용 시 'path not found' 오류 — external source object 필요. 'For remote sources, use an object with source: github and the repo name.'",
        "GitHub source object 형태: { 'source': 'github', 'repo': 'owner/repo' } — URL-based marketplace에서 외부 plugin 참조 시 사용. Git repository marketplace에서는 해당 없음",
        "settings.json allowedMarketplaceSources의 { 'source': 'github', 'repo': '...' } 는 marketplace 등록 권한 설정 — plugin entry source 필드와 별개 개념",
        "harness-meta는 Git repository marketplace만 지원 (GitHub shorthand + local 양쪽). URL-based marketplace로 배포 계획 없음"
      ],
      "drift": "v5.3 RESEARCH 추정 정확. './' 가 Git repository marketplace에서 spec-correct 형태임을 context7 명시 확인 — GitHub source 객체 전환은 spec 기준으로 불필요 (오히려 오적용)"
    }
  ],
  "codebase": {
    "affected_files": [
      ".claude-plugin/marketplace.json — source 필드 현행 './' 유지 결정 (변경 없음)"
    ],
    "untouched_files": [
      "plugin.json — 무관",
      "README/AGENTS/CLAUDE.md cascade — source 필드 변경 없으므로 무관"
    ],
    "current_state": "marketplace.json plugins[0].source = './' — Git repository marketplace spec-correct 형태",
    "target_state": "marketplace.json 무변경. CHANGELOG에 spec 검증 결정 1 entry 추가 + 본 milestone 산출물이 근거 문서화"
  },
  "options": [
    {
      "id": "A",
      "label": "현행 유지 + milestone 산출물 근거 문서화 (권장)",
      "description": "marketplace.json 무변경. CHANGELOG v5.4 entry로 source './' 현행 유지 — Git repo marketplace spec 검증 결과 1줄 추가. milestone 산출물이 정전 근거.",
      "pros": [
        "spec 정합 (Git repository marketplace에 './' 가 correct)",
        "불필요 변경 없음 (기능 동일, 오적용 risk 없음)",
        "1 phase 1 commit — Lightweight 모드"
      ],
      "cons": [
        "코드 변경 없음 (마일스톤 결과가 '유지'로 끝나는 특이 케이스)"
      ]
    },
    {
      "id": "B",
      "label": "GitHub source 객체로 전환",
      "description": "marketplace.json source 를 { 'source': 'github', 'repo': 'pdw96/harness-meta' } 로 교체",
      "pros": [
        "표면적으로 더 명시적"
      ],
      "cons": [
        "spec 오적용 — GitHub source 객체는 URL-based marketplace 전용",
        "Git repository marketplace에서 동작 보장 없음 (spec 근거 없음)",
        "기능 regression 위험"
      ]
    }
  ],
  "risks_identified": [
    "R1: Option B 적용 시 Git repository marketplace에서 plugin 인식 오류 가능성 (spec 외 적용)",
    "R2: milestone 결과가 '변경 없음'으로 귀결 — 사용자 기대와 다를 수 있음 (명시적 설명 필요)"
  ]
}
```
