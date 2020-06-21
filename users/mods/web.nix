{ pkgs, ... }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      unstable.nodejs-12_x
      unstable.nodePackages.eslint
    ];
  };
}
