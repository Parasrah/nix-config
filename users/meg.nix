{ pkgs }:

{
  description = "Meg Assistant";
  isNormalUser = true;
  home = "/home/meg";
  extraGroups = [ "wheel" "networkmanager" "nixos-config" ];
  packages = with pkgs; [

  ];
}
