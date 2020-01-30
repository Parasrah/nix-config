{ config, pkgs, ... }:

{
  imports =
    [
      ../default.nix
      # desktop
      ../../cfg/desktop/i3.nix
      # users
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
    vlc
    pango
    mkpasswd
    nix-index
    bluez-tools
    lxappearance
  ];

  environment.variables = {
    WIRELESS_INTERFACE = "wlp2s0";
  };

  programs = {
    bash = {
      promptInit = (builtins.readFile ../../dotfiles/powerline.sh) + ''
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

    xserver = {
      videoDrivers = [ "intel" ];
      deviceSection = ''
        Option "TearFree" "true"
      '';
    };
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    liveRestore = true;
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
