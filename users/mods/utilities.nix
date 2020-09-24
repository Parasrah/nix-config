{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      gimp
      nomacs
      okular
      asciidoctor
      poppler_utils
      unstable.etcher
    ];
  };
}
