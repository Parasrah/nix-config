{
  description = "Nude Solutions";
  isNormalUser = true;
  home = "/home/nude";
  extraGroups = [ "wheel" "networkmanager" "nixos-config" ];
  packages = with pkgs; [
    dbeaver
    firefox
    vlc
    unstable.nodejs
    custom.kitty
  ];
}
