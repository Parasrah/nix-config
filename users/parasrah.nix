{ pkgs }:

{
  isNormalUser = true;
  home = "/home/parasrah";
  description = "Brad (personal)";
  extraGroups = [ "wheel" "networkmanager" "nixos-config" ];
  initialHashedPassword = "$6$HkJllhqe$C8oSl9ox6WyNAdN6yjzTf3R1HzMbA6dDY8ziafg.XSG3LUrt5yG927KpDuA1nqGiiwGyGJ5jn5j.OwtNplSd3/";
  packages = with pkgs; [
    dbeaver-ce
    firefox
    vlc
    unstable.nodejs
    custom.kitty
  ];
}
