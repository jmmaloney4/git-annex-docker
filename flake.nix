{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, flake-utils}:
  let
    pkgs = import nixpkgs { system = "x86_64-linux"; };
  in
  flake-utils.lib.eachDefaultSystem (system: 
    {
      defaultPackage = pkgs.dockerTools.buildLayeredImage {
        name = "git-annex";
        contents = [
          pkgs.nix
          pkgs.bashInteractive
          pkgs.coreutils-full
          pkgs.cacert.out
          pkgs.iana-etc

          pkgs.git
          pkgs.git-annex
        ];
      };
    }
  );
}
