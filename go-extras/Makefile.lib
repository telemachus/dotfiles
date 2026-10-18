.DEFAULT_GOAL := test

fmt:
	golangci-lint fmt --no-config -Egofumpt

staticcheck:
	staticcheck ./...

revive:
	revive -config revive.toml ./...

golangci:
	golangci-lint run

lint: staticcheck revive golangci

vuln:
	govulncheck ./...

test:
	go test -shuffle on ./...

testv:
	go test -shuffle on -v ./...

testr:
	go test -race -shuffle on ./...

build: lint testr
	go build ./...

clean:
	go clean

cacheclean:
	go clean -testcache

.PHONY: fmt staticcheck revive golangci lint vuln
.PHONY: test testv testr build clean cacheclean
