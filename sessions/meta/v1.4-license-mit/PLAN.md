# meta v1.4-license-mit — PLAN

세션 시작: 2026-04-24
선행 세션: [`sessions/meta/v1.3-install-verify/`](../v1.3-install-verify/REPORT.md)
목적: `~/harness-meta/` public repo에 **MIT License**를 부착하여 타인의 사용·포크·기여의 법적 장벽을 제거한다. 오픈소스 생태계 확장 로드맵(v1.5~v2.0 AGENTS.md 채택·다국어 템플릿·multi-adapter)의 **선결 조건**.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: `~/harness-meta/{LICENSE (신규), README.md, CLAUDE.md}` → 전부 **S3** (repo 정책·설치).
- **T1 경로 다수결** — 3/3 S3 → meta 소유 확정.

## 배경

### 왜 지금 LICENSE인가

- 현 repo는 GitHub public (`github.com/pdw96/harness-meta`) — 그러나 LICENSE 파일 부재.
- **LICENSE 없는 public repo의 기본 법적 상태** = "All rights reserved" (저작권법 자동). 타인이 clone·fork는 가능하나 **사용·배포·수정 권한 없음** — 오픈소스가 아님.
- 차기 로드맵(v1.5~v2.0) 방향:
  1. AGENTS.md 오픈 표준 채택 (Linux Foundation 관리, 60,000+ 프로젝트)
  2. 다국어 템플릿 (Python/TS/JS/Go/Rust/Java/.NET 7개 Tier 1)
  3. Multi-adapter 지원 (claude-code/cursor/codex-cli/gemini-cli/windsurf/cline/aider 7개 Tier 1)
  4. 오픈소스 커뮤니티 기여 수용
- 위 작업 전 LICENSE 부재면 **기여자·사용자 모두 법적 불확실성**. 선결 세션 필수.

### 왜 MIT인가

- **가장 permissive**: 사용·수정·재배포·상업적 이용·sublicense 모두 허용
- **오픈소스 템플릿 사실상 표준**: Claude Code 생태계 관련 도구(Aider, Continue, 많은 MCP 서버) 대부분 MIT
- **기여 장벽 최소**: Apache-2.0의 CLA 권장 프로세스 없음, GPL의 copyleft 강제 없음
- **다른 라이선스와 호환**: Apache-2.0 / GPL / MPL 프로젝트가 MIT 코드 흡수 가능 → 생태계 확산 용이
- **본 repo 성격 적합**: 코드베이스는 설정·템플릿·스크립트 중심으로 copyleft 명분 약함. 특허 조항 필요한 발명 없음

### 사용자 확인 완료 사항 (대화 2026-04-24)

- 사업자 등록증·특허·상표 출원 **불필요** 확인
- 변호사 검토 **불필요** 확인
- 저작권자 표기: **Dowon Park** (개인, GitHub 계정 `pdw96`)
- 저작권 연도: **2026**

## 목표

- [ ] `~/harness-meta/LICENSE` 신규 — MIT License 정식 텍스트 + "Copyright (c) 2026 Dowon Park"
- [ ] `~/harness-meta/README.md` — 하단에 "License" 섹션 1개 추가 (`MIT` 명시 + LICENSE 파일 링크)
- [ ] `~/harness-meta/CLAUDE.md` — repo 정체성 섹션에 "License: MIT" 한 줄 추가 (Claude Code 자동 컨텍스트에 노출되어 향후 세션이 인지)
- [ ] `~/harness-meta/sessions/meta/v1.4-license-mit/REPORT.md` — 본 PLAN 체크박스 완수 증명
- [ ] 본 PLAN + LICENSE + 문서 갱신을 **단일 커밋**으로 묶음 (원자적 논리 단위)

## 범위

**포함**:
- LICENSE 파일 신규
- README.md / CLAUDE.md 최소 갱신 (License 언급)
- 세션 기록 (PLAN + REPORT)

**제외**:
- CONTRIBUTING.md / SECURITY.md / CODE_OF_CONDUCT.md / CHANGELOG.md — **v1.25-opensource-readiness 세션** (다국어 adapter 확정 후 최종 작성)
- `.github/` (workflows, issue templates) — 동일 세션 연기
- README 영문 번역 — 동일 세션 연기
- 개인정보 감사 (`qkreh` 경로 잔존 등) — 동일 세션 연기
- 기타 파일의 header 주석 — MIT는 파일별 header 불필요 (LICENSE 파일 1개로 충분)

