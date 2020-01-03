{ ... }:

{
  i18n.consoleUseXkbConfig = true;

  services.xserver = {

    layout = "us";

    xkbOptions = "ctrl:nocaps";

    libinput = {
      enable = true;
      naturalScrolling = true;
      tapping = true;
    };
  };
}
