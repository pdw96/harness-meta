# upbit v1.2-python-overlay-apply — PLAN

세션 시작: 2026-04-28
선행 세션 (meta): [`sessions/meta/v1.11b-overlay-python-skill/`](../../meta/v1.11b-overlay-python-skill/PLAN.md) — harness-python overlay 실 콘텐츠 확정 (T4 분리)

목적: `harness-python` skill을 upbit `.claude/skills/`에 실 배포. `install-project-claude.sh --force` 재실행으로 Python overlay Phase 2 적용.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/upbit/`

**근거**:

- 변경 파일: S6(1) `upbit/.claude/skills/harness-python/` 배포
- **T4 후행** — 선행 meta 세션(v1.11b)이 스펙 정의, 본 세션이 upbit에 값 적용
- **T3** — 검증 대상이 upbit `.claude/` → upbit 소속

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.11b-overlay-python-skill/REPORT.md` 후속 분기 표** (verbatim):

> `| sessions/upbit/v1.x-python-overlay-apply/ | upbit install-project-claude --force 재실행 → harness-python 실배포 (T4 후행) |`

**Parsed sub-items (1)**:

1. **`install-project-claude.sh --force` 재실행** → upbit `.claude/skills/harness-python/` 배포

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| upbit `.harness.toml` v1.0→v1.1 upgrade | `sessions/upbit/v1.x-manifest-upgrade/` (별 세션) |
| `harness-python` skill 실 동작 검증 (poetry run mypy 등) | upbit 실행 환경 별도 (본 세션은 설치만) |
| 다른 _base skill 내용 갱신 | 해당 시점 별 세션 |

## 1. 현재 상태

- upbit `.claude/skills/`: harness / harness-design / harness-plan / harness-review / harness-run / harness-ship (6건, _base only)
- `harness-python/` 미존재
- `.harness.toml`: `language = "python"`, `package_manager = "poetry"`

## 2. 실행 절차

```bash
bash ~/harness-meta/bootstrap/install-project-claude.sh ~/upbit --force
```

**예상 동작**:

- Phase 1: 기존 6 skill backup → _base 재복사
- Phase 2: `language = "python"` 감지 → `python/.claude/skills/harness-python/` 복사

**검증 (install 후)**:

```bash
ls ~/upbit/.claude/skills/harness-python/
# → SKILL.md  python-quality.md
```

## 3. 성공 기준

- [ ] `install-project-claude.sh --force` exit 0
- [ ] `upbit/.claude/skills/harness-python/SKILL.md` 존재
- [ ] `upbit/.claude/skills/harness-python/python-quality.md` 존재
- [ ] 기존 6 skill 정상 유지 (회귀 0)
