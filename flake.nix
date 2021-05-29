{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    kakoune-cr.url = "github:parasrah/kakoune.cr";

    home-manager = {
      url = "github:nix-community/home-manager/release-20.09";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = github:Mic92/sops-nix;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    dotfiles = {
      url = "/etc/nixos/users/parasrah/dotfiles";
      flake = false;
    };

    secrets = {
      url = "/etc/nixos/secrets";
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

  outputs = inputs@{ self, nixpkgs, home-manager, sops-nix, flake-utils, ... }:
    let
      inherit (nixpkgs) lib;
      inherit (lib) nixosSystem;

      specialArgs = { inherit inputs; };

      pkgsFor = system:
        import nixpkgs (import ./cfg/pkgs { inherit inputs system; });

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
        let
          pkgs = pkgsFor system;
        in
        {
          packages = {
            robots = self.homeConfigurations."${system}".robots.activationPackage;
          };

          homeConfigurations =
            let
              extraSpecialArgs = specialArgsFor system;

              payload = { inherit system extraSpecialArgs pkgs; };
            in
            {
              robots = home-manager.lib.homeManagerConfiguration (import ./users/parasrah/robots.nix payload);
            };

          devShell =
            pkgs.mkShell {
              EDITOR = "kak";

              sopsPGPKeyDirs = [
                "./keys/hosts/"
                "./keys/users/"
              ];

              buildInputs = with pkgs; [
                unstable.go-task

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
            home-manager.nixosModules.home-manager
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
