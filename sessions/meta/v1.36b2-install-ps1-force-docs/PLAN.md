# meta v1.36b2-install-ps1-force-docs — PLAN

세션 시작: 2026-04-30
직접 선행 세션:

- [`sessions/meta/v1.36b-postoolse-roadmap-hook/`](../v1.36b-postoolse-roadmap-hook/REPORT.md) — L3 "install.ps1 -Force 필요성" 발견 → 본 세션 trigger

목적: `install.ps1` 정기 재실행 시 `-Force` 필요성을 README.md + CLAUDE.md에 명시 문서화. 사용자가 "레이어 변경 후 재설치" 시 settings.json hooks.SessionStart 이미 등록 → abort 만나는 사례 차단.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S3(2) `README.md` + `CLAUDE.md` + S1a(1) `install.ps1` 헤더 코멘트 = **3/3 meta**
- **T1 경로 다수결** — S3 + S1a 모두 meta scope, 3/3
- **T2 스펙 vs 값** — 글로벌 install.ps1 사용 안내 = 모든 사용자 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.36b-postoolse-roadmap-hook/REPORT.md` Lessons Learned L3** (verbatim):

> **L3 — install.ps1 -Force 필요성** — 이미 올바른 SessionStart가 등록돼도 `-Force` 없으면 abort. 정기 재실행 용도로 `-Force` 단독 플래그 문서화 필요 (v1.36b2 후속 검토).

**Parsed sub-items (1)**:

1. **`-Force` 단독 플래그 문서화** — 정기 재실행 용도. README.md + CLAUDE.md 양쪽에 명시. 코드 수정 없음 (docs only)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `install.ps1` SessionStart 분기 idempotent no-op 추가 (PostToolUse 패턴 답습 — line 370-371) | `v1.36e-install-sessionstart-idempotent` (별 후속, evidence 누적 시) |
| `install.ps1` statusLine 분기 idempotent 검토 (line 302-313) | 동상 (위 후속과 묶기) |
| `install-skills.{ps1,sh}` `-Force` 미지원 정책 docs 보강 (현재 `--cleanup` opt-in으로만 backup 정리) | 별 후속 evidence-driven |
| `bootstrap/install-project-claude.{ps1,sh}` `-Force` 사용법 docs (이미 `bootstrap/docs/OVERLAY.md` §11에서 일부 다룸) | 별 후속 (필요 시) |
| `install.ps1` SYNOPSIS/DESCRIPTION 헤더 코멘트 갱신 | 본 세션 흡수 (1줄 추가, S3 동일 scope) |
| README.md `--force` (lowercase) 표기 정정 (line 63 "add `--force` / `-Force` flag") — install.ps1은 `-Force`만 지원, `--force`는 .sh 패턴 | 본 세션 흡수 (정합성) |
| sync-agents / install-skills 패턴과 통일된 "정기 재실행" 가이드 docs | 별 후속 (3 도구 통합 docs) |
| verify.ps1 Stage J PostToolUse 등록 검증 | `v1.36b5-posttooluse-verify-stage-j` (ROADMAP §3-B) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (SPEC_VERIFICATION.md §6-1 케이스 "내부 규약 보강" — install.ps1 사용 안내 docs 한정) |
| **re-verify** | N/A |

## 1. 문제 (현 docs 부재)

### 현재 상태 — README.md

```markdown
# Stage 1 (line 33-36)
git clone https://github.com/pdw96/harness-meta $HOME/harness-meta
cd $HOME/harness-meta
pwsh ./install.ps1                      # ← -Force 미언급

