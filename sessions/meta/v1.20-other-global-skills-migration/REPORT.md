# meta v1.20-other-global-skills-migration — REPORT

세션 종료: 2026-04-29
선행 세션:
- [`sessions/meta/v1.19-scorer-skill-distribution/`](../v1.19-scorer-skill-distribution/REPORT.md) — S1c 신규 + `install-skills` opt-in 인프라
- [`sessions/meta/v1.10j-scope-contract-discipline/`](../v1.10j-scope-contract-discipline/REPORT.md) — Scope contract 의무화

## 최종 결과

- **신규 파일 3건**: `bootstrap/skills/{mindvault,developer-profile}/SKILL.md` + 본 세션 PLAN/REPORT
- **수정 파일 3건**: `bootstrap/docs/SKILLS.md`, `tests/smoke-skills-install.sh`, `CLAUDE.md` (추가 검토 단계 stale 1줄 정정)
- **install-skills 코드 변경 0건** — auto-enumerate 기능 활용 (R5 정정)
- **Smoke**: 정적 7/7 PASS (5 → 7 확장). dynamic은 Windows 환경상 skip (Linux/Darwin only)
- **회귀 0**: ai-ready-scorer install/symlink 영향 0 (`already symlinked (no-op)` 확인)
- **upbit 영향 0**: `bootstrap/skills/`는 글로벌 user-skill source-of-truth 전용. 프로젝트별 `<proj>/.claude/skills/`와 분리

## 구현 요약

### Stage A — `bootstrap/skills/mindvault/SKILL.md` 신규 (R1)

원본: `~/.claude/skills/mindvault/SKILL.md` (9.7 KB, single-line frontmatter — upstream 그대로).

처리:
- frontmatter `--- name: ... ---` single-line → multi-line YAML 변환
- 본문 9.7 KB single-line → 정상 markdown (heading · code-fence · paragraph 분리)
- 상단 메타블록 추가:
  ```
  > Upstream: etinpres/mindvault (archived 2026-04-14, MIT license)
  > Local divergence (harness-meta v1.20): multi-line YAML frontmatter + markdown reformat. 의미 변경 없음.
  > Alternative: graphify (active).
  ```
- `disable-model-invocation: true` 추가 — PyPI `pip install mindvault-ai` + git post-commit hook side effect 차단
- `trigger: /mindvault` 필드 보존 (upstream 그대로 — Claude Code spec 외 silent ignore이지만 upstream parity 유지)
- **의미 변경 0** — instruction · code block · trigger keyword · output format 모두 보존

### Stage B — `bootstrap/skills/developer-profile/SKILL.md` 신규 (R2)

원본: `~/.claude/skills/developer-profile/SKILL.md` (750 bytes, multi-line YAML 정상).

