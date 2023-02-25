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
  let
    nonRootShadowSetup = { user, uid, gid ? uid }: with pkgs; [
        (
        writeTextDir "etc/shadow" ''
          root:!x:::::::
          ${user}:!:::::::
        ''
        )
        (
        writeTextDir "etc/passwd" ''
          root:x:0:0::/root:${runtimeShell}
          ${user}:x:${toString uid}:${toString gid}::/home/${user}:
        ''
        )
        (
        writeTextDir "etc/group" ''
          root:x:0:
          ${user}:x:${toString gid}:
        ''
        )
        (
        writeTextDir "etc/gshadow" ''
          root:x::
          ${user}:x::
        ''
        )
      ];
    in
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
        ] ++ nonRootShadowSetup { uid = 999; user = "git"; };
      };
    }
  );
}
