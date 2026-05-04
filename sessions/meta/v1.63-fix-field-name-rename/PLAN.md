# meta v1.63-fix-field-name-rename — PLAN

세션 시작: 2026-05-04
직접 선행 세션:
- [`sessions/meta/v1.62-fix-broad-bash-fine-grain/`](../v1.62-fix-broad-bash-fine-grain/PLAN.md) — `--fix` 패턴 답습 직속 + Stage 6 field name Out of scope 분리

목적: `tests/smoke-broad-bash-fine-grain.sh` Stage 6 field name (A1) 양방향 rename auto-fix 도입. 3 SKILL `^tools:` → `^allowed-tools:`, 4 agent `^allowed-tools:` → `^tools:`.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S3(1) `tests/smoke-broad-bash-fine-grain.sh` = **1/1 meta**
- **T1 경로 다수결** — S3 단독
- **T2 스펙 vs 값** — smoke 자동 정정 mechanism = 글로벌 정책

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.62-fix-broad-bash-fine-grain/REPORT.md` 다음 후보 (verbatim)**:

> `v1.62b-fix-field-name-rename` | E | Stage 6 field name (3 SKILL `tools:` → `allowed-tools:` + 4 agent 역방향) bidirectional auto-fix evidence

**Source — ROADMAP §3-E (verbatim)**:

> `v1.62b-fix-field-name-rename` | Stage 6 field name (3 SKILL ↔ 4 agent bidirectional rename) auto-fix evidence | `v1.62 REPORT`

**Parsed sub-items (3)**:

1. **3 SKILL `^tools:` → `^allowed-tools:` rename** — harness/harness-run/harness-ship SKILL.md
2. **4 agent `^allowed-tools:` → `^tools:` rename** — harness-verifier/dispatcher/explore/grey-area
3. **양쪽 필드 동시 존재 시 skip** — 수동 정정 필요 (자동 정정은 duplicate field 위험)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 양쪽 필드 동시 존재 시 자동 정정 (one delete + 다른 rename) | 후속 미정 — 어느 필드 보존할지 결정 분기 (사용자 판단 영역) |
| Stage 1/2/4 (V8/V9/R3/R4) auto-fix | v1.62 동일 정책 (구조적/positive existence) |
| `claude/commands/harness-meta.md` slash command field name | v1.60에서 V7으로 이미 처리 (다른 smoke) |
| 다른 smoke (`smoke-bash-permission-pattern` Stage 3 V7) 추가 보강 | v1.60에서 이미 V7 처리 (중복 회피) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 smoke tooling 추가만. Claude Code spec 신규 의존 없음 |
| **re-verify** | N/A |

## 배경

`smoke-broad-bash-fine-grain.sh` Stage 6은 Claude Code frontmatter spec A1(필드명) 정합 검증:
- **slash command/skill**: `allowed-tools:` (skill = pre-approval 목록)
- **subagent**: `tools:` (별도 schema)

v1.62 PLAN Out of scope에 "Stage 6 field name bidirectional rename auto-fix"가 명시 — "양방향 sed 안전성 검증 필요"가 분리 사유. 본 v1.63은 **단순 rename + 양쪽 동시 존재 시 skip** 정책으로 안전성 확보 후 진행.

## 구현 설계

### Argument parsing (v1.62 답습 — 기존 --fix block 확장)

기존 v1.62 argv 파싱 + V5 + R2/R6 block 보존. 동일 `--fix` flag로 Stage 6 rename도 추가 활성.

### Stage 6 SKILL rename (3 파일)

```bash
for f in "${SKILL_FILES[@]}"; do
    has_tools=$(grep -cE '^tools:' "$f" 2>/dev/null || echo 0)
    has_allowed=$(grep -cE '^allowed-tools:' "$f" 2>/dev/null || echo 0)
    if [ "$has_tools" -gt 0 ] && [ "$has_allowed" -gt 0 ]; then
        echo "  [skip Stage 6 SKILL] $f: 'tools:' + 'allowed-tools:' 양쪽 존재 — 수동 정정 필요"
    elif [ "$has_tools" -gt 0 ]; then
        if [ "$DRY_RUN" -eq 1 ]; then
            grep -nE '^tools:' "$f" | sed "s|^|  [would fix Stage 6 SKILL] $f: |"
        else
            sed -E -i.bak 's/^tools:/allowed-tools:/' "$f" && rm -f "$f.bak"
            echo "  [fix Stage 6 SKILL] $f: ^tools: → ^allowed-tools:"
        fi
        fix_count=$((fix_count + 1))
    fi
