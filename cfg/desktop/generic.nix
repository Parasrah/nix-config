{ pkgs, lib, ... }:
let
  compiledLayout =
    pkgs.runCommand "keyboard-layout" { } ''
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

    libinput.enable = true;

    # doesn't use built in options as NixOS only supports
    # a single section
    inputClassSections = [
      ''
        Identifier     "custom mouse"
        Driver         "libinput"
        MatchIsPointer "on"
        Option         "AccelProfile" "flat"
        Option         "AccelSpeed"   "0"
      ''
      ''
        Identifier "custom touchpad"
        Driver "libinput"
        MatchIsTouchpad "on"
        Option "NaturalScrolling" "true"
        Option "Tapping" "on"
      ''
    ];
  };
}
