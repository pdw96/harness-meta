# DESIGN — v3.16 changelog-unreleased-position-cleanup

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "Option B 채택 — [Unreleased] 5 항목 v1.0~v1.4 entry 흡수 + 빈 [Unreleased] 최상단 유지",
      "rationale": "사용자 명시 선택 (Stage B AskUserQuestion). 위치 + 내용 모두 Keep a Changelog 정합. 독자 혼란 완전 제거.",
      "alternatives_rejected": ["Option A (내용 유지 위치만 이동) — 의미 모호 유지", "Option C (섹션 완전 제거) — 빈 섹션 유지 Keep a Changelog 권장 위반 가능"]
    },
    {
      "id": "D2",
      "decision": "[Unreleased] 5 항목 귀속 — v1.0~v1.4 entry Added 섹션에 일괄 흡수",
      "rationale": "5 항목 (CI / pre-commit / GUARDRAILS / .env.example / CHANGELOG) 모두 초기 infra 작업 — v1.0~v1.4 era (2026-04 early) 에 해당. 개별 버전 특정보다 v1.0–v1.4 묶음 entry 흡수가 attribution 안전성 보장.",
      "alternatives_rejected": ["개별 버전 귀속 — 각 파일별 git log 확인 필요, 본 scope 초과"]
    },
    {
      "id": "D3",
      "decision": "[v3.15] entry 추가 — CHANGELOG.md v3.0~v3.14 backfill 완료 기록",
      "rationale": "v3.15_changelog-v3-backfill 완료 후 CHANGELOG.md 안에 [v3.15] entry 가 없는 상태 — 외부 visible artifact 누락. 본 milestone scope 내 추가 적합.",
      "alternatives_rejected": []
    },
    {
      "id": "D4",
      "decision": "lightweight 모드 적용 — 5 관점 subagent 검토 생략",
      "rationale": "§ 6.2 trigger 3건 충족: (1) narrative cleanup 본질 (CHANGELOG.md 정합화) (2) workflow / hook 미영향 (단일 파일) (3) 충돌 부재 예상 (명확한 이동 작업). 누적 6건째 (v3.11~v3.15 선례).",
      "alternatives_rejected": ["3 관점 검토 — 충돌 부재 확실, 생략 정당"]
    },
    {
      "id": "D5",
      "decision": "[v3.16] entry Stage G commit 안 추가 (자기참조 도그푸드)",
      "rationale": "본 milestone v3.16 자체를 CHANGELOG.md 에 기록하는 자기참조 — Stage G commit (산출물 포함) 이후 final 변경으로 추가. phase-1 commit 에는 포함하지 않음.",
      "alternatives_rejected": []
    }
  ],
  "approach": "[Unreleased] 섹션을 Keep a Changelog 권장 위치(헤더 직후)로 이동 + 5 항목 v1.0~v1.4 흡수 + [v3.15] entry 추가. lightweight 단일 phase 1 commit. Stage G commit 안 [v3.16] entry 자기참조 추가.",
  "phases": [
    {
      "n": 1,
      "title": "CHANGELOG.md 정합화 — [Unreleased] 위치 수정 + 5 항목 귀속 + [v3.15] entry 추가",
      "scope": "CHANGELOG.md 단일 파일 수정: (a) [v3.15] entry 삽입 (헤더 직후, [v3.14] 위), (b) [Unreleased] 빈 섹션 최상단 이동 ([v3.15] 위), (c) 구 [Unreleased] 위치 L190 5 항목 제거, (d) v1.0~v1.4 entry Added 섹션에 5 항목 흡수",
      "affected_files": ["CHANGELOG.md", "execute/phase-1.md"],
      "rationale": "단일 파일 단일 commit — 최소 변경 단위. [v3.16] entry 는 Stage G commit 안 추가 (자기참조 도그푸드).",
      "risks": ["markdownlint blank line 규칙 위반 주의", "5 항목 v1.0~v1.4 위치 정확한 삽입 위치 확인"]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "markdownlint blank line / heading 위반",
      "mitigation": "각 섹션 이동 후 blank line 확보 검증. pre-commit hook 자동 검출."
    },
    {
      "risk": "[Unreleased] 내 항목 v1.0~v1.4 이전 위치 삽입 오류",
      "mitigation": "CHANGELOG.md L296–L302 (v1.0–v1.4 entry) 확인 후 Added 섹션 신규 또는 기존 위치 다음에 추가."
    }
  ],
  "self_reference_policy": "avoid — lightweight 모드 적용, 5 관점 subagent 검토 생략. workflow 정의 narrative 자기참조 없음."
}
```

## Stage D 완료 직전 milestones.md 동기 갱신 (v3.5 의무)

phases[] 확정 후 milestones.md sub_milestones 1:1 갱신:

- phase-1: "CHANGELOG.md 정합화 — [Unreleased] 위치 수정 + 5 항목 귀속 + [v3.15] entry 추가"

→ milestones.md 갱신 대상.
