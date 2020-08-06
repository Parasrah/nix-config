# Core User Config
#
# All normal users should extend from "core"

{ username, pkgs, ... }:

let
  homeDirectory =
    "/home/${username}";

in
{
  os = {
    isNormalUser = true;
    home = homeDirectory;
  };

  homemanager = {
    home.homeDirectory = homeDirectory;

    home.packages = with pkgs; [
      at
      iw
      vlc
      git
      vim
      zip
      lsof
      wget
      curl
      unzip
      gnupg
      broot
      p7zip
      parted
      mtools
      openssl
      ripgrep
      killall
      hddtemp
      usbutils
      inetutils
      playerctl
      libnotify
      nix-index
      wireguard
      unetbootin
      lm_sensors
      pavucontrol
      bluez-tools
      lxappearance
      desktop-file-utils

      xorg.xkbcomp
      xorg.xmodmap

      gnome3.nautilus
      gnome3.seahorse

      unstable.nnn
      unstable.ytop
      unstable.brave
      unstable.kitty
      unstable.httpie
      unstable.flameshot
    ];
  };
}
