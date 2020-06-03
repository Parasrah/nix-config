# Core User Config
#
# All normal users should extend from "core"

{ username, pkgs }:

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
      vlc
      git
      vim
      zip
      lsof
      wget
      curl
      unzip
      gnupg
      kitty
      p7zip
      mtools
      openssl
      ripgrep
      killall
      hddtemp
      usbutils
      nettools
      libnotify
      wireguard
      unetbootin
      lm_sensors
      pavucontrol
      bluez-tools
      lxappearance
      unstable.brave
      gnome3.nautilus
      gnome3.seahorse
      unstable.flameshot
    ];
  };
}
