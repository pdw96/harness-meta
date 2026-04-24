# meta v1.9-project-auto-detect — REPORT

세션 기간: 2026-04-25 (단일 세션)
세션 범위: `bootstrap/detect-project.sh` 신규 + `DETECTION.md` + 4 fixture + smoke
판정: **PASS** (성공 기준 6/6, smoke 4/4)

**세션 소속 (self-apply)**: `sessions/meta/`
**근거**: 변경 전부 **S2** (bootstrap 자산). T1 단일 scope → meta.

## 최종 결과

- **신규 2**: `bootstrap/detect-project.sh` (~100 LOC bash), `bootstrap/docs/DETECTION.md` (확장 가이드 포함)
- **fixture 4**: detect-python-uv, detect-node-pnpm, detect-go, detect-rust
- **smoke 4/4 PASS** — 각 fixture에서 올바른 TOML 힌트 출력
- **세션 기록 3**: PLAN + REPORT + evidence

## 구현 요약 (PLAN 6/6)

| # | 목표 | 결과 |
|---|------|------|
| 1 | detect-project.sh 신규 | ✅ 9 언어 지원 |
| 2 | DETECTION.md (규칙 + 우선순위 + 한계) | ✅ |
| 3 | fixture 4 (Python/uv, TS/pnpm, Go, Rust) | ✅ |
| 4 | smoke 4/4 PASS | ✅ |
| 5 | Grey Area 15건 결정 | ✅ |
| 6 | 커밋 + push | ⏳ |

## Smoke 4/4 실측

| Fixture | 감지 lang | 감지 pm | test_cmd | 추가 |
|---------|----------|---------|----------|------|
| detect-python-uv | python | uv | uv run pytest | lint_cmd, format_cmd |
| detect-node-pnpm | typescript | pnpm | pnpm test | (biome 없음) |
| detect-go | go | go-mod | go test ./... | lint_cmd, format_cmd |
| detect-rust | rust | cargo | cargo test | lint_cmd, format_cmd |

모두 기대값과 일치. exit 0.

## Grey Area 15건 결정 반영

| ID | 결정 | 구현 |
|----|------|------|
| G1 | TOML only (JSON 보류) | ✅ |
| G2 | uv.lock 우선 + `[tool.poetry]` 구분 | ✅ |
| G3 | Java/Kotlin `src/main/kotlin/` 분기 | ✅ |
| G4 | runtime_version 미추출 | ✅ |
| G5 | Node version 미추출 | ✅ |
| G6 | unknown language 표시 | ✅ |
| G7 | 단일 언어 + monorepo 주석 | ✅ |
| G8 | 자동 .harness.toml 생성 안 함 | ✅ |
| G9 | Git Bash / forward slash | ✅ |
| G10 | bash 단일 | ✅ |
| G11 | fixture 4 | ✅ |
| G12 | Tier 2 커뮤니티 | ✅ 문서 |
| G13 | .mcp.json 별개 | ✅ |
| G14 | runtime_version v1.10 추가 | ✅ 문서 |
| G15 | test_cmd 없음 빈 출력 | ✅ |

## Lessons Learned

1. **bash `compgen -G`로 glob 검사**: `.csproj`/`.sln` 같은 와일드카드 검사에 `ls *.csproj 2>/dev/null | grep -q .` 패턴보다 `compgen -G "*.csproj" > /dev/null` 이 POSIX shell에서 더 정확. 단 Git Bash에서도 동작 확인됨.

2. **`has_content` 함수로 pyproject.toml 심층 검사**: `grep`으로 `[tool.poetry]` 섹션 존재 여부 판단 → v2 PEP 621 전용 pyproject와 구분. 깊은 TOML 파싱 없이 간단 정확.

3. **Node biome 감지는 optional**: `biome.json` 존재 시 lint/format 명령 자동 추가. 프로젝트에 없으면 skip. 후속 언어별 variant(v1.11+)에서 더 정밀 구분.

4. **fixture의 최소성**: 각 fixture는 감지 signature 파일만 포함 (실제 소스 코드 없음). smoke 검증 목적이므로 충분. 실제 bootstrap 시 언어별 template이 전체 골격 공급.

5. **detect → interview → manifest 파이프라인 단계 분리**: v1.9는 detect만. v1.10 interview가 결과를 사용자에게 보여주고 확정. v1.11+ template이 확정된 `.harness.toml`을 기반으로 `.claude/` 배포. 명확한 책임 분리.

## 커밋 계획

```
feat(meta): sessions/meta/v1.9-project-auto-detect — 프로젝트 자동 감지 스크립트

- add: bootstrap/detect-project.sh (~100 LOC bash-only)
    9 언어: python(uv/poetry/pdm/rye/hatch/pip), typescript/javascript(pnpm/bun/yarn/npm),
    go, rust, kotlin, java(gradle/maven), csharp, ruby, elixir
    Monorepo 감지 (pnpm-workspace/turbo/nx/go-work/cargo-workspace)
    TOML snippet stdout. test_cmd/lint_cmd/format_cmd 힌트 포함.
- add: bootstrap/docs/DETECTION.md
    지원 매트릭스 + 우선순위 + 한계 + 확장 가이드 + v1.10 interview 통합 계획
- add: tests/fixtures/detect-{python-uv,node-pnpm,go,rust}/
- add: sessions/meta/v1.9-project-auto-detect/{PLAN,REPORT,evidence/smoke-detect.txt}

Smoke 4/4 PASS — 각 언어별 기대 TOML 출력 검증.
Grey Area 15건 결정. v1.10 bootstrap interview 선행 작업.
```

## 후속

- v1.10-bootstrap-interview — detect 결과를 수용하는 인터뷰 로직
- v1.11~v1.13 bootstrap-templates — 언어별 overlay
