# meta v1.7-manifest-schema-v1.1 — REPORT

세션 기간: 2026-04-25 (단일 세션)
세션 범위: `.harness.toml` 스키마 v1.0 → v1.1 SemVer minor bump (additive only) + manifest-schema.md 12 섹션 재구성 + fixture + smoke
판정: **PASS** (성공 기준 12/12 충족, smoke PASS, verify 30/30 유지)

**세션 소속 (self-apply)**: `sessions/meta/`
**근거**: 변경 파일 9건 (manifest-schema.md + OWNERSHIP.md + fixture 3 + smoke 1 + 세션 3) → **S2** 전부. **T1** S2 다수결 + **T2** 스펙 변경 → meta 확정. upbit 실제 필드 추가는 T4 분할 후행 세션.

## 최종 결과

- **수정 2**: `bootstrap/manifest-schema.md` 대규모 재작성 (12 섹션 ~340 라인), `bootstrap/docs/OWNERSHIP.md` Evolution 조항 1 예시 문단
- **신규 5**: fixture 3 (`.harness.toml`, `.harness-state.txt`, `.gitkeep`) + `tests/smoke-v1.1.sh` 15라인 + evidence 1
- **세션 기록 2**: PLAN + 본 REPORT
- **smoke 결과**: PASS — hook이 state_file 주입 정상, statusline_cmd 실행 정상
- **verify.ps1**: 30/30 PASS 유지 (회귀 0)
- **Breaking change**: 0건 (additive only)

## 구현 요약 (PLAN 목표 대조)

| # | 목표 | 결과 | 구현 위치 |
|---|------|------|----------|
| 1 | manifest-schema.md 12 섹션 재구성 | ✅ | 설계원칙/변경요약/파싱제약/현버전/전체스키마/필드상세/관계/파싱표/호환매트릭스/다언어예시/파싱가이드/마이그레이션 |
| 2 | v1.0→v1.1 변경 요약 표 + 하위 호환 매트릭스 | ✅ | §2, §9 |
| 3 | bash 파싱 가능/불가 표 (dead field 명시) | ✅ | §8 — dead 6개 (schema_version, [agents] 2, [build] 3, format_cmd) |
| 4 | v1.6 선반영 정식화 (statusline_cmd/timeout_ms/state_file) | ✅ | §5, §6.3 |
| 5 | 신규 필드 9개 추가 | ✅ | runtime_version, locale, statusline_timeout_ms, [agents] 2, [build] 3, format_cmd |
| 6 | python_version deprecated retained | ✅ | §6.2 + §9 |
| 7 | 다언어 예시 4종 (Python/uv, TS/pnpm, Go, Rust) | ✅ | §10.1~10.4 |
| 8 | mcp_server vs agents.primary 관계 / guardrails vs AGENTS.md | ✅ | §7.1, §7.2 |
| 9 | OWNERSHIP.md Evolution 예시 | ✅ | "적용 사례 — v1.0 → v1.1 (2026-04-25)" |
| 10 | fixture schema-v1.1-full 4 파일 | ✅ | 3 + phases/ 디렉토리 |
| 11 | smoke-v1.1.sh + PASS evidence | ✅ | hook state_file 주입 / statusline_cmd 실행 |
| 12 | Grey Area 37건 결정 | ✅ | PLAN G1~G37 |

**완수율**: 12/12 (100%, 커밋 대기).

## smoke 실측

```
== hook (v1.1 fixture) ==
{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"## Harness state (schema v1.1 full fixture)\n- schema_version: 1.1\n- milestone: v3.0 (Example) — status: in-progress\n- phase: v3.0/0-example — 2/5 steps\n- state_file is being read correctly by session-init.sh (bash-only parse)."}}

== statusline (v1.1 fixture) ==
[v1.1]full-fixture-statusline

PASS: bash hook/statusline parses schema v1.1 fixture
```

**검증 포인트**:
- v1.6 bash hook이 **v1.1 신규 필드 파싱 회귀 없음** (additive 원칙 실증)
- `state_file` 경로의 UTF-8 내용(em-dash `—` 포함)이 `additionalContext`에 escape 정상
- `statusline_cmd` array 호출로 `printf` 인자 그대로 실행
- 6개 dead field(schema_version, [agents], [build], format_cmd)가 hook 동작에 영향 없음

## verify.ps1 30/30 회귀 확인

Z 3 · A 4 · B 7 · C 10 · D 3 · E 3 · F info · G 6 manual = **30/30 PASS** (WARN 0). v1.7 변경이 기존 smoke 영향 0건.

## Grey Area 사후 검증 (37건)

