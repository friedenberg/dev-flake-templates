{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/fe370c252d033f31e138582a8c5d4d8d2e3d8897";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    utils.url = "github:numtide/flake-utils";

    gomod2nix = {
      url = "github:nix-community/gomod2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, utils, gomod2nix, nixpkgs-stable }:
    {
      overlays = gomod2nix.overlays;
    } //
    (utils.lib.eachDefaultSystem
      (system:
        let

          pkgs = import nixpkgs {
            inherit system;
          };

          packages = {
            inherit (pkgs)
              go_1_23
              gopls
              golangci-lint
              gotools
              parallel
              ;

            # gopls = gopls.packages.${system}.default;
            gomod2nix = gomod2nix.packages.${system}.default;
          };

        in

        {
          inherit packages;

          devShells.default = pkgs.mkShell {
            packages = builtins.attrValues packages;
          };
        }
      )
    );
}
