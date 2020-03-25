{ username, pkgs }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      unstable.rustc
      unstable.rls
      unstable.cargo
    ];
  };
}
