.PHONY: install verify smoke test lint help

help:
	@echo "harness-meta — available targets:"
	@echo "  make install   Install global symlinks (~/.claude/)"
	@echo "  make verify    Run verify.ps1 (30-check health report)"
	@echo "  make smoke     Run primary smoke test (smoke-v1.1.sh)"
	@echo "  make test      Run all smoke tests in tests/"
	@echo "  make lint      Shellcheck on .sh files (requires shellcheck)"

install:
	pwsh ./install.ps1

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

lint:
	@which shellcheck > /dev/null 2>&1 || (echo "shellcheck not installed — brew install shellcheck / apt install shellcheck"; exit 0)
	shellcheck tests/*.sh bootstrap/*.sh claude/hooks/*.sh
