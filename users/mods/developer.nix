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
      direnv
      gnumake
      firefox
      mkpasswd
      git-crypt
      hyperfine
      nix-direnv
      inotify-tools
      webdev-browser

      unstable.scc
      unstable.zoxide
      unstable.postman
      (chromium.override { enableVaapi = true; })

      unstable.gitAndTools.gitui
      unstable.gitAndTools.delta
    ];
  };
}
