FROM nixos/nix:2.11.0@sha256:25ce92cb4488a7f911929d7ba74828cfac7eae45e359f45709d74cd6c5915dc5

RUN nix-channel --update
RUN nix-env -i git-annex