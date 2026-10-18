package cli_test

import (
	"bytes"
	"testing"

	"{{.modPath}}/internal/cli"
)

// Test{{.funcName}} is a placeholder that fails on purpose: replace it with
// the first real test.
func Test{{.funcName}}(t *testing.T) {
	t.Parallel()

	var stdout, stderr bytes.Buffer
	status := cli.{{.funcName}}(nil, &stdout, &stderr)
	t.Errorf("cli.{{.funcName}}(nil, ...) = %d; TODO: write a real test", status)
}
