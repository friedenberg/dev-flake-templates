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
          packages.${system} = with pkgs; {
            inherit go;
            inherit golangci-lint;
            inherit gopls;
            inherit gotools;
            inherit parallel;

            gomod2nix = gomod2nix.packages.${system}.default;
          };

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              go
              golangci-lint
              gopls
              gotools
              parallel
              gomod2nix.packages.${system}.default
            ];
          };
        })
    );
}
