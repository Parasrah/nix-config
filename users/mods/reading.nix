{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      # unstable.wine
      # unstable.winetricks
      unstable.calibre
    ];
  };
}
