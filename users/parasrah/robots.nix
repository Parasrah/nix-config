let
  util = import ../util;

in
util.createHomeUser
  ({
    username = "parasrah";

    stateVersion = "20.09";

    mods = [
      (import ../mods/core.nix)
      (import ../mods/kakoune.nix)
      (import ../mods/developer.nix)
      (import ../mods/gamer.nix)
      (import ../mods/web.nix)
      (import ../mods/rust.nix)
      (import ../mods/lua.nix)
      (import ../mods/nushell.nix)
      (import ./default.nix)
      (
        { pkgs, username, ... }: {
          homemanager = {
            home.packages = with pkgs; [ ];
          };
        }
      )
    ];
  })
