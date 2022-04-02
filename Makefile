DOCKER_REGISTRY		?=ghcr.io/best-friends
DOCKER_IMAGE_NAME ?=pgbouncer
DOCKER_IMAGE_TAG	?=latest
DOCKER_IMAGE			:=${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}

.PHONY: build
build:
	@docker build -t ${DOCKER_IMAGE} .

.PHONY: run
run: build
	@docker run -it --rm ${DOCKER_IMAGE} /bin/sh
