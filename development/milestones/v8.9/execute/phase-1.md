# v8.9 execute — phase-1: 카탈로그 영역 4 신설

## changes

1. **`bootstrap/claude-code-catalog/README.md`** — '## 4. harness-meta canonical 자산 인벤토리 (v8.9 신설)' § 추가(영역 3 뒤):
   - 경량 인벤토리 표 (자산 / source path(markdown link) / 책임 / 권고 case(gap 조건) / apply 방식) — secret-scan 첫 row.
   - 영역 1~3 직교 명시 + heterogeneous 시 extend/adopt(강요 아님) narrative + 경량 인벤토리(oos_1, full 구조 별도 후보) note + 신규 자산 등록 규약.
2. 카탈로그 § 제목 '카탈로그 3 영역'→'4 영역' + 매트릭스 표 영역 4 row 추가(d_1, d_6 (a)).

## verification

| smoke | 결과 |
| --- | --- |
| smoke-cross-ref | PASS=1 FAIL=0 (영역 4 자산 markdown link broken 0 — risk_3 차단 실효) |
| smoke-claude-md-drift | 13/13 PASS |

sc_1 충족. 자산 path = markdown link → drift 자동 차단.

## commit

(phase-2 완료 후 milestone 단위 — 사용자 확인)
