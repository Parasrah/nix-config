let
  fromPath =
    path : builtins.path {
      path = path;
    };

in
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

  xdg.configFile = {
    "i3/config".source = fromPath ../dotfiles/i3.config;

    "kitty/kitty.conf".source = fromPath ../dotfiles/kitty.conf;

    "fish/fish_variables".source = fromPath ../dotfiles/fish/fish_variables;
    
    "fish/functions".source = fromPath ../dotfiles/fish/functions;
  };
}
