{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      mono
      spotify
      unstable.steam
      unstable.discord
      google-chrome
    ];
  };
}
