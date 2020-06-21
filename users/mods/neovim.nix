
{ pkgs, ... }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      neovim
      unstable.nodePackages.neovim
    ];
  };
}
