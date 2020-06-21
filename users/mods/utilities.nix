{ pkgs, ... }:

{
  os = {  };

  homemanager = {
    home.packages = with pkgs; [
      gimp
      nomacs
      okular
      poppler_utils
    ];
  };
}
