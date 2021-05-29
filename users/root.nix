let
  createNixOsUser = import ./util/create-nixos-user.nix;

  homeDirectory = "/root";

in
createNixOsUser
  {
    inherit homeDirectory;

    username = "root";

    mods = [
      (
        { pkgs, ... }: {
          os = {
            home = homeDirectory;
            isNormalUser = false;
            group = "root";
            extraGroups = [ "nixos-config" ];
          };

          homemanager = {};
        }
      )
    ];
  }
