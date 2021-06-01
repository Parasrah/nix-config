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
              slack

              # fonts
              noto-fonts
              font-awesome
              dejavu_fonts
              unstable.recursive

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
              if [ -z "$NIX_PROFILE_LOADED" ]; then
                export NIX_PROFILE_LOADED=1
                . "$HOME/.nix-profile/etc/profile.d/nix.sh"
              fi

              echo "Xft.dpi: 144" | xrdb -merge
            '';

            services.dunst = {
              enable = true;
              settings = {
                global = {
                  monitor = 0;
                  follow = "mouse";
                  geometry = "250x50-24+24";
                  indicate_hidden = true;
                  shrink = false;
                  separator_height = 0;
                  padding = 16;
                  horizontal_padding = 24;
                  frame_width = 2;
                  sort = false;
                  idle_threshold = 120;
                  font = "Noto Sans 8";
                  line_height = 4;
                  markup = "full";
                  format = "<b>%s</b>\\n%b";
                  alignment = "left";
                  show_age_threshold = 60;
                  word_wrap = true;
                  ignore_newline = false;
                  stack_duplicates = false;
                  hide_duplicate_count = true;
                  show_indicators = false;
                  icon_position = "off";
                  sticky_history = true;
                  history_length = 20;
                  browser = "brave-browser -new-tab";
                  always_run_script = false;
                  class = "Dunst";
                };

                urgency_low = {
                  background = "#2f343f";
                  foreground = "#d8dee8";
                  timeout = 2;
                };

                urgency_normal = {
                  background = "#2f343f";
                  foreground = "#d8dee8";
                  timeout = 4;
                };

                urgency_critical = {
                  background = "#2f343f";
                  foreground = "#d8dee8";
                  frame_color = "#bf616a";
                  timeout = 0;
                };

                play_sound = {
                  summary = "*";
                  script = "play-notification";
                };
              };
            };

            services.gpg-agent = {
              enable = true;
              defaultCacheTtl = 1800;
              enableSshSupport = true;
            };

            services.lorri = {
              enable = true;
            };
          };
        }
      )
    ];
  })
