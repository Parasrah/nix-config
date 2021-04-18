{ pkgs, ... }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      mono
      piper
      spotify
      google-chrome

      unstable.steam
      unstable.discord
    ];
  };
}