### G1~G15 (PLAN 원안)

전부 구현 반영. 특히:
- G1 python_version deprecated retained → §6.2 "deprecated (v1.0). `runtime_version` 권장"
- G2 statusline_timeout_ms 스펙 3000 → §6.3 "기본 3000. hook 구현 하드코딩 일치"
- G9 upbit 무영향 → §10 말미 "upbit는 schema 1.0 계속 작동"

### G16~G37 (심층 분석 추가)

| ID | 결정 | 구현 반영 |
|----|------|----------|
| G16 | schema_version retained | ✅ §6.1 "현 bash hook 읽지 않음. 문서화 + tomllib 미래" |
| G17 | runtime_version 통일 채택 | ✅ §6.2 "값 해석은 language 조합. 필드 인플레이션 회피" |
| G18 | SemVer semantics 명시 | ✅ §4 "MINOR bump (1.0→1.1) = additive, 호환 / MAJOR = breaking" |
| G19 | string SemVer 비교 | ✅ §4 "`\"1.10\"` > `\"1.9\"` > `\"1.1\"`" |
| G20 | 신규 프로젝트 = 1.1, 기존 무변경 | ✅ §9, §12.1 |
| G21 | 섹션 순서 권장 | ✅ §3 "project → harness → agents → architecture → build → testing → notifications" |
| G22 | [agents].primary 해석 v1.8+ | ✅ §6.4 "실 해석 시점: v1.8-core-adapter-split" |
| G23 | [agents].secondary 배열 bash 불가 | ✅ §6.4, §8 bash grep "X" 표시 |
| G24 | locale bootstrap(v1.10+) 해석 | ✅ §6.2 "실 해석 bootstrap(v1.10+)" |
| G25 | [build] 선언만, v1.8+ | ✅ §6.6 "실 해석 시점: v1.8+ harness-ship" |
| G26 | format_cmd 선언만, v1.8+ | ✅ §6.7 "실 해석 v1.8+ harness-review" |
| G27 | statusline_timeout_ms 스펙 3000 | ✅ §6.3 구현 일치 |
| G28 | mcp_server vs agents.primary 관계 | ✅ §7.1 전용 문단 |
| G29 | guardrails vs AGENTS.md 분리 | ✅ §7.2 전용 문단 |
| G30 | 12 섹션 구성 | ✅ |
| G31 | upbit 참고 언급 | ✅ §10 말미 |
| G32 | bash 파싱 표 + dead field | ✅ §8 완전한 표 27행 |
| G33 | smoke 스크립트 + evidence | ✅ tests/smoke-v1.1.sh + evidence 캡처 |
| G34 | deprecated 문서만 (WARN 주체 없음) | ✅ §6.2 |
| G35 | 추가 필수 0개 (additive) | ✅ §9 "필수 추가 0" |
| G36 | 트레일링 주석 허용 | ✅ §3 "`key = "val"  # comment` OK" |
| G37 | inline table 금지 유지 | ✅ §3 |

**37/37 결정 반영.** 구현 중 재논의 없음.

## Lessons Learned

