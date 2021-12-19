GOOS:=$(shell go env GOOS)
GOARCH:=$(shell go env GOARCH)

build:
	go build -o dist/$(GOOS)/$(GOARCH)/kopiaui .

