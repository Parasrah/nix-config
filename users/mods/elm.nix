{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      # currently these are all fetched via nix-shell
    ];
  };
}
