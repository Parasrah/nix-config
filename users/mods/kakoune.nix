{ pkgs, ... }:

{
  os = { };

  homemanager = {
    home.packages = with pkgs; [
      kakoune-unwrapped
      unstable.kak-lsp
    ];
  };
}
