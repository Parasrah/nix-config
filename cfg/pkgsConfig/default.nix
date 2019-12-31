{ config }:

let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;

in
{
  allowUnfree = true;
  packageOverrides = {
    unstable = import unstableTarball {
      config = config.nixpkgs.config;
    };
  };
}
