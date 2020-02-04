let
  create = import ./util/create.nix;

  shared = import ./shared.nix;

in
create {
  username = "parasrah";

  user = {
    isNormalUser = true;
    home = "/home/parasrah";
    description = "Brad";
    extraGroups = [ "wheel" "networkmanager" "nixos-config" "docker" ];
    initialHashedPassword = "$6$HkJllhqe$C8oSl9ox6WyNAdN6yjzTf3R1HzMbA6dDY8ziafg.XSG3LUrt5yG927KpDuA1nqGiiwGyGJ5jn5j.OwtNplSd3/";
  };

  homemanager = pkgs: {
    home.packages = with pkgs; [
      nnn
      htop
      kitty
      neovim
      spotify
      firefox
      playerctl
      breeze-gtk
      inotify-tools
      signal-desktop
      azuredatastudio
      adapta-gtk-theme
      paper-icon-theme

      xorg.xbacklight

      gnome3.nautilus
      gnome3.seahorse

      lua51Packages.lua-lsp

      unstable.brave
      unstable.postman
      unstable.chromium
      unstable.flameshot
      unstable.nodejs-12_x

      unstable.nodePackages.neovim
      unstable.nodePackages.eslint

      unstable.elmPackages.elm
      unstable.elmPackages.elm-test
      unstable.elmPackages.elm-format
      unstable.elmPackages.elm-language-server
    ];

    home.sessionVariables = {
      PROJECTS = "TEST";
    };

    home.file = {
      ".background-image".source = ../dotfiles/wallpaper.jpg;
      ".npmrc".source = ../dotfiles/npmrc;
    };

    xdg.configFile = {
      i3.source = ../dotfiles/i3;
      polybar.source = ../dotfiles/polybar;
      dunst.source = ../dotfiles/dunst;
      kitty.source = ../dotfiles/kitty;
      rofi.source = ../dotfiles/rofi;
    };

    programs = {
      bash = {
        enable = true;
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
            editor = "neovim";
          };
        };

        signing = {
          signByDefault = true;
          key = "8922B1C024EFBF5C";
        };
      };

      vscode = {
        enable = true;
      };
    };
  };
}
