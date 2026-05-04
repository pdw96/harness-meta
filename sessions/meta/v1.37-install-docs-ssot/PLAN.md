# meta v1.37-install-docs-ssot — PLAN

세션 시작: 2026-04-30
직접 선행 세션:

- [`sessions/meta/v1.36e-install-sessionstart-idempotent/`](../v1.36e-install-sessionstart-idempotent/) — install.ps1 SessionStart/statusLine idempotent no-op 구현 + CLAUDE.md 갱신
- [`sessions/meta/v1.36b2-install-ps1-force-docs/`](../v1.36b2-install-ps1-force-docs/) — install.ps1 정기 재실행 -Force 명시 세션 (v1.36e로 번복)

목적: 충돌 정책 3곳(install.ps1 헤더 / README.md / CLAUDE.md) 중 v1.36e로 CLAUDE.md만 정확하게 갱신됨 → install.ps1 헤더 + README.md 2곳의 stale 내용을 수정하여 CLAUDE.md를 단일 소스로 수렴.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S3(1) `install.ps1` + S3(1) `README.md` = 2/2 meta
- **T1 경로 다수결** — S3 × 2 = meta 100%

## Scope inheritance (verbatim from ROADMAP §3-E)

**Source — `sessions/meta/ROADMAP.md` §"Out of scope (trigger 대기)" §3-E 표** (verbatim):

> `v1.36b2b-install-docs-ssot-convergence` | 충돌 정책 3곳 (install.ps1 헤더 + README + CLAUDE) drift evidence 누적. install.ps1 헤더 → README/CLAUDE link 1줄로 수렴 | `v1.36b2 REPORT L3`

**Parsed sub-items (2)**:

1. **install.ps1 헤더 충돌 정책 1줄 수렴** — 현재 3줄 블록 (line 16-19) 중 line 18 "(정기 재실행 시 -Force 필수)" 가 v1.36e 이후 stale. 3줄 → 1줄로 압축 + idempotent 반영 + CLAUDE.md 상세 링크.
2. **README.md reinstall note fix** — line 47 "subsequent runs abort without `-Force`" → idempotent 정확 반영

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| CLAUDE.md 변경 | 불필요 — v1.36e에서 이미 정확하게 갱신됨 |
| install.sh (macOS/Linux) 신설 | v1.21-cross-platform-install (별 도메인) |
| README.md Stage 2 Force reinstall note (line 65) | 이미 정확 ("Force reinstall" 명시 → 의도적 -Force 사용 케이스) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 docs 정확성 수정 + SSOT 수렴만) |
| **re-verify** | N/A |

## 배경

v1.36b2 (`2026-04-30`)에서 "install.ps1 정기 재실행 -Force 필수" 를 3 파일에 명시했으나,
v1.36e (`2026-04-30`)에서 SessionStart/statusLine을 idempotent로 구현하면서 CLAUDE.md만 갱신됨:

| 파일 | 현재 내용 | 정확성 |
|------|---------|--------|
| `install.ps1:18` | "(정기 재실행 시 -Force 필수)" | ❌ stale |
| `README.md:47` | "subsequent runs abort without `-Force`" | ❌ stale |
| `CLAUDE.md:55` | "정기 재실행 시 `-Force` 불필요" | ✅ 정확 |

ROADMAP §3-E에서 이 drift를 trigger E (정규화 우선순위 미달) 로 기록했으며, 사용자가 본 세션에서 진행하기로 결정.

## 목표

- [ ] `install.ps1` 헤더 충돌 정책 블록 (line 16-19) → 1줄로 압축 + idempotent 반영
- [ ] `README.md` line 47 reinstall note → idempotent 반영
- [ ] smoke 실행 — 기존 smoke 회귀 0 확인

## 변경 대상

| 파일 | scope | 변경 내용 |
|------|------|---------|
| `install.ps1` | S3 | 헤더 충돌 정책 3줄 → 1줄 (idempotent 반영 + CLAUDE.md 참조) |
| `README.md` | S3 | line 47 reinstall note 내용 수정 |

## 구체적 변경 내용

### install.ps1 (lines 16-19)

**Before**:

```
    충돌 정책:
      - ~/.claude/ 하위에 같은 이름 파일·링크가 이미 있으면 기본은 중단 + 경고
      - settings.json hooks.SessionStart / statusLine / PostToolUse[Edit|Write] 충돌도 동일 (정기 재실행 시 -Force 필수)
      - -Force 지정 시 ~/.claude/backup-<timestamp>/에 이동 후 덮어쓰기
```

**After**:

```
    충돌 정책: 파일·링크 충돌 시 중단 + 경고 (-Force로 ~/.claude/backup-<ts>/ 백업 후 덮어쓰기). settings.json은 idempotent (v1.36e). 상세: CLAUDE.md §명령어
```

### README.md (line 47)

**Before**:

```
> **Reinstall (after layer changes)**: `pwsh ./install.ps1 -Force` — `settings.json` `hooks.SessionStart` is registered on first install, so subsequent runs abort without `-Force`. Conflicting files back up to `~/.claude/backup-<ts>/`.
```

**After**:

```
> **Reinstall (after layer changes)**: `pwsh ./install.ps1` — `settings.json` hooks are idempotent (v1.36e); regular reinstalls work without `-Force`. Use `-Force` only when file symlinks conflict (backs up to `~/.claude/backup-<ts>/`).
```

## 성공 기준

- [ ] `install.ps1:18` 에 "정기 재실행 시 -Force 필수" 텍스트 없음
- [ ] `install.ps1` 충돌 정책 섹션이 1줄로 압축됨
- [ ] `README.md:47` 에 "subsequent runs abort without `-Force`" 텍스트 없음
- [ ] `README.md:47` 에 "idempotent" 반영됨
- [ ] `bash tests/smoke-bash-permission-pattern.sh` PASS (회귀 0)
- [ ] docs-only 변경 → 회귀 위험 최소

## 커밋 전략

```
docs(meta): install.ps1 + README — 충돌 정책 SSOT 수렴 (v1.36e idempotent 반영)

- install.ps1 헤더 충돌 정책 3줄 → 1줄 (settings.json idempotent v1.36e + CLAUDE.md 상세 링크)
- README.md reinstall note: "abort without -Force" → "idempotent (v1.36e), regular reinstall no -Force"
- CLAUDE.md는 이미 v1.36e에서 갱신됨 (단일 소스 역할 유지)
```

## 후속 세션 연결

본 세션 완료 후 ROADMAP §3-E `v1.36b2b` 항목 → §8 최근 완료로 이동.
