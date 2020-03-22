
{ username, pkgs }:

{
  os = {
    isNormalUser = true;
    home = "/home/" + username;
  };

  homemanager = {
    home.packages = with pkgs; [
      vlc
      git
      vim
      wget
      curl
      unzip
      gnupg
      ripgrep
      killall
      hddtemp
      nettools
      lm_sensors
      bluez-tools
      lxappearance
      unstable.brave
      gnome3.nautilus
      gnome3.seahorse
      unstable.flameshot
    ];
  };
}
