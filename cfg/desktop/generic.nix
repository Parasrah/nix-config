{ pkgs, lib, inputs, ... }:

{
  console.useXkbConfig = true;

  hardware.keyboard.zsa.enable = true;

  services.xserver = {
    enable = true;

    autoRepeatDelay = 250;
    autoRepeatInterval = 20;

    displayManager.sessionCommands = ''
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
