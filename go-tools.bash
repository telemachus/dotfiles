#!/usr/bin/env bash

go install github.com/kisielk/errcheck@latest
go install github.com/rogpeppe/godef@latest
go install golang.org/x/tools/cmd/goimports@master
go install github.com/mgechev/revive@latest
go install golang.org/x/tools/gopls@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
go install golang.org/x/tools/cmd/gorename@master
go install github.com/fatih/gomodifytags@latest
go install github.com/jstemmer/gotags@master
go install golang.org/x/tools/cmd/guru@master
go install github.com/josharian/impl@master
go install honnef.co/go/tools/cmd/keyify@master
go install github.com/fatih/motion@latest
