let
  util = import ./util;

in
util.create {
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
      go
      nnn
      gcc
      htop
      kitty
      neovim
      gnumake
      spotify
      python3
      firefox
      bookworm
      playerctl
      wireguard
      breeze-gtk
      pavucontrol
      inotify-tools
      signal-desktop
      azuredatastudio
      adapta-gtk-theme
      paper-icon-theme

      xorg.xbacklight

      gnome3.nautilus
      gnome3.seahorse

      python37Packages.pip
      python37Packages.setuptools

      lua51Packages.lua-lsp

      unstable.rls
      unstable.scc
      unstable.cargo
      unstable.rustc
      unstable.brave
      unstable.lutris
      unstable.elixir
      unstable.postman
      unstable.chromium
      unstable.flameshot
      unstable.nodejs-12_x

      unstable.nodePackages.neovim
      unstable.nodePackages.eslint

      unstable.elmPackages.elm
      unstable.elmPackages.elm-test
      unstable.elmPackages.elm-format
      unstable.elmPackages.elm-analyse
      unstable.elmPackages.elm-language-server
    ];

    home.file = {
      ".background-image".source = ./parasrah/dotfiles/wallpaper.jpg;
      ".npmrc".source = ./parasrah/dotfiles/npmrc;
    };

    xdg.configFile = {
      i3.source = ./parasrah/dotfiles/i3;
      polybar.source = ./parasrah/dotfiles/polybar;
      dunst.source = ./parasrah/dotfiles/dunst;
      kitty.source = ./parasrah/dotfiles/kitty;
      rofi.source = ./parasrah/dotfiles/rofi;
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
            editor = "nvim";
          };
        };

        signing = {
          signByDefault = true;
          key = builtins.readFile ../secrets/gpg/signingkey;
        };
      };
    };
  };
}
