# execute/phase-1.md — v3.16 changelog-unreleased-position-cleanup

```json
{
  "phase": 1,
  "title": "CHANGELOG.md 정합화 — [Unreleased] 위치 수정 + 5 항목 귀속 + [v3.15] entry 추가",
  "status": "complete",
  "affected_files": ["CHANGELOG.md", "execute/phase-1.md"],
  "changes": [
    "CHANGELOG.md: [v3.15] entry 삽입 (헤더 직후, [v3.14] 위)",
    "CHANGELOG.md: [Unreleased] 빈 섹션으로 최상단 이동 ([v3.15] 위)",
    "CHANGELOG.md: 구 [Unreleased] 위치(L190) 5 항목 제거",
    "CHANGELOG.md: v1.0~v1.4 entry Added 섹션에 5 항목 흡수"
  ],
  "commit": "e9dffa1",
  "execution_notes": "CHANGELOG.md 수정 완료: [Unreleased] 빈 섹션 L9 최상단 이동 + [v3.15] entry 삽입 (L11) + 구 [Unreleased] 5 항목 v1.0~v1.4 흡수 + 구 [Unreleased] 섹션 제거. pre-commit 14 hook PASS, 회귀 0."
}
```
