{ pkgs, lib, ... }:

let
  compiledLayout =
    pkgs.runCommand "keyboard-layout" {} ''
      ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${../../users/parasrah/dotfiles/layout.xkb} $out
    '';
in
{
  console.useXkbConfig = true;

  services.xserver = {
    enable = true;

    # doesn't work?
    autoRepeatDelay = 250;
    autoRepeatInterval = 20;

    displayManager.sessionCommands = ''
      ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY
      ${pkgs.xlibs.xset}/bin/xset r rate 250 20
    '';

    # for configuring touchpad
    libinput = {
      enable = true;
      naturalScrolling = true;
      tapping = true;
      additionalOptions = ''MatchIsTouchpad "on"'';
    };

    # for configuring everything else
    # inputClassSections = [ ];
  };
}
