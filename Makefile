PLATFORM ?= platform

build:
	docker build \
		--no-cache \
		--platform=linux/$(PLATFORM) \
		--build-arg PLATFORM=$(PLATFORM) \
		--tag=reecerose/health-check:$(PLATFORM) \
		-f Dockerfile .
