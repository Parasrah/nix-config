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
    xbacklight
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

    blueman = {
      enable = true;
    };

    xserver = {
      videoDrivers = [ "intel" ];
      deviceSection = ''
        Option "TearFree" "true"
      '';
    };

    mopidy = {
      enable = true;
      extensionPackages = with pkgs; [
        mopidy-spotify
        mopidy-local-sqlite
        mopidy-iris
      ];
      configuration = ''
        [spotify]
        ${builtins.readFile ../../secrets/spotify.conf}

        [mpd]
        enabled = true
        hostname = 127.0.0.1

        [iris]
        country = ca
        locale = en_CA
        spotify_authorization_url =
        lastfm_authorization_url =
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
  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };
}
