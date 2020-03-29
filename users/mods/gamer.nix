{ username, pkgs }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      unstable.steam
      unstable.lutris
      unstable.google-chrome
      unstable.discord
      spotify
    ];
  };
}