done
```

### Stage 6 agent rename (4 파일)

```bash
for f in "${AGENT_FILES[@]}"; do
    has_tools=$(grep -cE '^tools:' "$f" 2>/dev/null || echo 0)
    has_allowed=$(grep -cE '^allowed-tools:' "$f" 2>/dev/null || echo 0)
    if [ "$has_tools" -gt 0 ] && [ "$has_allowed" -gt 0 ]; then
        echo "  [skip Stage 6 agent] $f: 'tools:' + 'allowed-tools:' 양쪽 존재 — 수동 정정 필요"
    elif [ "$has_allowed" -gt 0 ]; then
        if [ "$DRY_RUN" -eq 1 ]; then
            grep -nE '^allowed-tools:' "$f" | sed "s|^|  [would fix Stage 6 agent] $f: |"
        else
            sed -E -i.bak 's/^allowed-tools:/tools:/' "$f" && rm -f "$f.bak"
            echo "  [fix Stage 6 agent] $f: ^allowed-tools: → ^tools:"
        fi
        fix_count=$((fix_count + 1))
    fi
done
```

### --help 텍스트 갱신

```
--fix:     V5 + R2/R6 + Stage 6 field name rename 자동 정정.
           Stage 6: 3 SKILL ^tools: → ^allowed-tools:, 4 agent ^allowed-tools: → ^tools:.
           양쪽 필드 동시 존재 시 skip (수동 정정 필요).
```

### 안전성 분석

- **단방향 rename sed**: line-anchor `^tools:` 또는 `^allowed-tools:` — body 평문 또는 들여쓰기된 표현 매치 안 됨
- **양쪽 동시 존재 차단**: duplicate field 발생 시 sed가 무조건 rename → 결과 모호. 본 정책으로 사용자 수동 개입 강제 → 안전
- **순서 영향 0**: V5 + R2/R6은 YAML list line 삭제 (Bash 패턴), Stage 6은 frontmatter top-level field rename (tools:/allowed-tools:). 동일 라인 매칭 가능성 0 → 순서 무관
- **백업**: `-i.bak` + `rm -f $f.bak` (동일 패턴)

## 목표

- [ ] 세션 디렉토리 + PLAN.md 작성 ✅
- [ ] Stage A — `tests/smoke-broad-bash-fine-grain.sh` --fix block에 Stage 6 SKILL rename 추가
- [ ] Stage B — agent rename 추가 + --help 텍스트 갱신
- [ ] Stage C — 검증: default 호출 6/6 PASS 유지 (회귀 0)
- [ ] Stage D — 검증: `--fix --dry-run` 호출 정상
- [ ] Stage E — E2E 시나리오 1: SKILL `^allowed-tools:` → `^tools:` 변경 → `--fix` → 정정 + 6/6 PASS
- [ ] Stage F — E2E 시나리오 2: agent `^tools:` → `^allowed-tools:` 변경 → `--fix` → 정정 + 6/6 PASS
- [ ] Stage G — E2E 시나리오 3: 양쪽 동시 존재 → `--fix` → skip 메시지 + 변경 없음
- [ ] REPORT.md 작성

## 변경 대상

| 경로 | scope | 변경 |
|------|------|------|
| `tests/smoke-broad-bash-fine-grain.sh` | S3 | --fix block에 Stage 6 SKILL/agent rename + skip 분기 + --help 텍스트 |

## 성공 기준

- [ ] default: 6/6 PASS (회귀 0)
- [ ] `--help`: Stage 6 rename 추가 안내 포함
- [ ] `--fix --dry-run`: plan 출력 (현재 0건)
- [ ] E2E SKILL: `^tools:` 주입 → `--fix` → `^allowed-tools:` 정정 + PASS
- [ ] E2E agent: `^allowed-tools:` 주입 → `--fix` → `^tools:` 정정 + PASS
- [ ] E2E both: 양쪽 동시 존재 → `--fix` → skip 메시지 + 변경 없음

## 커밋 전략

```
feat(meta): v1.63-fix-field-name-rename — smoke --fix Stage 6 field name 추가

- update: tests/smoke-broad-bash-fine-grain.sh (--fix block에 Stage 6 SKILL/agent rename + 양쪽 동시 skip)

3 SKILL: ^tools: → ^allowed-tools:. 4 agent: ^allowed-tools: → ^tools:.
양쪽 동시 존재 시 skip (수동 정정 필요).

default 6/6 PASS 유지 (회귀 0). E2E 3 시나리오 검증 (SKILL rename + agent rename + skip).
v1.62 패턴 답습 + 확장. v1.62b-fix-field-name-rename trigger 이행.
```

## 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.63b-fix-field-name-both-merge` | 양쪽 필드 동시 존재 시 자동 merge/delete 정책 evidence |
| `v1.61b-fix-model-effort-insert` | model+effort frontmatter 구조 삽입 (이연) |
| `v1.62c-fix-other-smokes` | 다른 smoke (smoke-language-overlay 등) `--fix` 패턴 evidence |
