{ pkgs, ... }:

{
  imports = [
    ./generic.nix
  ];

  services.xserver = {
    enable = true;

    desktopManager = {
      default = "none";
      xterm.enable = false;
    };

    displayManager = {
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

  services.compton = {
    enable = false;
    shadow = false;
    inactiveOpacity = "0.8";
    menuOpacity = "1.0";
    fade = true;
    fadeDelta = 5;
  };

  services.mpd = {
    enable = true;
  };

  services.gnome3.gnome-keyring.enable = true;

  programs.nm-applet.enable = false;

  security.pam.services.login.enableGnomeKeyring = true;

  security.pam.services.passwd = with pkgs; {
    text = lib.mkDefault (lib.mkAfter ''
      password optional ${gnome3.gnome-keyring}/lib/security/pam_gnome_keyring.so
    '');
  };
}
