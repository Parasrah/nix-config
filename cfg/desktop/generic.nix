{ pkgs, ... }:

let
  compiledLayout =
    pkgs.runCommand "keyboard-layout" {} ''
      ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${./layout.xkb} $out
    '';
in
{
  i18n.consoleUseXkbConfig = true;

  services.xserver = {
    enable = true;

    autoRepeatDelay = 240;
    autoRepeatInterval = 40;

    displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY";

    libinput = {
      enable = true;
      naturalScrolling = true;
      tapping = true;
    };
  };
}
