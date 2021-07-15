.DEFAULT_GOAL := help

CONTAINER_NAME:=kafka-cli
REPOSITORY:=totoroot
IMAGE_VERSION:=2.8.0
VERSION:=$(IMAGE_VERSION)-$(shell git describe --tags --always --dirty)

init:
	git config core.hooksPath .githooks

docker-build:
	docker build . -t ${REPOSITORY}/${CONTAINER_NAME}:${VERSION}

docker-push: docker-build
	docker push ${REPOSITORY}/${CONTAINER_NAME}:${VERSION}

docker-run: docker-build
	docker run --network host --name ${CONTAINER_NAME} ${REPOSITORY}/${CONTAINER_NAME}:${VERSION}

.PHONY: help
help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
