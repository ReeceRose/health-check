setup:
	docker buildx create --use

build:
	docker build \
		--no-cache \
		--platform=linux/$(PLATFORM) \
		--build-arg PLATFORM=$(PLATFORM) \
		--tag=reecerose/health-check:$(PLATFORM) \
		-f Dockerfile .

# Build and push
build-push:
	docker buildx build \
		--push \
		--no-cache \
		--platform linux/amd64,linux/arm64 \
		--tag=reecerose/health-check:latest \
		-f Dockerfile .
