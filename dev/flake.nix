{
  description = "A nix-flake based dev-sandbox environment for multiple languages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, fenix, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        # todo: any overlays
      ];
    };
    pkgs-stable = import nixpkgs-stable { inherit system; };
  in {
    devShells."${system}" = {

      cpp = pkgs.mkShell {
        packages = with pkgs; [
          clang_16
          cmake
        ];
        shellHook = ''
          clang --version
          cmake --version
        '';
      };

      zig = pkgs.mkShell {
        packages = with pkgs; [
          zig
        ];
        shellHook = ''
          echo zig `zig version`
        '';
      };

      rust = pkgs.mkShell {
        packages = [
          # nightly rust via fenix: https://github.com/nix-community/fenix
          fenix.packages.${system}.default.toolchain
        ];
        shellHook = ''
          rustc --version
          cargo --version
        '';
      };

      node = pkgs.mkShell {
        packages = with pkgs; [
          nodejs-18_x
          nodePackages.pnpm
        ];
        shellHook = ''
          echo "node `${pkgs.nodejs}/bin/node --version`"
        '';
      };

      default = pkgs.mkShell {
        shellHook = ''
          echo "use one of the language specific environments:"
          echo "  nix develop .#cpp"
          echo "  nix develop .#node"
          echo "  nix develop .#rust"
          echo "  nix develop .#zig"
          exit
        '';
      };
    };
  };
}
