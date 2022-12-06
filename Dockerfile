FROM nixos/nix:2.12.0@sha256:63eafcf4281328c2702b1f0f7ef0f439f260964f1b1f945271c18f6635a3193c

RUN nix-channel --update
RUN nix-env -i git-annex iana-etc
