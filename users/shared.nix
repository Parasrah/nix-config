{
  git = {
    aliases = {
      co = "checkout";
      all = "add -A";
      st = "status";
      pullprev = "!git checkout - && git pull && git checkout -";
      last = "log -1 HEAD";
      tree = "!git log --graph --decorate --pretty=format:'%C(yellow)%h %Cred%cr %Cblue(%an)%C(cyan)%d%Creset %s' --abbrev-commit --all";
    };

    extraConfig = {
      core = {
        editor = "neovim";
      };
    };
  };

  fzf = {
    enable = true;
    defaultCommand = "rg";
  };

  bash = {
    enable = true;
  };

  xdg.configFile = {
    "i3/config".source = ../dotfiles/i3.config;

    "dunst/dunstrc".source = ../dotfiles/dunst.ini;

    "kitty/kitty.conf".source = ../dotfiles/kitty.conf;

    "polybar".source = ../dotfiles/polybar;
  };
}
