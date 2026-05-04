# meta v1.10b-bootstrap-agents-md — REPORT

세션 기간: 2026-04-27 (단일 세션, PLAN 8 라운드 검토 후 옵션 B strict 적용)
세션 범위: v1.5 규약 §6 시나리오 A를 v1.10 Bootstrap 흐름의 S5 sub-step에 통합
판정: **PASS** (성공 기준 13/13, smoke 6/6 PASS)

**세션 소속 (self-apply)**: `sessions/meta/`. 신규 3 (S2) + 수정 10 (S2:7 + S1a:1 + S3:2) = **13/13 meta**. T1 다수결 + T2 스펙 정의.

## 옵션 B 분할 결정 (검토 8 라운드 누적 후)

PLAN 검토 라운드 누적으로 PLAN 비대화 인지 (250줄 → 600줄, Grey Area 12→28). 사용자의 "기초 강화" 원칙에 따라 v1.10b 본질만 유지 + 콘텐츠 자동화는 v1.10c로 분리.

**v1.10b 본질 (3 산출 + 부수 갱신)**:

- AGENTS.md.tmpl 영문 baseline (8 sections, ~80 라인, bootstrap_version stamp + footer link)
- CLAUDE.md.tmpl 재작성 (3 import: `@AGENTS.md` + `@~/harness-meta/projects/<name>/ARCHITECTURE.md` + 조건부 `@CLAUDE.override.md`)
- CLAUDE.override.md.tmpl 옵션 (Q13 트리거)
- v1.10 자산 갱신 (interview.md / INTERVIEW_FLOW.md / projects skeleton / sessions skeleton / slash command)

**v1.10c 후속 이연 (콘텐츠 자동화)**:

- license sed `MIT` default
- install_cmd 17개 PM 매핑 (Claude Bootstrap 매핑)
- Stage S3 preview 콘텐츠 default 표
- install_cmd vs build_cmd 분리 (cargo)

## 최종 결과

- **신규 자산 3 + smoke 1 + 세션 기록 3**:
  - `bootstrap/skeletons/AGENTS.md.tmpl` (~80 라인, 8 sections)
  - `bootstrap/skeletons/CLAUDE.override.md.tmpl` (Q13 응답 시만 생성)
  - `tests/smoke-bootstrap-agents-md.sh` (6 stage / 4 검증 포인트)
  - `sessions/meta/v1.10b-bootstrap-agents-md/{PLAN.md, REPORT.md, evidence/smoke-bootstrap-agents-md.txt}`
- **수정 10 파일**:
  - `bootstrap/skeletons/CLAUDE.md.tmpl` 재작성 (3 import)
  - `bootstrap/interview.md` (Q13 추가, UX 12→13, 카운트 본문)
  - `bootstrap/docs/INTERVIEW_FLOW.md` (S5 sub-step a-e + tmpl 변수 매핑 파일별 분리 + Q13 env 미매핑 + idempotency backup 일원화 + @import depth ≤ 5)
  - `bootstrap/skeletons/projects/INTERVIEW.md` (Q13 자리 + omit 7→9 + 자동 적용 4→5)
  - `bootstrap/skeletons/sessions/v0.1-bootstrap/PLAN.md` (S5 sub-step a-e 체크박스)
  - `bootstrap/skeletons/sessions/v0.1-bootstrap/REPORT.md` (S5 sub-step 표)
  - `claude/commands/harness-meta.md` (Stage S2/S5 갱신 — 12→13 + sub-step a-e)
  - `CLAUDE.md` / `README.md` (AGENTS.md baseline 명시 + 최신 meta 세션 v1.10b)

## smoke 6 stage 결과 (`evidence/smoke-bootstrap-agents-md.txt`)

```
[Stage 1] AGENTS.md.tmpl 8 sections PASS (공식 agents.md sample 4 § 일치 + PLAN 고유 4 §)
[Stage 2] AGENTS.md.tmpl 13 sed vars + placeholders + README relation + footer link PASS
[Stage 3] CLAUDE.md.tmpl 3 imports PASS
[Stage 4] sed 13-var + bootstrap_version stamp + license/install_cmd placeholder 잔존 PASS — {{ 잔존 0
[Stage 5] absolute path 0 + Do/Don't 5 + Boundaries 3 backups PASS
[Stage 6] CLAUDE.override.md.tmpl marker + header + Q13 § PASS

PASS — bootstrap agents-md smoke (6 stages, v1.10b strict)
```

**검증 4 포인트**:

1. AGENTS.md.tmpl 8 sections (Setup commands / Code style / Project structure / Session workflow / Testing instructions / PR instructions / Boundaries / Status — 공식 agents.md sample 4 § 일치 + PLAN 고유 4 §)
2. CLAUDE.md.tmpl 3 import — `@AGENTS.md` (시나리오 A) + `@ARCHITECTURE.md` (v1.10 본문) + `@CLAUDE.override.md` (조건부, N1)
3. sed 13 변수 치환 + bootstrap_version stamp + license/install_cmd placeholder 잔존 (v1.10c 후속 마커)
4. absolute path 0 + Do/Don't 5 + Boundaries 3 `.harness/backups/` (W17)

