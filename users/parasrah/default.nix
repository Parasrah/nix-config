{ pkgs, lib, ... }:

{
  os = {
    description = "Brad";
    extraGroups = [ "wheel" "networkmanager" "nixos-config" "docker" ];
    initialHashedPassword = "$6$HkJllhqe$C8oSl9ox6WyNAdN6yjzTf3R1HzMbA6dDY8ziafg.XSG3LUrt5yG927KpDuA1nqGiiwGyGJ5jn5j.OwtNplSd3/";
  };

  homemanager = {
    home.sessionVariables = rec {
      NIX = "/etc/nixos";

      # dotfiles
      DOTFILES = "${NIX}/users/parasrah/dotfiles";
      NVIMCONFIG = "${DOTFILES}/nvim";
      KAKCONFIG = "${DOTFILES}/kak";
      POWERLINE_GIT = "1";
      KAKOUNE_POSIX_SHELL = "${pkgs.dash}/bin/dash";

      # projects
      PROJECTS = "$HOME/Projects";
      BLOG = "${PROJECTS}/blog";
      ACREAGE = "${PROJECTS}/acreage";
      NERVES = "${PROJECTS}/nerves";

      # common variables
      MANPAGER = "kak-man-pager";
      EDITOR = "vi";
      VISUAL = "kak";
      TERMINAL = "kitty";

      # this is so profile will be loaded in all environments
      PROFILE_LOADED = "1";
      PATH = "${KAKCONFIG}/plugins/connect.kak/bin:${KAKCONFIG}/bin:$HOME/.gnpm/bin:$HOME/.cargo/bin:$HOME/Scripts:$PATH";
    };

    home.packages = with pkgs; [
      feh
      cloc
      cmatrix
      ncurses
      breeze-gtk
      asciidoctor
      nixpkgs-fmt
      signal-desktop
      adapta-gtk-theme
      paper-icon-theme

      unstable.etcher
    ];

    home.file = {
      ".background-image".source = ./dotfiles/wallpaper.jpg;
      ".npmrc".source = ./dotfiles/npmrc;
      ".xinitrc".source = ./dotfiles/xinitrc;
      ".xsession".source = ./dotfiles/xinitrc;
      ".xprofile".source = ./dotfiles/xinitrc;
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
      kaksys.source = "${pkgs.unstable.kakoune-unwrapped}/share/kak/autoload";
      "broot/conf.toml".source = ./dotfiles/broot/conf.toml;
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
        initExtra = lib.mkBefore (
          builtins.readFile ./dotfiles/powerline.sh + ''
            set -o vi

            # ssh agent fix for i3
            if [ -n "$DESKTOP_SESSION" ]; then
              eval $(gnome-keyring-daemon --start)
              export SSH_AUTH_SOCK
            fi

            # ensure profile is loaded
            if [ -z "$PROFILE_LOADED" ]; then
              . $HOME/.profile
            fi

            source $HOME/.config/broot/launcher/bash/br
          ''
        );

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
          co = "checkout";
          all = "add -A";
          st = "status";
          pullprev = "!git checkout - && git pull && git checkout -";
          last = "log -1 HEAD";
          tree = "!git log --graph --decorate --pretty=format:'%C(yellow)%h %Cred%cr %Cblue(%an)%C(cyan)%d%Creset %s' --abbrev-commit --all";
          recent = "for-each-ref --sort=-committerdate --count=10 --format='%(refname:short)' refs/heads/";
        };

        extraConfig = {
          core = {
            editor = "kak";
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
                hdmi)
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
              ${pkgs.feh}/bin/feh --bg-scale ${./dotfiles/wallpaper.jpg}
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

          hdmi = {
            fingerprint = {
              "HDMI-1" = "00ffffffffffff0009d1497945540000101e0103803e22782e08a5a2574fa2280f5054a56b80d1c081c081008180a9c0b300a940010151d000a0f0703e80302035006d552100001a000000ff0054344c3033363238534c300a20000000fd00184c1e873c000a202020202020000000fc0042656e5120454c32383730550a013c02034ef15661605d5e5f100504030207060f1f2021221413121601230907076d030c002000384420006001020367d85dc401788003e305c301e40f030000e60605015a5344681a00000101283c00565e00a0a0a02950302035006d552100001af45100a0f0701980302035006d552100001e00000000000000000000000000eb";
            };
            config = {
              "HDMI-1" = {
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
  };
}
