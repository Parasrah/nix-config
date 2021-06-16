{ pkgs, ... }:

{
  imports = [
    ./generic.nix
  ];

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
      lightdm = {
        enable = true;
        greeters = {
          gtk = {
            enable = true;
          };
        };
      };
    };

    windowManager.i3 = {
      enable = true;

      package = pkgs.unstable.i3;

      extraPackages = with pkgs; [
        dmenu
        rofi
        dunst
        pango
        unstable.i3lock
        pulseaudio-ctl
        (
          unstable.polybar.override {
            i3Support = true;
            mpdSupport = true;
            pulseSupport = true;
          }
        )
      ];
    };
  };

  services.compton = {
    enable = false;
    shadow = false;
    inactiveOpacity = "0.85";
    menuOpacity = "1.0";
    fade = true;
    fadeDelta = 3;
  };

  services.gnome.gnome-keyring.enable = true;

  programs.nm-applet.enable = false;

  security.pam.services.login.enableGnomeKeyring = true;

  security.pam.services.passwd = with pkgs; {
    text = lib.mkDefault (
      lib.mkAfter ''
        password optional ${gnome.gnome-keyring}/lib/security/pam_gnome_keyring.so
      ''
    );
  };
}
