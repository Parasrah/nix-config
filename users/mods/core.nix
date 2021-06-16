# Core User Config
#
# All normal users should extend from "core"

{ username, pkgs, homeDirectory, stateVersion, inputs, system, ... }:

{
  os = {
    isNormalUser = true;
    home = homeDirectory;
  };

  homemanager = {
    home.homeDirectory = homeDirectory;
    home.username = username;
    home.stateVersion = stateVersion;

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
      tealdeer
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
      appimage-run
      lxappearance
      desktop-file-utils

      xorg.xkbcomp
      xorg.xmodmap

      gnome.nautilus
      gnome.seahorse

      unstable.nnn
      unstable.brave
      unstable.httpie
      unstable.bottom
      unstable.flameshot
    ];
  };
}
