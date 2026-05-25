# RESEARCH — v3.9 inactive-smoke-git-mv-checklist

```json
{
  "external": [
    {
      "source": "v3.8 REPORT.lessons_learned L1",
      "topic": "smoke git mv 시 dirname 경로 갱신 단계 누락",
      "findings": "v3.6 #4 권고(inactive smoke 22건 git mv) 적용 시 `cd $(dirname \"$0\")/..` 경로 깊이 갱신이 누락 → v3.7/v3.8 두 milestone에서 버그 발견·수정 반복. L1 명시: '향후 smoke git mv 시 dirname 경로 일괄 갱신을 checklist에 포함 고려'.",
      "drift": "none — 사용자 직접 발의 아닌 L1 후속"
    }
  ],
  "codebase": {
    "affected_files": [
      "tests/CLAUDE.md — smoke 모듈 가이드 단일 source (git mv 체크리스트 추가 대상)"
    ],
    "untouched_files_explicit": [
      "tests/_inactive/ 22건 smoke 파일 — 내용 변경 없음",
      "tests/ active 7건 smoke 파일 — 내용 변경 없음",
      "claude/commands/harness-meta.md — workflow 정의 파일, 체크리스트 위치로 부적합 (tests 범위 아님)"
    ],
    "current_state": "tests/CLAUDE.md 안 'inactive smoke 경로 규약 (v3.8)' 1줄 주석이 유일한 관련 narrative. git mv 이후 수행해야 할 구체적 단계(경로 grep 검증, 깊이 계산 방법)는 부재.",
    "target_state": "tests/CLAUDE.md 에 smoke git mv 체크리스트 단락 추가. 최소 내용: (1) 이동 방향 별 경로 깊이 계산 규칙 (active↔inactive), (2) mv 후 dirname 경로 grep 검증 명령어 예시."
  },
  "options": [
    {
      "id": "A",
      "title": "기존 'inactive smoke 경로 규약' 주석 아래 체크리스트 인라인 확장",
      "pros": ["위치 근접 — 경로 규약과 체크리스트가 같은 섹션에 존재", "변경 최소 (1 위치)"],
      "cons": ["현행 hook 현황 표 아래 혼재 — 구조 상 '현황' 섹션과 무관한 체크리스트가 섞임"]
    },
    {
      "id": "B",
      "title": "회귀 검증 절차 섹션에 'smoke 파일 이동(git mv) 시 체크리스트' 독립 subsection 추가",
      "pros": ["회귀 검증 절차 = smoke 작업 절차 집합 → 논리적 위치 정합", "future extension 용이 (체크리스트 확장 시 독립 단락)"],
      "cons": ["1 파일 2 위치 참조 위험 — 경로 규약(현재 hook 섹션)과 체크리스트(회귀 검증 섹션)가 분산"]
    }
  ],
  "risks_identified": [
    "tests/CLAUDE.md 변경 시 smoke-claude-md-drift.sh 검증 대상 포함 — drift 없을 경우 PASS 유지",
    "체크리스트 내용이 지나치게 길어지면 § 6.2 lightweight 위반 — 3~5줄 cap 유지 필요"
  ]
}
```
