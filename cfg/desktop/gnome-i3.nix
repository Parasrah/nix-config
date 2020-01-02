{ pkgs, ... }:

let
  i3Config =
    import ./i3.nix { inherit pkgs; };

in
{
  imports = [ ./generic.nix ];

  services.xserver = {
    enable = true;

    displayManager = {
      default = "gdm";

      gdm = {
        enable = true;
        wayland = false;
      };
    };

    windowManager.i3 = i3Config.windowManager.i3;

    desktopManager = {
      gnome3 = {
        enable = true;
      }
    };
  };

  services.dbus.packages = with pkgs; [ gnome3.dconf gnome2.GConf ];
}
