{ config, pkgs, ... }:

{
  imports =
    [
      ../default.nix
      # desktop
      ../../cfg/desktop/i3.nix
      # users
      ../../users/parasrah/lexi.nix
    ];

  # Hardware
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/b4ec94d1-b330-4208-bd26-175273cd4e93";
      fsType = "ext4";
    };
    "/files" = {
      device = "/dev/disk/by-uuid/848ba4fe-0a5a-4278-b7e7-78a2ddb7a831";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/C7B9-5579";
      fsType = "vfat";
    };
  };

  boot.initrd.luks.devices = {
    cryptroot.device = "/dev/disk/by-uuid/4c135ce3-ad9d-430e-b20e-44e0dda7988d";
    cryptfiles.device = "/dev/disk/by-uuid/c4728935-37a2-4872-b394-c1583677fb98";
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs = {
    gnupg.agent = {
      enable = false;
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
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    liveRestore = true;
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

    # wg-quick.interfaces = import ../../cfg/wireguard 5;
  };

  # Sound
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };
}
