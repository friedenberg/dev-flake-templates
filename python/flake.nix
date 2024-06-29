{
  description = "A Nix-flake-based Python development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, nixpkgs-master }:
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
