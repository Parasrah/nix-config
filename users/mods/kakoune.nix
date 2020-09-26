{ pkgs, ... }:

{
  os = {};

  homemanager = {
    home.packages = with pkgs; [
      bc
      jq
      file
      dash
      aspell
      ripgrep
      coreutils
      editorconfig-core-c

      aspellDicts.en

      unstable.nnn
      unstable.kakoune-unwrapped
    ];
  };
}
