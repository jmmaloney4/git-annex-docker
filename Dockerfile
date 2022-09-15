FROM nixos/nix:2.11.1@sha256:d8c6b97091d6944dd773c3c239899af047077dbf5411ef229bb50e5b21404b0d

RUN nix-channel --update
RUN nix-env -i git-annex