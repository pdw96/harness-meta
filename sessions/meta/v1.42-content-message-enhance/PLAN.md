# meta v1.42-content-message-enhance — PLAN

세션 시작: 2026-05-01
직접 선행 세션: [`sessions/meta/v1.41-multiedit-content-filter/`](../v1.41-multiedit-content-filter/PLAN.md) — MultiEdit edits 콘텐츠 가드 도입

목적: PostToolUse hook이 REPORT.md 작성 감지 시 출력하는 additionalContext 메시지에 **감지된 섹션명(`## SectionName`)을 포함**한다. 현재는 고정 메시지만 출력 — claude가 어느 섹션이 쓰였는지 알면 더 정확하게 harness-roadmap-update를 invoke할 수 있다.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1a(1) `claude/hooks/post-report-write.sh` + S3(1) `tests/smoke-posttooluse-hook.sh` = **2/2 meta**
- **T1 경로 다수결** — S1a + S3 전부 meta scope

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/ROADMAP.md` §3-B 표 (verbatim)**:

> | `v1.41b-content-message-enhance` | 감지된 섹션명을 additionalContext 메시지에 포함 — evidence-driven | `v1.41 REPORT` |

**Parsed sub-items (1)**:

1. **section name extraction + message embed** — REPORT.md 작성 감지 시 `## SectionName` 형태 섹션명을 추출하여 additionalContext 메시지에 포함

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| grep+sed fallback에서 section 추출 | python3 전용 (fallback = best-effort, sections 불필요) — 후속 미정 |
| 섹션별 조건부 invoke 제어 (예: `## 판정` 감지 시만 invoke) | 별도 후속 evidence-driven |
| 섹션명 기반 메시지 다국어 처리 | 별도 후속 evidence-driven |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 hook 로직 + smoke만) |
| **re-verify** | N/A |

## 1. 배경

v1.41에서 MultiEdit `edits[*].new_string`에 `## ` 마커가 있는지 검사 (false positive 필터). 동일 python3 파싱 경로를 활용해 **어떤 섹션명인지까지 추출**하는 것이 v1.41b ROADMAP 약속.

현재 additionalContext 메시지:
```
REPORT.md write detected. Please invoke harness-roadmap-update SKILL now: /harness-roadmap-update — update ROADMAP.md with this session completed entry and Out of scope trigger rows.
```

목표 메시지 (sections 있을 때):
```
REPORT.md write detected (sections: ## 판정, ## Lessons Learned). Please invoke harness-roadmap-update SKILL now: /harness-roadmap-update
```

## 2. 구현 결정 (R1~R3)

### R1 — python3 블록: section 추출 + 5번째 출력 줄

python3 블록에 `import re` 추가 후:

```python
# v1.42: section name extraction
secs = []
if t == "Write":
    content = d.get("tool_input", {}).get("content", "")
    secs = re.findall(r'^## (.+)', content, re.MULTILINE)
elif t == "Edit":
    secs = re.findall(r'^## (.+)', d.get("tool_input", {}).get("new_string", ""), re.MULTILINE)
elif t == "MultiEdit":
    for e in edits:
        secs += re.findall(r'^## (.+)', e.get("new_string", ""), re.MULTILINE)
# sanitize: JSON-unsafe chars 제거, 40자 + 5개 상한
secs = [re.sub(r'["\\\x00-\x1f]', '', s.strip()[:40]) for s in secs[:5]]
secs_str = ", ".join("## " + s for s in secs if s)
print(secs_str)   # 5번째 출력 줄
```

exception 분기:
```python
except Exception:
    print("")   # line 1~4 (기존)
    print("")   # line 5 (secs_str empty)
```

### R2 — bash 변수 추출 + grep fallback

hook 상단에 `SECTIONS=''` 초기화 추가.

python3 블록 후 5번째 줄 추출:
```bash
SECTIONS=$(printf '%s' "$_result" | sed -n '5p')
```

grep fallback 블록 안에 `SECTIONS=''` 추가 (section 추출은 python3 전용).

### R3 — MSG 조건부 포맷

```bash
if [ -n "$SECTIONS" ]; then
    MSG="REPORT.md write detected (sections: ${SECTIONS}). Please invoke harness-roadmap-update SKILL now: /harness-roadmap-update"
else
    MSG="REPORT.md write detected. Please invoke harness-roadmap-update SKILL now: /harness-roadmap-update — update ROADMAP.md with this session completed entry and Out of scope trigger rows."
fi
```

## 3. 변경 대상 (2 파일)

| 경로 | scope | 변경 |
|------|------|------|
| `claude/hooks/post-report-write.sh` | S1a | R1+R2+R3 — `import re` + section 추출 + SECTIONS 변수 + MSG 조건부 |
| `tests/smoke-posttooluse-hook.sh` | S3 | Test J (sections 포함 검증) + Test K (graceful degradation) 추가. 12→14 |

## 4. 목표

- [ ] hook: python3 블록 `import re` + section 추출 (Write/Edit/MultiEdit 3종)
- [ ] hook: SECTIONS 초기화 (`SECTIONS=''`) + 5번째 줄 추출
- [ ] hook: grep fallback 블록에 `SECTIONS=''` 추가
- [ ] hook: MSG 조건부 포맷 (sections 있을 때/없을 때)
- [ ] smoke: Test J — Write + sections → message에 섹션명 포함
- [ ] smoke: Test K — Write + no sections → message 유효 (harness-roadmap-update 포함)
- [ ] smoke 14/14 PASS (기존 A~I 회귀 0)
- [ ] REPORT.md + ROADMAP 갱신

## 5. 성공 기준

- [ ] `post-report-write.sh`: python3 블록 5번째 출력 줄 = secs_str
- [ ] `post-report-write.sh`: `SECTIONS` 변수 bash에서 추출
- [ ] `post-report-write.sh`: MSG 조건부 (sections 있을 때 섹션명 포함)
- [ ] `smoke-posttooluse-hook.sh`: Test J `## 판정` 포함 검증 PASS
- [ ] `smoke-posttooluse-hook.sh`: Test K graceful degradation PASS
- [ ] 기존 Tests A~I 회귀 0
- [ ] 총 14/14 PASS

## 6. 커밋 전략

```
feat(meta): v1.42-content-message-enhance — hook additionalContext에 감지 섹션명 포함

- update: claude/hooks/post-report-write.sh (R1 python3 section 추출 + R2 SECTIONS 변수 + R3 MSG 조건부)
- update: tests/smoke-posttooluse-hook.sh (Test J + Test K 추가, 12→14)
- add: sessions/meta/v1.42-content-message-enhance/{PLAN,REPORT}.md

sections 있을 때: "(sections: ## 판정, ## Lessons Learned)" 포함
sections 없을 때: 기존 메시지 형식 유지 (graceful degradation)
smoke 14/14 PASS. 회귀 0 (A~I 기존 테스트 전부 유지).
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|---------|------|
| `v1.42b-section-conditional-invoke` | 특정 섹션 (`## 판정`, `## Lessons Learned`) 감지 시만 invoke 제어 evidence-driven |
| `v1.40c-hook-more-tools` | Delete / NotebookEdit 등 다른 파일 수정 도구 미발화 evidence |
