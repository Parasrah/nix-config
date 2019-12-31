{ pkgs }:

let
  create = import ../create.nix;

in
create {
  home = {
    description = "Meg Assistant";
    isNormalUser = true;
    home = "/home/meg";
    extraGroups = [ "wheel" "networkmanager" "nixos-config" ];
  };
  home = { };
}
