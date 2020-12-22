{ pkgs, lib, username, fun, ... }:

let
  home =
    "/home/${username}";

  env = rec {
    # base
    nix = "/etc/nixos";
    dotfiles = "${nix}/users/${username}/dotfiles";
    projects = "${home}/Projects";

    # config
    kak = "${dotfiles}/kak";
    nvim = "${dotfiles}/nvim";

    # common
    editor = "vi";
    visual = "kak";
    terminal = "kitty";
    kak_posix_shell = "${pkgs.dash}/bin/dash";
  };

  paths = with env; [
    "${kak}/plugins/connect.kak/bin"
    "${kak}/bin"
    "${home}/.gnpm/bin"
    "${home}/.cargo/bin"
    "${home}/Scripts"
    "${home}/.local/bin"
    "${dotfiles}/scripts"
  ];

in
{
  os = {
    description = "Brad";
    extraGroups = [ "wheel" "networkmanager" "nixos-config" "docker" ];
    initialHashedPassword = "$6$HkJllhqe$C8oSl9ox6WyNAdN6yjzTf3R1HzMbA6dDY8ziafg.XSG3LUrt5yG927KpDuA1nqGiiwGyGJ5jn5j.OwtNplSd3/";
    shell = pkgs.bash;
  };

  homemanager = {
    home.sessionVariables = {
      NIX = env.nix;
      DOTFILES = env.dotfiles;
      NVIMCONFIG = env.nvim;
      KAKCONFIG = env.kak;
      KAKOUNE_POSIX_SHELL = env.kak_posix_shell;
      PROJECTS = env.projects;
      EDITOR = env.editor;
      VISUAL = env.visual;
      TERMINAL = env.terminal;

      # setup path
      PATH = "${lib.strings.concatStringsSep ":" paths}:$PATH";
    };

    home.packages = with pkgs; [
      feh
      mpc_cli
      todoist
      ncurses
      mpdris2
      xss-lock
      tdesktop
      breeze-gtk
      signal-desktop
      adapta-gtk-theme
      paper-icon-theme

      unstable.starship
      unstable.spotify-tui

      unstable.gitAndTools.delta
    ];

    home.file =
      let
        xinitrc =
          fun.pipe
            [
              (builtins.readFile)
              (
                x: lib.strings.concatStringsSep "\n\n" [
                  x
                  ''
                    . ~/.profile
                  ''
                ]
              )
              (builtins.toFile ".xinitrc")
            ]
            ./dotfiles/xinitrc;
      in
        {
          ".background-image".source = ./dotfiles/wallpaper.png;
          ".npmrc".source = ./dotfiles/npmrc;
          ".xinitrc".source = xinitrc;
          ".xsession".source = xinitrc;
          ".xprofile".source = xinitrc;
          xterm-kitty = {
            source = "${pkgs.kitty}/lib/xterm/terminfo/x/xterm-kitty";
            target = ".terminfo/x/xterm-kitty";
          };
          kak-connect = {
            source = ./dotfiles/kak/share/kakoune-connect.desktop;
            target = ".local/share/applications/kakoune-connect.desktop";
          };
          "kakoune.svg" = {
            source = ./dotfiles/kak/share/kakoune.logo;
            target = ".local/share/icons/hicolor/scalable/apps/kakoune.svg";
          };
        };

    xdg.configFile = {
      i3.source = ./dotfiles/i3;
      polybar.source = ./dotfiles/polybar;
      dunst.source = ./dotfiles/dunst;
      kitty.source = ./dotfiles/kitty;
      rofi.source = ./dotfiles/rofi;
      kak-lsp.source = ./dotfiles/kak/kak-lsp;
      gitui.source = ./dotfiles/gitui;
      kaksys.source = "${pkgs.unstable.kakoune-unwrapped}/share/kak/autoload";
      "broot/conf.toml".source = ./dotfiles/broot/conf.toml;
      "starship.toml".source = ./dotfiles/starship.toml;
      "nu/config.toml".text =
        let
          surroundedPaths =
            builtins.map (x: "\"${x}\"") paths;

          joinedPath =
            builtins.concatStringsSep ", " surroundedPaths;

        in
          ''
            path = [${joinedPath}]
            use_starship = true
            skip_welcome_message = true

            [env]
            KAKOUNE_POSIX_SHELL = "${env.kak_posix_shell}"
            EDITOR = "${env.editor}"
            VISUAL = "${env.visual}"
            TERMINAL = "${env.terminal}"
            DOTFILES = "${env.dotfiles}"
            NIX = "${env.nix}"

            [line_editor]
            edit_mode = "vi"
            max_history_size = 10000
            history_duplicates = "ignoreconsecutive" # alwaysadd, ignoreconsecutive
            history_ignore_space = true
            completion_type = "circular" # circular, list, fuzzy
            auto_add_history = true
            bell_style = "none" # audible, none, visible
            color_mode = "enabled" # enabled, forced, disabled
            keyseq_timeout_ms = 50
          '';
    };

    xdg.mimeApps = {
      enable = true;
      associations = {
        added = {
          "image/png" = "brave-browser.desktop";
          "application/pdf" = "okularApplication_dvi.desktop";
        };
        removed = {};
      };
      defaultApplications = {
        "x-scheme-handler/http" = "brave-browser.desktop";
        "x-scheme-handler/https" = "brave-browser.desktop";
        "x-scheme-handler/ftp" = "brave-browser.desktop";
        "x-scheme-handler/chrome" = "brave-browser.desktop";
        "text/html" = "brave-browser.desktop";
        "application/x-extension-htm" = "brave-browser.desktop";
        "application/x-extension-html" = "brave-browser.desktop";
        "application/x-extension-shtml" = "brave-browser.desktop";
        "application/xhtml+xml" = "brave-browser.desktop";
        "application/x-extension-xhtml" = "brave-browser.desktop";
        "application/x-extension-xht" = "brave-browser.desktop";
        "x-scheme-handler/about" = "brave-browser.desktop";
        "x-scheme-handler/unknown" = "brave-browser.desktop";
        "x-scheme-handler/postman" = "Postman.desktop";
        "x-scheme-handler/mailto" = "brave-browser.desktop";
        "application/json" = "kakoune-connect.desktop";
        "text/plain" = "kakoune-connect.desktop";
        "text/xml" = "kakoune-connect.desktop";
        "text/x-ruby" = "kakoune-connect.desktop";
      };
    };

    programs = {
      bash = {
        enable = true;
        initExtra = lib.mkBefore ''
          # this is okay because home manager ensures it's only loaded once
          . $HOME/.profile

          set -o vi

          eval "$(zoxide init bash)"

          eval "$(starship init bash)"

          eval "$(direnv hook bash)"

          # ssh agent fix for i3
          if [ -n "$DESKTOP_SESSION" ]; then
            eval $(gnome-keyring-daemon --start)
            export SSH_AUTH_SOCK
          fi
        '';

        shellAliases = {};
      };

      fzf = {
        enable = true;
        defaultCommand = "rg --files -g '!.git/' -g '!node_modules/'";
      };

      git = {
        enable = true;
        userEmail = "git@parasrah.com";
        userName = "Parasrah";

        aliases = {
          st = "status";
          co = "checkout";
          all = "add -A";
          last = "log -1 HEAD";
          tree = "!git log --graph --decorate --pretty=format:'%C(yellow)%h %Cred%cr %Cblue(%an)%C(cyan)%d%Creset %s' --abbrev-commit --all";
          recent = "for-each-ref --sort=-committerdate --count=10 --format='%(refname:short)' refs/heads/";
          publish = "!git push -u origin $(git branch --show-current)";
        };

        extraConfig = {
          core = {
            editor = "kak";
            pager = "delta";
          };
          merge = {
            tool = "meld";
          };
          pull = {
            rebase = false;
          };
        };

        signing = {
          signByDefault = true;
          key = lib.strings.fileContents ../../secrets/gpg/signingkey;
        };
      };

      autorandr = {
        enable = true;
        hooks = {
          postswitch = {
            "10-change-dpi" = ''
              case "$AUTORANDR_CURRENT_PROFILE" in
                mobile)
                  DPI=96
                  ;;
                tower)
                  DPI=144
                  ;;
                home)
                  DPI=96
                  ;;
                *)
                  echo "unknown profile: $AUTORANDR_CURRENT_PROFILE"
                  exit 1
              esac

              echo "Xft.dpi: $DPI" | ${pkgs.xorg.xrdb}/bin/xrdb -merge
            '';

            "20-notify-i3" = ''
              ${pkgs.i3}/bin/i3-msg restart
            '';

            "30-change-background" = ''
              ${pkgs.feh}/bin/feh --bg-scale ${./dotfiles/wallpaper.png}
            '';
          };
        };

        profiles = {
          mobile = {
            fingerprint = {
              eDP1 = "00ffffffffffff004d10841400000000281b0104a51d11780ede50a3544c99260f505400000001010101010101010101010101010101ac3780a070383e403020350026a510000018892c80a070383e403020350026a510000018000000fe005754315233814c513133334d31000000000002410328001200000b010a20200001";
            };

            config = {
              eDP1 = {
                enable = true;
                primary = true;
                position = "0x0";
                mode = "1920x1080";
                gamma = "1.0:1.0:1.0";
                rate = "60.00";
                rotate = "normal";
              };
            };
          };

          tower = {
            fingerprint = {
              "HDMI-A-0" = "00ffffffffffff0009d1497945540000101e0103803e22782e08a5a2574fa2280f5054a56b80d1c081c081008180a9c0b300a940010151d000a0f0703e80302035006d552100001a000000ff0054344c3033363238534c300a20000000fd00184c1e873c000a202020202020000000fc0042656e5120454c32383730550a013c02034ef15661605d5e5f100504030207060f1f2021221413121601230907076d030c001000384420006001020367d85dc401788003e305c301e40f030000e60605015a5344681a00000101283c00565e00a0a0a02950302035006d552100001af45100a0f0701980302035006d552100001e00000000000000000000000000fb";
            };
            config = {
              "HDMI-A-0" = {
                enable = true;
                primary = true;
                position = "0x0";
                mode = "3840x2160";
                gamma = "1.0:1.0:1.0";
                rate = "60.00";
                rotate = "normal";
              };
            };
          };

          home = {
            fingerprint = {
              eDP1 = "00ffffffffffff004d10841400000000281b0104a51d11780ede50a3544c99260f505400000001010101010101010101010101010101ac3780a070383e403020350026a510000018892c80a070383e403020350026a510000018000000fe005754315233814c513133334d31000000000002410328001200000b010a20200001";
              DP1 = "00ffffffffffff0009d1497945540000101e0103803e22782e08a5a2574fa2280f5054a56b80d1c081c081008180a9c0b300a940010151d000a0f0703e80302035006d552100001a000000ff0054344c3033363238534c300a20000000fd00184c1e873c000a202020202020000000fc0042656e5120454c32383730550a013c02034ef15661605d5e5f100504030207060f1f2021221413121601230907076d030c001000384420006001020367d85dc401788003e305c301e40f030000e60605015a5344681a00000101283c00565e00a0a0a02950302035006d552100001af45100a0f0701980302035006d552100001e00000000000000000000000000fb";
            };
            config = {
              eDP1.enable = false;
              DP1 = {
                enable = true;
                primary = true;
                position = "0x0";
                mode = "2560x1440";
                gamma = "1.0:1.0:1.0";
                rate = "60.00";
                rotate = "normal";
              };
            };
          };
        };
      };
    };

    systemd.user.startServices = true;

    services = {
      spotifyd = {
        enable = true;
        # package = with pkgs.unstable.spotifyd;
        settings = {
          global = {
            username = builtins.readFile ../../secrets/spotify/username;
            password = builtins.readFile ../../secrets/spotify/password;
            backend = "pulseaudio";
            device_name = "nix";
          };
        };
      };
    };
  };
}
