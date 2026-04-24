---
name: harness-review
description: 하네스 전용 변경 리뷰 체크리스트 — ARCHITECTURE/ADR 준수, 테스트 존재, CRITICAL 규칙, 빌드 가능성 5항목. /harness-ship 10-2에서 호출.
disable-model-invocation: true
allowed-tools: Read, Glob, Grep, Bash(git*)
model: sonnet
---

이 프로젝트의 변경 사항을 리뷰하라.

먼저 다음 문서들을 읽어라:
- `/CLAUDE.md`
- 프로젝트 ARCHITECTURE 문서 (예: `/docs/core/ARCHITECTURE.md` 또는 `@~/harness-meta/projects/{name}/ARCHITECTURE.md`. 실제 경로는 CLAUDE.md의 import 선언 참조)
- 프로젝트 DECISIONS/ADR 문서 (예: `/docs/core/ADR.md`)
- 현재 마일스톤의 scope docs도 확인 (변경 파일이 해당 scope에 속하면):
  - `/docs/scope/{version}/PRD.md`
  - `/docs/scope/{version}/ADR.md`

그런 다음 변경된 파일들을 확인하고, 아래 체크리스트로 검증하라:

## 체크리스트

1. **아키텍처 준수**: ARCHITECTURE에 정의된 디렉토리 구조를 따르고 있는가?
2. **기술 스택 준수**: DECISIONS/ADR에 정의된 기술 선택을 벗어나지 않았는가?
3. **테스트 존재**: 새로운 기능에 대한 테스트가 작성되어 있는가?
4. **CRITICAL 규칙**: 프로젝트 `CLAUDE.md`의 CRITICAL 섹션에 선언된 금지 규칙을 위반하지 않았는가? (규칙 내용은 프로젝트별)
5. **빌드 가능**: 프로젝트 빌드 검증 커맨드(테스트·타입체크·린트)를 **각각 분리 실행** (`&&`로 묶으면 앞 단계 실패 시 뒤가 누락됨):
   ```bash
   {test_cmd}        # .harness.toml [testing].test_cmd
   {type_check_cmd}  # .harness.toml [testing].type_check_cmd (선택)
   {lint_cmd}        # .harness.toml [testing].lint_cmd (선택)
   # 언어별 예시는 harness-ship.md 10-2 섹션 참조
   ```

## 출력 형식

| 항목 | 결과 | 비고 |
|------|------|------|
| 아키텍처 준수 | PASS/FAIL | {상세} |
| 기술 스택 준수 | PASS/FAIL | {상세} |
| 테스트 존재 | PASS/FAIL | {상세} |
| CRITICAL 규칙 | PASS/FAIL | {상세} |
| 빌드 가능 | PASS/FAIL | {상세} |

FAIL 항목이 있으면 즉시 수정 방안을 구체적으로 제시하라.
