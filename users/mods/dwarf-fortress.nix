{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      unstable.dwarf-fortress
    ];
  };
}
