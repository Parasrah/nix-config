let
  create = import ./util/create.nix;

  shared = import ./shared.nix;

in
create {
  username = "parasrah";

  user = {
    isNormalUser = true;
    home = "/home/parasrah";
    description = "Brad";
    extraGroups = [ "wheel" "networkmanager" "nixos-config" "docker" ];
    initialHashedPassword = "$6$HkJllhqe$C8oSl9ox6WyNAdN6yjzTf3R1HzMbA6dDY8ziafg.XSG3LUrt5yG927KpDuA1nqGiiwGyGJ5jn5j.OwtNplSd3/";
  };

  homemanager = pkgs: {
    home.packages = with pkgs; [
      htop
      firefox
      inotify-tools
      kitty
      neovim
      nnn
      azuredatastudio
      gnome3.seahorse
      lua51Packages.lua-lsp
      unstable.brave
      unstable.chromium
      unstable.nodejs
      unstable.nodePackages.neovim
      unstable.nodePackages.eslint
      unstable.elmPackages.elm-language-server
      unstable.elmPackages.elm-format
      unstable.elmPackages.elm-test
      unstable.elmPackages.elm
    ];

    home.sessionVariables = {
      PROJECTS = "$HOME/Projects";
    };

    xdg.configFile = shared.xdg.configFile;

    programs.bash = shared.bash;

    programs.git = with shared.git; {
      enable = true;
      userEmail = "git@parasrah.com";
      userName = "Parasrah";
      aliases = aliases;
      extraConfig = extraConfig;
      signing = {
        signByDefault = true;
        key = "8922B1C024EFBF5C";
      };
    };

    programs.fzf = shared.fzf;

    programs.vscode = {
      enable = true;
    };
  };
}
