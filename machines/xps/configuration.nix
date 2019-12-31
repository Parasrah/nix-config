{ config, pkgs, ... }:

let
  default = import ../default.nix { inherit pkgs; };

in
default // {
  imports =
    [
      ../../cfg/desktop/gnome.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = import ../../cfg/networking/default.nix {
    hostname = "xps";
    interface = "wlp2s0";
  };

  # packages available to all users
  environment.systemPackages = with pkgs; default.environment.systemPackages ++ [
    mkpasswd
    gnupg
    nix-index
    unstable.neovim
  ];

  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  nixpkgs.config.packageOverrides = import ../cfg/packageOverrides/default.nix { inherit config; };
}