## 구현 요약 — PLAN 13/13

| # | 목표 | 결과 |
|---|------|------|
| 1 | AGENTS.md.tmpl (영문 baseline, 8 sections, ~80 라인) | ✅ |
| 2 | CLAUDE.md.tmpl 재작성 (3 import) | ✅ |
| 3 | CLAUDE.override.md.tmpl (Q13 응답 시만) | ✅ |
| 4 | interview.md (Q13 + sanity + UX 13) | ✅ |
| 5 | INTERVIEW_FLOW.md (S5 sub-step + tmpl 매핑 파일별 + Q13 + backup 일원화 + @import depth) | ✅ |
| 6 | projects/INTERVIEW.md (Q13 + omit 9 + 자동 적용 5) | ✅ |
| 7 | projects/ARCHITECTURE.md (v1.10b 후속 stamp 정정 — generic 표기 이미 OK) | ✅ |
| 8 | sessions/v0.1-bootstrap/{PLAN,REPORT}.md (S5 sub-step a-e) | ✅ |
| 9 | slash command (S2 12→13 + S5 sub-step) | ✅ |
| 10 | smoke 6 stage PASS | ✅ |
| 11 | CLAUDE.md / README.md 갱신 | ✅ |
| 12 | Grey Area 21 본질 + 7 v1.10c 이연 | ✅ |
| 13 | REPORT 본 파일 | ✅ |

## Grey Area 28 결정 반영 결과

**v1.10b 본질 21건**: G1 (영문 강제) / G2 (3 import) / G3 (override 옵션) / G4 (root만) / G5 (~80 라인) / G6 (locale 안내) / G7 (충돌 backup) / G8 (v1.5b 패턴) / G9 (v0.1 고정) / G10 (adapter 분리) / G11 (smoke 위치) / G12 (upbit retroactive 분리) / G14 (Q13 sanity) / G15 (section 명칭 공식) / G17 (bootstrap_version stamp) / G18 (skeleton 위치) / G19 (CLAUDE.md 3분기) / G20 (import depth ≤ 5) / G21 (Korean note 중복 제거) / G26 (Testing instructions §) / G27 (footer link).

**v1.10c 이연 7건**: G13 (license `MIT` default) / G16 (install_cmd 17 PM 매핑) / G22 (S3 preview 콘텐츠 default 표) / G23 (License MIT 안내) / G24 (install_cmd vs build_cmd 분리).

**별도 후속 세션 분리**: G28 (Bash permission pattern audit) → v1.10d.

## Lessons Learned

1. **PLAN 검토 8 라운드 = 본질 + 보강 자연 누적** — 초기 PLAN (250줄) → R 라운드 (스코프 정합) → M+W (실 동작 안전) → S (자체 일관성) → NN (context7 cross-reference) → 옵션 B 분할 (~600 → 본질만). **검토는 스코프를 확장시키는 자연 압력이 있다 — 의식적으로 본질·보강 구분 + T4 분할 적용** 필수.

2. **옵션 B T4 분할의 효용** — v1.10b 본질 (3 산출) + v1.10c 보강 (콘텐츠 자동화) 분리 후 각 세션 단일 책임 명확. v1.10b 적용 후 사용자가 즉시 사용 가능 (license/install_cmd 라인은 placeholder로 직접 편집 가능). v1.10c 적용 시 자동화 완성. 한 번에 너무 많이 하지 않음.

3. **`Bootstrap version: v1.10b` stamp 자동 갱신 (N27) 본질 vs 보강** — 단순 sed 1줄로 미래 갱신 비용 ↓. 본 세션 유지 결정 (v1.10c 이연 안 함). 보강이지만 비용 trivial.

4. **v1.5 §6 시나리오 A 적용 — `@CLAUDE.override.md` import 라인 (N1)이 결정적** — context7 검증으로 부재 파일 silent skip 동작 미확인 → 안전 분기 (Q13 응답 시만 import + 파일 둘 다 생성). 미보증 동작에 의존하지 않음.

5. **공식 agents.md sample 4 § 일치 (W5+W11+W15+N14+N21)** — Setup commands / Code style / Testing instructions / PR instructions. cross-tool 호환 (Codex / Cursor / Gemini / Copilot 공식 인식). PLAN 고유 4 § (Project structure / Session workflow / Boundaries / Status)는 harness-meta 운영 정책. Dev environment tips (공식 5번째)는 monorepo 위주 → v1.23로 이연.

