# v8.6 phase-1 — ARCHITECTURE § 3 권역 검증철학 정전화

## scope

ARCHITECTURE.md § 3 권역 3 edit (DESIGN phase-1 정합, 문서 정전화 only):

- (a) § 3.1 끝 신 paragraph — 검증철학 분리 선언
- (b) § 3.3 Verification row 명료화 절 + pointer
- (c) § 7.1 단방향 pointer

## changes

### (a) § 3.1 끝 신 paragraph (d_1/d_2/d_3/d_4 흡수)

`development/ARCHITECTURE.md` § 3.1 끝 (v6.0 운영 원칙 paragraph 뒤) 신 paragraph 추가:

- **두괄 negative 명제** (d_1 + design-review dx 흡수): "자기개발 횟수(~200 milestone)는 제품 역량 검증의 증거가 아니다" 를 paragraph 첫 문장에. 요리사 비유는 보조 후순.
- **자기개발=책상 / 제품 역량=현장 2 범주 분리** (d_1, sc_1): 각 범주의 검증 방식 + '보장하는 것 / 보장 못 하는 것' 명시.
- **외부 적용 = 1차 역량 검증 vector 정전화** (d_2, sc_2): v8.3(L41) + v8.5(L49/L54) 실증 2건 cross-ref 인용 ('현 evidence 2건, forward 누적' 정직 표기 — risk_1 mitigation).
- **self-loop 92.3% 재라벨** (d_4, sc_3): 'v4.0~v5.7, 13 milestone 기준 시점 고정 수치' + '자기개발 trace 통계이지 제품 역량 검증 성숙도 아님' 명시. 수치 보존(oos_2/risk_3).
- **'검증' 단어 3중 의미 경계 표** (d_3, sc_4 + design-review dx decisive): 라벨 / 층위(책상 2 vs 현장 1) / 본질 / **host 컬럼**(§ 4 / § 3.3 / § 3.1) 4 컬럼. 단어-책임 1:1(v2.0) = '세 라벨 세 책임' 명시.
- 범위 = 원칙 선언까지 + 산출물 문서 only + MILESTONE.md/§ 7.1 cross-ref.

### (b) § 3.3 Verification row 명료화 (d_5, sc_4)

5요소 매트릭스 Verification row (a) 책임 셀에 '**자기점검 = 책상 검증** 층위 — 제품 역량 검증(현장)은 § 3.1 검증철학 paragraph 의 별도 범주' 절 삽입. 기존 정의 무손상(d_6).

### (c) § 7.1 단방향 pointer (d_5, risk_4)

§ 7.1 3면 매트릭스 intro 뒤 '제품 역량 검증(외부 vector) 연결' pointer paragraph 추가 — 정의 1차 source = § 3.1, 본 § 7.1 = 단방향 pointer(cascade marker 부재 자연, § 7.3 선례 동형).

## verification

- `bash tests/smoke-spec-verification.sh` → PASS, FAIL=0 (d_6/sc_5 — 9-stage 단어·smoke 무손상).
- `python scripts/cascade_sync.py --check` → marker 보유 host in sync (ARCHITECTURE 100KB 초과 WARN skip = 자동검증 밖). § 3↔§ 7 단방향 pointer 는 marker 부재라 사용자 확인 책임(design-review dx 흡수).
- `bash tests/smoke-entry-title-guideline.sh` 영향 = ROADMAP entry title 무변경 (PASS 유지 예상).

## commit

(커밋 시점 = 사용자 명시 후 — VERIFY 통과 후 일괄 또는 단계별, 사용자 결정 대기)
