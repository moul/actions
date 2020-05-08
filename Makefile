DOCKER_IMAGE ?= moul/actions

all: shellcheck build test

.PHONY: shellcheck
shellcheck:
	shellcheck entrypoint.sh

.PHONY: build
build:
	docker build -t $(DOCKER_IMAGE) .

.PHONY: test
test:
	docker run -it --rm $(DOCKER_IMAGE) "lgtm" "." "false" "invalid-github-token"
