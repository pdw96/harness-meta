# meta v1.36d-skill-resync — PLAN

세션 시작: 2026-04-30
직접 선행 세션: [`sessions/meta/v1.36-roadmap-unification-and-flow/`](../v1.36-roadmap-unification-and-flow/PLAN.md) — skills 1단계 → 2단계 카테고리 이관 (audit/ + dev-tools/)

목적: v1.36에서 `install-skills.{ps1,sh}` 재실행 누락으로 `~/.claude/skills/` 4개 symlink가 1단계 old path를 가리킴 (broken). `install-skills.ps1 --all` 재실행으로 5개 skill symlink 정상화 + `harness-roadmap-update` 신규 install.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1c(0) 코드 변경 없음. 글로벌 user-skill symlink 운영 정정 (install-skills 재실행) → S1c + S3 범주
- **T3 검증 대상 기준** — 검증·정정 대상이 S1c 글로벌 user-skill → meta 소유
- **T5 애매하면 meta** — 운영 정정 그 자체는 코드 변경 0, 문서(PLAN+REPORT)가 전부

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.36b-postoolse-roadmap-hook/PLAN.md` Out of scope 표** (verbatim):

> `v1.36 install-skills 재실행 누락 정정 | v1.36 REPORT에 절차 누락 기록 추가 | 별 후속 v1.36d-skill-resync로 분리 (본 v1.36b 진행 중 발견)`

**Parsed sub-items (2)**:

1. **install-skills --all 재실행** — `~/.claude/skills/` 4개 broken symlink 갱신 + `harness-roadmap-update` 신규 install (5개 total)
2. **v1.36 REPORT addendum** — 절차 누락 기록 (필요 시)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| install-skills.sh (macOS/Linux) 동작 검증 | 사용자 macOS 기기 없음 — 별 후속 |
| verify.ps1 Stage K — skill symlink 2단계 경로 정합 | evidence-driven (별 후속) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (install-skills 재실행 운영 정정만) |
| **re-verify** | N/A |

## 1. 배경

v1.36에서 `bootstrap/skills/` 구조를 1단계 (`<name>/`) → 2단계 (`<category>/<name>/`) 로 이전했으나, 세션 완료 후 `install-skills.ps1 --all` 재실행을 누락했다.

**현 broken 상태**:

- `~/.claude/skills/ai-ready-scorer` → `bootstrap/skills/ai-ready-scorer` (경로 없음)
- `~/.claude/skills/harness-plan-verify` → `bootstrap/skills/harness-plan-verify` (경로 없음)
- `~/.claude/skills/developer-profile` → `bootstrap/skills/developer-profile` (경로 없음)
- `~/.claude/skills/mindvault` → `bootstrap/skills/mindvault` (경로 없음)
- `harness-roadmap-update` — 아예 미설치

## 2. 목표

- [ ] `install-skills.ps1 --all` 실행
- [ ] `~/.claude/skills/` 5개 symlink 확인 (4개 갱신 + 1개 신규)
- [ ] REPORT.md 작성

## 3. 성공 기준

- [ ] `~/.claude/skills/{ai-ready-scorer,harness-plan-verify,harness-roadmap-update,developer-profile,mindvault}` 5개 symlink 유효
- [ ] 각 symlink target이 2단계 경로(`bootstrap/skills/{audit,dev-tools}/<name>/`) 를 가리킴
