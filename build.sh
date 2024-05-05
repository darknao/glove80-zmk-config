#!/bin/bash

set -euo pipefail

IMAGE=glove80-zmk-config-docker
BRANCH="${1:-main}"

podman build -t "$IMAGE" .
podman run --rm -v "$PWD:/config:Z" -v "./glove80:/src:Z" -e BRANCH="$BRANCH" "$IMAGE"