# line 63 (Force note)
> **Force reinstall** (backs up existing files to `.claude/backup-<ts>/`): add `--force` / `-Force` flag.
```

**문제 1**: `--force` 표기 (lowercase, double dash)는 .sh 패턴 — install.ps1은 `-Force` 단일.
**문제 2**: backup 측면만 언급 — settings.json 충돌(SessionStart 정기 재실행) 미명시.

### 현재 상태 — CLAUDE.md

```markdown
# 레이어 변경 후 재설치 (글로벌) (line 47-48)
pwsh $HOME/harness-meta/install.ps1     # ← -Force 미언급
```

**문제**: 정기 재실행 = 본 세션 핵심 케이스. SessionStart 이미 등록 → abort.

### Root cause

`install.ps1` line 322-328:

```powershell
if ($settings.hooks.ContainsKey('SessionStart')) {
    if (-not $Force) {
        Write-Err "settings.json에 이미 hooks.SessionStart 존재. 글로벌 hook으로 교체하려면 -Force"
        throw "settings.json hooks.SessionStart conflict"
    }
    Write-Warn "hooks.SessionStart 덮어쓰기"
}
```

**비교**: PostToolUse 분기 (line 370-371)는 `if ($existingCmd -eq $ourCommand)` 체크하여 idempotent no-op. SessionStart는 미보유 → 항상 abort.

**docs 처치 vs 코드 처치**:

- 본 세션 (docs only) — 사용자에게 "재실행 시 `-Force`" 가이드. v1.36b L3 verbatim
- 별 후속 (코드, idempotent no-op 추가) — 근본 해결. Out of scope

## 2. 결정 (R1 ~ R3)

### R1 — README.md 갱신

#### R1-a — Stage 1 코드블록 직후 1줄 (line 36 다음)

신규 노트 추가 (Stage 1 = 글로벌 install.ps1 전용):

```markdown
# 1단계 — Global (initial install + periodic reinstall)
...
pwsh ./install.ps1
```

> **Reinstall** (after layer changes): add `-Force` — settings.json `hooks.SessionStart` is already registered after first install, so abort otherwise. Conflicts back up to `~/.claude/backup-<ts>/`.

#### R1-b — 기존 line 63 Force note 명확화 (Stage 2 dedicated)

L63 "Force reinstall" 노트는 **Stage 2 (install-project-claude) 전용**으로 정확 — `.sh`는 `-f|--force`, `.ps1`은 `-Force` 지원. **제거 안 함**. 다만 Stage 2 어구 명시:

```markdown
> **Force reinstall (Stage 2)** (backs up existing files to `<proj>/.claude/backup-<ts>/`): add `-f` / `--force` (sh) or `-Force` (PowerShell).
```

`--force` (sh) vs `-Force` (PS) **양쪽 정확** — 표기 정정 철회 (PLAN 초기 분석 오류).

#### ~~R1-c~~ — 철회 (install-project-claude.sh의 `--force` 실재 확인)

`bootstrap/install-project-claude.sh` line 12, 23에서 `-f|--force` 지원 확인. 글로벌 `install.ps1`과 다른 도구이므로 표기 분리 정합. 정정 무.

### R2 — CLAUDE.md 갱신

#### R2-a — line 38 "1단계 — 글로벌 (1회)" → "최초 1회" 명확화

첫 설치 vs 정기 재설치 구분 강화 (architecture 권고).

#### R2-b — line 47-48 "레이어 변경 후 재설치" 코드블록 갱신

```markdown
# 레이어 변경 후 재설치 (글로벌) — settings.json 이미 등록 → -Force 필수
pwsh $HOME/harness-meta/install.ps1 -Force
```

추가 1줄 보강:

```markdown
- `install.ps1` 정기 재실행은 **`-Force` 필수** — settings.json `hooks.SessionStart` 충돌 시 abort. 충돌 파일은 `~/.claude/backup-<ts>/`에 백업
```

위치: 현 line 55 "install.ps1이 ... 3 카테고리만 symlink" bullet 직후.

### R3 — install.ps1 헤더 코멘트 1줄 보강

line 16-18:

```powershell
충돌 정책:
  - ~/.claude/ 하위에 같은 이름 파일·링크가 이미 있으면 기본은 중단 + 경고
  - -Force 지정 시 ~/.claude/backup-<timestamp>/에 이동 후 덮어쓰기
```

→ 다음으로 갱신:

```powershell
충돌 정책:
  - ~/.claude/ 하위에 같은 이름 파일·링크가 이미 있으면 기본은 중단 + 경고
  - settings.json hooks.SessionStart / statusLine 충돌도 동일 (정기 재실행 시 -Force 필수)
  - -Force 지정 시 ~/.claude/backup-<timestamp>/에 이동 후 덮어쓰기
