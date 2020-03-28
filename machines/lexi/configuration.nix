{ config, pkgs, ... }:

{
  imports =
    [
      ../default.nix
      # desktop
      ../../cfg/desktop/gnome-i3.nix
      # users
      ../../users/parasrah/lexi.nix
      ../../users/qnbst/lexi.nix
      # live share
      "${builtins.fetchGit {
        url = "https://github.com/msteen/nixos-vsliveshare.git";
        ref = "master";
        rev = "c563a21ba8f5878f879b3061e8b98021b3ddfb2f";
      }}"
    ];

  # Hardware
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

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

    vsliveshare = {
      enable = true;
      extensionsDir = "$HOME/.vscode/extensions";
      nixpkgsPath = builtins.fetchGit {
        url = "https://github.com/NixOS/nixpkgs.git";
        ref = "refs/heads/nixos-20.03";
        rev = "61cc1f0dc07c2f786e0acfd07444548486f4153b";
      };
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

    wg-quick.interfaces = import ../../cfg/wireguard 5;
  };

  # Sound
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };
}
