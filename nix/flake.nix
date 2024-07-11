{
  description = "A Nix-flake-based Nix development environment";

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

        {
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              # cachix
              # haskellPackages.dhall-nix
              # lorri
              # niv
              # nixd
              nixfmt
              nixfmt-rfc-style
              # rnix-lsp
              # statix
              # vulnix
              nil
            ];
          };
        })
    );
}