처리: byte-for-byte 보존 (`diff` 결과 IDENTICAL 확인).
- `user-invocable: false` 유지 — 메뉴 숨김 + Claude 자동 로드 의도 정확 (Issue #19141 spec 정합)
- 콘텐츠 수정 0

### Stage C — symlink 교체 (R3)

```
$ bash install-skills.sh --all
[INFO] Windows detected — delegating to install-skills.ps1 (pwsh)
[INFO] ai-ready-scorer: already symlinked (no-op)
[WARN] developer-profile: backed up to ~/.claude/backups/skills/developer-profile.20260429-035422
[OK]   developer-profile: symlinked
[WARN] mindvault: backed up to ~/.claude/backups/skills/mindvault.20260429-035422
[OK]   mindvault: symlinked
```

작동 검증 (PowerShell `Get-Item -Force`):
```
ai-ready-scorer    | LinkType=SymbolicLink | Target=C:\Users\qkreh\harness-meta\bootstrap\skills\ai-ready-scorer
developer-profile  | LinkType=SymbolicLink | Target=C:\Users\qkreh\harness-meta\bootstrap\skills\developer-profile
mindvault          | LinkType=SymbolicLink | Target=C:\Users\qkreh\harness-meta\bootstrap\skills\mindvault
```

### Stage D — `bootstrap/docs/SKILLS.md` 갱신 (R4)

- `§ 1 개요` 직후 **§ "현 상태 — 매트릭스 (3 skill)"** 추가:
  - 표: skill / invocation 정책 / trigger / 도입 세션
  - `user-invocable` vs `disable-model-invocation` 직교 차이 명시 (Issue #19141 인용)
- `§ 7` (v1.19 사례) 직후 **§ 7b "v1.20 이관 사례 (mindvault + developer-profile)"** 추가:
  - 두 skill의 invocation 정책 차이
  - mindvault upstream archived 경고 + 폐기 사유 + graphify 대안
  - 절차 (4 step) + 효과 표
- 기존 § 7 (v1.19 사례) · § 8 (추가 절차) · § 9 (후속 분기) · § 10 (관련 문서)는 그대로 유지

### Stage E — `tests/smoke-skills-install.sh` 매트릭스 확장 (R5)

- 헤더 `v1.20+` 표기 추가
- 정적 5 → 7 checks:
  - ✓ mindvault SKILL.md 존재 + `disable-model-invocation: true` grep + `archived 2026-04-14` grep
  - ✓ developer-profile SKILL.md 존재 + `user-invocable: false` grep
- dynamic 3 (Linux/Darwin) 그대로 유지

### Stage F — 작동 검증

| 검증 | 결과 |
|------|------|
| `bash tests/smoke-skills-install.sh` | 정적 7/7 PASS |
| `bash install-skills.sh --list` | 3 skill 모두 노출 |
| `Get-Item -Force` LinkType (3 skill) | 모두 SymbolicLink + Target 정확 |
| `diff` developer-profile | IDENTICAL (byte-for-byte) |
| ai-ready-scorer no-op 확인 | `already symlinked (no-op)` |

### Stage F2 — 추가 검토 (사용자 발의 후 진행)

추가 검토 4 항목 + 발견 1건:

1. **mindvault 의미 변경 0 — token-level 검증** ✓
   - 메타블록 + `disable-model-invocation` 제외 후 token 비교: `old=2981, new=2981, removed=0, added=0`
   - 본문 instruction · code block · trigger keyword 0건 변경

2. **ai-ready-scorer 재스코어 — 회귀 0** ✓
   - `92/100 (S)` 그대로 (v1.18c 이후 baseline 동일)
   - 카테고리 분포 7개 모두 변동 0
   - mindvault + developer-profile 신규 디렉토리 추가의 부수효과 없음

3. **THIRD_PARTY attribution — 이미 충족** ✓
   - mindvault SKILL.md 헤딩 메타블록 `> Upstream: ... (MIT license)` 명시
   - harness-meta MIT × upstream MIT 호환

4. **README.md / CLAUDE.md cross-ref stale 점검** — **이슈 1건 발견**
   - `CLAUDE.md` L97 `"v1.19+: ai-ready-scorer"` — 단일 skill 표기, 3 skill로 확장됨에도 stale
   - **처치**: `"v1.19+) — see bootstrap/docs/SKILLS.md §1"`로 위임 형태로 정정 (1줄 수정)
   - SKILLS.md §1 매트릭스가 단일 소스 — CLAUDE.md는 매번 갱신 회피

### Stage F3 — CLAUDE.md L97 정정 (Stage F2 발견 처치)

```diff
-│   ├── skills/<name>/              # 글로벌 user-skill source (v1.19+: ai-ready-scorer)
+│   ├── skills/<name>/              # 글로벌 user-skill source (v1.19+) — see bootstrap/docs/SKILLS.md §1
```

효과:
- 향후 글로벌 skill 추가/제거 시 CLAUDE.md 갱신 의무 0 (단일 소스 = SKILLS.md §1)
- 본 v1.20 변경 외에도 v1.21+ 후속에 자동 적용

## 판정

PLAN 체크박스 vs 실제:

- [x] `bootstrap/skills/mindvault/SKILL.md` 존재 + multi-line YAML + 본문 markdown 정상 + upstream divergence 메타 + `disable-model-invocation: true`
- [x] `bootstrap/skills/developer-profile/SKILL.md` 존재 + `user-invocable: false` 유지
- [x] **의미 변경 0** — re-format only (mindvault) / byte-for-byte (developer-profile)
- [x] `bash install-skills.sh --list` 출력에 3 skill 모두 노출
- [x] `~/.claude/skills/{mindvault,developer-profile}` symlink 작동
- [x] `bootstrap/docs/SKILLS.md`: § 현 상태 표 + § 7b 이관 사례 + upstream archived 경고
- [x] `tests/smoke-skills-install.sh` 정적 7/7 PASS
- [x] **회귀 0** — ai-ready-scorer no-op
- [x] **upbit 영향 0**

**모든 성공 기준 PASS.**

## 외부 evidence (PLAN 작성 시 수집, 2026-04-29)

| 항목 | 발견 | 본 세션 반영 |
|------|------|-----------|
| `etinpres/mindvault` | archived 2026-04-14 (MIT). 저자 폐기 선언 | mindvault SKILL.md 메타블록 + SKILLS.md § 7b 경고 |
| `mindvault-ai` PyPI | active (PyPI 페이지 자체는 fetch 실패 — JS-rendered) | 본문 보존, archived 영향 사용자 책임 |
| graphify (alternative) | graphifyy on PyPI active | SKILLS.md § 7b alternative 명시 |
| Issue #19141 | `user-invocable` vs `disable-model-invocation` 직교 명확화 | SKILLS.md § 1 + 본 REPORT 명시 |
| Issue #26251 | `disable-model-invocation: true` 시 user slash 호출 막힘 bug | 외부 issue — 본 세션 무관 (observation only) |
| `install-skills.{sh,ps1}` 현 코드 | auto-enumerate `for d in "$SKILLS_SRC"/*/` 동작 중 | R5 (매트릭스 확장) scope 제거 — 디렉토리 추가만으로 충분 |

## Lessons Learned

- **L1 — 이관 전 외부 upstream 상태 검증 의무화** — 추천안 작성 시 web search 부재로 mindvault archived 사실 누락. 디테일 분석 단계에서 context7 + WebSearch 병행 후 발견. PLAN 진입 전 외부 검증 정형화 가치 확인
- **L2 — frontmatter 직교 필드 정확 매칭** — `user-invocable` vs `disable-model-invocation`은 의미 다름. skill 의도(자동 로드 / side effect 보호)에 따라 명시적 선택. mindvault → side effect 차단 / developer-profile → 자동 로드 + 메뉴 숨김
- **L3 — 인프라 재독해 후 scope 결정** — auto-enumerate 이미 동작 시 매트릭스 작업 불필요. 추천안 R5 over-engineering 제거 (8 stage → 7 stage 효율화)
- **L4 — re-format은 의미 변경 0 의무 + upstream divergence 명시** — mindvault SKILL.md 메타블록 추가 후 향후 갱신 추적 가능. byte-for-byte 보존 가능한 경우(developer-profile)는 reformat 없이 그대로
- **L5 — Stage F 검증을 Linux/Darwin 한정 dynamic + Windows 정적 + PowerShell symlink 검증의 3-way 병합** — Windows 환경에서도 LinkType 검증 가능. 향후 v1.21에서 Windows dynamic 통합 가치 확인

## 다음 후보 (보류)

| 후속 세션 | 트리거 조건 |
|-----------|----------|
| `v1.20b-graphify-evaluation` | 사용자가 graphify 도입 의향 명시 시 |
| `v1.21-cross-platform-install` | install-skills + sync-agents 통합. macOS/Linux dynamic 확장. PowerShell smoke 통합 |
| `v1.22-skills-categories` | `bootstrap/skills/<category>/<name>/` 2단계. 5+ skill 누적 후 |
| `vX-mindvault-self-fork` | PyPI `mindvault-ai` unpublish 발생 시 evidence-driven |

## 변경 파일 매트릭스

| 경로 | 상태 | scope |
|------|------|------|
| `bootstrap/skills/mindvault/SKILL.md` | 신규 | S1c |
| `bootstrap/skills/developer-profile/SKILL.md` | 신규 | S1c |
| `bootstrap/docs/SKILLS.md` | 수정 (§ 추가 2건) | S2 |
| `tests/smoke-skills-install.sh` | 수정 (정적 5 → 7) | S3 |
| `CLAUDE.md` | 수정 (L97 stale 1줄, F2 발견) | S3 |
| `sessions/meta/v1.20-.../{PLAN,REPORT}.md` | 신규 | meta |

총 **5 + 3 = 8 파일 변경** (코드 변경 0, 문서 + 정적 자산 only).

## Lessons Learned 추가 (F2 단계)

- **L6 — 추가 검토 단계의 token-level 의미 등가 검증** — re-format 작업의 의미 변경 0 검증을 token 비교로 자동화. 단순 line count 비교 대신 `tokenize → diff` 방식. 향후 reformat 류 세션에 정형화 가치
- **L7 — cross-ref stale 차단 = "SKILLS.md §1로 위임"** — CLAUDE.md/README.md에 skill list 직접 표기 회피. 매트릭스가 변할 때마다 cross-ref 갱신 의무가 stale 위험. 단일 소스 위임 패턴 정착
