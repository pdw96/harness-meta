# meta v1.59-hook-pattern-expand — PLAN

세션 시작: 2026-05-04
직접 선행 세션: [`sessions/meta/v1.58-hook-msg-dynamic-filename/`](../v1.58-hook-msg-dynamic-filename/PLAN.md)

목적: PostToolUse hook `post-report-write.sh`의 감지 대상을 `REPORT.(md|ipynb)` → `PLAN.md` 까지 확장. PLAN.md write 감지 시 `harness-plan-verify` SKILL invoke 안내.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1a(1) `claude/hooks/post-report-write.sh` + S3(1) `tests/smoke-posttooluse-hook.sh` = **2/2 meta**
- **T1 경로 다수결** — S1a + S3 모두 meta scope
- **T2 스펙 vs 값** — hook 감지 패턴·라우팅 규약 변경 = 글로벌 레이어 영향

## Scope inheritance (verbatim from 선행 세션)

**Source — ROADMAP §3-B `v1.40d-hook-pattern-expand` 사용자 발의 (2026-05-04)**:

> `v1.40d-hook-pattern-expand` — REPORT.md 외 파일 패턴 확장 (PLAN.md 등 감지) evidence | `v1.40 REPORT`

**Parsed sub-items (2)**:

1. **hook 파일 패턴 확장** — `REPORT.(md|ipynb)` 외에 `PLAN.md` 도 감지 (sessions/**/PLAN.md)
2. **SKILL 라우팅** — REPORT → `harness-roadmap-update`, PLAN → `harness-plan-verify`

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| hook 파일명 변경 (post-report-write.sh → post-session-write.sh) | 후속 미정 (install.ps1/verify.ps1/sh 대규모 갱신 수반, 현재 evidence 부재) |
| PLAN.md 섹션명 추출 (python3 section regex) | 후속 미정 (PLAN MSG에 sections 불필요 — 유용성 evidence 부재) |
| PLAN.md 외 파일 확장 (ARCHITECTURE.md, DECISIONS.md 등) | 후속 미정 (evidence-driven) |
| PLAN.ipynb 지원 | 후속 미정 (실사용 evidence 없음) |
| `install.ps1` / `verify.ps1` / `verify.sh` 변경 | 변경 불필요 — 매처 동일, 파일명 유지 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 regex 확장 + MSG 라우팅만. Claude Code PostToolUse 이벤트 구조 신규 의존 없음 |
| **re-verify** | N/A |

## 배경

v1.58까지 hook은 `sessions/**/REPORT.(md|ipynb)` 에만 반응. PLAN.md 작성 시 harness-plan-verify SKILL invoke 안내가 없어 사용자가 수동 인지해야 했음. ROADMAP §3-B `v1.40d-hook-pattern-expand`에 evidence-driven 후속으로 등록됨.

## 구현 설계

### hook 로직 변경 (post-report-write.sh)

현재:
```bash
printf '%s' "$NORM_PATH" | grep -qE 'sessions/[^/]+/[^/]+/REPORT\.(md|ipynb)$' \
    || { printf '%s\n' "$NOOP"; exit 0; }
REPORT_BASENAME=$(basename "$NORM_PATH")
```

변경:
```bash
FILE_TYPE=''
if printf '%s' "$NORM_PATH" | grep -qE 'sessions/[^/]+/[^/]+/REPORT\.(md|ipynb)$'; then
    FILE_TYPE='REPORT'
elif printf '%s' "$NORM_PATH" | grep -qE 'sessions/[^/]+/[^/]+/PLAN\.md$'; then
    FILE_TYPE='PLAN'
else
    printf '%s\n' "$NOOP"; exit 0
fi
FILE_BASENAME=$(basename "$NORM_PATH")   # REPORT_BASENAME → FILE_BASENAME
```

### MSG 라우팅

```bash
if [ "$FILE_TYPE" = 'PLAN' ]; then
    MSG="PLAN.md write detected. Please invoke harness-plan-verify SKILL now: /harness-plan-verify — verify spec (context7) before proceeding."
elif [ -n "$SECTIONS" ]; then
    MSG="${FILE_BASENAME} write detected (sections: ${SECTIONS}). Please invoke harness-roadmap-update SKILL now: /harness-roadmap-update"
else
    MSG="${FILE_BASENAME} write detected. Please invoke harness-roadmap-update SKILL now: /harness-roadmap-update — update ROADMAP.md with this session completed entry and Out of scope trigger rows."
fi
```

### PLAN.md + MultiEdit 가드 처리

MultiEdit 콘텐츠 가드(`HAS_MARKERS='false'` → NOOP)는 PLAN.md에도 동일 적용. 단 PLAN.md는 Write/Edit이 주된 도구 — MultiEdit은 드문 케이스. 보수적 설계 유지.

## 목표

- [ ] 세션 디렉토리 + PLAN.md 작성
- [ ] Stage A — hook `post-report-write.sh` 수정 (v1.59 헤더 + FILE_TYPE 분기 + MSG 라우팅 + REPORT_BASENAME→FILE_BASENAME)
- [ ] Stage B — smoke `smoke-posttooluse-hook.sh` 수정 (Test P + Test Q 추가, 18→20)
- [ ] Stage C — smoke 실행 검증 (20/20 PASS)
- [ ] REPORT.md 작성

## 변경 대상

| 경로 | scope | 변경 |
|------|------|------|
| `claude/hooks/post-report-write.sh` | S1a | v1.59 헤더 + FILE_TYPE + MSG 라우팅 + FILE_BASENAME |
| `tests/smoke-posttooluse-hook.sh` | S3 | Test P + Q 신규, 총 20/20 |

## 성공 기준

- [ ] hook: `sessions/**/PLAN.md` Write → additionalContext with `/harness-plan-verify`
- [ ] hook: `sessions/**/PLAN.md` 외 path → NOOP 유지
- [ ] hook: `sessions/**/REPORT.md` Write → 기존 동작 유지 (회귀 0)
- [ ] smoke 20/20 PASS (기존 18 + 신규 P + Q)
- [ ] REPORT_BASENAME → FILE_BASENAME 치환 (MSG 내용 동일)

## 커밋 전략

```
feat(meta): v1.59-hook-pattern-expand — PostToolUse hook PLAN.md 감지 + harness-plan-verify 라우팅

- update: claude/hooks/post-report-write.sh (v1.59 — FILE_TYPE REPORT/PLAN 분기 + MSG 라우팅)
- update: tests/smoke-posttooluse-hook.sh (Test P + Q 신규, 총 20/20)

smoke 20/20 PASS. 회귀 0 (기존 18 test 보존).
ROADMAP §3-B v1.40d-hook-pattern-expand trigger 이행.
```
