package cli

import (
	"fmt"
	"io"

	"github.com/telemachus/opts"
)

type cmdEnv struct {
	stdout        io.Writer
	stderr        io.Writer
	name          string
	version       string
	helpWanted    bool
	versionWanted bool
}

func (cmd *cmdEnv) parse(args []string) error {
	og := opts.NewGroup(cmd.name)
	og.Bool(&cmd.helpWanted, "help")
	og.Bool(&cmd.helpWanted, "h")
	og.Bool(&cmd.versionWanted, "version")
	og.Bool(&cmd.versionWanted, "V")

	// ParseAll rejects positional arguments. If {{.name}} needs them, switch
	// to og.Parse, which returns them.
	if err := og.ParseAll(args); err != nil {
		return fmt.Errorf("argument parsing error: %w", err)
	}

	return nil
}

const cmdUsage = `usage: {{.name}} [options]

{{.desc}}

Options:
  -h, --help     print this help and exit
  -V, --version  print version and exit
`
