# AI-Ready 루브릭 v1.0 — 7개 카테고리 100점

> AI 에이전트(Claude Code, Cursor, Copilot 등)가 코드베이스를 얼마나 잘 이해하고
> 안전하게 작업할 수 있는지를 평가한다. "AI가 읽기 좋은 코드 = 사람이 읽기 좋은 코드"
> 원칙에 더해, AI 특유의 요구사항(컨텍스트 레이어, 에이전틱 안전)을 추가로 평가한다.

---

## 등급 기준

| 등급 | 점수 범위 | 의미 |
|------|---------|------|
| **S** | 90~100 | AI-Native. 에이전트가 자율적으로 복잡한 작업 수행 가능 |
| **A** | 75~89  | AI-Ready. 대부분의 작업을 최소 지시로 수행 가능 |
| **B** | 60~74  | AI-Friendly. 기본 작업 가능, 일부 컨텍스트 보완 필요 |
| **C** | 45~59  | AI-Assisted. 상세한 지시 없이는 실수 가능성 높음 |
| **D** | 0~44   | AI-Hostile. 에이전트 활용 시 위험 및 비효율 높음 |

---

## 카테고리 1: 문서화 (15점)

AI 에이전트가 코드를 이해하기 위해 가장 먼저 읽는 것이 문서다.

| 항목 | 점수 | 측정 방법 |
|------|------|---------|
| README 존재 + 50줄 이상 | 3 | 파일 존재 + 줄 수 카운트 |
| CLAUDE.md / AGENTS.md 존재 | 3 | 파일 존재 여부 |
| 아키텍처 문서 (ARCHITECTURE.md / ADR) | 3 | docs/ 패턴 탐색 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
| Docstring 커버리지 ≥40% | 3 | AST 분석 (Python) |
| Changelog 존재 | 1 | CHANGELOG.md 패턴 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |

**AI 관점**: LLM은 코드를 볼 때 먼저 README와 CLAUDE.md로 프로젝트 의도를 파악한다.
이 두 파일이 없으면 AI는 코드만 보고 추론해야 하므로 실수 확률이 급증한다.

---

## 카테고리 2: 코드 구조 (15점)

AI가 파일을 탐색하고 변경 범위를 예측하기 위해 필요한 구조적 명확성.

| 항목 | 점수 | 측정 방법 |
|------|------|---------|
| 소스/테스트 디렉토리 분리 | 3 | src/ 또는 패키지 + tests/ 존재 |
| 파일 크기 ≤500줄 (위반 ≤2개) | 3 | 코드 파일 라인 수 |
| 설정 분리 (config/settings) | 3 | config.py / settings.py 패턴 |
| 패키지 매니페스트 존재 | 3 | pyproject.toml / package.json 등 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
| 루트 코드 파일 과다 방지 | 1 | 루트 코드 파일 ≤8개 |

**AI 관점**: 500줄 초과 파일은 LLM의 컨텍스트 창을 비효율적으로 소모한다.
모듈이 명확히 분리되면 AI가 변경 영향 범위를 정확하게 예측한다.

---

## 카테고리 3: 타입 안전성 (15점)

타입 정보는 AI의 추론 정확도를 높이는 가장 효과적인 기계 판독 가능 계약이다.

### Python (15점)
| 항목 | 점수 | 기준 |
|------|------|------|
| 타입 힌트 커버리지 ≥70% | 5 | AST 함수 분석 |
| mypy / pyright 설정 | 3 | 설정 파일 + 활성화 여부 |
| Pydantic / dataclass / TypedDict 사용 | 4 | import 패턴 탐색 |
| Protocol / ABC 인터페이스 정의 | 3 | import 패턴 탐색 |

### TypeScript (15점)
| 항목 | 점수 | 기준 |
|------|------|------|
| tsconfig.json (strict 모드) | 5 | 파일 존재 + strict 설정 |
| 런타임 스키마 (zod / io-ts) | 7 | import 패턴 탐색 |
| 기본 TypeScript 사용 | 3 | 항상 부여 |

**AI 관점**: 타입 힌트가 없으면 AI는 함수 입출력 계약을 추론에 의존해야 한다.
`def process(data)` vs `def process(data: TradeSignal) -> OrderResult`는
AI 추론 정확도에서 큰 차이를 만든다.

---

