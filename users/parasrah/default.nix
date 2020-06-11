{ pkgs, ... }:

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
      DOTFILES =  "${NIX}/users/parasrah/dotfiles";
      NVIMCONFIG = "${DOTFILES}/nvim";
      KAKCONFIG = "${DOTFILES}/kak";
      POWERLINE_GIT = "1";

      # projects
      PROJECTS = "$HOME/Projects";
      BLOG = "${PROJECTS}/blog";
      ACREAGE = "${PROJECTS}/acreage";
      NERVES = "${PROJECTS}/nerves";

      # common variables
      PAGER = "kak";
      MANPAGER = "kak-man-pager";
      EDITOR = "vi";
      VISUAL = "kak";
      TERMINAL = "kitty";

      # this is so profile will be loaded in all environments
      PROFILE_LOADED = "1";
      PATH = "${KAKCONFIG}/plugins/connect.kak/bin:${KAKCONFIG}/bin:$PATH";
    };

    home.packages = with pkgs; [
      breeze-gtk
      asciidoctor
      signal-desktop
      adapta-gtk-theme
      paper-icon-theme
    ];

    home.file = {
      ".background-image".source = ./dotfiles/wallpaper.jpg;
      ".npmrc".source = ./dotfiles/npmrc;
      xterm-kitty = {
        source = "${pkgs.kitty}/lib/xterm/terminfo/x/xterm-kitty";
        target = ".terminfo/x/xterm-kitty";
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

    programs = {
      bash = {
        enable = true;
        initExtra = builtins.readFile ./dotfiles/powerline.sh + ''
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
        '';
      };

      fzf = {
        enable = true;
        defaultCommand = "rg";
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
            editor = "nvim";
          };
        };

        signing = {
          signByDefault = true;
          key = builtins.readFile ../../secrets/gpg/signingkey;
        };
      };
    };
  };
}
