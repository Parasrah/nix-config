{ pkgs, ... }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      mono
      steam
      spotify
      google-chrome

      unstable.discord
    ];
  };
}
