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
      gdm = {
        enable = true;
        wayland = false;
      };
    };

    windowManager.i3 = i3Config.services.xserver.windowManager.i3;

    desktopManager = {
      gnome3 = {
        enable = true;
      };
    };
  };

  # keyring
  services.gnome3.gnome-keyring.enable = true;

  security.pam.services.login.enableGnomeKeyring = true;

  security.pam.services.passwd = with pkgs; {
    text = lib.mkDefault (lib.mkAfter ''
      password optional ${gnome3.gnome-keyring}/lib/security/pam_gnome_keyring.so
    '');
  };

  services.dbus.packages = with pkgs; [ gnome3.dconf gnome2.GConf ];
}
