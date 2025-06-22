.DEFAULT_GOAL := test

fmt:
	golangci-lint run --disable-all --no-config -Egofmt --fix
	golangci-lint run --disable-all --no-config -Egofumpt --fix

staticcheck: fmt
	staticcheck .

revive: fmt
	revive -config revive.toml ./...

golangci: fmt
	golangci-lint run

lint: fmt staticcheck revive golangci

test:
	go test -shuffle on

testv:
	go test -shuffle on -v

testr:
	go test -race -shuffle on

build: lint testr
	go build .

install: build
	go install .

clean:
	go clean -i -r -cache

.PHONY: fmt staticcheck revive golangci lint build install test testv testr clean
