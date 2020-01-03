let
  create = import ./util/create.nix;

  shared = import ./shared.nix;

in
create {
  username = "nude";

  user = {
    description = "Nude Solutions";
    isNormalUser = true;
    home = "/home/nude";
    extraGroups = [ "wheel" "networkmanager" "nixos-config" "docker" ];
    initialHashedPassword = "$6$eixEF7GGOo8T.4s$Npn8iBhur3G0uJmWc/L1MthwooGQX.KVmVd9jMnlWu6DLfOo7r7a3jVy/IirhN4c.0oI07KSyTGg2SKQSwa6v1";
  };

  homemanager = pkgs: {
    home.packages = with pkgs; [
      sqlpackage
      dbeaver
      vlc
      kitty
      neovim
      powershell
      nodejs
      nodePackages.eslint
      nodePackages.neovim
      unstable.brave
      unstable.teams
    ];

    xdg.configFile = shared.xdg.configFile;

    programs.bash = shared.bash;

    programs.git = with shared.git; {
      enable = true;
      userEmail = "bradp@nudesolutions.com";
      userName = "Brad Pfannmuller";
      aliases = aliases;
      extraConfig = extraConfig;
    };
  };
}
