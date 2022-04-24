# Note, need to specify amd64 as arm64 cannot fetch upx package (Mac M1 hack)
FROM --platform=amd64 golang:1.18.1-alpine3.15 AS builder
ARG TARGETARCH

WORKDIR /app
COPY . .
RUN apk update \
  && apk add upx

RUN GO111MODULE=on CGO_ENABLED=0 GOOS=linux GOARCH=$TARGETARCH go build -ldflags "-s -w" -o build/health-check main.go
RUN upx -4 build/health-check
RUN mv build/health-check /health-check

FROM scratch
COPY --from=builder /health-check /

ENTRYPOINT ["/health-check"]
