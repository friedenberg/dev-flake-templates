{
  description = "A Nix-flake-based Nix development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/release-24.11";
    utils.url = "github:numtide/flake-utils";
    fh.url = "https://flakehub.com/f/DeterminateSystems/fh/0.1.21.tar.gz";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , utils
    , fh
    }:
    (utils.lib.eachDefaultSystem
      (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

      in

      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            fh.packages.${system}.default
            nil
            nixfmt-rfc-style
          ];
        };
      })
    );
}
