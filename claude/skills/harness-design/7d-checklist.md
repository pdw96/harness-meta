# 7-Dimension 검증 체크리스트

각 step에 대해 아래 7개 차원을 PASS/FAIL로 평가하고 근거를 기록한다.

## D1. 정합성 (Consistency)
- [ ] PLAN.md의 요구사항을 빠짐없이 커버하는가?
- [ ] step 간 의존성이 DAG (순환 없음)로 표현되는가?
- [ ] 프로젝트 ARCHITECTURE 문서의 디렉토리 규칙 준수?
- [ ] 프로젝트 DECISIONS/ADR의 기술 결정 준수?
- [ ] 프로젝트 `CLAUDE.md`의 CRITICAL 규칙 준수 (규칙 내용은 프로젝트별)?

## D2. 안전성 (Safety)
- [ ] 에러 케이스를 명시적으로 열거했는가?
- [ ] 복구 전략(retry / fallback / graceful degrade) 있는가?
- [ ] 기존 기능의 역호환 유지 (기존 테스트 안 깨짐)?
- [ ] 동시성 이슈 (race condition, shared state) 고려?

## D3. 성능 (Performance)
- [ ] hot path (tick 단위 호출)에서 블로킹 없는가?
- [ ] LLM 호출이 있다면 토큰 비용 계산 + 캐싱 고려?
- [ ] 메모리 누수 없음 (deque maxlen, buffer 정리)?

## D4. 완전성 (Completeness)
- [ ] 숨겨진 요구사항 (warmup, 초기화, 경계값) 빠짐없음?
- [ ] 입력/출력 모두 명시 (공개 API 타입/의미)?
- [ ] 프로젝트 설정 정의 소스의 신규 필드 + `.env.example` 동기화?

## D5. 테스트 (Testability)
- [ ] AC가 **실행 가능한 명령**으로 표현되는가?
- [ ] mock 전략 명시 (network, time, random 등)?
- [ ] 경계값 테스트 포함 (0, None, 빈 배열, 최댓값)?

## D6. 운영 (Operability)
- [ ] 프로젝트 메트릭 정의 소스에 관련 메트릭 추가?
- [ ] 알림 기준 (연속 실패, 임계값 초과) 명시?
- [ ] feature flag로 안전하게 롤백 가능?

## D7. 데이터 흐름 (Data Flow)
- [ ] 프로젝트의 주요 데이터 파이프라인 전체 경로 추적? (입력 → 처리 → 출력)
- [ ] stub 구현체와 호환 (예: paper → live 같은 환경 전환)?
- [ ] 컨테이너 간 / 프로세스 간 통신 영향?

---

## 기록 양식 (step.md 말미)

```markdown
## 7-Dimension 검증

| 차원 | 판정 | 근거 |
|------|------|------|
| D1 정합성 | PASS | PLAN R1~R3 모두 `src/module_a.py` 에서 처리 |
| D2 안전성 | PASS | network error 시 retry 3회, timeout 10s |
| D3 성능 | PASS | hot path O(1), 캐시 30초 |
| D4 완전성 | FAIL | warmup 초기화 미명시 → Revision 1 |
| D5 테스트 | PASS | tests/test_module_a.py 15개 + 경계값 3개 |
| D6 운영 | PASS | `module_a_state` counter 메트릭 추가 |
| D7 데이터 흐름 | PASS | 동일 모듈이 양쪽 환경(예: paper/live)에서 import |
```

## Revision Gate

FAIL → step.md 수정 → 재검증 (최대 3회).
3회 초과 시 Escalation (사용자 판단 요청).
