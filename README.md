# Health Check

Simple Golang executable which makes an HTTP request to a health-check endpoint.

## Purpose

I needed a quick (and small!) solution for making an HTTP request to check the health of my API. Initially, I thought about just adding cUrl to my Dockerfile but this added about 5MB of size. This container alone is under 2MB and when baked into an image is most likely less than that.

## How to use

Using `health-check` is as easy as adding the following to your docker container:

```bash
# Near the top of your file...
FROM reecerose/health-check:amd64 as health-check

# Near the bottom of your file...
COPY --from=health-check /health-check /

# This can also be done via docker-compose instead of directly in the container
HEALTHCHECK --interval=60s --timeout=5s --start-period=10s --retries=1 CMD [ "/health-check" ]
```

By default, this will make an HTTP request to `http://localhost:80/health` but this can me modified using [environment variables](# Environment Variables).

The program accepts any status code between 200-299.

If you do not pass a platform arch to your container, just update that and replace it with your desired supported platform.

## Environment Variables

`HEALTH_CHECK_HTTP://HEALTH_CHECK_HTTP_BASE_URL:HEALTH_CHECK_HTTP_PORT/HEALTH_CHECK_HTTP_ROUTE` is the URL construction with environment variables.

- HEALTH_CHECK_HTTP: HTTP method (`http` or `https`) - defaults to `http`
- HEALTH_CHECK_HTTP_BASE_URL: URL of the application - defaults to `localhost`
- HEALTH_CHECK_HTTP_PORT: Port which the application is running on  - defaults to `80`
- HEALTH_CHECK_HTTP_ROUTE: Route of the health-check endpoint  - defaults to `health`

## Supported platforms

Currently, there are images for `amd64` and `arm64`. If you would like additional support, build the container via `make PLATFORM=<platform> build`. This should provide you with a cross compiled container of your platform choice.
