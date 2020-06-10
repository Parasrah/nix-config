{ pkgs, ... }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      bc
      file
      ripgrep
      unstable.kak-lsp
      kakoune-unwrapped
      editorconfig-core-c
    ];
  };
}
