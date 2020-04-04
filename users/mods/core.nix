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
      vlc
      git
      vim
      wget
      curl
      unzip
      gnupg
      kitty
      ripgrep
      killall
      hddtemp
      nettools
      wireguard
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
