{ pkgs }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  services.xserver.desktopManager.gnome3.enable = true;

  services.dbus.packages = with pkgs; [ gnome3.dconf gnome2.GConf ];
}
