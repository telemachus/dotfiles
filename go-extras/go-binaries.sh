#!/usr/bin/env dash

# Protect me from myself.
set -u

golangci_version=v2.14.0
failed=0

warn() {
    printf >&2 '%s: %s\n' "${0##*/}" "$1"
    failed=1
}

die() {
    warn "$1"
    exit 1
}

# Ensure we have the commands we need.
for cmd in go curl; do
    if ! command -v "$cmd" >/dev/null; then
        die "$cmd not found"
    fi
done

go install golang.org/x/perf/cmd/benchstat@latest ||
    warn "failed to install benchstat"
go install golang.org/x/tools/cmd/goimports@latest ||
    warn "failed to install goimports"
go install github.com/mgechev/revive@latest ||
    warn "failed to install revive"
go install golang.org/x/tools/gopls@latest ||
    warn "failed to install gopls"
go install honnef.co/go/tools/cmd/staticcheck@latest ||
    warn "failed to install staticcheck"
go install mvdan.cc/gofumpt@latest ||
    warn "failed to install gofumpt"
go install github.com/segmentio/golines@latest ||
    warn "failed to install golines"
go install golang.org/x/pkgsite/cmd/pkgsite@latest ||
    warn "failed to install pkgsite"
go install golang.org/x/vuln/cmd/govulncheck@latest ||
    warn "failed to install govulncheck"
go install github.com/itchyny/gojq/cmd/gojq@latest ||
    warn "failed to install gojq"
go install go.uber.org/nilaway/cmd/nilaway@latest ||
    warn "failed to install nilaway"
go install golang.org/x/tools/go/analysis/passes/fieldalignment/cmd/fieldalignment@latest ||
    warn "failed to install fieldalignment"
go install mvdan.cc/sh/v3/cmd/shfmt@latest ||
    warn "failed to install shfmt"
go install github.com/carlmjohnson/springerle@latest ||
    warn "failed to install springerle"

# This is a bit elaborate, but dash may lack pipefail.
installer=$(mktemp)
if curl -sSfL -o "$installer" https://golangci-lint.run/install.sh; then
    sh "$installer" -b "$(go env GOPATH)/bin" "$golangci_version" ||
        warn "failed to install golangci-lint"
else
    warn "failed to download the golangci-lint installer"
fi
rm -f "$installer"

exit "$failed"
