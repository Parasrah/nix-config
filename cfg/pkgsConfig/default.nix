{ config }:

{
  allowUnfree = true;
  packageOverrides = {
    unstable = import <nixos-unstable> {
      config = config.nixpkgs.config;
      overlays = config.nixpkgs.overlays;
    };
  };
}
