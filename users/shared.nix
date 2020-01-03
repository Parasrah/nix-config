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
    initExtra = (builtins.readFile ../dotfiles/powerline.sh) + ''
      if [ -n "$DESKTOP_SESSION" ];then
        eval $(gnome-keyring-daemon --start)
        export SSH_AUTH_SOCK
      fi
    '';
  };

  xdg.configFile = {
    "i3/config".source = ../dotfiles/i3.config;

    "kitty/kitty.conf".source = ../dotfiles/kitty.conf;
  };
}
