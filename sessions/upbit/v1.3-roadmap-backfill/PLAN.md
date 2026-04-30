# upbit v1.3-roadmap-backfill — PLAN

세션 시작: 2026-04-30
목적: `projects/upbit/ROADMAP.md` 소급 작성 — v1.36+ Bootstrap S6 신설 5번째 표준 파일(ROADMAP)을
기존 3 세션(v1.0/v1.1/v1.2) 이력 기반으로 채움.

선행 세션 (meta): [`sessions/meta/v1.36-roadmap-unification-and-flow/`](../../meta/v1.36-roadmap-unification-and-flow/) — ROADMAP 5번째 파일 체계 + skeleton 확정

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/upbit/`

**근거**:
- 변경 파일: S4 `~/harness-meta/projects/upbit/ROADMAP.md` — 프로젝트 아키텍처 문서
- **T1 경로 다수결** — 변경 파일 1건 전부 S4 (upbit) scope
- `bootstrap/skeletons/projects/ROADMAP.md.tmpl` (S2 skeleton)는 v1.36에서 기 완료 → 본 세션은 S4 값 적용만

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/ROADMAP.md` §3-F 표 (verbatim)**:

> `| v1.36c-legacy-project-roadmap-migration | A | 기존 프로젝트 (upbit 등) ROADMAP.md 소급 작성 evidence | v1.36 PLAN Out of scope |`

**Parsed sub-items (1)**:

1. **`projects/upbit/ROADMAP.md` 소급 작성** — v1.0~v1.2 완료 세션 이력 + Out of scope 항목 기반.
   `bootstrap/skeletons/projects/ROADMAP.md.tmpl` 템플릿 치환.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 다른 프로젝트 ROADMAP.md 소급 | 해당 프로젝트별 v1.x-roadmap-backfill 세션 (trigger A evidence 시) |
| upbit `.harness.toml` schema v1.1 upgrade | `v1.x-manifest-upgrade-1.1` (trigger E) |
| upbit statusline_cmd 풍부한 출력 복원 | `v1.x-statusline-cmd-migration` (trigger B) |
| harness-python 실 동작 검증 (upbit 세션) | 비즈니스 코드 영역 (S7) — /harness-plan 플로우 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 docs 작성만) |
| **re-verify** | N/A |

## 배경

v1.36에서 harness-meta Bootstrap S6가 5종 파일 (ARCHITECTURE/DECISIONS/INTERVIEW/STACK/**ROADMAP**) 생성 체계로 확장됐다.
`bootstrap/skeletons/projects/ROADMAP.md.tmpl` 템플릿도 v1.36에서 추가됐다.

그러나 v1.36 이전에 bootstrap된 기존 프로젝트(upbit)에는 `projects/upbit/ROADMAP.md`가 부재하다:
```
~/harness-meta/projects/upbit/
├── ARCHITECTURE.md  ✓
├── DECISIONS.md     ✓
├── INTERVIEW.md     ✓
└── STACK.md         ✓
   (ROADMAP.md 없음)
```

이 파일 부재로 harness-meta 8단계 흐름의 **단계 3 (ROADMAP 읽기)** + **단계 9 (ROADMAP 갱신)**이 upbit 세션에서 작동하지 않는다.

본 세션은 3건의 완료 upbit 세션(v1.0/v1.1/v1.2) 이력을 기반으로 소급 작성한다.

### upbit 완료 세션 이력 요약

| 세션 | 일자 | 요약 |
|------|------|------|
| v1.0-project-claude-install | 2026-04-25 | meta v1.8 BREAKING → upbit .claude/ 17파일 복구 (commands 6 + agents 4 + skills 6 + output-styles 1) |
| v1.1-skills-migration | 2026-04-25 | meta v1.8b commands→skills → .claude/commands/ 6 삭제 + skills 6 정리 + .claude/backup-*/ gitignore |
| v1.2-python-overlay-apply | 2026-04-28 | meta v1.11b Python overlay → harness-python skill + python-quality.md 배포 |

### upbit pending 이력

| 출처 | 항목 | 현황 |
|------|------|------|
| v1.0 REPORT "후속 세션 연결" | `v1.x-statusline-cmd-migration` — statusline 풍부한 출력 복원 | 미착수 (v1.1/v1.2가 다른 우선순위로 대체) |
| v1.0 REPORT "후속 세션 연결" | `v1.x-manifest-upgrade-1.1` — schema 1.1 선택 bump | 미착수 (선택 사항) |
| v1.2 REPORT "후속" | harness-python 실 동작 검증 | 사용자 manual (세션 불필요) |

## 목표

- [ ] `projects/upbit/ROADMAP.md` 신규 작성 (§6 최근 완료 3건 + §2 pending 항목)
- [ ] REPORT.md 작성
- [ ] harness-roadmap-update 호출 → meta ROADMAP §3-F 항목 archive

## 변경 대상

| 경로 | scope | 변경 |
|------|------|------|
| `projects/upbit/ROADMAP.md` | S4 | 신규 작성 |
| `sessions/upbit/v1.3-roadmap-backfill/PLAN.md` | S4 | 본 파일 |
| `sessions/upbit/v1.3-roadmap-backfill/REPORT.md` | S4 | 세션 종료 시 |

## 성공 기준

- [ ] `projects/upbit/ROADMAP.md` 존재
- [ ] §6 "최근 완료": v1.0 / v1.1 / v1.2 3건 정확히 기록
- [ ] §2 "Out of scope (trigger 대기)": pending 2건 (statusline / manifest-1.1) 분류 포함
- [ ] meta ROADMAP §3-F `v1.36c-legacy-project-roadmap-migration` 항목 archive

## 커밋 전략

```
docs(upbit): sessions/upbit/v1.3-roadmap-backfill — projects/upbit/ROADMAP.md 소급 작성

- add: projects/upbit/ROADMAP.md (v1.0~v1.2 이력 기반 소급)
- add: sessions/upbit/v1.3-roadmap-backfill/{PLAN,REPORT}.md

v1.36 Bootstrap S6 5종 파일 체계 소급 보완.
pending 2건 (statusline / manifest-1.1) §2 trigger 대기 이관.
```

## 후속 분기

| 후속 세션 | 조건 |
|---------|------|
| `v1.4-statusline-cmd-migration` | upbit statusline 풍부한 출력 복원 필요 시 (trigger B) |
| `v1.4-manifest-upgrade-1.1` | upbit .harness.toml schema 1.1 bump 필요 시 (trigger E) |
| 다른 프로젝트 ROADMAP 소급 | 신규 프로젝트 bootstrap 또는 요청 시 (trigger A) |
