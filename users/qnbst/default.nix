{ pkgs, ... }:

{
  os = {
    description = "Bea";
    extraGroups = ["networkmanager"];
    initialHashedPassword = "$6$rpJzIzk6jGJ7SQ/3$IYQTa/JugakPHG.DyDz/hBb1w3euy0iNTII2rVZaJrmIUfb1H79AC6YYXRNAcScmDQx76am83T6ZyQNaRCZex0";
  };

  homemanager = {
  };
}
