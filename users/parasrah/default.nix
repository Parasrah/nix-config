{ pkgs, ... }:

{
  os = {
    description = "Brad";
    extraGroups = [ "wheel" "networkmanager" "nixos-config" "docker" ];
    initialHashedPassword = "$6$HkJllhqe$C8oSl9ox6WyNAdN6yjzTf3R1HzMbA6dDY8ziafg.XSG3LUrt5yG927KpDuA1nqGiiwGyGJ5jn5j.OwtNplSd3/";
  };

  homemanager = {
    home.packages = with pkgs; [
      adapta-gtk-theme
      paper-icon-theme
      breeze-gtk
      signal-desktop
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
      kaksys.source = "${pkgs.unstable.kakoune-unwrapped}/share/kak/autoload";
    };

    programs = {
      bash = {
        enable = true;
        initExtra = builtins.readFile ./dotfiles/powerline.sh + ''
          set -o vi
          if [ -n "$DESKTOP_SESSION" ]; then
            eval $(gnome-keyring-daemon --start)
            export SSH_AUTH_SOCK
          fi
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
