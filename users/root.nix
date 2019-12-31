let
  create = import ./util/create.nix;

in
create {
  username = "root";

  user = {
    home = "/root";
    isNormalUser = false;
    group = "root";
    extraGroups = [ "nixos-config" ];
  };

  homemanager = pkgs: {
    home.packages = with pkgs; [
      neovim
    ];
  };
}
