.DEFAULT_GOAL := build

fmt:
	go fmt ./...

lint: fmt
	golangci-lint run

build: lint
	go build .

install: build
	go install .

test:
	go test -shuffle on ./...

testv:
	go test -shuffle on -v ./...

.PHONY: fmt lint build install test testv
