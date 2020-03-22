{ username, pkgs }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      unstable.elmPackages.elm
      unstable.elmPackages.elm-test
      unstable.elmPackages.elm-format
      unstable.elmPackages.elm-analyse
      unstable.elmPackages.elm-language-server
    ];
  };
}
