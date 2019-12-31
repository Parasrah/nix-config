{ ... }:

{
  i18n.consoleUseXkbConfig = true;
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:nocaps";
  services.xserver.libinput = {
    enable = true;
    naturalScrolling = true;
    tapping = true;
  };
}
