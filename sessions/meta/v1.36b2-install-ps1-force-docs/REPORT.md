# meta v1.36b2-install-ps1-force-docs — REPORT

세션 종료: 2026-04-30
PLAN: [`PLAN.md`](PLAN.md)
선행: [`sessions/meta/v1.36b-postoolse-roadmap-hook/`](../v1.36b-postoolse-roadmap-hook/) — Lessons Learned L3 trigger

## 최종 결과

| 지표 | 값 |
|------|---|
| 변경 파일 | 3 (`README.md`, `CLAUDE.md`, `install.ps1`) |
| 추가 라인 | +8 |
| 삭제 라인 | -5 |
| 신규 파일 | 2 (`PLAN.md`, `REPORT.md`) |
| 코드 수정 | 0 (install.ps1 헤더 주석 1줄만) |
| smoke 영향 | 0 (회귀 risk agent PASS) |
| 회귀 | 0 |

## 구현 요약

### R1-a — README.md Stage 1 직하 신규 노트 (영문)

L45 ("Creates symlinks ...") 직후에 추가:

```markdown
> **Reinstall (after layer changes)**: `pwsh ./install.ps1 -Force` — `settings.json` `hooks.SessionStart` is registered on first install, so subsequent runs abort without `-Force`. Conflicting files back up to `~/.claude/backup-<ts>/`.
```

핵심: **settings.json 충돌 명시** (기존 line 63 노트에 부재했던 정보).

### R1-b — README.md L63 Stage 2 명시 (PLAN 초기 분석 정정)

`bootstrap/install-project-claude.sh` line 12, 23 grep으로 `-f|--force` 실재 확인. L63 노트는 Stage 2에 정확 — 표기 정정 철회 (R1-c 철회).

```markdown
- > **Force reinstall** (backs up existing files to `.claude/backup-<ts>/`): add `--force` / `-Force` flag.
+ > **Force reinstall (Stage 2)** (backs up existing files to `<proj>/.claude/backup-<ts>/`): add `-f` / `--force` (sh) or `-Force` (PowerShell).
```

명확화 포인트:
- "(Stage 2)" 어구 추가 → Stage 1 (글로벌 install.ps1)와 명시 분리
- backup 경로 `<proj>/.claude/backup-<ts>/` 명시 → 글로벌 `~/.claude/backup-<ts>/`와 분리
- `-f` / `--force` (sh) vs `-Force` (PS) 도구 분리 명시

### R2-a — CLAUDE.md L38 "(최초 1회)" 명확화

Architecture 권고 채택. 첫 설치 vs 정기 재설치 구분 강화:

```markdown
- # 1단계 — 글로벌 (1회)
+ # 1단계 — 글로벌 (최초 1회)
```

### R2-b — CLAUDE.md L47-48 재설치 코드블록 `-Force` 추가

```markdown
- # 레이어 변경 후 재설치 (글로벌)
- pwsh $HOME/harness-meta/install.ps1
+ # 레이어 변경 후 재설치 (글로벌) — settings.json hooks.SessionStart 이미 등록 → -Force 필수
+ pwsh $HOME/harness-meta/install.ps1 -Force
```

### R2-b — CLAUDE.md L55 bullet 보강

```markdown
- `install.ps1`이 `~/.claude/{commands,hooks,statusline}/` **3 카테고리만** symlink (v1.8+ 축소). legacy harness-* 심볼릭 자동 cleanup. **정기 재실행 시 `-Force` 필수** — settings.json `hooks.SessionStart` / `statusLine` / `PostToolUse[Edit|Write]` 충돌 시 idempotent no-op 분기 부재 (`v1.36e-install-sessionstart-idempotent` 후속 검토).
```

3 충돌 항목 (`hooks.SessionStart` / `statusLine` / `PostToolUse[Edit|Write]`) 모두 명시 + 후속 세션 ID 가시화.

### R3 — install.ps1 헤더 충돌 정책 1줄

line 16-19 헤더 주석:

```powershell
충돌 정책:
  - ~/.claude/ 하위에 같은 이름 파일·링크가 이미 있으면 기본은 중단 + 경고
+ - settings.json hooks.SessionStart / statusLine / PostToolUse[Edit|Write] 충돌도 동일 (정기 재실행 시 -Force 필수)
  - -Force 지정 시 ~/.claude/backup-<timestamp>/에 이동 후 덮어쓰기
```

PowerShell `<# ... #>` block 주석 내부 — 파싱 영향 0 (회귀 risk agent 검증).

## 5 관점 검토 결과 (3 관점 — 작음 scope)

| 관점 | 결과 | 발견 |
|------|------|-----|
| ① architecture (Plan agent) | PASS | 결함 1 (S1a 표기 누락 → ✅ 적용) + 결함 2 (CLAUDE.md L41 "최초 1회" 명확화 → ✅ 적용) + SSOT drift 권고 (✅ Lessons L3 추가) |
| ③ 회귀 risk (Explore agent) | PASS | 회귀 risk 없음 (코드 수정 0, smoke 의존 0, line hardcode 의존 0) |
| ⑤ scope contract (Explore agent) | PASS | 5 § 모두 정합. drift=N/A 카테고리 명확화 권고 → ✅ "내부 규약 보강" 명시 |

