{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      unstable.elixir
      unstable.beamPackages.hex
    ];
  };
}
