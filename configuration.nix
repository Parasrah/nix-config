# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "xps"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp2s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim
    pkgs.mkpasswd
    pkgs.firefox
    pkgs.git
    pkgs.vlc
    pkgs.chromium
    pkgs.ripgrep
    pkgs.gnupg
    unstable.nodejs
  ];

  nixpkgs.overlays = [
    (self: super:
      (import ./pkgs/default.nix { pkgs = super; })
    )
  ];

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import ./cfg/unstable.nix { config = config; };
    };
  };

  environment.variables = {
    NIXOS = "/etc/nixos";
    NVIMCONFIG = "$NIXOS/pkgs/neovim/config";
    KITTY_CONFIG_DIRECTORY = "$NIXOS/pkgs/kitty";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  systemd.services.configure-permissions = {
    script = ''
      chown -R root:nixos-config /etc/nixos
      chmod -R g+rw /etc/nixos
    '';
    wantedBy = [ "multi-user.target" ];
    description = "allow nixos-config user access to change system config";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support.
  services.xserver.libinput = {
    enable = true;
    naturalScrolling = true;
  };

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Security
  security.sudo = {
    wheelNeedsPassword = true;
  };

  # Users
  users.mutableUsers = true;

  users.groups = {
    nixos-config = { };
  };

  users.users = {
    root = {
      home = "/root";
      isNormalUser = false;
      group = "root";
      extraGroups = [ "nixos-config" ];
      packages = with pkgs; [
        unstable.neovim
      ];
    };
    parasrah = {
      isNormalUser = true;
      home = "/home/parasrah";
      description = "Brad";
      extraGroups = [ "wheel" "networkmanager" "nixos-config" ];
      initialHashedPassword = "$6$HkJllhqe$C8oSl9ox6WyNAdN6yjzTf3R1HzMbA6dDY8ziafg.XSG3LUrt5yG927KpDuA1nqGiiwGyGJ5jn5j.OwtNplSd3/";
      packages = with pkgs; [
       	unstable.neovim
        my.kitty
      ];
    };
    qnbst = {
      isNormalUser = true;
      home = "/home/qnbst";
      description = "Bea";
      extraGroups = [ "networkmanager" ];
      initialHashedPassword = "$6$rpJzIzk6jGJ7SQ/3$IYQTa/JugakPHG.DyDz/hBb1w3euy0iNTII2rVZaJrmIUfb1H79AC6YYXRNAcScmDQx76am83T6ZyQNaRCZex0";
    };
  };

  i18n.consoleUseXkbConfig = true;
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "ctrl:nocaps";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}

