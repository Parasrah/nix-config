{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      python37
      python37Packages.pip
      python37Packages.setuptools
    ];
  };
}
