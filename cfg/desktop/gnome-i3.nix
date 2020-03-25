{ pkgs, ... }:

{
  imports = [
    ./i3.nix
  ];

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

  programs.nm-applet.enable = pkgs.lib.mkForce true;

  services.dbus.packages = with pkgs; [ gnome3.dconf gnome2.GConf ];
}
