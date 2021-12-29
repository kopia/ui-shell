GOOS:=$(shell go env GOOS)
GOARCH:=$(shell go env GOARCH)

LDFLAGS:=

ifeq ($(OS),Windows_NT)
LDFLAGS+=-H=windowsgui
endif

build:
	go build -ldflags "$(LDFLAGS)" -o dist/$(GOOS)/$(GOARCH)/kopiaui .

