targets := find . -maxdepth 1 -type d ! -name '.*' -print0

all: flake-update-all

flake-update target:
  #! /usr/bin/env -S bash -e
  pushd "{{invocation_directory()}}/{{target}}" >/dev/null
  nix flake update

# TODO doesn't work yet
flake-build target:
  #! /usr/bin/env -S bash -e
  pushd "{{invocation_directory()}}/{{target}}" >/dev/null
  nix build

flake-update-all:
  #! /usr/bin/env -S bash
  find . -maxdepth 1 -type d ! -name '.*' -print0 \
    | xargs -0 -L1 just flake-update
