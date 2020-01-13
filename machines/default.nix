{ pkgs, config, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "9bdfdfe14e03786f767eb3224e53713d34c70ced";
    ref = "release-19.09";
  };

in
{
  imports =
    [
      ../hardware-configuration.nix
      "${home-manager}/nixos"
      ../users/root.nix
    ];

  environment.variables = {
    NIX = "/etc/nixos";
    NVIMCONFIG = "$NIX/dotfiles/nvim";
    POWERLINE_GIT = "1";
    EDITOR = "neovim";
  };

  environment.sessionVariables = {
    TERMINAL = "kitty";
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

  # packages always available on all machines
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    vim
    unzip
    ripgrep
    nettools
    killall
  ];

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
  system.stateVersion = "19.09"; # Did you read the comment?
}