6. **AGENTS.md placeholder 주석 + sed 변수 마커 충돌** — `<!-- v1.10c: ({{install_cmd}}) -->` 같은 주석 안 변수 마커가 smoke `! grep -q '{{'` 검증에 fail. 주석에서 `{{}}` 제거 후 PASS. **placeholder 표기 시 sed 마커 주의**.

7. **PLAN 자체 일관성 회귀 패턴** — 검토 라운드마다 카운트 갱신 (12→13 / 4→5 / 7→9 / 25→28) 시 **6~10 위치에 stale 잔존**. grep 명령으로 stale 검증 + 일괄 정정 패턴 정착. 본 세션도 NN 라운드에서 stale 8 위치 정정.

## 후속 세션 연결

### 직접 연계

- **v1.10c-bootstrap-content-defaults** (S2, T4 분할) — license + install_cmd 자동화:
  1. `License: see LICENSE` → `License: {{license}}` + sed `MIT` default
  2. `Install deps: <see project README>` → `Install deps: {{install_cmd}}` + Claude(Bootstrap) 17 PM 매핑
  3. AGENTS.md.tmpl sed 13 → 15
  4. 자동 적용 manifest 4 + 콘텐츠 1 (v1.10b) → manifest 4 + 콘텐츠 3 (v1.10c)
  5. Stage S3 preview 콘텐츠 default 표 example 명세
  6. install_cmd vs build_cmd 분리 (cargo)
- **v1.10d-bash-permission-pattern-audit** (S1a, T4 분할) — context7 공식 (`Bash(cmd:*)` 콜론) vs PLAN v1.10 (`Bash(cmd*)` 콜론 없음) 패턴 audit
- **v1.11~v1.13 bootstrap-templates** (S2) — language overlay (Python/TS/Go/Rust)
- **v1.14~v1.20 adapter-{cursor,gemini,...}** (S2) — adapter 7종 매핑 파일
- **v1.21-cross-platform-install** (S3) — symlink/copy 자동 분기
- **v1.23-monorepo-polyglot** (S2) — nested AGENTS.md + Dev environment tips §

### 적용 사례

- 신규 프로젝트 추가 시점에 본 v1.10 + v1.10b 흐름 호출 → `sessions/<new-name>/v0.1-bootstrap/`
- upbit는 별도 `sessions/upbit/vX-agents-md-migration/` (T4 분할)

## 커밋 계획

```
feat(meta): sessions/meta/v1.10b-bootstrap-agents-md — AGENTS.md baseline 통합 (옵션 B strict)

- add: bootstrap/skeletons/AGENTS.md.tmpl (영문 baseline, 8 sections, ~80 라인,
       공식 agents.md sample 4 § 일치 + PLAN 고유 4 § + bootstrap_version stamp + footer link)
- add: bootstrap/skeletons/CLAUDE.override.md.tmpl (Q13 응답 시만 생성, sanity wrap)
- update: bootstrap/skeletons/CLAUDE.md.tmpl (재작성 — 3 import: @AGENTS.md + @ARCHITECTURE.md + @CLAUDE.override.md)
- update: bootstrap/interview.md (Q13 자유 응답 + UX 12→13 + 자유 응답 카운트 본문 정정)
- update: bootstrap/docs/INTERVIEW_FLOW.md (S5 sub-step a-e + tmpl 변수 매핑 파일별 분리 +
          Q13 env 미매핑 + idempotency backup 일원화 + @import depth ≤ 5)
- update: bootstrap/skeletons/projects/INTERVIEW.md (Q13 자리 + omit 7→9 + 자동 적용 4→5)
- update: bootstrap/skeletons/sessions/v0.1-bootstrap/{PLAN,REPORT}.md (S5 sub-step a-e)
- update: claude/commands/harness-meta.md (S2 12→13 + S5 sub-step a-e)
- update: CLAUDE.md / README.md (AGENTS.md baseline 명시 + 최신 meta 세션 v1.10b)
- add: tests/smoke-bootstrap-agents-md.sh (6 stage / 4 검증 포인트)
- add: sessions/meta/v1.10b-bootstrap-agents-md/{PLAN,REPORT,evidence/smoke-bootstrap-agents-md.txt}

v1.5 규약 §6 시나리오 A 신규 프로젝트 적용 — CLAUDE.md = @AGENTS.md import.
옵션 B strict 분할 — 본 세션은 본질 (3 산출 + bootstrap_version stamp + footer link),
콘텐츠 자동화 (license MIT default + install_cmd 17 PM 매핑)는 v1.10c-bootstrap-content-defaults 후속.

Smoke 6/6 PASS — 8 sections + 13 sed 변수 + 3 imports + Q13 marker + 절대경로 0 + Do/Don't 5 + Boundaries 3 backups.
Grey Area 28건 결정 (21 본질 + 7 v1.10c 이연). PLAN 8 라운드 검토 후 옵션 B 분할 결정.
```
