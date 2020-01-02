{ config, pkgs, ... }:

{
  imports =
    [
      ../default.nix
      ../../cfg/desktop/gnome-i3.nix
      ../../users/parasrah.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = import ../../cfg/networking {
    hostname = "xps";
    interface = "wlp2s0";
  };

  # packages available to all users
  environment.systemPackages = with pkgs; [
    mkpasswd
    nix-index
  ];

  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
