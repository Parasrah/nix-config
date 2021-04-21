{ pkgs, ... }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      mono
      piper
      steam
      spotify

      unstable.discord
    ];
  };
}
