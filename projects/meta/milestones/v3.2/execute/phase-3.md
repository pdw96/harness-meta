# execute/phase-3 — tests/CLAUDE.md § Skeleton 선택 매트릭스 2 row 추가

```json
{
  "phase": 3,
  "title": "tests/CLAUDE.md § Skeleton 선택 매트릭스 — 책임 분리 row + status 기반 분기 row",
  "status": "complete",
  "affected_files": [
    "tests/CLAUDE.md",
    "projects/meta/milestones/v3.2/execute/phase-3.md"
  ],
  "execution_notes": "Skeleton 선택 매트릭스 테이블 끝에 2 row 추가: (1) era 분류 vs entry schema 책임 분리 (L3 D16, detect_era 미호출 원칙) / (2) status 기반 검증 분기 (L9, pending 시 milestones_path 부재 허용). identifier 모두 backtick escape (MD049 준수). 두 row 모두 v3.1 lessons 직접 cross-ref."
}
```
