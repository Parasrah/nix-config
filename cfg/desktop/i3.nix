{ pkgs, ... }:

{
  imports = [ ./generic.nix ];

  services.xserver = {
    enable = true;

    desktopManager = {
      default = "none";
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;

      extraPackages = with pkgs; [
        dmenu
        rofi
        dunst
        pango
        i3lock
        (unstable.polybar.override {
          i3Support = true;
          mpdSupport = true;
          pulseSupport = true;
        })
      ];
    };
  };

  services.compton = {
    enable = true;
    shadow = false;
    inactiveOpacity = "0.8";
  };

  services.mpd = {
    enable = true;
  };

  services.gnome3.gnome-keyring.enable = true;

  programs.nm-applet = {
    enable = true;
  };

  security.pam.services.login.enableGnomeKeyring = true;

  security.pam.services.passwd = with pkgs; {
    text = lib.mkDefault (lib.mkAfter ''
      password optional ${gnome3.gnome-keyring}/lib/security/pam_gnome_keyring.so
    '');
  };
}
