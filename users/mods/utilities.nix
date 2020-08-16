{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      gimp
      bind
      nomacs
      okular
      mailutils
      poppler_utils
    ];
  };
}
