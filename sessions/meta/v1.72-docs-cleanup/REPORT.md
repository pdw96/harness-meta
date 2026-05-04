# meta v1.72-docs-cleanup — REPORT

세션 종료: 2026-05-05
선행 세션: [`sessions/meta/v1.71-fix-model-effort-insert/`](../v1.71-fix-model-effort-insert/PLAN.md)

## 최종 결과

- 변경 파일: 3 (`sessions/meta/ROADMAP.md`, `CLAUDE.md`, `README.md`)
- ROADMAP §3 ✅ 완료 행 삭제: **21건** (§3-A 1 / §3-B 7 / §3-D 1 / §3-E 12)
- CLAUDE.md 수정: 4항목 (파일수 ×2 + projects 5종 + ROADMAP cross-ref + 구 v1.11 링크 제거)
- README.md 수정: 2항목 (install.sh 구 주석 + projects 5종)
- 신규 파일: 2 (PLAN.md + REPORT.md)
- smoke 회귀: **0** (smoke-spec-verification 495/495 + smoke-scope-contract 164/164 PASS)

## 구현 요약

| 목표 | 실제 |
|------|------|
| ROADMAP §3 ✅ 21행 삭제 | ✓ §3-A 1건 + §3-B 7건 + §3-D 1건 + §3-E 12건. 헤더 카운트 갱신 (3-A 9→10건 / 3-B 13→10건). §8 최근 완료 표는 그대로 보존 |
| CLAUDE.md "17 파일" → "14 파일" (2곳) | ✓ 명령어 §61줄 + 디렉토리 구조 §106줄. "4 agents + 9 skills + 1 output-style" 부연 추가 |
| CLAUDE.md projects 4종 → 5종 + ROADMAP.md | ✓ 디렉토리 구조 §108~112줄. sessions 구조에 `meta/ROADMAP.md` 행 추가 |
| CLAUDE.md 구 v1.11 링크 제거 | ✓ 관련 문서 §140줄 → "최신 meta 세션 이력: @sessions/meta/ROADMAP.md §8" 로 대체 |
| README.md install.sh 주석 제거 | ✓ Line 44 `# coming in v1.21; for now use pwsh if available` 삭제 |
| README.md projects 4 → 5 docs | ✓ Line 153~161 ROADMAP.md 행 추가 + sessions/meta/ROADMAP.md 행 추가 |

## 판정

- [x] ROADMAP §3 잔류 ~~strikethrough~~ 0건
- [x] CLAUDE.md "14 파일" 정상 × 2
- [x] CLAUDE.md projects 5종 + ROADMAP.md 명시
- [x] CLAUDE.md v1.11 구 링크 제거
- [x] README.md install.sh 주석 제거
- [x] README.md projects 5 docs
- [x] smoke-spec-verification 495/495 PASS
- [x] smoke-scope-contract 164/164 PASS
- [x] 회귀 0 (문서 전용 변경)

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 문서 정리만) |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — ROADMAP §3 정리는 §8 archive와 중복 회피 mechanism** — `harness-roadmap-update` SKILL이 ✅ 표기 후 §8로 이관하나 §3 행을 삭제하지 않아 21건 누적. 향후 SKILL 5-step "Update"에 §3 row 자동 삭제 옵션 추가 검토 (별 후속, evidence-driven)
- **L2 — Cross-platform 호환성은 nested 파일 도입 전 context7 검증이 안전** — 사용자 발의의 "각 모듈마다 CLAUDE.md" 도입 전 Claude Code memory + AGENTS.md 표준 양쪽 검증 → A안 (Claude Code primary, root AGENTS.md 유지) 선택 근거 확보. 후속 v1.73에서 활용
- **L3 — T4 크로스 커팅 분할 첫 적용** — 정리(v1.72) + 정책 신설(v1.73) 분리. 단일 세션 흡수 시 scope 경계 불명료해짐 → 분할이 audit 명확성 확보

## 후속 세션

### 다음 후보 (등록)

| 후속 세션 | Trigger | 설명 |
|---------|--------|------|
| **`v1.73-nested-claude-md`** | 사용자 발의 (2026-05-05 확정) | 모듈별 CLAUDE.md 분할 — root CLAUDE.md 축소 + `bootstrap/CLAUDE.md` / `bootstrap/skills/CLAUDE.md` / `claude/CLAUDE.md` / `tests/CLAUDE.md` / `sessions/CLAUDE.md` 5개 신설. A안 (Claude Code only, AGENTS.md root 유지) 채택. context7 검증 완료 — Claude Code memory.md (subdirectory on-demand load) + AGENTS.md 표준 (nearest precedence rule) 양쪽 호환 |

### 보류

`harness-roadmap-update` SKILL이 §8 이관 시 §3 row를 자동 삭제하는 기능 (evidence-driven 후속, 현재 v1.72에서 수동 정리로 충분).
