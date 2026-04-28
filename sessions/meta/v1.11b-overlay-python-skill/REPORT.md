# meta v1.11b-overlay-python-skill — REPORT

세션 완료: 2026-04-28
선행 세션: [`sessions/meta/v1.11-language-overlay-infra/`](../v1.11-language-overlay-infra/REPORT.md)

## 최종 결과

- 신규 파일 2건 + 수정 파일 2건 (세션 문서 제외)
- smoke 11/11 PASS (Stage 1: 6 + Stage 2: 5)
- 회귀 0 — 기존 8체크 전체 PASS 유지

## 구현 요약

| Stage | 산출 | 비고 |
|-------|------|------|
| A | `bootstrap/templates/python/.claude/skills/harness-python/SKILL.md` | env/check/fix/all 4-dispatch + 5섹션 |
| B | `bootstrap/templates/python/.claude/skills/harness-python/python-quality.md` | PM 매핑 + 단계표 + 환경표 + 진단패턴 14건 |
| C | `bootstrap/docs/OVERLAY.md` §3 table | python/ `✓ (placeholder)` → `✓ (harness-python/ 2파일)` |
| D | `tests/smoke-language-overlay.sh` | 8 → 11 체크. S1.5/S1.6 static + S2.5 dynamic 추가 |
| E | 본 REPORT.md | |

## PLAN 체크박스 판정

- [x] `harness-python/SKILL.md` 존재 + `harness-*` prefix 준수
- [x] 4-section 구조 완비 (§0 전제 / §1 dispatch / §2 env / §3 quality gate / §4 fix / §5 진단)
- [x] PM 감지 로직 (uv/poetry/pdm/hatch/pip) 명시
- [x] `python-quality.md` PM 매핑 표 + 환경표 + 진단 패턴 14건
- [x] OVERLAY.md §3 python/ 행 갱신
- [x] smoke 11/11 PASS (PLAN 예측 10 → 실제 11: S2.5 dynamic 추가)
- [x] 회귀 0

## PLAN 대비 실제 차이

| 항목 | PLAN | 실제 |
|------|------|------|
| smoke 체크 수 | 10 (Stage 1 +2) | **11** (Stage 2 S2.5 추가) |
| SKILL.md 섹션 | 4 | **5** (§5 진단 힌트 독립 분리) |
| 진단 패턴 수 | 미지정 | **14건** |

## Lessons Learned

- **L1 — PM prefix 동적 조합이 broad Bash의 정당한 근거** — uv/poetry/pdm/hatch/pip × mypy/ruff/pytest = 20+ 조합 → `Bash(uv run *)` 열거보다 broad `Bash` + 본문 로직이 명확
- **L2 — 보조 참조 파일 분리 효과** — SKILL.md 길이 억제 + python-quality.md 독립 갱신 가능 (PM 추가 시 §1 표만 수정)
- **L3 — S2.5 dynamic check가 Phase 2 실제 복사를 증명** — static check만으로는 install-project-claude가 실제로 overlay를 dest에 복사했는지 보장 불가. dynamic이 필수

## 후속 분기

| 세션 | 조건 |
|------|------|
| `sessions/upbit/v1.x-python-overlay-apply/` | upbit `install-project-claude --force` 재실행 → harness-python 실배포 (T4 후행) |
| `v1.11b-ext` | pyproject.toml 분석 skill, pre-commit hook 연동 등 Python overlay 확장 |
| `v1.11c-overlay-typescript` | TS 사용자 발생 시 |