추가 발견 (구현 단계, agent 외):
- **R1-c 철회** — `bootstrap/install-project-claude.sh` line 12, 23 grep으로 `-f|--force` 실재 확인. L63 "--force / -Force" 표기 정정은 잘못된 분석. PLAN 갱신 (R1-c → 철회) + L63은 Stage 2 명시로 변경

## 판정

- [x] README.md Stage 1 직하 "Reinstall" 노트 존재 + settings.json 충돌 명시 + `-Force` (PS convention)
- [x] README.md line 63 → "Force reinstall (Stage 2)" 명시 (Stage 1과 분리, `--force / -Force` 양쪽 유지)
- [x] CLAUDE.md L38 "최초 1회" + L47-48 재설치 코드블록 `-Force` + L55 bullet 보강
- [x] install.ps1 헤더 충돌 정책 코멘트 1줄
- [x] 회귀 0 — 코드 수정 없음 (헤더 주석만)
- [x] AGENTS.md 영향 없음 (install 안내 미포함, 회귀 risk agent 검증)

PLAN 체크박스 6/6 완수.

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — PLAN 동상 (외부 spec 의존 무, 내부 규약 보강 only) |
| **re-verify** | N/A |

PLAN drift=N/A → REPORT drift=N/A. SPEC_VERIFICATION.md §11 매트릭스 OK case (N/A → N/A). 구현 중 신규 spec drift 발견 0.

## Lessons Learned

- **L1 — docs ↔ code 분리 원칙** — L3 trigger를 "코드 수정"으로 답하면 v1.36b2 ≠ install-ps1-force-docs (이름 mismatch). 본 세션은 docs only로 정확. 코드 수정 (`install.ps1` SessionStart idempotent no-op)은 별 후속 (`v1.36e-install-sessionstart-idempotent`)에서 evidence-driven 진행
- **L2 — `-Force` (PS) vs `-f|--force` (sh) 표기 분리** — install.ps1은 PS only. `bootstrap/install-project-claude.sh`는 `-f|--force` 실재 (line 12, 23). 양 도구는 OS·언어 분리 — 표기 통일 시도는 misleading. README L63 Stage 2 명시로 분리 정합
- **L3 — SSOT drift 방어 (architecture 권고)** — `-Force` 충돌 정책이 install.ps1 헤더 (canonical) + README.md + CLAUDE.md 3곳에 노출. 향후 충돌 정책 변경 시 **3곳 동시 갱신 의무**. 추가 충돌 항목 (예: 새 hook matcher) 도입 시 install.ps1 헤더 → README/CLAUDE link 1줄로 수렴 검토 (별 후속 가능)
- **L4 — 5 관점 검토가 PLAN 결함 3건 사전 발견** — architecture S1a 표기 + L41 명확화 + scope contract drift=N/A 카테고리. agent 호출 비용 < PLAN 결함 후행 발견 비용. 작음 scope (3 파일)에서도 3 관점 검토 가치 입증
- **L5 — 구현 중 사실 확인 → PLAN 정정 패턴** — `bootstrap/install-project-claude.sh` `-f|--force` 실재는 PLAN 작성 시점 확인 안 함. R1-c "lowercase 정정" 가정이 잘못됨 → 구현 중 grep 확인 → R1-c 철회 + R1-b 재정의 (Stage 2 명시). PLAN-as-history 정책 정합 (과거 의도 보존, 정정 fact는 REPORT 명시)

## 다음 후보 (보류)

| 후속 세션 | 조건 / 출처 |
|---------|----------|
| `v1.36e-install-sessionstart-idempotent` | install.ps1 SessionStart 분기 idempotent no-op 추가 (PostToolUse line 370-371 패턴 답습). evidence: 사용자 정기 재실행 빈도 + `-Force` 부담. 본 세션 L1 + L3 추적 |
| `v1.36b5-posttooluse-verify-stage-j` | verify.ps1/sh Stage J — PostToolUse 등록 여부 체크 (ROADMAP §3-B 기존) |
| `v1.36b3-multiedit-trigger` | MultiEdit으로 REPORT.md 갱신 evidence 발생 — matcher 확장 또는 별 hook (ROADMAP §3-B) |
| `v1.36b4-hook-debug-log` | post-report-write.sh silent no-op 문제 — stderr 로그 추가 (ROADMAP §3-B) |
| `v1.36b2b` (가상) | 충돌 정책 SSOT 수렴 — install.ps1 헤더 canonical → README/CLAUDE 1줄 link로 단일 소스 (L3 evidence-driven) |

## 관련

- 선행: [`sessions/meta/v1.36b-postoolse-roadmap-hook/`](../v1.36b-postoolse-roadmap-hook/REPORT.md) (Lessons Learned L3)
- 후속 후보: 위 표
- 단일 소스: install.ps1 line 1-38 (`<# ... #>` block 헤더)
- ROADMAP: [`sessions/meta/ROADMAP.md`](../ROADMAP.md) (§8 최근 완료 갱신 대상)
