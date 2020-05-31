{ config, pkgs, ... }:

{
  imports =
    [
      ../default.nix
      # desktop
      ../../cfg/desktop/gnome-i3.nix
      # users
      ../../users/parasrah/rei.nix
      # live share
      "${builtins.fetchGit {
        url = "https://github.com/msteen/nixos-vsliveshare.git";
        ref = "master";
        rev = "c563a21ba8f5878f879b3061e8b98021b3ddfb2f";
      }}"
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # packages available to all users
  environment.systemPackages = with pkgs; [
    xorg.xbacklight
  ];

  networking = {
    hostName = "rei";

    interfaces.wlp2s0.useDHCP = true;

    networkmanager.enable = true;

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

    vsliveshare = {
      enable = true;
      extensionsDir = "$HOME/.vscode/extensions";
      nixpkgsPath = builtins.fetchGit {
        url = "https://github.com/NixOS/nixpkgs.git";
        ref = "refs/heads/nixos-20.03";
        rev = "61cc1f0dc07c2f786e0acfd07444548486f4153b";
      };
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

  virtualisation = {
    docker = {
      enable = false;
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
