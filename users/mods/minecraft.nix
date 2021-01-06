{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      unstable.minecraft
      unstable.minecraft-server
    ];
  };
}
