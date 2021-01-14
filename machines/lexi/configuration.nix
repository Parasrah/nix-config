{ config, pkgs, ... }:

{
  imports =
    [
      ../default.nix
      # desktop
      ../../cfg/desktop/gnome-i3.nix
      # users
      ../../users/parasrah/lexi.nix
      # services
      ../../services/mopidy
    ];

  # Hardware

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment = {
    systemPackages = with pkgs; [
      imagemagick
      polkit_gnome
      vulkan-tools

      linuxPackages.batman_adv
    ];

    variables = {
      WIRELESS_INTERFACE = "wlp7s0";
      # For radv
      # VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
      # for amdvlk
      # VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/amd_icd64.json";
    };
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
      allowedTCPPorts = [ 22 43000 ];
      allowedUDPPorts = [ ];
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

    java = {
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
      videoDrivers = [ "amdgpu" ];
    };

    postfix = {
      enable = true;
    };

    openssh = {
      passwordAuthentication = false;
      enable = true;
      permitRootLogin = "prohibit-password";
    };

    xrdp = {
      enable = false;
      defaultWindowManager = "${pkgs.unstable.i3}/bin/i3";
    };
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    liveRestore = true;
  };

  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
    };

    guest = {
      enable = false;
    };
  };

  # Vulkan
  hardware.opengl = {
    driSupport = true;
    extraPackages = with pkgs; [ amdvlk ];

    # 32 bit support
    driSupport32Bit = true;
  };

  # Sound
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
}
