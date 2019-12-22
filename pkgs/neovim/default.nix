{ pkgs }:

# TODO: override version & get rid of unstable channel
pkgs.neovim.override {
  vimAlias = false;
  configure = {
  };
}
