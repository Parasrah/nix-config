{ pkgs, ... }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      spotify
      unstable.steam
      unstable.discord
    ];
  };
}
