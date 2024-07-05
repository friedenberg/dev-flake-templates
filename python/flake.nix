{
  description = "A Nix-flake-based Python development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
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
              python311
              python311Packages.pip
              python311Packages.python-lsp-server
              virtualenv
            ];
          };
        })
    );
}