1. **pyproject.toml `semantics-version` 거부 전례의 무게감**: [PEP 518](https://peps.python.org/pep-0518/)이 명시적으로 거부 ("premature optimization"). 우리는 유지했으나 **dead field** 현황을 정직히 §8에 표기함으로써 미래 제거 가능성도 문서화. 3rd-party 도구/v2.0 parser가 도입되면 역할 부여, 그전까지는 문서화 가치만.

2. **Additive only minor bump의 대가 = 기존 매니페스트 불변**: upbit `schema_version = "1.0"`이 변경 없이 v1.1 도구로 작동하는 것을 smoke 수준이 아니라 **매니페스트 스펙 레벨**에서 실증. T4 크로스 커팅 분할 원칙이 이 non-disruption을 가능하게 함 (meta 세션은 스펙만, upbit 세션에서 upgrade 수행).

3. **Dead field 개수를 투명히 공개**: §8 표에서 6개 dead field(schema_version, [agents].primary, [agents].secondary, [build] 3필드, format_cmd)를 명시. "당장 쓰이지 않는 필드를 스펙에 넣는 게 맞는가?" 의 대답은 **"v1.8+ 전제 준비"**. 대신 투명성으로 사용자 혼동 방지.

4. **`runtime_version` 통일 vs 언어별 필드의 결정**: `python_version`/`node_version`/`go_version` 나열은 언어 추가마다 스키마 확장 필요. 통일 `runtime_version` + `language` 조합으로 해석하면 **언어 추가에 스키마 무변경**. Tier 2/3 언어 도입 시 schema bump 불필요 → v1.1의 장기 수명 확보.

5. **smoke-v1.1.sh의 실증 가치**: 15라인 스크립트가 "v1.6 bash hook이 v1.1 추가 필드에서 회귀 없음"을 실측. verify.ps1 확장 없이도 **회귀 감지 자동화**. 향후 v1.2 / v2.0 bump 시 동일 패턴 재사용 가능. 차기 세션에서 `tests/smoke-all.sh` 통합 검토.

6. **`statusline_timeout_ms` 스펙-구현 일치의 작은 희생**: Lesson 원안은 "2000 권장"(성능)이지만 hook 구현이 3000 하드코딩 상태. 스펙을 2000으로 쓰면 **구현 lie**. 3000 유지 선택은 정직. Lesson #5는 별도 세션(`sessions/meta/vX-statusline-timeout-2s`)에서 스펙+구현 동시 변경.

## 커밋 계획

```
feat(meta): sessions/meta/v1.7-manifest-schema-v1.1 — schema 1.0 → 1.1 (additive)

- rewrite: bootstrap/manifest-schema.md (12 섹션 ~340 라인)
    schema_version "1.1" 정식 (SemVer minor bump, additive only).
    v1.6 선반영 정식화: statusline_cmd / statusline_timeout_ms / state_file
    신규: [project].runtime_version / locale / [agents] / [build] / format_cmd
    deprecated retained: [project].python_version
    v1.0 → v1.1 변경 요약 표 + 하위 호환 매트릭스
    bash 파싱 가능/불가 필드 분류 표 (dead field 6개 명시)
    다언어 예시 4종 (Python/uv, TS/pnpm, Go, Rust)
    mcp_server vs agents.primary / guardrails vs AGENTS.md 역할 분리
- update: bootstrap/docs/OWNERSHIP.md — Evolution 조항에 v1.1 적용 사례
- add: tests/fixtures/schema-v1.1-full/ (매니페스트 + state + .gitkeep)
- add: tests/smoke-v1.1.sh (15라인, bash 파싱 회귀 smoke)
- add: sessions/meta/v1.7-manifest-schema-v1.1/{PLAN,REPORT,evidence}

Additive only — 기존 v1.0 매니페스트(upbit 포함) 무영향.
smoke PASS, verify 30/30 유지. Grey Area 37건 결정.
pyproject.toml `semantics-version` 거부 전례 인지하고 유지 정당화 명시.
```

사용자 확인 후 커밋 + push.

## 후속 세션 연결

### 직접 연계 (T4 후행)

| 순위 | 세션 ID | Scope | 근거 |
|-----|---------|-------|------|
| 1 | **sessions/upbit/vX-statusline-cmd-migration** | S6 upbit | v1.6 + v1.7 함께 적용 (statusline_cmd + state_file). upbit 풍부한 statusline 복원 |
| 2 | **sessions/upbit/vX-manifest-upgrade-1.1** | S6 upbit | schema_version "1.1" + runtime_version/locale 등 선택적 upgrade (기능 필요 시) |
| 3 | v1.8-core-adapter-split | S1+S2 | `[agents]` 필드 실 해석. claude/ → bootstrap/templates/<language>/.claude/ 구조 재편 |

### 보류 후보

- `sessions/meta/vX-statusline-timeout-2s` — hook 기본값 3000 → 2000 (Lesson #5, 스펙+구현 동시)
- `sessions/meta/vX-manifest-linter-cli` — `.harness.toml` 스펙 검증 CLI 도구 (tomllib 기반)
- `sessions/meta/vX-schema-diff-tool` — v1.0 → v1.1 자동 upgrade 도구
- `sessions/meta/vX-smoke-all` — `tests/smoke-*.sh` 통합 실행기 (hook/statusline 전체 fixture smoke)
- `sessions/meta/vX-notifications-extend` — Slack/Teams/Webhook 일반화 (v1.2 후보)
- `sessions/meta/vX-schema-v2-planning` — tomllib parser 도입 (breaking, deprecated 필드 제거)

### 3개월 재평가 게이트

v1.1 신규 필드 실사용 패턴 관찰. 특히 다음 조건 충족 시 v1.2 또는 v2.0 논의:
- `[agents].secondary` / `statusline_timeout_ms` / `[build]` 실적용 3+ 프로젝트
- `[ci]`, `[worktree]`, Slack/Teams webhook 요청 누적
- Claude Code AGENTS.md 네이티브 지원 (관련 세션 트리거)

**백로그는 자동 후행 아님**. 사용자 명시 command로만 진행.
