#!/bin/bash

make PLATFORM=amd64
make PLATFORM=arm64

docker push reecerose/health-check:amd64
docker push reecerose/health-check:arm64