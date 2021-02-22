{ config, inputs, system }:

{
  allowUnfree = true;
  packageOverrides = {
    unstable = import inputs.nixpkgs-unstable {
      inherit system;
      config = config.nixpkgs.config;
      overlays = config.nixpkgs.overlays;
    };
  };
}
