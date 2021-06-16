{ pkgs, ... }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      git
      gcc
      cloc
      pass
      meld
      conda
      tokei
      vscode
      nodejs
      direnv
      gnumake
      firefox
      mkpasswd
      git-crypt
      hyperfine
      nix-direnv
      inotify-tools
      webdev-browser

      nodePackages.eslint

      unstable.scc
      unstable.zoxide
      unstable.postman

      unstable.gitAndTools.gitui
      unstable.gitAndTools.delta
    ];
  };
}
