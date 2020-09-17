{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      gcc
      pass
      grex
      conda
      tokei
      direnv
      gnumake
      firefox
      mkpasswd
      git-crypt
      hyperfine
      inotify-tools

      unstable.scc
      unstable.gitui
      unstable.vscode
      unstable.postman
      unstable.chromium
    ];
  };
}
