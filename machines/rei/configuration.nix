{ config, pkgs, ... }:

{
  imports =
    [
      ../default.nix
      # desktop
      ../../cfg/desktop/gnome-i3.nix
      # users
      ../../users/parasrah/rei.nix
      # services
      ../../services/mopidy
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # packages available to all users
  environment.systemPackages = with pkgs; [
    imagemagick
    polkit_gnome

    linuxPackages.batman_adv

    xorg.xbacklight
  ];

  networking = {
    hostName = "rei";

    networkmanager.enable = true;

    interfaces.wlp2s0.useDHCP = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };

    wg-quick.interfaces = import ../../cfg/wireguard 2;
  };

  environment.variables = {
    WIRELESS_INTERFACE = "wlp2s0";
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

    xserver = {
      videoDrivers = [ "intel" ];
      deviceSection = ''
        Option "TearFree" "true"
      '';
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
      liveRestore = true;
    };
  };


  users.extraGroups.vboxusers.members = [ "parasrah" ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };
}