```

`.SYNOPSIS` / `.PARAMETER Force` 본문은 충분 — 추가 변경 없음.

## 3. 변경 대상 (3 수정 + 2 신규)

### 수정 (3)

| 경로 | scope | 변경 |
|------|------|------|
| `README.md` | S3 | R1-a + R1-b — Stage 1 직하 신규 노트 + L63 Stage 2 명시 |
| `CLAUDE.md` | S3 | R2-a + R2-b — L41 "(최초 1회)" + 재설치 코드블록 `-Force` + 1 bullet 보강 |
| `install.ps1` | S1a | R3 — 헤더 코멘트 1줄 추가 (settings.json 충돌 명시) |

### 신규 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.36b2-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.36b2-.../REPORT.md` | meta | Stage F |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 초안 작성
- [ ] **5 관점 다각적 검토 (작음 → 3 관점)**
- [ ] **사용자 진입 승인**
- [ ] Stage A — README.md 갱신 (R1-a + R1-b + R1-c)
- [ ] Stage B — CLAUDE.md 갱신 (R2)
- [ ] Stage C — install.ps1 헤더 코멘트 (R3)
- [ ] Stage D — REPORT.md 작성
- [ ] Stage E — `harness-roadmap-update` SKILL invoke
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] README.md Stage 1 직하 "Reinstall" 노트 존재 + settings.json 충돌 명시 + `-Force` (PS convention)
- [ ] README.md line 63 "Force reinstall (Stage 2)" 명시 (Stage 1과 분리 — `--force / -Force` 양쪽 유지)
- [ ] CLAUDE.md L38 "최초 1회" + L47-48 "레이어 변경 후 재설치" 코드블록에 `-Force` 포함
- [ ] CLAUDE.md install.ps1 정기 재실행 -Force 필수 bullet 추가
- [ ] install.ps1 헤더 충돌 정책 코멘트 1줄 추가
- [ ] 회귀 0 — 코드 수정 없음 (docs only) + smoke 영향 없음
- [ ] AGENTS.md 영향 검토 — install 안내 미포함 → 변경 없음 (별 후속에서 통합 시 검토)

## 6. 커밋 전략

단일 커밋:

```
docs(meta): sessions/meta/v1.36b2-install-ps1-force-docs — install.ps1 정기 재실행 -Force 필수 명시

- update: README.md (R1 — Stage 1 직하 재실행 노트 + settings.json 충돌 명시 + `--force` lowercase 정정 + 기존 line 63 중복 제거)
- update: CLAUDE.md (R2 — 재설치 코드블록 -Force + 1 bullet 보강)
- update: install.ps1 (R3 — 헤더 충돌 정책 코멘트 1줄)
- add: sessions/meta/v1.36b2-.../{PLAN,REPORT}.md

Trigger: v1.36b REPORT L3 — 정기 재실행 시 hooks.SessionStart 이미 등록 → abort.
Scope: docs only. install.ps1 SessionStart 분기 idempotent no-op 추가는 별 후속 (Out of scope).
회귀 0 — 코드 수정 없음 (헤더 코멘트만).
```

## 7. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.36e-install-sessionstart-idempotent` | install.ps1 SessionStart 분기 idempotent no-op 추가 (PostToolUse 패턴 답습). evidence 누적 시 — 사용자 정기 재실행 빈도 + `-Force` 부담 |
| `v1.36b5-posttooluse-verify-stage-j` | verify.ps1/sh Stage J PostToolUse 등록 여부 체크 (ROADMAP §3-B 기존 항목) |

## 8. Lessons Forward (예상)

- **L1 — docs ↔ code 분리 원칙** — L3 trigger를 "코드 수정"으로 답하면 v1.36b2 ≠ install-ps1-force-docs (이름 mismatch). 본 세션은 docs only로 정확. 코드 수정은 별 후속에서 evidence-driven
- **L2 — `-Force` (PS) vs `--force` (sh) 표기 분리** — install.ps1은 PS convention. install-skills.sh는 GNU long-option. README.md 동일 라인에 `--force / -Force` 혼합 표기는 misleading
- **L3 — SSOT drift 방어** — `-Force` 충돌 정책이 install.ps1 헤더 (canonical) + README.md + CLAUDE.md 3곳에 노출. 향후 충돌 정책 변경 시 **3곳 동시 갱신 의무** — install.ps1 헤더가 single source of truth, README/CLAUDE는 사용 안내. 향후 충돌 정책 항목 추가 시 별 후속에서 install.ps1 헤더 → README/CLAUDE link 1줄로 수렴 검토
