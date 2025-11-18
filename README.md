NixOS System Configuration

### system upgrade steps:

1. update `nixpkgs.url` value in flake.nix `inputs`
2. run `nix flake update`
3. run `nixos-rebuild switch --upgrade --flake .`

