let
  create = import ./util/create.nix;

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
      dbeaver
      firefox
      vlc
      kitty
      neovim
      powershell
      nodejs
      nodePackages.eslint
      nodePackages.neovim
      unstable.cascadia-code
      unstable.brave
      unstable.elmPackages.elm-language-server
      unstable.elmPackages.elm-format
      unstable.elmPackages.elm-test
    ];

    xdg.configFile."kitty/kitty.conf" = {
      source = builtins.path {
        path = ../dotfiles/kitty.conf;
      };
    };

    xsession.windowManager.i3 = {
      enable = false;
      config = {
      };
    };

    gtk.iconTheme = with pkgs; {
      name = "Paper";
      package = paper-icon-theme;
    };

    gtk.theme = with pkgs; {
      name = "Ant";
      package = ant-theme;
    };

    programs.bash = {
      enable = true;
      initExtra = builtins.readFile ../dotfiles/powerline.sh;
    };

    programs.git = {
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
      };
      signing = {
        signByDefault = true;
        key = "8922B1C024EFBF5C";
      };
      extraConfig = {
        core = {
          editor = "neovim";
        };
      };
    };

    programs.fzf = {
      enable = true;
      defaultCommand = "rg";
    };

    programs.vscode = {
      enable = true;
    };
  };
}
