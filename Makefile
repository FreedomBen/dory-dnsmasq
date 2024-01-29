include .env

default: help

## help		:	Prints this help.
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
	docker buildx build --build-arg alpine_tag=${alpine_tag} --build-arg dnsmasq_version=${dnsmasq_version} --platform ${platforms} -t docker.io/tripox/dory-dnsmasq:${tag} . --push
	docker buildx build --build-arg alpine_tag=${alpine_tag} --build-arg dnsmasq_version=${dnsmasq_version} --platform ${platforms} -t docker.io/tripox/dory-dnsmasq:latest . --push

## remove		:	Remove the builder.
.PHONY: remove
remove :
	docker buildx rm dory