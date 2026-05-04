# bootstrap/ 모듈 가이드

신규 프로젝트 도입 자산 + 글로벌 user-skill source + 언어별 overlay templates를 보관하는 모듈.
Claude Code가 `bootstrap/` 하위 파일 접근 시 본 가이드를 on-demand로 추가 로드한다.

상위 진입: [`../CLAUDE.md`](../CLAUDE.md)

## 디렉토리 구성

```
bootstrap/
├── interview.md                    # Bootstrap 인터뷰 질문지 (7 유효 질문 + 자동 적용 10건)
├── manifest-schema.md              # .harness.toml v1.1 스펙
├── render-manifest.sh              # manifest 렌더러 (TOML 안전성 검증)
├── detect-project.sh               # 언어/PM/test_cmd/license 4-tier 감지
├── install-project-claude.{ps1,sh} # 프로젝트 .claude/ 14 파일 배포 (Phase 1 _base + Phase 2 overlay)
├── docs/                           # 단일 소스 도메인 docs
│   ├── OWNERSHIP.md                # S1~S7 + T1~T5 세션 소속 규약
│   ├── AGENTS_MD_STRATEGY.md       # AGENTS.md 표준 채택 + symlink/copy 이중 전략
│   ├── INTERVIEW_FLOW.md           # 8-stage Bootstrap 흐름
│   ├── OVERLAY.md                  # language overlay (10 lang matrix + harness-* prefix)
│   ├── SKILLS.md                   # 글로벌 user-skill 디렉토리 + 배포
│   ├── SPEC_VERIFICATION.md        # PLAN/REPORT context7 § 규격 + cross-file 매트릭스
│   ├── PERMISSION_PATTERN.md       # frontmatter 6축 spec
│   └── DETECTION.md                # detect-project.sh 규칙
├── skeletons/                      # Bootstrap S4/S6 산출물 템플릿 (CLAUDE.md.tmpl 등)
├── skills/                         # 글로벌 user-skill source — see skills/CLAUDE.md
└── templates/
    ├── _base/.claude/              # 언어 불문 baseline (14 파일: agents/skills/output-styles)
    └── <language>/.claude/         # 언어별 overlay (v1.11+ — python/ active)
```

## 핵심 규약

### Bootstrap 모드 진입

`/harness-meta <new-name>` 슬래시 명령이 다음 둘 다 부재 시 진입:

- `<proj>/.harness.toml` 부재
- `~/harness-meta/projects/<name>/` 부재

상세 8-stage: [`docs/INTERVIEW_FLOW.md`](docs/INTERVIEW_FLOW.md). 인터뷰 질문지: [`interview.md`](interview.md).

### Manifest 작성

- **schema_version**: v1.1 (additive only, v1.0 backward compat 100%)
- **bash 파싱 호환**: grep+sed로 `name`/`code_dir`/`phases_dir`/`statusline_cmd`/`state_file` 추출 가능해야 함 — 평탄 구조 + 단일 키
- **TOML 안전성**: 5종 (`"`, `'`, `\n`, `$`, `\`) 거부 → `render-manifest.sh` exit 2

스펙 단일 소스: [`manifest-schema.md`](manifest-schema.md).

### Templates 분리

- **_base/** — 언어 불문 baseline (14 파일). v1.8b commands→skills 이관 후 `agents/skills/output-styles` 3 카테고리만
- **<language>/** — 언어별 overlay. **`harness-*` prefix 의무** (사용자 custom 보호). 우선순위: overlay > _base
- **install-project-claude.{ps1,sh}** Phase 1 (_base) + Phase 2 (overlay) merge

상세: [`docs/OVERLAY.md`](docs/OVERLAY.md).

### Skeletons (Bootstrap S4/S6 산출물)

- `skeletons/CLAUDE.md.tmpl` — 프로젝트 CLAUDE.md (3 import: AGENTS.md + ARCHITECTURE.md + 조건부 CLAUDE.override.md)
- `skeletons/AGENTS.md.tmpl` — 프로젝트 baseline (영문 60~80행, 15 sed 변수)
- `skeletons/projects/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK,ROADMAP}.md.tmpl` — 5종 (v1.36+)
- `skeletons/sessions/v0.1-bootstrap/{PLAN,REPORT}.md.tmpl`

치환 방식: Claude(Bootstrap)가 `Read` → 답변 기반 텍스트 치환 → `Write` (sed helper script 없음).

### License 4-tier 감지 (v1.10e3)

`detect-project.sh`가 LICENSE 파일 + 메타데이터 자동 추출 → AGENTS.md `{{license}}` 치환:

1. **T1** SPDX-License-Identifier 헤더
2. **T2-Multi** multi-file dual-license (`LICENSE-MIT` + `LICENSE-APACHE`)
3. **T2** boilerplate 12 패턴
4. **T2.5** Cargo `license-file = "<path>"` 사용자 정의 LICENSE
5. **T3** 메타데이터 4 source (npm + PEP 639/621/poetry + Cargo)
6. **T4** Fallback `see LICENSE.`

상세: [`manifest-schema.md`](manifest-schema.md) §License 처리 + `interview.md` `## License`.

## 작업 가이드

### 신규 도메인 docs 추가 시

1. `bootstrap/docs/<NAME>.md` 작성 (단일 소스)
2. 본 `bootstrap/CLAUDE.md` `## 디렉토리 구성`에 1줄 추가
3. 상위 `../CLAUDE.md` 관련 문서 §에 cross-ref 추가 (root CLAUDE.md는 핵심 5건만 유지)
4. `sessions/meta/vX.Y-{name}/` 세션 기록

### 인터뷰 질문 추가/변경 시

1. `interview.md` 갱신 (Q번호 매트릭스 + UX 시퀀스)
2. `docs/INTERVIEW_FLOW.md` Stage S2 매핑 갱신
3. `render-manifest.sh` env mapping 추가 (필요 시)
4. `tests/smoke-bootstrap-render.sh` 회귀 검증

### Templates 변경 시

- `_base/.claude/<cat>/<file>` 추가/수정 → 모든 프로젝트 `install-project-claude` 재실행 필요 (BREAKING)
- `<language>/.claude/` overlay → 해당 언어 프로젝트만 영향
- 변경 후 fixture(`tests/fixtures/sample-project/`)로 dynamic 검증

## 관련 문서

- 상위 진입: [`../CLAUDE.md`](../CLAUDE.md) · [`../README.md`](../README.md)
- AGENTS.md 표준: [`docs/AGENTS_MD_STRATEGY.md`](docs/AGENTS_MD_STRATEGY.md)
- ROADMAP: [`../sessions/meta/ROADMAP.md`](../sessions/meta/ROADMAP.md)
- Bootstrap 첫 적용 사례 — upbit: [`../sessions/upbit/v0.1-bootstrap/`](../sessions/upbit/v0.1-bootstrap/) (참고)
