{ pkgs, ... }:

import ./i3.nix { inherit pkgs; } // {
  services.xserver = {

    desktopManager = {
      gnome3.enable = true;
    };

    displayManager = {
      gdm = {
        enable = false;
        wayland = false;
      };
    };
  };

  programs.nm-applet = {
    enable = true;
  };

  services.dbus.packages = with pkgs; [ gnome3.dconf gnome2.GConf ];
}
