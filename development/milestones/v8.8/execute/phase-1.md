# v8.8 execute — phase-1: 스캐너 hook + 등록

## changes

1. **`claude/hooks/session-start-secret-scan.sh`** (신규, bash-only, LF) — settings*.json raw grep 스캐너.
   - gate = `$CLAUDE_PROJECT_DIR/.claude/settings.json` + `settings.local.json` 명시 열거 + `[ -f ]` 가드 (glob nullglob 함정 회피, d_8b).
   - 보수 prefix-anchored 패턴 6종 (single-quote 배열 → JWT `\.` literal dot 보존, d_8a): Docker Hub PAT / Anthropic / GitHub classic PAT / GitHub fine-grained PAT(`github_pat_`, D-SEC-2) / AWS access key id(`AKIA` 한정, D-FP-1) / JWT.
   - secret 부재 시 `printf '{}'` no-op. 감지 시 `systemMessage`(사용자 UI 직접) + `additionalContext`(Claude relay) 병용 (D-DRIFT-1, claude-code-guide 확인).
   - 메시지(영문, locale §8) = 패턴명 + 'suspected' + tracked 차등 통지(settings.json HIGH / local gitignore, D-SEC-1) + 회수·rotate 안내.
   - JSON escape 4-step = session-init.sh 패턴 재사용 (d_6). 모든 분기 exit 0 + valid JSON.

2. **`claude/hooks/hooks.json`** — SessionStart[].hooks[] 에 3번째 command append (`${CLAUDE_PLUGIN_ROOT}/claude/hooks/session-start-secret-scan.sh`, d_5). 기존 session-init / version-track 무손상.

## verification (수동 4 케이스)

| 케이스 | 기대 | 결과 |
| --- | --- | --- |
| (1) harness-meta 자신 settings.local.json FP baseline | `{}` (오탐 0) | PASS — `{}` |
| (2) 모의 secret(dckr_pat_ + JWT eyJ.x.y) | systemMessage 에 Docker Hub PAT + JWT | PASS |
| (3) 정상 fixture(git push/curl docs URL) | no-op `{}` | PASS |
| (4) github_pat_ + dot 없는 eyJ 문자열 | github_pat 감지 + JWT 거부(literal dot 강제) | PASS |

모든 출력 valid JSON (python json.load 통과). sc_1/sc_2/sc_3/sc_5 phase-1 분 충족.

## commit

(phase-2 완료 후 milestone 단위 커밋 — 사용자 확인 후)
