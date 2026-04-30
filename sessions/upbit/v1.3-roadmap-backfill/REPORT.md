# upbit v1.3-roadmap-backfill — REPORT

세션 완료: 2026-04-30
선행 세션 (meta): [`sessions/meta/v1.36-roadmap-unification-and-flow/`](../../meta/v1.36-roadmap-unification-and-flow/)

## 최종 결과

- **신규 파일 1건**: `projects/upbit/ROADMAP.md`
- **세션 기록 2건**: `sessions/upbit/v1.3-roadmap-backfill/{PLAN,REPORT}.md`

## 구현 요약

| # | 목표 | 결과 |
|---|------|------|
| 1 | `projects/upbit/ROADMAP.md` 신규 작성 (§6 최근 완료 3건 + §2 pending 항목) | ✅ |
| 2 | REPORT.md 작성 | ✅ (본 파일) |
| 3 | harness-roadmap-update 호출 → meta ROADMAP §3-F archive | ⏳ 직후 invoke |

### `projects/upbit/ROADMAP.md` 내용

| 섹션 | 내용 |
|------|------|
| §1 다음 후보 (활성) | 0건 |
| §2 Out of scope (trigger 대기) | 2건: `v1.4-statusline-cmd-migration` (trigger B) + `v1.4-manifest-upgrade-1.1` (trigger E) |
| §3 Schedule 후보 | 0건 |
| §6 최근 완료 | 3건: v1.0(2026-04-25) + v1.1(2026-04-25) + v1.2(2026-04-28) |

## 판정

- [x] `projects/upbit/ROADMAP.md` 존재
- [x] §6 "최근 완료": v1.0 / v1.1 / v1.2 3건 정확히 기록
- [x] §2 "Out of scope (trigger 대기)": pending 2건 (statusline / manifest-1.1) 분류 포함
- [ ] meta ROADMAP §3-F `v1.36c-legacy-project-roadmap-migration` 항목 archive ← harness-roadmap-update 직후

**판정**: PASS (3/4 완료, harness-roadmap-update 호출 대기)

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 외부 spec 의존 무 (내부 docs 작성만) |
| **re-verify** | N/A |

## Lessons Learned

1. **bootstrap skeleton이 이미 있어 PLAN 범위 단순화**: `ROADMAP.md.tmpl`이 v1.36에서 기 생성 → 본 세션은 S4 값 적용만. T2 스펙 vs 값 분리 원칙이 실제로 세션 범위를 최소화함을 확인.

2. **소급 작성의 데이터 충실도**: upbit 3 세션 REPORT에서 "후속 세션 연결"을 명시적으로 기록했기 때문에 pending 항목 추출이 정확. 향후 세션 REPORT의 "후속" 섹션 기록 의무 가치 재확인.

3. **v1.0 "후속 세션 연결"에 listed된 `v1.1-statusline-cmd-migration` / `v1.2-manifest-upgrade-1.1`**: 실제 v1.1/v1.2 세션이 다른 긴급 우선순위(meta v1.8b/v1.11b 후속)로 대체됨. 이런 경우 명시적으로 §2 trigger 대기로 이관해야 이력이 소실되지 않음 — 본 소급 작성이 그 역할.

## 다음 후보 (보류)

- `v1.4-statusline-cmd-migration` — statusline 풍부한 출력 복원 (trigger B: verify.ps1/sh 실패 또는 사용자 요청 시)
- `v1.4-manifest-upgrade-1.1` — `.harness.toml` schema 1.1 bump (trigger E: 신규 필드 필요 시)
