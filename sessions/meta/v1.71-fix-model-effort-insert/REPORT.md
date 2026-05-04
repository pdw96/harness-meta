# meta v1.71-fix-model-effort-insert — REPORT

세션 완료: 2026-05-05
선행 세션: [`sessions/meta/v1.61-fix-thinking-effort/`](../v1.61-fix-thinking-effort/REPORT.md)

## 최종 결과

- 변경 파일: 1 (`tests/smoke-thinking-effort.sh`)
- default: 5/5 PASS (회귀 0)
- `--fix --dry-run`: V10 + R1/R2/R3 plan 정상 출력 + Stage skip
- E2E: 4 시나리오 violation 주입 → 5건 detect → `--fix` → 5/5 PASS + 자동 정정 후 백업 복원 → git diff 0

## 구현 요약

### `--fix` block 확장 — Python heredoc 위임 (R1/R2/R3)

v1.61의 V10 line-delete 처리 직후 R1/R2/R3 frontmatter insert/replace block 추가.

**알고리즘**:

1. 4 파일 + 기대값 매트릭스 (slash → `(sonnet, None)`, 3 SKILL → `(opus, xhigh)`)
2. Python으로 frontmatter 범위 식별 (`---` 사이)
3. `model:` / `effort:` 필드별 분기:
   - 부재 + want=None → no-op
   - 부재 + want=value → insert (closing `---` 직전)
   - 존재 + want=None → delete
   - 존재 + want != actual → replace (값만 변경)
   - 존재 + want == actual → no-op
4. delete 역순 처리 후 replace는 field name 재탐색 (인덱스 시프트 안전)

**파일 쓰기**: `write_text(..., encoding="utf-8", newline="\n")` — v1.69 패턴 답습 (CRLF 회귀 방지).

**stdout reconfigure**: Windows cp949 default 환경에서 `—` 출력 시 UnicodeEncodeError 발생 → v1.18d 패턴으로 UTF-8 + `errors='replace'` 적용.

### E2E 검증 (4 violation 동시 주입)

```
violation 1 — claude/commands/harness-meta.md model: sonnet → opus (replace 시나리오)
violation 2 — claude/commands/harness-meta.md effort: high 잔존 (delete 시나리오)
violation 3 — harness-design/SKILL.md model: opus → sonnet (replace 시나리오)
violation 4 — harness-plan/SKILL.md effort: xhigh → medium (replace 시나리오)
violation 5 — harness-ship/SKILL.md effort: xhigh 삭제 (insert 시나리오)
```

dry-run detect 5건 정확. `--fix` 실 적용 → Stage 1~5 PASS. 백업 복원 후 git diff 0.

## 판정

| 성공 기준 | 결과 |
| --- | --- |
| default 5/5 PASS (회귀 0) | ✅ |
| --fix --dry-run plan + Stage skip | ✅ |
| E2E: model 위반 → --fix → 정정 | ✅ (replace) |
| E2E: effort 위반 → --fix → 정정 | ✅ (replace) |
| E2E: 필드 부재 → --fix → 삽입 | ✅ (insert) |
| E2E: 필드 잔존(want=None) → --fix → 삭제 | ✅ (delete) |

## Spec verification (context7)

| sub-field | 값 |
| ----------- | --- |
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 smoke tooling 추가만. 외부 spec 의존 없음 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — Python heredoc 위임이 frontmatter 변환의 최적해**: bash sed로 closing `---` 추적하면 fragile. Python pathlib + line index = ~80라인. v1.61 sed 패턴은 line-delete까지만 안전, 구조 변환은 Python.
- **L2 — Windows cp949 stdout reconfigure 의무**: 한국어 메시지 출력 Python heredoc은 항상 v1.18d 패턴 (`sys.stdout.reconfigure(encoding="utf-8")`) 적용. v1.69 newline=과 묶어서 boilerplate화 가능.
- **L3 — delete 역순 + replace field-name 재탐색**: 인덱스 변경 안전 패턴. delete를 먼저 (역순), replace는 field name으로 재탐색, insert는 끝에 append.

## 다음 후보 (보류)

| 항목 | trigger 분류 | 조건 |
| --- | :---: | --- |
| `v1.71b-frontmatter-create` | E | frontmatter `---` 부재 파일 자동 생성 evidence (현재 0건 — WARN skip) |
| `v1.71c-other-frontmatter-fields` | E | `disable-model-invocation` / `argument-hint` 등 다른 필드 auto-fix evidence |
