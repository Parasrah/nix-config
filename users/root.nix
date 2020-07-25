let
  create = import ./util/create.nix;

in
create
  {
    username = "root";

    mods = [
      (
        { pkgs, ... }: {
          os = {
            home = "/root";
            isNormalUser = false;
            group = "root";
            extraGroups = [ "nixos-config" ];
          };

          homemanager = {};
        }
      )
    ];
  }
