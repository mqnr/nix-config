{
  description = "Multi-host Nix config";

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tangent = {
      url = "github:mqnr/tangent";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      nix-homebrew,
      ...
    }:
    let
      lib = nixpkgs.lib.extend (import ./lib/util.nix) // home-manager.lib;

      mkOverlays = [ inputs.emacs-overlay.overlays.default ];

      specialArgs = { inherit inputs lib; };

      sharedModules = host: [
        ./lib/options.nix
        ./modules/common
        (./hosts + "/${host}")

        (
          { ... }:
          {
            nixpkgs = {
              overlays = mkOverlays;
              config.allowUnfree = true;
            };
            nix.settings = {
              substituters = [
                "https://cache.nixos.org"
                "https://nix-community.cachix.org"
              ];
              trusted-public-keys = [
                "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
              ];
              experimental-features = [
                "nix-command"
                "flakes"
                "pipe-operators"
              ];
              trusted-users = [
                "root"
                "@build"
                "@wheel"
                "@admin"
              ];
            };
          }
        )
      ];

      mkNixos =
        {
          host,
          system ? "x86_64-linux",
        }:
        nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = sharedModules host ++ [
            ./modules/linux
            inputs.niri.nixosModules.niri
            inputs.home-manager.nixosModules.home-manager

            {
              home-manager.sharedModules = [
                inputs.dankMaterialShell.homeModules.dankMaterialShell.default
                inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
              ];
            }
          ];
        };

      mkDarwin =
        {
          host,
          system ? "aarch64-darwin",
        }:
        nix-darwin.lib.darwinSystem {
          inherit system specialArgs;
          modules = sharedModules host ++ [
            ./modules/darwin
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew

            {
              services.nix-daemon.enable = true;
              programs.zsh.enable = true;
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        acheron = mkNixos { host = "acheron"; };
        tigris = mkNixos { host = "tigris"; };
      };

      darwinConfigurations = {
        nile = mkDarwin { host = "nile"; };
      };
    };
}
