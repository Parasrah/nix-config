{ pkgs }:

{
  home = "/root";
  isNormalUser = false;
  group = "root";
  extraGroups = [ "nixos-config" ];
  packages = with pkgs; [
    unstable.neovim
  ];
}
