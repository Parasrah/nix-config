{ pkgs, ... }:

{
  os = {  };

  homemanager = {
    home.packages = with pkgs; [
      unstable.dotnet-sdk_3
      azuredatastudio
    ];
  };
}
