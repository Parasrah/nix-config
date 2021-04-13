{ pkgs, ... }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      mono
      steam
      piper
      spotify
      google-chrome

      unstable.discord
    ];
  };
}
