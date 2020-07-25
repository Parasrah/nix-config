{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      go
    ];
  };
}
