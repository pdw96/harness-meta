# execute/phase-1 — v3.5 open-stage-discipline-strengthening

```json
{
  "phase": 1,
  "title": "cascade 검증 smoke 도입 — `tests/smoke-open-stage-discipline.sh` 신규 + pre-commit hook 등록 + tests/CLAUDE.md 매트릭스 갱신",
  "status": "complete",
  "scope": "신규 smoke 1건 작성 + pre-commit hook 1건 등록 (smoke-bundle-trigger 직후, --fix 미지원 direct entry) + smoke 매트릭스 narrative 갱신 (헤더 카운트 28→29, '핵심 정책 검증' 표 1 row 추가, '현행 hook 현황' 헤더 milestone 거명 + 6→7 갱신, 표 1 row 추가, 'inactive 22' active 카운트 6→7 갱신).",
  "affected_files": [
    "tests/smoke-open-stage-discipline.sh",
    ".pre-commit-config.yaml",
    "tests/CLAUDE.md",
    "projects/meta/milestones/v3.5/execute/phase-1.md"
  ],
  "changes": [
    {
      "file": "tests/smoke-open-stage-discipline.sh",
      "section": "전체 (신규)",
      "type": "add",
      "description": "신규 smoke 작성. python3 부재 시 SKIP. cp949 boilerplate 적용 (D7). projects/<name>/milestones/ 순회 후 디렉토리 명 ^v\\d+\\.\\d+$ 매칭 시 milestones.md 페어링 검증. _era_detect.py:27 표지와 1:1 정합 (D3). historical 디렉토리 (밑줄 포함) 자연 skip (D6 forward-only)."
    },
    {
      "file": ".pre-commit-config.yaml",
      "section": "smoke-bundle-trigger hook 직후",
      "type": "add",
      "description": "ACTIVE block 1건 추가 — id: smoke-open-stage-discipline. entry: direct (bash tests/smoke-open-stage-discipline.sh, --fix 미지원, D5). files 패턴: 'projects/[^/]+/milestones/v[0-9]+\\.[0-9]+/.*\\.md$|\\.pre-commit-config\\.yaml$' (D4 — v[0-9]+\\.[0-9]+ D6 정규식과 1:1 정합 + 자기참조 검증 위해 pre-commit-config 자체 패턴 포함). pass_filenames: false."
    },
    {
      "file": "tests/CLAUDE.md",
      "section": "5개 위치",
      "type": "modify",
      "description": "(1) § 'smoke 매트릭스' 헤더: '현 28 파일' → '현 29 파일'. (2) § narrative 1차 source: '5 active' → '7 active' (v3.1 + v3.5 누적). (3) § '핵심 정책 검증' 표 smoke-bundle-trigger row 직후 smoke-open-stage-discipline row 추가 (검증 책임 / `_era_detect:27` 1:1 정합 / bundle-trigger 책임 직교 / v3.5 phase-1 신규 narrative). (4) § '현행 hook 현황' 헤더: 'v1.1 + v3.1 phase-3' → 'v1.1 + v3.1 phase-3 + v3.5 phase-1' + '5 hook (v1.1) + 1 hook (v3.1) + 1 hook (v3.5). 총 7 hook active'. (5) § '현행 hook 현황' 표 smoke-bundle-trigger row 직후 smoke-open-stage-discipline row 추가 (active v3.5, direct, files 패턴 D4). (6) § 'inactive 22 의 회귀 차단 책임' narrative: '위 6 active 외 22 smoke' → '위 7 active 외 22 smoke'."
    }
  ],
  "commit": "35c621c",
  "execution_notes": "smoke 단독 PASS — 9-stage-bundled checked=6 (v3.0~v3.5 모두 milestones.md 보유, 자기참조 도그푸드 정합), historical skipped=18 (밑줄 포함 디렉토리 forward-only). pre-commit 전체 14 hook (5 base + shellcheck + markdownlint + 7 active local) 모두 PASS, 회귀 0. INTENT/RESEARCH/DESIGN/APPROVE.md + milestones.md + ROADMAP entry 갱신은 D10 (b) 권장 패턴에 따라 Stage G (VERIFY) commit 안 포함 — phase-1 commit 에는 smoke 신규 + pre-commit 등록 + tests/CLAUDE.md 매트릭스 + 본 phase-1.md 4 파일만 포함."
}
```

## narrative

phase-1 단일 phase = 단일 commit. 변경 4 파일 (smoke 신규 + pre-commit 등록 + CLAUDE.md 매트릭스 + 본 phase-1.md) 은 cascade 검증 smoke 도입 의 단일 책임 단위 — 분리 시 중간 상태 (smoke 파일만 있고 hook 등록 부재 / hook 등록 있는데 매트릭스 narrative 부재) narrative 모순 → 단일 phase 통합 의무.

자기참조 도그푸드: 본 phase-1 commit 시점에 신규 smoke 가 처음 실행 — v3.5/milestones.md 이미 OPEN step 7 에서 작성됨 → 자기 smoke PASS 확정 (R6 mitigation 정합).
