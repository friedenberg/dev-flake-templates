{
  description = "A Nix-flake-based Shell development environment";

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
              shellcheck
              nodePackages.bash-language-server
              shfmt
            ];
          };
        })
    );
}
