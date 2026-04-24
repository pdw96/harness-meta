# meta v1.9c-docs-ps-home-path-fix — REPORT

세션 기간: 2026-04-25 (단일 세션)
세션 범위: `pwsh ~/harness-meta/` → `pwsh $HOME/harness-meta/` 활성 문서 치환
판정: **PASS** (활성 문서 pwsh ~/harness-meta 0건)

**세션 소속 (self-apply)**: `sessions/meta/`. S2/S3 → meta.

## 최종 결과

- **수정 5 파일**: `README.md`, `CLAUDE.md`, `bootstrap/templates/_base/README.md`, `bootstrap/docs/AGENTS_MD_STRATEGY.md`, `bootstrap/install-project-claude.ps1` (EXAMPLE 주석)
- 치환 건수: **10 occurrences** (pwsh + ~/upbit EXAMPLE 1건 포함)
- 세션 기록 파일들: **수정 안 함** (이력 보존)
- 세션 기록 2: PLAN + 본 REPORT

## 검증

```bash
grep -rn 'pwsh ~/harness-meta' <활성 문서>  → 0건
grep -rn 'pwsh ~/harness-meta' sessions/    → 이력 그대로 (수정 안 됨)
```

## Grey Area 결정 사후

| ID | 결정 | 구현 |
|----|------|------|
| G1 | 세션 기록 유지 | ✅ sessions/ 수정 0 |
| G2 | bash `~` 유지 | ✅ bash 예시 건드리지 않음 |
| G3 | 일반 경로 설명 유지 | ✅ `~/.claude/hooks/...` 등 skip |
| G4 | `$HOME` 표기 | ✅ |
| G5 | 범용 작동 (bash+PS) | ✅ |

## Lessons Learned

1. **PowerShell `~` 미확장의 일반성**: bash/zsh는 `~` 자동 확장하지만 PS는 **외부 명령 인자 내**에서 확장 안 함. cross-platform 문서는 `$HOME` 권장. 향후 모든 PS 예시에 동일 원칙 적용.

2. **이력 보존 vs 일관성의 타협**: 과거 세션 기록(v1.8, v1.8b 등)에 `pwsh ~/harness-meta/` 남음. 사용자가 과거 REPORT 참조 시 헷갈릴 수 있으나, **이력 불변 원칙**이 우선. README + 현 문서만 정확하면 OK.

3. **install-project-claude.ps1 내부 `.EXAMPLE` 주석도 치환**: PS Get-Help로 노출되는 문서화라 중요. `-ProjectRoot ~/upbit`도 `$HOME/upbit`로 통일.

## 커밋 계획

```
docs(meta): sessions/meta/v1.9c-docs-ps-home-path-fix — pwsh ~ → $HOME 치환

- update: README.md (4), CLAUDE.md (3), _base/README.md (1),
          AGENTS_MD_STRATEGY.md (1), install-project-claude.ps1 EXAMPLE (2)
- keep: sessions/** (이력 보존)
- add: sessions/meta/v1.9c-docs-ps-home-path-fix/{PLAN,REPORT}.md

PowerShell은 외부 명령 인자 내 ~ 미확장 → Windows 사용자 UX 이슈.
$HOME은 bash+PS 둘 다 작동 (범용).
```

## 후속

- v1.10-bootstrap-interview (로드맵 순차, **PC 재시작 후 진행 예정**)
