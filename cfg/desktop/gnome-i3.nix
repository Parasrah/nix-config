{ pkgs, ... }:

{
  imports = [
    ./generic.nix
  ];

  services.xserver = {
    enable = true;

    desktopManager = {
      default = "none";
      gnome3.enable = true;
    };

    displayManager = {
      gdm = {
        enable = false;
        wayland = false;
      };

      lightdm = {
        enable = true;
      };
    };

    windowManager.i3 = {
      enable = true;

      extraPackages = with pkgs; [
        dmenu
        rofi
        dunst
        pango
        i3lock
        pulseaudio-ctl
        (unstable.polybar.override {
          i3Support = true;
          mpdSupport = true;
          pulseSupport = true;
        })
      ];
    };
  };

  services.mpd = {
    enable = true;
  };

  services.gnome3.gnome-keyring.enable = true;

  services.dbus.packages = with pkgs; [ gnome3.dconf gnome2.GConf ];

  programs.nm-applet.enable = true;

  security.pam.services.passwd = with pkgs; {
    text = lib.mkDefault (lib.mkAfter ''
      password optional ${gnome3.gnome-keyring}/lib/security/pam_gnome_keyring.so
    '');
  };
}
