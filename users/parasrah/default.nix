{ pkgs, lib, username, fun, inputs, isNixOS, ... }:
let
  home =
    "/home/${username}";

  env = rec {
    # base
    nix = "/etc/nixos";
    dotfiles = "${nix}/users/${username}/dotfiles";
    projects = "${home}/Projects";

    # config
    kak = "${inputs.dotfiles}/kak";
    nvim = "${inputs.dotfiles}/nvim";

    # fzf
    fzfDefaultCmd = "fd --type f -H --exclude '.git/*'";

    # common
    editor = "vi -e";
    visual = "kcr edit";
    terminal = "kitty";
    kakPosixShell = "${pkgs.dash}/bin/dash";
  };

  paths = with env; [
    "${kak}/bin"
    "${home}/.npm-global/bin"
    "${home}/.cargo/bin"
    "${home}/Scripts"
    "${home}/.local/bin"
    "$DOTFILES/scripts"
  ];

in
{
  os = {
    description = "Brad";
    extraGroups = [ "wheel" "networkmanager" "nixos-config" "docker" "vboxusers" ];
    initialHashedPassword = "$6$HkJllhqe$C8oSl9ox6WyNAdN6yjzTf3R1HzMbA6dDY8ziafg.XSG3LUrt5yG927KpDuA1nqGiiwGyGJ5jn5j.OwtNplSd3/";
    shell = pkgs.bash;
  };

  homemanager = {
    home.sessionVariables = {
      NIX = env.nix;
      DOTFILES = env.dotfiles;
      NVIMCONFIG = env.nvim;
      KAKCONFIG = env.kak;
      KAKOUNE_POSIX_SHELL = env.kakPosixShell;
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
      signal-desktop

      unstable.starship
      unstable.spotify-tui

      unstable.gitAndTools.delta
    ] ++ lib.lists.optionals isNixOS [
      breeze-gtk
      paper-icon-theme
      adapta-gtk-theme
    ];

    home.file =
      let
        xinitrc =
          pkgs.writeTextFile {
            name = ".xinitrc";
            text = ''
              if [ -n "$__XINITRC_SOURCED" ]; then return; fi
              export __XINITRC_SOURCED=1

              # unlock keyring
              eval $(gnome-keyring-daemon --start --components=pkcs11,secrets)

              # run autorandr
              autorandr --change
            '';
          };

        pamEnvironment =
          pkgs.writeTextFile {
            name = ".pam_environment";
            text = ''
              LANGUAGE	        DEFAULT=en_CA:en
              LANG	            DEFAULT=en_CA.UTF-8
              LC_NUMERIC	      DEFAULT=en_CA.UTF-8
              LC_TIME	          DEFAULT=en_CA.UTF-8
              LC_MONETARY	      DEFAULT=en_CA.UTF-8
              LC_PAPER	        DEFAULT=en_CA.UTF-8
              LC_NAME	          DEFAULT=en_CA.UTF-8
              LC_ADDRESS	      DEFAULT=en_CA.UTF-8
              LC_TELEPHONE	    DEFAULT=en_CA.UTF-8
              LC_MEASUREMENT	  DEFAULT=en_CA.UTF-8
              LC_IDENTIFICATION	DEFAULT=en_CA.UTF-8
              PAPERSIZE	        DEFAULT=letter

              SSH_AGENT_PID	    DEFAULT=
              SSH_AUTH_SOCK	    DEFAULT="''${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
            '';
          };

      in
      {
        ".pam_environment".source = pamEnvironment;
        ".background-image".source = "${inputs.dotfiles}/wallpaper.png";
        ".npmrc".source = "${inputs.dotfiles}/npmrc";
        ".xinitrc".source = xinitrc;
        ".xsession".source = xinitrc;
        xterm-kitty = {
          source = "${pkgs.kitty}/lib/xterm/terminfo/x/xterm-kitty";
          target = ".terminfo/x/xterm-kitty";
        };
        "kakoune.svg" = {
          source = "${inputs.dotfiles}/kak/share/kakoune.logo";
          target = ".local/share/icons/hicolor/scalable/apps/kakoune.svg";
        };
      };

    xdg.configFile = {
      i3.source = "${inputs.dotfiles}/i3";
      polybar.source = "${inputs.dotfiles}/polybar";
      kitty.source = "${inputs.dotfiles}/kitty";
      kak-lsp.source = "${inputs.dotfiles}/kak/kak-lsp";
      gitui.source = "${inputs.dotfiles}/gitui";
      kaksys.source = "${pkgs.unstable.kakoune-unwrapped}/share/kak/autoload";
      "broot/conf.toml".source = "${inputs.dotfiles}/broot/conf.toml";
      "starship.toml".source = "${inputs.dotfiles}/starship.toml";
      "rofi/config.rasi".source = "${inputs.dotfiles}/rofi/config.rasi";
      "rofi/launcher.sh".source = "${inputs.dotfiles}/rofi/launcher.sh";
      "rofi/themes/style_8.rasi".source = "${inputs.dotfiles}/rofi/themes/style_8.rasi";
      "nu/config.toml".text = import ./nu.nix { inherit paths env; };
    };

    xdg.mimeApps = {
      enable = true;
      associations = {
        added = {
          "image/png" = "brave-browser.desktop";
          "application/pdf" = "okularApplication_dvi.desktop";
        };
        removed = { };
      };
      defaultApplications = {
        "application/csv" = "kakoune.desktop";
        "application/json" = "kakoune.desktop";
        "application/postscript" = "kakoune.desktop";
        "text/html" = "kakoune.desktop";
        "text/plain" = "kakoune.desktop";
        "text/troff" = "kakoune.desktop";
        "text/x-c++" = "kakoune.desktop";
        "text/x-c" = "kakoune.desktop";
        "text/x-java" = "kakoune.desktop";
        "text/x-lisp" = "kakoune.desktop";
        "text/x-makefile" = "kakoune.desktop";
        "text/xml" = "kakoune.desktop";
        "text/x-ruby" = "kakoune.desktop";
        "text/x-script.python" = "kakoune.desktop";
        "text/x-shellscript" = "kakoune.desktop";
        "application/x-directory" = "org.gnome.Nautilus.desktop";
        "inode/directory" = "org.gnome.Nautilus.desktop";
        "x-scheme-handler/http" = "brave-browser.desktop";
        "x-scheme-handler/https" = "brave-browser.desktop";
        "x-scheme-handler/ftp" = "brave-browser.desktop";
        "x-scheme-handler/chrome" = "brave-browser.desktop";
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
      };
    };

    programs = {
      bash = {
        enable = true;
        shellAliases = {
          # aliases
          ":q" = "exit";
          "cat" = "bat --paging=never";

          # cronus
          ":t" = "cronus";
          ":tw" = "cronus show week";
          ":td" = "cronus show day";
          ":ts" = "cronus status";

          # kak alias
          "la" = "ls --long";
          ":e" = "kcr edit";
          ":k" = "kcr-fzf-shell";
          ":K" = "kcr-fzf-shell --working-directory .";
          ":l" = "kcr list";
          ":a" = "kcr attach";
          ":s" = "kcr send";
          ":kill" = "kcr kill";
          "val" = "kcr get -r --value";
          "opt" = "kcr get -r --option";
          "reg" = "kcr get -r --register";
        };

        initExtra = ''
          # this is okay because home manager ensures it's only loaded once
          . $HOME/.profile

          # vim mode
          set -o vi

          eval "$(zoxide init bash)"
          eval "$(starship init bash)"
          eval "$(direnv hook bash)"

          # gpg
          export GPG_TTY=$(tty)
          gpg-connect-agent updatestartuptty /bye >/dev/null
        '';

        profileExtra = ''
          if [ -n "$__PROFILE_SOURCED" ]; then return; fi
          export __PROFILE_SOURCED=1
        '';
      };

      fzf = {
        enable = true;
        defaultCommand = "rg --files -g '!.git/' -g '!node_modules/'";
      };

      git = {
        enable = true;
        userEmail = "gpg@parasrah.com";
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
            excludesfile = "~/.gitignore";
          };
          merge = {
            tool = "meld";
          };
          pull = {
            rebase = false;
          };
          init = {
            defaultBranch = "main";
          };
        };

        signing = {
          signByDefault = true;
          key = "B909C2B388D31FD5CBCAE1A94CBE600F7547E797";
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
              ${pkgs.feh}/bin/feh --bg-scale ${"${inputs.dotfiles}/wallpaper.png"}
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
              "DisplayPort-2" = "00ffffffffffff0009d1497945540000101e0104b53e22783f08a5a2574fa2280f5054a56b80d1c081c081008180a9c0b300a94001014dd000a0f0703e80302035006d552100001a000000ff0054344c3033363238534c300a20000000fd00283c87873c010a202020202020000000fc0042656e5120454c32383730550a018f02032ef15661605d5e5f100504030207060f1f20212214131216012309070783010000e305c000e60605015a5344023a801871382d40582c45006d552100001e565e00a0a0a02950302035006d552100001a8c640050f0701f80082018046d552100001a00000000000000000000000000000000000000000000000000000093";
            };
            config = {
              "DisplayPort-2" = {
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
  };
}
