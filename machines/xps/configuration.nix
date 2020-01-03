{ config, pkgs, ... }:

{
  imports =
    [
      ../default.nix
      # desktop
      ../../cfg/desktop/gnome-i3.nix
      # users
      ../../users/parasrah.nix
      ../../users/nude.nix
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

  programs.gnupg.agent = {
    enable = false;
    enableSSHSupport = false;
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
