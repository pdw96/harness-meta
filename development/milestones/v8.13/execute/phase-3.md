---
phase: phase-3
milestone: v8.13
status: completed
---

# v8.13 phase-3 — catch-up 발행 10건 (GitHub Releases)

## Spec

```json
{
  "phase": "phase-3",
  "status": "completed",
  "scope": "milestones[] completed 중 GitHub Release 누락 10건 (가벼운 흐름 6 + 9-stage 4) 을 workflow_dispatch 로 catch-up 발행 (d_4). outward-facing 배포 — 사용자 명시 게이트(d_8) 후 실행. repo 파일 변경 0 (별책 phase-3.md 제외).",
  "changes": [
    {
      "type": "create",
      "path": "GitHub Releases (외부 visible artifact)",
      "description": "10건 발행 — 가벼운 흐름 6건(v8.2/v8.3/v8.5/v8.7/v8.10/v8.12, LIGHTWEIGHT.md ## 기록 추출) + 9-stage 4건(v8.4/v8.8/v8.9/v8.11, MILESTONE.md ## REPORT 추출). 발행 방식 = gh workflow run release-publish.yml -f version=vX.Y -f dry_run=false."
    }
  ],
  "verification": [
    {
      "method": "manual",
      "result": "PASS",
      "detail": "(1) dry-run 선행 검증 — v8.12 lightweight dry_run=true run 26503049066 success, 실 CI 에서 track=lightweight 감지 + LIGHTWEIGHT.md locate + ## 기록 추출 + tag conflict 부재 PASS. (2) 10건 live dispatch 전부 success (run 26503110724~26503143933). (3) gh release list 대조 — milestones[] completed 16건(v6.23~v8.12) 전부 release 존재, 누락 0. (4) spot-check v8.12 — title='v8.12 — 정련된 영역 4...'(frontmatter fallback) + body=## 기록 섹션 정상."
    }
  ],
  "commit": {
    "sha": "pending",
    "message": "(phase-3 = outward 발행, repo 파일 변경 0 — 별책은 phase-4 와 함께 commit)"
  }
}
```

## Narrative

phase-3 은 RESEARCH ext_2 가 실측한 누락 10건을 catch-up 발행했다. d_8 게이트 정합 — outward-facing 배포라 사용자 명시 확인 후 실행 (dry-run 검증 → 10건 live 순). dry-run(v8.12 lightweight, run 26503049066)이 실 GitHub Actions 환경에서 phase-2 의 LIGHTWEIGHT.md fallback 을 end-to-end 검증 (track=lightweight 감지 → ## 기록 추출 → body 생성)한 뒤 10건 live dispatch.

10건 전부 success, gh release list 대조 누락 0 (sc_3 충족). 핵심 = 가벼운 흐름 6건이 phase-2 fallback 으로 처음 발행됨 — v8.1 두 트랙 공존 이후 구조적으로 발행 불가였던 격차 해소. risk_4(outward 무단 실행) mitigation = d_8 2중 게이트(APPROVE + 발행 직전 재확인) 실작동. tag conflict 0 (보안검토 disjoint 확인대로). repo 파일 변경 0 (발행은 외부 artifact) — 본 별책은 phase-4 trim/smoke 와 함께 commit.
