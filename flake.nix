{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    kakoune-cr.url = "github:parasrah/kakoune.cr";

    home.url = "github:rycee/home-manager/release-20.09";

    sops-nix = {
      url = github:Mic92/sops-nix;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    dotfiles = {
      url = "/etc/nixos/users/parasrah/dotfiles";
      flake = false;
    };

    dungeondraft = {
      url = "/etc/nixos/pkgs/dungeondraft";
      flake = false;
    };

    wonderdraft = {
      url = "/etc/nixos/pkgs/wonderdraft";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, home, sops-nix, flake-utils, ... }:
    let
      inherit (nixpkgs) lib;
      inherit (lib) nixosSystem;

      specialArgs = { inherit inputs; };

      specialArgsFor = system: specialArgs // {
        inherit system;
      };

      homeManagerConfig = { config, sops-nix, ... }: {
        # Submodules have merge semantics, making it possible to amend
        # the `home-manager.users` submodule for additional functionality.
        options.home-manager.users = lib.mkOption {
          type = lib.types.attrsOf (
            lib.types.submoduleWith {
              modules = [ ];
              # Makes specialArgs available to Home Manager modules as well.
              specialArgs = specialArgs // {
                # Allow accessing the parent NixOS configuration.
                super = config;
              };
            }
          );
        };
      };
    in
    (flake-utils.lib.eachDefaultSystem
      (system:
        {
          packages = { };

          devShell =
            let
              pkgs = import nixpkgs { inherit system; };
            in
            pkgs.mkShell {
              sopsPGPKeyDirs = [
                "./keys/hosts/"
                "./keys/users/"
              ];

              buildInputs = with pkgs; [
                (callPackage sops-nix { }).sops-pgp-hook
              ];
            };
        }
      )) // {
      nixosConfigurations = {
        lexi = nixosSystem rec {
          system = "x86_64-linux";

          specialArgs = specialArgsFor system;

          modules = [
            nixpkgs.nixosModules.notDetected
            home.nixosModules.home-manager
            homeManagerConfig
            ./machines/lexi/configuration.nix
            sops-nix.nixosModules.sops
          ];
        };

        rei = nixosSystem {
          system = "x86_64-linux";

          modules = [
            (throw "need to setup hardware config")
            ./machines/rei/configuration.nix
          ];
        };
      };
    };
}
