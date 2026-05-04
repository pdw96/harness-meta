# meta v1.36d-skill-resync — REPORT

세션 완료: 2026-04-30

## 최종 결과

- 수정 파일: 1 (`install-skills.ps1`)
- 신규 symlink: 5 (`~/.claude/skills/` — 4개 갱신 + 1개 신규)
- 발견된 버그: 1 (`Resolve-SkillName` 파라미터명 `$Input` PowerShell 자동변수 충돌)

## 구현 요약

### 목표 1: install-skills.ps1 --all 재실행 ✅

실행 전 상태:

- `~/.claude/skills/` 4개 symlink가 old 1단계 경로(`bootstrap/skills/<name>/`) 가리킴 (broken)
- `harness-roadmap-update` 미설치

실행 중 버그 발견: `Resolve-SkillName` 함수의 `param([string]$Input)` 파라미터명이 PowerShell 자동변수 `$input` (pipeline input enumerator)과 충돌 → 파라미터 값이 항상 빈 문자열로 들어와 regex 실패.

**Fix**: `$Input` → `$SkillInput` rename (`install-skills.ps1:135,138,139,144,145,147,157,159,165,172`).

재실행 결과:

```
[OK] audit/ai-ready-scorer: symlinked → bootstrap/skills/audit/ai-ready-scorer
[OK] audit/harness-plan-verify: symlinked → bootstrap/skills/audit/harness-plan-verify
[OK] audit/harness-roadmap-update: symlinked → bootstrap/skills/audit/harness-roadmap-update (신규)
[OK] dev-tools/developer-profile: symlinked → bootstrap/skills/dev-tools/developer-profile
[OK] dev-tools/mindvault: symlinked → bootstrap/skills/dev-tools/mindvault
```

### 목표 2: symlink 5개 유효성 검증 ✅

모든 symlink가 2단계 경로 가리키며 SKILL.md 접근 가능 확인.

## 판정

- [x] `install-skills.ps1 --all` 실행 완료
- [x] `~/.claude/skills/` 5개 symlink 유효 (4개 갱신 + 1개 신규)
- [x] 각 symlink target이 2단계 경로 가리킴
- [x] **부수 픽스**: `$Input` → `$SkillInput` 파라미터명 충돌 해소 (v1.36 `-All` 기능 실질적 복구)

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 외부 spec 의존 무 (install-skills 재실행 + PS 자동변수 버그 픽스만) |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — PowerShell 자동변수 `$input` 충돌**: `param([string]$Input)` 파라미터명이 PowerShell 자동변수 `$input` (case-insensitive)과 충돌 → 값이 항상 빈 문자열. `$SkillInput` 등 중립 이름으로 회피. Reserved 자동변수 목록 주의: `$input`, `$_`, `$args`, `$true`, `$false`, `$null`, `$PSItem` 등.
- **L2 — v1.36 출시 때 install-skills 재실행 누락**: 2단계 구조 이전 후 배포 단계 확인 필요. 향후 2단계 변경 시 smoke-skills-install.sh에 설치 후 symlink 2단계 경로 정합 검증 추가 검토 (evidence-driven).

## 다음 후보

- **v1.36b-postoolse-roadmap-hook** — 본 세션 차단 해제됨. PostToolUse hook 구현 착수 가능.
- **v1.36d2-smoke-skills-install-path-check** (evidence-driven) — smoke-skills-install.sh에 symlink target이 2단계 경로인지 검증 추가. 현 시점 한 번 발생 → evidence 1건.
