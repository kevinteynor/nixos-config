{
  description = "Kevin's NixOS Flake";

  # Inputs
  # https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake.html#flake-format
  inputs = {
    # nixpkgs:
    # nixos-stable = 6 month release cadence (with only bug fixes in betwee)
    # nixos-unstable = latest main
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # home manager:
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # helix editor
    helix = {
      url = "github:helix-editor/helix/23.10";
    };    
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    helix,
    ...
  }@inputs: {
    # Used with `nixos-rebuild --flake .#<hostname>`
    # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation
    nixosConfigurations.kevin-framework = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      
      specialArgs = { inherit inputs helix; };

      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = inputs; 
          home-manager.users.kevin = import ./home.nix;
        }
      ];
    };
  };
}
