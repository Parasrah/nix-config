{ ... }:

{
  i18n.consoleUseXkbConfig = true;

  services.xserver = {

    layout = "us";

    xkbOptions = "ctrl:nocaps";

    libinput = {
      enable = true;
      tapping = true;
    };

    extraConfig = ''
      Section "InputClass"
        Identifier "touchpad"
        Driver "libinput"
        MatchIsTouchpad "on"
        Option "NaturalScrolling" "true"
      EndSection
    '';
  };
}
