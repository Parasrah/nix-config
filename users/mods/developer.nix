{ pkgs, ... }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      nnn
      gcc
      htop
      parted
      gnumake
      spotify
      firefox
      mkpasswd
      nix-index
      unstable.google-chrome
      unstable.scc
      unstable.neovim
      unstable.vscode
      unstable.lua5_1
      unstable.postman
      unstable.chromium
      desktop-file-utils
      unstable.nodejs-12_x
      lua51Packages.lua-lsp
      gnome3.gnome-terminal
      unstable.nodePackages.neovim
    ];
  };
}
