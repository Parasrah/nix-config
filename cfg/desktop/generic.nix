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

    displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY";

    # layout = "us";

    # xkbOptions = "ctrl:nocaps";

    libinput = {
      enable = true;
      naturalScrolling = true;
      tapping = true;
    };
  };
}
