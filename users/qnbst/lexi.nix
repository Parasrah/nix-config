let
  util = import ../util;

in
util.create
  {
    username = "qnbst";

    mods = [
      (import ../mods/core.nix)
      (import ../mods/gamer.nix)
      (import ../mods/python.nix)
      (import ../mods/web.nix)
      (import ./default.nix)
    ];
  }
