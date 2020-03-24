let
  util = import ../util;

in
util.create
  {
    username = "parasrah";

    mods = [
      (import ../mods/core.nix)
      (import ../mods/developer.nix)
      (import ../mods/elixir.nix)
      (import ../mods/elm.nix)
      (import ../mods/gamer.nix)
      (import ../mods/golang.nix)
      (import ../mods/python.nix)
      (import ../mods/rust.nix)
      (import ../mods/web.nix)
      (import ./default.nix)
      ({ pkgs, username }: {
        os = { isNormalUser = true; home = "/home/" + username; };

        homemanager = {
          home.homeDirectory = "/home/" + username;
          home.packages = with pkgs; [
            kitty
            vim
          ];
        };
      })
    ];
  }
