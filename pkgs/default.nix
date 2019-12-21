{ pkgs }: {
  my = pkgs.recurseIntoAttrs {
    neovim = pkgs.callPackage ./neovim/default.nix {};
    kitty = pkgs.callPackage ./kitty/default.nix {};
  };
}

