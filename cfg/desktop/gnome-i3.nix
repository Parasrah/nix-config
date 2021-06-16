{ pkgs, ... }:

{
  imports = [
    ./i3.nix
  ];

  services.xserver = {
    desktopManager = {
      gnome.enable = true;
    };

    displayManager = {
      gdm = {
        enable = false;
        wayland = false;
      };
    };
  };

  programs.nm-applet.enable = pkgs.lib.mkForce true;

  services.dbus.packages = with pkgs; [ gnome.dconf gnome2.GConf ];
}
