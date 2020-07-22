{ pkgs, ... }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      unstable.rustc
      # FIXME: waiting for file lock on build directory
      # unstable.rls
      unstable.cargo
    ];
  };
}
