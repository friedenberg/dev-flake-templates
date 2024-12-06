
flake-update target:
  #! /usr/bin/env -S bash -e
  pushd "{{invocation_directory()}}/{{target}}" >/dev/null
  nix flake update

flake-build target:
  #! /usr/bin/env -S bash -e
  pushd "{{invocation_directory()}}/{{target}}" >/dev/null
  nix build

# targets := `find . -type d -maxdepth 1`

flake-update-all: (flake-update "go")
flake-build-all: (flake-build "go")
