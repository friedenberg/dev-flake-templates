{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    utils.url = "github:numtide/flake-utils";

    gomod2nix = {
      url = "github:nix-community/gomod2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, utils, nixpkgs-master, gomod2nix }:
    (utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };

        in

        rec {
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              go
              golangci-lint
              gopls
              gotools
            ];
          };
        })
    );
}
