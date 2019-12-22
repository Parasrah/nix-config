{ pkgs }: {
  custom = pkgs.recurseIntoAttrs {
    neovim = pkgs.callPackage ./neovim/default.nix { };
    kitty = pkgs.callPackage ./kitty/default.nix { };
    azuredatastudio = pkgs.callPackage ./azuredatastudio/default.nix { };
  };
}

