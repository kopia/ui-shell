GOOS:=$(shell go env GOOS)
GOARCH:=$(shell go env GOARCH)

LDFLAGS:=

# windows,linux,darwin
GOOS:=$(shell go env GOOS)
# amd64,arm64,arm
GOARCH:=$(shell go env GOARCH)

extension:=
ifeq ($(OS),Windows_NT)
extension=.exe
endif

ifeq ($(GOOS),darwin)
build: dist/darwin/universal/kopiaui
endif

ifeq ($(GOOS),windows)
build: dist/windows/amd64/kopiaui.exe
endif

ifeq ($(GOOS),linux)
build: dist/linux/amd64/kopiaui
endif

dist/darwin/universal/kopiaui: dist/darwin/arm64/kopiaui dist/darwin/amd64/kopiaui
	mkdir -p dist/darwin/universal
	lipo -create -output $@ $<

dist/darwin/arm64/kopiaui:
	GOOS=darwin GOARCH=arm64 CGO_ENABLED=1 SDKROOT=$(shell xcrun --sdk macosx --show-sdk-path) go build -o $@ .

dist/darwin/amd64/kopiaui:
	GOOS=darwin GOARCH=amd64 CGO_ENABLED=1 SDKROOT=$(shell xcrun --sdk macosx --show-sdk-path) go build -o $@ .

dist/windows/amd64/kopiaui.exe:
	GOOS=windows GOARCH=amd64 go build -ldflags "-H=windowsgui" -o $@ .

dist/linux/amd64/kopiaui:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=1 go build -o $@ .

