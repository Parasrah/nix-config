{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      spotify
      unstable.steam
      unstable.discord
      (unstable.google-chrome.override {
        commandLineArgs = "--enable-accelerated-video-decode";
      })
    ];
  };
}
