{ config, pkgs, ... }:

let networkInfo = {
  hostname = "xps";
  interface = "wlp2s0";
};

in
{
  imports =
    [
      ../../hardware-configuration.nix
      ../../cfg/desktop/gnome.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = import ../../cfg/networking.nix { inherit networkInfo; };

  time = import ../../cfg/time.nix;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    curl
    vim
    mkpasswd
    git
    ripgrep
    gnupg
    nix-index
    unstable.neovim
  ];

  nixpkgs.overlays = [
    (self: super:
      (import ../../pkgs/default.nix { pkgs = super; })
    )
  ];

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = import ../../cfg/packageOverrides/default.nix;
  };

  environment.variables = {
    NIX = "/etc/nixos";
    NVIMCONFIG = "$NIX/pkgs/neovim/config";
    KITTY_CONFIG_DIRECTORY = "$NIX/pkgs/kitty";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  systemd.services.configure-permissions = {
    script = ''
      chown -R root:nixos-config /etc/nixos
      chmod -R g+rw /etc/nixos
    '';
    wantedBy = [ "multi-user.target" ];
    description = "allow nixos-config user access to change system config";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Security
  security.sudo = {
    wheelNeedsPassword = true;
  };

  # Users
  users.mutableUsers = true;

  users.groups = {
    nixos-config = { };
  };

  users.users = {
    root = import ./users/root.nix { pkgs = pkgs; };
    parasrah = import ./users/parasrah.nix { pkgs = pkgs; };
    nude = import ./users/nude.nix { pkgs = pkgs; };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}

