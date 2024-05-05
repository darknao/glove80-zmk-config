FROM nixpkgs/nix:nixos-23.11

ENV PATH=/root/.nix-profile/bin:/usr/bin:/bin

RUN <<EOF
    set -euo pipefail
    nix-env -iA cachix -f https://cachix.org/api/v1/install
    cachix use moergo-glove80-zmk-dev
    mkdir /config
    # Mirror ZMK repository to make it easier to reference both branches and
    # tags without remote namespacing
    git clone --mirror https://github.com/moergo-sc/zmk /zmk
    GIT_DIR=/zmk git worktree add --detach /src
EOF

# Prepopulate the container's nix store with the build dependencies for the main
# branch and the most recent three tags
RUN <<EOF
    cd /src
    for tag in main $(git tag -l --sort=committerdate | tail -n 3); do
      git checkout -q --detach $tag
      nix-shell --run true -A zmk ./default.nix
    done
EOF

COPY --chmod=755 entrypoint.sh /bin/entrypoint.sh


ENTRYPOINT ["/bin/entrypoint.sh"]

# Run build.sh to use this file
