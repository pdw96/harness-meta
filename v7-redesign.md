# v7 워크플로우 재설계 (root 진행)

본 file = harness-meta workflow 자체 재설계 design doc.

## 진행 본질

- 위치: `C:\Users\qkreh\harness-meta\` (root)
- 9-stage workflow 본질 안 진행 **안 함** (self-referential 회피)
- ROADMAP 등재 **안 함**
- 산출물 자유 형식 (필요 시 추가 file 자연 발현)
- audit trail = git commit + main branch
- 사용자 의도 #24 ("새 세션 진행") 정합 → 본 세션 안 carry-over + 다음 세션 안 design 본격 진입

## 본 세션 안 결정 (2026-05-22)

| # | 결정 | 적용 |
|:-:|---|---|
| 1 | v7.0/v7.1 폐기 | commit `57a01ed` — host 5 full rollback (옵션 B-2) |
| 2 | tag v7.0 삭제 (로컬 + remote) | push 완료 |
| 3 | 새 v7.0 scope = v7-0-pre-discussion.txt 안 8 후보 단일 milestone | 사용자 명시 |
| 4 | 진행 본질 = root 진행 + 자유 형식 + ROADMAP 등재 안 함 | 본 file 거주 자연 |

폐기 본질 (commit 57a01ed):

- `projects/meta/milestone/` (단수형 디렉토리) 통째 삭제
- 7 file → `9dfc217` (v6.23 last) 회귀 (catalog README / harness-meta.md / ARCHITECTURE / ROADMAP / `_era_detect.py` / 2 smoke)
- memory `feedback_v7_external_vector_mandate.md` 삭제 + MEMORY.md entry 3 곳 정정

## v7-0-pre-discussion.txt 종합 (Phase A / B / C 자연 분할)

### 4 핵심 인사이트

| # | 시점 | 인사이트 |
|:-:|:-:|---|
| 1 | #08 (5:48) | 정책/메모리 부하 자각 — self-host overhead 첫 표출 |
| 2 | #12, #13 (6:06~6:11) | 매 milestone 마다 next_candidates 부산물 발생 — 자기참조 loop 본질 인식 (폐기 v7.0 mechanism-cleanup 의 직접 trigger) |
| 3 | #14 (6:17) | 검증 sub-agent (5 관점 review) 의도 미달 자각 |
| 4 | #10, #20 (5:53, 7:01) | 외부 vector 방향 명시 — Claude Code built-in/skill 적극 활용 + 버전 추적 |

### 8 후보 (변경 본질)

| # | 메시지 | 본질 | 본질 분류 |
|:-:|:-:|---|---|
| 1 | #04, #05 | `.claude/rules/` 도입 (memory/architecture 정책 일부 이전 검토) | 정책 본질 |
| 2 | #15 | stage별 sub-agent/agent team 도입 필요성 | workflow 본질 |
| 3 | #16 | stage별 skill 도입 필요성 | workflow 본질 |
| 4 | #17 | stage별 최소권한원칙 정합성 검토 | workflow 본질 |
| 5 | #18 | stage 완료 시 context 사용량 확인 + /clear 결정 (context rot 방지) | workflow 본질 |
| 6 | #19 | 마일스톤 완료 시 산출물 reset + github tag 버전 관리 (BREAKING) | 산출물 본질 |
| 7 | #21, #22 | Claude Code docs 전수조사 + 버전 추적 agent | 외부 vector |
| 8 | #26 | 마일스톤 단위 commit/push (per-phase 금지) | commit 본질 |

## self-referential 충돌 6 본질

본 v7.0 자체 진행 시 — 변경 대상이 동시에 진행 도구가 되는 충돌.

| # | 현재 워크플로우 | v7.0 변경 후보 (충돌) |
|:-:|---|---|
| 1 | 산출물 영구 보존 (`milestones/v{X.Y}/`) | #19 다음 마일스톤 진행 시 reset |
| 2 | 9-stage (OPEN~PROPOSE) | #15 stage별 sub-agent + #16 skill + #17 권한 |
| 3 | per-phase 또는 milestone 단위 commit | #26 milestone 단위 only |
| 4 | 산출물 안 5 관점 review (조건부) | #15~17 안 변경 가능 |
| 5 | next_candidates 발의 default | #11 propose-next 정체성 의문 |
| 6 | memory/architecture 정책 본질 | #04 `.claude/rules/` 이전 검토 |

**해결 = root 진행** (workflow 본질 무시 → 6 충돌 100% 회피)

## 다음 세션 진입 가이드

본 file 읽기 + 다음 본질 순서 진행:

1. **8 후보 우선순위 결정** — 사용자 인터뷰 (`feedback_iterative_dialog` 스무고개 방식 정합)
   - 의존 관계 식별 (예: #19 산출물 reset 정책 도입 = 이후 모든 변경 본질 영향)
   - 우선순위 (P1/P2/P3) 결정
2. **새 워크플로우 본질 정전화 (design 본문)**
   - 본 file 또는 별 file (자유 형식) 안 진행
   - 현재 9-stage 보존 vs 부분 개편 vs 완전 대체 결정
3. **adoption mechanism 결정**
   - 새 워크플로우 정전화 후 본 repo 적용 방식
   - 다음 milestone (v7.0 이후) 부터 새 워크플로우 적용 본질
4. **본 v7.0 자체 결과 적용**
   - 본 file design 완료 본질 적용 = ARCHITECTURE.md / CLAUDE.md / agents/ / skills/ / hooks/ 등 본 repo 안 정전화
   - tag v7.0 재발급 (또는 안 함 — 결정 본질)

### 본 세션 안 미진입 본질 (다음 세션 안 진입)

- 8 후보 안 우선순위 + 의존 관계
- 새 워크플로우 본질 정의 (stage 변경 / 산출물 본질 / 권한 본질 / agent + skill 도입 본질)
- 본 file 안 design 본격 진입

## 첨부 file (root 안 거주)

- `v7-0-pre-discussion.txt` — 2026-05-21 사전 논의 transcript (26 메시지)
- `prompts.txt` — 사용자 prompt 모음 (root)

## 참고 commit

- `57a01ed` — v7.0/v7.1 폐기 (옵션 B-2 full rollback)
- `9dfc217` — v6.23 last (rollback 목표 상태)
- `20b2873` — v7.0 (폐기됨, git history 보존)
- `b7d834e` — v7.1 (폐기됨, git history 보존)

## 메모리 정합

- `feedback_iterative_pre_plan_review` — design 진행 안 매 round 결정적 이슈 trigger
- `feedback_iterative_dialog` — INTENT 본질 진입 전 사용자 의도 좁혀가기, paper 일괄 제시 금지
- `feedback_token_efficiency_priority` — 토큰 효율 우선
- `feedback_section_6_2_abolished` — workflow self-improvement 본질 현재 정체성 (§ 3.1) 안 자연 부합 안 함 — 본 재설계 본질 사용자 명시 발의 (A_user) 자연 정합
- `user_non_developer_role` — 비기술 용어 + 비유 + 결정 단계별 짚어가기
