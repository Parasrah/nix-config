{ pkgs }: {
  my = pkgs.recurseIntoAttrs {
    neovim = pkgs.callPackage ./pkgs/neovim/default.nix {};
  };
}

