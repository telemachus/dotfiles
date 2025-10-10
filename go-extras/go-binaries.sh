#!/usr/bin/env dash

warn() {
    printf >&2 '%s: %s\n' "${0##*/}" "$1"
}

go install golang.org/x/perf/cmd/benchstat@latest ||
    warn "failed to install benchstat"
go install github.com/kisielk/errcheck@latest ||
    warn "failed to install errcheck"
go install github.com/rogpeppe/godef@latest ||
    warn "failed to install godef"
go install golang.org/x/tools/cmd/goimports@latest ||
    warn "failed to install goimports"
go install github.com/mgechev/revive@latest ||
    warn "failed to install revive"
go install golang.org/x/tools/gopls@latest ||
    warn "failed to install gopls"
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest ||
    warn "failed to install golangci-lint"
go install honnef.co/go/tools/cmd/staticcheck@latest ||
    warn "failed to install staticcheck"
go install mvdan.cc/gofumpt@latest ||
    warn "failed to install gofumpt"
go install github.com/segmentio/golines@latest ||
    warn "failed to install golines"
go install golang.org/x/tools/cmd/godoc@latest ||
    warn "failed to install godoc"
go install golang.org/x/vuln/cmd/govulncheck@latest ||
    warn "failed to install govulncheck"
go install github.com/itchyny/gojq/cmd/gojq@latest ||
    warn "failed to install gojq"
go install go.uber.org/nilaway/cmd/nilaway@latest ||
    warn "failed to install nilaway"
go install golang.org/x/tools/go/analysis/passes/fieldalignment/cmd/fieldalignment@latest ||
    warn "failed to install fieldalignment"
go install github.com/dkorunic/betteralign/cmd/betteralign@latest ||
    warn "failed to install betteralign"
