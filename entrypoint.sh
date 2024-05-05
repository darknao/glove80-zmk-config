#!/usr/bin/env bash
set -euo pipefail
: "${BRANCH:=main}"

echo "Checking out $BRANCH from moergo-sc/zmk" >&2
cd /src
#git fetch origin
#git checkout -q --detach "$BRANCH"
git status

echo 'Building Glove80 firmware' >&2
cd /config
nix-build ./config --arg firmware 'import /src/default.nix {}' -j2 -o /tmp/combined --show-trace
install /tmp/combined/glove80.uf2 ./glove80.uf2
