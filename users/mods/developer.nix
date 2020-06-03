{ pkgs, ... }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      nnn
      gcc
      pass
      htop
      conda
      neovim
      parted
      gnumake
      spotify
      firefox
      mkpasswd
      nix-index
      git-crypt
      unstable.scc
      inotify-tools
      unstable.vscode
      unstable.lua5_1
      unstable.postman
      unstable.chromium
      desktop-file-utils
      unstable.nodejs-12_x
      lua51Packages.lua-lsp
      gnome3.gnome-terminal
      unstable.google-chrome
      unstable.nodePackages.neovim
    ];
  };
}
