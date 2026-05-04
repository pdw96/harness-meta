# meta v1.13-opensource-entry — REPORT

세션 완료: 2026-04-28
선행 세션: [`sessions/meta/v1.12-base-skills-i18n/`](../v1.12-base-skills-i18n/REPORT.md)

## 최종 결과

- 수정 파일 2건 (세션 문서 제외)
- 한국어 잔존: README.md 0건 (Python 검증)
- AGENTS.md 한국어 0건 (기존부터 영문 유지)

## 구현 요약

| Stage | 파일 | 변경 내용 |
|-------|------|---------|
| A — README.md | `README.md` | 한국어 전체(302 lines) → 영문 재작성 (191 lines, 8+1 섹션) |
| B — AGENTS.md | `AGENTS.md` | 3개 항목 업데이트 |

### README.md 변경 상세

**8+1 섹션 구조** (기존 12섹션 → 간결화):

1. What is this — 1단락 + 헤더 tagline
2. Requirements — Windows(primary) + macOS/Linux(secondary) 크로스플랫폼
3. Installation — 2-stage (Stage 1 global + Stage 2 per-project), verify
4. Directory layout — 구조 요약 (claude/ 3 items 정확 표기)
5. Activating a project — `.harness.toml` 최소 예시 + Bootstrap 명령
6. Usage — 명령 표 (harness-plan ~ harness-ship + harness-python 추가)
7. Language overlay (v1.11+) — Python overlay + OVERLAY.md 링크
8. Key docs — 6개 핵심 링크만
9. License — MIT

**수정된 오류**:

- 파일 수: "17 파일" → "14 files: 4 agents + 9 skills + 1 output-style" (v1.8b 이후 commands/ 제거)
- Windows-only → 크로스플랫폼 (macOS/Linux 명시)
- language overlay 섹션 신설 (v1.11+ harness-python)
- 관련 문서 목록: 긴 한국어 내부 링크 → 6개 핵심 영문 링크

### AGENTS.md 변경 상세

| 항목 | 기존 | 변경 |
|------|------|------|
| Stage 2 파일 수 | `_base/.claude/` (17 files) | (14 files: 4 agents + 9 skills + 1 output-style) |
| Python overlay 언급 | 없음 | overlay merge + `/harness-python` 설명 추가 |
| `claude/` 구조 설명 | "commands/agents/skills/hooks/statusline/output-styles" (6 카테고리) | "3 items: commands/harness-meta.md, hooks/session-init.sh, statusline/statusline.sh" |
| `_base/.claude/` 복사 주체 | `install.ps1` via symlink (오류) | `install-project-claude.{ps1,sh}` copy로 정정 |
| bootstrap/ 라인 | OVERLAY.md 없음 | `docs/OVERLAY.md` 추가 + templates 상세 |
| Key docs | OVERLAY.md 없음, 최신 세션 stale | OVERLAY.md 추가 + v1.13 최신 세션 업데이트 |

## PLAN 체크박스 판정

- [x] `README.md` 영문으로 재작성 완료
- [x] `README.md`: 설치 가이드 (2-stage), 디렉토리 구조, language overlay, key docs 포함
- [x] `AGENTS.md`: v1.11b/v1.12 반영, Python overlay 언급, OVERLAY.md 링크
- [x] `AGENTS.md`: 최신 세션 링크 v1.13으로 업데이트
- [x] 한국어 잔존: README 0건 (Python 검증)

## Lessons Learned

- **L1 — 파일 수 오류는 마이그레이션 때 자주 발생** — v1.8b에서 commands/ → skills/ 이관 시 README/AGENTS의 "17 파일" 표기가 갱신되지 않았음. 향후 구조 변경 세션에서 카운트 표기 검색 + 갱신을 체크리스트에 포함할 것
- **L2 — AGENTS.md Project structure의 claude/ 기술이 v1.8 이전 상태** — "6 카테고리" 기술이 v1.8 이전 구조 그대로였음. OWNERSHIP S1a/S1b 분리(v1.8)를 반영하지 않음
- **L3 — 오픈소스 README는 크로스플랫폼 + 외부 방문자 관점 필수** — 기존 README는 Windows + 한국어 사용자 전용. 영문 재작성 시 macOS/Linux 사용자와 비Claude 도구 기여자도 포함하도록 설계

## 후속

- upbit `.claude/` 재설치: `bash ~/harness-meta/bootstrap/install-project-claude.sh ~/upbit --force` (v1.12 영문화 + language overlay 배포)
- v1.14: Bootstrap 흐름 단순화 (10 stages → 간결화)
- v1.21: verify.ps1에 overlay 무결성 체크 + bash `install.sh` (Stage 1 macOS/Linux 지원)
