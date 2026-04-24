# meta v1.9b-install-legacy-cleanup — REPORT

세션 기간: 2026-04-25 (단일 세션)
세션 범위: `install-project-claude.{ps1,sh}`에 legacy cleanup 로직 추가
판정: **PASS** (성공 기준 5/5, smoke 완벽)

**세션 소속 (self-apply)**: `sessions/meta/`. S2 단일 → meta.

## 최종 결과

- **수정 2**: `install-project-claude.ps1` + `.sh` — Step 2.5 cleanup 단계 추가
- **smoke**: legacy 3 + user-custom 1 + conflicts 1 혼재 시나리오 → **3 legacy backup + 1 user 보존 + 1 conflicts backup** 정확
- **세션 기록 3**: PLAN + 본 REPORT + evidence/smoke-legacy.txt

## Smoke 검증

```
pre state:
  commands/harness.md, harness-plan.md, harness-ship.md   ← legacy (_base 부재)
  commands/user-custom.md                                  ← 사용자 custom
  skills/harness-plan/SKILL.md                             ← conflict (_base 존재)

post state:
  backup-030446/commands/{harness,harness-plan,harness-ship}.md    ← legacy 3건 이동
  commands/user-custom.md                                          ← 보존 (harness prefix 아님)
  backup-030447/skills/harness-plan/SKILL.md                       ← conflicts 1건 이동
  skills/*, agents/*, output-styles/*                              ← _base에서 복사 (17 파일)

[WARN] legacy cleanup — 3건 backup
[WARN] 충돌 1건 backup
[OK]   완료 — 11 항목 복사
```

**검증 포인트**:
- ✅ legacy `harness*` 3 자동 감지 + backup
- ✅ `user-custom.md` 건드리지 않음 (harness* prefix 필터)
- ✅ conflicts(skills/harness-plan) 별도 backup + 새 파일 복사
- ✅ 최종 commands/ 디렉토리에 user-custom.md만 잔존 (우발적 삭제 0)

## 구현 요약

| # | 목표 | 결과 |
|---|------|------|
| 1 | PowerShell cleanup 로직 | ✅ 91-117 라인 |
| 2 | Bash cleanup 로직 | ✅ 73-105 라인 |
| 3 | smoke PASS | ✅ legacy + custom + conflicts 시나리오 |
| 4 | evidence | ✅ smoke-legacy.txt |
| 5 | Grey Area 10건 | ✅ PLAN G1~G10 |

## Grey Area 결정 반영

| ID | 결정 | 구현 |
|----|------|------|
| G1 | -Force 전용 | ✅ `if ($Force)` / `if [ "$FORCE" -eq 1 ]` |
| G2 | `harness*` prefix | ✅ Get-ChildItem -Filter 'harness*' / for d in dst/harness* |
| G3 | backup 디렉토리 공유 의도 | ⚠️ **실제로는 분리됨** — legacy와 conflicts가 각자 `$backupRoot`/`$backup_root` 지연 생성. 1초 차이로 backup 2개 생성. 기능 OK, UX는 개선 후보 |
| G4 | 빈 카테고리 rmdir 미수행 | ✅ (commands/ 디렉토리는 user-custom.md 있으니 남음. 실측 확인) |
| G5 | legacy 0건 시 silent | ✅ |
| G6 | -Force 없이 WARN | 미구현 — 현재 -Force 전용으로 제한. 추후 개선 후보 |
| G7 | _base agents/ 건재 | ✅ |
| G8 | 복사 전 cleanup | ✅ Step 2.5로 스캔(1) 뒤, 복사(4) 전 위치 |
| G9 | dry-run 모드 | v1.22+ |
| G10 | smoke 시나리오 | ✅ |

## Lessons Learned

1. **Legacy cleanup과 conflicts backup 디렉토리 분리**: 구현 상 `$backupRoot`가 legacy와 conflicts 각자 지연 생성 → 타임스탬프 다른 backup 2개. 기능적으로는 문제 없으나 사용자가 혼란 가능. 개선: 공유 변수로 묶거나 최소 1초 sleep 제거. **후속 minor fix 후보**.

2. **harness* prefix 필터의 이점**: 사용자가 `.claude/commands/my-custom.md` 같은 개인 명령을 두어도 건드리지 않음. v1.8 install.ps1의 glob 패턴(`harness-*` vs `harness*`)을 v1.6에서 `harness.md`(hyphen 없음) 누락 이슈 발견 → `harness*`로 통일. v1.9b도 동일 패턴 사용하여 일관.

3. **smoke 시나리오가 3 케이스 동시 커버**: legacy 3 + user custom 1 + conflicts 1 = 5 파일 혼재. 한 번 실행으로 3가지 동작(legacy backup / user 보존 / conflicts backup)을 모두 검증. 각 케이스 별도 smoke 필요 없음.

4. **v1.1 upbit 수동 작업의 자동화**: 본 세션 배포 후 upbit 같은 상황(commands stale + skills 업데이트) 자동 처리. 사용자가 `git rm` 6번 수동 실행할 필요 없음. 차기 adapter/template 세션에서 카테고리 변화 시 재발 방지.

## 커밋 계획

```
feat(meta): sessions/meta/v1.9b-install-legacy-cleanup — install-project-claude cleanup 로직 추가

- update: bootstrap/install-project-claude.ps1 — Step 2.5 cleanup (-Force 전용)
- update: bootstrap/install-project-claude.sh — 동일 로직
- add: sessions/meta/v1.9b-install-legacy-cleanup/{PLAN,REPORT,evidence/smoke-legacy.txt}

upbit v1.1-skills-migration 발견 결함 해결 — _base 부재 카테고리 harness-*
파일 자동 backup. user custom 파일(harness prefix 아님) 건드리지 않음.

Smoke PASS — legacy 3 backup + user 1 보존 + conflicts 1 backup 검증.
Grey Area 10건 결정.
```

## 후속

- 개선 후보: legacy backup과 conflicts backup 디렉토리 공유 변수 통일
- v1.10-bootstrap-interview (로드맵 순차)
