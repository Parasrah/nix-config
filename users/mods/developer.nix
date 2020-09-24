{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      git
      gcc
      cloc
      pass
      meld
      conda
      delta
      tokei
      direnv
      gnumake
      firefox
      mkpasswd
      git-crypt
      hyperfine
      nix-direnv
      inotify-tools

      unstable.scc
      unstable.gitui
      unstable.vscode
      unstable.postman
      unstable.chromium
    ];
  };
}
