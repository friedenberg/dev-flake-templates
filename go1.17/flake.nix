{
  description = "Go 1.17 development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells = {
          default = pkgs.mkShellNoCC {
            buildInputs = with pkgs; [
              # go 1.17.1
              go

              # goimports, godoc, etc.
              gotools

              # https://github.com/golangci/golangci-lint
              golangci-lint

              # The Go language server (for IDEs and such)
              gopls

              # https://pkg.go.dev/github.com/ramya-rao-a/go-outline
              go-outline

              # https://github.com/uudashr/gopkgs
              gopkgs
            ];
          };
        };
      }
    );
}