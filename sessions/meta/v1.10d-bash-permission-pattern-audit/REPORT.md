# meta v1.10d-bash-permission-pattern-audit — REPORT (β scope)

세션 종료: 2026-04-27 (단일 세션 내 완료)
선행: [`v1.10b`](../v1.10b-bootstrap-agents-md/REPORT.md) (G28 분리), [`v1.10c`](../v1.10c-bootstrap-content-defaults/REPORT.md) (병렬 후속)
PLAN: [`PLAN.md`](PLAN.md)

## 최종 결과

- **변경 파일**: 9 (수정 7 + 신규 1 + 신규 smoke 1) + 세션 7 (PLAN/REPORT/audit 5/evidence 1) = 16
- **5 파일 frontmatter 5축 통합 정정**: 16 → 9 Bash 패턴 (44% 감소)
- **신규 doc**: `bootstrap/docs/PERMISSION_PATTERN.md` (~210 라인, 11 § + 9 keyword)
- **smoke**: 6 stage PASS — `evidence/smoke-bash-permission-pattern.txt`

## 구현 요약 — 5축 통합 정정

### Stage A — Audit evidence (5 파일, β scope)

| 파일 | 내용 |
|------|------|
| `audit/A1-anthropic-docs.md` | Anthropic 공식 11 verbatim 인용 (permissions/skills/settings + context7 plugin-dev conflict) |
| `audit/A2-pattern-inventory.md` | Layer 1A 5축 통합표 + Layer 1B (broad Bash 3 SKILL) + Layer 1C 16 패턴 분류 + Layer 2/3/4/5 |
| `audit/A3-redundancy-analysis.md` | 5축 통합 정정 매트릭스 + 의미 변화 검증 + (a)/(b) 시나리오 |
| `audit/A4-policy-decisions.md` | R1'-R7' 결정 (R1' revised + R6'/R7' 신규) + 별도 후속 3 세션 link |
| `audit/A5-regression-risk.md` | 5축 risk matrix (모두 🟢) + V1-V9 검증 항목 + dynamic 검증 절차 |

### Stage B — frontmatter 5축 통합 정정 (4 파일)

| 파일 | 변화 | 5축 |
|------|------|------|
| `claude/commands/harness-meta.md` | 11 → 9 Bash | A1+A2+A3+A4 (`tools:`→`allowed-tools:`, 콤마→YAML list, 공백 패턴, ls/grep 제거) |
| `_base/.claude/skills/harness-design/SKILL.md` | 1 → 0 Bash | A2+A3+A4 (콤마→list, ls 제거 — Bash 통째 제거) |
| `_base/.claude/skills/harness-plan/SKILL.md` | 3 → 1 Bash | A2+A3+A4 (콤마→list, ls/wc 제거, mkdir 공백화) |
| `_base/.claude/skills/harness-review/SKILL.md` | 1 → 0 Bash | A2+A3+A4 (콤마→list, git 제거 — review = read-only) |

**합계**: 16 → 9 Bash 패턴 (-7, 44% 감소). A1 1건 + A2 4건 + A3 9건 + A4 7건 통합.

### Stage C — `bootstrap/docs/PERMISSION_PATTERN.md` 신규 (~210 라인, 11 §)

§ 1. 결정 / § 2. 필드명 매트릭스 / § 3. Separator / § 4. 패턴 형식 / § 5. 자동 허용 set / § 6. fragile / § 7. compound + wrapper / § 8. harness-meta 정책 / § 9. settings 마이그레이션 / § 10. verify 체크리스트 / § 11. 관련 문서.

### Stage D — Documentation 정합 (3 파일)

- `CLAUDE.md`: 최신 meta 세션 v1.10c → v1.10d + PERMISSION_PATTERN.md link 추가
- `README.md`: 동상
- `bootstrap/docs/OWNERSHIP.md`: Evolution 조항에 v1.10d 신설 (S1a 1 + S1b 3 + S2 2 cross-cutting precedent)

### Stage E — Smoke (6 stage PASS)

`tests/smoke-bash-permission-pattern.sh` 신규 — 6 stage:

- V1 (A3): 콜론 없는 패턴 잔존 0 → PASS (4/4 파일)
- V5 (A4): 자동 허용 set declare 잔존 0 → PASS (4/4)
- V7 (A1): `allowed-tools:` 필드명 정합 → PASS
- V8 (A2): single-line 콤마 separator 잔존 0 → PASS (4/4)
- V9 (A2): YAML list 형식 (≥3 항목/파일) → PASS (14/5/6/3 항목)
- V4 (R5'): PERMISSION_PATTERN.md 존재 + 9 keyword → PASS

evidence: `evidence/smoke-bash-permission-pattern.txt`.

## 판정 (PLAN 체크박스)

- [x] audit/A1-A5 5 파일 작성 (β scope)
- [x] 4 파일 frontmatter 5축 통합 정정 (16 → 9 Bash 패턴)
- [x] `bootstrap/docs/PERMISSION_PATTERN.md` 신규 (~210 라인, 11 § — PLAN 추정 140-160 라인 초과, 5축 매트릭스 + 사용자 마이그레이션 가이드 + verify 체크리스트로 확장)
- [x] `bootstrap/docs/OWNERSHIP.md` Evolution 1줄
- [x] `CLAUDE.md` / `README.md` 최신 meta 세션 v1.10d
- [x] `tests/smoke-bash-permission-pattern.sh` 6 stage PASS
- [x] `evidence/smoke-bash-permission-pattern.txt`
- [x] REPORT.md 작성
- [ ] **사용자 확인 후 단일 커밋 + push** ← 진행 대기

**PLAN 8/9 완수**. 마지막 1건 (커밋 + push)은 사용자 확인 대기.

## 사용자 사이드 dynamic 검증 (V3)

**판별 시나리오**:

- (a) **현재 declare 무효 → 정정 후 정상 작동**: 사용자 정정 후 `/harness-meta` 진입 시 `mkdir foo` 등 명령 prompt **빈도 감소** 관찰
- (b) **현재 lenient 작동 → 정정 후 동일**: 변화 인지 못함 (정상)

**검증 명령** (사용자 직접):

1. 정정 commit 후 첫 `/harness-meta` 진입 (slash command 정상 인식 확인)
2. 진입 후 다음 명령 prompt 발생 여부:
   - `git status` — prompt 없음 기대 (자동 허용)
   - `mkdir foo` — pre-approval 작동 시 prompt 없음
   - `bash script.sh` — 동상
3. `/harness-design`, `/harness-plan`, `/harness-review` skill 정상 호출

→ 사용자 관찰 결과 본 REPORT의 별도 commit 또는 후속 세션 메모로 기록 권장.

## Lessons Learned

1. **Audit는 가설 검증보다 spec 전수 조사가 본질** — α scope (콜론 추가) 가설로 직진 시 발견 2 (`tools:` 필드명) + 발견 3 (콤마 separator 모호성) 누락. 사용자의 "디테일하게 분석" 요청 후 12 발견 종합 → β scope 확장. PLAN 작성 후 검증 단계가 audit 본질 결정
2. **공식 docs 다중 source cross-check** — context7 plugin-dev (콜론 + 콤마) vs skills docs (공백 + YAML list) conflict는 단일 source 의존 시 spec 차이로 오인. dominant source 식별 (skills docs canonical 채택) + minor source 보조
3. **`allowed-tools` semantics 정확화** — pre-approval (NOT 제한). 제거 = 차단 아님 = baseline 폴백. mental model 정정 후 R2' redundant 제거 정당화
4. **YAML list 형식 = separator 모호성 차단** — 공식 spec verbatim "space-separated string or YAML list". YAML list가 unambiguous + 가독성 + 확장성 (D2-b 채택)
5. **5축 통합 단일 commit** — 부분 적용 (콜론만 + 필드명 안 함) 시 정합성 깨짐. β scope 단일 commit으로 통합 정정
6. **fragile warning 존중** — argument 제약 fine-grain은 공식 명시 fragile. PreToolUse hook + deny rule 별도 인프라 (v1.21+ 또는 별도 보안 세션)
7. **dynamic 검증은 REPORT 단계** — frontmatter 정정의 실제 영향은 사용자 사이드 prompt 빈도 변화로만 판별. (a)/(b) 시나리오 관찰 → 후속 세션 또는 메모 기록

## 다음 후보 (보류 / 후속)

| 세션 | scope | 내용 | 상태 |
|------|------|------|:----:|
| `v1.10f-broad-bash-fine-grain` | S1b | 발견 6 — `harness/`, `harness-run/`, `harness-ship/` SKILL의 broad `Bash` declare 분석 | 보류 (D3-b) |
| `v1.10g-skill-thinking-effort` | S1b | 발견 12 — `thinking: high` vs `effort:` 검증 | 보류 (D4) |
| `sessions/upbit/v1.2-bash-permission-update/` | S6 (T4 후행) | upbit deployed 6 SKILL + settings 36 패턴 5축 통합 정정 + deny 7 fragile 재설계 (PreToolUse hook 또는 ask 전환) | upbit 측 진행 대기 |
| `v1.10e-detect-license` | S2 | License 안전 처리 — detect-project.sh가 LICENSE SPDX 헤더 추출 | v1.10c 폐기 결정 후속 |
| `v1.21-cross-platform-install` | S3 | verify.ps1에 V1+V5+V7+V8+V9 통합 | 미래 |

## 변경 파일 목록 (9 modified + 7 신규 = 16)

### 수정 (9)

- `claude/commands/harness-meta.md`
- `bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md`
- `bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md`
- `bootstrap/templates/_base/.claude/skills/harness-review/SKILL.md`
- `bootstrap/docs/OWNERSHIP.md`
- `CLAUDE.md`
- `README.md`

### 신규 (9)

- `bootstrap/docs/PERMISSION_PATTERN.md` (~210 라인)
- `tests/smoke-bash-permission-pattern.sh`
- `sessions/meta/v1.10d-bash-permission-pattern-audit/PLAN.md`
- `sessions/meta/v1.10d-bash-permission-pattern-audit/REPORT.md`
- `sessions/meta/v1.10d-bash-permission-pattern-audit/audit/A1-anthropic-docs.md`
- `sessions/meta/v1.10d-bash-permission-pattern-audit/audit/A2-pattern-inventory.md`
- `sessions/meta/v1.10d-bash-permission-pattern-audit/audit/A3-redundancy-analysis.md`
- `sessions/meta/v1.10d-bash-permission-pattern-audit/audit/A4-policy-decisions.md`
- `sessions/meta/v1.10d-bash-permission-pattern-audit/audit/A5-regression-risk.md`
- `sessions/meta/v1.10d-bash-permission-pattern-audit/evidence/smoke-bash-permission-pattern.txt`
