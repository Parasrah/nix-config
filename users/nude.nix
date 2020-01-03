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
    extraGroups = [ "wheel" "networkmanager" "nixos-config" ];
  };

  homemanager = pkgs: {
    home.packages = with pkgs; [
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

    xdg.configFile."kitty/kitty.conf" = {
      source = builtins.path {
        path = ../dotfiles/kitty.conf;
      };
    };

    xdg.configFile."i3/config" = {
      source = builtins.path {
        path = ../dotfiles/i3.config;
      };
    };

    programs.git = with shared.git; {
      enable = true;
      userEmail = "bradp@nudesolutions.com";
      userName = "Brad Pfannmuller";
      aliases = aliases;
      extraConfig = extraConfig;
    };
  };
}
