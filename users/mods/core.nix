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
      fd
      sd
      at
      iw
      vlc
      git
      vim
      zip
      bat
      lsof
      wget
      curl
      unzip
      gnupg
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
      nixpkgs-fmt
      lxappearance
      desktop-file-utils

      xorg.xkbcomp
      xorg.xmodmap

      gnome3.nautilus
      gnome3.seahorse

      unstable.nnn
      unstable.brave
      unstable.kitty
      unstable.httpie
      unstable.bottom
      unstable.flameshot
    ];
  };
}