**제외 이유**: v1.25 기능 확정 후 일괄 작성이 중복 작업 회피. 본 세션은 **법적 장벽 제거**라는 단일 목적.

## 변경 대상

### 신규 파일 (1)

| 경로 | scope | 역할 |
|------|-------|------|
| `~/harness-meta/LICENSE` | S3 | MIT License 정식 텍스트 (opensource.org 공식 버전 그대로) |

### 수정 파일 (2)

| 경로 | scope | 변경 내용 |
|------|-------|----------|
| `~/harness-meta/README.md` | S3 | 하단 "License" 섹션 추가 (10번째 섹션) + 목차 갱신 |
| `~/harness-meta/CLAUDE.md` | S3 | 상단 프로젝트 소개 다음에 "License: MIT" 1줄 추가 |

### 세션 기록 (2)

| 경로 | 역할 |
|------|------|
| `~/harness-meta/sessions/meta/v1.4-license-mit/PLAN.md` | 본 파일 |
| `~/harness-meta/sessions/meta/v1.4-license-mit/REPORT.md` | 구현 후 작성 |

## LICENSE 파일 내용 (확정)

`opensource.org/licenses/MIT` 공식 텍스트. Copyright 라인만 치환:

```
MIT License

Copyright (c) 2026 Dowon Park

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

**검증**: MIT 텍스트의 standard form (SPDX `MIT`). 수정 금지 — 수정 시 "MIT-modified"로 분류되어 자동 호환성 판정 깨짐.

## README 갱신 (확정 diff)

기존 목차 (라인 9~22)의 `11. 관련 문서` 뒤에 `12. License` 추가.

하단에 섹션 추가:

```markdown
## License

MIT License. 자세한 내용은 [`LICENSE`](LICENSE) 파일 참조.

Copyright (c) 2026 Dowon Park.
```

## CLAUDE.md 갱신 (확정 diff)

라인 3 (프로젝트 소개 뒤, `## 기술 스택` 앞)에 1줄 추가:

```markdown
**License**: MIT ([LICENSE](LICENSE)) — 오픈소스 사용·포크·기여 허용.
```

## Grey Areas — 논의 결정

| ID | 질문 | 결정 | 근거 |
|----|------|------|------|
| G1 | LICENSE 파일명 확장자 (`LICENSE` vs `LICENSE.md` vs `LICENSE.txt`) | **확장자 없는 `LICENSE`** | GitHub가 자동 인식(repo 우측 사이드바에 라이선스 뱃지 표시)하는 관례적 이름. `.md`/`.txt`도 인식하나 무확장자 가장 광범위 |
| G2 | Copyright holder 표기 (`Dowon Park` vs `pdw96` vs 이메일 포함) | **`Dowon Park`** (실명만) | MIT 관례는 실명 또는 단체명. GitHub ID/email은 식별 보조라 LICENSE 본문에는 불필요 |
| G3 | Copyright 연도 (`2026` vs `2026-2026` vs `2026-present`) | **`2026`** | v1.0-bootstrap(2026-04-24)부터 repo 시작 → 단일 연도 충분. 향후 연도 경과 시 `2026-20XX`로 갱신 (별도 세션에서) |
| G4 | 파일별 SPDX 헤더 주석 삽입 (`// SPDX-License-Identifier: MIT`) | **미삽입** | 스크립트·마크다운 위주 저장소에 헤더 주석은 과잉. LICENSE 단일 파일만으로 SPDX 자동 탐지(GitHub Linguist 등) 정상 작동 |
| G5 | 기존 세션 파일(`sessions/meta/v1.0~v1.3/`)에 라이선스 소급 적용 선언 | **불필요** | 저작권자 동일(본인). LICENSE 부착 시점부터 전체 repo가 MIT로 커버됨 (git history 포함) |
| G6 | Third-party 코드 유무 감사 (MIT와 비호환 라이선스 포함 여부) | **본 세션 내에서 수행** | 단 `~/harness-meta/` 내부만 대상. upbit 등 외부 repo 제외 |
| G7 | AGENTS.md 표준 텍스트 준수 | **해당 없음** | LICENSE는 AGENTS.md 대상 아님 |
| G8 | 다국어 LICENSE 번역 | **제공 안 함** | MIT License는 영문 원본만 법적 효력. 번역본은 reference only |