## 카테고리 4: 테스트 품질 (15점)

AI가 코드를 변경한 후 회귀를 자동으로 감지하기 위한 안전망.

| 항목 | 점수 | 기준 |
|------|------|------|
| 테스트 디렉토리 존재 | 2 | tests/ 패턴 또는 test_*.py 파일 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
| 테스트 파일 수 ≥15개 | 3 | 파일 카운트 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
| 테스트 프레임워크 설정 | 2 | pytest.ini / jest.config 등 |
| 커버리지 설정 | 2 | .coveragerc / [tool.coverage] (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
| 통합 테스트 존재 | 2 | tests/integration/ 패턴 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
| 테스트/소스 비율 ≥0.3 | 2 | 파일 수 비율 |
| CI 테스트 자동화 | 2 | CI 파일 내 test 명령 존재 |

**AI 관점**: AI가 리팩토링을 수행한 후 "이게 안전한가?"를 판단할 수 있는
유일한 자동화 메커니즘이 테스트다. 테스트 없는 코드베이스에서 AI 활용은 고위험이다.

---

## 카테고리 5: 컨텍스트 레이어 (15점)

AI 에이전트 특화 항목. 에이전트가 프로젝트 규칙을 이해하고 준수하기 위한 레이어.

| 항목 | 점수 | 기준 |
|------|------|------|
| CLAUDE.md / AGENTS.md 품질 | 11 | 내용 깊이 (존재 3 + 길이 2 + 아키텍처 3 + 명령어 3) |
| GUARDRAILS.md 존재 | 2 | docs/GUARDRAILS.md 패턴 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
| ADR / 의사결정 기록 | 2 | docs/adr/ 패턴 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |

### CLAUDE.md 품질 세부 배점

| 항목 | 배점 | 평가 기준 |
|------|------|---------|
| 파일 존재 | 3 | CLAUDE.md 또는 AGENTS.md 파일 |
| 충분한 분량 (≥30줄) | 2 | 줄 수 카운트 |
| 아키텍처 규칙 포함 | 3 | "아키텍처", "CRITICAL", "architecture" 키워드 |
| 실행 명령어 포함 | 3 | 코드 블록 내 실행 명령어 |

**AI 관점**: CLAUDE.md는 AI 에이전트에게 "이 프로젝트에서 해야 할 것과 하지 말아야 할 것"을
알려주는 가장 직접적인 채널이다. 이것이 없으면 AI는 코드를 분석해서 규칙을 추론해야 하는데,
잘못된 추론은 ADR-027(Paper-First 원칙) 같은 핵심 규칙을 위반하는 결과를 낳는다.

---

## 카테고리 6: 자동화 (15점)

AI 실수를 자동으로 차단하고, AI가 실행할 수 있는 표준 명령을 제공하는 인프라.

| 항목 | 점수 | 기준 |
|------|------|------|
| CI/CD 파이프라인 | 3 | .github/workflows/ 등 |
| Pre-commit 훅 | 3 | .pre-commit-config.yaml |
| 린터 설정 | 2 | ruff / ESLint 등 |
| Makefile / 태스크 러너 | 2 | Makefile / scripts/ 등 |
| Docker / 컨테이너화 | 2 | Dockerfile 등 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
| 의존성 Lock 파일 | 1 | poetry.lock / package-lock.json 등 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |

**AI 관점**: Pre-commit 훅은 AI가 생성한 코드의 품질 게이트 역할을 한다.
AI가 실수로 나쁜 코드를 작성해도 자동으로 차단된다. Makefile은 AI가
"어떤 명령으로 테스트하나?"를 추론 없이 바로 알 수 있게 한다.

---

## 카테고리 7: 에이전틱 안전 (10점)

AI 에이전트가 민감한 데이터를 노출하거나 위험한 작업을 수행하지 못하도록 하는 안전장치.

| 항목 | 점수 | 기준 |
|------|------|------|
| .gitignore 존재 | 1 | 파일 존재 |
| .env 미커밋 | 2 | git ls-files .env 결과 없음 |
| .env.example 존재 | 2 | 파일 존재 |
| 하드코딩 비밀 없음 | 2 | 정규식 패턴 탐색 |
| Claude Code 권한 설정 | 2 | .claude/settings.json permissions |
| 가드레일 파일 | 1 | docs/GUARDRAILS.md |

**AI 관점**: AI 에이전트는 코드베이스를 통째로 읽는다. .env가 커밋되어 있으면
AI 세션에 비밀 키가 노출된다. .claude/settings.json의 권한 설정은
AI가 `rm -rf` 같은 위험 명령을 실행하기 전에 확인을 요구하게 한다.

---

## N/A (Not Applicable) 정책

일부 체크는 repo 성격상 본질적으로 부적합하다 (예: dotfiles repo의 Dockerfile,
shell/markdown-only repo의 패키지 매니페스트). 이 경우 false negative 감점을 막기
위해 자동 만점 + N/A flag 부여 후 HTML 대시보드 ℹ️ icon으로 시각 구분한다.

### N/A 진입 조건 (4 조건 AND — `is_shell_markdown_only_repo`)

1. lang ∉ {Python, TypeScript, JavaScript, Go, Rust, Java, Kotlin, C#, Ruby, Swift}
2. 빌드 매니페스트 (package.json/Cargo.toml/go.mod/build.gradle*/pom.xml) **부재**
3. pyproject.toml 부재 OR runtime deps 비어있음 (tomllib 우선 + regex fallback)
4. 빌드 소스 파일 (.py/.ts/.go/.rs/.java/.kt/.cs/.rb/.swift) 개수 **< 10** (v1.18g2: 5→10, score_codebase.py 분할 부수 효과 보정)

### 적용 체크 (3건)

| 카테고리 | 체크 | 적용 세션 |
|---------|-----|---------|
| 자동화 | Docker / 컨테이너화 | v1.18b |
| 자동화 | 의존성 Lock 파일 | v1.18b |
| 코드 구조 | 패키지 매니페스트 | v1.18c |
| 문서화 | 아키텍처 문서 | v1.35 |
| 문서화 | Changelog | v1.35 |
| 컨텍스트 레이어 | GUARDRAILS.md | v1.35 |
| 컨텍스트 레이어 | ADR / 의사결정 기록 | v1.35 |
| 테스트 품질 | 테스트 디렉토리 존재 | v1.35 |
| 테스트 품질 | 테스트 파일 수 ≥15개 | v1.35 |
| 테스트 품질 | 커버리지 설정 | v1.35 |
| 테스트 품질 | 통합 테스트 존재 | v1.35 |

다른 체크에 N/A 확장은 evidence-driven 후속 (Type safety + Test pytest 설정 + Test borderline 2 sub는 새 helper 필요 → v1.36+).

### 데이터 모델

`Check` dataclass에 `na: bool = False` 필드 (default False, backward compat).
N/A 진입 시:
- `passed=True`, `score=max_score` (자동 만점)
- `na=True`
- `detail="N/A — ... (자동 만점)"`
- `action=None` → ROI 액션 리스트에서 자연 제외

JSON output에 `"na": true` 필드 포함. HTML 대시보드는 ✅/❌ 대신 ℹ️ icon 표시.

---

## ROI 계산 방식

```
ROI 점수 = 회복 가능 점수 × AI영향도 가중치 / 구현 시간(시)
```

| 난이도 | 예상 시간 | 예시 |
|--------|---------|------|
| 즉시 | 1시간 | 파일 생성, 설정 추가 |
| 단기 | 8시간 | 구조 정리, 테스트 추가 |
| 중기 | 40시간 | 대규모 리팩토링, 타입 힌트 전면 적용 |

ROI 점수가 높은 액션 = 적은 노력으로 AI 생산성이 크게 향상되는 작업.

---

## 언어별 지원 현황

| 언어 | 타입 안전성 | 기타 카테고리 |
|------|-----------|-------------|
| Python | ✅ 완전 지원 (AST 분석) | ✅ 완전 지원 |
| TypeScript | ✅ 완전 지원 | ✅ 완전 지원 |
| Go, Rust, Java, 기타 | ⚠️ 부분 점수 | ✅ 완전 지원 |

---

## 개선 로드맵 (v1.1 예정)

- [ ] 언어별 타입 분석 확장 (Go, Rust, Java)
- [ ] Git history 분석 (커밋 메시지 품질, 변경 빈도)
- [ ] 실제 커버리지 % 측정 (pytest-cov 실행)
- [ ] CLAUDE.md NLP 품질 분석
- [ ] PR diff 기반 점수 변화 추적
