{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      nodejs
      nodePackages.eslint
    ];
  };
}
