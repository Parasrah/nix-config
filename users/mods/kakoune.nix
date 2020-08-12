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
      kakoune-unwrapped
      editorconfig-core-c

      unstable.nnn

      aspellDicts.en
    ];
  };
}
