let
  util = import ../util;

in
util.create
  {
    username = "parasrah";

    mods = [
      (import ../mods/core.nix)
      (import ../mods/kakoune.nix)
      (import ../mods/neovim.nix)
      (import ../mods/developer.nix)
      (import ../mods/gamer.nix)
      (import ../mods/web.nix)
      (import ../mods/utilities.nix)
      (import ../mods/rust.nix)
      (import ../mods/lua.nix)
      (import ./default.nix)
      (
        { pkgs, username, ... }: {
          os = {};

          homemanager = {
            home.packages = with pkgs; [
              tigervnc
              batctl
            ];
          };
        }
      )
    ];
  }
