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
      tokei
      godot
      direnv
      gnumake
      firefox
      mkpasswd
      git-crypt
      hyperfine
      nix-direnv
      inotify-tools

      unstable.scc
      unstable.zoxide
      unstable.vscode
      unstable.postman
      unstable.chromium

      unstable.gitAndTools.gitui
      unstable.gitAndTools.delta
    ];
  };
}
