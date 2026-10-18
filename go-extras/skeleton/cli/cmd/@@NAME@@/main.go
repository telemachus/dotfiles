package main

import (
	"os"

	"{{.modPath}}/internal/cli"
)

func main() {
	os.Exit(cli.{{.funcName}}(os.Args[1:], os.Stdout, os.Stderr))
}
