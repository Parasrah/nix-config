{ username, pkgs }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
    ];
  };
}
