---
description: cascade source → host narrative 자동 동기 (v3.21 narrative 정전화 3 단계 패턴 (b) 단계 자동화)
allowed-tools: Bash, Read
argument-hint: "[apply]"
---

# /cascade-sync — cascade 자동 동기 mechanism (v6.4)

`projects/meta/ARCHITECTURE.md` § 4 끝 narrative 정전화 누적 매트릭스 #8 row + paragraph 본문 안 정의된 cascade source → host 단방향 동기 mechanism.

## 책임

- **본 slash command** = UX orchestrator. script 호출 + diff 사용자 표시 + 사용자 명시 응답 (y/n) 받기 + 결과 보고.
- **scripts/cascade_sync.py** = mechanical work 단일 source. enumerate (grep cascade-source marker) + hash compare + diff text + apply.

DESIGN.D10 (책임 경계) + D13 (subprocess injection 차단, fixed argument list).

## 실행 절차

`$ARGUMENTS` 안 사용자가 `apply` 키워드를 명시했는지 확인.

### Step 1 — Check (dry-run, default)

다음 명령을 Bash tool 으로 호출 (fixed argument list — 다른 argument 금지):

```bash
python scripts/cascade_sync.py --check
```

출력 = drift detected (0 개 또는 N 개) 와 각 host 안 expected vs actual hash. exit code = 0 (모두 sync) 또는 1 (drift detected) 또는 2 (ERROR).

### Step 2 — Report

- exit 0: "모든 cascade host 가 source 와 sync 상태입니다." 보고 + 종료.
- exit 1: drift list 사용자에게 표시 + Step 3 진입.
- exit 2: ERROR 사용자에게 보고 (source 부재 / anchor 부재 / path traversal / marker HTML escape 위반 등) + 사용자 결정 받기.

### Step 3 — User approval (apply 분기)

drift 발견 시:

- `$ARGUMENTS` 안 `apply` 부재 = 사용자에게 "drift 발견. apply 진행할까요? (y/n)" 명시 응답 받기.
- `$ARGUMENTS` 안 `apply` 존재 = 사용자가 apply 명시 의도 이나 LLM 는 여전히 diff 출력 후 "apply 진행 확정합니다. 회귀 시 git checkout 으로 rollback 가능합니다." 보고 후 Step 4 진입 (P2_sec_2 보강 — apply 명시이라도 LLM diff 출력 후 confirmation).

`y` 또는 명시 승인 시 Step 4 진입. 그 외 = 종료.

### Step 4 — Apply (자동 Edit)

```bash
python scripts/cascade_sync.py --apply
```

출력 = updated marker(s) list. exit code = 0.

### Step 5 — Final report

- updated host(s) list + count 사용자에게 보고.
- "phase commit 전 `git diff` 으로 변경 검토 의무." narrative 추가.

## Mechanism 안전 가드레일

- **dry-run default** (D8) — `--check` flag 가 기본, `--apply` 는 사용자 명시 호출.
- **fixed argument list** (D13) — slash command 가 script 호출 시 `--check` 또는 `--apply` 두 형태 만 허용 (shell metacharacter `;`, `&&`, `$(...)` injection 차단).
- **path traversal 차단** (D12) — script 안 `is_relative_to(REPO_ROOT)` 검증 의무. `../../../etc/passwd` 등 repo 외부 path 차단.
- **외부 URL skip** (D12 + r_6) — script 안 `^https?://` 매칭 시 stderr warn + skip.

## Cascade source vs host 정의 (cf ARCHITECTURE § 4 끝 #8)

- **Cascade source** = 정전 narrative 의 1차 위치 (예: ARCHITECTURE.md § 4 끝 매트릭스 #8 row).
- **Cascade host** = source narrative 를 인용/요약/cross-ref 하는 외부 위치 (예: root CLAUDE.md, AGENTS.md, README.md 안 동일 paragraph 의 줄임 인용).
- 본 mechanism = source 변경 시 host 안 expected-hash 갱신 (인용 stale 회피).

## Marker comment 형식 (cf DESIGN.D7)

```markdown
<!-- cascade-source: <repo-relative path>#<anchor> expected-hash:<16-hex> -->
```

- `<path>` = repo-relative (예: `projects/meta/ARCHITECTURE.md`)
- `<anchor>` = heading slug (auto) 또는 explicit HTML id (`<a id="X">`)
- `expected-hash` = source paragraph 본문 (whitespace normalize 후) SHA-256 16-hex prefix

## 관련

- 정전 source: [`projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 4 끝 매트릭스 #8 row + paragraph 본문
- 본 milestone: [`projects/meta/milestones/v6.4/MILESTONE.md`](../../projects/meta/milestones/v6.4/MILESTONE.md)
- smoke 자동 검증: [`tests/smoke-cascade-drift.sh`](../../tests/smoke-cascade-drift.sh)
