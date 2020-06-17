{ pkgs, ... }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      gcc
      pass
      htop
      conda
      neovim
      parted
      gnumake
      firefox
      spotify
      mkpasswd
      nix-index
      git-crypt
      inotify-tools
      desktop-file-utils
      lua51Packages.lua-lsp
      gnome3.gnome-terminal

      unstable.nnn
      unstable.scc
      unstable.vscode
      unstable.lua5_1
      unstable.postman
      unstable.chromium
      unstable.nodejs-12_x
      unstable.google-chrome
      unstable.nodePackages.neovim
    ];
  };
}
