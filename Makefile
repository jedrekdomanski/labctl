GIT_COMMIT=$(shell git rev-parse --verify HEAD)
UTC_NOW=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")

.PHONY: build-dev
build-dev:
	go build \
		-ldflags="-X 'main.tagVersion=dev' -X 'main.tagCommit=${GIT_COMMIT}' -X 'main.tagDate=${UTC_NOW}'" \
		-o labctl

.PHONY: build-dev-darwin-arm64
build-dev-darwin-arm64:
	GOOS=darwin GOARCH=arm64 go build \
		-ldflags="-X 'main.tagVersion=dev' -X 'main.tagCommit=${GIT_COMMIT}' -X 'main.tagDate=${UTC_NOW}'" \
		-o labctl

.PHONY: release
release:
	goreleaser --clean

.PHONY: release-snapshot
release-snapshot:
	goreleaser release --snapshot --clean

.PHONY: test-e2e
test-e2e:
	go test -v -count 1 ./e2e/exec
