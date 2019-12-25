{ pkgs }:

{
  description = "Nude Solutions";
  isNormalUser = true;
  home = "/home/nude";
  extraGroups = [ "wheel" "networkmanager" "nixos-config" ];
  packages = with pkgs; [
    dbeaver-ce
    firefox
    vlc
    unstable.nodejs
    custom.kitty
  ];
}
