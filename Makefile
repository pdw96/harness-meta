.PHONY: install verify smoke test test-integration lint help

help:
	@echo "harness-meta — available targets:"
	@echo "  make install   Print install guidance (v5.0+ Claude Code Plugin spec — claude plugin install)"
	@echo "  make verify    Print verify guidance (v4.2+ verify.{ps1,sh} 폐기 — environment-auditor subagent 호출)"
	@echo "  make smoke     Run CI/pre-commit active smoke tests"
	@echo "  make test      Run all smoke tests in tests/"
	@echo "  make test-integration  Run integration tests in tests/integration/"
	@echo "  make lint      Shellcheck on .sh files (requires shellcheck)"

install:
	@echo "v5.0+ install — Claude Code Plugin spec 채택 (.claude-plugin/plugin.json manifest)."
	@echo "표준 명령 (Option A — 외부 방문자, clone 불요):"
	@echo "  1. claude plugin marketplace add pdw96/harness-meta"
	@echo "  2. claude plugin install harness-meta@harness-meta"
	@echo ""
	@echo "로컬 dev (Option B):"
	@echo "  1. git clone https://github.com/pdw96/harness-meta \$$HOME/harness-meta"
	@echo "  2. claude plugin marketplace add ~/harness-meta"
	@echo "  3. claude plugin install harness-meta@harness-meta"
	@echo ""
	@echo "Plugin source 거주: ~/.claude/plugins/cache/harness-meta/"
	@echo "Deprecated since v5.0 (v5.0+ 환경에서는 비활성): 자연어 'harness-meta 설치해줘' + v4.1 D7 sequence."

verify:
	@echo "Static verify script 폐기 (v4.2_verify-infra-agent-absorption)."
	@echo "Claude Code 안 자연어 호출: 'verify 해줘' 또는 'environment audit 해줘'."
	@echo "메인 Claude 가 environment-auditor subagent 호출 → 10 stage 매트릭스"
	@echo "(Z 플랫폼 / A 환경 / B Symlink 또는 Junction / C settings.json / D Hook / E Statusline /"
	@echo " F backup / I Frontmatter / J PostToolUse / G Runtime-only) read-only audit."

smoke:
	@failed=0; \
	for f in \
		tests/smoke-projects-scope-discipline.sh \
		tests/smoke-spec-verification.sh \
		tests/smoke-scope-contract.sh \
		tests/smoke-cross-ref.sh \
		tests/smoke-claude-md-drift.sh \
		tests/smoke-bundle-trigger.sh \
		tests/smoke-open-stage-discipline.sh \
		tests/smoke-entry-title-guideline.sh \
		tests/smoke-cascade-drift.sh \
		tests/smoke-candidate-draft-schema.sh \
		tests/smoke-audit-fact-verify.sh \
		tests/smoke-agent-frontmatter-schema.sh \
		tests/smoke-roadmap-archival.sh \
		tests/smoke-workflow-registration.sh \
		tests/smoke-plugin-manifest.sh; do \
		echo "--- $$f ---"; \
		bash "$$f" || failed=$$((failed+1)); \
	done; \
	if [ $$failed -gt 0 ]; then echo "FAIL: $$failed active smoke test(s) failed"; exit 1; fi; \
	echo "ALL ACTIVE SMOKES PASS"

test:
	@failed=0; \
	for f in tests/smoke-*.sh; do \
		echo "--- $$f ---"; \
		bash "$$f" || failed=$$((failed+1)); \
	done; \
	if [ $$failed -gt 0 ]; then echo "FAIL: $$failed test(s) failed"; exit 1; fi; \
	echo "ALL PASS"

test-integration:
	@failed=0; \
	for f in tests/integration/*.sh; do \
		echo "--- $$f ---"; \
		bash "$$f" || failed=$$((failed+1)); \
	done; \
	if [ $$failed -gt 0 ]; then echo "FAIL: $$failed test(s) failed"; exit 1; fi; \
	echo "ALL PASS"

lint:
	@which shellcheck > /dev/null 2>&1 || (echo "shellcheck not installed — brew install shellcheck / apt install shellcheck"; exit 0)
	shellcheck tests/*.sh bootstrap/*.sh claude/hooks/*.sh
