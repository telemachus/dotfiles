{{if not (stringscontains .modPath "/")}}// The bare module path keeps this project off pkg.go.dev while it is
// experimental. Change it to github.com/telemachus/{{.name}} when it is ready.
{{end}}module {{.modPath}}

go {{.goVersion}}
