include .env

default: help

## help	:	Prints this help.
.PHONY: help
help :
	@sed -n 's/^##//p' Makefile

## builder	:	Create the builder.
.PHONY: builder
builder :
	docker buildx create --name dory --use

## build push	:	Build and push docker images.
.PHONY: build push
build push :
	docker buildx build --build-arg version=${version} --platform ${platforms} -t docker.io/tripox/dory-dnsmasq:${version} . --push
	docker buildx build --build-arg version=${version} --platform ${platforms} -t docker.io/tripox/dory-dnsmasq:latest . --push
