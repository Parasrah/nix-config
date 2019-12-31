{ pkgs, ... }:

{
  imports = [ ./generic.nix ];

  services.xserver = {
    displayManager = {
      gdm = {
        enable = true;
        wayland = false;
      };
    };

    windowManager = {
      default = "none";
    };

    desktopManager = {
      gnome3 = {
        enable = true;
      };
    };
  };

  services.dbus.packages = with pkgs; [ gnome3.dconf gnome2.GConf ];
}
