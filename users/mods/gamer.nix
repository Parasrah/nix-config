{ pkgs, ... }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      spotify
      unstable.steam
      unstable.google-chrome
      unstable.discord
    ];
  };
}
