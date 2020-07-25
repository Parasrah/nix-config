{ config, pkgs, ... }:

{
  imports =
    [
      ../default.nix
      # desktop
      ../../cfg/desktop/gnome-i3.nix
      # users
      ../../users/parasrah/lexi.nix
    ];

  # Hardware
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.variables = {
    WIRELESS_INTERFACE = "wlp7s0";
  };

  # Networking
  networking = {
    hostName = "lexi";

    networkmanager.enable = true;

    interfaces = {
      # ethernet
      enp3s0 = {
        useDHCP = true;
      };

      # wireless
      wlp7s0 = {
        useDHCP = true;
      };
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };

    wg-quick.interfaces = import ../../cfg/wireguard 5;
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
    };

    dconf = {
      enable = true;
    };
  };

  services = {
    postgresql = {
      enable = true;
    };

    blueman = {
      enable = true;
    };

    mopidy = import ../../cfg/mopidy { inherit pkgs; };
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    liveRestore = true;
  };

  # Sound
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };
}