### G6 Third-party 감사 실행 계획

구현 단계에서 다음 확인:
- `~/harness-meta/` 하위 모든 파일의 작성자 = 본인 (git log 기반)
- 외부 스니펫 복사 없음 (install.ps1, verify.ps1 등은 자체 구현 확인됨)
- 외부 의존 도구(Claude Code, PowerShell 7, Git Bash, python3)는 **본 repo에 코드 포함 아님** — 사용자 환경 전제, 라이선스 무관

감사 결과 외부 코드 발견 시 PLAN 수정 후 재논의. 미발견 시 REPORT에 "감사 통과" 기록.

## 성공 기준

- [ ] `~/harness-meta/LICENSE` 존재 + MIT 공식 텍스트 완전 일치 (SPDX validator 통과 가능)
- [ ] `README.md`에 `## License` 섹션 + LICENSE 파일 링크 존재
- [ ] `README.md` 목차에 `12. License` 항목 존재
- [ ] `CLAUDE.md` 상단에 `License: MIT` 1줄 존재
- [ ] GitHub 웹 UI에서 repo 루트 방문 시 "MIT License" 뱃지 자동 인식 (push 후 확인)
- [ ] Third-party 코드 감사 통과 (외부 스니펫·비호환 라이선스 코드 0건)
- [ ] 커밋 메시지 conventional commits 형식 (`docs(meta): ...`)
- [ ] REPORT.md 작성 완료

## 커밋 전략

단일 커밋 (원자적 법적 선언 + 문서 동기화).

```
docs(meta): sessions/meta/v1.4-license-mit — MIT License 부착

- add: LICENSE (MIT 공식 텍스트, Copyright (c) 2026 Dowon Park)
- update: README.md — License 섹션 + 목차
- update: CLAUDE.md — License: MIT 선언
- add: sessions/meta/v1.4-license-mit/{PLAN,REPORT}.md

배경: 오픈소스 로드맵(v1.5~v2.0 AGENTS.md/다국어/multi-adapter) 선결 조건.
Third-party 코드 감사 통과. 저작권자: Dowon Park (개인).
```

사용자 확인 후 `~/harness-meta` repo에 커밋. **Push는 본 세션 범위 외** — 사용자가 수동 `git push` (또는 차기 세션).

## 후속 세션 연결

### 직접 연결

- **v1.5-philosophy-patterns** (S2) — 하네스 철학·패턴 문서 작성. LICENSE 부착 후 즉시 가능
- **v1.5b-agents-md-strategy** (S1+S2) — AGENTS.md 오픈 표준 채택 결정 + symlink 전략

### 보류 후보 (v1.3 REPORT 승계 + v1.4 신규)

- v1.6-language-neutral-claude-layer (S1) — hook/statusline/commands Python 하드코딩 제거
- v1.7-manifest-schema-v1.1 (S2) — `[agents]`/`[build]`/`runtime_version`/`format_cmd` 필드
- v1.8-core-adapter-split (S1+S2) — `core/` + `adapters/claude-code/` 구조 분리
- v1.9-project-auto-detect (S2) — language/PM/test_cmd 자동 감지
- v1.10~v1.13 — bootstrap templates (python-node / go-rust / jvm-dotnet)
- v1.14~v1.20 — adapters (cursor / codex-cli / gemini-cli / windsurf / cline / aider / claude-code 재정비)
- v1.21-cross-platform-install (S3) — install.py + verify.py (macOS/Linux)
- v1.22-bootstrap-e2e-orchestration (S1+S2)
- v1.23-polyglot-monorepo-support (S2)
- v1.24-community-tier2-tier3-scaffold (S2)
- **v1.25-opensource-readiness (S3)** — CONTRIBUTING/SECURITY/CHANGELOG/.github/영문 README/PII 감사 (**최종**)
- v2.0-harness-core-extraction (L3) — scripts/harness → core/runtime/python/

로드맵 전체 기간 중 3개월 단위 `sessions/meta/vX-ecosystem-audit/` 재평가 세션 삽입 (AGENTS.md 표준·Claude Code 업데이트·Biome/uv 진화 등 생태계 변화 반영).

**본 세션은 단독 완결**. 후속은 사용자 명시 호출 시 진행.
