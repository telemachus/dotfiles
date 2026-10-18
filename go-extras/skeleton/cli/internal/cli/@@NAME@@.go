// Package cli implements the command line interface for {{.name}}.
package cli

import (
	"fmt"
	"io"
)

const (
	exitSuccess      = 0
	exitFailure      = 1
	exitParseFailure = 2
)

// {{.funcName}} runs {{.name}} with args, writing output to stdout and errors
// to stderr. It returns 0 for success, 1 for failure, and 2 for an error while
// parsing the command line.
func {{.funcName}}(args []string, stdout, stderr io.Writer) int {
	cmd := &cmdEnv{
		name:    "{{.name}}",
		version: "v0.0.1",
		stdout:  stdout,
		stderr:  stderr,
	}
	if err := cmd.parse(args); err != nil {
		fmt.Fprintf(cmd.stderr, "%s: %s\n", cmd.name, err)
		fmt.Fprintf(cmd.stderr, "Use '%s --help' for more information.\n", cmd.name)

		return exitParseFailure
	}

	// Help and version are not errors.
	switch {
	case cmd.helpWanted:
		fmt.Fprint(cmd.stdout, cmdUsage)

		return exitSuccess
	case cmd.versionWanted:
		fmt.Fprintln(cmd.stdout, cmd.name, cmd.version)

		return exitSuccess
	}

	// TODO: write the program. Return exitFailure if it fails.

	return exitSuccess
}
