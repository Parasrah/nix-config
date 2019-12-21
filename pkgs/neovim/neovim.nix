pkgs.neovim.override {
  configure = {
    customRC = builtins.readFile ./config/init.vim;
    vimAlias = false;
  };
}
