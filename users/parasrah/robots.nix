let
  util = import ../util;

in
util.createHomeUser
  ({
    username = "parasrah";

    stateVersion = "20.09";

    mods = [
      (import ../mods/core.nix)
      (import ../mods/kakoune.nix)
      (import ../mods/developer.nix)
      (import ../mods/web.nix)
      (import ../mods/rust.nix)
      (import ../mods/lua.nix)
      (import ../mods/nushell.nix)
      (import ./default.nix)
      (
        { pkgs, username, ... }: {
          homemanager = {
            home.packages = with pkgs; [
              # fonts
              noto-fonts
              recursive
              font-awesome
              dejavu_fonts

              # i3
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

            fonts.fontconfig.enable = true;
            programs.home-manager.enable = true;
            home.sessionVariables.LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
            targets.genericLinux.enable = true;
            programs.bash.profileExtra = ''
              . "$HOME/.nix-profile/etc/profile.d/nix.sh"
            '';

            services.gpg-agent = {
              enable = true;
              defaultCacheTtl = 1800;
              enableSshSupport = true;
            };
          };
        }
      )
    ];
  })
