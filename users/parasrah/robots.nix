let
  util = import ../util;
in
util.createHomeUser
  ({
    username = "parasrah";

    stateVersion = "20.09";

    mods = [
      (import ./default.nix)
      (import ../mods/core.nix)
      (import ../mods/kakoune.nix)
      (import ../mods/developer.nix)
      (import ../mods/web.nix)
      (import ../mods/rust.nix)
      (import ../mods/lua.nix)
      (
        { pkgs, username, homeDirectory, inputs, lib, ... }:
        let
          # TODO: see if you can get autorandr working on virtual monitor
          xinitrc =
            pkgs.writeTextFile {
              name = ".xinitrc";
              text = ''
                if [ -n "$__XINITRC_SOURCED" ]; then return; fi
                export __XINITRC_SOURCED=1

                # unlock keyring
                eval $(gnome-keyring-daemon --start --components=pkcs11,secrets)

                # force dpi, TODO: use autorandr (might be difficult w/ virtual monitor)
                echo "Xft.dpi: 144" | xrdb -merge

                # fix keyboard
                ${inputs.dotfiles}/scripts/fix-keyboard "${inputs.dotfiles}/layout.xkb" 2>/dev/null

                # source profile
                . ~/.profile

                # set background image
                ${pkgs.feh}/bin/feh --bg-scale "${homeDirectory}/.background-image"
              '';
            };

        in
        {
          homemanager = {
            home.packages = with pkgs; [
              slack
              wmctrl
              chromium

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
            xdg.enable = true;
            xdg.mime.enable = true;
            home.sessionVariables.LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
            targets.genericLinux.enable = true;

            pam.sessionVariables = {
              LANGUAGE = "en_CA:en";
              LANG = "en_CA.UTF-8";
              LC_NUMERIC = "en_CA.UTF-8";
              LC_TIME = "en_CA.UTF-8";
              LC_MONETARY = "en_CA.UTF-8";
              LC_PAPER = "en_CA.UTF-8";
              LC_NAME = "en_CA.UTF-8";
              LC_ADDRESS = "en_CA.UTF-8";
              LC_TELEPHONE = "en_CA.UTF-8";
              LC_MEASUREMENT = "en_CA.UTF-8";
              LC_IDENTIFICATION = "en_CA.UTF-8";
              PAPERSIZE = "letter";
              SSH_AGENT_PID = "";
              SSH_AUTH_SOCK = "\${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh";
            };

            programs.bash = {
              # TODO: make `util#create` support `lib.mkAfter` & `lib.mkBefore`
              # or (preferably) find way to make Nix modules to work w/ home manager
              # and NixOS
              initExtra = ''
                . $HOME/.profile

                # vim mode
                set -o vi

                eval "$(zoxide init bash)"
                eval "$(starship init bash)"
                eval "$(direnv hook bash)"

                # gpg
                export GPG_TTY=$(tty)
                gpg-connect-agent updatestartuptty /bye >/dev/null

                # completions
                if ! shopt -oq posix; then
                  if [ -f /usr/share/bash-completion/bash_completion ]; then
                    . /usr/share/bash-completion/bash_completion
                  elif [ -f /etc/bash_completion ]; then
                    . /etc/bash_completion
                  fi
                fi
              '';

              profileExtra = ''
                if [ -n "$__PROFILE_SOURCED" ]; then return; fi
                export __PROFILE_SOURCED=1

                . "$HOME/.nix-profile/etc/profile.d/nix.sh"
              '';

              shellAliases = {
                ls = "ls --color=auto";
              };
            };

            home.file.".xinitrc".source = xinitrc;
            home.file.".xsession".source = xinitrc;
            home.file.".xprofile".source = xinitrc;
            home.file.".npmrc".text = ''
              prefix=~/.npm-global
              ignore-scripts=false
            '';

            services.gpg-agent = {
              enable = true;
              defaultCacheTtl = 1800;
              enableSshSupport = true;
            };

            services.lorri = {
              enable = true;
            };

            services.flameshot = {
              # enable this after getting onto 21.05
              enable = false;
            };

            services.screen-locker.enable = false;
          };
        }
      )
    ];
  })
