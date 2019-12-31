{ ... }:

{
  i18n.consoleUseXkbConfig = true;

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "ctrl:nocaps";
    libinput = {
      enable = true;
      naturalScrolling = true;
      tapping = true;
    };
  };
}
