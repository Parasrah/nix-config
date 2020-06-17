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

    # doesn't work?
    # autoRepeatDelay = 250;
    # autoRepeatInterval = 20;

    displayManager.sessionCommands = ''
      ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY
      ${pkgs.xlibs.xset}/bin/xset r rate 250 20
    '';

    libinput = {
      enable = true;
      naturalScrolling = true;
      tapping = true;
    };
  };
}
