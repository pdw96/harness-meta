# meta v1.37-install-docs-ssot — REPORT

세션 완료: 2026-04-30
커밋: `a4e58ad`

## 최종 결과

- 변경 파일: 2 (install.ps1, README.md)
- 신규 파일: 0
- smoke-bash-permission-pattern: 6/6 PASS
- 회귀: 0

## 구현 요약

| 목표 | 구현 | 커밋 |
|------|------|------|
| install.ps1 충돌 정책 1줄 수렴 | 헤더 3줄 블록 → 1줄 (idempotent v1.36e + CLAUDE.md 참조) | `a4e58ad` |
| README.md reinstall note fix | "abort without -Force" → "idempotent (v1.36e), no -Force" | `a4e58ad` |

## 판정

- [x] `install.ps1:16` 에 "정기 재실행 시 -Force 필수" 텍스트 없음
- [x] `install.ps1` 충돌 정책 섹션이 1줄로 압축됨
- [x] `README.md:47` 에 "subsequent runs abort without `-Force`" 텍스트 없음
- [x] `README.md:47` 에 "idempotent" 반영됨
- [x] `bash tests/smoke-bash-permission-pattern.sh` PASS (6/6)
- [x] CLAUDE.md 변경 없음 (단일 소스 역할 유지)

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 외부 spec 의존 무 (내부 docs 정확성 수정) |
| **re-verify** | N/A |

## Lessons Learned

- L1 — **v1.36e에서 파생 docs 미갱신 패턴**: v1.36e가 CLAUDE.md만 갱신하고 install.ps1/README.md를 갱신하지 않은 사례. 향후 idempotent 동작 변경 시 3곳(install.ps1 헤더 / README.md / CLAUDE.md) 동시 갱신 의무.
- L2 — **작은 docs 세션은 PLAN→구현→커밋이 20분 내 완료**: 회귀 risk 없는 content-only 수정은 빠른 단위 커밋이 적절.

## 다음 후보 (보류)

ROADMAP §3-E `v1.36b2b` → §8 최근 완료로 이동 완료 (harness-roadmap-update에서 처리).
