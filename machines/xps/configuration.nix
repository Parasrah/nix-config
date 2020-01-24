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
    mkpasswd
    nix-index
    vlc
    pango
    bluez-tools
  ];

  programs.bash = {
    promptInit = (builtins.readFile ../../dotfiles/powerline.sh) + ''
      set -o vi
      if [ -n "$DESKTOP_SESSION" ];then
        eval $(gnome-keyring-daemon --start)
        export SSH_AUTH_SOCK
      fi
    '';
  };

  programs.gnupg.agent = {
    enable = false;
    enableSSHSupport = false;
  };

  services.postgresql = {
    enable = true;
  };

  services.xserver = {
    videoDrivers = [ "intel" ];
    deviceSection = ''
      Option "TearFree" "true"
    '';
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
