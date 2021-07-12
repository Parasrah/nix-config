let
  util = import ../util;

in
util.createNixOsUser
  {
    username = "parasrah";

    mods = [
      (import ../mods/core.nix)
      (import ../mods/kitty.nix)
      (import ../mods/kakoune.nix)
      (import ../mods/developer.nix)
      (import ../mods/gamer.nix)
      (import ../mods/utilities.nix)
      (import ../mods/rust.nix)
      (import ../mods/dwarf-fortress.nix)
      (import ../mods/pentesting.nix)
      (import ../mods/dnd.nix)
      (import ../mods/gamedev.nix)
      (import ../mods/reading.nix)
      (import ./default.nix)
      (
        { pkgs, username, ... }: {
          os = {};

          homemanager = {
            home.packages = with pkgs; [
              batctl
              deluge
              cryptee
              libva-utils
            ];
          };
        }
      )
    ];
  }
