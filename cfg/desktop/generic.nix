{
  i18n.consoleUseXkbConfig = true;
  xserver.enable = true;
  xserver.layout = "us";
  xserver.xkbOoptions = "ctrl:nocaps";
  services.xserver.libinput = {
    enable = true;
    naturalScrolling = true;
  };
}
