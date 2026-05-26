#!/usr/bin/env bash
# SessionStart hook — .claude/settings*.json 평문 secret 스캔 경고 (v8.8).
#
# Design (v8.8_settings-allowlist-secret-scan):
#   - origin = v8.7 부수 발견: Claude Code 가 과거 curl 명령을 settings.local.json
#     permissions.allow 리스트에 통째 저장하며 평문 PAT/JWT 박제. allow 갱신은
#     발화 hook 이벤트가 부재(claude-code-guide 2026-05-27) → PreToolUse 로 구조적
#     관측 불가 → SessionStart 주기 스캔이 유일 viable 메커니즘.
#   - JSON 구조 파싱 안 함 (session-init.sh '깊은 파싱 안 함' 철학 정합) — settings
#     파일을 raw grep. secret 이 allow/deny/기타 어느 키에 있든 포착.
#   - warn-only (block/자동수정 부재) — false positive 회피 + 작성자 판단 1차 source.
#   - 보수 prefix-anchored 패턴만 — FP=0 목표 (generic password regex 의도 제외).
#   - gate = .claude/settings*.json 존재 (CWD-relative) → harness-meta 자기 보호 +
#     글로벌 hook CWD-무관 특성으로 임의 프로젝트 자동 커버 (의도된 보호 확장).
#
# Output: systemMessage (사용자 UI 직접 표시) + hookSpecificOutput.additionalContext
#         (Claude relay). SessionStart 가 systemMessage universal field 지원
#         (claude-code-guide 2026-05-27 확인).
# Registration: claude/hooks/hooks.json SessionStart[].hooks[]
#
# All branches exit 0 with valid JSON to avoid Claude Code SessionStart UI
# error (anthropics/claude-code issues #12671, #19346, #21643).

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"

# 1. 후보 settings 파일 명시 열거 ([-f] 가드 → glob nullglob 함정 회피)
files=()
for f in "$PROJECT_DIR/.claude/settings.json" "$PROJECT_DIR/.claude/settings.local.json"; do
    [ -f "$f" ] && files+=("$f")
done

# settings 파일 부재 -> no-op
if [ "${#files[@]}" -eq 0 ]; then
    printf '{}'
    exit 0
fi

# 2. 보수 prefix-anchored secret 패턴 (single-quote → JWT 의 \. literal dot 보존)
#    형식: 'name|ERE-regex' (regex 에 | 부재하므로 첫 | 로 split)
patterns=(
    'Docker Hub PAT|dckr_pat_[A-Za-z0-9_-]{8,}'
    'Anthropic API key|sk-ant-[A-Za-z0-9_-]{8,}'
    'GitHub classic PAT|gh[pousr]_[A-Za-z0-9]{20,}'
    'GitHub fine-grained PAT|github_pat_[A-Za-z0-9_]{22,}'
    'AWS access key id|AKIA[0-9A-Z]{16}'
    'JWT|eyJ[A-Za-z0-9_-]{8,}\.[A-Za-z0-9_-]{8,}\.[A-Za-z0-9_-]{8,}'
)

hit_names=""
shared_hit=0   # settings.json — 통상 commit (노출 위험 高)
local_hit=0    # settings.local.json — 통상 gitignore

_add_name() {
    case ",$hit_names," in
        *",$1,"*) ;;  # 이미 포함
        *) hit_names="${hit_names:+$hit_names, }$1" ;;
    esac
}

for entry in "${patterns[@]}"; do
    name="${entry%%|*}"
    regex="${entry#*|}"
    for f in "${files[@]}"; do
        if grep -Eq "$regex" "$f" 2>/dev/null; then
            _add_name "$name"
            case "$f" in
                *settings.local.json) local_hit=1 ;;
                *settings.json) shared_hit=1 ;;
            esac
        fi
    done
done

# 3. secret 부재 -> no-op
if [ -z "$hit_names" ]; then
    printf '{}'
    exit 0
fi

# 4. 경고 메시지 (영문 — AGENTS.md §8 locale, 기존 SessionStart hook 2종 정합)
risk_note=""
if [ "$shared_hit" -eq 1 ]; then
    risk_note="$risk_note settings.json is typically committed to git (HIGH exposure)."
fi
if [ "$local_hit" -eq 1 ]; then
    risk_note="$risk_note settings.local.json is usually gitignored (lower exposure, but plaintext locally)."
fi

msg="[Security] Suspected plaintext secret(s) in .claude settings: ${hit_names}. Move them to environment variables or a secret manager. If stored in the permissions allow-list, remove the entry and rotate/revoke the credential (an AWS access key id implies a paired secret access key — check both).${risk_note}"

# 5. JSON escape (session-init.sh 4-step 패턴 재사용)
#    Step 1: strip control chars illegal raw in JSON strings.
#    Step 2: escape backslash, double-quote, tab, CR; awk joins lines with \n.
escaped=$(printf '%s' "$msg" \
    | LC_ALL=C tr -d '\000-\010\013\014\016-\037\177' \
    | sed -e 's/\\/\\\\/g' \
          -e 's/"/\\"/g' \
          -e 's/\t/\\t/g' \
          -e 's/\r/\\r/g' \
    | awk 'BEGIN{ORS=""} NR>1{print "\\n"} {print}')

printf '{"systemMessage":"%s","hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}' "$escaped" "$escaped"
exit 0
