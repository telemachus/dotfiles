#!/usr/bin/env bash

go install github.com/kisielk/errcheck@latest || exit 1
go install github.com/rogpeppe/godef@latest || exit 1
go install golang.org/x/tools/cmd/goimports@latest || exit 1
go install github.com/mgechev/revive@latest || exit 1
go install golang.org/x/tools/gopls@latest || exit 1
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest || exit 1
go install honnef.co/go/tools/cmd/staticcheck@latest || exit 1
go install golang.org/x/tools/cmd/gorename@latest || exit 1
go install github.com/fatih/motion@latest || exit 1
go install mvdan.cc/gofumpt@latest || exit 1
go install github.com/segmentio/golines@latest || exit 1
