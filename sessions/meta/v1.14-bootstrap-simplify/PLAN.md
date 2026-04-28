# meta v1.14-bootstrap-simplify — PLAN

세션 시작: 2026-04-28
선행 세션: [`sessions/meta/v1.13-opensource-entry/`](../v1.13-opensource-entry/PLAN.md) — README 영문 재작성 + AGENTS.md 업데이트

목적: Bootstrap 흐름 단순화. 현재 10 stages (S0–S10, 실제 11단계) + 13 질문을 **8 stages + 7 질문**으로 간결화.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1a(1) `claude/commands/harness-meta.md` + S2(3) `bootstrap/{interview.md, docs/INTERVIEW_FLOW.md, skeletons/projects/INTERVIEW.md}` + S3(1) `CLAUDE.md` = **5/5 meta**
- **T1 경로 다수결** — S1a 1 + S2 3 + S3 1 = 전건 meta
- **T2 스펙 vs 값** — Bootstrap 흐름 규약 변경 = 모든 신규 프로젝트에 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.13-opensource-entry/PLAN.md` Out of scope 표 (verbatim)**:

> `| v1.14 Bootstrap 단순화 | 후속 세션 |`

**Source 2 — `sessions/meta/v1.12-base-skills-i18n/REPORT.md` 후속 § (verbatim)**:

> `v1.14: Bootstrap 흐름 단순화 (10 stages → 간결화)`

**Source 3 — 사용자 발의 (2026-04-28) verbatim**:

> `14`

**Parsed sub-items (2)**:

1. **10 stages → 간결화** — S0–S10 (11단계) 중 중복·저가치 단계 제거/통합. 목표: 8 stages
2. **13 질문 → 간결화** — 당연한 default를 묻는 질문 제거. 목표: 7 effective Q

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `detect-project.sh` 단순화 (468줄 license 감지 로직) | 별도 세션 evidence-driven |
| `render-manifest.sh` 변경 | 불필요 (env var auto-set으로 대응) |
| `INTERVIEW_FLOW.md` 내 license 알고리즘 중복 문서 제거 | 별도 세션 |
| `bootstrap/skeletons/sessions/v0.1-bootstrap/` 템플릿 갱신 | v1.14 이후 |
| v1.14~v1.20 adapter sessions (Cursor/Codex/Gemini) | 별도 도메인 |
| `bash ./install.sh` macOS/Linux Stage 1 | v1.21-cross-platform-install |

## 1. 현황 분석

### 1-1. 현재 흐름 (11단계)

| Stage | 사용자 부담 | 복잡도 |
|-------|-----------|--------|
| S0 모드 진입 확인 | 낮음 | 낮음 |
| S1 detect 실행 | 없음 (자동) | 낮음 |
| S2 인터뷰 13Q | **높음** | 높음 |
| S3 manifest preview | 중간 | 낮음 |
| S4 manifest write + verify | 없음 (자동) | 낮음 |
| S5 부수 자산 생성 | 없음 (자동) | 중간 |
| S6 .claude/ 배포 | 없음 (자동) | 낮음 |
| S7 아키텍처 문서 4종 | 없음 (자동) | 중간 |
| S8 세션 기록 2종 | 없음 (자동) | 낮음 |
| S9 README 등록 | 없음 (자동) | **저가치** |
| S10 후속 안내 | 낮음 | 낮음 |

**병목**: S2(13Q), S3+S4 2-turn dance, S9(저가치)

### 1-2. 인터뷰 질문 분석

| Q# | 질문 | 현재 방식 | 단순화 방향 |
|----|------|---------|-----------|
| Q1 name | 프로젝트 이름 | 필수 | **유지** |
| Q2 language | 주 언어 | detect default | **유지** |
| Q3 package_manager | 패키지 매니저 | detect default | **유지** |
| Q4 runtime_version | 런타임 버전 | 사용자 입력 | **유지** |
| Q5 code_dir | 하네스 코드 디렉토리 | default `scripts/harness` | **유지** |
| Q6 phases_dir | phases 디렉토리 | default `phases` | **유지** |
| **Q7** meta_ref | harness-meta 내부 경로 | default `projects/{Q1}/ARCHITECTURE.md` | **→ 자동** |
| **Q8** guardrails | GUARDRAILS.md 경로 | default `docs/GUARDRAILS.md` | **→ 자동** |
| **Q9** locale | 작업 언어 | default `en` | **→ 자동** |
| Q10 testing cmds | 테스트/린트/포맷/타입체크 | detect default | **유지** (4개 → 1번에) |
| **Q11** observability | 관측 스택 | 자유 응답 | **→ post-bootstrap 이연** |
| **Q12** CI/CD | CI/CD 인프라 | 자유 응답 | **→ post-bootstrap 이연** |
| Q13 Claude-specific | Claude 전용 지시 | 선택 | **유지** (optional 명확화) |

**결과**: 사용자가 답해야 하는 질문 13 → 7 (Q1–Q6 + Q10 + Q13 optional)

**Q7/Q8/Q9 자동화 근거**:
- Q7: `projects/{Q1}/ARCHITECTURE.md` 외 답이 나온 사례 0 — 항상 동일 패턴
- Q8: `docs/GUARDRAILS.md` 외 답이 나온 사례 0 — 항상 default
- Q9: `en` 외 답 = 한국어 사용자만 `ko` — manifest에서 사후 편집이 더 자연스러움

**Q11/Q12 이연 근거**:
- bootstrap 작동에 필수 아님 — 아키텍처 문서 placeholder에 `(미설정)` 채우는 용도
- S8 후속 안내(새 S7)에서 "아키텍처 문서에 observability/CI 항목 채우세요" 안내로 대체

## 2. 결정 (R1~R4)

### R1 — 인터뷰 7Q로 축소

**삭제 (3건)**:
- Q7 (meta_ref): Claude가 `projects/${HM_NAME}/ARCHITECTURE.md`로 자동 설정
- Q8 (guardrails): Claude가 `docs/GUARDRAILS.md`로 자동 설정
- Q9 (locale): render-manifest.sh 기본값 `en` 그대로 사용 (HM_LOCALE 미설정)

**이연 (2건)**:
- Q11 (observability): 이제 인터뷰에서 묻지 않음. 새 S7 안내에서 "ARCHITECTURE.md에 후속 작성" 언급
- Q12 (CI/CD): 동상

**유지 (7건, optional 포함)**:
- Q1–Q6 필수 (6)
- Q10 테스트 명령 (1, detect default 포함)
- Q13 Claude-specific (optional, 더 명확하게 표시)

**`interview.md` 변경**:
- 코어 표: 7 필수 → 6 (Q1-Q6) + auto-3 행 (Q7/Q8/Q9는 "자동 적용" 표로 이동)
- 옵션 표: Q10만 (Q8/Q9 제거)
- 자유 응답: Q11/Q12 제거, Q13만 유지
- 자동 적용: 기존 7건 + Q7/Q8/Q9 auto 3건 = 10건 (단, Q7/Q8/Q9는 manifest 섹션에 통합)
- 세션 S3-S10 procedure 단락 → 새 흐름(R2)으로 교체

### R2 — Stage 8로 축소

**제거**:
- S9 (README 등록): 삭제. 근거: README에 프로젝트 목록을 매번 업데이트하는 가치 < 비용. 공개 contributor가 늘어나면 자연히 AGENTS.md/README에 프로젝트 등장.

**통합**:
- S3 (render preview) + S4 (manifest write+verify) → **S3** (write+preview+verify, 1-turn)
  - `render-manifest.sh` 실행 후 stdout을 파일로 바로 write
  - 결과 manifest를 Claude가 인라인으로 사용자에게 보여줌 + "확정?" 확인
  - S4의 round-trip 검증(name/code_dir/phases_dir grep+sed)은 write 직후 동일하게 수행

**재번호**:

| 신규 # | 기존 # | 단계 |
|--------|--------|------|
| S0 | S0 | 모드 진입 확인 |
| S1 | S1 | detect-project.sh |
| S2 | S2 | 인터뷰 (7Q, 1-turn) |
| S3 | S3+S4 | manifest write+preview+verify |
| S4 | S5 | 부수 자산 (AGENTS.md, CLAUDE.md, GUARDRAILS, .gitkeep) |
| S5 | S6 | .claude/ 배포 (install-project-claude) |
| S6 | S7+S8 | 아키텍처 기록 (4종) + 세션 기록 (PLAN+REPORT) |
| S7 | S10 | 후속 안내 (+ Q11/Q12 채우기 안내 추가) |

**S6에 Q11/Q12 흡수**: INTERVIEW.md 스켈레톤에 Q11/Q12 placeholder 유지. 단 비어있어도 bootstrap 진행. S7 안내에서 "ARCHITECTURE.md/STACK.md의 observability/CI 항목 후속 작성" 안내.

### R3 — `INTERVIEW.md` 스켈레톤 단순화 (143L → ~50L)

- Q7/Q8/Q9 블록 제거 (자동 적용이므로 인터뷰 기록 불필요)
- Q11/Q12/Q13 블록 제거 (post-bootstrap 자유 기록 → 별도 별칸 or 생략)
- 자동 적용 7건 표: 핵심 3건(bootstrap_version/install_cmd/license)만 간략 기록
- 결과: Q1–Q6 + Q10 기록 (7 Q블록 × ~5줄 = ~40줄 + 헤더/푸터)

### R4 — 문서 업데이트 (3파일)

**`claude/commands/harness-meta.md`** Bootstrap 표:
- 10행 → 8행 (S9 제거, S3+S4 통합, S10→S7)
- 제목: "10-stage" → "8-stage"
- S2 설명: "13 질문" → "7 질문 (Q7/Q8/Q9/Q11/Q12 자동/이연)"

**`bootstrap/docs/INTERVIEW_FLOW.md`**:
- §2 stage 표: 10행 → 8행
- §3 데이터 전달 S2→S3 매핑 표: Q7/Q8/Q9 행 삭제 또는 "auto" 표시
- §4 실패 정책 표: S3/S4 행 → S3으로 통합, S9 제거

**`CLAUDE.md`**:
- "Bootstrap 모드 (신규 프로젝트 도입, 10-stage)" 제목 → 8-stage
- 표: S9 행 제거, S3+S4 통합, S10→S7

## 3. 변경 대상 (5 수정)

| 경로 | scope | 변경 |
|------|------|------|
| `claude/commands/harness-meta.md` | S1a | R2+R4 — Bootstrap 표 8행 + S2 설명 7Q |
| `bootstrap/interview.md` | S2 | R1 — Q7/Q8/Q9/Q11/Q12 제거, 자동 적용 갱신, S3-S10 procedure → 새 S3-S7 |
| `bootstrap/docs/INTERVIEW_FLOW.md` | S2 | R4 — stage 표 + 데이터 전달 표 갱신 |
| `bootstrap/skeletons/projects/INTERVIEW.md` | S2 | R3 — 143L → ~50L |
| `CLAUDE.md` | S3 | R4 — Bootstrap 표 mirror (harness-meta.md와 동기) |

## 4. 성공 기준

- [ ] Bootstrap 흐름: 10 stages → 8 stages (`harness-meta.md` Bootstrap 표)
- [ ] Interview: 13Q → 7 effective (Q7/Q8/Q9 auto, Q11/Q12 post-bootstrap 이연)
- [ ] S3+S4 통합: `harness-meta.md` + `INTERVIEW_FLOW.md`에서 단일 S3로 표기
- [ ] S9 제거: 3개 문서에서 S9(README 등록) 행/단락 삭제
- [ ] `INTERVIEW.md` 스켈레톤: Q7/Q8/Q9/Q11/Q12/Q13 블록 제거 → ~50L
- [ ] `CLAUDE.md` Bootstrap 표: `harness-meta.md`와 동기
- [ ] 기존 smoke 회귀 0 (`tests/smoke-bootstrap-*.sh`, `smoke-language-overlay.sh`, `smoke-scope-contract.sh`)

## 5. 커밋 전략

```
feat(meta): sessions/meta/v1.14-bootstrap-simplify — Bootstrap 10 stages → 8 stages, 13Q → 7Q

- update: claude/commands/harness-meta.md — Bootstrap table 10→8 stages (S9 removed, S3+S4 merged)
- update: bootstrap/interview.md — interview 13Q → 7 effective (Q7/Q8/Q9 auto, Q11/Q12 deferred)
- update: bootstrap/docs/INTERVIEW_FLOW.md — stage table + data flow table sync
- update: bootstrap/skeletons/projects/INTERVIEW.md — 143L → ~50L (remove Q7-Q9/Q11-Q13 blocks)
- update: CLAUDE.md — Bootstrap table mirror (harness-meta.md sync)
- add: sessions/meta/v1.14-bootstrap-simplify/{PLAN,REPORT}.md
```

## 6. 후속

- v1.15: AGENTS.md.tmpl Q11/Q12 observability/CI 섹션 → skeleton 갱신
- v1.21: `install.sh` macOS/Linux Stage 1 지원 (`install.ps1` 상대)
- v1.14~v1.20 (adapter): Cursor, Codex, Gemini 각 overlay 도입
