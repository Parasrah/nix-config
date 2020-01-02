{ pkgs, ... }:

{
  imports = [ ./generic.nix ];

  services.xserver = {
    enable = true;

    desktopManager = {
      default = "none";
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;

      extraPackages = with pkgs; [
        dmenu
        i3lock
        i3status
        i3blocks
      ];
    };
  };
}
