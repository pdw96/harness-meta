.PHONY: install verify smoke test test-integration lint help

help:
	@echo "harness-meta — available targets:"
	@echo "  make install   Print install guidance (v4.0+ static script 폐기 — Claude Code 자연어 호출)"
	@echo "  make verify    Print verify guidance (v4.2+ verify.{ps1,sh} 폐기 — environment-auditor subagent 호출)"
	@echo "  make smoke     Run primary smoke test (smoke-v1.1.sh)"
	@echo "  make test      Run all smoke tests in tests/"
	@echo "  make test-integration  Run integration tests in tests/integration/"
	@echo "  make lint      Shellcheck on .sh files (requires shellcheck)"

install:
	@echo "Static install script 폐기 (v4.0 B3)."
	@echo "Claude Code 안 자연어 호출: 'harness-meta 설치해줘' (또는 영어 동치)."
	@echo "메인 Claude 또는 component-installer subagent 가 v4.1 D7 5 step sequence"
	@echo "(Backup → OS detect → Primary attempt by OS [Windows junction / Linux/macOS symlink]"
	@echo " → Copy fallback → Cleanup retention) 진행."

verify:
	@echo "Static verify script 폐기 (v4.2_verify-infra-agent-absorption)."
	@echo "Claude Code 안 자연어 호출: 'verify 해줘' 또는 'environment audit 해줘'."
	@echo "메인 Claude 가 environment-auditor subagent 호출 → 10 stage 매트릭스"
	@echo "(Z 플랫폼 / A 환경 / B Symlink 또는 Junction / C settings.json / D Hook / E Statusline /"
	@echo " F backup / I Frontmatter / J PostToolUse / G Runtime-only) read-only audit."

smoke:
	bash tests/smoke-v1.1.sh

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
