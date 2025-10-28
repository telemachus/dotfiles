.PHONY: install-nlua tapered-tests unnamed-tests

# Install nlua and busted via luarocks
install-nlua:
	@if ! command -v "$$HOME/local/lua/bin/nlua" >/dev/null 2>&1; then \
		printf "Installing nlua...\n"; \
		luarocks install nlua; \
	fi

# Run tapered tests, installing nlua if needed
tapered-tests: install-nlua
	@nlua test/tapered_test.lua

# Run unnamed tests, installing nlua if needed
unnamed-tests: install-nlua
	@nlua test/unnamed_test.lua
