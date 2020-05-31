{ pkgs, config, ... }:

{
  imports =
    [
      ../hardware-configuration.nix
      <home-manager/nixos>
      ../users/root.nix
    ];

  environment.variables = rec {
    NIX = "/etc/nixos";
    DOTFILES =  "${NIX}/users/parasrah/dotfiles";
    NVIMCONFIG = "${DOTFILES}/nvim";
    POWERLINE_GIT = "1";
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "kitty";
    PROJECTS = "$HOME/Projects";
    BLOG = "${PROJECTS}/blog";
  };

  environment.etc."inputrc" = {
    text = ''
      set meta-flag on
      set input-meta on
      set convert-meta off
      set output-meta on
      set colored-stats on
      set completion-ignore-case On
      set show-all-if-ambiguous On
      set show-all-if-unmodified On
      set visible-stats On
    '';
  };

  fonts.fonts = with pkgs; [
    unifont
    noto-fonts
    font-awesome
    unstable.cascadia-code
  ];

  systemd.services.configuration-perms = {
    script = ''
      chown -R root:nixos-config /etc/nixos
      chmod -R g+rw /etc/nixos
    '';
    wantedBy = [ "multi-user.target" ];
    description = "allow nixos-config user access to change system config";
  };

  time = import ../cfg/time;

  nixpkgs.overlays = [
    (import ../pkgs)
  ];

  nixpkgs.config = import ../cfg/pkgsConfig { inherit config; };

  # Security
  security.sudo = {
    wheelNeedsPassword = true;
  };

  # Users
  users.mutableUsers = true;

  users.groups.nixos-config = {};

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
}
