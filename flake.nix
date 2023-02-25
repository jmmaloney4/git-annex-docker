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
        contents = with pkgs; [
          nix
          bashInteractive
          coreutils-full
          cacert.out
          iana-etc
          openssh
          git
          git-annex
        ];
        config.Env = [
          "USER=nobody"
        ];
      };
    }
  );
}
