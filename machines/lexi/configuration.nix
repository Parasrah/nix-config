{ config, pkgs, ... }:

let
  fun =
    import ../../fun { inherit pkgs; };

in
{
  imports =
    [
      ../default.nix
      # desktop
      ../../cfg/desktop/i3.nix
      # users
      ../../users/parasrah.nix
      # TODO: remove
      "${builtins.fetchGit {
        url = "https://github.com/msteen/nixos-vsliveshare.git";
        ref = "refs/heads/master";
      }}"
    ];

  services.vsliveshare = {
    enable = true;
    extensionsDir = "$HOME/.vscode/extensions";
    nixpkgsPath = builtins.fetchGit {
      url = "https://github.com/NixOS/nixpkgs.git";
      ref = "refs/heads/nixos-20.03";
      rev = "61cc1f0dc07c2f786e0acfd07444548486f4153b";
    };
  };

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

  # packages available to all users
  environment.systemPackages = with pkgs; [
    vlc
    pango
    steam
    parted
    mkpasswd
    nix-index
    bluez-tools
    lxappearance
    google-chrome
    desktop-file-utils
    unstable.vscode
  ];

  environment.variables = {
    WIRELESS_INTERFACE = "wlp4s0";
  };

  programs = {
    bash = {
      promptInit = (builtins.readFile ../../users/parasrah/dotfiles/powerline.sh) + ''
        set -o vi
        if [ -n "$DESKTOP_SESSION" ];then
          eval $(gnome-keyring-daemon --start)
          export SSH_AUTH_SOCK
        fi
      '';
    };

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
