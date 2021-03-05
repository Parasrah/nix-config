{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      godot
      aseprite
    ];
  };
}
