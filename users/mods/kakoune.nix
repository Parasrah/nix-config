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
      kakoune-cr
      kakoune-unwrapped
      editorconfig-core-c

      aspellDicts.en

      unstable.nnn
    ];
  };
}
