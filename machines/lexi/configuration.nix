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

  # packages available to all users
  environment.systemPackages = with pkgs; [
    polkit_gnome

    xorg.xbacklight

    linuxPackages.batman_adv
  ];

  environment.variables = {
    WIRELESS_INTERFACE = "wlp4s0";
  };

  # Networking
  networking = {
    hostName = "lexi";

    networkmanager.enable = true;

    interfaces = {
      enp3s0 = {
        useDHCP = true;
      };

      wlp4s0 = {
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
