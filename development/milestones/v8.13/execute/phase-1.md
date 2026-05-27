---
phase: phase-1
milestone: v8.13
status: completed
---

# v8.13 phase-1 — stale 문서 정합 + 트랙별 archival trigger 명문화

## Spec

```json
{
  "phase": "phase-1",
  "status": "completed",
  "scope": "operational 현재-지침 stale ('archival = CHANGELOG.md') 를 'v6.20+ GitHub Releases 단일 source' 로 정합 + 트랙별 archival trigger (9-stage PROPOSE / 가벼운 흐름 ## 기록) 명문화. historical 기술 서술(ARCHITECTURE 156/166/179/191/288/306/313/369) 무손상.",
  "changes": [
    {
      "type": "edit",
      "path": "CLAUDE.md",
      "description": "line 34 (ROADMAP 입력 행) + line 68 (schema A2 설명) 의 'archival = CHANGELOG.md' → GitHub Releases (v6.19+ 단일 source, 두 트랙 발행, CHANGELOG v6.19 까지 historical)."
    },
    {
      "type": "edit",
      "path": "development/ARCHITECTURE.md",
      "description": "4곳 — (110) Trace 5요소 row: past archival = GitHub Releases + 3중 archival 재정의(REPORT/LIGHTWEIGHT ## 기록 + git + GitHub Release) / (219) schema A2 entry: archival target GitHub Releases + smoke 신설 거명 / (371) § 7.4 '## 기록 trace 편입': '자동 인식 안 함→CHANGELOG 수동' stale 를 '두 트랙 발행(LIGHTWEIGHT fallback)' 으로 + 트랙별 trigger paragraph 신설 / (199) #13 cascade host paragraph: v8.13 보강 3항(LIGHTWEIGHT 분기 + smoke + 트랙 trigger) 추가. historical(156/166/179) 무손상."
    },
    {
      "type": "edit",
      "path": "development/ROADMAP.md",
      "description": "schema_note(line 7) 2곳 ('archival = CHANGELOG' + 'trace 3중=CHANGELOG entry') + 의도 섹션(182~186 archival target + trace 3중 목록) + 비고(203 끝 절 'past trace=CHANGELOG 위임') → GitHub Releases 정합. 156-style historical 무손상."
    },
    {
      "type": "edit",
      "path": "skills/stage-report/SKILL.md",
      "description": "archival 실행 stage 의 1차 checklist 재작성 — line 12(단어 책임) + 29(작성 항목) + § 3 archival 절차 블록(68~81: CHANGELOG entry 추가 → GitHub Release 발행 + publish-then-trim + 트랙별 trigger 인용) + 관련 링크(release-publish.yml 추가, CHANGELOG=historical 표기)."
    },
    {
      "type": "edit",
      "path": "skills/stage-open/SKILL.md",
      "description": "line 113 archival 안내 → REPORT(9-stage)/## 기록(가벼운 흐름) 시점 + GitHub Release 발행+trim 정합."
    },
    {
      "type": "edit",
      "path": "claude/hooks/post-report-write.sh",
      "description": "line 178 PROPOSE case 메시지 archival cycle → GitHub Release 발행 후 trim (CHANGELOG v6.19 까지 historical)."
    }
  ],
  "verification": [
    {
      "method": "manual",
      "result": "PASS",
      "detail": "grep 'CHANGELOG.md 이전|archival = CHANGELOG|CHANGELOG.md entry' operational 잔존 0 — 3 매치(ARCHITECTURE 156 / ROADMAP 18 milestone summary / ROADMAP 203은 정합 완료)는 historical 서술 또는 milestone 자체 문제서술로 분류. ROADMAP:18 의 '6건'은 phase-4 에서 10건 정정 예정."
    },
    {
      "method": "smoke",
      "result": "PASS",
      "detail": "smoke-spec-verification PASS + smoke-cross-ref 13/13 PASS + smoke-claude-md-drift 13/13 PASS."
    }
  ],
  "commit": {
    "sha": "pending",
    "message": "docs(meta): [v8.13] phase-1 archival 보존 target stale 정합 + 트랙별 trigger 명문화"
  }
}
```

## Narrative

phase-1 은 RESEARCH d_2/d_7 기반 stale 정합 — design-review spec-drift 흡수로 초안 4곳에서 stage-report/stage-open SKILL + ROADMAP 의도/비고 까지 확장됐다. 핵심 host 는 stage-report SKILL § 3 archival 절차 (실제 archival 실행 checklist 라 'CHANGELOG entry 추가' → 'GitHub Release 발행 + publish-then-trim' 으로 절차 자체 재작성) + ARCHITECTURE § 7.4 line 371 ('가벼운 흐름 ## 기록 자동 인식 안 함 → CHANGELOG 수동 1줄' stale 가 d_3 적용 후 거짓이 되므로 '두 트랙 발행' 으로 정합 + 트랙별 trigger paragraph 신설).

cascade host = ARCHITECTURE § 4 끝 #13 row paragraph (line 199) — historical 서술(v6.19 migration)은 보존하고 끝에 v8.13 보강 3항(LIGHTWEIGHT 분기 + recent-3 smoke + 트랙 trigger)만 append (DESIGN narrative 의 historical/operational 경계 정합). historical 기술 서술(156 v5.21 drift 해소 사례 / 166 #13 row / 179 drift 해소 paragraph)은 무손상 — 변경 시 v5.21/v6.19 의 실제 역사가 거짓이 되기 때문.

verification — operational stale grep 0 확인 (잔존 3 매치는 historical 또는 milestone 자체 problem 서술). smoke 3종 전부 PASS. ROADMAP:18 milestone summary 의 'v8.7~v8.12 (6건)' 은 RESEARCH ext_2 가 10건으로 정정했으므로 phase-4 trim 시 함께 갱신 예정 (현재는 OPEN-time 진단 보존).
