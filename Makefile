.PHONY: install verify smoke test test-integration lint help

help:
	@echo "harness-meta — available targets:"
	@echo "  make install   Print install guidance (v4.0+ static script 폐기 — Claude Code 자연어 호출)"
	@echo "  make verify    Run verify.ps1 (30-check health report)"
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
	pwsh ./verify.ps1

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
