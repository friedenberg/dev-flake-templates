{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    utils.url = "github:numtide/flake-utils";

    gomod2nix = {
      url = "github:nix-community/gomod2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, utils, gomod2nix }:
    {
      overlays = gomod2nix.overlays;
    } //
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
              gomod2nix.packages.${system}.default
              parallel
            ];
          };
        })
    );
}
