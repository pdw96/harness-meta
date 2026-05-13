# REPORT — v3.6 overengineering-audit

```json
{
  "version": "v3.6",
  "id": "overengineering-audit",
  "summary": "사용자 직접 발의 (2026-05-11) — 외부 best practice (Martin Fowler / OpenAI / Anthropic / Pi) 비교 + 내부 정량 (18일간 24 milestone 중 9건 workflow self-improvement, pending 4/6 narrative 강화, narrative ÷ 코드 변경 5~9x, 외부 프로젝트 적용 0건) 진단 결과 명확한 오버엔지니어링 + 자기참조 사이클 진입 확인. lightweight 모드 (v2.0_workflow-word-fidelity 자기참조 회피 표지 선례) 적용 + 권고 7건 중 즉시 적용 가능한 4건 (#1/#4/#6/#7) lightweight remediation 실행. 권고 #2 (9-stage trim) / #3 (5 관점 trim) / #5 (4 era forward migration) 은 workflow self-improvement 자체로 사이클 재진입 risk → PROPOSE evidence-base trigger candidate 거명만 (release train 거부, ARCHITECTURE.md § 6.2 정합). 3 phase / 2 commit (phase-1 4ef8a74 / phase-2 9ba1eb1 / phase-3 + Stage G+H+I 통합 commit pending) 진행, pre-commit 14 hook 모두 PASS, 회귀 0. 본 milestone 자체가 lightweight 모드 첫 도입 사례 — § 6.2 신설 milestone.",
  "delta": {
    "files_changed": 26,
    "files_added": 8,
    "files_renamed": 22,
    "files_deleted": 0,
    "modules_affected": [
      "projects/meta/ROADMAP.md (defer + 신 entry)",
      "projects/meta/ARCHITECTURE.md (§ 6.2 신설)",
      "projects/meta/milestones/v3.6/ (신규 디렉토리 + 9 산출물)",
      "tests/_inactive/ (신규 디렉토리)",
      "tests/ (22 smoke git mv)",
      "tests/CLAUDE.md (매트릭스 갱신)"
    ],
    "commits": ["4ef8a74 (phase-1)", "9ba1eb1 (phase-2)"]
  },
  "lessons_learned": [
    {
      "id": "L1",
      "topic": "Lightweight 모드 자기참조 회피 표지 정합",
      "narrative": "본 milestone 이 진단 + remediation 자체 → 9-stage rigid 적용 시 narrative 5~9x overhead 재연 위험. v2.0 선례 (chicken-and-egg 회피) 직접 적용 + ARCHITECTURE § 6.2 신설로 정전화. 결과: 산출물 총 LOC < 850줄 cap 정합, 5 관점 subagent 검토 생략 + 의견 충돌 0. lightweight 정신 + audit trail 둘 다 보존 가능 입증."
    },
    {
      "id": "L2",
      "topic": "Smoke 'manual leverage' narrative 정전화 — archive 격리",
      "narrative": "v3.5 이전 'inactive 22 manual leverage' narrative 가 실 검증 부재 변명 — phase-2 archive 격리 (`tests/_inactive/`) 로 정전화. active 7 (pre-commit 강제) vs archive 22 (디렉토리 분리 + git history 보존, manual 호출 가능) 명료 책임 분리. release train 거부 + evidence-base 승격 trigger 정책 ARCHITECTURE § 6.2 직접 매핑."
    },
    {
      "id": "L3",
      "topic": "smoke-claude-md-drift Stage S4 phrasing 의무 — '현 N 파일' 패턴 보존",
      "narrative": "phase-2 archive 갱신 시 tests/CLAUDE.md 헤더 '현 29 파일' → 첫 시도 '현 7 active + 22 archive' 변경이 smoke-claude-md-drift Stage S4 정규식 (현 N 파일 + 실제 tests/ 안 .sh 카운트 비교) FAIL trigger. '현 7 파일 active + archive 22' 로 phrasing 재조정으로 PASS. lightweight 정신상 smoke 변경 회피 + narrative 자체 정합 회귀. drift smoke 의 정규식 strict 함이 narrative 유연성 제약 — 향후 narrative 강화 시 pattern 의존성 사전 확인 의무."
    },
    {
      "id": "L4",
      "topic": "claude/commands/harness-meta.md 변경 회피 = 자기참조 사이클 탈출 핵심",
      "narrative": "D4 결정 — 권고 #6 (narrative cap 정책 명문화) 위치 = ARCHITECTURE.md § 6.2 (정의 단일 source), 절대로 claude/commands/harness-meta.md (workflow 절차) 변경 회피. 본 변경이 자기참조 사이클의 가장 직접적 trigger (v2.0/v3.4/v3.5 모두 workflow 절차 narrative 강화). 정의 단일 source 안 정책 명시는 workflow 절차 변경과 본질 다름 — '정의' 진화 vs '절차' 진화."
    }
  ]
}
```

## 비고

본 REPORT.md 56줄 (cap < 100줄 정합). next_candidates (forward) 는 PROPOSE.md 분리 — REPORT 는 backward 종합만.
