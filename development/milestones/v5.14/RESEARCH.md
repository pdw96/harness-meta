---
id: v5.14
title: RESEARCH v5.14
version: v5.14
stage: RESEARCH
status: completed
---

# RESEARCH — v5.14 external-audit-team-cycle-3-call

## Spec

```json
{
  "external": [
    {
      "source": "v5.13 3-layer fact 검증 절차 (ARCHITECTURE § 4 끝 + agents/project-harness-audit-team/CLAUDE.md Note + claude/commands/harness-meta.md --audit step)",
      "topic": "fact 검증 절차 실전 적용 준비",
      "findings": "3-layer 완성 (WHAT 정의 → WHERE orchestration → HOW workflow step). --audit 분기 안 proposal-draft 생성 직후 synthesizer가 4 산출물 안 fact 인용(boolean/수치/파일명/표) 직접 매핑 검증 의무 step 존재. cycle 3 = 절차 첫 실전 적용 기회.",
      "drift": "없음 — v5.13 바로 다음 milestone"
    },
    {
      "source": "v5.10 audit-2026-05-18/ (scanner-output.md / analyzer-output.md / mapper-output.md / proposal-draft.md)",
      "topic": "cycle 2 audit 결과 — diff 기준선",
      "findings": "4 산출물 기준: N4 gap(hooks/mcpServers 미선언) + claude_md_in_repo hallucination(v5.11 정정) + plugin version 1.0.0. v1.18 이후 N4 완전 해소.",
      "drift": "현재 upbit 상태와 v5.10 기준선 주요 delta — (1) plugin.json hooks + mcpServers 신설 (v1.18) / (2) .claude/hooks/ → .claude-plugin/hooks/ git rename / (3) .mcp.json 삭제 / (4) plugin version 1.0.0 → 1.1.0 / (5) CLAUDE.md 실존 (hallucination 정정)"
    }
  ],
  "codebase": {
    "affected_files": [
      "projects/upbit/audit-2026-05-18/{scanner,analyzer,mapper,proposal-draft}-output.md (diff 기준선 read-only)",
      "projects/meta/milestones/v5.14/{INTENT,RESEARCH,DESIGN,APPROVE,VERIFY,REPORT,PROPOSE}.md + execute/ + milestones.md (신규 산출물)"
    ],
    "untouched_files": [
      "upbit repo 소스 파일 (read-only scan 대상 — audit-team이 scan, 수정 없음)",
      "projects/meta/milestones/_archive/ (historical 보존)"
    ],
    "current_state": {
      "upbit_plugin_version": "1.1.0",
      "upbit_plugin_hooks": "선언됨 (PreToolUse Bash/Write + PostToolUse Edit|Write|MultiEdit)",
      "upbit_plugin_mcp_servers": "선언됨 (harness, type:stdio, poetry)",
      "upbit_claude_md_in_repo": true,
      "upbit_agents_count": 6,
      "upbit_skills_count": 7,
      "last_audit_date": "2026-05-18 (v5.10 / cycle 2)",
      "last_commit_since_audit": "8c3ad01 (v1.18 artifacts)"
    },
    "target_state": {
      "cycle_3_audit_complete": true,
      "fact_verification_procedure_first_applied": true,
      "ecosystem_integrator_vector_count": 3,
      "v5_10_diff_produced": true
    }
  },
  "options": [
    {
      "id": "A",
      "title": "4 멤버 전체 audit chain (v5.10 동일 scope)",
      "description": "project-scanner → harness-gap-analyzer → claude-docs-mapper → component-proposer 순차 호출. v5.13 fact 검증 절차 적용. v5.10 audit과 동일 4 멤버 — installer 제외 (사용자 결정 게이트 후 별도).",
      "pros": [
        "ecosystem integrator vector 완전 evidence",
        "v5.10 4 파일 1:1 diff 가능",
        "proposer 산출물 = 사용자 결정 게이트 입력 직접 생성"
      ],
      "cons": [
        "proposer hallucination 위험 (cycle 4 가능성)",
        "4 멤버 순차 시간 소요"
      ]
    },
    {
      "id": "B",
      "title": "2 멤버 경량 (scanner + gap-analyzer only)",
      "description": "scanner + gap-analyzer 2 멤버만 — v5.10 대비 delta 빠른 파악. docs-mapper + proposer 제외.",
      "pros": [
        "빠른 delta 확인",
        "hallucination 위험 감소"
      ],
      "cons": [
        "proposer 산출물 없음 → 사용자 결정 게이트 입력 미생성",
        "ecosystem integrator vector 완전 evidence 미달",
        "v5.10 1:1 diff 불가 (4→2 파일)"
      ]
    }
  ],
  "risks_identified": [
    {
      "risk": "proposer hallucination cycle 4 — v5.10 cycle 2 proposer 12 항목 표 hallucination 선례",
      "likelihood": "medium",
      "mitigation": "v5.13 fact 검증 절차 실전 적용 (synthesizer가 4 산출물 fact 직접 매핑 검증)"
    },
    {
      "risk": "scanner claude_md_in_repo false 재발 — v5.11에서 정정된 hallucination 유형",
      "likelihood": "medium",
      "mitigation": "synthesizer가 scanner 산출물 안 boolean 필드 직접 read-only 검증"
    },
    {
      "risk": "v5.10 → v5.14 delta 너무 작아 유효한 gap 미발견",
      "likelihood": "low",
      "mitigation": "v1.18 이후 변경분 외 upbit 코드베이스 자체 진화(테스트 수 등)도 scanner가 신규 스캔"
    }
  ]
}
```
