{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      wonderdraft
      dungeondraft
    ];
  };
}
