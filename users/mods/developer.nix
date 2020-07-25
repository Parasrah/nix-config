{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      gcc
      pass
      conda
      gnumake
      firefox
      mkpasswd
      git-crypt
      inotify-tools

      unstable.scc
      unstable.vscode
      unstable.postman
      unstable.chromium
    ];
  };
}
